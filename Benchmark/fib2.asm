    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 35000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    
    call fib2_bench     ; 3:17      call ( -- ret ) R:( -- )
    
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
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
xdo102save:             ;           xdo(1000,0) 102
    ld  (idx102),BC     ; 4:20      xdo(1000,0) 102
xdo102:                 ;           xdo(1000,0) 102 
            
    ld   BC, 0          ; 3:10      xdo(20,0) 103
xdo103save:             ;           xdo(20,0) 103
    ld  (idx103),BC     ; 4:20      xdo(20,0) 103
xdo103:                 ;           xdo(20,0) 103 
    push DE             ; 1:11      index(103) xi
    ex   DE, HL         ; 1:4       index(103) xi
    ld   HL, (idx103)   ; 3:16      index(103) xi   idx always points to a 16-bit index 
    call fib2           ; 3:17      call ( -- ret ) R:( -- ) 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
                        ;[12:45]    xloop 103   variant +1.B: 0 <= index < stop <= 256, run 20x
idx103 EQU $+1          ;           xloop 103   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       xloop 103   0.. +1 ..(20), real_stop:0x0014
    nop                 ; 1:4       xloop 103   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       xloop 103   index++
    ld  (idx103),A      ; 3:13      xloop 103
    xor  0x14           ; 2:7       xloop 103   lo(real_stop)
    jp   nz, xdo103     ; 3:10      xloop 103   index-stop
xleave103:              ;           xloop 103
xexit103:               ;           xloop 103
        
                        ;[16:57/58] xloop 102   variant +1.default: step one, run 1000x
idx102 EQU $+1          ;           xloop 102   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 102   0.. +1 ..(1000), real_stop:0x03E8
    inc  BC             ; 1:6       xloop 102   index++
    ld    A, C          ; 1:4       xloop 102
    xor  0xE8           ; 2:7       xloop 102   lo(real_stop) first (232>3)
    jp   nz, xdo102save ; 3:10      xloop 102   3x false positive
    ld    A, B          ; 1:4       xloop 102
    xor  0x03           ; 2:7       xloop 102   hi(real_stop)
    jp   nz, xdo102save ; 3:10      xloop 102   232x false positive if he was first
xleave102:              ;           xloop 102
xexit102:               ;           xloop 102
    
fib2_bench_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
