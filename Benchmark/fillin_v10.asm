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
            
                        ;[3:16]     255 over c! 1+  push_over_cstore_1add(255)   ( addr -- addr+1 )
    ld  (HL),low 255    ; 2:10      255 over c! 1+  push_over_cstore_1add(255)
    inc  HL             ; 1:6       255 over c! 1+  push_over_cstore_1add(255)
             
                     ;[11:39/18,39] dup 0x5B00 = until 101   ( x1 -- x1 )   0x5B00 == HL
    ld    A, L          ; 1:4       dup 0x5B00 = until 101
    or    A             ; 1:4       dup 0x5B00 = until 101   L = 0x00
    jp   nz, begin101   ; 3:10      dup 0x5B00 = until 101
    ld    A, 0x5B       ; 2:7       dup 0x5B00 = until 101
    xor   H             ; 1:4       dup 0x5B00 = until 101   H = 0x5B
    jp   nz, begin101   ; 3:10      dup 0x5B00 = until 101
break101:               ;           dup 0x5B00 = until 101
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
Fillin_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
