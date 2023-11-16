include("HashCode2014Solution.jl")

using BenchmarkTools

city = HashCode2014Solution.read_city()

(UB_total_duration, UB_total_distance) = HashCode2014Solution.ComputeUpperBound(city)

# original
solution = HashCode2014Solution.random_walk(city)

@show HashCode2014Solution.total_distance(solution, city)

# modified
@btime solution_modified = HashCode2014Solution.random_walk_modified($city)

@show HashCode2014Solution.total_distance(solution_modified, city)