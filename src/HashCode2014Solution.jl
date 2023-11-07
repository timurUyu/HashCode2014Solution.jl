module HashCode2014Solution

using HashCode2014
using Random: AbstractRNG, default_rng

export random_walk_modified

include("random_walk_modified.jl")

# city = HashCode2014.read_city()

# solution = HashCode2014.random_walk(city)

# solution_modified = HashCode2014Solution

# HashCode2014.is_feasible(solution, city; verbose=true)

# HashCode2014.plot_streets(city, solution)

end
