using FloatTracker
using ShallowWaters, PyPlot

config_logger(filename="nan_tf", buffersize=20, cstg=true, cstgArgs=true, cstgLineNum=true)
exclude_stacktrace([:prop])

P = run_model(T=TrackedFloat32,
              cfl=10, Ndays=100, nx=100, L_ratio=1,
              bc="nonperiodic", wind_forcing_x="double_gyre",
              topography="seamount")
pcolormesh(P.η')
savefig("height_nan_tf.png")

speed = sqrt.(Ix(P.u.^2)[:,2:end-1] + Iy(P.v.^2)[2:end-1,:])
pcolormesh(speed')
savefig("speed_nan_tf.png")

ft_flush_logs()
