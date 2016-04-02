#!/bin/bash
# cd <dir>
# mkdir Build
# cd Build
# # you can pass -DCMAKE_INSTALL_PREFIX=/path/to/somewhere to install to an alternate location
# cmake .. -DCMAKE_BUILD_TYPE=Release # or Debug if you are investigating a crash
# make
# make install
# cd ..

BUILD_DIR=$SRC_DIR/Build
INSTALL_DIR=$PREFIX

mkdir BUILD_DIR
cd BUILD_DIR

####### for mac ######
if [ `uname` == Darwin ]; then
    echo "Darwin detected!"
    export CC=clang
    export CXX=clang++
####### for linux #######
else
    echo "Linux detected!"
fi

cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release
make
make install

cd ..

python setup.py build_ext -L $INSTALL_DIR/lib -I $INSTALL_DIR/include
python setup.py install

rm -rf $BUILD_DIR
