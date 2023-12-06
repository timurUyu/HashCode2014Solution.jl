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

    @inbounds for i in 1:(length(path) - 1)
        neighbor_idx = searchsortedfirst(rg[path[i]], path[i + 1])

        # @show path, i, path[i], neighbor_idx
        # @show rg[path[i]][neighbor_idx]
        street = rg[path[i]][neighbor_idx].street
        if street ∉ seen_streets
            total_distance += rg[path[i]][neighbor_idx].distance
            push!(seen_streets, street)
        end
    end

    return total_distance
end

"""
    get_best_neighbor_fast!(current_path::Vector{Int}, starting_junction::Int, rg::RouteGrid, current_idx::Int)
    get_best_neighbor(starting_junction::Int, rg::RouteGrid)


Get the neighbor of a junction that leads to the longest path. Path length is specified by `rg.path_length`. A
path taken so far can also be specified.

# Arguments
- `current_path::Vector{Int}`: the path that has been taken so far, padded with zeros
- `starting_junction::Int`: the junction from which to start
- `rg::RouteGrid`: a city, in the form of a RouteGrid
- `current_idx::Int`: the index of the junction in `current_path` that is being considered the starting junction
"""
function get_best_neighbor(
    current_path::Vector{Int}, starting_junction::Int, rg::RouteGrid, current_idx::Int
)

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
        # @show current_path
        # @show path
        current_path[(current_idx + 1):(current_idx + rg.path_length)] = map(
            x -> x.junction, path
        )

        # @show current_path
        new_path_length = path_length(
            view(current_path, 1:(current_idx + rg.path_length)), rg
        )

        if new_path_length > max_length
            max_length = new_path_length
            best_neighbor = path[1]
        end
    end

    return best_neighbor, max_length
end

function get_best_neighbor(starting_junction::Int, rg::RouteGrid)
    return get_best_neighbor(zeros(Int, 10000), starting_junction, rg, 1)
end

"""
    change_duration(city, total_duration)

Create a new City with a different `total_duration` and everything else equal.
"""
function change_duration(city::City, total_duration)
    new_city = City(;
        total_duration=total_duration,
        nb_cars=city.nb_cars,
        starting_junction=city.starting_junction,
        junctions=copy(city.junctions),
        streets=copy(city.streets),
    )
    return new_city
end