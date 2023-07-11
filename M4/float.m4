dnl ## FLoat
dnl
define({carry_flow_warning},1){}dnl
include(M4PATH{}float_const.m4){}dnl
dnl
dnl
dnl # ( s1 -- f1 )
define({S2F},{dnl
__{}__ADD_TOKEN({__TOKEN_S2F},{s>f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_S2F},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fIld})
    call fIld           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( u1 -- f1 )
define({U2F},{dnl
__{}__ADD_TOKEN({__TOKEN_U2F},{u>f},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_U2F},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fWld})
    call fWld           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- s1 )
define({F2S},{dnl
__{}__ADD_TOKEN({__TOKEN_F2S},{f>s},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2S},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fIst})
    call fIst           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- u1 )
define({F2U},{dnl
__{}__ADD_TOKEN({__TOKEN_F2U},{f>u},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2U},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fWst})
    call fWst           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 + f1
define({FADD},{dnl
__{}__ADD_TOKEN({__TOKEN_FADD},{f+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fAdd})
    call fAdd           ; 3:17      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 + f1
define({FSUB},{dnl
__{}__ADD_TOKEN({__TOKEN_FSUB},{f-},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FSUB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fSub})
    call fSub           ; 3:17      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- -f1 )
define({FNEGATE},{dnl
__{}__ADD_TOKEN({__TOKEN_FNEGATE},{fnegate},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FNEGATE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, H          ; 1:4       __INFO
    xor  0x80           ; 2:7       __INFO
    ld    H, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
define({FABS},{dnl
__{}__ADD_TOKEN({__TOKEN_FABS},{fabs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FABS},{dnl
__{}define({__INFO},__COMPILE_INFO)
    res   7, H          ; 2:8       __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- )
define({FDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_FDOT},{f.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FDOT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fDot})
    call fDot           ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 * f1
define({FMUL},{dnl
__{}__ADD_TOKEN({__TOKEN_FMUL},{f*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FMUL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fMul})
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO
    call fMul           ; 3:17      __INFO   HL = BC*DE
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 / f1
define({FDIV},{dnl
__{}__ADD_TOKEN({__TOKEN_FDIV},{f/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FDIV},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fDiv})
    ld    B, D          ; 1:4       __INFO
    ld    C, E          ; 1:4       __INFO
    call fDiv           ; 3:17      __INFO   HL = BC/HL
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f2 f1 -- f )
dnl # f = f2 / f1
define({FSQRT},{dnl
__{}__ADD_TOKEN({__TOKEN_FSQRT},{fsqrt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FSQRT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fSqrt})
    call fSqrt          ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # "round towards zero"
define({FTRUNC},{dnl
__{}__ADD_TOKEN({__TOKEN_FTRUNC},{ftrunc},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FTRUNC},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fTrunc})
    call fTrunc         ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( uf1 -- uf2 )
dnl # "round down to zero"
define({FTRUNC_ABS},{dnl
__{}__ADD_TOKEN({__TOKEN_FTRUNC_ABS},{ftrunc_abs},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FTRUNC_ABS},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fTrunc_abs})
    call fTrunc_abs     ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = f1 % 1.0
define({FFRAC},{dnl
__{}__ADD_TOKEN({__TOKEN_FFRAC},{ffrac},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FFRAC},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fFrac})
    call fFrac          ; 3:17      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = e^f1
define({FEXP},{dnl
__{}__ADD_TOKEN({__TOKEN_FEXP},{fexp},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FEXP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fExp})
    push DE             ; 1:11      __INFO
    call fExp           ; 3:17      __INFO   HL = e^HL
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = ln(f1)
define({FLN},{dnl
__{}__ADD_TOKEN({__TOKEN_FLN},{fln},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FLN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fLn})
    push DE             ; 1:11      __INFO
    call fLn            ; 3:17      __INFO   HL = ln(HL)
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = sin(f1)
define({FSIN},{dnl
__{}__ADD_TOKEN({__TOKEN_FSIN},{fsin},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FSIN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fSin})
    push DE             ; 1:11      __INFO
    call fSin           ; 3:17      __INFO   HL = sin(HL)
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 f2 -- f3 )
dnl # f3 = f1 % f2
define({FMOD},{dnl
__{}__ADD_TOKEN({__TOKEN_FMOD},{fmod},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FMOD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__def({USE_fMod})
    ld    B, D          ; 1:4       __INFO
    ld    C, E          ; 1:4       __INFO
    call fMod           ; 3:17      __INFO   HL = BC % HL
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = f1 * 2.0
define({F2MUL},{dnl
__{}__ADD_TOKEN({__TOKEN_F2MUL},{f2*},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2MUL},{dnl
__{}define({__INFO},__COMPILE_INFO)
    inc   H             ;  1:4      __INFO
    .WARNING The exponent is not tested and may overflow!}){}dnl
dnl
dnl
dnl # ( f1 -- f2 )
dnl # f2 = f1 / 2.0
define({F2DIV},{dnl
__{}__ADD_TOKEN({__TOKEN_F2DIV},{f2/},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_F2DIV},{dnl
__{}define({__INFO},__COMPILE_INFO)
    dec   H             ;  1:4      __INFO
    .WARNING The exponent is not tested and may underflow!}){}dnl
dnl
dnl
dnl
