#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

nm -p -P $MUSL/lib/libc.a |awk '$2~/[A-Zvw]/{print $1,$2}' |sort |uniq |awk '
NR==1 {
	prev=$1
	t=$2
	next
}
{
	if (prev != $1) {
		print t "\t" prev
		prev=$1
		t=$2
	} else
		t = t $2
}
END {
	print t "\t" prev
}' >data/musl.syms.all

# without U
awk '$1!="U"{sub(/U/,"",$1); print $1 "\t" $2}' data/musl.syms.all >data/musl.syms
# only U
awk '$1=="U"{print $1 "\t" $2}' data/musl.syms.all >data/musl.syms.undef
# seen sym kinds
awk '{for(i=1; i<=length($1); i++) a[substr($1,i,1)]=1} END{for(i in a) print i}' data/musl.syms
