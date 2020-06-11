sinclude(./float/fmod.m4){}dnl
sinclude(./float/ftrunc.m4){}dnl
sinclude(./float/fsqrt.m4){}dnl
sinclude(./float/fwld.m4){}dnl
sinclude(./float/fwst.m4){}dnl
sinclude(./float/faddsub.m4){}dnl
sinclude(./float/fln.m4){}dnl
sinclude(./float/fexp.m4){}dnl
sinclude(./float/fdivmul.m4){}dnl
sinclude(./float/fsin.m4){}dnl
dnl
sinclude(./M4/float/fmod.m4){}dnl
sinclude(./M4/float/ftrunc.m4){}dnl
sinclude(./M4/float/fsqrt.m4){}dnl
sinclude(./M4/float/fwld.m4){}dnl
sinclude(./M4/float/fwst.m4){}dnl
sinclude(./M4/float/faddsub.m4){}dnl
sinclude(./M4/float/fln.m4){}dnl
sinclude(./M4/float/fexp.m4){}dnl
sinclude(./M4/float/fdivmul.m4){}dnl
sinclude(./M4/float/fsin.m4){}dnl
dnl
sinclude(../M4/float/fmod.m4){}dnl
sinclude(../M4/float/ftrunc.m4){}dnl
sinclude(../M4/float/fsqrt.m4){}dnl
sinclude(../M4/float/fwld.m4){}dnl
sinclude(../M4/float/fwst.m4){}dnl
sinclude(../M4/float/faddsub.m4){}dnl
sinclude(../M4/float/fln.m4){}dnl
sinclude(../M4/float/fexp.m4){}dnl
sinclude(../M4/float/fdivmul.m4){}dnl
sinclude(../M4/float/fsin.m4){}dnl
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
ifdef( {USE_fSin},{sinclude(./float/fsin.tab)})dnl
ifdef( {USE_fExp},{sinclude(./float/fexp.tab)})dnl
ifdef( {USE_fMul},{sinclude(./float/fmul.tab)})dnl
ifdef( {USE_fDiv},{sinclude(./float/fdiv.tab)})dnl
ifdef({USE_fSqrt},{sinclude(./float/fsqrt.tab)})dnl
ifdef(  {USE_fLn},{sinclude(./float/fln.tab)})dnl
dnl
ifdef( {USE_fSin},{sinclude(./M4/float/fsin.tab)})dnl
ifdef( {USE_fExp},{sinclude(./M4/float/fexp.tab)})dnl
ifdef( {USE_fMul},{sinclude(./M4/float/fmul.tab)})dnl
ifdef( {USE_fDiv},{sinclude(./M4/float/fdiv.tab)})dnl
ifdef({USE_fSqrt},{sinclude(./M4/float/fsqrt.tab)})dnl
ifdef(  {USE_fLn},{sinclude(./M4/float/fln.tab)})dnl
dnl
ifdef( {USE_fSin},{sinclude(../M4/float/fsin.tab)})dnl
ifdef( {USE_fExp},{sinclude(../M4/float/fexp.tab)})dnl
ifdef( {USE_fMul},{sinclude(../M4/float/fmul.tab)})dnl
ifdef( {USE_fDiv},{sinclude(../M4/float/fdiv.tab)})dnl
ifdef({USE_fSqrt},{sinclude(../M4/float/fsqrt.tab)})dnl
ifdef(  {USE_fLn},{sinclude(../M4/float/fln.tab)})dnl
dnl
dnl
dnl
