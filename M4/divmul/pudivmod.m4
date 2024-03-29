dnl ## division
define({__},{})dnl
dnl
dnl
dnl
dnl
dnl
dnl
ifdef({USE_PDIVMOD},{dnl
__{}ifelse(PUDM_MIN:PUDM_MAX,1:1,{dnl
; Divide 8-bit signed values from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
P8DM:                   ;           p8dm
    push BC             ; 1:11      p8dm
    exx                 ; 1:4       p8dm
    ex  [SP],HL         ; 1:19      p8dm   save R.A.S. && [HL'] = divisor
    xor   A             ; 1:4       p8dm
    or  [HL]            ; 1:7       p8dm
    ld    D, A          ; 1:4       p8dm   divisor sign
    call  m, PDM_NEG    ; 3:17      p8dm
    exx                 ; 1:4       p8dm   abs([BC])
                        ;           p8dm
    push DE             ; 1:11      p8dm
    exx                 ; 1:4       p8dm
    pop  HL             ; 1:10      p8dm   [HL'] = dividend
    ld    A,[HL]        ; 1:7       p8dm
    xor   D             ; 1:4       p8dm
    push AF             ; 1:11      p8dm   the sign of the result
    xor   D             ; 1:4       p8dm
    push AF             ; 1:11      p8dm   remainder sign
    call  m, PDM_NEG    ; 3:17      p8dm
    exx                 ; 1:4       p8dm   abs([DE])
                        ;           p8dm
    call P16UDM         ; 3:17      p8dm
                        ;           p8dm
    pop  AF             ; 1:10      p8dm   remainder sign
    ex   DE, HL         ; 1:4       p8dm
    call  m, PDM_NEG    ; 3:17      p8dm
    ex   DE, HL         ; 1:4       p8dm
                        ;           p8dm
    pop  AF             ; 1:10      p8dm   the sign of the result
    jp    p, $+6        ; 3:10      p8dm
    call PDM_NEG        ; 3:17      p8dm
                        ;           p8dm
    push BC             ; 1:11      p8dm
    exx                 ; 1:4       p8dm
    pop  HL             ; 1:10      p8dm   [HL'] = divisor
    xor   A             ; 1:4       p8dm
    or    D             ; 1:4       p8dm   divisor sign
    call  m, PDM_NEG    ; 3:17      p8dm
    pop  HL             ; 1:10      p8dm   load R.A.S.
    exx                 ; 1:4       p8dm
                        ;           p8dm
    ret                 ; 1:10      p8dm
PDM_NEG:                ;           p8dm_neg
    xor   A             ; 1:4       p8dm_neg
    sub [HL]            ; 1:7       p8dm_neg
    ld  [HL],A          ; 1:7       p8dm_neg
    ret                 ; 1:10      p8dm_neg},
__{}PUDM_MIN:PUDM_MAX,2:2,{dnl
; Divide 16-bit signed values from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
P16DM:                  ;           p16dm
    push BC             ; 1:11      p16dm
    exx                 ; 1:4       p16dm
    ex  [SP],HL         ; 1:19      p16dm   save R.A.S. && [HL'] = divisor
    inc   L             ; 1:4       p16dm
    xor   A             ; 1:4       p16dm
    or  [HL]            ; 1:7       p16dm
    ld    D, A          ; 1:4       p16dm   divisor sign
    call  m, PDM_NEG1   ; 3:17      p16dm
    exx                 ; 1:4       p16dm   abs([BC])
                        ;           p16dm
    push DE             ; 1:11      p16dm
    exx                 ; 1:4       p16dm
    pop  HL             ; 1:10      p16dm   [HL'] = dividend
    inc   L             ; 1:4       p16dm
    ld    A,[HL]        ; 1:7       p16dm
    xor   D             ; 1:4       p16dm
    push AF             ; 1:11      p16dm   the sign of the result
    xor   D             ; 1:4       p16dm
    push AF             ; 1:11      p16dm   remainder sign
    call  m, PDM_NEG1   ; 3:17      p16dm
    exx                 ; 1:4       p16dm   abs([DE])
                        ;           p16dm
    call P16UDM         ; 3:17      p16dm
                        ;           p16dm
    pop  AF             ; 1:10      p16dm   remainder sign
    ex   DE, HL         ; 1:4       p16dm
    call  m, PDM_NEG2   ; 3:17      p16dm
    ex   DE, HL         ; 1:4       p16dm
                        ;           p16dm
    pop  AF             ; 1:10      p16dm   the sign of the result
    jp    p, $+6        ; 3:10      p16dm
    call PDM_NEG2       ; 3:17      p16dm
                        ;           p16dm
    push BC             ; 1:11      p16dm
    exx                 ; 1:4       p16dm
    pop  HL             ; 1:10      p16dm   [HL'] = divisor
    xor   A             ; 1:4       p16dm
    or    D             ; 1:4       p16dm   divisor sign
    call  m, PDM_NEG2   ; 3:17      p16dm
    pop  HL             ; 1:10      p16dm   load R.A.S.
    exx                 ; 1:4       p16dm
                        ;           p16dm
    ret                 ; 1:10      p16dm
PDM_NEG1:               ;           p16dm_neg
    dec   L             ; 1:4       p16dm_neg
PDM_NEG2:               ;           p16dm_neg
    xor   A             ; 1:4       p16dm_neg
    sub [HL]            ; 1:7       p16dm_neg
    ld  [HL],A          ; 1:7       p16dm_neg
    inc   L             ; 1:4       p16dm_neg
    ld    A, 0x00       ; 2:7       p16dm_neg
    sbc   A,[HL]        ; 1:7       p16dm_neg
    ld  [HL],A          ; 1:7       p16dm_neg
    ret                 ; 1:10      p16dm_neg},
__{}PUDM_MIN:PUDM_MAX,256:256,{dnl
; Divide 2048-bit signed values from pointer
; In: [BC], [DE], [HL]
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
P2048DM:                ;           p2048dm
    push BC             ; 1:11      p2048dm
    exx                 ; 1:4       p2048dm
    ex  [SP],HL         ; 1:19      p2048dm   save R.A.S. && [HL'] = divisor
    dec   L             ; 1:4       p2048dm
    xor   A             ; 1:4       p2048dm
    or  [HL]            ; 1:7       p2048dm
    ld    D, A          ; 1:4       p2048dm   divisor sign
    call  m, PDM_NEG1   ; 3:17      p2048dm
    exx                 ; 1:4       p2048dm   abs([BC])
                        ;           p2048dm
    push DE             ; 1:11      p2048dm
    exx                 ; 1:4       p2048dm
    pop  HL             ; 1:10      p2048dm   [HL'] = dividend
    dec   L             ; 1:4       p2048dm
    ld    A,[HL]        ; 1:7       p2048dm
    xor   D             ; 1:4       p2048dm
    push AF             ; 1:11      p2048dm   the sign of the result
    xor   D             ; 1:4       p2048dm
    push AF             ; 1:11      p2048dm   remainder sign
    call  m, PDM_NEG1   ; 3:17      p2048dm
    exx                 ; 1:4       p2048dm   abs([DE])
                        ;           p2048dm
    call P2048UDM       ; 3:17      p2048dm
                        ;           p2048dm
    push DE             ; 1:11      p2048dm
    exx                 ; 1:4       p2048dm
    pop  HL             ; 1:10      p2048dm   [HL'] = remainder
    pop  AF             ; 1:10      p2048dm   remainder sign
    call  m, PDM_NEG2   ; 3:17      p2048dm
    exx                 ; 1:4       p2048dm
                        ;           p2048dm
    pop  AF             ; 1:10      p2048dm   the sign of the result
    jp    p, $+10       ; 3:10      p2048dm
    push HL             ; 1:11      p2048dm
    exx                 ; 1:4       p2048dm
    pop  HL             ; 1:10      p2048dm   [HL'] = result
    call PDM_NEG2       ; 3:17      p2048dm
    exx                 ; 1:4       p2048dm
                        ;           p2048dm
    push BC             ; 1:11      p2048dm
    exx                 ; 1:4       p2048dm
    pop  HL             ; 1:10      p2048dm   [HL'] = divisor
    xor   A             ; 1:4       p2048dm
    or    D             ; 1:4       p2048dm   divisor sign
    call  m, PDM_NEG2   ; 3:17      p2048dm
    pop  HL             ; 1:10      p2048dm   load R.A.S.
    exx                 ; 1:4       p2048dm
                        ;           p2048dm
    ret                 ; 1:10      p2048dm
PDM_NEG1:               ;           p2048dm_neg
    inc   L             ; 1:4       p2048dm_neg   = 0
PDM_NEG2:               ;           p2048dm_neg
    ld    C, L          ; 1:4       p2048dm_neg   = 0
    ld    A, C          ; 1:4       p2048dm_neg
    sbc   A,[HL]        ; 1:7       p2048dm_neg
    ld  [HL],A          ; 1:7       p2048dm_neg
    inc   L             ; 1:4       p2048dm_neg
    jr   nz, $-4        ; 2:7/12    p2048dm_neg
    ret                 ; 1:10      p2048dm_neg},
{
; Divide 8..2048-bit signed values from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
PDM:                    ;           pdm
    push BC             ; 1:11      pdm
    exx                 ; 1:4       pdm
    ex  [SP],HL         ; 1:19      pdm   save R.A.S. && [HL'] = divisor
    ld    E, A          ; 1:4       pdm   sizeof(number) in bytes

    ld    B, L          ; 1:4       pdm   save offset
    add   A, L          ; 1:4       pdm
    dec   A             ; 1:4       pdm
    ld    L, A          ; 1:4       pdm
    xor   A             ; 1:4       pdm
    or  [HL]            ; 1:7       pdm
    ld    D, A          ; 1:4       pdm   divisor sign
    call  m, PDM_NEG1   ; 3:17      pdm
    exx                 ; 1:4       pdm   abs([BC])
                        ;           pdm
    push DE             ; 1:11      pdm
    exx                 ; 1:4       pdm
    pop  HL             ; 1:10      pdm   [HL'] = dividend
    ld    B, L          ; 1:4       pdm   save offset
    ld    A, E          ; 1:4       pdm
    add   A, L          ; 1:4       pdm
    dec   A             ; 1:4       pdm
    ld    L, A          ; 1:4       pdm
    ld    A,[HL]        ; 1:7       pdm
    xor   D             ; 1:4       pdm
    push AF             ; 1:11      pdm   the sign of the result
    xor   D             ; 1:4       pdm
    push AF             ; 1:11      pdm   remainder sign
    call  m, PDM_NEG1   ; 3:17      pdm
    ld    A, E          ; 1:4       pdm   A = sizeof(number) in bytes
    exx                 ; 1:4       pdm   abs([DE])
                        ;           pdm
ifelse(eval(PUDM_MIN<=32):eval(PUDM_MAX<=32),1:1,{dnl
__{}    call P256UDM        ; 3:17      pdm},
{dnl
__{}    call PUDM           ; 3:17      pdm})
                        ;           pdm
    push DE             ; 1:11      pdm
    exx                 ; 1:4       pdm
    pop  HL             ; 1:10      pdm   [HL'] = remainder
    pop  AF             ; 1:10      pdm   remainder sign
    call  m, PDM_NEG2   ; 3:17      pdm
    exx                 ; 1:4       pdm
                        ;           pdm
    pop  AF             ; 1:10      pdm   the sign of the result
    jp    p, $+10       ; 3:10      pdm
    push HL             ; 1:11      pdm
    exx                 ; 1:4       pdm
    pop  HL             ; 1:10      pdm   [HL'] = result
    call PDM_NEG2       ; 3:17      pdm
    exx                 ; 1:4       pdm
                        ;           pdm
    push BC             ; 1:11      pdm
    exx                 ; 1:4       pdm
    pop  HL             ; 1:10      pdm   [HL'] = divisor
    xor   A             ; 1:4       pdm
    or    D             ; 1:4       pdm   divisor sign
    call  m, PDM_NEG2   ; 3:17      pdm
    pop  HL             ; 1:10      pdm   load R.A.S.
    exx                 ; 1:4       pdm
                        ;           pdm
    ret                 ; 1:10      pdm
PDM_NEG1:               ;           pdm_neg
    ld    L, B          ; 1:4       pdm_neg   load offset
PDM_NEG2:               ;           pdm_neg
    ld    B, E          ; 1:4       pdm_neg
    ld    C, 0x00       ; 2:7       pdm_neg
    ld    A, C          ; 1:4       pdm_neg
    sbc   A,[HL]        ; 1:7       pdm_neg
    ld  [HL],A          ; 1:7       pdm_neg
    inc   L             ; 1:4       pdm_neg
    djnz $-4            ; 2:8/13    pdm_neg
    ret                 ; 1:10      pdm_neg}){}dnl
}){}dnl
dnl
dnl
dnl
ifelse(PUDM_MIN:PUDM_MAX,1:1,{
; Divide 8-bit unsigned value from pointer
; In: [BC], [DE], [HL]
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
__{}P8UDM:                  ;           p8udm
__{}    push BC             ; 1:11      p8udm
__{}    ld    A,[DE]        ; 1:7       p8udm
__{}    ex  [SP],HL         ; 1:19      p8udm
__{}    ld   BC, 0x0000     ; 2:7       p8udm
__{}    inc   B             ; 1:4       p8udm
__{}    sla [HL]            ; 2:15      p8udm
__{}    jr    c, $+8        ; 2:7/12    p8udm
__{}    jr    z, $+19       ; 2:7/12    p8udm   exit with div 0
__{}    cp  [HL]            ; 1:7       p8udm
__{}    jr   nc, $-8        ; 2:7/12    p8udm
__{}    or    A             ; 1:4       p8udm
__{}    rr  [HL]            ; 2:15      p8udm
__{}    sla   C             ; 2:8       p8udm   result *= 2
__{}    cp  [HL]            ; 1:7       p8udm
__{}    jr    c, $+4        ; 2:7/12    p8udm
__{}    sub [HL]            ; 1:7       p8udm
__{}    inc   C             ; 1:4       p8udm   result += 1
__{}    djnz $-10           ; 2:8/13    p8udm
__{}    ex  [SP],HL         ; 1:19      p8udm
__{}    ld  [HL],C          ; 1:7       p8udm
__{}    ld  [DE],A          ; 1:7       p8udm
__{}    pop  BC             ; 1:10      p8udm
__{}    ret                 ; 1:10      p8udm},
PUDM_MIN:PUDM_MAX,2:2,{
; Divide 16-bit unsigned value from pointer
; In: [BC], [DE], [HL]
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
__{}P16UDM:                 ;           p16udm
__{}    push BC             ; 1:11      p16udm
__{}    xor   A             ; 1:4       p16udm
__{}    ld  [HL],A          ; 1:7       p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    ld  [HL],A          ; 1:7       p16udm
__{}    dec   L             ; 1:4       p16udm   p16_res = 0
__{}    ex  [SP],HL         ; 1:19      p16udm

__{}    ld    B, A          ; 1:4       p16udm

__{}    inc   L             ; 1:4       p16udm
__{}    or  [HL]            ; 1:7       p16udm
__{}    dec   L             ; 1:4       p16udm
__{}    or  [HL]            ; 1:7       p16udm   p16_3 == 0?
__{}    jr    z, $+57       ; 2:7/12    p16udm   exit with div 0

__{}    inc   B             ; 1:4       p16udm
__{}    sla [HL]            ; 2:15      p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    rl  [HL]            ; 2:15      p16udm
__{}    dec   L             ; 1:4       p16udm   p16_3 *= 2
__{}    jr   nc, $-7        ; 2:7/12    p16udm

__{}    inc   L             ; 1:4       p16udm
__{}    rr  [HL]            ; 2:15      p16udm
__{}    dec   L             ; 1:4       p16udm
__{}    rr  [HL]            ; 2:15      p16udm

__{}    ex  [SP],HL         ; 1:19      p16udm
__{}    sla [HL]            ; 2:15      p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    rl  [HL]            ; 2:15      p16udm   result *= 2
__{}    dec   L             ; 1:4       p16udm
__{}    ex  [SP],HL         ; 1:19      p16udm

__{}    ld    A,[DE]        ; 1:7       p16udm
__{}    sub [HL]            ; 1:7       p16udm
__{}    ld  [DE],A          ; 1:7       p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    inc   E             ; 1:4       p16udm
__{}    ld    A,[DE]        ; 1:7       p16udm
__{}    sbc   A,[HL]        ; 1:7       p16udm
__{}    ld  [DE],A          ; 1:7       p16udm
__{}    dec   L             ; 1:4       p16udm
__{}    dec   E             ; 1:4       p16udm

__{}    jr    c, $+9        ; 2:7/12    p16udm

__{}    ex  [SP],HL         ; 1:19      p16udm
__{}    inc [HL]            ; 1:11      p16udm   result += 1
__{}    ex  [SP],HL         ; 1:19      p16udm
__{}    djnz $-29           ; 2:8/13    p16udm
__{}    jr   $+15           ; 2:7/12    p16udm

__{}    ld    A,[DE]        ; 1:7       p16udm
__{}    add   A,[HL]        ; 1:7       p16udm
__{}    ld  [DE],A          ; 1:7       p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    inc   E             ; 1:4       p16udm
__{}    ld    A,[DE]        ; 1:7       p16udm
__{}    adc   A,[HL]        ; 1:7       p16udm
__{}    ld  [DE],A          ; 1:7       p16udm
__{}    dec   L             ; 1:4       p16udm
__{}    dec   E             ; 1:4       p16udm

__{}    or    A             ; 1:4       p16udm

__{}    djnz $-44           ; 2:8/13    p16udm

__{}    ex  [SP],HL         ; 1:19      p16udm
__{}    pop  BC             ; 1:10      p16udm
__{}    ret                 ; 1:10      p16udm},
PUDM_MIN:PUDM_MAX,256:256,{
; Divide 2048-bit unsigned value from pointer
; In: [BC], [DE], [HL]
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
__{}P2048UDM:               ;           p2048udm
__{}    push BC             ; 1:11      p2048udm
__{}    xor   A             ; 1:4       p2048udm   ( p2048_3 p2048_2 p2048_res -- p2048_3 p2048_mod p2048_res )  p2048_2 u/mod p2048_3  with align $1
__{}    ld  [HL],A          ; 1:7       p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    jr   nz, $-2        ; 2:7/12    p2048udm   p2048_res = 0

__{}    ex  [SP],HL         ; 1:19      p2048udm

__{}    or  [HL]            ; 1:7       p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    jr   nz, $-2        ; 2:7/12    p2048udm   p2048_3 == 0?

__{}    or    A             ; 1:4       p2048udm
__{}    jr    z, _e_x_i_t_       ; 2:7/12    p2048udm   exit with div 0

__{}    ld    C, L          ; 1:4       p2048udm
__{}    ld    B, L          ; 1:4       p2048udm   shift_counter = 0
__{}
__{}    inc  BC             ; 1:6       p2048udm   shift_counter++
__{}
__{}    rl  [HL]            ; 2:15      p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    jr   nz, $-3        ; 2:7/12    p2048udm   p2048_3 *= 2
__{}
__{}    jr   nc, $-6        ; 2:7/12    p2048udm   p2048_3 overflow?

_l_o_o_p_
__{}    dec   L             ; 1:4       p2048udm
__{}    rr  [HL]            ; 2:15      p2048udm
__{}    dec   L             ; 1:4       p2048udm
__{}    jr   nz, $-3        ; 2:7/12    p2048udm   p2048_3 >>= 1
__{}    rr  [HL]            ; 2:15      p2048udm

__{}    ex  [SP],HL         ; 1:19      p2048udm
__{}    rl  [HL]            ; 2:15      p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    jr   nz, $-3        ; 2:7/12    p2048udm   result *= 2
__{}    ex  [SP],HL         ; 1:19      p2048udm

__{}    ld    A,[DE]        ; 1:7       p2048udm
__{}    sbc   A,[HL]        ; 1:7       p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    inc   E             ; 1:4       p2048udm
__{}    jr   nz, $-4        ; 2:7/12    p2048udm   p2048_mod>p2048_3?

__{}    jr    c, $+12       ; 2:7/12    p2048udm

__{}    ld    A,[DE]        ; 1:7       p2048udm
__{}    sbc   A,[HL]        ; 1:7       p2048udm
__{}    ld  [DE],A          ; 1:7       p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    inc   E             ; 1:4       p2048udm
__{}    jr   nz, $-5        ; 2:7/12    p2048udm   p2048_mod -= p2048_3?

__{}    ex  [SP],HL         ; 1:19      p2048udm
__{}    inc [HL]            ; 1:11      p2048udm   result += 1
__{}    ex  [SP],HL         ; 1:19      p2048udm

__{}    dec  BC             ; 1:6       p2048udm
__{}    ld    A, B          ; 1:4       p2048udm
__{}    or    C             ; 1:4       p2048udm
__{}    jr   nz, _l_o_o_p_  ; 2:7/12    p2048udm
_e_x_i_t_
__{}    ex  [SP],HL         ; 1:19      p2048udm
__{}    pop  BC             ; 1:10      p2048udm
__{}    ret                 ; 1:10      p2048udm},
eval(PUDM_MIN<=32):eval(PUDM_MAX<=32),1:1,{
; Divide 8..256-bit unsigned value from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
__{}P256UDM:                ;           p256udm
__{}    push BC             ; 1:11      p256udm
__{}    ld    C, A          ; 1:4       p256udm   C = x bytes

__{}    xor   A             ; 1:4       p256udm
__{}    exx                 ; 1:4       p256udm
__{}    ld    B, A          ; 1:4       p256udm   B' = shift_counter = 0
__{}    exx                 ; 1:4       p256udm

__{}    ld    B, C          ; 1:4       p256udm
__{}    ld  [HL],A          ; 1:7       p256udm
__{}    inc   L             ; 1:4       p256udm   px_res = 0
__{}    djnz $-2            ; 2:8/13    p256udm
__{}    ex   AF, AF'        ; 1:4       p256udm
__{}    ld    A, L          ; 1:4       p256udm
__{}    sub   C             ; 1:4       p256udm
__{}    ld    L, A          ; 1:4       p256udm   return to original value

__{}    ex  [SP],HL         ; 1:19      p256udm

__{}    ld    A, L          ; 1:4       p256udm   A' = original value L
__{}    ex   AF, AF'        ; 1:4       p256udm

__{}    ld    B, C          ; 1:4       p256udm
__{}    or  [HL]            ; 1:7       p256udm
__{}    inc   L             ; 1:4       p256udm
__{}    djnz $-2            ; 2:8/13    p256udm   px_3 == 0?

__{}    or    A             ; 1:4       p256udm
__{}    jr    z, P256UDM_E  ; 2:7/12    p256udm   exit with div 0

__{}    ex   AF, AF'        ; 1:4       p256udm
__{}    ld    L, A          ; 1:4       p256udm   return to original value
__{}    ex   AF, AF'        ; 1:4       p256udm
__{}    ld    B, C          ; 1:4       p256udm
__{}    exx                 ; 1:4       p256udm
__{}    inc   B             ; 1:4       p256udm   shift_counter++
__{}    exx                 ; 1:4       p256udm
__{}
__{}    rl  [HL]            ; 2:15      p256udm
__{}    inc   L             ; 1:4       p256udm
__{}    djnz $-3            ; 2:8/13    p256udm   px_3 *= 2
__{}
__{}    jr   nc, $-12       ; 2:7/12    p256udm   px_3 overflow?

__{}P256UDM_L:              ;           p256udm
__{}    ld    B, C          ; 1:4       p256udm   L = orig L + $1
__{}    dec   L             ; 1:4       p256udm
__{}    rr  [HL]            ; 2:15      p256udm
__{}    djnz $-3            ; 2:8/13    p256udm   px_3 >>= 1

__{}    ex  [SP],HL         ; 1:19      p256udm
__{}    ld    A, L          ; 1:4       p256udm
__{}    ld    B, C          ; 1:4       p256udm
__{}    rl  [HL]            ; 2:15      p256udm
__{}    inc   L             ; 1:4       p256udm
__{}    djnz $-3            ; 2:8/13    p256udm   result *= 2
__{}    ld    L, A          ; 1:4       p256udm   return to original value
__{}    ex  [SP],HL         ; 1:19      p256udm

__{}    push  DE            ; 1:11      p256udm
__{}    ld    B, C          ; 1:4       p256udm
__{}    ld    A,[DE]        ; 1:7       p256udm
__{}    sbc   A,[HL]        ; 1:7       p256udm
__{}    inc   L             ; 1:4       p256udm
__{}    inc   E             ; 1:4       p256udm
__{}    djnz $-4            ; 2:8/13    p256udm   (px_mod < px_3)?
__{}    pop  DE             ; 1:10      p256udm

__{}    jr    c, P256UDM_N  ; 2:7/12    p256udm

__{}    ex  [SP],HL         ; 1:19      p256udm
__{}    inc [HL]            ; 1:11      p256udm   result += 1
__{}    ex  [SP],HL         ; 1:19      p256udm

__{}    push DE             ; 1:11      p256udm
__{}    ex   AF, AF'        ; 1:4       p256udm
__{}    ld    L, A          ; 1:4       p256udm   return to original value
__{}    ex   AF, AF'        ; 1:4       p256udm
__{}    ld    B, C          ; 1:4       p256udm
__{}    ld    A,[DE]        ; 1:7       p256udm
__{}    sbc   A,[HL]        ; 1:7       p256udm
__{}    ld  [DE],A          ; 1:7       p256udm
__{}    inc   L             ; 1:4       p256udm
__{}    inc   E             ; 1:4       p256udm
__{}    djnz $-5            ; 2:8/13    p256udm   px_mod -= px_3
__{}    pop  DE             ; 1:10      p256udm
__{}P256UDM_N:              ;           p256udm
__{}    or    A             ; 1:4       p256udm
__{}    exx                 ; 1:4       p256udm
__{}    dec   B             ; 1:4       p256udm
__{}    exx                 ; 1:4       p256udm
__{}    jr   nz, P256UDM_L  ; 2:7/12    p256udm

__{}P256UDM_E:              ;           p256udm
__{}    ex   AF, AF'        ; 1:4       p256udm
__{}    ld    L, A          ; 1:4       p256udm   return to original value
__{}    ex  [SP],HL         ; 1:19      p256udm
__{}    pop  BC             ; 1:10      p256udm
__{}    ret                 ; 1:10      p256udm},
{
; Divide 8..2048-bit unsigned value from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
__{}PUDM:                   ;           pudm
__{}    push BC             ; 1:11      pudm
__{}    ld    C, A          ; 1:4       pudm   C = x bytes

__{}    xor   A             ; 1:4       pudm
__{}    exx                 ; 1:4       pudm
__{}    ld    B, A          ; 1:4       pudm
__{}    ld    C, A          ; 1:4       pudm   BC' = shift_counter = 0
__{}    exx                 ; 1:4       pudm

__{}    ld    B, C          ; 1:4       pudm
__{}    ld  [HL],A          ; 1:7       pudm
__{}    inc   L             ; 1:4       pudm   px_res = 0
__{}    djnz $-2            ; 2:8/13    pudm
__{}    ex   AF, AF'        ; 1:4       pudm
__{}    ld    A, L          ; 1:4       pudm
__{}    sub   C             ; 1:4       pudm
__{}    ld    L, A          ; 1:4       pudm   return to original value

__{}    ex  [SP],HL         ; 1:19      pudm

__{}    ld    A, L          ; 1:4       pudm   A' = original value L
__{}    ex   AF, AF'        ; 1:4       pudm

__{}    ld    B, C          ; 1:4       pudm
__{}    or  [HL]            ; 1:7       pudm
__{}    inc   L             ; 1:4       pudm
__{}    djnz $-2            ; 2:8/13    pudm   px_3 == 0?

__{}    or    A             ; 1:4       pudm
__{}    jr    z, PUDM_EXIT  ; 2:7/12    pudm   exit with div 0

__{}    ex   AF, AF'        ; 1:4       pudm
__{}    ld    L, A          ; 1:4       pudm   return to original value
__{}    ex   AF, AF'        ; 1:4       pudm
__{}    ld    B, C          ; 1:4       pudm
__{}    exx                 ; 1:4       pudm
__{}    inc   BC            ; 1:6       pudm   shift_counter++
__{}    exx                 ; 1:4       pudm
__{}
__{}    rl  [HL]            ; 2:15      pudm
__{}    inc   L             ; 1:4       pudm
__{}    djnz $-3            ; 2:8/13    pudm   px_3 *= 2
__{}
__{}    jr   nc, $-12       ; 2:7/12    pudm   px_3 overflow?

__{}PUDM_LOOP:              ;           pudm
__{}    ld    B, C          ; 1:4       pudm   L = orig L + $1
__{}    dec   L             ; 1:4       pudm
__{}    rr  [HL]            ; 2:15      pudm
__{}    djnz $-3            ; 2:8/13    pudm   px_3 >>= 1

__{}    ex  [SP],HL         ; 1:19      pudm
__{}    ld    A, L          ; 1:4       pudm
__{}    ld    B, C          ; 1:4       pudm
__{}    rl  [HL]            ; 2:15      pudm
__{}    inc   L             ; 1:4       pudm
__{}    djnz $-3            ; 2:8/13    pudm   result *= 2
__{}    ld    L, A          ; 1:4       pudm   return to original value
__{}    ex  [SP],HL         ; 1:19      pudm

__{}    push  DE            ; 1:11      pudm
__{}    ld    B, C          ; 1:4       pudm
__{}    ld    A,[DE]        ; 1:7       pudm
__{}    sbc   A,[HL]        ; 1:7       pudm
__{}    inc   L             ; 1:4       pudm
__{}    inc   E             ; 1:4       pudm
__{}    djnz $-4            ; 2:8/13    pudm   (px_mod < px_3)?
__{}    pop  DE             ; 1:10      pudm

__{}    jr    c, PUDM_NEXT  ; 2:7/12    pudm

__{}    ex  [SP],HL         ; 1:19      pudm
__{}    inc [HL]            ; 1:11      pudm   result += 1
__{}    ex  [SP],HL         ; 1:19      pudm

__{}    push DE             ; 1:11      pudm
__{}    ex   AF, AF'        ; 1:4       pudm
__{}    ld    L, A          ; 1:4       pudm   return to original value
__{}    ex   AF, AF'        ; 1:4       pudm
__{}    ld    B, C          ; 1:4       pudm
__{}    ld    A,[DE]        ; 1:7       pudm
__{}    sbc   A,[HL]        ; 1:7       pudm
__{}    ld  [DE],A          ; 1:7       pudm
__{}    inc   L             ; 1:4       pudm
__{}    inc   E             ; 1:4       pudm
__{}    djnz $-5            ; 2:8/13    pudm   px_mod -= px_3
__{}    pop  DE             ; 1:10      pudm
__{}PUDM_NEXT:              ;           pudm
__{}    exx                 ; 1:4       pudm
__{}    dec  BC             ; 1:6       pudm
__{}    ld    A, B          ; 1:4       pudm
__{}    or    C             ; 1:4       pudm
__{}    exx                 ; 1:4       pudm
__{}    jr   nz, PUDM_LOOP  ; 2:7/12    pudm

__{}PUDM_EXIT:              ;           pudm
__{}    ex   AF, AF'        ; 1:4       pudm
__{}    ld    L, A          ; 1:4       pudm   return to original value
__{}    ex  [SP],HL         ; 1:19      pudm
__{}    pop  BC             ; 1:10      pudm
__{}    ret                 ; 1:10      pudm}){}dnl
dnl
dnl
dnl
dnl
dnl
ifelse(0,1,{
__{}    xor   A             ; 1:4       __INFO
__{}    exx                 ; 1:4       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    ld    C, A          ; 1:4       __INFO   shift_counter = 0
__{}    exx                 ; 1:4       __INFO

__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO   p{}eval(8*($1))_res = 0
__{}    djnz $-2            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO

__{}    ex  [SP],HL         ; 1:19      __INFO

__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}
__{}    inc   L             ; 1:4       __INFO
__{}    or  [HL]            ; 1:7       __INFO
__{}    djnz $-2            ; 2:8/13    __INFO   p{}eval(8*($1))_3 == 0?

__{}    or    A             ; 1:4       __INFO
__{}    jr    z, _e_x_i_t_  ; 2:7/12    __INFO   exit with div 0

__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    exx                 ; 1:4       __INFO
__{}    inc   BC            ; 1:6       __INFO   shift_counter++
__{}    exx                 ; 1:4       __INFO
__{}
__{}    rl  [HL]            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   p{}eval(8*($1))_3 *= 2
__{}
__{}    jr   nc, $-11       ; 2:7/12    __INFO   p{}eval(8*($1))_3 overflow?

_l_o_o_p_
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO   L = orig L + $1
__{}    dec   L             ; 1:4       __INFO
__{}    rr  [HL]            ; 2:15      __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   p{}eval(8*($1))_3 >>= 1

__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    rl  [HL]            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   result *= 2
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO

__{}    push  DE            ; 1:11      __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    sbc   A,[HL]        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-4            ; 2:8/13    __INFO   (p{}eval(8*($1))_mod < p{}eval(8*($1))_3)?
__{}    pop  DE             ; 1:10      __INFO

__{}    jr    c, $+17       ; 2:7/12    __INFO

__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    inc [HL]            ; 1:11      __INFO   result += 1
__{}    ex  [SP],HL         ; 1:19      __INFO

__{}    push  DE            ; 1:11      __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    sbc   A,[HL]        ; 1:7       __INFO
__{}    ld  [DE],A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-5            ; 2:8/13    __INFO   p{}eval(8*($1))_mod -= p{}eval(8*($1))_3
__{}    pop  DE             ; 1:10      __INFO

__{}    exx                 ; 1:4       __INFO
__{}    dec  BC             ; 1:6       __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    or    C             ; 1:4       __INFO
__{}    exx                 ; 1:4       __INFO
__{}    jr   nz, _l_o_o_p_  ; 2:7/12    __INFO

_e_x_i_t_
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO}){}dnl
dnl
dnl
dnl
ifelse(0,1,{
__{}    xor   A             ; 1:4       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO   p{}eval(8*($1))_res = 0
__{}    djnz $-2            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO

__{}    ex  [SP],HL         ; 1:19      __INFO

__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  [HL]            ; 1:7       __INFO
__{}    djnz $-2            ; 2:8/13    __INFO   (p{}eval(8*($1))_3 == 0)?

__{}    or    A             ; 1:4       __INFO
__{}    jr    z, _e_x_i_t_  ; 2:7/12    __INFO   exit with div 0

__{}    xor   A             ; 1:4       __INFO   shift_counter = 0
__{}
__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    inc   A             ; 1:4       __INFO   shift_counter++
__{}
__{}    rl  [HL]            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   p{}eval(8*($1))_3 *= 2
__{}
__{}    jr   nc, $-9        ; 2:7/12    __INFO   p{}eval(8*($1))_3 overflow?

_l_o_o_p_
__{}    push  BC            ; 1:11      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO   L = orig L + $1
__{}    dec   L             ; 1:4       __INFO
__{}    rr  [HL]            ; 2:15      __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   p{}eval(8*($1))_3 >>= 1
__{}    pop  BC             ; 1:10      __INFO

__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    rl  [HL]            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   result *= 2
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO

__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    or    A             ; 1:4       __INFO
__{}    push DE             ; 1:11      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    sbc   A,[HL]        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-4            ; 2:8/13    __INFO   (p{}eval(8*($1))_mod < p{}eval(8*($1))_3)?
__{}    pop  DE             ; 1:10      __INFO

__{}    jr    c, $+17       ; 2:7/12    __INFO

__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    inc [HL]            ; 1:11      __INFO   result += 1
__{}    ex  [SP],HL         ; 1:19      __INFO

__{}    ld    L, C          ; 1:4       __INFO
__{}    push  DE            ; 1:11      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    sbc   A,[HL]        ; 1:7       __INFO
__{}    ld  [DE],A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-5            ; 2:8/13    __INFO   p{}eval(8*($1))_mod -= p{}eval(8*($1))_3
__{}    pop  DE             ; 1:10      __INFO

__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    dec   A             ; 1:4       __INFO
__{}    jr   nz, _l_o_o_p_  ; 2:7/12    __INFO

_e_x_i_t_
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO}){}dnl
dnl
dnl
dnl
