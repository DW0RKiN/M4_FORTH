dnl ## recursive sfor si snext
dnl
dnl
dnl # ---------  sfor ... snext -----------
dnl # 5 sfor dup . snext --> 5 4 3 2 1 0
dnl # ( index -- index )
dnl # stop = 0
define({SFOR},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}__SET_LOOP(LOOP_COUNT,{S},0,,-1){}dnl
__{}__ADD_TOKEN({__TOKEN_SFOR},{for_}LOOP_STACK,LOOP_STACK){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SFOR},{dnl
__{}define({__INFO},__COMPILE_INFO{}(s))
for{}$1:                 ;           __INFO ( index -- index )}){}dnl
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
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}__SET_LOOP(LOOP_COUNT,{S},0,,-1){}dnl
__{}__ADD_TOKEN({__TOKEN_QSFOR},{?for_}LOOP_STACK,LOOP_STACK){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_QSFOR},{dnl
__{}define({__INFO},__COMPILE_INFO{}(s)){}dnl
dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   next{}$1        ; 3:10      sfor leave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}    ex   DE, HL         ; 1:4       sfor unloop LOOP_STACK
__{}    pop  DE             ; 1:10      sfor unloop LOOP_STACK})
    ld   A, H           ; 1:4       __INFO
    and  L              ; 1:4       __INFO
    inc  A              ; 1:4       __INFO
    jp   z, next{}$1     ; 3:10      __INFO   ( -1 -- )
for{}$1:                 ;           __INFO   ( index -- index )}){}dnl
dnl
dnl
dnl
dnl # ( index -- index-1 )
define({SNEXT},{dnl
__{}__ADD_TOKEN({__TOKEN_SNEXT},{next_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SNEXT},{dnl
__{}define({__INFO},__COMPILE_INFO{}(s))
    ld    A, H          ; 1:4       __INFO
    or    L             ; 1:4       __INFO
    dec  HL             ; 1:6       __INFO   index--
    jp  nz, for{}$1      ; 3:10      __INFO
leave{}$1:               ;           __INFO{}dnl
__{}__ASM_TOKEN_UNLOOP($1){}dnl
}){}dnl
dnl
dnl
dnl
