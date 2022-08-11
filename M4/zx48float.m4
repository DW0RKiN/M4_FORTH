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
__{}define({ZXTEMP_EXP},__HEX_L(ZXTEMP_EXP+129)){}dnl
__{}ifelse(format({%a},$1),{0x0p+0},{define({ZXTEMP_EXP},{00})}){}dnl
__{}define({ZXTEMP_MANTISSA_1},format({%02x},eval(ZXTEMP_SIGN+((ZXTEMP_MANTISSA>>24) & 0x7F)))){}dnl
__{}define({ZXTEMP_MANTISSA_2},__HEX_E(ZXTEMP_MANTISSA)){}dnl
__{}define({ZXTEMP_MANTISSA_3},__HEX_H(ZXTEMP_MANTISSA)){}dnl
__{}define({ZXTEMP_MANTISSA_4},__HEX_L(ZXTEMP_MANTISSA)){}dnl
}){}dnl
dnl
dnl # ---------------------
dnl
define({ZX48FLOAT2ARRAY},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FLOAT2ARRAY},{zx48float2array},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FLOAT2ARRAY},{dnl
__{}define({__INFO},{zx48float2array}){}dnl
dnl
__{}ZX48FSTRING_TO_FHEX($1){}dnl
__{}DB 0x{}ZXTEMP_EXP,0x{}ZXTEMP_MANTISSA_1,0x{}ZXTEMP_MANTISSA_2,0x{}ZXTEMP_MANTISSA_3,0x{}ZXTEMP_MANTISSA_4 ; = $1 = format({%a},$1){}dnl
}){}dnl
dnl
dnl
dnl
define({ZX48FADDR},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FADDR},{zx48faddr},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FADDR},{dnl
__{}define({__INFO},{zx48faddr}){}dnl
define({USE_ZX48FADDR},{})
    call _ZX48FADDR     ; 3:17      zx48faddr   ( -- )}){}dnl
dnl
dnl
dnl # F@
define({ZX48FFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FFETCH},{zx48ffetch},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FFETCH},{dnl
__{}define({__INFO},{zx48ffetch}){}dnl
define({USE_ZX48FFETCH},{})ifelse($1,{},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    call _ZX48FFETCH    ; 3:17      zx48ffetch   ( addr -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl # F!
define({ZX48FSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSTORE},{zx48fstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSTORE},{dnl
__{}define({__INFO},{zx48fstore}){}dnl
define({USE_ZX48FSTORE},{})ifelse($1,{},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    call _ZX48FSTORE    ; 3:17      zx48fstore   ( addr -- ) ( F: r -- )}){}dnl
dnl
dnl
dnl # FOVER
define({ZX48FOVER},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FOVER},{zx48fover},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FOVER},{dnl
__{}define({__INFO},{zx48fover}){}dnl
define({USE_ZX48FOVER},{})
    call _ZX48FOVER     ; 3:17      fover zx48fover   ( F: r1 r2 -- r1 r2 r1 )}){}dnl
dnl
dnl
define({PUSH_ZX48FPICK},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ZX48FPICK},{push_zx48fpick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ZX48FPICK},{dnl
__{}define({__INFO},{push_zx48fpick}){}dnl
dnl
__{}ifelse($1,{},{
__{}    .error {$0}($@): Missing parameter!},
__{}{dnl
__{}__{}ifelse($#,{1},{dnl
__{}__{}__{}ifelse(eval(($1)<1),{1},{
__{}__{}__{}__{}    .error {$0}($@): Bad parameter!},
__{}__{}__{}eval(($1)>51),{1},{define({USE_ZX48FPICK_BC},{})
__{}__{}__{}__{}    ld   BC, __HEX_HL(-5*($1))     ; 3:10      $1 fpick  push_zx48fpick($1)   ( F: -- r )
__{}__{}__{}__{}    call _ZX48FPICK_BC  ; 3:17      $1 fpick  push_zx48fpick($1)},
__{}__{}__{}{define({USE_ZX48FPICK_C},{})
__{}__{}__{}__{}    ld    C, __HEX_L(-5*($1))       ; 2:7       $1 fpick  push_zx48fpick($1)   ( F: -- r )
__{}__{}__{}__{}    call _ZX48FPICK_C   ; 3:17      $1 fpick  push_zx48fpick($1)})},
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
__{}define({__INFO},{zx48frot}){}dnl
define({USE_ZX48FROT},{})
    call _ZX48FROT      ; 3:17      frot zx48frot   ( F: r1 r2 r3 -- r2 r3 r1 )}){}dnl
dnl
dnl
dnl # FDROP
define({ZX48FDROP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FDROP},{zx48fdrop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FDROP},{dnl
__{}define({__INFO},{zx48fdrop}){}dnl
define({USE_ZX48FDROP},{})
    call _ZX48FDROP     ; 3:17      fdrop zx48fdrop   ( F: r -- )}){}dnl
dnl
dnl
dnl # FABS
define({ZX48FABS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FABS},{zx48fabs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FABS},{dnl
__{}define({__INFO},{zx48fabs}){}dnl
define({USE_ZX48FABS},{})
    call _ZX48FABS      ; 3:17      fabs zx48fabs   ( F: r1 -- abs(r1) )}){}dnl
dnl
dnl
dnl # F+
define({ZX48FADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FADD},{zx48fadd},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FADD},{dnl
__{}define({__INFO},{zx48fadd}){}dnl
define({USE_ZX48FADD},{})
    call _ZX48FADD      ; 3:17      F+ zx48fadd   ( F: r1 r2 -- r1+r2 )}){}dnl
dnl
dnl
dnl # F-
define({ZX48FSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSUB},{zx48fsub},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSUB},{dnl
__{}define({__INFO},{zx48fsub}){}dnl
define({USE_ZX48FSUB},{})
    call _ZX48FSUB      ; 3:17      F- zx48fsub   ( F: r1 r2 -- r1-r2 )}){}dnl
dnl
dnl
dnl # FNEGATE
define({ZX48FNEGATE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FNEGATE},{zx48fnegate},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FNEGATE},{dnl
__{}define({__INFO},{zx48fnegate}){}dnl
define({USE_ZX48FNEGATE},{})
    call _ZX48FNEGATE   ; 3:17      fnegate zx48fnegate   ( F: r1 -- -r1 )}){}dnl
dnl
dnl
dnl # FSIN
define({ZX48FSIN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSIN},{zx48fsin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSIN},{dnl
__{}define({__INFO},{zx48fsin}){}dnl
define({USE_ZX48FSIN},{})
    call _ZX48FSIN      ; 3:17      zx48fsin   ( F: r1 -- sin(r1) )}){}dnl
dnl
dnl
dnl # FCOS
define({ZX48FCOS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FCOS},{zx48fcos},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FCOS},{dnl
__{}define({__INFO},{zx48fcos}){}dnl
define({USE_ZX48FCOS},{})
    call _ZX48FCOS      ; 3:17      zx48fcos   ( F: r1 -- cos(r1) )}){}dnl
dnl
dnl
dnl # FTAN
define({ZX48FTAN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FTAN},{zx48ftan},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FTAN},{dnl
__{}define({__INFO},{zx48ftan}){}dnl
define({USE_ZX48FTAN},{})
    call _ZX48FTAN      ; 3:17      zx48ftan   ( F: r1 -- tan(r1) )}){}dnl
dnl
dnl
dnl # FASIN
define({ZX48FASIN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FASIN},{zx48fasin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FASIN},{dnl
__{}define({__INFO},{zx48fasin}){}dnl
define({USE_ZX48FASIN},{})
    call _ZX48FASIN     ; 3:17      zx48fasin   ( F: r1 -- arcsin(r1) )}){}dnl
dnl
dnl
dnl # FACOS
define({ZX48FACOS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FACOS},{zx48facos},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FACOS},{dnl
__{}define({__INFO},{zx48facos}){}dnl
define({USE_ZX48FACOS},{})
    call _ZX48FACOS     ; 3:17      zx48facos   ( F: r1 -- arccos(r1) )}){}dnl
dnl
dnl
dnl # FATAN
define({ZX48FATAN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FATAN},{zx48fatan},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FATAN},{dnl
__{}define({__INFO},{zx48fatan}){}dnl
define({USE_ZX48FATAN},{})
    call _ZX48FATAN     ; 3:17      zx48fatan   ( F: r1 -- arctan(r1) )}){}dnl
dnl
dnl
dnl # FLN
define({ZX48FLN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FLN},{zx48fln},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FLN},{dnl
__{}define({__INFO},{zx48fln}){}dnl
define({USE_ZX48FLN},{})
    call _ZX48FLN       ; 3:17      zx48fln   ( F: r1 -- ln(r1) )}){}dnl
dnl
dnl
dnl # FEXP
define({ZX48FEXP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FEXP},{zx48fexp},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FEXP},{dnl
__{}define({__INFO},{zx48fexp}){}dnl
define({USE_ZX48FEXP},{})
    call _ZX48FEXP      ; 3:17      zx48fexp   ( F: r1 -- e^r1 )}){}dnl
dnl
dnl
dnl # FSQRT
define({ZX48FSQRT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSQRT},{zx48fsqrt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSQRT},{dnl
__{}define({__INFO},{zx48fsqrt}){}dnl
define({USE_ZX48FSQRT},{})
    call _ZX48FSQRT     ; 3:17      zx48fsqrt   ( F: r1 -- r1^0.5 )}){}dnl
dnl
dnl
dnl # ( F: r -- r r )
define({ZX48FDUP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FDUP},{zx48fdup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FDUP},{dnl
__{}define({__INFO},{zx48fdup}){}dnl
define({USE_ZX48FDUP},{})
    call _ZX48FDUP      ; 3:17      zx48fdup   ( F: r -- r r )}){}dnl
dnl
dnl
dnl # F.
define({ZX48FDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FDOT},{zx48fdot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FDOT},{dnl
__{}define({__INFO},{zx48fdot}){}dnl
define({USE_ZX48FDOT},{})
    call _ZX48FDOT      ; 3:17      zx48fdot   ( F: r -- )}){}dnl
dnl
dnl
dnl # ( F: r -- r )  "13,57,9A,CD,EF "
define({ZX48FHEXDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FHEXDOT},{zx48fhexdot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FHEXDOT},{dnl
__{}define({__INFO},{zx48fhexdot}){}dnl
define({USE_ZX48FHEXDOT},{})
    call _ZX48FHEXDOT   ; 3:17      zx48fhexdot   ( F: r -- r )}){}dnl
dnl
dnl
dnl
define({ZX48FINT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FINT},{zx48fint},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FINT},{dnl
__{}define({__INFO},{zx48fint}){}dnl
define({USE_ZX48FINT},{})
    call _ZX48FINT      ; 3:17      zx48fint   ( F: r -- x )}){}dnl
dnl
dnl
dnl # FSWAP
define({ZX48FSWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FSWAP},{zx48fswap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FSWAP},{dnl
__{}define({__INFO},{zx48fswap}){}dnl
define({USE_ZX48FSWAP},{})
    call _ZX48FSWAP     ; 3:17      zx48fswap   ( F: r1 r2 -- r2 r1 )}){}dnl
dnl
dnl
dnl # F*
define({ZX48FMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FMUL},{zx48fmul},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FMUL},{dnl
__{}define({__INFO},{zx48fmul}){}dnl
define({USE_ZX48FMUL},{})
    call _ZX48FMUL      ; 3:17      zx48fmul   ( F: r1 r2 -- r1*r2 )}){}dnl
dnl
dnl
dnl # F**
define({ZX48FMULMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FMULMUL},{zx48fmulmul},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FMULMUL},{dnl
__{}define({__INFO},{zx48fmulmul}){}dnl
define({USE_ZX48FMULMUL},{})
    call _ZX48FMULMUL   ; 3:17      zx48fmulmul   ( F: r1 r2 -- r1^r2 )}){}dnl
dnl
dnl
dnl # F/
define({ZX48FDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FDIV},{zx48fdiv},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FDIV},{dnl
__{}define({__INFO},{zx48fdiv}){}dnl
define({USE_ZX48FDIV},{})
    call _ZX48FDIV      ; 3:17      zx48fdiv   ( F: r1 r2 -- r1/r2 )}){}dnl
dnl
dnl
dnl
define({ZX48UMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48UMUL},{zx48umul},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48UMUL},{dnl
__{}define({__INFO},{zx48umul}){}dnl

                        ;[4:27]     zx48umul   ( c b a -- c b*a )
    call 0x30a9         ; 3:17      zx48umul   {call ZX ROM HL=HL*DE routine}
    pop  DE             ; 1:10      zx48umul}){}dnl
dnl
dnl
dnl
dnl # F<=
define({ZX48FLE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FLE},{zx48fle},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FLE},{dnl
__{}define({__INFO},{zx48fle}){}dnl
define({USE_ZX48FCOMPARE},{})
    ld    B, 0x09       ; 2:7       zx48f<=   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f<=}){}dnl
dnl
dnl
dnl # F>=
define({ZX48FGE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FGE},{zx48fge},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FGE},{dnl
__{}define({__INFO},{zx48fge}){}dnl
define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0A       ; 2:7       zx48f>=   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f>=}){}dnl
dnl
dnl
dnl # F<>
define({ZX48FNE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FNE},{zx48fne},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FNE},{dnl
__{}define({__INFO},{zx48fne}){}dnl
define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0B       ; 2:7       zx48f<>   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f<>}){}dnl
dnl
dnl
dnl # F>
define({ZX48FGT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FGT},{zx48fgt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FGT},{dnl
__{}define({__INFO},{zx48fgt}){}dnl
define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0C       ; 2:7       zx48f>   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f>}){}dnl
dnl
dnl
dnl # F<
define({ZX48FLT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FLT},{zx48flt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FLT},{dnl
__{}define({__INFO},{zx48flt}){}dnl
define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0D       ; 2:7       zx48f<   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f<}){}dnl
dnl
dnl
dnl # F=
define({ZX48FEQ},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FEQ},{zx48feq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FEQ},{dnl
__{}define({__INFO},{zx48feq}){}dnl
define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0E       ; 2:7       zx48f=   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f=}){}dnl
dnl
dnl
dnl # U>F
define({ZX48U_TO_F},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48U_TO_F},{zx48u_to_f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48U_TO_F},{dnl
__{}define({__INFO},{zx48u_to_f}){}dnl
define({USE_ZX48U_TO_F},{})
    call _ZX48U_TO_F    ; 3:17      zx48u>f   ( u -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl # u U>F
define({PUSH_ZX48U_TO_F},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ZX48U_TO_F},{push_zx48u_to_f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ZX48U_TO_F},{dnl
__{}define({__INFO},{push_zx48u_to_f}){}dnl
define({USE_ZX48BC_TO_F},{}){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
    ld   BC, format({%-11s},$1); 4:20      push_zx48s>f($1)   ( F: -- $1 )
    call _ZX48BC_TO_F   ; 3:17      push_zx48s>f($1)},
eval($1>=0),{1},{dnl
    ld   BC, format({%-11s},$1); 3:10      push_zx48s>f($1)   ( F: -- $1 )
    call _ZX48BC_TO_F   ; 3:17      push_zx48s>f($1)},
{define({USE_ZX48FNEGATE},{}){}dnl
    ld   BC, format({%-11s},eval(-($1))); 3:10      push_zx48s>f($1)   ( F: -- $1 )
    call _ZX48BC_TO_F   ; 3:17      push_zx48s>f($1)
    call _ZX48FNEGATE   ; 3:17      push_zx48s>f($1)})}){}dnl
dnl
dnl
dnl # S>F
define({ZX48S_TO_F},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48S_TO_F},{zx48s_to_f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48S_TO_F},{dnl
__{}define({__INFO},{zx48s_to_f}){}dnl
define({USE_ZX48S_TO_F},{})
    call _ZX48S_TO_F    ; 3:17      zx48s>f   ( x -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl # x S>F
define({PUSH_ZX48S_TO_F},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ZX48S_TO_F},{push_zx48s_to_f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ZX48S_TO_F},{dnl
__{}define({__INFO},{push_zx48s_to_f}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{define({USE_ZX48BBC_TO_F},{}){}dnl
    ld   BC, format({%-11s},$1); 4:20      push_zx48s>f($1)   ( F: -- $1 )
    call _ZX48BBC_TO_F  ; 3:17      push_zx48s>f($1)},
eval($1>=0),{1},{dnl
    ld   BC, format({%-11s},$1); 3:10      push_zx48s>f($1)   ( F: -- $1 )
__{}ifelse(eval(($1) & 0x8000),{0},{define({USE_ZX48BBC_TO_F},{}){}dnl
__{}    call _ZX48BBC_TO_F  ; 3:17      push_zx48s>f($1)   $1 == 0 0??????? ????????},
__{}{define({USE_ZX48CFBC_TO_F},{}){}dnl
__{}    xor   A             ; 1:4       push_zx48s>f($1)   $1 == 0 1??????? ????????
__{}    call _ZX48CFBC_TO_F ; 3:17      push_zx48s>f($1)})},
{dnl
    ld   BC, format({%-11s},$1); 3:10      push_zx48s>f($1)   ( F: -- $1 )
__{}ifelse(eval(($1) & 0x8000),{0},{define({USE_ZX48CFBC_TO_F},{}){}dnl
__{}    scf                 ; 1:4       push_zx48s>f($1)   $1 == 1 0??????? ????????
__{}    call _ZX48CFBC_TO_F ; 3:17      push_zx48s>f($1)},
__{}{define({USE_ZX48BBC_TO_F},{}){}dnl
__{}    call _ZX48BBC_TO_F  ; 3:17      push_zx48s>f($1)   $1 == 1 1??????? ????????})}){}dnl
})dnl
dnl
dnl
define({PUSH_ZX48F},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ZX48F},{push_zx48f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ZX48F},{dnl
__{}define({__INFO},{push_zx48f}){}dnl
ZX48FSTRING_TO_FHEX($1)
                       ;[15:195]    push_zx48f($1)   = format({%a},$1)
    push DE             ; 1:11      push_zx48f($1)
    push HL             ; 1:11      push_zx48f($1)
    ld    A, 0x{}ZXTEMP_EXP       ; 2:7       push_zx48f($1)
    ld   DE, 0x{}ZXTEMP_MANTISSA_2{}ZXTEMP_MANTISSA_1     ; 3:10      push_zx48f($1)
    ld   BC, 0x{}ZXTEMP_MANTISSA_4{}ZXTEMP_MANTISSA_3     ; 3:10      push_zx48f($1)
    call 0x2ABB         ; 3:124     push_zx48f($1)   new float = a,e,d,c,b
    pop  HL             ; 1:11      push_zx48f($1)
    pop  DE             ; 1:11      push_zx48f($1)
}){}dnl
dnl
dnl
dnl # F>S
define({ZX48F_TO_S},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48F_TO_S},{zx48f_to_s},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48F_TO_S},{dnl
__{}define({__INFO},{zx48f_to_s}){}dnl
define({USE_ZX48F_TO_S},{})
    call _ZX48F_TO_S    ; 3:17      zx48f>s   ( -- x ) ( F: r -- )}){}dnl
dnl
dnl
dnl # D>F
define({ZX48D_TO_F},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48D_TO_F},{zx48d_to_f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48D_TO_F},{dnl
__{}define({__INFO},{zx48d_to_f}){}dnl
define({USE_ZX48D_TO_F},{})
    call _ZX48D_TO_F    ; 3:17      zx48d>f   ( d -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl # F>D
define({ZX48F_TO_D},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48F_TO_D},{zx48f_to_d},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48F_TO_D},{dnl
__{}define({__INFO},{zx48f_to_d}){}dnl
define({USE_ZX48F_TO_D},{})
    call _ZX48F_TO_D    ; 3:17      zx48f>d   ( -- d ) ( F: r -- )}){}dnl
dnl
dnl
dnl
dnl # FLOAT+
define({ZX48FLOATADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FLOATADD},{zx48floatadd},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FLOATADD},{dnl
__{}define({__INFO},{zx48floatadd}){}dnl

    ld   BC, 0x0005     ; 3:10      zx48float+   ( a1 -- a2 ) ( F: -- )
    add  HL, BC         ; 1:11      zx48float+}){}dnl}){}dnl
dnl
dnl
dnl # F0=
define({ZX48F0EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48F0EQ},{zx48f0eq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48F0EQ},{dnl
__{}define({__INFO},{zx48f0eq}){}dnl
define({USE_ZX48F0EQ},{})
    call _ZX48F0EQ      ; 3:17      zx48f0=   ( -- flag ) ( F: r -- )}){}dnl
dnl
dnl
dnl # F0<
define({ZX48F0LT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48F0LT},{zx48f0lt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48F0LT},{dnl
__{}define({__INFO},{zx48f0lt}){}dnl
define({USE_ZX48F0LT},{})
    call _ZX48F0LT      ; 3:17      zx48f0<   ( -- flag ) ( F: r -- )}){}dnl
dnl
dnl
dnl
define({ZX48FVARIABLE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX48FVARIABLE},{zx48fvariable},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX48FVARIABLE},{dnl
__{}define({__INFO},{zx48fvariable}){}dnl
dnl
__{}ifelse($1,{},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}    .error zx48fvariable($@): Missing parameter with variable name!})},
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
__{}__{}    .error zx48fvariable($@): To many parameters!})}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
