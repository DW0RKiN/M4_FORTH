dnl ## recursive sfor si snext
dnl
dnl
dnl # ---------  sfor ... snext -----------
dnl # 5 sfor dup . snext --> 5 4 3 2 1 0
dnl # ( index -- index )
dnl # stop = 0
define({SFOR},{dnl
__{}__ADD_TOKEN({__TOKEN_SFOR},{sfor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SFOR},{dnl
__{}define({__INFO},{sfor}){}dnl
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   snext{}LOOP_STACK       ; 3:10      sfor leave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    ex   DE, HL         ; 1:4       sfor unloop LOOP_STACK
__{}    pop  DE             ; 1:10      sfor unloop LOOP_STACK})
sfor{}LOOP_STACK:                ;           sfor LOOP_STACK ( index -- index )}){}dnl
dnl
dnl
dnl
dnl #  5 ?sfor dup . snext --> 5 4 3 2 1 0
dnl #  0 ?sfor dup . snext --> 0
dnl # -1 ?sfor dup . snext -->
dnl # -2 ?sfor dup . snext --> -2 -3 -4 ... 2 1 0
dnl # ( index -- index )
dnl # stop = 0
define({QUESTIONSFOR},{dnl
__{}__ADD_TOKEN({__TOKEN_QUESTIONSFOR},{questionsfor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_QUESTIONSFOR},{dnl
__{}define({__INFO},{questionsfor}){}dnl
dnl
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
sfor{}LOOP_STACK:                ;           sfor LOOP_STACK ( index -- index )}){}dnl
dnl
dnl
dnl
dnl # ( index -- index-1 )
define({SNEXT},{dnl
__{}__ADD_TOKEN({__TOKEN_SNEXT},{snext},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SNEXT},{dnl
__{}define({__INFO},{snext}){}dnl

    ld   A, H           ; 1:4       snext LOOP_STACK
    or   L              ; 1:4       snext LOOP_STACK
    dec  HL             ; 1:6       snext LOOP_STACK index--
    jp  nz, sfor{}LOOP_STACK     ; 3:10      snext LOOP_STACK
snext{}LOOP_STACK:               ;           snext LOOP_STACK{}dnl
__{}UNLOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
dnl
dnl
