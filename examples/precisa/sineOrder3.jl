using FloatTracker: TrackedFloat64, write_out_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="sineOrder3", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function sineOrder3(Z)
  0.954929658551372 * Z -  0.12900613773279798*Z*Z*Z
end

nn = 100

for X in rand(Uniform(-2, 2), nn)
  sineOrder3(tf(X))
end

write_out_logs()

