#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

( cd $MUSL; git log -n1 ) | awk '
BEGIN {
	getline
	hash = $2
	getline

	commit = "<h4>commit</h4><p>commit <a href=\"http://git.musl-libc.org/cgit/musl/commit/?id=" hash "\">" hash "</a>"
	while (getline == 1)
		commit = commit "<br>" $0

	FS = "\t"

	posix = "data/posix2008.ok"
	syms = "data/musl.syms"
	tags = "data/musl.tags"

	while (getline < syms == 1)
		sym[$2] = $1
	while (getline < tags == 1) {
		if ($2 ~ /bits\//)
			s = $3 " "
		else
			s = "<a href=\"http://git.musl-libc.org/cgit/musl/tree/include/" $2 "#n" $4 "\">" $3 "</a> "
		kind[$1] = kind[$1] $3
		kindstr[$1] = kindstr[$1] s
	}

	legend = "<h4>legend</h4><ul><li>status: musl implementation status summary<ul>"
	legend = legend "<li>(empty) - implemented"
	legend = legend "<li>nosym - prototype found in include files (see decl) but not in libc.a (see sym)"
	legend = legend "<li>nodecl - symbol is in libc.a but not declared in a public header"
	legend = legend "<li>missing - neither in include files (see decl) nor in libc.a (see sym)"
	legend = legend "</ul><li>sym: external symbol kind as found by `nm libc.a` (symbol kind only reported once)<ul>"
	legend = legend "<li>C - symbol is common (uninitialized data)"
	legend = legend "<li>D - symbol is in the initialized data section"
	legend = legend "<li>R - symbol is in the read only data section"
	legend = legend "<li>T - symbol is in the text section"
	legend = legend "<li>V - weak object"
	legend = legend "<li>W - weak symbol"
	legend = legend "</ul><li>decl: kind of declaration as found by `ctags -R include` (every occurance is reported)<ul>"
	legend = legend "<li>d - macro definition"
	legend = legend "<li>p - function prototype"
	legend = legend "<li>x - external and forward variable declaration"
	legend = legend "</ul></ul>"
	legend = legend "<p>(STREAMS and posix_trace* apis are excluded)"

	print "<h3>musl vs posix api</h3>"
	print commit
	print legend
	print "<h4>table</h4><table border=1><tr><th colspan=3>musl<th colspan=4>posix<tr><th>status<th>sym<th>decl<th>name<th>header<th>option<th>desc"
	nodecl = nosym = missing = 0
	while (getline < posix == 1) {
		s = "<tr><td>"
		if (sym[$1] && kind[$1]) {
			s = s "&#160;"
		} else if (sym[$1]) {
			s = s "nodecl"
			nodecl++
		} else if (kind[$1] ~ /d/) {
			s = s "&#160;"
		} else if (kind[$1]) {
			s = s "nosym"
			nosym++
		} else {
			s = s "missing"
			missing++
		}
		s = s "<td>" sym[$1]
		if (!sym[$1])
			s = s "&#160;"
		s = s "<td>" kindstr[$1]
		if (!kind[$1])
			s = s "&#160;"

		s = s "<td><a href=\"http://pubs.opengroup.org/onlinepubs/9699919799/functions/" $1 ".html\">" $1 "</a>"
		n = split($2, x, " ")
		s = s "<td>"
		for (i = 1; i <= n; i++) {
			h = x[i]
			gsub(/\//, "_", h)
			s = s " <a href=\"http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/" h ".html\">" x[i] "</a>"
		}
		n = split($3, x, " ")
		s = s "<td>"
		for (i = 1; i <= n; i++)
			s = s " <a href=\"http://pubs.opengroup.org/onlinepubs/9699919799/help/codes.html#" x[i] "\">" x[i] "</a>"
		if (n==0)
			s = s "&#160;"
		s = s "<td>" $4
		print s
	}
	print "</table>"
	print "<h4>stats</h4><ul><li>missing: " missing "<li>nosym: " nosym "<li>nodecl: " nodecl "</ul>"
}' >tab_posix.html
