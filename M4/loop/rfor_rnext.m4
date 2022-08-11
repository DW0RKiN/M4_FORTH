dnl ## recursive rfor ri rnext
dnl
dnl # ---------  rfor ... rnext  -----------
dnl # 5 rfor ri . rnext --> 5 4 3 2 1 0
dnl # ( index -- ) r: ( -- index )
dnl # stop = 0
define({RFOR},{dnl
__{}__ADD_TOKEN({__TOKEN_RFOR},{rfor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RFOR},{dnl
__{}define({__INFO},{rfor}){}dnl
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       rfor leave LOOP_STACK
__{}    inc  L              ; 1:4       rfor leave LOOP_STACK
__{}    jp   next{}LOOP_STACK       ;           rfor leave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       rfor unloop LOOP_STACK
__{}    inc  L              ; 1:4       rfor unloop LOOP_STACK
__{}    inc  HL             ; 1:6       rfor unloop LOOP_STACK
__{}    exx                 ; 1:4       rfor unloop LOOP_STACK})
    ex  (SP),HL         ; 1:19      rfor LOOP_STACK
    ex   DE, HL         ; 1:4       rfor LOOP_STACK
    exx                 ; 1:4       rfor LOOP_STACK
    pop  DE             ; 1:10      rfor LOOP_STACK index
    dec  HL             ; 1:6       rfor LOOP_STACK
    ld  (HL),D          ; 1:7       rfor LOOP_STACK
    dec  L              ; 1:4       rfor LOOP_STACK
    ld  (HL),E          ; 1:7       rfor LOOP_STACK stop
    exx                 ; 1:4       rfor LOOP_STACK ( index -- ) R: ( -- index )
for{}LOOP_STACK:                 ;           rfor LOOP_STACK}){}dnl
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
__{}__ADD_TOKEN({__TOKEN_QUESTIONRFOR},{questionrfor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_QUESTIONRFOR},{dnl
__{}define({__INFO},{questionrfor}){}dnl
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       rfor leave LOOP_STACK
__{}    inc  L              ; 1:4       rfor leave LOOP_STACK
__{}    jp   next{}LOOP_STACK       ;           rfor leave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       rfor unloop LOOP_STACK
__{}    inc  L              ; 1:4       rfor unloop LOOP_STACK
__{}    inc  HL             ; 1:6       rfor unloop LOOP_STACK
__{}    exx                 ; 1:4       rfor unloop LOOP_STACK})
    ex  (SP),HL         ; 1:19      rfor LOOP_STACK index
    ex   DE, HL         ; 1:4       rfor LOOP_STACK
    exx                 ; 1:4       rfor LOOP_STACK
    pop  DE             ; 1:10      rfor LOOP_STACK index
    dec  HL             ; 1:6       rfor LOOP_STACK
    ld    A, D          ; 1:4       rfor LOOP_STACK
    and   E             ; 1:4       rfor LOOP_STACK
    inc   A             ; 1:4       rfor LOOP_STACK
    jp    z, next{}LOOP_STACK    ; 3:10      rfor LOOP_STACK ( -1 -- ) R: ( -- )
    ld  (HL),D          ; 1:7       rfor LOOP_STACK
    dec  L              ; 1:4       rfor LOOP_STACK
    ld  (HL),E          ; 1:7       rfor LOOP_STACK stop
    exx                 ; 1:4       rfor LOOP_STACK
    ex   DE, HL         ; 1:4       rfor LOOP_STACK
    pop  DE             ; 1:10      rfor LOOP_STACK ( index -- ) R: ( -- index )
for{}LOOP_STACK:                 ;           rfor LOOP_STACK}){}dnl
dnl
dnl
dnl
dnl # ( index -- index-1 )
define({RNEXT},{dnl
__{}__ADD_TOKEN({__TOKEN_RNEXT},{rnext},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RNEXT},{dnl
__{}define({__INFO},{rnext}){}dnl

    exx                 ; 1:4       rnext LOOP_STACK
    ld    E,(HL)        ; 1:7       rnext LOOP_STACK
    inc   L             ; 1:4       rnext LOOP_STACK
    ld    D,(HL)        ; 1:7       rnext LOOP_STACK DE = index
    ld    A, E          ; 1:4       rnext LOOP_STACK
    or    D             ; 1:4       rnext LOOP_STACK
    jr    z, next{}LOOP_STACK    ; 2:7/12    rnext LOOP_STACK exit
    dec  DE             ; 1:6       rnext LOOP_STACK index--
    ld  (HL),D          ; 1:7       rnext LOOP_STACK
    dec   L             ; 1:4       rnext LOOP_STACK
    ld  (HL),E          ; 1:7       rnext LOOP_STACK
    exx                 ; 1:4       rnext LOOP_STACK
    jp   for{}LOOP_STACK         ; 3:10      rnext LOOP_STACK
next{}LOOP_STACK:                ;           rnext LOOP_STACK
    inc  HL             ; 1:6       rnext LOOP_STACK
    exx                 ; 1:4       rnext LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
dnl
dnl
