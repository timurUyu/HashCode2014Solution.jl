include("HashCode2014Solution.jl")

city = HashCode2014Solution.read_city()

solution = HashCode2014Solution.random_walk(city)

@show HashCode2014Solution.total_distance(solution, city)

solution_modified = HashCode2014Solution.random_walk_modified(city)

@show HashCode2014Solution.total_distance(solution_modified, city)