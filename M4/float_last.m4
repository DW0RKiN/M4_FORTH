include(M4PATH{}float/fmod.m4){}dnl
include(M4PATH{}float/ftrunc.m4){}dnl
include(M4PATH{}float/fsqrt.m4){}dnl
include(M4PATH{}float/fwld.m4){}dnl
include(M4PATH{}float/fwst.m4){}dnl
include(M4PATH{}float/faddsub.m4){}dnl
include(M4PATH{}float/fln.m4){}dnl
include(M4PATH{}float/fexp.m4){}dnl
include(M4PATH{}float/fdivmul.m4){}dnl
include(M4PATH{}float/fsin.m4){}dnl
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
ifdef( {USE_fSin},{include(M4PATH{}float/fsin.tab)})dnl
ifdef( {USE_fExp},{include(M4PATH{}float/fexp.tab)})dnl
ifdef( {USE_fMul},{include(M4PATH{}float/fmul.tab)})dnl
ifdef( {USE_fDiv},{include(M4PATH{}float/fdiv.tab)})dnl
ifdef({USE_fSqrt},{include(M4PATH{}float/fsqrt.tab)})dnl
ifdef(  {USE_fLn},{include(M4PATH{}float/fln.tab)})dnl
dnl
dnl
dnl
