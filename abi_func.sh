#!/bin/sh

#set -xeu

export LC_ALL=C
#MUSL=${MUSL:-../musl}

awk -F'\t' '$3 ~ /^p$/ {
	print $1
}' data/musl.tags >/tmp/m.funcs
awk -F'\t' '$3 ~ /^p$/ {
	print $2
}' data/musl.tags >/tmp/m.header

echo '#define _GNU_SOURCE 1' >abi_func.cc
echo '#define _FILE_OFFSET_BITS 64' >>abi_func.cc
echo '#define SYSLOG_NAMES 1' >>abi_func.cc
#echo '#include <stddef.h>' >>abi_func.cc
#echo '#include <sys/types.h>' >>abi_func.cc
echo '' >>abi_func.cc

sort /tmp/m.header |uniq |awk '
#	/^sys\/(auxv|cachectl|fantotify|errno|fcntl|poll|signal|soundcard|termios)\.h$/ { printf "//" }
#	/^(stdalign|stdnoreturn|threads|wait)\.h$/ { printf "//" }
#	/^sys\/(cachectl)\.h$/ { printf "//" }
#	/^(threads)\.h$/ { printf "//" }
	{ print "#include <" $0 ">" }' >>abi_func.cc
#echo 'typedef long long long_long; typedef long double long_double;' >>abi.cc
#echo 'struct size{int i;}; struct align{int i;};' >>abi.cc
#echo '#define p(s,t) void x_##t(s t x, s t* ptr, size(*y)[sizeof(s t)], align(*z)[__alignof__(s t)]){}' >>abi.cc
#echo '#define pp(s,t) void x_##t(s t* ptr, size(*y)[sizeof(s t*)], align(*z)[__alignof__(s t*)]){}' >>abi.cc

echo '#define T(x) void t_##x(__typeof(x)*p){}' >>abi_func.cc
echo '
#ifdef __GLIBC__
#define M(x)
#undef sigsetjmp
#define sigsetjmp __sigsetjmp
#else
#define M(x) x
#endif
' >>abi_func.cc

sort /tmp/m.funcs |uniq |awk '
	/^(__flt_rounds|__freadahead|__freadptr|__freadptrinc|__fseterr|_flush_cache|_pthread_cleanup_pop|_pthread_cleanup_push|cachectl|cacheflush|call_once|cnd_broadcast|cnd_destroy|cnd_init|cnd_signal|cnd_timedwait|cnd_wait|fgetln|getdents|gets|index|issetugid|memchr|memrchr|mtx_destroy|mtx_init|mtx_lock|mtx_timedlock|mtx_trylock|mtx_unlock|posix_close|rindex|strcasestr|strchr|strchrnul|strlcat|strlcpy|strpbrk|strrchr|strstr|thrd_create|thrd_current|thrd_detach|thrd_equal|thrd_exit|thrd_join|thrd_sleep|thrd_yield|tss_create|tss_delete|tss_get|tss_set|wcschr|wcspbrk|wcsrchr|wcsstr|wcswcs|wmemchr)$/ {
		print "M(T(" $0 "))"; next
	}
	/^(ElfW)$/ { printf "// " }
	{ print "T(" $0 ")" }' >>abi_func.cc

#$CXX -S -o - abi_func.cc |sed -n 's/^\(_Z.*\):/\1/p' |$CXXFILT |sed '
#s/(\*)/@/;s/^t_\([^(]*\)(\(.*\)@\(.*\))/\2\1\3/
#s/floatcomplex /float _Complex/g
#s/doublecomplex /double _Complex/g
#' >data/musl.abi_func
