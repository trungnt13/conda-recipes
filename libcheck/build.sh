#!/bin/bash
# cd <dir>
# mkdir Build
# cd Build
# # you can pass -DCMAKE_INSTALL_PREFIX=/path/to/somewhere to install to an alternate location
# cmake .. -DCMAKE_BUILD_TYPE=Release # or Debug if you are investigating a crash
# make
# make install
# cd ..

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/lib64/
# export LIBRARY_PATH=$LIBRARY_PATH:~/.local/lib64/
# export CPATH=$CPATH:~/.local/include
# export LIBRARY_PATH=$LIBRARY_PATH:~/.local/lib
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/lib

INSTALL_DIR=$PREFIX
CONDA_ENV_PATH=$(conda info -e | grep '*' | tr -s ' ' | cut -d' ' -f3)

####### for mac ######
if [ `uname` == Darwin ]; then
    echo "Darwin detected!"
    export CC=clang
    export CXX=clang++
####### for linux #######
else
    echo "Linux detected!"
    export CC=gcc
    export CXX=g++

    # export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_ENV_PATH/lib
    # export LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_ENV_PATH/lib
    # export CPATH=$LD_LIBRARY_PATH:$CONDA_ENV_PATH/include
fi

./configure --prefix=$INSTALL_DIR --bindir=$CONDA_ENV_PATH/bin --libdir=$CONDA_ENV_PATH/lib --includedir=$CONDA_ENV_PATH/include

make
# ignore the tests
# make check
make install