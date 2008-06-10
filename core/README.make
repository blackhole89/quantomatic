To make the binary you need to a set a few things up... You need to
have an environment variable POLYLIB so that library linking
succeeds. I suspect this is not needed if you have polyml installed in
a standard place, but for non-standard installs, something like the
following needs to be in your environment setup:

export POLYLIB="YOUR_PATH_TO_POLYML_DIR/polyml-5.2.0/lib"
export LD_LIBRARY_PATH="$POLYLIB:$LD_LIBRARY_PATH"
export DYLD_LIBRARY_PATH="$POLYLIB:$DYLD_LIBRARY_PATH"

If you have polyml in a standard place, or have set it up correctly,
you should simply be able to type 

make

and it will build the quantomatic executable in the bin directory.  