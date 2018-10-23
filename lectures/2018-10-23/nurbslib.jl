
"""
   input(prompt::String="")::String

Read a string from STDIN. The trailing newline is stripped.

The prompt string, if given, is printed to standard output without a
trailing newline before reading input.
""" 
function input(prompt::String="")::String
   print(prompt)
   return chomp(readline())
end



"""
Function to generate a B-spline open knot vector with multiplicity k at the ends 
(see Sec. 3.3).
c		= order of the basis function
n 		= the number of control polygon vertices
nplus2 	= index of x() for the first occurence of the maximum knot vector value
nplusc 	= maximum value of the knot vector n + c
x() 	= array containing the knot vector
"""

function knot(n::Int, c::Int) 
	nplusc = n+c
	nplus2 = n+2
	x = zeros(Float64, nplusc)
	x[1] = 0
	for i = 2:nplusc
		if i > c && i < nplus2 
			x[i] = x[i-1] + 1
		else
			x[i] = x[i-1]
		end  
	end
	return x
end



"""
	Function to generate B-spline basis functions for open uniform knot vectors 
	(see Eqs. (3.2))

	c 		= order of the B-spline basis function
	d 		= first term of the basis function recursion relation
	e 		= second term of the basis function recursion relation
	npts 	= number of control polygon vertices 
	n[,]	= array containing the basis functions
			  n(1,1) contains the basis function associated with B_1 etc. 
	nplusc 	= constant npts + c, maximum number of knot values
	t 		= parameter value
	temp[] 	= temporary array
	x[] 	= knot vector
"""
function basis(c,t,npts,x)
	temp = Array{Float64}(20)
	nplusc = npts+c
	n = zeros(Float64,1,nplusc);

	# calculate the first-order basis functions N_i,1 (see Eq. (3.2a))
	for i = 1:nplusc-1
		if t >= x[i] && t < x[i+1] 
			temp[i] = 1 
		else
			temp[i] = 0 
		end 
	end

	# calculate the higher-order basis functions (see Eq. (3.2b))
	for k = 2:c
		for i = 1:nplusc-k
			if temp[i] ≠ 0  	# if basis function is zero skip the calculation 
				d = ((t-x[i]) * temp[i])/(x[i+k-1]-x[i])
			else
				d = 0
			end 
			if temp[i+1] ≠ 0    # if basis function is zero skip the calculation
				e = ((x[i+k]-t) * temp[i+1])/(x[i+k]-x[i+1]) 
			else
				e = 0 
			end 
			temp[i] = d + e 
		end
	end
	if t == x[nplusc] 	# pick up last point
		temp[npts] = 1 
	end

	# put in n array
	for i = 1:npts 
		n[1,i] = temp[i]
	end
	if t == x[nplusc] 	# pick up last point
		n[1,npts] = 1 	
	end
	return n[1,1:npts]
end


"""
Function to generate a B-spline curve using an open uniform knot vector (Eq. (3.1))

b(,) = array containing the control polygon vertices
		b( ,1) contains the x component of the vertex
		b( ,2) contains the y component of the vertex
		b( ,3) contains the z component of the vertex
k 	= order of the B-spline basis function
nbasis = array containing the basis functions for a single value of t 
nplusc = number of knot values
npts = number of control polygon vertices 
p(,) = array containing the curve points
		p( ,1) contains the x component of the point
		p( ,2) contains the y component of the point
		p( ,3) contains the z component of the point
p1 	= number of points to be calculated on the curve 
t 	= parameter value 0 ≤ t < 1
x() = array containing the knot vector
"""
function bspline(npts::Int, k::Int, p1::Int, b::Array{Float64,2})

	# zero and dimension the knot vector and the basis array
	
	nplusc = npts + k
	x = knot(npts,k)
	p = zeros(3, p1*length(x))::Array{Float64,2}
	temp = zeros(1,3)

	# generate the uniform open knot vector

	icount = 0

	# calculate the points on the B-spline curve

	for t = 0 : x[npts+k]/(p1-1) : x[npts+k]
		icount = icount+1
		nbasis = basis(k,t,npts,x)	# generate the basis for this value of t
		temp = (b * nbasis)'				# generate the point on the curve
		p[1,icount] = temp[1,1] 			# assign the current value of the point 
		p[2,icount] = temp[1,2]				# on the curve to the curve array
		p[3,icount] = temp[1,3]
	end 
	
	return p
end


