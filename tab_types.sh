#!/bin/sh

export LC_ALL=C

awk -F'\t' '
($3=="t"||$3=="s") && ($2~/^include/ || $2~/^arch.*bits/) && $1!~/^__/ && $1!~/ __/ {
	print $1
}' data/musl.inc.tags |sort -u |awk '
function gfmt(s) {
	if (s ~ /^ *$/)
		return ""
	s0 = s
	sub(/:/, "#l", s)
	return "<a href=\"http://sourceware.org/git/?p=glibc.git;a=blob;f=" s "\">" s0 "</a><br>"
}
function mfmt(s) {
	if (s ~ /^ *$/)
		return ""
	s0 = s
	sub(/:/, "#n", s)
	return "<a href=\"http://git.musl-libc.org/cgit/musl/tree/" s "\">" s0 "</a><br>"
}
function ga(s) {
	n = split(s, a, / /)
	r = ""
	for (i = 1; i <= n; i++)
		r = r " " gfmt(a[i])
	return r
}
function ma(s) {
	n = split(s, a, / /)
	r = ""
	for (i = 1; i <= n; i++)
		r = r " " mfmt(a[i])
	return r
}
function pinc(s) {
	n = split(s, a, / /)
	for (i = 1; i <= n; i++) {
		sub(/:.*/,"",a[i])
		sub(/include\//,"",a[i])
		sub(/arch.*bits\//,"",a[i])
		h0 = a[i]
		if (a[i] in pmap) {
			gsub(/\//,"_",a[i])
			return "<a href=\"http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/" a[i] ".html\">" h0 "</a>"
		}
	}
	return ""
}
BEGIN {
	FS = "\t"

	posix = "data/posix.inc"
	g = "data/glibc.inc.tags"
	m = "data/musl.inc.tags"

	while (getline < posix == 1)
		pmap[$1] = 1
	while (getline < g == 1)
#		if ($3=="t" || $3=="s")
			gmap[$1] = gmap[$1] " " $2 ":" $4
	while (getline < m == 1)
		if (($3=="t" || $3=="s") && $2 !~ /^src\//)
			mmap[$1] = mmap[$1] " " $2 ":" $4

	print "<h3>types</h3>"
	print "<h4>table</h4><table border=1><tr><th>name<th>posix<th>musl<th>glibc"
	

	while (getline == 1) {
		print "<tr><td>" $1 "<td>" pinc(mmap[$1]) "<td>" ma(mmap[$1]) "<td>" ga(gmap[$1])
#		s = s "<td><a href=\"http://pubs.opengroup.org/onlinepubs/9699919799/functions/" $1 ".html\">" $1 "</a>"
#			s = s " <a href=\"http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/" h ".html\">" x[i] "</a>"
	}
	print "</table>"
}' >tab_types.html
