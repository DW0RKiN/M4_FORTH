dnl ## FLoat
dnl
define({carry_flow_warning},1){}dnl
include(M4PATH{}float_const.m4){}dnl
dnl
dnl
dnl # ( s1 -- f1 )
define({S2F},{dnl
__{}__ADD_TOKEN({__TOKEN_S2F},{s2f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_S2F},{dnl
__{}define({__INFO},{s2f}){}dnl

ifdef({USE_fIld},,define({USE_fIld},{}))dnl
    call fIld           ; 3:17      s>f}){}dnl
dnl
dnl
dnl # ( u1 -- f1 )
define({U2F},{dnl
__{}__ADD_TOKEN({__TOKEN_U2F},{u2f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_U2F},{dnl
__{}define({__INFO},{u2f}){}dnl

ifdef({USE_fWld},,define({USE_fWld},{}))dnl
    call fWld           ; 3:17      u>f}){}dnl
dnl
dnl
dnl # ( f1 -- s1 )
define({F2S},{dnl
__{}__ADD_TOKEN({__TOKEN_F2S},{f2s},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2S},{dnl
__{}define({__INFO},{f2s}){}dnl

ifdef({USE_fIst},,define({USE_fIst},{}))dnl
    call fIst           ; 3:17      f>s}){}dnl
dnl
dnl
dnl # ( f1 -- u1 )
define({F2U},{dnl
__{}__ADD_TOKEN({__TOKEN_F2U},{f2u},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2U},{dnl
__{}define({__INFO},{f2u}){}dnl

ifdef({USE_fWst},,define({USE_fWst},{}))dnl
    call fWst           ; 3:17      f>u}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 + f1
define({FADD},{dnl
__{}__ADD_TOKEN({__TOKEN_FADD},{fadd},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FADD},{dnl
__{}define({__INFO},{fadd}){}dnl

ifdef({USE_fAdd},,define({USE_fAdd},{}))dnl
    call fAdd           ; 3:17      f+
    pop  DE             ; 1:10      f+}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 + f1
define({FSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_FSUB},{fsub},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FSUB},{dnl
__{}define({__INFO},{fsub}){}dnl

ifdef({USE_fSub},,define({USE_fSub},{}))dnl
    call fSub           ; 3:17      f-
    pop  DE             ; 1:10      f-}){}dnl
dnl
dnl
dnl # ( f1 -- -f1 )
define({FNEGATE},{dnl
__{}__ADD_TOKEN({__TOKEN_FNEGATE},{fnegate},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FNEGATE},{dnl
__{}define({__INFO},{fnegate}){}dnl

    ld    A, H          ; 1:4       fnegate
    xor  0x80           ; 2:7       fnegate
    ld    H, A          ; 1:4       fnegate}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
define({FABS},{dnl
__{}__ADD_TOKEN({__TOKEN_FABS},{fabs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FABS},{dnl
__{}define({__INFO},{fabs}){}dnl

    res   7, H          ; 2:8       fabs}){}dnl
dnl
dnl
dnl # ( f1 -- )
define({FDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_FDOT},{fdot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FDOT},{dnl
__{}define({__INFO},{fdot}){}dnl

ifdef({USE_fDot},,define({USE_fDot},{}))dnl
    call fDot           ; 3:17      f.}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 * f1
define({FMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_FMUL},{fmul},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FMUL},{dnl
__{}define({__INFO},{fmul}){}dnl

ifdef({USE_fMul},,define({USE_fMul},{}))dnl
    ld    B, H          ; 1:4       f*
    ld    C, L          ; 1:4       f*
    call fMul           ; 3:17      f* HL = BC*DE
    pop  DE             ; 1:10      f*}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 / f1
define({FDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_FDIV},{fdiv},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FDIV},{dnl
__{}define({__INFO},{fdiv}){}dnl

ifdef({USE_fDiv},,define({USE_fDiv},{}))dnl
    ld    B, D          ; 1:4       f/
    ld    C, E          ; 1:4       f/
    call fDiv           ; 3:17      f/ HL = BC/HL
    pop  DE             ; 1:10      f/}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 / f1
define({FSQRT},{dnl
__{}__ADD_TOKEN({__TOKEN_FSQRT},{fsqrt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FSQRT},{dnl
__{}define({__INFO},{fsqrt}){}dnl

ifdef({USE_fSqrt},,define({USE_fSqrt},{}))dnl
    call fSqrt          ; 3:17      fsqrt}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # "round towards zero"
define({FTRUNC},{dnl
__{}__ADD_TOKEN({__TOKEN_FTRUNC},{ftrunc},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FTRUNC},{dnl
__{}define({__INFO},{ftrunc}){}dnl

ifdef({USE_fTrunc},,define({USE_fTrunc},{}))dnl
    call fTrunc         ; 3:17      ftrunc}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = f1 % 1.0
define({FFRAC},{dnl
__{}__ADD_TOKEN({__TOKEN_FFRAC},{ffrac},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FFRAC},{dnl
__{}define({__INFO},{ffrac}){}dnl

ifdef({USE_fFrac},,define({USE_fFrac},{}))dnl
    call fFrac          ; 3:17      ffrac}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = e^f1
define({FEXP},{dnl
__{}__ADD_TOKEN({__TOKEN_FEXP},{fexp},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FEXP},{dnl
__{}define({__INFO},{fexp}){}dnl

ifdef({USE_fExp},,define({USE_fExp},{}))dnl
    push DE             ; 1:11      fexp
    call fExp           ; 3:17      fexp HL = e^HL
    pop  DE             ; 1:10      fexp}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = ln(f1)
define({FLN},{dnl
__{}__ADD_TOKEN({__TOKEN_FLN},{fln},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FLN},{dnl
__{}define({__INFO},{fln}){}dnl

ifdef({USE_fLn},,define({USE_fLn},{}))dnl
    push DE             ; 1:11      fln
    call fLn            ; 3:17      fln HL = ln(HL)
    pop  DE             ; 1:10      fln}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = sin(f1)
define({FSIN},{dnl
__{}__ADD_TOKEN({__TOKEN_FSIN},{fsin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FSIN},{dnl
__{}define({__INFO},{fsin}){}dnl

ifdef({USE_fSin},,define({USE_fSin},{}))dnl
    push DE             ; 1:11      fsin
    call fSin           ; 3:17      fsin HL = sin(HL)
    pop  DE             ; 1:10      fsin}){}dnl
dnl
dnl
dnl # ( f1 f2 -- f3 )
dnl # f3 = f1 % f2
define({FMOD},{dnl
__{}__ADD_TOKEN({__TOKEN_FMOD},{fmod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FMOD},{dnl
__{}define({__INFO},{fmod}){}dnl

ifdef({USE_fMod},,define({USE_fMod},{}))dnl
    ld    B, D          ; 1:4       fmod
    ld    C, E          ; 1:4       fmod
    call fMod           ; 3:17      fmod HL = BC % HL
    pop  DE             ; 1:10      fmod}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = f1 * 2.0
define({F2MUL},{dnl
__{}__ADD_TOKEN({__TOKEN_F2MUL},{f2mul},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2MUL},{dnl
__{}define({__INFO},{f2mul}){}dnl

    inc   H             ;  1:4      f2*
    .WARNING The exponent is not tested and may overflow!}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = f1 / 2.0
define({F2DIV},{dnl
__{}__ADD_TOKEN({__TOKEN_F2DIV},{f2div},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2DIV},{dnl
__{}define({__INFO},{f2div}){}dnl

    dec   H             ;  1:4      f2/
    .WARNING The exponent is not tested and may underflow!}){}dnl
dnl
dnl
dnl
