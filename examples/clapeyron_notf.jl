using Clapeyron

model = VTPR(["carbon monoxide", "carbon dioxide"])
res = bubble_pressure(model, 218.15, [1e-5, 1 - 1e-5])

