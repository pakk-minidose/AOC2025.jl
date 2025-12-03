include("../utils/read_input.jl")
using .InputLoader

function highestjoltage(bank::String, ndigits::Int)::Int
    int_bank = [parse(Int, c) for c in bank]
    endoffset = ndigits - 1
    startoffset = 0
    indices = Vector{Int}(undef, ndigits)
    for n in 1:ndigits
        ix = argmax(
                view(int_bank, (startoffset + 1):(length(int_bank)-endoffset))
            ) + startoffset
        indices[n] = ix
        startoffset = ix
        endoffset = ndigits - n - 1
    end
    result = sum(int_bank[ix]*10^(n-1) for (n, ix) in enumerate(reverse(indices)))
    return result
end

function totaljoltage(input, ndigits)
    sum(highestjoltage(row, ndigits) for row in eachline(IOBuffer(input)))
end


"""
Solves day 3 part 1
"""
function main1()
    input = read_input_file(input_file_path("day3.txt"))
    println(totaljoltage(input, 2))
end


"""
Solves day 3 part 2
"""
function main2()
    input = read_input_file(input_file_path("day3.txt"))
    println(totaljoltage(input, 12))
end
