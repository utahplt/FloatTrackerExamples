using FloatTracker: TrackedFloat64, ft_flush_logs, config_logger
using Random
using Distributions: Uniform

config_logger(filename="himmilbeau", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function himmilbeau(X1, X2)
  (X1*X1 + X2 - 11)* (X1*X1 + X2 - 11) + (X1 + X2*X2 - 7)*(X1 + X2*X2 - 7)
end

nn = 20

for X1 in rand(Uniform(-5, 5), nn)
  for X2 in rand(Uniform(-5, 5), nn)
    himmilbeau(tf(X1), tf(X2))
  end
end

ft_flush_logs()

