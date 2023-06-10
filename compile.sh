#!/bin/sh

[ $# -lt 1 ] && printf "Need filename!\n" && exit 1

if [ ! -s $1.m4 ] ; then
    printf "$1.m4 not found!\n" >&2;
    exit 2
fi

printf "Compilation m4>asm: ...";

m4 $1.m4 > $1.asm

error=$?      

if [ $error != 0 ] ; then
    printf "fail! error: $error\n";
    exit 3
fi
printf "ok!\n";

if [ -f $1.bin ] ; then
    old=$(ls -l $1.bin)
else 
    old="not exist"
fi

printf "Compilation asm>bin: ...";

if [ $# -lt 2 ] ; then
    pasmo -d                   $1.asm $1.bin > smaz
    pasmo --tap                $1.asm $1_bin.tap 2>/dev/null
else
    pasmo -d    --equ __ORG=$2 $1.asm $1.bin > smaz
    pasmo --tap --equ __ORG=$2 $1.asm $1_bin.tap 2>/dev/null
fi

error=$?      

if [ $error != 0 ] ; then
    printf "fail! error: $error\n";
    exit 4
fi
if [ ! -s $1_bin.tap ] ; then
    printf "fail! $1_bin.tap not exist\n";
    exit 5
fi
printf "ok!\n";

printf "old: $old\n"
printf "new: " 
ls -l $1.bin

if [ $# -lt 2 ] ; then
    exit 0
fi

# -------------------  if $2 use  -------------------



#generate loader.bas
if [ ! -f loader.bas ] ; then
    printf "Generate basic loader...\n"
    printf "10 LOAD \"\" CODE\n" > loader.bas
    printf "20 POKE 23672,0: POKE 23673,0: POKE 23674,0\n" >> loader.bas
    printf "30 RANDOMIZE USR $2\n" >> loader.bas
    printf "40 PAUSE 1: LET s=PEEK 23672+256*PEEK 23673+65536*PEEK 23674: LET s=s/50: LET m=INT (INT s/60): LET h=INT (m/60): PRINT \"Time: \";h;\"h \";m-60*h;\"min \";INT ((s-60*m)*100)/100;\"s \";: PAUSE 0: STOP\n" >> loader.bas
else
    printf "The existing loader will be used\n"
fi

printf "Compilation bas>tap: ...";

zmakebas -o loader.tap loader.bas

error=$?      

if [ $error != 0 ] ; then
    printf "fail! error: $error\n";
    exit 6
fi
printf "ok!\n";


cat loader.tap $1_bin.tap > $1.tap

rm loader.tap
rm $1_bin.tap

if ! [ -x "$(command -v fuse-sdl)" ] ; then
    if ! [ -x "$(command -v fuse)" ] ; then
        echo 'Error: fuse or fuse-sdl is not installed.' >&2
        exit 7
    else
        fuse --no-confirm-actions -m 48 -t $1.tap
    fi
else
    fuse-sdl --no-confirm-actions -m 48 -t $1.tap
fi
