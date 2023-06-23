#!/bin/sh

#check ./Lz_Pack
compression=zx0
from=../octode2k16
to=./Output
addr=49152

#handle command line options
while [ $# -gt 0 ] ; do
   if [ "$1" = "-c" ] ; then
      compression=$2
   elif [ "$1" = "-f" ] ; then
      from="$2"
   elif [ "$1" = "-t" ] ; then
      to="$2"
   elif [ "$1" = "-a" ] ; then
      addr="$2"
   else
      echo "Bad parameter: $1" >&2
      echo "Use: $0 -c compression -f path_from -t path_to file1 file2 file3 ..." >&2
      echo "Default:" >&2
      echo "   compression: zx0" >&2
      echo "     path from: ../octode2k16/" >&2
      echo "       path to: ./Output/" >&2
      echo "   buffer addr: 49152" >&2
      exit 1
   fi
   shift
   shift
done

printf "compression program: $compression\n"
printf "          path from: $from\n"
printf "            path to: $to\n"
printf "        buffer addr: $addr\n\n"

 
if [ ! -f ./$compression ] ; then
	if [ "$compression" = "zx0" ] ; then
		[ ! -f ./zx0_source/Makefile ] && echo "File $compression and ./zx0_source/make not found!" >&2 && exit 2
		printf "Compile ${compression}.c\n"
		cd ./zx0_source/
		make
		mv zx0 ../zx0
		cd ..
	else
		[ ! -f ./lzx_source/${compression}.cpp ] && echo "File $compression and ./lzx_source/${compression}.cpp not found!" >&2 && exit 2
		cd ./lzx_source/
		printf "Compile ${compression}.cpp\n"
		g++ ./${compression}.cpp -o $compression
		mv $compression ../$compression
		cd ..
	fi

	[ ! -f ./$compression ] &&  echo "Compilation ${compression}.cpp failed!" >&2 && exit 3
fi

for file in ${from}/*.dat
do
	name=${file##*/}
	name=${name%%.dat}
	
	[ "$name" = "*.dat" ] && echo "No source files?" >&2 && exit 4

	printf "\n;; -------------- name: $name -------------\n"
	printf	"\tpasmo --equ $name=$addr $from/${name}.dat $to/${name}.bin\n" 
	
	pasmo --equ $name=$addr $from/${name}.dat $to/${name}.bin 
	error=$?
	[ $error != 0 ] && printf "Error: $error\n" >&2 && exit 2
	
	if [ "$compression" = "zx0" ] ; then
		./$compression ${to}/${name}.bin ${to}/${name}.zx0
	else
		./$compression ${to}/${name}.bin
	fi
done

echo

if [ "$compression" = "zx0" ] ; then
	du -sbc ${to}/*.zx0
elif [ "$compression" = "Lz_Pack" ] ; then
	du -sbc ${to}/*.lz_
elif [ "$compression" = "LzmPack" ] ; then
	du -sbc ${to}/*.lm_
fi
