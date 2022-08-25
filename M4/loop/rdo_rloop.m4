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
__{}ifelse(__GET_LOOP_END($1),{},{
                       ;[15:116]    __INFO   ( stop index -- ) ( R: -- stop index )
    ex  (SP),HL         ; 1:19      __INFO
    push DE             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   DE = stop
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec  L              ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO   DE = index
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec  L              ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
do{}$1:                  ;           __INFO},
__{}__GET_LOOP_BEGIN($1),{},{
                        ;[9:65]     __INFO   ( index -- ) ( R: -- index )
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
                        ;[9:42]     __INFO   ( -- ) ( R: -- index )
    exx                 ; 1:4       __INFO
    ld   DE, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index
    dec  HL             ; 1:6       __INFO
do{}$1:                  ;           __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO})}){}dnl
dnl
dnl
dnl
dnl # ?do(r)
define({__ASM_TOKEN_QRDO},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r))
__{}ifelse(__GET_LOOP_END($1),{},{dnl
    push HL             ; 1:11      __INFO   index
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    jr   nz, $+8        ; 2:7/12    __INFO
    pop  HL             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp   exit{}$1        ; 3:10      __INFO
    push DE             ; 1:11      __INFO   stop
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   stop
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec  L              ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO   stop
    pop  DE             ; 1:10      __INFO   index
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec  L              ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO   index
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO   ( stop index -- ) R: ( -- stop index )
do{}$1:                  ;           __INFO},
__{}__GET_LOOP_BEGIN($1),{},{
define({_TMP_INFO},__INFO){}dnl
define({_TMP_STACK_INFO},__INFO{   }( index -- ) ( R: -- index )  stop=__GET_LOOP_END($1)){}dnl
__EQ_MAKE_BEST_CODE(__GET_LOOP_END($1),16,31,7,34){}dnl
__{}_TMP_BEST_CODE
    jr   nz, $+7        ; 2:7/12    __INFO
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    jp   exit{}$1        ; 3:10      __INFO
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
__IS_NUM(__GET_LOOP_BEGIN($1)):__HEX_HL(__GET_LOOP_BEGIN($1)),1:__HEX_HL(__GET_LOOP_END($1)),{
                        ;[5:18]     __INFO   ( -- ) ( R: -- index )
    jp   exit{}$1        ; 3:10      __INFO
do{}$1:                  ;           __INFO
    dec   L             ; 1:4       __INFO
    exx                 ; 1:4       __INFO},
{
                        ;[9:42]     __INFO   ( -- ) ( R: -- index )
    exx                 ; 1:4       __INFO
    ld   DE, format({%-11s},__GET_LOOP_BEGIN($1)); 3:10      __INFO   DE = index
    dec  HL             ; 1:6       __INFO
do{}$1:                  ;           __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO}))}){}dnl
dnl
dnl
dnl
dnl # ( -- i )
dnl # hodnota indexu aktualni smycky
define({RI},{dnl
ifelse($#,{0},{dnl
__{}__ADD_TOKEN({__TOKEN_RI},{ri_}LOOP_STACK,LOOP_STACK)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_RI},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r))
    exx                 ; 1:4       __INFO   ( -- i ) R:( stop_i i -- stop_i i )
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    push DE             ; 1:11      __INFO
    dec   L             ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- j )
dnl # hodnota indexu prvni vnejsi smycky
define({RJ},{dnl
ifelse($#,{0},{dnl
__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_RJ},{rj_}LOOP_STACK,LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}popdef({__TEMP})},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_RJ},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r))
    exx                 ; 1:4       __INFO   ( -- j ) R:( stop_j j stop_i i -- stop_j j stop_i i )
    ld   DE, 0x0004     ; 3:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    add  HL, DE         ; 1:11      __INFO
    ld    C,(HL)        ; 1:7       __INFO   lo
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO   hi
    ex   DE, HL         ; 1:4       __INFO
    push BC             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- k )
dnl # hodnota indexu druhe vnejsi smycky
define({RK},{dnl
ifelse($#,{0},{dnl
__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_RK},{rk_}LOOP_STACK,LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}__{}popdef({__TEMP}){}dnl
__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}popdef({__TEMP})},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_RK},{dnl
__{}define({__INFO},__COMPILE_INFO{}(r))
    exx                 ; 1:4       __INFO   ( -- k ) R:( stop_k k stop_j j stop_i i -- stop_k k stop_j j stop_i i )
    ld   DE, 0x0008     ; 3:10      __INFO
    ex   DE, HL         ; 1:4       __INFO
    add  HL, DE         ; 1:11      __INFO
    ld    C,(HL)        ; 1:7       __INFO   lo
    inc   L             ; 1:4       __INFO
    ld    B,(HL)        ; 1:7       __INFO   hi
    ex   DE, HL         ; 1:4       __INFO
    push BC             ; 1:11      __INFO
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ex  (SP),HL         ; 1:19      __INFO}){}dnl
dnl
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
    ld    A,(HL)        ; 1:4       __INFO
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
__{}define({__INFO},__COMPILE_INFO{}(r)){}dnl
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
    rra                 ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
    jr   nz, $+8        ; 2:7/12    __INFO
    ld    A, D          ; 1:4       __INFO
    inc   L             ; 1:4       __INFO
    sbc   A,(HL)        ; 1:7       __INFO   hi index+2-stop
    jr    z, leave{}$1   ; 2:7/12    __INFO
    dec   L             ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    jp    p, do{}$1      ; 3:10      __INFO   ( -- ) R:( stop index -- stop index+$1 )
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
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO   ( step -- ) R:( stop index -- stop index+step )},
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
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO   ( step -- ) R:( stop index -- stop index+step )},
__{}{
__{}dnl #                      ;[25:121+22=143]
__{}__{}__ADD_HL_CONST(-(__GET_LOOP_END(}$1{)),{BC = -stop = -(__GET_LOOP_END(}$1{))},{HL+= -stop = index-stop}){}dnl
__{}__{}                       ;[eval(17+2*__BYTES):eval(102+2*__CLOCKS)]    __INFO
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
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO   ( -- ) R:( stop index -- stop index+__GET_LOOP_STEP($1) )},
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
__{}__{}    ld    A, H          ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO   HL+=  step = index-stop+step
__{}__{}    xor   H             ; 1:4       __INFO   reverse sign --> exit{}dnl
__{}__{}__ADD_HL_CONST(__GET_LOOP_END(}$1{),{BC =  stop = __GET_LOOP_END(}$1{)},{HL+=  stop = index+step}){}dnl
__{}__{}__CODE
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    jp    p, do{}$1      ; 3:10      __INFO})
__{}leave{}$1:               ;           __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    exx                 ; 1:4       __INFO   ( -- ) R:( stop index -- )
__{}exit{}$1:                ;           __INFO{}dnl
})}){}dnl
dnl
dnl
dnl
