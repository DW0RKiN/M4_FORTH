    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    
    call gcd1_bench     ; 3:17      call ( -- ret ) R:( -- )
    
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====   
    
;   ---  the beginning of a non-recursive function  ---
gcd1:                   ;           ( a b -- gcd )
    pop  BC             ; 1:10      : ret
    ld  (gcd1_end+1),BC ; 4:20      : ( ret -- ) R:( -- )                                                                
        
    ld    A, D          ; 1:4       over if
    or    E             ; 1:4       over if
    jp    z, else101    ; 3:10      over if                                                                         
            
begin101:               ;           begin 101                                                                         
            
    ld    A, H          ; 1:4       dup_while 101
    or    L             ; 1:4       dup_while 101
    jp    z, break101   ; 3:10      dup_while 101                                                                   
                
    ld    A, L          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, else102    ; 3:10      2dup u> if 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
else102  EQU $          ;           = endif
endif102: 
    or    A             ; 1:4       over -
    sbc  HL, DE         ; 2:15      over -                                               
            
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
        
    jp   endif101       ; 3:10      else
else101:                                                               
            
    ld    A, H          ; 1:4       dup if
    or    L             ; 1:4       dup if
    jp    z, else103    ; 3:10      dup if 
    pop  DE             ; 1:10      nip ( b a -- a ) 
    jp   endif103       ; 3:10      else
else103: 
    pop  DE             ; 1:10      2drop 1
    ld   HL, 1          ; 3:10      2drop 1 
endif103:                                                   
        
endif101: 
    
gcd1_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  --------- 
    
;   ---  the beginning of a non-recursive function  ---
gcd1_bench:             ;           ( -- )
    pop  BC             ; 1:10      : ret
    ld  (gcd1_bench_end+1),BC; 4:20      : ( ret -- ) R:( -- )
        
    ld   BC, 0          ; 3:10      xdo(100,0) 101
xdo101save:             ;           xdo(100,0) 101
    ld  (idx101),BC     ; 4:20      xdo(100,0) 101
xdo101:                 ;           xdo(100,0) 101
;#        PUSH2(100,0) SDO XJ OVER CALL(gcd1) DROP SLOOP
            
    ld   BC, 0          ; 3:10      xdo(100,0) 102
xdo102save:             ;           xdo(100,0) 102
    ld  (idx102),BC     ; 4:20      xdo(100,0) 102
xdo102:                 ;           xdo(100,0) 102 
    push DE             ; 1:11      index(101) xj
    ex   DE, HL         ; 1:4       index(101) xj
    ld   HL, (idx101)   ; 3:16      index(101) xj   idx always points to a 16-bit index 
    push DE             ; 1:11      index(102) xi
    ex   DE, HL         ; 1:4       index(102) xi
    ld   HL, (idx102)   ; 3:16      index(102) xi   idx always points to a 16-bit index 
    call gcd1           ; 3:17      call ( -- ret ) R:( -- ) 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
                        ;[12:45]    xloop 102   variant +1.B: 0 <= index < stop <= 256, run 100x
idx102 EQU $+1          ;           xloop 102   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       xloop 102   0.. +1 ..(100), real_stop:0x0064
    nop                 ; 1:4       xloop 102   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       xloop 102   index++
    ld  (idx102),A      ; 3:13      xloop 102
    xor  0x64           ; 2:7       xloop 102   lo(real_stop)
    jp   nz, xdo102     ; 3:10      xloop 102   index-stop
xleave102:              ;           xloop 102
xexit102:               ;           xloop 102
        
                        ;[12:45]    xloop 101   variant +1.B: 0 <= index < stop <= 256, run 100x
idx101 EQU $+1          ;           xloop 101   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       xloop 101   0.. +1 ..(100), real_stop:0x0064
    nop                 ; 1:4       xloop 101   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       xloop 101   index++
    ld  (idx101),A      ; 3:13      xloop 101
    xor  0x64           ; 2:7       xloop 101   lo(real_stop)
    jp   nz, xdo101     ; 3:10      xloop 101   index-stop
xleave101:              ;           xloop 101
xexit101:               ;           xloop 101
    
gcd1_bench_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
