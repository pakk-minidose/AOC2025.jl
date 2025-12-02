include("../utils/read_input.jl")
using .InputLoader
import Base: +, -


function parseinput(input::String)::Vector{Tuple{Char, Int}}
    split_input = split(input, '\n')
    len_input = length(split_input) - 1
    results = Vector{Tuple{Char, Int}}(undef, len_input)
    Threads.@threads for line_no in 1:len_input
        line = split_input[line_no]
        results[line_no] = (line[1], parse(Int, line[2:end]))
    end
    return results
end


struct Position
    position::Int
    max_position::Int

    function Position(position, max_position)
        function printerrorargs()
            return "`position=$position`, `max_position=$max_position`"
        end

        if position < 0 || max_position < 0
            throw(ArgumentError("All inputs to Position must be non-negative integers." * printerrorargs()))
        end
        if !(0 ≤ position ≤ max_position)
            throw(ArgumentError("Argument `position` is not within 0 and `max_position`." * printerrorargs()))
        end

        new(position, max_position)
    end

    function Position(position:: Int)
        Position(position, 99)
    end
end

function +(position::Position, by::Int)::Tuple{Position, Int}
    new_position = position.position + by
    zero_clicks = new_position ÷ (position.max_position + 1)
    remainder = new_position - zero_clicks * (position.max_position + 1)
    return Position(remainder, position.max_position), zero_clicks
end

function -(position::Position, by::Int)::Tuple{Position, Int}
    new_position = position.position - by
    zero_clicks = abs(new_position ÷ (position.max_position + 1))
    remainder = new_position + (position.max_position + 1) * zero_clicks
    if remainder < 0
        zero_clicks += 1
        remainder += position.max_position + 1
    end
    return Position(remainder, position.max_position), zero_clicks + (remainder==0) - (position.position == 0)
end

function moveby(position::Position, instruction::Tuple{Char, Int})::Tuple{Position, Int}
    if instruction[1] == 'R'
        return position + instruction[2]
    elseif instruction[1] == 'L'
        return position - instruction[2]
    else
        throw(ArgumentError("Invalid direction: $(instruction[1])")) 
    end
end

function zeropasses(position:: Position, instructions::Vector{Tuple{Char, Int}})::Tuple{Int, Int}
    zero_stops = 0
    zero_clicks = 0
    for instruction in instructions
        position, zp = moveby(position, instruction)
        if position.position == 0
            zero_stops += 1
        end
        zero_clicks += zp
    end
    return zero_stops, zero_clicks
end

function main(file_name::String)
    instructions = parseinput(read_input_file(input_file_path(file_name)))
    position = Position(50)
    z_passes = zeropasses(position, instructions)
    return z_passes
end

#=
# run the Julia with `julia --threads auto`
using Pkg
Pkg.activate(".")
using BenchmarkTools
include("./1/day1_optimized.jl")
const input = read_input_file(input_file_path("day1__part3.txt"))
const position = Position(50)
@benchmark zeropasses($position, parseinput($input))
=#

#=
using Pkg
Pkg.activate(".")
using Profile

include("./1/day1_optimized.jl")

const input = parseinput(read_input_file(input_file_path("day1__part3.txt")))
const position = Position(50)

function profiled(p, i)
    zeropasses(p, i)
end

profiled(position, input)

for _ in 1:100
    Profile.@profile profiled(position, input)
end

Profile.print()
=#
