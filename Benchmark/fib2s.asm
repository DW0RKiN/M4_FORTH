    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000      ; 3:10      Init Return address stack
    exx                 ; 1:4
    
    call fib2s_bench    ; 3:17      scall
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   
    
;   ---  the beginning of a data stack function  ---
fib2s:                  ;           ( n1 -- n2 )
        
    ld    A, H          ; 1:4       dup 0= if
    or    L             ; 1:4       dup 0= if
    jp   nz, else101    ; 3:10      dup 0= if 
    ret                 ; 1:10      sexit 
else101  EQU $          ;           = endif
endif101:
        
    push DE             ; 1:11      push2(0,1)
    ld   DE, 0          ; 3:10      push2(0,1)
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1) 
    ex   DE, HL         ; 1:4       rot
    ex  (SP),HL         ; 1:19      rot ( c b a -- b a c ) 
    dec  HL             ; 1:6       1- 
        
    ld    B, H          ; 1:4       for 101
    ld    C, L          ; 1:4       for 101
    ex   DE, HL         ; 1:4       for 101
    pop  DE             ; 1:10      for 101 index
for101:                 ;           for 101
    ld  (idx101),BC     ; 4:20      next 101 save index 
            
    add  HL, DE         ; 1:11      over + 
    ex   DE, HL         ; 1:4       swap ( b a -- a b )
        
idx101 EQU $+1          ;           next 101
    ld   BC, 0x0000     ; 3:10      next 101 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 101
    or    C             ; 1:4       next 101
    dec  BC             ; 1:6       next 101 index--, zero flag unaffected
    jp   nz, for101     ; 3:10      next 101
next101:                ;           next 101
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
fib2s_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
    
;   ---  the beginning of a data stack function  ---
fib2s_bench:            ;           ( -- )
        

    ld   BC, 0          ; 3:10      xdo(1000,0) 102
    ld  (idx102),BC     ; 4:20      xdo(1000,0) 102
xdo102:                 ;           xdo(1000,0) 102 
            

    ld   BC, 0          ; 3:10      xdo(20,0) 103
    ld  (idx103),BC     ; 4:20      xdo(20,0) 103
xdo103:                 ;           xdo(20,0) 103 
    push DE             ; 1:11      index xi 103
    ex   DE, HL         ; 1:4       index xi 103
    ld   HL, (idx103)   ; 3:16      index xi 103 idx always points to a 16-bit index 
    call fib2s          ; 3:17      scall 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
idx103 EQU $+1          ;           xloop 103 0 <= index < stop < 256
    ld    A, 0          ; 2:7       xloop 103
    nop                 ; 1:4       xloop 103 idx always points to a 16-bit index
    inc   A             ; 1:4       xloop 103 index++
    ld  (idx103),A      ; 3:13      xloop 103
    sub  low 20         ; 2:7       xloop 103
    jp    c, xdo103     ; 3:10      xloop 103 index-stop
xleave103:              ;           xloop 103
xexit103:               ;           xloop 103
        
idx102 EQU $+1          ;           xloop 102 index < stop && same sign
    ld   BC, 0x0000     ; 3:10      xloop 102 idx always points to a 16-bit index
    inc  BC             ; 1:6       xloop 102 index++
    ld  (idx102),BC     ; 4:20      xloop 102 save index
    ld    A, C          ; 1:4       xloop 102
    sub  low 1000       ; 2:7       xloop 102 index - stop
    ld    A, B          ; 1:4       xloop 102
    sbc   A, high 1000  ; 2:7       xloop 102 index - stop
    jp    c, xdo102     ; 3:10      xloop 102
xleave102:              ;           xloop 102
xexit102:               ;           xloop 102
    
fib2s_bench_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------



VARIABLE_SECTION:

STRING_SECTION:

