    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000      ; 3:10
    exx                 ; 1:4
    
    call fib2a_bench    ; 3:17      scall
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   


    
;   ---  the beginning of a data stack function  ---
fib2a_bench:            ;           ( -- )
        

    ld   BC, 0          ; 3:10      xdo(1000,0) 101
    ld  (idx101),BC     ; 4:20      xdo(1000,0) 101
xdo101:                 ;           xdo(1000,0) 101 
            

    ld   BC, 0          ; 3:10      xdo(20,0) 102
    ld  (idx102),BC     ; 4:20      xdo(20,0) 102
xdo102:                 ;           xdo(20,0) 102 
    push DE             ; 1:11      index xi 102
    ex   DE, HL         ; 1:4       index xi 102
    ld   HL, (idx102)   ; 3:16      index xi 102 idx always points to a 16-bit index 
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
idx102 EQU $+1          ;           xloop 102 0 <= index < stop < 256
    ld    A, 0          ; 2:7       xloop 102
    nop                 ; 1:4       xloop 102 idx always points to a 16-bit index
    inc   A             ; 1:4       xloop 102 index++
    ld  (idx102),A      ; 3:13      xloop 102
    sub  low 20         ; 2:7       xloop 102
    jp    c, xdo102     ; 3:10      xloop 102 index-stop
xleave102:              ;           xloop 102
xexit102:               ;           xloop 102
        
idx101 EQU $+1          ;           xloop 101 index < stop && same sign
    ld   BC, 0x0000     ; 3:10      xloop 101 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 101 index++
    ld  (idx101),BC     ; 4:20      xloop 101 save index
    ld    A, C          ; 1:4       xloop 101
    sub  low 1000       ; 2:7       xloop 101 index - stop
    ld    A, B          ; 1:4       xloop 101
    sbc   A, high 1000  ; 2:7       xloop 101 index - stop
    jp    c, xdo101     ; 3:10      xloop 101
xleave101:              ;           xloop 101
xexit101:               ;           xloop 101
    
fib2a_bench_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


VARIABLE_SECTION:

STRING_SECTION:

