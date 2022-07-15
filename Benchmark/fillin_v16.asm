ORG 32768

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init

    push HL             ; 1:11      fillin   save TOS
    ld   HL, 0x4000     ; 3:10      fillin
    ld    A, 0x5B       ; 2:7       fillin 
    ld   BC, 0x00FF     ; 3:10      fillin 
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   1x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   2x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   3x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:6       fillin   4x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   5x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   6x
    ld  (HL),C          ; 1:7       fillin
    inc   L             ; 1:4       fillin   7x
    ld  (HL),C          ; 1:7       fillin
    inc  HL             ; 1:6       fillin   8x
    cp    H             ; 1:4       fillin
    jp   nz, $-17       ; 3:10      fillin
    pop  HL             ; 1:10      fillin   load TOS

Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====   
