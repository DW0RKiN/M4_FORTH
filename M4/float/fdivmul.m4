dnl
dnl
ifdef({USE_fDiv},{ifdef({USE_fMul},,define({USE_fMul},{}))
;  Input:  BC, HL with a mantissa equal to 1.0 (eeee eeee s000 0000)
; Output: HL = BC / HL = BC / (1.0 * 2^HL_exp) = BC * 1.0 * 2^-HL_exp, if ( overflow or underflow ) set carry
; Pollutes: AF, BC, DE

;# if ( 1.m = 1.0 ) => 1/(2^x * 1.0) = 1/2^x * 1/1.0 = 2^-x * 1.0    
;# New_sign = BC_sign ^ HL_sign
;# New_exp  = (BC_exp - bias) + ( bias - HL_exp ) + bias = bias + BC_exp - HL_exp
;# New_mant = BC_mant * 1.0 = BC_mant
; *****************************************
                 fDiv_POW2              ; *
; *****************************************
    ld    A, B          ; 1:4       BC_exp
    sub   H             ; 1:4      -HL_exp
    add   A, 0x40       ; 2:7       bias
    ld    L, A          ; 1:4 
    xor   H             ; 1:4       xor sign
    xor   B             ; 1:4       xor sign
    jp    m, fDiv_FLOW  ; 3:10 
    ld    H, L          ; 1:4 
    ld    L, C          ; 1:4 
    ret                 ; 1:10 
fDiv_FLOW:        
    bit   6, L          ; 2:8       sign+(0x00..0x3F)=overflow, sign+(0x41..0x7F)=underflow
    jr    z, fDiv_OVER  ; 2:12/7 
        
fDiv_UNDER:      
    ld    A, L          ; 1:4 
    cpl                 ; 1:4 
    and  0x80           ; 2:7       sign mask
    ld    H, A          ; 1:4 
    ld    L, 0x00       ; 2:7{}ifelse(carry_flow_warning,{1},{
    scf                 ; 1:4       carry = error})
    ret                 ; 1:10 

fDiv_OVER:
    ld    A, L          ; 1:4 
    cpl                 ; 1:4 
    or   0x7F           ; 2:7       exp mask
    ld    H, A          ; 1:4 
    ld    L, 0xFF       ; 2:7{}ifelse(carry_flow_warning,{1},{
    scf                 ; 1:4       carry = error})
    ret                 ; 1:10 
     
; ---------------------------------------------
;  Input:  BC , HL
; Output: HL = BC / HL   =>   DE = 1 / HL   =>   HL = BC * DE
; if ( 1.m = 1.0 ) => 1/(2^x * 1.0) = 1/2^x * 1/1.0 = 2^-x * 1.0    
; if ( 1.m > 1.0 ) => 1/(2^x * 1.m) = 1/2^x * 1/1.m = 2^-x * 0.9999 .. 0.5001   =>   2^(-x-1) * 1.0002 .. 1.9998    
; Pollutes: AF, BC, DE
; *****************************************
                    fDiv                ; *
; *****************************************
    ld    A, L          ; 1:4 
    or    A             ; 1:4 
    jr    z, fDiv_POW2  ; 2:12/7 
    ld    A, H          ; 1:4       NegE - 1 = (0 - (E - bias)) + bias - 1 = 2*bias - E - 1 = 128 - E - 1 = 127 - E
    xor  0x7F           ; 2:7       NegE = 127 - E = 0x7F - E = 0x7F XOR E     
    ld    D, A          ; 1:4 

    ld    H, DIVTAB/256 ; 2:7 
    ld    E, (HL)       ; 1:7 
    ; continues with fMul (HL = BC * DE), DE = 1 / HL}){}dnl
dnl
dnl
ifdef({USE_fMul},{
; Floating-point multiplication
;  In: DE, BC multiplicands
; Out: HL = BC * DE, if ( carry_flow_warning && (overflow || underflow )) set carry;
; Pollutes: AF, BC, DE

; SEEE EEEE MMMM MMMM
; Sign       0 .. 1           = 0??? ???? ???? ???? .. 1??? ???? ???? ???? 
; Exp      -64 .. 63          = ?000 0000 ???? ???? .. ?111 1111 ???? ????;   (Bias 64 = 0x40)
; Mantis   1.0 .. 1.99609375  = ???? ???? 0000 0000 .. ???? ???  1111 1111 = 1.0000 0000 .. 1.1111 1111
; use POW2TAB
; *****************************************
                   fMul                 ; *
; *****************************************
    ld    A, B          ; 1:4 
    add   A, D          ; 1:4 
    sub  0x40           ; 2:7       HL_exp = (BC_exp-bias + DE_exp-bias) + bias = BC_exp + DE_exp - bias
    ld    H, A          ; 1:4       seee eeee
        
    xor   B             ; 1:4 
    xor   D             ; 1:4 
    jp    m, fMul_FLOW  ; 3:10 
    ld    B, H          ; 1:4       seee eeee
fMul_HOPE:

    ld    A, C          ; 1:4 
    sub   E             ; 1:4 
    jr   nc, fMul_DIFF  ; 2:12/7 
    ld    A, E          ; 1:4 
    sub   C             ; 1:4 
fMul_DIFF:
    ld    L, A          ; 1:4       L = a - b
    ld    A, E          ; 1:4 
    ld    H, Tab_AmB/256; 2:7           
    ld    E, (HL)       ; 1:7 
    inc   H             ; 1:4         
    ld    D, (HL)       ; 1:7 
    add   A, C          ; 1:4 
    ld    L, A          ; 1:4       L = a + b
        
    sbc   A, A          ; 1:4 
    add   A, A          ; 1:4 
    add   A, Tab_ApB/256; 2:7 
    ld    H, A          ; 1:4 
        
    ld    A, (HL)       ; 1:4 
    add   A, E          ; 1:4 
    ld    E, A          ; 1:4       for rounding
    inc   H             ; 1:4 
    ld    A, (HL)       ; 1:4 
    adc   A, D          ; 1:4   
    ld    H, A          ; 1:4 
    ld    L, E          ; 1:4 
           
    jp    p, fMul_NOADD ; 3:10      (ApB)+(AmB) >= 0x4000 => pricti: 0x00
                        ;           (ApB)+(AmB) >= 0x8000 => pricti: 0x20
    ld   DE, 0x0020     ; 3:10
    add  HL, DE         ; 1:11 
    add  HL, HL         ; 1:11 

    ld    L, H          ; 1:4 
    ld    H, B          ; 1:4         

    inc   H             ; 1:4 
    ld    A, B          ; 1:4 
    xor   H             ; 1:4 
    ret   p             ; 1:11/5 
        
; In: B sign
fMul_OVER:
    ld    A, B          ; 1:4 
fMul_OVER_A:
    or   0x7F           ; 2:7       exp_mask
    ld    H, A          ; 1:4 
    ld    L, 0xFF       ; 2:7{}ifelse(carry_flow_warning,{1},{
    scf                 ; 1:4       carry = error})
    ret                 ; 1:10 

fMul_NOADD:
    add  HL, HL         ; 1:11 
    add  HL, HL         ; 1:11 

    ld    L, H          ; 1:4 
    ld    H, B          ; 1:4{}ifelse(carry_flow_warning,{1},{
    or    A             ; 1:4})
    ret                 ; 1:10 
        
fMul_FLOW:
    ld    A, H          ; 1:4 
    cpl                 ; 1:4       real sign
    bit   6, H          ; 2:8       sign+(0x00..0x3E)=overflow, sign+(0x40..0x7F)=underflow
    jr    z, fMul_OVER_A; 2:12/7 

    add   A, A          ; 1:4       sign out
    jr   nz, fMul_UNDER ; 2:12/7 
        
    rra                 ; 1:4 
    ld    B, A          ; 1:4       s000 0000 
    call fMul_HOPE      ; 3:17      exp+1
    ld    A, H          ; 1:4 
    dec   H             ; 1:4       exp-1
    xor   H             ; 1:4 
    ret   p             ; 1:11/5   
        
    xor   H             ; 1:4       sign
    add   A, A          ; 1:4       sign out
                
fMul_UNDER:
    ld   HL, 0x0100     ; 3:10
    rr    H             ; 2:8       sign in, set carry
    ret                 ; 1:10}){}dnl
dnl
dnl
