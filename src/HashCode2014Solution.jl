module HashCode2014Solution

using HashCode2014
using Random: AbstractRNG, default_rng

export unique_random_walk
export RouteGridNode,
    RouteGrid,
    create_grid,
    get_neighboring_junctions,
    path_length,
    greedy_path,
    get_best_neighbor!,
    get_best_neighbor
export ComputeUpperBound

include("unique_random_walk.jl")
include("route_grid.jl")
include("greedy_path.jl")
include("ComputeUpperBound.jl")
include("utils.jl")

city = HashCode2014.read_city()
solution = unique_random_walk(city, rg)
HashCode2014.is_feasible(solution, city)
HashCode2014.total_distance(solution, city)

rg = create_grid(city)

end