#!/bin/sh

if test "$1" = "--check" ; then
   shift
   i="; vvv\n"
   j="dnl\n; ^^^"
   
   _first="changequote(\`{',\`}')dnl
dnl
sinclude(./path0.m4)dnl
sinclude(./M4/path1.m4)dnl
sinclude(../M4/path2.m4)dnl
ifelse(M4PATH,{},{
.error M4 did not find a relative path from the source file to the M4 libraries.})dnl
dnl
;# vvv --- __macros.m4
include(M4PATH{}__macros.m4)dnl
dnl
;# vvv --- float.m4
include(M4PATH{}float.m4)dnl
;# vvv --- if.m4
include(M4PATH{}if.m4)dnl
;# vvv --- case.m4
include(M4PATH{}case.m4)dnl
;# vvv --- logic.m4
include(M4PATH{}logic.m4)dnl
;# vvv --- function.m4
include(M4PATH{}function.m4)dnl
;# vvv --- loop.m4
include(M4PATH{}loop.m4)dnl
;# vvv --- device.m4
include(M4PATH{}device.m4)dnl
;# vvv --- arithmetic.m4
include(M4PATH{}arithmetic.m4)dnl
;# vvv --- memory.m4
include(M4PATH{}memory.m4)dnl
;# vvv --- other.m4
include(M4PATH{}other.m4)dnl
;# vvv --- stack.m4
include(M4PATH{}stack.m4)dnl
;# vvv --- array.m4
include(M4PATH{}array.m4)dnl
;# vvv --- zx48float.m4
include(M4PATH{}zx48float.m4)dnl
;# ^^^ ---
dnl
define({__},{})dnl
dnl
define({last_action},{dnl
__{};# vvv --- float_runtime.m4
__{}include(M4PATH{}float_runtime.m4)dnl
__{};# vvv --- graphic_runtime.m4
__{}include(M4PATH{}graphic_runtime.m4)dnl
__{};# vvv --- zx48float_runtime.m4
__{}include(M4PATH{}zx48float_runtime.m4)dnl
__{};# vvv --- runtime.m4
__{}include(M4PATH{}runtime.m4)dnl
__{};# ^^^ ---
})dnl
m4wrap({last_action})dnl
dnl\n${@}"
   printf "$_first" | m4 --debug= | awk '
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
    printf "                       ;[%2i:%i]\n",sum_bytes,sum_clock
}'
elif test "$1" = "--silent" ; then

   shift
   file=`find ./ -name "FIRST.M4" -exec echo {} \;`
   test "$file" = "" && file=`find ../ -name "FIRST.M4" -exec echo {} \;`
   if test "$file" = "" ; then
      printf "$0 error: FIRST.M4 not found!\\n"
      exit 1
   fi

   printf "include(\`$file')${@}" | m4 --silent | awk '
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
    printf "                       ;[%2i:%i]\n",sum_bytes,sum_clock
}'

else
   file=`find ./ -name "FIRST.M4" -exec echo {} \;`
   test "$file" = "" && file=`find ../ -name "FIRST.M4" -exec echo {} \;`
   if test "$file" = "" ; then
      printf "$0 error: FIRST.M4 not found!\\n"
      exit 1
   fi

   printf "include(\`$file')${@}" | m4 | awk '
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
    printf "                       ;[%2i:%i]\n",sum_bytes,sum_clock
}'

fi
