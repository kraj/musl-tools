#!/bin/sh

export LC_ALL=C

D=data
M=../musl/lib
G=/lib

# list symbol info in tab separated format:
# name versioning type visibility addr size Ndx lib
syms() {
	readelf -W -d -s $1 |awk -v lib=$1 '
/^ *[0-9]*:/ && $5 != "LOCAL" && $7 !~ /UND|ABS/ {
	sub(/@/," @")
	ver = $9
	if ($10)
		ver = ver " " $10
	print $8 "\t" ver "\t" $4 "\t" $5 "\t" $2 "\t" $3 "\t" $7 "\t" lib
}' | sort |uniq
}

# all symbol info
syms $M/libc.so >$D/so_syms_musl
while read lib
do
	syms $G/$lib
done <<EOF | sort >$D/so_syms_glibc
libanl.so.1
libc.so.6
libcidn.so.1
libcrypt.so.1
libdl.so.2
libm.so.6
libnsl.so.1
libnss_compat.so.2
libnss_dns.so.2
libnss_files.so.2
libnss_hesiod.so.2
libnss_nis.so.2
libnss_nisplus.so.2
libpthread.so.0
libresolv.so.2
librt.so.1
libutil.so.1
EOF

# symbol name only
awk -F'\t' '{print $1}' $D/so_syms_glibc |uniq >$D/so_syms_glibc_1
awk -F'\t' '{print $1}' $D/so_syms_musl |uniq >$D/so_syms_musl_1

# difference between musl and glibc symbols
diff $D/so_syms_glibc_1 $D/so_syms_musl_1 >$D/so_syms_1.diff
sed -n '/^< /s/< //p' $D/so_syms_1.diff >$D/so_syms_glibc_1_extra
sed -n '/^> /s/> //p' $D/so_syms_1.diff >$D/so_syms_musl_1_extra

# select symbol info of extra symbols only
selsym() {
	awk -v syms=$1 '
BEGIN {
	while (getline < syms == 1)
		a[$1] = a[$1] $0 "\n"
}
{printf("%s",a[$1])}
' $2
}
selsym $D/so_syms_glibc $D/so_syms_glibc_1_extra >$D/so_syms_glibc_extra
selsym $D/so_syms_musl $D/so_syms_musl_1_extra >$D/so_syms_musl_extra
