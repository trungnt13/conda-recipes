#!/bin/bash

if [ `uname` == Linux ]; then
    export CFLAGS="-I$PREFIX/include -L$PREFIX/lib"
#I had to install libpopt-dev to make this build
 #   export POPT_CFLAGS="-I$PREFIX/include -L$PREFIX/lib"
 #   export POPT_LIBS="-I$PREFIX/include -L$PREFIX/lib"
fi

./configure --prefix=$PREFIX
make
make install
