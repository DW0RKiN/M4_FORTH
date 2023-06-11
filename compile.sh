#!/bin/sh

# Use:
#   compile.sh name_without_suffix
#   compile.sh name_without_suffix start_addr
#   compile.sh name_without_suffix start_addr no_emul
#   compile.sh name_without_suffix start_addr emulator parameters

# ------------------- Parameter reading

[ $# -lt 1 ] && printf "Error: Need filename!\n" >&2 && exit 1

name=$1
shift

[ ! -s $name.m4 ] && printf "Error: $name.m4 not found!\n" >&2 && exit 2

case $1 in
    0x[0-9a-fA-F]*) addr=$(printf "%d" $1); shift ;;
    ''|*[!0-9]*) ;;
    *) addr=$1; shift ;;
esac

[ ! -z $1 ] && emul=$1 && shift

printf "name: $name.m4\n"
printf "addr: $addr\n"
printf "emul: $emul\n"
printf "parameters: $*\n\n"

# ------------------- Compilation m4>asm

printf "Compilation m4>asm: ...";

m4 $name.m4 > $name.asm

error=$?      

if [ $error != 0 ] ; then
    printf "fail! error: $error\n";
    exit 3
fi
printf "ok!\n";

if [ -f $name.bin ] ; then
    old=$(ls -l $name.bin)
else 
    old="not exist"
fi

# ------------------- Compilation asm>bin

printf "Compilation asm>bin: ...";

if [ -z $addr ] ; then
    pasmo -d                   $name.asm $name.bin > smaz
    pasmo --tap                $name.asm $name.tap 2>/dev/null
else
    pasmo -d    --equ __ORG=$addr $name.asm $name.bin > smaz
    pasmo --tap --equ __ORG=$addr $name.asm $name.tap 2>/dev/null
fi

error=$?      

if [ $error != 0 ] ; then
    printf "fail! error: $error\n";
    exit 4
fi
if [ ! -s $name.tap ] ; then
    printf "fail! $name.tap not exist\n";
    exit 5
fi
printf "ok!\n";

printf "old: $old\n"
printf "new: " 
ls -l $name.bin

[ -z $addr ] && exit 0

# ------------------- Generate loader if addr exist

if [ ! -f loader.bas ] ; then
    printf "Generate basic loader...\n"
    printf "10 LOAD \"\" CODE\n" > loader.bas
    printf "20 POKE 23672,0: POKE 23673,0: POKE 23674,0\n" >> loader.bas
    printf "30 RANDOMIZE USR $addr\n" >> loader.bas
    printf "40 PAUSE 1: LET s=PEEK 23672+256*PEEK 23673+65536*PEEK 23674: LET s=s/50: LET m=INT (INT s/60): LET h=INT (m/60): PRINT \"Time: \";h;\"h \";m-60*h;\"min \";INT ((s-60*m)*100)/100;\"s \";: PAUSE 0: STOP\n" >> loader.bas
else
    printf "The existing loader.bas will be used\n"
fi

printf "Compilation bas>tap: ...";

zmakebas -o loader.tap loader.bas

error=$?      

if [ $error != 0 ] ; then
    printf "fail! error: $error\n";
    exit 6
fi
printf "ok!\n";

# ------------------- Concatenate loader with code and clean

mv ./$name.tap ./${name}_bin.tap
cat loader.tap ${name}_bin.tap > $name.tap
rm loader.tap
rm ${name}_bin.tap

# ------------------- Run the ZX Spectrum emulator

[ "$emul" = "no_emul" ] && exit 0

if [ ! -z $emul ] ; then
    [ ! -x "$(command -v $emul)" ] && printf "Error: $emul not found!\n" >&2 && exit 7
    $emul $* $name.tap
    exit 0
fi

if [ -x "$(command -v fuse)" ] ; then
    fuse --no-confirm-actions -m 48 -t $name.tap
    exit 0
fi

if [ -x "$(command -v fuse-sdl)" ] ; then
    fuse-sdl --no-confirm-actions -m 48 -t $name.tap
    exit 0
fi

if [ -x "$(command -v fbzx)" ] ; then
    fbzx $name.tap
    exit 0
fi

printf "No ZX Spectrum emulator found installed. Tried fuse, fuse-sdl and fbzx."
