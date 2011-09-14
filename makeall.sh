#!/bin/sh

export LC_ALL=C

[ -f data/musl.tags.proto -a -f data/posix2008.ok.proto ] || ./makeproto.sh

{
	awk -F'\t' '{print $1}' data/musl.tags data/posix2008.ok # data/c99
	awk -F'\t' '{print $2}' data/musl.syms
} |sort |uniq |awk -F'\t' '
BEGIN {
	posix = "data/posix2008.ok.proto"
	syms = "data/musl.syms"
	tags = "data/musl.tags.proto"

	while (getline < syms == 1)
		sym[$2] = $1
	while (getline < tags == 1)
		tag[$1] = $2 "\t" $3 "\t" $5 "\t" $6
	while (getline < posix == 1)
		pos[$1] = $2 "\t" $5 "\t" $6
}
{
	s = ""
	if (sym[$1])
		s = s " obj"
	if (tag[$1])
		s = s " inc"
	if (pos[$1])
		s = s " posix"

	print $1 "\t" substr(s,2) "\t" sym[$1] "\t" tag[$1] "\t" pos[$1]
}' >data/musl.all

awk -F'\t' '
$2 == "obj" || $2 == "obj posix" {
	# not declared
	if ($1 !~ /^_/)
		print "nodecl\t" $1 "\t" $3
}
$2 ~ /inc posix/ && $4 != $8 {
	# different header

	n = split($8, a, " ")
	for (i = 1; i <= n; i++)
		if ($4 == a[i])
			break
	if (i > n)
		print "header\t" $1 "\t" $4 "\t" $8
}
$2 ~ /inc posix/ && $7 != $10 && $5 == "p" {
	# different prototype

	# todo: move to type.sh
	gsub(/restrict const/, "const", $10)
	gsub(/restrict/, "", $10)
	gsub(/\[[0-9]+\]/, "[]", $10)
	gsub(/unsigned int/, "unsigned", $7)
	gsub(/long int/, "long", $7)

	if ($7 != $10)
		print "proto\t" $1 "\t" $4 "\t" $7 "\t" $10 "\t" $6 "\t" $9
}
' data/musl.all >data/musl.problems

