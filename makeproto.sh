#!/bin/sh

export LC_ALL=C
MUSL=${MUSL:-../musl}

awk -F'\t' '{if($3=="p")print $5; else print ""}' data/musl.tags |./type.sh >/tmp/tags.type
awk -F'\t' '{print $5}' data/posix2008.ok |./type.sh >/tmp/posix2008.type

join() {
	awk -v f=$2 '{getline s < f; print $0 "\t" s}' $1
}

join data/musl.tags /tmp/tags.type >data/musl.tags.proto
join data/posix2008.ok /tmp/posix2008.type >data/posix2008.ok.proto

rm -f /tmp/tags.type /tmp/posix2008.type
