#!/bin/sh
file=`find ./ -name "FIRST.M4" -exec echo {} \;`
 test "$file" = "" && file=`find ../ -name "FIRST.M4" -exec echo {} \;`
if test "$file" = "" ; then
    printf "$0 error: FIRST.M4 not found!\\n"
    exit 1
fi
echo "include(\`$file')dnl\n${@}" | m4
