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
dnl # z@
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
__{}__{}    call _ZFETCH        ; 3:17      __INFO   ( addr -- ) ( F: -- z )}){}dnl
}){}dnl
dnl
dnl
dnl # z!
define({ZSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZSTORE},{z!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#>0),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__def({USE_ZSTORE})
__{}__{}    call _ZSTORE        ; 3:17      __INFO   ( addr -- ) ( F: z -- )}){}dnl
}){}dnl
dnl
dnl
dnl # zover
define({ZOVER},{dnl
__{}__ADD_TOKEN({__TOKEN_ZOVER},{zover},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZOVER},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZOVER})
    call _ZOVER         ; 3:17      __INFO   ( F: z1 z2 -- z1 z2 z1 )}){}dnl
dnl
dnl
define({PUSH_ZPICK},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ZPICK},{$1 zpick},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ZPICK},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<1),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}  .error {$0}($@):  Parameter is memory reference!},
__{}__IS_NUM($1),0,{
__{}  .error {$0}($@):  Parameter is not number!},
__{}{dnl
__{}__{}ifelse(eval($1),0,{
__{}__{}__{}    .error {$0}($@): Parameter is zero! 1 and higher are supported.},
__{}__{}eval(($1)<1),{1},{
__{}__{}__{}    .error {$0}($@): Negative parameter! 1 and higher are supported.},
__{}__{}eval(($1)>51),{1},{
__{}__{}__{}__def({USE_ZPICK_BC})
__{}__{}__{}    ld   BC, __HEX_HL(-5*($1))     ; 3:10      __INFO   ( F: -- z )
__{}__{}__{}    call _ZPICK_BC      ; 3:17      __INFO},
__{}__{}{dnl
__{}__{}__{}__def({USE_ZPICK_C})
__{}__{}__{}    ld    C, __HEX_L(-5*($1))       ; 2:7       __INFO   ( F: -- z )
__{}__{}__{}    call _ZPICK_C       ; 3:17      __INFO}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl # zrot
define({ZROT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZROT},{zrot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZROT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZROT})
    call _ZROT          ; 3:17      __INFO   ( F: z1 z2 z3 -- z2 z3 z1 )}){}dnl
dnl
dnl
dnl # zdrop
define({ZDROP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZDROP},{zdrop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZDROP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZDROP})
    call _ZDROP         ; 3:17      __INFO   ( F: z -- )}){}dnl
dnl
dnl
dnl # zabs
define({ZABS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZABS},{zabs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZABS},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZABS})
    call _ZABS          ; 3:17      __INFO   ( F: z1 -- abs(z1) )}){}dnl
dnl
dnl
dnl # z+
define({ZADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ZADD},{z+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZADD})
    call _ZADD          ; 3:17      __INFO   ( F: z1 z2 -- z1+z2 )}){}dnl
dnl
dnl
dnl # z-
define({ZSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_ZSUB},{z-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZSUB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZSUB})
    call _ZSUB          ; 3:17      __INFO   ( F: z1 z2 -- z1-z2 )}){}dnl
dnl
dnl
dnl # znegate
define({ZNEGATE},{dnl
__{}__ADD_TOKEN({__TOKEN_ZNEGATE},{znegate},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZNEGATE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZNEGATE})
    call _ZNEGATE       ; 3:17      __INFO   ( F: z1 -- -z1 )}){}dnl
dnl
dnl
dnl # zsin
define({ZSIN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZSIN},{zsin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZSIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZSIN})
    call _ZSIN          ; 3:17      __INFO   ( F: z1 -- sin(z1) )}){}dnl
dnl
dnl
dnl # zcos
define({ZCOS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZCOS},{zcos},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZCOS},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOS})
    call _ZCOS          ; 3:17      __INFO   ( F: z1 -- cos(z1) )}){}dnl
dnl
dnl
dnl # ztan
define({ZTAN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZTAN},{ztan},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZTAN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZTAN})
    call _ZTAN          ; 3:17      __INFO   ( F: z1 -- tan(z1) )}){}dnl
dnl
dnl
dnl # zasin
define({ZASIN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZASIN},{zasin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZASIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZASIN})
    call _ZASIN         ; 3:17      __INFO   ( F: z1 -- arcsin(z1) )}){}dnl
dnl
dnl
dnl # zacos
define({ZACOS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZACOS},{zacos},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZACOS},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZACOS})
    call _ZACOS         ; 3:17      __INFO   ( F: z1 -- arccos(z1) )}){}dnl
dnl
dnl
dnl # zatan
define({ZATAN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZATAN},{zatan},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZATAN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZATAN})
    call _ZATAN         ; 3:17      __INFO   ( F: z1 -- arctan(z1) )}){}dnl
dnl
dnl
dnl # zln
define({ZLN},{dnl
__{}__ADD_TOKEN({__TOKEN_ZLN},{zln},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZLN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZLN})
    call _ZLN           ; 3:17      __INFO   ( F: z1 -- ln(z1) )}){}dnl
dnl
dnl
dnl # zexp
define({ZEXP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZEXP},{zexp},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZEXP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZEXP})
    call _ZEXP          ; 3:17      __INFO   ( F: z1 -- e^z1 )}){}dnl
dnl
dnl
dnl # zsqrt
define({ZSQRT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZSQRT},{zsqrt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZSQRT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZSQRT})
    call _ZSQRT         ; 3:17      __INFO   ( F: z1 -- z1^0.5 )}){}dnl
dnl
dnl
dnl # ( F: z -- z z )
define({ZDUP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZDUP},{zdup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZDUP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZDUP})
    call _ZDUP          ; 3:17      __INFO   ( F: z -- z z )}){}dnl
dnl
dnl
dnl # z.
define({ZDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZDOT},{z.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZDOT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZDOT})
    call _ZDOT          ; 3:17      __INFO   ( F: z -- )}){}dnl
dnl
dnl
dnl # ( F: z -- z )  "13,57,9A,CD,EF "
define({ZHEXDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZHEXDOT},{zhex.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZHEXDOT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZHEXDOT})
    call _ZHEXDOT       ; 3:17      __INFO   ( F: z -- z )}){}dnl
dnl
dnl
dnl # zint
define({ZINT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZINT},{zint},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZINT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZINT})
    call _ZINT          ; 3:17      __INFO   ( F: z -- x )}){}dnl
dnl
dnl
dnl # zswap
define({ZSWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZSWAP},{zswap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZSWAP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZSWAP})
    call _ZSWAP         ; 3:17      __INFO   ( F: z1 z2 -- z2 z1 )}){}dnl
dnl
dnl
dnl # Z*
define({ZMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_ZMUL},{z*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZMUL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZMUL})
    call _ZMUL          ; 3:17      __INFO   ( F: z1 z2 -- z1*z2 )}){}dnl
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
    call _ZMULMUL       ; 3:17      __INFO   ( F: z1 z2 -- z1^z2 )}){}dnl
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
    call _ZDIV          ; 3:17      __INFO   ( F: z1 z2 -- z1/z2 )}){}dnl
dnl
dnl
dnl
define({ZXROM_UMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_ZXROM_UMUL},{zxrom_umul},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZXROM_UMUL},{dnl
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
    ld    B, 0x09       ; 2:7       __INFO   ( F: z1 z2 -- 1 or 0 )
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
    ld    B, 0x0A       ; 2:7       __INFO   ( F: z1 z2 -- 1 or 0 )
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
    ld    B, 0x0B       ; 2:7       __INFO   ( F: z1 z2 -- 1 or 0 )
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
    ld    B, 0x0C       ; 2:7       __INFO   ( F: z1 z2 -- 1 or 0 )
    call _ZCOMPARE      ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # Z<
define({ZLT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZLT},{z<},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZLT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0D       ; 2:7       __INFO   ( F: z1 z2 -- 1 or 0 )
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
    ld    B, 0x0E       ; 2:7       __INFO   ( F: z1 z2 -- 1 or 0 )
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
    call _U_TO_F        ; 3:17      __INFO   ( u -- ) ( F: -- z )}){}dnl
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
    call _S_TO_Z        ; 3:17      __INFO   ( x -- ) ( F: -- z )}){}dnl
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
    call _R_TO_S        ; 3:17      __INFO   ( -- x ) ( F: z -- )}){}dnl
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
    call _D_TO_Z        ; 3:17      __INFO   ( d -- ) ( F: -- z )}){}dnl
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
    call _Z_TO_D        ; 3:17      __INFO   ( -- d ) ( F: z -- )}){}dnl
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
    call _Z0EQ          ; 3:17      __INFO   ( -- flag ) ( F: z -- )}){}dnl
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
    call _Z0LT          ; 3:17      __INFO   ( -- flag ) ( F: z -- )}){}dnl
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
