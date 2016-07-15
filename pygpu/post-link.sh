#!/bin/bash

mkdir -p $PREFIX/etc/conda/deactivate.d
mkdir -p $PREFIX/etc/conda/activate.d

# deactivate.d
cat <<"EOF" > $PREFIX/etc/conda/deactivate.d/pygpu.sh
#!/bin/bash

if [ `uname` == Darwin ]; then
    export DYLD_LIBRARY_PATH=$MACLIBRARYPATHOLD
    export MACLIBRARYPATHOLD=
fi

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH_OLD
export LD_LIBRARY_PATH_OLD=

export LIBRARY_PATH=$LIBRARY_PATH_OLD
export LIBRARY_PATH_OLD=

export CPATH=$CPATH_OLD
export CPATH_OLD=

EOF

# activate.d
cat <<"EOF" > $PREFIX/etc/conda/activate.d/pygpu.sh
#!/bin/bash

if [ `uname` == Darwin ]; then
    export MACLIBRARYPATHOLD=$DYLD_LIBRARY_PATH
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$CONDA_PREFIX/libgpuarray/lib
fi

export LD_LIBRARY_PATH_OLD=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/libgpuarray/lib

export LIBRARY_PATH_OLD=$LIBRARY_PATH
export LIBRARY_PATH=$LIBRARY_PATH:$CONDA_PREFIX/libgpuarray/lib

export CPATH_OLD=$CPATH
export CPATH=$CPATH:$CONDA_PREFIX/libgpuarray/include

EOF