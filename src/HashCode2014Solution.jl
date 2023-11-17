module HashCode2014Solution

using HashCode2014
using Random: AbstractRNG, default_rng

export random_walk_modified
export RouteGridNode, RouteGrid, create_grid, get_neighboring_junctions
export ComputeUpperBound

include("random_walk_modified.jl")
include("route_grid.jl")
include("ComputeUpperBound.jl")

city = HashCode2014.read_city()

rg = create_grid(city)

end
