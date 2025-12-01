module InputLoader
export input_file_path, read_input_file

const module_dir = dirname(@__FILE__)

function input_file_path(input_file_name::String)
    return abspath(joinpath(module_dir, "../inputs", input_file_name))
end

function read_input_file(input_file_path::String)
    if !isfile(input_file_path)
        throw(ArgumentError("$input_file_path is not a valid file"))
    end
    return read(input_file_path, String)
end

end