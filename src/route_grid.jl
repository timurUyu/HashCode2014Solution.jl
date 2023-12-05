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

"""
    RouteGrid

Transform a city into a graph where each junction is a node, and the streets are edges.

# Fields
- `neighbors::Vector{SVector{RouteGridNode}}`: for each junction, the list of street-junctions that can be reached from it.
"""
@kwdef struct RouteGrid
    neighbors::Vector{SArray{S,RouteGridNode,1} where S<:Tuple}
end

function Base.show(io::IO, rg::RouteGrid)
    return print(io, "RouteGrid with $(length(rg.neighbors)) junctions")
end

"""
    create_grid(city::City)

Create a RouteGrid from a City.

# Arguments
- `city::City`: the city to transform

"""
function create_grid(city::City)
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

    return RouteGrid(map(x -> convert_to_svector(x), neighbors))
end

function convert_to_svector(v::Vector)
    return SVector(v...)
end

rg = create_grid(HashCode2014.read_city())
