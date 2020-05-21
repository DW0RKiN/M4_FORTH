#!/bin/sh

[ $# -lt 1 ] && echo Need filename! && exit

if [ -f $1.m4 ] ; then
    m4 $1.m4 > $1.asm
    pasmo -d $1.asm $1.bin > smaz
else
    printf "%s\n" "$1.m4 not found!" >&2;
fi
