using FloatTracker: TrackedFloat64, ft_flush_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="t_div_t1", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function t_div_t1(T)
  T / (T + 1)
end

nn = 1000

for T in range(0, 999)
  t_div_t1(tf(T))
end

ft_flush_logs()
