using Test
include("../day2.jl")

const mini_input_expected = 
    [11:22,95:115,998:1012,1188511880:1188511890,222220:222224,1698522:1698528,446443:446449,38593856:38593862,565653:565659,824824821:824824827,2121212118:2121212124]

@testset "parseinput" begin
    @test parseinput("1-10") == [1:10]
    @test parseinput("1-10,15-100") == [1:10, 15:100]
end

@testset "isdoublesequence" begin
    @test !isdoublesequence(1)
    @test !isdoublesequence(123)
    
    @test !isdoublesequence(1221)

    @test isdoublesequence(55)
    @test isdoublesequence(6464)
    @test isdoublesequence(123123)
end

@testset "mini input" begin
    input = read_input_file(input_file_path("mini_day2.txt"))
    @test parseinput(input) == mini_input_expected

    @test main(parseinput(input)) == [11, 22, 99, 1010, 1188511885, 222222, 446446, 38593859]
    @test sum(main(parseinput(input))) == 1227775554
end