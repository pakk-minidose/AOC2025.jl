using Test
include("../day4.jl")

const input=
"""..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
"""

@testset "parseinput" begin
    @test parseinput("@.@\n") == [
        false false false false false;
        false true  false true  false; 
        false false false false false
     ]

    @test size(parseinput(input)) == (12, 12)
    @test eltype(parseinput(input)) == Bool
end

@testset "allaccessible" begin
    @test allaccessible(input) == 13
end

@testset "allaccessible!" begin
    @test allaccessible!(input) == 43
end