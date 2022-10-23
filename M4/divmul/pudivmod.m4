dnl ## division
define({__},{})dnl
dnl
dnl
dnl
ifelse(PUDM_MIN:PUDM_MAX,1:1,{
; Divide 8-bit unsigned value from pointer
; In: [BC], [DE], [HL]
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
__{}P8UDM:                  ;           p8udm
__{}    push BC             ; 1:11      p8udm
__{}    ld    A,(DE)        ; 1:7       p8udm
__{}    ex  (SP),HL         ; 1:19      p8udm
__{}    ld   BC, 0x0000     ; 2:7       p8udm
__{}    inc   B             ; 1:4       p8udm
__{}    sla (HL)            ; 2:15      p8udm
__{}    jr    c, $+8        ; 2:7/12    p8udm
__{}    jr    z, $+19       ; 2:7/12    p8udm   exit with div 0
__{}    cp  (HL)            ; 1:7       p8udm
__{}    jr   nc, $-8        ; 2:7/12    p8udm
__{}    or    A             ; 1:4       p8udm
__{}    rr  (HL)            ; 2:15      p8udm
__{}    sla   C             ; 2:8       p8udm   result *= 2
__{}    cp  (HL)            ; 1:7       p8udm
__{}    jr    c, $+4        ; 2:7/12    p8udm
__{}    sub (HL)            ; 1:7       p8udm
__{}    inc   C             ; 1:4       p8udm   result += 1
__{}    djnz $-10           ; 2:8/13    p8udm
__{}    ex  (SP),HL         ; 1:19      p8udm
__{}    ld  (HL),C          ; 1:7       p8udm
__{}    ld  (DE),A          ; 1:7       p8udm
__{}    pop  BC             ; 1:10      p8udm
__{}    ret                 ; 1:10      p8udm},
PUDM_MIN:PUDM_MAX,2:2,{
; Divide 16-bit unsigned value from pointer
; In: [BC], [DE], [HL]
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
__{}P16UDM:                 ;           p16udm
__{}    push BC             ; 1:11      p16udm
__{}    xor   A             ; 1:4       p16udm
__{}    ld  (HL),A          ; 1:7       p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    ld  (HL),A          ; 1:7       p16udm
__{}    dec   L             ; 1:4       p16udm   p16_res = 0
__{}    ex  (SP),HL         ; 1:19      p16udm

__{}    ld    B, A          ; 1:4       p16udm

__{}    inc   L             ; 1:4       p16udm
__{}    or  (HL)            ; 1:7       p16udm
__{}    dec   L             ; 1:4       p16udm
__{}    or  (HL)            ; 1:7       p16udm   p16_3 == 0?
__{}    jr    z, $+57       ; 2:7/12    p16udm   exit with div 0

__{}    inc   B             ; 1:4       p16udm
__{}    sla (HL)            ; 2:15      p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    rl  (HL)            ; 2:15      p16udm
__{}    dec   L             ; 1:4       p16udm   p16_3 *= 2
__{}    jr   nc, $-7        ; 2:7/12    p16udm

__{}    inc   L             ; 1:4       p16udm
__{}    rr  (HL)            ; 2:15      p16udm
__{}    dec   L             ; 1:4       p16udm
__{}    rr  (HL)            ; 2:15      p16udm

__{}    ex  (SP),HL         ; 1:19      p16udm
__{}    sla (HL)            ; 2:15      p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    rl  (HL)            ; 2:15      p16udm   result *= 2
__{}    dec   L             ; 1:4       p16udm
__{}    ex  (SP),HL         ; 1:19      p16udm

__{}    ld    A,(DE)        ; 1:7       p16udm
__{}    sub (HL)            ; 1:7       p16udm
__{}    ld  (DE),A          ; 1:7       p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    inc   E             ; 1:4       p16udm
__{}    ld    A,(DE)        ; 1:7       p16udm
__{}    sbc   A,(HL)        ; 1:7       p16udm
__{}    ld  (DE),A          ; 1:7       p16udm
__{}    dec   L             ; 1:4       p16udm
__{}    dec   E             ; 1:4       p16udm

__{}    jr    c, $+9        ; 2:7/12    p16udm

__{}    ex  (SP),HL         ; 1:19      p16udm
__{}    inc (HL)            ; 1:11      p16udm   result += 1
__{}    ex  (SP),HL         ; 1:19      p16udm
__{}    djnz $-29           ; 2:8/13    p16udm
__{}    jr   $+15           ; 2:7/12    p16udm

__{}    ld    A,(DE)        ; 1:7       p16udm
__{}    add   A,(HL)        ; 1:7       p16udm
__{}    ld  (DE),A          ; 1:7       p16udm
__{}    inc   L             ; 1:4       p16udm
__{}    inc   E             ; 1:4       p16udm
__{}    ld    A,(DE)        ; 1:7       p16udm
__{}    adc   A,(HL)        ; 1:7       p16udm
__{}    ld  (DE),A          ; 1:7       p16udm
__{}    dec   L             ; 1:4       p16udm
__{}    dec   E             ; 1:4       p16udm

__{}    or    A             ; 1:4       p16udm

__{}    djnz $-44           ; 2:8/13    p16udm

__{}    ex  (SP),HL         ; 1:19      p16udm
__{}    pop  BC             ; 1:10      p16udm
__{}    ret                 ; 1:10      p16udm},
PUDM_MIN:PUDM_MAX,256:256,{
; Divide 2048-bit unsigned value from pointer
; In: [BC], [DE], [HL]
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
__{}P2048UDM:               ;           p2048udm
__{}    push BC             ; 1:11      p2048udm
__{}    xor   A             ; 1:4       p2048udm   ( p2048_3 p2048_2 p2048_res -- p2048_3 p2048_mod p2048_res )  p2048_2 u/mod p2048_3  with align $1
__{}    ld  (HL),A          ; 1:7       p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    jr   nz, $-2        ; 2:7/12    p2048udm   p2048_res = 0

__{}    ex  (SP),HL         ; 1:19      p2048udm

__{}    or  (HL)            ; 1:7       p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    jr   nz, $-2        ; 2:7/12    p2048udm   p2048_3 == 0?

__{}    or    A             ; 1:4       p2048udm
__{}    jr    z, _e_x_i_t_       ; 2:7/12    p2048udm   exit with div 0

__{}    ld    C, L          ; 1:4       p2048udm
__{}    ld    B, L          ; 1:4       p2048udm   shift_counter = 0
__{}
__{}    inc  BC             ; 1:6       p2048udm   shift_counter++
__{}
__{}    rl  (HL)            ; 2:15      p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    jr   nz, $-3        ; 2:7/12    p2048udm   p2048_3 *= 2
__{}
__{}    jr   nc, $-6        ; 2:7/12    p2048udm   p2048_3 overflow?

_l_o_o_p_
__{}    dec   L             ; 1:4       p2048udm
__{}    rr  (HL)            ; 2:15      p2048udm
__{}    dec   L             ; 1:4       p2048udm
__{}    jr   nz, $-3        ; 2:7/12    p2048udm   p2048_3 >>= 1
__{}    rr  (HL)            ; 2:15      p2048udm

__{}    ex  (SP),HL         ; 1:19      p2048udm
__{}    rl  (HL)            ; 2:15      p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    jr   nz, $-3        ; 2:7/12    p2048udm   result *= 2
__{}    ex  (SP),HL         ; 1:19      p2048udm

__{}    ld    A,(DE)        ; 1:7       p2048udm
__{}    sbc   A,(HL)        ; 1:7       p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    inc   E             ; 1:4       p2048udm
__{}    jr   nz, $-4        ; 2:7/12    p2048udm   p2048_mod>p2048_3?

__{}    jr    c, $+12       ; 2:7/12    p2048udm

__{}    ld    A,(DE)        ; 1:7       p2048udm
__{}    sbc   A,(HL)        ; 1:7       p2048udm
__{}    ld  (DE),A          ; 1:7       p2048udm
__{}    inc   L             ; 1:4       p2048udm
__{}    inc   E             ; 1:4       p2048udm
__{}    jr   nz, $-5        ; 2:7/12    p2048udm   p2048_mod -= p2048_3?

__{}    ex  (SP),HL         ; 1:19      p2048udm
__{}    inc (HL)            ; 1:11      p2048udm   result += 1
__{}    ex  (SP),HL         ; 1:19      p2048udm

__{}    dec  BC             ; 1:6       p2048udm
__{}    ld    A, B          ; 1:4       p2048udm
__{}    or    C             ; 1:4       p2048udm
__{}    jr   nz, _l_o_o_p_  ; 2:7/12    p2048udm
_e_x_i_t_
__{}    ex  (SP),HL         ; 1:19      p2048udm
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
__{}    ld  (HL),A          ; 1:7       p256udm
__{}    inc   L             ; 1:4       p256udm   px_res = 0
__{}    djnz $-2            ; 2:8/13    p256udm
__{}    ex   AF, AF'        ; 1:4       p256udm
__{}    ld    A, L          ; 1:4       p256udm
__{}    sub   C             ; 1:4       p256udm
__{}    ld    L, A          ; 1:4       p256udm   return to original value

__{}    ex  (SP),HL         ; 1:19      p256udm

__{}    ld    A, L          ; 1:4       p256udm   A' = original value L
__{}    ex   AF, AF'        ; 1:4       p256udm

__{}    ld    B, C          ; 1:4       p256udm
__{}    or  (HL)            ; 1:7       p256udm
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
__{}    rl  (HL)            ; 2:15      p256udm
__{}    inc   L             ; 1:4       p256udm
__{}    djnz $-3            ; 2:8/13    p256udm   px_3 *= 2
__{}
__{}    jr   nc, $-12       ; 2:7/12    p256udm   px_3 overflow?

__{}P256UDM_L:              ;           p256udm
__{}    ld    B, C          ; 1:4       p256udm   L = orig L + $1
__{}    dec   L             ; 1:4       p256udm
__{}    rr  (HL)            ; 2:15      p256udm
__{}    djnz $-3            ; 2:8/13    p256udm   px_3 >>= 1

__{}    ex  (SP),HL         ; 1:19      p256udm
__{}    ld    A, L          ; 1:4       p256udm
__{}    ld    B, C          ; 1:4       p256udm
__{}    rl  (HL)            ; 2:15      p256udm
__{}    inc   L             ; 1:4       p256udm
__{}    djnz $-3            ; 2:8/13    p256udm   result *= 2
__{}    ld    L, A          ; 1:4       p256udm   return to original value
__{}    ex  (SP),HL         ; 1:19      p256udm

__{}    push  DE            ; 1:11      p256udm
__{}    ld    B, C          ; 1:4       p256udm
__{}    ld    A,(DE)        ; 1:7       p256udm
__{}    sbc   A,(HL)        ; 1:7       p256udm
__{}    inc   L             ; 1:4       p256udm
__{}    inc   E             ; 1:4       p256udm
__{}    djnz $-4            ; 2:8/13    p256udm   (px_mod < px_3)?
__{}    pop  DE             ; 1:10      p256udm

__{}    jr    c, P256UDM_N  ; 2:7/12    p256udm

__{}    ex  (SP),HL         ; 1:19      p256udm
__{}    inc (HL)            ; 1:11      p256udm   result += 1
__{}    ex  (SP),HL         ; 1:19      p256udm

__{}    push DE             ; 1:11      p256udm
__{}    ex   AF, AF'        ; 1:4       p256udm
__{}    ld    L, A          ; 1:4       p256udm   return to original value
__{}    ex   AF, AF'        ; 1:4       p256udm
__{}    ld    B, C          ; 1:4       p256udm
__{}    ld    A,(DE)        ; 1:7       p256udm
__{}    sbc   A,(HL)        ; 1:7       p256udm
__{}    ld  (DE),A          ; 1:7       p256udm
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
__{}    ex  (SP),HL         ; 1:19      p256udm
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
__{}    ld  (HL),A          ; 1:7       pudm
__{}    inc   L             ; 1:4       pudm   px_res = 0
__{}    djnz $-2            ; 2:8/13    pudm
__{}    ex   AF, AF'        ; 1:4       pudm
__{}    ld    A, L          ; 1:4       pudm
__{}    sub   C             ; 1:4       pudm
__{}    ld    L, A          ; 1:4       pudm   return to original value

__{}    ex  (SP),HL         ; 1:19      pudm

__{}    ld    A, L          ; 1:4       pudm   A' = original value L
__{}    ex   AF, AF'        ; 1:4       pudm

__{}    ld    B, C          ; 1:4       pudm
__{}    or  (HL)            ; 1:7       pudm
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
__{}    rl  (HL)            ; 2:15      pudm
__{}    inc   L             ; 1:4       pudm
__{}    djnz $-3            ; 2:8/13    pudm   px_3 *= 2
__{}
__{}    jr   nc, $-12       ; 2:7/12    pudm   px_3 overflow?

__{}PUDM_LOOP:              ;           pudm
__{}    ld    B, C          ; 1:4       pudm   L = orig L + $1
__{}    dec   L             ; 1:4       pudm
__{}    rr  (HL)            ; 2:15      pudm
__{}    djnz $-3            ; 2:8/13    pudm   px_3 >>= 1

__{}    ex  (SP),HL         ; 1:19      pudm
__{}    ld    A, L          ; 1:4       pudm
__{}    ld    B, C          ; 1:4       pudm
__{}    rl  (HL)            ; 2:15      pudm
__{}    inc   L             ; 1:4       pudm
__{}    djnz $-3            ; 2:8/13    pudm   result *= 2
__{}    ld    L, A          ; 1:4       pudm   return to original value
__{}    ex  (SP),HL         ; 1:19      pudm

__{}    push  DE            ; 1:11      pudm
__{}    ld    B, C          ; 1:4       pudm
__{}    ld    A,(DE)        ; 1:7       pudm
__{}    sbc   A,(HL)        ; 1:7       pudm
__{}    inc   L             ; 1:4       pudm
__{}    inc   E             ; 1:4       pudm
__{}    djnz $-4            ; 2:8/13    pudm   (px_mod < px_3)?
__{}    pop  DE             ; 1:10      pudm

__{}    jr    c, PUDM_NEXT  ; 2:7/12    pudm

__{}    ex  (SP),HL         ; 1:19      pudm
__{}    inc (HL)            ; 1:11      pudm   result += 1
__{}    ex  (SP),HL         ; 1:19      pudm

__{}    push DE             ; 1:11      pudm
__{}    ex   AF, AF'        ; 1:4       pudm
__{}    ld    L, A          ; 1:4       pudm   return to original value
__{}    ex   AF, AF'        ; 1:4       pudm
__{}    ld    B, C          ; 1:4       pudm
__{}    ld    A,(DE)        ; 1:7       pudm
__{}    sbc   A,(HL)        ; 1:7       pudm
__{}    ld  (DE),A          ; 1:7       pudm
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
__{}    ex  (SP),HL         ; 1:19      pudm
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
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO   p{}eval(8*($1))_res = 0
__{}    djnz $-2            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO

__{}    ex  (SP),HL         ; 1:19      __INFO

__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    djnz $-2            ; 2:8/13    __INFO   p{}eval(8*($1))_3 == 0?

__{}    or    A             ; 1:4       __INFO
__{}    jr    z, _e_x_i_t_  ; 2:7/12    __INFO   exit with div 0

__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    exx                 ; 1:4       __INFO
__{}    inc   BC            ; 1:6       __INFO   shift_counter++
__{}    exx                 ; 1:4       __INFO
__{}
__{}    rl  (HL)            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   p{}eval(8*($1))_3 *= 2
__{}
__{}    jr   nc, $-11       ; 2:7/12    __INFO   p{}eval(8*($1))_3 overflow?

_l_o_o_p_
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO   L = orig L + $1
__{}    dec   L             ; 1:4       __INFO
__{}    rr  (HL)            ; 2:15      __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   p{}eval(8*($1))_3 >>= 1

__{}    ex  (SP),HL         ; 1:19      __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    rl  (HL)            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   result *= 2
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex  (SP),HL         ; 1:19      __INFO

__{}    push  DE            ; 1:11      __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-4            ; 2:8/13    __INFO   (p{}eval(8*($1))_mod < p{}eval(8*($1))_3)?
__{}    pop  DE             ; 1:10      __INFO

__{}    jr    c, $+17       ; 2:7/12    __INFO

__{}    ex  (SP),HL         ; 1:19      __INFO
__{}    inc (HL)            ; 1:11      __INFO   result += 1
__{}    ex  (SP),HL         ; 1:19      __INFO

__{}    push  DE            ; 1:11      __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    ld  (DE),A          ; 1:7       __INFO
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
__{}    ex  (SP),HL         ; 1:19      __INFO}){}dnl
dnl
dnl
dnl
ifelse(0,1,{
__{}    xor   A             ; 1:4       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO   p{}eval(8*($1))_res = 0
__{}    djnz $-2            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO

__{}    ex  (SP),HL         ; 1:19      __INFO

__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    or  (HL)            ; 1:7       __INFO
__{}    djnz $-2            ; 2:8/13    __INFO   (p{}eval(8*($1))_3 == 0)?

__{}    or    A             ; 1:4       __INFO
__{}    jr    z, _e_x_i_t_  ; 2:7/12    __INFO   exit with div 0

__{}    xor   A             ; 1:4       __INFO   shift_counter = 0
__{}
__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    inc   A             ; 1:4       __INFO   shift_counter++
__{}
__{}    rl  (HL)            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   p{}eval(8*($1))_3 *= 2
__{}
__{}    jr   nc, $-9        ; 2:7/12    __INFO   p{}eval(8*($1))_3 overflow?

_l_o_o_p_
__{}    push  BC            ; 1:11      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO   L = orig L + $1
__{}    dec   L             ; 1:4       __INFO
__{}    rr  (HL)            ; 2:15      __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   p{}eval(8*($1))_3 >>= 1
__{}    pop  BC             ; 1:10      __INFO

__{}    ex  (SP),HL         ; 1:19      __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    rl  (HL)            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    djnz $-3            ; 2:8/13    __INFO   result *= 2
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex  (SP),HL         ; 1:19      __INFO

__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    or    A             ; 1:4       __INFO
__{}    push DE             ; 1:11      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-4            ; 2:8/13    __INFO   (p{}eval(8*($1))_mod < p{}eval(8*($1))_3)?
__{}    pop  DE             ; 1:10      __INFO

__{}    jr    c, $+17       ; 2:7/12    __INFO

__{}    ex  (SP),HL         ; 1:19      __INFO
__{}    inc (HL)            ; 1:11      __INFO   result += 1
__{}    ex  (SP),HL         ; 1:19      __INFO

__{}    ld    L, C          ; 1:4       __INFO
__{}    push  DE            ; 1:11      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A,(DE)        ; 1:7       __INFO
__{}    sbc   A,(HL)        ; 1:7       __INFO
__{}    ld  (DE),A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    djnz $-5            ; 2:8/13    __INFO   p{}eval(8*($1))_mod -= p{}eval(8*($1))_3
__{}    pop  DE             ; 1:10      __INFO

__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    dec   A             ; 1:4       __INFO
__{}    jr   nz, _l_o_o_p_  ; 2:7/12    __INFO

_e_x_i_t_
__{}    ld    L, C          ; 1:4       __INFO
__{}    ex  (SP),HL         ; 1:19      __INFO}){}dnl
dnl
dnl
dnl
