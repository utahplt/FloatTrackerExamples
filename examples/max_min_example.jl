using FloatTracker

config_logger(filename="max_example", buffersize=1)

function maximum(lst)
  max_seen = 0.0
  for x in lst
    if ! (x <= max_seen)
      max_seen = x              # swap if new val greater
    end
  end
  max_seen
end

maximum([TrackedFloat32(x) for x in [1.0, 5.0, 4.0, NaN, 4.0]])
ft_flush_logs()
