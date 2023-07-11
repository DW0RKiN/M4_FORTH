ifdef({USE_fFloor},{dnl
__def({USE_fTrunc_abs}){}dnl
__def({USE_fAdd})
; Round towards negative infinity
; In: HL any floating-point number
; Out: HL same number rounded towards negative infinity
; Pollutes: AF,B
; *****************************************
                   fFloor                 ; *
; *****************************************
        
    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    jr   nc, fTrunc_abs ; 2:7/12    floor(0+) = ftrunc
    
    or    L             ; 1:4
    ret   z             ; 1:5/11    floor(-0.0) = -0.0
    
    push DE             ; 1:11
    ld    D, H          ; 1:4
    ld    E, L          ; 1:4
    
    res   7, H          ; 2:8
    call  fTrunc_abs    ; 3:17
    set   7, H          ; 2:8
    
    ex   DE, HL         ; 1:4
    or    A             ; 1:4
    sbc  HL, DE         ; 2:15 
    ex   DE, HL         ; 1:4

    jr    z, $+8        ; 2:7/12    ftrunc(f) == f?

    ld   DE, 0xC000     ; 3:10      -1.0
    call fAddP          ; 3:17      f+
        
    pop  DE             ; 1:10      f+
    ret                 ; 1:10
})dnl
dnl
dnl
dnl
ifdef({USE_fTrunc},{__def({USE_fTrunc_abs})
; Round towards zero
; In: HL any floating-point number
; Out: HL same number rounded towards zero
; Pollutes: AF,B
; *****************************************
                    fTrunc                ; *
; *****************************************
    
    bit   7, H          ; 2:8
    jr    z, fTrunc_abs ; 2:7/12

    res   7, H          ; 2:8
    call  fTrunc_abs    ; 3:17
    set   7, H          ; 2:8
    ret                 ; 1:10
})dnl
dnl
dnl
dnl
ifdef({USE_fTrunc_abs},{
; Round towards zero
; In: HL any positive floating-point number
; Out: HL same number rounded towards zero
; Pollutes: AF,B
; *****************************************
                  fTrunc_abs              ; *
; *****************************************

    ld    A, H          ; 1:4
    sub  0x40           ; 2:7       bias
    jr    c, fTrunc_ZERO; 2:12/7    Completely fractional
fTrunc_Next:
    sub  0x08           ; 2:7       mant bits
    ret  nc             ; 1:5/11    Already integer
    neg                 ; 2:8

    ld    B, A          ; 1:4
    ld    A, 0xFF       ; 2:7
fTrunc_Loop:            ;           odmazani mantisy za plovouci radovou carkou
    add   A, A          ; 1:4
    djnz fTrunc_Loop    ; 2:13/8
    and   L             ; 1:4
    ld    L, A          ; 1:4
    ret                 ; 1:10
fTrunc_ZERO:
    ld   HL, FPMIN      ; 3:10      fpmin
    ret                 ; 1:10
})dnl
dnl
dnl
dnl
ifdef({USE_fFrac},{
; Fractional part, remainder after division by 1
;  In: HL any floating-point number
; Out: HL fractional part, with sign intact
; Pollutes: AF, B
; *****************************************
                    fFrac                ; *
; *****************************************
    ld    A, H          ; 1:4
    and  0x7F           ; 2:7       delete sign
    cp   0x48           ; 2:7       bias + mant bits{}ifdef({USE_fTrunc},{
    jr   nc, fTrunc_ZERO; 2:7/12    Already integer},{
    jr   nc, fFrac_ZERO ; 2:7/12    Already integer})
    sub  0x40           ; 2:7       bias
    ret   c             ; 1:5/11    Pure fraction

    inc   A             ; 1:4       2^0*1.xxx > 1
    ld    B, A          ; 1:4
    ld    A, L          ; 2:7
fFrac_Loop:             ;           odmazani mantisy pred plovouci radovou carkou
    dec   H             ; 1:4
    add   A, A          ; 1:4
    djnz fFrac_Loop     ; 2:13/8

    ld    L, A          ; 1:4
    ret   c             ; 1:11/5
ifdef({USE_fTrunc},{
    jr    z, fTrunc_ZERO; 2:7/12},{
    jr    z, fFrac_ZERO ; 2:7/12})

fFrac_Norm:             ;           normalizace cisla
    dec   H             ; 1:4
    add   A, A          ; 1:4
    jr   nc, fFrac_Norm ; 2:12/7

    ld    L, A          ; 1:4
    ret                 ; 1:10
ifdef({USE_fTrunc},,{
fFrac_ZERO:
    ld    HL, FPMIN    ; 3:10      fpmin
    ret                 ; 1:10})})dnl
dnl
dnl
dnl
