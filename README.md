# Parallel and Distributed Computing (IN480)

## ABACUS 2016/17

### Teachers

*	[Alberto Paoluzzi](http://paoluzzi.dia.uniroma3.it), 
*	[Roberto D'Autilia](https://www.researchgate.net/profile/Roberto_DAutilia)

## Course Description, Goals and Objectives

This course introduces to techniques of parallel and  distributed computing, and to hardware and software architectures for high-performance scientific and technical computing. Some space will be given to iterative distributed methods for simulation of numerical problems, and to methods for assessment of very large geometric models and meshes. The programming launguage used is [_Julia_](http://julialang.org), novel dynamic language for scientific computing. Specific learning goals are:

1. Solve compute-intensive problems faster;
2. Solve larger problems in the same amount of time;
3. Solve same size problems with higher accuracy in the same amount of time.

## Course program

Brief introduction to Julia language. Introduction to parallel architectures, Principle of parallel and distributed programming with Julia. Primitives of communication on synchronization: [MPI](https://www.open-mpi.org) paradigm. Languages based on directives: [OpenMP](http://openmp.org/wp/). Performance metrics of parallel programs. Matrix operations and dense linear systems: introduction to [BLAS](http://www.netlib.org/blas/), [LAPACK](http://www.netlib.org/blas/), [scaLAPACK](http://www.netlib.org/scalapack/). Sparse linear systems: introduction to [CombBLAS](http://gauss.cs.ucsb.edu/~aydin/CombBLAS/html/), [GraphBLAS](http://graphblas.org/index.php/Graph_BLAS_Forum). Collaborative development of course projects: heart-quake simulations; parallel  [LAR](https://github.com/cvdlab/LAR.jl).

## Programming language

[http://julialang.org](http://julialang.org)

"_Julia_ is a high-level, high-performance dynamic programming language for technical computing, with syntax that is familiar to users of other technical computing environments."

## Computational resources

Access will be granted to the [Compute Cluster](http://web-cluster.fis.uniroma3.it)  of Mathematics and Physics Department, integrated by resources of [CVDLAB](http://cvdlab.org) as access point.

## Teaching materials

*	[Learning Julia](https://www.manning.com/books/julia-in-action)

*	Blaise N. Barney, [HPC Training Materials](https://computing.llnl.gov/tutorials/parallel_comp/), by kind permission of [Lawrence Livermore National Laboratory](https://www.llnl.gov)'s Computational Training Center

*	Grama, Gupta, Karypis, Kumar [Introduction to Parallel Computing](http://srmcse.weebly.com/uploads/8/9/0/9/8909020/introduction_to_parallel_computing_second_edition-ananth_grama..pdf). Addison-Wesley, Harlow, 2003. Second edition. ISBN:0201648652

*	J. Dongarra, J. Kurzak, J. Demmel, M. Heroux, [Linear Algebra Libraries for High- Performance Computing: Scientific Computing with Multicore and Accelerators](http://www.netlib.org/utk/people/JackDongarra/SLIDES/sc2011-tutorial.pdf), SuperComputing 2011 (SC11)

*	Antonio DiCarlo, Alberto Paoluzzi, and Vadim Shapiro, [Linear algebraic representation for topological structures](http://www.sciencedirect.com/science/article/pii/S001044851300184X), _Computer-Aided Design_, 46-1, 2014

