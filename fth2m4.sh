#!/bin/sh

[ $# -lt 1 ] && printf "Error: Need filename with forth!\n" >&2 && exit 1

[ $# -gt 2 ] && printf "Use: $0 <soubor_s_programem.fth> <-zfloat>\n" >&2 && exit 1

[ ! -s $1 ] && printf "Error: $1 not found!\n" >&2 && exit 2

AWK_SCRIPT="$(dirname "$(readlink -f "$0")")/fth2m4.awk"

[ ! -s $AWK_SCRIPT ] && printf "Error: $AWK_SCRIPT not found!\n" >&2 && exit 2


printf "$(cat $1 | awk -v arg="$2" -f $AWK_SCRIPT)"
