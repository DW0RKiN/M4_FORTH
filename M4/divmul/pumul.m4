dnl ## division
define({__},{})dnl
dnl
dnl
dnl
ifelse(PUMUL_MIN:PUMUL_MAX,1:1,{
; Multiplication 8-bit unsigned value from pointer
; In: [BC], [DE], [HL]
; Out: [HL] = [BC] * [DE]
__{}P8UMUL:                 ;           p8umul
__{}    ld    A,[BC]        ; 1:7       p8umul
__{}    push BC             ; 1:11      p8umul
__{}    push HL             ; 1:11      p8umul
__{}    ld    H, A          ; 1:4       p8umul
__{}    ld    A,[DE]        ; 1:7       p8umul
__{}    ld    L, A          ; 1:4       p8umul
__{}    ld    B, 0x08       ; 2:7       p8umul
__{}    xor   A             ; 1:4       p8umul
__{}    add   A, A          ; 1:4       p8umul
__{}    rl    L             ; 2:8       p8umul
__{}    jr   nc, $+3        ; 2:7/12    p8umul
__{}    add   A, H          ; 1:4       p8umul
__{}    djnz $-6            ; 2:8/13    p8umul
__{}    pop  HL             ; 1:10      p8umul
__{}    ld  [HL],A          ; 1:7       p8umul
__{}    pop  BC             ; 1:10      p8umul
__{}    ret                 ; 1:10      p8umul},
PUMUL_MIN:PUMUL_MAX,2:2,{
; Multiplication 16-bit unsigned value from pointer
; In: [BC], [DE], [HL]
; Out: [HL] = [BC] * [DE]
__{}P16UMUL:                ;           p16umul
__{}    push BC             ; 1:11      p16umul
__{}    xor   A             ; 1:4       p16umul
__{}    ld  [HL],A          ; 1:7       p16umul
__{}    inc   L             ; 1:4       p16umul
__{}    ld  [HL],A          ; 1:7       p16umul
__{}    dec   L             ; 1:4       p16umul
__{}    pop  BC             ; 1:10      p16umul
__{}    push BC             ; 1:11      p16umul
__{}    ld    A,[BC]        ; 1:7       p16umul
__{}    push AF             ; 1:11      p16umul
__{}    inc   C             ; 1:4       p16umul
__{}    ld    A,[BC]        ; 1:7       p16umul
__{}    ld   BC, 0xF102     ; 3:10      p16umul   ld C,1 && pop af
__{}    ld    B, 0x08       ; 2:7       p16umul
__{}    sla [HL]            ; 2:15      p16umul
__{}    inc   L             ; 1:4       p16umul
__{}    rl  [HL]            ; 2:15      p16umul
__{}    dec   L             ; 1:4       p16umul
__{}    add   A, A          ; 1:4       p16umul
__{}    jr   nc, $+14       ; 2:7/12    p16umul
__{}    ex   AF, AF'        ; 1:4       p16umul
__{}    ld    A,[DE]        ; 1:7       p16umul
__{}    add   A,[HL]        ; 1:7       p16umul
__{}    ld  [HL],A          ; 1:7       p16umul
__{}    inc   L             ; 1:4       p16umul
__{}    inc   E             ; 1:4       p16umul
__{}    ld    A,[DE]        ; 1:7       p16umul
__{}    adc   A,[HL]        ; 1:7       p16umul
__{}    ld  [HL],A          ; 1:7       p16umul
__{}    ex   AF, AF'        ; 1:4       p16umul
__{}    dec   L             ; 1:4       p16umul
__{}    dec   E             ; 1:4       p16umul
__{}    djnz $-21           ; 2:8/13    p16umul
__{}    dec   C             ; 1:4       p16umul
__{}    jr   nz, $-27       ; 2:7/12    p16umul
__{}    pop  BC             ; 1:10      p16umul
__{}    ret                 ; 1:10      p16umul},
PUMUL_MIN:PUMUL_MAX,256:256,{
; Multiplication 2048-bit unsigned value from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [BC] * [DE]
__{}P2048UMUL:              ;           p2048umul
__{}    push BC             ; 1:11      p2048umul
__{}    xor   A             ; 1:4       p2048umul
__{}    ld  [HL],A          ; 1:7       p2048umul
__{}    inc   L             ; 1:4       p2048umul
__{}    jr   nz, $-2        ; 2:7/12    p2048umul   [p1] = 0
__{}    ld    C, L          ; 1:4       p2048umul
__{}    ex  [SP],HL         ; 1:19      p2048umul
__{}    dec   L             ; 1:4       p2048umul
__{}    ld    A,[HL]        ; 1:7       p2048umul
__{}    ex  [SP],HL         ; 1:19      p2048umul{}dnl
__{}ifelse(TYP_PUMUL,{fast},{
__{}__{}    or    A             ; 1:4       p2048umul
__{}__{}    jr   nz, $+12       ; 2:7/12    p2048umul
__{}__{}    ld    B,[HL]        ; 1:7       p2048umul
__{}__{}    ld  [HL],A          ; 1:7       p2048umul
__{}__{}    inc   L             ; 1:4       p2048umul
__{}__{}    ld    A,[HL]        ; 1:7       p2048umul
__{}__{}    ld  [HL],B          ; 1:7       p2048umul
__{}__{}    inc   L             ; 1:4       p2048umul
__{}__{}    jr   nz, $-6        ; 2:7/12    p2048umul
__{}__{}    jr  $+25            ; 2:12      p2048umul})
__{}    ld    B, 0x08       ; 2:7       p2048umul
__{}    or    A             ; 1:4       p2048umul
__{}    rl  [HL]            ; 2:15      p2048umul
__{}    inc   L             ; 1:4       p2048umul
__{}    jr   nz, $-3        ; 2:7/12    p2048umul
__{}    add   A, A          ; 1:4       p2048umul
__{}    jr   nc, $+12       ; 2:7/12    p2048umul
__{}    ex   AF, AF'        ; 1:4       p2048umul
__{}    or    A             ; 1:4       p2048umul
__{}    ld    A,[DE]        ; 1:7       p2048umul
__{}    adc   A,[HL]        ; 1:7       p2048umul
__{}    ld  [HL],A          ; 1:7       p2048umul
__{}    inc   L             ; 1:4       p2048umul
__{}    inc   E             ; 1:4       p2048umul
__{}    jr   nz, $-5        ; 2:7/12    p2048umul
__{}    ex   AF, AF'        ; 1:4       p2048umul
__{}    djnz $-19           ; 2:8/13    p2048umul
__{}    dec   C             ; 1:4       p2048umul
__{}ifelse(TYP_PUMUL,{fast},{dnl
__{}__{}    jr   nz, $-41       ; 2:7/12    p2048umul},
__{}{dnl
__{}__{}    jr   nz, $-28       ; 2:7/12    p2048umul})
__{}    pop  BC             ; 1:10      p2048umul
__{}    ret                 ; 1:10      p2048umul},
{
; Multiplication 8..2048-bit unsigned value from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [BC] * [DE]
__{}PXUMUL:                 ;           pxumul
__{}    push BC             ; 1:11      pxumul
__{}    ld    C, A          ; 1:4       pxumul   C = x bytes
__{}    ex  [SP],HL         ; 1:19      pxumul
__{}    add   A, L          ; 1:4       pxumul
__{}    ld    L, A          ; 1:4       pxumul
__{}    ex  [SP],HL         ; 1:19      pxumul   p3 += x
__{}    ld    A, L          ; 1:4       pxumul
__{}    add   A, C          ; 1:4       pxumul
__{}    ld    L, A          ; 1:4       pxumul
__{}    xor   A             ; 1:4       pxumul
__{}    ld    B, C          ; 1:4       pxumul
__{}    dec   L             ; 1:4       pxumul
__{}    ld  [HL],A          ; 1:7       pxumul
__{}    djnz $-2            ; 2:8/13    pxumul   [p1] = 0
__{}    ld    A, C          ; 1:4       pxumul
__{}PXMUL_L1:               ;           pxumul
__{}    ex   AF, AF'        ; 1:4       pxumul
__{}ifelse(eval((PUMUL_MAX<=4) || (ifelse(TYP_PUMUL,{small},1,0))),1,{dnl
__{}__{}    ex  [SP],HL         ; 1:19      pxumul
__{}__{}    dec   L             ; 1:4       pxumul
__{}__{}    ex  [SP],HL         ; 1:19      pxumul},
__{}{dnl
__{}__{}    ex  [SP],HL         ; 1:19      pxumul
__{}__{}    dec   L             ; 1:4       pxumul
__{}__{}    ld    A,[HL]        ; 1:7       pxumul
__{}__{}    ex  [SP],HL         ; 1:19      pxumul
__{}__{}    or    A             ; 1:4       pxumul
__{}__{}    jr   nz, PXMUL_J    ; 2:7/12    pxumul
__{}__{}ifelse(1,0,{dnl
__{}__{}__{}    push BC             ; 1:11      pxumul
__{}__{}__{}    ld    B, C          ; 1:4       pxumul
__{}__{}__{}    ld    C, L          ; 1:4       pxumul
__{}__{}__{}    ex   AF, AF'        ; 1:4       pxumul
__{}__{}__{}    push AF             ; 1:11      pxumul
__{}__{}__{}    ld    A,[HL]        ; 1:7       pxumul
__{}__{}__{}    ex   AF, AF'        ; 1:4       pxumul
__{}__{}__{}    ld  [HL],A          ; 1:7       pxumul
__{}__{}__{}    inc   L             ; 1:4       pxumul
__{}__{}__{}    djnz $-4            ; 2:8/13    pxumul   [HL+1] = [HL]
__{}__{}__{}    pop  AF             ; 1:10      pxumul
__{}__{}__{}    ex   AF, AF'        ; 1:4       pxumul
__{}__{}__{}    ld    L, C          ; 1:4       pxumul
__{}__{}__{}    pop  BC             ; 1:10      pxumul},
__{}__{}{dnl
__{}__{}__{}    push BC             ; 1:11      pxumul
__{}__{}__{}    push DE             ; 1:11      pxumul
__{}__{}__{}    dec   C             ; 1:4       pxumul
__{}__{}__{}    ld    B, 0x00       ; 2:7       pxumul
__{}__{}__{}    ld    D, H          ; 1:4       pxumul
__{}__{}__{}    ld    A, L          ; 1:4       pxumul
__{}__{}__{}    add   A, C          ; 1:4       pxumul
__{}__{}__{}    ld    E, A          ; 1:4       pxumul
__{}__{}__{}    ld    L, E          ; 1:4       pxumul
__{}__{}__{}    dec   L             ; 1:4       pxumul
__{}__{}__{}    lddr                ; 2:16/21   pxumul   [DE]-- = [HL]--
__{}__{}__{}    ex   DE, HL         ; 1:4       pxumul
__{}__{}__{}    ld  [HL],B          ; 1:7       pxumul
__{}__{}__{}    pop  DE             ; 1:10      pxumul
__{}__{}__{}    pop  BC             ; 1:10      pxumul})
__{}__{}    jr  PXMUL_N1        ; 2:12      pxumul
__{}__{}PXMUL_J:                ;           pxumul})
__{}    ld    B, 0x08       ; 2:7       pxumul
__{}PXMUL_L2:               ;           pxumul
__{}    push BC             ; 1:11      pxumul
__{}    or    A             ; 1:4       pxumul
__{}    ld    B, C          ; 1:4       pxumul
__{}    ld    C, L          ; 1:4       pxumul
__{}    rl  [HL]            ; 2:15      pxumul
__{}    inc   L             ; 1:4       pxumul
__{}    djnz $-3            ; 2:8/13    pxumul   result [p1] *= 2
__{}    ld    L, C          ; 1:4       pxumul
__{}    pop  BC             ; 1:10      pxumul
__{}    ex  [SP],HL         ; 1:19      pxumul
__{}    rlc [HL]            ; 2:15      pxumul   left rotation [p3] --> carry?
__{}    ex  [SP],HL         ; 1:19      pxumul
__{}    jr   nc, PXMUL_N2   ; 2:7/12    pxumul
__{}    push BC             ; 1:11      pxumul
__{}    push DE             ; 1:11      pxumul
__{}    or    A             ; 1:4       pxumul
__{}    ld    B, C          ; 1:4       pxumul
__{}    ld    C, L          ; 1:4       pxumul
__{}    ld    A,[DE]        ; 1:7       pxumul
__{}    adc   A,[HL]        ; 1:7       pxumul
__{}    ld  [HL],A          ; 1:7       pxumul
__{}    inc   L             ; 1:4       pxumul
__{}    inc   E             ; 1:4       pxumul
__{}    djnz $-5            ; 2:8/13    pxumul
__{}    ld    L, C          ; 1:4       pxumul
__{}    pop  DE             ; 1:10      pxumul
__{}    pop  BC             ; 1:10      pxumul
__{}PXMUL_N2:               ;           pxumul
__{}    djnz PXMUL_L2       ; 2:8/13    pxumul
__{}PXMUL_N1:               ;           pxumul
__{}    ex   AF, AF'        ; 1:4       pxumul
__{}    dec   A             ; 1:4       pxumul
__{}    jr   nz, PXMUL_L1   ; 2:7/12    pxumul
__{}    pop  BC             ; 1:10      pxumul
__{}    ret                 ; 1:10      pxumul}){}dnl
dnl
dnl
dnl
dnl
dnl
__{}ifelse(0,1,{
__{}    pop  BC             ; 1:10      __INFO
__{}    ld    A,[BC]        ; 1:7       __INFO
__{}    push BC             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO
__{}    ld    H, A          ; 1:4       __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    B, 0x08       ; 2:7       __INFO
__{}    xor   A             ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO
__{}    rl    L             ; 2:8       __INFO
__{}    jr   nc, $+3        ; 2:7/12    __INFO
__{}    add   A, H          ; 1:4       __INFO
__{}    djnz $-6            ; 2:8/13    __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    ld  [HL],A          ; 1:7       __INFO}){}dnl
dnl
__{}ifelse(0,2,{
__{}    xor   A             ; 1:4       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    pop  BC             ; 1:10      __INFO
__{}    push BC             ; 1:11      __INFO
__{}    ld    A,[BC]        ; 1:7       __INFO
__{}    push AF             ; 1:11      __INFO
__{}    inc   C             ; 1:4       __INFO
__{}    ld    A,[BC]        ; 1:7       __INFO
__{}    ld   BC, 0xF102     ; 3:10      __INFO   ld C,1 && pop af
__{}    ld    B, 0x08       ; 2:7       __INFO
__{}    sla [HL]            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    rl  [HL]            ; 2:15      __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO
__{}    jr   nc, $+14       ; 2:7/12    __INFO
__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    add   A,[HL]        ; 1:7       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    adc   A,[HL]        ; 1:7       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO
__{}    djnz $-21           ; 2:8/13    __INFO
__{}    dec   C             ; 1:4       __INFO
__{}    jr   nz, $-27       ; 2:7/12    __INFO}){}dnl
dnl
__{}ifelse(0,256,{
__{}    xor   A             ; 1:4       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    jr   nz, $-2        ; 2:7/12    __INFO   [p1] = 0
__{}    ld    C, L          ; 1:4       __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ld    A,[HL]        ; 1:7       __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO{}dnl
__{}ifelse(TYP_PUMUL,{fast},{
__{}__{}    or    A             ; 1:4       __INFO
__{}__{}    jr   nz, $+12       ; 2:7/12    __INFO
__{}__{}    ld    B,[HL]        ; 1:7       __INFO
__{}__{}    ld  [HL],A          ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    ld    A,[HL]        ; 1:7       __INFO
__{}__{}    ld  [HL],B          ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    jr   nz, $-6        ; 2:7/12    __INFO
__{}__{}    jr  $+25            ; 2:12      __INFO})
__{}    ld    B, 0x08       ; 2:7       __INFO
__{}    or    A             ; 1:4       __INFO
__{}    rl  [HL]            ; 2:15      __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    jr   nz, $-3        ; 2:7/12    __INFO
__{}    add   A, A          ; 1:4       __INFO
__{}    jr   nc, $+12       ; 2:7/12    __INFO
__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    or    A             ; 1:4       __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    adc   A,[HL]        ; 1:7       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    jr   nz, $-5        ; 2:7/12    __INFO
__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    djnz $-19           ; 2:8/13    __INFO
__{}    dec   C             ; 1:4       __INFO
__{}ifelse(TYP_PUMUL,{fast},{dnl
__{}__{}    jr   nz, $-41       ; 2:7/12    __INFO},
__{}{dnl
__{}__{}    jr   nz, $-28       ; 2:7/12    __INFO})}){}dnl
dnl
ifelse(default,0,{
__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    ld    B, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    add   A, L          ; 1:4       __INFO
__{}    ld    L, A          ; 1:4       __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO   p3 += $1
__{}    xor   A             ; 1:4       __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    djnz $-2            ; 2:8/13    __INFO   [p1] = 0
__{}    ld    L, C          ; 1:4       __INFO
__{}    ld    C, __HEX_L($1)       ; 2:7       __INFO
__{}    ld    B, 0x08       ; 2:7       __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    sla [HL]            ; 2:15      __INFO
__{}    push BC             ; 1:11      __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1-1)       ; 2:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    rl  [HL]            ; 2:15      __INFO
__{}    djnz $-3            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    pop  BC             ; 1:10      __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    rlc [HL]            ; 2:15      __INFO
__{}    ex  [SP],HL         ; 1:19      __INFO
__{}    jr   nc, $+20       ; 2:7/12    __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    add   A,[HL]        ; 1:7       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    push BC             ; 1:11      __INFO
__{}    push DE             ; 1:11      __INFO
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, __HEX_L($1-1)       ; 2:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    ld    A,[DE]        ; 1:7       __INFO
__{}    adc   A,[HL]        ; 1:7       __INFO
__{}    ld  [HL],A          ; 1:7       __INFO
__{}    djnz $-5            ; 2:8/13    __INFO
__{}    ld    L, C          ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    pop  BC             ; 1:10      __INFO
__{}    djnz $-37           ; 2:8/13    __INFO
__{}    dec   C             ; 1:4       __INFO
__{}    jr   nz, $-45       ; 2:7/12    __INFO}){}dnl
dnl
dnl
dnl
dnl
