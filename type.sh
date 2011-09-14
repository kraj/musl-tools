#!/bin/sh

export LC_ALL=C

# drop names from a declaration (hack to make prototypes comparable)
awk '
BEGIN {
	# type is not typedefed so next unknown id is probably a variable name
	split("void char short int long float double signed unsigned _Bool _Complex", a)
	for (i in a)
		tok[a[i]] = "type"

	# next token is an id, type is not typedefed
	split("struct union enum", a)
	for (i in a)
		tok[a[i]] = "struct"

	# decoratoin that can be skipped
	split("static extern auto register inline const volatile restrict", a)
	for (i in a)
		tok[a[i]] = "decor"

	# punctuators
	split("( ) [ ] , ... *", a)
	for (i in a)
		tok[a[i]] = "punct"
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
	gsub(/\/\*[^/]*\*\//, "")
	gsub(/\/\/.*/, "")

	gsub(/[^a-zA-Z0-9_.]/," & ")
	gsub(/\.\.\./, " & ")

	state = "type"
	sep = ""
	s = ""
	for (i = 1; i <= NF; i++) {
		if ($i == ";")
			break
		if (state == "type") {
			put($i)
			if (!tok[$i] || tok[$i] == "type")
				state = "id"
			if (tok[$i] == "struct") {
				i++
				put($i)
				state = "id"
			}
		} else if (state == "id") {
			if (!tok[$i]) {
				state = "idfound"
				continue
			}
			put($i)
			if ($i == ")")
				state = "idfound"
			if ($i == ",")
				state = "type"
		} else if (state == "idfound") {
			put($i)
			if ($i == "(" || $i == ",")
				state = "type"
		}
	}
	print s
}
'
