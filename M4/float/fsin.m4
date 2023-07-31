ifdef({USE_fSin},{
; Trigonometric function sine
; Input: HL -π/2..π/2
; Output: HL = sin[HL]
; Pollutes: AF, DE
; *****************************************
                    fSin                ; *
; *****************************************

    ld    A, H          ; 1:4
    and  0x7F           ; 2:7       abs[HL]
    sub  0x3F           ; 2:7
    jr   nc, fSin_3F40  ; 2:12/7
    add   A, 0x02       ; 2:7
    jr    c, fSin_3D3E  ; 2:12/7
    inc   A             ; 1:4
    ret   nz            ; 1:5/11
    ld    A, 0x71       ; 2:7
    sub   L             ; 1:4
    ret   nc            ; 1:5/11{}ifelse(carry_flow_warning,{1},{
    or    A             ; 1:4       reset carry})
    dec   L             ; 1:4
    ret                 ; 1:10
fSin_3D3E:
    ld    D, SinTab_3D3E/256; 2:7
    rra                 ; 1:4
    ld    A, L          ; 1:4
    rra                 ; 1:4
    ld    E, A          ; 1:4
    ld    A, [DE]       ; 1:7
    jr    c, $+6        ; 2:12/7
    rra                 ; 1:4
    rra                 ; 1:4
    rra                 ; 1:4
    rra                 ; 1:4
    or   0xF0           ; 2:7
    rl    E             ; 2:8

    jr   nc, fSin_OK    ; 2:12/7
    jp    p, fSin_OK    ; 3:10
    sub  0x08           ; 2:7
fSin_OK:
    ld    E, A          ; 1:4
    ld    D, 0xFF       ; 2:7
    add  HL, DE         ; 1:11{}ifelse(carry_flow_warning,{1},{
    or    A             ; 1:4       reset carry})
    ret                 ; 1:10
fSin_3F40:
    add   A, high SinTab_3F ; 2:7
    ex   DE, HL         ; 1:4
    ld    H, A          ; 1:4
    ld    L, E          ; 1:4
    ld    L, [HL]       ; 1:7
    ld    H, 0xFF       ; 2:7
    add  HL, DE         ; 1:11{}ifelse(carry_flow_warning,{1},{
    or    A             ; 1:4       reset carry})
    ret                 ; 1:10})dnl
dnl
dnl
dnl
