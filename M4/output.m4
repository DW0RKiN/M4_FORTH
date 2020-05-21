dnl ## Runtime enviroment
dnl
dnl
ifdef({USE_DOT},{
; Input: A = or numbers, DE string index, HL = number, BC = {10000,1000,100,10,1}
; Output: Write number to memory
; Pollutes: AF, AF', HL, B, DE
NEXTNUMBER:
    ex   AF, AF'        ; 1:4
    xor   A             ; 1:4

    inc   A             ; 1:4
    sbc  HL, BC         ; 2:15
    jr   nc, $-3        ; 2:7/12
    
    add  HL, BC         ; 1:11
    dec   A             ; 1:4
    ld    B, A          ; 1:4    
    add   A, '0'        ; 2:7       0   
    ex   AF, AF'        ; 1:4
    
    or    B             ; 1:4
    ret   z             ; 1:5/11    zatim same nuly
    
    ex   AF, AF'        ; 1:4
    ld  (DE), A         ; 1:7
    inc  DE             ; 1:6
    ex   AF, AF'        ; 1:4
    ret                 ; 1:10

; Input: HL
; Output: Print decimal number in HL
; Pollutes: AF, AF', BC, delete top stack
PRINT_NUM:
    push DE             ; 1:11

    ld   DE, STRNUM     ; 3:10

    bit   7, H          ; 2:8
    jr    z, PRINT_NUM_P; 2:7/12
    
    ld    A, '-'        ; 2:7
    ld  (DE), A         ; 1:7
    inc  DE             ; 1:6

    ld    A, L          ; 1:4
    cpl                 ; 1:4
    ld    L, A          ; 1:4
    ld    A, H          ; 1:4
    cpl                 ; 1:4
    ld    H, A          ; 1:4
    inc  HL             ; 1:6
PRINT_NUM_P:
    
    xor   A             ; 1:4
    ld   BC, 10000      ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld   BC, 1000       ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld   BC, 100        ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld   BC, 10         ; 3:10
    call NEXTNUMBER     ; 3:17
    
    ld    A, '0'        ; 2:7
    add   A, L          ; 1:4
    ld  (DE), A         ; 1:7
    
    ex   DE, HL         ; 1:4
    
    inc  HL             ; 1:6
    ld  (HL), 0x20      ; 2:10      space after
    
    ld   DE, STRNUM     ; 3:10
    sbc  HL, DE         ; 2:15
    push HL             ; 1:11
            
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    
    pop  BC             ; 1:10      Length-1 of string to print
    ld   DE, STRNUM     ; 3:10      Address of string
    call 0x2040         ; 3:17      Print our string

    pop  HL             ; 1:10      last DE
    pop  BC             ; 1:10      ret
    pop  DE             ; 1:10
    push BC             ; 1:11      ret
    ret                 ; 1:10
STRNUM:
DB      "Dw0rkin"},{})dnl
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
    push DE             ; 1:11      Address of string
    push HL             ; 1:11      Length of string to print

    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    
    pop  BC             ; 1:10      Length of string to print
    pop  DE             ; 3:10      Address of string
    call 0x203C         ; 3:17      Print our string
    ret                 ; 1:10})dnl
dnl
dnl
dnl
ifdef({USE_UMUL},{
; Input: HL,DE
; Output: HL=HL*DE
; Pollutes: AF, DE
UMULTIPLY:
    ld    A, H          ; 1:4
    or    A             ; 1:4
    jr    z, MUL_DEgr   ; 2:7/12

    ld    A, D          ; 1:4
    or    A             ; 1:4
    jr    z, MUL_HLgr   ; 2:7/12
    
;   overflow
    ld   HL, 32767      ; 3:10
    ret                 ; 1:10

MUL_HLgr:
    ex   DE, HL         ; 1:4
MUL_DEgr:
;     HL=DE*HL==DE*0L

    ld    A, L          ; 1:4
    ld    L, H          ; 1:4       HL = 0 
    
MUL_LOOP:
    srl   A             ; 2:8       divide A by 2
    jr   nc,$+3         ; 2:7/12
    add  HL,DE          ; 1:11

    sla   E             ; 2:8
    rl    D             ; 2:8       multiply DE by 2
    
    or    A             ; 1:4
    jr   nz,MUL_LOOP    ; 2:7/12
    
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
ALL_STRING_STACK
dnl
dnl
