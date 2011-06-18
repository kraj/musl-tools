#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

(
	cd $MUSL/include
	ctags -f /tmp/musl.tags -R -n -u --language-force=c --c-kinds=pxdstuv --fields=k --exclude='*.sh' .
)

awk '
BEGIN {
	FS="\t"
}
/^[^!]/ {
	gsub(/[^0-9]*/,"",$3)
	if ($4 == "s")
		$1 = "struct " $1
	if ($4 == "u")
		$1 = "union " $1
	print $1 "\t" $2 "\t" $4 "\t" $3
}' /tmp/musl.tags |sort >data/musl.tags
rm -f /tmp/musl.tags
