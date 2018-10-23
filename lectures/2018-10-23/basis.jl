include("./nurbslib.jl")       

npts = parse(Int, input("number of polygon points? "));
c = parse(Int, input("spline order? "));
	
n = zeros(Float64,1,20);

t = 0.0
nplusc = npts + c;
x = knot(npts,c);
print("knot vector is ", x[1:nplusc], "\n\n");
		
	
while(( t >= 0.) && (t <= x[nplusc]::Float64))
	try
		t = parse(Float64, input("parameter value t? (ENTER to end) "));
	catch
		break
	end
	print("t = $(t)\n");
	n[1,1:npts] = basis(c,t,npts,x);
	print("Basis function is $(n[1,1:npts])\n ");
	
	sum = 0.0
	for i = 1:npts
		sum = sum + n[1,i];
	end
	print("Sum of the Basis functions is $(sum) \n");
end
print("t is outside the parameter range, program ends \n");
