using HashCode2014;
using StaticArrays;

"""
    path_length(path::Vector{Int}, rg::RouteGrid)

Compute the length of a path in a RouteGrid.

# Arguments
- `path::Vector{Int}`: a path made up of the junctions that are visited
- `rg::RouteGrid`: a city, in the form of a RouteGrid
"""
function path_length(path::Vector{Int}, rg::RouteGrid)
    total_distance::Int = 0
    seen_streets = Set{Int}()
    street::Int = -1
    neighbor_idx::Int = -1

    for i in 1:(length(path) - 1)
        neighbor_idx = searchsortedfirst(rg.neighbors[path[i]], path[i + 1])

        street = rg.neighbors[path[i]][neighbor_idx].street
        if street ∉ seen_streets
            total_distance += rg.neighbors[path[i]][neighbor_idx].distance
            push!(seen_streets, street)
        end
    end

    return total_distance
end

"""
    get_best_neighbor(starting_junction::Int, rg::RouteGrid, current_path::Vector{Int}=[starting_junction], n::Int=1)

Get the neighbor of a junction that leads to the longest path. Path length is `n=1` by default, but can be changed. A
path taken so far can also be specified.

# Arguments
- `starting_junction::Int`: the junction from which to start
- `rg::RouteGrid`: a city, in the form of a RouteGrid
- `current_path::Vector{Int}=[starting_junction]`: the path that has been taken so far
- `n::Int=1`: the length of the path to consider
"""
function get_best_neighbor(
    starting_junction::Int,
    rg::RouteGrid;
    current_path::Vector{Int}=Int[starting_junction],
    n::Int=1,
)
    max_length, best_neighbor = -Inf, RouteGridNode(-1, -1, -1, -1)
    new_path_length = 0

    for neighbor in rg.neighbors[starting_junction]
        if neighbor.junction == starting_junction
            continue
        end

        if n == 1
            new_path_length = path_length(vcat(current_path, [neighbor.junction]), rg)
        else
            _, new_path_length = get_best_neighbor(
                neighbor.junction,
                rg;
                current_path=vcat(current_path, [neighbor.junction]),
                n=n - 1,
            )
        end

        if new_path_length > max_length
            max_length = new_path_length
            best_neighbor = neighbor
        end
    end

    return best_neighbor, max_length
end