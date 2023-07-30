dnl ## recursive sdo si sloop
dnl
dnl
dnl # ---------  sdo ... sloop  -----------
dnl # 5 0 sdo . sloop --> 0 1 2 3 4
dnl # ( stop index -- stop index )
define({__ASM_TOKEN_SDO},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(s)}){}dnl
__{}ifelse(dnl
__{}__HEX_HL(__GET_LOOP_END($1)),0x0000,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},
__{}__HEX_HL(__GET_LOOP_END($1)),0x0001,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},
__{}__HEX_HL(__GET_LOOP_END($1)),0xFFFF,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},
__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{:},{
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},
__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},
__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__ASM_TOKEN_PUSH_SWAP(__GET_LOOP_END($1))
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},
__{}{dnl
__{}__{}__{}__ASM_TOKEN_PUSH2(__GET_LOOP_END($1),__GET_LOOP_BEGIN($1))
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )}){}dnl
})}){}dnl
dnl
dnl
dnl # ---------  ?sdo ... sloop  -----------
dnl # 5 0 sdo . sloop --> 0 1 2 3 4
dnl # ( stop index -- stop index )
define({__ASM_TOKEN_QSDO},{dnl
ifelse($#,0,{
__{}  .error {$0}($@): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__COMPILE_INFO},__COMPILE_INFO{(s)}){}dnl
__{}ifelse(__IS_NUM(__GET_LOOP_END($1)):__IS_NUM(__GET_LOOP_BEGIN($1)),{1:1},{
__{}__{}ifelse(eval(__GET_LOOP_END($1)),eval(__GET_LOOP_BEGIN($1)),{
__{}__{}    jp   exit{}$1        ; 3:10      __COMPILE_INFO   ( stop index -- )
__{}__{}do{}$1:                  ;           __COMPILE_INFO},
__{}__{}{__ASM_TOKEN_SDO($1)})},

__{}__HEX_HL(__GET_LOOP_END($1)),0x0000,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}__{}    ld    A, H          ; 1:4       __COMPILE_INFO
__{}__{}    or    L             ; 1:4       __COMPILE_INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __COMPILE_INFO
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},

__{}__HEX_HL(__GET_LOOP_END($1)),0x0001,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}__{}    ld    A, L          ; 1:4       __COMPILE_INFO
__{}__{}    dec   A             ; 1:4       __COMPILE_INFO
__{}__{}    or    H             ; 1:4       __COMPILE_INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __COMPILE_INFO
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},

__{}__HEX_HL(__GET_LOOP_END($1)),0xFFFF,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}__{}    ld    A, H          ; 1:4       __COMPILE_INFO
__{}__{}    and   L             ; 1:4       __COMPILE_INFO
__{}__{}    inc   A             ; 1:4       __COMPILE_INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __COMPILE_INFO
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},

__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{:},{
__{}__{}    or    A             ; 1:4       __COMPILE_INFO
__{}__{}    sbc  HL, DE         ; 2:15      __COMPILE_INFO
__{}__{}    add  HL, DE         ; 1:11      __COMPILE_INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __COMPILE_INFO
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},

__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{:0},{dnl
__{}__{}__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))
__{}__{}    ld    A, E          ; 1:4       __COMPILE_INFO
__{}__{}    or    D             ; 1:4       __COMPILE_INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __COMPILE_INFO
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop 0 -- stop 0 )},

__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))
__{}__{}    or    A             ; 1:4       __COMPILE_INFO
__{}__{}    sbc  HL, DE         ; 2:15      __COMPILE_INFO
__{}__{}    add  HL, DE         ; 1:11      __COMPILE_INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __COMPILE_INFO
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},

__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__ASM_TOKEN_PUSH_SWAP(__GET_LOOP_END($1))
__{}__{}    or    A             ; 1:4       __COMPILE_INFO
__{}__{}    sbc  HL, DE         ; 2:15      __COMPILE_INFO
__{}__{}    add  HL, DE         ; 1:11      __COMPILE_INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __COMPILE_INFO
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},

__{}__{}__GET_LOOP_END($1),__GET_LOOP_BEGIN($1),{
__{}__{}    jp   exit{}$1        ; 3:10      __COMPILE_INFO   ( stop index -- )
__{}__{}do{}$1:                  ;           __COMPILE_INFO},

__{}{dnl
__{}__{}__ASM_TOKEN_PUSH2(__GET_LOOP_END($1),__GET_LOOP_BEGIN($1))
__{}__{}    or    A             ; 1:4       __COMPILE_INFO
__{}__{}    sbc  HL, DE         ; 2:15      __COMPILE_INFO
__{}__{}    add  HL, DE         ; 1:11      __COMPILE_INFO
__{}__{}    jp    z, leave{}$1   ; 3:10      __COMPILE_INFO
__{}__{}do{}$1:                  ;           __COMPILE_INFO   ( -- stop index )}){}dnl
})}){}dnl
dnl
dnl
dnl # --------------------------------------------------------
dnl
dnl
dnl # loop
dnl # ( stop index -- stop ++index )
define({__ASM_TOKEN_SLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(s)}){}dnl
__{}ifelse($#,{0},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0x0000,
__{}__{}{
__{}__{}__{}dnl # stop if "index+1 =  0"
__{}__{}__{}dnl # stop if "index   = -1"
__{}__{}__{}    inc  HL             ; 1:6       __INFO   index++
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    or    H             ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0x0001,
__{}__{}{
__{}__{}__{}dnl # stop if "index+1 =  1"
__{}__{}__{}dnl # stop if "index   =  0"
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    or    H             ; 1:4       __INFO
__{}__{}__{}    inc  HL             ; 1:6       __INFO   index++
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0xFFFF,
__{}__{}{
__{}__{}__{}dnl # stop if "index+1 = -1"
__{}__{}__{}dnl # stop if "index   = -2"
__{}__{}__{}    inc  HL             ; 1:6       __INFO   index++
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    and   H             ; 1:4       __INFO
__{}__{}__{}    inc   A             ; 1:4       __INFO   0xFF?
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}__{}{
__{}__{}__{}    inc  HL             ; 1:6       __INFO   index++
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    xor   E             ; 1:4       __INFO   lo(index - stop)
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    xor   D             ; 1:4       __INFO   hi(index - stop)
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO})
__{}__{}leave{}$1:               ;           __INFO{}dnl
__{}__{}__ASM_TOKEN_UNLOOP($1)
__{}__{}exit{}$1:                ;           __INFO{(s)}{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # -1 +loop
dnl # ( stop index -- stop index-- )
define({__ASM_TOKEN_SUB1_ADDSLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(s)}){}dnl
__{}ifelse($#,{0},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),__GET_LOOP_END($1),1,__IS_NUM(__GET_LOOP_BEGIN($1)):__HEX_HL(__GET_LOOP_BEGIN($1)),1:__HEX_HL(__GET_LOOP_END($1)),1,0),1,{
__{}__{}__{}                        ;           __INFO   variant -1 and no repeat},
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0x0000,{dnl
__{}__{}__{}dnl # stop if "index   =  0" --> no store end to DE
__{}__{}__{}dnl # stop if "index-1 = -1"
__{}__{}__{}ifelse(__HEX_H(__GET_LOOP_BEGIN($1)):__HEX_L(__GET_LOOP_BEGIN($1)>__GET_LOOP_END($1)),__HEX_H(__GET_LOOP_END($1)):0x01,{dnl
__{}__{}__{}__{}ifelse(__HEX_L(__GET_LOOP_BEGIN($1)<=0x80),0x01,{
__{}__{}__{}__{}__{}    dec   L             ; 1:4       __INFO   index--
__{}__{}__{}__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__{}__{}__{}{
__{}__{}__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}__{}__{}    dec   L             ; 1:4       __INFO   index--
__{}__{}__{}__{}__{}    or    A             ; 1:4       __INFO
__{}__{}__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO})},
__{}__{}__{}{
__{}__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}__{}    or    H             ; 1:4       __INFO
__{}__{}__{}__{}    dec  HL             ; 1:6       __INFO   index--
__{}__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO})},
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0x0001,{dnl
__{}__{}__{}dnl # stop if "index   = 1" --> no store end to DE
__{}__{}__{}dnl # stop if "index-1 = 0"
__{}__{}__{}ifelse(__HEX_H(__GET_LOOP_BEGIN($1)):__HEX_L(__GET_LOOP_BEGIN($1)>__GET_LOOP_END($1)),__HEX_H(__GET_LOOP_END($1)):0x01,{
__{}__{}__{}__{}    dec   L             ; 1:4       __INFO   index--},
__{}__{}__{}{
__{}__{}__{}__{}    dec  HL             ; 1:6       __INFO   index--
__{}__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}__{}    or    H             ; 1:4       __INFO})
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0xFFFF,{
__{}__{}__{}dnl # stop if "index   = -1" --> no store end to DE
__{}__{}__{}dnl # stop if "index-1 = -2"
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    and   H             ; 1:4       __INFO
__{}__{}__{}    dec  HL             ; 1:6       __INFO   index--
__{}__{}__{}    inc   A             ; 1:4       __INFO   0xFF?
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}__{}__HEX_H(__GET_LOOP_BEGIN($1)):__HEX_L(__GET_LOOP_BEGIN($1)>__GET_LOOP_END($1)),__HEX_H(__GET_LOOP_END($1)):0x01,{dnl
__{}__{}__{}ifelse(__HEX_L(__GET_LOOP_END($1)):__HEX_L(0x80>=(0xFF & (__GET_LOOP_BEGIN($1)))),0x00:0x01,{
__{}__{}__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__{}__{}__HEX_L(__GET_LOOP_END($1)),0x01,{
__{}__{}__{}__{}    dec   L             ; 1:4       __INFO   index--
__{}__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}__{}__{}{
__{}__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}__{}    dec   L             ; 1:4       __INFO   index--
__{}__{}__{}__{}    xor   E             ; 1:4       __INFO
__{}__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO})},
__{}__{}{
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    xor   E             ; 1:4       __INFO   lo(index - stop)
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    dec  HL             ; 1:6       __INFO   index--
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    xor   D             ; 1:4       __INFO   hi(index - stop)
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO})
__{}__{}leave{}$1:               ;           __INFO{}dnl
__{}__{}__ASM_TOKEN_UNLOOP($1)
__{}__{}exit{}$1:                ;           __INFO{(s)}{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # 2 +loop
dnl # ( stop index -- stop index+step )
define({__ASM_TOKEN_2_ADDSLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(s)){}dnl
__{}ifelse($#,{0},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__HEX_HL(__GET_LOOP_END($1)):_TYP_SINGLE,0xFFFF:small,
__{}__{}{__ASM_TOKEN_NUM_ADDSLOOP($1)},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0x0000,
__{}__{}{
__{}__{}__{}dnl #                     7:30
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}__{}    inc  HL             ; 1:6       __INFO   HL = index+2-stop
__{}__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0x0001,
__{}__{}{
__{}__{}__{}dnl # stop if "index+2 = 1 or 2"
__{}__{}__{}dnl # stop if "index+1 = 0 or 1"
__{}__{}__{}dnl # stop if "index   =-1 or 0"
__{}__{}__{}dnl #                     9:37
__{}__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    and 0xFE            ; 2:7       __INFO   set_bit(0) = 0
__{}__{}__{}    or    H             ; 1:4       __INFO   0 or 1 --> zero flag
__{}__{}__{}    inc  HL             ; 1:6       __INFO   HL = index+2-stop
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0xFFFF,
__{}__{}{
__{}__{}__{}dnl # stop if "index+2 =-1 or  0"
__{}__{}__{}dnl # stop if "index+1 =-2 or -1"
__{}__{}__{}dnl # stop if "index   =-3 or -2"
__{}__{}__{}dnl #                    10:41
__{}__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    or  0x01            ; 2:7       __INFO   set_bit(0) = 1
__{}__{}__{}    and   H             ; 1:4       __INFO   -2 or -1 --> zero flag
__{}__{}__{}    inc  HL             ; 1:6       __INFO   HL = index+2-stop
__{}__{}__{}    inc   A             ; 1:4       __INFO   0xFF?
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO},
__{}__{}_TYP_SINGLE,{small},{
__{}__{}__{}dnl #                    11:60
__{}__{}__{}    or    A             ; 1:4       __INFO   small version
__{}__{}__{}    sbc  HL, DE         ; 2:15      __INFO   HL = index-stop
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}__{}    inc  HL             ; 1:6       __INFO   HL = index+2-stop
__{}__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index+step, sign flag unaffected
__{}__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__{}{
__{}__{}__{}dnl #                    14:38/56
__{}__{}__{}    inc  HL             ; 1:6       __INFO   standart version
__{}__{}__{}    inc  HL             ; 1:6       __INFO   HL = index+2
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    sub   E             ; 1:4       __INFO
__{}__{}__{}    rra                 ; 1:4       __INFO
__{}__{}__{}    add   A, A          ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    sbc   A, D          ; 1:4       __INFO
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO})
__{}__{}leave{}$1:               ;           __INFO{}dnl
__{}__{}__ASM_TOKEN_UNLOOP($1)
__{}__{}exit{}$1:                ;           __INFO{(s)}{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # +loop
dnl # ( stop index step -- stop index+step )
define({__ASM_TOKEN_ADDSLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(s)){}dnl
__{}ifelse($#,{0},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0x0000,
__{}__{}{
__{}__{}__{}    ld    A, H          ; 1:4       __INFO   ( index step -- index+step )  stop=0
__{}__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index+step
__{}__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0x0001,
__{}__{}{
__{}__{}__{}    dec  DE             ; 1:6       __INFO   index-stop
__{}__{}__{}    ld    A, H          ; 1:4       __INFO   ( index step -- index+step )  stop=1
__{}__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}__{}    inc  HL             ; 1:6       __INFO   index+step
__{}__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__{}__HEX_HL(__GET_LOOP_END($1)),0xFFFF,
__{}__{}{
__{}__{}__{}    inc  DE             ; 1:6       __INFO   index-stop
__{}__{}__{}    ld    A, H          ; 1:4       __INFO   ( index step -- index+step )  stop=-1
__{}__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}__{}    dec  HL             ; 1:6       __INFO   index+step
__{}__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__{}_TYP_SINGLE,{fast},{
__{}__{}__{}dnl #                    12:61
__{}__{}__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}__{}__{}    add  HL, DE         ; 1:11      __INFO   index+step
__{}__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}__{}    sub   C             ; 1:4       __INFO
__{}__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}__{}    sbc   A, B          ; 1:4       __INFO
__{}__{}__{}    ld    E, A          ; 1:4       __INFO   E = hi index-stop
__{}__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}__{}    sub   C             ; 1:4       __INFO
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    sbc   A, B          ; 1:4       __INFO
__{}__{}__{}    xor   E             ; 1:4       __INFO
__{}__{}__{}    ld    D, B          ; 1:4       __INFO
__{}__{}__{}    ld    E, C          ; 1:4       __INFO
__{}__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__{}{
__{}__{}__{}dnl #                     9:63
__{}__{}__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}__{}    or    A             ; 1:4       __INFO
__{}__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step, sign flag unaffected
__{}__{}__{}    ld    D, B          ; 1:4       __INFO
__{}__{}__{}    ld    E, C          ; 1:4       __INFO
__{}__{}__{}    jp    p, do{}$1      ; 3:10      __INFO})
__{}__{}leave{}$1:               ;           __INFO{}dnl
__{}__{}__ASM_TOKEN_UNLOOP($1)
__{}__{}exit{}$1:                ;           __INFO{(s)}{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # step +loop
dnl # ( stop index -- stop index+step )
define({__ASM_TOKEN_NO_NUM_ADDSLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(s)}){}dnl
__{}ifelse($#,{0},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{ifelse(dnl
__{}__HEX_HL(__GET_LOOP_END($1)),0x0000,
__{}{
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step, stop = 0
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__HEX_HL(__GET_LOOP_END($1)),0x0001,
__{}{
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step, stop = 1
__{}__{}    dec  HL             ; 1:6       __INFO   HL-= stop = index-stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+= step = index-stop+step
__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}    inc  HL             ; 1:6       __INFO   HL+= stop = index+step
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}__HEX_HL(__GET_LOOP_END($1)),0xFFFF,
__{}{
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step, stop = -1
__{}__{}    inc  HL             ; 1:6       __INFO   HL-= stop = index-stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+= step = index-stop+step
__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}    dec  HL             ; 1:6       __INFO   HL+= stop = index+step
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO},
__{}{
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, DE         ; 2:15      __INFO   HL = index-stop
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop+step
__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index+step, sign flag unaffected
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO})
__{}leave{}$1:               ;           __INFO{}dnl
__{}__ASM_TOKEN_UNLOOP($1)
__{}exit{}$1:                ;           __INFO{(s)}{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # step +loop
dnl # ( stop index -- stop index+step )
define({__ASM_TOKEN_NUM_ADDSLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(s)}){}dnl
__{}ifelse($#,{0},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{ifelse(dnl
__{}__HEX_HL(__GET_LOOP_END($1)),0x0000,
__{}{
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step, stop = 0
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}__{}__{}ifelse(eval(__GET_LOOP_STEP($1) & 0x8000),0,{dnl
__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO},
__{}__{}__{}{dnl
__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO})},
__{}__HEX_HL(__GET_LOOP_END($1)),0x0001,
__{}{
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step, stop = 1
__{}__{}    dec  HL             ; 1:6       __INFO   HL-= stop = index-stop
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+= step = index-stop+step
__{}__{}    inc  HL             ; 1:6       __INFO   HL+= stop = index+step
__{}__{}__{}ifelse(eval(__GET_LOOP_STEP($1) & 0x8000),0,{dnl
__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO},
__{}__{}__{}{dnl
__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO})},
__{}__HEX_HL(__GET_LOOP_END($1)),0xFFFF,
__{}{
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step, stop = -1
__{}__{}    inc  HL             ; 1:6       __INFO   HL-= stop = index-stop
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+= step = index-stop+step
__{}__{}    dec  HL             ; 1:6       __INFO   HL+= stop = index+step
__{}__{}__{}ifelse(eval(__GET_LOOP_STEP($1) & 0x8000),0,{dnl
__{}__{}__{}    jp   nc, do{}$1      ; 3:10      __INFO},
__{}__{}__{}{dnl
__{}__{}__{}    jp    c, do{}$1      ; 3:10      __INFO})},
__{}{
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, DE         ; 2:15      __INFO   HL = index-stop
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index-stop+step
__{}__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index+step, sign flag unaffected
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO})
__{}leave{}$1:               ;           __INFO{}dnl
__{}__ASM_TOKEN_UNLOOP($1)
__{}exit{}$1:                ;           __INFO{(s)}{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # step +loop
dnl # ( stop index -- stop index+step )
define({__ASM_TOKEN_PUSH_ADDSLOOP},{dnl
ifelse($#,{0},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}ifelse(__IS_NUM(__GET_LOOP_STEP($1)),{0},{__ASM_TOKEN_NO_NUM_ADDSLOOP($1)},{dnl
__{}__{}ifelse(eval(__GET_LOOP_STEP($1)),{1},{__ASM_TOKEN_SLOOP($1)},
__{}__{}eval(__GET_LOOP_STEP($1)),{-1},{__ASM_TOKEN_SUB1_ADDSLOOP($1)},
__{}__{}eval(__GET_LOOP_STEP($1)),{2},{__ASM_TOKEN_2_ADDSLOOP($1)},
__{}__{}{__ASM_TOKEN_NUM_ADDSLOOP($1)})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl
