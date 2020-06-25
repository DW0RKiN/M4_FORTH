    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000
    exx
    
    call fib2a_bench    ; 3:17      scall
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   


    
;   ---  b e g i n  ---
fib2a_bench:            ;           ( -- )
        

    exx                 ; 1:4       xdo(1000,0) 101
    dec  HL             ; 1:6       xdo(1000,0) 101
    ld  (HL),high 0     ; 2:10      xdo(1000,0) 101
    dec   L             ; 1:4       xdo(1000,0) 101
    ld  (HL),low 0      ; 2:10      xdo(1000,0) 101
    exx                 ; 1:4       xdo(1000,0) 101 R:( -- 0 )
xdo101:                 ;           xdo(1000,0) 101 
            

    exx                 ; 1:4       xdo(20,0) 102
    dec  HL             ; 1:6       xdo(20,0) 102
    ld  (HL),high 0     ; 2:10      xdo(20,0) 102
    dec   L             ; 1:4       xdo(20,0) 102
    ld  (HL),low 0      ; 2:10      xdo(20,0) 102
    exx                 ; 1:4       xdo(20,0) 102 R:( -- 0 )
xdo102:                 ;           xdo(20,0) 102 
    exx                 ; 1:4       index xi 102
    ld    E,(HL)        ; 1:7       index xi 102
    inc   L             ; 1:4       index xi 102
    ld    D,(HL)        ; 1:7       index xi 102
    push DE             ; 1:11      index xi 102
    dec   L             ; 1:4       index xi 102
    exx                 ; 1:4       index xi 102 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 102
    ex  (SP),HL         ; 1:19      index xi 102 ( -- x ) 
    push DE             ; 1:11
    ld    B, L          ; 1:4
    ld    C, H          ; 1:4       CB = counter
    ld   HL, 0x0000     ; 3:10
    ld   DE, 0x0001     ; 3:10
    inc   C             ; 1:4
    inc   B             ; 1:4
    dec   B             ; 1:4
    jr    z, $+6        ; 2:7/12    
    ex   DE, HL         ; 1:4
    add  HL, DE         ; 1:11      +
    djnz $-2            ; 2:13/8
    dec  C              ; 1:4
    jr  nz, $-5         ; 2:12/7
    pop  DE             ; 1:10 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    exx                 ; 1:4       xloop(20,0) 102
    ld    E,(HL)        ; 1:7       xloop(20,0) 102
    inc   L             ; 1:4       xloop(20,0) 102
    ld    D,(HL)        ; 1:7       xloop(20,0) 102
    inc  DE             ; 1:6       xloop(20,0) 102 index++
    ld    A, low 20     ; 2:7       xloop(20,0) 102
    xor   E             ; 1:4       xloop(20,0) 102
    jr   nz, $+7        ; 2:7/12    xloop(20,0) 102
    ld    A, high 20    ; 2:7       xloop(20,0) 102
    xor   D             ; 1:4       xloop(20,0) 102
    jr    z, xleave102  ; 2:7/12    xloop(20,0) 102 exit
    ld  (HL), D         ; 1:7       xloop(20,0) 102
    dec   L             ; 1:4       xloop(20,0) 102
    ld  (HL), E         ; 1:6       xloop(20,0) 102
    exx                 ; 1:4       xloop(20,0) 102
    jp   xdo102         ; 3:10      xloop(20,0) 102
xleave102:              ;           xloop(20,0) 102
    inc  HL             ; 1:6       xloop(20,0) 102
    exx                 ; 1:4       xloop(20,0) 102 R:( index -- )
xexit102 EQU $
        
    exx                 ; 1:4       xloop(1000,0) 101
    ld    E,(HL)        ; 1:7       xloop(1000,0) 101
    inc   L             ; 1:4       xloop(1000,0) 101
    ld    D,(HL)        ; 1:7       xloop(1000,0) 101
    inc  DE             ; 1:6       xloop(1000,0) 101 index++
    ld    A, low 1000   ; 2:7       xloop(1000,0) 101
    xor   E             ; 1:4       xloop(1000,0) 101
    jr   nz, $+7        ; 2:7/12    xloop(1000,0) 101
    ld    A, high 1000  ; 2:7       xloop(1000,0) 101
    xor   D             ; 1:4       xloop(1000,0) 101
    jr    z, xleave101  ; 2:7/12    xloop(1000,0) 101 exit
    ld  (HL), D         ; 1:7       xloop(1000,0) 101
    dec   L             ; 1:4       xloop(1000,0) 101
    ld  (HL), E         ; 1:6       xloop(1000,0) 101
    exx                 ; 1:4       xloop(1000,0) 101
    jp   xdo101         ; 3:10      xloop(1000,0) 101
xleave101:              ;           xloop(1000,0) 101
    inc  HL             ; 1:6       xloop(1000,0) 101
    exx                 ; 1:4       xloop(1000,0) 101 R:( index -- )
xexit101 EQU $
    
fib2a_bench_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


VARIABLE_SECTION:

STRING_SECTION:

