EV = [[4,1], [1,4], [4,3], [1,2], [7,4], [7,3], [3,6], [6,3], 
[2,7], [2,5], [7,5], [5,6]]
       
EV = hcat(EV...)
n = max(EV...)
 

# matrice di adiacenza dei vertici
B = zeros(Int8,n,n)
for e=1:size(EV,2)
	i,j = EV[:,e]
    B[i,j] = 1
end


# matrice sparsa di adiacenza dei vertici
I,J,V = Int64[],Int64[],Int8[] 
for e=1:size(EV,2)
	i,j = EV[:,e]
	push!(I,i)
	push!(J,j)
	push!(V,1)
end
B = sparse(I,J,V)


B = full(B')
x = [0;0;0;1;0;0;0]

B*x
B*B*x



