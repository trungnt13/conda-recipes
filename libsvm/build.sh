#!/bin/bash

if [[ `uname` == 'Darwin' ]]; then
	sed -i '' 's/-soname/-install_name/g' Makefile
	sed -i '' 's/libsvm.so.$(SHVER)/libsvm.$(SHVER).dylib/g' Makefile
fi
make all
make lib
# there is no make check or something similar and no make install

mkdir -p $PREFIX/share/licenses/libsvm $PREFIX/lib $PREFIX/include $PREFIX/bin
install -m644 svm.h $PREFIX/include/svm.h
install -m644 COPYRIGHT $PREFIX/share/licenses/libsvm/LICENSE
install -m755 svm-train $PREFIX/bin/
install -m755 svm-scale $PREFIX/bin/
install -m755 svm-predict $PREFIX/bin/
if [[ `uname` == 'Darwin' ]]; then
	install -m644 libsvm.2.dylib $PREFIX/lib/
	ln -s libsvm.2.dylib $PREFIX/lib/libsvm.dylib
else
	install -m644 libsvm.so.2 $PREFIX/lib/
	ln -s libsvm.so.2 $PREFIX/lib/libsvm.so
fi
