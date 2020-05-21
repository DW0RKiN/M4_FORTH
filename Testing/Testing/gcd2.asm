    ORG 32768
    
;   ===  b e g i n  ===
    exx
    push HL
    push DE
    ld   HL, 60000
    exx
    
    call gcd2_bench     ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call
    
    pop  DE
    pop  HL
    exx
    ret
;   =====  e n d  =====   
        
    
;   ---  b e g i n  ---
gcd2:                   ;           ( a b -- gcd )
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :                                                              
        
    ld    A, H          ; 1:4       dcp0
    or    L             ; 1:4       dcp0
    or    D             ; 1:4       dcp0
    or    E             ; 1:4       dcp0     
    jp   nz, else101    ; 3:10      ifz 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop 
    ld   HL, 1          ; 3:10      drop_push 
    jp   gcd2_end       ; 3:10 
else101  EQU $          ;           = endif
endif101:                                          
        
    ld    A, H          ; 1:4       cp0
    or    L             ; 1:4       cp0      
    jp   nz, else102    ; 3:10      ifz 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop              
    jp   gcd2_end       ; 3:10 
else102  EQU $          ;           = endif
endif102:                                          
        
    ex   DE, HL         ; 1:4       swap 
    ld    A, H          ; 1:4       cp0
    or    L             ; 1:4       cp0 
    jp   nz, else103    ; 3:10      ifz 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop              
    jp   gcd2_end       ; 3:10 
else103  EQU $          ;           = endif
endif103:                                          
        
begin101:  
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup 
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -                                                                    
        
    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, repeat101  ; 3:10      while 101  
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup 
    ld    A, H          ; 1:4       <
    xor   D             ; 1:4       <
    jp    p, $+7        ; 3:10      <
    rl    D             ; 2:8       < sign x2
    jr   $+5            ; 2:12      <
    ex   DE, HL         ; 1:4       <
    sbc  HL, DE         ; 2:15      <
    sbc  HL, HL         ; 2:15      <
    pop  DE             ; 1:10      <  
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else104    ; 3:10      if 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over 
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -                                                          
                 
    jp   endif104       ; 3:10      else
else104: 
    ex   DE, HL         ; 1:4       swap 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over 
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      - 
    ex   DE, HL         ; 1:4       swap                                              
                 
endif104:                                                               
        
    jp   begin101       ; 3:10      repeat 101
repeat101: 
    pop  DE             ; 1:10      nip 
    
gcd2_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----

    
;   ---  b e g i n  ---
gcd2_bench:             ;           ( -- )
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
    exx                 ; 1:4       index xj 102    
    ld    E, L          ; 1:4       index xj 102
    ld    D, H          ; 1:4       index xj 102
    inc   L             ; 1:4       index xj 102
    inc  HL             ; 1:6       index xj 102
    ld    C,(HL)        ; 1:7       index xj 102 lo    
    inc   L             ; 1:4       index xj 102
    ld    B,(HL)        ; 1:7       index xj 102 hi
    push BC             ; 1:11      index xj 102
    ex   DE, HL         ; 1:4       index xj 102
    exx                 ; 1:4       index xj 102
    ex   DE, HL         ; 1:4       index xj 102 ( j x2 x1 -- j  x1 x2 )
    ex  (SP),HL         ; 1:19      index xj 102 ( j x1 x2 -- x2 x1 j ) 
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
    call gcd2           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop 
    exx                 ; 1:4       xloop 102
    inc (HL)            ; 1:7       xloop 102 index_lo++
    ld    A, 100        ; 2:7       xloop 102
    scf                 ; 1:4       xloop 102
    sbc   A, (HL)       ; 1:7       xloop 102 stop_lo - index_lo - 1
    exx                 ; 1:4       xloop 102
    jp   nc,xdo102      ; 3:10      xloop 102 again
    exx                 ; 1:4       xloop 102
    inc   L             ; 1:4       xloop 102
    inc  HL             ; 1:6       xloop 102
    exx                 ; 1:4       xloop 102
        
    exx                 ; 1:4       xloop 101
    inc (HL)            ; 1:7       xloop 101 index_lo++
    ld    A, 100        ; 2:7       xloop 101
    scf                 ; 1:4       xloop 101
    sbc   A, (HL)       ; 1:7       xloop 101 stop_lo - index_lo - 1
    exx                 ; 1:4       xloop 101
    jp   nc,xdo101      ; 3:10      xloop 101 again
    exx                 ; 1:4       xloop 101
    inc   L             ; 1:4       xloop 101
    inc  HL             ; 1:6       xloop 101
    exx                 ; 1:4       xloop 101
    
gcd2_bench_end:
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

