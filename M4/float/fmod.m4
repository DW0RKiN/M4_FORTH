ifdef({USE_fMod},{
; Remainder after division
;  In: BC dividend, HL modulus
; Out: HL = BC % HL = BC - int(BC/HL) * HL = frac(BC/HL) * HL  => does not return correct results with larger exponent difference
; Pollutes: AF, BC, DE
; *****************************************
                    fMod                ; *
; *****************************************

    res   7, H          ; 2:8       HL = abs(HL), exp HL will be used for the result
    ld    A, B          ; 1:4
    and  0x80           ; 2:7       sign mask
    ld    D, A          ; 1:4       Result sign only
    xor   B             ; 1:4
    sub   H             ; 1:4
    jr    c, fMod_HL_GR ; 2:12/7
    ld    E, A          ; 1:4       diff exp
    ld    A, C          ; 1:4
    jr   nz, fMod_Sub   ; 2:12/7

    cp    L             ; 1:4
    jr    z, fMod_FPmin ; 2:12/7
    jr    c, fMod_HL_GR ; 2:12/7

fMod_Sub:               ;           BC_mantis - HL_mantis
    sub   L             ; 1:4
    jr    z, fMod_FPmin ; 2:7/11    fpmin
    jr   nc, fMod_NORM  ; 2:7/11

; fMod_Add_HALF:
    dec   E             ; 1:4
    jp    m, fMod_STOP  ; 3:10

    add   A, A          ; 1:4
    jr   nc, fMod_X     ; 2:7/11
    add   A, L          ; 1:4
    jr    c, fMod_Sub   ; 2:7/11
    db   0x06           ;           ld B, $85
fMod_X:
    add   A, L          ; 1:4

fMod_NORM:
    add   A, A          ; 1:4
    dec   E             ; 1:4
    jr   nc, fMod_NORM  ; 2:7/11

    jp    p, fMod_Sub   ; 3:10      E >= 0

    ld    L, A          ; 1:4
    ld    A, H          ; 1:4
    add   A, E          ; 1:4
    xor   D             ; 1:4
    ld    H, A          ; 1:4
    xor   D             ; 1:4
    ret   p             ; 1:5/11
;       fall

; Input: D = sign only
fMod_UNDERFLOW:
    ld    H, D          ; 1:4
    ld    L, 0x00       ; 2:7{}ifelse(carry_flow_warning,{1},{
    scf                 ; 1:4       carry = error})
    ret                 ; 1:10

fMod_STOP:
    add   A, L          ; 1:4
    ld    L, A          ; 1:4
    ld    A, H          ; 1:4
    xor   D             ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10

fMod_HL_GR:{}ifelse(carry_flow_warning,{1},{
    or    A             ; 1:4})
    ld    H, B          ; 1:4
    ld    L, C          ; 1:4
    ret                 ; 1:10

fMod_FPmin:             ;           RET with reset carry
    ld    L, 0x00       ; 2:7
    ld    H, D          ; 1:4
    ret                 ; 1:10})dnl
dnl
dnl
