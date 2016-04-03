#!/bin/bash

mkdir -p $PREFIX/etc/conda/deactivate.d
mkdir -p $PREFIX/etc/conda/activate.d

# deactivate.d
cat <<"EOF" > $PREFIX/etc/conda/deactivate.d/pygpu.sh
export CPATH=$CPATH_OLD
export CPATH_OLD=
EOF

# activate.d
cat <<"EOF" > $PREFIX/etc/conda/activate.d/pygpu.sh
export CPATH_OLD=$CPATH
export CPATH=$CPATH:$CONDA_ENV_PATH/include
EOF
