using FloatTracker: TrackedFloat64, ft_flush_logs, config_logger
using Random
using Distributions: Uniform

config_logger(filename="kepler0", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function kepler0(X1, X2, X3, X4, X5, X6)
    X2 * X5 + X3 * X6 - X2 * X3 - X5 * X6
                 + X1 * (-X1 + X2 + X3 - X4 + X5 + X6)
end

nn = 10

for X1 in rand(Uniform(4, 6.36), nn)
  for X2 in rand(Uniform(4, 6.36), nn)
    for X3 in rand(Uniform(4, 6.36), nn)
      for X4 in rand(Uniform(4, 6.36), nn)
        for X5 in rand(Uniform(4, 6.36), nn)
          for X6 in rand(Uniform(4, 6.36), nn)
            kepler0(tf(X1), tf(X2), tf(X3), tf(X4), tf(X5), tf(X6))
          end
        end
      end
    end
  end
end

ft_flush_logs()

