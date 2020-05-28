dnl ## Runtime enviroment
dnl
dnl
ifdef({USE_DOT},{ifdef({USE_UDOT},,define({USE_UDOT},{}))
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, AF', BC, DE, HL = DE, DE = (SP)
PRINT_NUM:
    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    jr   nc, PRINT_UNUM ; 2:7/12
    
    xor   A             ; 1:4
    sub   L             ; 1:4
    ld    L, A          ; 1:4
    sbc   A, H          ; 1:4
    sub   L             ; 1:4
    ld    H, A          ; 1:4

    PUTCHAR(' ')
    PUTCHAR('-')
    
    push DE             ; 1:11
    jp   PRINT_UNUM+4   ; 3:10}){}dnl
dnl
dnl
ifdef({USE_UDOT},{
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, AF', BC, DE, HL = DE, DE = (SP)
PRINT_UNUM:
    push DE             ; 1:11

    PUTCHAR(' ')

    ld   DE, STRNUM     ; 3:10
    
    xor   A             ; 1:4
    ld   BC, -10000     ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld   BC, -1000      ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld   BC, -100       ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld   BC, -10        ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld    A, '0'        ; 2:7
    add   A, L          ; 1:4
    ld  (DE), A         ; 1:7
    
    ex   DE, HL         ; 1:4
    ld   DE, STRNUM     ; 3:10
    sbc  HL, DE         ; 2:15
    ld   B, H           ; 1:4
    ld   C, L           ; 1:4       Length-1 of string to print
    ld   DE, STRNUM     ; 3:10      Address of string
    call 0x2040         ; 3:17      Print our string

                        ; x x hl ret de --> hl de ret
    pop  HL             ; 1:10      previous DE
    pop  BC             ; 1:10      ret
    pop  DE             ; 1:10      previous (SP)
    push BC             ; 1:11      ret
    ret                 ; 1:10
STRNUM:
DB      "65536 "

; Input: A = or numbers, DE string index, HL = number, BC = {10000,1000,100,10,1}
; Output: Write number to memory
; Pollutes: AF, AF', HL, B, DE
NEXTNUMBER:
    ex   AF, AF'        ; 1:4
    ld   A, 0xFF        ; 2:7

    inc   A             ; 1:4
    add  HL, BC         ; 1:11
    jr    c, $-2        ; 2:7/12    
    
    sbc  HL, BC         ; 2:15
    ld    B, A          ; 1:4    
    add   A, '0'        ; 2:7       0   
    ex   AF, AF'        ; 1:4
    
    or    B             ; 1:4
    ret   z             ; 1:5/11    zatim same nuly
    
    ex   AF, AF'        ; 1:4
    ld  (DE), A         ; 1:7
    inc  DE             ; 1:6
    ex   AF, AF'        ; 1:4
    ret                 ; 1:10})dnl
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
    ret                 ; 1:10})dnl
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
    ret                 ; 1:10})dnl
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
    ret                 ; 1:10})})dnl
dnl
dnl
dnl

ifdef({USE_MUL},{
; Input: HL,DE
; Output: HL=HL*DE
; It does not matter whether it is signed or unsigned multiplication.
; Pollutes: AF, B, DE
MULTIPLY:   
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jr    c, $+3        ; 2:7/12
    ex   DE, HL         ; 1:4

    ld    B, H          ; 1:4       
    ld    A, L          ; 1:4
    ld   HL, 0x0000     ; 3:10 

    srl   B             ; 2:8
    rra                 ; 1:4       divide BA by 2
    jr   nc, $+3        ; 2:7/12
MUL_LOOP:
    add  HL, DE         ; 1:11
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2    
    srl   B             ; 2:8
    rra                 ; 1:4       divide BA by 2
    jr    c, MUL_LOOP   ; 2:7/12
    jp   nz, MUL_LOOP+1 ; 3:10      B = ?

    db   0x06           ; 2:7
MUL_LOOP2:
    add  HL, DE         ; 1:11
    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    srl   A             ; 2:8       divide A by 2
    jr    c, MUL_LOOP2  ; 2:7/12
    jp   nz, MUL_LOOP2+1; 3:10      A = ?

    ret                 ; 1:10})dnl
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
    ret                 ; 1:10})dnl
dnl
dnl
dnl
ifdef({USE_UDIV},{
; Divide 16-bit unsigned values (with 16-bit result)
; In: DE / HL
; Out: HL = DE / HL, DE = DE % HL
UDIVIDE:
    ex   DE, HL         ; 1:4
    ld    C, L          ; 1:4
    ld    A, H          ; 1:4
    ld   HL, 0x0000     ; 3:10
    or    A             ; 1:4
    jr    z, UDIVIDE_HI0; 2:7/12
    add   A, A          ; 1:4
    ld    B, 8          ; 2:7     
UDIVIDE_LO:
    rl    L             ; 2:8
    sbc  HL,DE          ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL,DE          ; 1:11      No Add 1
    rla                 ; 1:4
    djnz UDIVIDE_LO     ; 2:8/13
    
    cpl                 ; 1:4
UDIVIDE_HI0:
    ld    B, A          ; 1:4
    ld    A, C          ; 1:4
    ld    C, B          ; 1:4
    ld    B, 8          ; 2:7
UDIVIDE_HI:
    rla                 ; 1:4
    adc  HL,HL          ; 2:15
    sbc  HL,DE          ; 2:15
    jr   nc, $+3        ; 2:7/12    No Add 1
    add  HL,DE          ; 1:11
    djnz UDIVIDE_HI     ; 2:8/13
    
    rla                 ; 1:4
    cpl                 ; 1:4
    ex   DE, HL         ; 1:4
    ld    H, C          ; 1:4
    ld    L, A          ; 1:4
    ret                 ; 1:10})dnl
dnl
ALL_VARIABLE
STRING_SECTION:
define({STRING_POP},{STRING_STACK{}popdef({STRING_STACK})})ALL_STRING_STACK
dnl
dnl
