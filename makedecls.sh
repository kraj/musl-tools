#!/bin/sh

set -eu

export LC_ALL=C

# musl repo dir
MUSL="${MUSL:-../musl}"

ALL='
aarch64
arm
i386
microblaze
mips
mips64
mipsn32
or1k
powerpc
powerpc64
sh
x32
x86_64
'

ARCH="${ARCH:-$ALL}"

# install headers to /tmp/T.$arch
for arch in $ARCH
do
[ -e T.$arch ] && continue
make -f "$MUSL"/Makefile install-headers srcdir="$MUSL" prefix=/tmp/T.$arch ARCH=$arch
rm -rf obj/include/bits
done
rm -rf obj lib

# run ctags on headers
for arch in $ARCH
do
[ -e /tmp/T.$arch/musl.tags ] && continue
(
cd /tmp/T.$arch/include
ctags -f ../musl.tags -R -n -u --language-force=c --c-kinds=pxdstuve --fields=k .
# fix wchar_t bug of ctags (not ok for c++)
awk '/typedef.* wchar_t/{print "wchar_t\tbits/alltypes.h\t" NR ";\"\tt"}' bits/alltypes.h >>../musl.tags
)
done

# add declarations (slow)
for arch in $ARCH
do
[ -e /tmp/T.$arch/musl.decls ] && continue
(
cd /tmp/T.$arch/include
awk '
BEGIN { FS="\t" }

function decl(t,h,n) {
	cmd = "awk '\''NR==" n
	if (t ~ /[pxt]/)
		cmd = cmd "{s=$0; if(s!~/;/){getline; s=s \" \" $0} print s; exit}"
	else if (t == "d")
		cmd = cmd "{s=$0; while(gsub(/\\\\$/,\"\",s)){getline; s=s $0} print s; exit}"
	else
		return ""
	cmd = cmd "'\'' " h
	cmd | getline s
	close(cmd)
	gsub(/\t/, " ", s)
	gsub(/ +/, " ", s)
	if (t == "p")
		gsub(/ \(/, "(", s)
	return s
}
/^[^!]/ {
	gsub(/[^0-9]*/,"",$3)
	if ($4 == "s")
		$1 = "struct " $1
	if ($4 == "u")
		$1 = "union " $1
#	print $1 "\t" $2 "\t" $4 "\t" $3 "\t" decl($4,$2,$3)
	# without line number
	print $1 "\t" $2 "\t" $4 "\t" decl($4,$2,$3)
}' ../musl.tags >../musl.decls.raw

# fix ups
awk '
BEGIN { FS="\t" }
$3=="d" && $4 ~ /^#undef/ {next}
$3=="x" && $4 ~ /^(struct|union) [_0-9a-zA-Z]*;$/ {
	a = ($4 ~ /^struct/) ? "struct " : "union "
	b = ($4 ~ /^struct/) ? "S" : "U"
	print a $1 "\t" $2 "\t" b "\t" $4
	next
}
$1~/^(FILE|DIR)$/ {
	print $1 "\t" $2 "\tT\t" $4
	next
}
{ print $0 }' ../musl.decls.raw | sort >../musl.decls
)
done

# add decls to data/
for arch in $ARCH
do
grep '	bits/' /tmp/T.$arch/musl.decls >data/musl.$arch.decls
done
for arch in $ARCH
do
grep -v '	bits/' /tmp/T.$arch/musl.decls >data/musl.generic.decls
break
done
