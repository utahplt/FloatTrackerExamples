
using FloatTracker: TrackedFloat64, write_out_logs, set_logger_config!
using Random
using Distributions: Uniform

set_logger_config!(filename="logExp", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function polycarp(P_i_x, P_i_y, S_x, S_y, BUFF)
  if ((P_i_y >= (S_y - BUFF)) && (abs(P_i_x - S_x) < BUFF))
    P_i_x - (2 * BUFF)
  else
    P_i_x
  end
end

nn = 9

for P_i_x in rand(Uniform(1, 10), nn)
  for P_i_y in rand(Uniform(1, 10), nn)
    for S_x in rand(Uniform(1, 10), nn)
      for S_y in rand(Uniform(1, 10), nn)
        for BUFF in rand(Uniform(0.1, 0.3), nn)
          polycarp(tf(P_i_x),tf(P_i_y),tf(S_x),tf(S_y),tf(BUFF))
        end
      end
    end
  end
end

write_out_logs()


