#!/bin/sh

if test "$1" = "--check" ; then
   shift
   i="; vvv\n"
   j="dnl\n; ^^^"
   
   _first="changequote(\`{',\`}')dnl
define({__},{})dnl
sinclude(./path0.m4)dnl
sinclude(./M4/path1.m4)dnl
sinclude(../M4/path2.m4)dnl
ifelse(M4PATH,{},{
.error M4 did not find a relative path from the source file to the M4 libraries.})dnl
dnl
define({my_includes},{ifelse(\$1,,,{dnl
;# vvv --- \$1
include(M4PATH{}\$1){}dnl
\$0(shift(\$@))})}){}dnl
dnl
my_includes(__macros.m4,float.m4,if.m4,case.m4,logic.m4,function.m4,loop.m4,device.m4,arithmetic.m4,memory.m4,other.m4,stack.m4,array.m4,zx48float.m4){}dnl
;# ^^^ ---
dnl
define({last_action},{my_includes(float_runtime.m4,graphic_runtime.m4,zx48float_runtime.m4,runtime.m4){}dnl
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
   if [ -t 1 ] ; then
      color=1;
   else 
      color=0;
   fi
   
   file=`find ./ -name "FIRST.M4" -exec echo {} \;`
   
   test "$file" = "" && file=`find ../ -name "FIRST.M4" -exec echo {} \;`
   
   if test "$file" = "" ; then
      printf "$0 error: FIRST.M4 not found!\\n"
      exit 1
   fi

   printf "include(\`$file')${@}" | m4 | awk -v color=$color '
BEGIN {
    str_time=strftime("%Y%m%d%H%M%S");
    sum_bytes=0; 
    sum_clock=0
    first=1} 
{
    match($0,/^[^;]+;([ 0-9]+):([0-9]+)/,arr);
    sum_bytes+= arr[1]; 
    sum_clock+=arr[2];
    if ( first ) {
        first=0;
        if ( $0 ~ /^\s*$/) ;
        else
           print $0;
    }
    else
        print $0;
}
END {
    end_time=strftime("%Y%m%d%H%M%S");
    time=end_time-str_time;
    if ( color == 1 ) 
       printf "\033[1;30m; seconds: %-5i       ;[%2i:%i]\033[0m\n",time,sum_bytes,sum_clock
    else
       printf "; seconds: %-5i       ;[%2i:%i]\n",time,sum_bytes,sum_clock
    endif
}'

fi
