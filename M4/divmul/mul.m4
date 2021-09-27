dnl ## multiplication
define({___},{})dnl
dnl
dnl
dnl
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
    jr    z, MULTIPLY_D ; 2:7/12    <-------------+
    add   A, A          ; 1:4                     |
    jr    c, MULTIPLY_E6; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E5; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E4; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E3; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E2; 2:7/12                  |
    add   A, A          ; 1:4
    jr    c, MULTIPLY_E1; 2:7/12                  |
    add   A, A          ; 1:4                     |
    jr    c, MULTIPLY_E0; 2:7/12    always carry -+
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
                        ;[35:577-623] # test7 version can be changed with "define({TYPMUL},{name})", name=fast,small,test,test2,...   
    ld    B, H          ; 1:4
    ld    C, L          ; 1:4       BC = HL

    xor   A             ; 1:4
    srl   L             ; 2:8       L /= 2 --> check carry
    jr   nc, MULTIPLY2  ; 2:7/12
MULTIPLY1:              ;           L*D loop
    add   A, D          ; 1:4       A += D*2^x
MULTIPLY2:
    sla   D             ; 2:8       D *= 2 
    srl   L             ; 2:8       L /= 2 --> check carry
    jr    c, MULTIPLY1  ; 2:7/12
    jp   nz, MULTIPLY2  ; 3:10      (L > 0)?
    
    ld    H, A          ; 1:4       HL = L*D, L = 0

    srl   E             ; 2:8       E /= 2 --> check carry
    jr   nc, MULTIPLY4  ; 2:7/12
MULTIPLY3:              ;           HL*E loop
    add  HL, BC         ; 1:11
MULTIPLY4:
    sla   C             ; 2:8
    rl    B             ; 2:8       BC *= 2

    srl   E             ; 2:8       E /= 2 --> check carry
    jr    c, MULTIPLY3  ; 2:7/12
    jp   nz, MULTIPLY4  ; 3:10      (E > 0)?
    
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{test8},{
; HL*DE = (H0+L)*(D0+E)= H0*D0 + H0*E + D0*L + L*E = 0 + H0*E + D0*L + L*E
; Pollutes: AF, C, DE
MULTIPLY:
                        ;[35:570-623] # test8 version can be changed with "define({TYPMUL},{name})", name=fast,small,test,test2,...   

    ld    C, L          ; 1:4
    ld    L, E          ; 1:4
    
    xor   A             ; 1:4
    srl   L             ; 2:8       E /= 2
    jr   nc, MULTIPLY2  ; 2:7/12        
MULTIPLY1:              ;           H*E loop
    add   A, H          ; 1:4       A += H*2^x
MULTIPLY2:
    sla   H             ; 2:8       H *= 2
    srl   L             ; 2:8       E /= 2
    jr    c, MULTIPLY1  ; 2:7/12
    jp   nz, MULTIPLY2  ; 3:10      (E > 0)?

    ld    H, A          ; 1:4       HL = D*L, L = 0

    srl   C             ; 2:8       E /= 2
    jr   nc, MULTIPLY4  ; 2:7/12
MULTIPLY3:              ;           L*DE
    add  HL, DE         ; 1:11
MULTIPLY4:
    sla   E             ; 2:8
    rl    D             ; 2:8       DE *= 2    

    srl   C             ; 2:8       L /= 2
    jr    c, MULTIPLY3  ; 2:7/12
    jp   nz, MULTIPLY4  ; 3:10      (L > 0)?
        
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{z88dk},{
; Pollutes: AF, C, DE
MULTIPLY:
                        ;[31:807-886] # z88dk version can be changed with "define({TYPMUL},{name})", name=fast,small,test,test2,...   

    inc   H             ; 1:4
    dec   H             ; 1:4
    jr    z, MULTIPLY_H0; 2:7/12        
    inc   D             ; 1:4
    dec   D             ; 1:4
    jr    z, MULTIPLY_D0; 2:7/12        
    ld    C, L          ; 1:4
    ld    A, H          ; 1:4
    ld    B, 0x10       ; 1:4       HL = HL * DE --> CA * DE
    jr    MULTIPLY2     ; 2:12        
MULTIPLY_D0:
    ex   DE, HL         ; 1:4
MULTIPLY_H0:
    ld    A, L          ; 1:4       HL = 0L * DE --> A * DE
    ld    B, 0x08       ; 1:4
MULTIPLY2:
    ld   HL, 0x0000     ; 3:10
MULTIPLY_B:
    add  HL, HL         ; 1:11
    sla   C             ; 2:8
    rla                 ; 1:4       AC *= 2
    jr   nc, $+3        ; 2:7/12        
    add  HL, DE         ; 1:11
    djnz MULTIPLY_B     ; 2:8/13 
        
    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY},
TYPMUL,{old_default},{
; Pollutes: AF, B, DE
MULTIPLY:
                        ;[42:cca 593-757] # old_default version can be changed with "define({TYPMUL},{name})", name=fast,small,test,test2,...
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
MULTIPLY_SIZE EQU  $-MULTIPLY},
{
; HL = HL*DE = H0*E + L*DE
; Pollutes: AF, C, DE
MULTIPLY:
                        ;[36:471-627] # default version can be changed with "define({TYPMUL},{name})", name=fast,small,test,test2,...   
    xor   A             ; 1:4
    ld    C, E          ; 1:4

    srl   H             ; 2:8       H /= 2
    jr   nc, $+3        ; 2:7/12        
MULTIPLY1:              ;           H0*0E
    add   A, C          ; 1:4       A += C(original E)

    sla   C             ; 2:8       C(original E) *= 2
    srl   H             ; 2:8       H /= 2
    jr    c, MULTIPLY1  ; 2:7/12
    jp   nz, MULTIPLY1+1; 3:10      H = ?

    ld    C, L          ; 1:4
    ld    L, H          ; 1:4       L = 0
    ld    H, A          ; 1:4       HL *= E

    srl   C             ; 2:8       C(original L) /= 2
    jr   nc, $+3        ; 2:7/12    
MULTIPLY2:              ;           0L*DE
    add  HL, DE         ; 1:11
    
    sla   E             ; 2:8
    rl    D             ; 2:8       DE *= 2    

    srl   C             ; 2:8       C(original L) /= 2
    jr    c, MULTIPLY2  ; 2:7/12
    jp   nz, MULTIPLY2+1; 3:10      C(original L) = ?

    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY}){}dnl
}){}dnl
dnl
dnl
dnl
