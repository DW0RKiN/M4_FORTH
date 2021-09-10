dnl ## Runtime enviroment
dnl
dnl
ifdef({USE_S16},{ifdef({USE_U16},,define({USE_U16},{}))
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_S16:
    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    jr   nc, PRINT_U16  ; 2:7/12
    
    xor   A             ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    L, A          ; 1:4       neg
    sbc   A, H          ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    H, A          ; 1:4       neg
    PUTCHAR(' ')
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      ld   BC, ** 
    
    ; fall to print_u16}){}dnl
dnl
dnl
ifdef({USE_U16},{
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, AF', BC, DE, HL = DE, DE = (SP)
PRINT_U16:
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A

; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_U16_ONLY:
    call BIN2DEC        ; 3:17
    pop  BC             ; 1:10      ret
    ex   DE, HL         ; 1:4
    pop  DE             ; 1:10
    push BC             ; 1:10      ret
    ret                 ; 1:10

; Input: HL = number
; Output: print number
; Pollutes: AF, HL, BC
BIN2DEC:
    xor   A             ; 1:4       A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10
    call BIN2DEC_CHAR+2 ; 3:17    
    ld   BC, -1000      ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld   BC, -100       ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld    C, -10        ; 2:7
    call BIN2DEC_CHAR   ; 3:17
    ld    A, L          ; 1:4
    add   A,'0'         ; 2:7
    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A
    ret                 ; 1:10
    
BIN2DEC_CHAR:
    and  0xF0           ; 2:7       '0'..'9' => '0', unchanged 0
    
    add  HL, BC         ; 1:11
    inc   A             ; 1:4
    jr    c, $-2        ; 2:7/12
    sbc  HL, BC         ; 2:15
    dec   A             ; 1:4
    ret   z             ; 1:5/11
    
    or   '0'            ; 2:7       0 => '0', unchanged '0'..'9'
    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A
    ret                 ; 1:10}){}dnl
dnl
dnl
dnl
ifdef({USE_TYPE},{

; addr n --
; print n chars from addr
;  Input: HL, DE
; Output: Print decimal number in HL
; Pollutes: AF, AF', BC, DE, HL
PRINT_STRING:
    ld    B, H          ; 1:4       Length of string to print    
    ld    C, L          ; 1:4       Length of string to print
    call 0x203C         ; 3:17      Print our string
    ret                 ; 1:10}){}dnl
dnl
dnl
dnl
ifdef({USE_LSHIFT},{

; ( x u -- x)
; shifts x left u places
;  Input: HL, DE
; Output: HL = DE << HL
; Pollutes: AF, BC, DE, HL
DE_LSHIFT:
    ld    A, L          ; 1:4    
    ld   BC, 0x0010     ; 3:10
    sbc  HL, BC         ; 2:15
    jr   nc, DE_LSHIFTZ ; 2:7/12
    
    cp    0x08          ; 2:7
    jr    c, $+7        ; 2:7/12
    sub   0x08          ; 2:7
    ld    D, E          ; 1:4
    ld    E, 0x00       ; 2:7
    
    ld    H, D          ; 1:4
    ld    L, E          ; 1:4
    or    A             ; 1:4
    ret   z             ; 1:5/11

    ld    B, A          ; 1:4
    add  HL, HL         ; 1:11
    djnz $-1            ; 2:8/13
    ret                 ; 1:10
DE_LSHIFTZ:
    ld   HL, 0x0000     ; 3:10
    ret                 ; 1:10}){}dnl
dnl
dnl
dnl
ifdef({USE_RSHIFT},{

; ( x u -- x)
; shifts x right u places
;  Input: HL, DE
; Output: HL = DE >> HL
; Pollutes: AF, BC, DE, HL
DE_RSHIFT:
    ld    A, L          ; 1:4    
    ld   BC, 0x0010     ; 3:10
    sbc  HL, BC         ; 2:15
    jr   nc, ifdef({USE_LSHIFT},{DE_LSHIFTZ},{DE_RSHIFTZ}) ; 2:7/12
    
    cp    0x08          ; 2:7
    jr    c, $+7        ; 2:7/12
    sub   0x08          ; 2:7
    ld    E, D          ; 1:4
    ld    D, 0x00       ; 2:7       unsigned
    
    ld    H, D          ; 1:4
    ld    L, E          ; 1:4
    or    A             ; 1:4
    ret   z             ; 1:5/11

    ld    B, A          ; 1:4
    ld    A, L          ; 1:4
    srl   H             ; 2:8       unsigned
    rra                 ; 1:4
    djnz $-3            ; 2:8/13
    ld    L, A          ; 1:4
    ret                 ; 1:10{}ifdef({USE_LSHIFT},,{
DE_RSHIFTZ:
    ld   HL, 0x0000     ; 3:10
    ret                 ; 1:10})}){}dnl
dnl
dnl
dnl
ifdef({USE_MUL},{
; Input: HL,DE
; Output: HL=HL*DE ((un)signed)
; It does not matter whether it is signed or unsigned multiplication.{}dnl
ifelse(TYPMUL,{small},{
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[17:cca 835-846] small version
    ld    B, 0x10       ; 2:7
    ld    A, H          ; 1:4
    ld    C, L          ; 1:4
    ld   HL, 0x0000     ; 3:10

    add  HL, HL         ; 1:11
    rl    C             ; 2:8
    rla                 ; 1:4
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    djnz $-7            ; 2:13/8
    
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{fast},{
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[148:cca 359-428] fast version
   
                        ;           HL = HL*DE = HL*E + 256*D*L
    ld    B, H          ; 1:4
    ld    C, L          ; 1:4       HL = BC = base 1x
    
    ld    A, E          ; 1:4       DE check bits
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E7; 2:7/12
    jr    z, MULTIPLY_D ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E6; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E5; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E4; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E3; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E2; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E1; 2:7/12    
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E0; 2:7/12    
                        ;           
MULTIPLY_D:             ;           A == E == 0 
    ld    H, A          ; 1:4
    ld    L, A          ; 1:4       HL = 0

    sla   D             ; 2:8       check D 1000_0000 bit
    jr    c, MULTIPLY_D7; 2:7/12
    ret   z             ; 1:5/11
    sla   D             ; 2:8       check D 0100_0000 bit
    jr    c, MULTIPLY_D6; 2:7/12
    sla   D             ; 2:8       check D 0010_0000 bit
    jr    c, MULTIPLY_D5; 2:7/12
    sla   D             ; 2:8       check D 0001_0000 bit
    jr    c, MULTIPLY_D4; 2:7/12
    sla   D             ; 2:8       check D 0000_1000 bit
    jr    c, MULTIPLY_D3; 2:7/12
    sla   D             ; 2:8       check D 0000_0100 bit
    jr    c, MULTIPLY_D2; 2:7/12
    sla   D             ; 2:8       check D 0000_0010 bit
    jr    c, MULTIPLY_D1; 2:7/12    
                        ;           D == 1
    ld    H, C          ; 1:4       HL = 256*HL
    ret                 ; 1:10

MULTIPLY_E7:            ;           HL 1x --> 128x
    add  HL, HL         ; 1:11
    
    add   A, A          ; 1:4       check E 0100_0000 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E6:            ;           HL 1x --> 64x
    add  HL, HL         ; 1:11
    
    add   A, A          ; 1:4       check E 0010_0000 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11

MULTIPLY_E5:            ;           HL 1x --> 32x
    add  HL, HL         ; 1:11
    
    add   A, A          ; 1:4       check E 0001_0000 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E4:            ;           HL 1x --> 16x
    add  HL, HL         ; 1:11
    
    add   A, A          ; 1:4       check E 0000_1000 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E3:            ;           HL 1x --> 8x
    add  HL, HL         ; 1:11
    
    add   A, A          ; 1:4       check E 0000_0100 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E2:            ;           HL 1x --> 4x
    add  HL, HL         ; 1:11
    
    add   A, A          ; 1:4       check E 0000_0010 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E1:            ;           HL 1x --> 2x
    add  HL, HL         ; 1:11
    
    add   A, A          ; 1:4       check E 0000_0001 bit
    jr   nc, $+3        ; 2:7/12
    add  HL, BC         ; 1:11
MULTIPLY_E0:            ;           A = 0
    
    sla   D             ; 2:8       check D 1000_0000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D7:
    add   A, C          ; 1:4
    ret   z             ; 1:5/11    (D == 0 || C == 0) --> zero flag --> HL = HL*E
    
    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0100_0000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D6:
    add   A, C          ; 1:4
    
    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0010_0000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D5:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0001_0000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D4:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0000_1000 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D3:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0000_0100 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D2:
    add   A, C          ; 1:4
    
    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0000_0010 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D1:
    add   A, C          ; 1:4

    add   A, A          ; 1:4
    sla   D             ; 2:8       check D 0000_0001 bit
    jr   nc, $+3        ; 2:7/12
MULTIPLY_D0:
    add   A, C          ; 1:4

    add   A, H          ; 1:4    
    ld    H, A          ; 1:4
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{old_fast},{
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[147:cca 423-490] fast version
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jr    c, $+3        ; 2:7/12
    ex   DE, HL         ; 1:4       H=>D faster 7+4<12
    
    ld    A, H          ; 1:4
    ld    C, L          ; 1:4
    ld   HL, 0x0000     ; 3:10
    
    add   A, A          ; 1:4       ?......._.......x
    jr    c, MULTIPLY1  ; 2:7/12
    jr    z, MULTIPLY_LO; 2:7/12    00000000_.......x
    add   A, A          ; 1:4       0?......_......xx
    jr    c, MULTIPLY2  ; 2:7/12
    add   A, A          ; 1:4       00?....._.....xxx
    jr    c, MULTIPLY3  ; 2:7/12
    add   A, A          ; 1:4       000?...._....xxxx
    jr    c, MULTIPLY4  ; 2:7/12
    add   A, A          ; 1:4       0000?..._...xxxxx
    jr    c, MULTIPLY5  ; 2:7/12
    add   A, A          ; 1:4       00000?.._..xxxxxx
    jr    c, MULTIPLY6  ; 2:7/12
    add   A, A          ; 1:4       000000?._.xxxxxxx
    jr    c, MULTIPLY7  ; 2:7/12    
    jp   MULTIPLY8      ; 3:10      00000001_xxxxxxxx
MULTIPLY_LO:
    ld    A, C          ; 1:4
    add   A, A          ; 1:4       00000000_?.......
    jr    c, MULTIPLY9  ; 2:7/12
    add   A, A          ; 1:4       00000000_0?......
    jr    c, MULTIPLY10 ; 2:7/12
    add   A, A          ; 1:4       00000000_00?.....
    jr    c, MULTIPLY11 ; 2:7/12
    add   A, A          ; 1:4       00000000_000?....
    jr    c, MULTIPLY12 ; 2:7/12
    add   A, A          ; 1:4       00000000_0000?...
    jr    c, MULTIPLY13 ; 2:7/12
    add   A, A          ; 1:4       00000000_00000?..
    jr    c, MULTIPLY14 ; 2:7/12
    add   A, A          ; 1:4       00000000_000000?.
    jr    c, MULTIPLY15 ; 2:7/12
    add   A, A          ; 1:4       00000000_0000000?
    ret  nc             ; 1:5/11
    ex   DE, HL         ; 1:4       HL = DE
    ret                 ; 1:10

MULTIPLY1:
    ld    L, E          ; 1:4       
    sla   L             ; 2:8
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY2:
    add  HL, DE         ; 1:11
    sla   L             ; 2:8
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY3:
    add  HL, DE         ; 1:11
    sla   L             ; 2:8
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY4:
    add  HL, DE         ; 1:11
    sla   L             ; 2:8
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY5:
    add  HL, DE         ; 1:11
    sla   L             ; 2:8
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY6:
    add  HL, DE         ; 1:11
    sla   L             ; 2:8
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY7:
    add  HL, DE         ; 1:11
    sla   L             ; 2:8
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY8:
    add  HL, DE         ; 1:11      oooooooo_........
    add  HL, HL         ; 1:11      256x
    ld    A, C          ; 1:4
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY9:
    add  HL, DE         ; 1:11      ooooooo._........
    add  HL, HL         ; 1:11      128x
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY10:
    add  HL, DE         ; 1:11      oooooo.._........
    add  HL, HL         ; 1:11      64x
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY11:
    add  HL, DE         ; 1:11      ooooo..._........
    add  HL, HL         ; 1:11      32x
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY12:
    add  HL, DE         ; 1:11      oooo...._........
    add  HL, HL         ; 1:11      16x
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY13:
    add  HL, DE         ; 1:11      ooo....._........
    add  HL, HL         ; 1:11      8x
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY14:
    add  HL, DE         ; 1:11      oo......_........
    add  HL, HL         ; 1:11      4x
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY15:
    add  HL, DE         ; 1:11      o......._........
    add  HL, HL         ; 1:11      2x
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{test},{
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[43:cca 510-644] test version
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jr    c, $+3        ; 2:7/12
    ex   DE, HL         ; 1:4       H=>D faster 7+4<12

    ld    A, E          ; 1:4
    ld    B, H          ; 1:4       
    ld    C, L          ; 1:4
    ld   HL, 0x0000     ; 3:10 

    srl   C             ; 2:8       divide old HL by 2
    jr   nc, MUL_LOOP+1 ; 2:7/12
MUL_LOOP:
    add  HL, DE         ; 1:11

    sla   E             ; 2:8
    rl    D             ; 2:8       multiply old DE by 2
    srl   C             ; 2:8       divide old HL by 2
    jr    c, MUL_LOOP   ; 2:7/12
    jp   nz, MUL_LOOP+1 ; 3:10

    ld    E, C          ; 1:4
    srl   B             ; 2:8       divide old DE by 2
    jr   nc, MUL_LOOP2+2; 2:7/12
MUL_LOOP2:
    ld    D, A          ; 1:4
    add  HL, DE         ; 1:11
    add   A, A          ; 1:4       multiply old DE by 2
    srl   B             ; 2:8       divide old HL by 2
    jr    c, MUL_LOOP2  ; 2:7/12
    jp   nz, MUL_LOOP2+2; 3:10
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{test2},{
; Pollutes: AF, B, DE
MULTIPLY:
                        ;[105:cca 538-702]test2 version
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jr    c, $+3        ; 2:7/12
    ex   DE, HL         ; 1:4       H=>D faster 7+4<12

    ld    B, H          ; 1:4       
    ld    A, L          ; 1:4
    ld   HL, 0x0000     ; 3:10 

    srl   B             ; 2:8
    rra                 ; 1:4       divide old HL by 2, zero flag unaffected
    jr   nc, $+3        ; 2:7/12
MUL_LOOP:
    add  HL, DE         ; 1:11
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2    
    srl   B             ; 2:8
    rra                 ; 1:4       divide old HL by 2, zero flag unaffected
    jr    c, MUL_LOOP   ; 2:7/12
    jp   nz, MUL_LOOP+1 ; 3:10
;2x E
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide A by 2
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret   z             ; 1:5/11
;3x E
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide A by 2
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret   z             ; 1:5/11
;4x E
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide A by 2
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret   z             ; 1:5/11
;5x E
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide A by 2
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret   z             ; 1:5/11
;6x E
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide A by 2
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret   z             ; 1:5/11
;7x E
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide A by 2
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret   z             ; 1:5/11
;8x E
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide A by 2
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret   z             ; 1:5/11
;9x
    sla   D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide A by 2
    ret  nc             ; 1:5/11
    add  HL, DE         ; 1:11
;---------------
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{test3},{
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[62:cca 584-593] test3 version
    xor   A             ; 1:4       A = 0 = 256sum
    ld    C, E          ; 1:4
    ld    B, D          ; 1:4
    ld    E, A          ; 1:4
    ld    D, A          ; 1:4       DE = 0 = sum

    srl   B             ; 2:8       check 8. bit
    jp   nc, $+4        ; 3:10
    add   A, L          ; 1:4       + 256x
    jr    z, HL0E_begin ; 2:7/12
    
    srl   C             ; 2:8       check 0. bit
    jp   nc, HLDE_turn  ; 3:10

HLDE_sum:
    ex   DE, HL         ; 1:4
    add  HL, DE         ; 1:11      DE += HL
    ex   DE, HL         ; 1:4
HLDE_turn:
    add  HL, HL         ; 1:11      next turn --> 2xHL

    srl   B             ; 2:8       check 8. bit
    jp   nc, $+4        ; 3:10
    add   A, L          ; 1:4       + 256x
    
    srl   C             ; 2:8       check 0. bit
    jr    c, HLDE_sum   ; 2:7/12
    jp   nz, HLDE_turn  ; 3:10

; fall into HLD0

DB 0x0E                 ; 2:7       ld C, 0x85
HLD0_256x:
    add   A, L          ; 1:4       + 256x

HLD0_turn:
    sla   L             ; 2:8       next turn --> 2xL

    srl   B             ; 2:8       check 8. bit
    jr    c, HLD0_256x  ; 2:7/12
    jr   nz, HLD0_turn  ; 2:7/12

    ex   DE, HL         ; 1:4
    add   A, H          ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10
    
HL0E_sum:               ;    or H0_DE
    ex   DE, HL         ; 1:4
    add  HL, DE         ; 1:11      DE += HL
    ex   DE, HL         ; 1:4
HL0E_turn:
    add  HL, HL         ; 1:11      next turn --> 2xHL
HL0E_begin:
    srl   C             ; 2:8       check 0. bit
    jr    c, HL0E_sum   ; 2:7/12
    jp   nz, HL0E_turn  ; 3:10

    ex   DE, HL         ; 1:4
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{test4},{
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[89:cca 477-596] test4 version
    xor   A             ; 1:4       A = 0 = 256sum
    ld    B, H          ; 1:4
    ld    C, L          ; 1:4
    ld    H, A          ; 1:4
    ld    L, A          ; 1:4       HL = 0 = result BC*DE

    srl   B             ; 2:8       check 8. bit
    jr    z, CDE_begin  ; 2:7/12    B == 0, carry?
    jp   nc, $+6        ; 3:10      carry == 0    
    add   A, E          ; 1:4
    jr    z, BCD0_begin ; 2:7/12    B == 0
    
    srl   C             ; 2:8       check 0. bit
    jp   nc, BCDE_turn  ; 3:10

BCDE_sum:
    add  HL, DE         ; 1:11      HL += DE
BCDE_turn:
    sla   E             ; 2:8
    rl    D             ; 2:8       next turn --> 2xDE
    
    srl   B             ; 2:8       check 8. bit
    jp   nc, $+4        ; 3:10
    add   A, E          ; 1:4       + 256x
    
    srl   C             ; 2:8       check 0. bit
    jr    c, BCDE_sum   ; 2:7/12
    jp   nz, BCDE_turn  ; 3:10

; fall into B0DE

DB 0x0E                 ; 2:7       ld C, 0x85
B0DE_256x:
    add   A, E          ; 1:4       + 256x

B0DE_turn:
    sla   E             ; 2:8       next turn --> 2xE

    srl   B             ; 2:8       check 8. bit
    jr    c, B0DE_256x  ; 2:7/12
    jr   nz, B0DE_turn  ; 2:7/12

    add   A, H          ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10
    
CDE_begin:
    jr   nc, $+3        ; 2:7/12    
    ld    H, E          ; 1:4       256x
    srl   C             ; 2:8       check 0. bit
    jp   nc, CDE_turn   ; 3:10
    
CDE_sum:                ;           B == 0 or E == 0
    add  HL, DE         ; 1:11      HL += DE
CDE_turn:
    sla   E             ; 2:8
    rl    D             ; 2:8       next turn --> 2xDE
    srl   C             ; 2:8       check 0. bit
    jr    c, CDE_sum    ; 2:7/12
    jp   nz, CDE_turn   ; 3:10

    ret                 ; 1:10

BCD0_begin:
    ld    A, D          ; 1:4
    srl   C             ; 2:8       check 0. bit
    jp   nc, BCD0_turn  ; 3:10

BCD0_sum:
    ld    D, A          ; 1:4
    add  HL, DE         ; 1:11      HL += D0
BCD0_turn:
    add   A, A          ; 1:4       next turn --> 2xA0
    srl   C             ; 2:8       check 0. bit
    jr    c, BCD0_sum   ; 2:7/12
    jp   nz, BCD0_turn  ; 3:10
    
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{test5},{
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[62:cca 501-593] test5 version
    xor   A             ; 1:4       A = 0 = 256sum
    ld    B, H          ; 1:4
    ld    C, L          ; 1:4
    ld    H, A          ; 1:4
    ld    L, A          ; 1:4       HL = 0 = result BC*DE

    srl   B             ; 2:8       check 8. bit
    jp   nc, $+4        ; 3:10
    add   A, E          ; 1:4       + 256x

    jr    z, CDE_begin  ; 2:7/12    B == 0 or E == 0
    
    srl   C             ; 2:8       check 0. bit
    jp   nc, BCDE_turn  ; 3:10

BCDE_sum:
    add  HL, DE         ; 1:11      HL += DE
BCDE_turn:
    sla   E             ; 2:8
    rl    D             ; 2:8       next turn --> 2xDE
    
    srl   B             ; 2:8       check 8. bit
    jp   nc, $+4        ; 3:10
    add   A, E          ; 1:4       + 256x
    
    srl   C             ; 2:8       check 0. bit
    jr    c, BCDE_sum   ; 2:7/12
    jp   nz, BCDE_turn  ; 3:10

; fall into B0DE

DB 0x0E                 ; 2:7       ld C, 0x85
B0DE_256x:
    add   A, E          ; 1:4       + 256x

B0DE_turn:
    sla   E             ; 2:8       next turn --> 2xE

    srl   B             ; 2:8       check 8. bit
    jr    c, B0DE_256x  ; 2:7/12
    jr   nz, B0DE_turn  ; 2:7/12

    add   A, H          ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10
    
CDE_sum:                ;           B == 0 or E == 0
    add  HL, DE         ; 1:11      HL += DE
CDE_turn:
    sla   E             ; 2:8
    rl    D             ; 2:8       next turn --> 2xDE
CDE_begin:
    srl   C             ; 2:8       check 0. bit
    jr    c, CDE_sum    ; 2:7/12
    jp   nz, CDE_turn   ; 3:10

    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{test6},{
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[45:cca 517-580] test6 version
    ld    B, H          ; 1:4
    ld    C, L          ; 1:4
    ld   HL, 0x000      ; 3:10      HL = 0 = result BC*DE

    srl   B             ; 2:8       check 8. bit
    sbc   A, A          ; 1:4       0x00 or 0xff
    and   E             ; 1:4       0x00 or E

    srl   C             ; 2:8       check 0. bit
    jp   nc, BCDE_turn  ; 3:10

BCDE_sum:
    add  HL, DE         ; 1:11      HL += DE
BCDE_turn:
    sla   E             ; 2:8
    rl    D             ; 2:8       next turn --> 2xDE
    
    srl   B             ; 2:8       check 8. bit
    jp   nc, $+4        ; 3:10
    add   A, E          ; 1:4       + 256x
    
    srl   C             ; 2:8       check 0. bit
    jr    c, BCDE_sum   ; 2:7/12
    jp   nz, BCDE_turn  ; 3:10

; fall into B0DE

DB 0x0E                 ; 2:7       ld C, 0x85
B0DE_256x:
    add   A, E          ; 1:4       + 256x

B0DE_turn:
    sla   E             ; 2:8       next turn --> 2xE

    srl   B             ; 2:8       check 8. bit
    jr    c, B0DE_256x  ; 2:7/12
    jr   nz, B0DE_turn  ; 2:7/12

    add   A, H          ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{test7},{
; Pollutes: AF, BC, DE
MULTIPLY:
                        ;[42:632-???] test7 version
   
    ld    C, D          ; 1:4       HL = HL*DE --> HL*CA = HL*A + 256*C*L
    ld    A, E          ; 1:4       DE --> CA check bits
    ld    D, H          ; 1:4
    ld    E, L          ; 1:4       DE = base 1x

    ld    B, 0x08       ; 2:7       HL=HL*A
MULTIPLY_A:
    add   A, A          ; 1:4       check E bits
    jr    c, MULTIPLY_DE; 2:7/12
    djnz MULTIPLY_A     ; 2:8/13
    
    ld    H, A          ; 1:4
    ld    L, A          ; 1:4       HL = 0
    jp   MULTIPLY_E0    ; 3:10
    
MULTIPLY_LO:
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4       check E bits
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
MULTIPLY_DE:
    djnz MULTIPLY_LO    ; 2:8/13

MULTIPLY_E0:            ;           A = 0

    sla   C             ; 2:8       check original D 7 bit
    jr   nc, $+3        ; 2:7/12
    add   A, E          ; 1:4       add original L
    ret   z             ; 1:5/11    (D == 0 || C == 0) --> zero flag --> HL = HL*E
    
    ld    B, 0x07       ; 2:7
MULTIPLY_HI:
    add   A, A          ; 1:4
    sla   C             ; 2:8       check original D 6-->0 bit
    jr   nc, $+3        ; 2:7/12
    add   A, E          ; 1:4       add original L
    djnz MULTIPLY_HI    ; 2:8/13

    add   A, H          ; 1:4    
    ld    H, A          ; 1:4
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
{
; Pollutes: AF, B, DE
MULTIPLY:
                        ;[42:cca 593-757] # default version can be changed with "define({name})", name=fast,small,test,test2,...
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jr    c, $+3        ; 2:7/12
    ex   DE, HL         ; 1:4       H=>D faster 7+4<12

    ld    B, H          ; 1:4       
    ld    A, L          ; 1:4
    ld   HL, 0x0000     ; 3:10 

    srl   B             ; 2:8
    rra                 ; 1:4       divide old HL by 2, zero flag unaffected
    jr   nc, $+3        ; 2:7/12
MUL_LOOP:
    add  HL, DE         ; 1:11
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2    
    srl   B             ; 2:8
    rra                 ; 1:4       divide old HL by 2, zero flag unaffected
    jr    c, MUL_LOOP   ; 2:7/12
    jp   nz, MUL_LOOP+1 ; 3:10      B = ?

    db   0x06           ; 2:7       ld B, 0x19 --> ignores the first add HL,DE
MUL_LOOP2:
    add  HL, DE         ; 1:11
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide old HL by 2, zero flag unaffected
    jr    c, MUL_LOOP2  ; 2:7/12
    jp   nz, MUL_LOOP2+1; 3:10      A = ?

    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
ifdef({USE_DIV},{ifdef({USE_UDIV},,define({USE_UDIV},{}))

; Divide 16-bit signed values (with 16-bit result)
; In: DE / HL
; Out: HL = DE / HL, DE = DE % abs(HL)
DIVIDE:
    ld    A, H          ; 1:4
    xor   D             ; 1:4
    push AF             ; 1:11      div output sign
    
    ld    A, D          ; 1:4
    add   A, A          ; 1:4
    push AF             ; 1:11      mod output sign    
    jr   nc, $+8        ; 2:7/12    
    xor   A             ; 1:4
    sub   E             ; 1:4
    ld    E, A          ; 1:4
    sbc   A, D          ; 1:4
    sub   E             ; 1:4
    ld    D, A          ; 1:4

    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    jr   nc, $+8        ; 2:7/12
    xor   A             ; 1:4
    sub   L             ; 1:4
    ld    L, A          ; 1:4
    sbc   A, H          ; 1:4
    sub   L             ; 1:4
    ld    H, A          ; 1:4

    call UDIVIDE        ; 3:17
    
    pop  AF             ; 1:10      mod output sign    
    jr   nc, $+8        ; 2:7/12
    xor   A             ; 1:4
    sub   E             ; 1:4
    ld    E, A          ; 1:4
    sbc   A, D          ; 1:4
    sub   E             ; 1:4
    ld    D, A          ; 1:4
    
    pop  AF             ; 1:10      div output sign
    ret  p              ; 1:5/11
    
    xor   A             ; 1:4
    sub   L             ; 1:4
    ld    L, A          ; 1:4
    sbc   A, H          ; 1:4
    sub   L             ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10}){}dnl
dnl
dnl
dnl
ifdef({USE_UDIV},{

; Divide 16-bit unsigned values (with 16-bit result)
; In: DE / HL
; Out: HL = DE / HL, DE = DE % HL
UDIVIDE:{}ifelse(TYPDIV,{old_fast},{
                        ;           old_fast version
    ex   DE, HL         ; 1:4       HL/DE
    ld    A, D          ; 1:4
    or    A             ; 1:4
    jp   nz, UDIVIDE_16 ; 3:10      HL/0E
        
    sla   H             ; 2:8       AHL = 0HL
    jr    c, UDIVIDE1   ; 2:7/12
    jr    z, UDIVIDE_8H ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE2   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE3   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE4   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE5   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE6   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE7   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE8   ; 2:7/12
UDIVIDE_8H:
    sla   L             ; 2:8
    jr    c, UDIVIDE9   ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE10  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE11  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE12  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE13  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE14  ; 2:7/12
    sla   L             ; 2:8
    jp    c, UDIVIDE15  ; 3:10
    sla   L             ; 2:8
    jp    c, UDIVIDE16  ; 3:10

    ld    E, D          ; 1:4
    ret                 ; 1:10

;1
UDIVIDE1:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;2
    sla   H             ; 2:8
UDIVIDE2:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;3
    sla   H             ; 2:8
UDIVIDE3:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;4
    sla   H             ; 2:8
UDIVIDE4:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;5
    sla   H             ; 2:8
UDIVIDE5:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;6
    sla   H             ; 2:8
UDIVIDE6:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;7
    sla   H             ; 2:8
UDIVIDE7:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;8
    sla   H             ; 2:8
UDIVIDE8:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4

;9
    sla   L             ; 2:8
UDIVIDE9:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;10
    sla   L             ; 2:8
UDIVIDE10:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;11
    sla   L             ; 2:8
UDIVIDE11:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;12
    sla   L             ; 2:8
UDIVIDE12:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;13
    sla   L             ; 2:8
UDIVIDE13:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;14
    sla   L             ; 2:8
UDIVIDE14:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;15
    sla   L             ; 2:8
UDIVIDE15:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;16
    sla   L             ; 2:8
UDIVIDE16:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4

    ld    E, A          ; 1:4       DE = DE % HL
    ret                 ; 1:10

UDIVIDE_16:             ;           DE >= 256
    ld    A, L          ; 1:4
    ld    L, H          ; 1:4
    ld    H, 0x00       ; 2:7       00HL --> 0HLA 

;1 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;2 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;3 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;4 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;5 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;6 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;7 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;8 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

    rla                 ; 1:4
    cpl                 ; 1:4
    ex   DE, HL         ; 1:4
    ld    H, 0x00       ; 2:7
    ld    L, A          ; 1:4
    ret                 ; 1:10},
TYPDIV,{old},
{
                        ;           old version
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, D          ; 1:4
    or    A             ; 1:4
    jr   nz, UDIVIDE_16 ; 2:7/12
        
    ld    B, 16         ; 2:7     
    add  HL, HL         ; 1:11      2*HL
    jr    c, $+7        ; 2:7/12
    djnz $-3            ; 2:13/8

    ld    E, A          ; 1:4       DE = 0 % 0E = 0
    ret                 ; 1:10      HL = 0 / 0E = 0
    
    add  HL, HL         ; 1:11      2*HL
    rla                 ; 1:4
    jr    c, $+5        ; 2:7/12    fix 256 / 129..255
    cp    E             ; 1:4
    jr    c, $+4        ; 2:7/12
    inc   L             ; 1:4
    sub   E             ; 1:4
    djnz $-9            ; 2:13/8

    ld    E, A          ; 1:4       DE = DE % HL
    ret                 ; 1:10      HL = DE / HL
    
UDIVIDE_16:             ;           HL/256+
    ld    A, L          ; 1:4
    ld    L, H          ; 1:4
    ld    H, 0x00       ; 2:7       HLA = 0HL 
    ld    B, 0x08       ; 2:7
        
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    djnz $-8            ; 2:8/13
    
    rla                 ; 1:4
    cpl                 ; 1:4
    ex   DE, HL         ; 1:4
    ld    H, B          ; 1:4
    ld    L, A          ; 1:4
    ret                 ; 1:10},
TYPDIV,{fast},
{    
    ld    A, H          ; 1:4       fast version
    or    L             ; 1:4       HL = DE / HL
    ret   z             ; 1:5/11    HL = DE / 0
    ld   BC, 0x00FF     ; 3:10
if 1
    ld    A, D          ; 1:4       
UDIVIDE_LE:    
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11   
    jr    c, UDIVIDE_GT ; 2:7/12
    cp    H             ; 1:4       
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE
else
UDIVIDE_LE:    
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11   
    jr    c, UDIVIDE_GT ; 2:7/12
    ld    A, H          ; 1:4       
    sub   D             ; 1:4
    jp    c, UDIVIDE_LE ; 3:10
    jp   nz, UDIVIDE_GT ; 3:10
    ld    A, E          ; 1:4
    sub   L             ; 1:4
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE
endif
UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0xFFFF = inverted result
;1    
    rr    D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;2
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;3
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;4
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;5
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;6
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;7
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;8
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12

UDIVIDE_LOOP:
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    rl    C             ; 2:8
    djnz UDIVIDE_LOOP   ; 2:8/13    B--

    ex   DE, HL         ; 1:4
    cpl                 ; 1:4
    ld    L, A          ; 1:4
    ld    A, C          ; 1:4
    cpl                 ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10
    
UDIVIDE_END:
    ex   DE, HL         ; 1:4
    cpl                 ; 1:4
    ld    L, A          ; 1:4
    ld    H, B          ; 1:4
    ret                 ; 1:10},
TYPDIV,{small},{
    ld    A, H          ; 1:4       small version
    or    L             ; 1:4       HL = DE / HL
    ret   z             ; 1:5/11    HL = DE / 0
    ld   BC, 0x0000     ; 3:10
    ld    A, D          ; 1:4       
UDIVIDE_LE:    
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11   
    jr    c, UDIVIDE_GT ; 2:7/12
    cp    H             ; 1:4
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE
UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0x0000 = result
UDIVIDE_LOOP:
    rr    D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    ccf                 ; 1:4       inverts carry flag
    adc   A, A          ; 1:4
    rl    C             ; 2:8
    djnz UDIVIDE_LOOP   ; 2:8/13    B--
    
    ex   DE, HL         ; 1:4    
    ld    L, A          ; 1:4
    ld    H, C          ; 1:4
    ret                 ; 1:10},
TYPDIV,{synthesis},
{    
    ld    A, H          ; 1:4       synthesis version
    or    A             ; 1:4
    jr    z, UDIVIDE_0L ; 2:7/12        
    
    ld   BC, 0x0000     ; 3:10
    ld    A, D          ; 1:4
UDIVIDE_LE:    
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11   
    jr    c, UDIVIDE_GT ; 2:7/12
    cp    H             ; 1:4
    jp   nc, UDIVIDE_LE ; 3:10
UDIVIDE_NC:             ;
    or    A             ; 1:4       HL > DE

UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0x0000 = result
UDIVIDE_LOOP:
    rr    D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    ccf                 ; 1:4       inverts carry flag
    adc   A, A          ; 1:4
    rl    C             ; 2:8
    djnz UDIVIDE_LOOP   ; 2:8/13    B--
    
    ex   DE, HL         ; 1:4    
    ld    L, A          ; 1:4
    ld    H, C          ; 1:4
    ret                 ; 1:10

UDIVIDE_0L:             ;           HL = DE / 0L
    cp    L             ; 1:4
    ret   z             ; 1:5/11    HL = DE / 0
if 1
    ld    A, E          ; 1:4
    sub   L             ; 1:4
    ld    A, D          ; 1:4
    sbc   A, H          ; 1:4
    jr    c, UDIVIDE_Z  ; 1:7/12

    ld    A, D          ; 1:4
    cp    L             ; 1:4
    jr    c, UDIVIDE_LO ; 2:7/12
    xor   A             ; 1:4
else
    cp    D             ; 1:4
    jr    z, UDIVIDE_LO ; 2:7/12
endif
    ld    B, 0x04       ; 2:7
UDIVIDE_D:
    sla   D             ; 2:8
    rla                 ; 1:4       AD << 1
    cp    L             ; 1:4       A-L?
    jr    c,$+4         ; 2:7/12
    sub   L             ; 1:4
    inc   D             ; 1:4
    
    sla   D             ; 2:8
    rla                 ; 1:4       AD << 1
    cp    L             ; 1:4       A-L?
    jr    c,$+4         ; 2:7/12
    sub   L             ; 1:4
    inc   D             ; 1:4
    djnz UDIVIDE_D      ; 2:8/13    B--

    ld    H, D          ; 1:4
    
UDIVIDE_LO:
    ld    B, 0x04       ; 2:7
UDIVIDE_E:
    sla   E             ; 2:8
    rla                 ; 1:4       AE << 1
    jr    c, $+5        ; 2:7/12
    cp    L             ; 1:4       A-L?
    jr    c, $+4        ; 2:7/12
    sub   L             ; 1:4
    inc   E             ; 1:4

    sla   E             ; 2:8
    rla                 ; 1:4       AE << 1
    jr    c, $+5        ; 2:7/12
    cp    L             ; 1:4       A-L?
    jr    c, $+4        ; 2:7/12
    sub   L             ; 1:4
    inc   E             ; 1:4
    djnz UDIVIDE_E      ; 2:8/13    B--
    
    ld    L, E          ; 1:4       HL = DE / HL
    ld    D, B          ; 1:4
    ld    E, A          ; 1:4       DE = DE % HL
    ret                 ; 1:10
UDIVIDE_Z:
    ld    L, H          ; 1:4
    ret                 ; 1:10},
{
    ld    A, H          ; 1:4       default version
    or    L             ; 1:4       HL = DE / HL
    ret   z             ; 1:5/11    HL = DE / 0?
    
    ld   BC, 0x0000     ; 3:10
if 0
UDIVIDE_LE:    
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11   
    jr    c, UDIVIDE_GT ; 2:7/12
    ld    A, H          ; 1:4       
    sub   D             ; 1:4
    jp    c, UDIVIDE_LE ; 3:10
    jp   nz, UDIVIDE_GT ; 3:10
    ld    A, E          ; 1:4
    sub   L             ; 1:4
else
    ld    A, D          ; 1:4
UDIVIDE_LE:    
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11   
    jr    c, UDIVIDE_GT ; 2:7/12
    cp    H             ; 1:4
endif
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE

UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0x0000 = result
UDIVIDE_LOOP:
    rr    D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    ccf                 ; 1:4       inverts carry flag
    adc   A, A          ; 1:4
    rl    C             ; 2:8
    djnz UDIVIDE_LOOP   ; 2:8/13    B--
    
    ex   DE, HL         ; 1:4    
    ld    L, A          ; 1:4
    ld    H, C          ; 1:4
    ret                 ; 1:10})}){}dnl
dnl
dnl
dnl
dnl
ifdef({USE_Random},{ifdef({USE_Rnd},,define({USE_Rnd},{}))
; ( max -- rand )
; 16-bit pseudorandom generator
; HL = random < max, or HL = 0
Random:
    ld    A, H          ; 1:4
    or    A             ; 1:4
    jr    z, Random_H0  ; 2:7/11
    
    ld    C, 0xFF       ; 2:7
    xor   A             ; 1:4
    adc   A, A          ; 1:4
    cp    H             ; 1:4
    jr    c, $-2        ; 2:7/11
    ld    B, A          ; 1:4       BC = mask = 0x??FF
    jr   Random_Begin   ; 2:12
    
Random_H0:
    ld    B, A          ; 1:4
    or    L             ; 1:4
    ret   z             ; 1:5/11

    xor   A             ; 1:4
    adc   A, A          ; 1:4
    cp    L             ; 1:4
    jr    c, $-2        ; 2:7/11
    ld    C, A          ; 1:4       BC = mask = 0x00??
    
Random_Begin:
    push  DE            ; 1:11
    ex    DE, HL        ; 1:4
Random_new:
    call Rnd            ; 3:17
    
    ld    A, C          ; 1:4
    and   L             ; 1:4
    ld    L, A          ; 1:4
    ld    A, B          ; 1:4
    and   H             ; 1:4
    ld    H, A          ; 1:4
    
    sbc  HL, DE         ; 2:15
    jr   nc, Random_new ; 2:7/11
    
Rnd_Exit:
    add  HL, DE         ; 1:11
    pop  DE             ; 1:10
    ret                 ; 1:10}){}dnl
dnl
dnl
dnl
ifdef({USE_Rnd},{
; ( -- rand )
; 16-bit pseudorandom generator
; Out: HL = 0..65535
Rnd:
SEED EQU $+1
    ld   HL, 0x0001     ; 3:10      seed must not be 0
    ld    A, H          ; 1:4
    rra                 ; 1:4
    ld    A, L          ; 1:4
    rra                 ; 1:4
    xor   H             ; 1:4
    ld    H, A          ; 1:4       xs ^= xs << 7;
    rra                 ; 1:4
    xor   L             ; 1:4
    ld    L, A          ; 1:4       xs ^= xs >> 9;
    xor   H             ; 1:4
    ld    H, A          ; 1:4       xs ^= xs << 8;
    ld  (SEED), HL      ; 3:16

Rnd_8a EQU $+1
    ld    A, 0x01       ; 2:7
    rrca                ; 1:4       multiply by 32
    rrca                ; 1:4
    rrca                ; 1:4
    xor  0x1F           ; 2:7
Rnd_8b EQU $+1
    add   A, 0x01       ; 2:7
    sbc   A, 0xFF       ; 1:4       carry
    ld  (Rnd_8a), A     ; 3:13
    ld  (Rnd_8b), A     ; 3:13
    
    xor   H             ; 1:4
    ld    H, A          ; 1:4
    ld    A, R          ; 2:9
    xor   L             ; 1:4
    ld    L, A          ; 1:4
    ret                 ; 1:10}){}dnl
dnl
dnl
dnl
dnl
ifdef({USE_KEY},{
; Read key from keyboard
; In: 
; Out: push stack, TOP = HL = key
READKEY:
    ex   DE, HL         ; 1:4       readkey
    ex  (SP),HL         ; 1:19      readkey
    push HL             ; 1:11      readkey
    ld   BC, 0x5C08     ; 3:10      readkey {ZX Spectrum LAST K} system variable
    xor   A             ; 1:4       readkey
    ld    H, A          ; 1:4       readkey
    ld  (BC),A          ; 1:7       readkey
    ld    A,(BC)        ; 1:7       readkey read new value of {LAST K}
    cp    H             ; 1:4       readkey is it still zero?
    jr    z, $-2        ; 2:7/12    readkey
    ld    L, A          ; 1:4       readkey
    ret                 ; 1:10      readkey}){}dnl
dnl
dnl
dnl
ifdef({USE_ACCEPT},{
; Read string from keyboard
; In: DE = addr, HL = length 
; Out: 2x pop stack, TOP = HL = loaded
READSTRING:
    ld    B, D          ; 1:4       readstring
    ld    C, E          ; 1:4       readstring BC = addr
    ex   DE, HL         ; 1:4       readstring 
READSTRING2:
    xor   A             ; 1:4       readstring
    ld    (0x5C08),A    ; 3:13      readstring {ZX Spectrum LAST K} system variable
    
    ld    A,(0x5C08)    ; 3:13      readstring read new value of {LAST K}
    or    A             ; 1:4       readstring is it still zero?
    jr    z, $-4        ; 2:7/12    readstring

    cp  0x0D            ; 2:7       readstring enter?
    jr    z, READSTRING3; 2:7/12    readstring
    ld  (HL),A          ; 1:7       readstring
    inc  HL             ; 1:6       readstring
    dec  DE             ; 1:6       readstring
    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A    
    ld    A, D          ; 1:4       readstring
    or    E             ; 1:4       readstring
    jr   nz, READSTRING2; 2:7/12    readstring
READSTRING3:
    or    A             ; 1:4       readstring
    sbc  HL, BC         ; 2:15      readstring
    
    pop  BC             ; 1:10      readstring ret
    pop  DE             ; 1:10      readstring
    push BC             ; 1:11      readstring ret
    ret                 ; 1:10      readstring}){}dnl
dnl
dnl
ALL_VARIABLE
STRING_SECTION:
define({STRING_POP},{STRING_STACK{}popdef({STRING_STACK})})ALL_STRING_STACK
dnl
dnl
