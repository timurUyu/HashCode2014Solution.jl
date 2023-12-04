"""
    ComputeUpperBound(city, duration_limit)

Algorithm to compute upper bound on distance. Compares velocity of each street and constructs
8 separate paths for each car in a "drag race" style journey. This approach relaxes the
constraint on connectivity of the streets.

# Fields
- 'city::City': a street in the city
- 'duration_limit::Int64': the total time limit imposed on cars traversing streets
"""
function ComputeUpperBound(city::City, duration_limit::Int64, rg::HashCode2014Solution.RouteGrid)

    (; total_duration, nb_cars, starting_junction, streets) = city

    vel = zeros(Float64, length(streets))

    for i in eachindex(streets)
        vel[i] = streets[i].distance / streets[i].duration
    end
    inds_sorted_vel = sortperm(vel, rev=true)

    UB_distance = zeros(8)
    UB_duration = zeros(8)

    for i in inds_sorted_vel
        if UB_duration[(i-1)%8 + 1] + streets[i].duration < duration_limit
            UB_distance[(i-1)%8 + 1] += streets[i].distance
            UB_duration[(i-1)%8 + 1] += streets[i].duration
        end
    end

    return (UB_distance, UB_duration)

end