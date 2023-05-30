using FloatTracker: TrackedFloat64, write_out_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="sqroot", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function sqroot(Y)
  1 + 0.5 * Y - 0.125 * Y * Y + 0.0625 * Y * Y * Y - 0.0390625 * Y * Y * Y * Y
end

nn = 2000

for Y in rand(Uniform(0, 1), nn)
  sqroot(tf(Y))
end

write_out_logs()

