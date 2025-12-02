include("../utils/read_input.jl")
using .InputLoader

function parseinput(input)
    ranges = []
    for r in split(input, ',')
        minmax = split(r, '-')
        push!(ranges, parse(Int, minmax[1]):parse(Int, minmax[2]))
    end
    return ranges
end

function isdoublesequence(i)
    s = string(i)
    l = length(s)
    if l%2==1
        return false
    end
    return s[1:l÷2]==s[(l÷2)+1:end]
end

function main(ranges)
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