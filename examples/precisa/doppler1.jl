using FloatTracker: TrackedFloat64, write_out_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="doppler1", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function dop1(U,V,T)
  # T | (331.4 + (0.6 * T) + U) * (331.4 + (0.6 * T) + U)/=0):unb_double=
  T1 = 331.4 + (0.6 * T)
  (-T1 * V) / ((T1 + U) * (T1 + U))
end

nn = 20

# dop1 inputs
for U in rand(Uniform(-100, 100), nn)
  for V in rand(Uniform(20, 20000), nn)
    for T in rand(Uniform(-30, 50), nn)
      dop1(tf(U), tf(V), tf(T))
    end
  end
end

# dop2
for U in rand(Uniform(-125, 125), nn)
  for V in rand(Uniform(15, 25000), nn)
    for T in rand(Uniform(-40, 60), nn)
      dop1(tf(U), tf(V), tf(T))
    end
  end
end

# dop3
for U in rand(Uniform(-30, 120), nn)
  for V in rand(Uniform(320, 20300), nn)
    for T in rand(Uniform(-50, 30), nn)
      dop1(tf(U), tf(V), tf(T))
    end
  end
end

write_out_logs()

