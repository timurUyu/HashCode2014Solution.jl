"""
    random_walk_modified(rng, city)
    random_walk_modified(city)

Modified version of random_walk() from HashCode2014.
"""
function random_walk_modified(rng::AbstractRNG, city::City)
    (; total_duration, nb_cars, starting_junction, streets) = city
    itineraries = Vector{Vector{Int}}(undef, nb_cars)

    all_visited_streets = Set(Int[])

    for c in 1:nb_cars
        itinerary = [starting_junction]
        duration = 0

        curr_visited_streets = Set(Int[])
        
        while true
            current_junction = last(itinerary)
            candidates = [
                (s, street) for (s, street) in enumerate(streets) if (
                    HashCode2014.is_street_start(current_junction, street) &&
                    duration + street.duration <= total_duration
                )
            ]
            if isempty(candidates)
                break
            else
                current_location = [city.junctions[current_junction].latitude, city.junctions[current_junction].longitude]

                diff_locations = [[city.junctions[j].latitude-current_location[1], city.junctions[j].longitude-current_location[2]] for j in  [HashCode2014.get_street_end(current_junction, st[2]) for st in candidates]]

                dir_angle = [atand(dl[1], dl[2]) for dl in diff_locations]

                inds = []
                for i in eachindex(candidates)

                    # weight based on direction [currently equal in each]
                    if 90 < dir_angle[i] <= 180
                        push!(inds, i*ones(Int, 1)...)
                    elseif  0 < dir_angle[i] <= 90
                        push!(inds, i*ones(Int, 1)...)
                    elseif -90 < dir_angle[i] <= 0
                        push!(inds, i*ones(Int, 1)...)
                    elseif -180 <= dir_angle[i] <= -90
                        push!(inds, i*ones(Int, 1)...)
                    else
                        @error "Invalid angle"
                    end

                    # weight based on whether visited street before
                    # if candidates[i][1] in curr_visited_streets
                    #     push!(inds, i*ones(Int, 3)...)
                    if candidates[i][1] in all_visited_streets
                        push!(inds, i*ones(Int, 1)...)
                    else
                        push!(inds, i*ones(Int, 49)...)
                    end
                    
                end
                ind = rand(rng, inds)

                s, street = candidates[ind]

                push!(curr_visited_streets, s)
                push!(all_visited_streets, s)
                
                next_junction = HashCode2014.get_street_end(current_junction, street)
                push!(itinerary, next_junction)
                duration += street.duration
            end
        end
        itineraries[c] = itinerary
    end
    return Solution(itineraries)
end

random_walk_modified(city::City) = random_walk_modified(default_rng(), city)