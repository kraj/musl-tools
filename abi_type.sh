#!/bin/sh

export LC_ALL=C

ALL='
aarch64
arm
i386
microblaze
mips
or1k
powerpc
sh
x32
x86_64
'
ARCH="${ARCH:-$ALL}"

# install headers to T.$arch
for arch in $ARCH
do

{
awk -F'\t' '$3 ~ /^[sutSUT]$/ {
	print $1
}' data/musl.generic.decls data/musl.$arch.decls
echo 'function_pointer
object_pointer
char
short
int
long
long_long
float
double
long_double
wchar_t
bool'
} |sort |uniq >/tmp/m.$arch.type

awk -F'\t' '{print $2}' data/musl.generic.decls |sort |uniq >/tmp/m.header

echo '
#define _GNU_SOURCE 1
#define _FILE_OFFSET_BITS 64
#define SYSLOG_NAMES 1
#include <stddef.h>
#include <sys/types.h>
' >abi_type.$arch.cc

awk '
/^sys\/(cachectl|fantotify|errno|fcntl|io|kd|poll|reg|signal|soundcard|termios|vt)\.h$/ { printf "//" }
/^(wait)\.h$/ { printf "//" }
{ w=0 }
/^(stdalign|stdnoreturn|threads)\.h$/ { w=1 }
{
	if(w) print "#ifndef __GLIBC__"
	print "#include <" $0 ">"
	if(w) print "#endif"
}' /tmp/m.header >>abi_type.$arch.cc

echo '
typedef long long long_long;
typedef long double long_double;
typedef void *object_pointer;
typedef void (*function_pointer)();
struct size {char c;};
struct align {char c;};
struct incomplete {char c;};
#define T(s,t) void x_##t(s t x, s t* ptr, size(*y)[sizeof(s t)], align(*z)[__alignof__(s t)]){}
#define P(s,t) void x_##t(incomplete x, s t* ptr, incomplete y, incomplete z){}
#ifdef __GLIBC__
#define M(x)
#else
#define M(x) x
#endif
' >>abi_type.$arch.cc

awk '
/^(struct|union) __(CODE|ptcb|siginfo|ucontext|sigjmp_buf|double_repr|float_repr|sigset_t|mbstate_t|fsid_t|locale_struct)$/ ||
/^(elf_fpxregset_t|struct user_fpxregs_struct|Sg_io_vec|struct ih_.*|struct ip6_hdrctl|tcp_seq|union _G_fpos64_t|struct cpu_set_t|__isoc_va_list|ns_tcp_tsig.*|ns_tsig_.*|struct ptrace_peeksiginfo_.*)$/ { printf "//" }
{ if (!sub(/ /,",")) sub(/^/,",") }
/,(once_flag|mtx_t|cnd_t|thrd_start_t|thrd_t|tss_dtor_t|tss_t)$/ { print "M(T(" $0 "))"; next}
/,(DIR|FILE)$/ { print "P(" $0 ")"; next }
{ print "T(" $0 ")" }' /tmp/m.$arch.type >>abi_type.$arch.cc
done

#$CXX -S -o - abi_type.cc |sed -n 's/^\(_Z.*\):/\1/p' |$CXXFILT |sed '
#s/^x_\([^(]*\)(\(.*\))/\1: \2/
#s/floatcomplex /float _Complex/g
#s/doublecomplex /double _Complex/g
#' >data/musl.abi_type
