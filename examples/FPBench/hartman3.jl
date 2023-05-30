using FloatTracker: TrackedFloat64, write_out_logs, set_logger_config!
using Random
using Distributions: Uniform

set_logger_config!(filename="hartman3", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

function hartman3(X1,X2,X3)
  E1 = (3 * (X1 - 0.3689) * (X1 - 0.3689)) +
            (10 * (X2 - 0.117) * (X2 - 0.117)) +
                  (30 * (X3 - 0.2673) * (X3 - 0.2673))
  E2 = (0.1 * (X1 - 0.4699) * (X1 - 0.4699)) +
              (10 * (X2 - 0.4387) * (X2 - 0.4387)) +
                   (35 * (X3 - 0.747) * (X3 - 0.747))
  E3 = (3 * (X1 - 0.1091) * (X1 - 0.1091)) +
               (10 * (X2 - 0.8732) * (X2 - 0.8732)) +
                    (30 * (X3 - 0.5547) * (X3 - 0.5547))
  E4 = (0.1 * (X1 - 0.03815) * (X1 - 0.03815)) +
              (10 * (X2 - 0.5743) * (X2 - 0.5743)) +
                   (35 * (X3 - 0.8828) * (X3 - 0.8828))
  -((1 * exp(-E1)) + (1.2 * exp(-E2)) + (3 * exp(-E3)) + (3.2 * exp(-E4)))
end

nn = 50

for X1 in rand(Uniform(0, 1), nn)
  for X2 in rand(Uniform(0, 1), nn)
    for X3 in rand(Uniform(0, 1), nn)
      hartman3(tf(X1), tf(X2), tf(X3))
    end
  end
end

write_out_logs()

