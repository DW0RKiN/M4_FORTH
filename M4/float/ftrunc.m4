ifdef({USE_fTrunc},{
; Round towards zero
; In: HL any floating-point number
; Out: HL same number rounded towards zero
; Pollutes: AF,B
; *****************************************
                    fTrunc                ; *
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
    ld   HL, FPMIN     ; 3:10      fpmin
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
