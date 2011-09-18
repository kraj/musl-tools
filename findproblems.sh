#!/bin/sh

export LC_ALL=C

./makeproto.sh
{
	awk -F'\t' '{print $1}' data/musl.tags data/posix2008.ok # data/c99
	awk -F'\t' '{print $2}' data/musl.syms
} |sort |uniq |awk -F'\t' '
BEGIN {
	syms = "data/musl.syms"
	tags = "data/musl.tags.proto"
	srctags = "data/musl.src.tags.proto"
	posix = "data/posix2008.ok.proto"

	while (getline < syms == 1)
		sym[$2] = $1

	while (getline < tags == 1) {
		if ($5 ~ /^#undef/)
			continue
		if ($1 in tag)
			tag[$1] = tag[$1] "@" $2 "\t" $3 "\t" $5 "\t" $6
		else
			tag[$1] = $2 "\t" $3 "\t" $5 "\t" $6
	}

	while (getline < srctags == 1) {
		if ($3 != "f")
			continue
		if ($1 in stag)
			stag[$1] = stag[$1] "@" $2 "\t" $3 "\t" $5 "\t" $6
		else
			stag[$1] = $2 "\t" $3 "\t" $5 "\t" $6
	}

	while (getline < posix == 1)
		pos[$1] = $2 "\t" $5 "\t" $6
}
{
	s = ""
	if (sym[$1])
		s = s " obj"
	if (tag[$1])
		s = s " inc"
	else
		tag[$1] = "\t\t\t"
	if (pos[$1])
		s = s " posix"
	else
		pos[$1] = "\t\t"

	n = split(tag[$1],a,"@")
	for (i = 1; i <= n; i++)
		print $1 "\t" substr(s,2) "\t" sym[$1] "\t" a[i] "\t" pos[$1]
	n = split(stag[$1],a,"@")
	for (i = 1; i <= n; i++)
		print $1 "\t" substr(s,2) "\t" sym[$1] "\t" a[i] "\t" pos[$1]
}' >data/musl.all

awk -F'\t' '
BEGIN {
}

herr && lastid != $1 {
	print herr
	herr = ""
}
$2 == "obj" || $2 == "obj posix" {
	# not declared
	if ($1 !~ /^_/)
		print "nodecl\t" $1 "\t" $3
}
$5 == "p" {
	# check for different declarations of the same symbol
	if ($1 in proto) {
		if (proto[$1] != $6)
			print "proto\t" $1 "\t" $4 "\t" head[$1] "\t" $6 "\t" proto[$1]
	} else {
		proto[$1] = $6
		protoshort[$1] = $7
		head[$1] = $4
	}
}
$5 == "f" && $1 in protoshort {
	# func definition with different proto
	dec = protoshort[$1]
	def = $7
	gsub(/extern */, "", dec)
	gsub(/void/, "", dec)
	gsub(/void/, "", def)
	if (protoshort[$1] != $7 && dec != def)
		print "proto\t" $1 "\t" $4 "\t" head[$1] "\t" $7 "\t" protoshort[$1]
}
$2 ~ /inc posix/ && $4 == $8 {
	head[$1] = $4
	herr = ""
}
$2 ~ /inc posix/ && head[$1] != $8 && $4 !~ /^bits\// && $5 != "f" {
	# different header
	n = split($8, a, " ")
	for (i = 1; i <= n; i++)
		if ($4 == a[i])
			break
	if (i > n)
		# delay error msg
		herr = "header\t" $1 "\t" $4 "\t" $8
}
$2 ~ /inc posix/ && $7 != $10 && $5 == "p" {
	# different prototype
	print "proto\t" $1 "\t" $4 "\t" $7 "\t" $10 "\t" $6 "\t" $9
}
{
	lastid = $1
}
END{
	if(herr)
		print herr
}
' data/musl.all |uniq >data/musl.problems

