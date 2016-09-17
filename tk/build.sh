#!/bin/bash
mkdir build
cd build

./configure --prefix=./build
make
make test
make install