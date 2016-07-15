#!/bin/bash
# If conda cannot find gpuarray/array.h :
# export CPATH=$CPATH:/path/to/conda/envs/name/include

# Build ...
BUILD_DIR=$SRC_DIR/Build
INSTALL_DIR=~/.local/libgpuarray
# $PREFIX/libgpuarray

mkdir $BUILD_DIR
rm -rf $INSTALL_DIR # remove old libgpuarray
mkdir $INSTALL_DIR
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

# Add PATH to .bashrc
if [ `uname` == Darwin ]; then
    if ! grep -Fxq 'export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:~/.local/libgpuarray/lib' ~/.bashrc
        then
            echo "" >> ~/.bashrc
            echo '################# libgpuarray' >> ~/.bashrc
            echo 'export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:~/.local/libgpuarray/lib' >> ~/.bashrc
            export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:~/.local/libgpuarray/lib
        fi
else
    echo "" >> ~/.bashrc
    echo '################# libgpuarray' >> ~/.bashrc
fi

if ! grep -Fxq 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/libgpuarray/lib' ~/.bashrc
    then
        echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/libgpuarray/lib' >> ~/.bashrc
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/libgpuarray/lib
    fi

if ! grep -Fxq 'export LIBRARY_PATH=$LIBRARY_PATH:~/.local/libgpuarray/lib' ~/.bashrc
    then
        echo 'export LIBRARY_PATH=$LIBRARY_PATH:~/.local/libgpuarray/lib' >> ~/.bashrc
        export LIBRARY_PATH=$LIBRARY_PATH:~/.local/libgpuarray/lib
    fi

if ! grep -Fxq 'export CPATH=$CPATH:~/.local/libgpuarray/include' ~/.bashrc
    then
        echo 'export CPATH=$CPATH:~/.local/libgpuarray/include' >> ~/.bashrc
        export CPATH=$CPATH:~/.local/libgpuarray/include
    fi
