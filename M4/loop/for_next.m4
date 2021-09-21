dnl ## non-recursive for i next
dnl
dnl ---------  for ... next  -----------
dnl 5 for i . next --> 5 4 3 2 1 0
dnl ( index -- ) r: ( -- )
dnl stop = 0
define({FOR}, {dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   next{}LOOP_STACK        ;           for leave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}                        ;           for unloop LOOP_STACK})
    ld    B, H          ; 1:4       for LOOP_STACK
    ld    C, L          ; 1:4       for LOOP_STACK
    ex   DE, HL         ; 1:4       for LOOP_STACK
    pop  DE             ; 1:10      for LOOP_STACK index
for{}LOOP_STACK:                 ;           for LOOP_STACK
    ld  (idx{}LOOP_STACK),BC     ; 4:20      next LOOP_STACK save index})dnl
dnl
dnl
dnl
dnl ( -- ) r: ( -- )
dnl stop = 0
define({PUSH_FOR}, {dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   next{}LOOP_STACK       ;           for leave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}                        ;           for unloop LOOP_STACK})
    ld   BC, format({%-11s},$1); 3:10      $1 for LOOP_STACK
for{}LOOP_STACK:                 ;           $1 for LOOP_STACK
    ld  (idx{}LOOP_STACK),BC     ; 4:20      $1 for LOOP_STACK save index})dnl
dnl
dnl
dnl
dnl  5 ?for i . next --> 5 4 3 2 1 0
dnl  0 ?for i . next --> 0
dnl -1 ?for i . next -->
dnl -2 ?for i . next --> -2 -3 -4 ... 2 1 0
dnl ( index -- ) r: ( -- )
dnl stop = 0
define({QUESTIONFOR}, {dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   next{}LOOP_STACK       ;           ?for leave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}                        ;           ?for unloop LOOP_STACK})
    ld    B, H          ; 1:4       ?for LOOP_STACK
    ld    C, L          ; 1:4       ?for LOOP_STACK
    ex   DE, HL         ; 1:4       ?for LOOP_STACK
    pop  DE             ; 1:10      ?for LOOP_STACK index
    ld    A, B          ; 1:4       ?for LOOP_STACK
    and   C             ; 1:4       ?for LOOP_STACK
    inc   A             ; 1:4       ?for LOOP_STACK
    jp    z, next{}LOOP_STACK    ; 3:10      ?for LOOP_STACK ( index -- )
for{}LOOP_STACK:                 ;           ?for LOOP_STACK
    ld  (idx{}LOOP_STACK),BC     ; 4:20      $1 xfor LOOP_STACK save index})dnl
dnl
dnl
dnl
dnl ( index -- index-1 )
define({NEXT},{
idx{}LOOP_STACK EQU $+1          ;           next LOOP_STACK
    ld   BC, 0x0000     ; 3:10      next LOOP_STACK idx always points to a 16-bit index
    ld    A, B          ; 1:4       next LOOP_STACK
    or    C             ; 1:4       next LOOP_STACK
    dec  BC             ; 1:6       next LOOP_STACK index--, zero flag unaffected
    jp   nz, for{}LOOP_STACK     ; 3:10      next LOOP_STACK
next{}LOOP_STACK:                ;           next LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl
