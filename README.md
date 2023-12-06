# HashCode2014Solution

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://timurUyu.github.io/HashCode2014Solution.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://timurUyu.github.io/HashCode2014Solution.jl/dev/)
[![Build Status](https://github.com/timurUyu/HashCode2014Solution.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/timurUyu/HashCode2014Solution.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/timurUyu/HashCode2014Solution.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/timurUyu/HashCode2014Solution.jl)

## Overview
HashCode2014Solution.jl is an extension of [Guillaume Dalle's](https://github.com/gdalle) HashCode2014, a lightweight package designed to interact with the data of Google's 2014 Hash Code challenge. This package was developed as part of a project for the MIT course 18.C25 - [Real-World Computation with Julia](https://github.com/mitmath/JuliaComputation).

## Installation

```julia-repl
pkg> add HashCode2014Solution
```

## Basic Use
The main solution algorithm is the `unique_random_walk` function, a modified version of the random walk implemented in [HashCode2014](https://github.com/gdalle/HashCode2014.jl), but weighting against already visited junctions.

```julia-repl
# Create instance of city using HashCode2014
julia> city = HashCode2014Solution.read_city()
HashCode2014.City( ... )

# Create custom type that represents the city as an adjacency list
julia> rg = create_grid(city, 3)
RouteGrid with 11348 junctions and paths of length 3

# Get problem solution
julia> solution = HashCode2014Solution.unique_random_walk(city, rg)
HashCode2014.Solution(...)

# Evaluate solution distance
julia> HashCode2014Solution.total_distance(solution, city)
941183
```

## Documentation
The full documentation is available at [GitHub Pages](https://juliagraphs.org/Graphs.jl/dev/).

## Overview
HashCode2014Solution.jl is an extension of Guillaume Dalle's HashCode2014, a lightweight package designed to interact with the data of Google's 2014 Hash Code challenge. This package was developed as part of a project for the MIT course 18.C25 - Real-World Computation with Julia.

## Installation

```julia-repl
pkg> add HashCode2014Solution
```

## Basic Use
The main solution algorithm is the `unique_random_walk` function, a modified version of the random walk implemented in [HashCode2014](https://github.com/gdalle/HashCode2014.jl), but weighting against already visited junctions.

```julia-repl
# Create instance of city using HashCode2014
julia> city = HashCode2014Solution.read_city()
HashCode2014.City( ... )

# Create custom type that represents the city as an adjacency list
julia> rg = create_grid(city, 3)
RouteGrid with 11348 junctions and paths of length 3

# Get problem solution
julia> solution = HashCode2014Solution.unique_random_walk(city, rg)
HashCode2014.Solution(...)

# Evaluate solution distance
julia> HashCode2014Solution.total_distance(solution, city)
941183
```

## Documentation
The full documentation is available at [here](https://timuruyu.github.io/HashCode2014Solution.jl/dev/).