    ORG 32768
    
;   ===  b e g i n  ===
    exx
    push HL
    push DE
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000
    exx
    
    call fib1_bench     ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call
    
    pop  DE
    pop  HL
    exx
    ret
;   =====  e n d  =====   
    
;   ---  b e g i n  ---
fib1:                   ;           ( a -- b )
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :
        
    ld    A, H          ; 1:4       dup 2 < if
    add   A, A          ; 1:4       dup 2 < if
    jr    c, $+11       ; 2:7/12    dup 2 < if    positive constant

    ld    A, L          ; 1:4       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    sub   low 2         ; 2:7       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    ld    A, H          ; 1:4       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    sbc   A, high 2     ; 2:7       dup 2 < if    (HL<2) --> (HL-2<0) --> carry if true
    jp   nc, else101    ; 3:10      dup 2 < if 
    ld   HL, 1          ; 3:10      drop_push(1) 
    jp   fib1_end       ; 3:10      exit 
else101  EQU $          ;           = endif
endif101:
        
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup  
    dec  HL             ; 1:6       1- 
    call fib1           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
        
    ex   DE, HL         ; 1:4       swap 
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2- 
    call fib1           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
fib1_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----
    
;   ---  b e g i n  ---
fib1_bench:             ;           ( -- )
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :
        
    exx                 ; 1:4       xdo 101
    dec  HL             ; 1:6       xdo 101
    ld  (HL),high 0     ; 2:10      xdo 101
    dec   L             ; 1:4       xdo 101
    ld  (HL),low 0      ; 2:10      xdo 101
    exx                 ; 1:4       xdo 101
xdo101:                 ;           xdo 101
            
    exx                 ; 1:4       xdo 102
    dec  HL             ; 1:6       xdo 102
    ld  (HL),high 0     ; 2:10      xdo 102
    dec   L             ; 1:4       xdo 102
    ld  (HL),low 0      ; 2:10      xdo 102
    exx                 ; 1:4       xdo 102
xdo102:                 ;           xdo 102 
    exx                 ; 1:4       index xi 102    
    ld    A,(HL)        ; 1:7       index xi 102 lo
    inc   L             ; 1:4       index xi 102
    ex   AF, AF'        ; 1:4       index xi 102
    ld    A,(HL)        ; 1:7       index xi 102 hi
    dec   L             ; 1:4       index xi 102
    exx                 ; 1:4       index xi 102
    push DE             ; 1:11      index xi 102
    ex   DE, HL         ; 1:4       index xi 102
    ld    H, A          ; 1:4       index xi 102
    ex   AF, AF'        ; 1:4       index xi 102
    ld    L, A          ; 1:4       index xi 102
;   exx                 ; 1:4       index xi 102
;   ld    E,(HL)        ; 1:7       index xi 102
;   inc   L             ; 1:4       index xi 102
;   ld    D,(HL)        ; 1:7       index xi 102
;   push DE             ; 1:11      index xi 102
;   dec   L             ; 1:4       index xi 102
;   exx                 ; 1:4       index xi 102
;   ex   DE, HL         ; 1:4       index xi 102 ( i x2 x1 -- i  x1 x2 )
;   ex  (SP),HL         ; 1:19      index xi 102 ( i x1 x2 -- x2 x1 i ) 
    call fib1           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop 
    exx                 ; 1:4       xloop 102
    inc (HL)            ; 1:7       xloop 102 index_lo++
    ld    A, 20         ; 2:7       xloop 102
    scf                 ; 1:4       xloop 102
    sbc   A, (HL)       ; 1:7       xloop 102 stop_lo - index_lo - 1
    exx                 ; 1:4       xloop 102
    jp   nc,xdo102      ; 3:10      xloop 102 again
    exx                 ; 1:4       xloop 102
    inc   L             ; 1:4       xloop 102
    inc  HL             ; 1:6       xloop 102
    exx                 ; 1:4       xloop 102
        
    exx                 ; 1:4       xloop 101
    ld    E,(HL)        ; 1:7       xloop 101
    inc   L             ; 1:4       xloop 101
    ld    D,(HL)        ; 1:7       xloop 101
    inc  DE             ; 1:6       xloop 101 index++
    ld    A, low 1000   ; 2:7       xloop 101
    scf                 ; 1:4       xloop 101
    sbc   A, E          ; 1:4       xloop 101 stop_lo - index_lo - 1
    ld    A, high 1000  ; 2:7       xloop 101
    sbc   A, D          ; 1:4       xloop 101 stop_hi - index_hi - 1
    jr    c, $+9        ; 2:7/12    xloop 101 exit
    ld  (HL), D         ; 1:7       xloop 101
    dec   L             ; 1:4       xloop 101
    ld  (HL), E         ; 1:6       xloop 101
    exx                 ; 1:4       xloop 101
    jp   xdo101         ; 3:10      xloop 101
    inc  HL             ; 1:6       xloop 101
    exx                 ; 1:4       xloop 101
    
fib1_bench_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


VARIABLE_SECTION:

STRING_SECTION:

