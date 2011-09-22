#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

awk -F'\t' '$3 ~ /^[sut]$/ {
	print $1
}' data/musl.tags >/tmp/m.type
echo 'short' >>/tmp/m.type
echo 'int' >>/tmp/m.type
echo 'long' >>/tmp/m.type
echo 'long long' >>/tmp/m.type
echo 'float' >>/tmp/m.type
echo 'double' >>/tmp/m.type
echo 'long double' >>/tmp/m.type
echo 'wchar_t' >>/tmp/m.type
echo '_Bool' >>/tmp/m.type
echo 'void*' >>/tmp/m.type

(
	cd $MUSL/include
	find . -name '*.h' | sed 's,^\./,,' >/tmp/m.header
)

echo '#define _GNU_SOURCE 1' >sizeof.c
echo '#define _LARGEFILE64_SOURCE 1' >>sizeof.c
echo '#define _FILE_OFFSET_BITS 64' >>sizeof.c
echo '#define SYSLOG_NAMES 1' >>sizeof.c
echo '#include <stddef.h>' >>sizeof.c
echo '#include <sys/types.h>' >>sizeof.c
echo '' >>sizeof.c

sort /tmp/m.header |uniq |awk '
	/^features\.h$/ { printf "//" }
	{ print "#include <" $0 ">" }' >>sizeof.c
echo '#define p(x) printf("%s\\t%u\\n", #x, sizeof(x));' >>sizeof.c
echo 'int main(){' >>sizeof.c
sort /tmp/m.type |uniq |awk '
	/^struct __(CODE|fpstate|ptcb|siginfo|ucontext)$/ ||
	/^(DIR|FILE|elf_fpxregset_t)$/ { printf "//" }
	{ print "p(" $0 ")" }' >>sizeof.c
echo 'return 0;}' >>sizeof.c
