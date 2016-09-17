#! /bin/bash
# Copyright 2016 Peter Williams and collaborators.
# This file is licensed under a 3-clause BSD license; see LICENSE.txt.

[ "$NJOBS" = '<UNDEFINED>' -o -z "$NJOBS" ] && NJOBS=$(nproc)
set -e
# don't get locally installed pkg-config entries:
export PKG_CONFIG_LIBDIR="$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig"

mkdir -p $PREFIX/lib64
ln -s $PREFIX/lib/libffi.la $PREFIX/lib64/libffi.la
configure_args=(
    --prefix=$PREFIX
    --with-tiff-includes=$PREFIX/include
    --with-tiff-libraries=$PREFIX/lib
)

if [ -n "$OSX_ARCH" ] ; then
    # rpath setting is often needed to run compiled autoconf test programs:
    export MACOSX_DEPLOYMENT_TARGET=10.6
    sdk=/
    export CFLAGS="$CFLAGS -isysroot $sdk"
    export LDFLAGS="$LDFLAGS -Wl,-syslibroot,$sdk -Wl,-rpath,$PREFIX/lib"
 # Needed to work around busted libxml2.la file in v. 2.9.2-0:
    rm -f $PREFIX/lib/*.la

fi

./configure "${configure_args[@]}" #|| { cat config.log ; exit 1 ; }
make -j$NJOBS
make install

