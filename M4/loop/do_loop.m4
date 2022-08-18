dnl ## non-recursive do loop
dnl
dnl
dnl # ============================================
dnl
dnl
dnl # ---------  do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_MDO_I8},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    ld    A, E          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
    ld    A, D          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- stop index )
define({__ASM_TOKEN_QMDO_I8},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    ld    A, E          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop
    ld    A, D          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, exit{}$1    ; 3:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  do ... -loop  -----------
dnl # 0 5 do i . loop --> 5 4 3 2 1 0
dnl # 0 0 do i . loop --> 0
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_MDO_D8},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    dec  DE             ; 1:6       __INFO
    ld    A, E          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop-1
    ld    A, D          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop-1
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... 1 +loop  -----------
dnl # 0 5 do i . loop --> 5 4 3 2 1 0
dnl # 0 0 do i . loop -->
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_QMDO_D8},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m)
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    dec  DE             ; 1:6       __INFO
    ld    A, E          ; 1:4       __INFO
    ld  (stp_lo{}$1), A  ; 3:13      __INFO   lo stop-1
    ld    A, D          ; 1:4       __INFO
    ld  (stp_hi{}$1), A  ; 3:13      __INFO   hi stop-1
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, exit{}$1    ; 3:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- )
define({__ASM_TOKEN_MDO_I16},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    ld  (stp{}$1), DE    ; 4:20      __INFO
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- stop index )
define({__ASM_TOKEN_QMDO_I16},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld  (stp{}$1), DE    ; 4:20      __INFO   ( stop index -- )
    dec  HL             ; 1:6       __INFO
    ld  (idx{}$1), HL    ; 3:16      __INFO   index
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp  loop{}$1         ; 3:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  do ... -1 +loop  -----------
dnl # 0 5 do i . loop --> 5 4 3 2 1 0
dnl # 5 5 do i . loop --> 5 4 3 2 1 0 -1 ... -32768 32767 32766 ... 7 6 5
dnl # ( stop index -- ) r:( -- stop index )
define({__ASM_TOKEN_MDO_D16},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    dec  DE             ; 1:6       __INFO   stop-1
    ld  (stp{}$1), DE    ; 4:20      __INFO
    pop  DE             ; 1:10      __INFO
    pop  HL             ; 1:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
dnl # ---------  ?do ... -1 +loop  -----------
dnl # 0 5 do i . loop --> 5 4 3 2 1 0
dnl # 5 5 do i . loop -->
dnl # ( stop index -- ) r:( -- stop index )
define({__ASM_TOKEN_QMDO_D16},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld  (idx{}$1), HL    ; 3:16      __INFO   ( stop index -- )
    or    A             ; 1:4       __INFO
    sbc  HL, DE         ; 2:15      __INFO
    dec  DE             ; 1:6       __INFO   stop-1
    ld  (stp{}$1), DE    ; 4:20      __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO
    jp    z, exit{}$1    ; 3:10      __INFO
do{}$1:                  ;           __INFO}){}dnl
dnl
dnl
define({TEST_IDEA_DO_I_LOOP},{
                        ;[12:60]    do_101 i_101
    ld    A, E          ; 1:4       do_101 i_101
    ld  (stp_lo101), A  ; 3:13      do_101 i_101   lo stop
    ld    A, D          ; 1:4       do_101 i_101
    ld  (stp_hi101), A  ; 3:13      do_101 i_101   hi stop
    pop  DE             ; 1:10      do_101 i_101
do101:                  ;           do_101 i_101
    ld  (idx101), HL    ; 3:16      do_101 i_101   save index

                     ;[20:52/73/87] loop_101
    push DE             ; 1:11      loop_101   ( -- i )
    ex   DE, HL         ; 1:4       loop_101
idx101 EQU $+1          ;           loop_101
    ld   HL, 0x0000     ; 3:10      loop_101   idx always points to a 16-bit index
    inc  HL             ; 1:6       loop_101   index++
    ld    A, L          ; 1:4       loop_101   lo new index
stp_lo101 EQU $+1       ;           loop_101
    xor  0x00           ; 2:7       loop_101   lo stop
    jp   nz, do101      ; 3:10      loop_101
    ld    A, H          ; 1:4       loop_101   hi new index
stp_hi101 EQU $+1       ;           loop_101
    xor  0x00           ; 2:7       loop_101   hi stop
    jp   nz, do101      ; 3:10      loop_101
    ex   DE, HL         ; 1:4       loop_101
    pop  DE             ; 1:10      loop_101
leave101:               ;           loop_101
exit101:                ;           loop_101
                       ;[32:147]}){}dnl
dnl
dnl
define({TEST_IDEA_SMALL_DO_I_LOOP},{
                        ;[8:46]     do_101 i_101
    ld  (stp101), DE    ; 4:20      do_101 i_101   stop
    pop  DE             ; 1:10      do_101 i_101
do101:                  ;           do_101 i_101
    ld  (idx101), HL    ; 3:16      do_101 i_101   save index

                        ;[18:81/95] loop_101
    push DE             ; 1:11      loop_101   ( -- i )
    ex   DE, HL         ; 1:4       loop_101
idx101 EQU $+1          ;           loop_101
    ld   HL, 0x0000     ; 3:10      loop_101   idx always points to a 16-bit index
    inc  HL             ; 1:6       loop_101   index++
stp101 EQU $+1          ;           loop_101
    ld   BC, 0x0000     ; 3:10      loop_101   stop
    or    A             ; 1:4       loop_101   lo stop
    sbc  HL, BC         ; 2:15      loop_101
    add  HL, BC         ; 1:11      loop_101
    jp   nz, do101      ; 3:10      loop_101
    ex   DE, HL         ; 1:4       loop_101
    pop  DE             ; 1:10      loop_101
leave101:               ;           loop_101
exit101:                ;           loop_101
                       ;[26:141]}){}dnl
dnl
dnl
dnl # ( -- i )
dnl # hodnota indexu aktualni smycky
define({I},{dnl
__{}__ADD_TOKEN({__TOKEN_I},{i_}LOOP_STACK,LOOP_STACK){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_I},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    push DE             ; 1:11      __INFO   ( -- i )
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, (idx{}$1)   ; 3:16      __INFO   idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # ( x -- i )
dnl # hodnota indexu aktualni smycky
define({DROP_I},{dnl
__{}__ADD_TOKEN({__TOKEN_DROP_I},{drop i_}LOOP_STACK,LOOP_STACK){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_I},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld   HL, (idx{}$1)   ; 3:16      __INFO   ( x -- i )  idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl
dnl # ( -- j )
dnl # hodnota indexu vnejsi smycky
define({J},{dnl
ifelse($#,{0},{dnl
__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_J},{j_}LOOP_STACK,LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}popdef({__TEMP})},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_J},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    push DE             ; 1:11      __INFO   ( -- j )
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, (idx{}$1)   ; 3:16      __INFO   idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl
dnl # ( x -- j )
dnl # hodnota indexu vnejsi smycky
define({DROP_J},{dnl
__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_DROP_J},{drop j_}LOOP_STACK,LOOP_STACK){}dnl
__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}popdef({__TEMP}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_J},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld   HL, (idx{}$1)   ; 3:16      __INFO   ( x -- j )  idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # ( -- k )
dnl # hodnota indexu druhe vnejsi smycky
define({K},{dnl
__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_K},{k_}LOOP_STACK,LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}__{}popdef({__TEMP}){}dnl
__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}popdef({__TEMP}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_K},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, (idx{}$1)   ; 3:16      __INFO   idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl
dnl # ( x -- k )
dnl # hodnota indexu druhe vnejsi smycky
define({DROP_K},{dnl
__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}pushdef({__TEMP},LOOP_STACK){}dnl
__{}__{}__{}popdef({LOOP_STACK}){}dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_DROP_K},{drop k_}LOOP_STACK,LOOP_STACK){}dnl
__{}__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}__{}popdef({__TEMP}){}dnl
__{}__{}pushdef({LOOP_STACK},__TEMP){}dnl
__{}__{}popdef({__TEMP}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DROP_K},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
    ld   HL, (idx{}$1)   ; 3:16      __INFO   ( x -- k )  idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # ( -- )
dnl # 5 0 do i .     loop --> 0 1 2 3 4
dnl # 5 0 do i . +1 +loop --> 0 1 2 3 4
define({__ASM_TOKEN_MLOOP_I8},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
idx{}$1 EQU $+1          ;[20:78/57] __COMPILE_INFO
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    inc  BC             ; 1:6       __INFO   index++
    ld  (idx{}$1), BC    ; 4:20      __INFO   save index
    ld    A, C          ; 1:4       __INFO   lo new index
stp_lo{}$1 EQU $+1       ;           __INFO
    xor  0x00           ; 2:7       __INFO   lo stop
    jp   nz, do{}$1      ; 3:10      __INFO
    ld    A, B          ; 1:4       __INFO   hi new index
stp_hi{}$1 EQU $+1       ;           __INFO
    xor  0x00           ; 2:7       __INFO   hi stop
    jp   nz, do{}$1      ; 3:10      __INFO
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # 0 5 do i . -1 +loop --> 5 4 3 2 1 0
define({__ASM_TOKEN_SUB1_ADDMLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
idx{}$1 EQU $+1          ;[20:78/57] __INFO
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    dec  BC             ; 1:6       __INFO   index--
    ld  (idx{}$1), BC    ; 4:20      __INFO   save index
    ld    A, C          ; 1:4       __INFO   lo new index
stp_lo{}$1 EQU $+1       ;           __INFO
    xor  0x00           ; 2:7       __INFO   lo stop-1
    jp   nz, do{}$1      ; 3:10      __INFO
    ld    A, B          ; 1:4       __INFO   hi new index
stp_hi{}$1 EQU $+1       ;           __INFO
    xor  0x00           ; 2:7       __INFO   hi stop-1
    jp   nz, do{}$1      ; 3:10      __INFO
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl # ( -- )
dnl # 5 0 do i .     loop --> 0 1 2 3 4
dnl # 5 0 do i . +1 +loop --> 0 1 2 3 4
define({__ASM_TOKEN_MLOOP16},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m)){}dnl

loop{}$1:                ;[18:92]    __INFO
    push HL             ; 1:11      __INFO
idx{}$1 EQU $+1          ;           __INFO
    ld   HL, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    inc  HL             ; 1:6       __INFO   index++
    ld  (idx{}$1), HL    ; 3:16      __INFO   save index
stp{}$1 EQU $+1          ;           __INFO
    ld   BC, 0x0000     ; 3:10      __INFO   stop
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO   index - stop
    pop  HL             ; 1:10      __INFO
    jp   nz, do{}$1      ; 3:10      __INFO
dnl #                     ;18:92
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # 0 5 do i . -1 +loop --> 5 4 3 2 1 0
define({__ASM_TOKEN_SUB1_MLOOP16},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
loop{}$1:                ;[18:92]    __INFO
    push HL             ; 1:11      __INFO
idx{}$1 EQU $+1          ;           __INFO
    ld   HL, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    dec  HL             ; 1:6       __INFO   index--
    ld  (idx{}$1), HL    ; 3:16      __INFO   save index
stp{}$1 EQU $+1          ;           __INFO
    ld   BC, 0x0000     ; 3:10      __INFO   stop-1
    or    A             ; 1:4       __INFO
    sbc  HL, BC         ; 2:15      __INFO   index - stop
    pop  HL             ; 1:10      __INFO
    jp   nz, do{}$1      ; 3:10      __INFO
dnl #                     ;18:92
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO}){}dnl
dnl
dnl
dnl
dnl # 2 +loop
dnl # ( -- )
dnl # 6 0 do i . 2 +loop --> 0 2 4
dnl # 5 0 do i . 2 +loop --> 0 2 4
dnl # 6 4 do i . 2 +loop --> 4
dnl # 6 5 do i . 2 +loop --> 5
dnl # 6 6 do i . 2 +loop --> 6 8 10 12 ...
define({__ASM_TOKEN_2_ADDMLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m))
idx{}$1 EQU $+1          ;           __INFO
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    inc  BC             ; 1:6       __INFO   index++
    ld    A, C          ; 1:4       __INFO
stp_lo{}$1 EQU $+1       ;           __INFO
    sub  0x00           ; 2:7       __INFO   lo index - stop
    rra                 ; 1:4       __INFO
    add   A, A          ; 1:4       __INFO   and 0xFE with save carry
    ld    A, B          ; 1:4       __INFO
    inc  BC             ; 1:6       __INFO   index++
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index
    jp   nz, do{}$1      ; 3:10      __INFO
stp_hi{}$1 EQU $+1       ;           __INFO
    sbc   A, 0x00       ; 2:7       __INFO   hi index - stop
    jp   nz, do{}$1      ; 3:10      __INFO
dnl #                         ;23:71/92/92
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
}){}dnl
dnl
dnl
dnl
dnl # step +loop
define({__ASM_TOKEN_PUSH_ADDMLOOP},{dnl
__{}ifelse(__SAVE_EVAL($1),{1},{__ASM_TOKEN_MLOOP($1)},
__{}__SAVE_EVAL($1),{-1},{__ASM_TOKEN_SUB1_ADDMLOOP($1)},
__{}__SAVE_EVAL($1),{2},{__ASM_TOKEN_2_ADDMLOOP($1)},
__{}{define({__INFO},__COMPILE_INFO{}(m))
    push HL             ; 1:11      __INFO
idx{}$1 EQU $+1          ;           __INFO
    ld   HL, 0x0000     ; 3:10      __INFO
    ld   BC, format({%-11s},$2); 3:10      __INFO BC = step
    add  HL, BC         ; 1:11      __INFO HL = index+step
    ld  (idx{}$1), HL    ; 3:16      __INFO save index
stp_lo{}$1 EQU $+1       ;           __INFO
    ld    A, 0x00       ; 2:7       __INFO lo stop
    sub   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
stp_hi{}$1 EQU $+1       ;           __INFO
    ld    A, 0x00       ; 2:7       __INFO hi stop
    sbc   A, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO HL = stop-(index+step)
    add  HL, BC         ; 1:11      __INFO HL = stop-index
    xor   H             ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO
    jp    p, do{}$1      ; 3:10      __INFO negative step
dnl #                     ;??:???
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
})}){}dnl
dnl
dnl
dnl
define({__ASM_TOKEN_ADDMLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO{}(m)){}dnl

    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO BC = step
idx{}$1 EQU $+1          ;           __INFO
    ld   HL, 0x0000     ; 3:10      __INFO
    add  HL, BC         ; 1:11      __INFO HL = index+step
    ld  (idx{}$1), HL    ; 3:16      __INFO save index
stp_lo{}$1 EQU $+1       ;           __INFO
    ld    A, 0x00       ; 2:7       __INFO lo stop
    sub   L             ; 1:4       __INFO
    ld    L, A          ; 1:4       __INFO
stp_hi{}$1 EQU $+1       ;           __INFO
    ld    A, 0x00       ; 2:7       __INFO hi stop
    sbc   A, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO HL = stop-(index+step)
    add  HL, BC         ; 1:11      __INFO HL = stop-index
    xor   H             ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO
    jp    p, do{}$1      ; 3:10      __INFO
dnl #                     ;24:114
leave{}$1:               ;           __INFO
exit{}$1:                ;           __INFO{}dnl
}){}dnl
dnl
dnl
dnl
dnl
