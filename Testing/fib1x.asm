    ORG 32768
    
;   ===  b e g i n  ===
    exx
    push HL
    push DE
    ld   HL, 35000
    exx
    
    call fib1_bench     ; 3:17      scall
    
    pop  DE
    pop  HL
    exx
    ret
;   =====  e n d  =====   
    
;   ---  b e g i n  ---
fib1x:                  ;           ( a -- b )
        
    ld    A, H          ; 1:4       dup 2 < if
    add   A, A          ; 1:4       dup 2 < if
    jr    c, $+11       ; 2:7/12    dup 2 < if    positive constant

    ld    A, L          ; 1:4       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    sub   low 2         ; 2:7       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    ld    A, H          ; 1:4       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    sbc   A, high 2     ; 2:7       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    jp   nc, else101    ; 3:10      dup 2 < if 
    ld   HL, 1          ; 3:10      drop_push(1) 
    ret                 ; 1:10      sexit 
else101  EQU $          ;           = endif
endif101:
        
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup  
    dec  HL             ; 1:6       1- 
    call fib1x          ; 3:17      scall 
        
    ex   DE, HL         ; 1:4       swap 
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2- 
    call fib1x          ; 3:17      scall 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
fib1x_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----
    
;   ---  b e g i n  ---
fib1_bench:             ;           ( -- )
        
    push DE             ; 1:11      push(1000)
    ex   DE, HL         ; 1:4       push(1000)
    ld   HL, 1000       ; 3:10      push(1000) 
szdo101:                ;           szdo 101 stack: ( index )
            
    push DE             ; 1:11      push2(20,0)
    ld   DE, 20         ; 3:10      push2(20,0)
    push HL             ; 1:11      push2(20,0)
    ld   HL, 0          ; 3:10      push2(20,0) 
sdo102:                 ;           sdo 102 stack: ( stop index ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup 
    call fib1x          ; 3:17      scall 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop 
    inc  HL             ; 1:6       sloop 102 index++
    ld   A, L           ; 1:4       sloop 102
    sub  E              ; 1:4       sloop 102 lo index - stop
    ld   A, H           ; 1:4       sloop 102
    sbc  A, D           ; 1:4       sloop 102 hi index - stop
    jp   c, sdo102      ; 3:10      sloop 102
    pop  HL             ; 1:10      unsloop 101 index out
    pop  DE             ; 1:10      unsloop 101 stop  out
        
    dec  HL             ; 1:6       szloop 101 index--
    ld   A, H           ; 1:4       szloop 101
    or   L              ; 1:4       szloop 101
    jp  nz, szdo101     ; 3:10      szloop 101
    ex   DE, HL         ; 1:4       unszloop LOOP_STACK
    pop  DE             ; 1:10      unszloop LOOP_STACK
    
fib1_bench_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

VARIABLE_SECTION:

STRING_SECTION:

