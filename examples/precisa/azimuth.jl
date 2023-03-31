using FloatTracker: TrackedFloat64, write_out_logs, set_logger
using Random
using Distributions: Uniform

set_logger(filename="azimuth", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function azimuth(lat1, lon1, lat2, lon2)
  dlon = NaN # lon2 - lon1
  y = cos(lat2) * sin(dlon)
  x = (cos(lat1) * sin(lat2)) - (sin(lat1) * (cos(lat2) * cos(dlon)))
  atan(y / x)
end

nn = 2

for lat1 in rand(Uniform(0,0.4), nn)
  for lat2 in rand(Uniform(0.5,1), nn)
    for lon1 in rand(Uniform(0,3.14159265), nn)
      for lon2 in rand(Uniform(-3.14159265,-0.5), nn)
        azimuth(tf(lat1), tf(lat2), tf(lon1), tf(lon2))
      end
    end
  end
end

write_out_logs()
