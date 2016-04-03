#!/bin/bash

mkdir -p $PREFIX/etc/conda/deactivate.d
mkdir -p $PREFIX/etc/conda/activate.d
# deactivate.d
cat <<EOF > $PREFIX/etc/conda/deactivate.d/openmpi.sh
#!/bin/sh
unset CPATH
export CPATH=$CPATH_OLD
unset CPATH_OLD
EOF

# activate.d
cat <<EOF > $PREFIX/etc/conda/activate.d/openmpi.sh
#!/bin/sh
export CPATH_OLD=$CPATH
export CPATH=$CPATH:$PREFIX/include
EOF
