# Usage, run from the root of this repo:
#  $  julia --project=. examples/nbody_replay.jl

using Dates
using FloatTracker

config_logger(filename="nbody_logs", buffersize=20, cstg=true, cstgArgs=false, cstgLineNum=true)
replay_injection("nbody_loop_recording.txt")

println("FloatTracker configured; loading NBodySimulator...")
using NBodySimulator: NullThermostat, MassBody, InfiniteBox, GravitationalSystem, NBodySimulation, run_simulation
using StaticArrays

println("Configuring massive bodies...")
body1 = MassBody(SVector(TrackedFloat64(0.0), TrackedFloat64(1.0), TrackedFloat64(0.0)), SVector(TrackedFloat64(5.775e-6), TrackedFloat64(0.0), TrackedFloat64(0.0)), TrackedFloat64(2.0))
body2 = MassBody(SVector(TrackedFloat64(0.0), TrackedFloat64(-1.0), TrackedFloat64(0.0)), SVector(TrackedFloat64(-5.775e-6), TrackedFloat64(0.0), TrackedFloat64(0.0)), TrackedFloat64(2.0))
body3 = MassBody(SVector(TrackedFloat64(0.0), TrackedFloat64(-1.0), TrackedFloat64(1.0)), SVector(TrackedFloat64(-5.775e-6), TrackedFloat64(0.0), TrackedFloat64(0.0)), TrackedFloat64(5.0))

G = 6.673e-11
system = GravitationalSystem([body1, body2, body3], G)

tspan = (TrackedFloat64(0.0), TrackedFloat64(3000000.0))

println("Setting up simulation...")
simulation = NBodySimulation(system, tspan, InfiniteBox(SVector(TrackedFloat64(-Inf), TrackedFloat64(Inf), TrackedFloat64(-Inf), TrackedFloat64(Inf), TrackedFloat64(-Inf), TrackedFloat64(Inf))),
                             NullThermostat(), TrackedFloat64(1.38e-23), x -> 0, x -> 0, x -> 0) # the 1.38e-23 is the kb_SI var; units: J/K

println("Running simulation...")
sim_result = run_simulation(simulation)
println("Running simulation...done")

ft_flush_logs()
