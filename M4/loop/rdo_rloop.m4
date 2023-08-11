dnl ## recursive rdo rloop
dnl
dnl # DO(R)         LOOP
dnl # DO(R)         ADDLOOP
dnl # DO(R)         PUSH_ADDLOOP(step)
dnl # QUESTIONDO(R) LOOP
dnl # QUESTIONDO(R) ADDLOOP
dnl # QUESTIONDO(R) PUSH_ADDLOOP(step)
dnl
dnl
dnl # do(r)
define({__ASM_TOKEN_RDO},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r)){}dnl
__{}ifelse(__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
                       ;[15:116]    __INFO   ( stop index -- ) ( R: -- stop index )
    ex  (SP),HL         ; 1:19      __INFO
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   DE = stop
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO   DE = index
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
do{}$1:                  ;           __INFO},
__{}__GET_LOOP_END($1):__IS_MEM_REF(__GET_LOOP_BEGIN($1)),{:1},{
                       ;[17:109]    __INFO   ( stop __GET_LOOP_BEGIN($1) -- ) ( R: -- stop __GET_LOOP_BEGIN($1) )
    ex  (SP),HL         ; 1:19      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   DE = stop
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ld   BC,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO
    ld  (HL),B          ; 1:7       __INFO   hi index
    dec  L              ; 1:4       __INFO
    ld  (HL),C          ; 1:7       __INFO   hi index
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
do{}$1:                  ;           __INFO},
__{}__GET_LOOP_END($1):__SAVE_EVAL(__GET_LOOP_BEGIN($1)),{:0},{
                       ;[14:93]     __INFO   ( stop __GET_LOOP_BEGIN($1) -- ) ( R: -- stop __GET_LOOP_BEGIN($1) )
    ex  (SP),HL         ; 1:19      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   DE = stop
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    xor   A             ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO   hi index
    dec  L              ; 1:4       __INFO
    ld  (HL),A          ; 1:7       __INFO   hi index
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
do{}$1:                  ;           __INFO},
__{}__GET_LOOP_END($1),{},{
                       ;[15:95]     __INFO   ( stop __GET_LOOP_BEGIN($1) -- ) ( R: -- stop __GET_LOOP_BEGIN($1) )
    ex  (SP),HL         ; 1:19      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   DE = stop
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),format({%-11s},high __GET_LOOP_BEGIN($1)); 2:10      __INFO   hi index
    dec  L              ; 1:4       __INFO
    ld  (HL),format({%-11s},low __GET_LOOP_BEGIN($1)); 2:10      __INFO   lo index
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
do{}$1:                  ;           __INFO},
__{}__GET_LOOP_BEGIN($1),{},{
                        ;[9:65]     __INFO   ( __GET_LOOP_END($1) index -- ) ( R: -- index )
    ex  (SP), HL        ; 1:19      __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   DE = index
    dec  HL             ; 1:6       __INFO
do{}$1:                  ;           __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO},
{
                        ;[9:42]     __INFO   ( __GET_LOOP_BEGIN($1) __GET_LOOP_END($1) -- ) ( R: -- index )
    exx                 ; 1:4       __INFO
    ld   DE, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index
    dec  HL             ; 1:6       __INFO
do{}$1:                  ;           __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # ?do(r)
define({__ASM_TOKEN_QRDO},{dnl
__{}define({__INFO},__COMPILE_INFO{(r)}){}dnl
__{}ifelse(dnl
__{}__GET_LOOP_BEGIN($1):__GET_LOOP_END($1),{:},{
__{}__{}                       ;[24:158]    __INFO   ( stop index -- ) R: ( -- stop index )
__{}__{}    push HL             ; 1:11      __INFO   index
__{}__{}    push DE             ; 1:11      __INFO   stop
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, DE         ; 2:15      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   stop
__{}__{}    pop  BC             ; 1:10      __INFO   index
__{}__{}    jr    z, $+10       ; 2:7/12    __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),D          ; 1:7       __INFO   hi stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),E          ; 1:7       __INFO   lo stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),B          ; 1:7       __INFO   hi index
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO   lo index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO
__{}__{}do{}$1:                  ;           __INFO},
__{}__GET_LOOP_END($1):__IS_MEM_REF(__GET_LOOP_BEGIN($1)),{:1},{
__{}__{}                       ;[28:172]    __INFO   ( stop __GET_LOOP_BEGIN($1) -- ) ( R: -- stop __GET_LOOP_BEGIN($1) )
__{}__{}    ld   BC,format({%-12s},__GET_LOOP_BEGIN($1)); 4:20      __INFO   index
__{}__{}    push BC             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO   stop
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   stop
__{}__{}    pop  BC             ; 1:10      __INFO   index
__{}__{}    jr    z, $+10       ; 2:7/12    __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),D          ; 1:7       __INFO   hi stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),E          ; 1:7       __INFO   lo stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),B          ; 1:7       __INFO   hi index
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO   lo index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO
__{}__{}do{}$1:                  ;           __INFO},
__{}__GET_LOOP_END($1),{},{
__{}__{}__MAKE_BEST_CODE_R16_CP(__INFO,__INFO{   }( stop __GET_LOOP_BEGIN($1) -- ) ( R: -- stop __GET_LOOP_BEGIN($1) ),{HL},__GET_LOOP_BEGIN($1),21,118,2,-7){}dnl
__{}__{}_TMP_BEST_CODE
__{}__{}    jr    z, $+16       ; 2:7/12    __INFO
__{}__{}    push HL             ; 1:11      __INFO   stop
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),D          ; 1:7       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),E          ; 1:7       __INFO   stop
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),format({%-11s},high __GET_LOOP_BEGIN($1)); 2:10      __INFO   hi index
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),format({%-11s},low __GET_LOOP_BEGIN($1)); 2:10      __INFO   lo index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp    z, exit{}$1    ; 3:10      __INFO
__{}__{}do{}$1:                  ;           __INFO},
__{}__GET_LOOP_BEGIN($1),{},{
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},__INFO{   }( __GET_LOOP_END($1) index -- ) ( R: -- index )){}dnl
__{}__{}__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),14,83,0,0){}dnl
__{}__{}_TMP_BEST_CODE
__{}__{}    ex  (SP),HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  DE             ; 1:10      __INFO   DE = index
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    jp   nz, exit{}$1    ; 3:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1:                  ;           __INFO
__{}__{}    ld  (HL),D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  (HL),E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO},
__{}__{}__IS_NUM(__GET_LOOP_BEGIN($1)):__HEX_HL(__GET_LOOP_BEGIN($1)),1:__HEX_HL(__GET_LOOP_END($1)),{
__{}__{}                        ;[5:18]     __INFO   ( -- ) ( R: -- index )
__{}__{}    jp   exit{}$1        ; 3:10      __INFO
__{}__{}do{}$1:                  ;           __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO},
__{}{
__{}__{}                       ;ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,[10:52],[ 9:42])     __INFO   ( __GET_LOOP_BEGIN($1) __GET_LOOP_END($1) -- ) ( R: -- index )
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld   DE, format({%-11s},__GET_LOOP_BEGIN($1)); ifelse(__IS_MEM_REF(__GET_LOOP_BEGIN($1)),1,4:20,3:10)      __INFO   DE = index
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}do{}$1:                  ;           __INFO
__{}__{}    ld  (HL),D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  (HL),E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # ------------------------------------- loop ---------------------------------------------
dnl
dnl
dnl # loop(r)
define({__ASM_TOKEN_RLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r)){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    inc  HL             ; 1:6       __INFO
    inc  DE             ; 1:6       __INFO   index++
    ld    A,(HL)        ; 1:7       __INFO
    xor   E             ; 1:4       __INFO   lo(index ^ stop)
    jr   nz, $+8        ; 2:7/12    __INFO
    ld    A, D          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    xor (HL)            ; 1:7       __INFO   hi(index ^ stop)
    jr    z, leave{}$1   ; 2:7/12    __INFO   exit
    dec   L             ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL), D         ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL), E         ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    jp   do{}$1          ; 3:10      __INFO},
__SAVE_EVAL(__GET_LOOP_END($1)),0,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    inc  DE             ; 1:6       __INFO   index++
    ld    A, E          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    jp   nz, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(__GET_LOOP_END($1)),1,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    ld    A, E          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    inc  DE             ; 1:6       __INFO   index++
    jp   nz, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(0xFF00 & (__GET_LOOP_END($1))),0,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    inc  DE             ; 1:6       __INFO   index++
    ld    A, format({%-11s},low __GET_LOOP_END($1)); 2:7       __INFO   lo stop
    xor   E             ; 1:4       __INFO   lo(index ^ stop)
    or    D             ; 1:4       __INFO   hi(stop) = 0
    jp   nz, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(0xFF & (__GET_LOOP_END($1))),0,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    inc  DE             ; 1:6       __INFO   index++
    ld    A, format({%-11s},high __GET_LOOP_END($1)); 2:7       __INFO   hi stop
    xor   D             ; 1:4       __INFO   hi(index ^ stop)
    or    E             ; 1:4       __INFO   lo(stop) = 0
    jp   nz, do{}$1      ; 3:10      __INFO},
__IS_NUM(__GET_LOOP_END($1)),0,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    inc  DE             ; 1:6       __INFO   index++
    ld    A, format({%-11s},low __GET_LOOP_END($1)); 2:7       __INFO   lo stop
    xor   E             ; 1:4       __INFO   lo(index ^ stop
    jp   nz, do{}$1      ; 3:10      __INFO
    ld    A, format({%-11s},high __GET_LOOP_END($1)); 2:7       __INFO   hi stop
    xor   D             ; 1:4       __INFO   hi(index ^ stop
    jp   nz, do{}$1      ; 3:10      __INFO},
{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    inc  DE             ; 1:6       __INFO   index++
ifelse(__HEX_L(__GET_LOOP_END($1)),0x01,{define({__TMP_A},0x00){}dnl
    ld    A, E          ; 1:4       __INFO   lo index
    dec   A             ; 1:4       __INFO   lo(index ^ stop)},
__HEX_L(__GET_LOOP_END($1)),0xFF,{define({__TMP_A},0x00){}dnl
    ld    A, E          ; 1:4       __INFO   lo index
    inc   A             ; 1:4       __INFO   lo(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),__HEX_L(__GET_LOOP_END($1)),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),__HEX_L(1+__GET_LOOP_END($1)),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),__HEX_L(__GET_LOOP_END($1)-1),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),__HEX_L(2*__GET_LOOP_END($1)),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),__HEX_L(__HEX_L(__GET_LOOP_END($1))/2),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1))){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
    cp    E             ; 1:4       __INFO   lo(index ^ stop)},
{define({__TMP_A},0){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1))       ; 2:7       __INFO   lo stop
    xor   E             ; 1:4       __INFO   lo(index ^ stop)})
    jp   nz, do{}$1      ; 3:10      __INFO
ifelse(__HEX_H(__GET_LOOP_END($1)),__TMP_A,{dnl
    xor   D             ; 1:4       __INFO   hi(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),0x01,{dnl
    ld    A, D          ; 1:4       __INFO   hi index
    dec   A             ; 1:4       __INFO   hi(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),0xFF,{dnl
    ld    A, D          ; 1:4       __INFO   hi index
    inc   A             ; 1:4       __INFO   hi(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),__HEX_L(1+__TMP_A),{dnl
    inc   A             ; 1:4       __INFO   hi(stop) = __HEX_H(__GET_LOOP_END($1))
    cp    D             ; 1:4       __INFO   hi(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),__HEX_L(__TMP_A-1),{dnl
    dec   A             ; 1:4       __INFO   hi(stop) = __HEX_H(__GET_LOOP_END($1))
    cp    D             ; 1:4       __INFO   hi(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),__HEX_L(2*__TMP_A),{dnl
    add   A, A          ; 1:4       __INFO   hi(stop) = __HEX_H(__GET_LOOP_END($1))
    cp    D             ; 1:4       __INFO   hi(index ^ stop)},
__HEX_H(__GET_LOOP_END($1)),__HEX_L(__TMP_A/2),{dnl
    rra                 ; 1:4       __INFO   hi(stop) = __HEX_H(__GET_LOOP_END($1))
    cp    D             ; 1:4       __INFO   hi(index ^ stop)},
{dnl
    ld    A, __HEX_H(__GET_LOOP_END($1))       ; 2:7       __INFO   hi stop
    xor   D             ; 1:4       __INFO   hi(index ^ stop)})
    jp   nz, do{}$1      ; 3:10      __INFO})
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # -1 +loop(r)
define({__ASM_TOKEN_SUB1_ADDRLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{(r)}){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    inc  HL             ; 1:6       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    xor   E             ; 1:4       __INFO   lo index - stop
    jr   nz, $+8        ; 2:7/12    __INFO
    inc   L             ; 1:4       __INFO
    ld    A,(HL)        ; 1:7       __INFO
    xor   D             ; 1:4       __INFO   hi index - stop
    jr    z, leave{}$1   ; 2:7/12    __INFO   exit
    dec   L             ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO
    dec  DE             ; 1:6       __INFO   index--
    ld  (HL), D         ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL), E         ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    jp   do{}$1          ; 3:10      __INFO},
__SAVE_EVAL(__GET_LOOP_END($1)),0,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    ld    A, E          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    dec  DE             ; 1:6       __INFO   index--
    jp   nz, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(__GET_LOOP_END($1)),1,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
    ld    A, E          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    jp   nz, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(0xFF00 & (__GET_LOOP_END($1)-1)),0,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
    ld    A, format({%-11s},low __GET_LOOP_END($1)-1); 2:7       __INFO   lo stop-1
    xor   E             ; 1:4       __INFO   lo(index ^ stop-1)
    or    D             ; 1:4       __INFO   hi(stop-1) = 0
    jp   nz, do{}$1      ; 3:10      __INFO},
__SAVE_EVAL(0xFF & (__GET_LOOP_END($1)-1)),0,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
    ld    A, format({%-11s},high __GET_LOOP_END($1)-1); 2:7       __INFO   hi stop-1
    xor   D             ; 1:4       __INFO   hi(index ^ stop-1)
    or    E             ; 1:4       __INFO   lo(stop-1) = 0
    jp   nz, do{}$1      ; 3:10      __INFO},
__IS_NUM(__GET_LOOP_END($1)-1),0,{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
    ld    A, format({%-11s},low __GET_LOOP_END($1)-1); 2:7       __INFO   lo stop-1
    xor   E             ; 1:4       __INFO   lo(index ^ stop-1
    jp   nz, do{}$1      ; 3:10      __INFO
    ld    A, format({%-11s},high __GET_LOOP_END($1)-1); 2:7       __INFO   hi stop-1
    xor   D             ; 1:4       __INFO   hi(index ^ stop-1
    jp   nz, do{}$1      ; 3:10      __INFO},
{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    dec  DE             ; 1:6       __INFO   index--
ifelse(__HEX_L(__GET_LOOP_END($1)-1),0x01,{define({__TMP_A},0x00){}dnl
    ld    A, E          ; 1:4       __INFO   lo index
    dec   A             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_L(__GET_LOOP_END($1)-1),0xFF,{define({__TMP_A},0x00){}dnl
    ld    A, E          ; 1:4       __INFO   lo index
    inc   A             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__GET_LOOP_END($1)-1),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(1+__GET_LOOP_END($1)-1),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__GET_LOOP_END($1)-1-1),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(2*(__GET_LOOP_END($1)-1)),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__HEX_L(__GET_LOOP_END($1)-1)/2),{define({__TMP_A},__HEX_L(__GET_LOOP_END($1)-1)){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    cp    E             ; 1:4       __INFO   lo(index ^ stop-1)},
{define({__TMP_A},0){}dnl
    ld    A, __HEX_L(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   lo stop-1
    xor   E             ; 1:4       __INFO   lo(index ^ stop-1)})
    jp   nz, do{}$1      ; 3:10      __INFO
ifelse(__HEX_H(__GET_LOOP_END($1)-1),__TMP_A,{dnl
    xor   D             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),0x01,{dnl
    ld    A, D          ; 1:4       __INFO   hi index
    dec   A             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),0xFF,{dnl
    ld    A, D          ; 1:4       __INFO   hi index
    inc   A             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(1+__TMP_A),{dnl
    inc   A             ; 1:4       __INFO   hi(stop-1) = __HEX_H(__GET_LOOP_END($1)-1)
    cp    D             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__TMP_A-1),{dnl
    dec   A             ; 1:4       __INFO   hi(stop-1) = __HEX_H(__GET_LOOP_END($1)-1)
    cp    D             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(2*__TMP_A),{dnl
    add   A, A          ; 1:4       __INFO   hi(stop-1) = __HEX_H(__GET_LOOP_END($1)-1)
    cp    D             ; 1:4       __INFO   hi(index ^ stop-1)},
__HEX_H(__GET_LOOP_END($1)-1),__HEX_L(__TMP_A/2),{dnl
    rra                 ; 1:4       __INFO   hi(stop-1) = __HEX_H(__GET_LOOP_END($1)-1)
    cp    D             ; 1:4       __INFO   hi(index ^ stop-1)},
{dnl
    ld    A, __HEX_H(__GET_LOOP_END($1)-1)       ; 2:7       __INFO   hi stop-1
    xor   D             ; 1:4       __INFO   hi(index ^ stop-1)})
    jp   nz, do{}$1      ; 3:10      __INFO})
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # 2 +loop(r)
define({__ASM_TOKEN_2_ADDRLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r)){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    inc  DE             ; 1:6       __INFO
    inc  DE             ; 1:6       __INFO   DE = index+2
    inc  HL             ; 1:6       __INFO
    ld    A, E          ; 1:4       __INFO
    sub (HL)            ; 1:7       __INFO   lo index+2-stop
    and  0xFE           ; 2:7       __INFO
    jr   nz, $+8        ; 2:7/12    __INFO
    ld    A, D          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    sub (HL)            ; 1:7       __INFO   hi index+2-stop
    jr    z, leave{}$1   ; 2:7/12    __INFO
    dec   L             ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    jp   do{}$1          ; 3:10      __INFO   ( -- ) R:( stop index -- stop index+$1 )
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO},
{
    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    inc  DE             ; 1:6       __INFO
    inc  DE             ; 1:6       __INFO   DE = index+2
    ld    A, E          ; 1:4       __INFO
    sub  format({%-15s},low __GET_LOOP_END($1)); 2:7       __INFO   lo index+2-stop
    rra                 ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
    jp   nz, do{}$1      ; 3:10      __INFO
    ld    A, D          ; 1:4       __INFO
    sbc   A, format({%-11s},high __GET_LOOP_END($1)); 2:7       __INFO   hi index+2-stop
    jp   nz, do{}$1      ; 3:10      __INFO
leave{}$1:               ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO})
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # +loop(r)
dnl # ( step -- )
define({__ASM_TOKEN_ADDRLOOP},{dnl
__{}ifelse(__SAVE_EVAL(__GET_LOOP_STEP($1)),{1},{__ASM_TOKEN_RLOOP($1)},
__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{-1},{__ASM_TOKEN_SUB1_ADDRLOOP($1)},
__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{2},{__ASM_TOKEN_2_ADDRLOOP($1)},
__{}{define({__INFO},__COMPILE_INFO{}(r)){}dnl
__{}ifelse(__GET_LOOP_END($1):_TYP_SINGLE,{:fast},{
__{}__{}                       ;[38:193]    __INFO   fast version
__{}__{}    ex  (SP),HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    pop  BC             ; 1:10      __INFO   BC = step
__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    add   A, C          ; 1:4       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,(HL)        ; 1:7       __INFO   DE = index
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    ld    E, A          ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}__{}    ld    D, A          ; 1:4       __INFO   DE = index-stop
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    add   A, C          ; 1:4       __INFO
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    jp    m, leave{}$1   ; 3:10      __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    jp   do{}$1          ; 3:10      __INFO   ( step -- ) R:( stop index -- stop index+step )},
__{}__GET_LOOP_END($1),{},{
__{}__{}                       ;[35:217]    __INFO   default version
__{}__{}    ex  (SP),HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,(HL)        ; 1:7       __INFO   DE = index
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    C,(HL)        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    B,(HL)        ; 1:7       __INFO   BC = stop
__{}__{}    ex  (SP),HL         ; 1:19      __INFO   HL = step
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO   HL = index-stop
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    add  HL, DE         ; 1:11      __INFO   HL = index-stop+step
__{}__{}    xor   H             ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL = index+step
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    jp    m, leave{}$1   ; 3:10      __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),D          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  (HL),E          ; 1:7       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    jp   do{}$1          ; 3:10      __INFO   ( step -- ) R:( stop index -- stop index+step )},
__{}{
__{}dnl #                      ;[25:121+22=143]
__{}__{}__ADD_HL_CONST(-(__GET_LOOP_END(}$1{)),{BC = -stop = -(__GET_LOOP_END(}$1{))},{HL+= -stop = index-stop}){}dnl
__{}__{}                       ;[eval(18+2*__BYTES):eval(106+2*__CLOCKS)]    __INFO
__{}__{}    ex  (SP),HL         ; 1:19      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,(HL)        ; 1:7       __INFO   DE = index
__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = index, DE = R.A.S.{}dnl
__{}__{}__CODE
__{}__{}    pop  BC             ; 1:10      __INFO   BC =  step
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+=  step = index-stop+step
__{}__{}    xor   H             ; 1:4       __INFO   reverse sign --> exit{}dnl
__{}__{}__ADD_HL_CONST(__GET_LOOP_END(}$1{),{BC =  stop = __GET_LOOP_END(}$1{)},{HL+=  stop = index+step}){}dnl
__{}__{}__CODE
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO})
__{}leave{}$1:               ;           __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    exx                 ; 1:4       __INFO   ( step -- ) R:( stop index -- )
__{}exit{}$1:                ;           __INFO})}){}dnl
dnl
dnl
dnl
dnl # step +loop(r)
define({__ASM_TOKEN_PUSH_ADDRLOOP},{dnl
__{}ifelse(__SAVE_EVAL(__GET_LOOP_STEP($1)),{1},{__ASM_TOKEN_RLOOP($1)},
__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{-1},{__ASM_TOKEN_SUB1_ADDRLOOP($1)},
__{}__SAVE_EVAL(__GET_LOOP_STEP($1)),{2},{__ASM_TOKEN_2_ADDRLOOP($1)},
__{}{define({__INFO},__COMPILE_INFO{}(r)){}dnl
__{}ifelse(__GET_LOOP_END($1),{},{
__{}__{}                       ;[38:170]    __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC = step
__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    add   A, C          ; 1:4       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,(HL)        ; 1:7       __INFO   DE = index
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    ld    E, A          ; 1:4       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}__{}    ld    D, A          ; 1:4       __INFO   DE = index-stop
__{}__{}    ld    A, E          ; 1:4       __INFO
__{}__{}    add   A, C          ; 1:4       __INFO
__{}__{}    ld    A, D          ; 1:4       __INFO
__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}    xor   D             ; 1:4       __INFO
__{}__{}    jp    m, $+10       ; 3:10      __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    jp   do{}$1         ; 3:10      __INFO   ( -- ) R:( stop index -- stop index+__GET_LOOP_STEP($1) )},
__{}__IS_NUM(__GET_LOOP_STEP($1)),0,{
__{}__{}__ADD_HL_CONST(-(__GET_LOOP_END(}$1{)),{BC = -stop = -(__GET_LOOP_END(}$1{))},{HL+= -stop = index-stop}){}dnl
__{}__{}                       ;[eval(17+2*__BYTES):eval(79+2*__CLOCKS)]    __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,(HL)        ; 1:7       __INFO   DE = index
__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = index, DE = R.A.S.{}dnl
__{}__{}__CODE
__{}__{}    ld   BC, format({%-11s},__GET_LOOP_STEP($1)); 3:10      __INFO   BC =  step = __GET_LOOP_STEP($1)
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+=  step = index-stop+step
__{}__{}    sbc   A, A          ; 1:4       __INFO{}dnl
__{}__{}__ADD_HL_CONST(__GET_LOOP_END(}$1{),{BC =  stop = __GET_LOOP_END(}$1{)},{HL+=  stop = index+step}){}dnl
__{}__{}__CODE
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    or   A              ; 1:4       __INFO
__{}__{}  if (((__GET_LOOP_STEP($1)) & 0x8000) = 0)
__{}__{}    jp    z, do{}$1      ; 3:10      __INFO
__{}__{}  else
__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}  endif},
__{}{
__{}dnl #                      ;[25:121+22=143]
__{}__{}__ADD_HL_CONST(-(__GET_LOOP_END(}$1{)),{BC = -stop = -(__GET_LOOP_END(}$1{))},{HL+= -stop = index-stop}){}dnl
__{}__{}                       ;[eval(17+2*__BYTES):eval(79+2*__CLOCKS)]    __INFO
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    D,(HL)        ; 1:7       __INFO   DE = index
__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = index, DE = R.A.S.{}dnl
__{}__{}__CODE
__{}__{}    ld   BC, __HEX_HL(__GET_LOOP_STEP($1))     ; 3:10      __INFO   BC =  step = __GET_LOOP_STEP($1)
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+=  step = index-stop+step
__{}__{}    sbc   A, A          ; 1:4       __INFO{}dnl
__{}__{}__ADD_HL_CONST(__GET_LOOP_END(}$1{),{BC =  stop = __GET_LOOP_END(}$1{)},{HL+=  stop = index+step}){}dnl
__{}__{}__CODE
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    or   A              ; 1:4       __INFO
__{}__{}ifelse(__IS_NUM(__GET_LOOP_STEP($1)),1,{dnl
__{}__{}__{}ifelse(eval((__GET_LOOP_STEP($1)) & 0x8000),0,{dnl
__{}__{}__{}    jp    z, do{}$1      ; 3:10      __INFO},
__{}__{}__{}{dnl
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO})},
__{}__{}{dnl
__{}__{}__{}if (((__GET_LOOP_STEP($1)) & 0x8000) = 0)
__{}__{}__{}    jp    z, do{}$1      ; 3:10      __INFO
__{}__{}__{}else
__{}__{}__{}    jp   nz, do{}$1      ; 3:10      __INFO
__{}__{}__{}endif})})
__{}leave{}$1:               ;           __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    exx                 ; 1:4       __INFO   ( -- ) R:( stop index -- )
__{}exit{}$1:                ;           __INFO{}dnl
})}){}dnl
dnl
dnl
dnl
