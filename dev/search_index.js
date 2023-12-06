var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = HashCode2014Solution","category":"page"},{"location":"#HashCode2014Solution","page":"Home","title":"HashCode2014Solution","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for HashCode2014Solution.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [HashCode2014Solution]","category":"page"},{"location":"#HashCode2014Solution.RouteGrid","page":"Home","title":"HashCode2014Solution.RouteGrid","text":"RouteGrid\n\nTransform a city into a graph where each junction is a node, and the streets are edges.\n\nFields\n\nneighbors::Vector{SVector{RouteGridNode}}: for each junction, the list of street-junctions that can be reached from it.\n\n\n\n\n\n","category":"type"},{"location":"#HashCode2014Solution.RouteGridNode","page":"Home","title":"HashCode2014Solution.RouteGridNode","text":"RouteGridNode\n\nGroup a junction and a street that leads to it together.\n\nFields\n\nstreet::Int: a street in the city\njunction::Int: a junction that can be reached from the street\ndistance::Int: the length of the street\n\n\n\n\n\n","category":"type"},{"location":"#HashCode2014Solution.ComputeUpperBound-Tuple{HashCode2014.City, Int64, RouteGrid}","page":"Home","title":"HashCode2014Solution.ComputeUpperBound","text":"ComputeUpperBound(city, duration_limit)\n\nAlgorithm to compute upper bound on distance. Compares velocity of each street and constructs 8 separate paths for each car in a \"drag race\" style journey. This approach relaxes the constraint on connectivity of the streets.\n\nFields\n\n'city::City': a street in the city\n'duration_limit::Int64': the total time limit imposed on cars traversing streets\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.create_grid-Tuple{HashCode2014.City}","page":"Home","title":"HashCode2014Solution.create_grid","text":"create_grid(city::City)\n\nCreate a RouteGrid from a City.\n\nArguments\n\ncity::City: the city to transform\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.get_best_neighbor!-Tuple{Vector{Int64}, Int64, RouteGrid, Int64}","page":"Home","title":"HashCode2014Solution.get_best_neighbor!","text":"get_best_neighbor!(current_path::Vector{Int}, starting_junction::Int, rg::RouteGrid, current_idx::Int, n::Int=1)\n\nGet the neighbor of a junction that leads to the longest path. Path length is n=1 by default, but can be changed. A path taken so far can also be specified.\n\nArguments\n\ncurrent_path::Vector{Int}: the path that has been taken so far, padded with zeros to be the same length as rg.neighbors\nstarting_junction::Int: the junction from which to start\nrg::RouteGrid: a city, in the form of a RouteGrid\ncurrent_idx::Int: the index of the junction in current_path that is being considered the starting junction\nn::Int=1: the length of the path to consider\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.get_best_neighbor-Tuple{Int64, RouteGrid}","page":"Home","title":"HashCode2014Solution.get_best_neighbor","text":"get_best_neighbor(starting_junction::Int, rg::RouteGrid, n::Int=1)\n\nGet the neighbor of a junction that leads to the longest path. Path length is n=1 by default, but can be changed.\n\nArguments\n\nstarting_junction::Int: the junction from which to start\nrg::RouteGrid: a city, in the form of a RouteGrid\nn::Int=1: the length of the path to consider\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.greedy_path-Tuple{RouteGrid, Int64, Int64}","page":"Home","title":"HashCode2014Solution.greedy_path","text":"greedy_path(rg::RouteGrid, starting_junction::Int, total_duration::Int; n::Int=1)\n\nFind a path through the city by always choosing the best neighbor to visit next. The best neighbor is the one that leads to the longest path. Path length is n=1 by default, but can be changed.\n\nArguments\n\nrg::RouteGrid: a city, in the form of a RouteGrid\nstarting_junction::Int: the junction from which to start\ntotal_duration::Int: the total duration of the path\nn::Int=1: the length of the path to consider when choosing the best neighbor\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.path_length-Tuple{AbstractVector{Int64}, RouteGrid}","page":"Home","title":"HashCode2014Solution.path_length","text":"path_length(path::AbstractVector{Int}, rg::RouteGrid)\n\nCompute the length of a path in a RouteGrid.\n\nArguments\n\npath::AbstractVector{Int}: a path made up of the junctions that are visited\nrg::RouteGrid: a city, in the form of a RouteGrid\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Solution.unique_random_walk-Tuple{Random.AbstractRNG, HashCode2014.City, Any}","page":"Home","title":"HashCode2014Solution.unique_random_walk","text":"unique_random_walk(rng, city, rg)\nunique_random_walk(city, rg)\n\nModified version of random_walk() from HashCode2014. Uses a custom type, RouteGrid, to determine candidate streets and weights against streets which have already been traversed. Threading over the random walks of each car improves performance significantly.\n\n\n\n\n\n","category":"method"}]
}
