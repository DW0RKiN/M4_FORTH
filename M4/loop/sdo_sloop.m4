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
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)),0,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},
__{}__SAVE_EVAL(__GET_LOOP_END($1)),1,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},
__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{:},{
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},
__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},
__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__ASM_TOKEN_PUSH_SWAP(__GET_LOOP_END($1))
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},
__{}{dnl
__{}__{}__ASM_TOKEN_PUSH2(__GET_LOOP_END($1),__GET_LOOP_BEGIN($1))
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )}){}dnl
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
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)),0,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    L             ; 1:4       __INFO
__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},
__{}__SAVE_EVAL(__GET_LOOP_END($1)),1,{dnl
__{}__{}ifelse(__GET_LOOP_BEGIN($1),{},,{__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))})
__{}    ld    A, H          ; 1:4       __INFO
__{}    dec   A             ; 1:4       __INFO
__{}    or    L             ; 1:4       __INFO
__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- index )  stop = __GET_LOOP_END($1)},
__{}__GET_LOOP_END($1):__GET_LOOP_BEGIN($1),{:},{
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    add  HL, DE         ; 1:11      __INFO
__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},
__{}__GET_LOOP_END($1),{},{dnl
__{}__{}__ASM_TOKEN_PUSH(__GET_LOOP_BEGIN($1))
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    add  HL, DE         ; 1:11      __INFO
__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},
__{}__GET_LOOP_BEGIN($1),{},{dnl
__{}__{}__ASM_TOKEN_PUSH_SWAP(__GET_LOOP_END($1))
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    add  HL, DE         ; 1:11      __INFO
__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )},
__{}{dnl
__{}__{}__ASM_TOKEN_PUSH2(__GET_LOOP_END($1),__GET_LOOP_BEGIN($1))
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    add  HL, DE         ; 1:11      __INFO
__{}    jp    z, leave{}$1   ; 3:10      __INFO
__{}do{}$1:                  ;           __COMPILE_INFO   ( stop index -- stop index )}){}dnl
})}){}dnl
dnl
dnl
dnl # --------------------------------------------------------
dnl
dnl
dnl # loop
dnl # ( stop index -- stop ++index )
define({__ASM_TOKEN_SLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(s)})
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)),{0},
{dnl
    inc  HL             ; 1:6       __INFO   index++
    ld    A, L          ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    jp   nz, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(__GET_LOOP_END($1)),{1},
{dnl
    ld    A, L          ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO   index++
    jp   nz, do{}$1      ; 3:10      __INFO},
{dnl
    inc  HL             ; 1:6       __INFO   index++
    ld    A, L          ; 1:4       __INFO
    xor   E             ; 1:4       __INFO   lo(index - stop)
    jp   nz, do{}$1      ; 3:10      __INFO
    ld    A, H          ; 1:4       __INFO
    xor   D             ; 1:4       __INFO   hi(index - stop)
    jp   nz, do{}$1      ; 3:10      __INFO})
leave{}$1:               ;           __INFO{}dnl
__{}__ASM_TOKEN_UNLOOP($1)}){}dnl
dnl
dnl
dnl # -1 +loop
dnl # ( stop index -- stop index-- )
define({__ASM_TOKEN_SUB1_ADDSLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(s)})
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)),{0},
{dnl
    ld    A, L          ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO   index--
    jp   nz, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(__GET_LOOP_END($1)),{1},
{dnl
    dec  HL             ; 1:6       __INFO   index--
    ld    A, L          ; 1:4       __INFO
    or    H             ; 1:4       __INFO
    jp   nz, do{}$1      ; 3:10      __INFO},
{dnl
    ld    A, L          ; 1:4       __INFO
    xor   E             ; 1:4       __INFO   lo(index - stop)
    ld    A, H          ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO   index--
    jp   nz, do{}$1      ; 3:10      __INFO
    xor   D             ; 1:4       __INFO   hi(index - stop)
    jp   nz, do{}$1      ; 3:10      __INFO})
leave{}$1:               ;           __INFO{}dnl
__{}__ASM_TOKEN_UNLOOP($1)}){}dnl
dnl
dnl
dnl # 2 +loop
dnl # ( stop index -- stop index+step )
define({__ASM_TOKEN_2_ADDSLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(s)){}dnl
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)),{0},
{
    ld    A, H          ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    inc  HL             ; 1:6       __INFO   HL = index+2-stop
    xor   H             ; 1:4       __INFO   sign flag!
    jp    p, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(__GET_LOOP_END($1)),{1},
{
    inc  HL             ; 1:6       __INFO   
    ld    A, L          ; 1:4       __INFO
    and 0xFE            ; 2:7       __INFO
    or    H             ; 1:4       __INFO   0 or 1 --> zero flag
    inc  HL             ; 1:6       __INFO   HL = index+2-stop
    jp   nz, do{}$1      ; 3:10      __INFO},
{ifelse(_TYP_SINGLE,{small},{
__{}    or    A             ; 1:4       __INFO   small version
__{}    sbc  HL, DE         ; 2:15      __INFO   HL = index-stop
__{}    ld    A, H          ; 1:4       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    inc  HL             ; 1:6       __INFO   HL = index+2-stop
__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}    add  HL, DE         ; 1:11      __INFO   HL = index+step, sign flag unaffected
__{}    jp    p, do{}$1      ; 3:10      __INFO},
dnl #                          14:38/56
{
__{}    inc  HL             ; 1:6       __INFO   standart version
__{}    inc  HL             ; 1:6       __INFO   HL = index+2
__{}    ld    A, L          ; 1:4       __INFO
__{}    sub   E             ; 1:4       __INFO
__{}    rra                 ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO
__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    sbc   A, D          ; 1:4       __INFO
__{}    jp   nz, do{}$1      ; 3:10      __INFO})})
dnl #                          11:60
leave{}$1:               ;           __INFO{}dnl
__{}__ASM_TOKEN_UNLOOP($1)}){}dnl
dnl
dnl
dnl # +loop
dnl # ( stop index step -- stop index+step )
define({__ASM_TOKEN_ADDSLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(s)){}dnl
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)),{0},
{
    ld    A, H          ; 1:4       __INFO   ( index step -- index+step )  stop=0
    add  HL, DE         ; 1:11      __INFO   HL = index+step
    xor   H             ; 1:4       __INFO   sign flag!
    pop  DE             ; 1:10      __INFO
    jp    p, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(__GET_LOOP_END($1)),{1},
{
    dec  DE             ; 1:6       __INFO   index-stop
    ld    A, H          ; 1:4       __INFO   ( index step -- index+step )  stop=1
    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
    xor   H             ; 1:4       __INFO   sign flag!
    inc  HL             ; 1:6       __INFO   index+step
    pop  DE             ; 1:10      __INFO
    jp    p, do{}$1      ; 3:10      __INFO},
{ifelse({_TYP_SINGLE},{fast},{
dnl #                          12:61
__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}    add  HL, DE         ; 1:11      __INFO   index+step
__{}    ld    A, E          ; 1:4       __INFO
__{}    sub   C             ; 1:4       __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    sbc   A, B          ; 1:4       __INFO
__{}    ld    E, A          ; 1:4       __INFO   E = hi index-stop
__{}    ld    A, L          ; 1:4       __INFO
__{}    sub   C             ; 1:4       __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    sbc   A, B          ; 1:4       __INFO
__{}    xor   E             ; 1:4       __INFO},
{
dnl #                           9:63
__{}    pop  BC             ; 1:10      __INFO   BC = stop
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}    ld    A, H          ; 1:4       __INFO
__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}    xor   H             ; 1:4       __INFO   sign flag!
__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step, sign flag unaffected})
    ld    D, B          ; 1:4       __INFO
    ld    E, C          ; 1:4       __INFO
    jp    p, do{}$1      ; 3:10      __INFO})
leave{}$1:               ;           __INFO{}dnl
__{}__ASM_TOKEN_UNLOOP($1)}){}dnl
dnl
dnl
dnl
dnl # step +loop
dnl # ( stop index -- stop index+step )
define({__ASM_TOKEN_NO_NUM_ADDSLOOP},{dnl
ifelse($#,{0},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{define({__INFO},__COMPILE_INFO{(s)})
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)),{0},
{dnl
    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
    ld    A, H          ; 1:4       __INFO
    add  HL, BC         ; 1:11      __INFO   HL = index+step
    xor   H             ; 1:4       __INFO   sign flag!
    jp    p, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(__GET_LOOP_END($1)),{1},
{dnl
    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
    dec  HL             ; 1:6       __INFO   HL-= stop = index-stop
    ld    A, H          ; 1:4       __INFO
    add  HL, BC         ; 1:11      __INFO   HL+= step = index-stop+step
    xor   H             ; 1:4       __INFO   sign flag!
    inc  HL             ; 1:6       __INFO   HL+= stop = index+step
    jp    p, do{}$1      ; 3:10      __INFO},
{dnl
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO   HL = index-stop
    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
    ld    A, H          ; 1:4       __INFO
    add  HL, BC         ; 1:11      __INFO   HL = index-stop+step
    xor   H             ; 1:4       __INFO   sign flag!
    add  HL, DE         ; 1:11      __INFO   HL = index+step, sign flag unaffected
    jp    p, do{}$1      ; 3:10      __INFO})
leave{}$1:               ;           __INFO{}dnl
__{}__ASM_TOKEN_UNLOOP($1)}){}dnl
}){}dnl
dnl
dnl
dnl # step +loop
dnl # ( stop index -- stop index+step )
define({__ASM_TOKEN_NUM_ADDSLOOP},{dnl
ifelse($#,{0},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{define({__INFO},__COMPILE_INFO{(s)})
__{}ifelse(__SAVE_EVAL(__GET_LOOP_END($1)),{0},
{dnl
    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}ifelse(eval(__GET_LOOP_STEP($1) & 0x8000),0,{dnl
__{}    jp   nc, do{}$1      ; 3:10      __INFO},
__{}{dnl
__{}    jp    c, do{}$1      ; 3:10      __INFO})},
__SAVE_EVAL(__GET_LOOP_END($1)),{1},
{dnl
    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
    dec  HL             ; 1:6       __INFO   HL-= stop = index-stop
    add  HL, BC         ; 1:11      __INFO   HL+= step = index-stop+step
    inc  HL             ; 1:6       __INFO   HL+= stop = index+step
__{}ifelse(eval(__GET_LOOP_STEP($1) & 0x8000),0,{dnl
__{}    jp   nc, do{}$1      ; 3:10      __INFO},
__{}{dnl
__{}    jp    c, do{}$1      ; 3:10      __INFO})},
{dnl
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO   HL = index-stop
    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
    ld    A, H          ; 1:4       __INFO
    add  HL, BC         ; 1:11      __INFO   HL = index-stop+step
    xor   H             ; 1:4       __INFO   sign flag!
    add  HL, DE         ; 1:11      __INFO   HL = index+step, sign flag unaffected
    jp    p, do{}$1      ; 3:10      __INFO})
leave{}$1:               ;           __INFO{}dnl
__{}__ASM_TOKEN_UNLOOP($1)}){}dnl
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
