#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

(
	cd $MUSL/src
#	ctags -f /tmp/musl.tags -R -n -u --language-force=c --c-kinds=pxdstuf --fields=k --exclude='*.sh' --exclude='*o' --exclude='*.s' .
	ctags -f /tmp/musl.tags -R -n -u --language-force=c --c-kinds=xtf --fields=k --exclude='*.sh' --exclude='*o' --exclude='*.s' .
)

awk -v src=$MUSL/src/ '
BEGIN {
	FS="\t"
}
function proto(t,f,n) {
	if (t == "f" && n > 1)
		n--
	cmd = "awk '\''NR==" n
	if (t == "p")
		cmd = cmd "{s=$0; if(s!~/;/){getline; s=s \" \" $0} print s; exit}"
	else if (t == "f") {
		cmd = cmd "{s=$0; sub(/^#.*/,\"\",s); sub(/^}/,\"\",s); gsub(/\\/\\/.*/,\"\",s); gsub(/.*\\*\\//,\"\",s);"
		cmd = cmd "while(s!~/{/){getline; s=s \" \" $0} sub(/ *{.*$/,\"\",s); print s; exit}"
	} else if (t == "d")
		cmd = cmd "{s=$0; while(gsub(/\\\\$/,\"\",s)){getline; s=s $0} print s; exit}"
	else
		return ""
	cmd = cmd "'\'' " src f
	cmd | getline s
	close(cmd)
	gsub(/\t/, " ", s)
	gsub(/ +/, " ", s)
	sub(/^ /,"",s)
	return s
}
/^[^!]/ {
	gsub(/[^0-9]*/,"",$3)
	if ($4 == "s")
		$1 = "struct " $1
	if ($4 == "u")
		$1 = "union " $1
	p = proto($4,$2,$3)
	if ($4 != "f" || p !~ /static/)
		print $1 "\t" $2 "\t" $4 "\t" $3 "\t" p
}' /tmp/musl.tags |sort >data/musl.src.tags
rm -f /tmp/musl.tags
