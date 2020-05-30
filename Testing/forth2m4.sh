#!/bin/bash

TMPFILE=$(mktemp)
TMPFILE2=$(mktemp)

cat $1 |  sed 's#\(\s\|^\);\(\s\|$\)#\1SEMICOLON\2#gi'| sed 's#\(\s\|^\)\\\(\s\|$\)#\1;\2#gi' > $TMPFILE

# ( comment) ... ( comment) ...
while :
do
    cat $TMPFILE | 
    sed -e 's#^\([^;{]*\s\|^\)(\(\s\+[^()]*\))\(\s\+\|$\)$#\1;(\2)#' |
    sed -e 's#^\([^;{]*\s\|^\)(\(\s\+[^()]*([^()]*)[^()]*\))\(\s\+\|$\)$#\1;(\2)#' |
    sed -e 's#^\([^;{]*\s\|^\)(\(\s\+[^()]*\))\s\+\([^ 	].*\)$#\1;(\2)\n\3#' |
    sed -e 's#^\([^;{]*\s\|^\)(\(\s\+[^()]*([^()]*)[^()]*\))\s\+\([^ 	].*\)$#\1;(\2)\n\3#' > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done

# .( string) ... .( string) ...
while :
do
    cat $TMPFILE | 
    sed -e 's#^\([^;{]*\s\|^\)\."\s\([^"]*\)"\(\s\+\|$\)$#\1PRINT({"\2"})#' |
    sed -e 's#^\([^;{]*\s\|^\)\."\s\([^"]*\)"\s\+\([^ 	].*\)$#\1PRINT({"\2"})\n\3#' |
    sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*\))\(\s\+\|$\)$#\1PRINT({"\2"})#' |
    sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*([^()]*)[^()]*\))\(\s\+\|$\)$#\1PRINT({"\2"})#' |
    sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*\))\s\+\([^ 	].*\)$#\1PRINT({"\2"})\n\3#' |
    sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*([^()]*)[^()]*\))\s\(\s*[^ 	].*\)$#\1PRINT({"\2"}) \3#' > $TMPFILE2
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


while :
do

cat $TMPFILE |

sed 's#^\([^;{]*\s\|^\):\s\+\([^ 	]\+\)\(\s\|$\)#\1\COLON(\2)\3#gi' |

sed 's#^\([^;{]*\s\|^\)1+\(\s\|$\)#\1_1ADD\2#gi' |
sed 's#^\([^;{]*\s\|^\)1-\(\s\|$\)#\1_1SUB\2#gi' |
sed 's#^\([^;{]*\s\|^\)2+\(\s\|$\)#\1_2ADD\2#gi' |
sed 's#^\([^;{]*\s\|^\)2-\(\s\|$\)#\1_2SUB\2#gi' |
sed 's#^\([^;{]*\s\|^\)2\*\(\s\|$\)#\1_2MUL\2#gi' |
sed 's#^\([^;{]*\s\|^\)2/\(\s\|$\)#\1_2DIV\2#gi' |
# 0 = --> 0=
sed 's#^\([^;{]*\s\|^\)0\s\+=\(\s\|$\)#\1_0EQ\2#gi' |
sed 's#^\([^;{]*\s\|^\)0=\(\s\|$\)#\1_0EQ\2#gi' |
# 0 < --> 0<
sed 's#^\([^;{]*\s\|^\)0\s\+<\(\s\|$\)#\1_0LT\2#gi' |
sed 's#^\([^;{]*\s\|^\)0<\(\s\|$\)#\1_0LT\2#gi' |
# 0 > --> 0>
sed 's#^\([^;{]*\s\|^\)0\s\+>=\(\s\|$\)#\1_0GE\2#gi' |
sed 's#^\([^;{]*\s\|^\)0>=\(\s\|$\)#\1_0GE\2#gi' |

sed 's#^\([^;{]*\s\|^\)d0=\(\s\|$\)#\1D0EQ\2#gi' |
sed 's#^\([^;{]*\s\|^\)D0=\(\s\|$\)#\1D0EQ\2#gi' |
sed 's#^\([^;{]*\s\|^\)0\s\+0\s\+=\(\s\|$\)#\1D0EQ\2#gi' |

sed 's#^\([^;{]*\s\|^\)pick\(\s\|$\)#\1PICK\2#gi' |
sed 's#^\([^;{]*\s\|^\)0\s\+PICK\(\s\|$\)#\1_0_PICK\2#gi' |
sed 's#^\([^;{]*\s\|^\)1\s\+PICK\(\s\|$\)#\1_1_PICK\2#gi' |
sed 's#^\([^;{]*\s\|^\)2\s\+PICK\(\s\|$\)#\1_2_PICK\2#gi' |
sed 's#^\([^;{]*\s\|^\)3\s\+PICK\(\s\|$\)#\1_3_PICK\2#gi' |

sed 's#^\([^;{]*\s\|^\)@\(\s\|$\)#\1FETCH\2#gi' |

sed 's#^\([^;{]*\s\|^\)>r\(\s\|$\)#\1TO_R\2#gi' |
sed 's#^\([^;{]*\s\|^\)r>\(\s\|$\)#\1R_FROM\2#gi' |
sed 's#^\([^;{]*\s\|^\)r@\(\s\|$\)#\1R_FETCH\2#gi' |

sed 's#^\([^;{]*\s\|^\)\*\(\s\|$\)#\1\MUL\2#gi' |
sed 's#^\([^;{]*\s\|^\)\(mod\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)/mod\(\s\|$\)#\1\DIVMOD\2#gi' |
sed 's#^\([^;{]*\s\|^\)/\(\s\|$\)#\1DIV\2#gi' |

sed 's#^\([^;{]*\s\|^\)\(umod\)\(\s\|$\)#\1\U\2\3#gi' |
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

sed 's#^\([^;{]*\s\|^\)u>=\(\s\|$\)#\1UGE\2#gi' |
sed 's#^\([^;{]*\s\|^\)u<=\(\s\|$\)#\1ULE\2#gi' |
sed 's#^\([^;{]*\s\|^\)u>\(\s\|$\)#\1UGT\2#gi' |
sed 's#^\([^;{]*\s\|^\)u<\(\s\|$\)#\1ULT\2#gi' |

sed 's#^\([^;{]*\s\|^\)\(rshift\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(lshift\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)>>\(\s\|$\)#\1RSHIFT\2#gi' |
sed 's#^\([^;{]*\s\|^\)<<\(\s\|$\)#\1LSHIFT\2#gi' |

sed 's#^\([^;{]*\s\|^\)\.\(\s\|$\)#\1DOT\2#gi' |
sed 's#^\([^;{]*\s\|^\)u\.\(\s\|$\)#\1UDOT\2#gi' |

sed 's#^\([^;{]*\s\|^\)+!\(\s\|$\)#\1PLUS_STORE\2#gi' |
sed 's#^\([^;{]*\s\|^\)!\(\s\|$\)#\1STORE\2#gi' |
sed 's#^\([^;{]*\s\|^\)cr\(\s\|$\)#\1CR\2#gi' |
sed 's#^\([^;{]*\s\|^\)2dup\(\s\|$\)#\1_2DUP\2#gi' |
sed 's#^\([^;{]*\s\|^\)2drop\(\s\|$\)#\1_2DROP\2#gi' |
sed 's#^\([^;{]*\s\|^\)\.s\(\s\|$\)#\1DOTS\2#gi' |

sed 's#^\([^;{]*\s\|^\)\(type\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(emit\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(key\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(tuck\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(over\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)2\(over\)\(\s\|$\)#\1_2\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(nip\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(swap\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)2\(swap\)\(\s\|$\)#\1_2\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(rot\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)-\(rot\)\(\s\|$\)#\1R\U\2\3#gi' |

sed 's#^\([^;{]*\s\|^\)\(dup\)\(\s\|$\)#\1\U\2\3#gi' |

sed 's#^\([^;{]*\s\|^\)\(do\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(loop\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(if\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(else\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(then\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(begin\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(while\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(repeat\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(until\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(again\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(i\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(j\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(k\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(unloop\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(constant\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(variable\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)VARIABLE\s\+\([^ 	]\+\)\(\s\|$\)#\1VARIABLE(\2)\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(exit\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(false\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(true\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(invert\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(abs\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(xor\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(or\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(and\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(negate\)\(\s\|$\)#\1\U\2\3#gi' |
sed 's#^\([^;{]*\s\|^\)\(drop\)\(\s\|$\)#\1\U\2\3#gi' |

sed 's#^\([^;{]*\s\|^\)1\s\+SUB\(\s\|$\)#\1_1SUB\2#gi' |
sed 's#^\([^;{]*\s\|^\)2\s\+SUB\(\s\|$\)#\1_2SUB\2#gi' |
sed 's#^\([^;{]*\s\|^\)1\s\+ADD\(\s\|$\)#\1_1ADD\2#gi' |
sed 's#^\([^;{]*\s\|^\)2\s\+ADD\(\s\|$\)#\1_2ADD\2#gi' |

# optimize

sed 's#^\([^;{]*\s\|^\)DUP\s\+IF\(\s\|$\)#\1DUP_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_0EQ\s\+IF\(\s\|$\)#\1_0EQ_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+_0EQ_IF\(\s\|$\)#\1DUP_0EQ_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)D0EQ\s\+IF\(\s\|$\)#\1D0EQ_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+D0EQ_IF\(\s\|$\)#\1_2DUP_D0EQ_IF\2#gi' |

sed 's#^\([^;{]*\s\|^\)DUP\sWHILE\(\s\|$\)#\1DUP_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\sUDOT\(\s\|$\)#\1DUP_UDOT\2#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\sDOT\(\s\|$\)#\1DUP_DOT\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\sTYPE\(\s\|$\)#\1_2DUP_TYPE\2#gi' |

sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULT\s\+IF\(\s\|$\)#\1_2DUP_ULT_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULE\s\+IF\(\s\|$\)#\1_2DUP_ULE_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGT\s\+IF\(\s\|$\)#\1_2DUP_UGT_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGE\s\+IF\(\s\|$\)#\1_2DUP_UGE_IF\2#gi' |

sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+EMIT\(\s\|$\)#\1PUTCHAR(\2)\3#gi' |

sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+LT\s\+IF\(\s\|$\)#\1DUP_PUSH_LT_IF(\2)\3#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+LE\s\+IF\(\s\|$\)#\1DUP_PUSH_LE_IF(\2)\3#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+GT\s\+IF\(\s\|$\)#\1DUP_PUSH_GT_IF(\2)\3#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+GE\s\+IF\(\s\|$\)#\1DUP_PUSH_GE_IF(\2)\3#gi' |

sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+ULT\s\+IF\(\s\|$\)#\1DUP_PUSH_ULT_IF(\2)\3#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+ULE\s\+IF\(\s\|$\)#\1DUP_PUSH_ULE_IF(\2)\3#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UGT\s\+IF\(\s\|$\)#\1DUP_PUSH_UGT_IF(\2)\3#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+UGE\s\+IF\(\s\|$\)#\1DUP_PUSH_UGE_IF(\2)\3#gi' |

sed 's#^\([^;{]*\s\|^\)DROP\s\+\([-+]*[0-9]\+\)\(\s\|$\)#\1DROP_PUSH(\2)\3#gi' |
sed 's#^\([^;{]*\s\|^\)_2DROP\s\+\([-+]*[0-9]\+\)\(\s\|$\)#\1_2DROP_PUSH(\2)\3#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+\([-+]*[0-9]\+\)\(\s\|$\)#\1DUP_PUSH(\2)\3#gi' |

sed 's#^\([^;{]*\s\|^\)\([+]*[0-9]\+\)\s\+MUL\(\s\|$\)#\1PUSH_MUL(\2)\3#gi' > $TMPFILE2

    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


# numbers
while :
do
    cat $TMPFILE | sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\s\+\([-+]*[0-9]\+\)\(\s\|$\)#\1PUSH2(\2,\3)\4#gi' > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done

# numbers
while :
do
    cat $TMPFILE | sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\(\s\|$\)#\1PUSH(\2)\3#gi' > $TMPFILE2
    diff $TMPFILE $TMPFILE2 > /dev/null 2>&1
    error=$?
    cat $TMPFILE2 > $TMPFILE
    [ $error -gt 1 ] && exit
    [ $error -eq 0 ] && break
done


# unknown --> name function
while :
do
    cat $TMPFILE |
# rename badname --> _badname
    sed 's#^\([^;{]*\s\|^\)CALL(\([^_a-zA-Z]\)#\1CALL(_\2#gi' |
    sed 's#^\([^;{]*\s\|^\)COLON(\([^_a-zA-Z]\)#\1COLON(_\2#gi' |
# call
    sed 's#^\([^;{]*\s\|^\)\([0-9a-z]\+[^ 	]*\)\(\s\|$\)#\1CALL(\2)\3#g' > $TMPFILE2
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
    
printf "include(\`${DIR}FIRST.M4')dnl \nORG 0x8000\nINIT(60000)\n...\nSTOP\n"
cat $TMPFILE
printf "\ninclude({${DIR}LAST.M4})dnl\n"
