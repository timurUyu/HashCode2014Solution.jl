module HashCode2014Solution

using HashCode2014
using Random: AbstractRNG, default_rng

export random_walk_modified
export RouteGridNode, RouteGrid, create_grid
export path_length, get_best_neighbor!, get_best_neighbor
export greedy_path!, greedy_path
export get_length_n_paths, generate_all_paths, get_solution
export change_duration
export ComputeUpperBound

include("unique_random_walk.jl")
include("route_grid.jl")
include("greedy_path.jl")
include("ComputeUpperBound.jl")
include("utils.jl")
include("final_solution.jl")

city = HashCode2014.read_city()
solution = unique_random_walk(city, rg)
HashCode2014.is_feasible(solution, city)
HashCode2014.total_distance(solution, city)

rg = create_grid(city, 2)

end