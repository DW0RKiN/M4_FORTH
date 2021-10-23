#!/bin/bash

# Protection against:    sed 's#^\([^;{]*\s\|^\)COLON(\([^_a-zA-Z[.ch.][.CH.]]\)#\1COLON(xxx_\2#gi'
# and then error messages for non-Czech settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

TMPFILE=$(mktemp)
TMPFILE2=$(mktemp)
TMPFILE3=$(mktemp)

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

# .( string) ... ." string" ... s" string"
while :
do
    cat $TMPFILE |
    # s" Hello Word" whitespace EOL
    sed -e 's#^\([^;{]*\s\|^\)[Ss]"\s\([^"]*\)"\(\s\+\|$\)$#\1STRING({"\2"})#' |
    # s" Hello Word" whitespace Other Words
    sed -e 's#^\([^;{]*\s\|^\)[Ss]"\s\([^"]*\)"\s\+\([^ 	].*\)$#\1STRING({"\2"})\n\3#' |
    # ." Hello Word" whitespace EOL
    sed -e 's#^\([^;{]*\s\|^\)\."\s\([^"]*\)"\(\s\+\|$\)$#\1PRINT({"\2"})#' |
    # ." Hello Word" whitespace Other Words
    sed -e 's#^\([^;{]*\s\|^\)\."\s\([^"]*\)"\s\+\([^ 	].*\)$#\1PRINT({"\2"})\n\3#' |
    # .( Hello Word) whitespace EOL
    sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*\))\(\s\+\|$\)$#\1PRINT({"\2"})#' |
    # .( Hel(lo) Word) whitespace EOL
    sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*([^()]*)[^()]*\))\(\s\+\|$\)$#\1PRINT({"\2"})#' |
    # .( Hello Word) whitespace Other Words
    sed -e 's#^\([^;{]*\s\|^\)\.(\s\([^()]*\))\s\+\([^ 	].*\)$#\1PRINT({"\2"})\n\3#' |
    # .( Hel(lo) Word) whitespace Other Words
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

    sed 's#^\([^;{]*\s\|^\)?\(\s\|$\)#\1!\ .\2#gi' |

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

    sed 's#^\([^;{]*\s\|^\)+!\(\s\|$\)#\1ADDSTORE\2#gi' |

    sed 's#^\([^;{]*\s\|^\)!\(\s\|$\)#\1STORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)TUCK\s\+STORE\(\s\|$\)#\1TUCK_STORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)TUCK_STORE\s\+_2ADD\(\s\|$\)#\1TUCK_STORE_2ADD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER_SWAP\s\+STORE\(\s\|$\)#\1OVER_SWAP_STORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP\s\+STORE\(\s\|$\)#\1_2DUP_STORE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2DUP_STORE\s\+2+\(\s\|$\)#\1_2DUP_STORE_2ADD\2#gi' |
    
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

    sed 's#^\([^;{]*\s\|^\)cr\(\s\|$\)#\1CR\2#gi' |
    sed 's#^\([^;{]*\s\|^\)\.s\(\s\|$\)#\1DOTS\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Tt]ype\(\s\|$\)#\1TYPE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ee]mit\(\s\|$\)#\1EMIT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Dd]up\s\+EMIT\(\s\|$\)#\1DUP_EMIT\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Ss]pace\(\s\|$\)#\1SPACE\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Kk]ey\(\s\|$\)#\1KEY\2#g' |
    sed 's#^\([^;{]*\s\|^\)[Aa]ccept\(\s\|$\)#\1ACCEPT\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Ss]wap\(\s\|$\)#\1SWAP\2#g' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+OVER\(\s\|$\)#\1SWAP_OVER\2#gi' |
    sed 's#^\([^;{]*\s\|^\)SWAP\s\+\([+-]*[0-9]\+\)\(\s\|$\)#\1SWAP_PUSH(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+SWAP\(\s\|$\)#\1PUSH_SWAP(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)2[Ss]wap\(\s\|$\)#\1_2SWAP\2#g' |

    sed 's#^\([^;{]*\s\|^\)?[Dd]up\(\s\|$\)#\1QUESTIONDUP\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Dd]up\(\s\|$\)#\1DUP\2#g' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+SWAP\(\s\|$\)#\1DUP_PUSH_SWAP(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)2[Dd]up\(\s\|$\)#\1_2DUP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)over\s\+over\(\s\|$\)#\1_2DUP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Dd]rop\(\s\|$\)#\1DROP\2#g' |
    sed 's#^\([^;{]*\s\|^\)2[Dd]rop\(\s\|$\)#\1_2DROP\2#g' |
    sed 's#^\([^;{]*\s\|^\)drop\s\+drop\(\s\|$\)#\1_2DROP\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Nn]ip\(\s\|$\)#\1NIP\2#g' |
    sed 's#^\([^;{]*\s\|^\)swap\s\+drop\(\s\|$\)#\1NIP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2[Nn]ip\(\s\|$\)#\1_2NIP\2#g' |
    sed 's#^\([^;{]*\s\|^\)_2SWAP\s\+_2DROP\(\s\|$\)#\1_2NIP\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Tt]uck\(\s\|$\)#\1TUCK\2#g' |
    sed 's#^\([^;{]*\s\|^\)swap\s\+over\(\s\|$\)#\1TUCK\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2[Tt]uck\(\s\|$\)#\1_2TUCK\2#g' |
    sed 's#^\([^;{]*\s\|^\)2swap\s\+2over\(\s\|$\)#\1_2TUCK\2#gi' |

    sed 's#^\([^;{]*\s\|^\)[Oo]ver\(\s\|$\)#\1OVER\2#g' |
    sed 's#^\([^;{]*\s\|^\)OVER\s\+SWAP\(\s\|$\)#\1OVER_SWAP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2[Oo]ver\(\s\|$\)#\1_2OVER\2#g' |

    sed 's#^\([^;{]*\s\|^\)[Rr]ot\(\s\|$\)#\1ROT\2#g' |
    sed 's#^\([^;{]*\s\|^\)ROT\s\+DROP\s\+SWAP\(\s\|$\)#\1NROT_NIP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ROT\s\+DROP\(\s\|$\)#\1ROT_DROP\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2[Rr]ot\(\s\|$\)#\1_2ROT\2#g' |
    sed 's#^\([^;{]*\s\|^\)-_2ROT\(\s\|$\)#\1N2ROT\2#g' |

    sed 's#^\([^;{]*\s\|^\)-[Rr]ot\(\s\|$\)#\1NROT\2#g' |
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
    sed 's#^\([^;{]*\s\|^\)+[Ll]oop\(\s\|$\)#\1ADDLOOP\2#g' |

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

    sed 's#^\([^;{]*\s\|^\)NROT\sSWAP\s_2SWAP\sSWAP\(\s\|$\)#\1STACK_BCAD\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER\s_2OVER\sDROP\(\s\|$\)#\1STACK_CBABC\2#gi' |
    sed 's#^\([^;{]*\s\|^\)_2OVER\sNIP\s_2OVER\sNIP\sSWAP\(\s\|$\)#\1STACK_CBABC\2#gi' |
    sed 's#^\([^;{]*\s\|^\)OVER\s3\sPICK\(\s\|$\)#\1STACK_CBABC\2#gi' |
    sed 's#^\([^;{]*\s\|^\)2\sPICK\s2\sPICK\sSWAP\(\s\|$\)#\1STACK_CBABC\2#gi' |

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
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+SUB\(\s\|$\)#\1PUSH_SUB(\2)\3#g' |

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

    sed 's#^\([^;{]*\s\|^\)DUP\s\+UNTIL\(\s\|$\)#\1DUP_UNTIL\2#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\([+-]*[0-9]\+\)\s\+EQ\s\+UNTIL\(\s\|$\)#\1DUP_PUSH_EQ_UNTIL(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+\(0x[0-9A-F]\+\)\s\+EQ\s\+UNTIL\(\s\|$\)#\1DUP_PUSH_EQ_UNTIL(\2)\3#gi' |
    sed 's#^\([^;{]*\s\|^\)DUP\s\+IF\(\s\|$\)#\1DUP_IF\2#gi' |

    sed 's#^\([^;{]*\s\|^\)eq\(\s\|$\)#\1EQ\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ne\(\s\|$\)#\1NE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)lt\(\s\|$\)#\1LT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)le\(\s\|$\)#\1LE\2#gi' |
    sed 's#^\([^;{]*\s\|^\)gt\(\s\|$\)#\1GT\2#gi' |
    sed 's#^\([^;{]*\s\|^\)ge\(\s\|$\)#\1GE\2#gi' |

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
    sed 's#^\([^;{]*\s\|^\)\([+-]*[0-9]\+\)\s\+OVER\(\s\|$\)#\1PUSH_OVER(\2)\3#gi' |
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

    # xloop
    while :
    do
        cat $TMPFILE |
        sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\s\+\([-+]*[0-9]\+\)\s\+DO\(\s\+[^oO]*\s\+\)LOOP\(\s\|$\)#\1XD_____00_____(\2,\3)\4XL_____00__________00_____P\5#g' |
        sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\s\+\([-+]*[0-9]\+\)\s\+DO\(\s\+[^oO]*\s\+\)PUSH_ADDLOOP(#\1XD_____00_____(\2,\3)\4PUSH_ADDXL_____00__________00_____P(#g' > $TMPFILE2
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
    cat $TMPFILE |
    sed 's#\(\s\+\)EQU\s\+\([-+]*[0-9]\+\)\(\s\|$\)#\1___EQU___\2___\3#g' |
    sed 's#^\([^;{]*\s\|^\)\([-+]*[0-9]\+\)\(\s\|$\)#\1PUSH(\2)\3#gi' |
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

printf "include(\`${DIR}FIRST.M4')dnl \nORG 0x8000\nINIT(60000)\n...\nSTOP\n"
cat $TMPFILE
printf "\ninclude({${DIR}LAST.M4})dnl\n"
