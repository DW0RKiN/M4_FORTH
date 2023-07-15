dnl ## FLoat
dnl
define({carry_flow_warning},1){}dnl
include(M4PATH{}float_const.m4){}dnl
dnl
dnl
dnl
define({FPUSH},{dnl
__{}define({$0_SIGN},0){}dnl
__{}ifelse(substr($1,0,1),{-},{dnl
__{}__{}define({$0_SIGN},0x8000){}dnl
__{}__{}define({$0_HEX_REAL},{__HEX_FLOAT(substr($1,1))})},
__{}substr($1,0,1),{+},{dnl
__{}__{}define({$0_HEX_REAL},{__HEX_FLOAT(substr($1,1))})},
__{}{dnl
__{}__{}define({$0_HEX_REAL},{__HEX_FLOAT($1)})}){}dnl
__{}dnl
__{}ifelse($0_SIGN:$0_HEX_REAL,{0x8000:0x0p+0},{
__{}__{}  .WARNING You are trying to convert "negative zero" to Danagy 16 bit floating point format, so it will be changed to a negative value closest to zero.{}dnl  
__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},FMMIN)},
__{}$0_HEX_REAL,{0x0p+0},{
__{}__{}  .WARNING You are trying to convert "positive zero" to Danagy 16 bit floating point format, so it will be changed to a positive value closest to zero.{}dnl
__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},FPMIN)},
__{}$0_SIGN:$0_HEX_REAL,{0x8000:inf},{
__{}__{}  .WARNING You are trying to convert "-inf" to Danagy 16 bit floating point format. It will be converted as a smallest possible value.{}dnl
__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},FMMAX)},
__{}$0_HEX_REAL,{inf},{
__{}__{}  .WARNING You are trying to convert "+inf" to Danagy 16 bit floating point format. It will be converted as a largest possible value.{}dnl
__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},FPMAX)},
__{}$0_HEX_REAL,{nan},{
__{}__{}  .WARNING You are trying to convert "Not a Number" to Danagy 16 bit floating point format. It will be converted as a positive value closest to zero.{}dnl
__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},FPMIN)},
__{}{dnl
__{}__{}dnl    # Výpočet exponentu
__{}__{}define({$0_EXP},{eval(substr($0_HEX_REAL,incr(index($0_HEX_REAL,{p}))) + 0x40)}){}dnl
__{}__{}dnl    # Výpočet mantisy    
__{}__{}define({$0_MAN},{substr($0_HEX_REAL,incr(index($0_HEX_REAL,{x})),eval(index($0_HEX_REAL,{p})-index($0_HEX_REAL,{x})-1))}){}dnl
__{}__{}ifelse(substr($0_MAN,0,2),{1.},{define({$0_MAN},{1}substr($0_MAN,2))}){}dnl
__{}__{}define({$0_MAN},$0_MAN{000}){}dnl
__{}__{}define({$0_ROUND_NIBBLE},substr($0_MAN,3,1)){}dnl
__{}__{}define({$0_MAN},{0x}substr($0_MAN,0,3)){}dnl
__{}__{}ifelse(eval({0x}$0_ROUND_NIBBLE>7),1,{define({$0_MAN},eval($0_MAN+1))}){}dnl
__{}__{}ifelse(__HEX_HL($0_MAN),0x0200,{dnl
__{}__{}__{}define({$0_EXP},incr($0_EXP)){}dnl
__{}__{}__{}define({$0_MAN},0)},
__{}__{}{dnl
__{}__{}__{}define({$0_MAN},eval($0_MAN-0x100))}){}dnl
__{}__{}dnl
__{}__{}ifelse(eval(($0_EXP-0x48)>=0),1,{dnl
__{}__{}__{}define({$0_REAL},eval(($0_MAN+256)*__POW(2,eval($0_EXP-0x48))))},
__{}__{}{dnl
__{}__{}__{}define({$0_REAL},eval($0_MAN+256)/__POW(2,eval(0x48-$0_EXP)))}){}dnl
__{}__{}dnl
__{}__{}ifelse(1,0,{
__{}__{}__{}$0_HEX_REAL
__{}__{}__{}s:$0_SIGN
__{}__{}__{}e:$0_EXP = __HEX_L($0_EXP) = eval($0_EXP-0x48)
__{}__{}__{}m:__HEX_HL($0_MAN)
__{}__{}__{}i:$0_REAL}){}dnl
__{}__{}dnl
__{}__{}ifelse(eval(($0_EXP < 0) && $0_SIGN),1,{
__{}__{}__{}  .WARNING The value "$1" is too close to zero, so it will be changed to a negative value closest to zero.{}dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},FMMIN)},
__{}__{}eval($0_EXP < 0 ),1,{
__{}__{}__{}  .WARNING The value "$1" is too close to zero, so it will be changed to a positive value closest to zero.{}dnl    
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},FPMIN)},
__{}__{}eval(($0_EXP > 0x7F) && $0_SIGN ),1,{
__{}__{}__{}  .WARNING The value "$1" is less than the smallest possible value, so it will be changed to the smallest possible value.{}dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},FMMAX)},  
__{}__{}eval($0_EXP > 0x7F),1,{
__{}__{}__{}  .WARNING The value "$1" is greater than the largest possible value, so it will be changed to the largest possible value.{}dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1},FPMAX)},  
__{}__{}{dnl   # Sestavení hexadecimální hodnoty
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSH},{$1 -> }$0_REAL,__HEX_HL($0_SIGN + $0_EXP * 0x100 + $0_MAN)){}dnl
__{}__{}}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
dnl # ( s1 -- f1 )
define({S2F},{dnl
__{}__ADD_TOKEN({__TOKEN_S2F},{s>f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_S2F},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fIld})
    call fIld           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( u1 -- f1 )
define({U2F},{dnl
__{}__ADD_TOKEN({__TOKEN_U2F},{u>f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_U2F},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fWld})
    call fWld           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- s1 )
define({F2S},{dnl
__{}__ADD_TOKEN({__TOKEN_F2S},{f>s},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2S},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fIst})
    call fIst           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- u1 )
define({F2U},{dnl
__{}__ADD_TOKEN({__TOKEN_F2U},{f>u},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2U},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fWst})
    call fWst           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 + f1
define({FADD},{dnl
__{}__ADD_TOKEN({__TOKEN_FADD},{f+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fAdd})
    call fAdd           ; 3:17      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 + f1
define({FSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_FSUB},{f-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FSUB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fSub})
    call fSub           ; 3:17      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- -f1 )
define({FNEGATE},{dnl
__{}__ADD_TOKEN({__TOKEN_FNEGATE},{fnegate},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FNEGATE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, H          ; 1:4       __INFO
    xor  0x80           ; 2:7       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
define({FABS},{dnl
__{}__ADD_TOKEN({__TOKEN_FABS},{fabs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FABS},{dnl
__{}define({__INFO},__COMPILE_INFO)
    res   7, H          ; 2:8       __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- )
define({FDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_FDOT},{f.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FDOT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fDot})
    call fDot           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 * f1
define({FMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_FMUL},{f*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FMUL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fMul})
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO
    call fMul           ; 3:17      __INFO   HL = BC*DE
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 / f1
define({FDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_FDIV},{f/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FDIV},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fDiv})
    ld    B, D          ; 1:4       __INFO
    ld    C, E          ; 1:4       __INFO
    call fDiv           ; 3:17      __INFO   HL = BC/HL
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 / f1
define({FSQRT},{dnl
__{}__ADD_TOKEN({__TOKEN_FSQRT},{fsqrt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FSQRT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fSqrt})
    call fSqrt          ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # "round towards zero"
define({FTRUNC},{dnl
__{}__ADD_TOKEN({__TOKEN_FTRUNC},{ftrunc},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FTRUNC},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fTrunc})
    call fTrunc         ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( uf1 -- uf2 )
dnl # "round down to zero"
define({FTRUNC_ABS},{dnl
__{}__ADD_TOKEN({__TOKEN_FTRUNC_ABS},{ftrunc_abs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FTRUNC_ABS},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fTrunc_abs})
    call fTrunc_abs     ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # "round towards negative infinity"
define({FLOOR},{dnl
__{}__ADD_TOKEN({__TOKEN_FLOOR},{floor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FLOOR},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fFloor}){}dnl
__{}__def({USE_fTrunc_abs}){}dnl
__{}__def({USE_fAdd})
    call fFloor         ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = f1 % 1.0
define({FFRAC},{dnl
__{}__ADD_TOKEN({__TOKEN_FFRAC},{ffrac},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FFRAC},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fFrac})
    call fFrac          ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = e^f1
define({FEXP},{dnl
__{}__ADD_TOKEN({__TOKEN_FEXP},{fexp},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FEXP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fExp})
    push DE             ; 1:11      __INFO
    call fExp           ; 3:17      __INFO   HL = e^HL
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = ln(f1)
define({FLN},{dnl
__{}__ADD_TOKEN({__TOKEN_FLN},{fln},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FLN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fLn})
    push DE             ; 1:11      __INFO
    call fLn            ; 3:17      __INFO   HL = ln(HL)
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = sin(f1)
define({FSIN},{dnl
__{}__ADD_TOKEN({__TOKEN_FSIN},{fsin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FSIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fSin})
    push DE             ; 1:11      __INFO
    call fSin           ; 3:17      __INFO   HL = sin(HL)
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 f2 -- f3 )
dnl # f3 = f1 % f2
define({FMOD},{dnl
__{}__ADD_TOKEN({__TOKEN_FMOD},{fmod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FMOD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fMod})
    ld    B, D          ; 1:4       __INFO
    ld    C, E          ; 1:4       __INFO
    call fMod           ; 3:17      __INFO   HL = BC % HL
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = f1 * 2.0
define({F2MUL},{dnl
__{}__ADD_TOKEN({__TOKEN_F2MUL},{f2*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2MUL},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc   H             ;  1:4      __INFO
    .WARNING The exponent is not tested and may overflow!}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = f1 / 2.0
define({F2DIV},{dnl
__{}__ADD_TOKEN({__TOKEN_F2DIV},{f2/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2DIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
    dec   H             ;  1:4      __INFO
    .WARNING The exponent is not tested and may underflow!}){}dnl
dnl
dnl
dnl
dnl # f0=
dnl # ( f -- flag )
dnl # if ( f == +-0e ) flag = -1; else flag = 0;
dnl # 0 if 16-bit floating point number not equal to +-zero, -1 if equal
define({F0EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_F0EQ},{f0=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F0EQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(TYP_FLOAT,{small},{
__{}                        ;[6:40]     __INFO   ( f -- flag )  flag: f == +-0e  # version: TYP_FLOAT = small; other: default
__{}    add  HL, HL         ; 1:11      __INFO   sign out
__{}    ld    A, H          ; 1:4       __INFO
__{}    dec  HL             ; 1:6       __INFO
__{}    sub   H             ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag},
__{}{
__{}                        ;[7:34]     __INFO   ( f -- flag )  flag: f == +-0e  # version: TYP_FLOAT = default; other: small
__{}    ld    A, H          ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO
__{}    or    L             ; 1:4       __INFO
__{}    sub  0x01           ; 2:7       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # f0<
dnl # ( f -- flag )
define({F0LT},{dnl
__{}__ADD_TOKEN({__TOKEN_F0LT},{f0<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F0LT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(TYP_FLOAT,{small},{
__{}                        ;[6:33]     __INFO   ( f -- flag )  flag: f < +-0e  # version: TYP_FLOAT = small; other: default
__{}    ld    A, H          ; 1:4       __INFO
__{}    dec  HL             ; 1:6       __INFO
__{}    and   H             ; 1:4       __INFO   negative without +-0e
__{}    add   A, A          ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag},
__{}TYP_FLOAT,{no_A},{
__{}                        ;[6:36]     __INFO   ( f -- flag )  flag: f < +-0e  # version: TYP_FLOAT = small; other: default
__{}    ld   BC, 0x7FFF     ; 3:10      __INFO
__{}    add  HL, BC         ; 1:11      __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag},
__{}{
__{}                        ;[7:30]     __INFO   ( f -- flag )  flag: f < +-0e  # version: TYP_FLOAT = default; other: small
__{}    ld    A, H          ; 1:4       __INFO
__{}    dec  HL             ; 1:6       __INFO
__{}    and   H             ; 1:4       __INFO   negative without +-0e
__{}    add   A, A          ; 1:4       __INFO
__{}    sbc   A, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO
__{}    ld    L, A          ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup f0=
dnl # ( f -- f flag )
dnl # if ( f == +-0e ) flag = -1; else flag = 0;
dnl # 0 if 16-bit floating point number not equal to +-zero, -1 if equal
define({DUP_F0EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_F0EQ},{dup f0=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_F0EQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:49]     __INFO   ( f -- f flag )  flag: f == +-0e
    ld    A, H          ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    sub  0x01           ; 2:7       __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = flag{}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup f0<
dnl # ( f -- f flag )
define({DUP_F0LT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_F0LT},{dup f0<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_F0LT},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:51]     __INFO   ( f -- f flag )  flag: f < +-0e
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, 0x7FFF     ; 3:10      __INFO
    add  HL, DE         ; 1:11      __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = flag{}dnl
}){}dnl
dnl
dnl
dnl
dnl # f<
dnl # ( f1 f2 -- flag )
define({FLT},{dnl
__{}__ADD_TOKEN({__TOKEN_FLT},{f<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FLT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(1,0,{
__{}                       ;[12:67]     __INFO   ( f1 f2 -- flag )  flag: f1 < f2
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    rlca                ; 1:4       __INFO   set carry and 0 bit
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO   f1<f2 --> f1-f2<0 --> carry if true
__{}    adc   A, 0x00       ; 2:7       __INFO   invert carry?
__{}    rra                 ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag},

1,0,{
__{}                       ;[13:70]     __INFO   ( f1 f2 -- flag )  flag: f1 < f2
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO   i... ....
__{}    sbc  HL, DE         ; 2:15      __INFO   f1<f2 --> f1-f2<0 --> carry if true
__{}    jr    z, $+6        ; 2:7/12    __INFO
__{}    rra                 ; 1:4       __INFO   ci.. ....
__{}    sub  0x40           ; 2:7       __INFO   f... ....
__{}    add   A, A          ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag},

__{}{
__{}                       ;[11:62]     __INFO   ( f1 f2 -- flag )  flag: f1 < f2
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    jp    m, $+4        ; 3:10      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO   f1<f2 --> f1-f2<0 --> carry if true
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup f<
dnl # ( f1 f2 -- f1 f2 flag )
define({_2DUP_FLT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_FLT},{2dup f<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_FLT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(1,0,{
__{}                       ;[13:84]     __INFO   ( f1 f2 -- f1 f2 flag )  flag: f1 < f2
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    jp    m, $+4        ; 3:10      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO   f1<f2 --> f1-f2<0 --> carry if true
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO},
1,0,{
__{}                       ;[15:74]     __INFO   ( f1 f2 -- f1 f2 flag )  flag: f1 < f2
__{}    push DE             ; 1:11      __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO   set carry
__{}    ld    A, E          ; 1:4       __INFO
__{}    sbc   A, L          ; 1:4       __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    sbc   A, H          ; 1:4       __INFO   f1<f2 --> f1-f2<0 --> carry if true
__{}    rra                 ; 1:4       __INFO
__{}    xor   C             ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag},
{
__{}                       ;[12:68]     __INFO   ( f1 f2 -- f1 f2 flag )  flag: f1 < f2
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    rlca                ; 1:4       __INFO   set carry and 0 bit
__{}    sbc  HL, DE         ; 2:15      __INFO   f1<f2 --> f1-f2<0 --> carry if true
__{}    adc   A, 0x00       ; 2:7       __INFO   invert carry?
__{}    rra                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # f>
dnl # ( f1 f2 -- flag )
define({FGT},{dnl
__{}__ADD_TOKEN({__TOKEN_FGT},{f>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FGT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(1,1,{
__{}                       ;[11:63]     __INFO   ( f1 f2 -- flag )  flag: f1 > f2
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    rlca                ; 1:4       __INFO   set carry and 0 bit
__{}    sbc  HL, DE         ; 2:15      __INFO   f1>f2 --> 0>f2-f1 --> carry if true
__{}    adc   A, 0x00       ; 2:7       __INFO   invert carry?
__{}    rra                 ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag},

__{}{
__{}                       ;[11:62]     __INFO   ( f1 f2 -- flag )  flag: f1 > f2
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    jp    p, $+4        ; 3:10      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO   f1>f2 --> 0>f2-f1 --> carry if true
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup f>
dnl # ( f1 f2 -- f1 f2 flag )
define({_2DUP_FGT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_FGT},{2dup f>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_FGT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(1,0,{
__{}                       ;[13:84]     __INFO   ( f1 f2 -- f1 f2 flag )  flag: f1 > f2
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    jp    p, $+4        ; 3:10      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO   f1>f2 --> 0>f2-f1 --> carry if true
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO},

1,1,{
__{}                       ;[13:72]     __INFO   ( f1 f2 -- f1 f2 flag )  flag: f1 > f2
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    rlca                ; 1:4       __INFO   set carry and 0 bit
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO   f1>f2 --> 0>f2-f1 --> carry if true
__{}    adc   A, 0x01       ; 2:7       __INFO   invert carry?
__{}    rra                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag},

1,1,{
__{}                       ;[14:75]     __INFO   ( f1 f2 -- f1 f2 flag )  flag: f1 > f2
__{}    push DE             ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO   i... ....
__{}    sbc  HL, DE         ; 2:15      __INFO   f1<f2 --> f1-f2<0 --> carry if true
__{}    jr    z, $+6        ; 2:7/12    __INFO   remove fail with -x -x
__{}    adc   A, A          ; 1:4       __INFO   i .... ...c
__{}    sbc   A, 0x00       ; 2:7       __INFO     .... ...?
__{}    rra                 ; 1:4       __INFO     .... .... ?
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # f>=
dnl # ( f1 f2 -- flag )
define({FGE},{dnl
__{}__ADD_TOKEN({__TOKEN_FGE},{f>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FGE},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}                       ;[12:66]     __INFO   ( f1 f2 -- flag )  flag: f1 >= f2
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    D             ; 1:4       __INFO
__{}    jp    m, $+4        ; 3:10      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO   f1>=f2 --> f1-f2>=0 --> not carry if true
__{}    ccf                 ; 1:4       __INFO
__{}    sbc  HL, HL         ; 2:15      __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO{}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2dup f>=
dnl # ( f1 f2 -- f1 f2 flag )
define({_2DUP_FGE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_FGE},{2dup f>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_FGE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[12:68]     __INFO   ( f1 f2 -- f1 f2 flag )  flag: f1 >= f2
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    A, H          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    rlca                ; 1:4       __INFO   set carry and 0 bit
    sbc  HL, DE         ; 2:15      __INFO   f1>=f2 --> f1-f2>=0 --> not carry if true
    adc   A, 0x01       ; 2:7       __INFO   invert carry?
    rra                 ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = flag}){}dnl
dnl
dnl
dnl
dnl # f<=
dnl # ( f1 f2 -- flag )
define({FLE},{dnl
__{}__ADD_TOKEN({__TOKEN_FLE},{f<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FLE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[11:63]     __INFO   ( f1 f2 -- flag )  flag: f1 <= f2
    ld    A, H          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    rlca                ; 1:4       __INFO   set carry and 0 bit
    sbc  HL, DE         ; 2:15      __INFO   f1>f2 --> 0>f2-f1 --> carry if true
    adc   A, 0x01       ; 2:7       __INFO   invert carry?
    rra                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = flag}){}dnl
dnl
dnl
dnl
dnl # 2dup f<=
dnl # ( f1 f2 -- f1 f2 flag )
define({_2DUP_FLE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_FLE},{2dup f<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_FLE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                       ;[13:72]     __INFO   ( f1 f2 -- f1 f2 flag )  flag: f1 <= f2
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    A, H          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    rlca                ; 1:4       __INFO   set carry and 0 bit
    ccf                 ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO   f1>f2 --> 0>f2-f1 --> carry if true
    adc   A, 0x00       ; 2:7       __INFO   invert carry?
    rra                 ; 1:4       __INFO
    sbc  HL, HL         ; 2:15      __INFO   HL = flag}){}dnl
dnl
dnl
dnl
dnl
