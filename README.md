# FloatTrackerExamples

Examples for the [FloatTracker.jl](https://github.com/utahplt/FloatTracker.jl) repository.

# Synopsis

To install the dependencies, open up a Julia REPL and enter the package manager by typing `]`, then run the following:

```
pkg> activate .
pkg> instantiate
```

Once the dependencies are loaded, you can run the examples with e.g.:

```
$ julia --project=. examples/nbody.jl
```

If the FloatTracker.jl source has updated, run the following from the package manager:

```
pkg> activate .
pkg> up
```

You can also add the FloatTracker.jl source as a dev dependency:

```
pkg> develop FloatTracker.jl
```

And when you want to switch back to the "normal" version:

```
pkg> free FloatTracker.jl
```

See instructions on the [Julia package manager docs](https://pkgdocs.julialang.org/v1/getting-started/#Modifying-A-Dependency).

# Description

[FloatTracker.jl](https://github.com/utahplt/FloatTracker.jl) is a [Julia](https://julialang.org) library for diagnosing floating-point errors. This repository showcases how it can be used.

## Examples

We've created several examples of our library in action, most utilizing existing Julia packages.

### NBodySimulator.jl

[NBodySimulator](https://github.com/SciML/NBodySimulator.jl) simulates n-interacting bodies.

```
$ julia --project=. examples/nbody.jl
```

### Finch.jl

[Finch](https://github.com/paralab/finch) is a DSL for solving partial differential equations numerically.

```
$ julia --project=. examples/finch/example-advection2d-fv.jl
```

### ShallowWaters.jl

[ShallowWaters.jl](https://github.com/milankl/shallowwaters.jl) is a Julia library for simulating a shallow water model. The interesting thing with this project is that the type of float used in the simulation has been parameterized, allowing us to easily inject our `TrackedFloat` type.

```
$ julia --project=. examples/shallow_waters.jl
```

# License

MIT License

# Authors

 - [Taylor Allred](https://github.com/tcallred)
 - [Ashton Wiersdorf](https://github.com/ashton314)
 - [Ben Greenman](https://github.com/bennn)
