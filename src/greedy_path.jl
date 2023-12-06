using HashCode2014;
using StaticArrays;
using Printf;

"""
    greedy_path(rg::RouteGrid, starting_junction::Int, total_duration::Int; n::Int=1)

Find a path through the city by always choosing the best neighbor to visit next. The best
neighbor is the one that leads to the longest path. Path length is specified by `rg.path_length`.

# Arguments
- `rg::RouteGrid`: a city, in the form of a RouteGrid
- `starting_junction::Int`: the junction from which to start
- `total_duration::Int`: the total duration of the path
"""
function greedy_path(rg::RouteGrid, starting_junction::Int, total_duration::Int)
    t::Int = 0

    # Initialize a path to build upon
    path = zeros(Int, length(rg.neighbors))
    path[1] = starting_junction
    current_idx = 1
    best_neighbor = RouteGridNode(-1, -1, -1, -1), 0
    last_neighbor = starting_junction

    while t < total_duration
        best_neighbor, _ = get_best_neighbor!(path, last_neighbor, rg, current_idx)
        current_idx += 1
        path[current_idx] = best_neighbor.junction
        last_neighbor = best_neighbor.junction
        t += best_neighbor.duration
    end

    return path[1:current_idx]
end