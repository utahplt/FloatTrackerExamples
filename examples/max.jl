using FloatTracker: TrackedFloat16, write_out_logs, set_logger

set_logger(filename="max", buffersize=1)

function maximum(lst)
  max_seen = 0.0
  for x in lst
    if ! (x <= max_seen)
      max_seen = x              # swap if new val greater
    end
  end
  max_seen
end

function maximum2(lst)
  foldl(max, lst)
end

println("--- With less than ---")
# res = maximum([1, NaN, 4])
res = maximum([TrackedFloat16(x) for x in [1, 5, 4, NaN, 4]]).val
println("Result: $(res)")
println()

println("--- With builtin max ---")
# res2 = maximum2([1, NaN, 4])
res2 = maximum2([TrackedFloat16(x) for x in [1, NaN, 4]]).val
println("Result: $(res2)")

write_out_logs()
