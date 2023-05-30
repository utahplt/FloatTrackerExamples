using FloatTracker: TrackedFloat64, write_out_logs, set_logger_config!
using Random
using Distributions: Uniform

set_logger_config!(filename="sphere", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function sphere(R,X,Lat,Lon)
  X + R * (sin(Lat) * cos(Lon))
  # X + R * sin(Lat) * cos(Lon) worst round-off error
end

nn = 20

for R in rand(Uniform(0, 10), nn)
  for X in rand(Uniform(-10, 10), nn)
    for Lat in rand(Uniform(-1.570796, 1.570796), nn)
      for Lon in rand(Uniform(-3.14159265, 3.14159265), nn)
        sphere(tf(R),tf(X),tf(Lat),tf(Lon))
      end
    end
  end
end

write_out_logs()

