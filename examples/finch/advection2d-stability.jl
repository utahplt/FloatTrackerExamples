using Finch

initFinch("FVadvection2d");

useLog("FVadvection2dslog", level=3)

# Configuration setup
domain(2)
solverType(FV)

timeStepper(EULER_EXPLICIT)
setSteps(0.005,400) # NOTE: steps are set manually in the animation code at the bottom

mesh(QUADMESH, elsperdim=[100, 100], bids=3)

# Variables and BCs
u = variable("u", location=CELL)
boundary(u, 1, FLUX, "(abs(y-0.1) < 0.05 && sin(3*pi*t)>0) ? 1 : 0") # x=0
boundary(u, 2, NO_BC) # x=1
boundary(u, 3, NO_BC) # y=0/1

# Time interval and initial condition
initial(u, 0)

# Coefficients
coefficient("a", ["cos(pi*x/2)","sin(pi*x/2)"], type=VECTOR) # advection velocity

# The "upwind" function applies upwinding to the term (a.n)*u with flow velocity a.
conservationForm(u, "surface(upwind(a,u))");

# Create an animated GIF

xy = Finch.finch_state.fv_info.cellCenters
using Plots

stepper = Finch.finch_state.time_stepper;
nsteps = 400; # 400 is stable, 200 is unstable
dt = 2.0 / nsteps;
stepsPerFrame = 4;
frames = Int(ceil(nsteps/stepsPerFrame));
setSteps(dt, stepsPerFrame)

anim = @animate for i=1:frames
    stepper.cfl = dt * stepsPerFrame * (i-1)
    solve(u);
    plot(xy[1,:], xy[2,:], u.values[:], st=:surface,camera=(30,45))
    zlims!(0.0,1.0)
end
gif(anim, "advection.gif", fps = 20)

finalizeFinch()
