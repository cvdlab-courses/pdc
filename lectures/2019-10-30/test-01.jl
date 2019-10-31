using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using ViewerGL; GL = ViewerGL

#//////////////////////////////////////////////////////////////////////
# ----- solid ridge construction --------------------------------------
#//////////////////////////////////////////////////////////////////////

# parametric solid generation -----------------------------------------
# ridge = extrusion solid ---------------------------------------------
# whose section is a circle approximation -- with #sides ≥ 3 ----------

#-- topological algorithm (distribution of product over skeletons)-----
n = 10
circle1 = Lar.circle()([n])
interval1 = Lar.qn(1)([3])

circle0 = (circle1[1], [[k] for k=1:size(circle1[1],2)])
interval0 = (interval1[1], [[k] for k=1:size(interval1[1],2)])

cyl1a = Lar.larModelProduct(circle0,interval1)
cyl1b = Lar.larModelProduct(circle1,interval0)
cyl1 = ( cyl1a[1],append!(cyl1a[2], cyl1b[2]) )

GL.VIEW([ GL.GLGrid(cyl1[1], cyl1[2],GL.COLORS[1],1) ]);

cyl2a = Lar.larModelProduct(circle1,interval1)
circle2 = (circle1[1],[collect(1:n)])
cyl2b = Lar.larModelProduct(circle2,interval0)
cyl2 = ( cyl2a[1],append!(cyl2a[2], cyl2b[2]) )

#-- LAR model building -----------------------------------------------
V,EV = cyl1
V,FV = cyl2 
rod = V,FV,EV

#///////// single rod instance /////////////////////////////

cop_EV = convert(Lar.ChainOp, Lar.coboundary_0( EV::Lar.Cells ));
cop_FE = Lar.coboundary_1( V, FV::Lar.Cells, EV::Lar.Cells );
W = convert(Lar.Points, V');
#------ E^3 arrangement ------------------------------------
V, copEV, copFE, copCF = Lar.Arrangement.spatial_arrangement( W, cop_EV, cop_FE)

#------ visualization --------------------------------------
W = convert(Lar.Points, V')
V,CVs,FVs,EVs = Lar.pols2tria(W, copEV, copFE, copCF)
GL.VIEW(GL.GLExplode(V,FVs,1.,1.,1.,99,1));

#/////// triple instance ///////////////////////////////////

#------ model generation --------------------------------------
tris = Lar.Struct([ 
	rod,
	Lar.Struct([Lar.r(pi/2,0,0), rod ]) ,
	Lar.Struct([Lar.r(0,pi/2,0), rod ]) 
])
V,FV,EV = Lar.struct2lar( tris )
GL.VIEW([ GL.GLGrid( V, EV, GL.COLORS[1],1) ]);

#------ E^3 arrangement ------------------------------------
cop_EV = convert(Lar.ChainOp, Lar.coboundary_0(EV::Lar.Cells));
cop_FE = Lar.coboundary_1(V, FV::Lar.Cells, EV::Lar.Cells);
W = convert(Lar.Points, V');
V, copEV, copFE, copCF = Lar.Arrangement.spatial_arrangement( W, cop_EV, cop_FE)

#------ visualization --------------------------------------
W = convert(Lar.Points, V')
V,CVs,FVs,EVs = Lar.pols2tria(W, copEV, copFE, copCF)
GL.VIEW(GL.GLExplode(V,FVs,1.,1.,1.,99,1));

#///////// Exploded views of 2-sells and boundaries of 2-cells ///

GL.VIEW(GL.GLExplode(V,FVs,1.5,1.5,1.5,99,1));
GL.VIEW(GL.GLExplode(V,EVs,1.5,1.5,1.5,99,1));

#////////// Algebra atoms (generated 3-cells) //////////////////

meshes = GL.GLExplode(V,CVs[2:end],4,4,4,99,0.5);
GL.VIEW( push!( meshes, GL.GLFrame) );



