using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using Plasm

# generation of 2D grid
nsamples = 20
V,(VV,EV,FV) = Lar.cuboidGrid([nsamples,nsamples], true)
Plasm.view(V,EV)

# numbering of vertices and edges
Plasm.view(Plasm.numbering(1.)((V,[VV,EV]))) 

# embedding the grid in 3D (to simulate a terrain map)
W = [V; rand(Float64, size(V,2))']
Plasm.view(W,EV)
Plasm.view(W,FV)

# using a simplicial grid 2-complex
shape = [nsamples,nsamples]
V, FV = Lar.simplexGrid(shape)
Plasm.view(W,FV)

# viewing the 2-cell numbering
Plasm.view(Plasm.numbering(1.)((W,[VV,FV])))

#change the orientation of odd simplices (What...?!)
FW = [[v2,v1,v3] for (k,(v1,v2,v3)) in enumerate(FV) if k%2==1]
Plasm.view(W,FW)

# correctly orienting the grid
FW = [k%2==1 ? [v2,v1,v3] : [v1,v2,v3] for (k,(v1,v2,v3)) in enumerate(FV)]
Plasm.view(W,FW)

# using to display a surface:   see repo: LinearAlgebraicRepresentation/src/mapper.j
