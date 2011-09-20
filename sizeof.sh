#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

awk -F'\t' '$3 ~ /^[sut]$/ {
	print $1
}' data/musl.tags >/tmp/m.type
echo 'wchar_t' >>/tmp/m.type

(
	cd $MUSL/include
	find . -name '*.h' | sed 's,^\./,,' >/tmp/m.header
)

echo '#define _GNU_SOURCE 1' >sizeof.c
echo '#define _LARGEFILE64_SOURCE 1' >>sizeof.c
echo '#define _FILE_OFFSET_BITS 64' >>sizeof.c
echo '#include <stddef.h>' >>sizeof.c
echo '#include <sys/types.h>' >>sizeof.c
echo '' >>sizeof.c

sort /tmp/m.header |uniq |awk '
	/^features\.h$/ { printf "//" }
	{ print "#include <" $0 ">" }' >>sizeof.c
echo '#define p(x) printf("%s\\t%u\\n", #x, sizeof(x));' >>sizeof.c
echo 'int main(){' >>sizeof.c
sed 's/.*/p(&)/' /tmp/m.type |awk '
	/p\(CODE\)/ ||
	/p\(DIR\)/ ||
	/p\(FILE\)/ ||
	/p\(struct __CODE\)/ ||
	/p\(struct __fpstate\)/ ||
	/p\(struct __ptcb\)/ ||
	/p\(struct __siginfo\)/ ||
	/p\(struct __ucontext\)/ ||
	/p\(struct in6_mutinfo\)/ ||
	/p\(struct npttimeval\)/ { printf "//" }
	{ print }' >>sizeof.c
echo 'return 0;}' >>sizeof.c

