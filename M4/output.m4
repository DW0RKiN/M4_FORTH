dnl ## Runtime enviroment
define({__},{})dnl
dnl
dnl
dnl
ifdef({USE_S32},{define({USE_DNEGATE},{}){}define({USE_U32},{})
;==============================================================================
; ( hi lo -- )
; Input: HL
; Output: Print space and signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRINT_S32:              ;           print_s32
    ld    A, D          ; 1:4       print_s32
    add   A, A          ; 1:4       print_s32
    jr   nc, PRINT_U32  ; 2:7/12    print_s32
    call NEGATE_32      ; 3:17      print_s32
    ld    A, ' '        ; 2:7       print_s32   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_s32   putchar with {ZX 48K ROM} in, this will print char in A
    ld    A, '-'        ; 2:7       print_s32   putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      print_s32   ld   BC, **
    ; fall to print_u32})dnl
dnl
dnl
ifdef({USE_U32},{
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRINT_U32:              ;           print_u32
    ld    A, ' '        ; 2:7       print_u32   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_u32   putchar with {ZX 48K ROM} in, this will print char in A
    ; fall to print_u32_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRINT_U32_ONLY:         ;           print_u32_only
    xor   A             ; 1:4       print_u32_only   A=0 => 103, A='0' => 00103
    push IX             ; 2:15      print_u32_only
    ex   DE, HL         ; 1:4       print_u32_only   HL = hi word
    ld  IXl, E          ; 2:8       print_u32_only
    ld  IXh, D          ; 2:8       print_u32_only   IX = lo word
    ld   DE, 0x3600     ; 3:10      print_u32_only   C4 65 36 00 = -1000000000
    ld   BC, 0xC465     ; 3:10      print_u32_only
    call BIN32_DEC+2    ; 3:17      print_u32_only
    ld    D, 0x1F       ; 2:7       print_u32_only   FA 0A 1F 00 = -100000000
    ld   BC, 0xFA0A     ; 3:10      print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0x6980     ; 3:10      print_u32_only   FF 67 69 80 = -10000000
    ld   BC, 0xFF67     ; 3:10      print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xBDC0     ; 3:10      print_u32_only   FF F0 BD C0 = -1000000
    ld    C, 0xF0       ; 2:7       print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0x7960     ; 3:10      print_u32_only   FF FE 79 60 = -100000
    ld    C, 0xFE       ; 2:7       print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xD8F0     ; 3:10      print_u32_only   FF FF D8 F0 = -10000
    ld    C, B          ; 1:4       print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xFC18     ; 3:10      print_u32_only   FF FF FC 18 = -1000
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xFF9C     ; 3:10      print_u32_only   FF FF FF 9C = -100
    call BIN32_DEC      ; 3:17      print_u32_only
    ld    E, 0xF6       ; 2:7       print_u32_only   FF FF FF F6 = -10
    call BIN32_DEC      ; 3:17      print_u32_only
    ld    A, IXl        ; 2:8       print_u32_only
    pop  IX             ; 2:14      print_u32_only
    pop  BC             ; 1:10      print_u32_only   load ret
    pop  HL             ; 1:10      print_u32_only
    pop  DE             ; 1:10      print_u32_only
    push BC             ; 1:10      print_u32_only   save ret
    jr   BIN32_DEC_CHAR ; 2:12      print_u32_only
;------------------------------------------------------------------------------
; Input: A = 0..9 or '0'..'9' = 0x30..0x39 = 48..57, HL, IX, BC, DE
; Output: if ((HLIX/(-BCDE) > 0) || (A >= '0')) print number HLIX/(-BCDE)
; Pollutes: AF, AF', IX, HL
BIN32_DEC:              ;           bin32_dec
    and  0xF0           ; 2:7       bin32_dec   reset A to 0 or '0'
    add  IX, DE         ; 2:15      bin32_dec   lo word
    adc  HL, BC         ; 2:15      bin32_dec   hi word
    inc   A             ; 1:4       bin32_dec
    jr    c, $-5        ; 2:7/12    bin32_dec
    ex   AF, AF'        ; 1:4       bin32_dec
    ld    A, IXl        ; 2:8       bin32_dec
    sub   E             ; 1:4       bin32_dec
    ld  IXl, A          ; 2:8       bin32_dec
    ld    A, IXh        ; 2:8       bin32_dec
    sbc   A, D          ; 1:4       bin32_dec
    ld  IXh, A          ; 2:8       bin32_dec
    sbc  HL, BC         ; 2:15      bin32_dec   hi word
    ex   AF, AF'        ; 1:4       bin32_dec
    dec   A             ; 1:4       bin32_dec
    ret   z             ; 1:5/11    bin32_dec   does not print leading zeros
BIN32_DEC_CHAR:         ;           bin32_dec
    or   '0'            ; 2:7       bin32_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    rst  0x10           ; 1:11      bin32_dec   putchar with {ZX 48K ROM} in, this will print char in A
    ret                 ; 1:10      bin32_dec}){}dnl
dnl
dnl
ifdef({USE_S16},{
;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_S16:              ;           print_s16
    ld    A, H          ; 1:4       print_s16
    add   A, A          ; 1:4       print_s16
    jr   nc, PRINT_U16  ; 2:7/12    print_s16
    xor   A             ; 1:4       print_s16   neg
    sub   L             ; 1:4       print_s16   neg
    ld    L, A          ; 1:4       print_s16   neg
    sbc   A, H          ; 1:4       print_s16   neg
    sub   L             ; 1:4       print_s16   neg
    ld    H, A          ; 1:4       print_s16   neg
    ld    A, ' '        ; 2:7       print_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_s16   putchar with {ZX 48K ROM} in, this will print char in A
    ld    A, '-'        ; 2:7       print_s16   putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      print_s16   ld   BC, **
__{}define({USE_U16},{}){}dnl
    ; fall to print_u16}){}dnl
dnl
dnl
ifdef({USE_U16},{
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_U16:              ;           print_u16
    ld    A, ' '        ; 2:7       print_u16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_u16   putchar with {ZX 48K ROM} in, this will print char in A
    ; fall to print_u16_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_U16_ONLY:         ;           print_u16_only
    xor   A             ; 1:4       print_u16_only   A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10      print_u16_only
    call BIN16_DEC+2    ; 3:17      print_u16_only
    ld   BC, -1000      ; 3:10      print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld   BC, -100       ; 3:10      print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld    C, -10        ; 2:7       print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld    A, L          ; 1:4       print_u16_only
    pop  BC             ; 1:10      print_u16_only   load ret
    ex   DE, HL         ; 1:4       print_u16_only
    pop  DE             ; 1:10      print_u16_only
    push BC             ; 1:10      print_u16_only   save ret
    jr   BIN16_DEC_CHAR ; 2:12      print_u16_only
;------------------------------------------------------------------------------
; Input: A = 0..9 or '0'..'9' = 0x30..0x39 = 48..57, HL, IX, BC, DE
; Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
; Pollutes: AF, HL
BIN16_DEC:              ;           bin16_dec
    and  0xF0           ; 2:7       bin16_dec   reset A to 0 or '0'
    add  HL, BC         ; 1:11      bin16_dec
    inc   A             ; 1:4       bin16_dec
    jr    c, $-2        ; 2:7/12    bin16_dec
    sbc  HL, BC         ; 2:15      bin16_dec
    dec   A             ; 1:4       bin16_dec
    ret   z             ; 1:5/11    bin16_dec   does not print leading zeros
BIN16_DEC_CHAR:         ;           bin16_dec
    or   '0'            ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    rst   0x10          ; 1:11      bin16_dec   putchar with {ZX 48K ROM} in, this will print char in A
    ret                 ; 1:10      bin16_dec}){}dnl
dnl
dnl
dnl
ifdef({USE_LSHIFT},{
;==============================================================================
; ( x u -- ? x<<u )
; shifts x left u places
;  Input: HL, DE
; Output: HL = DE << HL
; Pollutes: AF, B, DE, HL
DE_LSHIFT:              ;[28:]      de_lshift
    ld    A, 15         ; 2:7       de_lshift
    sub   L             ; 1:4       de_lshift
    sbc   A, A          ; 1:4       de_lshift
    or    H             ; 1:4       de_lshift
    jr   nz, DE_LSHIFTZ ; 2:7/12    de_lshift
    or    L             ; 1:4       de_lshift
    ex   DE, HL         ; 1:4       de_lshift   HL = x
    ret   z             ; 1:5/11    de_lshift    A = u
    ld    B, A          ; 1:4       de_lshift
    sub   0x08          ; 2:7       de_lshift
    jr    c, $+7        ; 2:7/12    de_lshift
    ld    H, L          ; 1:4       de_lshift
    ld    L, 0x00       ; 2:7       de_lshift   HL = HL << 8
    ret   z             ; 1:5/11    de_lshift
    ld    B, A          ; 1:4       de_lshift
    add  HL, HL         ; 1:11      de_lshift   HL = HL << 1
    djnz $-1            ; 2:8/13    de_lshift
    ret                 ; 1:10      de_lshift
DE_LSHIFTZ:             ;           de_lshift
    ld   HL, 0x0000     ; 3:10      de_lshift   HL = 0
    ret                 ; 1:10      de_lshift}){}dnl
dnl
dnl
dnl
ifdef({USE_RSHIFT},{
;==============================================================================
; ( x u -- x)
; shifts x right u places
;  Input: HL, DE
; Output: HL = DE >> HL
; Pollutes: AF, BC, DE, HL
DE_RSHIFT:              ;[ifdef({USE_LSHIFT},{28},{32}):]      de_rshift
    ld    A, 15         ; 2:7       de_rshift
    sub   L             ; 1:4       de_rshift
    sbc   A, A          ; 1:4       de_rshift
    or    H             ; 1:4       de_rshift
    jr   nz, ifdef({USE_LSHIFT},{DE_LSHIFTZ},{DE_RSHIFTZ}) ; 2:7/12    de_rshift
    or    L             ; 1:4       de_rshift
    ex   DE, HL         ; 1:4       de_rshift   HL = x
    ret   z             ; 1:5/11    de_rshift    A = u
    ld    B, A          ; 1:4       de_rshift
    sub   0x08          ; 2:7       de_rshift
    jr    c, $+7        ; 2:7/12    de_rshift
    ld    L, H          ; 1:4       de_rshift
    ld    H, 0x00       ; 2:7       de_rshift   HL = HL >> 8
    ret   z             ; 1:5/11    de_rshift
    ld    B, A          ; 1:4       de_rshift
    ld    A, L          ; 1:4       de_rshift
    srl   H             ; 2:8       de_rshift   unsigned
    rra                 ; 1:4       de_rshift   HA = HA >> 1
    djnz $-3            ; 2:8/13    de_rshift
    ld    L, A          ; 1:4       de_rshift
    ret                 ; 1:10      de_rshift{}ifdef({USE_LSHIFT},{},{
DE_RSHIFTZ:             ;           de_rshift
    ld   HL, 0x0000     ; 3:10      de_rshift   HL = 0
    ret                 ; 1:10      de_rshift})}){}dnl
dnl
dnl
dnl
ifdef({USE_DNEGATE},{
;==============================================================================
; ( d -- -d )
NEGATE_32:              ;[14:62]    negate_32
    xor   A             ; 1:4       negate_32
    ld    C, A          ; 1:4       negate_32
    sub   L             ; 1:4       negate_32
    ld    L, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, H          ; 1:4       negate_32
    ld    H, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, E          ; 1:4       negate_32
    ld    E, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, D          ; 1:4       negate_32
    ld    D, A          ; 1:4       negate_32
    ret                 ; 1:10      negate_32})dnl
dnl
dnl
ifdef({USE_DMAX},{
;==============================================================================
; ( 5 3 -- 5 )
; ( -5 -3 -- -3 )
; ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_max HL:lo_max )
MAX_32:                ;[21:104/129]max_32   ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_max HL:lo_max )
    push AF             ; 1:11      max_32   BC = lo_2
    ld    A, L          ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    sub   C             ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    ld    A, H          ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    sbc   A, B          ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    ex  (SP),HL         ; 1:19      max_32   HL = hi_2
    ld    A, E          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    sbc   A, L          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    ld    A, D          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    sbc   A, H          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    rra                 ; 1:4       max_32   carry --> sign
    xor   H             ; 1:4       max_32
    xor   D             ; 1:4       max_32
    jp    p, $+6        ; 3:10      max_32
    ex   DE, HL         ; 1:4       max_32   DE = hi_2
    pop  HL             ; 1:10      max_32   removing lo_1 from the stack
    push BC             ; 1:11      max_32
    pop  HL             ; 1:10      max_32
    ret                 ; 1:10      max_32})dnl
dnl
dnl
dnl
ifdef({USE_DMIN},{
;==============================================================================
; ( 5 3 -- 3 )
; ( -5 -3 -- -5 )
; ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_min HL:lo_min )
MIN_32:                ;[21:104/129]min_32   ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_min HL:lo_min )
    push AF             ; 1:11      min_32   BC = lo_2
    ld    A, C          ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    sub   L             ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    ld    A, B          ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    sbc   A, H          ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    ex  (SP),HL         ; 1:19      min_32   HL = hi_2
    ld    A, L          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    sbc   A, E          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    ld    A, H          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    sbc   A, D          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    rra                 ; 1:4       min_32   carry --> sign
    xor   H             ; 1:4       min_32
    xor   D             ; 1:4       min_32
    jp    p, $+6        ; 3:10      min_32
    ex   DE, HL         ; 1:4       min_32   DE = hi_2
    pop  HL             ; 1:10      min_32   removing lo_1 from the stack
    push BC             ; 1:11      min_32
    pop  HL             ; 1:10      min_32
    ret                 ; 1:10      min_32})dnl
dnl
dnl
dnl
ifdef({USE_DLT},{
;==============================================================================
; D<
; ( d2 d1 -- flag ) --> BC:lo_2 ( hi_2 ret DE:hi_1 HL:lo_1 -- flag )
; In: (SP+2) = hi_2, (SP) = ret, BC = lo_2, DE = hi_1, HL = lo_1
; Out: DE = (SP+4), HL = flag (d2 < d1)
LT_32:                  ;[18:110]   lt_32   ( hi_2 ret BC:lo_2 DE:hi_1 HL:lo_1 -- flag )
    ld    A, C          ; 1:4       lt_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    sub   L             ; 1:4       lt_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    ld    A, B          ; 1:4       lt_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    sbc   A, H          ; 1:4       lt_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    pop  BC             ; 1:10      lt_32   load ret
    pop  HL             ; 1:10      lt_32   HL = hi_2
    sbc  HL, DE         ; 2:15      lt_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    rra                 ; 1:4       lt_32   carry --> sign
    xor   H             ; 1:4       lt_32
    xor   D             ; 1:4       lt_32
    add   A, A          ; 1:4       lt_32   sign --> carry
    sbc   A, A          ; 1:4       lt_32   0x00 or 0xff
    ld    H, A          ; 1:4       lt_32
    ld    L, A          ; 1:4       lt_32
    pop  DE             ; 1:10      lt_32
    push BC             ; 1:11      lt_32   save ret
    ret                 ; 1:10      lt_32})dnl
dnl
dnl
dnl
ifdef({USE_MUL},{
;==============================================================================
include(M4PATH{}divmul/mul.m4){}dnl
})dnl
dnl
dnl
dnl
ifdef({USE_DIV},{ifdef({USE_UDIV},,define({USE_UDIV},{}))
;==============================================================================
include(M4PATH{}divmul/div.m4){}dnl
})dnl
dnl
dnl
dnl
ifdef({USE_UDIV},{
;==============================================================================
include(M4PATH{}divmul/udiv.m4){}dnl
})dnl
dnl
dnl
dnl
ifdef({USE_Random},{ifdef({USE_Rnd},,define({USE_Rnd},{}))
;==============================================================================
; ( max -- rand )
; 16-bit pseudorandom generator
; HL = random < max, or HL = 0
Random:                 ;[41:]      Random
    ld    A, H          ; 1:4       Random
    or    A             ; 1:4       Random
    jr    z, Random_0L  ; 2:7/11    Random
    ld    C, 0xFF       ; 2:7       Random
    xor   A             ; 1:4       Random
    adc   A, A          ; 1:4       Random
    cp    H             ; 1:4       Random
    jr    c, $-2        ; 2:7/11    Random
    ld    B, A          ; 1:4       Random   BC = mask = 0x??FF
    jr   Random_Begin   ; 2:12      Random
Random_0L:              ;           Random
    ld    B, A          ; 1:4       Random
    or    L             ; 1:4       Random
    ret   z             ; 1:5/11    Random
    xor   A             ; 1:4       Random
    adc   A, A          ; 1:4       Random
    cp    L             ; 1:4       Random
    jr    c, $-2        ; 2:7/11    Random
    ld    C, A          ; 1:4       Random   BC = mask = 0x00??
;------------------------------------------------------------------------------
; In: BC = mask, HL = max
; Out: HL = 0..max-1
Random_Begin:           ;           Random
    push  DE            ; 1:11      Random
    ex    DE, HL        ; 1:4       Random   DE = max
Random_Next:            ;           Random
    call Rnd            ; 3:17      Random
    ld    A, C          ; 1:4       Random
    and   L             ; 1:4       Random
    ld    L, A          ; 1:4       Random
    ld    A, B          ; 1:4       Random
    and   H             ; 1:4       Random
    ld    H, A          ; 1:4       Random
    sbc  HL, DE         ; 2:15      Random
    jr   nc, Random_Next; 2:7/11    Random
    add  HL, DE         ; 1:11      Random
    pop  DE             ; 1:10      Random
    ret                 ; 1:10      Random}){}dnl
dnl
dnl
dnl
ifdef({USE_Rnd},{
;==============================================================================
; ( -- rand )
; 16-bit pseudorandom generator
; Out: HL = 0..65535
; Pollutes: AF, AF', HL
Rnd:                    ;[44:182]   rnd
SEED_8BIT EQU $+1
    ld    L, 0x01       ; 2:7       rnd   seed must not be 0
    ld    A, L          ; 1:4       rnd
    rrca                ; 1:4       rnd
    rrca                ; 1:4       rnd
    rrca                ; 1:4       rnd
    xor  0x1F           ; 2:7       rnd   A = 32*L
    add   A, L          ; 2:7       rnd   A = 33*L
    sbc   A, 0xFF       ; 2:7       rnd   carry
    ld  (SEED_8BIT), A  ; 3:13      rnd   save new 8bit number
    ex   AF, AF'        ; 1:4       rnd
SEED EQU $+1
    ld   HL, 0x0001     ; 3:10      rnd   seed must not be 0
    ld    A, H          ; 1:4       rnd
    rra                 ; 1:4       rnd   hi.0 bit to carry
    ld    A, L          ; 1:4       rnd
    rra                 ; 1:4       rnd
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd   hi(xs) ^= hi(xs << 7);
    ld    A, L          ; 1:4       rnd
    rra                 ; 1:4       rnd   lo.0 bit to carry
    ld    A, H          ; 1:4       rnd
    rra                 ; 1:4       rnd
    xor   L             ; 1:4       rnd
    ld    L, A          ; 1:4       rnd   lo(xs) ^= lo(xs << 7) + (xs >> 9);
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd   xs ^= xs << 8;
    ld  (SEED), HL      ; 3:16      rnd   save new 16bit number
    ex   AF, AF'        ; 1:4       rnd
    xor   L             ; 1:4       rnd
    ld    L, A          ; 1:4       rnd
    ld    A, R          ; 2:9       rnd
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd
    ret                 ; 1:10      rnd}){}dnl
dnl
dnl
dnl
ifdef({USE_KEY},{
;==============================================================================
; Read key from keyboard
; In:
; Out: push stack, TOP = HL = key
READKEY:
    ex   DE, HL         ; 1:4       readkey
    ex  (SP),HL         ; 1:19      readkey
    push HL             ; 1:11      readkey
    ld   BC, 0x5C08     ; 3:10      readkey {ZX Spectrum LAST K} system variable
    xor   A             ; 1:4       readkey
    ld    H, A          ; 1:4       readkey
    ld  (BC),A          ; 1:7       readkey
    ld    A,(BC)        ; 1:7       readkey read new value of {LAST K}
    cp    H             ; 1:4       readkey is it still zero?
    jr    z, $-2        ; 2:7/12    readkey
    ld    L, A          ; 1:4       readkey
    ret                 ; 1:10      readkey}){}dnl
dnl
dnl
dnl
ifdef({USE_ACCEPT},{
;==============================================================================
; Read string from keyboard
; In: DE = addr, HL = length
; Out: 2x pop stack, TOP = HL = loaded
READSTRING:
    ld    B, D          ; 1:4       readstring
    ld    C, E          ; 1:4       readstring BC = addr
    ex   DE, HL         ; 1:4       readstring
READSTRING2:
    xor   A             ; 1:4       readstring
    ld    (0x5C08),A    ; 3:13      readstring {ZX Spectrum LAST K} system variable

    ld    A,(0x5C08)    ; 3:13      readstring read new value of {LAST K}
    or    A             ; 1:4       readstring is it still zero?
    jr    z, $-4        ; 2:7/12    readstring

    cp  0x0D            ; 2:7       readstring enter?
    jr    z, READSTRING3; 2:7/12    readstring
    ld  (HL),A          ; 1:7       readstring
    inc  HL             ; 1:6       readstring
    dec  DE             ; 1:6       readstring
    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A
    ld    A, D          ; 1:4       readstring
    or    E             ; 1:4       readstring
    jr   nz, READSTRING2; 2:7/12    readstring
READSTRING3:
    or    A             ; 1:4       readstring
    sbc  HL, BC         ; 2:15      readstring

    pop  BC             ; 1:10      readstring ret
    pop  DE             ; 1:10      readstring
    push BC             ; 1:11      readstring ret
    ret                 ; 1:10      readstring}){}dnl
dnl
dnl
dnl
ifdef({USE_TYPE},{
;==============================================================================
; ( addr n -- )
; print n chars from addr
;  Input: HL, DE
; Output: Print decimal number in HL
; Pollutes: AF, BC, DE
PRINT_TYPE:             ;[10:76]    print_string
    ld    B, H          ; 1:4       print_string
    ld    C, L          ; 1:4       print_string   BC = length of string to print
    call 0x203C         ; 3:17      print_string   Use {ZX 48K ROM}
    pop  AF             ; 1:10      print_string   load ret
    pop  HL             ; 1:10      print_string
    pop  DE             ; 1:10      print_string
    push AF             ; 1:11      print_string   save ret
    ret                 ; 1:10      print_string}){}dnl
dnl
dnl
dnl
ifdef({USE_TYPE_Z},{
;==============================================================================
; Print C-style stringZ
; In: HL = addr stringZ
; Out: BC = addr zero
PRINT_TYPE_Z:           ;           print_type_z
    ld    B, H          ; 1:4       print_type_z
    ld    C, L          ; 1:4       print_type_z   BC = addr stringZ
__{}define({USE_STRING_Z},{})dnl
    jr    PRINT_STRING_Z; 2:12      print_type_z
}){}dnl
dnl
dnl
dnl
ifdef({USE_STRING_Z},{
;==============================================================================
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst   0x10          ; 1:11      print_string_z putchar with {ZX 48K ROM} in, this will print char in A
    inc  BC             ; 1:6       print_string_z
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z
}){}dnl
dnl
dnl
dnl
ifelse(ALL_VARIABLE,{},,{
VARIABLE_SECTION:
}ALL_VARIABLE
){}dnl
dnl
dnl
dnl
ifdef({STRING_NUM_STACK},{
STRING_SECTION:{}PRINT_STRING_STACK
})dnl
dnl
dnl
dnl
