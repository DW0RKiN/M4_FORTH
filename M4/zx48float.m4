dnl ## ZX Spectrum 48 ROM Floating point Arithmetic
dnl
dnl
dnl
define({ZX_READCHAR},{dnl
__{}define({ZXTEMP_CHAR},substr(ZXTEMP_STRING,0,1)){}dnl
__{}define({ZXTEMP_STRING},substr(ZXTEMP_STRING,1)){}dnl
})dnl
dnl
dnl
define({ZX_READ_MANT},{dnl
__{}define({ZX_READ_TEMP},ZXTEMP_CHAR){}dnl
__{}ifelse(ZX_READ_TEMP,{p},{define({ZX_READ_TEMP},{0})}){}dnl
__{}ifelse(len(ZXTEMP_MANTISSA),{10},{define({ZX_READ_TEMP},{})}){}dnl
__{}define({ZXTEMP_MANTISSA},ZXTEMP_MANTISSA{}ZX_READ_TEMP){}dnl
__{}ifelse(ZXTEMP_CHAR,{p},{dnl
__{}__{}ifelse(eval(len(ZXTEMP_MANTISSA)<10),{1},{ZX_READ_MANT})},
__{}{dnl
__{}__{}ZX_READCHAR{}dnl
__{}__{}ZX_READ_MANT}){}dnl
}){}dnl
dnl
dnl
define({ZX48FSTRING_TO_FHEX},{dnl
__{}define({ZXTEMP_STRING},format({%a},$1)){}dnl
__{}ZX_READCHAR{}dnl                               # 0 or -+
__{}define({ZXTEMP_SIGN},0){}dnl
__{}define({ZXTEMP_EXP},{}){}dnl
__{}define({ZXTEMP_MANTISSA},{0x}){}dnl
__{}ifelse(ZXTEMP_CHAR,{+},{ZX_READCHAR}){}dnl
__{}ifelse(ZXTEMP_CHAR,{-},{ZX_READCHAR{}define({ZXTEMP_SIGN},0x80)}){}dnl
__{}ZX_READCHAR{}dnl                               # x
__{}ZX_READCHAR{}dnl                               # 1
__{}ifelse(ZXTEMP_CHAR,{1},{ZX_READCHAR}){}dnl     # .
__{}ifelse(ZXTEMP_CHAR,{.},{ZX_READCHAR}){}dnl     # ?
__{}ZX_READ_MANT{}dnl
__{}ifelse(ZXTEMP_CHAR,{p},{dnl
__{}__{}define({ZXTEMP_EXP},ZXTEMP_STRING){}dnl
__{}})dnl
__{}define({ZXTEMP_MANTISSA},format({0x%08x},eval((ZXTEMP_MANTISSA>>1) & 0x7FFFFFFF))){}dnl
__{}define({ZXTEMP_EXP},substr(__HEX_L(ZXTEMP_EXP+129),2)){}dnl
__{}ifelse(format({%a},$1),{0x0p+0},{define({ZXTEMP_EXP},{00})}){}dnl
__{}define({ZXTEMP_MANTISSA_1},format({%02x},eval(ZXTEMP_SIGN+((ZXTEMP_MANTISSA>>24) & 0x7F)))){}dnl
__{}define({ZXTEMP_MANTISSA_2},substr(__HEX_E(ZXTEMP_MANTISSA),2)){}dnl
__{}define({ZXTEMP_MANTISSA_3},substr(__HEX_H(ZXTEMP_MANTISSA),2)){}dnl
__{}define({ZXTEMP_MANTISSA_4},substr(__HEX_L(ZXTEMP_MANTISSA),2)){}dnl
}){}dnl
dnl
dnl # ---------------------
dnl
define({ZFLOAT2ARRAY},{dnl
__{}__ADD_TOKEN({__TOKEN_ZFLOAT2ARRAY},{zfloat2array},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZFLOAT2ARRAY},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}ZX48FSTRING_TO_FHEX($1){}dnl
__{}DB 0x{}ZXTEMP_EXP,0x{}ZXTEMP_MANTISSA_1,0x{}ZXTEMP_MANTISSA_2,0x{}ZXTEMP_MANTISSA_3,0x{}ZXTEMP_MANTISSA_4 ; = $1 = format({%a},$1){}dnl
}){}dnl
dnl
dnl
dnl # ???? wtf :D tiskne neco se zalomenim
define({ZADDR},{dnl
__{}__ADD_TOKEN({__TOKEN_ZADDR},{zaddr},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZADDR},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZADDR})
    call _ZADDR         ; 3:17      __INFO   ( -- )}){}dnl
dnl
dnl
dnl # Z@
define({ZFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_ZFETCH},{z@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZFETCH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#>0),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__def({USE_ZFETCH})
__{}__{}    call _ZFETCH        ; 3:17      __INFO   ( addr -- ) ( F: -- r )}){}dnl
}){}dnl
dnl
dnl
dnl # F!
define({ZX48FSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSTORE},{zx48fstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FSTORE},{})ifelse($1,{},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    call _ZX48FSTORE    ; 3:17      __INFO   ( addr -- ) ( F: r -- )}){}dnl
dnl
dnl
dnl # FOVER
define({ZX48FOVER},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FOVER},{zx48fover},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FOVER},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FOVER})
    call _ZX48FOVER     ; 3:17      __INFO   ( F: r1 r2 -- r1 r2 r1 )}){}dnl
dnl
dnl
define({PUSH_ZX48FPICK},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ZX48FPICK},{push_zx48fpick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ZX48FPICK},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}ifelse($1,{},{
__{}    .error {$0}($@): Missing parameter!},
__{}{dnl
__{}__{}ifelse($#,{1},{dnl
__{}__{}__{}ifelse(eval(($1)<1),{1},{
__{}__{}__{}__{}    .error {$0}($@): Bad parameter!},
__{}__{}__{}eval(($1)>51),{1},{
__{}__{}__{}__{}__def({USE_ZX48FPICK_BC})
__{}__{}__{}__{}    ld   BC, __HEX_HL(-5*($1))     ; 3:10      __INFO   ( F: -- r )
__{}__{}__{}__{}    call _ZX48FPICK_BC  ; 3:17      __INFO},
__{}__{}__{}{dnl
__{}__{}__{}__{}__def({USE_ZX48FPICK_C})
__{}__{}__{}__{}    ld    C, __HEX_L(-5*($1))       ; 2:7       __INFO   ( F: -- r )
__{}__{}__{}__{}    call _ZX48FPICK_C   ; 3:17      __INFO})},
__{}__{}{
__{}__{}    .error zx48fvariable($@): To many parameters!}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl # FROT
define({ZX48FROT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FROT},{zx48frot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FROT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FROT})
    call _ZX48FROT      ; 3:17      __INFO   ( F: r1 r2 r3 -- r2 r3 r1 )}){}dnl
dnl
dnl
dnl # FDROP
define({ZX48FDROP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FDROP},{zx48fdrop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FDROP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FDROP})
    call _ZX48FDROP     ; 3:17      __INFO   ( F: r -- )}){}dnl
dnl
dnl
dnl # FABS
define({ZX48FABS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FABS},{zx48fabs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FABS},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FABS})
    call _ZX48FABS      ; 3:17      __INFO   ( F: r1 -- abs(r1) )}){}dnl
dnl
dnl
dnl # F+
define({ZX48FADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FADD},{zx48fadd},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FADD})
    call _ZX48FADD      ; 3:17      __INFO   ( F: r1 r2 -- r1+r2 )}){}dnl
dnl
dnl
dnl # F-
define({ZX48FSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSUB},{zx48fsub},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSUB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FSUB})
    call _ZX48FSUB      ; 3:17      __INFO   ( F: r1 r2 -- r1-r2 )}){}dnl
dnl
dnl
dnl # FNEGATE
define({ZX48FNEGATE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FNEGATE},{zx48fnegate},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FNEGATE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FNEGATE})
    call _ZX48FNEGATE   ; 3:17      __INFO   ( F: r1 -- -r1 )}){}dnl
dnl
dnl
dnl # FSIN
define({ZX48FSIN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSIN},{zx48fsin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FSIN})
    call _ZX48FSIN      ; 3:17      __INFO   ( F: r1 -- sin(r1) )}){}dnl
dnl
dnl
dnl # FCOS
define({ZX48FCOS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FCOS},{zx48fcos},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FCOS},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FCOS})
    call _ZX48FCOS      ; 3:17      __INFO   ( F: r1 -- cos(r1) )}){}dnl
dnl
dnl
dnl # FTAN
define({ZX48FTAN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FTAN},{zx48ftan},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FTAN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FTAN})
    call _ZX48FTAN      ; 3:17      __INFO   ( F: r1 -- tan(r1) )}){}dnl
dnl
dnl
dnl # FASIN
define({ZX48FASIN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FASIN},{zx48fasin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FASIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FASIN})
    call _ZX48FASIN     ; 3:17      __INFO   ( F: r1 -- arcsin(r1) )}){}dnl
dnl
dnl
dnl # FACOS
define({ZX48FACOS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FACOS},{zx48facos},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FACOS},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FACOS})
    call _ZX48FACOS     ; 3:17      __INFO   ( F: r1 -- arccos(r1) )}){}dnl
dnl
dnl
dnl # FATAN
define({ZX48FATAN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FATAN},{zx48fatan},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FATAN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FATAN})
    call _ZX48FATAN     ; 3:17      __INFO   ( F: r1 -- arctan(r1) )}){}dnl
dnl
dnl
dnl # FLN
define({ZX48FLN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FLN},{zx48fln},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FLN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FLN})
    call _ZX48FLN       ; 3:17      __INFO   ( F: r1 -- ln(r1) )}){}dnl
dnl
dnl
dnl # FEXP
define({ZX48FEXP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FEXP},{zx48fexp},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FEXP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FEXP})
    call _ZX48FEXP      ; 3:17      __INFO   ( F: r1 -- e^r1 )}){}dnl
dnl
dnl
dnl # FSQRT
define({ZX48FSQRT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSQRT},{zx48fsqrt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSQRT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FSQRT})
    call _ZX48FSQRT     ; 3:17      __INFO   ( F: r1 -- r1^0.5 )}){}dnl
dnl
dnl
dnl # ( F: r -- r r )
define({ZX48FDUP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FDUP},{zx48fdup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FDUP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FDUP})
    call _ZX48FDUP      ; 3:17      __INFO   ( F: r -- r r )}){}dnl
dnl
dnl
dnl # F.
define({ZX48FDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FDOT},{zx48fdot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FDOT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FDOT})
    call _ZX48FDOT      ; 3:17      __INFO   ( F: r -- )}){}dnl
dnl
dnl
dnl # ( F: r -- r )  "13,57,9A,CD,EF "
define({ZX48FHEXDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FHEXDOT},{zx48fhexdot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FHEXDOT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FHEXDOT})
    call _ZX48FHEXDOT   ; 3:17      __INFO   ( F: r -- r )}){}dnl
dnl
dnl
dnl
define({ZX48FINT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FINT},{zx48fint},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FINT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FINT})
    call _ZX48FINT      ; 3:17      __INFO   ( F: r -- x )}){}dnl
dnl
dnl
dnl # FSWAP
define({ZX48FSWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSWAP},{zx48fswap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FSWAP})
    call _ZX48FSWAP     ; 3:17      __INFO   ( F: r1 r2 -- r2 r1 )}){}dnl
dnl
dnl
dnl # F*
define({ZX48FMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FMUL},{zx48fmul},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FMUL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZX48FMUL})
    call _ZX48FMUL      ; 3:17      __INFO   ( F: r1 r2 -- r1*r2 )}){}dnl
dnl
dnl
dnl # Z**
define({ZMULMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_ZMULMUL},{z**},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZMULMUL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZMULMUL})
    call _ZMULMUL       ; 3:17      __INFO   ( F: r1 r2 -- r1^r2 )}){}dnl
dnl
dnl
dnl # Z/
define({ZDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_ZDIV},{z/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZDIV},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZDIV})
    call _ZDIV          ; 3:17      __INFO   ( F: r1 r2 -- r1/r2 )}){}dnl
dnl
dnl
dnl
define({ZUMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_ZUMUL},{zumul},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZUMUL},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[4:27]     __INFO   ( c b a -- c b*a )
    call 0x30a9         ; 3:17      __INFO   {call ZX ROM HL=HL*DE routine}
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # Z<=
define({ZLE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZLE},{z<=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZLE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x09       ; 2:7       __INFO   ( F: r1 r2 -- 1 or 0 )
    call _ZCOMPARE      ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # Z>=
define({ZGE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZGE},{z>=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZGE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0A       ; 2:7       __INFO   ( F: r1 r2 -- 1 or 0 )
    call _ZCOMPARE      ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # Z<>
define({ZNE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZNE},{z<>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZNE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0B       ; 2:7       __INFO   ( F: r1 r2 -- 1 or 0 )
    call _ZCOMPARE      ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # Z>
define({ZGT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZGT},{z>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZGT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0C       ; 2:7       __INFO   ( F: r1 r2 -- 1 or 0 )
    call _ZCOMPARE      ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # Z<
define({ZLT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FLT},{z<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FLT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0D       ; 2:7       __INFO   ( F: r1 r2 -- 1 or 0 )
    call _ZCOMPARE      ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # Z=
define({ZEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_ZEQ},{z=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZEQ},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0E       ; 2:7       __INFO   ( F: r1 r2 -- 1 or 0 )
    call _ZCOMPARE      ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # U>Z
define({U_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_U_TO_Z},{u>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_U_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_U_TO_Z})
    call _U_TO_F        ; 3:17      __INFO   ( u -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl # u u>z
define({PUSH_U_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_U_TO_Z},{$1 u>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_U_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),1,{dnl
__{}__{}__def({USE_BC_TO_Z})
__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   ( F: -- $1 )
__{}__{}    call _BC_TO_Z       ; 3:17      __INFO},
__{}eval($1>=0),{1},{dnl
__{}__{}__def({USE_BC_TO_Z})
__{}__{}    ld   BC, format({%-11s},$1); 3:10      __INFO   ( F: -- $1 )
__{}__{}    call _BC_TO_Z       ; 3:17      __INFO},
__{}{dnl
__{}__{}__def({USE_ZNEGATE}){}dnl
__{}__{}__def({USE_BC_TO_Z})
__{}__{}    ld   BC, format({%-11s},eval(-($1))); 3:10      __INFO   ( F: -- $1 )
__{}__{}    call _BC_TO_Z       ; 3:17      __INFO
__{}__{}    call _ZNEGATE       ; 3:17      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # S>Z
define({S_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_S_TO_Z},{s>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_S_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_S_TO_Z})
    call _S_TO_Z        ; 3:17      __INFO   ( x -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl # x s>z
define({PUSH_S_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_S_TO_Z},{$1 s>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_S_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{dnl
__{}__def({USE_SIGN_BC_TO_Z}){}dnl
__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   ( F: -- $1 )
__{}    call _SIGN_BC_TO_Z  ; 3:17      __INFO},
__{}eval($1>=0),{1},{dnl
__{}    ld   BC, format({%-11s},$1); 3:10      __INFO   ( F: -- $1 )
__{}ifelse(eval(($1) & 0x8000),{0},{dnl
__{}__{}__def({USE_SIGN_BC_TO_Z}){}dnl
__{}__{}    call _SIGN_BC_TO_Z  ; 3:17      __INFO   $1 == 0 0??????? ????????},
__{}{dnl
__{}__{}__def({USE_CF_BC_TO_Z}){}dnl
__{}__{}    xor   A             ; 1:4       __INFO   $1 == 0 1??????? ????????
__{}__{}    call _CF_BC_TO_Z    ; 3:17      __INFO})},
__{}{dnl
__{}    ld   BC, format({%-11s},$1); 3:10      __INFO   ( F: -- $1 )
__{}ifelse(eval(($1) & 0x8000),{0},{dnl
__{}__{}__def({USE_CF_BC_TO_Z}){}dnl
__{}__{}    scf                 ; 1:4       __INFO   $1 == 1 0??????? ????????
__{}__{}    call _CF_BC_TO_Z    ; 3:17      __INFO},
__{}{dnl
__{}__{}__def({USE_SIGN_BC_TO_Z}){}dnl
__{}__{}    call _SIGN_BC_TO_Z  ; 3:17      __INFO   $1 == 1 1??????? ????????})}){}dnl
})dnl
dnl
dnl
define({PUSH_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_Z},{push_z($1)},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<1),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{ZX48FSTRING_TO_FHEX($1)
                       ;[15:195]    __INFO   = format({%a},$1)
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld    A, 0x{}ZXTEMP_EXP       ; 2:7       __INFO
    ld   DE, 0x{}ZXTEMP_MANTISSA_2{}ZXTEMP_MANTISSA_1     ; 3:10      __INFO
    ld   BC, 0x{}ZXTEMP_MANTISSA_4{}ZXTEMP_MANTISSA_3     ; 3:10      __INFO
    call 0x2ABB         ; 3:124     __INFO   new float = a,e,d,c,b
    pop  HL             ; 1:11      __INFO
    pop  DE             ; 1:11      __INFO
}){}dnl
}){}dnl
dnl
dnl
dnl # r>s
define({R_TO_S},{dnl
__{}__ADD_TOKEN({__TOKEN_R_TO_S},{r>s},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_R_TO_S},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_R_TO_S})
    call _R_TO_S        ; 3:17      __INFO   ( -- x ) ( F: r -- )}){}dnl
dnl
dnl
dnl # d>z
define({D_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_D_TO_Z},{d>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_D_TO_Z})
    call _D_TO_Z        ; 3:17      __INFO   ( d -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl # z>d
define({Z_TO_D},{dnl
__{}__ADD_TOKEN({__TOKEN_Z_TO_D},{z>d},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_Z_TO_D},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_Z_TO_D})
    call _Z_TO_D        ; 3:17      __INFO   ( -- d ) ( F: r -- )}){}dnl
dnl
dnl
dnl
dnl # zfloat+
dnl # sizeof(z) = 5
define({ZFLOATADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ZFLOATADD},{zfloat+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZFLOATADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld   BC, 0x0005     ; 3:10      __INFO   ( a1 -- a2 ) ( F: -- )
    add  HL, BC         ; 1:11      __INFO}){}dnl
dnl
dnl
dnl # z0=
define({Z0EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_Z0EQ},{z0=},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_Z0EQ},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}__def({USE_Z0EQ})
    call _Z0EQ          ; 3:17      __INFO   ( -- flag ) ( F: r -- )}){}dnl
dnl
dnl
dnl # z0<
define({Z0LT},{dnl
__{}__ADD_TOKEN({__TOKEN_Z0LT},{z0<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_Z0LT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_Z0LT})
    call _Z0LT          ; 3:17      __INFO   ( -- flag ) ( F: r -- )}){}dnl
dnl
dnl
dnl
define({ZVARIABLE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZVARIABLE},{zvariable},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZVARIABLE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}ifelse($1,{},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}    .error zvariable($@): Missing parameter with variable name!})},
__{}{dnl
__{}__{}ifelse($#,{1},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}$1:
__{}__{}  db 0x00
__{}__{}  db 0x00
__{}__{}  db 0x00
__{}__{}  db 0x00
__{}__{}  db 0x00})},
__{}__{}$#,{2},{ZX48FSTRING_TO_FHEX($2)define({ALL_VARIABLE},ALL_VARIABLE
__{}__{}format({%-24s},$1:); = $2 = format({%a},$2) = exp:0x{}ZXTEMP_EXP mantissa:0x{}ZXTEMP_MANTISSA_1{}ZXTEMP_MANTISSA_2{}ZXTEMP_MANTISSA_3{}ZXTEMP_MANTISSA_4 (big-endien)
__{}__{}  db 0x{}ZXTEMP_EXP
__{}__{}  dw 0x{}ZXTEMP_MANTISSA_2{}ZXTEMP_MANTISSA_1
__{}__{}  dw 0x{}ZXTEMP_MANTISSA_4{}ZXTEMP_MANTISSA_3)},
__{}__{}{define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}    .error zvariable($@): To many parameters!})}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
