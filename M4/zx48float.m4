dnl ## ZX Spectrum 48 ROM Floating point Arithmetic
dnl
dnl
dnl
dnl # $1 = sign (1 bit)
dnl # $2 = exponent (8 bit)
dnl # $3 = mantissa (64 bit)
define({__SET_ZXFLOAT},{dnl
__{}define({ZXTEMP_EXP},substr(__HEX_L($2),2)){}dnl
__{}define({ZXTEMP_MANTISSA_1},format({%02X},eval(256*$1+(($3>>24) & 0x7F)))){}dnl
__{}define({ZXTEMP_MANTISSA_2},substr(__HEX_E($3),2)){}dnl
__{}define({ZXTEMP_MANTISSA_3},substr(__HEX_H($3),2)){}dnl
__{}define({ZXTEMP_MANTISSA_4},substr(__HEX_L($3),2)){}dnl
}){}dnl
dnl
dnl
dnl
define({ZX48FSTRING_TO_FHEX},{dnl
__{}define({$0_SIGN},0){}dnl
__{}ifelse(substr($1,0,1),{-},{dnl
__{}__{}define({$0_SIGN},1){}dnl
__{}__{}define({$0_HEX_REAL},{__HEX_FLOAT(substr($1,1))})},
__{}substr($1,0,1),{+},{dnl
__{}__{}define({$0_HEX_REAL},{__HEX_FLOAT(substr($1,1))})},
__{}{dnl
__{}__{}define({$0_HEX_REAL},{__HEX_FLOAT($1)})}){}dnl
__{}dnl
__{}ifelse($0_HEX_REAL,{0x0p+0},{dnl
__{}__{}__SET_ZXFLOAT(0,0,0)},
__{}$0_SIGN:$0_HEX_REAL,{1:inf},{
__{}__{}  .WARNING You are trying to convert "-inf" to ZX floating point format. It will be converted as a smallest possible value.{}dnl
__{}__{}__SET_ZXFLOAT(1,0xFF,0x7FFFFFFF)},
__{}$0_HEX_REAL,{inf},{
__{}__{}  .WARNING You are trying to convert "+inf" to ZX floating point format. It will be converted as a largest possible value.{}dnl
__{}__{}__SET_ZXFLOAT(0,0xFF,0x7FFFFFFF)},
__{}$0_HEX_REAL,{nan},{
__{}__{}  .WARNING You are trying to convert "Not a Number" to ZX floating point format. It will be converted as a zero.{}dnl
__{}__{}__SET_ZXFLOAT(0,0,0)},
__{}{dnl
__{}__{}dnl    # Výpočet exponentu
__{}__{}define({$0_EXP},{eval(substr($0_HEX_REAL,incr(index($0_HEX_REAL,{p}))) + 0x81)}){}dnl
__{}__{}dnl    # Výpočet mantisy    
__{}__{}define({$0_MAN},{substr($0_HEX_REAL,incr(index($0_HEX_REAL,{x})),eval(index($0_HEX_REAL,{p})-index($0_HEX_REAL,{x})-1))}){}dnl
__{}__{}ifelse(substr($0_MAN,0,2),{1.},{dnl
__{}__{}__{}define({$0_MAN},substr($0_MAN,2))},
__{}__{}{dnl
__{}__{}__{}errprint({
Error: }$0_HEX_REAL{ has an unexpected format, it does not start as "1."})}){}dnl
__{}__{}define({$0_MAN},{0x}substr($0_MAN{00000000},0,8)){}dnl
__{}__{}define({$0_ROUND_BIT},eval($0_MAN & 1)){}dnl
__{}__{}define({$0_MAN},eval((($0_MAN>>1) & 0x7FFFFFFF)+$0_ROUND_BIT)){}dnl
__{}__{}ifelse(__HEX_D($0_MAN),0x80,{dnl
__{}__{}__{}define({$0_EXP},incr($0_EXP)){}dnl
__{}__{}__{}define({$0_MAN},0)}){}dnl
__{}__{}dnl
__{}__{}ifelse(1,0,{
__{}__{}__{}$0_HEX_REAL
__{}__{}__{}s:$0_SIGN
__{}__{}__{}e:$0_EXP = __HEX_L($0_EXP) = eval($0_EXP-0x48)
__{}__{}__{}m:__HEX_DEHL($0_MAN)}){}dnl
__{}__{}dnl
__{}__{}ifelse(eval($0_EXP <= 0),1,{
__{}__{}__{}  .WARNING The value "$1" is too close to zero, so it will be changed to a zero.{}dnl   
__{}__{}__{}__SET_ZXFLOAT(0,0,0)},
__{}__{}eval(($0_EXP > 0xFF) && $0_SIGN ),1,{
__{}__{}__{}  .WARNING The value "$1" is less than the smallest possible value, so it will be changed to the smallest possible value.{}dnl
__{}__{}__{}__SET_ZXFLOAT(1,0xFF,0x7FFFFFFF)},
__{}__{}eval($0_EXP > 0xFF),1,{
__{}__{}__{}  .WARNING The value "$1" is greater than the largest possible value, so it will be changed to the largest possible value.{}dnl
__{}__{}__{}__SET_ZXFLOAT(0,0xFF,0x7FFFFFFF)},
__{}__{}{dnl   # Sestavení hexadecimální hodnoty
__{}__{}__{}__SET_ZXFLOAT($0_SIGN,$0_EXP,$0_MAN){}dnl
__{}__{}}){}dnl
__{}}){}dnl
})dnl
dnl
dnl # ---------------------
dnl
dnl
dnl # zdepth
dnl # ( -- 0 ) if ( Z: -- )
dnl # ( -- 1 ) if ( Z: z -- z )
dnl # ( -- 2 ) if ( Z: z2 z1 -- z2 z1 )
dnl # ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
dnl # n is the number of floating-point values contained in the calculator stack
define({ZDEPTH},{dnl
__{}__ADD_TOKEN({__TOKEN_ZDEPTH},{zdepth},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZDEPTH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#>0),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}__def({USE_ZDEPTH})
__{}__{}    call _ZDEPTH        ; 3:17      __INFO   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )}){}dnl
}){}dnl
dnl
dnl
dnl
define({ZFLOAT2ARRAY},{dnl
__{}__ADD_TOKEN({__TOKEN_ZFLOAT2ARRAY},{zfloat2array},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZFLOAT2ARRAY},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
dnl
__{}ZX48FSTRING_TO_FHEX($1){}dnl
__{}DB 0x{}ZXTEMP_EXP,0x{}ZXTEMP_MANTISSA_1,0x{}ZXTEMP_MANTISSA_2,0x{}ZXTEMP_MANTISSA_3,0x{}ZXTEMP_MANTISSA_4 ; = $1 = __HEX_FLOAT($1){}dnl
}){}dnl
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
__{}__{}    call _ZFETCH        ; 3:17      __INFO   ( addr -- ) ( Z: -- z )}){}dnl
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
__{}__{}    call _ZSTORE        ; 3:17      __INFO   ( addr -- ) ( Z: z -- )}){}dnl
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
    call _ZOVER         ; 3:17      __INFO   ( Z: z1 z2 -- z1 z2 z1 )}){}dnl
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
__{}__{}__{}    ld   BC, __HEX_HL(-5*($1))     ; 3:10      __INFO   ( Z: -- z )
__{}__{}__{}    call _ZPICK_BC      ; 3:17      __INFO},
__{}__{}{dnl
__{}__{}__{}__def({USE_ZPICK_C})
__{}__{}__{}    ld    C, __HEX_L(-5*($1))       ; 2:7       __INFO   ( Z: -- z )
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
    call _ZROT          ; 3:17      __INFO   ( Z: z1 z2 z3 -- z2 z3 z1 )}){}dnl
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
    call _ZDROP         ; 3:17      __INFO   ( Z: z -- )}){}dnl
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
    call _ZABS          ; 3:17      __INFO   ( Z: z1 -- abs(z1) )}){}dnl
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
    call _ZADD          ; 3:17      __INFO   ( Z: z1 z2 -- z1+z2 )}){}dnl
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
    call _ZSUB          ; 3:17      __INFO   ( Z: z1 z2 -- z1-z2 )}){}dnl
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
    call _ZNEGATE       ; 3:17      __INFO   ( Z: z1 -- -z1 )}){}dnl
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
    call _ZSIN          ; 3:17      __INFO   ( Z: z1 -- sin(z1) )}){}dnl
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
    call _ZCOS          ; 3:17      __INFO   ( Z: z1 -- cos(z1) )}){}dnl
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
    call _ZTAN          ; 3:17      __INFO   ( Z: z1 -- tan(z1) )}){}dnl
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
    call _ZASIN         ; 3:17      __INFO   ( Z: z1 -- arcsin(z1) )}){}dnl
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
    call _ZACOS         ; 3:17      __INFO   ( Z: z1 -- arccos(z1) )}){}dnl
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
    call _ZATAN         ; 3:17      __INFO   ( Z: z1 -- arctan(z1) )}){}dnl
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
    call _ZLN           ; 3:17      __INFO   ( Z: z1 -- ln(z1) )}){}dnl
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
    call _ZEXP          ; 3:17      __INFO   ( Z: z1 -- e^z1 )}){}dnl
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
    call _ZSQRT         ; 3:17      __INFO   ( Z: z1 -- z1^0.5 )}){}dnl
dnl
dnl
dnl # ( Z: z -- z z )
define({ZDUP},{dnl
__{}__ADD_TOKEN({__TOKEN_ZDUP},{zdup},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZDUP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZDUP})
    call _ZDUP          ; 3:17      __INFO   ( Z: z -- z z )}){}dnl
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
    call _ZDOT          ; 3:17      __INFO   ( Z: z -- )}){}dnl
dnl
dnl
dnl # ( Z: z -- z )  "13,57,9A,CD,EF "
define({ZHEXDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_ZHEXDOT},{zhex.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZHEXDOT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZHEXDOT})
    call _ZHEXDOT       ; 3:17      __INFO   ( Z: z -- z )}){}dnl
dnl
dnl
dnl # zfloor
define({ZFLOOR},{dnl
__{}__ADD_TOKEN({__TOKEN_ZFLOOR},{zfloor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZFLOOR},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZFLOOR})
    call _ZFLOOR        ; 3:17      __INFO   ( Z: z -- x )}){}dnl
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
    call _ZSWAP         ; 3:17      __INFO   ( Z: z1 z2 -- z2 z1 )}){}dnl
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
    call _ZMUL          ; 3:17      __INFO   ( Z: z1 z2 -- z1*z2 )}){}dnl
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
    call _ZMULMUL       ; 3:17      __INFO   ( Z: z1 z2 -- z1^z2 )}){}dnl
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
    call _ZDIV          ; 3:17      __INFO   ( Z: z1 z2 -- z1/z2 )}){}dnl
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
__{}__def({USE_ZCOMPARE2FLAG})
    ld    B, 0x09       ; 2:7       __INFO   ( -- flag ) ( Z: z1 z2 -- )
    call _ZCOMPARE2FLAG ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # f<= negate s>f
define({ZLE_NEGATE_S_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_ZLE_NEGATE_S_TO_Z},{z<= negate s>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZLE_NEGATE_S_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x09       ; 2:7       __INFO   ( Z: z1 z2 -- zbool ) z<= if 1e else 0e then
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
__{}__def({USE_ZCOMPARE2FLAG})
    ld    B, 0x0A       ; 2:7       __INFO   ( -- flag ) ( Z: z1 z2 -- )
    call _ZCOMPARE2FLAG ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # f>= negate s>f
define({ZGE_NEGATE_S_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_ZGE_NEGATE_S_TO_Z},{z>= negate s>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZGE_NEGATE_S_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0A       ; 2:7       __INFO   ( Z: z1 z2 -- zbool ) z>= if 1e else 0e then
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
__{}__def({USE_ZCOMPARE2FLAG})
    ld    B, 0x0B       ; 2:7       __INFO   ( -- flag ) ( Z: z1 z2 -- )
    call _ZCOMPARE2FLAG ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # f<> negate s>f
define({ZNE_NEGATE_S_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_ZNE_NEGATE_S_TO_Z},{z<> negate s>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZNE_NEGATE_S_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0B       ; 2:7       __INFO   ( Z: z1 z2 -- zbool ) z<> if 1e else 0e then
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
__{}__def({USE_ZCOMPARE2FLAG})
    ld    B, 0x0C       ; 2:7       __INFO   ( -- flag ) ( Z: z1 z2 -- )
    call _ZCOMPARE2FLAG ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # f> negate s>f
define({ZGT_NEGATE_S_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_ZGT_NEGATE_S_TO_Z},{z> negate s>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZGT_NEGATE_S_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0C       ; 2:7       __INFO   ( Z: z1 z2 -- zbool ) z> if 1e else 0e then
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
__{}__def({USE_ZCOMPARE2FLAG})
    ld    B, 0x0D       ; 2:7       __INFO   ( -- flag ) ( Z: z1 z2 -- )
    call _ZCOMPARE2FLAG ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # f< negate s>f
define({ZLT_NEGATE_S_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_ZLT_NEGATE_S_TO_Z},{z< negate s>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZLT_NEGATE_S_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0D       ; 2:7       __INFO   ( Z: z1 z2 -- zbool ) z< if 1e else 0e then
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
__{}__def({USE_ZCOMPARE2FLAG})
    ld    B, 0x0E       ; 2:7       __INFO   ( -- flag ) ( Z: z1 z2 -- )
    call _ZCOMPARE2FLAG ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # f= negate s>f
define({ZEQ_NEGATE_S_TO_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_ZEQ_NEGATE_S_TO_Z},{z= negate s>z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZEQ_NEGATE_S_TO_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_ZCOMPARE})
    ld    B, 0x0E       ; 2:7       __INFO   ( Z: z1 z2 -- zbool ) z= if 1e else 0e then
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
    call _U_TO_F        ; 3:17      __INFO   ( u -- ) ( Z: -- z )}){}dnl
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
__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   ( Z: -- $1 )
__{}__{}    call _BC_TO_Z       ; 3:17      __INFO},
__{}eval($1>=0),{1},{dnl
__{}__{}__def({USE_BC_TO_Z})
__{}__{}    ld   BC, format({%-11s},$1); 3:10      __INFO   ( Z: -- $1 )
__{}__{}    call _BC_TO_Z       ; 3:17      __INFO},
__{}{dnl
__{}__{}__def({USE_ZNEGATE}){}dnl
__{}__{}__def({USE_BC_TO_Z})
__{}__{}    ld   BC, format({%-11s},eval(-($1))); 3:10      __INFO   ( Z: -- $1 )
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
    call _S_TO_Z        ; 3:17      __INFO   ( x -- ) ( Z: -- z )}){}dnl
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
__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   ( Z: -- $1 )
__{}    call _SIGN_BC_TO_Z  ; 3:17      __INFO},
__{}eval($1>=0),{1},{dnl
__{}    ld   BC, format({%-11s},$1); 3:10      __INFO   ( Z: -- $1 )
__{}ifelse(eval(($1) & 0x8000),{0},{dnl
__{}__{}__def({USE_SIGN_BC_TO_Z}){}dnl
__{}__{}    call _SIGN_BC_TO_Z  ; 3:17      __INFO   $1 == 0 0??????? ????????},
__{}{dnl
__{}__{}__def({USE_CF_BC_TO_Z}){}dnl
__{}__{}    xor   A             ; 1:4       __INFO   $1 == 0 1??????? ????????
__{}__{}    call _CF_BC_TO_Z    ; 3:17      __INFO})},
__{}{dnl
__{}    ld   BC, format({%-11s},$1); 3:10      __INFO   ( Z: -- $1 )
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
dnl # 1E -2.3E-5 etc.
define({ZPUSH},{dnl
__{}ifelse(eval($#<1),1,{
__{}  .error {$0}($@): Missing parameter!},
__{}{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP},{$1},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_ZPUSH},{__dtto},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_2DROP},{__dtto},$@){}dnl
__{}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZPUSH},{dnl
__{}ifelse($1,,,{ZX48FSTRING_TO_FHEX($1)
__{}    ld    A, 0x{}ZXTEMP_EXP       ; 2:7       $1   = __HEX_FLOAT($1)
__{}    ld   DE, 0x{}ZXTEMP_MANTISSA_2{}ZXTEMP_MANTISSA_1     ; 3:10      $1   = 0x{}ZXTEMP_EXP{}ZXTEMP_MANTISSA_1{}{}ZXTEMP_MANTISSA_2{}ZXTEMP_MANTISSA_3{}ZXTEMP_MANTISSA_4
__{}    ld   BC, 0x{}ZXTEMP_MANTISSA_4{}ZXTEMP_MANTISSA_3     ; 3:10      $1
__{}    call 0x2ABB         ; 3:124     $1   new float = a,e,d,c,b{}dnl
__{}$0(shift($@))}){}dnl
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
    call _R_TO_S        ; 3:17      __INFO   ( -- x ) ( Z: z -- )}){}dnl
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
    call _D_TO_Z        ; 3:17      __INFO   ( d -- ) ( Z: -- z )}){}dnl
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
    call _Z_TO_D        ; 3:17      __INFO   ( -- d ) ( Z: z -- )}){}dnl
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
    ld   BC, 0x0005     ; 3:10      __INFO   ( a1 -- a2 ) ( Z: -- )
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
    call _Z0EQ          ; 3:17      __INFO   ( -- flag ) ( Z: z -- )}){}dnl
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
    call _Z0LT          ; 3:17      __INFO   ( -- flag ) ( Z: z -- )}){}dnl
dnl
dnl
dnl
dnl # ZVARIABLE(name,value)
dnl # ZVARIABLE(name)
define({ZVARIABLE},{dnl
__{}define({__PSIZE_$1},5){}dnl
__{}__ADD_TOKEN({__TOKEN_ZVARIABLE},{zvariable $1 $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZVARIABLE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}($@): Missing parameter with variable name!},
__{}eval($#>2),{1},{
__{}__{}    .error {$0}($@): To many parameters!},
__{}eval($#),{1},{
__{}__{}format({%-24s},{});           __INFO{}dnl
__{}__{}define({__PSIZE_$1},5){}dnl
__{}__{}pushdef({LAST_HERE_NAME},$1){}dnl
__{}__{}pushdef({LAST_HERE_ADD},5){}dnl
__{}__{}__{}__ADD_DB_VARIABLE($1,0,__INFO){}dnl
__{}__{}__{}__ADD_DW_VARIABLE(,0,__INFO){}dnl
__{}__{}__{}__ADD_DW_VARIABLE(,0,__INFO)},
__{}{
__{}__{}format({%-24s},{});           __INFO{}dnl
__{}__{}define({__PSIZE_$1},5){}dnl
__{}__{}pushdef({LAST_HERE_NAME},$1){}dnl
__{}__{}pushdef({LAST_HERE_ADD},5){}dnl
__{}__{}ZX48FSTRING_TO_FHEX($2){}dnl
__{}__{}__ADD_SPEC_VARIABLE({
}format({%-24s},$1:){;           }__INFO{   = $2 = }__HEX_FLOAT($2){
}    db 0x{}ZXTEMP_EXP{             ;           }__INFO{   = exp
}    db 0x{}ZXTEMP_MANTISSA_1{             ;           }__INFO{   = sign + high 7 bits mantissa (big-endien)
}    db 0x{}ZXTEMP_MANTISSA_2{,0x}ZXTEMP_MANTISSA_3{,0x}ZXTEMP_MANTISSA_4{   ;           }__INFO{   = low mantissa (big-endien)}){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
