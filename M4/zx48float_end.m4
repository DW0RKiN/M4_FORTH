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
    ld (0x5C65),HL      ; 3:16      _zx48fstore   {save STKEND}
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
ifdef({USE_ZX48FPUSH},{
_ZX48FPUSH:
    push DE             ; 1:11      _zx48fpush   ( c ret . b a -- ret . c b )
    ld    B, H          ; 1:4       _zx48fpush
    ld    C, L          ; 1:4       _zx48fpush
    call 0x2D2B         ; 3:17      _zx48fpush   {call ZX ROM stack BC routine}
    pop  HL             ; 1:10      _zx48fpush
    pop  BC             ; 1:10      _zx48fpush   ret
    pop  DE             ; 1:10      _zx48fpush
    push BC             ; 1:11      _zx48fpush   ret
    ret                 ; 1:10      _zx48fpush
}){}dnl
dnl
dnl
ifdef({USE_BC_ZX48FPUSH},{
_BC_ZX48FPUSH:
    push DE             ; 1:11      _bc_zx48fpush
    push HL             ; 1:11      _bc_zx48fpush
    call 0x2D2B         ; 3:17      _bc_zx48fpush   {call ZX ROM stack BC routine}
    pop  HL             ; 1:10      _bc_zx48fpush
    pop  DE             ; 1:10      _bc_zx48fpush
    ret                 ; 1:10      _bc_zx48fpush
}){}dnl
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
    ld (0x5C65),HL      ; 3:16      _zx48fdot   {save STKEND}
    pop  HL             ; 1:10      _zx48fdot
    pop  DE             ; 1:10      _zx48fdot
    ret                 ; 1:10      _zx48fdot
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
    ld (0x5C65),HL      ; 3:16      _zx48fmul   {save STKEND}
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
    ld (0x5C65),HL      ; 3:16      _zx48fdiv   {save STKEND}
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
ifdef({USE_ZX48FLT},{
_ZX48FLT:
    push DE             ; 1:11      _zx48flt
    push HL             ; 1:11      _zx48flt
    rst 0x28            ; 1:11      Use the calculator
    db  0x0D            ; 1:        calc-less
    db  0x38            ; 1:        calc-end    {Pollutes: AF, BC, BC', DE'(=DE)}
    pop  HL             ; 1:10      _zx48flt
    pop  DE             ; 1:10      _zx48flt
    ret                 ; 1:10      _zx48flt
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
    ld   HL,(0x5C65)    ; 3:17      _zx48faddr   {HL= stkend}
    UDOTZXROM
    ld    A, 0x0D       ; 2:7       _zx48faddr-cr   {Pollutes: AF, DE', BC'}
    rst   0x10          ; 1:11      _zx48faddr-cr   {with 48K ROM in, this will print char in A}
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
dnl
dnl
dnl
