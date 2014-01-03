#!/bin/sh

export LC_ALL=C

# drop names from a declaration (hack to make prototypes comparable)
awk '
BEGIN {
	# builtin type specifiers/qualifiers..
	s = "void char short int long float double signed unsigned _Bool _Complex bool complex"
	s = s " static extern auto register inline const volatile restrict __restrict"
	# typedef names in posix without _t
	s = s " FILE DIR VISIT ENTRY ACTION DBM datum fd_set jmp_buf sigjmp_buf va_list __isoc_va_list nl_item nl_catd"
	s = s " scalar real-floating" # used in macros
	split(s, a)
	for (i in a)
		tok[a[i]] = "builtin"

	# next token is an id
	split("struct union enum", a)
	for (i in a)
		tok[a[i]] = "struct"
}

function put(tok) {
	if (tok ~ /^[a-zA-Z_]/) {
		s = s sep tok
		sep = " "
	} else {
		s = s tok
		sep = ""
	}
}

{
	# eat comments
	gsub(/\/\*[^\/]*\*\//, "")
	gsub(/\/\/.*/, "")

	gsub(/[^a-zA-Z0-9_.-]/," & ")
	gsub(/\.\.\./, " & ")

	sep = ""
	s = ""
	for (i = 1; i <= NF; i++) {
		if ($i == ";")
			break
		if ($i ~ /[a-zA-Z_][a-zA-Z0-9_]*/ && !tok[$i] && $i !~ /_t$/)
			continue
		put($i)
		if (tok[$i] == "struct") {
			i++
			put($i)
		}
	}

	# fixes
	gsub(/\[[0-9]+\]/, "[]", s)
	gsub(/unsigned int/, "unsigned", s)
	gsub(/long int/, "long", s)
	gsub(/__restrict/, "restrict", s)
	gsub(/__isoc_va_list/, "va_list", s)

	print s
}
'
