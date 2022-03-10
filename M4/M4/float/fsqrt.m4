ifdef({USE_fSqrt},{
; ( f1 -- f2 )
; (2^+3 * mantisa)^0.5 = 2^+1 * 2^+0.5 * mantisa^0.5 = 2^+1 * 2^+0.5 ...
; *****************************************
                    fSqrt                 ; *
; *****************************************
    ld    A, H          ; 1:4
    and  0x7F           ; 2:7       abs(HL)
    add   A, 0x40       ; 2:7
    rra                 ; 1:4       A = (exp-bias)/2 + bias = (exp+bias)/2
                        ;           carry => out = out * 2^0.5
    ld    H, SQR_TAB/256; 2:7
    jr   nc, fSqrt1     ; 2:12/7
    inc   H             ; 1:4{}ifelse(carry_flow_warning,{1},{
    or    A             ; 1:4       RET with reset carry})
fSqrt1:
    ld    L, (HL)       ; 1:7
    ld    H, A          ; 1:4
    ret                 ; 1:10
})dnl
dnl
dnl
dnl
