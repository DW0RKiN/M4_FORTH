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
; It does not matter whether it is signed or unsigned multiplication.
; Pollutes: AF, B, DE
MULTIPLY:{}ifelse(TYPMUL,{small},{
; small variant
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
    
    ret                 ; 1:10},TYPMUL,{fast},
{
; fast variant
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jr    c, $+3        ; 2:7/12
    ex   DE, HL         ; 1:4       H=>D faster 7+4<12
    
    ld    A, H          ; 1:4
    ld    C, L          ; 1:4
    ld   HL, 0x0000     ; 3:10
    
    add   A, A          ; 1:4
    jr    c, MULTIPLY1  ; 2:7/12
    jr    z, MULTIPLY_LO; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY2  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY3  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY4  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY5  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY6  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY7  ; 2:7/12    
    jp   MULTIPLY8      ; 3:10
MULTIPLY_LO:
    ld    A, C          ; 1:4
    add   A, A          ; 1:4
    jr    c, MULTIPLY9  ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY10 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY11 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY12 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY13 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY14 ; 2:7/12
    add   A, A          ; 1:4
    jr    c, MULTIPLY15 ; 2:7/12
    add   A, A          ; 1:4
    ret  nc             ; 1:5/11
    ex   DE, HL         ; 1:4
    ret                 ; 1:10

MULTIPLY1:
    ld    H, D          ; 1:4
    ld    L, E          ; 1:4
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY2:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY3:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY4:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY5:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY6:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY7:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY8:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    ld    A, C          ; 1:4
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY9:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY10:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY11:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY12:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY13:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY14:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
MULTIPLY15:
    add  HL, DE         ; 1:11
    add  HL, HL         ; 1:11
    add   A, A          ; 1:4
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11
    ret                 ; 1:10},
TYPMUL,{test},{
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
    jp   nz, MUL_LOOP2+1; 3:10
    ret                 ; 1:10},
TYPMUL,{test2},{
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
    ret                 ; 1:10},
{
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

    db   0x06           ; 2:7
MUL_LOOP2:
    add  HL, DE         ; 1:11
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide old HL by 2, zero flag unaffected
    jr    c, MUL_LOOP2  ; 2:7/12
    jp   nz, MUL_LOOP2+1; 3:10      A = ?

    ret                 ; 1:10})}){}dnl
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
UDIVIDE:{}ifelse(TYPDIV,{fast},{
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
    jr    c, $+5        ; 2:7/12
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
{
    ld    A, H          ; 1:4
    or    L             ; 1:4       HL = DE / HL
    ret   z             ; 1:5/11    HL = DE / 0
    ld    BC, 0x0000    ; 3:10
UDIVIDE_LE:    
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11   
    jr    c, UDIVIDE_GT ; 2:7/12
    ld    A, H          ; 1:4       
    sub   D             ; 1:4
    jr    c, UDIVIDE_LE ; 2:7/12
    jp   nz, UDIVIDE_GT ; 3:10
    ld    A, E          ; 1:4
    sub   L             ; 1:4
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE
UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0x0000
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
