using ShallowWaters, FloatTracker
# using BenchmarkTools, StatsPlots

# const bsuite = BenchmarkGroup()
# bsuite["baseline"] = BenchmarkGroup(["baseline"])
# bsuite["ft"] = BenchmarkGroup(["ft"])

# bsuite["baseline"]["basic"] = @benchmarkable run_model(nx=100, L_ratio=1, cfl=0.8, Ndays=300,
#                                                        bc="nonperiodic", wind_forcing_x="double_gyre",
#                                                        topography="seamount")

# bsuite["ft"]["basic"] = @benchmarkable run_model(T=TrackedFloat32,
#                                                  nx=100, L_ratio=1, cfl=0.8, Ndays=300,
#                                                  bc="nonperiodic", wind_forcing_x="double_gyre",
#                                                  topography="seamount")

# # If a cache of tuned parameters already exists, use it, otherwise, tune and cache
# # the benchmark parameters. Reusing cached parameters is faster and more reliable
# # than re-tuning `suite` every time the file is included.
# paramspath = joinpath(dirname(@__FILE__), "params.json")

# if isfile(paramspath)
#     loadparams!(bsuite, BenchmarkTools.load(paramspath)[1], :evals);
# else
#     tune!(bsuite)
#     BenchmarkTools.save(paramspath, params(bsuite));
# end

# results = run(bsuite)
# plot(results)


println("\n\n----- No FloatTracker; no NaN -----\n")
@time run_model(nx=100, L_ratio=1, cfl=0.8, Ndays=100,
                bc="nonperiodic", wind_forcing_x="double_gyre",
                topography="seamount")

println("\n\n----- No FloatTracker; yes NaN -----\n")
@time run_model(nx=100, L_ratio=1, cfl=1.5, Ndays=100,
                bc="nonperiodic", wind_forcing_x="double_gyre",
                topography="seamount")

println("\n\n----- With FloatTracker; no NaN -----\n")
@time run_model(T=TrackedFloat32,
                nx=100, L_ratio=1, cfl=0.8, Ndays=100,
                bc="nonperiodic", wind_forcing_x="double_gyre",
                topography="seamount")

println("\n\n----- With FloatTracker; yes NaN -----\n")
@time run_model(T=TrackedFloat32,
                nx=100, L_ratio=1, cfl=1.5, Ndays=100,
                bc="nonperiodic", wind_forcing_x="double_gyre",
                topography="seamount")

println("\n\n----- Limit to 100 gen events -----\n")
exclude_stacktrace([:prop, :kill])
config_logger(maxLogs=100)
@time run_model(T=TrackedFloat32,
                nx=100, L_ratio=1, cfl=1.5, Ndays=100,
                bc="nonperiodic", wind_forcing_x="double_gyre",
                topography="seamount")

println("\n\n----- No logging anywhere -----\n")
exclude_stacktrace([:gen, :prop, :kill])
@time run_model(T=TrackedFloat32,
                nx=100, L_ratio=1, cfl=1.5, Ndays=100,
                bc="nonperiodic", wind_forcing_x="double_gyre",
                topography="seamount")
