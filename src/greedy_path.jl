using HashCode2014;
using StaticArrays;

"""
    greedy_path(rg::RouteGrid, starting_junction::Int, total_duration::Int; n::Int=1)

Find a path through the city by always choosing the best neighbor to visit next. The best
neighbor is the one that leads to the longest path. Path length is specified by `rg.path_length`.

# Arguments
- `path::Vector{Int}`: the path to build upon, padded with zeros to be the same length as `rg.neighbors`
- `current_idx::Int`: the index of the junction in `path` that is being considered the starting junction
- `rg::RouteGrid`: a city, in the form of a RouteGrid
- `starting_junction::Int`: the junction from which to start
- `total_duration::Int`: the total duration of the path
"""
function greedy_path!(
    path::Vector{Int},
    current_idx::Int,
    rg::RouteGrid,
    starting_junction::Int,
    total_duration::Int,
)
    if path[current_idx] != starting_junction
        throw(
            ArgumentError(
                "starting_junction must be the same as path[current_idx], but is $(starting_junction) instead of $(path[current_idx])",
            ),
        )
    end

    t::Int = 0

    best_neighbor = RouteGridNode(-1, -1, -1, -1), 0
    last_neighbor = starting_junction

    while t < total_duration
        best_neighbor, _ = get_best_neighbor(path, last_neighbor, rg, current_idx)
        current_idx += 1
        path[current_idx] = best_neighbor.junction
        last_neighbor = best_neighbor.junction
        t += best_neighbor.duration
    end

end

"""
    greedy_path(rg::RouteGrid, starting_junction::Int, total_duration::Int)

Find a path through the city by always choosing the best neighbor to visit next. The best
neighbor is the one that leads to the longest path. Path length is specified by `rg.path_length`.

# Arguments
- `rg::RouteGrid`: a city, in the form of a RouteGrid
- `starting_junction::Int`: the junction from which to start
- `total_duration::Int`: the total duration of the path
"""
function greedy_path(rg::RouteGrid, starting_junction::Int, total_duration::Int)
    path = zeros(Int, 10000)
    path[1] = starting_junction

    greedy_path!(path, 1, rg, starting_junction, total_duration)
    return path[1:(findfirst(x -> x == 0, path) - rg.path_length)]
end