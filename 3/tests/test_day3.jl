using Test
include("../day3_threaded.jl")

@testset "highestjoltage" begin
    @test highestjoltage("987654321111111", 2) == 98
    @test highestjoltage("811111111111119", 2) == 89
    @test highestjoltage("234234234234278", 2) == 78
    @test highestjoltage("818181911112111", 2) == 92

    @test highestjoltage("987654321111111", 12) == 987654321111
    @test highestjoltage("811111111111119", 12) == 811111111119
    @test highestjoltage("234234234234278", 12) == 434234234278
    @test highestjoltage("818181911112111", 12) == 888911112111
end

@testset "totaljoltage" begin
    input=
        """987654321111111
        811111111111119
        234234234234278
        818181911112111
        """
    @test totaljoltage(input, 2) == 357
    @test totaljoltage(input, 12) == 3121910778619
end