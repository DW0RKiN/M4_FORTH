#!/bin/sh
file=`find ./ -name "FIRST.M4" -exec echo {} \;`
 test "$file" = "" && file=`find ../ -name "FIRST.M4" -exec echo {} \;`
if test "$file" = "" ; then
    printf "$0 error: FIRST.M4 not found!\\n"
    exit 1
fi
printf "; vvv\ninclude(\`$file')dnl\n; ^^^ ${@}" | m4 | awk '
BEGIN {
    sum_bytes=0; 
    sum_clock=0} 
{
    match($0,/^[^;]+;([ 0-9]+):([0-9]+)/,arr);
    sum_bytes+= arr[1]; 
    sum_clock+=arr[2];
    print $0
} 
END {
    printf "                        [%2i:%i]\n",sum_bytes,sum_clock
}'
