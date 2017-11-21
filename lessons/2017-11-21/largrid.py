import collections, itertools
from larlib import *


def larModelProduct(twoModels):
    (V, cells1), (W, cells2) = twoModels
    vertices = collections.OrderedDict(); k = 0
    for v in V:
        for w in W:
            id = tuple(v+w)
            if not vertices.has_key(id):
                vertices[id] = k
                k += 1   
    cells = [ [vertices[tuple(V[v] + W[w])] for v in c1 for w in c2]
             for c1 in cells1 for c2 in cells2]  
    model = [list(v) for v in vertices.keys()], cells
    return model


geom_0,topol_0 = [[0.],[1.],[2.],[3.],[4.]],[[0,1],[1,2],[2,3],[3,4]]
geom_1,topol_1 = [[0.],[1.],[2.]], [[0,1],[1,2]]
mod_0 = (geom_0,topol_0)
mod_1 = (geom_1,topol_1)
squares = larModelProduct([mod_0,mod_1])
cubes = larModelProduct([squares,mod_0])


def grid_0(n):
    return [[i] for i in xrange(n+1)]

def grid_1(n):
    return [[i,i+1] for i in xrange(n)]

def larGrid(n):
    def larGrid1(d):
        if d==0: return grid_0(n)
        elif d==1: return grid_1(n)
    return larGrid1
    
def index2addr (shape):
    n = len(shape)
    theShape = shape[1:]+[1]
    weights = [prod(theShape[k:]) for k in xrange(n)]
    def index2addr0 (multiIndex):
        return dot(multiIndex, weights)
    return index2addr0

def binaryRange(n):
    return [('{0:0'+str(n)+'b}').format(k) for k in xrange(2**n)]

def larVertProd(vertLists):
    return [[x[0] for x in v] for v in itertools.product(*vertLists)]
    
def filterByOrder(n):
    terms = [[int(elem) for elem in list(term)] for term in binaryRange(n)]
    return [[term for term in terms if sum(term) == k] for k in xrange(n+1)]

def larCellProd(cellLists):
    shapes = [len(item) for item in cellLists]
    indices = itertools.product(*[xrange(shape) for shape in shapes])
    def assemblies(index):
    	return itertools.product(*[cells[k] for k,cells in zip(index,cellLists)])
    jointCells = [list(assemblies(index)) for index in indices]
    convert = index2addr([ shape+1 if (len(cellLists[k][0]) > 1) else shape
                             for k,shape in enumerate(shapes) ])
    return [map(convert, cell) for cell in jointCells]

def larGridSkeleton(shape):
    n = len(shape)
    def larGridSkeleton0(d):
        components = filterByOrder(n)[d]
        componentCellLists = [ [apply(f,[x]) for f,x in zip( [larGrid(dim) for dim in shape],(component) ) ]
                              for component in components ]
        print "componentCellLists =",componentCellLists
        out = [ larCellProd(cellLists)  for cellLists in componentCellLists ]
        return list(itertools.chain(*out))
    return larGridSkeleton0

def larImageVerts(shape):
   def vertexDomain(n): 
      return [[k] for k in xrange(n)]
   vertLists = [vertexDomain(k+1) for k in shape]
   vertGrid = larVertProd(vertLists)
   return vertGrid

def larCuboids(shape, full=False):
   vertGrid = larImageVerts(shape)
   gridMap = larGridSkeleton(shape)
   if not full: 
      cells = gridMap(len(shape))
   else:
      skeletonIds = xrange(len(shape)+1)
      cells = [ gridMap(id) for id in skeletonIds ]
   return vertGrid, cells


VIEW(EXPLODE(1.5,1.5,1.5)(MKPOLS(mergeSkeleton(larCuboids([3,2,1],True)))))


