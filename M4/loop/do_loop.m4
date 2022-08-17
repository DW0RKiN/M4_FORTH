dnl ## non-recursive do loop
dnl
dnl
dnl # ---------  do ... loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- )
define({DO},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_DO},{do},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_DO},{__ASM_TOKEN_DO_D8($1)}){}dnl
dnl
dnl
dnl # ---------  ?do ... loop  -----------
dnl # 5 0 ?do i . loop --> 0 1 2 3 4
dnl # 5 5 ?do i . loop -->
dnl # ( stop index -- ) r:( -- )
define({QUESTIONDO},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_QUESTIONDO},{questiondo},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_QUESTIONDO},{__ASM_TOKEN_QDO_D8($1)}){}dnl
dnl
dnl
dnl # ============================================
dnl
dnl
dnl # ---------  do ... 1 +loop  -----------
dnl # 5 0 do i . loop --> 0 1 2 3 4
dnl # 5 5 do i . loop --> 5 6 7 ... -2 -1 0 1 2 3 4
dnl # ( stop index -- ) r:( -- )
define({DO_I8},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_DO_I8},{do},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_DO_I8},{dnl
__{}define({__INFO},{do_{}$1})
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
define({QDO_I8},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_QDO_I8},{do},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_QDO_I8},{dnl
__{}define({__INFO},{?do_{}$1})
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
define({DO_D8},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_DO_D8},{do},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_DO_D8},{dnl
__{}define({__INFO},{do_{}$1})
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
define({QDO_D8},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_QDO_D8},{do},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_QDO_D8},{dnl
__{}define({__INFO},{?do_{}$1})
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
define({DO_I16},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_DO_I16},{do},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_DO_I16},{dnl
__{}define({__INFO},{do_{}$1})
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
define({QDO_I16},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_QDO_I16},{do},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_QDO_I16},{dnl
__{}define({__INFO},{do_{}$1})
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
define({DO_D16},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_DO_D16},{do},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_DO_D16},{dnl
__{}define({__INFO},{do_{}$1})
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
define({QDO_D16},{dnl
ifelse($#,{0},{dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{jp   leave{}LOOP_STACK       ;           leave_{}LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{{{                    }};           unloop_{}LOOP_STACK}){}dnl
__{}__ADD_TOKEN({__TOKEN_QDO_D16},{do},LOOP_COUNT)},
__{}{
__{}  .error {$0}($@): Unexpected parameter!})}){}dnl
dnl
define({__ASM_TOKEN_QDO_D16},{dnl
__{}define({__INFO},{?do_{}$1})
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
__{}define({__INFO},__COMPILE_INFO)
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
__{}define({__INFO},__COMPILE_INFO)
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
__{}define({__INFO},__COMPILE_INFO)
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
__{}define({__INFO},__COMPILE_INFO)
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
__{}define({__INFO},__COMPILE_INFO)
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
__{}define({__INFO},__COMPILE_INFO)
    ld   HL, (idx{}$1)   ; 3:16      __INFO   ( x -- k )  idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl # ( -- )
dnl # 5 0 do i .     loop --> 0 1 2 3 4
dnl # 5 0 do i . +1 +loop --> 0 1 2 3 4
define({LOOP_I8},{dnl
__{}__ADD_TOKEN({__TOKEN_LOOP_I8},{loop_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LOOP_I8},{dnl
__{}define({__INFO},{loop_{}$1}){}dnl

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
define({LOOP_D8},{dnl
__{}__ADD_TOKEN({__TOKEN_LOOP_D8},{-1 +loop_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LOOP_D8},{dnl
__{}define({__INFO},{-1 +loop_{}$1}){}dnl

idx{}$1 EQU $+1          ;[20:78/57] __COMPILE_INFO
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
define({LOOP_I16},{dnl
__{}__ADD_TOKEN({__TOKEN_LOOP_I16},{loop_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LOOP_I16},{dnl
__{}define({__INFO},{loop_{}$1}){}dnl

loop{}$1:                ;[18:92]    __COMPILE_INFO
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
define({LOOP_D16},{dnl
__{}__ADD_TOKEN({__TOKEN_LOOP_D16},{loop_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LOOP_D16},{dnl
__{}define({__INFO},{-1 +loop_{}$1})
loop{}$1:                ;[18:92]    __COMPILE_INFO
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
dnl # ( -- )
dnl # 5 2 do i .     loop --> 2 3 4
dnl # 5 2 do i . +1 +loop --> 2 3 4
define({LOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_LOOP},{loop_}LOOP_STACK,LOOP_STACK){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LOOP},{dnl
__{}define({__INFO},{loop_{}$1})
idx{}$1 EQU $+1          ;[20:78/61] __COMPILE_INFO
    ld   BC, 0x0000     ; 3:10      __INFO   idx always points to a 16-bit index
    ld    A, C          ; 1:4       __INFO
stp_lo{}$1 EQU $+1       ;           __INFO
    xor  0x00           ; 2:7       __INFO   lo index - stop - 1
    ld    A, B          ; 1:4       __INFO
    inc  BC             ; 1:6       __INFO   index++
    ld  (idx{}$1),BC     ; 4:20      __INFO   save index
    jp   nz, do{}$1      ; 3:10      __INFO
stp_hi{}$1 EQU $+1       ;           __INFO
    xor  0x00           ; 2:7       __INFO   hi index - stop - 1
    jp   nz, do{}$1      ; 3:10      __INFO
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
define({_2_ADDLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_2_ADDLOOP},{2 +loop},LOOP_STACK){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2_ADDLOOP},{dnl
__{}define({__INFO},{2 +loop_{}$1}){}dnl

idx{}$1 EQU $+1          ;           __COMPILE_INFO{}_{}$1
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
dnl # step +loop
dnl # ( -- )
define({PUSH_ADDLOOP},{dnl
__{}ifelse(eval($#),0,{
__{}__{}  .error {$0}($@) without parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@) To much parameters!},
__{}__SAVE_EVAL($1),{1},{LOOP},
__{}__SAVE_EVAL($1),{-1},{LOOP_D8},
__{}__SAVE_EVAL($1),{2},{_2_ADDLOOP},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ADDLOOP},{$1 +loop_}LOOP_STACK,LOOP_STACK,$1){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ADDLOOP},{dnl
__{}define({__INFO},{$2 +loop_{}$1}){}dnl

    push HL             ; 1:11      __COMPILE_INFO
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
}){}dnl
dnl
dnl
dnl
dnl # +loop
dnl # ( step -- )
define({ADDLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_ADDLOOP},{+loop},LOOP_STACK){}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ADDLOOP},{dnl
__{}define({__INFO},{+loop_{}$1}){}dnl

    ld    B, H          ; 1:4       __COMPILE_INFO
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
