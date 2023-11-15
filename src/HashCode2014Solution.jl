module HashCode2014Solution

using HashCode2014
using Random: AbstractRNG, default_rng

export random_walk_modified
export ComputeUpperBound

include("random_walk_modified.jl")
include("ComputeUpperBound.jl")

end