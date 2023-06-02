using FloatTracker: TrackedFloat64, write_out_logs, config_logger
using Random
using Distributions: Uniform

config_logger(filename="carbongas", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function carbonGas(V)
  K = 0.000000000000000000000013806503
  T = 300
  A = 0.401
  B = 0.0000427
  N = 1000
  P = 35000000
  (P + A * (N/V) * (N/V)) * (V - N * B) - (K * N * T)
end

nn = 10

for v in rand(Uniform(0.1,0.5), nn)
  carbonGas(tf(v))
end

write_out_logs()

