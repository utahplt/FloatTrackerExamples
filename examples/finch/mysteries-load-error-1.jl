# 2D advection solving mysteries

# Misc utils.
using ArgParse
using Dates

using Finch # Note: to add the package, first do: ]add "https://github.com/paralab/Finch.git"
using FloatTracker:
    TrackedFloat64, set_exclude_stacktrace, set_inject_nan, set_logger, write_log_to_file

function parse_recording_args()
  aps = ArgParseSettings()

  now_str = Dates.format(now(), "yyyymmddHHMMss")
  default_recording_file = "rand-adv2d-recording_$now_str"

  @add_arg_table! aps begin
    "--record"
        help = "turn on recording"
        action = :store_true

    "--recording-file"
        help = "set default recording file"
        arg_type = String
        default = default_recording_file

    "--replay-file"
        help = "replay from file; overridden by --record"
        arg_type = String
        default = ""
  end

  return parse_args(aps)
end

####################### FloatTracker configuration ######################

set_exclude_stacktrace([:prop])
set_logger(filename="inj-adv2d", buffersize=20, cstg=true, cstgArgs=false, cstgLineNum=true)

fns = []
libs = []

# Check args to see if we should record or not
parsed_args = parse_recording_args()
println("Parsed args:")
for (arg,val) in parsed_args
  println("  $arg  =>  $val")
end

# Recording setup
println("Recording to $recording_file...")

# Injection setup
set_inject_nan(true, 1000, 1, fns, libs, record=recording_file)

####################### Finch setup ######################################

initFinch("inj-adv2d", TrackedFloat64) # This is where we tell Finch to use our
                                       # TrackedFloat type---very handy

domain(2)
solverType(FV)

# NaN-making timestepper
timeStepper(EULER_EXPLICIT,cfl=20000)

# Make a uniform grid of quads on a 0.1 x 0.3 rectangle domain
println("Setting up mesh...")
mesh(QUADMESH, elsperdim=[15, 45], bids=4, interval=[0, 0.1, 0, 0.3])
println("Setting up mesh...done")

# Variables and BCs
u = variable("u", location=CELL)
boundary(u, 1, FLUX, "(abs(y-0.06) < 0.033 && sin(3*pi*t)>0) ? 1 : 0") # x=0
boundary(u, 2, NO_BC) # x=0.1
boundary(u, 3, NO_BC) # y=0
boundary(u, 4, NO_BC) # y=0.3

# Time interval and initial condition
T = 1.3;                        # Also try: T = 10
timeInterval(T)
initial(u, "0")

# Coefficients
coefficient("a", ["0.1*cos(pi*x/2/0.1)","0.3*sin(pi*x/2/0.1)"], type=VECTOR) # advection velocity
coefficient("s", ["0.1 * sin(pi*x)^4 * sin(pi*y)^4"]) # source

# The "upwind" function applies upwinding to the term (a.n)*u with flow velocity a.
# The optional third parameter is for tuning. Default upwind = 0, central = 1. Choose something between these.
conservationForm(u, "s + surface(upwind(a,u))");

println("Solving...")
solve(u)
println("Solving...done")

finalizeFinch()

write_log_to_file()
