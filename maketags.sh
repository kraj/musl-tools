#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

(
	cd $MUSL/include
	ctags -f /tmp/musl.tags -R -n -u --language-force=c --c-kinds=pxdstuv --fields=k --exclude='*.sh' .

	# fix wchar_t bug of ctags
	awk '/typedef.* wchar_t/{print "wchar_t\tbits/alltypes.h\t" NR ";\"\tt"}' bits/alltypes.h >>/tmp/musl.tags
)

awk -v inc=$MUSL/include/ '
BEGIN {
	FS="\t"
}
function proto(t,h,n) {
	cmd = "awk '\''NR==" n
	if (t == "p")
		cmd = cmd "{s=$0; if(s!~/;/){getline; s=s \" \" $0} print s; exit}"
	else if (t == "d")
		cmd = cmd "{s=$0; while(gsub(/\\\\$/,\"\",s)){getline; s=s $0} print s; exit}"
	else
		return ""
	cmd = cmd "'\'' " inc h
	cmd | getline s
	close(cmd)
	gsub(/\t/, " ", s)
	gsub(/ +/, " ", s)
	gsub(/ \(/, "(", s)
	return s
}
/^[^!]/ {
	gsub(/[^0-9]*/,"",$3)
	if ($4 == "s")
		$1 = "struct " $1
	if ($4 == "u")
		$1 = "union " $1
	print $1 "\t" $2 "\t" $4 "\t" $3 "\t" proto($4,$2,$3)
}' /tmp/musl.tags |sort >data/musl.tags
rm -f /tmp/musl.tags
