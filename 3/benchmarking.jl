include("day3_optimized.jl")

const input = read_input_file(input_file_path("day3.txt"))
@allocations totaljoltage(input, 12)
# 8201 for the original version
# 3401 new version with view
# 3001 with preallocated indices, now about 50% of allocations happens when reading the input
# 2001 when replacing eachline with split
# 1610 when replacing reverse with view


using Pkg, Profile
Pkg.activate(".")
using PProf

Profile.Allocs.clear()
totaljoltage(input, 12)
Profile.Allocs.@profile sample_rate=1.0 totaljoltage(input, 12)
p = Profile.Allocs.fetch()
length(p.allocs)
PProf.Allocs.pprof(p; from_c=false)

Profile.clear()
for _ in 1:100
    Profile.@profile totaljoltage(input, 12)
end
Profile.print()
# currently the biggest slowdown is in the parsing of the string input to a list of integers and in the argmax

using BenchmarkTools
@benchmark totaljoltage($input, 12)
#=original benchmark
julia> @benchmark totaljoltage($input, 12)
BenchmarkTools.Trial: 10000 samples with 1 evaluation per sample.
 Range (min … max):  201.458 μs …  16.731 ms  ┊ GC (min … max):  0.00% … 98.41%
 Time  (median):     208.917 μs               ┊ GC (median):     0.00%
 Time  (mean ± σ):   246.536 μs ± 319.015 μs  ┊ GC (mean ± σ):  13.93% ± 12.85%

  █▄▃                                                           ▁
  ███▇▆▅▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▅██▆▆▇ █
  201 μs        Histogram: log(frequency) by time       1.47 ms <

 Memory estimate: 1.01 MiB, allocs estimate: 8201.
=#
#=new benchmark with view
Julia> @benchmark totaljoltage($input, 12)
BenchmarkTools.Trial: 10000 samples with 1 evaluation per sample.
 Range (min … max):  151.583 μs …  12.872 ms  ┊ GC (min … max): 0.00% … 98.08%
 Time  (median):     154.959 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   172.824 μs ± 205.218 μs  ┊ GC (mean ± σ):  8.34% ±  9.79%

  █▄▃▂                                                          ▁
  ████▇▇▆▅▄▄▃▃▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▆▇▇ █
  152 μs        Histogram: log(frequency) by time        878 μs <

 Memory estimate: 409.47 KiB, allocs estimate: 2802.
=#
#=new benchmark with indices preallocation
julia> @benchmark totaljoltage($input, 12)
BenchmarkTools.Trial: 10000 samples with 1 evaluation per sample.
 Range (min … max):  144.916 μs …  11.633 ms  ┊ GC (min … max): 0.00% … 98.41%
 Time  (median):     148.917 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   165.417 μs ± 181.067 μs  ┊ GC (mean ± σ):  7.77% ±  9.30%

  █▅▂▁                                                          ▁
  ████▇▇▆▅▅▅▄▁▁▃▁▁▃▃▁▃▁▁▁▁▃▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▅▆▅▅ █
  145 μs        Histogram: log(frequency) by time        862 μs <

 Memory estimate: 346.97 KiB, allocs estimate: 2402.
=#
#=new multithreaded runtime
julia> @benchmark totaljoltage($input, 12)
BenchmarkTools.Trial: 10000 samples with 1 evaluation per sample.
 Range (min … max):   68.084 μs …   6.290 ms  ┊ GC (min … max):  0.00% … 96.33%
 Time  (median):      78.875 μs               ┊ GC (median):     0.00%
 Time  (mean ± σ):   101.164 μs ± 176.964 μs  ┊ GC (mean ± σ):  16.71% ±  9.81%

  █▄▂▁                                                          ▁
  ████▇██▇▅▄▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▃▄▄▄▆▄▅▆ █
  68.1 μs       Histogram: log(frequency) by time       1.16 ms <

 Memory estimate: 358.28 KiB, allocs estimate: 2632.
=#
