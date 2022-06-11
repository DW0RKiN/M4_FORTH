#!/bin/bash

# Protection against:    sed 's#^\([^;{]*\s\|^\)COLON(\([^_a-zA-Z[.ch.][.CH.]]\)#\1COLON(xxx_\2#gi'
# and then error messages for non-Czech settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

TMPFILE=$(mktemp)
TMPFILE2=$(mktemp)
TMPFILE3=$(mktemp)

# : new_word ... ;   -->   : new_word ... SEMICOLON
# / line end comment -->   ;# line end comment

cat $1 |  sed 's#\(\s\|^\);\(\s\|$\)#\1SEMICOLON\2#gi'| sed 's#\(\s\|^\)\\\(\s\|$\)#\1;\#\2#gi' > $TMPFILE

# ( comment1) ... ( comment2)( comment3) ... -->
# ;#( comment1)
# ...
# ;#( comment2)
# ;#( comment3)
# ...

while :
do

   # [^\s] not work! --> [^[:space:]] or [^ 	]

    cat $TMPFILE |
    sed -e 's#^\([^;{(]*\s\)(\(\s\+[^)]*\))[[:space:]]*\([^[:space:]]\+.*\)$#\1\n;\#(\2)\n\3#g' |
    sed -e 's#^\([^;{(]*\s\)(\(\s\+[^)]*\))[[:space:]]*$#\1\n;\#(\2)#g' |

    sed -e              's#^(\(\s\+[^)]*\))[[:space:]]*\([^[:space:]]\+.*\)$#;\#(\1)\n\2#g' |
    sed -e              's#^(\(\s\+[^)]*\))[[:space:]]*$#;\#(\1)#g' > $TMPFILE2

#   ( comment1 ( 5+5)) ( comment2 ( 10+10))
#     sed -e 's#^\([^;{]*\s\|^\)(\(\s\+[^()]*\))\(\s\+\|$\)$#\1;\#(\2)#' |
#     sed -e 's#^\([^;{]*\s\|^\)(\(\s\+[^()]*([^()]*)[^()]*\))\(\s\+\|$\)$#\1;(\2)#' |
#     sed -e 's#^\([^;{]*\s\|^\)(\(\s\+[^()]*\))\s\+\([^ 	].*\)$#\1;(\2)\n\3#' |
#     sed -e 's#^\([^;{]*\s\|^\)(\(\s\+[^()]*([^()]*)[^()]*\))\s\+\([^ 	].*\)$#\1;(\2)\n\3#' > $TMPFILE2

    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done

# .( string) ... ." string" ... s" string"
while :
do
    cat $TMPFILE |
    # "... .( Hello Word)..."
    sed -e   's#^\([^;{(]*\s\)\.(\s\([^)]*\))[[:space:]]*\([^[:space:]]\+.*\)$#\1\nPRINT_Z({"\2"})\n\3#g' |
    # "... .( Hello Word)   "
    sed -e   's#^\([^;{(]*\s\)\.(\s\([^)]*\))[[:space:]]*$#\1\nPRINT_Z({"\2"})#g' |
    # ".( Hello Word)..."
    sed -e                's#^\.(\s\([^)]*\))[[:space:]]*\([^[:space:]]\+.*\)$#PRINT_Z({"\1"})\n\2#g' |
    # ".( Hello Word)   "
    sed -e                's#^\.(\s\([^)]*\))[[:space:]]*$#PRINT_Z({"\1"})#g' |

    sed -e   's#^\([^;{(]*\s\)\."\s\([^"]*\)"[[:space:]]*\([^[:space:]]\+.*\)$#\1\nPRINT_Z({"\2"})\n\3#g' |
    sed -e   's#^\([^;{(]*\s\)\."\s\([^"]*\)"[[:space:]]*$#\1\nPRINT_Z({"\2"})#g' |
    sed -e                's#^\."\s\([^"]*\)"[[:space:]]*\([^[:space:]]\+.*\)$#PRINT_Z({"\1"})\n\2#g' |
    sed -e                's#^\."\s\([^"]*\)"[[:space:]]*$#PRINT_Z({"\1"})#g' |

    sed -e 's#^\([^;{(]*\s\)[Ss]"\s\([^"]*\)"[[:space:]]*\([^[:space:]]\+.*\)$#\1\nSTRING_Z({"\2"})\n\3#g' |
    sed -e 's#^\([^;{(]*\s\)[Ss]"\s\([^"]*\)"[[:space:]]*$#\1\nSTRING_Z({"\2"})#g' |
    sed -e              's#^[Ss]"\s\([^"]*\)"[[:space:]]*\([^[:space:]]\+.*\)$#STRING_Z({"\1"})\n\2#g' |
    sed -e              's#^[Ss]"\s\([^"]*\)"[[:space:]]*$#STRING_Z({"\1"})#g' > $TMPFILE2

#     cat $TMPFILE |
#     # s" Hello Word" whitespace EOL
#     sed -e 's#^\([^;{]*\s\|^\)[Ss]"\s\([^"]*\)"\(\s\+\|$\)$#\1STRING({"\2"})#' |
#     # s" Hello Word" whitespace Other Words
#     sed -e 's#^\([^;{]*\s\|^\)[Ss]"\s\([^"]*\)"\s\+\([^ 	].*\)$#\1STRING({"\2"})\n\3#' |
#     # ." Hello Word" whitespace EOL
#     sed -e 's#^\([^;{]*\s\|^\)\."\s\([^"]*\)"\(\s\+\|$\)$#\1PRINT_Z({"\2"})#' |
#     # ." Hello Word" whitespace Other Words
#     sed -e 's#^\([^;{]*\s\|^\)\."\s\([^"]*\)"\s\+\([^ 	].*\)$#\1PRINT_Z({"\2"})\n\3#' |
#     # .( Hello Word) whitespace EOL
#     sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*\))\(\s\+\|$\)$#\1PRINT_Z({"\2"})#' |
#     # .( Hel(lo) Word) whitespace EOL
#     # This is probably not legal, according to https://www.tutorialspoint.com/execute_forth_online.php
#     sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*([^()]*)[^()]*\))\(\s\+\|$\)$#\1PRINT_Z({"\2"})#' |
#     # .( Hello Word) whitespace Other Words
#     sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*\))\s\+\([^ 	].*\)$#\1PRINT_Z({"\2"})\n\3#' |
#     # .( Hel(lo) Word) whitespace Other Words
#     # This is probably not legal, according to https://www.tutorialspoint.com/execute_forth_online.php
#     sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*([^()]*)[^()]*\))\s\(\s*[^ 	].*\)$#\1PRINT_Z({"\2"}) \3#' > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


# : name ; : name2 ;
while :
do
    cat $TMPFILE | sed 's#^\([^;{]*\s\|^\):\s\+\([^ 	]\+\)\([^;]\+\)\(\s\+\);\(\s\|$\)#\1\COLON(\2)\3\4SEMICOLON\5#gi'  > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done

# .( string )
while :
do
    cat $TMPFILE | sed 's#^\([^;{]*\s\|^\):\s\+\([^ 	]\+\)\([^;]\+\)\(\s\+\);\(\s\|$\)#\1\COLON(\2)\3\4SEMICOLON\5#gi'  > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done

if [ "$2" == "-ZXROM" ]
then

while :
do
# set -x
    cat $TMPFILE |


    sed 's#^\([^;{]*\s\|^\)d>f\(\s\|$\)#\1ZX48D_TO_F\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f>d\(\s\|$\)#\1ZX48F_TO_D\2#gi' |

    sed 's#^\([^;{]*\s\|^\)s>f\(\s\|$\)#\1ZX48S_TO_F\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f>s\(\s\|$\)#\1ZX48F_TO_S\2#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+ZX48S_TO_F\(\s\|$\)#\1PUSH_ZX48S_TO_F(\2)\3#gi' |


    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+fpick\(\s\|$\)#\1PUSH_ZX48FPICK(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)fabs\(\s\|$\)#\1ZX48FABS\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f+\(\s\|$\)#\1ZX48FADD\2#gi' |

    sed 's#^\([^;{]*\s\|^\)facos\(\s\|$\)#\1ZX48FACOS\2#gi' |
    sed 's#^\([^;{]*\s\|^\)fasin\(\s\|$\)#\1ZX48FASIN\2#gi' |
    sed 's#^\([^;{]*\s\|^\)fatan\(\s\|$\)#\1ZX48FATAN\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fcos\(\s\|$\)#\1ZX48FCOS\2#gi' |
    sed 's#^\([^;{]*\s\|^\)fsin\(\s\|$\)#\1ZX48FSIN\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ftan\(\s\|$\)#\1ZX48FTAN\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f/\(\s\|$\)#\1ZX48FDIV\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f\.\(\s\|$\)#\1ZX48FDOT\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fdrop\(\s\|$\)#\1ZX48FDROP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fdup\(\s\|$\)#\1ZX48FDUP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fexp\(\s\|$\)#\1ZX48FEXP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f\@\(\s\|$\)#\1ZX48FFETCH\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fint\(\s\|$\)#\1ZX48FINT\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fln\(\s\|$\)#\1ZX48FLN\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f\*\(\s\|$\)#\1ZX48FMUL\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f\*\*\(\s\|$\)#\1ZX48FMULMUL\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fnegate\(\s\|$\)#\1ZX48FNEGATE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fover\(\s\|$\)#\1ZX48FOVER\2#gi' |

    sed 's#^\([^;{]*\s\|^\)frot\(\s\|$\)#\1ZX48FROT\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fsqrt\(\s\|$\)#\1ZX48FSQRT\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f!\(\s\|$\)#\1ZX48FSTORE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f-\(\s\|$\)#\1ZX48FSUB\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fswap\(\s\|$\)#\1ZX48FSWAP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)fvariable\s\+\([^ 	]\+\)\(\s\|$\)#\1FVARIABLE(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)f<=\(\s\|$\)#\1ZX48FGE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f>=\(\s\|$\)#\1ZX48FLE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f<>\(\s\|$\)#\1ZX48FNE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f=\(\s\|$\)#\1ZX48FEQ\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f<\(\s\|$\)#\1ZX48FLT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f>\(\s\|$\)#\1ZX48FGT\2#gi' |

    sed 's#^\([^;{]*\s\|^\)f0<\(\s\|$\)#\1ZX48F0LT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f0=\(\s\|$\)#\1ZX48F0EQ\2#gi' |

    sed 's#^\([^;{]*\s\|^\)float+\(\s\|$\)#\1ZX48FLOATADD\2#gi' |
# +123.567e+45
# -1.567E-5
# 565e4
# -.123e+560
# \+ ...1 or more
# \? ...0 or 1
# *  ...0 or more
    sed 's#^\([^;{]*\s\|^\)\([+-]\?[0-9]*\.\?[0-9]\+[Ee][+-]\?[0-9]\+\)\(\s\|$\)#\1PUSH_ZX48F(\2)\3#gi' |
# +123.567e
# -1.567E
# 565e
# -.123e
    sed 's#^\([^;{]*\s\|^\)\([+-]\?[0-9]*\.\?[0-9]\+[Ee]\)\(\s\|$\)#\1PUSH_ZX48F(\2+0)\3#gi' > $TMPFILE2
# set +x
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


fi


# POZOR!!! pokud ignorujeme velka a mala pismena pres parametr ...#gi
# a slovo se sklada pouze s pismen, ktera menime na velka tak tam nesmi byt to "i"
# protoze pokud je na radku vice techto slov tak to zmeni jen posledni...
# "echo "pick pick" | "sed "s#pick#PICK#gi" --> "pick PICK"
# "echo "pick pick" | "sed "s#[Pp]ick#PICK#g" --> "PICK PICK"

while :
do
    cat $TMPFILE |

    sed 's#^\([^;{]*\s\|^\):\s\+\([^ 	]\+\)\(\s\|$\)#\1\COLON(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)?\(\s\|$\)#\1!\ .\2#gi' |

    # 0 = --> 0=
    sed 's#^\([^;{]*\s\|^\)[-+]*[0]\+\s\+=\(\s\|$\)#\1_0EQ\2#gi' |
    sed 's#^\([^;{]*\s\|^\)0=\(\s\|$\)#\1_0EQ\2#gi' |
    # 0 < --> 0<
    sed 's#^\([^;{]*\s\|^\)[-+]*[0]\+\s\+<\(\s\|$\)#\1_0LT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)0<\(\s\|$\)#\1_0LT\2#gi' |
    # 0 > --> 0>
    sed 's#^\([^;{]*\s\|^\)[-+]*[0]\+\s\+>=\(\s\|$\)#\1_0GE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)0>=\(\s\|$\)#\1_0GE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Pp]ick\(\s\|$\)#\1PICK\2#g' |
    sed 's#^\([^;{]*\s\|^\)+!\(\s\|$\)#\1ADDSTORE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)!\(\s\|$\)#\1STORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)TUCK\s\+STORE\(\s\|$\)#\1TUCK_STORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)TUCK_STORE\s\+_2ADD\(\s\|$\)#\1TUCK_STORE_2ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER_SWAP\s\+STORE\(\s\|$\)#\1OVER_SWAP_STORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+STORE\(\s\|$\)#\1_2DUP_STORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP_STORE\s\+2+\(\s\|$\)#\1_2DUP_STORE_2ADD\2#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+SWAP\s\+STORE\(\s\|$\)#\1PUSH_OVER_STORE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\(0x[0-9A-F]\+\)\s\+SWAP\s\+STORE\(\s\|$\)#\1PUSH_OVER_STORE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER_STORE(\([^)]\+\))\s\+2+\(\s\|$\)#\1PUSH_OVER_STORE_2ADD(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)@\(\s\|$\)#\1FETCH\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+FETCH\(\s\|$\)#\1DUP_FETCH\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP_FETCH\s\+SWAP\(\s\|$\)#\1DUP_FETCH_SWAP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)c!\(\s\|$\)#\1CSTORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)c@\(\s\|$\)#\1CFETCH\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+CFETCH\(\s\|$\)#\1DUP_CFETCH\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP_CFETCH\s\+SWAP\(\s\|$\)#\1DUP_CFETCH_SWAP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)2!\(\s\|$\)#\1_2STORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2@\(\s\|$\)#\1_2FETCH\2#gi' |

    sed 's#^\([^;{]*\s\|^\)2>r\(\s\|$\)#\1_2TO_R\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2r>\(\s\|$\)#\1_2R_FROM\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2r@\(\s\|$\)#\1_2R_FETCH\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2[Rr][Dd]rop\(\s\|$\)#\1_2RDROP\2#g' |

    sed 's#^\([^;{]*\s\|^\)>r\(\s\|$\)#\1TO_R\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+TO_R\(\s\|$\)#\1DUP_TO_R\2#gi' |
    sed 's#^\([^;{]*\s\|^\)r>\(\s\|$\)#\1R_FROM\2#gi' |
    sed 's#^\([^;{]*\s\|^\)r@\(\s\|$\)#\1R_FETCH\2#gi' |
    sed 's#^\([^;{]*\s\|^\)[Rr][Dd]rop\(\s\|$\)#\1RDROP\2#g' |

    sed 's#^\([^;{]*\s\|^\)\*\(\s\|$\)#\1\MUL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)[Mm]od\(\s\|$\)#\1MOD\2#g' |
    sed 's#^\([^;{]*\s\|^\)/[Mm][Oo][Dd]\(\s\|$\)#\1\DIVMOD\2#g' |
    sed 's#^\([^;{]*\s\|^\)/\(\s\|$\)#\1DIV\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Uu][Mm]od\(\s\|$\)#\1UMOD\2#g' |
    sed 's#^\([^;{]*\s\|^\)u/mod\(\s\|$\)#\1\UDIVMOD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)u/\(\s\|$\)#\1UDIV\2#gi' |

    sed 's#^\([^;{]*\s\|^\)+\(\s\|$\)#\1ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)-\(\s\|$\)#\1SUB\2#gi' |

    sed 's#^\([^;{]*\s\|^\)=\(\s\|$\)#\1EQ\2#gi' |
    sed 's#^\([^;{]*\s\|^\)<>\(\s\|$\)#\1NE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)>=\(\s\|$\)#\1GE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)<=\(\s\|$\)#\1LE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)>\(\s\|$\)#\1GT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)<\(\s\|$\)#\1LT\2#gi' |
    
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+EQ\(\s\|$\)#\1EQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+NE\(\s\|$\)#\1NE\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+LT\(\s\|$\)#\1GT\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+LE\(\s\|$\)#\1GE\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+GE\(\s\|$\)#\1LE\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+GT\(\s\|$\)#\1LT\2#g' |

    sed 's#^\([^;{]*\s\|^\)u=\(\s\|$\)#\1UEQ\2#gi' |
    sed 's#^\([^;{]*\s\|^\)u<>\(\s\|$\)#\1UNE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)u>=\(\s\|$\)#\1UGE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)u<=\(\s\|$\)#\1ULE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)u>\(\s\|$\)#\1UGT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)u<\(\s\|$\)#\1ULT\2#gi' |

    sed 's#^\([^;{]*\s\|^\)SWAP\s\+UEQ\(\s\|$\)#\1EQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+UNE\(\s\|$\)#\1NE\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+ULT\(\s\|$\)#\1UGT\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+ULE\(\s\|$\)#\1UGE\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+UGE\(\s\|$\)#\1ULE\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+UGT\(\s\|$\)#\1ULT\2#g' |

    sed 's#^\([^;{]*\s\|^\)S>D\(\s\|$\)#\1S_TO_D\2#gi' |
    sed 's#^\([^;{]*\s\|^\)D>S\(\s\|$\)#\1D_TO_S\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Rr][Ss]hift\(\s\|$\)#\1RSHIFT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ll][Ss]hift\(\s\|$\)#\1LSHIFT\2#g' |
    sed 's#^\([^;{]*\s\|^\)>>\(\s\|$\)#\1RSHIFT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)<<\(\s\|$\)#\1LSHIFT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9][0-9]*\+\)\s\+RSHIFT\(\s\|$\)#\1PUSH_RSHIFT(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)-\([0-9][0-9]*\+\)\s\+RSHIFT\(\s\|$\)#\1PUSH_LSHIFT(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9][0-9]*\+\)\s\+LSHIFT\(\s\|$\)#\1PUSH_LSHIFT(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)-\([0-9][0-9]*\+\)\s\+LSHIFT\(\s\|$\)#\1PUSH_RSHIFT(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)\.\(\s\|$\)#\1DOT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)u\.\(\s\|$\)#\1UDOT\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Cc]r\(\s\|$\)#\1CR\2#g' |
    sed 's#^\([^;{]*\s\|^\)\.s\(\s\|$\)#\1DOTS\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Tt]ype\(\s\|$\)#\1TYPE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ee]mit\(\s\|$\)#\1EMIT\2#g' |

    sed 's#^\([^;{]*\s\|^\)PRINT_Z({\"\(.\)\"})\(\s\|$\)#\1PUSH_EMIT('\''\2'\'')\3#g' |

    sed 's#^\([^;{]*\s\|^\)[Dd]up\s\+EMIT\(\s\|$\)#\1DUP_EMIT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ss]pace\(\s\|$\)#\1SPACE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Kk]ey\(\s\|$\)#\1KEY\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Aa]ccept\(\s\|$\)#\1ACCEPT\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Ss]wap\(\s\|$\)#\1SWAP\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+OVER\(\s\|$\)#\1SWAP_OVER\2#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+SWAP\(\s\|$\)#\1PUSH_SWAP(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)2SWAP\(\s\|$\)#\1_2SWAP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)?DUP\(\s\|$\)#\1QUESTIONDUP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+OVER\(\s\|$\)#\1PUSH_OVER(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+-]0[Xx][0-9A-Fa-f]\+\)\s\+OVER\(\s\|$\)#\1PUSH_OVER(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)[Dd]up\(\s\|$\)#\1DUP\2#g' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+DUP\(\s\|$\)#\1DUP_DUP\2#g' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+PUSH_SWAP(\([^)]\+\))\(\s\|$\)#\1PUSH_OVER(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]\+\))\s\+CSTORE\(\s\|$\)#\1PUSH_OVER_CSTORE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER_CSTORE(\([^)]\+\))\s\+1+\(\s\|$\)#\1PUSH_OVER_CSTORE_1ADD(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]\+\))\s\+STORE\(\s\|$\)#\1PUSH_OVER_STORE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER_STORE(\([^)]\+\))\s\+2+\(\s\|$\)#\1PUSH_OVER_CSTORE_2ADD(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)2dup\(\s\|$\)#\1_2DUP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)4dup\(\s\|$\)#\1_4DUP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)over\s\+over\(\s\|$\)#\1_2DUP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Dd]rop\(\s\|$\)#\1DROP\2#g' |
    sed 's#^\([^;{]*\s\|^\)2DROP\(\s\|$\)#\1_2DROP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)drop\s\+drop\(\s\|$\)#\1_2DROP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Nn]ip\(\s\|$\)#\1NIP\2#g' |
    sed 's#^\([^;{]*\s\|^\)swap\s\+drop\(\s\|$\)#\1NIP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2NIP\(\s\|$\)#\1_2NIP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+_2DROP\(\s\|$\)#\1_2NIP\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Tt]uck\(\s\|$\)#\1TUCK\2#g' |
    sed 's#^\([^;{]*\s\|^\)swap\s\+over\(\s\|$\)#\1TUCK\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2TUCK\(\s\|$\)#\1_2TUCK\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2swap\s\+2over\(\s\|$\)#\1_2TUCK\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Oo]ver\(\s\|$\)#\1OVER\2#g' |
    sed 's#^\([^;{]*\s\|^\)OVER\s\+SWAP\(\s\|$\)#\1OVER_SWAP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2OVER\(\s\|$\)#\1_2OVER\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2OVER\s\+_2OVER\(\s\|$\)#\1_4DUP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Rr]ot\(\s\|$\)#\1ROT\2#g' |
    sed 's#^\([^;{]*\s\|^\)NROT\s\+SWAP\(\s\|$\)#\1NROT_SWAP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ROT\s\+DROP\s\+SWAP\(\s\|$\)#\1NROT_NIP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ROT\s\+DROP\(\s\|$\)#\1ROT_DROP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2[Rr]ot\(\s\|$\)#\1_2ROT\2#g' |
    sed 's#^\([^;{]*\s\|^\)-_2ROT\(\s\|$\)#\1N2ROT\2#g' |

    sed 's#^\([^;{]*\s\|^\)-[Rr]ot\(\s\|$\)#\1NROT\2#g' |
    sed 's#^\([^;{]*\s\|^\)-2[Rr]ot\(\s\|$\)#\1N2ROT\2#g' |
    sed 's#^\([^;{]*\s\|^\)NROT\s\+NIP\(\s\|$\)#\1NROT_NIP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)rot\s\+rot\(\s\|$\)#\1NROT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)NROT\s\+_2SWAP\(\s\|$\)#\1NROT_2SWAP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)0\+\s\+[c]*move[>]*\(\s\|$\)#\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Mm]ove\(\s\|$\)#\1MOVE\2#g' |
    sed 's#^\([^;{]*\s\|^\)move>\(\s\|$\)#\1MOVEGT\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Cc][Mm]ove\(\s\|$\)#\1CMOVE\2#g' |
    sed 's#^\([^;{]*\s\|^\)cmove>\(\s\|$\)#\1CMOVEGT\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Dd]o\(\s\|$\)#\1DO\2#g' |
    sed 's#^\([^;{]*\s\|^\)?[Dd]o\(\s\|$\)#\1QUESTIONDO\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ll]oop\(\s\|$\)#\1LOOP\2#g' |
    sed 's#^\([^;{]*\s\|^\)+loop\(\s\|$\)#\1ADDLOOP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Ee]nd[Cc]ase\(\s\|$\)#\1DROP ENDCASE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Cc]ase\(\s\|$\)#\1CASE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ee]nd[Oo]f\(\s\|$\)#\1ENDOF\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Oo]f\(\s\|$\)#\1OF DROP\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Ff]or\(\s\|$\)#\1FOR\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Nn]ext\(\s\|$\)#\1NEXT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ii]f\(\s\|$\)#\1IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ee]lse\(\s\|$\)#\1ELSE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Tt]hen\(\s\|$\)#\1THEN\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Bb]egin\(\s\|$\)#\1BEGIN\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ww]hile\(\s\|$\)#\1WHILE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Rr]epeat\(\s\|$\)#\1REPEAT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Uu]ntil\(\s\|$\)#\1UNTIL\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Aa]gain\(\s\|$\)#\1AGAIN\2#g' |
    sed 's#^\([^;{]*\s\|^\)i\(\s\|$\)#\1I\2#g' |
    sed 's#^\([^;{]*\s\|^\)j\(\s\|$\)#\1J\2#g' |
    sed 's#^\([^;{]*\s\|^\)k\(\s\|$\)#\1K\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Uu]nloop\(\s\|$\)#\1UNLOOP\2#g' |

    sed 's#^\([^;{]*\s\|^\)\([^ 	]\+\)\s\+const\s\+\([^ 	]\+\)\(\s\|$\)#\1CONSTANT(\3,\2)\4#gi' |
    sed 's#^\([^;{]*\s\|^\)\([^ 	]\+\)\s\+constant\s\+\([^ 	]\+\)\(\s\|$\)#\1CONSTANT(\3,\2)\4#gi' |
    sed 's#^\([^;{]*\s\|^\)\([^ 	]\+\)\s\+var\s\+\([^ 	]\+\)\(\s\|$\)#\1VARIABLE(\3,\2)\4#gi' |
    sed 's#^\([^;{]*\s\|^\)\([^ 	]\+\)\s\+dvar\s\+\([^ 	]\+\)\(\s\|$\)#\1DVARIABLE(\3,\2)\4#gi' |

    sed 's#^\([^;{]*\s\|^\)[Vv]ariable\(\s\|$\)#\1VARIABLE\2#g' |
    sed 's#^\([^;{]*\s\|^\)VARIABLE\s\+\([^ 	]\+\)\(\s\|$\)#\1VARIABLE(\2)\3#g' |

    sed 's#^\([^;{]*\s\|^\)[Ee]xit\(\s\|$\)#\1EXIT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ff]alse\(\s\|$\)#\1FALSE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Tt]rue\(\s\|$\)#\1TRUE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ii]nvert\(\s\|$\)#\1INVERT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ww]ithin\(\s\|$\)#\1WITHIN\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Aa]bs\(\s\|$\)#\1ABS\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Xx]or\(\s\|$\)#\1XOR\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Oo]r\(\s\|$\)#\1OR\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Aa]nd\(\s\|$\)#\1AND\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Mm]ax\(\s\|$\)#\1MAX\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Mm]in\(\s\|$\)#\1MIN\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Nn]egate\(\s\|$\)#\1NEGATE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ll]eave\(\s\|$\)#\1LEAVE\2#g' |

    sed 's#^\([^;{]*\s\|^\)m\*\(\s\|$\)#\1MMUL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)m+\(\s\|$\)#\1MADD\2#gi' |

    sed 's#^\([^;{]*\s\|^\)um\*\(\s\|$\)#\1UMMUL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)fm/mod\(\s\|$\)#\1FMDIVMOD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)sm/rem\(\s\|$\)#\1SMDIVREM\2#gi' |
    sed 's#^\([^;{]*\s\|^\)um/mod\(\s\|$\)#\1UMDIVMOD\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Dd]+\(\s\|$\)#\1DADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\.\s\+DADD\(\s\|$\)#\1PUSHDOT_DADD(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+DADD\(\s\|$\)#\1_2DUP_DADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2OVER\s\+DADD\(\s\|$\)#\1_2OVER_DADD\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Dd]-\(\s\|$\)#\1DSUB\2#gi' |
    sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\.\s\+DSUB\(\s\|$\)#\1PUSHDOT_DSUB(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DSUB\(\s\|$\)#\1_2SWAP_DSUB\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2OVER\s\+DSUB\(\s\|$\)#\1_2OVER_DSUB\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Dd][Aa]bs\(\s\|$\)#\1DABS\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd][Mm]ax\(\s\|$\)#\1DMAX\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd][Mm]in\(\s\|$\)#\1DMIN\2#g' |
    sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\.\s\+DMAX\(\s\|$\)#\1PUSHDOT_DMAX(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\.\s\+DMIN\(\s\|$\)#\1PUSHDOT_DMIN(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd][Nn]egate\(\s\|$\)#\1DNEGATE\2#g' |
    sed 's#^\([^;{]*\s\|^\)D1+\(\s\|$\)#\1D1ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)D1-\(\s\|$\)#\1D1SUB\2#gi' |
    sed 's#^\([^;{]*\s\|^\)D2+\(\s\|$\)#\1D2ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)D2-\(\s\|$\)#\1D2SUB\2#gi' |
    sed 's#^\([^;{]*\s\|^\)D2\*\(\s\|$\)#\1D2MUL\2#g' |
    sed 's#^\([^;{]*\s\|^\)D2/\(\s\|$\)#\1D2DIV\2#g' |
    sed 's#^\([^;{]*\s\|^\)D256\*\(\s\|$\)#\1D256MUL\2#g' |
    sed 's#^\([^;{]*\s\|^\)D256/\(\s\|$\)#\1D256DIV\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Dd]0=\(\s\|$\)#\1D0EQ\2#gi' |
    sed 's#^\([^;{]*\s\|^\)[-+]*0\+\s\+[-+]*0\+\s\+DEQ\(\s\|$\)#\1D0EQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)[-+]*0\+\.\s\+DEQ\(\s\|$\)#\1D0EQ\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Dd]0<\(\s\|$\)#\1D0LT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[-+]*0\+\s\+[-+]*0\+\s\+DLT\(\s\|$\)#\1D0LT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[-+]*0\+\.\s\+DLT\(\s\|$\)#\1D0LT\2#g' |
    
    sed 's#^\([^;{]*\s\|^\)[Dd]=\(\s\|$\)#\1DEQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd]<>\(\s\|$\)#\1DNE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd]<\(\s\|$\)#\1DLT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd]>=\(\s\|$\)#\1DGE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd]<=\(\s\|$\)#\1DLE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd]>\(\s\|$\)#\1DGT\2#g' |
    
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DEQ\(\s\|$\)#\1DEQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DNE\(\s\|$\)#\1DNE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DLT\(\s\|$\)#\1DGT\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DLE\(\s\|$\)#\1DGE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DGE\(\s\|$\)#\1DLE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DGT\(\s\|$\)#\1DLT\2#g' |
    
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+\([-+]*[0-9]\+\)\.\s\+DLT\(\s\|$\)#\1_2DUP_PUSHDOT_DLT(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+\([-+]*[0-9]\+\)\.\s\+DLE\(\s\|$\)#\1_2DUP_PUSHDOT_DLE(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+\([-+]*[0-9]\+\)\.\s\+DGE\(\s\|$\)#\1_2DUP_PUSHDOT_DGE(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+\([-+]*[0-9]\+\)\.\s\+DGT\(\s\|$\)#\1_2DUP_PUSHDOT_DGT(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+\([-+]*0[Xx][0-9a-fA-F]\+\)\.\s\+DLT\(\s\|$\)#\1_2DUP_PUSHDOT_DLT(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+\([-+]*0[Xx][0-9a-fA-F]\+\)\.\s\+DLE\(\s\|$\)#\1_2DUP_PUSHDOT_DLE(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+\([-+]*0[Xx][0-9a-fA-F]\+\)\.\s\+DGE\(\s\|$\)#\1_2DUP_PUSHDOT_DGE(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+\([-+]*0[Xx][0-9a-fA-F]\+\)\.\s\+DGT\(\s\|$\)#\1_2DUP_PUSHDOT_DGT(\2)\3#g' |
    
    sed 's#^\([^;{]*\s\|^\)[Dd][Uu]=\(\s\|$\)#\1DUEQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd][Uu]<>\(\s\|$\)#\1DUNE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd][Uu]<\(\s\|$\)#\1DULT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd][Uu]<=\(\s\|$\)#\1DULE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd][Uu]>=\(\s\|$\)#\1DUGE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd][Uu]>\(\s\|$\)#\1DUGT\2#g' |

    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DUEQ\(\s\|$\)#\1DUEQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DUNE\(\s\|$\)#\1DUNE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DULT\(\s\|$\)#\1DUGT\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DULE\(\s\|$\)#\1DUGE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DUGE\(\s\|$\)#\1DULE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+DUGT\(\s\|$\)#\1DULT\2#g' |

    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DEQ\(\s\|$\)#\1_4DUP_DEQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DNE\(\s\|$\)#\1_4DUP_DNE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DLT\(\s\|$\)#\1_4DUP_DLT\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DGE\(\s\|$\)#\1_4DUP_DGE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DLE\(\s\|$\)#\1_4DUP_DLE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DGT\(\s\|$\)#\1_4DUP_DGT\2#g' |

    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DUEQ\(\s\|$\)#\1_4DUP_DEQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DUNE\(\s\|$\)#\1_4DUP_DNE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DULT\(\s\|$\)#\1_4DUP_DULT\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DULE\(\s\|$\)#\1_4DUP_DULE\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DUGT\(\s\|$\)#\1_4DUP_DUGT\2#g' |
    sed 's#^\([^;{]*\s\|^\)_4DUP\s\+DUGE\(\s\|$\)#\1_4DUP_DUGE\2#g' |

    sed 's#^\([^;{]*\s\|^\)DEQ\s\+IF\(\s\|$\)#\1DEQ_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DNE\s\+IF\(\s\|$\)#\1DNE_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DLT\s\+IF\(\s\|$\)#\1DLT_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DGE\s\+IF\(\s\|$\)#\1DGE_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DLE\s\+IF\(\s\|$\)#\1DLE_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DGT\s\+IF\(\s\|$\)#\1DGT_IF\2#g' |

    sed 's#^\([^;{]*\s\|^\)DUEQ\s\+IF\(\s\|$\)#\1DEQ_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DUNE\s\+IF\(\s\|$\)#\1DNE_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DULT\s\+IF\(\s\|$\)#\1DULT_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DULE\s\+IF\(\s\|$\)#\1DULE_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DUGT\s\+IF\(\s\|$\)#\1DUGT_IF\2#g' |
    sed 's#^\([^;{]*\s\|^\)DUGE\s\+IF\(\s\|$\)#\1DUGE_IF\2#g' |

    sed 's#^\([^;{]*\s\|^\)s>f\(\s\|$\)#\1S2F\2#gi' |
    sed 's#^\([^;{]*\s\|^\)u>f\(\s\|$\)#\1U2F\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f>s\(\s\|$\)#\1F2S\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f>u\(\s\|$\)#\1F2U\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f+\(\s\|$\)#\1FADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f-\(\s\|$\)#\1FSUB\2#gi' |
    sed 's#^\([^;{]*\s\|^\)[Ff][Nn]egate\(\s\|$\)#\1FNEGATE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ff][Aa]bs\(\s\|$\)#\1FABS\2#g' |
    sed 's#^\([^;{]*\s\|^\)f\.\(\s\|$\)#\1FDOT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f\*\(\s\|$\)#\1FMUL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f/\(\s\|$\)#\1FDIV\2#gi' |
    sed 's#^\([^;{]*\s\|^\)[Ff][Ss]qrt\(\s\|$\)#\1FSQRT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ff][Tt]runc\(\s\|$\)#\1FTRUNC\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ff][Rr]ac\(\s\|$\)#\1FFRAC\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ff][Ee]xp\(\s\|$\)#\1FEXP\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ff][Ll]n\(\s\|$\)#\1FLN\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ff][Mm]od\(\s\|$\)#\1FMOD\2#g' |
    sed 's#^\([^;{]*\s\|^\)f2\*\(\s\|$\)#\1F2MUL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)f2/\(\s\|$\)#\1F2DIV\2#gi' |
    sed 's#^\([^;{]*\s\|^\)[Ff][Ss]in\(\s\|$\)#\1FSIN\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Bb]ye\(\s\|$\)#\1BYE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ff]ill\(\s\|$\)#\1FILL\2#g' |

    sed 's#^\([^;{]*\s\|^\)NROT\s\+SWAP\s\+_2SWAP\sSWAP\(\s\|$\)#\1STACK_BCAD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER\s\+_2OVER\s\+DROP\(\s\|$\)#\1STACK_CBABC\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2OVER\s\+NIP\s\+_2OVER\s\+NIP\s\+SWAP\(\s\|$\)#\1STACK_CBABC\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER\s\+3\s\+PICK\(\s\|$\)#\1STACK_CBABC\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2\s\+PICK\s\+2\s\+PICK\s\+SWAP\(\s\|$\)#\1STACK_CBABC\2#gi' |

    sed 's#^\([^;{]*\s\|^\)T{\(\s\|$\)#\1TEST_START\2#gi' |
    sed 's#^\([^;{]*\s\|^\)->\(\s\|$\)#\1TEST_EQ\2#gi' |
    sed 's#^\([^;{]*\s\|^\)\}T\(\s\|$\)#\1TEST_END\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Rr]andom\(\s\|$\)#\1RANDOM\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Rr]nd\(\s\|$\)#\1RND\2#g' > $TMPFILE2

    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


oddelovac="`printf "\a"`"
# 'x' --> 0000000000xxx
CHAR=`cat $TMPFILE | grep "^\([^;{]*\s\|^\)\('.'\)\(\s.*\|\s*\|$\)$" | sed "s%^\([^;{]*\s\|^\)\('.'\)\(\s.*\|\s*\|$\)$%\2%g"`
NUM="0"
for x in $CHAR
do
    NUM="$(($NUM+1))"
    name="0000000000$NUM"
    while :
    do
    cat $TMPFILE | sed "s${oddelovac}^\([^;{]*\s\|^\)${x}\(\s\|$\)${oddelovac}\1${name}\2${oddelovac}g" > $TMPFILE2
        diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
        error=$?
        cat $TMPFILE2 > $TMPFILE
        [ $error -gt 1 ] && exit
        [ $error -eq 0 ] && break
    done
done

# variable --> 0000000000xxx
VAR=""
VAR="$VAR `cat $TMPFILE | grep '^\([^;{]*\s\|^\)DVARIABLE(\([^,)]\+\)[,)].*' | sed 's#^\([^;{]*\s\|^\)DVARIABLE(\([^,)]\+\)[,)].*#\2#g'`"
VAR="$VAR `cat $TMPFILE | grep '^\([^;{]*\s\|^\)VARIABLE(\([^,)]\+\)[,)].*' | sed 's#^\([^;{]*\s\|^\)VARIABLE(\([^,)]\+\)[,)].*#\2#g'`"
VAR="$VAR `cat $TMPFILE | grep '^\([^;{]*\s\|^\)CONSTANT(\([^,)]\+\)[,)].*' | sed 's#^\([^;{]*\s\|^\)CONSTANT(\([^,)]\+\)[,)].*#\2#g'`"

oddelovac="`printf "\a"`"
for x in $VAR
do
    NUM="$(($NUM+1))"
    name="0000000000$NUM"

    cat $TMPFILE | sed "s${oddelovac}^\([^;{]*\)(${x}\([,)]\)${oddelovac}\1(${name}\2${oddelovac}g" > $TMPFILE2
    cat $TMPFILE2 > $TMPFILE

    while :
    do
        cat $TMPFILE | sed "s${oddelovac}^\([^;{]*\s\|^\)${x}\(\s\|$\)${oddelovac}\1${name}\2${oddelovac}g" > $TMPFILE2
        diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
        error=$?
        cat $TMPFILE2 > $TMPFILE
        [ $error -gt 1 ] && exit
        [ $error -eq 0 ] && break
    done
done

# optimize
while :
do
    cat $TMPFILE |

# stupidni co nikdo neudela
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+SWAP\(\s\|$\)#\1\2#gi' |
    
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+\([+-]*[0-9]\+\)\s\+WITHIN\(\s\|$\)#\1PUSH2_WITHIN(\2,\3)\4#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+OF\(\s\|$\)#\1PUSH_OF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\(0x[0-9A-F]\+\)\s\+OF\(\s\|$\)#\1PUSH_OF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+FILL\(\s\|$\)#\1PUSH_FILL(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\(0x[0-9A-F]\+\)\s\+FILL\(\s\|$\)#\1PUSH_FILL(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+PUSH_FILL(\([^)]*\))\(\s\|$\)#\1PUSH2_FILL(\2,\3)\4#gi' |
    sed 's#^\([^;{]*\s\|^\)\(0x[0-9A-F]\+\)\s\+PUSH_FILL(\([^)]*\))\(\s\|$\)#\1PUSH2_FILL(\2,\3)\4#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+PUSH2_FILL(\([^)]*\))\(\s\|$\)#\1PUSH3_FILL(\2,\3)\4#gi' |
    sed 's#^\([^;{]*\s\|^\)\(0x[0-9A-F]\+\)\s\+PUSH2_FILL(\([^)]*\))\(\s\|$\)#\1PUSH3_FILL(\2,\3)\4#gi' |

    sed 's#^\([^;{]*\s\|^\)1+\(\s\|$\)#\1_1ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)1-\(\s\|$\)#\1_1SUB\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2+\(\s\|$\)#\1_2ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2-\(\s\|$\)#\1_2SUB\2#gi' |

    sed 's#^\([^;{]*\s\|^\)1\s\+ADD\(\s\|$\)#\1_1ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)1\s\+SUB\(\s\|$\)#\1_1SUB\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2\s\+ADD\(\s\|$\)#\1_2ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2\s\+SUB\(\s\|$\)#\1_2SUB\2#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+ADD\(\s\|$\)#\1PUSH_ADD(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*0[Xx][0-9a-fA-F]\+\)\s\+ADD\(\s\|$\)#\1PUSH_ADD(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+SUB\(\s\|$\)#\1PUSH_SUB(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*0[Xx][0-9a-fA-F]\+\)\s\+SUB\(\s\|$\)#\1PUSH_SUB(\2)\3#g' |
    
    sed 's#^\([^;{]*\s\|^\)DUP\s\+PUSH_ADD(\([^)]\+\))\(\s\|$\)#\1DUP_PUSH_ADD(\2)\3#g' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+AND\(\s\|$\)#\1PUSH_AND(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+OR\(\s\|$\)#\1PUSH_OR(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+XOR\(\s\|$\)#\1PUSH_XOR(\2)\3#g' |

    sed 's#^\([^;{]*\s\|^\)\(0x[0-9A-F]\+\)\s\+AND\(\s\|$\)#\1PUSH_AND(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)\(0x[0-9A-F]\+\)\s\+OR\(\s\|$\)#\1PUSH_OR(\2)\3#g' |
    sed 's#^\([^;{]*\s\|^\)\(0x[0-9A-F]\+\)\s\+XOR\(\s\|$\)#\1PUSH_XOR(\2)\3#g' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+MAX\(\s\|$\)#\1PUSH_MAX(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\(0x[0-9A-F]\+\)\s\+MAX\(\s\|$\)#\1PUSH_MAX(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+MIN\(\s\|$\)#\1PUSH_MIN(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\(0x[0-9A-F]\+\)\s\+MIN\(\s\|$\)#\1PUSH_MIN(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+ADDLOOP\(\s\|$\)#\1PUSH_ADDLOOP(\2)\3#g' |

    sed 's#^\([^;{]*\s\|^\)\([0-9]\+\)\(\s\+\)MOVE\(\s\|$\)#\1PUSH(2*(\2))\3CMOVE\4#g' |
    sed 's#^\([^;{]*\s\|^\)\([0-9]\+\)\(\s\+\)MOVEGT\(\s\|$\)#\1PUSH(2*(\2))\3CMOVEGT\4#g' |

    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9][0-9]*\)\s\+PICK\(\s\|$\)#\1PUSH_PICK(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)_0EQ\s\+UNTIL\(\s\|$\)#\1_0EQ_UNTIL\2#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP\s\+UNTIL\(\s\|$\)#\1DUP_UNTIL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+_0EQ_UNTIL\(\s\|$\)#\1DUP_0EQ_UNTIL\2#gi' |

    sed 's#^\([^;{]*\s\|^\)OVER\s\+UNTIL\(\s\|$\)#\1OVER_UNTIL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER\s\+_0EQ_UNTIL\(\s\|$\)#\1OVER_0EQ_UNTIL\2#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP_CFETCH\s\+UNTIL\(\s\|$\)#\1DUP_CFETCH_UNTIL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP_CFETCH\s\+_0EQ_UNTIL\(\s\|$\)#\1DUP_CFETCH_0EQ_UNTIL\2#gi' |

    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+EQ\s\+UNTIL\(\s\|$\)#\1_2DUP_EQ_UNTIL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+EQ\s\+UNTIL\(\s\|$\)#\1DUP_PUSH_EQ_UNTIL(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\(0x[0-9A-F]\+\)\s\+EQ\s\+UNTIL\(\s\|$\)#\1DUP_PUSH_EQ_UNTIL(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+IF\(\s\|$\)#\1DUP_IF\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Ee]q\(\s\|$\)#\1EQ\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Nn]e\(\s\|$\)#\1NE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ll]t\(\s\|$\)#\1LT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ll]e\(\s\|$\)#\1LE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Gg]t\(\s\|$\)#\1GT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Gg]e\(\s\|$\)#\1GE\2#g' |

    sed 's#^\([^;{]*\s\|^\)_0EQ\s\+IF\(\s\|$\)#\1_0EQ_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_0LT\s\+IF\(\s\|$\)#\1_0LT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_0GE\s\+IF\(\s\|$\)#\1_0GE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)D0EQ\s\+IF\(\s\|$\)#\1D0EQ_IF\2#gi' |

    sed 's#^\([^;{]*\s\|^\)EQ\s\+IF\(\s\|$\)#\1EQ_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)NE\s\+IF\(\s\|$\)#\1NE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)LT\s\+IF\(\s\|$\)#\1LT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)LE\s\+IF\(\s\|$\)#\1LE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)GT\s\+IF\(\s\|$\)#\1GT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)GE\s\+IF\(\s\|$\)#\1GE_IF\2#gi' |

    sed 's#^\([^;{]*\s\|^\)UEQ\s\+IF\(\s\|$\)#\1UEQ_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)UNE\s\+IF\(\s\|$\)#\1UNE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ULT\s\+IF\(\s\|$\)#\1ULT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ULE\s\+IF\(\s\|$\)#\1ULE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)UGT\s\+IF\(\s\|$\)#\1UGT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)UGE\s\+IF\(\s\|$\)#\1UGE_IF\2#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP\s\+_0EQ_IF\(\s\|$\)#\1DUP_0EQ_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+_0LT_IF\(\s\|$\)#\1DUP_0LT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+_0GE_IF\(\s\|$\)#\1DUP_0GE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+D0EQ_IF\(\s\|$\)#\1_2DUP_D0EQ_IF\2#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP\sWHILE\(\s\|$\)#\1DUP_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\sUDOT\(\s\|$\)#\1DUP_UDOT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\sDOT\(\s\|$\)#\1DUP_DOT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\sTYPE\(\s\|$\)#\1_2DUP_TYPE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+EQ_IF\(\s\|$\)#\1_2DUP_EQ_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+NE_IF\(\s\|$\)#\1_2DUP_NE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+LT_IF\(\s\|$\)#\1_2DUP_LT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+LE_IF\(\s\|$\)#\1_2DUP_LE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+GT_IF\(\s\|$\)#\1_2DUP_GT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+GE_IF\(\s\|$\)#\1_2DUP_GE_IF\2#gi' |

    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UEQ_IF\(\s\|$\)#\1_2DUP_UEQ_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UNE_IF\(\s\|$\)#\1_2DUP_UNE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULT_IF\(\s\|$\)#\1_2DUP_ULT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULE_IF\(\s\|$\)#\1_2DUP_ULE_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGT_IF\(\s\|$\)#\1_2DUP_UGT_IF\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGE_IF\(\s\|$\)#\1_2DUP_UGE_IF\2#gi' |

    sed 's#^\([^;{]*\s\|^\)EQ\s\+WHILE\(\s\|$\)#\1EQ_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)NE\s\+WHILE\(\s\|$\)#\1NE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)LT\s\+WHILE\(\s\|$\)#\1LT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)LE\s\+WHILE\(\s\|$\)#\1LE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)GT\s\+WHILE\(\s\|$\)#\1GT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)GE\s\+WHILE\(\s\|$\)#\1GE_WHILE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)UEQ\s\+WHILE\(\s\|$\)#\1UEQ_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)UNE\s\+WHILE\(\s\|$\)#\1UNE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ULT\s\+WHILE\(\s\|$\)#\1ULT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ULE\s\+WHILE\(\s\|$\)#\1ULE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)UGT\s\+WHILE\(\s\|$\)#\1UGT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)UGE\s\+WHILE\(\s\|$\)#\1UGE_WHILE\2#gi' |
    
    sed 's#^\([^;{]*\s\|^\)DEQ\s\+WHILE\(\s\|$\)#\1DEQ_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DNE\s\+WHILE\(\s\|$\)#\1DNE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DLT\s\+WHILE\(\s\|$\)#\1DLT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DLE\s\+WHILE\(\s\|$\)#\1DLE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DGT\s\+WHILE\(\s\|$\)#\1DGT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DGE\s\+WHILE\(\s\|$\)#\1DGE_WHILE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)_4DUP_DEQ\s\+WHILE\(\s\|$\)#\1_4DUP_DEQ_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_4DUP_DNE\s\+WHILE\(\s\|$\)#\1_4DUP_DNE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_4DUP_DLT\s\+WHILE\(\s\|$\)#\1_4DUP_DLT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_4DUP_DLE\s\+WHILE\(\s\|$\)#\1_4DUP_DLE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_4DUP_DGT\s\+WHILE\(\s\|$\)#\1_4DUP_DGT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_4DUP_DGE\s\+WHILE\(\s\|$\)#\1_4DUP_DGE_WHILE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+EQ_WHILE\(\s\|$\)#\1DUP_PUSH_EQ_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+NE_WHILE\(\s\|$\)#\1DUP_PUSH_NE_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+LT_WHILE\(\s\|$\)#\1DUP_PUSH_LT_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+LE_WHILE\(\s\|$\)#\1DUP_PUSH_LE_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+GT_WHILE\(\s\|$\)#\1DUP_PUSH_GT_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+GE_WHILE\(\s\|$\)#\1DUP_PUSH_GE_WHILE(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UEQ_WHILE\(\s\|$\)#\1DUP_PUSH_UEQ_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UNE_WHILE\(\s\|$\)#\1DUP_PUSH_UNE_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+ULT_WHILE\(\s\|$\)#\1DUP_PUSH_ULT_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+ULE_WHILE\(\s\|$\)#\1DUP_PUSH_ULE_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UGT_WHILE\(\s\|$\)#\1DUP_PUSH_UGT_WHILE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UGE_WHILE\(\s\|$\)#\1DUP_PUSH_UGE_WHILE(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+EQ_WHILE\(\s\|$\)#\1_2DUP_EQ_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+NE_WHILE\(\s\|$\)#\1_2DUP_NE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+SUB\s\+WHILE\(\s\|$\)#\1_2DUP_NE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+LT_WHILE\(\s\|$\)#\1_2DUP_LT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+LE_WHILE\(\s\|$\)#\1_2DUP_LE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+GT_WHILE\(\s\|$\)#\1_2DUP_GT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+GE_WHILE\(\s\|$\)#\1_2DUP_GE_WHILE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UEQ_WHILE\(\s\|$\)#\1_2DUP_UEQ_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UNE_WHILE\(\s\|$\)#\1_2DUP_UNE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULT_WHILE\(\s\|$\)#\1_2DUP_ULT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULE_WHILE\(\s\|$\)#\1_2DUP_ULE_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGT_WHILE\(\s\|$\)#\1_2DUP_UGT_WHILE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGE_WHILE\(\s\|$\)#\1_2DUP_UGE_WHILE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+FETCH\(\s\|$\)#\1PUSH_FETCH(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+STORE\(\s\|$\)#\1PUSH_STORE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+PUSH_STORE(\([^)]*\))\(\s\|$\)#\1PUSH2_STORE(\2,\3)\4#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+CFETCH\(\s\|$\)#\1PUSH_CFETCH(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+CSTORE\(\s\|$\)#\1PUSH_CSTORE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_SWAP(\([+]*[0-9]\+\))\s\+CSTORE\(\s\|$\)#\1PUSH_SWAP_CSTORE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+PUSH_CSTORE(\([^)]*\))\(\s\|$\)#\1PUSH2_CSTORE(\2,\3)\4#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+_2FETCH\(\s\|$\)#\1PUSH_2FETCH(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+_2STORE\(\s\|$\)#\1PUSH_2STORE(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+PUSH_2STORE(\([^)]*\))\(\s\|$\)#\1PUSH2_2STORE(\2,\3)\4#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+\([+]*[0-9]\+\)\s\+ADDSTORE\(\s\|$\)#\1PUSH2_ADDSTORE(\2,\3)\4#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+EMIT\(\s\|$\)#\1PUTCHAR(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+EQ_IF\(\s\|$\)#\1PUSH_EQ_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+NE_IF\(\s\|$\)#\1PUSH_NE_IF(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP\s\+PUSH_EQ_IF(#\1DUP_PUSH_EQ_IF(#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+PUSH_NE_IF(#\1DUP_PUSH_NE_IF(#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+LT_IF\(\s\|$\)#\1DUP_PUSH_LT_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+LE_IF\(\s\|$\)#\1DUP_PUSH_LE_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+GT_IF\(\s\|$\)#\1DUP_PUSH_GT_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+GE_IF\(\s\|$\)#\1DUP_PUSH_GE_IF(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+EQ_IF\(\s\|$\)#\1DUP_PUSH_EQ_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+NE_IF\(\s\|$\)#\1DUP_PUSH_NE_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+LT_IF\(\s\|$\)#\1DUP_PUSH_LT_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+LE_IF\(\s\|$\)#\1DUP_PUSH_LE_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+GT_IF\(\s\|$\)#\1DUP_PUSH_GT_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+GE_IF\(\s\|$\)#\1DUP_PUSH_GE_IF(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UEQ_IF\(\s\|$\)#\1DUP_PUSH_UEQ_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UNE_IF\(\s\|$\)#\1DUP_PUSH_UNE_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+ULT_IF\(\s\|$\)#\1DUP_PUSH_ULT_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+ULE_IF\(\s\|$\)#\1DUP_PUSH_ULE_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UGT_IF\(\s\|$\)#\1DUP_PUSH_UGT_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UGE_IF\(\s\|$\)#\1DUP_PUSH_UGE_IF(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+UEQ_IF\(\s\|$\)#\1DUP_PUSH_UEQ_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+UNE_IF\(\s\|$\)#\1DUP_PUSH_UNE_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+ULT_IF\(\s\|$\)#\1DUP_PUSH_ULT_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+ULE_IF\(\s\|$\)#\1DUP_PUSH_ULE_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+UGT_IF\(\s\|$\)#\1DUP_PUSH_UGT_IF(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_OVER(\([^)]*\))\s\+UGE_IF\(\s\|$\)#\1DUP_PUSH_UGE_IF(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)DROP\s\+\([-+]*[0-9]\+\)\(\s\|$\)#\1DROP_PUSH(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DROP\s\+\([-+]*[0-9]\+\)\(\s\|$\)#\1_2DROP_PUSH(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([-+]*[0-9]\+\)\(\s\|$\)#\1DUP_PUSH(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)cell\(\s\|$\)#\12\2#gi' |
    sed 's#^\([^;{]*\s\|^\)-cell\(\s\|$\)#\1-2\2#gi' |
    sed 's#^\([^;{]*\s\|^\)+*cell\(\s\|$\)#\12\2#gi' |
    sed 's#^\([^;{]*\s\|^\)cell+\(\s\|$\)#\1_2ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)cell-\(\s\|$\)#\1_2SUB\2#gi' |
    sed 's#^\([^;{]*\s\|^\)cells\(\s\|$\)#\1_2MUL\2#gi' |

    sed 's#^\([^;{]*\s\|^\)2\*\(\s\|$\)#\1_2MUL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2/\(\s\|$\)#\1_2DIV\2#gi' |
    sed 's#^\([^;{]*\s\|^\)256\*\(\s\|$\)#\1_256MUL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)256/\(\s\|$\)#\1_256DIV\2#gi' |
    sed 's#^\([^;{]*\s\|^\)0*256\s\+MUL\(\s\|$\)#\1_256MUL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)0*256\s\+DIV\(\s\|$\)#\1_256DIV\2#gi' |

    sed 's#^\([^;{]*\s\|^\)DUP\s\+ADD\(\s\|$\)#\1DUP_ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER\s\+ADD\(\s\|$\)#\1OVER_ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER\s\+SUB\(\s\|$\)#\1OVER_SUB\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER\s\+\([+-]*[0-9]\+\)\(\s\|$\)#\1OVER_PUSH(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+DROP\(\s\|$\)#\1NIP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+FOR\(\s\|$\)#\1PUSH_FOR(\2)\3#gi' |

    sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+MUL\(\s\|$\)#\1PUSH_MUL(\2)\3#gi' > $TMPFILE2

    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


cat $TMPFILE | sed 's#o#_____0_____#g' | sed 's#O#_____00_____#g' > $TMPFILE2
cat $TMPFILE2 > $TMPFILE

while :
do
    cat $TMPFILE |
    sed 's#^\([^;{]*\s\|^\)D_____00_____\(\s\|$\)#\1DO\2#gi' |
    sed 's#^\([^;{]*\s\|^\)L_____00__________00_____P\(\s\|$\)#\1LOOP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ADDL_____00__________00_____P\(\s\|$\)#\1ADDLOOP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)PUSH_ADDL_____00__________00_____P(#\1PUSH_ADDLOOP(#gi'  > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done

# xloop
while :
do
    cat $TMPFILE > $TMPFILE3

# opravit ?do!!! questiondo !!!
# nefunguje pokud lezi "do" a "loop" na jinych radcich, a nejde to snadno spravit pres tr '\n' '\f' protoze pak zase nefunguje ^ a to se mlati s komentari a retezci...
    #           5  1 do ...         loop    -->      xdo(5,1) ...         xloop
    # SWAP_PUSH(5) 1 do ...         loop    --> swap xdo(5,1) ...         xloop
    #           5  1 do ... push_addloop(2) -->      xdo(5,1) ... push_addxloop(2)
    # SWAP_PUSH(5) 1 do ... push_addloop(2) --> swap xdo(5,1) ... push_addxloop(2)
    while :
    do
        cat $TMPFILE |
        sed -e '1h;2,$H;$!d;g' -e 's#\(\n[^;{]*\s\|\n\|^[\s]*\)\([-+]*[0-9]\+\)\s\+ADDLOOP\(\s\|\n\|$\)#\1PUSH_ADDLOOP(\2)\3#g' |
        sed -e '1h;2,$H;$!d;g' -e 's#\(\n[^;{]*\s\|\n\|^[\s]*\)\([-+]*[0-9]\+\)\s\+\([-+]*[0-9]\+\)\s\+DO\(\s\+[^oO]*\s\+\|\s\+\)LOOP\(\s\|$\)#\1XD_____00_____(\2,\3)\4XL_____00__________00_____P\5#g' |
        sed -e '1h;2,$H;$!d;g' -e 's#\(\n[^;{]*\s\|\n\|^[\s]*\)\([-+]*[0-9]\+\)\s\+\([-+]*[0-9]\+\)\s\+DO\(\s\+[^oO]*\s\+\|\s\+\)PUSH_ADDLOOP(#\1XD_____00_____(\2,\3)\4PUSH_ADDXL_____00__________00_____P(#g' > $TMPFILE2
        diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
        error=$?
        cat $TMPFILE2 > $TMPFILE
        [ $error -gt 1 ] && exit
        [ $error -eq 0 ] && break
    done

    cat $TMPFILE | sed 's#^\([^;{]*\s\|^\)DO\(\s\+[^oO]*\s\++*[Lo]\)OO\([Pp]\s\|$\)#\1D_____00_____\2_____00__________00_____\3#' > $TMPFILE2
    cat $TMPFILE2 > $TMPFILE

    diff $TMPFILE $TMPFILE3 > /dev/null 2>&1
    error=$?
    cat $TMPFILE > $TMPFILE3
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done

# optimize
while :
do
    cat $TMPFILE |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+\([+-]*[0-9]\+\)\(\s\|$\)#\1SWAP_PUSH(\2)\3#gi' > $TMPFILE2

    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


# xloop
while :
do
    cat $TMPFILE | sed 's#_____0_____#o#g' | sed 's#_____00_____#O#g' > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


# numbers
while :
do
    cat $TMPFILE | sed -e '1h;2,$H;$!d;g' -e 's#\(\n[^;{]*\s\|\n\|^[^;{]*\s\)\([-+]*[0-9]\+\)\s\+\([-+]*[0-9]\+\)\(\s\|$\|\n\)#\1PUSH2(\2,\3)\4#g' > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done

# numbers
while :
do
    cat $TMPFILE |
    sed 's#\(\s\+\)EQU\s\+\([-+]*[0-9]\+\)\(\s\|$\)#\1___EQU___\2___\3#g' |
    sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\(\s\|$\)#\1PUSH(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\.\(\s\|$\)#\1PUSHDOT(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([-+]*0[Xx][0-9a-fA-F]\+\)\.\(\s\|$\)#\1PUSHDOT(\2)\3#gi' |
    sed 's#\(\s\+\)___EQU___\([-+]*[0-9]\+\)___\(\s\|$\)#\1EQU\ \2\3#g' > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


# 0000000000xxx --> 'x'
NUM="0"
for x in $CHAR
do
    name="${x}"
    NUM="$(($NUM+1))"

    while :
    do
        cat $TMPFILE | sed "s${oddelovac}^\([^;{]*[(,]\)0000000000${NUM}\([,)]\)${oddelovac}\1${name}\2${oddelovac}g" > $TMPFILE2
        diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
        error=$?
        cat $TMPFILE2 > $TMPFILE
        [ $error -gt 1 ] && exit
        [ $error -eq 0 ] && break
    done
done


# 0000000000xxx --> name variable
for x in $VAR
do
    name=`printf "${x}" | sed 's#@#_load#g' | sed 's#!#_save#g' | sed 's#+#_p_#g' | sed 's#-#_m_#g' | sed 's#[^_a-zA-Z0-9]#_#g' | sed 's#^#_#g'`
    NUM="$(($NUM+1))"

    while :
    do
        cat $TMPFILE | sed "s${oddelovac}^\([^;{]*[(,]\)0000000000${NUM}\([,)]\)${oddelovac}\1${name}\2${oddelovac}g" > $TMPFILE2
        diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
        error=$?
        cat $TMPFILE2 > $TMPFILE
        [ $error -gt 1 ] && exit
        [ $error -eq 0 ] && break
    done
done


# word/function
FCE=""
FCE="$FCE `cat $TMPFILE | grep '^\([^;{]*\s\|^\)COLON(\([^)]\+\)).*' | sed 's#^\([^;{]*\s\|^\)COLON(\([^)]\+\)).*#\2#g'`"

for x in $FCE
do
    name=`printf "${x}" | sed 's#@#_load#g' | sed 's#!#_save#g' | sed 's#+#_p_#g' | sed 's#-#_m_#g' | sed 's#[^_a-zA-Z0-9]#_#g' | sed 's#^#_#g'`

    cat $TMPFILE | sed "s#^\([^;{]*\)(${x}\([,)]\)#\1(${name}\2#g" > $TMPFILE2
    cat $TMPFILE2 > $TMPFILE

    while :
    do
        cat $TMPFILE | sed "s#^\([^;{]*\s\|^\)${x}\(\s\|$\)#\1CALL(${name})\2#g" > $TMPFILE2
        diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
        error=$?
        cat $TMPFILE2 > $TMPFILE
        [ $error -gt 1 ] && exit
        [ $error -eq 0 ] && break
    done
done


# other
while :
do
    cat $TMPFILE |
# ___  --> space
    sed 's#^\([^;{]*\s\|^\)___\(.\+\)___EQU___\(.\+\)___#\1\2 EQU \3#g' > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


if [ -f ./FIRST.M4 ]
then
    DIR="./"
elif [ -f ./M4/FIRST.M4 ]
then
    DIR="./M4/"
elif [ -f ../M4/FIRST.M4 ]
then
    DIR="../M4/"
else
    DIR=" adds_the_path_to_the_file "
fi

printf "include(\`${DIR}FIRST.M4')dnl \n"

ORG=""
ORG="$ORG`cat $TMPFILE | grep '^ORG.*' | sed 's#^ORG.*#Yes#g'`"

if [ -z "${ORG}" ]
then
    printf "ORG 0x8000\n"
fi

INIT=""
INIT="$INIT`cat $TMPFILE | grep '^INIT.*' | sed 's#^INIT.*#Yes#g'`"

if [ -z "${INIT}" ]
then
    printf "INIT(60000)\n"
fi

STOP=""
STOP="$STOP`cat $TMPFILE | grep '^STOP.*' | sed 's#^STOP.*#Yes#g'`"

if [ -z "${STOP}" ]
then
    printf "...\nSTOP\n"
fi

cat $TMPFILE
printf "\ninclude({${DIR}LAST.M4})dnl\n"
