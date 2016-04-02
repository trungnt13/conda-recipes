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

BUILD_DIR=$SRC_DIR/Build
INSTALL_DIR=$PREFIX
CONDA_ENV_PATH=$(conda info -e | grep '*' | tr -s ' ' | cut -d' ' -f3)

mkdir $BUILD_DIR
cd $BUILD_DIR

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

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_ENV_PATH/lib
    export LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_ENV_PATH/lib
    export CPATH=$LD_LIBRARY_PATH:$CONDA_ENV_PATH/include
fi

cmake .. -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release
make
make install

cd ..

python setup.py build_ext -L $INSTALL_DIR/lib -I $INSTALL_DIR/include
python setup.py install

rm -rf $BUILD_DIR
