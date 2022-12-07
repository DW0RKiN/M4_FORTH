dnl ## Binary Division by a Constant, variant 1
define({__},{})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 2
define({_2UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_2UDIV},{2u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[4:16]     __INFO   Variant HL/2 = HL >> 1
    srl   H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO         HL >>= 1{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 3
define({_3UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_3UDIV},{3u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(TYPDIV,{small},{
                        ;[26:248]   __INFO   Variant HL/3 = (HL*257*85) >> 16 = (HL*(1+1/256)*b_0101_0101) >> 8
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    ld    A, 0xf8       ; 2:7       __INFO         b_1111_1000
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x --> 10x --> 42x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 4x --> 20x --> 84x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 5x --> 21x --> 85x
    jp    m, $-7        ; 3:10      __INFO
    ld   BC, 0x0055     ; 3:10      __INFO         rounding down constant
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 85x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       __INFO
    adc   A, 0x00       ; 2:7       __INFO         + carry
    ld    H, A          ; 1:4       __INFO         HL = HL/3 = HL*(65536/65536)/3 = HL*21845/65536 = (HL*(1+256)*85) >> 16},
__{}{
                        ;[35:212]   __INFO   Variant HL/3 = (HL*257*85) >> 16 = (HL*(1+1/256)*b_0101_0101) >> 8
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 4x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 5x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 10x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 20x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 21x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 42x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 84x
    add  HL, BC         ; 1:11      __INFO
    ld   BC, 0x0055     ; 3:10      __INFO         rounding down constant
    adc   A, B          ; 1:4       __INFO      +1 AHL = 85x
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 85x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       __INFO
    adc   A, 0x00       ; 2:7       __INFO         + carry
    ld    H, A          ; 1:4       __INFO         HL = HL/3 = HL*(65536/65536)/3 = HL*21845/65536 = (HL*(1+256)*85) >> 16{}dnl
})})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 4
define({_4UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_4UDIV},{4u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:32]     __INFO   Variant HL/4 = HL >> 2
    srl   H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO         HL >>= 1
    srl   H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO         HL >>= 1{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 5
define({_5UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_5UDIV},{5u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_5UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[33:197]   __INFO   Variant HL/5 = (HL*257*51) >> 16 = (HL*257*b_0011_0011) >> 16
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 3x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 6x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 12x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 24x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 25x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 50x
    add  HL, BC         ; 1:11      __INFO
    ld   BC, 0x0033     ; 3:10      __INFO         rounding down constant
    adc   A, B          ; 1:4       __INFO      +1 AHL = 51x
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 51x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       __INFO
    adc   A, 0x00       ; 2:7       __INFO         + carry
    ld    H, A          ; 1:4       __INFO         HL = HL/5 = HL*(65536/65536)/5 = HL*13107/65536 = (HL*(1+256)*51) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 6
define({_6UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_6UDIV},{6u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_6UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(TYPDIV,{small},{
                        ;[29:260]   __INFO   Variant HL/6 = (HL*257*85) >> 17 = (HL*(1+1/256)*b_0101_0101) >> (1+8)
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    ld    A, 0xf8       ; 2:7       __INFO         b_1111_1000
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x --> 10x --> 42x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 4x --> 20x --> 84x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 5x --> 21x --> 85x
    jp    m, $-7        ; 3:10      __INFO
    ld   BC, 0x0055     ; 3:10      __INFO         rounding down constant
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 85x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    adc   A, 0x00       ; 2:7       __INFO         + carry
    rra                 ; 1:4       __INFO
    rr    H             ; 2:8       __INFO         AH >>= 1
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO         HL = HL/6 = HL*(2*65536/2*65536)/6 = HL*21845/(2*65536) = (HL*(1+256)*85) >> (1+16)},
__{}{
                        ;[38:224]   __INFO   Variant HL/6 = (HL*257*85) >> 17 = (HL*(1+1/256)*b_0101_0101) >> (1+8)
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 4x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 5x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 10x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 20x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 21x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 42x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 84x
    add  HL, BC         ; 1:11      __INFO
    ld   BC, 0x0055     ; 3:10      __INFO         rounding down constant
    adc   A, B          ; 1:4       __INFO      +1 AHL = 85x
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 85x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    adc   A, 0x00       ; 2:7       __INFO         + carry
    rra                 ; 1:4       __INFO
    rr    H             ; 2:8       __INFO         AH >>= 1
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO         HL = HL/6 = HL*(2*65536/2*65536)/6 = HL*21845/(2*65536) = (HL*(1+256)*85) >> (1+16){}dnl
})})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 7
define({_7UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_7UDIV},{7u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_7UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[22:467]   __INFO   Variant HL/7 = HL/8 + HL/(7*8) = HL/8 + HL/64 + HL/(7*8*8) = HL/8 + HL/64 + HL/512 + HL/4096 + HL/32768 + HL/262144 + ...
                        ;           __INFO   = (((HL+constant)>>2) + (HL<<1) + (HL<<4) + (HL<<7) + (HL<<10) + (HL<<13)) >> 16
                        ;           __INFO   = (((((((( (HL+constant)>>3) + HL)>>3 + HL)>>3 + HL)>>3 + HL)>>3) + HL)>>3 + HL)>>3
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO         BC = 1x
    ld   HL, 0x4606     ; 3:10      __INFO
    ld    A, L          ; 1:4       __INFO
    add  HL, BC         ; 1:11      __INFO
    rr    H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO         HL >>= 1
    srl   H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO         HL >>= 1
    srl   H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO         HL >>= 1
    dec   A             ; 1:4       __INFO
    jr   nz, $-14       ; 2:7/12    __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 8
define({_8UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_8UDIV},{8u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_8UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[11:44]    __INFO   Variant HL/8 = HL >> 3
    ld    A, L          ; 1:4       __INFO
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO         HA >>= 1
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO         HA >>= 1
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO         HA >>= 1
    ld    L, A          ; 1:4       __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 10
define({_10UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_10UDIV},{10u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_10UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[36:209]   __INFO   Variant HL/10 = HL*(2*65536/2*65536)/10 = HL*(2*65536/10)/(2*65536) = HL*13107/(2*65536) = HL*51*257/(2*65536)
                        ;           __INFO   = HL*b_0011_0011*(1+1/256) >> (1+8)
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 3x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 6x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 12x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 24x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO      +1 AHL = 25x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 50x
    add  HL, BC         ; 1:11      __INFO
    ld   BC, 0x0033     ; 3:10      __INFO         rounding down constant
    adc   A, B          ; 1:4       __INFO      +1 AHL = 51x
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 51x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         _BC = "A.H" 51x/256 = 0.19921875x
    add  HL, BC         ; 1:11      __INFO         _HL = "H.L" + "A.H" = 51.19921875x
    adc   A, 0x00       ; 2:7       __INFO         AHL = 51.19921875x
    rra                 ; 1:4       __INFO
    rr    H             ; 2:8       __INFO
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO         HL = HL/10 = (HL*51*257)>>17 = (HL*51.19921875)>>8 = HL*0.099998474{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x1 = 0..2559
dnl x = x1 u/ 10
define({MAX2559_10UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_MAX2559_10UDIV},{(max2259)10u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MAX2559_10UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[21:134]   __INFO   Variant HL/10 = 0..2559*25.5*257/655360 = (HL*25.5*(1+1/256)) >> 8, HL < 2560
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO         BC = 1x
    srl   H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO         HL >>= 1
    inc  HL             ; 1:6       __INFO         rounding down
    add  HL, BC         ; 1:11      __INFO         HL = 1.5x
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO         BC = 1.5x
    add  HL, HL         ; 1:11      __INFO         HL = 3x
    add  HL, HL         ; 1:11      __INFO         HL = 6x
    add  HL, HL         ; 1:11      __INFO         HL = 12x
    add  HL, HL         ; 1:11      __INFO         HL = 24x
    add  HL, BC         ; 1:11      __INFO         HL = 25.5x
    ld    B, 0x00       ; 2:7       __INFO
    ld    C, H          ; 1:4       __INFO         BC = 25.5x/256 = 0.099609375x
    add  HL, BC         ; 1:11      __INFO         HL = 25.599609375x (2560 overflow here)
    ld    L, H          ; 1:4       __INFO
    ld    H, B          ; 1:4       __INFO         HL = 25.599609375x/256 = 0.099998474x{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x1 = 0..43689
dnl x = x1 u/ 10
define({MAX43689_10UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_MAX43689_10UDIV},{(max43689)10u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MAX43689_10UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[29:165]   __INFO   Variant HL/10 = 0..43689*25.5*257/655360 = (HL*25.5*(1+1/256)) >> 8, HL < 43690
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO         BC = 1x
    srl   H             ; 2:8       __INFO
    rr    L             ; 2:8       __INFO         HL >>= 1
    inc  HL             ; 1:6       __INFO         rounding down
    add  HL, BC         ; 1:11      __INFO         HL = 1.5x
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO         BC = 1.5x (43690 overflow here)
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO         _HL = 3x
    adc   A, A          ; 1:4       __INFO         AHL = 3x
    add  HL, HL         ; 1:11      __INFO         _HL = 6x
    adc   A, A          ; 1:4       __INFO         AHL = 6x
    add  HL, HL         ; 1:11      __INFO         _HL = 12x
    adc   A, A          ; 1:4       __INFO         AHL = 12x
    add  HL, HL         ; 1:11      __INFO         _HL = 24x
    adc   A, A          ; 1:4       __INFO         AHL = 24x
    add  HL, BC         ; 1:11      __INFO         _HL = 25.5x
    adc   A, 0x00       ; 2:7       __INFO         AHL = 25.5x
    ld    B, A          ; 1:4       __INFO
    ld    C, H          ; 1:4       __INFO         BC = 25.5x/256 = 0.099609375x
    add  HL, BC         ; 1:11      __INFO         HL = 25.599609375x
    adc   A, 0x00       ; 2:7       __INFO
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO         HL = 25.599609375x >> 8 = 0.099998474x{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 15
define({_15UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_15UDIV},{15u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_15UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[25:146]   __INFO   Variant HL/15 = (HL*257*17) >> 16 = (HL*257*b_0001_0001) >> 16
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 4x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 8x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 16x
    add  HL, BC         ; 1:11      __INFO
    ld   BC, 0x0011     ; 3:10      __INFO         rounding down constant
    adc   A, B          ; 1:4       __INFO      +1 AHL = 17x
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 17x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       __INFO
    adc   A, 0x00       ; 2:7       __INFO         + carry
    ld    H, A          ; 1:4       __INFO         HL = HL/15 = HL*(65536/65536)/15 = HL*4369/65536 = (HL*(1+256)*17) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 16
define({_16UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_16UDIV},{16u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_16UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(TYPDIV,{small},{
                        ;[11:72]    __INFO   Variant HL/16 = HL >> 4 = (HL << 4) >> 8 = (HL*16) >> 8
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 2x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 4x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 8x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 16x
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO},
__{}{
                        ;[14:56]    __INFO   Variant HL/16 = HL >> 4
    ld    A, L          ; 1:4       __INFO
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO         HA >>= 1
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO         HA >>= 1
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO         HA >>= 1
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO         HA >>= 1
    ld    L, A          ; 1:4       __INFO{}dnl
})})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 17
define({_17UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_17UDIV},{17u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_17UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[26:150]   __INFO   Variant HL/17 = (HL*257*15) >> 16 = (HL*257*b_0000_1111) >> 16
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 4x
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 8x
    add  HL, HL         ; 1:11      __INFO  -1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 16x
    sbc  HL, BC         ; 2:15      __INFO
    ld   BC, 0x000f     ; 3:10      __INFO         rounding down constant
    sbc   A, B          ; 1:4       __INFO      -1 AHL = 15x
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 15x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       __INFO
    adc   A, 0x00       ; 2:7       __INFO         + carry
    ld    H, A          ; 1:4       __INFO         HL = HL/17 = HL*(65536/65536)/17 = HL*3855/65536 = (HL*(1+256)*15) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 31
define({_31UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_31UDIV},{31u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_31DIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[46:245.5] __INFO   Variant HL/31 = (33*HL*(4+1/256)) >> (8+4)
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO         BC = 1x
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 2x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 4x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 8x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 16x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 32x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO    +1  AHL = 33x
    ld    B, A          ; 1:4       __INFO
    ld    C, H          ; 1:4       __INFO    /256 BC = 33x/256 = 0.1289x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 66x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 132x
    add  HL, BC         ; 1:11      __INFO
    adc   A, 0x00       ; 2:7       __INFO    +BC AHL = 132.1289x
    rl    L             ; 2:8       __INFO        carry for rounding
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO         HL = 132.1289x/256 = 0.51613x
    jr   nc, $+3        ; 2:7/12    __INFO
    inc  HL             ; 1:6       __INFO        rounding
    ld    A, L          ; 1:4       __INFO
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO        0.25806x
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO        0.12903x
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO        0.06452x
    srl   H             ; 2:8       __INFO
    rra                 ; 1:4       __INFO        0.03226x = 1 / 31
    ld    L, A          ; 1:4       __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 32
define({_32UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_32UDIV},{32u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_32UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:57]     __INFO   Variant HL/32 = HL >> 5 = (HL << 3) >> 8 = (HL*8) >> 8
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 2x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 4x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 8x
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 51
define({_51UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_51UDIV},{51u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_51UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[21:116]   __INFO   Variant HL/51 = (HL*257*5) >> 16 = (HL*257*b_0000_0101) >> 16
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO   0
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 4x
    add  HL, BC         ; 1:11      __INFO
    ld   BC, 0x0005     ; 3:10      __INFO         rounding down constant
    adc   A, B          ; 1:4       __INFO      +1 AHL = 5x
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 5x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       __INFO
    adc   A, 0x00       ; 2:7       __INFO         + carry
    ld    H, A          ; 1:4       __INFO         HL = HL/51 = HL*(65536/65536)/51 = HL*1285/65536 = (HL*(1+256)*5) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 63
define({_63UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_63UDIV},{63u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_63UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[43:235.5] __INFO   Variant HL/63 = (HL*(1+4/256)*(1+16/65536)) >> (-2 + 8)
    ld    A, H          ; 1:4       __INFO
    sub   0x7e          ; 1:4       __INFO         2*63*256=32256
    jr    c, $+3        ; 2:7/12    __INFO
    ld    H, A          ; 1:4       __INFO
    ex   AF, AF'        ; 1:4       __INFO         HL <= 33279
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO         BC = 1x
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 2x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 4x
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO    /256 HL = 4x/256 = 0.015625x
    add  HL, BC         ; 1:11      __INFO    +1   HL = 1.015625x
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO         BC = 1.015625x
    xor   A             ; 1:4       __INFO
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO    /256 HL = 1.015625x/256 = 0.003967285x
    add  HL, HL         ; 1:11      __INFO    *2   HL = 2x
    add  HL, HL         ; 1:11      __INFO    *2   HL = 4x
    add  HL, HL         ; 1:11      __INFO    *2   HL = 8x
    add  HL, HL         ; 1:11      __INFO    *2   HL = 16x
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO    /256 HL = 0.063476563x/256 = 0.000247955x
    add  HL, BC         ; 1:11      __INFO    +BC  HL = 1.015872955x
    inc  HL             ; 1:6       __INFO         rounding
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 2.03174591x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO    *2  AHL = 4.06349182x
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO    /256 HL = 4.06349182x/256 = 0.015873015x = 1 / 63
    ex   AF, AF'        ; 1:4       __INFO
    jr    c, $+6        ; 2:7/12    __INFO
    ld    A, H          ; 1:4       __INFO
    add   A, 0x02       ; 2:7       __INFO
    ld    H, A          ; 1:4       __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 64
define({_64UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_64UDIV},{64u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_64UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:42]     __INFO   Variant HL/64 = HL >> 6 = (HL << 2) >> 8 = (HL*4) >> 8
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 2x
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 4x
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 85
define({_85UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_85UDIV},{85u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_85UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[19:101]   __INFO   Variant HL/85 = (HL*257*3) >> 16 = (HL*257*b_0000_0011) >> 16
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   1     1x = base
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO   1
    adc   A, A          ; 1:4       __INFO      *2 AHL = 2x
    add  HL, BC         ; 1:11      __INFO
    ld   BC, 0x0003     ; 3:10      __INFO         rounding down constant
    adc   A, B          ; 1:4       __INFO      +1 AHL = 3x
    add  HL, BC         ; 1:11      __INFO
    adc   A, B          ; 1:4       __INFO      +0 AHL = 3x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       __INFO
    adc   A, 0x00       ; 2:7       __INFO         + carry
    ld    H, A          ; 1:4       __INFO         HL = HL/85 = HL*(65536/65536)/85 = HL*771/65536 = (HL*(1+256)*3) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 128
define({_128UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_128UDIV},{128u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_128UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:27]     __INFO   Variant HL/128 = HL >> 7 = (HL << 1) >> 8 = (HL*2) >> 8
    xor   A             ; 1:4       __INFO
    add  HL, HL         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO         AHL = 2x
    ld    L, H          ; 1:4       __INFO
    ld    H, A          ; 1:4       __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 255
define({_255UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_255UDIV},{255u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_255UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[13:63]    __INFO   Variant HL/255 = (HL*257*1) >> 16 = (HL*257*b_0000_0001) >> 16
    xor   A             ; 1:4       __INFO
    ld   BC, 0x0001     ; 3:10      __INFO         rounding down constant
    add  HL, BC         ; 1:11      __INFO
    adc   A, A          ; 1:4       __INFO      +0 AHL = 1x with rounding down constant
    ld    B, A          ; 1:4       __INFO        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       __INFO         BC = "A.H"
    add  HL, BC         ; 1:11      __INFO         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       __INFO
    adc   A, 0x00       ; 2:7       __INFO         + carry
    ld    H, A          ; 1:4       __INFO         HL = HL/255 = HL*(65536/65536)/255 = HL*257/65536 = (HL*(1+256)) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 256
define({_256UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_256UDIV},{256u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_256UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[3:11]     __INFO   Variant HL/256 = HL >> 8
    ld    L, H          ; 1:4       __INFO
    ld    H, 0x00       ; 2:7       __INFO{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 512
define({_512UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_512UDIV},{512u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_512UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:19]     512/   Variant HL/512 = HL >> 9 = H >> 1
    ld    L, H          ; 1:4       512/
    ld    H, 0x00       ; 2:7       512/
    srl   L             ; 2:8       512/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 1024
define({_1024UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_1024UDIV},{1024u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_1024UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[7:27]     1024/   Variant HL/1024 = HL >> 10 = H >> 2
    ld    L, H          ; 1:4       1024/
    ld    H, 0x00       ; 2:7       1024/
    srl   L             ; 2:8       1024/
    srl   L             ; 2:8       1024/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 2048
define({_2048UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_2048UDIV},{2048u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2048UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:34]     2048/   Variant HL/2048 = HL >> 11 = H >> 3
    ld    A, H          ; 1:4       2048/
    ld   HL, 0x001f     ; 3:10      2048/
    rra                 ; 1:4       2048/
    rra                 ; 1:4       2048/
    rra                 ; 1:4       2048/
    and   L             ; 1:4       2048/
    ld    L, A          ; 1:4       2048/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 4096
define({_4096UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_4096UDIV},{4096u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_4096UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[10:38]    4096/   Variant HL/4096 = HL >> 12 = H >> 4
    ld    A, H          ; 1:4       4096/
    ld   HL, 0x000f     ; 3:10      4096/
    rra                 ; 1:4       4096/
    rra                 ; 1:4       4096/
    rra                 ; 1:4       4096/
    rra                 ; 1:4       4096/
    and   L             ; 1:4       4096/
    ld    L, A          ; 1:4       4096/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 8192
define({_8192UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_8192UDIV},{8192u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_8192UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:34]     8192/   Variant HL/8192 = HL >> 13 = H >> 5 = (H << 3) >> 8
    ld    A, H          ; 1:4       8192/
    ld   HL, 0x0007     ; 3:10      8192/
    rlca                ; 1:4       8192/
    rlca                ; 1:4       8192/
    rlca                ; 1:4       8192/
    and   L             ; 1:4       8192/
    ld    L, A          ; 1:4       8192/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 16384
define({_16384UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_16384UDIV},{16384u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_16384UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:30]     16384/   Variant HL/16384 = HL >> 14 = H >> 6 = (H << 2) >> 8
    ld    A, H          ; 1:4       16384/
    ld   HL, 0x0003     ; 3:10      16384/
    rlca                ; 1:4       16384/
    rlca                ; 1:4       16384/
    and   L             ; 1:4       16384/
    ld    L, A          ; 1:4       16384/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 32768
define({_32768UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_32768UDIV},{32768u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_32768UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:24]     32768/   Variant HL/32768 = HL >> 15 = H >> 7 = (H << 1) >> 8
    xor   A             ; 1:4       32768/
    rl    H             ; 2:8       32768/
    ld    H, A          ; 1:4       32768/
    adc   A, A          ; 1:4       32768/
    ld    L, A          ; 1:4       32768/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 65535
define({_65535UDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_65535UDIV},{65535u/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_65535UDIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[9:33]     65535/
    ld    A, H          ; 1:4       65535/
    and   L             ; 1:4       65535/
    add   A, 0x01       ; 2:7       65535/
    ld   HL, 0x0000     ; 3:10      65535/
    rl    L             ; 2:8       65535/{}dnl
})dnl
dnl
dnl
dnl
