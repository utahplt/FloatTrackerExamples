using LinearAlgebra
using FloatTracker: TrackedFloat16, ft_flush_logs, enable_nan_injection, config_logger, exclude_stacktrace

enable_nan_injection()
config_logger(filename="gram_schmidt", buffersize=5)
exclude_stacktrace([:prop])

gs_cofficient(v1, v2) = dot(v2, v1) / dot(v1, v1)

multiply(cofficient, v) = map(x -> x * cofficient, v)

proj(v1, v2) = multiply(gs_cofficient(v1, v2), v1)

function gs(X)
  Y = []
  for v in X
    temp_vec = v
    for inY in Y
      proj_vec = proj(inY, v)
      temp_vec = map((x, y) -> x - y, temp_vec, proj_vec)
    end
    push!(Y, temp_vec)
  end
  Y
end

# Basic test
test = [[3.0 1.0], [2.0 2.0]]

# Test that produces nans
# test2 = [[1.0 1.0 0.0], [1.0 3.0 1.0], [2.0 -1.0 1.0], [1.0 1.0 0.0], [1.0 3.0 1.0], [2.0 -1.0 1.0]]

# Convert to tracked floats
tr_test = map(v -> map(x -> TrackedFloat16(x), v), test)
# tr_test2 = map(v -> map(x -> TrackedFloat16(x), v), test2)

println(test)
println(gs(tr_test))
# println(test2)
# println(gs(test))
# println(gs(tr_test2))
# for vector in gs(tr_test2) 
#   for x in vector
#     println(x)
#     if isnan(x.val)
#       println(x.journey)
#     end
#   end
# end

ft_flush_logs()
