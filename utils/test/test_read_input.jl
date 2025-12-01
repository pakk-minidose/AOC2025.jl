include("../read_input.jl")

using .InputLoader
using Test

@testset "input_file_path" begin
    test_file_path = input_file_path("test_input.txt.test")
    @test isabspath(test_file_path)
    @test isfile(test_file_path)
end

@testset "read_input_file" begin
    test_file_path = input_file_path("test_input.txt.test")
    read_input = read_input_file(test_file_path)
    @test read_input isa String
    @test read_input == "Hello, World!"

    nonexistent_file_path = input_file_path("jkfjnanvndajnnafnajfj")
    @test_throws ArgumentError read_input_file(nonexistent_file_path)
end