include(__pathfloat__{}{fwld.m4}){}dnl
include(__pathfloat__{}{fwst.m4}){}dnl
include(__pathfloat__{}{faddsub.m4}){}dnl
include(__pathfloat__{}{fdivmul.m4}){}dnl
dnl
ifdef({USE_fDot},{
fDot:
    push DE             ; 1:11

    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    ld    E, L          ; 1:4       mantisa
    rr    E             ; 2:8       bit 7 = sign
    ld   BC, 0x0000     ; 3:10
    ld    D, B          ; 1:4
    rr    D             ; 2:8       bit 7 = bit 0 L mantissa
    rrca                ; 1:4
    add   A, 0x41       ; 2:7       new exponent
    call 0x2AB6         ; 3:17      Ulozenie floating point cisla (A E D C B) v na vrchol zasobnika kalkulacky
    call 0x2DE3         ; 3:17      Vypis vrcholu zasobnika kalkukacky

    pop  DE             ; 1:10
    pop  HL             ; 1:10      ret
    ex  (SP),HL         ; 1:19
    ex   DE, HL         ; 1:4
    ret                 ; 1:10})dnl
dnl
dnl
ifdef({USE_fMul},{include(__pathfloat__{}{fmul.tab})})dnl
ifdef({USE_fDiv},{include(__pathfloat__{}{fdiv.tab})})dnl
dnl
dnl
