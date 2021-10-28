    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    
    call Fillin         ; 3:17      scall
    
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====   
    
;   ---  the beginning of a data stack function  ---
Fillin:                 ;           ( -- )
         
    push DE             ; 1:11      push2(65535,0)
    ld   DE, 65535      ; 3:10      push2(65535,0)
    push HL             ; 1:11      push2(65535,0)
    ld   HL, 0          ; 3:10      push2(65535,0) 
    ld   BC, 16384      ; 3:10      xdo(23296,16384) 101
xdo101save:             ;           xdo(23296,16384) 101
    ld  (idx101),BC     ; 4:20      xdo(23296,16384) 101
xdo101:                 ;           xdo(23296,16384) 101 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 
    push DE             ; 1:11      index(101) xi
    ex   DE, HL         ; 1:4       index(101) xi
    ld   HL, (idx101)   ; 3:16      index(101) xi   idx always points to a 16-bit index 
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup ( a b -- a b a b ) 
                        ;[5:40]     ! store   ( x addr -- )
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store 
                        ;[10:57/37] xloop 101   variant +1.I: step one with hi(real_stop) exclusivity, run 6912x
idx101 EQU $+1          ;           xloop 101   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      xloop 101   16384.. +1 ..(23296), real_stop:0x5B00
    inc  BC             ; 1:6       xloop 101   index++
    ld    A, B          ; 1:4       xloop 101
    xor  0x5B           ; 2:7       xloop 101   hi(real_stop)
    jp   nz, xdo101save ; 3:10      xloop 101
xleave101:              ;           xloop 101
xexit101:               ;           xloop 101 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )
    
Fillin_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
