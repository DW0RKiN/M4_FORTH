#!/bin/sh

#check ./xm2octode2k16
if [ ! -f ./xm2octode2k16 ] ; then
	printf "Compile xm2octode2k16.cpp\n"
	g++ ./xm2octode2k16.cpp -o xm2octode2k16
fi
if [ ! -f ./xm2octode2k16 ] ; then
	echo "File ./xm2octode2k16 not found!" >&2
	exit 2
fi
   
for file in *.xm; do
	./xm2octode2k16 $file $@
	error=$?      
	[ $error != 0 ] && printf "Error: $error\n" >&2 && exit 1
done
