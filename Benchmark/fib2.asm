    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 35000      ; 3:10
    exx                 ; 1:4
    
    call fib2_bench     ; 3:17      call ( -- ret ) R:( -- )
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====   
    
;   ---  the beginning of a non-recursive function  ---
fib2:                   ;           ( n1 -- n2 )
    pop  BC             ; 1:10      : ret
    ld  (fib2_end+1),BC ; 4:20      : ( ret -- ) R:( -- )
        
    push DE             ; 1:11      push2(0,1)
    ld   DE, 0          ; 3:10      push2(0,1)
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1) 
    ex   DE, HL         ; 1:4       rot
    ex  (SP),HL         ; 1:19      rot ( c b a -- b a c ) 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    ld  (idx101), HL    ; 3:16      ?do 101 save index
    or    A             ; 1:4       ?do 101
    sbc  HL, DE         ; 2:15      ?do 101
    dec  DE             ; 1:6       ?do 101 stop-1
    ld    A, E          ; 1:4       ?do 101 
    ld  (stp_lo101), A  ; 3:13      ?do 101 lo stop
    ld    A, D          ; 1:4       ?do 101 
    ld  (stp_hi101), A  ; 3:13      ?do 101 hi stop
    pop  HL             ; 1:10      ?do 101
    pop  DE             ; 1:10      ?do 101
    jp    z, exit101    ; 3:10      ?do 101 ( -- ) R: ( -- )
do101:                  ;           ?do 101 
            
    add  HL, DE         ; 1:11      over + 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
idx101 EQU $+1          ;           loop 101
    ld   BC, 0x0000     ; 3:10      loop 101 idx always points to a 16-bit index
    ld    A, C          ; 1:4       loop 101
stp_lo101 EQU $+1       ;           loop 101
    xor  0x00           ; 2:7       loop 101 lo index - stop - 1
    ld    A, B          ; 1:4       loop 101
    inc  BC             ; 1:6       loop 101 index++
    ld  (idx101),BC     ; 4:20      loop 101 save index
    jp   nz, do101      ; 3:10      loop 101    
stp_hi101 EQU $+1       ;           loop 101
    xor  0x00           ; 2:7       loop 101 hi index - stop - 1
    jp   nz, do101      ; 3:10      loop 101
leave101:               ;           loop 101
exit101:                ;           loop 101 
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
fib2_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
    
;   ---  the beginning of a non-recursive function  ---
fib2_bench:             ;           ( -- )
    pop  BC             ; 1:10      : ret
    ld  (fib2_bench_end+1),BC; 4:20      : ( ret -- ) R:( -- )
        

    ld   BC, 0          ; 3:10      xdo(1000,0) 102
    ld  (idx102),BC     ; 4:20      xdo(1000,0) 102
xdo102:                 ;           xdo(1000,0) 102 
            

    ld   BC, 0          ; 3:10      xdo(20,0) 103
    ld  (idx103),BC     ; 4:20      xdo(20,0) 103
xdo103:                 ;           xdo(20,0) 103 
    push DE             ; 1:11      index xi 103
    ex   DE, HL         ; 1:4       index xi 103
    ld   HL, (idx103)   ; 3:16      index xi 103 idx always points to a 16-bit index 
    call fib2           ; 3:17      call ( -- ret ) R:( -- ) 
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
    
fib2_bench_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


VARIABLE_SECTION:

STRING_SECTION:

