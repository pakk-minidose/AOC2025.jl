using Test

include("../day1.jl")

@testset "parseinput" begin
    parsed =parseinput(
        """R11
        L12
        L48
        R93
        """
    )
    expected = [('R', 11), ('L', 12), ('L', 48), ('R', 93)]
    @test parsed == expected

    @test parseinput("\n\n\n") == []
end

@testset "Position" begin
    @test Position(0).max_position==99
    @test Position(0).position == 0
    @test Position(50).position == 50

    @test_throws ArgumentError Position(11, 10)

    @test_throws ArgumentError Position(-5)
    @test_throws ArgumentError Position(-5, 99)
    @test_throws ArgumentError Position(0, -10)

    @test_throws MethodError Position(0.1)
    @test_throws InexactError Position(0, 1.1)
end

@testset "Position operations" begin
    @testset "addition" begin
        @test Position(10) + 4 == (Position(14), 0)
        @test Position(10, 10) + 4 == (Position(3, 10), 1)
        @test Position(50) + 1000 == (Position(50), 10)
        @test_throws ArgumentError Position(10) + (-10)

    end
    @testset "substraction" begin
        @test Position(20) - 4 == (Position(16), 0)
        @test Position(0, 10) - 5 == (Position(6, 10), 0)
        @test Position(1, 10) - 5 == (Position(7, 10), 1)
        @test Position(5) - 5 == (Position(0), 1)
        @test Position(50) - 1000 == (Position(50), 10)
        @test Position(79, 99) - 379 == (Position(0), 4)
        @test_throws ArgumentError Position(10) - (-3)
    end
end

@testset "moveby" begin
    @test moveby(Position(10), ('R', 5)) == (Position(15), 0)
    @test moveby(Position(10), ('L', 2)) == (Position(8), 0)
    @test_throws ArgumentError moveby(Position(10), ('B', 2))
end

@testset "aoc_example_input" begin
    @test main("mini_day1.txt") == (3, 6)
end