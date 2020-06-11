    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    
    call gcd2_bench     ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   
        

;   ---  b e g i n  ---
gcd2:                   ;           ( a b -- gcd )
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
      
    ld    A, H          ; 1:4       2dup D0= if
    or    L             ; 1:4       2dup D0= if
    or    D             ; 1:4       2dup D0= if
    or    E             ; 1:4       2dup D0= if
    jp   nz, else101    ; 3:10      2dup D0= if 
    pop  DE             ; 1:10      2drop 1
    ld   HL, 1          ; 3:10      2drop 1 
    jp   gcd2_end       ; 3:10      exit 
else101  EQU $          ;           = endif
endif101:                                          
         
    ld    A, H          ; 1:4       dup 0= if
    or    L             ; 1:4       dup 0= if
    jp   nz, else102    ; 3:10      dup 0= if   
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )         
    jp   gcd2_end       ; 3:10      exit 
else102  EQU $          ;           = endif
endif102:                                          
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, H          ; 1:4       dup 0= if
    or    L             ; 1:4       dup 0= if
    jp   nz, else103    ; 3:10      dup 0= if   
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )         
    jp   gcd2_end       ; 3:10      exit 
else103  EQU $          ;           = endif
endif103:                                          
    
begin101: 
        
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -                                                                    
    
    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101  
        
    ld    A, H          ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    ld    C, A          ; 1:4       2dup < if
    ld    A, E          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sub   L             ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    ld    A, D          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    sbc   A, H          ; 1:4       2dup < if    (DE<HL) --> (DE-HL<0) --> carry if true
    rra                 ; 1:4       2dup < if
    xor   C             ; 1:4       2dup < if
    jp    p, else104    ; 3:10      2dup < if 
            
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      -                                                          
        
    jp   endif104       ; 3:10      else
else104: 
            
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      - 
    ex   DE, HL         ; 1:4       swap ( b a -- a b )                                              
        
endif104:                                                               
    
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101 
    
    pop  DE             ; 1:10      nip ( b a -- a )

gcd2_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
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
    exx                 ; 1:4       : R:( -- ret )
    

    exx                 ; 1:4       xdo(100,0) 101
    dec  HL             ; 1:6       xdo(100,0) 101
    ld  (HL),high 0     ; 2:10      xdo(100,0) 101
    dec   L             ; 1:4       xdo(100,0) 101
    ld  (HL),low 0      ; 2:10      xdo(100,0) 101
    exx                 ; 1:4       xdo(100,0) 101 R:( -- 0 )
xdo101:                 ;           xdo(100,0) 101
        

    exx                 ; 1:4       xdo(100,0) 102
    dec  HL             ; 1:6       xdo(100,0) 102
    ld  (HL),high 0     ; 2:10      xdo(100,0) 102
    dec   L             ; 1:4       xdo(100,0) 102
    ld  (HL),low 0      ; 2:10      xdo(100,0) 102
    exx                 ; 1:4       xdo(100,0) 102 R:( -- 0 )
xdo102:                 ;           xdo(100,0) 102 
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
    ld    E,(HL)        ; 1:7       index xi 102
    inc   L             ; 1:4       index xi 102
    ld    D,(HL)        ; 1:7       index xi 102
    push DE             ; 1:11      index xi 102
    dec   L             ; 1:4       index xi 102
    exx                 ; 1:4       index xi 102 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 102
    ex  (SP),HL         ; 1:19      index xi 102 ( -- x ) 
    call gcd2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- ) 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    exx                 ; 1:4       xloop(100,0) 102
    inc (HL)            ; 1:7       xloop(100,0) 102 index_lo++
    ld    A, (HL)       ; 1:7       xloop(100,0) 102 index_lo
    sub  100            ; 2:7       xloop(100,0) 102 index_lo - stop_lo
    exx                 ; 1:4       xloop(100,0) 102
    jp    c, xdo102     ; 3:10      xloop(100,0) 102 again
    exx                 ; 1:4       xloop(100,0) 102
    inc   L             ; 1:4       xloop(100,0) 102
xleave102:              ;           xloop(100,0) 102
    inc  HL             ; 1:6       xloop(100,0) 102
    exx                 ; 1:4       xloop(100,0) 102 R:( index -- )
    
    exx                 ; 1:4       xloop(100,0) 101
    inc (HL)            ; 1:7       xloop(100,0) 101 index_lo++
    ld    A, (HL)       ; 1:7       xloop(100,0) 101 index_lo
    sub  100            ; 2:7       xloop(100,0) 101 index_lo - stop_lo
    exx                 ; 1:4       xloop(100,0) 101
    jp    c, xdo101     ; 3:10      xloop(100,0) 101 again
    exx                 ; 1:4       xloop(100,0) 101
    inc   L             ; 1:4       xloop(100,0) 101
xleave101:              ;           xloop(100,0) 101
    inc  HL             ; 1:6       xloop(100,0) 101
    exx                 ; 1:4       xloop(100,0) 101 R:( index -- )

gcd2_bench_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----


VARIABLE_SECTION:

STRING_SECTION:

