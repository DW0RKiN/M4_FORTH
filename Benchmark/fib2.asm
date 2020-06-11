    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000
    exx
    
    call fib2_bench     ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   
    
;   ---  b e g i n  ---
fib2:                   ;           ( n1 -- n2 )
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
        
    push DE             ; 1:11      push2(0,1)
    ld   DE, 0          ; 3:10      push2(0,1)
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1) 
    ex   DE, HL         ; 1:4       rot
    ex  (SP), HL        ; 1:19      rot ( c b a -- b a c ) 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push HL             ; 1:11      do 101 index
    push DE             ; 1:11      do 101 stop
    exx                 ; 1:4       do 101
    pop  DE             ; 1:10      do 101 stop
    dec  HL             ; 1:6       do 101
    ld  (HL),D          ; 1:7       do 101
    dec  L              ; 1:4       do 101
    ld  (HL),E          ; 1:7       do 101 stop
    pop  DE             ; 1:10      do 101 index
    dec  HL             ; 1:6       do 101
    ld  (HL),D          ; 1:7       do 101
    dec  L              ; 1:4       do 101
    ld  (HL),E          ; 1:7       do 101 index
    exx                 ; 1:4       do 101
    pop  HL             ; 1:10      do 101
    pop  DE             ; 1:10      do 101 ( stop index -- ) r: ( -- stop index )
do101: 
            
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      + 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    exx                 ; 1:4       loop 101
    ld   E,(HL)         ; 1:7       loop 101
    inc  L              ; 1:4       loop 101
    ld   D,(HL)         ; 1:7       loop 101 DE = index   
    inc  HL             ; 1:6       loop 101
    inc  DE             ; 1:6       loop 101 index + 1
    ld    A, E          ; 1:4       loop 101
    sub (HL)            ; 1:7       loop 101 lo index - stop
    ld    A, D          ; 1:4       loop 101
    inc   L             ; 1:4       loop 101
    sbc  A,(HL)         ; 1:7       loop 101 hi index - stop
    jr  nc, leave101    ; 2:7/12    loop 101 exit
    dec  L              ; 1:4       loop 101
    dec  HL             ; 1:6       loop 101
    ld  (HL), D         ; 1:7       loop 101
    dec  L              ; 1:4       loop 101
    ld  (HL), E         ; 1:7       loop 101
    exx                 ; 1:4       loop 101
    jp   do101          ; 3:10      loop 101
leave101:
    inc  HL             ; 1:6       loop 101
    exx                 ; 1:4       loop 101 
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
fib2_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----
    
;   ---  b e g i n  ---
fib2_bench:             ;           ( -- )
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
        

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
    call fib2           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- ) 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    exx                 ; 1:4       xloop(20,0) 103
    inc (HL)            ; 1:7       xloop(20,0) 103 index_lo++
    ld    A, (HL)       ; 1:7       xloop(20,0) 103 index_lo
    sub  20             ; 2:7       xloop(20,0) 103 index_lo - stop_lo
    exx                 ; 1:4       xloop(20,0) 103
    jp    c, xdo103     ; 3:10      xloop(20,0) 103 again
    exx                 ; 1:4       xloop(20,0) 103
    inc   L             ; 1:4       xloop(20,0) 103
xleave103:              ;           xloop(20,0) 103
    inc  HL             ; 1:6       xloop(20,0) 103
    exx                 ; 1:4       xloop(20,0) 103 R:( index -- )
        
    exx                 ; 1:4       xloop(1000,0) 102

    ld    E,(HL)        ; 1:7       xloop(1000,0) 102
    inc   L             ; 1:4       xloop(1000,0) 102
    ld    D,(HL)        ; 1:7       xloop(1000,0) 102
    inc  DE             ; 1:6       xloop(1000,0) 102 index++
    ld    A, low 1000   ; 2:7       xloop(1000,0) 102
    scf                 ; 1:4       xloop(1000,0) 102
    sbc   A, E          ; 1:4       xloop(1000,0) 102 stop_lo - index_lo - 1
    ld    A, high 1000  ; 2:7       xloop(1000,0) 102
    sbc   A, D          ; 1:4       xloop(1000,0) 102 stop_hi - index_hi - 1
    jr    c, xleave102  ; 2:7/12    xloop(1000,0) 102 exit
    ld  (HL), D         ; 1:7       xloop(1000,0) 102
    dec   L             ; 1:4       xloop(1000,0) 102
    ld  (HL), E         ; 1:6       xloop(1000,0) 102
    exx                 ; 1:4       xloop(1000,0) 102
    jp   xdo102         ; 3:10      xloop 102
xleave102:              ;           xloop(1000,0) 102
    inc  HL             ; 1:6       xloop(1000,0) 102
    exx                 ; 1:4       xloop(1000,0) 102 R:( index -- )
    
fib2_bench_end:
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

