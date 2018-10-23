include("./nurbslib.jl")       

n = parse(Int, input("number of polygon points? "));
c = parse(Int, input("spline order? "));
nplusc = n + c;

try nplusc <= 21; 
	x = knot(n,c);
	print("knot vector is ", x[1:nplusc], "\n");
catch
	print("Program limits exceeded. n+c = $(n+c) > 21.\n");
	print("Knot vector not calculated.\n");
end