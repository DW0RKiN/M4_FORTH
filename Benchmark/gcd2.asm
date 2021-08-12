    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10
    exx                 ; 1:4
    
    call gcd2_bench     ; 3:17      call ( -- ret ) R:( -- )
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   
        

;   ---  the beginning of a non-recursive function  ---
gcd2:                   ;           ( a b -- gcd )
    pop  BC             ; 1:10      : ret
    ld  (gcd2_end+1),BC ; 4:20      : ( ret -- ) R:( -- )
      
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
    
    ld    A, E          ; 1:4       2dup <> while 101
    sub   L             ; 1:4       2dup <> while 101
    jr   nz, $+7        ; 2:7/12    2dup <> while 101
    ld    A, D          ; 1:4       2dup <> while 101
    sub   H             ; 1:4       2dup <> while 101
    jp    z, break101   ; 3:10      2dup <> while 101  
        
    ld    A, E          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    xor   H             ; 1:4       2dup < if
    jp    p, else104    ; 3:10      2dup < if 
            
    or    A             ; 1:4       over -
    sbc  HL, DE         ; 2:15      over -                                                          
        
    jp   endif104       ; 3:10      else
else104: 
            
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    or    A             ; 1:4       over -
    sbc  HL, DE         ; 2:15      over -  ; swap                                              
        
endif104:                                                               
    
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101 
    
    pop  DE             ; 1:10      nip ( b a -- a )

gcd2_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------          


;   ---  the beginning of a non-recursive function  ---
gcd2_bench:             ;           ( -- )
    pop  BC             ; 1:10      : ret
    ld  (gcd2_bench_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    

    ld   BC, 0          ; 3:10      xdo(100,0) 101
    ld  (idx101),BC     ; 4:20      xdo(100,0) 101
xdo101:                 ;           xdo(100,0) 101
        

    ld   BC, 0          ; 3:10      xdo(100,0) 102
    ld  (idx102),BC     ; 4:20      xdo(100,0) 102
xdo102:                 ;           xdo(100,0) 102 
    push DE             ; 1:11      index xj 102
    ex   DE, HL         ; 1:4       index xj 102
    ld   HL, (idx101)   ; 3:16      index xj 102 idx always points to a 16-bit index 
    push DE             ; 1:11      index xi 102
    ex   DE, HL         ; 1:4       index xi 102
    ld   HL, (idx102)   ; 3:16      index xi 102 idx always points to a 16-bit index 
    call gcd2           ; 3:17      call ( -- ret ) R:( -- ) 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
idx102 EQU $+1          ;           xloop 102 0 <= index < stop < 256
    ld    A, 0          ; 2:7       xloop 102
    nop                 ; 1:4       xloop 102 idx always points to a 16-bit index
    inc   A             ; 1:4       xloop 102 index++
    ld  (idx102),A      ; 3:13      xloop 102
    sub  low 100        ; 2:7       xloop 102
    jp    c, xdo102     ; 3:10      xloop 102 index-stop
xleave102:              ;           xloop 102
xexit102:               ;           xloop 102
    
idx101 EQU $+1          ;           xloop 101 0 <= index < stop < 256
    ld    A, 0          ; 2:7       xloop 101
    nop                 ; 1:4       xloop 101 idx always points to a 16-bit index
    inc   A             ; 1:4       xloop 101 index++
    ld  (idx101),A      ; 3:13      xloop 101
    sub  low 100        ; 2:7       xloop 101
    jp    c, xdo101     ; 3:10      xloop 101 index-stop
xleave101:              ;           xloop 101
xexit101:               ;           xloop 101

gcd2_bench_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


VARIABLE_SECTION:

STRING_SECTION:

