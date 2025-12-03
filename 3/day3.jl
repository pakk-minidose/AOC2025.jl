function highestjoltage(bank::String)
    int_bank = [parse(Int, c) for c in bank]
    first_ix = argmax(int_bank[1:end-1])
    second_ix = argmax(int_bank[(first_ix+1):end]) + first_ix
    return int_bank[first_ix]*10 + int_bank[second_ix]
end


function totaljoltage(input)
    sum(highestjoltage(row) for row in eachline(IOBuffer(input)))
end



input=
"987654321111111
811111111111119
234234234234278
818181911112111"

rows = collect(eachline(IOBuffer(input)))

@assert highestjoltage(rows[1]) == 98
@assert highestjoltage(rows[2]) == 89
@assert highestjoltage(rows[3]) == 78
@assert highestjoltage(rows[4]) == 92

@assert totaljoltage(input) == 357