using LinearAlgebraicRepresentation
using Plasm
Lar = LinearAlgebraicRepresentation
Psm = Plasm

function bezier(npts,b,cpts,p)
	Ni(n,i) = factorial(n)/(factorial(i)*factorial(n-i))
	Basis(n,i,t) = Ni(n,i)*t^i*((1-t)^(n-i))
	j = Array{Number}(20)
	temp = Array{Number}(20); temp1 = Array{Number}(20); temp2 = Array{Number}(20)
	icount = 0
	j = zeros(npts)
	for t=0:1/(cpts-1):1
	   icount += 1
	   # determine the Bernstein basis function
	   for i=1:npts
		   j[i] = Basis(npts-1,i-1,t)
		   @show i, j[i]
	   end
	   # determine a point on the curve
	   temp = b*j
	   # place in array
	   for i=1:3
		   p[icount,i] = temp[i]
	   end
	end
end

bb = Array{Float64,2}(10,3) 	# allows for up to 10  control vertices
pp = Array{Float64,2}(100,3)	# allows for up to 100 points on curve

npts = 4;
cpts = 21;   # eleven points on curve 
bb = zeros(3,npts)
cc = zeros(3,cpts)

#=
    Define the control polygon, Ex. 2.1 in the z=1 plane because
    this is three dimensional routine. x=b[1], y=b[2], z=b[3], etc.
=#    
    bb[1]=1;
    bb[2]=1;
    bb[3]=1;
    bb[4]=2;
    bb[5]=3;
    bb[6]=1;
    bb[7]=4;
    bb[8]=3;
    bb[9]=1;
    bb[10]=3;
    bb[11]=1;
    bb[12]=1;

bezier(npts,bb,cpts,pp)

verts = pp[1:cpts,:]'
_,cells = Lar.cuboidGrid([20])
Plasm.view(verts,cells)

