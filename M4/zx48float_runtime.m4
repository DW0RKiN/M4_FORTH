dnl ## ZX Spectrum 48 ROM Floating point Arithmetic
define({__},{})dnl
dnl
dnl
dnl
dnl # zdepth
ifdef({USE_ZDEPTH},{
__{}ifelse(_TYP_SINGLE,small,{dnl
__{}                     ;[26:688..736] _zdepth   # small version can be changed with "define({_TYP_SINGLE},{default})"
__{}_ZDEPTH:                ;           _zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
__{}    ex   DE, HL         ; 1:4       _zdepth
__{}    ex  (SP),HL         ; 1:19      _zdepth   ret
__{}    push HL             ; 1:11      _zdepth   back ret
__{}    ld   HL, (0x5C65)   ; 3:16      _zdepth   {STKEND} - Address of temporary work space = address of top of calculator stack
__{}    ld   BC, (0x5C63)   ; 4:20      _zdepth   {STKBOT} - Address of bottom of calculator stack
__{}    xor   A             ; 1:4       _zdepth
__{}    sbc  HL, BC         ; 2:15      _zdepth   HL = 5*n
__{}  if 1
__{}    jr   nc, _ZDEPTH_D5 ; 2:7/12    _zdepth
__{}    sub   L             ; 1:4       _zdepth
__{}    ld    L, A          ; 1:4       _zdepth
__{}    sbc   A, H          ; 1:4       _zdepth
__{}    sub   L             ; 1:4       _zdepth
__{}    ld    H, A          ; 1:4       _zdepth
__{}    ld    A, '-'        ; 2:7       _zdepth   -
__{}__PUTCHAR_A(_zdepth)
__{}    xor   A             ; 1:4       _zdepth
__{}_ZDEPTH_D5:             ;           _zdepth
__{}  endif
__{}    ld   BC, 0x1005     ; 3:10      _zdepth
__{}    add  HL, HL         ; 1:11      _zdepth
__{}    adc   A, A          ; 1:4       _zdepth
__{}    cp    C             ; 1:4       _zdepth
__{}    jr    c, $+4        ; 2:7/12    _zdepth
__{}    sub   C             ; 1:4       _zdepth
__{}    inc   L             ; 1:4       _zdepth
__{}    djnz $-7            ; 2:8/13    _zdepth
__{}    ret                 ; 1:10      _zdepth},
__{}{dnl
__{}                       ;[46:292]    _zdepth   # default version can be changed with "define({_TYP_SINGLE},{small})"
__{}_ZDEPTH:                ;           _zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
__{}    ex   DE, HL         ; 1:4       _zdepth
__{}    ex  (SP),HL         ; 1:19      _zdepth   ret
__{}    push HL             ; 1:11      _zdepth
__{}    ld   HL, (0x5C65)   ; 3:16      _zdepth   {STKEND} - Address of temporary work space = address of top of calculator stack
__{}    ld   BC, (0x5C63)   ; 4:20      _zdepth   {STKBOT} - Address of bottom of calculator stack
__{}    xor   A             ; 1:4       _zdepth
__{}    sbc  HL, BC         ; 2:15      _zdepth   HL = 5*n
__{}  if 1
__{}    jr   nc, _ZDEPTH_D5 ; 2:7/12    _zdepth
__{}    sub   L             ; 1:4       _zdepth
__{}    ld    L, A          ; 1:4       _zdepth
__{}    sbc   A, H          ; 1:4       _zdepth
__{}    sub   L             ; 1:4       _zdepth
__{}    ld    H, A          ; 1:4       _zdepth
__{}    ld    A, '-'        ; 2:7       _zdepth   -
__{}__PUTCHAR_A(_zdepth)
__{}    xor   A             ; 1:4       _zdepth
__{}_ZDEPTH_D5:             ;           _zdepth
__{}  endif
__{}    ld    B, H          ; 1:4       _zdepth
__{}    ld    C, L          ; 1:4       _zdepth   1x = base
__{}    add  HL, HL         ; 1:11      _zdepth
__{}    adc   A, A          ; 1:4       _zdepth   *2 AHL = 2x
__{}    add  HL, BC         ; 1:11      _zdepth
__{}    adc   A, 0x00       ; 2:7       _zdepth   +1 AHL = 3x
__{}    add  HL, HL         ; 1:11      _zdepth
__{}    adc   A, A          ; 1:4       _zdepth   *2 AHL = 6x
__{}    add  HL, HL         ; 1:11      _zdepth
__{}    adc   A, A          ; 1:4       _zdepth   *2 AHL = 12x
__{}    add  HL, HL         ; 1:11      _zdepth
__{}    adc   A, A          ; 1:4       _zdepth   *2 AHL = 24x
__{}    add  HL, BC         ; 1:11      _zdepth
__{}    adc   A, 0x00       ; 2:7       _zdepth   +1 AHL = 25x
__{}    add  HL, HL         ; 1:11      _zdepth
__{}    adc   A, A          ; 1:4       _zdepth   *2 AHL = 50x
__{}    add  HL, BC         ; 1:11      _zdepth
__{}    ld   BC, 0x0033     ; 3:10      _zdepth   rounding down constant
__{}    adc   A, B          ; 1:4       _zdepth   +1 AHL = 51x
__{}    add  HL, BC         ; 1:11      _zdepth
__{}    adc   A, B          ; 1:4       _zdepth   +0 AHL = 51x with rounding down constant
__{}    ld    B, A          ; 1:4       _zdepth   (AHL * 257) >> 16 = (AHL0 + 0AHL) >> 16 = AH.L0 + A.HL = A0 + H.L + A.H
__{}    ld    C, H          ; 1:4       _zdepth   BC = "A.H"
__{}    add  HL, BC         ; 1:11      _zdepth   HL = "H.L" + "A.H"
__{}    ld    L, H          ; 1:4       _zdepth
__{}    adc   A, 0x00       ; 2:7       _zdepth   + carry
__{}    ld    H, A          ; 1:4       _zdepth   HL = HL/5 = HL*(65536/65536)/5 = HL*13107/65536 = (HL*(1+256)*51) >> 16
__{}    ret                 ; 1:10      _zdepth}){}dnl
}){}dnl
dnl
dnl
dnl # z@
ifdef({USE_ZFETCH},{
_ZFETCH:                ;           _z@
    push DE             ; 1:11      _z@   ( addr -- ) ( Z: -- z )
    ld   DE,(0x5C65)    ; 4:20      _z@   {STKEND}
    call 0x33C0         ; 3:315     _z@   {call ZX ROM move floating-point number routine HL->DE}
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
    push DE             ; 1:11      _z!   ( addr -- ) ( Z: z -- )
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
__PUTCHAR_A(_z.)
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
__PUTCHAR_A(_zhex.)
    ret                 ; 1:10      _zhex.

_ZHEXDOT:               ;           _zhex.
    push HL             ; 1:11      _zhex.
    ld   HL,(0x5C65)    ; 3:16      _zhex.   {HL= stkend}
    ld   BC, 0xfffb     ; 3:10      _zhex.
    add  HL, BC         ; 1:11      _zhex.
    ld    B, 0x05       ; 2:7       _zhex.
    jr   _ZXHEXDOT_FIRST; 2:12      _zhex.
    ld    A, ','        ; 2:7       _zhex.
__PUTCHAR_A(_zhex.)
_ZXHEXDOT_FIRST:        ;           _zhex.
    ld    A,(HL)        ; 1:7       _zhex.
    inc  HL             ; 1:6       _zhex.
    call _ZHEX_A        ; 3:17      _zhex.
    djnz $-eval(7+__BYTES)            ; 2:8/13    _zhex.
    ld    A, ' '        ; 2:7       _zhex.
__PUTCHAR_A(_zhex.)
    pop  HL             ; 1:10      _zhex.
    ret                 ; 1:10      _zhex.
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
dnl # z2drop
dnl # zdrop zdrop
ifdef({USE_Z2DROP},{
_Z2DROP:                ;           _z2drop
    push DE             ; 1:11      _z2drop
    push HL             ; 1:11      _z2drop
    rst 0x28            ; 1:11      Use the calculator
    db  0x02            ; 1:        calc-delete
    db  0x02            ; 1:        calc-delete
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _z2drop
    pop  DE             ; 1:10      _z2drop
    ret                 ; 1:10      _z2drop
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
_ZCOMPARE:              ;           _zcompare   ( Z: z1 z2 -- zflag )  zflag = 1 or 0
    push DE             ; 1:11      _zcompare
    push HL             ; 1:11      _zcompare
if 1
    rst 0x28            ; 1:11      Use the calculator    {Save only: AF', HL'}
    db  0x0D            ; 1:        calc-less   Important is what the register B contains
    db  0x38            ; 1:        calc-end
else
    rst 0x28            ; 1:11      Use the calculator    {Save only: AF', HL'}
    db  0x3B            ; 1:        fp_calc_2: (perform the actual operation)
    db  0x38            ; 1:        calc-end
endif
    pop  HL             ; 1:10      _zcompare
    pop  DE             ; 1:10      _zcompare
    ret                 ; 1:10      _zcompare
}){}dnl
dnl
dnl
dnl
dnl # zcompare
ifdef({USE_ZCOMPARE2FLAG},{
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
_ZCOMPARE2FLAG:         ;           _zcompare2flag   ( -- flag ) ( Z: z1 z2 -- )
    pop  AF             ; 1:10      _zcompare2flag
    push DE             ; 1:11      _zcompare2flag
    push AF             ; 1:11      _zcompare2flag
    push HL             ; 1:11      _zcompare2flag
if 1
    rst 0x28            ; 1:11      Use the calculator    {Save only: AF', HL'}
    db  0x0D            ; 1:        calc-less   Important is what the register B contains
    db  0x38            ; 1:        calc-end
else
    rst 0x28            ; 1:11      Use the calculator    {Save only: AF', HL'}
    db  0x3B            ; 1:        fp_calc_2: (perform the actual operation)
    db  0x38            ; 1:        calc-end
endif
    ld   HL,(0x5C65)    ; 3:16      _zcompare2flag   {load STKEND}
    dec  HL             ; 1:6       _zcompare2flag
    dec  HL             ; 1:6       _zcompare2flag
    dec  HL             ; 1:6       _zcompare2flag
    xor   A             ; 1:4       _zcompare2flag
    sub (HL)            ; 1:7       _zcompare2flag
    dec  HL             ; 1:6       _zcompare2flag
    dec  HL             ; 1:6       _zcompare2flag
    ld  (0x5C65), HL    ; 3:16      _zcompare2flag   {save STKEND-5}
    ld    L, A          ; 1:4       _zcompare2flag
    ld    H, A          ; 1:4       _zcompare2flag    
    pop  DE             ; 1:10      _zcompare2flag
    ret                 ; 1:10      _zcompare2flag
}){}dnl
dnl
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
dnl # zfloor
ifdef({USE_ZFLOOR},{
_ZFLOOR:                ;           _zfloor
    push DE             ; 1:11      _zfloor
    push HL             ; 1:11      _zfloor
    call 0x36AF         ; 3:17      _zfloor   {call ZX ROM int}
    pop  HL             ; 1:10      _zfloor
    pop  DE             ; 1:10      _zfloor
    ret                 ; 1:10      _zfloor
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
    ld    A, 0x0D       ; 2:7       _zaddr cr   {Pollutes: AF, AF', DE', BC'}
__PUTCHAR_A(_zaddr cr)
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
dnl # z2dup
ifdef({USE_Z2DUP},{
_Z2DUP:                ;[22:144]    _z2dup
    push DE             ; 1:11      _z2dup
    push HL             ; 1:11      _z2dup
    ld   HL,(0x5C65)    ; 3:16      _z2dup   {load STKEND}
    ex   DE, HL         ; 1:4       _z2dup
    ld   HL,0xFFF6      ; 3:10      _z2dup   -10
    add  HL, DE         ; 1:11      _z2dup
    ld   BC,0x000A      ; 3:10      _z2dup   10 bytes
    ldir                ; 2:21/16   _z2dup
    ld  (0x5C65),DE     ; 4:20      _z2dup   {save STKEND+10}
    pop  HL             ; 1:10      _z2dup
    pop  DE             ; 1:10      _z2dup
    ret                 ; 1:10      _z2dup
}){}dnl
dnl
dnl
dnl # znip
ifdef({USE_ZNIP},{
_ZNIP:                 ;[20:130]    _znip
    push DE             ; 1:11      _znip   ( addr -- ) ( Z: z2 z1 -- z1 )
    push HL             ; 1:11      _znip   addr
    call 0x35bf         ; 3:17      _znip   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    ld    B, 0x05       ; 2:7       _znip
    dec  HL             ; 1:6       _znip
    dec  DE             ; 1:6       _znip
    ld    A,(DE)        ; 1:7       _znip
    ld  (HL),A          ; 1:7       _znip
    djnz $-4            ; 2:8/13    _znip
    ld  (0x5C65),DE     ; 4:20      _znip   {save STKEND-5}
    pop  HL             ; 1:10      _znip
    pop  DE             ; 1:10      _znip
    ret                 ; 1:10      _znip
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
dnl # zpick ( u -- ) ( Z: zu .. z2 z1 z0 -- zu .. z2 z1 z0 zu )
ifdef({xUSE_ZPICK},{
_ZPICK:                ;[29:510]    _zpick   ( x2 ret x1 u -- ret x2 x1 ) ( Z: zu .. z1 z0 -- zu .. z1 z0 zu )   
    inc  HL             ; 1:6       _zpick 
    ld    B, H          ; 1:4       _zpick
    ld    C, L          ; 1:4       _zpick   x+1 
    add  HL, HL         ; 1:11      _zpick   2(x+1) 
    add  HL, HL         ; 1:11      _zpick   4(x+1) 
    add  HL, BC         ; 1:11      _zpick   5(x+1)
    ld    B, H          ; 1:4       _zpick
    ld    C, L          ; 1:4       _zpick   5(x+1)
    pop  HL             ; 1:10      _zpick   ( x2 x1 ret )
    ex  (SP),HL         ; 1:19      _zpick
    push HL             ; 1:11      _zpick   ( ret x2 x1 ret )
    push DE             ; 1:11      _zpick   ( ret x2 x1 x1 ret )
    ld   HL,(0x5C65)    ; 3:16      _zpick   ( .. 5*(u+1) stkend )
    ld    D, H          ; 1:4       _zpick
    ld    E, L          ; 1:4       _zpick   5(x+1)
    sbc  HL, BC         ; 2:15      _zpick   ( .. stkend stkend-5*(u+1) )    
  if 1
    call 0x33C0         ; 3:315     _zpick   5x (DE++) = (HL++), BC = 0  ( Z: zu .. z1 z0 -- zu .. z1 z0 zu )
  else
    ld   BC,0x0005      ; 3:10      _zpick   5 bytes
    ldir                ; 2:100     _zpick   (DE++) = (HL++)
  endif
    ld  (0x5C65),DE     ; 4:20      _zpick   {save STKEND}
    pop  HL             ; 1:10      _zpick
    pop  DE             ; 1:10      _zpick
    ret                 ; 1:10      _zpick   ( ret x2 x1 -- x2 x1 )
}){}dnl
dnl
dnl
dnl # zpick ( u -- ) ( Z: zu .. z2 z1 z0 -- zu .. z2 z1 z0 zu )
ifdef({xxUSE_ZPICK},{
_ZPICK:                ;[31:514]    _zpick   ( x2 ret x1 u -- ret x2 x1 ) ( Z: zu .. z1 z0 -- zu .. z1 z0 zu )   
    ld    A, L          ; 1:4       _zpick
    cpl                 ; 1:4       _zpick
    ld    L, A          ; 1:4       _zpick
    ld    A, H          ; 1:4       _zpick
    cpl                 ; 1:4       _zpick
    ld    H, A          ; 1:4       _zpick
    
    ld    B, H          ; 1:4       _zpick
    ld    C, L          ; 1:4       _zpick
    add  HL, HL         ; 1:11      _zpick 
    add  HL, HL         ; 1:11      _zpick 
    add  HL, BC         ; 1:11      _zpick   -5*(u+1)
    
    pop  BC             ; 1:10      _zpick   ret
    pop  AF             ; 1:10      _zpick   x2
    push BC             ; 1:11      _zpick   ret
    push AF             ; 1:11      _zpick   x2
    push DE             ; 1:11      _zpick   x1
    
    ld   DE,(0x5C65)    ; 4:20      _zpick   ( ret x2 x1 stkend -5*(u+1) )
    add  HL, DE         ; 1:11      _zpick   ( .. stkend stkend-5*(u+1) )    
  if 1
    call 0x33C0         ; 3:315     _zpick   5x (DE++) = (HL++), BC = 0  ( Z: zu .. z1 z0 -- zu .. z1 z0 zu )
  else
    ld   BC,0x0005      ; 3x10      _zpick   5 bytes
    ldir                ; 2x100     _zpick   (DE++) = (HL++)
  endif
    ld  (0x5C65),DE     ; 4:20      _zpick   {save STKEND}
    pop  HL             ; 1:10      _zpick
    pop  DE             ; 1:10      _zpick
    ret                 ; 1:10      _zpick   ( ret x2 x1 -- x2 x1 )
}){}dnl
dnl
dnl
dnl # zpick ( u -- ) ( Z: zu .. z2 z1 z0 -- zu .. z2 z1 z0 zu )
ifdef({USE_ZPICK},{__def({USE_ZPICK_BC})
_ZPICK:                ;[31:514]    _zpick   ( x2 ret x1 u -- ret x2 x1 ) ( Z: zu .. z1 z0 -- zu .. z1 z0 zu )
    inc  HL             ; 1:6       _zpick 
    ld    B, H          ; 1:4       _zpick
    ld    C, L          ; 1:4       _zpick
    add  HL, HL         ; 1:11      _zpick 
    add  HL, HL         ; 1:11      _zpick 
    add  HL, BC         ; 1:11      _zpick   5*(u+1)
    xor   A             ; 1:4       _zpick
    sub   L             ; 1:4       _zpick
    ld    C, A          ; 1:4       _zpick
    sbc   A, H          ; 1:4       _zpick
    sub   C             ; 1:4       _zpick
    ld    B, A          ; 1:4       _zpick   BC = -5*(u+1)
    pop  HL             ; 1:10      _zpick   ret
    ex  (SP),HL         ; 1:19      _zpick   ( ret x1 x2 ){}dnl
__{}ifdef({USE_ZPICK_C},{
__{}    push HL             ; 1:11      _zpick
__{}    push DE             ; 1:11      _zpick
__{}    jr   __ZPICK_BC+2   ; 2:12      _zpick   ( ret x2 x1 x1 x2 )},
__{}{
__{}    ex   DE, HL         ; 1:4       _zpick   ( ret x2 x1 )
__{}    ; fall to _zpick_bc}){}dnl
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
_ZROT:                  ;           _zrot   ( Z: z3 z2 z1 -- z2 z1 z3 )
    push DE             ; 1:11      _zrot
    push HL             ; 1:11      _zrot
    ld   HL,(0x5C65)    ; 3:16      _zrot   {load STKEND}
    ex   DE, HL         ; 1:4       _zrot   {DE = STKEND = (z0)}
    ld   HL,0xFFF1      ; 3:10      _zrot   -15
    add  HL, DE         ; 1:11      _zrot   {HL = STKEND - 15 = (z3)}
    push HL             ; 1:11      _zrot   {STKEND-15}
    call 0x33C0         ; 3:315     _zrot   5x (DE++) = (HL++), BC = 0  ( Z: z3 z2 z1 -- z3 z2 z1 z3 )
    pop  DE             ; 1:10      _zrot   {DE = STKEND - 15}
    ld   C,0x0F         ; 2:7       _zrot   {BC = 15}
    ldir                ; 2:21/16   _zrot   15x (DE++) = (HL++)  ( Z: z3 z2 z1 z3 -- z2 z1 z3 )
    pop  HL             ; 1:10      _zrot
    pop  DE             ; 1:10      _zrot
    ret                 ; 1:10      _zrot
}){}dnl
dnl
dnl
dnl # z-rot
ifdef({USE_ZNROT},{__def({USE_DEC_SWAP_5x})
_ZNROT:                ;[14:103]    _z-rot   ( Z: z3 z2 z1 -- z1 z3 z2 )
    push DE             ; 1:11      _z-rot
    push HL             ; 1:11      _z-rot
    call 0x35bf         ; 3:17      _z-rot   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    call DEC_SWAP_5x    ; 3:17      _z-rot   ( Z: z3 z2 z1 -- z3 z1 z2 )
    call DEC_SWAP_5x    ; 3:17      _z-rot   ( Z: z3 z1 z2 -- z1 z3 z2 ) 
    pop  HL             ; 1:10      _z-rot
    pop  DE             ; 1:10      _z-rot
    ret                 ; 1:10      _z-rot
}){}dnl
dnl
dnl
dnl
dnl # zswap
ifdef({USE_ZSWAP},{ifelse(dnl
TYP_FLOAT,fast,{
__{}_ZSWAP:                ;[19:128+]   _zswap   version: fast
__{}    push DE             ; 1:11      _zswap
__{}    push HL             ; 1:11      _zswap
__{}    call 0x35bf         ; 3:17      _zswap   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
__{}    ld    B,0x05        ; 2:7       _zswap
__{}    dec  DE             ; 1:6       _zswap
__{}    dec  HL             ; 1:6       _zswap
__{}    ld    A,(DE)        ; 1:7       _zswap
__{}    ld    C,(HL)        ; 1:7       _zswap
__{}    ld  (HL),A          ; 1:7       _zswap
__{}    ld    A, C          ; 1:4       _zswap
__{}    ld  (DE),A          ; 1:7       _zswap
__{}    djnz $-7            ; 2:8/13    _zswap},

ifelse(TYP_FLOAT,small,0,1):ifdef({USE_DEC_SWAP_5x},1,0),1:1,{
__{}_ZSWAP:                ;[11:383+]   _zswap   version: use_dec_swap_5x
__{}    push DE             ; 1:11      _zswap
__{}    push HL             ; 1:11      _zswap
__{}    call 0x35bf         ; 3:17      _zswap   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
__{}    call DEC_SWAP_5x    ; 3:17      _zswap},

1,0,{
__{}_ZSWAP:                ;[14:103+]   _zswap   version: ???
__{}    push DE             ; 1:11      _zswap
__{}    push HL             ; 1:11      _zswap
__{}    call 0x35bf         ; 3:17      _zswap   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
__{}    call 0x35c2         ; 3:17      _zswap   {call ZX ROM            DE= HL    , HL = HL-5}
__{}    call 0x343C         ; 3:17      _zswap   {call ZX ROM exchange rutine}},

{
__{}_ZSWAP:                 ;[8:63+]    _zswap   version: default
__{}    push DE             ; 1:11      _zswap
__{}    push HL             ; 1:11      _zswap
__{}    rst 0x28            ; 1:11      _zswap   Use the calculator
__{}    db  0x01            ; 1:        _zswap   calc-exchange
__{}    db  0x38            ; 1:        _zswap   calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}})
    pop  HL             ; 1:10      _zswap
    pop  DE             ; 1:10      _zswap
    ret                 ; 1:10      _zswap
}){}dnl
dnl
dnl
dnl
ifdef({USE_DEC_SWAP_5x},{__def({USE_DEC_SWAP_Bx})
DEC_SWAP_5x:           ;[12:297]    -swap_5x
    ld    B,0x05        ; 2:7       -swap_5x
    ; fall to -swap_Bx}){}dnl
dnl
ifdef({USE_DEC_SWAP_Bx},{
DEC_SWAP_Bx:           ;[10:5+B*57] -swap_Bx
    dec  DE             ; 1:6       -swap_Bx
    dec  HL             ; 1:6       -swap_Bx
    ld    A,(DE)        ; 1:7       -swap_Bx
    ld    C,(HL)        ; 1:7       -swap_Bx
    ld  (HL),A          ; 1:7       -swap_Bx
    ld    A, C          ; 1:4       -swap_Bx
    ld  (DE),A          ; 1:7       -swap_Bx
    djnz $-7            ; 2:8/13    -swap_Bx
    ret                 ; 1:10      -swap_Bx
}){}dnl
dnl
dnl
dnl
ifdef({USE_ZTEST},{
;==============================================================================
; ( z2 z1 -- )
; set carry if z2 > z1, A <> 0
; set not carry if z2 < z1, A <> 0
; set zero if z2 = z1, A = 0
; Pollutes: AF, BC
ZTEST:                 ;[49:185]    ztest   diff sign
                       ;[49:220]    ztest   diff exp
              ;[49:260/306/352/398] ztest   diff mantiss
                       ;[49:427]    ztest   equal
    push DE             ; 1:11      ztest
    push HL             ; 1:11      ztest
    ld   DE, 0xFFFB     ; 3:10      ztest   -5
    ld   HL,(0x5C65)    ; 3:16      ztest   load stkend
    add  HL, DE         ; 1:11      ztest   stkend-5
    ld    B,(HL)        ; 1:7       ztest   load exp z1
    ex   DE, HL         ; 1:4       ztest
    add  HL, DE         ; 1:11      ztest   stkend-10
    ld  (0x5C65), HL    ; 3:16      ztest   save stkend
    ld    C,(HL)        ; 1:7       ztest   load exp z2
    inc  HL             ; 1:6       ztest
    inc  DE             ; 1:6       ztest
    ld    A,(DE)        ; 1:7       ztest   man z1
    xor (HL)            ; 1:7       ztest   xor sign
    ld    A,(DE)        ; 1:7       ztest   sign z1
    jp    m, ZTEST_DIF_S; 3:10      ztest   diff sign?
    ld    A, B          ; 1:4       ztest
    sub   C             ; 1:4       ztest   exp z1 - exp z2 -> carry: z2>z1
    ld    C,(HL)        ; 1:7       ztest   sign z2 & z1
    jr   nz, ZTEST_DIF  ; 2:7/12    ztest   continues with same exp
    ld    B, 0x04       ; 2:7       ztest
    ld    A,(DE)        ; 1:7       ztest
    sub (HL)            ; 1:7       ztest   man z1 - man z2 -> carry: z2>z1
    inc  HL             ; 1:6       ztest
    inc  DE             ; 1:6       ztest
    jr   nz, ZTEST_DIF  ; 2:7/12    ztest   continues with same mantiss
    djnz $-6            ; 2:8/13    ztest
    pop  HL             ; 1:10      ztest
    pop  DE             ; 1:10      ztest
    ret                 ; 1:10      ztest   equal
ZTEST_DIF:              ;           ztest
    rra                 ; 1:4       ztest
    xor   C             ; 1:4       ztest   xor sign
ZTEST_DIF_S:            ;           ztest
    scf                 ; 1:4       ztest   nz output
    adc   A, A          ; 1:4       ztest
    pop  HL             ; 1:10      ztest
    pop  DE             ; 1:10      ztest
    ret                 ; 1:10      ztest   carry: z2>z1
}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
