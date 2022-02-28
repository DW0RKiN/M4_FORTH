#!/bin/sh

[ $# -lt 1 ] && echo Need filename! && exit

if [ -f $1.m4 ] ; then
    m4 $1.m4 > $1.asm
    printf "old: " 
    ls -l $1.bin
    pasmo -d $1.asm $1.bin > smaz
    printf "new: " 
    ls -l $1.bin
else
    printf "%s\n" "$1.m4 not found!" >&2;
fi
