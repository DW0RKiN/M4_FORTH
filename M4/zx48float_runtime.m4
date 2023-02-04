dnl ## ZX Spectrum 48 ROM Floating point Arithmetic
define({__},{})dnl
dnl
dnl
dnl
dnl # z@
ifdef({USE_ZFETCH},{
_ZFETCH:                ;           _z@
    push DE             ; 1:11      _z@   ( addr -- ) ( F: -- z )
    ld   DE,(0x5C65)    ; 4:20      _z@   {STKEND}
    call 0x33C0         ; 3:17      _z@   {call ZX ROM move floating-point number routine HL->DE}
    ld  (0x5C65),DE     ; 4:20      _z@   {STKEND+5}
    pop  HL             ; 1:10      _z@
    pop  BC             ; 1:10      _z@   ret
    pop  DE             ; 1:10      _z@
    push BC             ; 1:11      _z@   ret
    ret                 ; 1:10      _z@
}){}dnl
dnl
dnl
dnl # z!
ifdef({USE_ZSTORE},{
_ZSTORE:                ;           _z!
    push DE             ; 1:11      _z!   ( addr -- ) ( F: z -- )
    push HL             ; 1:11      _z!   addr
    call 0x35bf         ; 3:17      _z!   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    ld  (0x5C65),HL     ; 3:16      _z!   {save STKEND}
    pop  DE             ; 1:10      _z!   addr
    ld   BC, 0x0005     ; 3:10      _z!
    ldir                ; 2:21/16   _z!
    pop  HL             ; 1:10      _z!
    pop  BC             ; 1:10      _z!   ret
    pop  DE             ; 1:10      _z!
    push BC             ; 1:11      _z!   ret
    ret                 ; 1:10      _z!
}){}dnl
dnl
dnl
dnl # z>s
ifdef({USE_Z_TO_S},{
_Z_TO_S:                ;           _z>s
    pop  BC             ; 1:10      _z>s   ret
    push DE             ; 1:11      _z>s
    push BC             ; 1:11      _z>s   ret
    push HL             ; 1:11      _z>s
    call 0x36AF         ; 3:17      _z>s   {call ZX ROM int}
    ld   HL,(0x5C65)    ; 3:16      _z>s   {load STKEND}
    dec  HL             ; 1:6       _z>s
    dec  HL             ; 1:6       _z>s
    ld    D,(HL)        ; 1:7       _z>s
    dec  HL             ; 1:6       _z>s
    ld    E,(HL)        ; 1:7       _z>s
    dec  HL             ; 1:6       _z>s
    dec  HL             ; 1:6       _z>s
    ld  (0x5C65),HL     ; 3:16      _z>s   {save STKEND+5}
    ex   DE, HL         ; 1:6       _z>s
    pop  DE             ; 1:10      _z>s
    ret                 ; 1:10      _z>s
}){}dnl
dnl
dnl
dnl # z>d
ifdef({USE_Z_TO_D},{define({USE_DNEGATE},{})
_Z_TO_D:                ;           _z>d
    pop  BC             ; 1:10      _z>d   ret
    push DE             ; 1:11      _z>d
    push HL             ; 1:11      _z>d
    push BC             ; 1:11      _z>d   ret

    ld   HL,(0x5C65)    ; 3:16      _z>d   {load STKEND}
    dec  HL             ; 1:6       _z>d
    ld    C,(HL)        ; 1:7       _z>d
    dec  HL             ; 1:6       _z>d
    ld    B,(HL)        ; 1:7       _z>d
    dec  HL             ; 1:6       _z>d
    ld    E,(HL)        ; 1:7       _z>d
    dec  HL             ; 1:6       _z>d
    ld    D,(HL)        ; 1:7       _z>d
    push DE             ; 1:11      _z>d   sign
    dec  HL             ; 1:6       _z>d
    ld    A, 0xA0       ; 2:7       _z>d
    sub (HL)            ; 1:7       _z>d
    ld  (0x5C65),HL     ; 3:16      _z>d   {save STKEND+5}

    set   7, D          ; 2:8       _z>d
if 1
    ld    L, C          ; 1:4       _z>d
    ld    H, B          ; 1:4       _z>d
    jr    z, $+11       ; 2:7/12    _z>d   -0x1p+31 == -0x80000000

    srl   D             ; 2:8       _z>d
    rr    E             ; 2:8       _z>d
    rr    H             ; 2:8       _z>d
    rr    L             ; 2:8       _z>d
    dec   A             ; 1:4       _z>d
    jr   nz, $-9        ; 2:7/12    _z>d
else
    ld    H, C          ; 1:4       _z>d
    ld    C, B          ; 1:4       _z>d
    ld    B, E          ; 1:4       _z>d
    ld    E, D          ; 1:4       _z>d
    ld    D, 0x00       ; 2:7       _z>d
    sub  0x08           ; 2:7       _z>d
    jr   nc, $-8        ; 2:7/12    _z>d

    ld    L, C          ; 1:4       _z>d
    ld    C, A          ; 1:4       _z>d
    ld    A, H          ; 1:4       _z>d
    ld    H, B          ; 1:4       _z>d

    add   A, A          ; 1:4       _z>d
    adc  HL, HL         ; 2:15      _z>d
    rl    E             ; 2:8       _z>d
    rl    D             ; 2:8       _z>d
    inc   C             ; 1:4       _z>d
    jr   nz, $-8        ; 2:7/12    _z>d
endif
    pop  AF             ; 1:10      _z>d   sign
    add   A, A          ; 1:4       _z>d
    ret  nc             ; 1:5/11    _z>d

    jp   NEGATE_32      ; 3:10      _z>d

}){}dnl
dnl
dnl
dnl # u>z
ifdef({USE_U_TO_Z},{
_U_TO_Z:                ;           _u>z
    push DE             ; 1:11      _u>z   ( c ret . b a -- ret . c b )
    ld    B, H          ; 1:4       _u>z
    ld    C, L          ; 1:4       _u>z
    call 0x2D2B         ; 3:17      _u>z   {call ZX ROM stack BC routine}
    pop  HL             ; 1:10      _u>z
    pop  BC             ; 1:10      _u>z   ret
    pop  DE             ; 1:10      _u>z
    push BC             ; 1:11      _u>z   ret
    ret                 ; 1:10      _u>z
}){}dnl
dnl
dnl
ifdef({USE_BC_TO_Z},{
_BC_TO_Z:               ;           _bc>z
    push DE             ; 1:11      _bc>z
    push HL             ; 1:11      _bc>z
    call 0x2D2B         ; 3:17      _bc>z   {call ZX ROM stack BC routine}
    pop  HL             ; 1:10      _bc>z
    pop  DE             ; 1:10      _bc>z
    ret                 ; 1:10      _bc>z
}){}dnl
dnl
dnl
dnl # s>z
ifdef({USE_S_TO_Z},{define({USE_SIGN_BC_TO_Z},{})
_S_TO_Z:                ;           _s>z   ( num ret . de hl -- ret . num de )
    ld    B, H          ; 1:4       _s>z
    ld    C, L          ; 1:4       _s>z
    pop  HL             ; 1:10      _s>z   ( num . de ret )
    ex  (SP),HL         ; 1:19      _s>z   ( ret . de num )
    ex   DE, HL         ; 1:4       _s>z   ( ret . num de )
    ; fall to _sign_bc_to_z
}){}dnl
dnl
ifdef({USE_SIGN_BC_TO_Z},{define({USE_CF_BC_TO_Z},{})
_SIGN_BC_TO_Z:          ;[2:8]      _sign_bc>z
    ld    A, B          ; 1:4       _sign_bc>z
    add   A, A          ; 1:4       _sign_bc>z
    ; fall to _cf_bc_to_z
}){}dnl
dnl
ifdef({USE_CF_BC_TO_Z},{
if 1
_CF_BC_TO_Z:           ;[14:200]    _cf_bc>z
    sbc   A, A          ; 1:4       _cf_bc>z   0x00 or 0xff
    push HL             ; 1:11      _cf_bc>z
    push DE             ; 1:11      _cf_bc>z
    ld    E, A          ; 1:4       _cf_bc>z
    ld    D, C          ; 1:4       _cf_bc>z
    ld    C, B          ; 1:4       _cf_bc>z
    xor   A             ; 1:4       _cf_bc>z
    ld    B, A          ; 1:4       _cf_bc>z
    call 0x2ABB         ; 3:124     _cf_bc>z   new float = a,e,d,c,b = 0,0-sign,lo,hi,0
    pop  DE             ; 1:10      _cf_bc>z
else
_CF_BC_TO_Z:           ;[22:138]    _cf_bc>z
    sbc   A, A          ; 1:4       _cf_bc>z   0x00 or 0xff
    push HL             ; 1:11      _cf_bc>z
    ld   HL,(0x5C65)    ; 3:16      _cf_bc>z   {load STKEND}
    ld  (HL),0x00       ; 2:10      _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (HL), A         ; 1:7       _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (HL), C         ; 1:7       _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (HL), B         ; 1:7       _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (HL),0x00       ; 2:10      _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (0x5C65),HL     ; 3:16      _cf_bc>z   {save STKEND+5}
endif
    pop  HL             ; 1:10      _cf_bc>z
    ret                 ; 1:10      _cf_bc>z
}){}dnl
dnl
dnl
ifdef({USE_D_TO_Z},{define({USE_DNEGATE},{})
_D_TO_Z:                ;           _d>z   ( num2 num1 ret . de hl -- ret . num2 num1 )
    ld    A, D          ; 1:4       _d>z
    or    E             ; 1:4       _d>z
    or    H             ; 1:4       _d>z
    or    L             ; 1:4       _d>z
    jr    z, _ZERO_TO_Z ; 2:7/12    _d>z   zero?
    ld    A, 0x7F       ; 2:7       _d>z
    or    D             ; 1:4       _d>z
    push AF             ; 1:11      _d>z   save sign 0x7f or 0xff
    call  m, NEGATE_32  ; 3:17      _d>z
    ld    B, 0xA0       ; 2:7       _d>z
    jp    m, $+12       ; 3:10      _d>z   0x80000000

    dec   B             ; 1:4       _d>z   exp--
    add  HL, HL         ; 1:11      _d>z
    rl    E             ; 2:8       _d>z
    rl    D             ; 2:8       _d>z
    jp    p, $-6        ; 3:10      _d>z   wait for sign

    pop  AF             ; 1:11      _d>z   load sign 0x7f or 0xff
    and   D             ; 1:4       _d>z
    ld    D, E          ; 1:4       _d>z
    ld    E, A          ; 1:4       _d>z   swap D and E
    ld    A, B          ; 1:4       _d>z   exp
_ZERO_TO_Z:             ;           _d>z   zero entry
    ld    B, L          ; 1:4       _d>z
    ld    C, H          ; 1:4       _d>z
    call 0x2ABB         ; 3:124     _d>z   new float = a,e,d,c,b
    pop  BC             ; 1:10      _d>z   ret
    pop  HL             ; 1:10      _d>z
    pop  DE             ; 1:10      _d>z
    push BC             ; 1:10      _d>z   ret
    ret                 ; 1:10      _d>z
}){}dnl
dnl
dnl
dnl # z.
ifdef({USE_ZDOT},{
_ZDOT:                  ;           _z.
    push DE             ; 1:11      _z.
    push HL             ; 1:11      _z.
    call 0x35bf         ; 3:17      _z.   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    push HL             ; 1:11      _z.
    call 0x2de3         ; 3:17      _z.   {call ZX ROM print a floating-point number routine}
    pop  HL             ; 1:10      _z.
    ld  (0x5C65),HL     ; 3:16      _z.   {save STKEND}
    ld    A, ' '        ; 2:7       _z.   {putchar Pollutes: AF, AF', DE', BC'}
    rst  0x10           ; 1:11      _z.   {putchar with ZX 48K ROM in, this will print char in A}
    pop  HL             ; 1:10      _z.
    pop  DE             ; 1:10      _z.
    ret                 ; 1:10      _z.
}){}dnl
dnl
dnl
ifdef({USE_ZHEXDOT},{
_ZHEX_A:                ;           _zhex.
    push AF             ; 1:11      _zhex.
    rra                 ; 1:4       _zhex.
    rra                 ; 1:4       _zhex.
    rra                 ; 1:4       _zhex.
    rra                 ; 1:4       _zhex.
    call _ZHEX_LO       ; 3:17      _zhex.
    pop  AF             ; 1:10      _zhex.
    ; fall

;  In: A = number
; Out: (A & $0F) => '0'..'9','A'..'F'
_ZHEX_LO:               ;           _zhex.
    or   0xF0           ; 2:7       _zhex.   reset H flag
    daa                 ; 1:4       _zhex.   $F0..$F9 + $60 => $50..$59; $FA..$FF + $66 => $60..$65
    add   A, 0xA0       ; 2:7       _zhex.   $F0..$F9, $100..$105
    adc   A, 0x40       ; 2:7       _zhex.   $30..$39, $41..$46   = '0'..'9', 'A'..'F'
    rst  0x10           ; 1:11      _zhex.   {putchar with ZX 48K ROM in, this will print char in A}
    ret                 ; 1:10      _zhex.

_ZHEXDOT:               ;           _zhex.
    push HL             ; 1:11      _zhex.
    ld   HL,(0x5C65)    ; 3:16      _zhex.   {HL= stkend}
    ld   BC, 0xfffb     ; 3:10      _zhex.
    add  HL, BC         ; 1:11      _zhex.
    ld    B, 0x05       ; 2:7       _zhex.
    jr   $+5            ; 2:12      _zhex.
    ld    A, ','        ; 2:7       _zhex.
    rst  0x10           ; 1:11      _zhex.   {putchar with ZX 48K ROM in, this will print char in A}
    ld    A,(HL)        ; 1:7       _zhex.
    inc  HL             ; 1:6       _zhex.
    call _ZHEX_A        ; 3:17      _zhex.
    djnz $-8            ; 2:8/13    _zhex.
    ld    A, ' '        ; 2:7       _zhex.
    rst  0x10           ; 1:11      _zhex.   {putchar with ZX 48K ROM in, this will print char in A}
    pop  HL             ; 1:10      _zhex.
    ret                 ; 1:10      _zhex.
}){}dnl
dnl
dnl
dnl # zswap
ifdef({USE_ZSWAP},{
_ZSWAP:                 ;           _zswap
    push DE             ; 1:11      _zswap
    push HL             ; 1:11      _zswap
if 1
if 1
    rst 0x28            ; 1:11      Use the calculator
    db  0x01            ; 1:        calc-exchange
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
else
    call 0x35bf         ; 3:17      _zswap   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    call 0x35c2         ; 3:17      _zswap   {call ZX ROM            DE= HL    , HL = HL-5}
    call 0x343C         ; 3:17      _zswap   {call ZX ROM exchange rutine}
endif
else
    call 0x35bf         ; 3:17      _zswap   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    ld    B,0x05        ; 2:7       _zswap
    dec  DE             ; 1:6       _zswap
    dec  HL             ; 1:6       _zswap
    ld    A,(DE)        ; 1:7       _zswap
    ld    C,(HL)        ; 1:7       _zswap
    ld  (HL),A          ; 1:7       _zswap
    ld    A, C          ; 1:4       _zswap
    ld  (DE),A          ; 1:7       _zswap
    djnz $-7            ; 2:8/13    _zswap
endif
    pop  HL             ; 1:10      _zswap
    pop  DE             ; 1:10      _zswap
    ret                 ; 1:10      _zswap
}){}dnl
dnl
dnl
dnl # zdrop
ifdef({USE_ZDROP},{
_ZDROP:                 ;           _zdrop
    push DE             ; 1:11      _zdrop
    push HL             ; 1:11      _zdrop
    rst 0x28            ; 1:11      Use the calculator
    db  0x02            ; 1:        calc-delete
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zdrop
    pop  DE             ; 1:10      _zdrop
    ret                 ; 1:10      _zdrop
}){}dnl
dnl
dnl
dnl # z-
ifdef({USE_ZSUB},{
_ZSUB:                  ;           _z-
    push DE             ; 1:11      _z-
    push HL             ; 1:11      _z-
    rst 0x28            ; 1:11      Use the calculator
    db  0x03            ; 1:        calc-sub
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _z-
    pop  DE             ; 1:10      _z-
    ret                 ; 1:10      _z-
}){}dnl
dnl
dnl
dnl # z*
ifdef({USE_ZMUL},{
_ZMUL:                  ;           _z*
    push DE             ; 1:11      _z*
    push HL             ; 1:11      _z*
if 1
    rst 0x28            ; 1:11      Use the calculator
    db  0x04            ; 1:        calc-mul
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC', DE'(=DE)}
else
    call 0x35bf         ; 3:17      _z*   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    ld  (0x5C65),HL     ; 3:16      _z*   {save STKEND}
    call 0x35c2         ; 3:17      _z*   {call ZX ROM            DE= HL    , HL = HL-5}
    call 0x30ca         ; 3:17      _z*   {call ZX ROM fmul, adr_HL = adr_DE * adr_HL}
endif
    pop  HL             ; 1:10      _z*
    pop  DE             ; 1:10      _z*
    ret                 ; 1:10      _z*
}){}dnl
dnl
dnl
dnl # z/
ifdef({USE_ZDIV},{
_ZDIV:                  ;           _z/
    push DE             ; 1:11      _z/
    push HL             ; 1:11      _z/
if 1
    rst 0x28            ; 1:11      Use the calculator
    db  0x05            ; 1:        calc-div
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC', DE'(=DE)}
else
    call 0x35bf         ; 3:17      _z/   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    ld  (0x5C65),HL     ; 3:16      _z/   {save STKEND}
    call 0x35c2         ; 3:17      _z/   {call ZX ROM            DE= HL    , HL = HL-5}
    call 0x31af         ; 3:17      _z/   {call ZX ROM fdiv}
endif
    pop  HL             ; 1:10      _z/
    pop  DE             ; 1:10      _z/
    ret                 ; 1:10      _z/
}){}dnl
dnl
dnl
dnl # z**
ifdef({USE_ZMULMUL},{
_ZMULMUL:               ;           _z**
    push DE             ; 1:11      _z**
    push HL             ; 1:11      _z**
    rst 0x28            ; 1:11      Use the calculator
    db  0x06            ; 1:        calc-to_power
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC', DE'(=DE)}
    pop  HL             ; 1:10      _z**
    pop  DE             ; 1:10      _z**
    ret                 ; 1:10      _z**
}){}dnl
dnl
dnl
dnl # zcompare
ifdef({USE_ZCOMPARE},{
; Input: B
; compare 0x09: <= (numbers)
; compare 0x0A: >= (numbers)
; compare 0x0B: <> (numbers)
; compare 0x0C: > (numbers)
; compare 0x0D: < (numbers)
; compare 0x0E: = (numbers)
; compare 0x11: <= (strings)
; compare 0x12: >= (strings)
; compare 0x13: <> (strings)
; compare 0x14: > (strings)
; compare 0x15: < (strings)
; compare 0x16: = (strings)
_ZCOMPARE:              ;           _zcompare
    push DE             ; 1:11      _zcompare
    push HL             ; 1:11      _zcompare
if 1
    rst 0x28            ; 1:11      Use the calculator
    db  0x0D            ; 1:        calc-less   Important is what the register B contains
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
else
    rst 0x28            ; 1:11      Use the calculator
    db  0x3B            ; 1:        fp_calc_2: (perform the actual operation)
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
endif
    pop  HL             ; 1:10      _zcompare
    pop  DE             ; 1:10      _zcompare
    ret                 ; 1:10      _zcompare
}){}dnl
dnl
dnl
dnl # z0=
ifdef({USE_Z0EQ},{
_Z0EQ:                  ;           _z0=
    ex   DE, HL         ; 1:4       _z0=   ( ret . de hl -- de ret . hl flag )
    ex  (SP),HL         ; 1:19      _z0=
    push HL             ; 1:11      _z0=   ret
    ld   HL,(0x5C65)    ; 3:16      _z0=   {load STKEND}
    ld    B, 0x05       ; 2:7       _z0=
    xor   A             ; 1:4       _z0=
    dec  HL             ; 1:6       _z0=
    or  (HL)            ; 1:7       _z0=
    djnz $-2            ; 2:8/13    _z0=
    ld  (0x5C65), HL    ; 3:16      _z0=   {save STKEND-5}
    sub  0x01           ; 2:7       _z0=
    sbc  HL, HL         ; 2:15      _z0=
    ret                 ; 1:10      _z0=
}){}dnl
dnl
dnl
dnl # z0<
ifdef({USE_Z0LT},{
_Z0LT:                  ;           _z0<
    ex   DE, HL         ; 1:4       _z0<   ( ret . de hl -- de ret . hl flag )
    ex  (SP),HL         ; 1:19      _z0<
    push HL             ; 1:11      _z0<   ret
    ld   HL,(0x5C65)    ; 3:16      _z0<   {load STKEND}
    ld    B, 0x05       ; 2:7       _z0<
    ld    A,(HL)        ; 1:7       _z0<
    dec  HL             ; 1:6       _z0<
    djnz $-2            ; 2:8/13    _z0<
    ld  (0x5C65), HL    ; 3:16      _z0<   {save STKEND-5}
    add   A, A          ; 2:7       _z0<
    sbc  HL, HL         ; 2:15      _z0<
    ret                 ; 1:10      _z0<
}){}dnl
dnl
dnl
dnl # z+
ifdef({USE_ZADD},{
_ZADD:                  ;           _z+
    push DE             ; 1:11      _z+
    push HL             ; 1:11      _z+
    rst 0x28            ; 1:11      Use the calculator
    db  0x0F            ; 1:        calc-add
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _z+
    pop  DE             ; 1:10      _z+
    ret                 ; 1:10      _z+
}){}dnl
dnl
dnl
dnl # zsin
ifdef({USE_ZSIN},{
_ZSIN:                  ;           _zsin
    push DE             ; 1:11      _zsin
    push HL             ; 1:11      _zsin
    rst 0x28            ; 1:11      Use the calculator
    db  0x1F            ; 1:        calc-sin
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zsin
    pop  DE             ; 1:10      _zsin
    ret                 ; 1:10      _zsin
}){}dnl
dnl
dnl
dnl # zcos
ifdef({USE_ZCOS},{
_ZCOS:                  ;           _zcos
    push DE             ; 1:11      _zcos
    push HL             ; 1:11      _zcos
    rst 0x28            ; 1:11      Use the calculator
    db  0x20            ; 1:        calc-cos
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zcos
    pop  DE             ; 1:10      _zcos
    ret                 ; 1:10      _zcos
}){}dnl
dnl
dnl
dnl # ztan
ifdef({USE_ZTAN},{
_ZTAN:                  ;           _ztan
    push DE             ; 1:11      _ztan
    push HL             ; 1:11      _ztan
    rst 0x28            ; 1:11      Use the calculator
    db  0x21            ; 1:        calc-tan
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _ztan
    pop  DE             ; 1:10      _ztan
    ret                 ; 1:10      _ztan
}){}dnl
dnl
dnl
dnl # zasin
ifdef({USE_ZASIN},{
_ZASIN:                 ;           _zasin
    push DE             ; 1:11      _zasin
    push HL             ; 1:11      _zasin
    rst 0x28            ; 1:11      Use the calculator
    db  0x22            ; 1:        calc-arcsin
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zasin
    pop  DE             ; 1:10      _zasin
    ret                 ; 1:10      _zasin
}){}dnl
dnl
dnl
dnl # zacos
ifdef({USE_ZACOS},{
_ZACOS:                 ;           _zacos
    push DE             ; 1:11      _zacos
    push HL             ; 1:11      _zacos
    rst 0x28            ; 1:11      Use the calculator
    db  0x23            ; 1:        calc-arccos
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zacos
    pop  DE             ; 1:10      _zacos
    ret                 ; 1:10      _zacos
}){}dnl
dnl
dnl
dnl # zatan
ifdef({USE_ZATAN},{
_ZATAN:                 ;           _zatan
    push DE             ; 1:11      _zatan
    push HL             ; 1:11      _zatan
    rst 0x28            ; 1:11      Use the calculator
    db  0x24            ; 1:        calc-arctan
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zatan
    pop  DE             ; 1:10      _zatan
    ret                 ; 1:10      _zatan
}){}dnl
dnl
dnl
dnl # zln
ifdef({USE_ZLN},{
_ZLN:                   ;           _zln
    push DE             ; 1:11      _zln
    push HL             ; 1:11      _zln
    rst 0x28            ; 1:11      Use the calculator
    db  0x25            ; 1:        calc-ln
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zln
    pop  DE             ; 1:10      _zln
    ret                 ; 1:10      _zln
}){}dnl
dnl
dnl
dnl # zexp
ifdef({USE_ZEXP},{
_ZEXP:                  ;           _zexp
    push DE             ; 1:11      _zexp
    push HL             ; 1:11      _zexp
    rst 0x28            ; 1:11      Use the calculator
    db  0x26            ; 1:        calc-exp
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zexp
    pop  DE             ; 1:10      _zexp
    ret                 ; 1:10      _zexp
}){}dnl
dnl
dnl
dnl # zsqrt
ifdef({USE_ZSQRT},{
_ZSQRT:                 ;           _zsqrt
    push DE             ; 1:11      _zsqrt
    push HL             ; 1:11      _zsqrt
    rst 0x28            ; 1:11      Use the calculator
    db  0x28            ; 1:        calc-sqrt
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zsqrt
    pop  DE             ; 1:10      _zsqrt
    ret                 ; 1:10      _zsqrt
}){}dnl
dnl
dnl
dnl # zabs
ifdef({USE_ZABS},{
_ZABS:                  ;           _zabs
    push DE             ; 1:11      _zabs
    push HL             ; 1:11      _zabs
    rst 0x28            ; 1:11      Use the calculator
    db  0x2A            ; 1:        calc-abs
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zabs
    pop  DE             ; 1:10      _zabs
    ret                 ; 1:10      _zabs
}){}dnl
dnl
dnl
dnl # znegate
ifdef({USE_ZNEGATE},{
_ZNEGATE:               ;           _znegate
    push DE             ; 1:11      _znegate
    push HL             ; 1:11      _znegate
    rst 0x28            ; 1:11      Use the calculator
    db  0x1B            ; 1:        calc-negate
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _znegate
    pop  DE             ; 1:10      _znegate
    ret                 ; 1:10      _znegate
}){}dnl
dnl
dnl
dnl # zint
ifdef({USE_ZINT},{
_ZINT:                  ;           _zint
    push DE             ; 1:11      _zint
    push HL             ; 1:11      _zint
    call 0x36AF         ; 3:17      _zint   {call ZX ROM int}
    pop  HL             ; 1:10      _zint
    pop  DE             ; 1:10      _zint
    ret                 ; 1:10      _zint
}){}dnl
dnl
dnl
dnl # zaddr
ifdef({USE_ZADDR},{
_ZADDR:                 ;           _zaddr
    push DE             ; 1:11      _zaddr
    ex   DE, HL         ; 1:4       _zaddr
    ld   HL,(0x5C65)    ; 3:16      _zaddr   {HL= stkend}
__ASM_TOKEN_UDOTZXROM
    ld    A, 0x0D       ; 2:7       _zaddr-cr   {Pollutes: AF, AF', DE', BC'}
    rst  0x10           ; 1:11      _zaddr-cr   {with 48K ROM in, this will print char in A}
    ret                 ; 1:10      _zaddr
}){}dnl
dnl
dnl
dnl # zdup
ifdef({USE_ZDUP},{
_ZDUP:                  ;           _zdup
    push DE             ; 1:11      _zdup
    push HL             ; 1:11      _zdup
    rst 0x28            ; 1:11      Use the calculator
    db  0x31            ; 1:        calc-duplicate
    db  0x38            ; 1:        calc-end
    pop  HL             ; 1:10      _zdup
    pop  DE             ; 1:10      _zdup
    ret                 ; 1:10      _zdup
}){}dnl
dnl
dnl
dnl # zover
ifdef({USE_ZOVER},{
if 1
_ZOVER:                ;[22:144]    _zover
    push DE             ; 1:11      _zover
    push HL             ; 1:11      _zover
    ld   HL,(0x5C65)    ; 3:16      _zover   {load STKEND}
    ex   DE, HL         ; 1:4       _zover
    ld   HL,0xFFF6      ; 3:10      _zover   -10
    add  HL, DE         ; 1:11      _zover
    ld   BC,0x0005      ; 3:10      _zover   5 bytes
    ldir                ; 2:21/16   _zover
    ld  (0x5C65),DE     ; 4:20      _zover   {save STKEND+5}
else
_ZOVER:                ;[20:130]    _zover
    push DE             ; 1:11      _zover
    push HL             ; 1:11      _zover
    ld   HL,(0x5C65)    ; 3:16      _zover   {load STKEND}
    ex   DE, HL         ; 1:4       _zover
    ld   HL,0xFFF6      ; 3:10      _zover   -10
    add  HL, DE         ; 1:11      _zover
    call 0x33c0         ; 3:17      _zover
    ld  (0x5C65),DE     ; 4:20      _zover   {save STKEND+5}
endif
    pop  HL             ; 1:10      _zover
    pop  DE             ; 1:10      _zover
    ret                 ; 1:10      _zover
}){}dnl
dnl
dnl
ifdef({USE_ZPICK_C},{__def({USE_ZPICK_BC})
; Input: C
_ZPICK_C:               ;           _zpick_c
    ld    B, 0xFF       ; 2:7       _zpick_c
    ; fall to _zpick_bc
}){}dnl
dnl
ifdef({USE_ZPICK_BC},{
; Input: BC
_ZPICK_BC:             ;[20:152]    _zpick_bc
    push DE             ; 1:11      _zpick_bc
    push HL             ; 1:11      _zpick_bc
    ld   HL,(0x5C65)    ; 3:16      _zpick_bc   {load STKEND}
    ld    D, H          ; 1:11      _zpick_bc
    ld    E, L          ; 1:11      _zpick_bc
    add  HL, BC         ; 1:11      _zpick_bc
    ld   BC,0x0005      ; 3:10      _zpick_bc   5 bytes
    ldir                ; 2:21/16   _zpick_bc
    ld  (0x5C65),DE     ; 4:20      _zpick_bc   {save STKEND+5}
    pop  HL             ; 1:10      _zpick_bc
    pop  DE             ; 1:10      _zpick_bc
    ret                 ; 1:10      _zpick_bc
}){}dnl
dnl
dnl
dnl # zrot
ifdef({USE_ZROT},{
_ZROT:                  ;           _zrot   ( F: z1 z2 z3 -- z2 z3 z1 )
    push DE             ; 1:11      _zrot
    push HL             ; 1:11      _zrot
    ld   HL,(0x5C65)    ; 3:16      _zrot   {load STKEND}
    ex   DE, HL         ; 1:4       _zrot   {DE = STKEND}
    ld   HL,0xFFF1      ; 3:10      _zrot   -15
    add  HL, DE         ; 1:11      _zrot   {HL = STKEND - 15}
    push HL             ; 1:11      _zrot   {STKEND-15}
    call 0x33C0         ; 3:17      _zrot   (DE++) = (HL++), BC = 0   ( F: z1 z2 z3    -- z1 z2 z3 z1 )
    pop  DE             ; 1:10      _zrot   {DE = STKEND - 15}
    ld   C,0x0F         ; 2:7       _zrot   {BC = 15}
    ldir                ; 2:21/16   _zrot   (DE++) = (HL++)   ( F: z1 z2 z3 z1 -- z2 z3 z1 )
    pop  HL             ; 1:10      _zrot
    pop  DE             ; 1:10      _zrot
    ret                 ; 1:10      _zrot
}){}dnl
dnl
dnl
dnl
