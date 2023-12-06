using StaticArrays

"""
    RouteGridNode

Group a junction and a street that leads to it together.

# Fields
- `street::Int`: a street in the city
- `junction::Int`: a junction that can be reached from the street
- `distance::Int`: the length of the street
"""
@kwdef struct RouteGridNode
    junction::Int
    street::Int
    distance::Int
    duration::Int
end

function Base.show(io::IO, rg_node::RouteGridNode)
    return print(
        io,
        "RouteGridNode to junction $(rg_node.junction) along street $(rg_node.street) of length $(rg_node.distance)",
    )
end

function Base.isless(rgn::RouteGridNode, idx::Int)
    return rgn.junction < idx
end

"""
    RouteGrid

Transform a city into a graph where each junction is a node, and the streets are edges.

# Fields
- `neighbors::Vector{SVector{RouteGridNode}}`: for each junction, the list of street-junctions that can be reached from it.
"""
@kwdef struct RouteGrid
    neighbors::Vector{SArray{S,RouteGridNode,1} where S<:Tuple}
    paths::Vector{Set{SArray{T,Int,1} where T<:Tuple}}
    path_length::Int
end

function Base.show(io::IO, rg::RouteGrid)
    return print(io, "RouteGrid with $(length(rg.neighbors)) junctions")
end

"""
    create_grid(city::City, n::Int)

Create a RouteGrid from a City, and compute all paths of length `n` for each junction.

# Arguments
- `city::City`: the city to transform
- `n::Int`: the length of the path to consider
"""
function create_grid(city::City, n::Int=2)
    neighbors::Vector{Vector{RouteGridNode}} = []

    for i in 1:length(city.streets)
        street = city.streets[i]
        while length(neighbors) < street.endpointA
            push!(neighbors, [])
        end

        push!(
            neighbors[street.endpointA],
            RouteGridNode(street.endpointB, i, street.distance, street.duration),
        )

        if street.bidirectional
            while length(neighbors) < street.endpointB
                push!(neighbors, [])
            end
            push!(
                neighbors[street.endpointB],
                RouteGridNode(street.endpointA, i, street.distance, street.duration),
            )
        end
    end

    return RouteGrid(
        map(x -> convert_to_sorted_svector(x), neighbors),
        generate_all_paths(neighbors; n=n),
        n,
    )
end

function convert_to_sorted_svector(v::Vector)
    return SVector(sort(v; by=x -> x.junction)...)
end

"""
    get_length_n_paths(junction::Int, rg::RouteGrid; n::Int=1)

Get all paths of length `n` that start at `starting_junction`.

# Arguments
- `starting_junction::Int`: the junction from which to start
- `neighbors::Vector{Vector{RouteGridNode}}`: for each junction, the list of street-junctions that can be reached from it.
- `n::Int=1`: the length of the path to consider
"""
function get_length_n_paths(
    junction::Int, neighbors::Vector{Vector{RouteGridNode}}; n::Int=1
)
    if n < 0
        throw(ArgumentError("n must be non-negative"))
    end

    if n == 0
        return [[junction]]
    end

    paths = Vector{Int}[]
    for neighbor in neighbors[junction]
        for path in get_length_n_paths(neighbor.junction, neighbors; n=n - 1)
            push!(paths, pushfirst!(path, junction))
        end
    end

    return paths
end

"""
    generate_all_paths(paths, rg::RouteGrid; n::Int=2)

Generate all paths of length `n` for each junction in `rg`.

# Arguments
- `paths::Vector{Vector{Int}}`: a Vector to store the paths in
- `neighbors::Vector{Vector{RouteGridNode}}`: for each junction, the list of street-junctions that can be reached from it.
- `n::Int=2`: the length of the path to consider

"""
function generate_all_paths(neighbors::Vector{Vector{RouteGridNode}}; n::Int=2)
    if n < 2
        throw(ArgumentError("n must be at least 2"))
    end

    paths = Set{SVector{n + 1,Int}}[]

    for i in 1:length(neighbors)
        push!(paths, Set(get_length_n_paths(i, neighbors; n=n)))
    end

    return paths
end

function Base.getindex(rg::RouteGrid, idx::Int)
    return rg.neighbors[idx]
end