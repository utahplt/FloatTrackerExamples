using FloatTracker: TrackedFloat64, write_out_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="turbine1", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function turbine1(V, W, R)
  3 + 2 / (R * R) - 0.125 * (3 - 2 * V) * (W * W * R * R) / (1 - V) - 4.5
end

nn = 100

for V in rand(Uniform(-4.5, -0.3), nn)
  for W in rand(Uniform(0.4, 0.9), nn)
    for R in rand(Uniform(3.8, 7.8), nn)
      turbine1(tf(V), tf(W), tf(R))
    end
  end
end

write_out_logs()

