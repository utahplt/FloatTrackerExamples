using FloatTracker: TrackedFloat64, ft_flush_logs, config_logger
using Random
using Distributions: Uniform

config_logger(filename="jet", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function jet(X1, X2)
  T = (3*X1*X1 + 2*X2 - X1)
  X1 + ((2*X1*(T/(X1*X1 + 1))*
  (T/(X1*X1 + 1) - 3) + X1*X1*(4*(T/(X1*X1 + 1))-6))*
  (X1*X1 + 1) + 3*X1*X1*(T/(X1*X1 + 1)) + X1*X1*X1 + X1 +
  3*((3*X1*X1 + 2*X2 -X1)/(X1*X1 + 1)))
end

nn = 20

for X1 in rand(Uniform(-5, 5), nn)
  for X2 in rand(Uniform(-20, 5), nn)
    jet(tf(X1), tf(X2))
  end
end

ft_flush_logs()

