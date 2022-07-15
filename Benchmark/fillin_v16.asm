ORG 32768

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init

    push HL             ; 1:11      fillin   save TOS
    ld   HL, 0xFFFF     ; 3:10      fillin
    ld    B, 216        ; 2:7       fillin
    di                  ; 1:4       fillin
    ld  ($+7+16+3),SP   ; 4:20      fillin
    ld   SP, 0x5B00     ; 3:10      fillin

    push HL             ; 1:11      fillin   2x
    push HL             ; 1:11      fillin   4x
    push HL             ; 1:11      fillin   6x
    push HL             ; 1:11      fillin   8x
    push HL             ; 1:11      fillin   10x
    push HL             ; 1:11      fillin   12x
    push HL             ; 1:11      fillin   14x
    push HL             ; 1:11      fillin   16x

    push HL             ; 1:11      fillin   18x
    push HL             ; 1:11      fillin   20x
    push HL             ; 1:11      fillin   22x
    push HL             ; 1:11      fillin   24x
    push HL             ; 1:11      fillin   26x
    push HL             ; 1:11      fillin   28x
    push HL             ; 1:11      fillin   30x
    push HL             ; 1:11      fillin   32x

    djnz $-16           ; 2:8/13    fillin
    ld   SP, 0x0000     ; 3:10      fillin
    ei                  ; 1:4       fillin
    pop  HL             ; 1:10      fillin   load TOS

Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====   
