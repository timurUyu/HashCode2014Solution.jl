using BenchmarkTools

city = HashCode2014Solution.read_city()

rg = create_grid(city, 6)

# Upper bounds
(UB_distance_by_car, UB_duration_by_car) = HashCode2014Solution.ComputeUpperBound(
    city, city.total_duration, rg
)
(UB_distance_by_car, UB_duration_by_car) = HashCode2014Solution.ComputeUpperBound(
    city, city.total_duration, rg
)

UB_distance = sum(UB_distance_by_car)
UB_duration, _ = findmax(UB_duration_by_car)

## ---Optimised Random Walk---
# Run single simulation
solution_rg = HashCode2014Solution.unique_random_walk(city, rg)
@show HashCode2014Solution.total_distance(solution_rg, city)

# Run multiple simulations - select itinerary corresponding with furthest distance
rw_distances = zeros(Float64, 15)
@btime Threads.@threads for i in eachindex(rw_distances)
    rw_distances[i] = HashCode2014Solution.total_distance(
        HashCode2014Solution.unique_random_walk(city, rg), city
    )
end
@show mean(rw_distances)
@show findmax(rw_distances)

## ---Greedy Path---
path = greedy_path(rg, city.starting_junction, city.total_duration ÷ 4)
@benchmark greedy_path($rg, $city.starting_junction, $city.total_duration ÷ 4)
@benchmark path_length(path, rg)