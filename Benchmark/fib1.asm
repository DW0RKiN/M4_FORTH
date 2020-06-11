    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000
    exx
    
    call fib1_bench     ; 3:17      scall
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   
    
;   ---  b e g i n  ---
fib1:                   ;           ( a -- b )
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
        
    ld    A, H          ; 1:4       dup 2 < if
    add   A, A          ; 1:4       dup 2 < if
    jr    c, $+11       ; 2:7/12    dup 2 < if    positive constant
    ld    A, L          ; 1:4       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    sub   low 2         ; 2:7       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    ld    A, H          ; 1:4       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    sbc   A, high 2     ; 2:7       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    jp   nc, else101    ; 3:10      dup 2 < if 
    ld   HL, 1          ; 3:10      drop 1 
    jp   fib1_end       ; 3:10      exit 
else101  EQU $          ;           = endif
endif101:
        
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )  
    dec  HL             ; 1:6       1- 
    call fib1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- ) 
        
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2- 
    call fib1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- ) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
fib1_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----
    
;   ---  b e g i n  ---
fib1_bench:             ;           ( -- )
        
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
    call fib1           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- ) 
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
    
fib1_bench_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


VARIABLE_SECTION:

STRING_SECTION:

