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
        
    push DE             ; 1:11      push2(65535,0x4000)
    ld   DE, 65535      ; 3:10      push2(65535,0x4000)
    push HL             ; 1:11      push2(65535,0x4000)
    ld   HL, 0x4000     ; 3:10      push2(65535,0x4000) 
begin101:               ;           begin 101 
                        ;[4:26]     2dup ! 2+ _2dup_store_2add   ( x addr -- x addr+2 )
    ld  (HL),E          ; 1:7       2dup ! 2+ _2dup_store_2add
    inc  HL             ; 1:6       2dup ! 2+ _2dup_store_2add
    ld  (HL),D          ; 1:7       2dup ! 2+ _2dup_store_2add
    inc  HL             ; 1:6       2dup ! 2+ _2dup_store_2add 
                        ;[11:18/39] dup 0x5B00 eq until 101   variant: lo(0x5B00) = 0
    ld    A, L          ; 1:4       dup 0x5B00 eq until 101
    or    A             ; 1:4       dup 0x5B00 eq until 101
    jp   nz, begin101   ; 3:10      dup 0x5B00 eq until 101
    ld    A, high 0x5B00; 2:7       dup 0x5B00 eq until 101
    xor   H             ; 1:4       dup 0x5B00 eq until 101
    jp   nz, begin101   ; 3:10      dup 0x5B00 eq until 101
break101:               ;           dup 0x5B00 eq until 101 
    pop  HL             ; 1:10      2drop
    pop  DE             ; 1:10      2drop ( b a -- )
    
Fillin_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
