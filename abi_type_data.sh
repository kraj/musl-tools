#!/bin/sh

CXXFILT=${CXXFILT:-c++filt}
#TODO
ARCH=${ARCH:-x86_64}

$CXX -S -o - abi_type.$ARCH.cc |sed -n 's/^\(_Z.*\):/\1/p' |$CXXFILT |sed '
s/^x_\([^(]*\)(\(.*\))/\1: \2/
s/^y_\([^(]*\)(\(.*\))/\1*: \2/
s/floatcomplex /float _Complex/g
s/doublecomplex /double _Complex/g
'
