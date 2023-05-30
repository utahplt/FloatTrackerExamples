using FloatTracker: TrackedFloat64, write_out_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="kepler1", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function kepler1(X1, X2, X3, X4)
  X1 * X4 * (-X1 + X2 + X3 - X4)
  + X2 * (X1 - X2 + X3 + X4)
  + X3 * (X1 + X2 - X3 + X4)
  - X2 * X3 * X4 - X1 * X3 - X1 * X2 - X4
end

nn = 10

for X1 in rand(Uniform(4, 6.36), nn)
  for X2 in rand(Uniform(4, 6.36), nn)
    for X3 in rand(Uniform(4, 6.36), nn)
      for X4 in rand(Uniform(4, 6.36), nn)
        kepler1(tf(X1), tf(X2), tf(X3), tf(X4))
      end
    end
  end
end

write_out_logs()

