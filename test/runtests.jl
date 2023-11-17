using HashCode2014
using HashCode2014Solution
using Test

@testset "HashCode2014Solution.jl" begin
    @testset "Test RouteGrid correctness" begin
        city = HashCode2014.read_city()
        rg = HashCode2014Solution.create_grid(city)

        for i in 1:length(rg.neighbors)
            for neighbor in rg.neighbors[i]
                @test HashCode2014.is_street(
                    i, neighbor.junction, city.streets[neighbor.street]
                )
            end
        end
    end
end
