using FloatTracker: TrackedFloat64, write_out_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="doppler1", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function dop1(U,V,T)
  T1 = 331.4 + (0.6 * T)
  (-T1 * V) / ((T1 + U) * (T1 + U))
end

nn = 6

for U in rand(Uniform(-100, 100), nn)
  for V in rand(Uniform(20, 20000), nn)
    for T in rand(Uniform(-30, 50), nn)
      dop1(tf(U), tf(V), tf(T))
    end
  end
end

write_out_logs()


