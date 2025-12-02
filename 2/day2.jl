include("../utils/read_input.jl")
using .InputLoader

function parseinput(input::String)::Vector{UnitRange{Int64}}
    ranges = []
    for r in split(input, ',')
        minmax = split(r, '-')
        push!(ranges, parse(Int, minmax[1]):parse(Int, minmax[2]))
    end
    return ranges
end

function isdoublesequence(i::Int)::Bool
    s = string(i)
    l = length(s)
    if l%2==1
        return false
    end
    return s[1:l÷2]==s[(l÷2)+1:end]
end

function doublesequences(ranges::Vector{UnitRange{Int64}})::Vector{Int}
    doubles = []
    for range in ranges
        for n in range
            if isdoublesequence(n)
                push!(doubles, n)
            end
        end
    end
    return doubles
end

"""
solves part 1 of the day 2 puzzle
"""
function main()
    ranges = parseinput(read_input_file(input_file_path("day2.txt")))
    doubles = doublesequences(ranges)
    println(sum(doubles))
end