using IterTools

function grid_0(n)
    return hcat([[i] for i in range(0,n+1)]...)
end

function grid_1(n)
    return hcat([[i,i+1] for i in range(0,n)]...)
end

function larGrid(n)
    function larGrid1(d)
        if d==0 
        	return grid_0(n)
        elseif d==1 
        	return grid_1(n) 
        end
    end
    return larGrid1
end

function index2addr(shape)
    n = length(shape)
    theShape = append!(shape[2:end],1)
    weights = [prod(theShape[k:end]) for k in range(1,n)]
    function index2addr0(multiIndex)
        return dot(collect(multiIndex), weights) + 1
    end
    return index2addr0
end

function binaryRange(n)
    return [bin(k,n) for k in range(0,2^n)]
end

function larVertProd(vertLists)
	coords = [[x[1] for x in v] for v in IterTools.product(vertLists...)]
    return sortcols(hcat(coords...))
end

function filterByOrder(n)
    terms = [[parse(Int8,bit) for bit in convert(Array{Char,1},term)] for term in binaryRange(n)]
    return [[term for term in terms if sum(term) == k] for k in range(0,n+1)]
end

function larCellProd(cellLists)
    shapes = [length(item) for item in cellLists]
    cart = IterTools.product([range(0,shape) for shape in shapes]...)
    indices = hcat([collect(tuple) for tuple in sort(collect(cart))]...)
    
    h = 1
	index = indices[:,h]
	inCart = [collect(cells[k+1]) for (k,cells) in collect(zip(index,cellLists))]
	jointCells = sort(collect(IterTools.product(inCart...)))
    for h in range(2,size(indices,2))
    	index = indices[:,h]
    	inCart = [collect(cells[k+1]) for (k,cells) in collect(zip(index,cellLists))]
    	jointCells = hcat( jointCells, sort(collect(IterTools.product(inCart...))) )
    end              			
    convertIt = index2addr([ shape+1 for shape in shapes ])		
    [hcat(map(convertIt, jointCells[:,j])...) for j in range(1,size(jointCells,2))]
end

function larImageVerts(shape)
	function vertexDomain(n)
		return [[k] for k in range(0,n)]
	end
	vertLists = [vertexDomain(k+1) for k in shape]
	vertGrid = larVertProd(vertLists)
	return vertGrid
end

function larGridSkeleton(shape)
    n = length(shape)
    function larGridSkeleton0(d)
        components = filterByOrder(n)[d]
        mymap(arr) = [arr[:,k]  for k in range(1,size(arr,2))]
        componentCellLists = [ [ mymap(f(x)) for (f,x) in zip( [larGrid(dim) for dim in shape],component ) ]
                              for component in components ]
        out = [ larCellProd(cellLists)  for cellLists in componentCellLists ]
        return vcat(out...)
    end
    return larGridSkeleton0
end

function larCuboids(shape, full=false)
	vertGrid = larImageVerts(shape)
	gridMap = larGridSkeleton(shape)
	if ! full
		cells = gridMap(length(shape)+1)
	else
		skeletonIds = range(1,length(shape)+1)
		cells = [ gridMap(id) for id in skeletonIds ]
	end
	return vertGrid, cells
end

shape = (3,2,1)
cubes = larCuboids(shape,true)
print(cubes)

shape = (1,1,1)
cubes = larCuboids(shape,true)
print(cubes)

shape = (10,10,10)
cubes = larCuboids(shape,true)
print(cubes)

