include("../utils/read_input.jl")
using .InputLoader


function parseinput(input)
    rows = split(input, '\n')[1:end-1]
    n_rows = length(rows)
    n_cols = length(first(rows))
    rolls_map = zeros(Bool, n_rows+2, n_cols+2)
    for (r_ix, row) in enumerate(rows)
        for  (c_ix, col) in enumerate(row)
            if row[c_ix] == '@'
                rolls_map[r_ix+1, c_ix+1] = true
            end
        end
    end
    return rolls_map
end

function findrolls(rolls_map)
    return findall(rolls_map)
end

function proximity(ix)
    return CartesianIndices(
            (
                ix[1]-1:ix[1]+1,
                ix[2]-1:ix[2]+1,
            )
        )
end

function isaccessible(ix, rolls_map)
    return sum(rolls_map[proximity(ix)]) ≤ 4
end

function allaccessible(input)
    rolls_map = parseinput(input)
    accessible_rolls = 0
    for roll_ix in findrolls(rolls_map)
        if isaccessible(roll_ix, rolls_map)
            accessible_rolls += 1
        end
    end
    return accessible_rolls
end

function accessall!(rolls_map)
    accessible_rolls = 0
    for roll_ix in findrolls(rolls_map)
        if isaccessible(roll_ix, rolls_map)
            accessible_rolls += 1
            rolls_map[roll_ix] = false
        end
    end
    return accessible_rolls
end

function allaccessible!(input)
    rolls_map = parseinput(input)
    last_accessed = -1
    accessible_rolls = 0
    while last_accessed != 0
        last_accessed = accessall!(rolls_map)
        accessible_rolls += last_accessed
    end
    return accessible_rolls
end


function main1()
    input = read_input_file(input_file_path("day4.txt"))
    println(allaccessible(rolls_map))
end

function main2()
    input = read_input_file(input_file_path("day4.txt"))
    println(allaccessible!(input))
end