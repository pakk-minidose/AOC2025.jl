# AOC2025.jl

## Day 1
Run `julia -e 'include("1/day1.jl"); println(main("day1.txt"))'` in your terminal. This will print a tuple of the form (solution_part_1, solution_part_2).

### Benchmarking
The näive solution in `1/day1.jl` can be benchmarked by executing the following code in the Julia REPL (run in the root of the repo):
```julia
using Pkg
Pkg.activate(".")
using BenchmarkTools

include("./1/day1.jl")

input = parseinput(read_input_file(input_file_path("day1.txt")))
position = Position(50)
@benchmark zeropasses($position, $input)
```

This gives us the following results:
![day1 benchmark results](day1_benchmark.png)