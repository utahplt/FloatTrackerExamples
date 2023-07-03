using FloatTracker: TrackedFloat16, TrackedFloat32, ft_flush_logs, exclude_stacktrace, config_logger
using ShallowWaters, PyPlot

# Dialing the logger high has some inpact too
config_logger(filename="pretty_nan_tf", buffersize=100000, cstg=true, cstgArgs=true, cstgLineNum=true)
# set_exclude_stacktrace([:prop,:kill,:gen])
# Props and kills take the lion share of the perf hit
exclude_stacktrace([:prop,:kill])

P = run_model(T=TrackedFloat32,
              nx=100, L_ratio=1, bc="nonperiodic", wind_forcing_x="double_gyre",
              topography="seamount",cfl=2,Ndays=300)

pcolormesh(P.η')
savefig("height_pretty_nan_tf.png")

speed = sqrt.(Ix(P.u.^2)[:,2:end-1] + Iy(P.v.^2)[2:end-1,:])
pcolormesh(speed')
savefig("speed_pretty_nan_tf.png")
