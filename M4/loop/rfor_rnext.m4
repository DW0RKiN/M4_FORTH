dnl ## recursive rfor ri rnext
dnl
dnl # ---------  rfor ... rnext  -----------
dnl # 5 rfor ri . rnext --> 5 4 3 2 1 0
dnl # ( index -- ) r: ( -- index )
dnl # stop = 0
define({RFOR},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       rfor-leave_{}LOOP_STACK
__{}    inc  L              ; 1:4       rfor-leave_{}LOOP_STACK
__{}    jp   next{}LOOP_STACK       ;           rfor-leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       rfor-unloop_{}LOOP_STACK
__{}    inc  L              ; 1:4       rfor-unloop_{}LOOP_STACK
__{}    inc  HL             ; 1:6       rfor-unloop_{}LOOP_STACK
__{}    exx                 ; 1:4       rfor-unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_RFOR},{rfor_}LOOP_STACK,LOOP_STACK)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_RFOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex  (SP),HL         ; 1:19      __INFO
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   index
    dec  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec  L              ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO   stop
    exx                 ; 1:4       __INFO   ( index -- ) R: ( -- index )
for{}$1:                 ;           __INFO}){}dnl
dnl
dnl
dnl
dnl #  5 ?rfor ri . rnext --> 5 4 3 2 1 0
dnl #  0 ?rfor ri . rnext --> 0
dnl # -1 ?rfor ri . rnext -->
dnl # -2 ?rfor ri . rnext --> -2 -3 -4 ... 2 1 0
dnl # ( index -- ) r: ( -- index )
dnl # stop = 0
define({QUESTIONRFOR},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       ?rfor-leave_{}LOOP_STACK
__{}    inc  L              ; 1:4       ?rfor-leave_{}LOOP_STACK
__{}    jp   next{}LOOP_STACK       ;           ?rfor-leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       ?rfor-unloop_{}LOOP_STACK
__{}    inc  L              ; 1:4       ?rfor-unloop_{}LOOP_STACK
__{}    inc  HL             ; 1:6       ?rfor-unloop_{}LOOP_STACK
__{}    exx                 ; 1:4       ?rfor-unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_QRFOR},{?rfor_}LOOP_STACK,LOOP_STACK)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_QRFOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ex  (SP),HL         ; 1:19      __INFO   index
    ex   DE, HL         ; 1:4       __INFO
    exx                 ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   index
    dec  HL             ; 1:6       __INFO
    ld    A, D          ; 1:4       __INFO
    and   E             ; 1:4       __INFO
    inc   A             ; 1:4       __INFO
    jp    z, next{}$1    ; 3:10      __INFO   ( -1 -- ) R: ( -- )
    ld  (HL),D          ; 1:7       __INFO
    dec  L              ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO   stop
    exx                 ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO   ( index -- ) R: ( -- index )
for{}$1:                 ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- i )
dnl # RXI from rxdo_rxloop.m4
dnl # ( -- j )
dnl # RXJ from rxdo_rxloop.m4
dnl # ( -- j )
dnl # RXK from rxdo_rxloop.m4
dnl
dnl
dnl
dnl # ( index -- index-1 )
define({RNEXT},{dnl
__{}__ADD_TOKEN({__TOKEN_RNEXT},{rnext_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RNEXT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl

    exx                 ; 1:4       __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc   L             ; 1:4       __INFO
    ld    D,(HL)        ; 1:7       __INFO   DE = index
    ld    A, E          ; 1:4       __INFO
    or    D             ; 1:4       __INFO
    jr    z, next{}$1    ; 2:7/12    __INFO   exit
    dec  DE             ; 1:6       __INFO   index--
    ld  (HL),D          ; 1:7       __INFO
    dec   L             ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    exx                 ; 1:4       __INFO
    jp   for{}$1         ; 3:10      __INFO
next{}$1:                ;           __INFO
    inc  HL             ; 1:6       __INFO
    exx                 ; 1:4       __INFO{}dnl
}){}dnl
dnl
dnl
dnl
