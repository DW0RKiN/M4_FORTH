#!/bin/sh

#check ./Lz_Pack
compression=zx0
to=./Output
addr=49152
use_prolog="no"

#handle command line options
while [ $# -gt 0 ] ; do
	if [ "$1" = "-c" ] ; then
		compression=$2
	elif [ "$1" = "-t" ] ; then
		to="$2"
	elif [ "$1" = "-a" ] ; then
		addr="$2"
	elif [ "$1" = "-use_prolog" ] ; then
		use_prolog="yes"
		shift
		continue
	elif [ "$1" = "--" ] ; then
		shift
		break
	elif [ "${1%%-*}" = "" ] ; then
		echo "Error! Bad parameter: $1\n" >&2
		echo "Use: $0 -c compression -t path_to -a addr --use_prolog file1 file2 file3 ..." >&2
		echo "\n\tif file start with '-' char, you can use -- before file" >&2
		echo "\nDefault:" >&2
		echo "   compression: zx0" >&2
		echo "       path to: ./Output/" >&2
		echo "   buffer addr: 49152" >&2
		echo "    use_prolog: no" >&2
		exit 1
	else
		break
	fi
	shift
	shift
done

printf "compression program: $compression\n"
printf "            path to: $to\n"
printf "        buffer addr: $addr\n"
printf "       source files: $@\n\n"


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



bin_files=""

for file in $@
do
	# name.abc.txt --> ${file%.*}  --> name.abc
	# name.abc.txt --> ${file%%.*} --> name
	name=${file##*/}
	no_suffix=${name%.*}

	[ ! -f $file ] && echo "Source file \"$file\" not found !" >&2 && continue

	printf "\n; -------------- name: $name > ${no_suffix}.bin -------------\n"
	printf	"\tpasmo --equ $no_suffix=$addr $file $to/${no_suffix}.bin\n" 

	bin_files="$bin_files $to/${no_suffix}.bin"

	pasmo --equ $no_suffix=$addr $file $to/${no_suffix}.bin 
	error=$?
	[ $error != 0 ] && printf "pasmo error: $error\n" >&2 && exit 2
done

pack_files=""
printf "" > tmp_delete_this

for file in $(ls -rS $bin_files)
do
	# name.abc.txt --> ${file%.*}  --> name.abc
	# name.abc.txt --> ${file%%.*} --> name
	name=${file##*/}
	no_suffix=${name%.*}

	[ ! -f $file ] && echo "Source file \"$file\" not found !" >&2 && continue

	printf "\n; -------------- compress: ${no_suffix}.bin -------------\n"

	if [ "$compression" = "zx0" ] ; then
		pack_files="$pack_files $to/${no_suffix}.zx0"
		./$compression $file ${to}/${no_suffix}.zx0
	elif [ "$compression" = "Lz_Pack" ] ; then
		pack_files="$pack_files $to/${no_suffix}.lz_"
		if [ "$use_prolog" = "yes" ] ; then
			./$compression $file -p tmp_delete_this
			mv tmp_delete_this tmp_delete_this_2
			cat ${to}/${no_suffix}.lz_ tmp_delete_this_2 >> tmp_delete_this
		else
			./$compression $file
		fi
	elif [ "$compression" = "LzmPack" ] ; then
		pack_files="$pack_files $to/${no_suffix}.lzm"
		if [ "$use_prolog" = "yes" ] ; then
			./$compression $file -p tmp_delete_this
			mv tmp_delete_this tmp_delete_this_2
			cat ${to}/${no_suffix}.lzm tmp_delete_this_2 >> tmp_delete_this
		else
			./$compression $file
		fi	
	else
		./$compression $file
	fi
	error=$?
	[ $error != 0 ] && printf "$compression error: $error\n" >&2 && exit 2
done

echo

if [ "$use_prolog" = "yes" ] ; then
	rm tmp_delete_this tmp_delete_this_2
	echo "from last include to first (reverse sort):"
fi	

du -sbc $pack_files
