#!/bin/sh

#check ./Lz_Pack
compression=zx0
to=./Output
addr=49152
use_prolog="no"

help_info () {
	echo "Use: $0 -c compression -t path_to -a addr -use_prolog file1 file2 ... path/*.dat" >&2
	echo "" >&2
	echo "	if file start with '-' char, you can use -- before file1" >&2
	echo "" >&2
	echo "	-use_prolog  ...Slightly higher compression ratio." >&2
	echo "			For a scenario where several smaller files are compressed." >&2
	echo "			And later independently decompressed to the same buffer address." >&2
	echo "			Because each compressed file will be stored before the decompression buffer." >&2
	echo "			So every next compressed file will be able to refer to more and more previous files." >&2
	echo "			The smallest files will be packed first, so they will be closer to the buffer." >&2
	echo "			Only for Lz_Pack and LzmPack." >&2
	echo "			Warning: File order, content, and addresses must not be changed." >&2
	echo "" >&2
	echo "	Default:" >&2
	echo "	   compression: zx0" >&2
	echo "	       path to: ./Output/" >&2
	echo "	   buffer addr: 49152" >&2
	echo "	    use_prolog: no" >&2
}

printf "Bash script mass compiling asm files using \"pasmo\" for the given address\n\tand then compressing the resulting bin files.\n\n"

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
	elif [ "$1" = "-h" ] ; then
		help_info
		exit 0
	elif [ "${1%%-*}" = "" ] ; then
		echo "Error! Bad parameter: $1\n" >&2
		help_info
		exit 1
	else
		break
	fi
	shift
	shift
done

printf "(compression program) -c : $compression\n"
printf "            (path to) -t : $to\n"
printf "        (buffer addr) -a : $addr\n"
printf "             -use_prolog : $use_prolog\n"
printf "             source files: $@\n\n"

[ $# -eq 0 ] && printf "Error: need source file name! Try $0 -h\n" >&2 && exit 3

if [ ! -f ./$compression ] ; then
	if [ "$compression" = "zx0" ] ; then
		[ ! -f ./zx0_source/Makefile ] && echo "File $compression and ./zx0_source/make not found!" >&2 && exit 4
		printf "Compile ${compression}.c\n"
		cd ./zx0_source/
		make
		mv zx0 ../zx0
		cd ..
	else
		[ ! -f ./lzx_source/${compression}.cpp ] && echo "File $compression and ./lzx_source/${compression}.cpp not found!" >&2 && exit 4
		cd ./lzx_source/
		printf "Compile ${compression}.cpp\n"
		g++ ./${compression}.cpp -o $compression
		mv $compression ../$compression
		cd ..
	fi

	[ ! -f ./$compression ] &&  echo "Compilation ${compression}.cpp failed!" >&2 && exit 5
fi


[ ! -d ${to} ] && mkdir ${to} 
[ $? != 0 ] && printf "Error: Not found destination directory!\n" >&2 exit 6

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
	[ $error != 0 ] && printf "pasmo error: $error\n" >&2 && exit 7
done

pack_files=""
[ "$use_prolog" = "yes" ] && printf "" > tmp_delete_this && incbin=""
start_addr=$addr

for file in $(ls -rS -- $bin_files)
do
	# name.abc.txt --> ${file%.*}  --> name.abc
	# name.abc.txt --> ${file%%.*} --> name
	name=${file##*/}
	no_suffix=${name%%.*}

	[ ! -f $file ] && echo "Source file \"$file\" not found !" >&2 && continue

	printf "\n; -------------- compress: ${no_suffix}.bin -------------\n"

	if [ "$compression" = "zx0" ] ; then
		pack_files="$pack_files $to/${no_suffix}.zx0"
		./$compression -f $file ${to}/${no_suffix}.zx0
		error=$?
		[ $error != 0 ] && printf "$compression error: $error\n" >&2 && exit 8

	elif [ "$compression" = "Lz_Pack" ] ; then
		pack_files="$pack_files $to/${no_suffix}.lz_"
		if [ "$use_prolog" = "yes" ] ; then
		
			incbin="\tincbin ${to}/${no_suffix}.lz_\n\t; $start_addr\n$incbin"

			./$compression $file -p tmp_delete_this
			error=$?
			[ $error != 0 ] && printf "$compression error: $error\n" >&2 && exit 8
			
			size=$(wc -c $to/${no_suffix}.lz_)
			size=${size%% *}
			start_addr=$(($start_addr - $size ))
			incbin="${no_suffix}:\n\t; $start_addr\n$incbin"

			mv tmp_delete_this tmp_delete_this_2
			cat ${to}/${no_suffix}.lz_ tmp_delete_this_2 >> tmp_delete_this
		else
			./$compression $file
			error=$?
			[ $error != 0 ] && printf "$compression error: $error\n" >&2 && exit 8

		fi
	elif [ "$compression" = "LzmPack" ] ; then
	
		pack_files="$pack_files $to/${no_suffix}.lzm"
		if [ "$use_prolog" = "yes" ] ; then
		
			incbin="\tincbin ${to}/${no_suffix}.lzm\n\t; $start_addr\n$incbin"

			./$compression $file -p tmp_delete_this
			error=$?
			[ $error != 0 ] && printf "$compression error: $error\n" >&2 && exit 8

			size=$(wc -c $to/${no_suffix}.lzm)
			size=${size%% *}
			start_addr=$(($start_addr - $size ))
			incbin="${no_suffix}:\n\t; $start_addr\n$incbin"

			mv tmp_delete_this tmp_delete_this_2
			cat ${to}/${no_suffix}.lzm tmp_delete_this_2 >> tmp_delete_this
		else
			./$compression $file
			error=$?
			[ $error != 0 ] && printf "$compression error: $error\n" >&2 && exit 8

		fi	
	else
		./$compression $file
		error=$?
		[ $error != 0 ] && printf "$compression error: $error\n" >&2 && exit 8

	fi

done

echo

if [ "$use_prolog" = "yes" ] ; then
	rm tmp_delete_this tmp_delete_this_2
	printf "include this:\n\n"
	printf "\tORG $start_addr\n"
	printf "${incbin}; buffer_addr:\n\n"

	printf "from last include to first (reverse sort):\n"
fi	

du -sbc $pack_files
