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

	c11 = "data/c11"
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
	legend = legend "</ul><li>decl: kind of declaration as found by `ctags -R include` (every occurance is reported, arch specific definitions are not linked)<ul>"
	legend = legend "<li>d - macro definition"
	legend = legend "<li>t - typedef"
	legend = legend "<li>s - struct declaration"
	legend = legend "<li>u - union declaration"
	legend = legend "<li>p - function prototype"
	legend = legend "<li>x - external and forward variable declaration"
	legend = legend "</ul></ul>"
	legend = legend "<p>(Annex K apis are excluded: -D__STDC_WANT_LIB_EXT1__=0 is assumed)"

	print "<h3>musl vs c11 api</h3>"
	print commit
	print legend
	print "<h4>table</h4><table border=1><tr><th colspan=3>musl<th colspan=4>c11<tr><th>status<th>sym<th>decl<th>name<th>header<th>proto<th>section"
	nodecl = nosym = missing = 0
	while (getline < c11 == 1) {
		s = "<tr><td>"
		if (sym[$1] && kind[$1]) {
			s = s "&#160;"
		} else if (sym[$1]) {
			s = s "nodecl"
			nodecl++
		} else if (kind[$1] ~ /[dtsue]/) {
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

		s = s "<td>" $1
		s = s "<td>" $3
		if ($2)
			s = s "<td>" $2
		else
			s = s "<td>&#160;"
		s = s "<td>" $4
		print s
	}
	print "</table>"
	print "<h4>stats</h4><ul><li>missing: " missing "<li>nosym: " nosym "<li>nodecl: " nodecl "</ul>"
}' >tab_c11.html
