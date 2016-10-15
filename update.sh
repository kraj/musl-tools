#!/bin/sh

export LC_ALL=C

[ -e /tmp/Mrepo ] && echo 'using existing Mrepo' || git clone ${MUSL:-../musl} /tmp/Mrepo
export MUSL=/tmp/Mrepo

[ -e /tmp/Mprefix ] && echo 'using existing Mprefix' || (
mkdir -p /tmp/Mbuild
cd /tmp/Mbuild
/tmp/Mrepo/configure --prefix=/tmp/Mprefix --syslibdir=/tmp/Mprefix/lib --disable-wrapper 
make -j install
)
export MUSL_PREFIX=/tmp/Mprefix

. ./makesyms.sh
. ./maketags.sh
. ./maketagssrc.sh
. ./makedecls.sh
. ./abi_type.sh
. ./abi_func.sh

. ./tab_c99.sh
. ./tab_c11.sh
. ./tab_posix.sh
. ./findproblems.sh
