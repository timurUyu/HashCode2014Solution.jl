# using HashCode2014;

# """
#     random_walk_then_greedy(rg::RouteGrid, city::City, split::Float64)

# Run a random walk for a proportion of the total duration, then run a greedy path for the remainder. Throws
# an error if the solution is not feasible.

# # Arguments
# - `rg::RouteGrid`: a city, in the form of a RouteGrid
# - `city::City`: the city to solve
# - `split::Float64`: the proportion of the total duration to run the random walk for
# """
# function random_walk_then_greedy(rg::RouteGrid, city::City, split::Float64)
#     random_walk_duration = round(Int, city.total_duration * split)
#     greedy_path_duration = city.total_duration - random_walk_duration

#     city = change_duration(city, random_walk_duration)
#     random_walk_results = unique_random_walk(city, rg)

#     @show total_distance(random_walk_results, city)

#     intermediate_sol = random_walk_results.itineraries

#     Threads.@threads for i in 1:8
#         n = length(intermediate_sol[i])
#         intermediate_sol[i] = vcat(intermediate_sol[i], zeros(Int, 10000))
#         greedy_path!(intermediate_sol[i], n, rg, intermediate_sol[i][n], greedy_path_duration)
#         intermediate_sol[i] = intermediate_sol[i][1:(findfirst(x -> x == 0, intermediate_sol[i]) - rg.path_length)]
#     end
    
#     solution = Solution(intermediate_sol)
#     if !is_feasible(solution, city)
#         throw(ArgumentError("Solution is not feasible"))
#     end

#     return solution
# end