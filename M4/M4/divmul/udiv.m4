dnl ## multiplication
define({___},{})dnl
dnl
dnl
dnl
; Divide 16-bit unsigned values (with 16-bit result)
; In: DE / HL
; Out: HL = DE / HL, DE = DE % HL
UDIVIDE:{}ifelse(TYPDIV,{old_fast},{
                        ;           old_fast version
    ex   DE, HL         ; 1:4       HL/DE
    ld    A, D          ; 1:4
    or    A             ; 1:4
    jp   nz, UDIVIDE_16 ; 3:10      HL/0E

    sla   H             ; 2:8       AHL = 0HL
    jr    c, UDIVIDE1   ; 2:7/12
    jr    z, UDIVIDE_8H ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE2   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE3   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE4   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE5   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE6   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE7   ; 2:7/12
    sla   H             ; 2:8
    jr    c, UDIVIDE8   ; 2:7/12
UDIVIDE_8H:
    sla   L             ; 2:8
    jr    c, UDIVIDE9   ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE10  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE11  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE12  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE13  ; 2:7/12
    sla   L             ; 2:8
    jr    c, UDIVIDE14  ; 2:7/12
    sla   L             ; 2:8
    jp    c, UDIVIDE15  ; 3:10
    sla   L             ; 2:8
    jp    c, UDIVIDE16  ; 3:10

    ld    E, D          ; 1:4
    ret                 ; 1:10

;1
UDIVIDE1:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;2
    sla   H             ; 2:8
UDIVIDE2:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;3
    sla   H             ; 2:8
UDIVIDE3:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;4
    sla   H             ; 2:8
UDIVIDE4:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;5
    sla   H             ; 2:8
UDIVIDE5:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;6
    sla   H             ; 2:8
UDIVIDE6:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;7
    sla   H             ; 2:8
UDIVIDE7:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4
;8
    sla   H             ; 2:8
UDIVIDE8:
    rla                 ; 1:4       AL << 1
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   H             ; 1:4

;9
    sla   L             ; 2:8
UDIVIDE9:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;10
    sla   L             ; 2:8
UDIVIDE10:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;11
    sla   L             ; 2:8
UDIVIDE11:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;12
    sla   L             ; 2:8
UDIVIDE12:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;13
    sla   L             ; 2:8
UDIVIDE13:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;14
    sla   L             ; 2:8
UDIVIDE14:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;15
    sla   L             ; 2:8
UDIVIDE15:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4
;16
    sla   L             ; 2:8
UDIVIDE16:
    rla                 ; 1:4       AL << 1
    jr    c, $+5        ; 2:7/12
    cp    E             ; 1:4       A-E?
    jr    c, $+4        ; 2:7/12
    sub   E             ; 1:4
    inc   L             ; 1:4

    ld    E, A          ; 1:4       DE = DE % HL
    ret                 ; 1:10

UDIVIDE_16:             ;           DE >= 256
    ld    A, L          ; 1:4
    ld    L, H          ; 1:4
    ld    H, 0x00       ; 2:7       00HL --> 0HLA

;1 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;2 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;3 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;4 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;5 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;6 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;7 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

;8 16b/256+
    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE?
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back

    rla                 ; 1:4
    cpl                 ; 1:4
    ex   DE, HL         ; 1:4
    ld    H, 0x00       ; 2:7
    ld    L, A          ; 1:4
    ret                 ; 1:10},
TYPDIV,{old},
{
                        ;           old version
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, D          ; 1:4
    or    A             ; 1:4
    jr   nz, UDIVIDE_16 ; 2:7/12

    ld    B, 16         ; 2:7
    add  HL, HL         ; 1:11      2*HL
    jr    c, $+7        ; 2:7/12
    djnz $-3            ; 2:13/8

    ld    E, A          ; 1:4       DE = 0 % 0E = 0
    ret                 ; 1:10      HL = 0 / 0E = 0

    add  HL, HL         ; 1:11      2*HL
    rla                 ; 1:4
    jr    c, $+5        ; 2:7/12    fix 256 / 129..255
    cp    E             ; 1:4
    jr    c, $+4        ; 2:7/12
    inc   L             ; 1:4
    sub   E             ; 1:4
    djnz $-9            ; 2:13/8

    ld    E, A          ; 1:4       DE = DE % HL
    ret                 ; 1:10      HL = DE / HL

UDIVIDE_16:             ;           HL/256+
    ld    A, L          ; 1:4
    ld    L, H          ; 1:4
    ld    H, 0x00       ; 2:7       HLA = 0HL
    ld    B, 0x08       ; 2:7

    rla                 ; 1:4
    adc  HL, HL         ; 2:15
    sbc  HL, DE         ; 2:15      HL-DE
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    djnz $-8            ; 2:8/13

    rla                 ; 1:4
    cpl                 ; 1:4
    ex   DE, HL         ; 1:4
    ld    H, B          ; 1:4
    ld    L, A          ; 1:4
    ret                 ; 1:10},
TYPDIV,{fast},
{
    ld    A, H          ; 1:4       fast version
    or    L             ; 1:4       HL = DE / HL
    ret   z             ; 1:5/11    HL = DE / 0
    ld   BC, 0x00FF     ; 3:10
if 1
    ld    A, D          ; 1:4
UDIVIDE_LE:
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11
    jr    c, UDIVIDE_GT ; 2:7/12
    cp    H             ; 1:4
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE
else
UDIVIDE_LE:
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11
    jr    c, UDIVIDE_GT ; 2:7/12
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jp    c, UDIVIDE_LE ; 3:10
    jp   nz, UDIVIDE_GT ; 3:10
    ld    A, E          ; 1:4
    sub   L             ; 1:4
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE
endif
UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0xFFFF = inverted result
;1
    rr    D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;2
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;3
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;4
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;5
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;6
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;7
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12
;8
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    dec   B             ; 1:4       B--
    jr    z, UDIVIDE_END; 2:7/12

UDIVIDE_LOOP:
    srl   D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    adc   A, A          ; 1:4
    rl    C             ; 2:8
    djnz UDIVIDE_LOOP   ; 2:8/13    B--

    ex   DE, HL         ; 1:4
    cpl                 ; 1:4
    ld    L, A          ; 1:4
    ld    A, C          ; 1:4
    cpl                 ; 1:4
    ld    H, A          ; 1:4
    ret                 ; 1:10

UDIVIDE_END:
    ex   DE, HL         ; 1:4
    cpl                 ; 1:4
    ld    L, A          ; 1:4
    ld    H, B          ; 1:4
    ret                 ; 1:10},
TYPDIV,{small},{
    ld    A, H          ; 1:4       small version
    or    L             ; 1:4       HL = DE / HL
    ret   z             ; 1:5/11    HL = DE / 0
    ld   BC, 0x0000     ; 3:10
    ld    A, D          ; 1:4
UDIVIDE_LE:
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11
    jr    c, UDIVIDE_GT ; 2:7/12
    cp    H             ; 1:4
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE
UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0x0000 = result
UDIVIDE_LOOP:
    rr    D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    ccf                 ; 1:4       inverts carry flag
    adc   A, A          ; 1:4
    rl    C             ; 2:8
    djnz UDIVIDE_LOOP   ; 2:8/13    B--

    ex   DE, HL         ; 1:4
    ld    L, A          ; 1:4
    ld    H, C          ; 1:4
    ret                 ; 1:10},
TYPDIV,{synthesis},
{
    ld    A, H          ; 1:4       synthesis version
    or    A             ; 1:4
    jr    z, UDIVIDE_0L ; 2:7/12

    ld   BC, 0x0000     ; 3:10
    ld    A, D          ; 1:4
UDIVIDE_LE:
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11
    jr    c, UDIVIDE_GT ; 2:7/12
    cp    H             ; 1:4
    jp   nc, UDIVIDE_LE ; 3:10
UDIVIDE_NC:             ;
    or    A             ; 1:4       HL > DE

UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0x0000 = result
UDIVIDE_LOOP:
    rr    D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    ccf                 ; 1:4       inverts carry flag
    adc   A, A          ; 1:4
    rl    C             ; 2:8
    djnz UDIVIDE_LOOP   ; 2:8/13    B--

    ex   DE, HL         ; 1:4
    ld    L, A          ; 1:4
    ld    H, C          ; 1:4
    ret                 ; 1:10

UDIVIDE_0L:             ;           HL = DE / 0L
    cp    L             ; 1:4
    ret   z             ; 1:5/11    HL = DE / 0
if 1
    ld    A, E          ; 1:4
    sub   L             ; 1:4
    ld    A, D          ; 1:4
    sbc   A, H          ; 1:4
    jr    c, UDIVIDE_Z  ; 1:7/12

    ld    A, D          ; 1:4
    cp    L             ; 1:4
    jr    c, UDIVIDE_LO ; 2:7/12
    xor   A             ; 1:4
else
    cp    D             ; 1:4
    jr    z, UDIVIDE_LO ; 2:7/12
endif
    ld    B, 0x04       ; 2:7
UDIVIDE_D:
    sla   D             ; 2:8
    rla                 ; 1:4       AD << 1
    cp    L             ; 1:4       A-L?
    jr    c,$+4         ; 2:7/12
    sub   L             ; 1:4
    inc   D             ; 1:4

    sla   D             ; 2:8
    rla                 ; 1:4       AD << 1
    cp    L             ; 1:4       A-L?
    jr    c,$+4         ; 2:7/12
    sub   L             ; 1:4
    inc   D             ; 1:4
    djnz UDIVIDE_D      ; 2:8/13    B--

    ld    H, D          ; 1:4

UDIVIDE_LO:
    ld    B, 0x04       ; 2:7
UDIVIDE_E:
    sla   E             ; 2:8
    rla                 ; 1:4       AE << 1
    jr    c, $+5        ; 2:7/12
    cp    L             ; 1:4       A-L?
    jr    c, $+4        ; 2:7/12
    sub   L             ; 1:4
    inc   E             ; 1:4

    sla   E             ; 2:8
    rla                 ; 1:4       AE << 1
    jr    c, $+5        ; 2:7/12
    cp    L             ; 1:4       A-L?
    jr    c, $+4        ; 2:7/12
    sub   L             ; 1:4
    inc   E             ; 1:4
    djnz UDIVIDE_E      ; 2:8/13    B--

    ld    L, E          ; 1:4       HL = DE / HL
    ld    D, B          ; 1:4
    ld    E, A          ; 1:4       DE = DE % HL
    ret                 ; 1:10
UDIVIDE_Z:
    ld    L, H          ; 1:4
    ret                 ; 1:10},
{
                        ;[51:cca 900] # default version can be changed with "define({TYPDIV},{name})", name=old_fast,old,fast,small,synthesis
                        ; /3 --> cca 1551, /5 --> cca 1466, 7/ --> cca 1414, /15 --> cca 1290, /17 --> cca 1262, /31 --> cca 1172, /51 --> cca 1098, /63 --> cca 1058, /85 --> cca 1014, /255 --> cca 834
    ld    A, H          ; 1:4
    or    L             ; 1:4       HL = DE / HL
    ret   z             ; 1:5/11    HL = DE / 0?

    ld   BC, 0x0000     ; 3:10
if 0
UDIVIDE_LE:
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11
    jr    c, UDIVIDE_GT ; 2:7/12
    ld    A, H          ; 1:4
    sub   D             ; 1:4
    jp    c, UDIVIDE_LE ; 3:10
    jp   nz, UDIVIDE_GT ; 3:10
    ld    A, E          ; 1:4
    sub   L             ; 1:4
else
    ld    A, D          ; 1:4
UDIVIDE_LE:
    inc   B             ; 1:4       B++
    add  HL, HL         ; 1:11
    jr    c, UDIVIDE_GT ; 2:7/12
    cp    H             ; 1:4
endif
    jp   nc, UDIVIDE_LE ; 3:10
    or    A             ; 1:4       HL > DE

UDIVIDE_GT:             ;
    ex   DE, HL         ; 1:4       HL = HL / DE
    ld    A, C          ; 1:4       CA = 0x0000 = result
UDIVIDE_LOOP:
    rr    D             ; 2:8
    rr    E             ; 2:8       DE >> 1
    sbc  HL, DE         ; 2:15
    jr   nc, $+3        ; 2:7/12
    add  HL, DE         ; 1:11      back
    ccf                 ; 1:4       inverts carry flag
    adc   A, A          ; 1:4
    rl    C             ; 2:8
    djnz UDIVIDE_LOOP   ; 2:8/13    B--

    ex   DE, HL         ; 1:4
    ld    L, A          ; 1:4
    ld    H, C          ; 1:4
    ret                 ; 1:10{}dnl
}){}dnl
dnl
dnl
dnl
