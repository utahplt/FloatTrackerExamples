using FloatTracker: TrackedFloat64, ft_flush_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="styblinski", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function styblinski(X, Y)
  if (Y <= 0)
    if (X <= 0)
      -1.4717 +  2.83079 * X + 0.786996 * X * X + 2.83079 * Y - 0.000000000000000107939 * X * Y + 0.786996 * Y * Y
    else
      -1.4717 - 2.33079 * X + 0.786996 * X*X + 2.83079 * Y + 0.00000000000000091748 * X * Y + 0.786996 * Y * Y
    end
  else
    if (X <= 0)
      -1.4717 + (2.83079 * X) + (0.786996 * X * X) - 2.33079 * Y + 0.000000000000000323816 * X * Y + 0.786996 * Y * Y
    else
      -1.4717 - 2.33079 * X + 0.786996 * X * X - 2.33079 * Y + 0.00000000000000172702 * X * Y + 0.786996 * Y * Y
    end
  end
end

nn = 100

for X in rand(Uniform(-5, 5), nn)
  for Y in rand(Uniform(-5, 5), nn)
    styblinski(tf(X),tf(Y))
  end
end

ft_flush_logs()
