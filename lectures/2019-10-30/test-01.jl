using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL; GL = ViewerGL

#======================================================================
# ----- solid ridge construction --------------------------------------
#======================================================================

# parametric solid generation -----------------------------------------
# ridge = extrusion solid ---------------------------------------------
# whose section is a circle approximation -- with #sides ≥ 3 ----------

function cyl(n)
	circle = Lar.circle()([n]) # LAR model
	interval = Lar.qn(1)([3])
	tube = Lar.larModelProduct(circle,interval)
end
function close(FV)
	push!(FV, collect(1:2:2*n), collect(2:2:2*n+1)  )
	return FV
end
function edges(FV)
	EV = [[2*k-1, 2*k] for k=1:div(2*size(V,2),2)]
	append!(EV, [[k,k%n+1] for k=1:n ], [[n+k,n+k%n+1] for k=1:n] ) # TODO:  finish 
end


function cylinder(n) 
	V, FV = cyl(n)
	FV = close(FV)
	return V,FV
end

n=6

V,FV = cylinder(n) 
GL.VIEW([ GL.GLGrid(V,FV[1:n],GL.COLORS[1],1) ]);
GL.VIEW([ GL.GLGrid(V,FV[n+1:n+2],GL.COLORS[1],1) ]);
Plasm.view(V,FV)

EV = [[2*k-1, 2*k] for k=1:div(size(V,2),2)]
GL.VIEW([ GL.GLGrid(V,EV,GL.COLORS[1],1) ]);

#-- topological algorithm -------------------------------------------

n=6
circle1 = Lar.circle()([n])
interval1 = Lar.qn(1)([3])

circle0 = (circle1[1], [[k] for k=1:size(circle1[1],2)])
interval0 = (interval1[1], [[k] for k=1:size(interval1[1],2)])

cyl1a = Lar.larModelProduct(circle0,interval1)
cyl1b = Lar.larModelProduct(circle1,interval0)
cyl1 = ( cyl1a[1],append!(cyl1a[2], cyl1b[2]) )
GL.VIEW([ GL.GLGrid(cyl1[1], cyl1[2],GL.COLORS[1],1) ]);


cyl2a = Lar.larModelProduct(circle,interval)
circle2 = (circle[1], convert(Lar.Cells,[sort(collect(Set(cat(circle[2]))))]))
cyl2b = Lar.larModelProduct(circle2,interval0)
cyl2 = ( cyl2a[1],append!(cyl2a[2], cyl2b[2]) )

GL.VIEW([ GL.GLGrid(cyl2[1], cyl2[2],GL.COLORS[1],1) ]);
Plasm.view(cyl2)


#=
meshes = []
model = V,FV
W,EW = Lar.fragmentlines(model);
for k=1:length(EW)
	color = GL.COLORS[k%12+1] - (rand(Float64,4)*0.1)
	push!(meshes, GL.GLGrid(W,[EW[k]],color,1) )
end
GL.VIEW(meshes);
=#


