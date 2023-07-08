using Dates

using NBodySimulator
using StaticArrays

my_c1 = 0.347111
my_c2 = 0.532728

c1 = 3.47111e-6
c2 = 5.32728e-6

println("Configuring massive bodies...")
# body1 = MassBody(SVector(-100.0, 0.0, 0.0), SVector(my_c1, my_c2, 0.0), 1.2)
# body2 = MassBody(SVector(100.0, 0.0, 0.0),  SVector(my_c1, my_c2, 0.0), 1.2)
# body3 = MassBody(SVector(0.0, 0.0, 0.0),  SVector(-2*my_c1, -2*my_c2, 0.0), 2.2)

body1 = MassBody(SVector(-1.0, 0.0, 0.0), SVector(c1, c2, 0.0), 1.5)
body2 = MassBody(SVector(1.0, 0.0, 0.0), SVector(c1, c2, 0.0), 1.5)
body3 = MassBody(SVector(-0.1, -0.1, 0.0), SVector(-2 * c1, -2 * c2, 0.0), 1.5)

G = 6.673e-11
system = GravitationalSystem([body1, body2, body3], G)

tspan = (0.0, 1500000.0)

println("Setting up simulation...")
system = GravitationalSystem([body1, body2, body3], G)
simulation = NBodySimulation(system, tspan)

println("Running simulation...")
sim_result = run_simulation(simulation)
println("Running simulation...done")

println("Plotting result...")
using Plots
animate(sim_result, "pretty_particles.gif", fps=10)
println("Plotting result...done")
