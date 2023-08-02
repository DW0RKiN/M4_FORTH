ifdef({USE_fExp},{{}ifdef({USE_fMul},,define({USE_fMul},{}))
; Natural exponential function
; Input: HL
; Output: HL = exp(HL) +- lowest 2 bit
; e^((2^e)*m) =
; e^((2^e)*(m1+m0.5+m0.25+m0.125+m0.0.0625))
; m1 => b1 = 1, m0.5 => b0.5 = 0 or 1, m0.25 => b0.25 = 0 or 1, ...
; e^( b1*  (2^e) + b0.5*  (2^e-1) + b0.25*  (2^e-2) + b0.125*  (2^e-3) + b0.0625*  (2^e-4) + ... ) =
;     b1*e^(2^e) * b0.5*e^(2^e-1) * b0.25*e^(2^e-2) * b0.125*e^(2^e-3) * b0.0625*e^(2^e-4) * ...
; Pollutes: AF, BC, DE
; *****************************************
                    fExp                ; *
; *****************************************
    ld    D, EXP_TAB/256; 2:7
    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    ld    E, A          ; 1:4
    jr   nc, $+3        ; 2:7/11
    inc   D             ; 1:4

    cp   2*0x37         ; 2:7
    jr    c, fExp_ONE   ; 2:7/11
    cp   2*0x46         ; 2:7
    jr   nc, fExp_FLOW  ; 2:7/11

    ld    A, L          ; 1:4       fraction

    ex   DE, HL         ; 1:4
    inc   L             ; 1:4
    ld    D,[HL]        ; 1:7
    dec   L             ; 1:4
    ld    E,[HL]        ; 1:7

fExp_0_BIT:
    jr    z, fExp_EXIT  ; 2:7/11
fExp_Loop:
    dec   L             ; 1:4       exp--
    ld    B,[HL]        ; 1:7
    dec   L             ; 1:4
    add   A, A          ; 1:4
    jr   nc, fExp_0_BIT ; 2:7/11
    ld    C,[HL]        ; 1:7

    push HL             ; 1:11
    push AF             ; 1:11
    call fMul           ; 3:17      HL = BC * DE
    pop  AF             ; 1:10
    ex   DE, HL         ; 1:4
    pop  HL             ; 1:10

    jp  fExp_Loop       ; 3:10

fExp_ONE:
    ld    DE, 0x4000    ; 3:10      bias*256
fExp_EXIT:
    ex   DE, HL         ; 1:4
    ret                 ; 1:10

fExp_FLOW:
    ld    A, H          ; 1:4
    add   A, A          ; 1:4       sign out
    jr    c, fExp_UNDER ; 2:7/11
fExp_OVER:              ;{}ifelse(carry_flow_warning,{1},{
    scf                 ; 1:4})
    ld    HL, 0x7FFF    ; 3:10      fpmax
    ret                 ; 1:10

fExp_UNDER:
    ld    HL, 0x0000    ; 3:10      fpmin
    ret                 ; 1:10})dnl
dnl
dnl
dnl
