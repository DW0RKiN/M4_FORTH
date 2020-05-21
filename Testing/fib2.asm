    ORG 32768
    
;   ===  b e g i n  ===
    exx
    push HL
    push DE
    ld   HL, 35000
    exx
    
    call fib2_bench     ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call
    
    pop  DE
    pop  HL
    exx
    ret
;   =====  e n d  =====   
    
;   ---  b e g i n  ---
fib2:                   ;           ( n1 -- n2 )
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       :
        
    push DE             ; 1:11      push2(0,1)
    ld   DE, 0          ; 3:10      push2(0,1)
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1) 
    ex   DE, HL         ; 1:4       rot ( x3 x1 x2 )
    ex  (SP), HL        ; 1:19      rot ( x2 x1 x3 ) 
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
    pop  DE             ; 1:10      do 101
do101: 
            
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      + 
    ex   DE, HL         ; 1:4       swap 
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
    jr  nc, $+11        ; 2:7/12    loop 101 exit
    dec  L              ; 1:4       loop 101
    dec  HL             ; 1:6       loop 101
    ld  (HL), D         ; 1:7       loop 101
    dec  L              ; 1:4       loop 101
    ld  (HL), E         ; 1:7       loop 101
    exx                 ; 1:4       loop 101
    jp   do101          ; 3:10      loop 101
    inc  HL             ; 1:6       loop 101
    exx                 ; 1:4       loop 101 
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop
    
fib2_end:
    exx                 ; 1:4       ;
    ld   E,(HL)         ; 1:7       ;
    inc  L              ; 1:4       ;
    ld   D,(HL)         ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE,HL          ; 1:4       ;
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
    exx                 ; 1:4       :
        
    exx                 ; 1:4       xdo 102
    dec  HL             ; 1:6       xdo 102
    ld  (HL),high 0     ; 2:10      xdo 102
    dec   L             ; 1:4       xdo 102
    ld  (HL),low 0      ; 2:10      xdo 102
    exx                 ; 1:4       xdo 102
xdo102:                 ;           xdo 102 
            
    exx                 ; 1:4       xdo 103
    dec  HL             ; 1:6       xdo 103
    ld  (HL),high 0     ; 2:10      xdo 103
    dec   L             ; 1:4       xdo 103
    ld  (HL),low 0      ; 2:10      xdo 103
    exx                 ; 1:4       xdo 103
xdo103:                 ;           xdo 103 
    exx                 ; 1:4       index xi 103    
    ld    A,(HL)        ; 1:7       index xi 103 lo
    inc   L             ; 1:4       index xi 103
    ex   AF, AF'        ; 1:4       index xi 103
    ld    A,(HL)        ; 1:7       index xi 103 hi
    dec   L             ; 1:4       index xi 103
    exx                 ; 1:4       index xi 103
    push DE             ; 1:11      index xi 103
    ex   DE, HL         ; 1:4       index xi 103
    ld    H, A          ; 1:4       index xi 103
    ex   AF, AF'        ; 1:4       index xi 103
    ld    L, A          ; 1:4       index xi 103
;   exx                 ; 1:4       index xi 103
;   ld    E,(HL)        ; 1:7       index xi 103
;   inc   L             ; 1:4       index xi 103
;   ld    D,(HL)        ; 1:7       index xi 103
;   push DE             ; 1:11      index xi 103
;   dec   L             ; 1:4       index xi 103
;   exx                 ; 1:4       index xi 103
;   ex   DE, HL         ; 1:4       index xi 103 ( i x2 x1 -- i  x1 x2 )
;   ex  (SP),HL         ; 1:19      index xi 103 ( i x1 x2 -- x2 x1 i ) 
    call fib2           ; 3:17      call
    ex   DE,HL          ; 1:4       call    
    exx                 ; 1:4       call 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop 
    exx                 ; 1:4       xloop 103
    inc (HL)            ; 1:7       xloop 103 index_lo++
    ld    A, 20         ; 2:7       xloop 103
    scf                 ; 1:4       xloop 103
    sbc   A, (HL)       ; 1:7       xloop 103 stop_lo - index_lo - 1
    exx                 ; 1:4       xloop 103
    jp   nc,xdo103      ; 3:10      xloop 103 again
    exx                 ; 1:4       xloop 103
    inc   L             ; 1:4       xloop 103
    inc  HL             ; 1:6       xloop 103
    exx                 ; 1:4       xloop 103
        
    exx                 ; 1:4       xloop 102
    ld    E,(HL)        ; 1:7       xloop 102
    inc   L             ; 1:4       xloop 102
    ld    D,(HL)        ; 1:7       xloop 102
    inc  DE             ; 1:6       xloop 102 index++
    ld    A, low 1000   ; 2:7       xloop 102
    scf                 ; 1:4       xloop 102
    sbc   A, E          ; 1:4       xloop 102 stop_lo - index_lo - 1
    ld    A, high 1000  ; 2:7       xloop 102
    sbc   A, D          ; 1:4       xloop 102 stop_hi - index_hi - 1
    jr    c, $+9        ; 2:7/12    xloop 102 exit
    ld  (HL), D         ; 1:7       xloop 102
    dec   L             ; 1:4       xloop 102
    ld  (HL), E         ; 1:6       xloop 102
    exx                 ; 1:4       xloop 102
    jp   xdo102         ; 3:10      xloop 102
    inc  HL             ; 1:6       xloop 102
    exx                 ; 1:4       xloop 102
    
fib2_bench_end:
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

