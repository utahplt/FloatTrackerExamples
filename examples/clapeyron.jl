using Clapeyron
using Clapeyron: ForwardDiff
using FloatTracker

# ForwardDiff.Dual

Base.:-(x::ForwardDiff.Dual, y::TrackedFloat32) = x - y.val
Base.:-(y::TrackedFloat32, x::ForwardDiff.Dual) = y.val - x
Base.:+(x::ForwardDiff.Dual, y::TrackedFloat32) = x + y.val
Base.:+(y::TrackedFloat32, x::ForwardDiff.Dual) = y.val + x
Base.:*(x::ForwardDiff.Dual, y::TrackedFloat32) = x * y.val
Base.:*(y::TrackedFloat32, x::ForwardDiff.Dual) = y.val * x
Base.:/(x::ForwardDiff.Dual, y::TrackedFloat32) = x / y.val
Base.:/(y::TrackedFloat32, x::ForwardDiff.Dual) = y.val / x

config_logger(filename="clapeyron", maxLogs=100, cstgArgs=true)
exclude_stacktrace([:prop, :kill])

model = VTPR(["carbon monoxide", "carbon dioxide"])
# bubble_pressure(model, TrackedFloat32(218.15), [TrackedFloat32(1e-5), TrackedFloat32(Base.-(1, 1e-5))])
# bubble_pressure(model, TrackedFloat32(218.15), [1e-5, Base.-(1, 1e-5)])
bubble_pressure(model, TrackedFloat32(218.15), [1e-5, 1 - 1e-5])
# bubble_pressure(model, 218.15, [1e-5, 1 - 1e-5])

ft_flush_logs()
