ifdef({USE_fLn},{ifdef({USE_fAdd},,define({USE_fAdd},{}))
; logaritmus naturalis
; Input: HL 
; Output: HL = ln(abs(HL)) +- lowest bit (with exponent -1($7E) the error is bigger...)
; ln(2^e*m) = ln(2^e) + ln(m) = e*ln(2) + ln(m) = ln2_exp[e] + ln_m[m]
; Pollutes: AF, B, DE
; *****************************************
                     fLn                ; *
; *****************************************
                        ;           fixes input errors with exponent equal to -1 
    ld    A, H          ; 1:4        
    add   A, A          ; 1:4 
    xor  2*0x3F         ; 2:7 
    jr    z, fLn_FIX    ; 2:12/7  

    ld    A, H          ; 1:4       save

    ld    H, high Ln_M  ; 2:7       Ln_M[]        
    ld    E, (HL)       ; 1:7 
    inc   H             ; 1:4       hi Ln_M[]
    ld    D, (HL)       ; 1:7 

    add   A, A          ; 1:4       sign out, HL = abs(HL)
    ld    L, A          ; 1:4 
    cp   0x80           ; 2:7       2*bias 
    jr    z, fLn_NO_Add ; 2:7/11 

    inc   H             ; 1:4       Ln2_Exp[]

    ld    A, (HL)       ; 1:7 
    inc   L             ; 1:4 
    ld    H, (HL)       ; 1:7 
    ld    L, A          ; 1:4 
        
    ld    A, D          ; 1:4 
    or    E             ; 1:4 
    jp   nz, fAdd       ; 3:10      HL = HL + DE = +-Ln2_Exp[] + Ln_M[]
    ret                 ; 1:10 
        
fLn_FIX:
    ld    H, high Ln_FIX; 2:7 
    ld    E, (HL)       ; 1:7 
    inc   H             ; 1:4 
    ld    D, (HL)       ; 1:7 

fLn_NO_Add:
    ex   DE, HL         ; 1:4 
    ret                 ; 1:10})
dnl
dnl
dnl
