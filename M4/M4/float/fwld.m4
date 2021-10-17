ifdef({USE_fIld}, {ifdef({USE_fWld},,define({USE_fWld},{}))
; Load Integer. Convert signed 16-bit integer into floating-point number
;  In: HL = Integer to convert
; Out: HL = floating point representation
; Pollutes: AF
; *****************************************
                    fIld                ; *
; *****************************************
    bit   7, H          ; 2:8
    jr    z, fWld       ; 2:7/12
    xor   A             ; 1:4
    sub   L             ; 1:4
    ld    L, A          ; 1:4
    sbc   A, H          ; 1:4
    sub   L             ; 1:4
    ld    H, A          ; 1:4
    ld    A, 0xD0       ; 2:7       sign+bias+16
    jr   nz, fWld_NORM  ; 2:7/12

    ld    H, 0xC8       ; 2:7       sign+bias+8
    ld    A, L          ; 1:4
    jp    fWld_B_NORM   ; 3:10}){}dnl
dnl
dnl
dnl
ifdef({USE_fWld}, {
; Load Word. Convert unsigned 16-bit integer into floating-point number
;  In: HL = Word to convert
; Out: HL = floating point representation
; Pollutes: AF
; *****************************************
                    fWld                ; *
; *****************************************
    ld    A, H          ; 1:4       HL = xxxx xxxx xxxx xxxx 
    or    A             ; 1:4 
    jr    z, fWld_B     ; 2:12/7 
    ld    A, 0x50       ; 2:7       bias+16
fWld_NORM:
    add  HL, HL         ; 1:11 
    dec   A             ; 1:4 
    jp   nc, fWld_NORM  ; 3:10        
        
    sla   L             ; 2:8       rounding
    ld    L, H          ; 1:4 
    ld    H, A          ; 1:4 
    ret   nc            ; 1:11/5 
    ccf                 ; 1:4 
    ret   z             ; 1:11/5 
    inc   L             ; 1:4       rounding up
    ret   nz            ; 1:11/5 
    inc   H             ; 1:4       exp++
    ret                 ; 1:10 
        
fWld_B:                 ;           HL = 0000 0000 xxxx xxxx
    or    L             ; 1:4 
    ret   z             ; 1:5/11 
                
    ld    H, 0x48       ; 2:7       bias+8
fWld_B_NORM:
    dec   H             ; 1:4 
    add   A, A          ; 1:4 
    jr   nc, fWld_B_NORM; 2:12/7 

    ld    L, A          ; 1:4 
    ret                 ; 1:10}){}dnl
dnl
dnl
