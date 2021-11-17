dnl ## constant multiplication, variant 1
define({___},{})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK1_RESET},{dnl
___{}undefine({_TOKEN_INIT})dnl
___{}undefine({_TOKEN_PUSH})dnl
___{}undefine({_TOKEN_POP})dnl
___{}undefine({_TOKEN_SAVE})dnl
___{}undefine({_TOKEN_2X})dnl
___{}undefine({_TOKEN_128X})dnl
___{}undefine({_TOKEN_256X})dnl
___{}undefine({_TOKEN_END})dnl
___{}undefine({_TOKEN_CHECK})dnl
___{}define({_COST},{0})dnl
___{}define({XMUL_BIT},{1})dnl
___{}define({XMUL_SUM},{0})dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK1_LOOP},{dnl
___{}define({PUSH_MUL_MK1_PAR},eval($1))dnl
___{}define({_OUTPUT},{ _TOKEN_INIT() _TOKEN_PUSH()})dnl
___{}_PUSH_MUL_MK1_LOOP($1)dnl
___{}_ADD_OUTPUT({ _TOKEN_END() _TOKEN_CHECK() _TOKEN_POP()})dnl
})dnl
dnl
dnl
dnl
define({_PUSH_MUL_MK1_LOOP},{ifelse(eval(PUSH_MUL_MK1_PAR>1),{1},{dnl
___{}ifelse(eval(PUSH_MUL_MK1_PAR & 1),{1},dnl
___{}___{}{_ADD_OUTPUT({ _TOKEN_SAVE()})}){}dnl
___{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/2)){}dnl
___{}ifelse(eval(PUSH_MUL_MK1_PAR & 127),{0},{dnl
___{}___{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/128)){}dnl
___{}___{}define({XMUL_BIT},eval(XMUL_BIT*256)){}dnl
___{}___{}_ADD_OUTPUT({ _TOKEN_256X()}){}dnl
___{}},eval(((PUSH_MUL_MK1_PAR & 63)==0) && (XMUL_BIT > 1)),{1},{dnl
___{}___{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/64)){}dnl
___{}___{}define({XMUL_BIT},eval(XMUL_BIT*128)){}dnl
___{}___{}_ADD_OUTPUT({ _TOKEN_128X()}){}dnl
___{}},{dnl
___{}___{}define({XMUL_BIT},eval(2*XMUL_BIT)){}dnl
___{}___{}_ADD_OUTPUT({ _TOKEN_2X()}){}dnl
___{}}){}dnl
___{}_PUSH_MUL_MK1_LOOP($1){}dnl
})})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK1_NEGLOOP},{dnl
___{}define({PUSH_MUL_MK1_PAR},eval($1-1))dnl
___{}define({_OUTPUT},{ _TOKEN_INIT() _TOKEN_PUSH()})dnl
___{}_PUSH_MUL_MK1_NEGLOOP($1)dnl
___{}_ADD_OUTPUT({ _TOKEN_END() _TOKEN_CHECK() _TOKEN_POP()})dnl
})dnl
dnl
dnl
dnl
define({_PUSH_MUL_MK1_NEGLOOP},{ifelse(eval(PUSH_MUL_MK1_PAR>=1),{1},{dnl
___{}ifelse(eval(PUSH_MUL_MK1_PAR & 1),{0},dnl
___{}___{}{_ADD_OUTPUT({ _TOKEN_SAVE()})}){}dnl
___{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/2)){}dnl
___{}ifelse(eval(PUSH_MUL_MK1_PAR & 127),{127},{dnl
___{}___{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/128)){}dnl
___{}___{}define({XMUL_BIT},eval(XMUL_BIT*256)){}dnl
___{}___{}_ADD_OUTPUT({ _TOKEN_256X()}){}dnl
___{}},eval(((PUSH_MUL_MK1_PAR & 63)==63) && (XMUL_BIT > 1)),{1},{dnl
___{}___{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/64)){}dnl
___{}___{}define({XMUL_BIT},eval(XMUL_BIT*128)){}dnl
___{}___{}_ADD_OUTPUT({ _TOKEN_128X()}){}dnl
___{}},{dnl
___{}___{}define({XMUL_BIT},eval(2*XMUL_BIT)){}dnl
___{}___{}_ADD_OUTPUT({ _TOKEN_2X()}){}dnl
___{}}){}dnl
___{}_PUSH_MUL_MK1_NEGLOOP($1){}dnl
})})dnl
dnl
dnl
dnl
define({_MUL_DEF_ALL},{dnl
___{}define({_TOKEN_INIT},{dnl
___{}___{}define({XMUL_SUM},{0})dnl
___{}___{}define({XMUL_BIT},{1})}){}dnl
___{}define({_TOKEN_PUSH},{}){}dnl
___{}define({_TOKEN_POP},{}){}dnl
___{}define({_TOKEN_SAVE},{dnl
___{}___{}define({XMUL_SUM},XMUL_BIT)dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}    ld    B{,} H          ; 1:4       $1 *
___{}___{}    ld    C{,} L          ; 1:4       $1 *   [XMUL_SUM{}x]}){}dnl
___{}define({_TOKEN_2X},{dnl
___{}___{}define({XMUL_BIT},eval(2*XMUL_BIT))dnl
___{}___{}_ADD_COST(1+256*11)
___{}___{}    add  HL{,} HL         ; 1:11      $1 *   XMUL_BIT{}x}){}dnl
___{}define({_TOKEN_128X},{dnl
___{}___{}define({XMUL_BIT},eval(128*XMUL_BIT))dnl
___{}___{}_ADD_COST(7+256*27)
___{}___{}    rr    H             ; 2:8       $1 *
___{}___{}    rr    L             ; 2:8       $1 *
___{}___{}    ld    H{,} L          ; 1:4       $1 *
___{}___{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x}){}dnl
___{}define({_TOKEN_256X},{dnl
___{}___{}define({XMUL_BIT},eval(256*XMUL_BIT))dnl
___{}___{}_ADD_COST(3+256*11)
___{}___{}    ld    H{,} L          ; 1:4       $1 *
___{}___{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x}){}dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_BIT))}){}dnl
___{}define({_TOKEN_CHECK},{dnl
___{}___{}ifelse(eval(XMUL_RESULT!=$1),{1},{
___{}___{}___{}.error Error in mk1 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
___{}___{}})})dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_ADD_BC},{dnl
___{}_MUL_DEF_ALL($1){}dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_BIT+XMUL_SUM)){}dnl
___{}___{}ifelse(eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}_ADD_COST(1+256*11)
___{}___{}___{}    add  HL{,} BC         ; 1:11      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x + XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_SUB_BC},{dnl
___{}_MUL_DEF_ALL($1){}dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM)){}dnl
___{}___{}ifelse(eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}_ADD_COST(3+256*19)
___{}___{}___{}    or    A             ; 1:4       $1 *
___{}___{}___{}    sbc  HL{,} BC         ; 2:15      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x - XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_ADD_BA},{dnl
___{}_MUL_DEF_ALL($1){}dnl
___{}define({_TOKEN_SAVE},{dnl
___{}___{}define({XMUL_SUM},XMUL_BIT)dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}    ld    B{,} H          ; 1:4       $1 *
___{}___{}    ld    A{,} L          ; 1:4       $1 *   [XMUL_SUM{}x]{}dnl
___{}___{}define({_TOKEN_SAVE},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(5+256*20)
___{}___{}___{}    add   A{,} L          ; 1:4       $1 *
___{}___{}___{}    ld    C{,} A          ; 1:4       $1 *
___{}___{}___{}    ld    A{,} B          ; 1:4       $1 *
___{}___{}___{}    adc   A{,} H          ; 1:4       $1 *
___{}___{}___{}    ld    B{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]})}){}dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_BIT+XMUL_SUM)){}dnl
___{}___{}ifelse(eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}_ADD_COST(1+256*11)
___{}___{}___{}    add  HL{,} BC         ; 1:11      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x + XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_SUB_BA},{dnl
___{}_MUL_DEF_ADD_BA($1){}dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM)){}dnl
___{}___{}ifelse(eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}_ADD_COST(3+256*19)
___{}___{}___{}    or    A             ; 1:4       $1 *
___{}___{}___{}    sbc  HL{,} BC         ; 2:15      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x - XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_ADD_DE},{dnl
___{}_MUL_DEF_ALL($1){}dnl
___{}define({_TOKEN_PUSH},{dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}    ld    B{,} D          ; 1:4       $1 *
___{}___{}    ld    C{,} E          ; 1:4       $1 *}){}dnl
___{}define({_TOKEN_POP},{dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}    ld    D{,} B          ; 1:4       $1 *
___{}___{}    ld    E{,} C          ; 1:4       $1 *}){}dnl
___{}define({_TOKEN_SAVE},{dnl
___{}___{}define({XMUL_SUM},XMUL_BIT)dnl
___{}___{}_ADD_COST(2+256*8)
___{}___{}    ld    D{,} H          ; 1:4       $1 *
___{}___{}    ld    E{,} L          ; 1:4       $1 *   [XMUL_SUM{}x]{}dnl
___{}___{}define({_TOKEN_SAVE},{dnl
___{}___{}___{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
___{}___{}___{}_ADD_COST(3+256*19)
___{}___{}___{}    ex   DE{,} HL         ; 1:4       $1 *
___{}___{}___{}    add  HL{,} DE         ; 1:11      $1 *   [XMUL_SUM{}x]
___{}___{}___{}    ex   DE{,} HL         ; 1:4       $1 *})}){}dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_BIT+XMUL_SUM)){}dnl
___{}___{}ifelse(eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}_ADD_COST(1+256*11)
___{}___{}___{}    add  HL{,} DE         ; 1:11      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x + XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_SUB_DE},{dnl
___{}_MUL_DEF_ADD_DE($1){}dnl
___{}define({_TOKEN_END},{dnl
___{}___{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM)){}dnl
___{}___{}ifelse(eval(XMUL_SUM>0),{1},{dnl
___{}___{}___{}_ADD_COST(3+256*19)
___{}___{}___{}    or    A             ; 1:4       $1 *
___{}___{}___{}    sbc  HL{,} DE         ; 2:15      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x - XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
dnl
dnl "const *"
dnl ( x1 -- const*x1 )
define({PUSH_MUL_MK1},{dnl
___{}define({PUSH_MUL_MK1_1BITS},SUM_1BITS($1)){}dnl
___{}define({PUSH_MUL_MK1_0BITS},SUM_0BITS($1-1)){}dnl
___{}PUSH_MUL_MK1_RESET{}dnl
dnl
ifelse(eval($1==0),{1},{
dnl n = 0
dnl
___{}define({PUSH_MUL_MK1_OUT},{
    ld   HL, 0x0000     ; 3:10      0 *})dnl
___{}define({PUSH_MUL_MK1_COST},eval(3+256*10)){}dnl
___{}define({PUSH_MUL_MK1_INFO},PUSH_MUL_INFO_PLUS(2563,$1,{Variant mk1: HL * 0}))dnl
},PUSH_MUL_MK1_1BITS,{1},{
dnl n = 2^a
dnl 1,2,4,8,16,32,...
___{}PUSH_MUL_MK1_LOOP($1){}dnl
___{}_MUL_DEF_ALL($1)dnl
___{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
___{}define({PUSH_MUL_MK1_COST},_COST)dnl
___{}define({PUSH_MUL_MK1_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk1: HL * 2^a}))dnl
},PUSH_MUL_MK1_1BITS,{2},{
dnl n = 2^a + 2^b
dnl 3,5,6,9,10,12,17,18,20,24,...
dnl Not all variants are optimal. For example, 258.
___{}PUSH_MUL_MK1_LOOP($1){}dnl
___{}_MUL_DEF_ADD_BC($1)dnl
___{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
___{}define({PUSH_MUL_MK1_COST},_COST)dnl
___{}define({PUSH_MUL_MK1_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk1: HL * (2^a + 2^b)}))dnl
},PUSH_MUL_MK1_0BITS,{1},{
dnl n = 2^a - 2^b, a > b
dnl 60=64-4
___{}PUSH_MUL_MK1_NEGLOOP($1){}dnl
___{}_MUL_DEF_SUB_BC($1)dnl
___{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
___{}define({PUSH_MUL_MK1_COST},_COST)dnl
___{}define({PUSH_MUL_MK1_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk1: HL * (2^a - 2^b)}))dnl
},PUSH_MUL_MK1_1BITS,{3},{
dnl
dnl n = 2^a + 2^b + 2^c
dnl 11=8+2+1,69=64+4+1
___{}PUSH_MUL_MK1_LOOP($1){}dnl
___{}_MUL_DEF_ADD_BA($1)dnl
___{}define({PUSH_MUL_MK1_OUT},_OUTPUT){}dnl
___{}define({PUSH_MUL_MK1_COST},_COST)dnl
___{}define({PUSH_MUL_MK1_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk1: HL * (2^a + 2^b + 2^c)}))dnl
},PUSH_MUL_MK1_0BITS,{2},{
dnl
dnl n = 2^a - 2^b - 2^c, a > b > c
dnl 27=32-4-1,54=64-8-2
___{}PUSH_MUL_MK1_NEGLOOP($1){}dnl
___{}_MUL_DEF_SUB_BA($1)dnl
___{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
___{}define({PUSH_MUL_MK1_COST},_COST)dnl
___{}define({PUSH_MUL_MK1_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk1: HL * (2^a - 2^b - 2^c)}))dnl
},eval(PUSH_MUL_MK1_1BITS <= PUSH_MUL_MK1_0BITS + 2),{1},{
dnl n = 2^a + 2^b + 2^c + ...
___{}PUSH_MUL_MK1_LOOP($1){}dnl
___{}_MUL_DEF_ADD_DE($1)dnl
___{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
___{}define({PUSH_MUL_MK1_COST},_COST)dnl
___{}define({PUSH_MUL_MK1_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk1: HL * (2^a + 2^b + 2^c + ...)}))dnl
},{
dnl n = 2^a - 2^b - 2^c - ...
dnl 187=128+32+16+8+2+1=256-64-4-1
___{}PUSH_MUL_MK1_NEGLOOP($1){}dnl
___{}_MUL_DEF_SUB_DE($1)dnl
___{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
___{}define({PUSH_MUL_MK1_COST},_COST)dnl
___{}define({PUSH_MUL_MK1_INFO},PUSH_MUL_INFO_PLUS(_COST,$1,{Variant mk1: HL * (2^a - 2^b - 2^c - ...)}))dnl
})})dnl
dnl
dnl
dnl
