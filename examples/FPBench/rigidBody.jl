using FloatTracker: TrackedFloat64, ft_flush_logs, config_logger
using Random
using Distributions: Uniform

config_logger(filename="rigidBody2", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function rigidBody1(X1,X2,X3)
  ((((-X1 * X2) - (2 * X2 * X3)) - X1) - X3)
end

function rigidBody2(X1,X2,X3)
  (2 * X1 * X2 * X3) + (3 * X3 * X3) - (X2 * X1 * X2 * X3) - (3 * X3 * X3) - X2
end

nn = 30

for X1 in rand(Uniform(-15, 15), nn)
  for X2 in rand(Uniform(-15, 15), nn)
    for X3 in rand(Uniform(-15, 15), nn)
      rigidBody1(tf(X1), tf(X2), tf(X3))
      rigidBody2(tf(X1), tf(X2), tf(X3))
    end
  end
end

ft_flush_logs()


