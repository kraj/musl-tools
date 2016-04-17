#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

awk -F'\t' '$3 ~ /^[sut]$/ {
	print $1
}' data/musl.tags >/tmp/m.type
echo 'char' >>/tmp/m.type
echo 'short' >>/tmp/m.type
echo 'int' >>/tmp/m.type
echo 'long' >>/tmp/m.type
echo 'long_long' >>/tmp/m.type
echo 'float' >>/tmp/m.type
echo 'double' >>/tmp/m.type
echo 'long_double' >>/tmp/m.type
echo 'wchar_t' >>/tmp/m.type
echo 'bool' >>/tmp/m.type
echo 'void' >>/tmp/m.type

(
	cd $MUSL/include
	find . -name '*.h' | sed 's,^\./,,' >/tmp/m.header
)

echo '#define _GNU_SOURCE 1' >abi_type.cc
echo '#define _FILE_OFFSET_BITS 64' >>abi_type.cc
echo '#define SYSLOG_NAMES 1' >>abi_type.cc
echo '#include <stddef.h>' >>abi_type.cc
echo '#include <sys/types.h>' >>abi_type.cc
echo '' >>abi_type.cc

sort /tmp/m.header |uniq |awk '
	/^sys\/(auxv|cachectl|fantotify|errno|fcntl|kd|poll|signal|soundcard|termios|vt)\.h$/ { printf "//" }
	/^(bits\/.*|stdalign|stdnoreturn|threads|wait)\.h$/ { printf "//" }
	{ print "#include <" $0 ">" }' >>abi_type.cc
echo 'typedef long long long_long; typedef long double long_double;' >>abi_type.cc
echo 'struct size{int i;}; struct align{int i;};' >>abi_type.cc
echo '#define p(s,t) void x_##t(s t x, s t* ptr, size(*y)[sizeof(s t)], align(*z)[__alignof__(s t)]){}' >>abi_type.cc
echo '#define pp(s,t) void y_##t(s t* ptr, size(*y)[sizeof(s t*)], align(*z)[__alignof__(s t*)]){}' >>abi_type.cc
echo '
#ifdef __GLIBC__
#define M(x)
#else
#define M(x) x
#endif
' >>abi_type.cc

sort /tmp/m.type |uniq |awk '
	/^(once_flag|mtx_t|cnd_t|thrd_start_t|thrd_t|tss_dtor_t|tss_t)$/ ||
	/^(struct|union) __(CODE|ptcb|siginfo|ucontext|sigjmp_buf|double_repr|float_repr|sigset_t|mbstate_t|fsid_t)$/ ||
	/^(elf_fpxregset_t|struct user_fpxregs_struct|Sg_io_vec|struct ih_.*|struct ip6_hdrctl|tcp_seq|union _G_fpos64_t|struct cpu_set_t|__isoc_va_list|ns_tcp_tsig.*|ns_tsig_.*|struct ptrace_peeksiginfo_.*)$/ { printf "//" }
	{ if (!sub(/ /,",")) sub(/^/,",") }
	/,(DIR|FILE|void)$/ { print "pp(" $0 ")"; next }
	{ print "p(" $0 ")" }' >>abi_type.cc

#$CXX -S -o - abi_type.cc |sed -n 's/^\(_Z.*\):/\1/p' |$CXXFILT |sed '
#s/^x_\([^(]*\)(\(.*\))/\1: \2/
#s/^y_\([^(]*\)(\(.*\))/\1*: \2/
#s/floatcomplex /float _Complex/g
#s/doublecomplex /double _Complex/g
#' >data/musl.abi_type
