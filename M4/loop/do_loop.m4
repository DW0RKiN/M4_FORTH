dnl ## non-recursive do loop
define({__},{})dnl
dnl
dnl
dnl ---------  do ... loop  -----------
dnl 5 0 do i . loop --> 0 1 2 3 4 
dnl ( stop index -- ) r:( -- stop index )
define({DO},{ifelse($#,{0},,{
.error Unexpected parameter: do($@) --> push2($@) do ?}){}dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   leave{}LOOP_STACK       ;           leave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}                        ;           unloop LOOP_STACK})
    ld  (idx{}LOOP_STACK), HL    ; 3:16      do LOOP_STACK index
    dec  DE             ; 1:6       do LOOP_STACK stop-1
    ld    A, E          ; 1:4       do LOOP_STACK 
    ld  (stp_lo{}LOOP_STACK), A  ; 3:13      do LOOP_STACK lo stop
    ld    A, D          ; 1:4       do LOOP_STACK 
    ld  (stp_hi{}LOOP_STACK), A  ; 3:13      do LOOP_STACK hi stop
    pop  HL             ; 1:10      do LOOP_STACK
    pop  DE             ; 1:10      do LOOP_STACK ( -- ) R: ( -- )
do{}LOOP_STACK:                  ;           do LOOP_STACK})dnl
dnl
dnl
dnl ---------  ?do ... loop  -----------
dnl 5 0 ?do i . loop --> 0 1 2 3 4 
dnl 5 5 ?do i . loop -->  
dnl ( stop index -- ) r:( -- stop index )
define({QUESTIONDO},{ifelse($#,{0},,{
.error Unexpected parameter: ?do($@) --> push2($@) ?do ?}){}dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   leave{}LOOP_STACK       ;           leave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}                        ;           unloop LOOP_STACK})
    ld  (idx{}LOOP_STACK), HL    ; 3:16      ?do LOOP_STACK index
    or    A             ; 1:4       ?do LOOP_STACK
    sbc  HL, DE         ; 2:15      ?do LOOP_STACK
    dec  DE             ; 1:6       ?do LOOP_STACK stop-1
    ld    A, E          ; 1:4       ?do LOOP_STACK 
    ld  (stp_lo{}LOOP_STACK), A  ; 3:13      ?do LOOP_STACK lo stop
    ld    A, D          ; 1:4       ?do LOOP_STACK 
    ld  (stp_hi{}LOOP_STACK), A  ; 3:13      ?do LOOP_STACK hi stop
    pop  HL             ; 1:10      ?do LOOP_STACK
    pop  DE             ; 1:10      ?do LOOP_STACK
    jp    z, exit{}LOOP_STACK    ; 3:10      ?do LOOP_STACK ( -- ) R: ( -- )
do{}LOOP_STACK:                  ;           ?do LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( -- i )
dnl hodnota indexu vnitrni smycky
define({I},{
    push DE             ; 1:11      index i LOOP_STACK
    ex   DE, HL         ; 1:4       index i LOOP_STACK
    ld   HL, (idx{}LOOP_STACK)   ; 3:16      index i LOOP_STACK idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl ( -- j )
dnl hodnota indexu druhe vnitrni smycky
define({J},{
    push DE             ; 1:11      index j LOOP_STACK
    ex   DE, HL         ; 1:4       index j LOOP_STACK
__{}pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK}){}dnl
    ld   HL, (idx{}LOOP_STACK)   ;{}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK}){}dnl
__{} 3:16      index j LOOP_STACK idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl ( -- k )
dnl hodnota indexu treti vnitrni smycky
define({K},{
    push DE             ; 1:11      index k LOOP_STACK
    ex   DE, HL         ; 1:4       index k LOOP_STACK
__{}pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK}){}dnl
__{}pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK}){}dnl
    ld   HL, (idx{}LOOP_STACK)   ;{}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK}){}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK}){}dnl
__{} 3:16      index k LOOP_STACK idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl ( -- )
define({LOOP},{
idx{}LOOP_STACK EQU $+1          ;           loop LOOP_STACK
    ld   BC, 0x0000     ; 3:10      loop LOOP_STACK idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop LOOP_STACK
stp_lo{}LOOP_STACK EQU $+1       ;           loop LOOP_STACK
    xor  0x00           ; 2:7       loop LOOP_STACK lo index - stop - 1
    ld    A, B          ; 1:4       loop LOOP_STACK
    inc  BC             ; 1:6       loop LOOP_STACK index++
    ld  (idx{}LOOP_STACK),BC     ; 4:20      loop LOOP_STACK save index
    jp   nz, do{}LOOP_STACK      ; 3:10      loop LOOP_STACK    
stp_hi{}LOOP_STACK EQU $+1       ;           loop LOOP_STACK
    xor  0x00           ; 2:7       loop LOOP_STACK hi index - stop - 1
    jp   nz, do{}LOOP_STACK      ; 3:10      loop LOOP_STACK
dnl                     ;20:61/78/78
leave{}LOOP_STACK:               ;           loop LOOP_STACK
exit{}LOOP_STACK:                ;           loop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK})})dnl
dnl
dnl
dnl
dnl ( -- )
define({SUB1_ADDLOOP},{
idx{}LOOP_STACK EQU $+1          ;           -1 +loop LOOP_STACK
    ld   BC, 0x0000     ; 3:10      -1 +loop LOOP_STACK idx always points to a 16-bit index
    dec  BC             ; 1:6       -1 +loop LOOP_STACK index--
    ld  (idx{}LOOP_STACK),BC     ; 4:20      -1 +loop LOOP_STACK save index
    ld    A, C          ; 1:4       -1 +loop LOOP_STACK
stp_lo{}LOOP_STACK EQU $+1       ;           -1 +loop LOOP_STACK
    xor  0x00           ; 2:7       -1 +loop LOOP_STACK lo index - stop - 1
    jp   nz, do{}LOOP_STACK      ; 3:10      -1 +loop LOOP_STACK
    ld    A, B          ; 1:4       -1 +loop LOOP_STACK
stp_hi{}LOOP_STACK EQU $+1       ;           -1 +loop LOOP_STACK
    xor  0x00           ; 2:7       -1 +loop LOOP_STACK hi index - stop - 1
    jp   nz, do{}LOOP_STACK      ; 3:10      -1 +loop LOOP_STACK
dnl                     ;20:57/78/78
leave{}LOOP_STACK:               ;           -1 +loop LOOP_STACK
exit{}LOOP_STACK:                ;           -1 +loop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK})})dnl
dnl
dnl
dnl
dnl 2 +loop
dnl ( -- )
define({_2_ADDLOOP},{
idx{}LOOP_STACK EQU $+1          ;           2 +loop LOOP_STACK
    ld   BC, 0x0000     ; 3:10      2 +loop LOOP_STACK idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +loop LOOP_STACK index++
    ld    A, C          ; 1:4       2 +loop LOOP_STACK
stp_lo{}LOOP_STACK EQU $+1       ;           2 +loop LOOP_STACK
    sub  0x00           ; 2:7       2 +loop LOOP_STACK lo index - stop
    rra                 ; 1:4       2 +loop LOOP_STACK
    add   A, A          ; 1:4       2 +loop LOOP_STACK and 0xFE with save carry
    ld    A, B          ; 1:4       2 +loop LOOP_STACK
    inc  BC             ; 1:6       2 +loop LOOP_STACK index++
    ld  (idx{}LOOP_STACK),BC     ; 4:20      2 +loop LOOP_STACK save index
    jp   nz, do{}LOOP_STACK      ; 3:10      2 +loop LOOP_STACK
stp_hi{}LOOP_STACK EQU $+1       ;           2 +loop LOOP_STACK
    sbc   A, 0x00       ; 2:7       2 +loop LOOP_STACK hi index - stop
    jp   nz, do{}LOOP_STACK      ; 3:10      2 +loop LOOP_STACK
dnl                         ;23:71/92/92
leave{}LOOP_STACK:               ;           2 +loop LOOP_STACK
exit{}LOOP_STACK:                ;           2 +loop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl step +loop
dnl ( -- )
define({X_ADDLOOP},{
    push HL             ; 1:11      $1 +loop LOOP_STACK
idx{}LOOP_STACK EQU $+1          ;           $1 +loop LOOP_STACK
    ld   HL, 0x0000     ; 3:10      $1 +loop LOOP_STACK
    ld   BC, format({%-11s},$1); 3:10      $1 +loop LOOP_STACK BC = step
    add  HL, BC         ; 1:11      $1 +loop LOOP_STACK HL = index+step
    ld  (idx{}LOOP_STACK), HL    ; 3:16      $1 +loop LOOP_STACK save index
stp_lo{}LOOP_STACK EQU $+1       ;           $1 +loop LOOP_STACK
    ld    A, 0x00       ; 2:7       $1 +loop LOOP_STACK lo stop
    sub   L             ; 1:4       $1 +loop LOOP_STACK
    ld    L, A          ; 1:4       $1 +loop LOOP_STACK
stp_hi{}LOOP_STACK EQU $+1       ;           $1 +loop LOOP_STACK
    ld    A, 0x00       ; 2:7       $1 +loop LOOP_STACK hi stop
    sbc   A, H          ; 1:4       $1 +loop LOOP_STACK
    ld    H, A          ; 1:4       $1 +loop LOOP_STACK HL = stop-(index+step)
    add  HL, BC         ; 1:11      $1 +loop LOOP_STACK HL = stop-index
    xor   H             ; 1:4       $1 +loop LOOP_STACK
    pop  HL             ; 1:10      $1 +loop LOOP_STACK
    jp    p, do{}LOOP_STACK      ; 3:10      $1 +loop LOOP_STACK negative step
dnl                     ;??:???
leave{}LOOP_STACK:               ;           $1 +loop LOOP_STACK
exit{}LOOP_STACK:                ;           $1 +loop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl
dnl step +loop
dnl ( -- )
define({PUSH_ADDLOOP},{ifelse(eval($1),{1},{
                        ;           push_addloop($1) LOOP_STACK{}LOOP},
eval($1),{-1},{
                        ;           push_addloop($1) LOOP_STACK{}SUB1_ADDLOOP},
eval($1),{2},{
                        ;           push_addloop($1) LOOP_STACK{}_2_ADDLOOP},
{$#},{1},{X_ADDLOOP($1)},{
.error push_addloop without parameter!})})dnl
dnl
dnl
dnl +loop
dnl ( step -- )
define({ADDLOOP},{
    ld    B, H          ; 1:4       +loop LOOP_STACK
    ld    C, L          ; 1:4       +loop LOOP_STACK BC = step
idx{}LOOP_STACK EQU $+1          ;           +loop LOOP_STACK
    ld   HL, 0x0000     ; 3:10      +loop LOOP_STACK
    add  HL, BC         ; 1:11      +loop LOOP_STACK HL = index+step
    ld  (idx{}LOOP_STACK), HL    ; 3:16      +loop LOOP_STACK save index
stp_lo{}LOOP_STACK EQU $+1       ;           +loop LOOP_STACK
    ld    A, 0x00       ; 2:7       +loop LOOP_STACK lo stop
    sub   L             ; 1:4       +loop LOOP_STACK
    ld    L, A          ; 1:4       +loop LOOP_STACK
stp_hi{}LOOP_STACK EQU $+1       ;           +loop LOOP_STACK
    ld    A, 0x00       ; 2:7       +loop LOOP_STACK hi stop
    sbc   A, H          ; 1:4       +loop LOOP_STACK
    ld    H, A          ; 1:4       +loop LOOP_STACK HL = stop-(index+step)
    add  HL, BC         ; 1:11      +loop LOOP_STACK HL = stop-index
    xor   H             ; 1:4       +loop LOOP_STACK
    ex   DE, HL         ; 1:4       +loop LOOP_STACK
    pop  DE             ; 1:10      +loop LOOP_STACK
    jp    p, do{}LOOP_STACK      ; 3:10      +loop LOOP_STACK
dnl                     ;24:114
leave{}LOOP_STACK:               ;           +loop LOOP_STACK
exit{}LOOP_STACK:                ;           +loop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl
dnl
