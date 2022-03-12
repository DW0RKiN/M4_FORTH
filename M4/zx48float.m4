dnl ## ZX Spectrum 48 ROM Floating point Arithmetic
define({___},{})dnl
dnl
dnl
define({ZX_READCHAR},{dnl
___{}define({ZXTEMP_CHAR},substr(ZXTEMP_STRING,0,1)){}dnl
___{}define({ZXTEMP_STRING},substr(ZXTEMP_STRING,1)){}dnl
})dnl
dnl
dnl
define({ZX_READ_MANT},{dnl
___{}define({ZX_READ_TEMP},ZXTEMP_CHAR){}dnl
___{}ifelse(ZX_READ_TEMP,{p},{define({ZX_READ_TEMP},{0})}){}dnl
___{}ifelse(len(ZXTEMP_MANTISSA),{10},{define({ZX_READ_TEMP},{})}){}dnl
___{}define({ZXTEMP_MANTISSA},ZXTEMP_MANTISSA{}ZX_READ_TEMP){}dnl
___{}ifelse(ZXTEMP_CHAR,{p},{dnl
___{}___{}ifelse(eval(len(ZXTEMP_MANTISSA)<10),{1},{ZX_READ_MANT})},
___{}{dnl
___{}___{}ZX_READCHAR{}dnl
___{}___{}ZX_READ_MANT}){}dnl
}){}dnl
dnl
dnl
define({ZX48FSTRING_TO_FHEX},{dnl
___{}define({ZXTEMP_STRING},format({%a},$1)){}dnl
___{}ZX_READCHAR{}dnl                               0 or -+
___{}define({ZXTEMP_SIGN},0){}dnl
___{}define({ZXTEMP_EXP},{}){}dnl
___{}define({ZXTEMP_MANTISSA},{0x}){}dnl
___{}ifelse(ZXTEMP_CHAR,{+},{ZX_READCHAR}){}dnl
___{}ifelse(ZXTEMP_CHAR,{-},{ZX_READCHAR{}define({ZXTEMP_SIGN},0x80)}){}dnl
___{}ZX_READCHAR{}dnl                               x
___{}ZX_READCHAR{}dnl                               1
___{}ifelse(ZXTEMP_CHAR,{1},{ZX_READCHAR}){}dnl     .
___{}ifelse(ZXTEMP_CHAR,{.},{ZX_READCHAR}){}dnl     ?
___{}ZX_READ_MANT{}dnl
___{}ifelse(ZXTEMP_CHAR,{p},{dnl
___{}___{}define({ZXTEMP_EXP},ZXTEMP_STRING){}dnl
___{}})dnl
___{}define({ZXTEMP_MANTISSA},format({0x%08x},eval((ZXTEMP_MANTISSA>>1) & 0x7FFFFFFF))){}dnl
___{}define({ZXTEMP_EXP},format({%02x},eval(ZXTEMP_EXP+129))){}dnl
___{}ifelse(format({%a},$1),{0x0p+0},{define({ZXTEMP_EXP},{00})}){}dnl
___{}define({ZXTEMP_MANTISSA_1},format({%02x},eval(ZXTEMP_SIGN+((ZXTEMP_MANTISSA>>24) & 0x7F)))){}dnl
___{}define({ZXTEMP_MANTISSA_2},format({%02x},eval((ZXTEMP_MANTISSA>>16) & 0xFF))){}dnl
___{}define({ZXTEMP_MANTISSA_3},format({%02x},eval((ZXTEMP_MANTISSA>>8) & 0xFF))){}dnl
___{}define({ZXTEMP_MANTISSA_4},format({%02x},eval(ZXTEMP_MANTISSA & 0xFF))){}dnl
}){}dnl
dnl
dnl
define({ZX48FLOAT2ARRAY},{dnl
___{}ZX48FSTRING_TO_FHEX($1){}dnl
___{}DB 0x{}ZXTEMP_EXP,0x{}ZXTEMP_MANTISSA_1,0x{}ZXTEMP_MANTISSA_2,0x{}ZXTEMP_MANTISSA_3,0x{}ZXTEMP_MANTISSA_4 ; = $1 = format({%a},$1){}dnl
}){}dnl
dnl
dnl
dnl
define({ZX48FADDR},{define({USE_ZX48FADDR},{})
    call _ZX48FADDR     ; 3:17      zx48faddr   ( -- )}){}dnl
dnl
dnl
dnl F@
define({ZX48FFETCH},{define({USE_ZX48FFETCH},{})ifelse($1,{},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    call _ZX48FFETCH    ; 3:17      zx48ffetch   ( addr -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl F!
define({ZX48FSTORE},{define({USE_ZX48FSTORE},{})ifelse($1,{},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    call _ZX48FSTORE    ; 3:17      zx48fstore   ( addr -- ) ( F: r -- )}){}dnl
dnl
dnl
dnl FOVER
define({ZX48FOVER},{define({USE_ZX48FOVER},{})
    call _ZX48FOVER     ; 3:17      fover zx48fover   ( F: r1 r2 -- r1 r2 r1 )}){}dnl
dnl
dnl
dnl FROT
define({ZX48FROT},{define({USE_ZX48FROT},{})
    call _ZX48FROT      ; 3:17      frot zx48frot   ( F: r1 r2 r3 -- r2 r3 r1 )}){}dnl
dnl
dnl
dnl FDROP
define({ZX48FDROP},{define({USE_ZX48FDROP},{})
    call _ZX48FDROP     ; 3:17      fdrop zx48fdrop   ( F: r -- )}){}dnl
dnl
dnl
dnl FABS
define({ZX48FABS},{define({USE_ZX48FABS},{})
    call _ZX48FABS      ; 3:17      fabs zx48fabs   ( F: r1 -- abs(r1) )}){}dnl
dnl
dnl
dnl F+
define({ZX48FADD},{define({USE_ZX48FADD},{})
    call _ZX48FADD      ; 3:17      F+ zx48fadd   ( F: r1 r2 -- r1+r2 )}){}dnl
dnl
dnl
dnl F-
define({ZX48FSUB},{define({USE_ZX48FSUB},{})
    call _ZX48FSUB      ; 3:17      F- zx48fsub   ( F: r1 r2 -- r1-r2 )}){}dnl
dnl
dnl
dnl FNEGATE
define({ZX48FNEGATE},{define({USE_ZX48FNEGATE},{})
    call _ZX48FNEGATE   ; 3:17      fnegate zx48fnegate   ( F: r1 -- -r1 )}){}dnl
dnl
dnl
dnl FSIN
define({ZX48FSIN},{define({USE_ZX48FSIN},{})
    call _ZX48FSIN      ; 3:17      zx48fsin   ( F: r1 -- sin(r1) )}){}dnl
dnl
dnl
dnl FCOS
define({ZX48FCOS},{define({USE_ZX48FCOS},{})
    call _ZX48FCOS      ; 3:17      zx48fcos   ( F: r1 -- cos(r1) )}){}dnl
dnl
dnl
dnl FTAN
define({ZX48FTAN},{define({USE_ZX48FTAN},{})
    call _ZX48FTAN      ; 3:17      zx48ftan   ( F: r1 -- tan(r1) )}){}dnl
dnl
dnl
dnl FASIN
define({ZX48FASIN},{define({USE_ZX48FASIN},{})
    call _ZX48FASIN     ; 3:17      zx48fasin   ( F: r1 -- arcsin(r1) )}){}dnl
dnl
dnl
dnl FACOS
define({ZX48FACOS},{define({USE_ZX48FACOS},{})
    call _ZX48FACOS     ; 3:17      zx48facos   ( F: r1 -- arccos(r1) )}){}dnl
dnl
dnl
dnl FATAN
define({ZX48FATAN},{define({USE_ZX48FATAN},{})
    call _ZX48FATAN     ; 3:17      zx48fatan   ( F: r1 -- arctan(r1) )}){}dnl
dnl
dnl
dnl FLN
define({ZX48FLN},{define({USE_ZX48FLN},{})
    call _ZX48FLN       ; 3:17      zx48fln   ( F: r1 -- ln(r1) )}){}dnl
dnl
dnl
dnl FEXP
define({ZX48FEXP},{define({USE_ZX48FEXP},{})
    call _ZX48FEXP      ; 3:17      zx48fexp   ( F: r1 -- e^r1 )}){}dnl
dnl
dnl
dnl FSQRT
define({ZX48FSQRT},{define({USE_ZX48FSQRT},{})
    call _ZX48FSQRT     ; 3:17      zx48fsqrt   ( F: r1 -- r1^0.5 )}){}dnl
dnl
dnl
dnl ( F: r -- r r )
define({ZX48FDUP},{define({USE_ZX48FDUP},{})
    call _ZX48FDUP      ; 3:17      zx48fdup   ( F: r -- r r )}){}dnl
dnl
dnl
dnl F.
define({ZX48FDOT},{define({USE_ZX48FDOT},{})
    call _ZX48FDOT      ; 3:17      zx48fdot   ( F: r -- )}){}dnl
dnl
dnl
dnl ( F: r -- r )  "13,57,9A,CD,EF "
define({ZX48FHEXDOT},{define({USE_ZX48FHEXDOT},{})
    call _ZX48FHEXDOT   ; 3:17      zx48fhexdot   ( F: r -- r )}){}dnl
dnl
dnl
dnl
define({ZX48FINT},{define({USE_ZX48FINT},{})
    call _ZX48FINT      ; 3:17      zx48fint   ( F: r -- x )}){}dnl
dnl
dnl
dnl FSWAP
define({ZX48FSWAP},{define({USE_ZX48FSWAP},{})
    call _ZX48FSWAP     ; 3:17      zx48fswap   ( F: r1 r2 -- r2 r1 )}){}dnl
dnl
dnl
dnl F*
define({ZX48FMUL},{define({USE_ZX48FMUL},{})
    call _ZX48FMUL      ; 3:17      zx48fmul   ( F: r1 r2 -- r1*r2 )}){}dnl
dnl
dnl
dnl F**
define({ZX48FMULMUL},{define({USE_ZX48FMULMUL},{})
    call _ZX48FMULMUL   ; 3:17      zx48fmulmul   ( F: r1 r2 -- r1^r2 )}){}dnl
dnl
dnl
dnl F/
define({ZX48FDIV},{define({USE_ZX48FDIV},{})
    call _ZX48FDIV      ; 3:17      zx48fdiv   ( F: r1 r2 -- r1/r2 )}){}dnl
dnl
dnl
dnl
define({ZX48UMUL},{
                        ;[4:27]     zx48umul   ( c b a -- c b*a )
    call 0x30a9         ; 3:17      zx48umul   {call ZX ROM HL=HL*DE routine}
    pop  DE             ; 1:10      zx48umul}){}dnl
dnl
dnl
dnl
dnl F<=
define({ZX48FLE},{define({USE_ZX48FCOMPARE},{})
    ld    B, 0x09       ; 2:7       zx48f<=   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f<=}){}dnl
dnl
dnl
dnl F>=
define({ZX48FGE},{define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0A       ; 2:7       zx48f>=   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f>=}){}dnl
dnl
dnl
dnl F<>
define({ZX48FNE},{define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0B       ; 2:7       zx48f<>   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f<>}){}dnl
dnl
dnl
dnl F>
define({ZX48FGT},{define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0C       ; 2:7       zx48f>   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f>}){}dnl
dnl
dnl
dnl F<
define({ZX48FLT},{define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0D       ; 2:7       zx48f<   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f<}){}dnl
dnl
dnl
dnl F=
define({ZX48FEQ},{define({USE_ZX48FCOMPARE},{})
    ld    B, 0x0E       ; 2:7       zx48f=   ( F: r1 r2 -- 1 or 0 )
    call _ZX48FCOMPARE  ; 3:17      zx48f=}){}dnl
dnl
dnl
dnl U>F
define({ZX48U_TO_F},{define({USE_ZX48U_TO_F},{})
    call _ZX48U_TO_F    ; 3:17      zx48u>f   ( u -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl u U>F
define({PUSH_ZX48U_TO_F},{define({USE_ZX48BC_TO_F},{}){}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(index({$1},{(}),{0},{dnl
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
dnl S>F
define({ZX48S_TO_F},{define({USE_ZX48S_TO_F},{})
    call _ZX48S_TO_F    ; 3:17      zx48s>f   ( x -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl x S>F
define({PUSH_ZX48S_TO_F},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(index({$1},{(}),{0},{define({USE_ZX48BBC_TO_F},{}){}dnl
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
define({PUSH_ZX48F},{ZX48FSTRING_TO_FHEX($1)
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
dnl F>S
define({ZX48F_TO_S},{define({USE_ZX48F_TO_S},{})
    call _ZX48F_TO_S    ; 3:17      zx48f>s   ( -- x ) ( F: r -- )}){}dnl
dnl
dnl
dnl D>F
define({ZX48D_TO_F},{define({USE_ZX48D_TO_F},{})
    call _ZX48D_TO_F    ; 3:17      zx48d>f   ( d -- ) ( F: -- r )}){}dnl
dnl
dnl
dnl F>D
define({ZX48F_TO_D},{define({USE_ZX48F_TO_D},{})
    call _ZX48F_TO_D    ; 3:17      zx48f>d   ( -- d ) ( F: r -- )}){}dnl
dnl
dnl
dnl
dnl FLOAT+
define({ZX48FLOATADD},{
    ld   BC, 0x0005     ; 3:10      zx48float+   ( a1 -- a2 ) ( F: -- )
    add  HL, BC         ; 1:11      zx48float+}){}dnl}){}dnl
dnl
dnl
dnl F0=
define({ZX48F0EQ},{define({USE_ZX48F0EQ},{})
    call _ZX48F0EQ      ; 3:17      zx48f0=   ( -- flag ) ( F: r -- )}){}dnl
dnl
dnl
dnl F0<
define({ZX48F0LT},{define({USE_ZX48F0LT},{})
    call _ZX48F0LT      ; 3:17      zx48f0<   ( -- flag ) ( F: r -- )}){}dnl
dnl
dnl
dnl
define({ZX48FVARIABLE},{dnl
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
__{}__{}format({%-24s},$1:); = $2 = format({%a},$2) = 0x{}ZXTEMP_EXP{}ZXTEMP_MANTISSA_1{}ZXTEMP_MANTISSA_2{}ZXTEMP_MANTISSA_3{}ZXTEMP_MANTISSA_4
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
