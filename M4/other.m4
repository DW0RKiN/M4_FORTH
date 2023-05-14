dnl ## Other
dnl
dnl
dnl # ( -- )
dnl # Save shadow reg.
define({INIT},{dnl
__{}__ADD_TOKEN({__TOKEN_INIT},{init},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_INIT},{dnl
__{}define({__INFO},__COMPILE_INFO)
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      __INFO   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       __INFO   Upper screen
    call 0x1605         ; 3:17      __INFO   Open channel{}dnl
__{}ifdef({USE_FONT_5x8},{
__{}    ld  HL, PRINT_OUT   ; 3:10      __INFO
__{}    ld (CURCHL),HL      ; 3:16      __INFO
__{}    ld  HL, putchar     ; 3:10      __INFO
__{}    ld (PRINT_OUT),HL   ; 3:10      __INFO}){}dnl
__{}ifelse(ifdef({USE_FONT_5x8},1){}ifdef({USE_FONT_5x8_CALL},1),1,{
__{}  if 0
__{}    ld   HL, 0x0000     ; 3:10      __INFO
__{}    ld  (putchar_yx),HL ; 3:16      __INFO
__{}  else
__{}    ld   HL, 0x1821     ; 3:10      __INFO
__{}    ld   DE,(0x5C88)    ; 4:20      __INFO
__{}    or    A             ; 1:4       __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    ld    A, L          ; 1:4       __INFO   x
__{}    add   A, A          ; 1:4       __INFO   2*x
__{}    inc   A             ; 1:4       __INFO   2*2+1
__{}    add   A, A          ; 1:4       __INFO   4*x+2
__{}    add   A, A          ; 1:4       __INFO   8*x+4
__{}    ld    L, 0xFF       ; 2:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    sub 0x05            ; 2:7       __INFO
__{}    jr   nc, $-3        ; 2:7/12    __INFO
__{}    ld  (putchar_yx),HL ; 3:16      __INFO
__{}  endif}){}dnl
__{}ifelse($1,{},{
__{}__{}  .warning "Missing value for return address stack. The init() macro has no parameter!"
__{}__{}    ld   HL, 60000      ; 3:10      __INFO   Return address stack},
__{}__IS_NUM($1),0,{define({_TMP_INFO},__INFO   Return address stack = $1){}__LD_REG16({HL},$1)
__{}__{}  .warning "Return address stack must be at an odd address!"{}dnl
__{}__{}__CODE_16BIT},
__{}__HEX_HL(($1+0) & 1),0x0001,{
__{}__{}  .error "Return address stack must be at an odd address!"
__{}__{}    ld   HL, __HEX_HL($1)     ; 3:10      __INFO   Return address stack = $1},
__{}{
__{}__{}    ld   HL, __HEX_HL($1)     ; 3:10      __INFO   Return address stack = $1})
    exx                 ; 1:4       __INFO}){}dnl
dnl
dnl # ( -- )
dnl # Load shadow reg.
define({STOP},{dnl
__{}__ADD_TOKEN({__TOKEN_STOP},{stop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STOP},{dnl
__{}define({__INFO},__COMPILE_INFO)
Stop:                   ;           __INFO
    ld   SP, 0x0000     ; 3:10      __INFO   restoring the original SP value when the "bye" word is used{}dnl
__{}ifdef({USE_FONT_5x8_CALL},{
__{}  if 0
__{}    ld    A, 0x16       ; 2:7       __INFO   at y x
__{}    rst   0x10          ; 1:11      __INFO   putchar(reg A) with {ZX 48K ROM}
__{}    ld    A,(putchar_y) ; 3:13      __INFO
__{}    rst   0x10          ; 1:11      __INFO   putchar(reg A) with {ZX 48K ROM}
__{}    xor   A             ; 1:4       __INFO
__{}    rst   0x10          ; 1:11      __INFO   putchar(reg A) with {ZX 48K ROM}
__{}  else
__{}    ld   HL,(putchar_yx); 3:16
__{}    ld    A, 0x16       ; 2:7       __INFO   at y x
__{}    rst   0x10          ; 1:11      __INFO   putchar(reg A) with {ZX 48K ROM}
__{}    ld    A, H          ; 1:4       __INFO
__{}    rst   0x10          ; 1:11      __INFO   putchar(reg A) with {ZX 48K ROM}
__{}    ld    A, L          ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO   2x
__{}    add   A, A          ; 1:4       __INFO   4x
__{}    add   A, L          ; 1:4       __INFO   5x
__{}    add   A, 0x07       ; 1:4       __INFO
__{}    rrca                ; 1:4       __INFO
__{}    rrca                ; 1:4       __INFO
__{}    rrca                ; 1:4       __INFO
__{}    and   0x1F          ; 2:7       __INFO
__{}    rst   0x10          ; 1:11      __INFO   putchar(reg A) with {ZX 48K ROM}
__{}  endif})
    ld   HL, 0x2758     ; 3:10      __INFO
    exx                 ; 1:4       __INFO
    ret                 ; 1:10      __INFO
;   =====  e n d  =====}){}dnl
dnl
dnl
dnl
dnl # ( ? ? ? -- )
dnl # Fix back stack and register. Return to Basic.
define({BYE},{dnl
__{}__ADD_TOKEN({__TOKEN_BYE},{bye},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_BYE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    jp   Stop           ; 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # ( -- random )
define({RND},{dnl
__{}__ADD_TOKEN({__TOKEN_RND},{rnd},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RND},{dnl
__{}define({__INFO},{rnd}){}dnl
ifdef({USE_Rnd},,define({USE_Rnd},{}))
    ex   DE, HL         ; 1:4       rnd
    push HL             ; 1:11      rnd
    call Rnd            ; 3:17      rnd}){}dnl
dnl
dnl
dnl # ( max -- random )
define({RANDOM},{dnl
__{}__ADD_TOKEN({__TOKEN_RANDOM},{random},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RANDOM},{dnl
__{}define({__INFO},{random}){}dnl
ifdef({USE_Random},,define({USE_Random},{}))
    call Random         ; 3:17      random}){}dnl
dnl
dnl
dnl
dnl # ( yx -- addr )
define({PUTPIXEL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUTPIXEL},{putpixel},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUTPIXEL},{dnl
__{}define({__INFO},{putpixel}){}dnl
ifdef({USE_PIXEL},,define({USE_PIXEL},{}))
    call PIXEL          ; 3:17      pixel   ( yx -- yx )}){}dnl
dnl
dnl
dnl
dnl # ( yx_from yx_to -- )
define({LINE},{dnl
__{}__ADD_TOKEN({__TOKEN_LINE},{line},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LINE},{dnl
__{}define({__INFO},{line}){}dnl
ifdef({USE_LINE},,define({USE_LINE},{}))
    call line          ; 3:17       line
    pop  HL            ; 1:10       line
    pop  DE            ; 1:10       line}){}dnl
dnl
dnl
dnl
dnl # test_start 1 2 3 swap        test_eq 1 3 2             test_end
dnl # test_start ...max255stack... test_eq ...max255stack... test_end
dnl # ( -- )
define({TEST_START},{dnl
__{}__ADD_TOKEN({__TOKEN_TEST_START},{test_start},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TEST_START},{dnl
__{}define({__INFO},{test_start}){}dnl
define({USE_TESTING},{})
    call T_OPEN         ; 3:17      test_start}){}dnl
dnl
dnl
dnl # test_start 1 2 3 swap test_eq 1 3 2 test_end
dnl # ( -- )
define({TEST_EQ},{dnl
__{}__ADD_TOKEN({__TOKEN_TEST_EQ},{test_eq},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TEST_EQ},{dnl
__{}define({__INFO},{test_eq}){}dnl
define({USE_TESTING},{})
    call T_EQ           ; 3:17      test_eq}){}dnl
dnl
dnl
dnl # test_start 1 2 3 swap test_eq 1 3 2 test_end
dnl # ( -- )
define({TEST_END},{dnl
__{}__ADD_TOKEN({__TOKEN_TEST_END},{test_end},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TEST_END},{dnl
__{}define({__INFO},{test_end}){}dnl
define({USE_TESTING},{})
    call T_CLOSE        ; 3:17      test_end}){}dnl
dnl
dnl
dnl
dnl # ( -- ? )
dnl # inline asm
define({__ASM},{dnl
__{}__ADD_TOKEN({__TOKEN_ASM},{__asm},{{{$@}}})}){}dnl
dnl
define({__ASM_TOKEN_ASM},{
__{}define($0_TMP,__UNBOXING($@)){}dnl
__{}$0_TMP}){}dnl
dnl
dnl
dnl
dnl
