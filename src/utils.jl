using HashCode2014;
using StaticArrays;

"""
    path_length(path::AbstractVector{Int}, rg::RouteGrid)

Compute the length of a path in a RouteGrid.

# Arguments
- `path::AbstractVector{Int}`: a path made up of the junctions that are visited
- `rg::RouteGrid`: a city, in the form of a RouteGrid
"""
function path_length(path::AbstractVector{Int}, rg::RouteGrid)
    total_distance::Int = 0
    seen_streets = Set{Int}()
    street::Int = -1
    neighbor_idx::Int = -1

    for i in 1:(length(path) - 1)
        neighbor_idx = searchsortedfirst(rg[path[i]], path[i + 1])

        street = rg[path[i]][neighbor_idx].street
        if street ∉ seen_streets
            total_distance += rg[path[i]][neighbor_idx].distance
            push!(seen_streets, street)
        end
    end

    return total_distance
end

"""
    get_best_neighbor_fast!(current_path::Vector{Int}, starting_junction::Int, rg::RouteGrid, current_idx::Int, n::Int=1)

Get the neighbor of a junction that leads to the longest path. Path length is specified by `rg.path_length`. A
path taken so far can also be specified.

# Arguments
- `current_path::Vector{Int}`: the path that has been taken so far, padded with zeros to be the same length as `rg.neighbors`
- `starting_junction::Int`: the junction from which to start
- `rg::RouteGrid`: a city, in the form of a RouteGrid
- `current_idx::Int`: the index of the junction in `current_path` that is being considered the starting junction
"""
function get_best_neighbor!(
    current_path::Vector{Int}, starting_junction::Int, rg::RouteGrid, current_idx::Int
)
    # A perfect path is one that visits all junctions once and only once
    if length(current_path) != length(rg.neighbors)
        throw(
            ArgumentError(
                "current_path must be the same length as rg.neighbors, but is $(length(current_path)) instead of $(length(rg.neighbors))",
            ),
        )
    end

    # Set the starting junction if it hasn't been set yet
    if current_path[1] == 0
        current_path[1] = starting_junction
    end

    if current_path[current_idx] != starting_junction
        throw(
            ArgumentError(
                "current_idx must be the starting junction, but points to $(current_path[current_idx]) instead of $(starting_junction)",
            ),
        )
    end

    max_length, best_neighbor = -Inf, RouteGridNode(-1, -1, -1, -1)
    new_path_length = 0

    for path in rg.paths[starting_junction]
        current_path[(current_idx + 1):(current_idx + rg.path_length)] = map(
            x -> x.junction, path
        )
        new_path_length = path_length(
            view(current_path, 1:(current_idx + rg.path_length)), rg
        )

        if new_path_length > max_length
            max_length = new_path_length
            best_neighbor = path[2]
        end
    end

    return best_neighbor, max_length
end

"""
    get_best_neighbor(starting_junction::Int, rg::RouteGrid)

Get the neighbor of a junction that leads to the longest path.

# Arguments
- `starting_junction::Int`: the junction from which to start
- `rg::RouteGrid`: a city, in the form of a RouteGrid
"""
get_best_neighbor(starting_junction::Int, rg::RouteGrid) =
    get_best_neighbor!(zeros(Int, length(rg.neighbors)), starting_junction, rg, 1)