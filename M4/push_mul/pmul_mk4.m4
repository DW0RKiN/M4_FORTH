dnl ## constant multiplication, variant 4
define({___},{})dnl
dnl
dnl
dnl
define({MK4_TOKENS_HL_ADD_BC_MUL},{dnl
dnl
___{}define({_TOKEN_PUSH},{dnl
___{}___{}define({_COST},{0})dnl
___{}___{}define({XMUL_SUM},{1})dnl
___{}___{}define({XMUL_256X_SUM},{0})dnl
___{}___{}define({XMUL_RESULT},{0})dnl
___{}___{}ifelse(eval(HI_BIT($1)<($1)),{1},{dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}    ld    B{,} H          ; 1:4       $1 *
___{}___{}    ld    C{,} L          ; 1:4       $1 *   1       1x = base})}){}dnl
dnl
___{}define({_TOKEN_CHECK},{dnl
___{}___{}ifelse(eval(XMUL_RESULT!=$1),{1},{
___{}___{}___{}.error Error in mk4 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
___{}___{}})})dnl
dnl
___{}define({_TOKEN_256X_SAVE},{dnl
___{}___{}ifelse(eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(256*XMUL_SUM))dnl
___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *   256*L = XMUL_256X_SUM{}x{}dnl
___{}___{}},eval(XMUL_256X_SUM>0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_SUM))dnl
___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}    add   A{,} L          ; 1:4       $1 *  +256*L = XMUL_256X_SUM{}x})}){}dnl
dnl
___{}define({_TOKEN_2X},{dnl
___{}___{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
___{}___{}_ADD_COST(1+256*11)
___{}___{}    add  HL{,} HL         ; 1:11      $1 *   0  *2 = XMUL_SUM{}x}){}dnl
dnl
___{}define({_TOKEN_2X_SAVE},{dnl
___{}___{}_ADD_COST(2+256*22)
___{}___{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
___{}___{}    add  HL{,} HL         ; 1:11      $1 *   1  *2 = XMUL_SUM{}x
___{}___{}define({XMUL_SUM},eval(1+XMUL_SUM))dnl
___{}___{}    add  HL{,} BC         ; 1:11      $1 *      +1 = XMUL_SUM{}x}){}dnl
dnl
___{}define({_TOKEN_2X_256X_SAVE},{dnl
___{}___{}_ADD_COST(1+256*11)
___{}___{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
___{}___{}    add  HL{,} HL         ; 1:11      $1 *   1  *2 = XMUL_SUM{}x{}dnl
___{}___{}ifelse(eval(XMUL_256X_SUM==0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(256*XMUL_SUM))dnl
___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}    ld    A{,} L          ; 1:4       $1 *   256*L = XMUL_256X_SUM{}x{}dnl
___{}___{}},eval(XMUL_256X_SUM>0),{1},{dnl
___{}___{}___{}define({XMUL_256X_SUM},eval(XMUL_256X_SUM+256*XMUL_SUM))dnl
___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}    add   A{,} L          ; 1:4       $1 *  +256*L = XMUL_256X_SUM{}x}){}dnl
___{}___{}define({XMUL_SUM},eval(1+XMUL_SUM))dnl
___{}___{}_ADD_COST(1+256*11)
___{}___{}    add  HL{,} BC         ; 1:11      $1 *      +1 = XMUL_SUM{}x}){}dnl
dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_SUM+XMUL_256X_SUM)){}dnl
___{}___{}ifelse(eval(XMUL_256X_SUM>0),{1},{dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}    add   A{,} H          ; 1:4       $1 *
___{}___{}    ld    H{,} A          ; 1:4       $1 *     [XMUL_RESULT{}x] = XMUL_SUM{}x + XMUL_256X_SUM{}x})})dnl
})dnl
dnl
dnl
dnl
define({MK4_TOKENS_A_ADD_L_MUL},{dnl
dnl
___{}define({_TOKEN_PUSH},{dnl
___{}___{}define({_COST},{0})dnl
___{}___{}define({XMUL_SUM},{1})dnl
___{}___{}define({XMUL_RESULT},{0})dnl
___{}___{}_ADD_COST(1+256*4)
___{}___{}    ld    A{,} L          ; 1:4       $1 *   1       XMUL_SUM{x}}){}dnl
dnl
___{}define({_TOKEN_CHECK},{dnl
___{}___{}ifelse(eval(XMUL_RESULT!=$1),{1},{
___{}___{}___{}.error Error in mk4 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
___{}___{}})})dnl
dnl
___{}define({_TOKEN_2X},{dnl
___{}___{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
___{}___{}_ADD_COST(1+256*4)
___{}___{}    add   A{,} A          ; 1:4       $1 *   0  *2 = XMUL_SUM{}x}){}dnl
dnl
___{}define({_TOKEN_2X_SAVE},{dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
___{}___{}    add   A{,} A          ; 1:4       $1 *   1  *2 = XMUL_SUM{}x
___{}___{}define({XMUL_SUM},eval(1+XMUL_SUM))dnl
___{}___{}    add   A{,} L          ; 1:4       $1 *      +1 = XMUL_SUM{}x}){}dnl
dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(256*XMUL_SUM)){}dnl
___{}___{}_ADD_COST(3+256*11)
___{}___{}    ld    L{,} 0x00       ; 2:7       $1 *
___{}___{}    ld    H{,} A          ; 1:4       $1 *     [XMUL_RESULT{}x] = 256 * XMUL_SUM{}x})dnl
})dnl
dnl
dnl
dnl
define({MK4_TOKENS_A_ADD_C_MUL},{dnl
dnl
___{}define({_TOKEN_PUSH},{dnl
dnl      #define({_COST},{0})dnl 
___{}___{}define({XMUL_SUM},{1})dnl
___{}___{}define({XMUL_RESULT},{0})dnl
___{}___{}_ADD_COST(1+256*4)
___{}___{}    ld    A{,} C          ; 1:4       $1 *   1       XMUL_SUM{}x}){}dnl
dnl
___{}define({_TOKEN_CHECK},{dnl
___{}___{}ifelse(eval(XMUL_RESULT!=$1),{1},{
___{}___{}___{}.error Error in mk4 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
___{}___{}})})dnl
dnl
___{}define({_TOKEN_2X},{dnl
___{}___{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
___{}___{}_ADD_COST(1+256*4)
___{}___{}    add   A{,} A          ; 1:4       $1 *   0  *2 = XMUL_SUM{}x}){}dnl
dnl
___{}define({_TOKEN_2X_SAVE},{dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}define({XMUL_SUM},eval(2*XMUL_SUM))dnl
___{}___{}    add   A{,} A          ; 1:4       $1 *   1  *2 = XMUL_SUM{}x
___{}___{}define({XMUL_SUM},eval(1+XMUL_SUM))dnl
___{}___{}    add   A{,} C          ; 1:4       $1 *      +1 = XMUL_SUM{}x}){}dnl
dnl
___{}define({_TOKEN_END},{dnl redefine _token_end
___{}___{}define({XMUL_RESULT},eval(256*XMUL_SUM+XMUL_LO)){}dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}    add   A{,} H          ; 1:4       $1 *
___{}___{}    ld    H{,} A          ; 1:4       $1 *     [XMUL_RESULT{}x] = 256 * XMUL_SUM{}x + XMUL_LO{}x})dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK4_LOOP},{dnl
___{}ifelse(eval(($1)>1),{1},{dnl
___{}___{}ifelse(eval(XMUL_HI>=($1)),{1},{dnl
___{}___{}___{}define({XMUL_HI},eval(XMUL_HI-($1))){}dnl
___{}___{}___{}_PUSH_OUTPUT({_TOKEN_256X_SAVE() })dnl
___{}___{}___{}ifelse(eval($1 & 1),{1},{dnl
___{}___{}___{}___{}_PUSH_OUTPUT({_TOKEN_2X_SAVE() }){}dnl
___{}___{}___{}},{dnl
___{}___{}___{}___{}_PUSH_OUTPUT({_TOKEN_2X() }){}dnl
___{}___{}___{}})dnl
___{}___{}},eval((XMUL_HI > 0) && (($1 & 1) == 1) && (XMUL_HI>=($1 - 1))),{1},{dnl
___{}___{}___{}define({XMUL_HI},eval(XMUL_HI-($1-1))){}dnl
___{}___{}___{}_PUSH_OUTPUT({_TOKEN_2X_256X_SAVE() }){}dnl
___{}___{}},eval($1 & 1),{1},{dnl
___{}___{}___{}_PUSH_OUTPUT({_TOKEN_2X_SAVE() }){}dnl
___{}___{}},{dnl
___{}___{}___{}_PUSH_OUTPUT({_TOKEN_2X() }){}dnl
___{}___{}})dnl
___{}___{}PUSH_MUL_MK4_LOOP(eval(($1)/2))dnl
___{}},eval(($1)>0),{1},{dnl
___{}___{}ifelse(eval(XMUL_HI>=($1)),{1},{dnl
___{}___{}___{}define({XMUL_HI},eval(XMUL_HI-($1))){}dnl
___{}___{}___{}_PUSH_OUTPUT({_TOKEN_256X_SAVE() })}){}dnl
___{}})dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK4_CREATE_TOKENS},{dnl
___{}undefine({_TOKEN_2X})dnl
___{}undefine({_TOKEN_2X_256X_SAVE})dnl
___{}undefine({_TOKEN_256X_SAVE})dnl
___{}undefine({_TOKEN_2X_SAVE})dnl
___{}undefine({_TOKEN_PUSH})dnl
___{}undefine({_TOKEN_END})dnl
___{}undefine({_TOKEN_CHECK})dnl
___{}define({_OUTPUT},{_TOKEN_END() _TOKEN_CHECK()})dnl
___{}PUSH_MUL_MK4_LOOP($1)dnl
___{}_PUSH_OUTPUT({_TOKEN_PUSH() })dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK4},{ifelse(eval((($1) & 0xffff)==0),{1},{dnl
___{}define({PUSH_MUL_MK4_OUT},{
___{}___{}ld   HL{,} 0x0000     ; 3:10      $1 *})dnl
___{}define({PUSH_MUL_MK4_COST},{3+256*10})dnl
___{}define({PUSH_MUL_MK4_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk4: HL * 0}))dnl
},{dnl
___{}define({XMUL_HI},{0})dnl
___{}PUSH_MUL_MK4_CREATE_TOKENS($1)dnl
___{}MK4_TOKENS_HL_ADD_BC_MUL($1){}dnl
___{}define({PUSH_MUL_MK4_OUT},_OUTPUT)dnl
___{}define({PUSH_MUL_MK4_COST},_COST)dnl
___{}define({PUSH_MUL_MK4_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk4: ...(((HL*2^a)+HL)*2^b)+...}))dnl
dnl
___{}define({XMUL_HI},eval(($1)/256))dnl
___{}define({XMUL_LO},eval(($1) & 0xff))dnl
dnl
___{}ifelse(eval(XMUL_HI>0),{1},{dnl
___{}___{}ifelse(eval(XMUL_LO==0),{1},{dnl
___{}___{}___{}define({XMUL_LO},XMUL_HI)dnl
___{}___{}___{}define({XMUL_HI},{0})dnl
___{}___{}___{}PUSH_MUL_MK4_CREATE_TOKENS(XMUL_LO)dnl
___{}___{}___{}MK4_TOKENS_A_ADD_L_MUL($1){}dnl
___{}___{}___{}define({PUSH_MUL_MK4_TEMP},_OUTPUT)dnl
___{}___{}___{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(_COST,PUSH_MUL_MK4_COST),{1},{dnl
___{}___{}___{}___{}define({PUSH_MUL_MK4_OUT},{PUSH_MUL_MK4_TEMP})dnl
___{}___{}___{}___{}define({PUSH_MUL_MK4_COST},_COST)dnl
___{}___{}___{}___{}define({PUSH_MUL_MK4_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk4: 256*...(((L*2^a)+L)*2^b)+...}))dnl
___{}___{}___{}})dnl
___{}___{}},XMUL_LO,{1},{dnl
___{}___{}___{}define({XMUL_LO},XMUL_HI)dnl
___{}___{}___{}define({XMUL_HI},{0})dnl
___{}___{}___{}PUSH_MUL_MK4_CREATE_TOKENS(XMUL_LO)dnl
___{}___{}___{}MK4_TOKENS_A_ADD_L_MUL($1){}dnl
___{}___{}___{}define({_TOKEN_END},{dnl redefine _token_end
___{}___{}___{}___{}define({XMUL_RESULT},eval(256*XMUL_SUM+1)){}dnl
___{}___{}___{}___{}_ADD_COST(2+256*8)
___{}___{}___{}___{}    add   A{,} H          ; 1:4       $1 *
___{}___{}___{}___{}    ld    H{,} A          ; 1:4       $1 *     [XMUL_RESULT{}x] = 256 * XMUL_SUM{}x + 1x})dnl
___{}___{}___{}define({PUSH_MUL_MK4_TEMP},_OUTPUT)dnl
___{}___{}___{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(_COST,PUSH_MUL_MK4_COST),{1},{dnl
___{}___{}___{}___{}define({PUSH_MUL_MK4_OUT},{PUSH_MUL_MK4_TEMP})dnl
___{}___{}___{}___{}define({PUSH_MUL_MK4_COST},_COST)dnl
___{}___{}___{}___{}define({PUSH_MUL_MK4_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk4: 256*...(((L*2^a)+L)*2^b)+...}))dnl
___{}___{}___{}})dnl
___{}___{}},{dnl
___{}___{}___{}PUSH_MUL_MK4_CREATE_TOKENS(XMUL_LO)dnl
___{}___{}___{}ifelse(eval(XMUL_HI==0),{1},{dnl
___{}___{}___{}___{}MK4_TOKENS_HL_ADD_BC_MUL($1){}dnl
___{}___{}___{}___{}define({PUSH_MUL_MK4_TEMP},_OUTPUT)dnl
___{}___{}___{}___{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(_COST,PUSH_MUL_MK4_COST),{1},{dnl
___{}___{}___{}___{}___{}define({PUSH_MUL_MK4_OUT},{PUSH_MUL_MK4_TEMP})dnl
___{}___{}___{}___{}___{}define({PUSH_MUL_MK4_COST},_COST)dnl
___{}___{}___{}___{}___{}define({PUSH_MUL_MK4_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk4: ...(((HL*2^a)+256*L+HL)*2^b)+...}))dnl
___{}___{}___{}___{}})dnl
___{}___{}___{}},{dnl
___{}___{}___{}___{}define({XMUL_HI},{0})dnl
___{}___{}___{}___{}define({XMUL_LO},eval(($1) & 0xff))dnl
___{}___{}___{}___{}PUSH_MUL_MK4_CREATE_TOKENS(XMUL_LO)dnl
___{}___{}___{}___{}MK4_TOKENS_HL_ADD_BC_MUL($1){}dnl
___{}___{}___{}___{}define({_TOKEN_CHECK},{dnl
___{}___{}___{}___{}___{}ifelse(eval(XMUL_RESULT!=XMUL_LO),{1},{
___{}___{}___{}___{}___{}___{}.error Error in mk4 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
___{}___{}___{}___{}___{}})})dnl
___{}___{}___{}___{}define({_TOKEN_PUSH},{dnl
___{}___{}___{}___{}___{}define({_COST},{0})dnl
___{}___{}___{}___{}___{}define({XMUL_SUM},{1})dnl
___{}___{}___{}___{}___{}define({XMUL_256X_SUM},{0})dnl
___{}___{}___{}___{}___{}define({XMUL_RESULT},{0})dnl
___{}___{}___{}___{}___{}ifelse(eval(HI_BIT(XMUL_LO)<(XMUL_LO)),{1},{dnl
___{}___{}___{}___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}___{}___{}___{}    ld    B{,} H          ; 1:4       $1 *})dnl
___{}___{}___{}___{}___{}_ADD_COST(1+256*4)
___{}___{}___{}___{}___{}    ld    C{,} L          ; 1:4       $1 *   1       1x & 256x = base{}dnl
___{}___{}___{}___{}}){}dnl
___{}___{}___{}___{}define({PUSH_MUL_MK4_TEMP},_OUTPUT)dnl
___{}___{}___{}___{}define({XMUL_HI},{0})dnl
___{}___{}___{}___{}PUSH_MUL_MK4_CREATE_TOKENS(eval(($1)/256))dnl
___{}___{}___{}___{}MK4_TOKENS_A_ADD_C_MUL($1){}dnl
___{}___{}___{}___{}define({PUSH_MUL_MK4_TEMP2},{PUSH_MUL_MK4_TEMP}_OUTPUT)dnl
___{}___{}___{}___{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(_COST,PUSH_MUL_MK4_COST),{1},{dnl
___{}___{}___{}___{}___{}define({PUSH_MUL_MK4_OUT},{PUSH_MUL_MK4_TEMP2})dnl
___{}___{}___{}___{}___{}define({PUSH_MUL_MK4_COST},_COST)dnl
___{}___{}___{}___{}___{}define({PUSH_MUL_MK4_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk4: ...((L*2^a)+L*^b)+...(((HL*2^c)+HL)*2^d)+...}))dnl
___{}___{}___{}___{}})dnl
___{}___{}___{}})dnl
___{}___{}})dnl
___{}})dnl
})})dnl
dnl
dnl
dnl
