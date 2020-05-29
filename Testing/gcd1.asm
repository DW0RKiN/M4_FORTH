    ORG 32768
    
;   ===  b e g i n  ===
    exx
    push HL
    push DE
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    
    call gcd1_bench     ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call
    
    pop  DE
    pop  HL
    exx
    ret
;   =====  e n d  =====   
    
;   ---  b e g i n  ---
gcd1:                   ;           ( a b -- gcd )
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :                                                                
    
    ld    A, D          ; 1:4       over if
    or    E             ; 1:4       over if
    jp    z, else101    ; 3:10      if                                                                         
            
begin101:                                                                         
            
    ld    A, H          ; 1:4       dup_while 101
    or    L             ; 1:4       dup_while 101
    jp    z, repeat101  ; 3:10      dup_while 101                                                                   
                
    ld    A, L          ; 1:4       dup2 (u)> if    (DE>HL) --> (0>HL-DE) --> carry if true
    sub   E             ; 1:4       dup2 (u)> if    (DE>HL) --> (0>HL-DE) --> carry if true
    ld    A, H          ; 1:4       dup2 (u)> if    (DE>HL) --> (0>HL-DE) --> carry if true
    sbc   A, D          ; 1:4       dup2 (u)> if    (DE>HL) --> (0>HL-DE) --> carry if true
    jp   nc, else102    ; 3:10      dup2 (u)> if 
    ex   DE, HL         ; 1:4       swap 
else102  EQU $          ;           = endif
endif102: 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over 
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -                                               
            
    jp   begin101       ; 3:10      repeat 101
repeat101: 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop 
        
    jp   endif101       ; 3:10      else
else101:                                                               
            
    ld    A, H          ; 1:4       dup if
    or    L             ; 1:4       dup if
    jp    z, else103    ; 3:10      if 
    pop  DE             ; 1:10      nip 
    jp   endif103       ; 3:10      else
else103: 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop 
    ld   HL, 1          ; 3:10      drop_push(1) 
endif103:                                                   
        
endif101: 
    
gcd1_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  ----- 
    
;   ---  b e g i n  ---
gcd1_bench:             ;           ( -- )
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
    call gcd1           ; 3:17      call
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
    
gcd1_bench_end:
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

