dnl ## Binary Division by a Constant, variant 1
define({___},{})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 2
define({_2UDIV},{
                        ;[4:16]     2/   Variant HL/2 = HL >> 1
    srl   H             ; 2:8       2/
    rr    L             ; 2:8       2/         HL >>= 1{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 3
define({_3UDIV},{ifelse(TYPDIV,{small},{
                        ;[26:248]   3/   Variant HL/3 = (HL*257*85) >> 16 = (HL*(1+1/256)*b_0101_0101) >> 8
    ld    B, H          ; 1:4       3/
    ld    C, L          ; 1:4       3/   1     1x = base
    ld    A, 0xf8       ; 2:7       3/         b_1111_1000
    add  HL, HL         ; 1:11      3/   0
    adc   A, A          ; 1:4       3/      *2 AHL = 2x --> 10x --> 42x
    add  HL, HL         ; 1:11      3/   1
    adc   A, A          ; 1:4       3/      *2 AHL = 4x --> 20x --> 84x
    add  HL, BC         ; 1:11      3/
    adc   A, 0x00       ; 2:7       3/      +1 AHL = 5x --> 21x --> 85x
    jp    m, $-7        ; 3:10      3/
    ld   BC, 0x0055     ; 3:10      3/         rounding down constant
    add  HL, BC         ; 1:11      3/
    adc   A, B          ; 1:4       3/      +0 AHL = 85x with rounding down constant
    ld    B, A          ; 1:4       3/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       3/         BC = "A.H"
    add  HL, BC         ; 1:11      3/         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       3/
    adc   A, 0x00       ; 2:7       3/         + carry
    ld    H, A          ; 1:4       3/         HL = HL/3 = HL*(65536/65536)/3 = HL*21845/65536 = (HL*(1+256)*85) >> 16{}dnl
},{
                        ;[35:212]   3/   Variant HL/3 = (HL*257*85) >> 16 = (HL*(1+1/256)*b_0101_0101) >> 8
    ld    B, H          ; 1:4       3/
    ld    C, L          ; 1:4       3/   1     1x = base
    xor   A             ; 1:4       3/
    add  HL, HL         ; 1:11      3/   0
    adc   A, A          ; 1:4       3/      *2 AHL = 2x
    add  HL, HL         ; 1:11      3/   1
    adc   A, A          ; 1:4       3/      *2 AHL = 4x
    add  HL, BC         ; 1:11      3/
    adc   A, 0x00       ; 2:7       3/      +1 AHL = 5x
    add  HL, HL         ; 1:11      3/   0
    adc   A, A          ; 1:4       3/      *2 AHL = 10x
    add  HL, HL         ; 1:11      3/   1
    adc   A, A          ; 1:4       3/      *2 AHL = 20x
    add  HL, BC         ; 1:11      3/
    adc   A, 0x00       ; 2:7       3/      +1 AHL = 21x
    add  HL, HL         ; 1:11      3/   0
    adc   A, A          ; 1:4       3/      *2 AHL = 42x
    add  HL, HL         ; 1:11      3/   1
    adc   A, A          ; 1:4       3/      *2 AHL = 84x
    add  HL, BC         ; 1:11      3/
    ld   BC, 0x0055     ; 3:10      3/         rounding down constant
    adc   A, B          ; 1:4       3/      +1 AHL = 85x
    add  HL, BC         ; 1:11      3/
    adc   A, B          ; 1:4       3/      +0 AHL = 85x with rounding down constant
    ld    B, A          ; 1:4       3/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       3/         BC = "A.H"
    add  HL, BC         ; 1:11      3/         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       3/
    adc   A, 0x00       ; 2:7       3/         + carry
    ld    H, A          ; 1:4       3/         HL = HL/3 = HL*(65536/65536)/3 = HL*21845/65536 = (HL*(1+256)*85) >> 16{}dnl
})})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 4
define({_4UDIV},{
                        ;[8:32]     4/   Variant HL/4 = HL >> 2
    srl   H             ; 2:8       4/
    rr    L             ; 2:8       4/         HL >>= 1
    srl   H             ; 2:8       4/
    rr    L             ; 2:8       4/         HL >>= 1{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 5
define({_5UDIV},{
                        ;[33:197]   5/   Variant HL/5 = (HL*257*51) >> 16 = (HL*257*b_0011_0011) >> 16
    ld    B, H          ; 1:4       5/
    ld    C, L          ; 1:4       5/   1     1x = base
    xor   A             ; 1:4       5/
    add  HL, HL         ; 1:11      5/   1
    adc   A, A          ; 1:4       5/      *2 AHL = 2x
    add  HL, BC         ; 1:11      5/
    adc   A, 0x00       ; 2:7       5/      +1 AHL = 3x
    add  HL, HL         ; 1:11      5/   0
    adc   A, A          ; 1:4       5/      *2 AHL = 6x
    add  HL, HL         ; 1:11      5/   0
    adc   A, A          ; 1:4       5/      *2 AHL = 12x
    add  HL, HL         ; 1:11      5/   1
    adc   A, A          ; 1:4       5/      *2 AHL = 24x
    add  HL, BC         ; 1:11      5/
    adc   A, 0x00       ; 2:7       5/      +1 AHL = 25x
    add  HL, HL         ; 1:11      5/   1
    adc   A, A          ; 1:4       5/      *2 AHL = 50x
    add  HL, BC         ; 1:11      5/
    ld   BC, 0x0033     ; 3:10      5/         rounding down constant
    adc   A, B          ; 1:4       5/      +1 AHL = 51x
    add  HL, BC         ; 1:11      5/
    adc   A, B          ; 1:4       5/      +0 AHL = 51x with rounding down constant
    ld    B, A          ; 1:4       5/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       5/         BC = "A.H"
    add  HL, BC         ; 1:11      5/         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       5/
    adc   A, 0x00       ; 2:7       5/         + carry
    ld    H, A          ; 1:4       5/         HL = HL/5 = HL*(65536/65536)/5 = HL*13107/65536 = (HL*(1+256)*51) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 6
define({_6UDIV},{ifelse(TYPDIV,{small},{
                        ;[29:260]   6/   Variant HL/6 = (HL*257*85) >> 17 = (HL*(1+1/256)*b_0101_0101) >> (1+8)
    ld    B, H          ; 1:4       6/
    ld    C, L          ; 1:4       6/   1     1x = base
    ld    A, 0xf8       ; 2:7       6/         b_1111_1000
    add  HL, HL         ; 1:11      6/   0
    adc   A, A          ; 1:4       6/      *2 AHL = 2x --> 10x --> 42x
    add  HL, HL         ; 1:11      6/   1
    adc   A, A          ; 1:4       6/      *2 AHL = 4x --> 20x --> 84x
    add  HL, BC         ; 1:11      6/
    adc   A, 0x00       ; 2:7       6/      +1 AHL = 5x --> 21x --> 85x
    jp    m, $-7        ; 3:10      6/
    ld   BC, 0x0055     ; 3:10      6/         rounding down constant
    add  HL, BC         ; 1:11      6/
    adc   A, B          ; 1:4       6/      +0 AHL = 85x with rounding down constant
    ld    B, A          ; 1:4       6/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       6/         BC = "A.H"
    add  HL, BC         ; 1:11      6/         HL = "H.L" + "A.H"
    adc   A, 0x00       ; 2:7       6/         + carry
    rra                 ; 1:4       6/
    rr    H             ; 2:8       6/         AH >>= 1
    ld    L, H          ; 1:4       6/
    ld    H, A          ; 1:4       6/         HL = HL/6 = HL*(2*65536/2*65536)/6 = HL*21845/(2*65536) = (HL*(1+256)*85) >> (1+16){}dnl
},{
                        ;[38:224]   6/   Variant HL/6 = (HL*257*85) >> 17 = (HL*(1+1/256)*b_0101_0101) >> (1+8)
    ld    B, H          ; 1:4       6/
    ld    C, L          ; 1:4       6/   1     1x = base
    xor   A             ; 1:4       6/
    add  HL, HL         ; 1:11      6/   0
    adc   A, A          ; 1:4       6/      *2 AHL = 2x
    add  HL, HL         ; 1:11      6/   1
    adc   A, A          ; 1:4       6/      *2 AHL = 4x
    add  HL, BC         ; 1:11      6/
    adc   A, 0x00       ; 2:7       6/      +1 AHL = 5x
    add  HL, HL         ; 1:11      6/   0
    adc   A, A          ; 1:4       6/      *2 AHL = 10x
    add  HL, HL         ; 1:11      6/   1
    adc   A, A          ; 1:4       6/      *2 AHL = 20x
    add  HL, BC         ; 1:11      6/
    adc   A, 0x00       ; 2:7       6/      +1 AHL = 21x
    add  HL, HL         ; 1:11      6/   0
    adc   A, A          ; 1:4       6/      *2 AHL = 42x
    add  HL, HL         ; 1:11      6/   1
    adc   A, A          ; 1:4       6/      *2 AHL = 84x
    add  HL, BC         ; 1:11      6/
    ld   BC, 0x0055     ; 3:10      6/         rounding down constant
    adc   A, B          ; 1:4       6/      +1 AHL = 85x
    add  HL, BC         ; 1:11      6/
    adc   A, B          ; 1:4       6/      +0 AHL = 85x with rounding down constant
    ld    B, A          ; 1:4       6/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       6/         BC = "A.H"
    add  HL, BC         ; 1:11      6/         HL = "H.L" + "A.H"
    adc   A, 0x00       ; 2:7       6/         + carry
    rra                 ; 1:4       6/
    rr    H             ; 2:8       6/         AH >>= 1
    ld    L, H          ; 1:4       6/
    ld    H, A          ; 1:4       6/         HL = HL/6 = HL*(2*65536/2*65536)/6 = HL*21845/(2*65536) = (HL*(1+256)*85) >> (1+16){}dnl
})})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 7
define({_7UDIV},{
                        ;[22:467]   7/   Variant HL/7 = HL/8 + HL/(7*8) = HL/8 + HL/64 + HL/(7*8*8) = HL/8 + HL/64 + HL/512 + HL/4096 + HL/32768 + HL/262144 + ...
                        ;           7/   = (((HL+constant)>>2) + (HL<<1) + (HL<<4) + (HL<<7) + (HL<<10) + (HL<<13)) >> 16
                        ;           7/   = (((((((( (HL+constant)>>3) + HL)>>3 + HL)>>3 + HL)>>3 + HL)>>3) + HL)>>3 + HL)>>3
    ld    B, H          ; 1:4       7/
    ld    C, L          ; 1:4       7/         BC = 1x
    ld   HL, 0x4606     ; 3:10      7/
    ld    A, L          ; 1:4       7/
    add  HL, BC         ; 1:11      7/
    rr    H             ; 2:8       7/
    rr    L             ; 2:8       7/         HL >>= 1
    srl   H             ; 2:8       7/
    rr    L             ; 2:8       7/         HL >>= 1
    srl   H             ; 2:8       7/
    rr    L             ; 2:8       7/         HL >>= 1
    dec   A             ; 1:4       7/
    jr   nz, $-14       ; 2:7/12    7/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 8
define({_8UDIV},{
                        ;[11:44]    8/   Variant HL/8 = HL >> 3
    ld    A, L          ; 1:4       8/
    srl   H             ; 2:8       8/
    rra                 ; 1:4       8/         HA >>= 1
    srl   H             ; 2:8       8/
    rra                 ; 1:4       8/         HA >>= 1
    srl   H             ; 2:8       8/
    rra                 ; 1:4       8/         HA >>= 1
    ld    L, A          ; 1:4       8/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 10
define({_10UDIV},{
                        ;[36:209]   10/   Variant HL/10 = HL*(2*65536/2*65536)/10 = HL*(2*65536/10)/(2*65536) = HL*13107/(2*65536) = HL*51*257/(2*65536)
                        ;           10/   = HL*b_0011_0011*(1+1/256) >> (1+8)
    ld    B, H          ; 1:4       10/
    ld    C, L          ; 1:4       10/   1     1x = base
    xor   A             ; 1:4       10/
    add  HL, HL         ; 1:11      10/   1
    adc   A, A          ; 1:4       10/      *2 AHL = 2x
    add  HL, BC         ; 1:11      10/
    adc   A, 0x00       ; 2:7       10/      +1 AHL = 3x
    add  HL, HL         ; 1:11      10/   0
    adc   A, A          ; 1:4       10/      *2 AHL = 6x
    add  HL, HL         ; 1:11      10/   0
    adc   A, A          ; 1:4       10/      *2 AHL = 12x
    add  HL, HL         ; 1:11      10/   1
    adc   A, A          ; 1:4       10/      *2 AHL = 24x
    add  HL, BC         ; 1:11      10/
    adc   A, 0x00       ; 2:7       10/      +1 AHL = 25x
    add  HL, HL         ; 1:11      10/   1
    adc   A, A          ; 1:4       10/      *2 AHL = 50x
    add  HL, BC         ; 1:11      10/
    ld   BC, 0x0033     ; 3:10      10/         rounding down constant
    adc   A, B          ; 1:4       10/      +1 AHL = 51x
    add  HL, BC         ; 1:11      10/
    adc   A, B          ; 1:4       10/      +0 AHL = 51x with rounding down constant
    ld    B, A          ; 1:4       10/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       10/         _BC = "A.H" 51x/256 = 0.19921875x
    add  HL, BC         ; 1:11      10/         _HL = "H.L" + "A.H" = 51.19921875x
    adc   A, 0x00       ; 2:7       10/         AHL = 51.19921875x
    rra                 ; 1:4       10/
    rr    H             ; 2:8       10/
    ld    L, H          ; 1:4       10/
    ld    H, A          ; 1:4       10/         HL = HL/10 = (HL*51*257)>>17 = (HL*51.19921875)>>8 = HL*0.099998474{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x1 = 0..2559
dnl x = x1 u/ 10
define({MAX2559_10UDIV},{
                        ;[21:134]   10/   Variant HL/10 = 0..2559*25.5*257/655360 = (HL*25.5*(1+1/256)) >> 8, HL < 2560
    ld    B, H          ; 1:4       10/
    ld    C, L          ; 1:4       10/         BC = 1x
    srl   H             ; 2:8       10/
    rr    L             ; 2:8       10/         HL >>= 1
    inc  HL             ; 1:6       10/         rounding down
    add  HL, BC         ; 1:11      10/         HL = 1.5x
    ld    B, H          ; 1:4       10/
    ld    C, L          ; 1:4       10/         BC = 1.5x
    add  HL, HL         ; 1:11      10/         HL = 3x
    add  HL, HL         ; 1:11      10/         HL = 6x
    add  HL, HL         ; 1:11      10/         HL = 12x
    add  HL, HL         ; 1:11      10/         HL = 24x
    add  HL, BC         ; 1:11      10/         HL = 25.5x
    ld    B, 0x00       ; 2:7       10/
    ld    C, H          ; 1:4       10/         BC = 25.5x/256 = 0.099609375x
    add  HL, BC         ; 1:11      10/         HL = 25.599609375x (2560 overflow here)
    ld    L, H          ; 1:4       10/
    ld    H, B          ; 1:4       10/         HL = 25.599609375x/256 = 0.099998474x{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x1 = 0..43689
dnl x = x1 u/ 10
define({MAX2559_10UDIV},{
                        ;[29:165]   10/   Variant HL/10 = 0..43689*25.5*257/655360 = (HL*25.5*(1+1/256)) >> 8, HL < 43690
    ld    B, H          ; 1:4       10/
    ld    C, L          ; 1:4       10/         BC = 1x
    srl   H             ; 2:8       10/
    rr    L             ; 2:8       10/         HL >>= 1
    inc  HL             ; 1:6       10/         rounding down
    add  HL, BC         ; 1:11      10/         HL = 1.5x
    ld    B, H          ; 1:4       10/
    ld    C, L          ; 1:4       10/         BC = 1.5x (43690 overflow here)
    xor   A             ; 1:4       10/
    add  HL, HL         ; 1:11      10/         _HL = 3x
    adc   A, A          ; 1:4       10/         AHL = 3x
    add  HL, HL         ; 1:11      10/         _HL = 6x
    adc   A, A          ; 1:4       10/         AHL = 6x
    add  HL, HL         ; 1:11      10/         _HL = 12x
    adc   A, A          ; 1:4       10/         AHL = 12x
    add  HL, HL         ; 1:11      10/         _HL = 24x
    adc   A, A          ; 1:4       10/         AHL = 24x
    add  HL, BC         ; 1:11      10/         _HL = 25.5x
    adc   A, 0x00       ; 2:7       10/         AHL = 25.5x
    ld    B, A          ; 1:4       10/
    ld    C, H          ; 1:4       10/         BC = 25.5x/256 = 0.099609375x
    add  HL, BC         ; 1:11      10/         HL = 25.599609375x
    adc   A, 0x00       ; 2:7       10/
    ld    L, H          ; 1:4       10/
    ld    H, A          ; 1:4       10/         HL = 25.599609375x >> 8 = 0.099998474x{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 15
define({_15UDIV},{
                        ;[25:146]   15/   Variant HL/15 = (HL*257*17) >> 16 = (HL*257*b_0001_0001) >> 16
    ld    B, H          ; 1:4       15/
    ld    C, L          ; 1:4       15/   1     1x = base
    xor   A             ; 1:4       15/
    add  HL, HL         ; 1:11      15/   0
    adc   A, A          ; 1:4       15/      *2 AHL = 2x
    add  HL, HL         ; 1:11      15/   0
    adc   A, A          ; 1:4       15/      *2 AHL = 4x
    add  HL, HL         ; 1:11      15/   0
    adc   A, A          ; 1:4       15/      *2 AHL = 8x
    add  HL, HL         ; 1:11      15/   1
    adc   A, A          ; 1:4       15/      *2 AHL = 16x
    add  HL, BC         ; 1:11      15/
    ld   BC, 0x0011     ; 3:10      15/         rounding down constant
    adc   A, B          ; 1:4       15/      +1 AHL = 17x
    add  HL, BC         ; 1:11      15/
    adc   A, B          ; 1:4       15/      +0 AHL = 17x with rounding down constant
    ld    B, A          ; 1:4       15/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       15/         BC = "A.H"
    add  HL, BC         ; 1:11      15/         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       15/
    adc   A, 0x00       ; 2:7       15/         + carry
    ld    H, A          ; 1:4       15/         HL = HL/15 = HL*(65536/65536)/15 = HL*4369/65536 = (HL*(1+256)*17) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 16
define({_16UDIV},{ifelse(TYPDIV,{small},{
                        ;[11:72]    16/   Variant HL/16 = HL >> 4 = (HL << 4) >> 8 = (HL*16) >> 8
    xor   A             ; 1:4       16/
    add  HL, HL         ; 1:11      16/
    adc   A, A          ; 1:4       16/         AHL = 2x
    add  HL, HL         ; 1:11      16/
    adc   A, A          ; 1:4       16/         AHL = 4x
    add  HL, HL         ; 1:11      16/
    adc   A, A          ; 1:4       16/         AHL = 8x
    add  HL, HL         ; 1:11      16/
    adc   A, A          ; 1:4       16/         AHL = 16x
    ld    L, H          ; 1:4       16/
    ld    H, A          ; 1:4       16/{}dnl
},{
                        ;[14:56]    16/   Variant HL/16 = HL >> 4
    ld    A, L          ; 1:4       16/
    srl   H             ; 2:8       16/
    rra                 ; 1:4       16/         HA >>= 1
    srl   H             ; 2:8       16/
    rra                 ; 1:4       16/         HA >>= 1
    srl   H             ; 2:8       16/
    rra                 ; 1:4       16/         HA >>= 1
    srl   H             ; 2:8       16/
    rra                 ; 1:4       16/         HA >>= 1
    ld    L, A          ; 1:4       16/{}dnl
})})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 17
define({_17UDIV},{
                        ;[26:150]   17/   Variant HL/17 = (HL*257*15) >> 16 = (HL*257*b_0000_1111) >> 16
    ld    B, H          ; 1:4       17/
    ld    C, L          ; 1:4       17/   1     1x = base
    xor   A             ; 1:4       17/
    add  HL, HL         ; 1:11      17/   0
    adc   A, A          ; 1:4       17/      *2 AHL = 2x
    add  HL, HL         ; 1:11      17/   0
    adc   A, A          ; 1:4       17/      *2 AHL = 4x
    add  HL, HL         ; 1:11      17/   0
    adc   A, A          ; 1:4       17/      *2 AHL = 8x
    add  HL, HL         ; 1:11      17/  -1
    adc   A, A          ; 1:4       17/      *2 AHL = 16x
    sbc  HL, BC         ; 2:15      17/
    ld   BC, 0x000f     ; 3:10      17/         rounding down constant
    sbc   A, B          ; 1:4       17/      -1 AHL = 15x
    add  HL, BC         ; 1:11      17/
    adc   A, B          ; 1:4       17/      +0 AHL = 15x with rounding down constant
    ld    B, A          ; 1:4       17/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       17/         BC = "A.H"
    add  HL, BC         ; 1:11      17/         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       17/
    adc   A, 0x00       ; 2:7       17/         + carry
    ld    H, A          ; 1:4       17/         HL = HL/17 = HL*(65536/65536)/17 = HL*3855/65536 = (HL*(1+256)*15) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 255
define({_31_DIV},{
                        ;[46:245.5] 31/   Variant HL/31 = (33*HL*(4+1/256)) >> (8+4)
    ld    B, H          ; 1:4       31/
    ld    C, L          ; 1:4       31/         BC = 1x
    xor   A             ; 1:4       31/
    add  HL, HL         ; 1:11      31/
    adc   A, A          ; 1:4       31/    *2  AHL = 2x
    add  HL, HL         ; 1:11      31/
    adc   A, A          ; 1:4       31/    *2  AHL = 4x
    add  HL, HL         ; 1:11      31/
    adc   A, A          ; 1:4       31/    *2  AHL = 8x
    add  HL, HL         ; 1:11      31/
    adc   A, A          ; 1:4       31/    *2  AHL = 16x
    add  HL, HL         ; 1:11      31/
    adc   A, A          ; 1:4       31/    *2  AHL = 32x
    add  HL, BC         ; 1:11      31/
    adc   A, 0x00       ; 2:7       31/    +1  AHL = 33x
    ld    B, A          ; 1:4       31/
    ld    C, H          ; 1:4       31/    /256 BC = 33x/256 = 0.1289x
    add  HL, HL         ; 1:11      31/
    adc   A, A          ; 1:4       31/    *2  AHL = 66x
    add  HL, HL         ; 1:11      31/
    adc   A, A          ; 1:4       31/    *2  AHL = 132x
    add  HL, BC         ; 1:11      31/
    adc   A, 0x00       ; 2:7       31/    +BC AHL = 132.1289x
    rl    L             ; 2:8       31/        carry for rounding
    ld    L, H          ; 1:4       31/
    ld    H, A          ; 1:4       31/         HL = 132.1289x/256 = 0.51613x
    jr   nc, $+3        ; 2:7/12    31/
    inc  HL             ; 1:6       31/        rounding
    ld    A, L          ; 1:4       31/
    srl   H             ; 2:8       31/
    rra                 ; 1:4       31/        0.25806x
    srl   H             ; 2:8       31/
    rra                 ; 1:4       31/        0.12903x
    srl   H             ; 2:8       31/
    rra                 ; 1:4       31/        0.06452x
    srl   H             ; 2:8       31/
    rra                 ; 1:4       31/        0.03226x = 1 / 31
    ld    L, A          ; 1:4       31/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 32
define({_32UDIV},{
                        ;[9:57]     32/   Variant HL/32 = HL >> 5 = (HL << 3) >> 8 = (HL*8) >> 8
    xor   A             ; 1:4       32/
    add  HL, HL         ; 1:11      32/
    adc   A, A          ; 1:4       32/         AHL = 2x
    add  HL, HL         ; 1:11      32/
    adc   A, A          ; 1:4       32/         AHL = 4x
    add  HL, HL         ; 1:11      32/
    adc   A, A          ; 1:4       32/         AHL = 8x
    ld    L, H          ; 1:4       32/
    ld    H, A          ; 1:4       32/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 51
define({_51UDIV},{
                        ;[21:116]   51/   Variant HL/51 = (HL*257*5) >> 16 = (HL*257*b_0000_0101) >> 16
    ld    B, H          ; 1:4       51/
    ld    C, L          ; 1:4       51/   1     1x = base
    xor   A             ; 1:4       51/
    add  HL, HL         ; 1:11      51/   0
    adc   A, A          ; 1:4       51/      *2 AHL = 2x
    add  HL, HL         ; 1:11      51/   1
    adc   A, A          ; 1:4       51/      *2 AHL = 4x
    add  HL, BC         ; 1:11      51/
    ld   BC, 0x0005     ; 3:10      51/         rounding down constant
    adc   A, B          ; 1:4       51/      +1 AHL = 5x
    add  HL, BC         ; 1:11      51/
    adc   A, B          ; 1:4       51/      +0 AHL = 5x with rounding down constant
    ld    B, A          ; 1:4       51/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       51/         BC = "A.H"
    add  HL, BC         ; 1:11      51/         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       51/
    adc   A, 0x00       ; 2:7       51/         + carry
    ld    H, A          ; 1:4       51/         HL = HL/51 = HL*(65536/65536)/51 = HL*1285/65536 = (HL*(1+256)*5) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 63
define({_63UDIV},{
                        ;[43:235.5] 63/   Variant HL/63 = (HL*(1+4/256)*(1+16/65536)) >> (-2 + 8)
    ld    A, H          ; 1:4       63/
    sub   0x7e          ; 1:4       63/         2*63*256=32256
    jr    c, $+3        ; 2:7/12    63/
    ld    H, A          ; 1:4       63/
    ex   AF, AF'        ; 1:4       63/         HL <= 33279
    ld    B, H          ; 1:4       63/
    ld    C, L          ; 1:4       63/         BC = 1x
    xor   A             ; 1:4       63/
    add  HL, HL         ; 1:11      63/
    adc   A, A          ; 1:4       63/    *2  AHL = 2x
    add  HL, HL         ; 1:11      63/
    adc   A, A          ; 1:4       63/    *2  AHL = 4x
    ld    L, H          ; 1:4       63/
    ld    H, A          ; 1:4       63/    /256 HL = 4x/256 = 0.015625x
    add  HL, BC         ; 1:11      63/    +1   HL = 1.015625x
    ld    B, H          ; 1:4       63/
    ld    C, L          ; 1:4       63/         BC = 1.015625x
    xor   A             ; 1:4       63/
    ld    L, H          ; 1:4       63/
    ld    H, A          ; 1:4       63/    /256 HL = 1.015625x/256 = 0.003967285x
    add  HL, HL         ; 1:11      63/    *2   HL = 2x
    add  HL, HL         ; 1:11      63/    *2   HL = 4x
    add  HL, HL         ; 1:11      63/    *2   HL = 8x
    add  HL, HL         ; 1:11      63/    *2   HL = 16x
    ld    L, H          ; 1:4       63/
    ld    H, A          ; 1:4       63/    /256 HL = 0.063476563x/256 = 0.000247955x
    add  HL, BC         ; 1:11      63/    +BC  HL = 1.015872955x
    inc  HL             ; 1:6       63/         rounding
    add  HL, HL         ; 1:11      63/
    adc   A, A          ; 1:4       63/    *2  AHL = 2.03174591x
    add  HL, HL         ; 1:11      63/
    adc   A, A          ; 1:4       63/    *2  AHL = 4.06349182x
    ld    L, H          ; 1:4       63/
    ld    H, A          ; 1:4       63/    /256 HL = 4.06349182x/256 = 0.015873015x = 1 / 63
    ex   AF, AF'        ; 1:4       63/
    jr    c, $+6        ; 2:7/12    63/
    ld    A, H          ; 1:4       63/
    add   A, 0x02       ; 2:7       63/
    ld    H, A          ; 1:4       63/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 64
define({_64UDIV},{
                        ;[7:42]     64/   Variant HL/64 = HL >> 6 = (HL << 2) >> 8 = (HL*4) >> 8
    xor   A             ; 1:4       64/
    add  HL, HL         ; 1:11      64/
    adc   A, A          ; 1:4       64/         AHL = 2x
    add  HL, HL         ; 1:11      64/
    adc   A, A          ; 1:4       64/         AHL = 4x
    ld    L, H          ; 1:4       64/
    ld    H, A          ; 1:4       64/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 85
define({_85UDIV},{
                        ;[19:101]   85/   Variant HL/85 = (HL*257*3) >> 16 = (HL*257*b_0000_0011) >> 16
    ld    B, H          ; 1:4       85/
    ld    C, L          ; 1:4       85/   1     1x = base
    xor   A             ; 1:4       85/
    add  HL, HL         ; 1:11      85/   1
    adc   A, A          ; 1:4       85/      *2 AHL = 2x
    add  HL, BC         ; 1:11      85/
    ld   BC, 0x0003     ; 3:10      85/         rounding down constant
    adc   A, B          ; 1:4       85/      +1 AHL = 3x
    add  HL, BC         ; 1:11      85/
    adc   A, B          ; 1:4       85/      +0 AHL = 3x with rounding down constant
    ld    B, A          ; 1:4       85/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       85/         BC = "A.H"
    add  HL, BC         ; 1:11      85/         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       85/
    adc   A, 0x00       ; 2:7       85/         + carry
    ld    H, A          ; 1:4       85/         HL = HL/85 = HL*(65536/65536)/85 = HL*771/65536 = (HL*(1+256)*3) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 128
define({_128UDIV},{
                        ;[5:27]     128/   Variant HL/128 = HL >> 7 = (HL << 1) >> 8 = (HL*2) >> 8
    xor   A             ; 1:4       128/
    add  HL, HL         ; 1:11      128/
    adc   A, A          ; 1:4       128/         AHL = 2x
    ld    L, H          ; 1:4       128/
    ld    H, A          ; 1:4       128/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 255
define({_255UDIV},{
                        ;[13:63]    255/   Variant HL/255 = (HL*257*1) >> 16 = (HL*257*b_0000_0001) >> 16
    xor   A             ; 1:4       255/
    ld   BC, 0x0001     ; 3:10      255/         rounding down constant
    add  HL, BC         ; 1:11      255/
    adc   A, A          ; 1:4       255/      +0 AHL = 1x with rounding down constant
    ld    B, A          ; 1:4       255/        (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
    ld    C, H          ; 1:4       255/         BC = "A.H"
    add  HL, BC         ; 1:11      255/         HL = "H.L" + "A.H"
    ld    L, H          ; 1:4       255/
    adc   A, 0x00       ; 2:7       255/         + carry
    ld    H, A          ; 1:4       255/         HL = HL/255 = HL*(65536/65536)/255 = HL*257/65536 = (HL*(1+256)) >> 16{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 256
define({_256UDIV},{
                        ;[3:11]     256/   Variant HL/256 = HL >> 8
    ld    L, H          ; 1:4       256/
    ld    H, 0x00       ; 2:7       256/{}dnl
})dnl
dnl
dnl
dnl
dnl ( x1 -- x)
dnl x = x1 u/ 512
define({_512UDIV},{
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
define({_1024UDIV},{
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
define({_2048UDIV},{
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
define({_4096UDIV},{
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
define({_8192UDIV},{
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
define({_16384UDIV},{
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
define({_32768UDIV},{
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
define({_65535UDIV},{
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
