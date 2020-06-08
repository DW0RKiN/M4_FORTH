ifdef({USE_fSub}, {
        ; continue from @FMOD (if it was included)
dnl
; Subtract two floating-point numbers
;  In: HL, DE numbers to subtract, no restrictions
; Out: HL = DE - HL
; Pollutes: AF, B, DE
; *****************************************
                    fSub                ; *
; *****************************************
    ld    A, H          ; 1:4
    xor  0x80           ; 2:7       sign mask       
    ld    H, A          ; 1:4       HL = -HL
    ; continue
ifdef({USE_fAdd},,define({USE_fAdd},{}))})dnl
dnl
dnl
ifdef({USE_fAdd},{
; Add two floating-point numbers
;  In: HL, DE numbers to add, no restrictions
; Out: HL = DE + HL
; Pollutes: AF, B, DE
; *****************************************
                    fAdd                ; *
; *****************************************
    ld    A, H          ; 1:4
    xor   D             ; 1:4
    jp    m, fAdd_OP_SGN; 3:10
    ; continue
     
; Add two floating point numbers with the same sign
;  In: HL, DE numbers to add, no restrictions
; Out: HL = DE + HL,  if ( carry_flow_warning && overflow ) set carry
; Pollutes: AF, B, DE
; -------------- HL + DE ---------------
; HL = (+DE) + (+HL)
; HL = (-DE) + (-HL)
; *****************************************
                   fAddP                ; *
; *****************************************
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jr   nc, fAdd_HL_GR ; 2:7/12   
    ex   DE, HL         ; 1:4      
    neg                 ; 2:8
fAdd_HL_GR:
    and  0x7F           ; 2:7       exp mask
    jr    z, fAdd_Eq_Exp; 2:12/7    neresime zaokrouhlovani
    cp   0x0A           ; 2:7       pri posunu o NEUKLADANY_BIT+BITS_MANTIS uz mantisy nemaji prekryt, ale jeste se muze zaokrouhlovat 
    ret  nc             ; 1:11/5    HL + DE = HL, ret with reset carry

                        ;           Out: A = --( E | 1 0000 0000 ) >> A        
    ld    B, A          ; 1:4
    ld    A, E          ; 1:4
    dec   A             ; 1:4
    cp   0xFF           ; 2:7
    db   0x1E           ; 2:7       ld E, $B7
fAdd_Loop:
    or    A             ; 1:4
    rra                 ; 1:4
    djnz  fAdd_Loop     ; 2:13/8
        
    jr    c, fAdd1      ; 2:12/7

    add   A, L          ; 1:4       soucet mantis
    jr   nc, fAdd0_OkExp; 2:12/7
fAdd_Exp_PLUS:          ;           A = 10 mmmm mmmr, r = rounding bit                                    
    adc   A, B          ; 1:4       rounding
    rra                 ; 1:4       A = 01 cmmm mmmm
    ld    L, A          ; 1:4
    ld    A, H          ; 1:4        
    inc   H             ; 1:4
    xor   H             ; 1:4       ret with reset carry
    ret   p             ; 1:11/5        
    jr    fAdd_OVERFLOW ; 2:12

fAdd0_OkExp:            ;           A = 01 mmmm mmmm 0
    ld    L, A          ; 1:4
    ret                 ; 1:10   
        
fAdd1:
    add   A, L          ; 1:4       soucet mantis
    jr    c, fAdd_Exp_PLUS; 2:12/7
        
fAdd1_OkExp:            ;           A = 01 mmmm mmmm 1, reset carry
ifelse({1},{0},{
    ld    L, A          ; 1:4
    inc   L             ; 1:4
    ret  nz             ; 1:11/5
        
    ld    A, H          ; 1:4        
    inc   H             ; 1:4
    xor   H             ; 1:4       ret with reset carry
    ret   p             ; 1:11/5},{
    ld    L, A          ; 1:4
    ld    A, H          ; 1:4        
    inc  HL             ; 1:6
    xor   H             ; 1:4       ret with reset carry
    ret   p             ; 1:11/5})
    jr   fAdd_OVERFLOW  ; 2:12

fAdd_Eq_Exp:            ;           HL exp = DE exp
    ld    A, L          ; 1:4       1 mmmm mmmm
    add   A, E          ; 1:4      +1 mmmm mmmm
                        ;           1m mmmm mmmm
    rra                 ; 1:4       sign in && shift       
    ld    L, A          ; 1:4
        
    ld    A, H          ; 1:4        
    inc   H             ; 1:4
    xor   H             ; 1:4       ret with reset carry
    ret   p             ; 1:11/5
    ; fall

; In: H = s111 1111 + 1
; Out: HL = +- MAX
fAdd_OVERFLOW:
    dec   H             ; 1:4      
    ld    L, $FF        ; 2:7{}ifelse(carry_flow_warning,{1},{
    scf                 ; 1:4       carry = error})
    ret                 ; 1:10
    
    
; Subtraction two floating-point numbers with the same signs
;  In: HL,DE numbers to add, no restrictions
; Out: HL = DE + HL, if ( carry_flow_warning && underflow ) set carry
; Pollutes: AF, BC, DE
; -------------- HL - DE ---------------
; HL = (+DE) - (+HL) = (+DE) + (-HL)
; HL = (-DE) - (-HL) = (-DE) + (+HL)
; *****************************************
                   fSubP                ; *
; *****************************************
    ld    A, D          ; 1:4 
    xor  0x80           ; 2:7       sign mask 
    ld    D, A          ; 1:4 

; Add two floating-point numbers with the opposite signs
;  In: HL, DE numbers to add, no restrictions
; Out: HL = HL + DE
; Pollutes: AF, B, DE
; -------------- HL + DE ---------------
; HL = (+DE) + (-HL)
; HL = (-DE) + (+HL)
fAdd_OP_SGN:
    ld    A, H          ; 1:4 
    sub   D             ; 1:4 
    jp    m, fSub_HL_GR ; 3:10 
    ex   DE, HL         ; 1:4 
    ld    A, H          ; 1:4 
    sub   D             ; 1:4 
fSub_HL_GR:
    and  0x7F           ; 2:7       exp mask 
    jr    z, fSub_Eq_Exp; 2:12/7 

    cp   0x0A           ; 2:7       pri posunu vetsim nez o MANT_BITS + NEUKLADANY_BIT + ZAOKROUHLOVACI_BIT uz mantisy nemaji prekryt
    jr   nc, fSub_TOOBIG; 2:12/7    HL - DE = HL
        
                        ;           Out: E = ( E | 1 0000 0000 ) >> A        
    ld    B, A          ; 1:4 
    ld    A, E          ; 1:4 
    rra                 ; 1:4       1mmm mmmm m
    dec   B             ; 1:4 
    jr    z, fSub_NOLoop; 2:12/7 
    dec   B             ; 1:4 
    jr    z, fSub_LAST  ; 2:12/7 
fSub_Loop:
    or    A             ; 1:4 
    rra                 ; 1:4 
    djnz fSub_Loop      ; 2:13/8 
fSub_LAST:
    rl    B             ; 2:8       B = rounding 0.25
    rra                 ; 1:4         
fSub_NOLoop:            ;           carry = rounding 0.5
    ld    E, A          ; 1:4 
    ld    A, L          ; 1:4               
        
    jr    c, fSub1      ; 2:12/7 
        
    sub   E             ; 1:4 
    jr   nc, fSub0_OkExp; 2:12/7 
        
fSub_Norm_RESET:
    or    A             ; 1:4 
fSub_Norm:              ;           normalizace cisla
    dec   H             ; 1:4       exp--
    adc   A, A          ; 1:4 
    jr   nc, fSub_Norm  ; 2:7/12 
        
    sub   B             ; 1:4 
        
    ld    L, A          ; 1:4         
    ld    A, D          ; 1:4 
    xor   H             ; 1:4 
    ret   m             ; 1:11/5    RET with reset carry
    jr   fSub_UNDER     ; 2:12 

fSub0_OkExp:            ;           reset carry
    ld    L, A          ; 1:4       
    ret   nz            ; 1:11/5 

    sub   B             ; 1:4       exp--? => rounding 0.25 => 0.5 
    ret   z             ; 1:11/5 

    dec   HL            ; 1:6 
    ld    A, D          ; 1:4 
    xor   H             ; 1:4 
    ret   m             ; 1:11/5    RET with reset carry
    jr   fSub_UNDER     ; 2:12 

fSub1:
    sbc   A, E          ; 1:4       rounding half down
    jr    c, fSub_Norm  ; 2:12/7    carry => need half up
    ld    L, A          ; 1:4  
    ret                 ; 1:10 
   
fSub_Eq_Exp:
    ld    A, L          ; 1:4 
    sub   E             ; 1:4 
    jr    z, fSub_UNDER ; 2:12/7    (HL_exp = DE_exp && HL_mant = DE_mant) => HL = -DE
    jr   nc, fSub_EqNorm; 2:12/7 
    ex   DE, HL         ; 1:4 
    neg                 ; 2:8 

fSub_EqNorm:            ;           normalizace cisla
    dec   H             ; 1:4       exp--
    add   A, A          ; 1:4       musime posouvat minimalne jednou, protoze NEUKLADANY_BIT byl vynulovan
    jr   nc, fSub_EqNorm; 2:7/12 
        
    ld    L, A          ; 1:4         
    ld    A, D          ; 1:4 
    xor   H             ; 1:4  
    ret   m             ; 1:11/5 

fSub_UNDER:
    ld    L, 0x00       ; 2:7       
    ld    A, D          ; 1:4 
    cpl                 ; 1:4 
    and  0x80           ; 2:7       sign mask 
    ld    H, A          ; 1:4{}ifelse(carry_flow_warning,{1},{
    scf                 ; 1:4       carry = error})
    ret                 ; 1:10 

fSub_TOOBIG:
    ret   nz            ; 1:11/5    HL_exp - DE_exp > 7+1+1 => HL - DE = HL

    ld    A, L          ; 1:4 
    or    A             ; 1:4 
    ret   nz            ; 1:11/5    HL_mant > 1.0           => HL - DE = HL

    dec   L             ; 1:4 
    dec   H             ; 1:4       HL_exp = 8 + 1 + DE_exp  => HL_exp >= 9 => not underflow
    ret                 ; 1:10 
})dnl
dnl
dnl
