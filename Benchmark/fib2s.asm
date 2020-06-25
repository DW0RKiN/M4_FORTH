    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000
    exx
    
    call fib2s_bench    ; 3:17      scall
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   
    
;   ---  b e g i n  ---
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
        
    ex  (SP),HL         ; 1:19      for 101
    ex   DE, HL         ; 1:4       for 101
    exx                 ; 1:4       for 101
    pop  DE             ; 1:10      for 101 index
    dec  HL             ; 1:6       for 101
    ld  (HL),D          ; 1:7       for 101
    dec  L              ; 1:4       for 101
    ld  (HL),E          ; 1:7       for 101 stop
    exx                 ; 1:4       for 101 ( index -- ) R: ( -- index )
for101:                 ;           for 101 
            
    add  HL, DE         ; 1:11      over + 
    ex   DE, HL         ; 1:4       swap ( b a -- a b )
        
    exx                 ; 1:4       next 101
    ld    E,(HL)        ; 1:7       next 101
    inc   L             ; 1:4       next 101
    ld    D,(HL)        ; 1:7       next 101 DE = index   
    ld    A, E          ; 1:4       next 101
    or    D             ; 1:4       next 101
    jr    z, next101    ; 2:7/12    next 101 exit
    dec  DE             ; 1:6       next 101 index--
    ld  (HL),D          ; 1:7       next 101
    dec   L             ; 1:4       next 101
    ld  (HL),E          ; 1:7       next 101
    exx                 ; 1:4       next 101
    jp   for101         ; 3:10      next 101
next101:                ;           next 101
    inc  HL             ; 1:6       next 101
    exx                 ; 1:4       next 101
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
fib2s_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----
    
;   ---  b e g i n  ---
fib2s_bench:            ;           ( -- )
        

    exx                 ; 1:4       xdo(1000,0) 102
    dec  HL             ; 1:6       xdo(1000,0) 102
    ld  (HL),high 0     ; 2:10      xdo(1000,0) 102
    dec   L             ; 1:4       xdo(1000,0) 102
    ld  (HL),low 0      ; 2:10      xdo(1000,0) 102
    exx                 ; 1:4       xdo(1000,0) 102 R:( -- 0 )
xdo102:                 ;           xdo(1000,0) 102 
            

    exx                 ; 1:4       xdo(20,0) 103
    dec  HL             ; 1:6       xdo(20,0) 103
    ld  (HL),high 0     ; 2:10      xdo(20,0) 103
    dec   L             ; 1:4       xdo(20,0) 103
    ld  (HL),low 0      ; 2:10      xdo(20,0) 103
    exx                 ; 1:4       xdo(20,0) 103 R:( -- 0 )
xdo103:                 ;           xdo(20,0) 103 
    exx                 ; 1:4       index xi 103
    ld    E,(HL)        ; 1:7       index xi 103
    inc   L             ; 1:4       index xi 103
    ld    D,(HL)        ; 1:7       index xi 103
    push DE             ; 1:11      index xi 103
    dec   L             ; 1:4       index xi 103
    exx                 ; 1:4       index xi 103 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 103
    ex  (SP),HL         ; 1:19      index xi 103 ( -- x ) 
    call fib2s          ; 3:17      scall 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    exx                 ; 1:4       xloop(20,0) 103
    ld    E,(HL)        ; 1:7       xloop(20,0) 103
    inc   L             ; 1:4       xloop(20,0) 103
    ld    D,(HL)        ; 1:7       xloop(20,0) 103
    inc  DE             ; 1:6       xloop(20,0) 103 index++
    ld    A, low 20     ; 2:7       xloop(20,0) 103
    xor   E             ; 1:4       xloop(20,0) 103
    jr   nz, $+7        ; 2:7/12    xloop(20,0) 103
    ld    A, high 20    ; 2:7       xloop(20,0) 103
    xor   D             ; 1:4       xloop(20,0) 103
    jr    z, xleave103  ; 2:7/12    xloop(20,0) 103 exit
    ld  (HL), D         ; 1:7       xloop(20,0) 103
    dec   L             ; 1:4       xloop(20,0) 103
    ld  (HL), E         ; 1:6       xloop(20,0) 103
    exx                 ; 1:4       xloop(20,0) 103
    jp   xdo103         ; 3:10      xloop(20,0) 103
xleave103:              ;           xloop(20,0) 103
    inc  HL             ; 1:6       xloop(20,0) 103
    exx                 ; 1:4       xloop(20,0) 103 R:( index -- )
xexit103 EQU $
        
    exx                 ; 1:4       xloop(1000,0) 102
    ld    E,(HL)        ; 1:7       xloop(1000,0) 102
    inc   L             ; 1:4       xloop(1000,0) 102
    ld    D,(HL)        ; 1:7       xloop(1000,0) 102
    inc  DE             ; 1:6       xloop(1000,0) 102 index++
    ld    A, low 1000   ; 2:7       xloop(1000,0) 102
    xor   E             ; 1:4       xloop(1000,0) 102
    jr   nz, $+7        ; 2:7/12    xloop(1000,0) 102
    ld    A, high 1000  ; 2:7       xloop(1000,0) 102
    xor   D             ; 1:4       xloop(1000,0) 102
    jr    z, xleave102  ; 2:7/12    xloop(1000,0) 102 exit
    ld  (HL), D         ; 1:7       xloop(1000,0) 102
    dec   L             ; 1:4       xloop(1000,0) 102
    ld  (HL), E         ; 1:6       xloop(1000,0) 102
    exx                 ; 1:4       xloop(1000,0) 102
    jp   xdo102         ; 3:10      xloop(1000,0) 102
xleave102:              ;           xloop(1000,0) 102
    inc  HL             ; 1:6       xloop(1000,0) 102
    exx                 ; 1:4       xloop(1000,0) 102 R:( index -- )
xexit102 EQU $
    
fib2s_bench_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


VARIABLE_SECTION:

STRING_SECTION:

