include("HashCode2014Solution.jl")

using BenchmarkTools

city = HashCode2014Solution.read_city()

rg = HashCode2014Solution.create_grid(city)

(UB_distance_by_car, UB_duration_by_car) = HashCode2014Solution.ComputeUpperBound(city, city.total_duration, rg)

UB_distance = sum(UB_distance_by_car)
UB_duration, _ = findmax(UB_duration_by_car)

# original
solution = HashCode2014Solution.random_walk(city)
@show HashCode2014Solution.total_distance(solution, city)

# modified
solution_modified = HashCode2014Solution.random_walk_modified(city)
@show HashCode2014Solution.total_distance(solution_modified, city)

# HashCode2014Solution.plot_streets(city, solution_modified)