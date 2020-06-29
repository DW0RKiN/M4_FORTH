dnl ## for, sfor
dnl
dnl ---------  for ... next  -----------
dnl 5 for dup . next --> 5 4 3 2 1 0
dnl ( index -- ) r: ( -- index )
dnl stop = 0
define({FOR}, {dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       for leave LOOP_STACK
__{}    inc  L              ; 1:4       for leave LOOP_STACK
__{}    jp   next{}LOOP_STACK       ;           for leave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       for unloop LOOP_STACK
__{}    inc  L              ; 1:4       for unloop LOOP_STACK
__{}    inc  HL             ; 1:6       for unloop LOOP_STACK
__{}    exx                 ; 1:4       for unloop LOOP_STACK})
    ex  (SP),HL         ; 1:19      for LOOP_STACK
    ex   DE, HL         ; 1:4       for LOOP_STACK
    exx                 ; 1:4       for LOOP_STACK
    pop  DE             ; 1:10      for LOOP_STACK index
    dec  HL             ; 1:6       for LOOP_STACK
    ld  (HL),D          ; 1:7       for LOOP_STACK
    dec  L              ; 1:4       for LOOP_STACK
    ld  (HL),E          ; 1:7       for LOOP_STACK stop
    exx                 ; 1:4       for LOOP_STACK ( index -- ) R: ( -- index )
for{}LOOP_STACK:                 ;           for LOOP_STACK})dnl
dnl
dnl
dnl
dnl  5 ?for dup . next --> 5 4 3 2 1 0
dnl  0 ?for dup . next --> 0
dnl -1 ?for dup . next -->
dnl -2 ?for dup . next --> -2 -3 -4 ... 2 1 0
dnl ( index -- ) r: ( -- index )
dnl stop = 0
define({QUESTIONFOR}, {dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    exx                 ; 1:4       for leave LOOP_STACK
__{}    inc  L              ; 1:4       for leave LOOP_STACK
__{}    jp   next{}LOOP_STACK       ;           for leave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}    exx                 ; 1:4       for unloop LOOP_STACK
__{}    inc  L              ; 1:4       for unloop LOOP_STACK
__{}    inc  HL             ; 1:6       for unloop LOOP_STACK
__{}    exx                 ; 1:4       for unloop LOOP_STACK})
    ex  (SP),HL         ; 1:19      for LOOP_STACK index
    ex   DE, HL         ; 1:4       for LOOP_STACK
    exx                 ; 1:4       for LOOP_STACK
    pop  DE             ; 1:10      for LOOP_STACK index
    dec  HL             ; 1:6       for LOOP_STACK
    ld    A, D          ; 1:4       for LOOP_STACK
    and   E             ; 1:4       for LOOP_STACK
    inc   A             ; 1:4       for LOOP_STACK
    jp    z, next{}LOOP_STACK    ; 3:10      for LOOP_STACK ( -1 -- ) R: ( -- )
    ld  (HL),D          ; 1:7       for LOOP_STACK
    dec  L              ; 1:4       for LOOP_STACK
    ld  (HL),E          ; 1:7       for LOOP_STACK stop
    exx                 ; 1:4       for LOOP_STACK
    ex   DE, HL         ; 1:4       for LOOP_STACK
    pop  DE             ; 1:10      for LOOP_STACK ( index -- ) R: ( -- index )
for{}LOOP_STACK:                 ;           for LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( index -- index-1 )
define({NEXT},{
    exx                 ; 1:4       next LOOP_STACK
    ld    E,(HL)        ; 1:7       next LOOP_STACK
    inc   L             ; 1:4       next LOOP_STACK
    ld    D,(HL)        ; 1:7       next LOOP_STACK DE = index   
    ld    A, E          ; 1:4       next LOOP_STACK
    or    D             ; 1:4       next LOOP_STACK
    jr    z, next{}LOOP_STACK    ; 2:7/12    next LOOP_STACK exit
    dec  DE             ; 1:6       next LOOP_STACK index--
    ld  (HL),D          ; 1:7       next LOOP_STACK
    dec   L             ; 1:4       next LOOP_STACK
    ld  (HL),E          ; 1:7       next LOOP_STACK
    exx                 ; 1:4       next LOOP_STACK
    jp   for{}LOOP_STACK         ; 3:10      next LOOP_STACK
next{}LOOP_STACK:                ;           next LOOP_STACK
    inc  HL             ; 1:6       next LOOP_STACK
    exx                 ; 1:4       next LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl ---------  sfor ... snext -----------
dnl 5 sfor dup . snext --> 5 4 3 2 1 0
dnl ( index -- index )
dnl stop = 0
define({SFOR}, {dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   snext{}LOOP_STACK       ; 3:10      sfor leave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    ex   DE, HL         ; 1:4       sfor unloop LOOP_STACK
__{}    pop  DE             ; 1:10      sfor unloop LOOP_STACK})
sfor{}LOOP_STACK:                ;           sfor LOOP_STACK ( index -- index )})dnl
dnl
dnl
dnl
dnl  5 ?sfor dup . snext --> 5 4 3 2 1 0
dnl  0 ?sfor dup . snext --> 0
dnl -1 ?sfor dup . snext -->
dnl -2 ?sfor dup . snext --> -2 -3 -4 ... 2 1 0
dnl ( index -- index )
dnl stop = 0
define({QUESTIONSFOR}, {dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   snext{}LOOP_STACK       ; 3:10      sfor leave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    ex   DE, HL         ; 1:4       sfor unloop LOOP_STACK
__{}    pop  DE             ; 1:10      sfor unloop LOOP_STACK})
    ld   A, H           ; 1:4       sfor LOOP_STACK
    and  L              ; 1:4       sfor LOOP_STACK
    inc  A              ; 1:4       sfor LOOP_STACK
    jp   z, snext{}LOOP_STACK    ; 3:10      sfor LOOP_STACK ( -1 -- )
sfor{}LOOP_STACK:                ;           sfor LOOP_STACK ( index -- index )})dnl
dnl
dnl
dnl
dnl ( index -- index-1 )
define({SNEXT},{
    ld   A, H           ; 1:4       snext LOOP_STACK
    or   L              ; 1:4       snext LOOP_STACK
    dec  HL             ; 1:6       snext LOOP_STACK index--
    jp  nz, sfor{}LOOP_STACK     ; 3:10      snext LOOP_STACK
snext{}LOOP_STACK:               ;           snext LOOP_STACK{}dnl
__{}UNLOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
