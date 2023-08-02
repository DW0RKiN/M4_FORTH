dnl ## constant multiplication, variant 1
define({__},{})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK1_RESET},{dnl
__{}undefine({_TOKEN_INIT})dnl
__{}undefine({_TOKEN_PUSH})dnl
__{}undefine({_TOKEN_POP})dnl
__{}undefine({_TOKEN_SAVE})dnl
__{}undefine({_TOKEN_2X})dnl
__{}undefine({_TOKEN_128X})dnl
__{}undefine({_TOKEN_256X})dnl
__{}undefine({_TOKEN_END})dnl
__{}undefine({_TOKEN_CHECK})dnl
__{}define({_COST},{0})dnl
__{}define({XMUL_BIT},{1})dnl
__{}define({XMUL_SUM},{0})dnl
})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK1_LOOP},{dnl
__{}define({PUSH_MUL_MK1_PAR},eval($1))dnl
__{}define({_OUTPUT},{ _TOKEN_INIT() _TOKEN_PUSH()})dnl
__{}_PUSH_MUL_MK1_LOOP($1)dnl
__{}_ADD_OUTPUT({ _TOKEN_END() _TOKEN_CHECK() _TOKEN_POP()})dnl
})dnl
dnl
dnl
dnl
define({_PUSH_MUL_MK1_LOOP},{ifelse(eval(PUSH_MUL_MK1_PAR>1),{1},{dnl
__{}ifelse(eval(PUSH_MUL_MK1_PAR & 1),{1},dnl
__{}__{}{_ADD_OUTPUT({ _TOKEN_SAVE()})}){}dnl
__{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/2)){}dnl
__{}ifelse(eval(PUSH_MUL_MK1_PAR & 127),{0},{dnl
__{}__{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/128)){}dnl
__{}__{}define({XMUL_BIT},eval(XMUL_BIT*256)){}dnl
__{}__{}_ADD_OUTPUT({ _TOKEN_256X()}){}dnl
__{}},eval(((PUSH_MUL_MK1_PAR & 63)==0) && (XMUL_BIT > 1)),{1},{dnl
__{}__{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/64)){}dnl
__{}__{}define({XMUL_BIT},eval(XMUL_BIT*128)){}dnl
__{}__{}_ADD_OUTPUT({ _TOKEN_128X()}){}dnl
__{}},{dnl
__{}__{}define({XMUL_BIT},eval(2*XMUL_BIT)){}dnl
__{}__{}_ADD_OUTPUT({ _TOKEN_2X()}){}dnl
__{}}){}dnl
__{}_PUSH_MUL_MK1_LOOP($1){}dnl
})})dnl
dnl
dnl
dnl
define({PUSH_MUL_MK1_NEGLOOP},{dnl
__{}define({PUSH_MUL_MK1_PAR},eval($1-1))dnl
__{}define({_OUTPUT},{ _TOKEN_INIT() _TOKEN_PUSH()})dnl
__{}_PUSH_MUL_MK1_NEGLOOP($1)dnl
__{}_ADD_OUTPUT({ _TOKEN_END() _TOKEN_CHECK() _TOKEN_POP()})dnl
})dnl
dnl
dnl
dnl
define({_PUSH_MUL_MK1_NEGLOOP},{ifelse(eval(PUSH_MUL_MK1_PAR>=1),{1},{dnl
__{}ifelse(eval(PUSH_MUL_MK1_PAR & 1),{0},dnl
__{}__{}{_ADD_OUTPUT({ _TOKEN_SAVE()})}){}dnl
__{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/2)){}dnl
__{}ifelse(eval(PUSH_MUL_MK1_PAR & 127),{127},{dnl
__{}__{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/128)){}dnl
__{}__{}define({XMUL_BIT},eval(XMUL_BIT*256)){}dnl
__{}__{}_ADD_OUTPUT({ _TOKEN_256X()}){}dnl
__{}},eval(((PUSH_MUL_MK1_PAR & 63)==63) && (XMUL_BIT > 1)),{1},{dnl
__{}__{}define({PUSH_MUL_MK1_PAR},eval(PUSH_MUL_MK1_PAR/64)){}dnl
__{}__{}define({XMUL_BIT},eval(XMUL_BIT*128)){}dnl
__{}__{}_ADD_OUTPUT({ _TOKEN_128X()}){}dnl
__{}},{dnl
__{}__{}define({XMUL_BIT},eval(2*XMUL_BIT)){}dnl
__{}__{}_ADD_OUTPUT({ _TOKEN_2X()}){}dnl
__{}}){}dnl
__{}_PUSH_MUL_MK1_NEGLOOP($1){}dnl
})})dnl
dnl
dnl
dnl
define({_MUL_DEF_ALL},{dnl
__{}define({_TOKEN_INIT},{dnl
__{}__{}define({XMUL_SUM},{0})dnl
__{}__{}define({XMUL_BIT},{1})}){}dnl
__{}define({_TOKEN_PUSH},{}){}dnl
__{}define({_TOKEN_POP},{}){}dnl
__{}define({_TOKEN_SAVE},{dnl
__{}__{}define({XMUL_SUM},XMUL_BIT)dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    ld    B{,} H          ; 1:4       $1 *
__{}__{}    ld    C{,} L          ; 1:4       $1 *   [XMUL_SUM{}x]}){}dnl
__{}define({_TOKEN_2X},{dnl
__{}__{}define({XMUL_BIT},eval(2*XMUL_BIT))dnl
__{}__{}_ADD_COST(1+256*11)
__{}__{}    add  HL{,} HL         ; 1:11      $1 *   XMUL_BIT{}x}){}dnl
__{}define({_TOKEN_128X},{dnl
__{}__{}define({XMUL_BIT},eval(128*XMUL_BIT))dnl
__{}__{}_ADD_COST(7+256*27)
__{}__{}    rr    H             ; 2:8       $1 *
__{}__{}    rr    L             ; 2:8       $1 *
__{}__{}    ld    H{,} L          ; 1:4       $1 *
__{}__{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x}){}dnl
__{}define({_TOKEN_256X},{dnl
__{}__{}define({XMUL_BIT},eval(256*XMUL_BIT))dnl
__{}__{}_ADD_COST(3+256*11)
__{}__{}    ld    H{,} L          ; 1:4       $1 *
__{}__{}    ld    L{,} 0x00       ; 2:7       $1 *   XMUL_BIT{}x}){}dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_BIT))}){}dnl
__{}define({_TOKEN_CHECK},{dnl
__{}__{}ifelse(eval(XMUL_RESULT!=$1),{1},{
__{}__{}__{}.error Error in mk1 constant multiplication function. The generated code does not have the correct result. XMUL_RESULT <> $1
__{}__{}})})dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_ADD_BC},{dnl
__{}_MUL_DEF_ALL($1){}dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_BIT+XMUL_SUM)){}dnl
__{}__{}ifelse(eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}_ADD_COST(1+256*11)
__{}__{}__{}    add  HL{,} BC         ; 1:11      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x + XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_SUB_BC},{dnl
__{}_MUL_DEF_ALL($1){}dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM)){}dnl
__{}__{}ifelse(eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}_ADD_COST(3+256*19)
__{}__{}__{}    or    A             ; 1:4       $1 *
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x - XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_ADD_BA},{dnl
__{}_MUL_DEF_ALL($1){}dnl
__{}define({_TOKEN_SAVE},{dnl
__{}__{}define({XMUL_SUM},XMUL_BIT)dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    ld    B{,} H          ; 1:4       $1 *
__{}__{}    ld    A{,} L          ; 1:4       $1 *   [XMUL_SUM{}x]{}dnl
__{}__{}define({_TOKEN_SAVE},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(5+256*20)
__{}__{}__{}    add   A{,} L          ; 1:4       $1 *
__{}__{}__{}    ld    C{,} A          ; 1:4       $1 *
__{}__{}__{}    ld    A{,} B          ; 1:4       $1 *
__{}__{}__{}    adc   A{,} H          ; 1:4       $1 *
__{}__{}__{}    ld    B{,} A          ; 1:4       $1 *   [XMUL_SUM{}x]})}){}dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_BIT+XMUL_SUM)){}dnl
__{}__{}ifelse(eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}_ADD_COST(1+256*11)
__{}__{}__{}    add  HL{,} BC         ; 1:11      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x + XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_SUB_BA},{dnl
__{}_MUL_DEF_ADD_BA($1){}dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM)){}dnl
__{}__{}ifelse(eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}_ADD_COST(3+256*19)
__{}__{}__{}    or    A             ; 1:4       $1 *
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x - XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_ADD_DE},{dnl
__{}_MUL_DEF_ALL($1){}dnl
__{}define({_TOKEN_PUSH},{dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    ld    B{,} D          ; 1:4       $1 *
__{}__{}    ld    C{,} E          ; 1:4       $1 *}){}dnl
__{}define({_TOKEN_POP},{dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    ld    D{,} B          ; 1:4       $1 *
__{}__{}    ld    E{,} C          ; 1:4       $1 *}){}dnl
__{}define({_TOKEN_SAVE},{dnl
__{}__{}define({XMUL_SUM},XMUL_BIT)dnl
__{}__{}_ADD_COST(2+256*8)
__{}__{}    ld    D{,} H          ; 1:4       $1 *
__{}__{}    ld    E{,} L          ; 1:4       $1 *   [XMUL_SUM{}x]{}dnl
__{}__{}define({_TOKEN_SAVE},{dnl
__{}__{}__{}define({XMUL_SUM},eval(XMUL_SUM+XMUL_BIT))dnl
__{}__{}__{}_ADD_COST(3+256*19)
__{}__{}__{}    ex   DE{,} HL         ; 1:4       $1 *
__{}__{}__{}    add  HL{,} DE         ; 1:11      $1 *   [XMUL_SUM{}x]
__{}__{}__{}    ex   DE{,} HL         ; 1:4       $1 *})}){}dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_BIT+XMUL_SUM)){}dnl
__{}__{}ifelse(eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}_ADD_COST(1+256*11)
__{}__{}__{}    add  HL{,} DE         ; 1:11      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x + XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
define({_MUL_DEF_SUB_DE},{dnl
__{}_MUL_DEF_ADD_DE($1){}dnl
__{}define({_TOKEN_END},{dnl
__{}__{}define({XMUL_RESULT},eval(XMUL_BIT-XMUL_SUM)){}dnl
__{}__{}ifelse(eval(XMUL_SUM>0),{1},{dnl
__{}__{}__{}_ADD_COST(3+256*19)
__{}__{}__{}    or    A             ; 1:4       $1 *
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      $1 *   [XMUL_RESULT{}x] = XMUL_BIT{}x - XMUL_SUM{}x})}){}dnl
})dnl
dnl
dnl
dnl
dnl
dnl "const *"
dnl ( x1 -- const*x1 )
define({PUSH_MUL_MK1},{dnl
__{}define({PUSH_MUL_MK1_1BITS},SUM_1BITS($1)){}dnl
__{}define({PUSH_MUL_MK1_0BITS},SUM_0BITS($1-1)){}dnl
__{}PUSH_MUL_MK1_RESET{}dnl
dnl
ifelse(eval($1==0),{1},{dnl
dnl n = 0
dnl
__{}define({PUSH_MUL_MK1_OUT},{
    ld   HL, 0x0000     ; 3:10      0 *})dnl
__{}define({PUSH_MUL_MK1_COST},eval(3+256*10)){}dnl
__{}define({PUSH_MUL_MK1_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(2563,$1,{Variant mk1: HL * 0})})},
PUSH_MUL_MK1_1BITS,{1},{dnl
dnl n = 2^a
dnl 1,2,4,8,16,32,...
__{}PUSH_MUL_MK1_LOOP($1){}dnl
__{}_MUL_DEF_ALL($1)dnl
__{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
__{}define({PUSH_MUL_MK1_COST},_COST)dnl
__{}define({PUSH_MUL_MK1_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk1: HL * 2^a})})},
PUSH_MUL_MK1_1BITS,{2},{dnl
dnl n = 2^a + 2^b
dnl 3,5,6,9,10,12,17,18,20,24,...
dnl Not all variants are optimal. For example, 258.
__{}PUSH_MUL_MK1_LOOP($1){}dnl
__{}_MUL_DEF_ADD_BC($1)dnl
__{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
__{}define({PUSH_MUL_MK1_COST},_COST)dnl
__{}define({PUSH_MUL_MK1_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk1: HL * (2^a + 2^b)})})},
PUSH_MUL_MK1_0BITS,{1},{dnl
dnl n = 2^a - 2^b, a > b
dnl 60=64-4
__{}PUSH_MUL_MK1_NEGLOOP($1){}dnl
__{}_MUL_DEF_SUB_BC($1)dnl
__{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
__{}define({PUSH_MUL_MK1_COST},_COST)dnl
__{}define({PUSH_MUL_MK1_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk1: HL * (2^a - 2^b)})})},
PUSH_MUL_MK1_1BITS,{3},{dnl
dnl
dnl n = 2^a + 2^b + 2^c
dnl 11=8+2+1,69=64+4+1
__{}PUSH_MUL_MK1_LOOP($1){}dnl
__{}_MUL_DEF_ADD_BA($1)dnl
__{}define({PUSH_MUL_MK1_OUT},_OUTPUT){}dnl
__{}define({PUSH_MUL_MK1_COST},_COST)dnl
__{}define({PUSH_MUL_MK1_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk1: HL * (2^a + 2^b + 2^c)})})},
PUSH_MUL_MK1_0BITS,{2},{dnl
dnl
dnl n = 2^a - 2^b - 2^c, a > b > c
dnl 27=32-4-1,54=64-8-2
__{}PUSH_MUL_MK1_NEGLOOP($1){}dnl
__{}_MUL_DEF_SUB_BA($1)dnl
__{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
__{}define({PUSH_MUL_MK1_COST},_COST)dnl
__{}define({PUSH_MUL_MK1_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk1: HL * (2^a - 2^b - 2^c)})})},
eval(PUSH_MUL_MK1_1BITS <= PUSH_MUL_MK1_0BITS + 2),{1},{dnl
dnl n = 2^a + 2^b + 2^c + ...
__{}PUSH_MUL_MK1_LOOP($1){}dnl
__{}_MUL_DEF_ADD_DE($1)dnl
__{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
__{}define({PUSH_MUL_MK1_COST},_COST)dnl
__{}define({PUSH_MUL_MK1_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk1: HL * (2^a + 2^b + 2^c + ...)})})},
{dnl
dnl n = 2^a - 2^b - 2^c - ...
dnl 187=128+32+16+8+2+1=256-64-4-1
__{}PUSH_MUL_MK1_NEGLOOP($1){}dnl
__{}_MUL_DEF_SUB_DE($1)dnl
__{}define({PUSH_MUL_MK1_OUT},_OUTPUT)dnl
__{}define({PUSH_MUL_MK1_COST},_COST)dnl
__{}define({PUSH_MUL_MK1_INFO},{
__{}__{}PUSH_MUL_INFO_PLUS(}_COST{,$1,{Variant mk1: HL * (2^a - 2^b - 2^c - ...)})})dnl
})})dnl
dnl
dnl
dnl
