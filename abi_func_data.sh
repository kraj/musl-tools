#!/bin/sh

CXXFILT=${CXXFILT:-c++filt}

$CXX -std=c++11 -nostdinc++ -S -o - abi_func.cc |sed -n 's/^\(_Z.*\):/\1/p' |$CXXFILT |sed '
s/(\*)/@/;s/^t_\([^(]*\)(\(.*\)@\(.*\))/\2\1\3/
s/floatcomplex /float _Complex/g
s/doublecomplex /double _Complex/g
'
