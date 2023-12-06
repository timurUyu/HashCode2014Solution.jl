# HashCode2014Solution

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://timurUyu.github.io/HashCode2014Solution.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://timurUyu.github.io/HashCode2014Solution.jl/dev/)
[![Build Status](https://github.com/timurUyu/HashCode2014Solution.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/timurUyu/HashCode2014Solution.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/timurUyu/HashCode2014Solution.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/timurUyu/HashCode2014Solution.jl)

HashCode2014Solution.jl is an extension of [Guillaume Dalle's](https://github.com/gdalle) HashCode2014, a lightweight package designed to interact with the data of Google's 2014 Hash Code challenge. This package was developed as part of a project for the MIT course 18.C25 - [Real-World Computation with Julia](https://github.com/mitmath/JuliaComputation).

## How to use

The package reads in data about the streets (and junctions) of Paris and restructures it into a struct City. Simply call the function read_city()

```
city = HashCode2014Solution.read_city()
```

yes

```
julia> A = [-4. -17.; 2. 2.]
2×2 Matrix{Float64}:
 -4.0  -17.0
  2.0    2.0
```

