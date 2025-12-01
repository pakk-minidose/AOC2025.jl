include("../utils/read_input.jl")
using .InputLoader
import Base: +, -

function loadinput()::String
    return 
end

function parseinput(input::String)::Vector{Tuple{Char, Int}}
    return [
            (line[1], parse(Int, line[2:end])) 
            for line in split(input, '\n') if !isempty(line)
        ]
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
    if by < 0
        throw(ArgumentError("Argument `by` must be non-negative. by=$by"))
    end
    new_position = position.position + by
    zero_clicks = 0
    while new_position > position.max_position
        new_position -= position.max_position + 1
        zero_clicks +=1
    end
    return Position(new_position, position.max_position), zero_clicks
end

function -(position::Position, by::Int)::Tuple{Position, Int}
    if by < 0
        throw(ArgumentError("Argument `by` must be non-negative. by=$by"))
    end
    new_position = position.position - by
    zero_clicks = 0
    while new_position < 0
        # zero pass
        new_position += position.max_position + 1
        zero_clicks += 1
    end
    if new_position == 0
        # stopping right at zero without going further
        zero_clicks += 1
    end
    if position.position == 0
        # started already at 0 so the first underflow is not a click ending at zero or passing it
        zero_clicks -= 1
    end
    return Position(new_position, position.max_position), zero_clicks
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
    println(z_passes)
    return z_passes
end
