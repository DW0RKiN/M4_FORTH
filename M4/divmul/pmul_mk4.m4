dnl ## constant multiplication, variant 4
define({__},{})dnl
dnl
dnl
dnl
define({MK4_TOKENS_HL_ADD_BC_MUL},{dnl
dnl
__{}define({_TOKEN_PUSH},{dnl
__{}__{}define({_COST},{0})dnl
__{}__{}define({XMUL_SUM},{1})dnl
__{}__{}define({XMUL_A_SUM},{0})dnl
__{}__{}define({XMUL_RESULT},{0})dnl
__{}__{}ifelse(eval(HI_BIT($1)<($1)),{1},{dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    ld    B{,} H          ; 1:4       $1 *
__{}__{}    ld    C{,} L          ; 1:4       $1 *   1       1x = base})}){}dnl
dnl
__{}define({_TOKEN_CHECK},{dnl
__{}__{}ifelse(eval(XMUL_RESULT!=$1),{1},{
__{}__{}__{}.error Error in mk4 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
__{}__{}})})dnl
dnl
__{}define({_TOKEN_ASAVE},{dnl
__{}__{}ifelse(eval(XMUL_A_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_A_SUM},XMUL_SUM)dnl
__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *       L = XMUL_A_SUM{}x{}dnl
__{}__{}},eval(XMUL_A_SUM>0),{1},{dnl
__{}__{}__{}define({XMUL_A_SUM},eval(XMUL_A_SUM+XMUL_SUM))dnl
__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}    add   A{,} L          ; 1:4       $1 *      +L = XMUL_A_SUM{}x})}){}dnl
dnl
__{}define({_TOKEN_2X},{dnl
__{}__{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
__{}__{}_ADD_COST(1+256*11)
__{}__{}    add  HL{,} HL         ; 1:11      $1 *   0  *2 = XMUL_SUM{}x}){}dnl
dnl
__{}define({_TOKEN_2X_SAVE},{dnl
__{}__{}_ADD_COST(2+256*22)
__{}__{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
__{}__{}    add  HL{,} HL         ; 1:11      $1 *   1  *2 = XMUL_SUM{}x
__{}__{}define({XMUL_SUM},eval(1+XMUL_SUM))dnl
__{}__{}    add  HL{,} BC         ; 1:11      $1 *      +1 = XMUL_SUM{}x}){}dnl
dnl
__{}define({_TOKEN_2X_ASAVE_SAVE},{dnl
__{}__{}_ADD_COST(1+256*11)
__{}__{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
__{}__{}    add  HL{,} HL         ; 1:11      $1 *   1  *2 = XMUL_SUM{}x{}dnl
__{}__{}ifelse(eval(XMUL_A_SUM==0),{1},{dnl
__{}__{}__{}define({XMUL_A_SUM},eval(XMUL_SUM))dnl
__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}    ld    A{,} L          ; 1:4       $1 *      +L = XMUL_A_SUM{}x{}dnl
__{}__{}},eval(XMUL_A_SUM>0),{1},{dnl
__{}__{}__{}define({XMUL_A_SUM},eval(XMUL_A_SUM+XMUL_SUM))dnl
__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}    add   A{,} L          ; 1:4       $1 *      +L = XMUL_A_SUM{}x}){}dnl
__{}__{}define({XMUL_SUM},eval(1+XMUL_SUM))dnl
__{}__{}_ADD_COST(1+256*11)
__{}__{}    add  HL{,} BC         ; 1:11      $1 *      +1 = XMUL_SUM{}x}){}dnl
dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_SUM+256*XMUL_A_SUM)){}dnl
__{}__{}ifelse(eval(XMUL_A_SUM>0),{1},{dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    add   A{,} H          ; 1:4       $1 *
__{}__{}    ld    H{,} A          ; 1:4       $1 *     [XMUL_RESULT{}x] = XMUL_SUM{}x + 256*XMUL_A_SUM{}x})})dnl
})dnl
dnl
dnl
dnl
define({MK4_TOKENS_A_ADD_L_MUL},{dnl
dnl
__{}define({_TOKEN_PUSH},{dnl
__{}__{}define({_COST},{0})dnl
__{}__{}define({XMUL_SUM},{1})dnl
__{}__{}define({XMUL_RESULT},{0})dnl
__{}__{}_ADD_COST(1+256*4)
__{}__{}    ld    A{,} L          ; 1:4       $1 *   1       XMUL_SUM{x}}){}dnl
dnl
__{}define({_TOKEN_CHECK},{dnl
__{}__{}ifelse(eval(XMUL_RESULT!=$1),{1},{
__{}__{}__{}.error Error in mk4 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
__{}__{}})})dnl
dnl
__{}define({_TOKEN_2X},{dnl
__{}__{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
__{}__{}_ADD_COST(1+256*4)
__{}__{}    add   A{,} A          ; 1:4       $1 *   0  *2 = XMUL_SUM{}x}){}dnl
dnl
__{}define({_TOKEN_2X_SAVE},{dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
__{}__{}    add   A{,} A          ; 1:4       $1 *   1  *2 = XMUL_SUM{}x
__{}__{}define({XMUL_SUM},eval(1+XMUL_SUM))dnl
__{}__{}    add   A{,} L          ; 1:4       $1 *      +1 = XMUL_SUM{}x}){}dnl
dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(256*XMUL_SUM)){}dnl
__{}__{}_ADD_COST(3+256*11)
__{}__{}    ld    L{,} 0x00       ; 2:7       $1 *
__{}__{}    ld    H{,} A          ; 1:4       $1 *     [XMUL_RESULT{}x] = 256 * XMUL_SUM{}x})dnl
})dnl
dnl
dnl
dnl
define({MK4_TOKENS_A_ADD_C_MUL},{dnl
dnl
__{}define({_TOKEN_PUSH},{dnl
dnl      #define({_COST},{0})dnl
__{}__{}define({XMUL_SUM},{1})dnl
__{}__{}define({XMUL_RESULT},{0})dnl
__{}__{}_ADD_COST(1+256*4)
__{}__{}    ld    A{,} C          ; 1:4       $1 *   1       XMUL_SUM{}x}){}dnl
dnl
__{}define({_TOKEN_CHECK},{dnl
__{}__{}ifelse(eval(XMUL_RESULT!=$1),{1},{
__{}__{}__{}.error Error in mk4 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
__{}__{}})})dnl
dnl
__{}define({_TOKEN_2X},{dnl
__{}__{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
__{}__{}_ADD_COST(1+256*4)
__{}__{}    add   A{,} A          ; 1:4       $1 *   0  *2 = XMUL_SUM{}x}){}dnl
dnl
__{}define({_TOKEN_2X_SAVE},{dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
__{}__{}    add   A{,} A          ; 1:4       $1 *   1  *2 = XMUL_SUM{}x
__{}__{}define({XMUL_SUM},eval(1+XMUL_SUM))dnl
__{}__{}    add   A{,} C          ; 1:4       $1 *      +1 = XMUL_SUM{}x}){}dnl
dnl
__{}define({_TOKEN_END},{dnl redefine _token_end
__{}__{}define({XMUL_RESULT},eval(256*XMUL_SUM+XMUL_LO)){}dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    add   A{,} H          ; 1:4       $1 *
__{}__{}    ld    H{,} A          ; 1:4       $1 *     [XMUL_RESULT{}x] = 256 * XMUL_SUM{}x + XMUL_LO{}x})dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK4_LOOP},{dnl
__{}ifelse(eval(($1)>1),{1},{dnl
__{}__{}ifelse(eval(XMUL_HI>=($1)),{1},{dnl
__{}__{}__{}define({XMUL_HI},eval(XMUL_HI-($1))){}dnl
__{}__{}__{}_PUSH_OUTPUT({_TOKEN_ASAVE() })dnl
__{}__{}__{}ifelse(eval(XMUL_HI>=($1)),{1},{dnl
__{}__{}__{}__{}define({XMUL_HI},eval(XMUL_HI-($1))){}dnl
__{}__{}__{}__{}_PUSH_OUTPUT({_TOKEN_ASAVE() })dnl
__{}__{}__{}})dnl
__{}__{}})dnl
__{}__{}ifelse(eval((XMUL_HI > 0) && (($1 & 1) == 1) && (XMUL_HI>=($1 - 1))),{1},{dnl
__{}__{}__{}define({XMUL_HI},eval(XMUL_HI-($1-1))){}dnl
__{}__{}__{}_PUSH_OUTPUT({_TOKEN_2X_ASAVE_SAVE() }){}dnl
__{}__{}},eval($1 & 1),{1},{dnl
__{}__{}__{}_PUSH_OUTPUT({_TOKEN_2X_SAVE() }){}dnl
__{}__{}},{dnl
__{}__{}__{}_PUSH_OUTPUT({_TOKEN_2X() }){}dnl
__{}__{}})dnl
__{}__{}PUSH_MUL_MK4_LOOP(eval(($1)/2))dnl
__{}},eval(($1)>0),{1},{dnl
__{}__{}ifelse(eval(XMUL_HI>=($1)),{1},{dnl
__{}__{}__{}define({XMUL_HI},eval(XMUL_HI-($1))){}dnl
__{}__{}__{}_PUSH_OUTPUT({_TOKEN_ASAVE() })}){}dnl
__{}})dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK4_CREATE_TOKENS},{dnl
__{}undefine({_TOKEN_2X})dnl
__{}undefine({_TOKEN_2X_SAVE})dnl
__{}undefine({_TOKEN_2X_ASAVE_SAVE})dnl
__{}undefine({_TOKEN_ASAVE})dnl
__{}undefine({_TOKEN_PUSH})dnl
__{}undefine({_TOKEN_END})dnl
__{}undefine({_TOKEN_CHECK})dnl
__{}define({_OUTPUT},{_TOKEN_END() _TOKEN_CHECK()})dnl
__{}PUSH_MUL_MK4_LOOP($1)dnl
__{}_PUSH_OUTPUT({_TOKEN_PUSH() })dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK4},{ifelse(eval((($1) & 0xffff)==0),{1},{dnl
__{}define({PUSH_MUL_MK4_OUT},{
__{}__{}ld   HL{,} 0x0000     ; 3:10      $1 *})dnl
__{}define({PUSH_MUL_MK4_COST},{3+256*10})dnl
__{}define({PUSH_MUL_MK4_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk4: HL * 0})})dnl
},{dnl
__{}define({XMUL_HI},{0})dnl
__{}PUSH_MUL_MK4_CREATE_TOKENS($1)dnl
__{}MK4_TOKENS_HL_ADD_BC_MUL($1){}dnl
__{}define({PUSH_MUL_MK4_OUT},_OUTPUT)dnl
__{}define({PUSH_MUL_MK4_COST},_COST)dnl
__{}define({PUSH_MUL_MK4_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk4: ...(((HL*2^a)+HL)*2^b)+...})})dnl
dnl
__{}define({XMUL_HI},eval(($1)/256))dnl
__{}define({XMUL_LO},eval(($1) & 0xff))dnl
dnl
__{}ifelse(eval(XMUL_HI>0),{1},{dnl
__{}__{}ifelse(eval(XMUL_LO==0),{1},{dnl
__{}__{}__{}define({XMUL_LO},XMUL_HI)dnl
__{}__{}__{}define({XMUL_HI},{0})dnl
__{}__{}__{}PUSH_MUL_MK4_CREATE_TOKENS(XMUL_LO)dnl
__{}__{}__{}MK4_TOKENS_A_ADD_L_MUL($1){}dnl
__{}__{}__{}define({PUSH_MUL_MK4_TEMP},_OUTPUT)dnl
__{}__{}__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(_COST,PUSH_MUL_MK4_COST),{1},{dnl
__{}__{}__{}__{}define({PUSH_MUL_MK4_OUT},{PUSH_MUL_MK4_TEMP})dnl
__{}__{}__{}__{}define({PUSH_MUL_MK4_COST},_COST)dnl
__{}__{}__{}__{}define({PUSH_MUL_MK4_INFO},{
__{}__{}__{}__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk4: 256*...(((L*2^a)+L)*2^b)+...})})dnl
__{}__{}__{}})dnl
__{}__{}},XMUL_LO,{1},{dnl
__{}__{}__{}define({XMUL_LO},XMUL_HI)dnl
__{}__{}__{}define({XMUL_HI},{0})dnl
__{}__{}__{}PUSH_MUL_MK4_CREATE_TOKENS(XMUL_LO)dnl
__{}__{}__{}MK4_TOKENS_A_ADD_L_MUL($1){}dnl
__{}__{}__{}define({_TOKEN_END},{dnl redefine _token_end
__{}__{}__{}__{}define({XMUL_RESULT},eval(256*XMUL_SUM+1)){}dnl
__{}__{}__{}__{}_ADD_COST(2+256*8)
__{}__{}__{}__{}    add   A{,} H          ; 1:4       $1 *
__{}__{}__{}__{}    ld    H{,} A          ; 1:4       $1 *     [XMUL_RESULT{}x] = 256 * XMUL_SUM{}x + 1x})dnl
__{}__{}__{}define({PUSH_MUL_MK4_TEMP},_OUTPUT)dnl
__{}__{}__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(_COST,PUSH_MUL_MK4_COST),{1},{dnl
__{}__{}__{}__{}define({PUSH_MUL_MK4_OUT},{PUSH_MUL_MK4_TEMP})dnl
__{}__{}__{}__{}define({PUSH_MUL_MK4_COST},_COST)dnl
__{}__{}__{}__{}define({PUSH_MUL_MK4_INFO},{
__{}__{}__{}__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk4: 256*...(((L*2^a)+L)*2^b)+...+HL})})dnl
__{}__{}__{}})dnl
__{}__{}},{dnl
__{}__{}__{}PUSH_MUL_MK4_CREATE_TOKENS(XMUL_LO)dnl
__{}__{}__{}ifelse(eval(XMUL_HI==0),{1},{dnl
__{}__{}__{}__{}MK4_TOKENS_HL_ADD_BC_MUL($1){}dnl
__{}__{}__{}__{}define({PUSH_MUL_MK4_TEMP},_OUTPUT)dnl
__{}__{}__{}__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(_COST,PUSH_MUL_MK4_COST),{1},{dnl
__{}__{}__{}__{}__{}define({PUSH_MUL_MK4_OUT},{PUSH_MUL_MK4_TEMP})dnl
__{}__{}__{}__{}__{}define({PUSH_MUL_MK4_COST},_COST)dnl
__{}__{}__{}__{}__{}define({PUSH_MUL_MK4_INFO},{
__{}__{}__{}__{}__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+...})})dnl
__{}__{}__{}__{}})dnl
__{}__{}__{}},{dnl
__{}__{}__{}__{}define({XMUL_HI},{0})dnl
__{}__{}__{}__{}define({XMUL_LO},eval(($1) & 0xff))dnl
__{}__{}__{}__{}PUSH_MUL_MK4_CREATE_TOKENS(XMUL_LO)dnl
__{}__{}__{}__{}MK4_TOKENS_HL_ADD_BC_MUL($1){}dnl
__{}__{}__{}__{}define({_TOKEN_CHECK},{dnl
__{}__{}__{}__{}__{}ifelse(eval(XMUL_RESULT!=XMUL_LO),{1},{
__{}__{}__{}__{}__{}__{}.error Error in mk4 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
__{}__{}__{}__{}__{}})})dnl
__{}__{}__{}__{}define({_TOKEN_PUSH},{dnl
__{}__{}__{}__{}__{}define({_COST},{0})dnl
__{}__{}__{}__{}__{}define({XMUL_SUM},{1})dnl
__{}__{}__{}__{}__{}define({XMUL_A_SUM},{0})dnl
__{}__{}__{}__{}__{}define({XMUL_RESULT},{0})dnl
__{}__{}__{}__{}__{}ifelse(eval(HI_BIT(XMUL_LO)<(XMUL_LO)),{1},{dnl
__{}__{}__{}__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}__{}__{}__{}    ld    B{,} H          ; 1:4       $1 *})dnl
__{}__{}__{}__{}__{}_ADD_COST(1+256*4)
__{}__{}__{}__{}__{}    ld    C{,} L          ; 1:4       $1 *   1       1x & 256x = base{}dnl
__{}__{}__{}__{}}){}dnl
__{}__{}__{}__{}define({PUSH_MUL_MK4_TEMP},_OUTPUT)dnl
__{}__{}__{}__{}define({XMUL_HI},{0})dnl
__{}__{}__{}__{}PUSH_MUL_MK4_CREATE_TOKENS(eval(($1)/256))dnl
__{}__{}__{}__{}MK4_TOKENS_A_ADD_C_MUL($1){}dnl
__{}__{}__{}__{}define({PUSH_MUL_MK4_TEMP2},{PUSH_MUL_MK4_TEMP}_OUTPUT)dnl
__{}__{}__{}__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(_COST,PUSH_MUL_MK4_COST),{1},{dnl
__{}__{}__{}__{}__{}define({PUSH_MUL_MK4_OUT},{PUSH_MUL_MK4_TEMP2})dnl
__{}__{}__{}__{}__{}define({PUSH_MUL_MK4_COST},_COST)dnl
__{}__{}__{}__{}__{}define({PUSH_MUL_MK4_INFO},{
__{}__{}__{}__{}__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+...})})dnl
__{}__{}__{}__{}})dnl
__{}__{}__{}})dnl
__{}__{}})dnl
__{}})dnl
})})dnl
dnl
dnl
dnl
