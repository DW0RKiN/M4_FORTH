#!/bin/sh

# Use:
#   compile.sh name_without_suffix
#   compile.sh name_without_suffix start_addr
#   compile.sh name_without_suffix start_addr no_emul
#   compile.sh name_without_suffix start_addr emulator parameters
#   compile.sh name_without_suffix start_addr loader.bas
#   compile.sh name_without_suffix start_addr loader.bas no_emul
#   compile.sh name_without_suffix start_addr loader.bas emulator parameters

# ------------------- Parameter reading

[ $# -lt 1 ] && printf "Error: $0: Need filename!\n" >&2 && exit 1

name=$1
shift

[ ! -s "$name.m4" ] && printf "Error: $0: \"$name.m4\" not found!\n" >&2 && exit 2

case $1 in
    0x[0-9a-fA-F]*) addr=$(printf "%d" $1); shift ;;
    ''|*[!0-9]*) ;;
    *) addr=$1; shift ;;
esac

case "$1" in
    *.bas) load="$1"; shift ;;
esac

[ ! -z "$1" ] && emul="$1" && shift

printf "     name: $name.m4\n"
printf "   addres: $addr\n"
printf "   loader: $load\n"
printf "     emul: $emul\n"
printf "arguments: %s\n" "$@"

# ------------------- Compilation m4>asm

printf "Compilation m4>asm: ...";

m4 "$name.m4" > "$name.asm"

error=$?      
[ $error != 0 ] && printf "fail!\nError: $0: $error\n" >&2 && exit 3
printf "ok!\n";

if [ -f "$name.bin" ] ; then
    old=$(ls -l "$name.bin")
else 
    old="not exist"
fi

# ------------------- Compilation asm>bin

printf "Compilation asm>bin: ...";

if [ -z "$addr" ] ; then
    pasmo -d                   "$name.asm" "$name.bin" > smaz
    pasmo --tap                "$name.asm" "$name.tap" 2>/dev/null
else
    pasmo -d    --equ __ORG="$addr" "$name.asm" "$name.bin" > smaz
    pasmo --tap --equ __ORG="$addr" "$name.asm" "$name.tap" 2>/dev/null
fi

error=$?      
[ $error != 0 ] && printf "fail!\nError: $0: $error\n" >&2 && exit 4
[ ! -s "$name.bin" ] && printf "fail!\nError: $0: $name.bin not exist or is empty\n" && exit 5
printf "ok!\n";

printf "old: $old\n"
printf "new: " 
ls -l "$name.bin"

[ -z "$addr" ] && exit 0

# ------------------- Generate loader if addr exist

if [ ! -z "$load" ] ; then
    if [ -f "$load" ] ; then
        printf "The existing $load will be used\n"
    elif [ ! -z "$load" ] ; then
        printf "Error: $0: basic loader \"$load\" not found!\n">&2
        exit 6
    fi
else
    load=loader.bas
    printf "Generate basic loader...\n"
    printf "10 LOAD \"\" CODE\n" > "$load"
    printf "20 POKE 23672,0: POKE 23673,0: POKE 23674,0\n" >> "$load"
    printf "30 RANDOMIZE USR $addr\n" >> "$load"
    printf "40 PAUSE 1: LET s=PEEK 23672+256*PEEK 23673+65536*PEEK 23674: LET s=s/50: LET m=INT (INT s/60): LET h=INT (m/60): PRINT \"Time: \";h;\"h \";m-60*h;\"min \";INT ((s-60*m)*100)/100;\"s \";: PAUSE 0: STOP\n" >> "$load"
fi

printf "Compilation bas>tap: ...";

zmakebas -o loader.tap "$load"

error=$?      
[ $error != 0 ] && printf "fail!\nError: $0: $error\n" >&2 && exit 6

printf "ok!\n";

# ------------------- Concatenate loader with code and clean

mv "./$name.tap" "./${name}_bin.tap"
cat loader.tap "${name}_bin.tap" > "$name.tap"
rm loader.tap
rm "${name}_bin.tap"
[ -f loader.bas ] && rm loader.bas

# ------------------- Run the ZX Spectrum emulator

[ "$emul" = "no_emul" ] && exit 0

if [ ! -z "$emul" ] ; then
    [ ! -x "$(command -v "$emul")" ] && printf "Error: $0: $emul not found!\n" >&2 && exit 7
    $emul "$@" "$name.tap"
    exit 0
fi

for emul in "fuse -m 48" "fuse-sdl -m 48" "fbzx" 
do
    if [ -x "$(command -v ${emul%% *})" ] ; then
        $emul "$name.tap"
        exit 0
    fi
done

printf "No ZX Spectrum emulator found installed. Tried fuse, fuse-sdl and fbzx."
