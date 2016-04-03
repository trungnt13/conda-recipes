#!/bin/bash
# If conda cannot find gpuarray/array.h :
# export CPATH=$CPATH:/path/to/conda/envs/name/include


BUILD_DIR=$SRC_DIR/Build
INSTALL_DIR=$PREFIX

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
fi

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PREFIX/lib
export LIBRARY_PATH=$LIBRARY_PATH:$PREFIX/lib
export CPATH=$CPATH:$PREFIX/include

cmake .. -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release
make
make install

cd ..

python setup.py build_ext -L $INSTALL_DIR/lib -I $INSTALL_DIR/include
python setup.py install

rm -rf $BUILD_DIR
