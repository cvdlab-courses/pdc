
Table of Contents
Table of Contents
Pin
An Introduction to GPU Programming in Julia
How does the GPU work
GPUArrays
Performance
Memory
Garbage Collection
The GPUArray Constructors
Array Operations
GPUArrays in the real world
Writing GPU Kernels
Conclusion
Nextjournal
Explore
Docs
Dashboard

Remix
New

AP

Simon Danisch•Oct 17 2019•remix of nextjournal/julia-template
Julia & graphic enthusiast. Interested in high performance computing, GPUs and machine learning.
An Introduction to GPU Programming in Julia 
How does the GPU work
This article aims to give a quick introduction about how GPUs work and specifically give an overlook of the current Julia GPU ecosystem and how easy it is to get simple GPU programs running. To make things easier, you can run all the code samples directly in the article if you have an account and click on edit.
First of all, what is a GPU anyways?
A GPU is a massively parallel processor, with a couple of thousand parallel processing units. For example the Tesla k80, which is used in this article, offers 4992 parallel CUDA cores. GPUs are quite different from CPUs in terms of frequencies, latencies and hardware capabilities, but this is somewhat similar to a slow CPU with 4992 cores!

using CUDAdrv; CUDAdrv.name(CuDevice(0))
1.4s
Julia
Julia GPU+Flux

"Tesla K80"
The sheer number of parallel threads one can launch can yield massive speed-ups, but also makes it harder to utilize the GPU. Let's have a detailed look at the disadvantages one buys into when utilizing this raw power:
A GPU is a separate piece of hardware with its own memory space and different architecture. As a result, there are long transfer times from RAM to the GPUs memory (VRAM). Even launching a kernel on the GPU (in other words scheduling a function call) introduces large latencies. Times are around ~10us for GPUs, compared to a few nano seconds on a CPU
Setting up a kernel can quickly become complicated without a high level wrapper
Lower precision is the default and higher precision computations can easily void all performance gains
GPU functions (kernels) are inherently parallel, so writing GPU kernels is at least as difficult as writing parallel CPU code, but the difference in hardware adds quite a bit of complexity
Related to the above, a lot of algorithms won't port nicely to the GPU. For more details on what to expect, have a look at this blog post
Kernels are usually written in a C/C++ dialect, which is not the nicest language to write down your algorithms
There is a divide between CUDA and OpenCL, which are the dominant frameworks used to write low-level GPU code. While CUDA only supports Nvidia hardware, OpenCL supports all hardware but is a bit rough around the edges. One needs to decide what to use, and will get pretty much stuck with that decision
The good news is Julia, a high level scripting language, allows you to write both kernel and surrounding code in Julia itself, while running on most GPU hardware! 
GPUArrays
Most highly parallel algorithms need to churn through quite a bit of data to overcome all the threading and latency overheads. So most algorithms will need arrays to manage all that data, which calls for a good GPU array library as a crucial foundation.
GPUArrays.jl is that foundation in Julia. It offers an abstract array implementation tailored towards using the raw power of highly parallel hardware. It contains all the necessary functionality to set up the GPU, launch Julia GPU functions and offers some basic array algorithms.
Performance
Let's quickly motivate why we would want to move our calculations to the GPU with a simple interactive code example calculating the julia set:

using CuArrays, FileIO, Colors, GPUArrays, BenchmarkTools, ImageShow
using CuArrays: CuArray
"""
The function calculating the Julia set
"""
function juliaset(z0, maxiter)
    c = ComplexF32(-0.5, 0.75)
    z = z0
    for i in 1:maxiter
        abs2(z) > 4f0 && return (i - 1) % UInt8
        z = z * z + c
    end
    return maxiter % UInt8 # % is used to convert without overflow check
end
range = 100:50:2^12
cutimes, jltimes = Float64[], Float64[]
function run_bench(in, out)
  # use dot syntax to apply `juliaset` to each elemt of q_converted 
  # and write the output to result
  out .= juliaset.(in, 16)
  # all calls to the GPU are scheduled asynchronous, 
  # so we need to synchronize
  GPUArrays.synchronize(out)
end
# store a reference to the last results for plotting
last_jl, last_cu = nothing, nothing
for N in range
  w, h = N, N
  q = [ComplexF32(r, i) for i=1:-(2.0/w):-1, r=-1.5:(3.0/h):1.5]
  for (times, Typ) in ((cutimes, CuArray), (jltimes, Array))
    # convert to Array or CuArray - moving the calculation to CPU/GPU
    q_converted = Typ(q)
    result = Typ(zeros(UInt8, size(q)))
    for i in 1:10 # 5 samples per size
      # benchmarking macro, all variables need to be prefixed with $
      t = Base.@elapsed begin
        run_bench(q_converted, result)
      end
      global last_jl, last_cu # we're in local scope
      if result isa CuArray
        last_cu = result
      else
        last_jl = result
      end
      push!(times, t)
    end
  end
end
​
cu_jl = hcat(Array(last_cu), last_jl)
cmap = colormap("Blues", 16 + 1)
color_lookup(val, cmap) = cmap[val + 1]
color_lookup.(cu_jl, (cmap,))
147.2s
Julia
Julia GPU+Flux



using Plots; plotly()
x = repeat(range, inner = 10)
speedup = jltimes ./ cutimes
Plots.scatter(
  log2.(x), [speedup, fill(1.0, length(speedup))], 
  label = ["cuda" "cpu"], markersize = 2, markerstrokewidth = 0,
  legend = :right, xlabel = "2^N", ylabel = "speedup"
)
30.0s
Julia
Julia GPU+Flux

7
8
9
10
11
12
0
20
40
60
cuda
cpu
2^N
speedup
As you can see, for large arrays one gets a solid 60-80x speed-up by moving the calculation to the GPU. Getting this speed-up was as simple as converting the Julia array to a GPUArray.
One might think that the GPU performance suffers from being written in a dynamic language like Julia, but Julia's GPU performance should be pretty much on par with the raw performance of CUDA or OpenCL. Tim Besard did a great job at integrating the LLVM Nvidia compilation pipeline to achieve the same – or sometimes even better – performance as pure CUDA C code. Tim published a pretty detailed blog post in which he explains this further. CLArrays approach is a bit different and generates OpenCL C code directly from Julia, which has the same performance as OpenCL C!
To get a better idea of the performance and see some comparisons to multi-threadded CPU code, I collected some more benchmarks.
Memory
GPUs have their own memory space with video memory (VRAM), different caches, and registers. Whatever you do, any Julia object must get transferred to the GPU before you can work with it. Not all types in Julia work on the GPU.

struct Test # an immutable struct
# that only contains other immutable, which makes 
# isbitstype(Test) == true
  x::Float32 
end
​
# the isbits property is important, since those types can be used
# without constraints on the GPU!
@assert isbitstype(Test) == true
x = (2, 2)
isa(x, Tuple{Int, Int}) # tuples are also immutable
mutable struct Test2 #-> mutable, isbits(Test2) == false
  x::Float32
end
struct Test3
  # contains a heap allocation/ reference, not isbits
  x::Vector{Float32}
  y::Test2 # Test2 is mutable and also heap allocated / a reference
end
Vector{Test} # <-  An Array with isbits elements is contigious in memory
Vector{Test2} # <- An Array with mutable elements is basically an array of heap pointers. Since it just contains cpu heap pointers, it won't work on the GPU.
0.7s
Structs
Julia
Julia GPU+Flux

Array{Test2,1}
All those Julia types behave differently when transferred to the GPU or when created on the GPU. You can use the following table to get an overview of what to expect:
[
 isbits type
immutable type
mutable type
julia array
gpu array
(device) local memory
location of creation
on CPU
yes, copy
no ptrs, copy
copy
no
by reference
no
on GPU
yes
may contain device ptr
no (on 0.7 if elimated)
no
no
yes
 
]
[ 
location of creation
on CPU
on GPU
​	
  
 isbits type
yes, copy
yes
​	
  
immutable type
no ptrs, copy
may contain device ptr
​	
  
mutable type
copy
no (on 0.7 if elimated)
​	
  
julia array
no
no
​	
  
gpu array
by reference
no
​	
  
(device) local memory
no
yes
​	
 ]
Location of creation describes if the object was created on the CPU and then transferred to the GPU kernel, or if it was created on the GPU inside the kernel. The table shows if it is possible to create an instance of a type, and for the transfer from CPU to GPU, the table also indicates if the object gets copied or passed by reference.
Garbage Collection
A big difference when working with the GPU is that there is no garbage collector (GC) on the GPU. This is gladly not a big issue, since the kind of high performance kernel one writes for the GPU shouldn't create any GC-tracked memory to begin with.
As an alternative to heap allocated arrays inside the kernel, you can use GPUArrays. The GPUArray constructor will create GPU buffers and transfer the data to VRAM. If you call Array(gpu_array) the array will get transferred back to RAM, represented as a normal Julia Array. The Julia handle to those GPU arrays is tracked by Julia's GC and if it's not used anymore, the GPU memory will be freed.
Consequently, one can only use stack allocation on the device, and for the rest pre-allocated GPU buffers are used. As transfers are expensive, it is common to reuse and pre-allocate as much as possible when programming the GPU.
The GPUArray Constructors

using CuArrays, LinearAlgebra
using CuArrays.CURAND
​
# GPU Arrays can be constructed from all Julia arrays containing isbits types!
A1D = cu([1, 2, 3]) # cl for CLArrays
A1D = cufill(0, 100) # CLArray for CLArrays
# Float32 array - Float32 is usually preferred and can be up to 30x faster on most GPUs than Float64
diagonal_matrix = CuArray{Float32}(I, 100, 100)
filled = cufill(77f0, (4, 4, 4)) # 3D array filled with Float32 77
randy = curand(42, 42) # random numbers generated on the GPU
# The array constructor also accepts isbits iterators with a known size
# Note, that since you can also pass isbits types to a gpu kernel directly, in most cases you won't need to materialize them as an gpu array
from_iter = CuArray(1:10)
# let's create a point type to further illustrate what can be done:
struct Point
    x::Float32
    y::Float32
end
Base.convert(::Type{Point}, x::NTuple{2, Any}) = Point(x[1], x[2])
# because we defined the above convert from a tuple to a point
# [Point(2, 2)] can be written as Point[(2,2)] since all array 
# elements will get converted to Point
custom_types = cu(Point[(1, 2), (4, 3), (2, 2)])
typeof(custom_types)
5.0s
Julia
Julia GPU+Flux

CuArray{Point,1}
Array Operations
Lots of operations are already defined. Most importantly, GPUArrays support Julia's fusing dot broadcasting notation. This notation allows you to apply a function to each element of an array, and create a new array out of the return values of f. This functionality is usually referred to as a map. The broadcast refers to the fact that arrays with different shapes get broadcasted to the same shape.

x = zeros(4, 4) # 4x4 array of zeros
y = zeros(4) # 4 element array
z = 2 # a scalar
# y's 1st dimension gets repeated for the 2nd dimension in x
# and the scalar z get's repeated for all dimensions
# the below is equal to `broadcast(+, broadcast(+, xx, y), z)`
x .+ y .+ z
1.4s
Julia
Julia GPU+Flux

4×4 Array{Float64,2}:
 2.0  2.0  2.0  2.0
 2.0  2.0  2.0  2.0
 2.0  2.0  2.0  2.0
 2.0  2.0  2.0  2.0
The fusion happens because the Julia compiler will rewrite this expression into one lazy broadcast call that gets the call tree passed, which then can fuse the whole call tree into one function before looping over the array.
If you want a more thorough and interactive explanation of how broadcasting works, you can have a look at this great guide: julia.guide/broadcasting
This means any Julia function that runs without allocating heap memory (only creating isbits types), can be applied to each element of a GPUArray and multiple dot calls will get fused into one kernel call. As kernel call latency is high, this fusion is a very important optimization.

using CuArrays
A = cu([1, 2, 3])
B = cu([1, 2, 3])
C = curand(3)
result = A .+ B .- C
test(a::T) where T = a * convert(T, 2) # convert to same type as `a`
​
# inplace broadcast, writes directly into `result`
result .= test.(A) # custom function work
​
# The cool thing is that this composes well with custom types and custom functions.
# Let's go back to our Point type and define addition for it
Base.:(+)(p1::Point, p2::Point) = Point(p1.x + p2.x, p1.y + p2.y)
​
# now this works:
custom_types = cu(Point[(1, 2), (4, 3), (2, 2)])
​
# This particular example also shows the power of broadcasting: 
# Non array types are broadcasted and repeated for the whole length
result = custom_types .+ Ref(Point(2, 2))
​
# So the above is equal to (minus all the allocations):
# this allocates a new array on the gpu, which we can avoid with the above broadcast
broadcasted = fill(CuArray, Point(2, 2), (3,))
​
result == custom_types .+ broadcasted
6.2s
Julia
Julia GPU+Flux

true
Some more operations supported by GPUArrays:
Conversions and copy! to CPU arrays
multi dimensional indexing and slicing (xs[1:2, 5, :])
permutedims
Concatenation (vcat(x, y), cat(3, xs, ys, zs))
map, fused broadcast (zs .= xs.^2 .+ ys .* 2)
fill(CuArray, 0f0, dims), fill!(gpu_array, 0) 
Reduction over dimensions (reduce(+, xs, dims = 3), sum(x -> x^2, xs, dims = 1)
Reduction to scalar (reduce(*, xs), sum(xs), prod(xs))
Various BLAS operations (matrix*matrix, matrix*vector)
FFTs, using the same API as julia's FFT
Interested in a new type of notebook?
Try Nextjournal. The notebook for reproducible research.

SIGN UP
Automatically version-controlled all the time
Supports Python, R, Julia, Clojure and more
Invite co-workers, collaborate in real-time
Import your existing Jupyter notebooks
Learn more about Nextjournal
GPUArrays in the real world
Let's jump right into some cool use cases. 
This GPU accelerated smoke simulation was created with GPUArrays + CLArrays and runs on both GPU or CPU, with the GPU version being up to 15x faster:

There are many more use cases, including solving differential equations, FEM simulations, and solving PDEs. 
Let's walk through a simple Machine Learning example, to see how GPUArrays can be used:

using Flux, Flux.Data.MNIST, Statistics
using Flux: onehotbatch, onecold, crossentropy, throttle, params
using Base.Iterators: repeated, partition
using CuArrays
​
# Classify MNIST digits with a convolutional network
​
imgs = MNIST.images()
​
labels = onehotbatch(MNIST.labels(), 0:9)
​
# Partition into batches of size 1,000
train = [(cat(float.(imgs[i])..., dims = 4), labels[:,i])
         for i in partition(1:60_000, 1000)]
​
use_gpu = true # helper to easily switch between gpu/cpu
​
todevice(x) = use_gpu ? gpu(x) : x
​
train = todevice.(train)
​
# Prepare test set (first 1,000 images)
tX = cat(float.(MNIST.images(:test)[1:1000])..., dims = 4) |> todevice
tY = onehotbatch(MNIST.labels(:test)[1:1000], 0:9) |> todevice
​
m = todevice(Chain(
  Conv((2,2), 1=>16, relu),
  MaxPool((2, 2)),
  Conv((2,2), 16=>8, relu),
  MaxPool((2, 2)),
  x -> reshape(x, :, size(x, 4)),
  Dense(288, 10), softmax
))
​
loss(x, y) = crossentropy(m(x), y)
32.7s
Julia
Julia GPU+Flux
[ Info: Downloading MNIST dataset
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   469  100   469    0     0   1058      0 --:--:-- --:--:-- --:--:--  1056
100 9680k  100 9680k    0     0  5238k      0  0:00:01  0:00:01 --:--:-- 15.3M
[ Info: Downloading MNIST dataset
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   469  100   469    0     0   1288      0 --:--:-- --:--:-- --:--:--  1288
100 28881  100 28881    0     0  34219      0 --:--:-- --:--:-- --:--:-- 96270
[ Info: Downloading MNIST dataset
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   467  100   467    0     0   1282      0 --:--:-- --:--:-- --:--:--  1282
100 1610k  100 1610k    0     0  1225k      0  0:00:01  0:00:01 --:--:-- 3207k
[ Info: Downloading MNIST dataset
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   467  100   467    0     0   1297      0 --:--:-- --:--:-- --:--:--  1293
100  4542  100  4542    0     0   6247      0 --:--:-- --:--:-- --:--:--  6247

loss (generic function with 1 method)

# train
Flux.train!(loss, params(m), train, ADAM())
45.4s
Julia
Julia GPU+Flux

using Colors, FileIO, ImageShow
N = 7
img = tX[:, :, 1:1, N:N]
println("Predicted: ", Flux.onecold(m(gpu(img))) .- 1)
​
save("results/test.png", collect(tX[:, :, 1, N]))
11.2s
Julia
Julia GPU+Flux
Predicted: [4]


Just by converting the arrays to GPUArrays (with gpu(array)) we were able to move the entire computation to the GPU and get a pretty nice speed improvement. This is thanks to Julia's sophisticated AbstractArray infrastructure, into which GPUArrays seamlessly integrates. Subsequently, if you leave out the conversion to a GPUArray, the code will also run with normal Julia arrays – but then of course on the CPU. You can try this out by changing use_gpu = true to use_gpu = false and rerun the initialization and training cells. Comparing GPU and CPU, I get 975 seconds for a CPU run and 29 seconds for the GPU - which is a nice speed-up of ~33x.
Another nice property to look at is that GPUArrays never had to implement automatic differentiation explicitly to support the backward pass of the neuronal network efficiently. This is because Julia's automatic differentiation libraries work for arbitrary functions and emit code that can run efficiently on the GPU. This helps a lot to get Flux working on the GPU with minimal developer effort - and makes Flux GPU support work efficiently even for user defined functions. That this works out of the box without coordination between GPUArrays + Flux is a pretty unique property of Julia, which is explained in great detail in: Why Numba and Cython are no substitute for Julia
Writing GPU Kernels
One can get pretty far by just using the generic abstract array interface of GPUArrays without ever writing any GPU kernels. However, at some point one might need to implement an algorithm that needs to run on the GPU and can't be expressed by a combination of generic array algorithms!
The nice thing is that GPUArrays takes away quite a bit of work with a layered approach that lets you start off with high level code, but allows you to pretty much write low-level kernels similarly to what one would find in most OpenCL/CUDA examples. It also allows you to execute kernels both on OpenCL or CUDA devices, abstracting away any differences in those frameworks.
The function that makes this possible is named gpu_call. It can be called as gpu_call(kernel, A::GPUArray, args) and will call kernel with the arguments (state, args...) on the GPU. State is a backend specific object to implement functionality like getting the thread index. A GPUArray needs to get passed as the second argument to dispatch to the correct backend and supply the defaults for the launch parameters.

using GPUArrays, CuArrays
# Overloading the Julia Base map! function for GPUArrays
function Base.map!(f::Function, A::GPUArray, B::GPUArray)
    # our function that will run on the gpu
    function kernel(state, f, A, B)
        # If launch parameters aren't specified, linear_index gets the index
        # into the Array passed as second argument to gpu_call (`A`)
        i = linear_index(state)
        if i <= length(A)
          @inbounds A[i] = f(B[i])
        end
        return
    end
    # call kernel on the gpu
    gpu_call(kernel, A, (f, A, B))
end
0.3s
Julia
Julia GPU+Flux
Let's try to figure out what this is doing! In simple terms, this will call the Julia function kernel length(A) times in parallel on the GPU. Each parallel invocation of kernel has a thread index, which we can use to safely index into the arrays A and B. If we calculated our own indices instead of using linear_index, we'd need to make sure that we don't have multiple threads reading and writing to the same array locations. So, if we wrote this in pure Julia with threads, an equivalent version would look like this:

using BenchmarkTools
function threadded_map!(f::Function, A::Array, B::Array)
    Threads.@threads for i in 1:length(A)
        A[i] = f(B[i])
    end
  A
end
x, y = rand(10^7), rand(10^7)
kernel(y) = (y / 33f0) * (732.f0/y)
# on the cpu without threads:
single_t = @belapsed map!($kernel, $x, $y)
​
# "on the CPU with 4 threads (2 real cores):
thread_t = @belapsed threadded_map!($kernel, $x, $y)
​
# on the GPU:
xgpu, ygpu = cu(x), cu(y)
gpu_t = @belapsed begin
  map!($kernel, $xgpu, $ygpu)
  GPUArrays.synchronize($xgpu)
end
times = [single_t, thread_t, gpu_t]
speedup = maximum(times) ./ times
println("speedup: $speedup")
bar(["1 core", "2 cores", "gpu"], speedup, legend = false, fillcolor = :grey, ylabel = "speedup")
53.5s
Julia
Julia GPU+Flux
speedup: [1.0, 1.96716, 45.6603]

1 core
2 cores
gpu
0
10
20
30
40
speedup
Because the function isn't doing a lot of work, we don't see perfect scaling, but the threaded and GPU version still give us a nice speed-up. 
The GPU is a bit more complex than what the thread example allows us to show, since the hardware threads are laid out in blocks of threads – gpu_call abstracts that away in the simple version, but it can also be used with more complex launch configurations:

using CuArrays
​
threads = (2, 2)
blocks = (2, 2)
T = fill(CuArray, (0, 0), (4, 4))
B = fill(CuArray, (0, 0), (4, 4))
gpu_call(T, (B, T), (blocks, threads)) do state, A, B
  # those names pretty much refer to the cuda names
    b = (blockidx_x(state), blockidx_y(state))
    bdim = (blockdim_x(state), blockdim_y(state))
    t = (threadidx_x(state), threadidx_y(state))
    idx = (bdim .* (b .- 1)) .+ t
    A[idx...] = b
    B[idx...] = t
    return
end
println("Threads index: \n", T)
println("Block index: \n", B)
3.2s
Julia
Julia GPU+Flux
Threads index: 
Tuple{Int64,Int64}[(1, 1) (1, 2) (1, 1) (1, 2); (2, 1) (2, 2) (2, 1) (2, 2); (1, 1) (1, 2) (1, 1) (1, 2); (2, 1) (2, 2) (2, 1) (2, 2)]
Block index: 
Tuple{Int64,Int64}[(1, 1) (1, 1) (1, 2) (1, 2); (1, 1) (1, 1) (1, 2) (1, 2); (2, 1) (2, 1) (2, 2) (2, 2); (2, 1) (2, 1) (2, 2) (2, 2)]
In the above example you can see the iteration order of a more complex launch configuration. Figuring out the right iteration + launch configuration is crucial to achieve state of the art GPU performance – but won't be part of this simple introduction. There are plenty of GPU tutorials for CUDA and OpenCL which explain this in great detail and those principles are identical when programming the GPU in Julia.
Conclusion
Julia has come a long way to bring composable high-level programming to the high performance world. Now it's time to do the same for the GPU.
The hope is that Julia lowers the bar for people to start programming on GPUs, and that we can grow an extendable platform for open source GPU computing. The first success story, of automatic differentiation working out of the box via Julia packages that haven't even been written for the GPU, gives a lot of reason to believe in the success of Julia's extendable and generic design in the domain of GPU computing.
Interested in a new type of notebook?
Try Nextjournal. The notebook for reproducible research.

SIGN UP
Automatically version-controlled all the time
Supports Python, R, Julia, Clojure and more
Invite co-workers, collaborate in real-time
Import your existing Jupyter notebooks
Learn more about Nextjournal
Runtimes (1)
