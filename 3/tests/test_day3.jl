using Test
include("../day3.jl")

@testset "highestjoltage" begin
    @test highestjoltage("987654321111111") == 98
    @test highestjoltage("811111111111119") == 89
    @test highestjoltage("234234234234278") == 78
    @test highestjoltage("818181911112111") == 92
end

@testset "totaljoltage" begin
    input=
        """987654321111111
        811111111111119
        234234234234278
        818181911112111
        """
    @test totaljoltage(input) == 357
end