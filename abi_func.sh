#!/bin/sh

export LC_ALL=C

awk -F'\t' '$3 ~ /^p$/ {
	print $1
}' data/musl.generic.decls |sort |uniq >/tmp/m.funcs

echo '
#define _GNU_SOURCE 1
#define _FILE_OFFSET_BITS 64
' >abi_func.cc

awk -F'\t' '$3 ~ /^p$/ {
	if ($2 ~ /^(sys\/(cachectl|io)|threads)\.h$/) next
	print "#include <" $2 ">"
}' data/musl.generic.decls |sort |uniq >>abi_func.cc

echo '
#define T(x) void t_##x(__typeof(x)*p){}
#ifdef __GLIBC__
#define M(x)
#undef sigsetjmp
#define sigsetjmp __sigsetjmp
#else
#define M(x) x
#endif
' >>abi_func.cc

awk '
/^(_flush_cache|cachectl|cacheflush|iopl|ioperm|call_once|cnd_broadcast|cnd_destroy|cnd_init|cnd_signal|cnd_timedwait|cnd_wait|mtx_destroy|mtx_init|mtx_lock|mtx_timedlock|mtx_trylock|mtx_unlock|thrd_create|thrd_current|thrd_detach|thrd_equal|thrd_exit|thrd_join|thrd_sleep|thrd_yield|tss_create|tss_delete|tss_get|tss_set)$/ {
	print "// "$0; next
}
#/^(__flt_rounds|__freadahead|__freadptr|__freadptrinc|__fseterr|_pthread_cleanup_pop|_pthread_cleanup_push|gets|issetugid|posix_close|strlcat|strlcpy)$/
/^(__flt_rounds|__freadahead|__freadptr|__freadptrinc|__fseterr|_pthread_cleanup_pop|_pthread_cleanup_push|fgetln|getdents|gets|index|issetugid|memchr|memrchr|posix_close|rindex|strcasestr|strchr|strchrnul|strlcat|strlcpy|strpbrk|strrchr|strstr|wcschr|wcspbrk|wcsrchr|wcsstr|wcswcs|wmemchr)$/ {
	print "M(T(" $0 "))"; next
}
/^(ElfW)$/ { printf "// " }
{ print "T(" $0 ")" }' /tmp/m.funcs >>abi_func.cc
