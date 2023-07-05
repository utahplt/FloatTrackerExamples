using FloatTracker
using ShallowWaters, PyPlot

config_logger(filename="pretty_nan_tf", buffersize=100000, cstg=true, cstgArgs=true, cstgLineNum=true)
exclude_stacktrace([:prop,:kill]) # Props and kills kill our performance

P = run_model(T=TrackedFloat32,
              nx=100, L_ratio=1, cfl=2, Ndays=300,
              bc="nonperiodic", wind_forcing_x="double_gyre",
              topography="seamount")

pcolormesh(P.η')
savefig("height_pretty_nan_tf.png")

speed = sqrt.(Ix(P.u.^2)[:,2:end-1] + Iy(P.v.^2)[2:end-1,:])
pcolormesh(speed')
savefig("speed_pretty_nan_tf.png")
