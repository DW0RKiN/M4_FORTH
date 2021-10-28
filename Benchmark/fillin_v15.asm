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
        
    push DE             ; 1:11      0x4000 6912 255 fill
    push HL             ; 1:11      0x4000 6912 255 fill
    ld   HL, 0x4000     ; 3:10      0x4000 6912 255 fill HL = from
    ld   DE, 0x4000+1   ; 3:10      0x4000 6912 255 fill DE = to
    ld   BC, 6912-1     ; 3:10      0x4000 6912 255 fill
    ld  (HL),255        ; 2:10      0x4000 6912 255 fill
    ldir                ; 2:u*21/16 0x4000 6912 255 fill
    pop  HL             ; 1:10      0x4000 6912 255 fill
    pop  DE             ; 1:10      0x4000 6912 255 fill
    
Fillin_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
