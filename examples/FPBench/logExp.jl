
using FloatTracker: TrackedFloat64, ft_flush_logs, config_logger
using Random
using Distributions: Uniform

config_logger(filename="logExp", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function logExp(X)
   log(1 + exp(X))
end

nn = 100

for X1 in rand(Uniform(-8, 8), nn)
  logExp(tf(X1))
end

ft_flush_logs()

