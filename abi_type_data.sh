#!/bin/sh

CXXFILT=${CXXFILT:-c++filt}

$CXX -S -o - abi.cc |sed -n 's/^\(_Z.*\):/\1/p' |$CXXFILT |sed '
s/^x_\([^(]*\)(\(.*\))/\1: \2/
s/^y_\([^(]*\)(\(.*\))/\1*: \2/
s/floatcomplex /float _Complex/g
s/doublecomplex /double _Complex/g
'
