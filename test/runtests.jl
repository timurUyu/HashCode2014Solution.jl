using Test
using HashCode2014
using HashCode2014Solution

@testset "HashCode2014Solution.jl" begin
    @testset "Test RouteGrid correctness" begin
        city = HashCode2014.read_city()
        rg = HashCode2014Solution.create_grid(city)

        for i in 1:length(rg.neighbors)
            for neighbor in rg.neighbors[i]
                @test HashCode2014.is_street(
                    i, neighbor.junction, city.streets[neighbor.street]
                ) && neighbor.distance == city.streets[neighbor.street].distance &&
                    neighbor.duration == city.streets[neighbor.street].duration
            end
        end
    end

    @testset "Test path_length correctness for neighbors" begin
        city = HashCode2014.read_city()
        rg = HashCode2014Solution.create_grid(city)

        for i in 1:length(rg.neighbors)
            for neighbor in rg.neighbors[i]
                @test HashCode2014Solution.path_length([i, neighbor.junction], rg) ==
                    neighbor.distance

                if city.streets[neighbor.street].bidirectional
                    @test HashCode2014Solution.path_length(
                        [neighbor.junction, i, neighbor.junction, i, neighbor.junction], rg
                    ) == neighbor.distance
                end
            end
        end
    end

    @testset "get_best_neighbor and get_best_neighbor! equality" begin
        city = HashCode2014.read_city()
        rg = HashCode2014Solution.create_grid(city)

        path = zeros(Int, length(rg.neighbors))
        path[1] = city.starting_junction

        @test get_best_neighbor!(path, city.starting_junction, rg, 1) ==
            get_best_neighbor(city.starting_junction, rg)
    end

    @testset "Test get_best_neighbor w/ length 2 paths" begin
        city = HashCode2014.read_city()
        rg = HashCode2014Solution.create_grid(city)
        calculataed_max = -Inf

        for i in 1:length(rg.neighbors)
            best_neighbor, max_length = HashCode2014Solution.get_best_neighbor(i, rg; n=2)

            calculataed_max = -Inf
            path = [0, 0]
            for n1 in rg.neighbors[i]
                for n2 in rg.neighbors[n1.junction]
                    if n2.junction == i
                        calculataed_max = max(calculataed_max, n1.distance)
                    else
                        calculataed_max = max(calculataed_max, n1.distance + n2.distance)
                    end

                    if calculataed_max == n1.distance + n2.distance
                        path = [i, n1.junction, n2.junction]
                    end
                end
            end
            @test max_length == calculataed_max
            if max_length != calculataed_max
                @show i, max_length, calculataed_max, path
            end
        end
    end
end