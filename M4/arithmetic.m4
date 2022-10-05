dnl ## Arithmetic
dnl
dnl
dnl
include(M4PATH{}divmul/pdiv_mk1.m4){}dnl
include(M4PATH{}divmul/pmul_mk1.m4){}dnl
include(M4PATH{}divmul/pmul_mk2.m4){}dnl
include(M4PATH{}divmul/pmul_mk3.m4){}dnl
include(M4PATH{}divmul/pmul_mk4.m4){}dnl
dnl
dnl # ------------------------
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x2 + x1
define({ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ADD},{+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
    add  HL, DE         ; 1:11      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x -- x+n )
dnl # x = x + n
define({PUSH_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ADD},{$1 +},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(dnl
__IS_MEM_REF($1),{1},{
__{}    ; warning >>>$1<<< is a pointer to memory
__{}    ld   BC, format({%-11s},$1); 4:20      __INFO
__{}    add  HL, BC         ; 1:11      __INFO},
__IS_NUM($1),{0},{
__{}    ; warning M4 does not know the numerical value of >>>$1<<<
__{}    ld   BC, __FORM({%-11s},$1); 3:10      __INFO
__{}    add  HL, BC         ; 1:11      __INFO},
{ifelse(
__{}eval((($1)+3*256) & 0xffff),{0},{
__{}    dec  H              ; 1:4       __INFO   ( x -- x+__HEX_HL($1) )
__{}    dec  H              ; 1:4       __INFO
__{}    dec  H              ; 1:4       __INFO},
__{}eval((($1)+2*256) & 0xffff),{0},{
__{}    dec  H              ; 1:4       __INFO   ( x -- x+__HEX_HL($1) )
__{}    dec  H              ; 1:4       __INFO},
__{}eval((($1)+1*256) & 0xffff),{0},{
__{}    dec  H              ; 1:4       __INFO   ( x -- x+__HEX_HL($1) )},
__{}eval((($1)+    3) & 0xffff),{0},{
__{}    dec  HL             ; 1:6       __INFO   ( x -- x+__HEX_HL($1) )
__{}    dec  HL             ; 1:6       __INFO
__{}    dec  HL             ; 1:6       __INFO},
__{}eval((($1)+    2) & 0xffff),{0},{
__{}    dec  HL             ; 1:6       __INFO   ( x -- x+__HEX_HL($1) )
__{}    dec  HL             ; 1:6       __INFO},
__{}eval((($1)+    1) & 0xffff),{0},{
__{}    dec  HL             ; 1:6       __INFO   ( x -- x+__HEX_HL($1) )},
__{}eval(($1) & 0xFFFF),{0},{
__{}                        ;           __INFO   ( x -- x+__HEX_HL($1) )},
__{}eval(($1)-1),{0},{
__{}    inc  HL             ; 1:6       __INFO   ( x -- x+__HEX_HL($1) )},
__{}eval(($1)-2),{0},{
__{}    inc  HL             ; 1:6       __INFO   ( x -- x+__HEX_HL($1) )
__{}    inc  HL             ; 1:6       __INFO},
__{}eval(($1)-3),{0},{
__{}    inc  HL             ; 1:6       __INFO   ( x -- x+__HEX_HL($1) )
__{}    inc  HL             ; 1:6       __INFO
__{}    inc  HL             ; 1:6       __INFO},
__{}eval(($1)-1*256),{0},{
__{}    inc  H              ; 1:4       __INFO   ( x -- x+__HEX_HL($1) )},
__{}eval(($1)-2*256),{0},{
__{}    inc  H              ; 1:4       __INFO   ( x -- x+__HEX_HL($1) )
__{}    inc  H              ; 1:4       __INFO},
__{}eval(($1)-3*256),{0},{
__{}    inc  H              ; 1:4       __INFO   ( x -- x+__HEX_HL($1) )
__{}    inc  H              ; 1:4       __INFO
__{}    inc  H              ; 1:4       __INFO},
__{}eval((($1)) & 0xFF),{0},{
__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   ( x -- x+__HEX_HL($1) )
__{}    add   A, H          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO},
__{}{
__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO   ( x -- x+__HEX_HL($1) )
__{}    add  HL, BC         ; 1:11      __INFO})})}){}dnl
dnl
dnl
dnl # ( b a -- b a b+n )
define({OVER_PUSH_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_PUSH_ADD},{over $1 +},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_PUSH_ADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_OVER{}dnl
__{}__ASM_TOKEN_PUSH_ADD($1){}dnl
}){}dnl
dnl
dnl
dnl
define({PUSH2_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_ADD},{$1 $2 +},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_ADD},{dnl
__{}define({__INFO},{$1 $2 +}){}dnl
ifelse(dnl
dnl # ( -- x )
dnl # x = $1 + $2
dnl # CONSTANT(_a,5) CONSTANT(_b,7) PUSH2_ADD({_a},{_b}) -->  ld   HL, 0x000C     ; 3:10      _a _b +
dnl # CONSTANT(_a,5) CONSTANT(_b,7) PUSH2_ADD(_a,_b)     -->  ld   HL, 0x000C     ; 3:10      5 7 +
eval((__IS_MEM_REF($1)+__IS_MEM_REF($2))>0),{1},{dnl
__{}ifelse(eval(__IS_MEM_REF($1)+__IS_MEM_REF($2)),{2},{
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1+$2
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}__{}    ld   HL,format({%-12s},$2); 3:16      __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO},
__{}__IS_MEM_REF($1),{1},{
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1+$2
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL,format({%-12s},$1); 3:16      __INFO
__{}__{}    ld   BC, __FORM({%-11s},$2); 3:10      __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1+$2
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   BC, __FORM({%-11s},$1); 3:10      __INFO
__{}__{}    ld   HL,format({%-12s},$2); 3:16      __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO})},
{dnl
__{}__{}ifelse(__IS_NUM($1+$2),{0},{
__{}__{}    ; warning The condition >>>$1+$2<<< cannot be evaluated
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1+$2
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL, __FORM({%-11s},$1+$2); 3:10      __INFO},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1+$2
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL, __HEX_HL($1+$2)     ; 3:10      __INFO})})}){}dnl
dnl
dnl
dnl
dnl # dup 5 +
dnl # ( x -- x x+n )
define({DUP_PUSH_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_ADD},{dup $1 +},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_ADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(__IS_MEM_REF($1),{1},{
__{}    push DE             ; 1:11      __INFO   ( x -- x x+$1 )
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    add  HL, DE         ; 1:11      __INFO},
__IS_NUM($1),{0},{
__{}    ; warning The condition >>>$1<<< cannot be evaluated
__{}    push DE             ; 1:11      __INFO   ( x -- x x+$1 )
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO
__{}    add  HL, DE         ; 1:11      __INFO},
{
__{}    push DE             ; 1:11      __INFO   ( x -- x x+{}__HEX_HL($1) ){}ifelse(dnl
__{}eval((($1)+3*256) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    dec   H             ; 1:4       __INFO},
__{}eval((($1)+2*256) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    dec   H             ; 1:4       __INFO},
__{}eval((($1)+1*256) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    dec   H             ; 1:4       __INFO},
__{}eval((($1)+    2) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO},
__{}eval((($1)+    1) & 0xffff),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO},
__{}eval(($1) & 0xFFFF),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO},
__{}eval(($1)-1),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO},
__{}eval(($1)-2),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO},
__{}eval(($1)-1*256),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    inc   H             ; 1:4       __INFO},
__{}eval(($1)-2*256),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    inc   H             ; 1:4       __INFO},
__{}eval(($1)-3*256),{0},{
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    inc   H             ; 1:4       __INFO},
__{}eval((($1)) & 0xFF):_TYP_SINGLE,{0:fast},{
__{}__{}    ld    D, H          ; 1:4       __INFO   fast version
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO
__{}__{}    add   A, H          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO},
__{}eval((($1)) & 0xFF),{0},{
__{}__{}    ex   DE, HL         ; 1:4       __INFO   default version
__{}__{}    ld   HL, __HEX_HL($1)     ; 3:10      __INFO
__{}__{}    add  HL, DE         ; 1:11      __INFO},
__{}{
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL, __HEX_HL($1)     ; 3:10      __INFO
__{}__{}    add  HL, DE         ; 1:11      __INFO}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # "dup +"
dnl # ( x1 -- x2 )
dnl # x2 = x1 + x1
define({DUP_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_ADD},{dup +},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_ADD},{dnl
__{}define({__INFO},{dup +}){}dnl

    add  HL, HL         ; 1:11      dup +}){}dnl
dnl
dnl
dnl # over +
dnl # ( x2 x1 -- x2 x1+x2 )
define({OVER_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_ADD},{over +},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_ADD},{dnl
__{}define({__INFO},{over +}){}dnl

    add  HL, DE         ; 1:11      over +}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x2 - x1
define({SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_SUB},{-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SUB},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex   DE, HL         ; 1:4       __INFO
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # swap -
dnl # ( x2 x1 -- x )
dnl # x = x1 - x2
define({SWAP_SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_SUB},{swap -},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_SUB},{dnl
__{}define({__INFO},__COMPILE_INFO)
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # over -
dnl # ( x2 x1 -- x2 x1-x2 )
define({OVER_SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SUB},{over -},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SUB},{dnl
__{}define({__INFO},__COMPILE_INFO)
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl # ( x -- x-n )
dnl # x = x - n
define({PUSH_SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_SUB},{$1 -},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_SUB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(dnl
__IS_MEM_REF($1),{1},{
__{}    ; warning >>>$1<<< is a pointer to memory
__{}    ld   BC, format({%-11s},$1); 4:20      __INFO
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO},
__IS_NUM($1),{0},{
__{}    ; warning M4 does not know the numerical value of >>>$1<<<
__{}    ld   BC, format({%-11s},-($1)); 3:10      __INFO
__{}    add  HL, BC         ; 1:11      __INFO},
{ifelse(
__{}eval((($1)+3*256) & 0xffff),{0},{
__{}    inc  H              ; 1:4       __INFO   ( x -- x-__HEX_HL($1) )
__{}    inc  H              ; 1:4       __INFO
__{}    inc  H              ; 1:4       __INFO},
__{}eval((($1)+2*256) & 0xffff),{0},{
__{}    inc  H              ; 1:4       __INFO   ( x -- x-__HEX_HL($1) )
__{}    inc  H              ; 1:4       __INFO},
__{}eval((($1)+1*256) & 0xffff),{0},{
__{}    inc  H              ; 1:4       __INFO   ( x -- x-__HEX_HL($1) )},
__{}eval((($1)+    3) & 0xffff),{0},{
__{}    inc  HL             ; 1:6       __INFO   ( x -- x-__HEX_HL($1) )
__{}    inc  HL             ; 1:6       __INFO
__{}    inc  HL             ; 1:6       __INFO},
__{}eval((($1)+    2) & 0xffff),{0},{
__{}    inc  HL             ; 1:6       __INFO   ( x -- x-__HEX_HL($1) )
__{}    inc  HL             ; 1:6       __INFO},
__{}eval((($1)+    1) & 0xffff),{0},{
__{}    inc  HL             ; 1:6       __INFO   ( x -- x-__HEX_HL($1) )},
__{}eval((-($1)) & 0xFFFF),{0},{
__{}                        ;           __INFO   ( x -- x-__HEX_HL($1) )},
__{}eval(($1)-1),{0},{
__{}    dec  HL             ; 1:6       __INFO   ( x -- x-__HEX_HL($1) )},
__{}eval(($1)-2),{0},{
__{}    dec  HL             ; 1:6       __INFO   ( x -- x-__HEX_HL($1) )
__{}    dec  HL             ; 1:6       __INFO},
__{}eval(($1)-3),{0},{
__{}    dec  HL             ; 1:6       __INFO   ( x -- x-__HEX_HL($1) )
__{}    dec  HL             ; 1:6       __INFO
__{}    dec  HL             ; 1:6       __INFO},
__{}eval(($1)-1*256),{0},{
__{}    dec  H              ; 1:4       __INFO   ( x -- x-__HEX_HL($1) )},
__{}eval(($1)-2*256),{0},{
__{}    dec  H              ; 1:4       __INFO   ( x -- x-__HEX_HL($1) )
__{}    dec  H              ; 1:4       __INFO},
__{}eval(($1)-3*256),{0},{
__{}    dec  H              ; 1:4       __INFO   ( x -- x-__HEX_HL($1) )
__{}    dec  H              ; 1:4       __INFO
__{}    dec  H              ; 1:4       __INFO},
__{}eval((-($1)) & 0xFF),{0},{
__{}    ld    A, __HEX_H(-($1))       ; 2:7       __INFO   ( x -- x-__HEX_HL($1) )
__{}    add   A, H          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO},
__{}{
__{}    ld   BC, __HEX_HL(-($1))     ; 3:10      __INFO   ( x -- x-__HEX_HL($1) )
__{}    add  HL, BC         ; 1:11      __INFO})})}){}dnl
dnl
dnl
dnl
define({PUSH2_SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_SUB},{$1 $2 -},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_SUB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(dnl
dnl # ( -- x )
dnl # x = $1 - $2
dnl # CONSTANT(_a,7) CONSTANT(_b,5) PUSH2_SUB({_a},{_b}) -->  ld   HL, 0x0002     ; 3:10      _a _b -
dnl # CONSTANT(_a,7) CONSTANT(_b,5) PUSH2_SUB(_a,_b)     -->  ld   HL, 0x0002     ; 3:10      5 7 -
eval((__IS_MEM_REF($1)+__IS_MEM_REF($2))>0),{1},{dnl
__{}ifelse(eval(__IS_MEM_REF($1)+__IS_MEM_REF($2)),{2},{
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1-($2)
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL,format({%-12s},$1); 3:16      __INFO
__{}__{}    ld   BC,format({%-12s},$2); 4:20      __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO},
__{}__IS_MEM_REF($1),{1},{
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1-($2)
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL,format({%-12s},$1); 3:16      __INFO
__{}__{}    ld   BC, __FORM({%-11s},$2); 3:10      __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1-($2)
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL, __FORM({%-11s},$1); 3:10      __INFO
__{}__{}    ld   BC,format({%-12s},$2); 4:20      __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO})},
{dnl
__{}__{}ifelse(__IS_NUM($1+$2),{0},{
__{}__{}    ; warning The condition >>>$1+$2<<< cannot be evaluated
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1-($2)
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL, __FORM({%-11s},$1-($2)); 3:10      __INFO},
__{}{
__{}__{}    push DE             ; 1:11      __INFO   ( -- x )   x = $1-($2)
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL, __HEX_HL($1-($2))     ; 3:10      __INFO})})}){}dnl
dnl
dnl
dnl
dnl # ( x -- u )
dnl # absolute value of x
define({ABS},{dnl
__{}__ADD_TOKEN({__TOKEN_ABS},{abs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ABS},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, H          ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO
    jr   nc, $+8        ; 2:7/12    __INFO{}dnl
    __ASM_TOKEN_NEGATE}){}dnl
dnl
dnl
dnl # ( 5 3 -- 5 )
dnl # ( -5 -3 -- -3 )
define({MAX},{dnl
__{}__ADD_TOKEN({__TOKEN_MAX},{max},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MAX},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if HL is max
    sub   L             ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if HL is max
    ld    A, D          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if HL is max
    sbc   A, H          ; 1:4       __INFO    DE<HL --> DE-HL<0 --> carry if HL is max
    rra                 ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    jp    m, $+4        ; 3:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( 5 3 -- 5 )
dnl # ( -5 -3 -- -3 )
define({PUSH_MAX},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_MAX},{$1 max},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_MAX},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(__IS_MEM_REF($1),{1},{
    ld   BC, format({%-11s},$1); 4:20      __INFO
    ld    A, L          ; 1:4       __INFO    HL<$1 --> HL-$1<0 --> carry if $1 is max
    sub   C             ; 1:4       __INFO    HL<$1 --> HL-$1<0 --> carry if $1 is max
    ld    A, H          ; 1:4       __INFO    HL<$1 --> HL-$1<0 --> carry if $1 is max
    sbc   A, B          ; 1:4       __INFO    HL<$1 --> HL-$1<0 --> carry if $1 is max
    rra                 ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    xor   B             ; 1:4       __INFO
    jp    p, $+5        ; 3:10      __INFO
    ld    H, B          ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO    16:62 (58+66)/2},
{
    ld    A, low __FORM({%-7s},$1); 2:7       __INFO    $1>HL --> $1-HL>0 --> not carry if $1 is max or equal
    sub   L             ; 1:4       __INFO    $1>HL --> $1-HL>0 --> not carry if $1 is max or equal
    ld    A, high __FORM({%-6s},$1); 2:7       __INFO    $1>HL --> $1-HL>0 --> not carry if $1 is max or equal
    sbc   A, H          ; 1:4       __INFO    $1>HL --> $1-HL>0 --> not carry if $1 is max or equal
    rra                 ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
ifelse(__IS_NUM($1),{0},{dnl
__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}    jp    m, $+6        ; 3:10      __INFO    positive constant $1
__{}  else
__{}    jp    p, $+6        ; 3:10      __INFO    negative constant $1
__{}  endif},
{dnl
__{}ifelse(eval(($1) & 0x8000),0,{dnl
__{}    jp    m, $+6        ; 3:10      __INFO    positive constant $1},
__{}{dnl
__{}    jp    p, $+6        ; 3:10      __INFO    negative constant $1})})
    ld   HL, __FORM({%-11s},$1); 3:10      __INFO    14:45 (40+50)/2})}){}dnl
dnl
dnl
dnl # ( 5 3 -- 3 )
dnl # ( -5 -3 -- -5 )
define({MIN},{dnl
__{}__ADD_TOKEN({__TOKEN_MIN},{min},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MIN},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if HL is min
    sub   L             ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if HL is min
    ld    A, D          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if HL is min
    sbc   A, H          ; 1:4       __INFO    DE>=HL --> DE-HL>=0 --> not carry if HL is min
    rra                 ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    xor   D             ; 1:4       __INFO
    jp    p, $+4        ; 3:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( 5 3 -- 3 )
dnl # ( -5 -3 -- -5 )
define({PUSH_MIN},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_MIN},{$1 min},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_MIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(__IS_MEM_REF($1),{1},{
                        ;[16:~62]   __INFO
    ld   BC, format({%-11s},$1); 4:20      __INFO
    ld    A, C          ; 1:4       __INFO    $1<HL --> $1-HL<0 --> carry if $1 is min
    sub   L             ; 1:4       __INFO    $1<HL --> $1-HL<0 --> carry if $1 is min
    ld    A, B          ; 1:4       __INFO    $1<HL --> $1-HL<0 --> carry if $1 is min
    sbc   A, H          ; 1:4       __INFO    $1<HL --> $1-HL<0 --> carry if $1 is min
    rra                 ; 1:4       __INFO
    xor   H             ; 1:4       __INFO
    xor   B             ; 1:4       __INFO
    jp    p, $+5        ; 3:10      __INFO
    ld    H, B          ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO}
,{
                        ;[14:~45]   __INFO
    ld    A, low __FORM({%-7s},$1); 2:7       __INFO    $1<HL --> $1-HL<0 --> carry if $1 is min
    sub   L             ; 1:4       __INFO    $1<HL --> $1-HL<0 --> carry if $1 is min
    ld    A, high __FORM({%-6s},$1); 2:7       __INFO    $1<HL --> $1-HL<0 --> carry if $1 is min
    sbc   A, H          ; 1:4       __INFO    $1<HL --> $1-HL<0 --> carry if $1 is min
    rra                 ; 1:4       __INFO
    xor   H             ; 1:4       __INFO{}dnl
__{}ifelse(__IS_NUM($1),{0},{
__{}__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}__{}    jp    p, $+6        ; 3:10      __INFO    positive constant $1
__{}__{}  else
__{}__{}    jp    m, $+6        ; 3:10      __INFO    negative constant $1
__{}__{}  endif}
__{},eval(($1) & 0x8000),0,{
__{}__{}    jp    p, $+6        ; 3:10      __INFO    positive constant $1}dnl
__{},{
__{}__{}    jp    m, $+6        ; 3:10      __INFO    negative constant $1})
    ld   HL, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # ( x -- -x )
dnl # x = -x
define({NEGATE},{dnl
__{}__ADD_TOKEN({__TOKEN_NEGATE},{negate},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NEGATE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    xor   A             ; 1:4       __INFO
    sub   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
    sbc   A, H          ; 1:4       __INFO
    sub   L             ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x2 * x1
define({MUL},{dnl
__{}__ADD_TOKEN({__TOKEN_MUL},{*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MUL},{dnl
__{}__def({USE_MUL},{})dnl
__{}define({__INFO},__COMPILE_INFO)
    call MULTIPLY       ; 3:17      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x2 / x1
define({DIV},{dnl
__{}__ADD_TOKEN({__TOKEN_DIV},{/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DIV},{dnl
__{}__def({USE_DIV},{})dnl
__{}define({__INFO},__COMPILE_INFO)
    call DIVIDE         ; 3:17      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x2 % x1
define({MOD},{dnl
__{}__ADD_TOKEN({__TOKEN_MOD},{mod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MOD},{dnl
__{}__def({USE_DIV},{})dnl
__{}define({__INFO},__COMPILE_INFO)
    call DIVIDE         ; 3:17      __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x2 x1 -- r q )
dnl # x = x2 u% x1
define({DIVMOD},{dnl
__{}__ADD_TOKEN({__TOKEN_DIVMOD},{/mod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DIVMOD},{dnl
__{}__def({USE_DIV},{})dnl
__{}define({__INFO},__COMPILE_INFO)
    call DIVIDE         ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x2 u/ x1
define({UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_UDIV},{u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UDIV},{dnl
__{}__def({USE_UDIV},{}))dnl
__{}define({__INFO},__COMPILE_INFO)
    call UDIVIDE        ; 3:17      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( x2 x1 -- x )
dnl # x = x2 u% x1
define({UMOD},{dnl
__{}__ADD_TOKEN({__TOKEN_UMOD},{umod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UMOD},{dnl
__{}__def({USE_UDIV},{})dnl
__{}define({__INFO},__COMPILE_INFO)
    call UDIVIDE        ; 3:17      __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( x2 x1 -- r q )
dnl # x = x2 u% x1
define({UDIVMOD},{dnl
__{}__ADD_TOKEN({__TOKEN_UDIVMOD},{u/mod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UDIVMOD},{dnl
__{}__def({USE_UDIV},{})dnl
__{}define({__INFO},__COMPILE_INFO)
    call UDIVIDE        ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # "1+"
dnl # ( x1 -- x )
dnl # x = x1 + 1
define({_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_1ADD},{1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc  HL             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # "1-"
dnl # ( x1 -- x )
dnl # x = x1 - 1
define({_1SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_1SUB},{1-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1SUB},{dnl
__{}define({__INFO},__COMPILE_INFO)
    dec  HL             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # "2+"
dnl # ( x1 -- x )
dnl # x = x1 + 2
define({_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2ADD},{2+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc  HL             ; 1:6       __INFO
    inc  HL             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # "2-"
dnl # ( x1 -- x )
dnl # x = x1 - 2
define({_2SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_2SUB},{2-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2SUB},{dnl
__{}define({__INFO},__COMPILE_INFO)
    dec  HL             ; 1:6       __INFO
    dec  HL             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # "swap 1+ swap"
dnl # ( x2 x1 -- x2+1 x1 )
define({SWAP_1ADD_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_1ADD_SWAP},{swap 1+ swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_1ADD_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc  DE             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # "swap 1- swap"
dnl # ( x2 x1 -- x2-1 x1 )
define({SWAP_1SUB_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_1SUB_SWAP},{swap 1- swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_1SUB_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    dec  DE             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # "swap 2+ swap"
dnl # ( x2 x1 -- x2+2 x1 )
define({SWAP_2ADD_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_2ADD_SWAP},{swap 2+ swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_2ADD_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc  DE             ; 1:6       __INFO
    inc  DE             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # "swap 2- swap"
dnl # ( x2 x1 -- x2-2 x1 )
define({SWAP_2SUB_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_SWAP_2SUB_SWAP},{swap 2- swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_2SUB_SWAP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    dec  DE             ; 1:6       __INFO
    dec  DE             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # "rot +"
dnl # ( x3 x2 x1 -- x2 x1+x3 )
define({ROT_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_ADD},{rot +},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  BC             ; 1:10      __INFO   ( x3 x2 x1 -- x2 x1+x3 )
    add  HL, BC         ; 1:11      __INFO}){}dnl
dnl
dnl
dnl # "rot -"
dnl # ( x3 x2 x1 -- x2 x1-x3 )
define({ROT_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_SUB},{rot -},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_SUB},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  BC             ; 1:10      __INFO   ( x3 x2 x1 -- x2 x1-x3 )
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO}){}dnl
dnl
dnl
dnl # "rot 1+ nrot"
dnl # ( x3 x2 x1 -- x3+1 x2 x1 )
define({ROT_1ADD_NROT},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_1ADD_NROT},{rot 1+ nrot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_1ADD_NROT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  BC             ; 1:10      __INFO   ( x3 x2 x1 -- x3+1 x2 x1 )
    inc  BC             ; 1:6       __INFO
    push BC             ; 1:11      __INFO}){}dnl
dnl
dnl
dnl # "rot 1+ nrot 2over nip"
dnl # ( x3 x2 x1 -- x3+1 x2 x1 x3+1 )
define({ROT_1ADD_NROT_2OVER_NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_1ADD_NROT_2OVER_NIP},{rot 1+ -rot 2over nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_1ADD_NROT_2OVER_NIP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  BC             ; 1:10      __INFO   ( x3 x2 x1 -- x3+1 x2 x1 x3+1 )
    inc  BC             ; 1:6       __INFO
    push BC             ; 1:11      __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    ld    H, B          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # "rot 1- nrot"
dnl # ( x3 x2 x1 -- x3-1 x2 x1 )
define({ROT_1SUB_NROT},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_1SUB_NROT},{rot_1sub_nrot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_1SUB_NROT},{dnl
__{}define({__INFO},{rot_1sub_nrot}){}dnl

    pop  BC             ; 1:10      rot 1- nrot   ( x3 x2 x1 -- x3-1 x2 x1 )
    dec  BC             ; 1:6       rot 1- nrot
    push BC             ; 1:11      rot 1- nrot}){}dnl
dnl
dnl
dnl # "rot 1- nrot 2over nip"
dnl # ( x3 x2 x1 -- x3-1 x2 x1 x3-1 )
define({ROT_1SUB_NROT_2OVER_NIP},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_1SUB_NROT_2OVER_NIP},{rot 1- -rot 2over nip},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_1SUB_NROT_2OVER_NIP},{dnl
__{}define({__INFO},__COMPILE_INFO)
    pop  BC             ; 1:10      __INFO   ( x3 x2 x1 -- x3-1 x2 x1 x3-1 )
    dec  BC             ; 1:6       __INFO
    push BC             ; 1:11      __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    L, C          ; 1:4       __INFO
    ld    H, B          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # "rot 2+ nrot"
dnl # ( x3 x2 x1 -- x3+2 x2 x1 )
define({ROT_2ADD_NROT},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_2ADD_NROT},{rot_2add_nrot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_2ADD_NROT},{dnl
__{}define({__INFO},{rot_2add_nrot}){}dnl

    pop  BC             ; 1:10      rot 2+ nrot   ( x3 x2 x1 -- x3+2 x2 x1 )
    inc  BC             ; 1:6       rot 2+ nrot
    inc  BC             ; 1:6       rot 2+ nrot
    push BC             ; 1:11      rot 2+ nrot}){}dnl
dnl
dnl
dnl # "rot 2- nrot"
dnl # ( x3 x2 x1 -- x3-2 x2 x1 )
define({ROT_2SUB_NROT},{dnl
__{}__ADD_TOKEN({__TOKEN_ROT_2SUB_NROT},{rot_2sub_nrot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ROT_2SUB_NROT},{dnl
__{}define({__INFO},{rot_2sub_nrot}){}dnl

    pop  BC             ; 1:10      rot 2- nrot   ( x3 x2 x1 -- x3-2 x2 x1 )
    dec  BC             ; 1:6       rot 2- nrot
    dec  BC             ; 1:6       rot 2- nrot
    push BC             ; 1:11      rot 2- nrot}){}dnl
dnl
dnl
dnl # "2*"
dnl # ( x1 -- x )
dnl # x = x1 * 2
define({_2MUL},{dnl
__{}__ADD_TOKEN({__TOKEN_2MUL},{2*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2MUL},{dnl
__{}define({__INFO},{2*}){}dnl

    add  HL, HL         ; 1:11      2*}){}dnl
dnl
dnl
dnl # "2/"
dnl # ( x1 -- x )
dnl # x = x1 / 2
define({_2DIV},{dnl
__{}__ADD_TOKEN({__TOKEN_2DIV},{2/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DIV},{dnl
__{}define({__INFO},{2/}){}dnl

    sra   H             ; 2:8       2/   with sign
    rr    L             ; 2:8       2/}){}dnl
dnl
dnl
dnl # "256 *"
dnl # ( x1 -- x )
dnl # x = x1 * 256
define({_256MUL},{dnl
__{}__ADD_TOKEN({__TOKEN_256MUL},{256*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_256MUL},{dnl
__{}define({__INFO},{256*}){}dnl

    ld    H, L          ; 1:4       256*
    ld    L, 0x00       ; 2:7       256*}){}dnl
dnl
dnl
dnl # "256 /"
dnl # ( x1 -- x )
dnl # x = x1 / 256
define({_256DIV},{dnl
__{}__ADD_TOKEN({__TOKEN_256DIV},{256/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_256DIV},{dnl
__{}define({__INFO},{256/}){}dnl

    ld    L, H          ; 1:4       256/   with sign
    rl    H             ; 2:8       256/
    sbc   A, A          ; 1:4       256/
    ld    H, A          ; 1:4       256/}){}dnl
dnl
dnl
dnl
define({PUSH_MUL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_MUL},{$1 *},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_MUL},{dnl
__{}define({__INFO},{$1 *}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
{dnl
__{}PUSH_MUL_MK1($1){}dnl
__{}define({_BEST_OUT},{PUSH_MUL_MK1_OUT}){}dnl
__{}define({_BEST_COST},PUSH_MUL_MK1_COST){}dnl
__{}define({_BEST_INFO},{PUSH_MUL_MK1_INFO}){}dnl
__{}PUSH_MUL_MK2($1){}dnl
__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(PUSH_MUL_MK2_COST,_BEST_COST),{1},{dnl
__{}__{}define({_BEST_OUT},{PUSH_MUL_MK2_OUT}){}dnl
__{}__{}define({_BEST_COST},PUSH_MUL_MK2_COST){}dnl
__{}__{}define({_BEST_INFO},PUSH_MUL_MK2_INFO){}dnl
__{}}){}dnl
__{}PUSH_MUL_MK3($1){}dnl
__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(PUSH_MUL_MK3_COST,_BEST_COST),{1},{dnl
__{}__{}define({_BEST_OUT},{PUSH_MUL_MK3_OUT}){}dnl
__{}__{}define({_BEST_COST},PUSH_MUL_MK3_COST){}dnl
__{}__{}define({_BEST_INFO},PUSH_MUL_MK3_INFO){}dnl
__{}}){}dnl
__{}PUSH_MUL_MK4($1){}dnl
__{}ifelse(PUSH_MUL_CHECK_FIRST_IS_BETTER(PUSH_MUL_MK4_COST,_BEST_COST),{1},{dnl
__{}__{}define({_BEST_OUT},{PUSH_MUL_MK4_OUT}){}dnl
__{}__{}define({_BEST_COST},PUSH_MUL_MK4_COST){}dnl
__{}__{}define({_BEST_INFO},PUSH_MUL_MK4_INFO){}dnl
__{}}){}dnl
__{}_BEST_INFO{}dnl
__{}_BEST_OUT{}dnl
})}){}dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 8bit Arithmetic
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl # ( c2 c1 -- c2+c1 )
dnl # c = c2 + c1
define({CADD},{dnl
__{}__ADD_TOKEN({__TOKEN_CADD},{c+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CADD},{dnl
__{}define({__INFO},{c+}){}dnl

    ld    A, E          ; 1:4       C+   ( c2 c1 -- c2+c1 )
    add   A, L          ; 1:4       C+   ( c2 c1 -- c2+c1 )
    ld    L, A          ; 1:4       C+   ( c2 c1 -- c2+c1 )
    pop  DE             ; 1:10      C+}){}dnl
dnl
dnl
dnl
dnl # 0x8000 C@ C+
dnl # ( c1 -- c1+(adr) )
dnl # c = c2 + c1
define({PUSH_CFETCH_CADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CFETCH_CADD},{$1_cfetch c+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CFETCH_CADD},{dnl
__{}define({__INFO},{$1_cfetch c+}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},{
    ld    A, format({%-11s},{($1)}); 3:13      $1 C@ C+   ( c -- c+($1) )
    add   A, L          ; 1:4       $1 C@ C+
    ld    L, A          ; 1:4       $1 C@ C+},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # C@ 0x8000 C@ C+
dnl # ( c -- (c)+(adr) )
dnl # c = c2 + c1
define({CFETCH_PUSH_CFETCH_CADD},{dnl
__{}__ADD_TOKEN({__TOKEN_CFETCH_PUSH_CFETCH_CADD},{cfetch $1_cfetch c+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CFETCH_PUSH_CFETCH_CADD},{dnl
__{}define({__INFO},{cfetch $1_cfetch c+}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},{
    ld    A,format({%-12s},{($1)}); 3:13      C@ $1 C@ C+   ( c -- (c)+($1) )
    add   A,(HL)        ; 1:7       C@ $1 C@ C+
    ld    L, A          ; 1:4       C@ $1 C@ C+},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # 0x8000 C@ C+ 0x4000 C!
dnl # ( c -- )
define({PUSH_CFETCH_CADD_PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CFETCH_CADD_PUSH_CSTORE},{$1_cfetch c+ $2_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CFETCH_CADD_PUSH_CSTORE},{dnl
__{}define({__INFO},{$1_cfetch c+ $2_cstore}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
__{}$#,{2},{
                        ;[9:47]     $1 C@ C+ $2 C!   ( c --  )
    ld    A,format({%-12s},{($1)}); 3:13      $1 C@ C+ $2 C!
    add   A, L          ; 1:4       $1 C@ C+ $2 C!
    ld  format({%-16s},{($2), A}); 3:13      $1 C@ C+ $2 C!   [$2] = [$1] + low TOS
    ex   DE, HL         ; 1:4       $1 C@ C+ $2 C!
    pop  DE             ; 1:10      $1 C@ C+ $2 C!},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # C@ 0x8000 C@ C+ 0x4000 C!
dnl # ( c -- )
define({CFETCH_PUSH_CFETCH_CADD_PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_CFETCH_PUSH_CFETCH_CADD_PUSH_CSTORE},{cfetch $1_cfetch c+_push_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CFETCH_PUSH_CFETCH_CADD_PUSH_CSTORE},{dnl
__{}define({__INFO},{cfetch_push_cfetch c+_push_cstore}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
__{}$#,{2},{
                        ;[9:47]     C@ $1 C@ C+ $2 C!   ( c --  )
    ld    A,format({%-12s},{($1)}); 3:13      C@ $1 C@ C+ $2 C!
    add   A,(HL)        ; 1:7       C@ $1 C@ C+ $2 C!
    ld  format({%-16s},{($2), A}); 3:13      C@ $1 C@ C+ $2 C!   [$2] = [$1] + [TOS]
    ex   DE, HL         ; 1:4       C@ $1 C@ C+ $2 C!
    pop  DE             ; 1:10      C@ $1 C@ C+ $2 C!},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl # ( c -- c+n )
dnl # c = c + n
define({PUSH_CADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CADD},{$1 c+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CADD},{dnl
__{}define({__INFO},{$1 c+}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ; warning {$0}($@): The condition $1 cannot be evaluated
__{}    ld    A, format({%-11s},$1); 3:13     $1 C+
__{}    add   A, L          ; 1:4      $1 C+
__{}    ld    L, A          ; 1:4      $1 C+},
__IS_NUM($1),{0},{dnl
__{}    ; warning {$0}($@): The condition $1 cannot be evaluated
__{}    ld    A, __FORM({%-11s},$1); 2:7      $1 C+
__{}    add   A, L          ; 1:4      $1 C+
__{}    ld    L, A          ; 1:4      $1 C+},
{dnl
__{}ifelse(eval(($1)+3),{0},{dnl
__{}__{}    dec   L             ; 1:4       $1 C+   ( c -- c-2 )
__{}__{}    dec   L             ; 1:4       $1 C+
__{}__{}    dec   L             ; 1:4       $1 C+},
__{}eval(($1)+2),{0},{dnl
__{}__{}    dec   L             ; 1:4       $1 C+   ( c -- c-2 )
__{}__{}    dec   L             ; 1:4       $1 C+},
__{}__{}eval(($1)+1),{0},{dnl
__{}__{}    dec   L             ; 1:4       $1 C+   ( c -- c-1 )},
__{}__{}eval($1),{0},{snl
__{}__{}                        ;           $1 C+   ( c -- c+0 )},
__{}__{}eval(($1)-1),{0},{dnl
__{}__{}    inc   L             ; 1:4       $1 C+   ( c -- c+1 )},
__{}__{}eval(($1)-2),{0},{dnl
__{}__{}    inc   L             ; 1:4       $1 C+   ( c -- c+1 )
__{}__{}    inc   L             ; 1:4       $1 C+},
__{}__{}eval(($1)-3),{0},{dnl
__{}__{}    inc   L             ; 1:4       $1 C+   ( c -- c+1 )
__{}__{}    inc   L             ; 1:4       $1 C+
__{}__{}    inc   L             ; 1:4       $1 C+},
__{}__{}{ifelse(eval((((($1) | 255) + 1) > 256) || (($1 + 256) < 128)),{1},{dnl
__{}__{}__{}    ; warning {$0}($@): Parameter $1 exceeds one byte limit!
__{}__{}__{}}){}dnl
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       $1 C+   ( d -- d+$1 )
__{}__{}    add   A, L          ; 1:4       $1 C+
__{}__{}    ld    L, A          ; 1:4       $1 C+}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 16bit & 32bit mix Arithmetic
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl
dnl # S>D
dnl # ( x1 -- sign(x1) x1 )
define({S_TO_D},{dnl
__{}__ADD_TOKEN({__TOKEN_S_TO_D},{s_to_d},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_S_TO_D},{dnl
__{}define({__INFO},{s_to_d}){}dnl

    push DE             ; 1:11      S>D   ( x -- d ) == ( x -- sign(x) x )
    ld    A, H          ; 1:4       S>D
    add   A, A          ; 1:4       S>D
    sbc   A, A          ; 1:4       S>D
    ld    D, A          ; 1:4       S>D
    ld    E, A          ; 1:4       S>D}){}dnl
dnl
dnl
dnl
dnl # D>S
dnl # ( 0 x1 -- x1 )
define({D_TO_S},{dnl
__{}__ADD_TOKEN({__TOKEN_D_TO_S},{d_to_s},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D_TO_S},{dnl
__{}define({__INFO},{d_to_s}){}dnl

    pop  DE             ; 1:10      D>S   ( d -- x ) == ( 0 lo -- lo )}){}dnl
dnl
dnl
dnl
dnl # ( hi lo x -- d2 ) == ( d x -- d2 )  d2 = d + x
define({MADD},{dnl
__{}__ADD_TOKEN({__TOKEN_MADD},{m+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MADD},{dnl
__{}define({__INFO},{m+}){}dnl

                        ;[11:57]    M+   ( d x -- d2 )  d2 = d + x
    ld    A, H          ; 1:4       M+
    add   A, A          ; 1:4       M+
    sbc   A, A          ; 1:4       M+   0xFF or 0x00
    ld    C, A          ; 1:4       M+   d2 = d + CCHL
    add  HL, DE         ; 1:11      M+   lo16(d)+x
    pop  DE             ; 1:10      M+
    adc   A, E          ; 1:4       M+
    ld    E, A          ; 1:4       M+
    ld    A, C          ; 1:4       M+
    adc   A, D          ; 1:4       M+
    ld    D, A          ; 1:4       M+   hi16(d)+hi16(x)}){}dnl
dnl
dnl
dnl
dnl # ( d n -- floored_remainder floored_quotient )
define({FMDIVMOD},{dnl
__{}__ADD_TOKEN({__TOKEN_FMDIVMOD},{fm/mod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FMDIVMOD},{dnl
__{}define({__INFO},{fm/mod}){}dnl
define({USE_F32DIV16},{})
    pop  BC             ; 1:10      {FM/MOD}   ( d n -- floored_remainder floored_quotient )
    call F32DIV16       ; 3:17      {FM/MOD}}){}dnl
dnl
dnl
dnl
dnl # ( d n -- symmetric_remander symmetric_quotient )
define({SMDIVREM},{dnl
__{}__ADD_TOKEN({__TOKEN_SMDIVREM},{sm/rem},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SMDIVREM},{dnl
__{}define({__INFO},{sm/rem}){}dnl
define({USE_S32DIV16},{})
    pop  BC             ; 1:10      {SM/REM}   ( d n -- symmetric_remander symmetric_quotient )
    call S32DIV16       ; 3:17      {SM/REM}}){}dnl
dnl
dnl
dnl
dnl # ( ud u -- remainder quotient )
define({UMDIVMOD},{dnl
__{}__ADD_TOKEN({__TOKEN_UMDIVMOD},{um/mod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UMDIVMOD},{dnl
__{}define({__INFO},{um/mod}){}dnl
define({USE_U32DIV16},{})
    pop  BC             ; 1:10      {UM/MOD}   ( ud u -- remainder quotient )
    call U32DIV16       ; 3:17      {UM/MOD}}){}dnl
dnl
dnl
dnl
dnl # ( x1 x2 -- d )
define({MMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_MMUL},{m*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MMUL},{dnl
__{}define({__INFO},{m*}){}dnl
define({USE_S16MUL},{})
    call S16MUL         ; 3:17      M*   ( x1 x2 -- d )}){}dnl
dnl
dnl
dnl
dnl # ( u1 u2 -- ud )
define({UMMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_UMMUL},{um*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UMMUL},{dnl
__{}define({__INFO},{um*}){}dnl
define({USE_U16MUL},{})
    call U16MUL         ; 3:17      UM*   ( u1 u2 -- ud )}){}dnl
dnl
dnl
dnl
dnl # ( n1 n2 n3 -- n1*n2%n3 n1*n2/n3 )
define({MULDIVMOD},{dnl
__{}__ADD_TOKEN({__TOKEN_MULDIVMOD},{*/mod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MULDIVMOD},{dnl
__{}define({__INFO},{*/mod}){}dnl
define({USE_U16MUL},{})
    ex  (SP),HL         ; 1:19      {*/MOD}   ( n1 n2 n3 -- n1*n2%n3 n1*n2/n3 )
    call S16MUL         ; 3:17      {*/MOD}
    ex   DE, HL         ; 1:4       {*/MOD}
    ex  (SP),HL         ; 1:19      {*/MOD}
    call S32DIV16       ; 3:17      {*/MOD}}){}dnl
dnl
dnl
dnl
dnl # ( n1 n2 n3 -- n1*n2/n3 )
define({MULDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_MULDIV},{*/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MULDIV},{dnl
__{}define({__INFO},{*/}){}dnl
define({USE_U16MUL},{})
    ex  (SP),HL         ; 1:19      {*/}   ( n1 n2 n3 -- n1*n2/n3 )
    call S16MUL         ; 3:17      {*/}
    ex   DE, HL         ; 1:4       {*/}
    ex  (SP),HL         ; 1:19      {*/}
    call S32DIV16       ; 3:17      {*/}
    pop  DE             ; 1:10      {*/}}){}dnl
dnl
dnl
dnl
dnl ---------------------------------------------------------------------------
dnl ## 32bit Arithmetic ( DE = hi, HL = lo )
dnl ---------------------------------------------------------------------------
dnl
dnl
dnl
dnl # ( hi2 lo2 hi1 lo1 -- d2+d1 )
dnl # d = d2 + d1
define({DADD},{dnl
__{}__ADD_TOKEN({__TOKEN_DADD},{d+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DADD},{dnl
__{}define({__INFO},{d+}){}dnl

    pop  BC             ; 1:10      D+   ( hi2 lo2 hi1 lo1 -- d2+d1 )
    add  HL, BC         ; 1:11      D+   lo1+lo2
    ex   DE, HL         ; 1:4       D+
    pop  BC             ; 1:10      D+
    adc  HL, BC         ; 2:15      D+   hi1+hi2
    ex   DE, HL         ; 1:4       D+}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 )
dnl # [pd1] += [pd2]
define({PDADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PDADD},{pd+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A,(DE)        ; 1:7       __INFO   ( pd2 pd1 -- pd2 pd1 )  [pd1] += [pd2] with align 4
    add  (HL)           ; 1:7       __INFO
    ld   (HL), A        ; 1:7       __INFO
    ld     C, L         ; 1:4       __INFO
    ld     B, E         ; 1:4       __INFO
    inc    L            ; 1:4       __INFO
    inc    E            ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    adc   A,(HL)        ; 1:7       __INFO
    ld   (HL), A        ; 1:7       __INFO
    inc    L            ; 1:4       __INFO
    inc    E            ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    adc   A,(HL)        ; 1:7       __INFO
    ld   (HL), A        ; 1:7       __INFO
    inc    L            ; 1:4       __INFO
    inc    E            ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    adc   A,(HL)        ; 1:7       __INFO
    ld   (HL), A        ; 1:7       __INFO
    ld     L, C         ; 1:4       __INFO
    ld     E, B         ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( d -- d+n )
dnl # d = d + n
define({PUSHDOT_DADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_DADD},{$1. d+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_DADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ; warning {$0}($@): The condition $1 cannot be evaluated
__{}    ld   BC, format({%-11s},$1); 4:20      __INFO
__{}    add  HL, BC         ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld   BC,format({%-12s},($1+2)); 4:20      __INFO
__{}    adc  HL, BC         ; 2:15      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO},
__IS_NUM($1),{0},{dnl
__{}    .error {$0}($@): The condition $1 cannot be evaluated},
{ifelse(dnl
__{}__{}eval(($1)+3*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       __INFO   ( d -- d-3*2^24 )
__{}__{}    dec   D             ; 1:4       __INFO
__{}__{}    dec   D             ; 1:4       __INFO},
__{}__{}eval(($1)+2*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       __INFO   ( d -- d-2^25 )
__{}__{}    dec   D             ; 1:4       __INFO},
__{}__{}eval(($1)+1*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       __INFO   ( d -- d-2^24 )},
__{}__{}eval(($1)+5*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-5*2^16 )
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO},
__{}__{}eval(($1)+4*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-2^18 )
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO},
__{}__{}eval(($1)+3*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-3*2^16 )
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO},
__{}__{}eval(($1)+2*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-2^17 )
__{}__{}    dec  DE             ; 1:6       __INFO},
__{}__{}eval(($1)+1*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-2^16 )},
__{}__{}eval(($1)+2*256),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       __INFO   ( d -- d-2^9 )
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    sub   H             ; 1:4       __INFO
__{}__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}eval(($1)+1*256),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       __INFO   ( d -- d-2^8 )
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    sub   H             ; 1:4       __INFO
__{}__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}eval(((($1) & 0xFFFF0000) == 0xFFFF0000) && ((($1) & 0xFF) == 0)),{1},{dnl
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   ( d -- d+$1 )
__{}__{}    add   A, H          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO
__{}__{}    jr    c, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}eval(($1)+2),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       __INFO   ( d -- d-2 )
__{}__{}    dec  HL             ; 1:6       __INFO   lo--
__{}__{}    dec  HL             ; 1:6       __INFO   lo--
__{}__{}    sub   H             ; 1:4       __INFO   lo(d)-lo(d-2)
__{}__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}eval(($1)+1),{0},{dnl
__{}__{}    ld    A, L          ; 1:4       __INFO   ( d -- d-1 )
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO   lo--
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}eval($1),{0},{snl
__{}__{}                        ;           __INFO   ( d -- d+0 )},
__{}__{}eval(($1)-1),{0},{dnl
__{}__{}    inc  HL             ; 1:6       __INFO   lo++
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   hi++},
__{}__{}eval(($1)-256),{0},{dnl
__{}__{}    inc   H             ; 1:4       __INFO   ( d -- d+256 )
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   hi++},
__{}__{}eval(($1) & 0xFFFF00FF),{0},{dnl
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __INFO   ( d -- d+$1 )
__{}__{}    add   A, H          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO
__{}__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   hi++},
__{}__{}eval(($1)-1*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+2^16 )},
__{}__{}eval(($1)-2*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+2^17 )
__{}__{}    inc  DE             ; 1:6       __INFO},
__{}__{}eval(($1)-3*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+3*2^16 )
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO},
__{}__{}eval(($1)-4*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+2^18 )
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO},
__{}__{}eval(($1)-5*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+5*2^16 )
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO},
__{}__{}eval(($1)-1*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       __INFO   ( d -- d+2^24 )},
__{}__{}eval(($1)-2*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       __INFO   ( d -- d+2^25 )
__{}__{}    inc   D             ; 1:4       __INFO},
__{}__{}eval(($1)-3*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       __INFO   ( d -- d+3*2^24 )
__{}__{}    inc   D             ; 1:4       __INFO
__{}__{}    inc   D             ; 1:4       __INFO},
__{}__{}eval(($1) & 0xFFFFFF),{0},{dnl
__{}__{}    ld    A, __HEX_D($1)       ; 2:7       __INFO   ( d -- d+$1 )
__{}__{}    add   A, D          ; 1:4       __INFO
__{}__{}    ld    D, A          ; 1:4       __INFO},
__{}__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}    ld   BC, __HEX_DE($1)     ; 3:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO},
__{}__{}__HEX_DE($1),{0x0000},{dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO   ( d -- d+$1 )
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   hi++},
__{}__{}__HEX_DE($1),{0x0001},{dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO   ( d -- d+$1 )
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   hi++
__{}__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   hi++},
__{}__{}__HEX_DE($1),{0xFFFF},{dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO   ( d -- d{}$1 )
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    jr    c, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}__HEX_DE($1),{0xFFFE},{dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO   ( d -- d{}$1 )
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--
__{}__{}    jr    c, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}{dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   BC, __HEX_DE($1)     ; 3:10      __INFO
__{}__{}    adc  HL, BC         ; 2:15      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO}){}dnl
})}){}dnl
dnl
dnl
dnl # "2dup D+"
dnl # ( hi1 lo1 -- d1 d1+d1 )
dnl # d0 = d1 + d1
define({_2DUP_DADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_DADD},{2dup_d+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_DADD},{dnl
__{}define({__INFO},{2dup_d+}){}dnl

    push  DE            ; 1:11      2dup D+   ( hi1 lo1 -- hi1 lo1 hi1+hi1+carry lo1+lo1 )
    push  HL            ; 1:11      2dup D+
    add  HL, HL         ; 1:11      2dup D+
    ex   DE, HL         ; 1:4       2dup D+
    adc  HL, HL         ; 2:15      2dup D+
    ex   DE, HL         ; 1:4       2dup D+}){}dnl
dnl
dnl
dnl # 2swap D+
dnl # ( d2 d1 -- d1+d2 )
dnl # ( hi2 lo2 hi1 lo1 -- hi1+hi2+carry lo1+lo2 )
define({_2SWAP_DADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2SWAP_DADD},{2swap_d+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2SWAP_DADD},{dnl
__{}define({__INFO},{2swap_d+}){}dnl

                        ;[7:54]     2swap D+   ( hi2 lo2 hi1 lo1 -- hi1+hi2+carry lo1+lo2 )
    pop  BC             ; 1:10      2swap D+   lo2
    add  HL, BC         ; 1:11      2swap D+
    ex   DE, HL         ; 1:4       2swap D+
    pop  BC             ; 1:10      2swap D+   hi2
    adc  HL, BC         ; 2:15      2swap D+
    ex   DE, HL         ; 1:4       2swap D+}){}dnl
dnl
dnl
dnl # 2over D+
dnl # ( d2 d1 -- d2 d1+d2 )
dnl # ( hi2 lo2 hi1 lo1 -- hi2 lo2 hi1+hi2+carry lo1+lo2 )
define({_2OVER_DADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_DADD},{2over_d+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_DADD},{dnl
__{}define({__INFO},{2over_d+}){}dnl

                        ;[9:93]     2over D+   ( hi2 lo2 hi1 lo1 -- hi2 lo2 hi1+hi2+carry lo1+lo2 )
    pop  BC             ; 1:10      2over D+   lo2
    add  HL, BC         ; 1:11      2over D+
    ex  (SP),HL         ; 1:19      2over D+   hi2
    ex   DE, HL         ; 1:4       2over D+
    adc  HL, DE         ; 2:15      2over D+
    ex   DE, HL         ; 1:4       2over D+
    ex  (SP),HL         ; 1:19      2over D+
    push BC             ; 1:11      2over D+}){}dnl
dnl
dnl
dnl # ( d2 d1 -- d )
dnl # d = d2 - d1
define({DSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_DSUB},{d-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DSUB},{dnl
__{}define({__INFO},{d-}){}dnl
ifelse(TYP_DSUB,{small},{
                       ;[12:74]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    ld    B, D          ; 1:4       D-
    ld    C, E          ; 1:4       D-
    ex   DE, HL         ; 1:4       D-   DE = lo1
    pop  HL             ; 1:10      D-   HL = lo2
    or    A             ; 1:4       D-
    sbc  HL, DE         ; 2:15      D-   lo2-lo1
    ex   DE, HL         ; 1:4       D-
    pop  HL             ; 1:10      D-   HL = hi2
    sbc  HL, BC         ; 2:15      D-   hi2-hi1
    ex   DE, HL         ; 1:4       D-}
,{
                       ;[14:68]     D-   ( hi2 lo2 hi1 lo1 -- h2-h1-carry lo2-lo1 )
    pop  BC             ; 1:10      D-   BC = lo2
    ld    A, C          ; 1:4       D-
    sub   L             ; 1:4       D-   lo2-lo1
    ld    L, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, H          ; 1:4       D-   lo2-lo1
    ld    H, A          ; 1:4       D-
    pop  BC             ; 1:10      D-   BC = hi2
    ld    A, C          ; 1:4       D-
    sbc   A, E          ; 1:4       D-   hi2-hi1
    ld    E, A          ; 1:4       D-
    ld    A, B          ; 1:4       D-
    sbc   A, D          ; 1:4       D-   hi2-hi1
    ld    D, A          ; 1:4       D-})}){}dnl
dnl
dnl
dnl # ( pd2 pd1 -- pd2 pd1 )
dnl # [pd1] -= [pd2]
define({PDSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_PDSUB},{pd-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PDSUB},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A,(DE)        ; 1:7       __INFO   ( pd2 pd1 -- pd2 pd1 )  [pd1] -= [pd2] with align 4
    sub  (HL)           ; 1:7       __INFO
    ld   (HL), A        ; 1:7       __INFO
    ld     C, L         ; 1:4       __INFO
    ld     B, E         ; 1:4       __INFO
    inc    L            ; 1:4       __INFO
    inc    E            ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    ld   (HL), A        ; 1:7       __INFO
    inc    L            ; 1:4       __INFO
    inc    E            ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    ld   (HL), A        ; 1:7       __INFO
    inc    L            ; 1:4       __INFO
    inc    E            ; 1:4       __INFO
    ld    A,(DE)        ; 1:7       __INFO
    sbc   A,(HL)        ; 1:7       __INFO
    ld   (HL), A        ; 1:7       __INFO
    ld     L, C         ; 1:4       __INFO
    ld     E, B         ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # 2swap D-
dnl # ( d2 d1 -- d1-d2 )
define({_2SWAP_DSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_2SWAP_DSUB},{2swap_d-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2SWAP_DSUB},{dnl
__{}define({__INFO},{2swap_d-}){}dnl

                        ;[9:62]     2swap D-   ( hi2 lo2 hi1 lo1 -- hi1-hi2-carry lo1-lo2 )
    or    A             ; 1:4       2swap D-
    pop  BC             ; 1:10      2swap D-   lo2
    sbc  HL, BC         ; 2:15      2swap D-
    ex   DE, HL         ; 1:4       2swap D-
    pop  BC             ; 1:10      2swap D-   hi2
    sbc  HL, BC         ; 2:15      2swap D-
    ex   DE, HL         ; 1:4       2swap D-}){}dnl
dnl
dnl
dnl # 2over D-
dnl # ( d2 d1 -- d2 d1-d2 )
define({_2OVER_DSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_DSUB},{2over_d-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_DSUB},{dnl
__{}define({__INFO},{2over_d-}){}dnl

                        ;[11:101]   2over D-   ( hi2 lo2 hi1 lo1 -- hi2 lo2 hi1-hi2-carry lo2-lo1 )
    pop  BC             ; 1:10      2over D-   lo2
    or    A             ; 1:4       2over D-
    sbc  HL, BC         ; 2:15      2over D-
    ex  (SP),HL         ; 1:19      2over D-   hi2
    ex   DE, HL         ; 1:4       2over D-
    sbc  HL, DE         ; 2:15      2over D-
    ex   DE, HL         ; 1:4       2over D-
    ex  (SP),HL         ; 1:19      2over D-
    push BC             ; 1:11      2over D-}){}dnl
dnl
dnl
dnl # ( d -- d-n )
dnl # d = d - n
define({PUSHDOT_DSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_DSUB},{$1. d-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_DSUB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ; warning {$0}($@): The condition $1 cannot be evaluated
__{}    ld   BC, format({%-11s},$1); 4:20      __INFO
__{}    or    A, A          ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld   BC,format({%-12s},($1+2)); 4:20      __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO},
__IS_NUM($1),{0},{dnl
__{}    .error {$0}($@): The condition $1 cannot be evaluated},
{ifelse(dnl
__{}__{}eval(($1)+3*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       __INFO   ( d -- d+3*2^24 )
__{}__{}    inc   D             ; 1:4       __INFO
__{}__{}    inc   D             ; 1:4       __INFO},
__{}__{}eval(($1)+2*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       __INFO   ( d -- d+2^25 )
__{}__{}    inc   D             ; 1:4       __INFO},
__{}__{}eval(($1)+1*256*256*256),{0},{dnl
__{}__{}    inc   D             ; 1:4       __INFO   ( d -- d+2^24 )},
__{}__{}eval(($1)+5*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+5*2^16 )
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO},
__{}__{}eval(($1)+4*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+2^18 )
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO},
__{}__{}eval(($1)+3*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+3*2^16 )
__{}__{}    inc  DE             ; 1:6       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO},
__{}__{}eval(($1)+2*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+2^17 )
__{}__{}    inc  DE             ; 1:6       __INFO},
__{}__{}eval(($1)+1*256*256),{0},{dnl
__{}__{}    inc  DE             ; 1:6       __INFO   ( d -- d+2^16 )},
__{}__{}eval(($1)+256),{0},{dnl
__{}__{}    inc   H             ; 1:4       __INFO   ( d -- d+2^8 )
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   hi++},
__{}__{}eval(($1)+1),{0},{dnl
__{}__{}    inc  HL             ; 1:6       __INFO   ( d -- d+1 )
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   hi++},
__{}__{}eval($1),{0},{snl
__{}__{}                        ;           __INFO   ( d -- d+0 )},
__{}__{}eval(($1)-1),{0},{dnl
__{}__{}    ld    A, L          ; 1:4       __INFO   ( d -- d-1 )
__{}__{}    or    H             ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO   lo--
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}eval(($1)-2),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       __INFO   ( d -- d-2 )
__{}__{}    dec  HL             ; 1:6       __INFO   lo--
__{}__{}    dec  HL             ; 1:6       __INFO   lo--
__{}__{}    sub   H             ; 1:4       __INFO   lo(d)-lo(d-2)
__{}__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}eval(($1)-256),{0},{dnl
__{}__{}    inc   H             ; 1:4       __INFO   ( d -- d-2^8 )
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--
__{}__{}    dec   H             ; 1:4       __INFO},
__{}__{}eval(($1) & 0xFFFF00FF),{0},{dnl
__{}__{}    ld    A, H          ; 1:4       __INFO   ( d -- d-$1 )
__{}__{}    sub  __HEX_H($1)           ; 2:7       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO
__{}__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}eval(($1)-1*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-2^16 )},
__{}__{}eval(($1)-2*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-2^17 )
__{}__{}    dec  DE             ; 1:6       __INFO},
__{}__{}eval(($1)-3*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-3*2^16 )
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO},
__{}__{}eval(($1)-4*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-2^18 )
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO},
__{}__{}eval(($1)-5*256*256),{0},{dnl
__{}__{}    dec  DE             ; 1:6       __INFO   ( d -- d-5*2^16 )
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO
__{}__{}    dec  DE             ; 1:6       __INFO},
__{}__{}eval(($1)-1*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       __INFO   ( d -- d-2^24 )},
__{}__{}eval(($1)-2*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       __INFO   ( d -- d-2^25 )
__{}__{}    dec   D             ; 1:4       __INFO},
__{}__{}eval(($1)-3*256*256*256),{0},{dnl
__{}__{}    dec   D             ; 1:4       __INFO   ( d -- d-3*2^24 )
__{}__{}    dec   D             ; 1:4       __INFO
__{}__{}    dec   D             ; 1:4       __INFO},
__{}__{}eval(($1) & 0xFFFFFF),{0},{dnl
__{}__{}    ld    A, D          ; 1:4       __INFO   ( d -- d-($1) )
__{}__{}    sub  __HEX_D($1)           ; 2:7       __INFO   ( d -- d-($1) )
__{}__{}    ld    D, A          ; 1:4       __INFO},
__{}__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}    ld   BC, __HEX_DE(-($1))     ; 3:10      __INFO   ( d -- d-($1) )
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO},
__{}__{}eval(-($1) & 0xFFFF0000),{0},{dnl
__{}__{}    ld   BC, __HEX_HL(-($1))     ; 3:10      __INFO   ( d -- d-($1) )
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   hi++},
__{}__{}eval((-($1) & 0xFFFF0000) - 0xFFFF0000),{0},{dnl
__{}__{}    ld   BC, __HEX_HL(-($1))     ; 3:10      __INFO   ( d -- d-($1) )
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    jr    c, $+3        ; 2:7/12    __INFO
__{}__{}    dec  DE             ; 1:6       __INFO   hi--},
__{}__{}{dnl
__{}__{}    ld   BC, __HEX_HL(-($1))     ; 3:10      __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   BC, __HEX_DE(-($1))     ; 3:10      __INFO
__{}__{}    adc  HL, BC         ; 2:15      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ( d -- ud )
dnl # ( hi lo -- uhi ulo )
dnl # ud is absolute value of d
define({DABS},{dnl
__{}__ADD_TOKEN({__TOKEN_DABS},{dabs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DABS},{dnl
__{}define({__INFO},{dabs}){}dnl
define({USE_DNEGATE},{})
    ld    A, D          ; 1:4       dabs
    add   A, A          ; 1:4       dabs
    call  c, NEGATE_32  ; 3:17      dabs}){}dnl
dnl
dnl
dnl # ( 5 3 -- 5 )
dnl # ( -5 -3 -- -3 )
dnl # ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
define({DMAX},{dnl
__{}__ADD_TOKEN({__TOKEN_DMAX},{dmax},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DMAX},{dnl
__{}define({__INFO},{dmax}){}dnl
define({USE_DMAX},{})
                        ;[5:141/166]dmax   ( hi_2 lo_2 hi_1 lo_1 -- hi_max lo_max )
    pop  BC             ; 1:10      dmax   BC = lo_2
    pop  AF             ; 1:10      dmax   AF = hi_2
    call MAX_32         ; 3:17      dmax}){}dnl
dnl
dnl
dnl
dnl # ( 5 3 -- 5 )
dnl # ( -5 -3 -- -3 )
define({PUSHDOT_DMAX},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_DMAX},{$1._dmax},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_DMAX},{dnl
__{}define({__INFO},{$1._dmax}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}                        ;[27:94/118]$1 dmax
__{}    ld   BC, format({%-11s},$1); 4:20      $1 dmax
__{}    ld    A, L          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sub   C             ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, H          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, B          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld   BC, format({%-11s},($1+2)); 4:20      $1 dmax
__{}    ld    A, E          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, C          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, D          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, B          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    rra                 ; 1:4       $1 dmax   carry --> sign
__{}    xor   D             ; 1:4       $1 dmax
__{}    xor   B             ; 1:4       $1 dmax
__{}    jp    p, $+8        ; 3:10      $1 dmax
__{}    ld    D, B          ; 1:4       $1 dmax
__{}    ld    E, C          ; 1:4       $1 dmax
__{}    ld   HL, format({%-11s},$1); 3:16      $1 dmax},
__IS_NUM($1),{0},{dnl
    .error {$0}($@): M4 does not know $1 parameter value!},
{
__{}                        ;[23:62/82] $1 dmax
__{}    ld    A, L          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sub   __HEX_L($1)          ; 2:7       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, H          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, __HEX_H($1)       ; 2:7       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, E          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, __HEX_E($1)       ; 2:7       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    ld    A, D          ; 1:4       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    sbc   A, __HEX_D($1)       ; 2:7       $1 dmax   DEHL<$1 --> DEHL-$1<0 --> carry if $1 is max
__{}    rra                 ; 1:4       $1 dmax   carry --> sign
__{}    xor   D             ; 1:4       $1 dmax
__{}ifelse(eval(($1)<0),{1},{dnl
__{}__{}    jp    m, $+9        ; 3:10      $1 dmax   negative constant __HEX_DEHL($1)},
__{}{dnl
__{}__{}    jp    p, $+9        ; 3:10      $1 dmax   positive constant __HEX_DEHL($1)})
__{}    ld   HL, __HEX_HL($1)     ; 3:10      $1 dmax
__{}    ld   DE, __HEX_DE($1)     ; 3:10      $1 dmax}){}dnl
}){}dnl
dnl
dnl
dnl # ( 5 3 -- 3 )
dnl # ( -5 -3 -- -5 )
dnl # ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
define({DMIN},{dnl
__{}__ADD_TOKEN({__TOKEN_DMIN},{dmin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DMIN},{dnl
__{}define({__INFO},{dmin}){}dnl
define({USE_DMIN},{})
                        ;[5:141/166]dmin   ( hi_2 lo_2 hi_1 lo_1 -- hi_min lo_min )
    pop  BC             ; 1:10      dmin   BC = lo_2
    pop  AF             ; 1:10      dmin   AF = hi_2
    call MIN_32         ; 3:17      dmin}){}dnl
dnl
dnl
dnl # ( 5 3 -- 3 )
dnl # ( -5 -3 -- -5 )
define({PUSHDOT_DMIN},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_DMIN},{$1._dmin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_DMIN},{dnl
__{}define({__INFO},{$1._dmin}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_MEM_REF($1),{1},{dnl
__{}                        ;[27:94/118]$1 dmin
__{}    ld   BC, format({%-11s},$1); 4:20      $1 dmin
__{}    ld    A, C          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sub   L             ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, B          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, H          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld   BC, format({%-11s},($1+2)); 4:20      $1 dmin
__{}    ld    A, C          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, E          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, B          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, D          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    rra                 ; 1:4       $1 dmin
__{}    xor   D             ; 1:4       $1 dmin
__{}    xor   B             ; 1:4       $1 dmin
__{}    jp    p, $+8        ; 3:10      $1 dmin
__{}    ld    D, B          ; 1:4       $1 dmin
__{}    ld    E, C          ; 1:4       $1 dmin
__{}    ld   HL, format({%-11s},$1); 3:16      $1 dmin},
__IS_NUM($1),{0},{dnl
    .error {$0}($@): M4 does not know $1 parameter value!},
{dnl
__{}                        ;[23:62/82] $1 dmin
__{}    ld    A, __HEX_L($1)       ; 2:7       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sub   L             ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, __HEX_H($1)       ; 2:7       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, H          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, __HEX_E($1)       ; 2:7       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, E          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    ld    A, __HEX_D($1)       ; 2:7       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    sbc   A, D          ; 1:4       $1 dmin   $1<DEHL --> $1-DEHL<0 --> carry if $1 is min
__{}    rra                 ; 1:4       $1 dmin
__{}    xor   D             ; 1:4       $1 dmin
__{}ifelse(eval(($1)<0),{1},{dnl
__{}__{}    jp    m, $+9        ; 3:10      $1 dmin   negative constant __HEX_DEHL($1)},
__{}{dnl
__{}__{}    jp    p, $+9        ; 3:10      $1 dmin   positive constant __HEX_DEHL($1)})
__{}    ld   HL, __HEX_HL($1)     ; 3:10      $1 dmin
__{}    ld   DE, __HEX_DE($1)     ; 3:10      $1 dmin}){}dnl
}){}dnl
dnl
dnl
dnl # ( d -- -d )
define({DNEGATE},{dnl
__{}__ADD_TOKEN({__TOKEN_DNEGATE},{dnegate},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DNEGATE},{dnl
__{}define({__INFO},{dnegate}){}dnl
define({USE_DNEGATE},{})
                        ;[3:79]     dnegate   ( hi lo -- -hi -lo )
    call NEGATE_32      ; 3:17      dnegate}){}dnl
dnl
dnl
dnl # "D1+"
dnl # ( d -- d+1 )
define({D1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_D1ADD},{d1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D1ADD},{dnl
__{}define({__INFO},{d1+}){}dnl

    inc  HL             ; 1:6       D1+   lo word
    ld    A, L          ; 1:4       D1+
    or    H             ; 1:4       D1+
    jr   nz, $+3        ; 2:7/12    D1+
    inc  DE             ; 1:6       D1+   hi word}){}dnl
dnl
dnl
dnl # "2dup 2@ d1+ 2!" but with pointer
dnl # ( pd -- pd )  [pd] += 1
define({PD1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PD1ADD},{pd1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PD1ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc  (HL)           ; 1:11      __INFO   ( pd -- pd )  [pd] += 1 with align 4
    jr     z, $+14      ; 2:7/12    __INFO
    ld     C, L         ; 1:4       __INFO
    inc    L            ; 1:4       __INFO
    inc  (HL)           ; 1:11      __INFO
    jr     z, $+8       ; 2:7/12    __INFO
    inc    L            ; 1:4       __INFO
    inc  (HL)           ; 1:11      __INFO
    jr     z, $+4       ; 2:7/12    __INFO
    inc    L            ; 1:4       __INFO
    inc  (HL)           ; 1:11      __INFO
    ld     L, C         ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # "D1-"
dnl # ( d -- d-1 )
define({D1SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_D1SUB},{d1-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D1SUB},{dnl
__{}define({__INFO},{d1-}){}dnl

    ld    A, L          ; 1:4       D1-   ( d -- d-1 )
    or    H             ; 1:4       D1-
    dec  HL             ; 1:6       D1-   lo word
    jr   nz, $+3        ; 2:7/12    D1-
    dec  DE             ; 1:6       D1-   hi word}){}dnl
dnl
dnl
dnl # "2dup 2@ d1- 2!" but with pointer
dnl # ( pd -- pd )  [pd] -= 1
define({PD1SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_PD1SUB},{pd1-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PD1SUB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(1,1,{
                ;[19:34,71,100,110] __INFO   ( pd -- pd )  [pd] -= 1 with align 4
    xor    A            ; 1:4       __INFO
    or     A,(HL)       ; 1:7       __INFO
    jr    nz, $+16      ; 2:7/12    __INFO
    ld     C, L         ; 1:4       __INFO
    inc    L            ; 1:4       __INFO
    or   (HL)           ; 1:7       __INFO
    jr    nz, $+9       ; 2:7/12    __INFO
    dec  (HL)           ; 1:11      __INFO
    inc    L            ; 1:4       __INFO
    or   (HL)           ; 1:7       __INFO
    jr    nz, $+4       ; 2:7/12    __INFO
    dec  (HL)           ; 1:11      __INFO
    inc    L            ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO
    ld     L, C         ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO},
1,0,{
                ;[20:34,67,100,114] __INFO   ( pd -- pd )  [pd] -= 1 with align 4
    xor    A            ; 1:4       __INFO
    or     A,(HL)       ; 1:7       __INFO
    jr    nz, $+17      ; 2:7/12    __INFO
    inc    L            ; 1:4       __INFO
    or   (HL)           ; 1:7       __INFO
    jr    nz, $+11      ; 2:7/12    __INFO
    inc    L            ; 1:4       __INFO
    or   (HL)           ; 1:7       __INFO
    jr    nz, $+5       ; 2:7/12    __INFO
    inc    L            ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO
    dec    L            ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO
    dec    L            ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO
    dec    L            ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO},
1,0,{
                ;[21:34,75,108,118] __INFO   ( pd -- pd )  [pd] -= 1 with align 4
    dec  (HL)           ; 1:11      __INFO
    ld     A,(HL)       ; 1:7       __INFO
    inc    A            ; 1:4       __INFO
    jr    nz, $+18      ; 2:7/12    __INFO
    ld     C, L         ; 1:4       __INFO
    inc    L            ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO
    ld     A,(HL)       ; 1:7       __INFO
    inc    A            ; 1:4       __INFO
    jr     z, $+10      ; 2:7/12    __INFO
    inc    L            ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO
    ld     A,(HL)       ; 1:7       __INFO
    inc    A            ; 1:4       __INFO
    jr     z, $+4       ; 2:7/12    __INFO
    inc    L            ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO
    ld     L, C         ; 1:4       __INFO},
{
               ;[23:37,74,103,113] __INFO   ( pd -- pd )  [pd] -= 1 with align 4
    ld     B, 0x01      ; 2:7       __INFO
    ld     A,(HL)       ; 1:7       __INFO
    sub    A, B         ; 1:4       __INFO
    ld   (HL),A         ; 1:7       __INFO
    jr    nc, $+18      ; 2:7/12    __INFO
    ld     C, L         ; 1:4       __INFO
    inc    L            ; 1:4       __INFO
    ld     A,(HL)       ; 1:7       __INFO
    sub    A, B         ; 1:4       __INFO
    ld   (HL),A         ; 1:7       __INFO
    jr     z, $+10      ; 2:7/12    __INFO
    inc    L            ; 1:4       __INFO
    ld     A,(HL)       ; 1:7       __INFO
    sub    A, B         ; 1:4       __INFO
    ld   (HL),A         ; 1:7       __INFO
    jr     z, $+4       ; 2:7/12    __INFO
    inc    L            ; 1:4       __INFO
    dec  (HL)           ; 1:11      __INFO
    ld     L, C         ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # "D2+"
dnl # ( d -- d+2 )
define({D2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_D2ADD},{d2+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D2ADD},{dnl
__{}define({__INFO},{d2+}){}dnl

    ld   BC, 0x0002     ; 3:10      D2+   ( d -- d+2 )
    add  HL, BC         ; 1:11      D2+   lo word
    jr   nc, $+3        ; 2:7/12    D2+
    inc  DE             ; 1:6       D2+   hi word}){}dnl
dnl
dnl
dnl # "D2-"
dnl # ( d -- d-2 )
define({D2SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_D2SUB},{d2-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D2SUB},{dnl
__{}define({__INFO},{d2-}){}dnl

    ld    A, H          ; 1:4       D2-   ( d -- d-2 )
    dec  HL             ; 1:6       D2-   lo word
    dec  HL             ; 1:6       D2-   lo word
    sub   H             ; 1:4       D2-
    jr   nc, $+3        ; 2:7/12    D2-
    dec  DE             ; 1:6       D2-   hi word}){}dnl
dnl
dnl
dnl # "D2*"
dnl # ( d -- d*2 )
define({D2MUL},{dnl
__{}__ADD_TOKEN({__TOKEN_D2MUL},{d2*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D2MUL},{dnl
__{}define({__INFO},{d2*}){}dnl

    add  HL, HL         ; 1:11      D2*   lo word
    rl    E             ; 2:8       D2*
    rl    D             ; 2:8       D2*   hi word}){}dnl
dnl
dnl
dnl # "D2/"
dnl # ( d -- d/2 )
define({D2DIV},{dnl
__{}__ADD_TOKEN({__TOKEN_D2DIV},{d2/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D2DIV},{dnl
__{}define({__INFO},{d2/}){}dnl

    sra   D             ; 2:8       D2/   with sign
    rr    E             ; 2:8       D2/
    rr    H             ; 2:8       D2/
    rr    L             ; 2:8       D2/}){}dnl
dnl
dnl
dnl # "D256*"
dnl # ( d -- d*256 )
define({D256MUL},{dnl
__{}__ADD_TOKEN({__TOKEN_D256MUL},{d256*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D256MUL},{dnl
__{}define({__INFO},{d256*}){}dnl

    ld    D, E          ; 1:4       D256*
    ld    E, H          ; 1:4       D256*
    ld    H, L          ; 1:4       D256*
    ld    L, 0x00       ; 2:7       D256*}){}dnl
dnl
dnl
dnl # "D256/"
dnl # ( d -- d/256 )
define({D256DIV},{dnl
__{}__ADD_TOKEN({__TOKEN_D256DIV},{d256/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_D256DIV},{dnl
__{}define({__INFO},{d256/}){}dnl

    ld    L, H          ; 1:4       D256/
    ld    H, E          ; 1:4       D256/
    ld    E, D          ; 1:4       D256/
    rl    D             ; 2:8       D256/   with sign
    sbc   A, A          ; 1:4       D256/
    ld    D, A          ; 1:4       D256/}){}dnl
dnl
dnl
dnl
