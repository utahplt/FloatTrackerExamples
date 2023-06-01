#!/usr/bin/bash

JULIA_PROJECT=@.
DURATION=15s

function sec_header() {
    echo -e "\033[32;1m"
    echo "----------------------------------------------------------------------"
    echo $1
    echo "----------------------------------------------------------------------"
    echo -e "\033[0m"
}

function do_run () {
    echo -e "\n\033[34;1m → julia $1\033[0m"
    timeout $DURATION julia $1
}

echo -e "\033[35;1mRunning interesting examples… (timeout for each run: $DURATION)\033[0m"

sec_header "Basic examples"
do_run examples/max.jl
do_run examples/softmax.jl
do_run examples/conjugate_gradient.jl
do_run examples/gram_schmidt.jl
do_run examples/nbody.jl
do_run examples/shallow_waters.jl
do_run examples/sw_pretty_nan_tf.jl
do_run examples/sw_pretty_nonan_notf.jl

sec_header "Finch examples"
do_run examples/finch/example-poisson1d.jl
do_run examples/finch/example-advection1d-fv.jl
do_run examples/finch/example-advection2d-fv.jl
do_run examples/finch/example-heat2d.jl

sec_header "Metalhead"
echo "Nothing to do here yet"

sec_header "FPBench"
echo "Nothing to do here yet"
