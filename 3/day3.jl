include("../utils/read_input.jl")
using .InputLoader

function highestjoltage(bank::String)
    int_bank = [parse(Int, c) for c in bank]
    first_ix = argmax(int_bank[1:end-1])
    second_ix = argmax(int_bank[(first_ix+1):end]) + first_ix
    return int_bank[first_ix]*10 + int_bank[second_ix]
end


function totaljoltage(input)
    sum(highestjoltage(row) for row in eachline(IOBuffer(input)))
end


"""
Solves day 3 part 1
"""
function main1()
    input = read_input_file(input_file_path("day3.txt"))
    println(totaljoltage(input))
end