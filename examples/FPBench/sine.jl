using FloatTracker: TrackedFloat64, write_out_logs, set_logger_config!
using Random
using Distributions: Uniform

set_logger_config!(filename="sine", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function sine(X)
  X - (X*X*X)/6 + (X*X*X*X*X)/120 - (X*X*X*X*X*X*X)/5040
end

nn = 100

for X in rand(Uniform(-1.57079632679, 1.57079632679), nn)
  sine(tf(X))
end

write_out_logs()

