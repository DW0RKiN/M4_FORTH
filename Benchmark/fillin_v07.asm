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
        
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    ld   BC, 16384      ; 3:10      xdo_drop_xi(23296,16384) 101
xdo101save:             ;           xdo_drop_xi(23296,16384) 101
    ld  (idx101),BC     ; 4:20      xdo_drop_xi(23296,16384) 101
xdo101:                 ;           xdo_drop_xi(23296,16384) 101
    ld    H, B          ; 1:4       xdo_drop_xi(23296,16384) 101
    ld    L, C          ; 1:4       xdo_drop_xi(23296,16384) 101 
                        ;[6:32]     65535 over ! push_over_store(65535)   ( addr -- addr )
    ld  (HL),low 65535  ; 2:10      65535 over ! push_over_store(65535)
    inc  HL             ; 1:6       65535 over ! push_over_store(65535)
    ld  (HL),high 65535 ; 2:10      65535 over ! push_over_store(65535)
    dec  HL             ; 1:6       65535 over ! push_over_store(65535) 
                        ;[11:61/41] 2 +xloop 101   variant +2.D: step 2 with hi(real_stop) exclusivity, run 3456x
idx101 EQU $+1          ;           2 +xloop 101   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +xloop 101   16384.. +2 ..(23296), real_stop:0x5B00
    inc   C             ; 1:4       2 +xloop 101   index++
    inc  BC             ; 1:6       2 +xloop 101   index++
    ld    A, B          ; 1:4       2 +xloop 101
    xor  0x5B           ; 2:7       2 +xloop 101   hi(real_stop)
    jp   nz, xdo101save ; 3:10      2 +xloop 101
xleave101:              ;           2 +xloop 101
xexit101:               ;           2 +xloop 101 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
Fillin_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
