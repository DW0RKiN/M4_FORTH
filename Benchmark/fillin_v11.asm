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
        
    push DE             ; 1:11      push(0x4000)
    ex   DE, HL         ; 1:4       push(0x4000)
    ld   HL, 0x4000     ; 3:10      push(0x4000) 
begin101:               ;           begin 101 
                        ;[6:32]     65535 over ! 2+ push_over_store_2add(65535)   ( addr -- addr+2 )
    ld  (HL),low 65535  ; 2:10      65535 over ! 2+ push_over_store_2add(65535)
    inc  HL             ; 1:6       65535 over ! 2+ push_over_store_2add(65535)
    ld  (HL),high 65535 ; 2:10      65535 over ! 2+ push_over_store_2add(65535)
    inc  HL             ; 1:6       65535 over ! 2+ push_over_store_2add(65535) 
                        ;[6:21]     dup 0x5B00 hi_eq until 101
    ld    A, H          ; 1:4       dup 0x5B00 hi_eq until 101
    xor  high 0x5B00    ; 2:7       dup 0x5B00 hi_eq until 101   hi(TOS) ^ hi(stop)
    jp   nz, begin101   ; 3:10      dup 0x5B00 hi_eq until 101
break101:               ;           dup 0x5B00 hi_eq until 101 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
Fillin_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
