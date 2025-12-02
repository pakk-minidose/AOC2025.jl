input="11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

function parseinput(input)
    ranges = []
    for r in split(input, ',')
        minmax = split(r, '-')
        push!(ranges, parse(Int, minmax[1]):parse(Int, minmax[2]))
    end
    return ranges
end
parseinput(input)

function isdoublesequence(i)
    s = string(i)
    l = length(s)
    if l%2==1
        return false
    end
    return s[1:l÷2]==s[(l÷2)+1:end]
end
@assert isdoublesequence(55)
@assert isdoublesequence(6464)
@assert isdoublesequence(123123)

function main()
    ranges = parseinput(input)
    doubles = []
    for range in ranges
        for n in range
            if isdoublesequence(n)
                push!(doubles, n)
            end
        end
    end
    doubles
end
@assert sum(main()) == 1227775554
