using FloatTracker: TrackedFloat64, ft_flush_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="verhulst", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function verhulst(X)
  (4 * X)/(1 + (X/1.11))
end

nn = 2000

for X in rand(Uniform(0.1, 0.3), nn)
  verhulst(tf(X))
end

ft_flush_logs()

