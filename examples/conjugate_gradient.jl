using FloatTracker: TrackedFloat64, FunctionRef, write_out_logs, set_injector_config!, set_logger_config!, set_exclude_stacktrace!
using LinearAlgebra
using SparseArrays
using IterativeSolvers

# WARNING: FloatTracker API updates haven't been actually tested in full!

# fns = [FunctionRef(:norm2, Symbol("generic.jl"))]
# set_injector_config!(functions=fns)
set_logger_config!(filename="cg", cstg=true, cstgArgs=false, cstgLineNum=false)
# set_exlude_stacktrace!([:prop])

A = sparse([Float64(1), Float64(1), Float64(2), Float64(3)],
           [Float64(1), Float64(3), Float64(2), Float64(3)],
           [TrackedFloat64(0), TrackedFloat64(1), TrackedFloat64(2), TrackedFloat64(0)]
        )

B = [TrackedFloat64(1e-300), TrackedFloat64(3e-300), TrackedFloat64(1e-300)]
# B = [TrackedFloat64(2), TrackedFloat64(5), TrackedFloat64(1.5)]


# A = sparse([1.0,1.0,2.0,3.0],
#            [1.0,3.0,2.0,3.0],
#            [0.0,1.0,2.0,0.0]
#         )
#
# B = [1.0,3.0,2.0]

println(IterativeSolvers.cg(A, B))
write_out_logs()
