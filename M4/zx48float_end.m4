dnl ## ZX Spectrum 48 ROM Floating point Arithmetic
define({___},{})dnl
dnl
dnl
dnl
dnl F@
ifdef({USE_ZX48FFETCH},{
_ZX48FFETCH:
    push DE             ; 1:11      _zx48ffetch   ( addr -- ) ( F: -- r )
    ld   DE,(0x5C65)    ; 4:20      _zx48ffetch   {STKEND}
    call 0x33C0         ; 3:17      _zx48ffetch   {call ZX ROM move floating-point number routine HL->DE}
    ld  (0x5C65),DE     ; 4:20      _zx48ffetch   {STKEND+5}
    pop  HL             ; 1:10      _zx48ffetch
    pop  BC             ; 1:10      _zx48ffetch   ret
    pop  DE             ; 1:10      _zx48ffetch
    push BC             ; 1:11      _zx48ffetch   ret
    ret                 ; 1:10      _zx48ffetch
}){}dnl
dnl
dnl
dnl F!
ifdef({USE_ZX48FSTORE},{
_ZX48FSTORE:
    push DE             ; 1:11      _zx48fstore   ( addr -- ) ( F: r -- )
    push HL             ; 1:11      _zx48fstore   addr
    call 0x35bf         ; 3:17      _zx48fstore   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    ld  (0x5C65),HL     ; 3:16      _zx48fstore   {save STKEND}
    pop  DE             ; 1:10      _zx48fstore   addr
    ld   BC, 0x0005     ; 3:10      _zx48fstore
    ldir                ; 2:21/16   _zx48fstore
    pop  HL             ; 1:10      _zx48fstore
    pop  BC             ; 1:10      _zx48fstore   ret
    pop  DE             ; 1:10      _zx48fstore
    push BC             ; 1:11      _zx48fstore   ret
    ret                 ; 1:10      _zx48fstore
}){}dnl
dnl
dnl
ifdef({USE_ZX48F_TO_S},{
_ZX48F_TO_S:
    pop  BC             ; 1:10      _zx48f>s   ret
    push DE             ; 1:11      _zx48f>s
    push BC             ; 1:11      _zx48f>s   ret
    push HL             ; 1:11      _zx48f>s
    call 0x36AF         ; 3:17      _zx48f>s   {call ZX ROM int}
    ld   HL,(0x5C65)    ; 3:16      _zx48f>s   {load STKEND}
    dec  HL             ; 1:6       _zx48f>s
    dec  HL             ; 1:6       _zx48f>s
    ld    D,(HL)        ; 1:7       _zx48f>s
    dec  HL             ; 1:6       _zx48f>s
    ld    E,(HL)        ; 1:7       _zx48f>s
    dec  HL             ; 1:6       _zx48f>s
    dec  HL             ; 1:6       _zx48f>s
    ld  (0x5C65),HL     ; 3:16      _zx48f>s   {save STKEND+5}
    ex   DE, HL         ; 1:6       _zx48f>s
    pop  DE             ; 1:10      _zx48f>s
    ret                 ; 1:10      _zx48f>s
}){}dnl
dnl
dnl
ifdef({USE_ZX48F_TO_D},{define({USE_DNEGATE},{})
_ZX48F_TO_D:
    pop  BC             ; 1:10      _zx48f>d   ret
    push DE             ; 1:11      _zx48f>d
    push HL             ; 1:11      _zx48f>d
    push BC             ; 1:11      _zx48f>d   ret

    ld   HL,(0x5C65)    ; 3:16      _zx48f>d   {load STKEND}
    dec  HL             ; 1:6       _zx48f>d
    ld    C,(HL)        ; 1:7       _zx48f>d
    dec  HL             ; 1:6       _zx48f>d
    ld    B,(HL)        ; 1:7       _zx48f>d
    dec  HL             ; 1:6       _zx48f>d
    ld    E,(HL)        ; 1:7       _zx48f>d
    dec  HL             ; 1:6       _zx48f>d
    ld    D,(HL)        ; 1:7       _zx48f>d
    push DE             ; 1:11      _zx48f>d   sign
    dec  HL             ; 1:6       _zx48f>d
    ld    A, 0xA0       ; 2:7       _zx48f>d
    sub (HL)            ; 1:7       _zx48f>d
    ld  (0x5C65),HL     ; 3:16      _zx48f>d   {save STKEND+5}

    set   7, D          ; 2:8       _zx48f>d
if 1
    ld    L, C          ; 1:4       _zx48f>d
    ld    H, B          ; 1:4       _zx48f>d
    jr    z, $+11       ; 2:7/12    _zx48f>d   -0x1p+31 == -0x80000000

    srl   D             ; 2:8       _zx48f>d
    rr    E             ; 2:8       _zx48f>d
    rr    H             ; 2:8       _zx48f>d
    rr    L             ; 2:8       _zx48f>d
    dec   A             ; 1:4       _zx48f>d
    jr   nz, $-9        ; 2:7/12    _zx48f>d
else
    ld    H, C          ; 1:4       _zx48f>d
    ld    C, B          ; 1:4       _zx48f>d
    ld    B, E          ; 1:4       _zx48f>d
    ld    E, D          ; 1:4       _zx48f>d
    ld    D, 0x00       ; 2:7       _zx48f>d
    sub  0x08           ; 2:7       _zx48f>d
    jr   nc, $-8        ; 2:7/12    _zx48f>d

    ld    L, C          ; 1:4       _zx48f>d
    ld    C, A          ; 1:4       _zx48f>d
    ld    A, H          ; 1:4       _zx48f>d
    ld    H, B          ; 1:4       _zx48f>d

    add   A, A          ; 1:4       _zx48f>d
    adc  HL, HL         ; 2:15      _zx48f>d
    rl    E             ; 2:8       _zx48f>d
    rl    D             ; 2:8       _zx48f>d
    inc   C             ; 1:4       _zx48f>d
    jr   nz, $-8        ; 2:7/12    _zx48f>d
endif
    pop  AF             ; 1:10      _zx48f>d   sign
    add   A, A          ; 1:4       _zx48f>d
    ret  nc             ; 1:5/11    _zx48f>d

    jp   NEGATE_32      ; 3:10      _zx48f>d

}){}dnl
dnl
dnl
ifdef({USE_ZX48U_TO_F},{
_ZX48U_TO_F:
    push DE             ; 1:11      _zx48u>f   ( c ret . b a -- ret . c b )
    ld    B, H          ; 1:4       _zx48u>f
    ld    C, L          ; 1:4       _zx48u>f
    call 0x2D2B         ; 3:17      _zx48u>f   {call ZX ROM stack BC routine}
    pop  HL             ; 1:10      _zx48u>f
    pop  BC             ; 1:10      _zx48u>f   ret
    pop  DE             ; 1:10      _zx48u>f
    push BC             ; 1:11      _zx48u>f   ret
    ret                 ; 1:10      _zx48u>f
}){}dnl
dnl
dnl
ifdef({USE_ZX48BC_TO_F},{
_ZX48BC_TO_F:
    push DE             ; 1:11      _zx48bc_to_f
    push HL             ; 1:11      _zx48bc_to_f
    call 0x2D2B         ; 3:17      _zx48bc_to_f   {call ZX ROM stack BC routine}
    pop  HL             ; 1:10      _zx48bc_to_f
    pop  DE             ; 1:10      _zx48bc_to_f
    ret                 ; 1:10      _zx48bc_to_f
}){}dnl
dnl
dnl
ifdef({USE_ZX48S_TO_F},{define({USE_ZX48BBC_TO_F},{})
_ZX48S_TO_F:            ;           _zx48s>f   ( num ret . de hl -- ret . num de )
    ld    B, H          ; 1:4       _zx48s>f
    ld    C, L          ; 1:4       _zx48s>f
    pop  HL             ; 1:10      _zx48s>f   ( num . de ret )
    ex  (SP),HL         ; 1:19      _zx48s>f   ( ret . de num )
    ex   DE, HL         ; 1:4       _zx48s>f   ( ret . num de )
    ; fall to _zx48bbc_to_f
}){}dnl
dnl
ifdef({USE_ZX48BBC_TO_F},{define({USE_ZX48CFBC_TO_F},{})
_ZX48BBC_TO_F:          ;[2:8]      _zx48bbc_to_f
    ld    A, B          ; 1:4       _zx48bbc_to_f
    add   A, A          ; 1:4       _zx48bbc_to_f
    ; fall to _zx48cfbc_to_f
}){}dnl
dnl
ifdef({USE_ZX48CFBC_TO_F},{
if 1
_ZX48CFBC_TO_F:        ;[14:200]    _zx48cfbc_to_f
    sbc   A, A          ; 1:4       _zx48cfbc_to_f   0x00 or 0xff
    push HL             ; 1:11      _zx48cfbc_to_f
    push DE             ; 1:11      _zx48cfbc_to_f
    ld    E, A          ; 1:4       _zx48cfbc_to_f
    ld    D, C          ; 1:4       _zx48cfbc_to_f
    ld    C, B          ; 1:4       _zx48cfbc_to_f
    xor   A             ; 1:4       _zx48cfbc_to_f
    ld    B, A          ; 1:4       _zx48cfbc_to_f
    call 0x2ABB         ; 3:124     _zx48cfbc_to_f   new float = a,e,d,c,b = 0,0-sign,lo,hi,0
    pop  DE             ; 1:10      _zx48cfbc_to_f
else
_ZX48CFBC_TO_F:        ;[22:138]    _zx48cfbc_to_f
    sbc   A, A          ; 1:4       _zx48cfbc_to_f   0x00 or 0xff
    push HL             ; 1:11      _zx48cfbc_to_f
    ld   HL,(0x5C65)    ; 3:16      _zx48cfbc_to_f   {load STKEND}
    ld  (HL),0x00       ; 2:10      _zx48cfbc_to_f
    inc  HL             ; 1:6       _zx48cfbc_to_f
    ld  (HL), A         ; 1:7       _zx48cfbc_to_f
    inc  HL             ; 1:6       _zx48cfbc_to_f
    ld  (HL), C         ; 1:7       _zx48cfbc_to_f
    inc  HL             ; 1:6       _zx48cfbc_to_f
    ld  (HL), B         ; 1:7       _zx48cfbc_to_f
    inc  HL             ; 1:6       _zx48cfbc_to_f
    ld  (HL),0x00       ; 2:10      _zx48cfbc_to_f
    inc  HL             ; 1:6       _zx48cfbc_to_f
    ld  (0x5C65),HL     ; 3:16      _zx48cfbc_to_f   {save STKEND+5}
endif
    pop  HL             ; 1:10      _zx48cfbc_to_f
    ret                 ; 1:10      _zx48cfbc_to_f
}){}dnl
dnl
dnl
ifdef({USE_ZX48D_TO_F},{define({USE_DNEGATE},{})
_ZX48D_TO_F:            ;           _zx48d>f   ( num2 num1 ret . de hl -- ret . num2 num1 )
    ld    A, D          ; 1:4       _zx48d>f
    or    E             ; 1:4       _zx48d>f
    or    H             ; 1:4       _zx48d>f
    or    L             ; 1:4       _zx48d>f
    jr    z, _ZX48Z_TO_F; 2:7/12    _zx48d>f   zero?
    ld    A, 0x7F       ; 2:7       _zx48d>f
    or    D             ; 1:4       _zx48d>f
    push AF             ; 1:11      _zx48d>f   save sign 0x7f or 0xff
    call  m, NEGATE_32  ; 3:17      _zx48d>f
    ld    B, 0xA0       ; 2:7       _zx48d>f
    jp    m, $+12       ; 3:10      _zx48d>f   0x80000000
    
    dec   B             ; 1:4       _zx48d>f   exp--
    add  HL, HL         ; 1:11      _zx48d>f
    rl    E             ; 2:8       _zx48d>f
    rl    D             ; 2:8       _zx48d>f
    jp    p, $-6        ; 3:10      _zx48d>f   wait for sign

    pop  AF             ; 1:11      _zx48d>f   load sign 0x7f or 0xff
    and   D             ; 1:4       _zx48d>f
    ld    D, E          ; 1:4       _zx48d>f
    ld    E, A          ; 1:4       _zx48d>f   swap D and E
    ld    A, B          ; 1:4       _zx48d>f   exp
_ZX48Z_TO_F:            ;           _zx48d>f   zero entry
    ld    B, L          ; 1:4       _zx48d>f
    ld    C, H          ; 1:4       _zx48d>f
    call 0x2ABB         ; 3:124     _zx48d>f   new float = a,e,d,c,b
    pop  BC             ; 1:10      _zx48d>f   ret
    pop  HL             ; 1:10      _zx48d>f
    pop  DE             ; 1:10      _zx48d>f
    push BC             ; 1:10      _zx48d>f   ret
    ret                 ; 1:10      _zx48d>f
}){}dnl
dnl
dnl
dnl
ifdef({USE_ZX48FDOT},{
_ZX48FDOT:
    push DE             ; 1:11      _zx48fdot
    push HL             ; 1:11      _zx48fdot
    call 0x35bf         ; 3:17      _zx48fdot   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    push HL             ; 1:11      _zx48fdot
    call 0x2de3         ; 3:17      _zx48fdot   {call ZX ROM print a floating-point number routine}
    pop  HL             ; 1:10      _zx48fdot
    ld  (0x5C65),HL     ; 3:16      _zx48fdot   {save STKEND}
    ld    A, ' '        ; 2:7       _zx48fdot   {putchar Pollutes: AF, DE', BC'}
    rst  0x10           ; 1:11      _zx48fdot   {putchar with ZX 48K ROM in, this will print char in A}
    pop  HL             ; 1:10      _zx48fdot
    pop  DE             ; 1:10      _zx48fdot
    ret                 ; 1:10      _zx48fdot
}){}dnl
dnl
dnl
ifdef({USE_ZX48FHEXDOT},{
_ZX48FHEX_A:
    push AF             ; 1:11      _zx48fhexdot
    rra                 ; 1:4       _zx48fhexdot
    rra                 ; 1:4       _zx48fhexdot
    rra                 ; 1:4       _zx48fhexdot
    rra                 ; 1:4       _zx48fhexdot
    call _ZX48FHEX_LO   ; 3:17      _zx48fhexdot
    pop  AF             ; 1:10      _zx48fhexdot
    ; fall

;  In: A = number
; Out: (A & $0F) => '0'..'9','A'..'F'
_ZX48FHEX_LO:
    or   0xF0           ; 2:7       _zx48fhexdot   reset H flag
    daa                 ; 1:4       _zx48fhexdot   $F0..$F9 + $60 => $50..$59; $FA..$FF + $66 => $60..$65
    add   A, 0xA0       ; 2:7       _zx48fhexdot   $F0..$F9, $100..$105
    adc   A, 0x40       ; 2:7       _zx48fhexdot   $30..$39, $41..$46   = '0'..'9', 'A'..'F'
    rst  0x10           ; 1:11      _zx48fhexdot   {putchar with ZX 48K ROM in, this will print char in A}
    ret                 ; 1:10      _zx48fhexdot

_ZX48FHEXDOT:
    push HL             ; 1:11      _zx48fhexdot
    ld   HL,(0x5C65)    ; 3:16      _zx48fhexdot   {HL= stkend}
    ld   BC, 0xfffb     ; 3:10      _zx48fhexdot
    add  HL, BC         ; 1:11      _zx48fhexdot
    ld    B, 0x05       ; 2:7       _zx48fhexdot
    jr   $+5            ; 2:12      _zx48fhexdot
    ld    A, ','        ; 2:7       _zx48fhexdot
    rst  0x10           ; 1:11      _zx48fhexdot   {putchar with ZX 48K ROM in, this will print char in A}
    ld    A,(HL)        ; 1:7       _zx48fhexdot
    inc  HL             ; 1:6       _zx48fhexdot
    call _ZX48FHEX_A    ; 3:17      _zx48fhexdot
    djnz $-8            ; 2:8/13    _zx48fhexdot
    ld    A, ' '        ; 2:7       _zx48fhexdot
    rst  0x10           ; 1:11      _zx48fhexdot   {putchar with ZX 48K ROM in, this will print char in A}
    pop  HL             ; 1:10      _zx48fhexdot
    ret                 ; 1:10      _zx48fhexdot
}){}dnl
dnl
dnl
ifdef({USE_ZX48FSWAP},{
_ZX48FSWAP:
    push DE             ; 1:11      _zx48fswap
    push HL             ; 1:11      _zx48fswap
if 1
if 1
    rst 0x28            ; 1:11      Use the calculator
    db  0x01            ; 1:        calc-exchange
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
else
    call 0x35bf         ; 3:17      _zx48fswap   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    call 0x35c2         ; 3:17      _zx48fswap   {call ZX ROM            DE= HL    , HL = HL-5}
    call 0x343C         ; 3:17      _zx48fswap   {call ZX ROM exchange rutine}
endif
else
    call 0x35bf         ; 3:17      _zx48fswap   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    ld    B,0x05        ; 2:7       _zx48fswap
    dec  DE             ; 1:6       _zx48fswap
    dec  HL             ; 1:6       _zx48fswap
    ld    A,(DE)        ; 1:7       _zx48fswap
    ld    C,(HL)        ; 1:7       _zx48fswap
    ld  (HL),A          ; 1:7       _zx48fswap
    ld    A, C          ; 1:4       _zx48fswap
    ld  (DE),A          ; 1:7       _zx48fswap
    djnz $-7            ; 2:8/13    _zx48fswap
endif
    pop  HL             ; 1:10      _zx48fswap
    pop  DE             ; 1:10      _zx48fswap
    ret                 ; 1:10      _zx48fswap
}){}dnl
dnl
dnl
ifdef({USE_ZX48FDROP},{
_ZX48FDROP:
    push DE             ; 1:11      _zx48fdrop
    push HL             ; 1:11      _zx48fdrop
    rst 0x28            ; 1:11      Use the calculator
    db  0x02            ; 1:        calc-delete
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fdrop
    pop  DE             ; 1:10      _zx48fdrop
    ret                 ; 1:10      _zx48fdrop
}){}dnl
dnl
dnl
ifdef({USE_ZX48FSUB},{
_ZX48FSUB:
    push DE             ; 1:11      _zx48fsub
    push HL             ; 1:11      _zx48fsub
    rst 0x28            ; 1:11      Use the calculator
    db  0x03            ; 1:        calc-sub
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fsub
    pop  DE             ; 1:10      _zx48fsub
    ret                 ; 1:10      _zx48fsub
}){}dnl
dnl
dnl
ifdef({USE_ZX48FMUL},{
_ZX48FMUL:
    push DE             ; 1:11      _zx48fmul
    push HL             ; 1:11      _zx48fmul
if 1
    rst 0x28            ; 1:11      Use the calculator
    db  0x04            ; 1:        calc-mul
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC', DE'(=DE)}
else
    call 0x35bf         ; 3:17      _zx48fmul   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    ld  (0x5C65),HL     ; 3:16      _zx48fmul   {save STKEND}
    call 0x35c2         ; 3:17      _zx48fmul   {call ZX ROM            DE= HL    , HL = HL-5}
    call 0x30ca         ; 3:17      _zx48fmul   {call ZX ROM fmul, adr_HL = adr_DE * adr_HL}
endif
    pop  HL             ; 1:10      _zx48fmul
    pop  DE             ; 1:10      _zx48fmul
    ret                 ; 1:10      _zx48fmul
}){}dnl
dnl
dnl
ifdef({USE_ZX48FDIV},{
_ZX48FDIV:
    push DE             ; 1:11      _zx48fdiv
    push HL             ; 1:11      _zx48fdiv
if 1
    rst 0x28            ; 1:11      Use the calculator
    db  0x05            ; 1:        calc-div
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC', DE'(=DE)}
else
    call 0x35bf         ; 3:17      _zx48fdiv   {call ZX ROM stk-pntrs, DE= stkend, HL = DE-5}
    ld  (0x5C65),HL     ; 3:16      _zx48fdiv   {save STKEND}
    call 0x35c2         ; 3:17      _zx48fdiv   {call ZX ROM            DE= HL    , HL = HL-5}
    call 0x31af         ; 3:17      _zx48fdiv   {call ZX ROM fdiv}
endif
    pop  HL             ; 1:10      _zx48fdiv
    pop  DE             ; 1:10      _zx48fdiv
    ret                 ; 1:10      _zx48fdiv
}){}dnl
dnl
dnl
ifdef({USE_ZX48FMULMUL},{
_ZX48FMULMUL:
    push DE             ; 1:11      _zx48fmulmul
    push HL             ; 1:11      _zx48fmulmul
    rst 0x28            ; 1:11      Use the calculator
    db  0x06            ; 1:        calc-to_power
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fmulmul
    pop  DE             ; 1:10      _zx48fmulmul
    ret                 ; 1:10      _zx48fmulmul
}){}dnl
dnl
dnl
ifdef({USE_ZX48FCOMPARE},{
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
_ZX48FCOMPARE:
    push DE             ; 1:11      _zx48fcompare
    push HL             ; 1:11      _zx48fcompare
if 1
    rst 0x28            ; 1:11      Use the calculator
    db  0x0D            ; 1:        calc-less   Important is what the register B contains
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
else
    rst 0x28            ; 1:11      Use the calculator
    db  0x3B            ; 1:        fp_calc_2: (perform the actual operation)
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
endif
    pop  HL             ; 1:10      _zx48fcompare
    pop  DE             ; 1:10      _zx48fcompare
    ret                 ; 1:10      _zx48fcompare
}){}dnl
dnl
dnl
ifdef({USE_ZX48F0EQ},{
_ZX48F0EQ:
    ex   DE, HL         ; 1:4       _zx48f0=   ( ret . de hl -- de ret . hl flag )
    ex  (SP),HL         ; 1:19      _zx48f0=
    push HL             ; 1:11      _zx48f0=   ret
    ld   HL,(0x5C65)    ; 3:16      _zx48f0=   {load STKEND}
    ld    B, 0x05       ; 2:7       _zx48f0=
    xor   A             ; 1:4       _zx48f0=
    dec  HL             ; 1:6       _zx48f0=
    or  (HL)            ; 1:7       _zx48f0=
    djnz $-2            ; 2:8/13    _zx48f0=
    ld  (0x5C65), HL    ; 3:16      _zx48f0=   {save STKEND-5}
    sub  0x01           ; 2:7       _zx48f0=
    sbc  HL, HL         ; 2:15      _zx48f0=
    ret                 ; 1:10      _zx48f0=
}){}dnl
dnl
dnl
ifdef({USE_ZX48F0LT},{
_ZX48F0LT:
    ex   DE, HL         ; 1:4       _zx48f0<   ( ret . de hl -- de ret . hl flag )
    ex  (SP),HL         ; 1:19      _zx48f0<
    push HL             ; 1:11      _zx48f0<   ret
    ld   HL,(0x5C65)    ; 3:16      _zx48f0<   {load STKEND}
    ld    B, 0x05       ; 2:7       _zx48f0<
    ld    A,(HL)        ; 1:7       _zx48f0<
    dec  HL             ; 1:6       _zx48f0<
    djnz $-2            ; 2:8/13    _zx48f0<
    ld  (0x5C65), HL    ; 3:16      _zx48f0<   {save STKEND-5}
    add   A, A          ; 2:7       _zx48f0<
    sbc  HL, HL         ; 2:15      _zx48f0<
    ret                 ; 1:10      _zx48f0<
}){}dnl
dnl
dnl
ifdef({USE_ZX48FADD},{
_ZX48FADD:
    push DE             ; 1:11      _zx48fadd
    push HL             ; 1:11      _zx48fadd
    rst 0x28            ; 1:11      Use the calculator
    db  0x0F            ; 1:        calc-add
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fadd
    pop  DE             ; 1:10      _zx48fadd
    ret                 ; 1:10      _zx48fadd
}){}dnl
dnl
dnl
ifdef({USE_ZX48FSIN},{
_ZX48FSIN:
    push DE             ; 1:11      _zx48fsin
    push HL             ; 1:11      _zx48fsin
    rst 0x28            ; 1:11      Use the calculator
    db  0x1F            ; 1:        calc-sin
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fsin
    pop  DE             ; 1:10      _zx48fsin
    ret                 ; 1:10      _zx48fsin
}){}dnl
dnl
dnl
ifdef({USE_ZX48FCOS},{
_ZX48FCOS:
    push DE             ; 1:11      _zx48fcos
    push HL             ; 1:11      _zx48fcos
    rst 0x28            ; 1:11      Use the calculator
    db  0x20            ; 1:        calc-cos
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fcos
    pop  DE             ; 1:10      _zx48fcos
    ret                 ; 1:10      _zx48fcos
}){}dnl
dnl
dnl
ifdef({USE_ZX48FTAN},{
_ZX48FTAN:
    push DE             ; 1:11      _zx48ftan
    push HL             ; 1:11      _zx48ftan
    rst 0x28            ; 1:11      Use the calculator
    db  0x21            ; 1:        calc-tan
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48ftan
    pop  DE             ; 1:10      _zx48ftan
    ret                 ; 1:10      _zx48ftan
}){}dnl
dnl
dnl
ifdef({USE_ZX48FASIN},{
_ZX48FASIN:
    push DE             ; 1:11      _zx48fasin
    push HL             ; 1:11      _zx48fasin
    rst 0x28            ; 1:11      Use the calculator
    db  0x22            ; 1:        calc-arcsin
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fasin
    pop  DE             ; 1:10      _zx48fasin
    ret                 ; 1:10      _zx48fasin
}){}dnl
dnl
dnl
ifdef({USE_ZX48FACOS},{
_ZX48FACOS:
    push DE             ; 1:11      _zx48facos
    push HL             ; 1:11      _zx48facos
    rst 0x28            ; 1:11      Use the calculator
    db  0x23            ; 1:        calc-arccos
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48facos
    pop  DE             ; 1:10      _zx48facos
    ret                 ; 1:10      _zx48facos
}){}dnl
dnl
dnl
ifdef({USE_ZX48FATAN},{
_ZX48FATAN:
    push DE             ; 1:11      _zx48fatan
    push HL             ; 1:11      _zx48fatan
    rst 0x28            ; 1:11      Use the calculator
    db  0x24            ; 1:        calc-arctan
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fatan
    pop  DE             ; 1:10      _zx48fatan
    ret                 ; 1:10      _zx48fatan
}){}dnl
dnl
dnl
ifdef({USE_ZX48FLN},{
_ZX48FLN:
    push DE             ; 1:11      _zx48fln
    push HL             ; 1:11      _zx48fln
    rst 0x28            ; 1:11      Use the calculator
    db  0x25            ; 1:        calc-ln
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fln
    pop  DE             ; 1:10      _zx48fln
    ret                 ; 1:10      _zx48fln
}){}dnl
dnl
dnl
ifdef({USE_ZX48FEXP},{
_ZX48FEXP:
    push DE             ; 1:11      _zx48fexp
    push HL             ; 1:11      _zx48fexp
    rst 0x28            ; 1:11      Use the calculator
    db  0x26            ; 1:        calc-exp
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fexp
    pop  DE             ; 1:10      _zx48fexp
    ret                 ; 1:10      _zx48fexp
}){}dnl
dnl
dnl
ifdef({USE_ZX48FSQRT},{
_ZX48FSQRT:
    push DE             ; 1:11      _zx48fsqrt
    push HL             ; 1:11      _zx48fsqrt
    rst 0x28            ; 1:11      Use the calculator
    db  0x28            ; 1:        calc-sqrt
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fsqrt
    pop  DE             ; 1:10      _zx48fsqrt
    ret                 ; 1:10      _zx48fsqrt
}){}dnl
dnl
dnl
ifdef({USE_ZX48FABS},{
_ZX48FABS:
    push DE             ; 1:11      _zx48fabs
    push HL             ; 1:11      _zx48fabs
    rst 0x28            ; 1:11      Use the calculator
    db  0x2A            ; 1:        calc-abs
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fabs
    pop  DE             ; 1:10      _zx48fabs
    ret                 ; 1:10      _zx48fabs
}){}dnl
dnl
dnl
ifdef({USE_ZX48FNEGATE},{
_ZX48FNEGATE:
    push DE             ; 1:11      _zx48fnegate
    push HL             ; 1:11      _zx48fnegate
    rst 0x28            ; 1:11      Use the calculator
    db  0x1B            ; 1:        calc-negate
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48fnegate
    pop  DE             ; 1:10      _zx48fnegate
    ret                 ; 1:10      _zx48fnegate
}){}dnl
dnl
dnl
ifdef({USE_ZX48FINT},{
_ZX48FINT:
    push DE             ; 1:11      _zx48fint
    push HL             ; 1:11      _zx48fint
    call 0x36AF         ; 3:17      _zx48fint   {call ZX ROM int}
    pop  HL             ; 1:10      _zx48fint
    pop  DE             ; 1:10      _zx48fint
    ret                 ; 1:10      _zx48fint
}){}dnl
dnl
dnl
ifdef({USE_ZX48FADDR},{
_ZX48FADDR:
    push DE             ; 1:11      _zx48faddr
    ex   DE, HL         ; 1:4       _zx48faddr
    ld   HL,(0x5C65)    ; 3:16      _zx48faddr   {HL= stkend}
    UDOTZXROM
    ld    A, 0x0D       ; 2:7       _zx48faddr-cr   {Pollutes: AF, DE', BC'}
    rst  0x10           ; 1:11      _zx48faddr-cr   {with 48K ROM in, this will print char in A}
    ret                 ; 1:10      _zx48faddr
}){}dnl
dnl
dnl
ifdef({USE_ZX48FDUP},{
_ZX48FDUP:
    push DE             ; 1:11      _zx48fdup
    push HL             ; 1:11      _zx48fdup
    rst 0x28            ; 1:11      Use the calculator
    db  0x31            ; 1:        calc-duplicate
    db  0x38            ; 1:        calc-end
    pop  HL             ; 1:10      _zx48fdup
    pop  DE             ; 1:10      _zx48fdup
    ret                 ; 1:10      _zx48fdup
}){}dnl
dnl
dnl
ifdef({USE_ZX48FOVER},{
_ZX48FOVER:
    push DE             ; 1:11      _zx48fover
    push HL             ; 1:11      _zx48fover
if 1
    ld   HL,(0x5C65)    ; 3:16      _zx48fover   {load STKEND}
    ex   DE, HL         ; 1:4       _zx48fover
    ld   HL,0xFFF6      ; 3:10      _zx48fover   -10
    add  HL, DE         ; 1:11      _zx48fover
    ld   BC,0x0005      ; 3:10      _zx48fover   5
    ldir                ; 2:21/16   _zx48fover
    ld  (0x5C65),DE     ; 4:20      _zx48fover   {save STKEND+5}
else
    ld   HL,(0x5C65)    ; 3:16      _zx48fover   {load STKEND}
    ex   DE, HL         ; 1:4       _zx48fover
    ld   HL,0xFFF6      ; 3:10      _zx48fover   -10
    add  HL, DE         ; 1:11      _zx48fover
    call 0x33c0         ; 3:17      _zx48fover
    ld  (0x5C65),DE     ; 4:20      _zx48fover   {save STKEND+5}
endif
    pop  HL             ; 1:10      _zx48fover
    pop  DE             ; 1:10      _zx48fover
    ret                 ; 1:10      _zx48fover
}){}dnl
dnl
dnl
ifdef({USE_ZX48FROT},{
_ZX48FROT:              ;           _zx48frot   ( F: r1 r2 r3 -- r2 r3 r1 )
    push DE             ; 1:11      _zx48frot
    push HL             ; 1:11      _zx48frot
    ld   HL,(0x5C65)    ; 3:16      _zx48frot   {load STKEND}
    ex   DE, HL         ; 1:4       _zx48frot   {DE = STKEND}
    ld   HL,0xFFF1      ; 3:10      _zx48frot   -15
    add  HL, DE         ; 1:11      _zx48frot   {HL = STKEND - 15}
    push HL             ; 1:11      _zx48frot   {STKEND-15}
    call 0x33C0         ; 3:17      _zx48frot   (DE++) = (HL++), BC = 0   ( F: r1 r2 r3    -- r1 r2 r3 r1 )
    pop  DE             ; 1:10      _zx48frot   {DE = STKEND - 15}
    ld   C,0x0F         ; 2:7       _zx48frot   {BC = 15}
    ldir                ; 2:21/16   _zx48frot   (DE++) = (HL++)   ( F: r1 r2 r3 r1 -- r2 r3 r1 )
    pop  HL             ; 1:10      _zx48frot
    pop  DE             ; 1:10      _zx48frot
    ret                 ; 1:10      _zx48frot
}){}dnl
dnl
dnl
dnl
dnl
dnl
