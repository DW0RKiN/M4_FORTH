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
sed 's#^\([^;{]*\s\|^\)\([+]*[0-9][0-9]*\)\s\+PICK\(\s\|$\)#\1PUSH_PICK(\2)\3#gi' |

sed 's#^\([^;{]*\s\|^\)@\(\s\|$\)#\1FETCH\2#gi' |

sed 's#^\([^;{]*\s\|^\)>r\(\s\|$\)#\1TO_R\2#gi' |
sed 's#^\([^;{]*\s\|^\)r>\(\s\|$\)#\1R_FROM\2#gi' |
sed 's#^\([^;{]*\s\|^\)r@\(\s\|$\)#\1R_FETCH\2#gi' |

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

sed 's#^\([^;{]*\s\|^\)u>=\(\s\|$\)#\1UGE\2#gi' |
sed 's#^\([^;{]*\s\|^\)u<=\(\s\|$\)#\1ULE\2#gi' |
sed 's#^\([^;{]*\s\|^\)u>\(\s\|$\)#\1UGT\2#gi' |
sed 's#^\([^;{]*\s\|^\)u<\(\s\|$\)#\1ULT\2#gi' |

sed 's#^\([^;{]*\s\|^\)[Rr][Ss]hift\(\s\|$\)#\1RSHIFT\2#g' |
sed 's#^\([^;{]*\s\|^\)[Ll][Ss]hift\(\s\|$\)#\1LSHIFT\2#g' |
sed 's#^\([^;{]*\s\|^\)>>\(\s\|$\)#\1RSHIFT\2#gi' |
sed 's#^\([^;{]*\s\|^\)<<\(\s\|$\)#\1LSHIFT\2#gi' |

sed 's#^\([^;{]*\s\|^\)\.\(\s\|$\)#\1DOT\2#gi' |
sed 's#^\([^;{]*\s\|^\)u\.\(\s\|$\)#\1UDOT\2#gi' |

sed 's#^\([^;{]*\s\|^\)+!\(\s\|$\)#\1PLUS_STORE\2#gi' |
sed 's#^\([^;{]*\s\|^\)!\(\s\|$\)#\1STORE\2#gi' |
sed 's#^\([^;{]*\s\|^\)cr\(\s\|$\)#\1CR\2#gi' |
sed 's#^\([^;{]*\s\|^\)2dup\(\s\|$\)#\1_2DUP\2#gi' |
sed 's#^\([^;{]*\s\|^\)2drop\(\s\|$\)#\1_2DROP\2#gi' |
sed 's#^\([^;{]*\s\|^\)[Rr]drop\(\s\|$\)#\1RDROP\2#g' |
sed 's#^\([^;{]*\s\|^\)\.s\(\s\|$\)#\1DOTS\2#gi' |

sed 's#^\([^;{]*\s\|^\)cell\(\s\|$\)#\12\2#gi' |
sed 's#^\([^;{]*\s\|^\)cell+\(\s\|$\)#\1_2ADD\2#gi' |
sed 's#^\([^;{]*\s\|^\)cell-\(\s\|$\)#\1_2SUB\2#gi' |
sed 's#^\([^;{]*\s\|^\)cells\(\s\|$\)#\1_2MUL\2#gi' |

sed 's#^\([^;{]*\s\|^\)[Tt]ype\(\s\|$\)#\1TYPE\2#g' |
sed 's#^\([^;{]*\s\|^\)[Ee]mit\(\s\|$\)#\1EMIT\2#g' |
sed 's#^\([^;{]*\s\|^\)[Kk]ey\(\s\|$\)#\1KEY\2#g' |
sed 's#^\([^;{]*\s\|^\)[Oo]ver\(\s\|$\)#\1OVER\2#g' |
sed 's#^\([^;{]*\s\|^\)2[Oo]ver\(\s\|$\)#\1_2OVER\2#g' |
sed 's#^\([^;{]*\s\|^\)[Nn]ip\(\s\|$\)#\1NIP\2#g' |
sed 's#^\([^;{]*\s\|^\)2[Nn]ip\(\s\|$\)#\1_2NIP\2#g' |
sed 's#^\([^;{]*\s\|^\)[Tt]uck\(\s\|$\)#\1TUCK\2#g' |
sed 's#^\([^;{]*\s\|^\)2[Tt]uck\(\s\|$\)#\1_2TUCK\2#g' |
sed 's#^\([^;{]*\s\|^\)[Ss]wap\(\s\|$\)#\1SWAP\2#g' |
sed 's#^\([^;{]*\s\|^\)2[Ss]wap\(\s\|$\)#\1_2SWAP\2#g' |
sed 's#^\([^;{]*\s\|^\)[Rr]ot\(\s\|$\)#\1ROT\2#g' |
sed 's#^\([^;{]*\s\|^\)2[Rr]ot\(\s\|$\)#\1_2ROT\2#g' |
sed 's#^\([^;{]*\s\|^\)-[Rr]ot\(\s\|$\)#\1RROT\2#g' |

sed 's#^\([^;{]*\s\|^\)[Mm]ove\(\s\|$\)#\1_2MUL CMOVE\2#g' |
sed 's#^\([^;{]*\s\|^\)[Cc][Mm]ove\(\s\|$\)#\1CMOVE\2#g' |

sed 's#^\([^;{]*\s\|^\)[Dd]up\(\s\|$\)#\1DUP\2#g' |

sed 's#^\([^;{]*\s\|^\)[Dd]o\(\s\|$\)#\1DO\2#g' |
sed 's#^\([^;{]*\s\|^\)[Ll]oop\(\s\|$\)#\1LOOP\2#g' |
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
sed 's#^\([^;{]*\s\|^\)[Cc]onstant\(\s\|$\)#\1CONSTANT\2#g' |
sed 's#^\([^;{]*\s\|^\)[Vv]ariable\(\s\|$\)#\1VARIABLE\2#g' |
sed 's#^\([^;{]*\s\|^\)VARIABLE\s\+\([^ 	]\+\)\(\s\|$\)#\1VARIABLE(\2)\3#g' |
sed 's#^\([^;{]*\s\|^\)[Ee]xit\(\s\|$\)#\1EXIT\2#g' |
sed 's#^\([^;{]*\s\|^\)[Ff]alse\(\s\|$\)#\1FALSE\2#g' |
sed 's#^\([^;{]*\s\|^\)[Tt]rue\(\s\|$\)#\1TRUE\2#g' |
sed 's#^\([^;{]*\s\|^\)[Ii]nvert\(\s\|$\)#\1INVERT\2#g' |
sed 's#^\([^;{]*\s\|^\)[Aa]bs\(\s\|$\)#\1ABS\2#g' |
sed 's#^\([^;{]*\s\|^\)[Xx]or\(\s\|$\)#\1XOR\2#g' |
sed 's#^\([^;{]*\s\|^\)[Oo]r\(\s\|$\)#\1OR\2#g' |
sed 's#^\([^;{]*\s\|^\)[Aa]nd\(\s\|$\)#\1AND\2#g' |
sed 's#^\([^;{]*\s\|^\)[Nn]egate\(\s\|$\)#\1NEGATE\2#g' |
sed 's#^\([^;{]*\s\|^\)[Dd]rop\(\s\|$\)#\1DROP\2#g' |
sed 's#^\([^;{]*\s\|^\)[Ll]eave\(\s\|$\)#\1LEAVE\2#g' |

sed 's#^\([^;{]*\s\|^\)1\s\+SUB\(\s\|$\)#\1_1SUB\2#gi' |
sed 's#^\([^;{]*\s\|^\)2\s\+SUB\(\s\|$\)#\1_2SUB\2#gi' |
sed 's#^\([^;{]*\s\|^\)1\s\+ADD\(\s\|$\)#\1_1ADD\2#gi' |
sed 's#^\([^;{]*\s\|^\)2\s\+ADD\(\s\|$\)#\1_2ADD\2#gi' |

# optimize

sed 's#^\([^;{]*\s\|^\)DUP\s\+UNTIL\(\s\|$\)#\1DUP_UNTIL\2#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+IF\(\s\|$\)#\1DUP_IF\2#gi' |

sed 's#^\([^;{]*\s\|^\)_0EQ\s\+IF\(\s\|$\)#\1_0EQ_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+_0EQ_IF\(\s\|$\)#\1DUP_0EQ_IF\2#gi' |

sed 's#^\([^;{]*\s\|^\)_0LT\s\+IF\(\s\|$\)#\1_0LT_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+_0LT_IF\(\s\|$\)#\1DUP_0LT_IF\2#gi' |

sed 's#^\([^;{]*\s\|^\)_0GE\s\+IF\(\s\|$\)#\1_0GE_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\s\+_0GE_IF\(\s\|$\)#\1DUP_0GE_IF\2#gi' |

sed 's#^\([^;{]*\s\|^\)D0EQ\s\+IF\(\s\|$\)#\1D0EQ_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+D0EQ_IF\(\s\|$\)#\1_2DUP_D0EQ_IF\2#gi' |

sed 's#^\([^;{]*\s\|^\)DUP\sWHILE\(\s\|$\)#\1DUP_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\sUDOT\(\s\|$\)#\1DUP_UDOT\2#gi' |
sed 's#^\([^;{]*\s\|^\)DUP\sDOT\(\s\|$\)#\1DUP_DOT\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\sTYPE\(\s\|$\)#\1_2DUP_TYPE\2#gi' |

sed 's#^\([^;{]*\s\|^\)_2DUP\s\+EQ\s\+IF\(\s\|$\)#\1_2DUP_EQ_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+NE\s\+IF\(\s\|$\)#\1_2DUP_NE_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+LT\s\+IF\(\s\|$\)#\1_2DUP_LT_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+LE\s\+IF\(\s\|$\)#\1_2DUP_LE_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+GT\s\+IF\(\s\|$\)#\1_2DUP_GT_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+GE\s\+IF\(\s\|$\)#\1_2DUP_GE_IF\2#gi' |

sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UEQ\s\+IF\(\s\|$\)#\1_2DUP_UEQ_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UNE\s\+IF\(\s\|$\)#\1_2DUP_UNE_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULT\s\+IF\(\s\|$\)#\1_2DUP_ULT_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULE\s\+IF\(\s\|$\)#\1_2DUP_ULE_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGT\s\+IF\(\s\|$\)#\1_2DUP_UGT_IF\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGE\s\+IF\(\s\|$\)#\1_2DUP_UGE_IF\2#gi' |

sed 's#^\([^;{]*\s\|^\)_2DUP\s\+EQ\s\+WHILE\(\s\|$\)#\1_2DUP_EQ_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+NE\s\+WHILE\(\s\|$\)#\1_2DUP_NE_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+LT\s\+WHILE\(\s\|$\)#\1_2DUP_LT_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+LE\s\+WHILE\(\s\|$\)#\1_2DUP_LE_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+GT\s\+WHILE\(\s\|$\)#\1_2DUP_GT_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+GE\s\+WHILE\(\s\|$\)#\1_2DUP_GE_WHILE\2#gi' |

sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UEQ\s\+WHILE\(\s\|$\)#\1_2DUP_UEQ_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UNE\s\+WHILE\(\s\|$\)#\1_2DUP_UNE_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULT\s\+WHILE\(\s\|$\)#\1_2DUP_ULT_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+ULE\s\+WHILE\(\s\|$\)#\1_2DUP_ULE_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGT\s\+WHILE\(\s\|$\)#\1_2DUP_UGT_WHILE\2#gi' |
sed 's#^\([^;{]*\s\|^\)_2DUP\s\+UGE\s\+WHILE\(\s\|$\)#\1_2DUP_UGE_WHILE\2#gi' |

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
