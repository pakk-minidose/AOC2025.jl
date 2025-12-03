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

function isrepeatedsequence(i)
    s = string(i)
    for ix in 1:(length(s)-1)
        div, rem = divrem(length(s), ix)
        if rem != 0
            continue
        end
        if s[1:ix]^div == s
            return true
        end
    end
    return false
end

function repeatedsequences(ranges)
    repeatedsequences = []
    for range in ranges
        for n in range
            if isrepeatedsequence(n)
                push!(repeatedsequences, n)
            end
        end
    end
    return repeatedsequences
end

"""
solves part 1 of the day 2 puzzle
"""
function main1()
    ranges = parseinput(read_input_file(input_file_path("day2.txt")))
    doubles = doublesequences(ranges)
    println(sum(doubles))
end

"""
solves part 2 of the day 2 puzzle
"""
function main2()
    ranges = parseinput(read_input_file(input_file_path("day2.txt")))
    repeats = repeatedsequences(ranges)
    println(sum(repeats))
end

function main3()
    ranges = [1:10000000000]
    doubles = doublesequences(ranges)
    println(sum(doubles))
    repeats = repeatedsequences(ranges)
    println(sum(repeats))
end