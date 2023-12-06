"""
    unique_random_walk(rng, city, rg)
    unique_random_walk(city, rg)

Modified version of random_walk() from HashCode2014. Uses a custom type, RouteGrid, to
determine candidate streets and weights against streets which have already been traversed.
Threading over the random walks of each car improves performance significantly.

# Arguments
- `rng::AbstractRNG`: random number generator
- `city::City`: city of junctions connected by streets
- `rg::RouteGrid`: graph representing the city

"""
function unique_random_walk(rng::AbstractRNG, city::City, rg)
    (; total_duration, nb_cars, starting_junction, streets) = city

    # total_duration = 18000

    itineraries = Vector{Vector{Int}}(undef, nb_cars)

    all_visited_streets = Set(Int[])

    Threads.@threads for c in 1:nb_cars
        itinerary = [starting_junction]
        duration = 0

        curr_visited_streets = Set(Int[])

        while duration < total_duration
            current_junction = last(itinerary)

            candidates = rg[current_junction]

            if isempty(candidates)
                break
            else
                inds = []
                for i in eachindex(candidates)
                    if candidates[i].street in all_visited_streets
                        push!(inds, i*ones(Int, 1)...)
                    else
                        push!(inds, i*ones(Int, 59)...) # weight found to give good results
                    end
                end

                ind = rand(rng, inds)

                choice = candidates[ind]

                push!(curr_visited_streets, choice.street)
                push!(all_visited_streets, choice.street)

                next_junction = choice.junction
                push!(itinerary, next_junction)
                duration += choice.duration
            end
        end
        itineraries[c] = itinerary
    end
    return Solution(itineraries)
end

unique_random_walk(city::City, rg) = unique_random_walk(default_rng(), city, rg)