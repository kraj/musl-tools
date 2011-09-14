#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

awk -F'\t' -v inc=$MUSL/include/ '
$3 == "p" && $2 !~ /^bits\// {
	cmd = "awk '\''NR == " $4 "{s=$0;if(s!~/;/){getline; s=s " " $0} print s; exit}'\'' " inc $2
	cmd | getline proto
	close(cmd)
	gsub(/\t/, " ", proto)
}
{
	print $0 "\t" proto
	proto = ""
}
' data/musl.tags >/tmp/tags.proto

awk -F'\t' '{print $5}' /tmp/tags.proto |./type.sh >/tmp/tags.type
awk -F'\t' '{print $5}' data/posix2008.ok |./type.sh >/tmp/posix2008.type

join() {
	awk -v f=$2 '{getline s < f; print $0 "\t" s}' $1
}

join /tmp/tags.proto /tmp/tags.type >data/musl.tags.proto
join data/posix2008.ok /tmp/posix2008.type >data/posix2008.ok.proto

rm -f /tmp/tags.proto /tmp/tags.type /tmp/posix2008.type
