include("./nurbslib.jl")       

# allows for up to 10  control vertices 
# allows for up to 100 points on curve

npts = 10;
k = 4;     # second order, change to 4 to get fourth order 
p1 = (npts - k)*11;   # eleven points on each curve segment

#	Define the control polygon, Ex. 3.4 in the z=1 plane because
#	this is three dimensional routine. x=b[1], y=b[2], z=b[3], etc.

b =
[0.0  -1.0  1.0  2.0  1.0  1.0  2.5  2.5  4.0  5.0;
 0.0   2.0  4.0  3.0  1.0  2.0  1.0  3.0  4.0  0.0;
 1.0   1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0]

p = bspline(npts,k,p1,b);

print("\nControl polygon points\n\n");
for i = 1:npts
	print(" $(b[:,i]) \n")
end

print("\nCurve points\n\n");
for i = 1:p1
	print(" $(p[:,i]) \n");
end

