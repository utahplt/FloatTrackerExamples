using FloatTracker: TrackedFloat16, TrackedFloat32, ft_flush_logs, exclude_stacktrace, config_logger, ft_flush_logs
using ShallowWaters

exclude_stacktrace([:prop])

for search_id = 0:20
  run1_goodp = true
  run2_goodp = true
  run3_goodp = true
  run4_goodp = true

  run1_name = config_logger(filename="ndsh_id$search_id", buffersize=20, cstg=true, cstgArgs=false, cstgLineNum=false)
  println("Search $search_id; try 1; $run1_name")
  try
    P = run_model(T=TrackedFloat32, Tprog=TrackedFloat32, Tcomm=TrackedFloat32, Tini=TrackedFloat16,Ndays=2,nx=100,L_ratio=0.5,bc="nonperiodic",wind_forcing_x="double_gyre",topography="seamount", scale_sst=2^18, time_scheme="RK", output=1, cfl=search_id );
  catch e
    run1_goodp = false
  end
  ft_flush_logs()

  run2_name = config_logger(filename="ndsh_id$search_id", buffersize=20, cstg=true, cstgArgs=false, cstgLineNum=false)
  println("Search $search_id; try 2; run2_name")
  try
    P = run_model(T=TrackedFloat32, Tprog=TrackedFloat32, Tcomm=TrackedFloat32, Tini=TrackedFloat16,Ndays=2,nx=100,L_ratio=0.5,bc="nonperiodic",wind_forcing_x="double_gyre",topography="seamount", scale_sst=2^18, time_scheme="RK", output=1, cfl=search_id );
  catch e
    run2_goodp = false
  end
  ft_flush_logs()

  run3_name = config_logger(filename="ndsh_id$search_id", buffersize=20, cstg=true, cstgArgs=false, cstgLineNum=false)
  println("Search $search_id; try 3; $run3_name")
  try
    P = run_model(T=TrackedFloat32, Tprog=TrackedFloat32, Tcomm=TrackedFloat32, Tini=TrackedFloat16,Ndays=2,nx=100,L_ratio=0.5,bc="nonperiodic",wind_forcing_x="double_gyre",topography="seamount", scale_sst=2^18, time_scheme="RK", output=1, cfl=search_id );
  catch e
    run3_goodp = false
  end
  ft_flush_logs()

  run4_name = config_logger(filename="ndsh_id$search_id", buffersize=20, cstg=true, cstgArgs=false, cstgLineNum=false)
  println("Search $search_id; try 4; $run4_name")
  try
    P = run_model(T=TrackedFloat32, Tprog=TrackedFloat32, Tcomm=TrackedFloat32, Tini=TrackedFloat16,Ndays=2,nx=100,L_ratio=0.5,bc="nonperiodic",wind_forcing_x="double_gyre",topography="seamount", scale_sst=2^18, time_scheme="RK", output=1, cfl=search_id );
  catch e
    run4_goodp = false
  end
  ft_flush_logs()

  if run1_goodp == run2_goodp == run3_goodp == run4_goodp
    println("All runs had same return status $run1_goodp")
  else
    println("Runs did not all have same return: $run1_goodp $run2_goodp $run3_goodp $run4_goodp")
  end

  try
    run(`diff -s --brief $(run1_name)_error_log.txt $(run2_name)_error_log.txt`)
    run(`diff -s --brief $(run3_name)_error_log.txt $(run4_name)_error_log.txt`)
    run(`diff -s --brief $(run1_name)_error_log.txt $(run4_name)_error_log.txt`)
  catch e
    println("Failed to run diff: $e")
  end
end
