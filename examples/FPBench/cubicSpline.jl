using FloatTracker: TrackedFloat64, write_out_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="cubicSpline", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function cubicSpline(x)
  if (x <= -1.00000000000000022204460492503136)
    (((0.25 * (x + 2)) * (x + 2)) * (x + 2))
  elseif (x <= -0.00000000000000022204460492503136)
    (0.25 * (((-3 * (x * (x * x))) - (6 * (x * x))) + 4))
  elseif (x <= 0.9999999999999998)
    (0.25 * (((3 * (x * (x * x))) - (6 * (x * x))) + 4))
  elseif (x > 1.00000000000000022204460492503136)
    (0.25 * ((2 - x) * ((2 - x) * (2 - x))))
  else
    0
  end
end

nn = 10

for x in rand(Uniform(-2, 2), nn)
  cubicSpline(tf(x))
end

write_out_logs()

