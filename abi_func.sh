#!/bin/sh

export LC_ALL=C

awk -F'\t' '$3 ~ /^p$/ {
	print $1
}' data/musl.generic.decls |sort |uniq >/tmp/m.funcs

echo '
#define _GNU_SOURCE 1
#define _FILE_OFFSET_BITS 64
' >abi_func.cc

awk -F'\t' '$3 ~ /^p$/ {print $2}' data/musl.generic.decls |sort |uniq |awk '
/^sys\/io\.h$/ {print "// #include <"$0">"; next}
{
	w = $0 ~ /^(sys\/cachectl|threads)\.h$/
	if(w) print "#ifndef __GLIBC__"
	print "#include <" $0 ">"
	if(w) print "#endif"
}' >>abi_func.cc

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
# non-portable or ctags mistake
/^(iopl|ioperm|ElfW)$/ {
	print "// "$0; next
}
# polymorphic in glibc
/^(index|memchr|memrchr|rindex|strcasestr|strchr|strchrnul|strlcat|strlcpy|strpbrk|strrchr|strstr|wcschr|wcspbrk|wcsrchr|wcsstr|wcswcs|wmemchr)$/ ||
# musl only
/^(__flt_rounds|__freadahead|__freadptr|__freadptrinc|__fseterr|_pthread_cleanup_pop|_pthread_cleanup_push|fgetln|getdents|gets|issetugid|posix_close)$/ ||
/^(_flush_cache|cachectl|cacheflush)$/ ||
/^(call_once|cnd_broadcast|cnd_destroy|cnd_init|cnd_signal|cnd_timedwait|cnd_wait|mtx_destroy|mtx_init|mtx_lock|mtx_timedlock|mtx_trylock|mtx_unlock|thrd_create|thrd_current|thrd_detach|thrd_equal|thrd_exit|thrd_join|thrd_sleep|thrd_yield|tss_create|tss_delete|tss_get|tss_set)$/ {
	print "M(T(" $0 "))"; next
}
{ print "T(" $0 ")" }' /tmp/m.funcs >>abi_func.cc
