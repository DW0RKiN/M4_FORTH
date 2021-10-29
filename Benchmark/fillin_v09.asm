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
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(255)
    ex   DE, HL         ; 1:4       push(255)
    ld   HL, 255        ; 3:10      push(255) 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld  (HL),E          ; 1:7       C! cstore   ( char addr -- )
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore 1
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      + 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(0x5B00)
    ex   DE, HL         ; 1:4       push(0x5B00)
    ld   HL, 0x5B00     ; 3:10      push(0x5B00) 
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ld    A, H          ; 1:4       until 101
    or    L             ; 1:4       until 101
    ex   DE, HL         ; 1:4       until 101
    pop  DE             ; 1:10      until 101
    jp    z, begin101   ; 3:10      until 101
break101:               ;           until 101 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
Fillin_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
