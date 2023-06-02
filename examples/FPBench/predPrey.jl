using FloatTracker: TrackedFloat64, write_out_logs, config_logger
using Random
using Distributions: Uniform

config_logger(filename="predPrey", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function predatorPrey(X)
  (4 * X * X) / (1 + (X/1.11) * (X / 1.11))
end

nn = 100

for X in rand(Uniform(0.1, 0.3), nn)
  predatorPrey(tf(X))
end

write_out_logs()

