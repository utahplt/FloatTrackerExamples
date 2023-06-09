using Dates
using FloatTracker

config_logger(filename="nbody_logs", buffersize=20, cstg=true, cstgArgs=false, cstgLineNum=true)
fns = [FunctionRef(:run_simulation, Symbol("nbody_simulation_result.jl"))]
libs = ["NBodySimulator", "OrdinaryDiffEq"]
now_str = Dates.format(now(), "yyyymmddHHMMss")
recording_file = "nbody_recording_$now_str"
println("Recording to $recording_file...")
config_injector(odds=2, functions=fns, libraries=libs)
record_injection(recording_file)

# set_exclude_stacktrace([:prop])

println("FloatTracker configured; loading NBodySimulator...")
using NBodySimulator: NullThermostat, MassBody, InfiniteBox, GravitationalSystem, NBodySimulation, run_simulation
using StaticArrays

# body1 = MassBody(SVector(0.0, 1.0, 0.0), SVector(5.775e-6, 0.0, 0.0), 2.0)
# body2 = MassBody(SVector(0.0, -1.0, 0.0), SVector(-5.775e-6, 0.0, 0.0), 2.0)

println("Configuring massive bodies...")
body1 = MassBody(SVector(TrackedFloat64(0.0), TrackedFloat64(1.0), TrackedFloat64(0.0)), SVector(TrackedFloat64(5.775e-6), TrackedFloat64(0.0), TrackedFloat64(0.0)), TrackedFloat64(2.0))
body2 = MassBody(SVector(TrackedFloat64(0.0), TrackedFloat64(-1.0), TrackedFloat64(0.0)), SVector(TrackedFloat64(-5.775e-6), TrackedFloat64(0.0), TrackedFloat64(0.0)), TrackedFloat64(2.0))
body3 = MassBody(SVector(TrackedFloat64(0.0), TrackedFloat64(-1.0), TrackedFloat64(1.0)), SVector(TrackedFloat64(-5.775e-6), TrackedFloat64(0.0), TrackedFloat64(0.0)), TrackedFloat64(5.0))

# This version is really close to the second body, and it crashes
# body3 = MassBody(SVector(TrackedFloat64(0.0), TrackedFloat64(-1.0), TrackedFloat64(0.1)), SVector(TrackedFloat64(-5.775e-6), TrackedFloat64(0.0), TrackedFloat64(0.0)), TrackedFloat64(5.0))

# This configuration of the third body (pretty identical to the second body) makes it kill NaNs
# body3 = MassBody(SVector(TrackedFloat64(0.0), TrackedFloat64(-1.0), TrackedFloat64(0.0)), SVector(TrackedFloat64(-5.775e-6), TrackedFloat64(0.0), TrackedFloat64(0.0)), TrackedFloat64(5.0))

G = 6.673e-11
system = GravitationalSystem([body1, body2, body3], G)

# tspan = (0.0, 1111150.0)

tspan = (TrackedFloat64(0.0), TrackedFloat64(3000000.0))

println("Setting up simulation...")
simulation = NBodySimulation(system, tspan, InfiniteBox(SVector(TrackedFloat64(-Inf), TrackedFloat64(Inf), TrackedFloat64(-Inf), TrackedFloat64(Inf), TrackedFloat64(-Inf), TrackedFloat64(Inf))),
                             NullThermostat(), TrackedFloat64(1.38e-23), x -> 0, x -> 0, x -> 0) # the 1.38e-23 is the kb_SI var; units: J/K

println("Running simulation...")
sim_result = run_simulation(simulation)
println("Running simulation...done")

# println("Plotting result...")
# using Plots
# animate(sim_result, "animated_particles.gif")
# println("Plotting result...done")

ft_flush_logs()
