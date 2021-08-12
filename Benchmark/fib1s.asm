    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000      ; 3:10
    exx                 ; 1:4
    
    call fib1s_bench    ; 3:17      scall
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   
    
;   ---  the beginning of a data stack function  ---
fib1s:                  ;           ( a -- b )
        
    ld    A, H          ; 1:4       dup 2 < if
    add   A, A          ; 1:4       dup 2 < if
    jr    c, $+11       ; 2:7/12    dup 2 < if    positive constant
    ld    A, L          ; 1:4       dup 2 < if    HL<2 --> HL-2<0 --> carry if true
    sub   low 2         ; 2:7       dup 2 < if    HL<2 --> HL-2<0 --> carry if true
    ld    A, H          ; 1:4       dup 2 < if    HL<2 --> HL-2<0 --> carry if true
    sbc   A, high 2     ; 2:7       dup 2 < if    HL<2 --> HL-2<0 --> carry if true
    jp   nc, else101    ; 3:10      dup 2 < if 
    ld   HL, 1          ; 3:10      drop 1 
    ret                 ; 1:10      sexit 
else101  EQU $          ;           = endif
endif101:
        
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )  
    dec  HL             ; 1:6       1- 
    call fib1s          ; 3:17      scall 
        
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2- 
    call fib1s          ; 3:17      scall 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    
fib1s_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
    
;   ---  the beginning of a data stack function  ---
fib1s_bench:            ;           ( -- )
        
    push DE             ; 1:11      push(999)
    ex   DE, HL         ; 1:4       push(999)
    ld   HL, 999        ; 3:10      push(999) 
sfor101:                ;           sfor 101 ( index -- index )
            
    push DE             ; 1:11      push(19)
    ex   DE, HL         ; 1:4       push(19)
    ld   HL, 19         ; 3:10      push(19) 
sfor102:                ;           sfor 102 ( index -- index ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call fib1s          ; 3:17      scall 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    ld   A, H           ; 1:4       snext 102
    or   L              ; 1:4       snext 102
    dec  HL             ; 1:6       snext 102 index--
    jp  nz, sfor102     ; 3:10      snext 102
snext102:               ;           snext 102
    ex   DE, HL         ; 1:4       sfor unloop 102
    pop  DE             ; 1:10      sfor unloop 102
        
    ld   A, H           ; 1:4       snext 101
    or   L              ; 1:4       snext 101
    dec  HL             ; 1:6       snext 101 index--
    jp  nz, sfor101     ; 3:10      snext 101
snext101:               ;           snext 101
    ex   DE, HL         ; 1:4       sfor unloop 101
    pop  DE             ; 1:10      sfor unloop 101
    
fib1s_bench_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


VARIABLE_SECTION:

STRING_SECTION:

