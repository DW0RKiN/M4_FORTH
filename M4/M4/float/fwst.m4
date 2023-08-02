ifdef({USE_fIst}, {ifdef({USE_fWst},,define({USE_fWst},{}))
; Store Integer. Convert value of a floating-point number into signed 16-bit integer.
;  In: HL = floating point to convert
; Out: HL = Int representation, ??? carry if overflow
; Pollutes: AF, B
; *****************************************
                    fIst                ; *
; *****************************************
    ld    A, H          ; 1:4
    cp   0x4F           ; 2:7
    jr    c, fWst       ; 2:7/12

    add   A, A          ; 1:4
    jr   nc, fIst_OVER_P; 2:7/11

    rrca                ; 1:4
    add  A, 0xB1        ; 2:7
    jr    c, fIst_OVER_N; 2:7/12

    call fWst           ; 3:17
    xor   A             ; 1:4
    sub   L             ; 1:4
    ld    L, A          ; 1:4
    sbc   A, H          ; 1:4
    sub   L             ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10


fIst_OVER_N:
    ld   HL, 0x8000     ; 3:10
    ret                 ; 1:10

fIst_OVER_P:
    ld   HL, 0x7FFF     ; 3:10{}ifelse(carry_flow_warning,{1},{
    scf                 ; 1:4})
    ret                 ; 1:10
})dnl
dnl
dnl
ifdef({USE_fWst}, {
; Store Word. Convert absolute value of a floating-point number into unsigned 16-bit integer.
;  In: HL = floating point to convert
; Out: HL = Word representation, set carry if overflow
; Pollutes: AF, B
; *****************************************
                    fWst                ; *
; *****************************************
    ld    A, H          ; 1:4
    and  0x7F           ; 2:7       exp mask

    cp   0x50           ; 2:7       bias + 0x10
    jr   nc, fWst_OVER  ; 2:7/12

    sub  0x3F           ; 2:7       bias - 1
    jr    c, fWst_ZERO  ; 2:7/12
                        ;           A = 0..16
    if 0

    ld    B, A          ; 1:4
    ld    A, L          ; 1:4
    ld    HL, 0x0000    ; 3:10
    jr    z, fWst_Round ; 2:7/12
    scf                 ; 1:4

    adc  HL, HL         ; 2:15
    add   A, A          ; 1:4
    djnz $-3            ; 2:13/8

    ret   nc            ; 1:11/5
fWst_Round:
    or    A             ; 1:4
    ret   z             ; 1:11/5
    inc   HL            ; 1:6
    ret                 ; 1:10

    else

    ld    H, 0x01       ; 2:7
    sub  0x09           ; 2:7
    jr   nc, fWst256Plus; 2:7

    dec   HL            ; 1:6       rounding ( 0.5000 down => 0.4999 down )
    srl   H             ; 2:8
    rr    L             ; 2:8
    inc   A             ; 1:4
    jr    z, $+7        ; 2:12/7
    srl   L             ; 2:8
    inc   A             ; 1:4
    jr   nz, $-3        ; 2:12/7
    ret   nc            ; 1:11/5
    inc   L             ; 1:4{}ifelse(carry_flow_warning,{1},{
    or    A             ; 1:4})
    ret                 ; 1:10

fWst256Plus:
    ret   z             ; 1:5/11
    ld    B, A          ; 1:4
    add  HL, HL         ; 1:11
    djnz $-1            ; 2:13/8
    ret                 ; 1:10

    endif

fWst_OVER:
    ld    HL, 0xFFFF    ; 3:10{}ifelse(carry_flow_warning,{1},{
    scf                 ; 1:4})
    ret                 ; 1:10      RET with carry

fWst_ZERO:{}ifelse(carry_flow_warning,{1},{
    xor   A             ; 1:4
    ld    H, A          ; 1:4
    ld    L, A          ; 1:4},{
    ld    HL, 0x0000    ; 3:10})
    ret                 ; 1:10      RET with carry}){}dnl
dnl
dnl
dnl
