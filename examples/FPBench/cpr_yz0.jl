using FloatTracker: TrackedFloat64, ft_flush_logs, config_logger
using Random
using Distributions: Uniform

config_logger(filename="cpr_yz0", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function yz0(lat)
  floor(((((lat - (360/60) * floor(lat/(360/ 60))) / (360/ 60)) * 131072) + 0.5))
end

nn = 10

for lat in rand(Uniform(-90, 90), nn)
  yz0(tf(lat))
end

ft_flush_logs()

