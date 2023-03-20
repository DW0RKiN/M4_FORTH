dnl ## Runtime enviroment
define({__},{}){}dnl
dnl
dnl
dnl
ifdef({USE_TESTING},{
;==============================================================================
; T{ ...max255... -> ...max255... }T
; ( -- )
T_OPEN:                 ;           t_open
    push HL             ; 1:11      t_open
    ld   (T_EQ_SP), SP  ; 4:20      t_open
    pop  HL             ; 1:10      t_open
    ret                 ; 1:10      t_open

; T{ ...max255... -> ...max255... }T
; ->
; ( -- )
T_EQ:                   ;           t_eq
    push HL             ; 1:11      t_eq
    ld   (T_CLOSE_B),SP ; 4:20      t_eq
    ld   (T_CLOSE_C),SP ; 4:20      t_eq
T_EQ_SP EQU $+1         ;           t_eq
    ld   HL, 0x0000     ; 3:10      t_eq
    or    A             ; 1:4       t_eq
    sbc  HL, SP         ; 2:15      t_eq
    ld   (T_CLOSE_D),HL ; 3:16      t_eq
    pop  HL             ; 1:10      t_eq
    ret                 ; 1:10      t_eq

; T{ ...max255... -> ...max255... }T
; ( max255 -- )
T_CLOSE:                ;           t_close
    ex   DE, HL         ; 1:4       t_close
    ex  (SP),HL         ; 1:19      t_close   push de
    ld (T_CLOSE_E), HL  ; 3:16      t_close   save ret
    push DE             ; 1:11      t_close   push hl
T_CLOSE_B EQU $+1       ;           t_close
    ld   HL, 0x0000     ; 3:10      t_close
T_CLOSE_D EQU $+1       ;           t_close
    ld   DE, 0x0000     ; 3:10      t_close
    or    A             ; 1:4       t_close
    sbc  HL, SP         ; 2:15      t_close
    or    A             ; 1:4       t_close
    sbc  HL, DE         ; 2:15      t_close{}STRING_Z({"WRONG NUMBER OF RESULTS", 0x0D})
    call nz, PRINT_STRING_Z; 3:10/17 t_close
    rr    D             ; 2:8       t_close
    rr    E             ; 2:8       t_close
    ld    B, E          ; 1:4       t_close
    ld    C, 0x00       ; 2:7       t_close
T_CLOSE_C EQU $+1       ;           t_close
    ld   HL, 0x0000     ; 3:10      t_close
    pop  DE             ; 1:10      t_close
    ld    A,(HL)        ; 1:7       t_close
    xor   E             ; 1:4       t_close
    or    C             ; 1:4       t_close
    ld    C, A          ; 1:4       t_close
    inc  HL             ; 1:6       t_close
    ld    A,(HL)        ; 1:7       t_close
    xor   D             ; 1:4       t_close
    or    C             ; 1:4       t_close
    ld    C, A          ; 1:4       t_close
    inc  HL             ; 1:6       t_close
    djnz $-11           ; 2:8/13    t_close{}STRING_Z({"INCORRECT RESULT", 0x0D})
    call nz, PRINT_STRING_Z; 3:10/17 t_close
    ld   HL, (T_EQ_SP)  ; 3:16      t_close
    ld   SP, HL         ; 1:6       t_close
    pop  HL             ; 1:10      t_close
    pop  DE             ; 1:10      t_close
T_CLOSE_E EQU $+1       ;           t_close
    jp  0x0000          ; 3:10      t_close}){}dnl
dnl
dnl
dnl
ifdef({USE_U32BCD},{
BIN32BCD:               ;[122:]     bin32bcd
    push HL             ; 1:11      bin32bcd
    push DE             ; 1:11      bin32bcd
    push DE             ; 1:11      bin32bcd
    ld    B, H          ; 1:4       bin32bcd
    ld    C, L          ; 1:4       bin32bcd
    ld   HL, BIN32BCD_D ; 3:10      bin32bcd
    ld    A, C          ; 1:4       bin32bcd
    call BIN32BCD_LO    ; 3:17      bin32bcd
    ld    A, C          ; 1:4       bin32bcd
    call BIN32BCD_HI    ; 3:17      bin32bcd
    ld    A, B          ; 1:4       bin32bcd
    call BIN32BCD_LO    ; 3:17      bin32bcd
    ld    A, B          ; 1:4       bin32bcd
    call BIN32BCD_HI    ; 3:17      bin32bcd
    pop  BC             ; 1:10      bin32bcd
    ld    A, C          ; 1:4       bin32bcd
    call BIN32BCD_LO    ; 3:17      bin32bcd
    ld    A, C          ; 1:4       bin32bcd
    call BIN32BCD_HI    ; 3:17      bin32bcd
    ld    A, B          ; 1:4       bin32bcd
    call BIN32BCD_LO    ; 3:17      bin32bcd
    ld    A, B          ; 1:4       bin32bcd
    call BIN32BCD_HI    ; 3:17      bin32bcd
    pop  DE             ; 1:10      bin32bcd
    pop  HL             ; 1:10      bin32bcd
    ret                 ; 1:10      bin32bcd

BIN32BCD_HI:            ;           bin32bcd
    rra                 ; 1:4       bin32bcd
    rra                 ; 1:4       bin32bcd
    rra                 ; 1:4       bin32bcd
    rra                 ; 1:4       bin32bcd
BIN32BCD_LO:            ;           bin32bcd
    push BC             ; 1:11      bin32bcd
    and  0x0f           ; 2:7       bin32bcd
    ld    C, A          ; 1:4       bin32bcd
    jr   $+7            ; 2:12      bin32bcd
BIN32BCD1:              ;           bin32bcd
    inc  HL             ; 1:6       bin32bcd
    inc  HL             ; 1:6       bin32bcd
    inc  HL             ; 1:6       bin32bcd
    inc  HL             ; 1:6       bin32bcd
    inc  HL             ; 1:6       bin32bcd
    ld   DE, BIN32BCDRES; 3:10      bin32bcd
    ld    B, 0x05       ; 2:7       bin32bcd
BIN32BCD2:              ;           bin32bcd
    ld    A,(DE)        ; 1:7       bin32bcd
    adc   A,(HL)        ; 1:7       bin32bcd
    daa                 ; 1:4       bin32bcd
    ld  (DE),A          ; 1:7       bin32bcd
    dec  HL             ; 1:6       bin32bcd
    dec  DE             ; 1:6       bin32bcd
    djnz BIN32BCD2      ; 2:8/13    bin32bcd
    dec   C             ; 1:4       bin32bcd
    jp   nz, BIN32BCD1  ; 2:7/12    bin32bcd
    pop  BC             ; 1:10      bin32bcd
    ret                 ; 1:10      bin32bcd

                        ; 5:0
    DB 0x00, 0x00, 0x00, 0x00
BIN32BCDRES:
    DB 0x00
                        ;40:0
    DB 02, 68, 43, 54, 56   ; {BCD constant for 2^28 = 02 68 43 54 56}
    DB 00, 16, 77, 72, 16   ; {BCD constant for 2^24 = 00 16 77 72 16}
    DB 00, 01, 04, 85, 76   ; {BCD constant for 2^20 = 00 01 04 85 76}
    DB 00, 00, 06, 55, 36   ; {BCD constant for 2^16 = 00 00 06 55 36}
    DB 00, 00, 00, 40, 96   ; {BCD constant for 2^12 = 00 00 00 40 96}
    DB 00, 00, 00, 02, 56   ; {BCD constant for 2^08 = 00 00 00 02 56}
    DB 00, 00, 00, 00, 16   ; {BCD constant for 2^04 = 00 00 00 00 16}
    DB 00, 00, 00, 00       ; {BCD constant for 2^00 = 00 00 00 00 01}
BIN32BCD_D:
    DB 01
}){}dnl
dnl
dnl
dnl
ifdef({USE_PRT_SP_HEX_U32},{__def({USE_PRT_HEX_U32})
;==============================================================================
;    Input: 32-bit unsigned number in DEHL
;   Output: Print space and Hex DEHL
; Pollutes: A
PRT_SP_HEX_U32:         ;           prt_sp_hex_u32
    ld    A, ' '        ; 2:7       prt_sp_hex_u32   putchar Pollutes: AF, AF', DE', BC'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_sp_hex_u32},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_sp_hex_u32   putchar(reg A) with {ZX 48K ROM}})
    ; fall to prt_hex_u32}){}dnl
ifdef({USE_PRT_HEX_U32},{__def({USE_PRT_HEX_U16})
;------------------------------------------------------------------------------
;    Input: 32-bit unsigned number in DEHL
;   Output: Print Hex DEHL
; Pollutes: A
PRT_HEX_U32:            ;           prt_hex_u32
    ld    A, D          ; 1:4       prt_hex_u32
    call PRT_HEX_A      ; 3:17      prt_hex_u32
    ld    A, E          ; 1:4       prt_hex_u32
    call PRT_HEX_A      ; 3:17      prt_hex_u32
__{}ifdef({USE_PRT_SP_HEX_U16},{dnl
__{}    jr   PRT_HEX_U16    ; 2:12      prt_hex_u32},
__{}{dnl
__{}    ; fall to prt_hex_u16})}){}dnl
dnl
ifdef({USE_PRT_SP_HEX_U16},{__def({USE_PRT_HEX_U16})
;==============================================================================
;    Input: 16-bit unsigned number in DEHL
;   Output: Print space and Hex HL
; Pollutes: A
PRT_SP_HEX_U16:         ;           prt_sp_hex_u16
    ld    A, ' '        ; 2:7       prt_sp_hex_u16   putchar Pollutes: AF, AF', DE', BC'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_sp_hex_u16},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_sp_hex_u16   putchar(reg A) with {ZX 48K ROM}})
    ; fall to prt_hex_u16}){}dnl
ifdef({USE_PRT_HEX_U16},{__def({USE_PRT_HEX_A})
;------------------------------------------------------------------------------
;   Input: 16-bit unsigned number in HL
;   Output: Print Hex HL
; Pollutes: A
PRT_HEX_U16:            ;           prt_hex_u16
    ld    A, H          ;  1:4      prt_hex_u16
    call PRT_HEX_A      ;  3:17     prt_hex_u16
    ld    A, L          ;  1:4      prt_hex_u16
    ; fall to prt_hex_a}){}dnl
ifdef({USE_PRT_HEX_A},{__def({USE_PRT_HEX_NIBBLE})
;------------------------------------------------------------------------------
;    Input: A
;   Output: 00 .. FF
; Pollutes: A
PRT_HEX_A:              ;           prt_hex_a
    push AF             ; 1:11      prt_hex_a
    rra                 ; 1:4       prt_hex_a
    rra                 ; 1:4       prt_hex_a
    rra                 ; 1:4       prt_hex_a
    rra                 ; 1:4       prt_hex_a
    call PRT_HEX_NIBBLE ; 3:17      prt_hex_a
    pop  AF             ; 1:10      prt_hex_a
    ; fall to prt_hex_nibble}){}dnl
ifdef({USE_PRT_HEX_NIBBLE},{
;------------------------------------------------------------------------------
;    Input: A = number, DE = adr
;   Output: (A & $0F) => '0'..'9','A'..'F'
; Pollutes: AF, AF',BC',DE'
PRT_HEX_NIBBLE:         ;           prt_hex_nibble
    or      $F0         ; 2:7       prt_hex_nibble   reset H flag
    daa                 ; 1:4       prt_hex_nibble   $F0..$F9 + $60 => $50..$59; $FA..$FF + $66 => $60..$65
    add   A, $A0        ; 2:7       prt_hex_nibble   $F0..$F9, $100..$105
    adc   A, $40        ; 2:7       prt_hex_nibble   $30..$39, $41..$46   = '0'..'9', 'A'..'F'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_hex_nibble},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_hex_nibble   putchar(reg A) with {ZX 48K ROM}})
    ret                 ; 1:10}){}dnl
dnl
dnl
dnl
ifdef({USE_DUP_ZXPRT_SP_U16},{__def({USE_DUP_ZXPRT_U16})
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC
DUP_ZXPRT_SP_U16:       ;           dup_zxprt_sp_u16
    ld    A, ' '        ; 2:7       dup_zxprt_sp_u16   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      dup_zxprt_sp_u16   putchar(reg A) with {ZX 48K ROM}
    ; fall to dup_zxprt_u16}){}dnl
ifdef({USE_DUP_ZXPRT_U16},{
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC
DUP_ZXPRT_U16:          ;           dup_zxprt_u16   ( u -- )
    ld    B, H          ; 1:4       dup_zxprt_u16
    ld    C, L          ; 1:4       dup_zxprt_u16
    push DE             ; 1:11      dup_zxprt_u16
    push HL             ; 1:11      dup_zxprt_u16   save ret

    call 0x2D2B         ; 3:17      dup_zxprt_u16   {call ZX ROM stack BC routine}
    call 0x2DE3         ; 3:17      dup_zxprt_u16   {call ZX ROM print a floating-point number routine}

    pop  HL             ; 1:10      dup_zxprt_u16
    pop  DE             ; 1:10      dup_zxprt_u16
    ret                 ; 1:10      dup_zxprt_u16}){}dnl
dnl
dnl
dnl
ifdef({USE_ZXPRT_SP_U16},{__def({USE_ZXPRT_U16})
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
ZXPRT_SP_U16:           ;           zxprt_sp_u16
    ld    A, ' '        ; 2:7       zxprt_sp_u16   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      zxprt_sp_u16   putchar(reg A) with {ZX 48K ROM}
    ; fall to zxprt_u16}){}dnl
ifdef({USE_ZXPRT_U16},{
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
ZXPRT_U16:              ;           zxprt_u16   ( u -- )
    push DE             ; 1:11      zxprt_u16
    ld    B, H          ; 1:4       zxprt_u16
    ld    C, L          ; 1:4       zxprt_u16
    call 0x2D2B         ; 3:17      zxprt_u16   {call ZX ROM stack BC routine}
    call 0x2DE3         ; 3:17      zxprt_u16   {call ZX ROM print a floating-point number routine}

    pop  HL             ; 1:10      zxprt_u16
    pop  BC             ; 1:10      zxprt_u16   load ret
    pop  DE             ; 1:10      zxprt_u16
    push BC             ; 1:11      zxprt_u16   save ret
    ret                 ; 1:10      zxprt_u16}){}dnl
dnl
dnl
dnl
ifdef({USE_ZXPRT_SP_S16},{__def({USE_ZXPRT_S16})
;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
ZXPRT_SP_S16:           ;           zxprt_sp_s16
    ld    A, ' '        ; 2:7       zxprt_sp_s16   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      zxprt_sp_s16   putchar with {ZX 48K ROM} in, this will print char in A
    ; fall to zxprt_s16}){}dnl
ifdef({USE_ZXPRT_S16},{
;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
ZXPRT_S16:              ;           zxprt_s16   ( x -- )
    push DE             ; 1:11      zxprt_s16
    ld    A, H          ; 1:4       zxprt_s16
    add   A, A          ; 1:4       zxprt_s16
    sbc   A, A          ; 1:4       zxprt_s16   sign
    ld    E, A          ; 1:4       zxprt_s16   2. byte sign
    xor   A             ; 1:4       zxprt_s16   1. byte = 0
    ld    D, L          ; 1:4       zxprt_s16   3. byte lo
    ld    C, H          ; 1:4       zxprt_s16   4. byte hi
    ld    B, A          ; 1:4       zxprt_s16   5. byte = 0

    ld   IY, 0x5C3A     ; 4:14      zxprt_s16   {Re-initialise IY to ERR-NR.}

    call 0x2AB6         ; 3:17      zxprt_s16   {call ZX ROM STK store routine}
    call 0x2DE3         ; 3:17      zxprt_s16   {call ZX ROM print a floating-point number routine}
    pop  HL             ; 1:10      zxprt_s16
    pop  BC             ; 1:10      zxprt_s16   load ret
    pop  DE             ; 1:10      zxprt_s16
    push BC             ; 1:11      zxprt_s16   save ret
    ret                 ; 1:10      zxprt_u16}){}dnl
dnl
dnl
dnl
ifdef({USE_PRT_SP_S32},{__def({USE_PRT_S32})
;==============================================================================
; ( hi lo -- )
; Input: DEHL
; Output: Print space and signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_SP_S32:             ;           prt_sp_s32
    ld    A, ' '        ; 2:7       prt_sp_s32   putchar Pollutes: AF, AF', DE', BC'
    
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_sp_s32},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_sp_s32   putchar(reg A) with {ZX 48K ROM}})
    ; fall to prt_s32}){}dnl
ifdef({USE_PRT_S32},{__def({USE_DNEGATE}){}__def({USE_PRT_U32})
;------------------------------------------------------------------------------
; ( hi lo -- )
; Input: DEHL
; Output: Print signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_S32:                ;           prt_s32
    ld    A, D          ; 1:4       prt_s32
    add   A, A          ; 1:4       prt_s32
    jr   nc, PRT_U32    ; 2:7/12    prt_s32
    ld    A, '-'        ; 2:7       prt_s32   putchar Pollutes: AF, AF', DE', BC'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_s32},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_s32   putchar(reg A) with {ZX 48K ROM}})
    call NEGATE_32      ; 3:17      prt_s32
__{}ifdef({USE_PRT_SP_U32},{dnl
__{}    jr   PRT_U32        ; 2:12      prt_s32},
__{}{dnl
__{}    ; fall to prt_u32})}){}dnl
dnl
dnl
ifdef({USE_PRT_SP_U32},{__def({USE_PRT_U32})
;==============================================================================
; Input: DEHL
; Output: Print space and unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_SP_U32:             ;           prt_sp_u32
    ld    A, ' '        ; 2:7       prt_sp_u32   putchar Pollutes: AF, AF', DE', BC'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_sp_u32},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_sp_u32   putchar(reg A) with {ZX 48K ROM}})
    ; fall to prt_u32}){}dnl
ifdef({USE_PRT_U32},{
;------------------------------------------------------------------------------
; Input: DEHL
; Output: Print unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_U32:                ;           prt_u32
    xor   A             ; 1:4       prt_u32   HL = 103 & A=0 => 103, HL = 103 & A='0' => 00103
    push IX             ; 2:15      prt_u32
    ex   DE, HL         ; 1:4       prt_u32   HL = hi word
    ld  IXl, E          ; 2:8       prt_u32
    ld  IXh, D          ; 2:8       prt_u32   IX = lo word
    ld   DE, 0x3600     ; 3:10      prt_u32   C4 65 36 00 = -1000000000
    ld   BC, 0xC465     ; 3:10      prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld    D, 0x1F       ; 2:7       prt_u32   FA 0A 1F 00 = -100000000
    ld   BC, 0xFA0A     ; 3:10      prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0x6980     ; 3:10      prt_u32   FF 67 69 80 = -10000000
    ld   BC, 0xFF67     ; 3:10      prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xBDC0     ; 3:10      prt_u32   FF F0 BD C0 = -1000000
    ld    C, 0xF0       ; 2:7       prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0x7960     ; 3:10      prt_u32   FF FE 79 60 = -100000
    ld    C, 0xFE       ; 2:7       prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xD8F0     ; 3:10      prt_u32   FF FF D8 F0 = -10000
    ld    C, B          ; 1:4       prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xFC18     ; 3:10      prt_u32   FF FF FC 18 = -1000
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xFF9C     ; 3:10      prt_u32   FF FF FF 9C = -100
    call BIN32_DEC      ; 3:17      prt_u32
    ld    E, 0xF6       ; 2:7       prt_u32   FF FF FF F6 = -10
    call BIN32_DEC      ; 3:17      prt_u32
    ld    A, IXl        ; 2:8       prt_u32
    pop  IX             ; 2:14      prt_u32
    pop  BC             ; 1:10      prt_u32   load ret
    pop  HL             ; 1:10      prt_u32
    pop  DE             ; 1:10      prt_u32
    push BC             ; 1:11      prt_u32   save ret
    jr   BIN32_DEC_CHAR ; 2:12      prt_u32
;------------------------------------------------------------------------------
; Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
; Output: if ((HLIX/(-BCDE) > 0) || (A >= '0')) print number HLIX/(-BCDE)
; Pollutes: AF, AF', IX, HL
BIN32_DEC:              ;           bin32_dec
    add  IX, DE         ; 2:15      bin32_dec   lo word
    adc  HL, BC         ; 2:15      bin32_dec   hi word
    inc   A             ; 1:4       bin32_dec
    jr    c, $-5        ; 2:7/12    bin32_dec
    ex   AF, AF'        ; 1:4       bin32_dec
    ld    A, IXl        ; 2:8       bin32_dec
    sub   E             ; 1:4       bin32_dec
    ld  IXl, A          ; 2:8       bin32_dec
    ld    A, IXh        ; 2:8       bin32_dec
    sbc   A, D          ; 1:4       bin32_dec
    ld  IXh, A          ; 2:8       bin32_dec
    sbc  HL, BC         ; 2:15      bin32_dec   hi word
    ex   AF, AF'        ; 1:4       bin32_dec
    dec   A             ; 1:4       bin32_dec
    ret   z             ; 1:5/11    bin32_dec   does not print leading zeros
BIN32_DEC_CHAR:         ;           bin32_dec
    or   '0'            ; 2:7       bin32_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    __{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      bin32_dec},
__{}{dnl
__{}    rst   0x10          ; 1:11      bin32_dec   putchar(reg A) with {ZX 48K ROM}})
    ld    A, '0'        ; 2:7       bin32_dec   reset A to '0'
    ret                 ; 1:10      bin32_dec}){}dnl
dnl
dnl
ifdef({USE_PRT_SP_S16},{__def({USE_PRT_S16})
;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_S16:             ;           prt_sp_s16
    ld    A, ' '        ; 2:7       prt_sp_s16   putchar Pollutes: AF, AF', DE', BC'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_sp_s16},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_sp_s16   putchar(reg A) with {ZX 48K ROM}})
    ; fall to prt_s16}){}dnl
ifdef({USE_PRT_S16},{__def({USE_PRT_U16})
;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_S16:                ;           prt_s16
    ld    A, H          ; 1:4       prt_s16
    add   A, A          ; 1:4       prt_s16
    jr   nc, PRT_U16    ; 2:7/12    prt_s16
    ld    A, '-'        ; 2:7       prt_s16   putchar Pollutes: AF, AF', DE', BC'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_s16},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_s16   putchar(reg A) with {ZX 48K ROM}})
    xor   A             ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    L, A          ; 1:4       prt_s16   neg
    sbc   A, H          ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    H, A          ; 1:4       prt_s16   neg
__{}ifdef({USE_PRT_SP_U16},{dnl
__{}    jr   PRT_U16        ; 2:12      prt_s16},
__{}{dnl
__{}    ; fall to prt_u16})}){}dnl
dnl
dnl
ifdef({USE_PRT_SP_U16},{__def({USE_PRT_U16})
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_U16:             ;           prt_sp_u16
    ld    A, ' '        ; 2:7       prt_sp_u16   putchar Pollutes: AF, AF', DE', BC'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_sp_u16},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_sp_u16   putchar(reg A) with {ZX 48K ROM}})  
    ; fall to prt_u16}){}dnl
ifdef({USE_PRT_U16},{
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_U16:                ;           prt_u16
    xor   A             ; 1:4       prt_u16   HL=103 & A=0 => 103, HL = 103 & A='0' => 00103
    ld   BC, -10000     ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld   BC, -1000      ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld   BC, -100       ; 3:10      prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld    C, -10        ; 2:7       prt_u16
    call BIN16_DEC      ; 3:17      prt_u16
    ld    A, L          ; 1:4       prt_u16
    pop  HL             ; 1:10      prt_u16   load ret
    ex  (SP),HL         ; 1:19      prt_u16
    ex   DE, HL         ; 1:4       prt_u16
    jr   BIN16_DEC_CHAR ; 2:12      prt_u16
;------------------------------------------------------------------------------
; Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
; Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
; Pollutes: AF, HL
    inc   A             ; 1:4       bin16_dec
BIN16_DEC:              ;           bin16_dec
    add  HL, BC         ; 1:11      bin16_dec
    jr    c, $-2        ; 2:7/12    bin16_dec
    sbc  HL, BC         ; 2:15      bin16_dec
    or    A             ; 1:4       bin16_dec
    ret   z             ; 1:5/11    bin16_dec   does not print leading zeros
BIN16_DEC_CHAR:         ;           bin16_dec
    or   '0'            ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      bin16_dec},
__{}{dnl
__{}    rst   0x10          ; 1:11      bin16_dec   putchar(reg A) with {ZX 48K ROM}})  
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec}){}dnl
dnl
dnl
dnl
ifdef({USE_PRT_P},{__def({USE_PRT_PU})
;==============================================================================
; Input: A = bytes, [BC] = 10, [DE] = number, [HL] = tmp_result
; Output: Print decimal (if [BC]=10) number in [DE]
; Pollutes: AF, AF', BC', DE', [DE] = first number, [HL] = 0
PRT_P:                  ;           prt_p
    push HL             ; 1:11      prt_p
    push BC             ; 1:11      prt_p
    push AF             ; 1:11      prt_p
    ld    B, A          ; 1:4       prt_p   B = sizeof(number) in bytes
    add   A, E          ; 1:4       prt_p
    ld    L, A          ; 1:4       prt_p
    dec   L             ; 1:4       prt_p
    ld    H, D          ; 1:4       prt_p
    ld    A,(HL)        ; 1:7       prt_p
    add   A, A          ; 1:4       prt_p
    jr   nc, $+14       ; 2:7/12    prt_p
    ld    A, '-'        ; 2:7       prt_p   putchar Pollutes: AF, AF', DE', BC'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_p},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_p   putchar(reg A) with {ZX 48K ROM}})
    ld    L, E          ; 1:4       prt_p
    xor   A             ; 1:4       prt_p   clear carry
    ld    C, A          ; 1:4       prt_p
    ld    A, C          ; 1:4       prt_p
    sbc   A,(HL)        ; 1:7       prt_p
    ld  (HL),A          ; 1:7       prt_p
    inc   L             ; 1:4       prt_p
    djnz $-4            ; 2:8/13    prt_p
    pop  AF             ; 1:10      prt_p
    pop  BC             ; 1:10      prt_p
    pop  HL             ; 1:10      prt_p{}dnl
__{}ifdef({USE_PRT_SP_PU},{
    jr   PRT_PU         ; 2:12      prt_p})}){}dnl
dnl
ifdef({USE_PRT_SP_PU},{__def({USE_PRT_PU})
;==============================================================================
; Input: A = bytes, [BC] = 10, [DE] = number, [HL] = tmp_result
; Output: Print space and unsigned decimal (if [BC]=10) number in [DE]
; Pollutes: AF, AF', BC', DE', [DE] = first number, [HL] = 0
PRT_SP_PU:              ;           prt_sp_pu
    push AF             ; 1:11      prt_sp_pu
    ld    A, ' '        ; 2:7       prt_sp_pu   putchar Pollutes: AF, AF', DE', BC'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_sp_pu},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_sp_pu   putchar(reg A) with {ZX 48K ROM}})
    pop  AF             ; 1:10      prt_sp_pu
    ; fall to prt_pu}){}dnl
dnl
ifdef({USE_PRT_PU},{
;------------------------------------------------------------------------------
; Input: A = bytes, [BC] = 10, [DE] = number, [HL] = tmp_result
; Output: Print unsigned decimal (if [BC]=10) number in [DE]
; Pollutes: AF', BC', DE', [DE] = first number, [HL] = 0

PRT_PU:                 ;           prt_pu
    exx                 ; 1:4       prt_pu
    ld    E, A          ; 1:4       prt_pu   E' = sizeof(number) in bytes
    exx                 ; 1:4       prt_pu
    or    A             ; 1:4       prt_pu
    ex   DE, HL         ; 1:4       prt_pu
    jr   PRT_PU_ENTR    ; 2:12      prt_pu
PRT_PU_LOOP:            ;           prt_pu
    ex   DE, HL         ; 1:4       prt_pu
    exx                 ; 1:4       prt_pu
    ld    A, E          ; 1:4       prt_pu   E' = sizeof(number) in bytes
    exx                 ; 1:4       prt_pu
ifelse(PUDM_MIN:PUDM_MAX,1:1,{dnl
__{}    call  c, P8UDM      ; 3:17      prt_pu},
PUDM_MIN:PUDM_MAX,2:2,{dnl
__{}    call  c, P16UDM     ; 3:17      prt_pu},
PUDM_MIN:PUDM_MAX,256:256,{dnl
__{}    call  c, P2048UDM   ; 3:17      prt_pu},
eval(PUDM_MIN<=32):eval(PUDM_MAX<=32),1:1,{dnl
__{}    call  c, P256UDM    ; 3:17      prt_pu},
{dnl
__{}    call  c, PUDM       ; 3:17      prt_pu})

    ld    A,(DE)        ; 1:7       prt_pu   DE = number mod [BC]
    scf                 ; 1:4       prt_pu
PRT_PU_ENTR:            ;           prt_pu
    push AF             ; 1:11      prt_pu   print number if carry or end_mark

    push HL             ; 1:11      prt_pu

    scf                 ; 1:4       prt_pu
    ld    A,(BC)        ; 1:7       prt_pu

    exx                 ; 1:4       prt_pu
    ld    B, E          ; 1:4       prt_pu

    exx                 ; 1:4       prt_pu
    sbc   A,(HL)        ; 1:7       prt_pu   10-x-1=9-x
    inc   L             ; 1:4       prt_pu
    jr    c, $+7        ; 2:7/12    prt_pu
    xor   A             ; 1:4       prt_pu
    exx                 ; 1:4       prt_pu
    djnz $-7            ; 2:8/13    prt_pu
    exx                 ; 1:4       prt_pu

    pop  HL             ; 1:10      prt_pu

    jr    c, PRT_PU_LOOP; 2:7/12    prt_pu

    ld    A,(HL)        ; 1:7       prt_pu

ifdef({USE_PRT_HEX_NIBBLE},{dnl
    ex   DE, HL         ; 1:4       prt_pu
    call PRT_HEX_NIBBLE ; 3:17      prt_pu
    pop  AF             ; 1:10      prt_pu
    jr    c, $-5        ; 2:7/12    prt_pu},
{dnl
    ex   DE, HL         ; 1:4       prt_pu
    or      $F0         ; 2:7       prt_pu   reset H flag
    daa                 ; 1:4       prt_pu   $F0..$F9 + $60 => $50..$59; $FA..$FF + $66 => $60..$65
    add   A, $A0        ; 2:7       prt_pu   $F0..$F9, $100..$105
    adc   A, $40        ; 2:7       prt_pu   $30..$39, $41..$46   = '0'..'9', 'A'..'F'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_pu
__{}    pop  AF             ; 1:10      prt_pu
__{}    jr    c, $-12       ; 2:7/12    prt_pu},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_pu   putchar(reg A) with {ZX 48K ROM}
__{}    pop  AF             ; 1:10      prt_pu
__{}    jr    c, $-10       ; 2:7/12    prt_pu})})
    ret                 ; 1:10      prt_pu
}){}dnl
dnl
ifdef({USE_PRT_PU2},{
;------------------------------------------------------------------------------
; Input: A = bytes, [BC] = 10, [DE] = number, [HL] = tmp_result
; Output: Print unsigned decimal (if [BC]=10) number in [DE]
; Pollutes: AF', BC', DE', [DE] = first number, [HL] = 0

PRT_PU:                 ;           prt_pu
    exx                 ; 1:4       prt_pu
    ld    E, A          ; 1:4       prt_pu   E' = sizeof(number) in bytes
PRT_PU_IN:              ;           prt_pu
    exx                 ; 1:4       prt_pu
    or    A             ; 1:4       prt_pu
PRT_PU_LOOP:            ;           prt_pu
    push AF             ; 1:11      prt_pu   no carry = end
    exx                 ; 1:4       prt_pu
    ld    A, E          ; 1:4       prt_pu
    exx                 ; 1:4       prt_pu
ifelse(PUDM_MIN:PUDM_MAX,1:1,{dnl
__{}    call P8UDM          ; 3:17      prt_pu},
PUDM_MIN:PUDM_MAX,2:2,{dnl
__{}    call P16UDM         ; 3:17      prt_pu},
PUDM_MIN:PUDM_MAX,256:256,{dnl
__{}    call P2048UDM       ; 3:17      prt_pu},
eval(PUDM_MIN<=32):eval(PUDM_MAX<=32),1:1,{dnl
__{}    call P256UDM        ; 3:17      prt_pu},
{dnl
__{}    call PUDM           ; 3:17      prt_pu})

    exx                 ; 1:4       prt_pu
    ld    B, E          ; 1:4       prt_pu   E' = sizeof(number) in bytes
    exx                 ; 1:4       prt_pu
    push HL             ; 1:11      prt_pu
    scf                 ; 1:4       prt_pu
    ld    A,(BC)        ; 1:7       prt_pu

    sbc   A,(HL)        ; 1:7       prt_pu 10-x-1=9-x
    inc   L             ; 1:4       prt_pu
    jr    c, $+8        ; 2:7/12    prt_pu
    xor   A             ; 1:4       prt_pu
    exx                 ; 1:4       prt_pu
    dec   B             ; 1:4       prt_pu   B'--
    exx                 ; 1:4       prt_pu
    jr   nz, $-8        ; 2:7/12    prt_pu

    pop  HL             ; 1:10      prt_pu
    ex   DE, HL         ; 1:4       prt_pu
    ld    A,(HL)        ; 1:7       prt_pu
    jr    c, PRT_PU_LOOP; 2:7/12    prt_pu

    scf                 ; 1:4       prt_pu
    push AF             ; 1:11      prt_pu
    ld    A,(DE)        ; 1:7       prt_pu
    push AF             ; 1:11      prt_pu

    pop  AF             ; 1:10      prt_pu
    ex   DE, HL         ; 1:4       prt_pu
    ret  nc             ; 1:5/11    prt_pu
    add   A, $30        ; 2:7       prt_pu   '0'..'9'
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      prt_pu
__{}    jr    c, $-8        ; 2:7/12    prt_pu},
__{}{dnl
__{}    rst   0x10          ; 1:11      prt_pu   putchar(reg A) with {ZX 48K ROM}
__{}    jr    c, $-6        ; 2:7/12    prt_pu})}){}dnl
dnl
dnl
dnl
ifdef({USE_BITSET16},{
;==============================================================================
; ( x1 u -- ? x )  x = x1 | 2**u
; set u bit
;  Input: HL, DE
; Output: HL = DE | ( 1<<HL )
; Pollutes: AF, B, DE, HL
BITSET16:               ;[21:89/30] bitset16   ( x1 u -- ? x )  x = x1 | 2**u
    ld    A, 0xF0       ; 2:7       bitset16
    and   L             ; 1:4       bitset16
    or    H             ; 1:4       bitset16
    ex   DE, HL         ; 1:4       bitset16
    ret  nz             ; 1:5/11    bitset16   out of range 0..15
    ld    A, E          ; 1:4       bitset16   A = 0000 rnnn
    rlca                ; 1:4       bitset16   A = 000r nnn0
    rlca                ; 1:4       bitset16   A = 00rn nn00
    add   A, 0xE0       ; 2:7       bitset16   A = ...n nn00 carry = r
    ccf                 ; 1:4       bitset16   A = ...n nn00 carry = i = 1-r
    adc   A, A          ; 1:4       bitset16   A = ..nn n00i
    or   0xC4           ; 2:7       bitset16   A = 11nn n101 = set n,L   or   A = 11nn n100 = set n,H
    ld  ($+4), A        ; 3:13      bitset16
    set   0, L          ; 2:8       bitset16
    ret                 ; 1:10      bitset16}){}dnl
dnl
dnl
dnl
ifdef({USE_BITSET32},{__def({USE_BC_BITSET32})
;==============================================================================
; ( d1 u -- d )  d = d1 | 2**u
; set u bit
;  Input: HL=u, DE=lo, (SP)=ret, (SP+2)=hi
; Output: DEHL = d1 | (1 << u)
; Pollutes: AF, BC, DE, HL
BITSET32:              ;[29:143/67] bitset32   ( d1 u -- d )  d = d1 | 2**u
    ld    C, L          ; 1:4       bitset32
    ld    B, H          ; 1:4       bitset32   BC = u
    pop  HL             ; 1:10      bitset32   ret
    ex  (SP),HL         ; 1:19      bitset32
    ex   DE, HL         ; 1:4       bitset32   DEHL = d1
    ; fall to BC_BITSET32}){}dnl
ifdef({USE_BC_BITSET32},{
BC_BITSET32:           ;[24:102/26] bc_bitset32   ( d1 -- d )  d = d1 | 2**BC
    ld    A, 0xE0       ; 2:7       bc_bitset32
    and   C             ; 1:4       bc_bitset32
    or    B             ; 1:4       bc_bitset32
    ret  nz             ; 1:5/11    bc_bitset32   out of range 0..31
    ld    A, C          ; 1:4       bc_bitset32   A = 000r rnnn
    rlca                ; 1:4       bc_bitset32   2x
    rlca                ; 1:4       bc_bitset32   4x
    rlca                ; 1:4       bc_bitset32   8x
    ld    C, A          ; 1:4       bc_bitset32   C = rrnn n000, nnn = 0..7, rr=(L:0,H:1,E:2,D:3) --> 5-rr=(L:5,H:4,E:3,D:2)
    rlca                ; 1:4       bc_bitset32
    rlca                ; 1:4       bc_bitset32
    and  0x03           ; 1:4       bc_bitset32
    ld    B, A          ; 1:4       bc_bitset32   B = 0000 00rr
    ld    A, C          ; 1:4       bc_bitset32   A = rrnn n000
    or   0xC5           ; 2:7       bc_bitset32   A = 11nn n101     = set n, L
    sub   B             ; 1:4       bc_bitset32   A = 11nn n101 - B = set n, DEHL
    ld  ($+4), A        ; 3:13      bc_bitset32
    set   0, L          ; 2:8       bc_bitset32
    ret                 ; 1:10      bc_bitset32}){}dnl
dnl
dnl
dnl
ifdef({USE_DLSHIFT},{__def({USE_ROT_DLSHIFT})
;==============================================================================
; ( d1 u -- d )  d = d1<<u
; shifts d1 left u places
;  Input: HL=u, DE=lo, (SP)=ret, (SP+2)=hi
; Output: DEHL = d1 << u
; Pollutes: AF, BC, DE, HL
LSHIFT32:               ;[39:]      lshift32
    ld    C, L          ; 1:4       lshift32
    ld    B, H          ; 1:4       lshift32   BC = u
    pop  HL             ; 1:10      lshift32   ret
    ex  (SP),HL         ; 1:19      lshift32
    ex   DE, HL         ; 1:4       lshift32   DEHL = d1
    ; fall to BC_DLSHIFT32}){}dnl
ifdef({USE_ROT_DLSHIFT},{
;-------------------------------------------------------------------------------
; ( d1 -- d )  d = d1<<BC
; shifts d1 left BC places
;  Input: BC=u, DEHL=d1, (SP)=ret
; Output: DEHL <<=  BC
; Pollutes: AF, BC, DE, HL
BC_LSHIFT32:            ;[34:]      lshift32
    ld    A, 0xE0       ; 2:7       lshift32
    and   C             ; 1:4       lshift32
    or    B             ; 1:4       lshift32
    jr   nz, LSHIFT32_Z ; 2:7/12    lshift32   overflow
    ld    A, C          ; 1:4       lshift32
    and  0x07           ; 1:4       lshift32   A = u & 0x07
    jr    z, $+10       ; 2:7/12    lshift32
    ld    B, A          ; 1:4       lshift32
    add  HL, HL         ; 1:11      lshift32
    rl    E             ; 2:8       lshift32
    rl    D             ; 2:8       lshift32   DEHL = DEHL << 1
    djnz $-5            ; 2:8/13    lshift32
    xor   C             ; 1:4       lshift32   A = u & 0xF8
    ret   z             ; 1:5/11    lshift32
    sub  0x08           ; 2:7       lshift32
    ld    D, E          ; 1:4       lshift32
    ld    E, H          ; 1:4       lshift32
    ld    H, L          ; 1:4       lshift32
    ld    L, B          ; 1:4       lshift32   DEHL = DEHL << 8
    jr   $-7            ; 2:12      lshift32
LSHIFT32_Z:             ;           lshift32
    ld   DE, 0x0000     ; 3:10      lshift32
    ld    H, D          ; 1:4       lshift32
    ld    L, E          ; 1:4       lshift32   DEHL = 0
    ret                 ; 1:10      lshift32}){}dnl
dnl
dnl
dnl
ifdef({USE_DRSHIFT},{__def({USE_ROT_DRSHIFT})
;==============================================================================
; ( d1 u -- d )  d = d1>>u
; shifts d1 right u places
;  Input: HL=u, DE=lo, (SP)=ret, (SP+2)=hi
; Output: DEHL = d1 >> u
; Pollutes: AF, BC, DE, HL
RSHIFT32:               ;[39:]      rshift32
    ld    C, L          ; 1:4       rshift32
    ld    B, H          ; 1:4       rshift32   BC = u
    pop  HL             ; 1:10      rshift32   ret
    ex  (SP),HL         ; 1:19      rshift32
    ex   DE, HL         ; 1:4       rshift32   DEHL = d1
    ; fall to BC_DRSHIFT32}){}dnl
ifdef({USE_ROT_DRSHIFT},{
;-------------------------------------------------------------------------------
; ( d1 -- d )  d = d1>>BC
; shifts d1 right BC places
;  Input: BC=u, DEHL=d1, (SP)=ret
; Output: DEHL >>=  BC
; Pollutes: AF, BC, DE, HL
BC_RSHIFT32:            ;[37:]      rshift32
    ld    A, 0xE0       ; 2:7       rshift32
    and   C             ; 1:4       rshift32
    or    B             ; 1:4       rshift32
    jr   nz, ifdef({USE_ROT_DLSHIFT},{LSHIFT32_Z},{RSHIFT32_Z}) ; 2:7/12    rshift32   overflow
__{}ifelse({1},{1},{dnl
    ld    A, C          ; 1:4       rshift32
    and  0x07           ; 1:4       rshift32   A = u & 0x07
    jr    z, $+13       ; 2:7/12    rshift32
    ld    B, A          ; 1:4       rshift32
    srl   D             ; 2:8       rshift32   unsigned
    rr    E             ; 2:8       rshift32
    rr    H             ; 2:8       rshift32
    rr    L             ; 2:8       rshift32   DEHL = DEHL >> 1
    djnz $-8            ; 2:8/13    rshift32
    xor   C             ; 1:4       rshift32   A = u & 0xF8
    ret   z             ; 1:5/11    rshift32
    sub  0x08           ; 2:7       rshift32
    ld    L, H          ; 1:4       rshift32
    ld    H, E          ; 1:4       rshift32
    ld    E, D          ; 1:4       rshift32
    ld    D, B          ; 1:4       rshift32   DEHL = DEHL >> 8
    jr   $-7            ; 2:12      rshift32},
__{}{dnl
    or    C             ; 1:4       rshift32   A = u
    jr   $+7            ; 2:12      rshift32
    ld    L, H          ; 1:4       rshift32
    ld    H, E          ; 1:4       rshift32
    ld    E, D          ; 1:4       rshift32
    ld    D, B          ; 1:4       rshift32   DEHL = DEHL >> 8
    ld    C, A          ; 1:4       rshift32
    ret   z             ; 1:5/11    rshift32
    sub  0x08           ; 2:7       rshift32
    jr   nc, $-8        ; 2:7/12    rshift32
    ld    B, C          ; 1:4       rshift32
    srl   D             ; 2:8       rshift32   unsigned
    rr    E             ; 2:8       rshift32
    rr    H             ; 2:8       rshift32
    rr    L             ; 2:8       rshift32   DEHL = DEHL >> 1
    djnz $-8            ; 2:8/13    rshift32
    ret                 ; 1:10      rshift32}){}dnl
__{}ifdef({USE_ROT_DLSHIFT},{},{
__{}RSHIFT32_Z:             ;           rshift32
__{}    ld   DE, 0x0000     ; 3:10      rshift32
__{}    ld    H, D          ; 1:4       rshift32
__{}    ld    L, E          ; 1:4       rshift32   DEHL = 0
__{}    ret                 ; 1:10      rshift32})}){}dnl
dnl
dnl
dnl
ifdef({USE_LSHIFT},{
;==============================================================================
; ( x u -- ? x<<u )
; shifts x left u places
;  Input: HL, DE
; Output: HL = DE << HL
; Pollutes: AF, B, DE, HL
DE_LSHIFT:              ;[27:]      de_lshift
    ld    A, 0xF0       ; 2:7       de_lshift
    and   L             ; 1:4       de_lshift
    or    H             ; 1:4       de_lshift
    jr   nz, DE_LSHIFTZ ; 2:7/12    de_lshift   overflow
    or    L             ; 1:4       de_lshift
    ex   DE, HL         ; 1:4       de_lshift   HL = x
    ret   z             ; 1:5/11    de_lshift    A = E = u
    ld    B, A          ; 1:4       de_lshift
    sub   0x08          ; 2:7       de_lshift
    jr    c, $+7        ; 2:7/12    de_lshift
    ld    H, L          ; 1:4       de_lshift
    ld    L, 0x00       ; 2:7       de_lshift   HL = HL << 8
    ret   z             ; 1:5/11    de_lshift
    ld    B, A          ; 1:4       de_lshift
    add  HL, HL         ; 1:11      de_lshift   HL = HL << 1
    djnz $-1            ; 2:8/13    de_lshift
    ret                 ; 1:10      de_lshift
DE_LSHIFTZ:             ;           de_lshift
    ld   HL, 0x0000     ; 3:10      de_lshift   HL = 0
    ret                 ; 1:10      de_lshift}){}dnl
dnl
dnl
dnl
ifdef({USE_RSHIFT},{
;==============================================================================
; ( x u -- ? x>>u )
; shifts x right u places
;  Input: HL, DE
; Output: HL = DE >> HL
; Pollutes: AF, BC, DE, HL
DE_RSHIFT:              ;[ifdef({USE_LSHIFT},{28},{32}):]      de_rshift
    ld    A, 15         ; 2:7       de_rshift
    sub   L             ; 1:4       de_rshift
    sbc   A, A          ; 1:4       de_rshift
    or    H             ; 1:4       de_rshift
    jr   nz, ifdef({USE_LSHIFT},{DE_LSHIFTZ},{DE_RSHIFTZ}) ; 2:7/12    de_rshift
    or    L             ; 1:4       de_rshift
    ex   DE, HL         ; 1:4       de_rshift   HL = x
    ret   z             ; 1:5/11    de_rshift    A = u
    ld    B, A          ; 1:4       de_rshift
    sub   0x08          ; 2:7       de_rshift
    jr    c, $+7        ; 2:7/12    de_rshift
    ld    L, H          ; 1:4       de_rshift
    ld    H, 0x00       ; 2:7       de_rshift   HL = HL >> 8
    ret   z             ; 1:5/11    de_rshift
    ld    B, A          ; 1:4       de_rshift
    ld    A, L          ; 1:4       de_rshift
    srl   H             ; 2:8       de_rshift   unsigned
    rra                 ; 1:4       de_rshift   HA = HA >> 1
    djnz $-3            ; 2:8/13    de_rshift
    ld    L, A          ; 1:4       de_rshift
    ret                 ; 1:10      de_rshift{}ifdef({USE_LSHIFT},{},{
DE_RSHIFTZ:             ;           de_rshift
    ld   HL, 0x0000     ; 3:10      de_rshift   HL = 0
    ret                 ; 1:10      de_rshift})}){}dnl
dnl
dnl
dnl
ifdef({USE_DNEGATE},{
;==============================================================================
; ( d -- -d )
NEGATE_32:              ;[14:62]    negate_32   ( hi lo -- 0-hi-carry 0-lo )
    xor   A             ; 1:4       negate_32
    ld    C, A          ; 1:4       negate_32
    sub   L             ; 1:4       negate_32
    ld    L, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, H          ; 1:4       negate_32
    ld    H, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, E          ; 1:4       negate_32
    ld    E, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, D          ; 1:4       negate_32
    ld    D, A          ; 1:4       negate_32
    ret                 ; 1:10      negate_32}){}dnl
dnl
dnl
ifdef({USE_DMAX},{
;==============================================================================
; ( 5 3 -- 5 )
; ( -5 -3 -- -3 )
; ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_max HL:lo_max )
MAX_32:                ;[21:104/129]max_32   ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_max HL:lo_max )
    push AF             ; 1:11      max_32   BC = lo_2
    ld    A, L          ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    sub   C             ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    ld    A, H          ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    sbc   A, B          ; 1:4       max_32   BC>HL --> 0>HL-BC --> carry if lo_2 is max
    ex  (SP),HL         ; 1:19      max_32   HL = hi_2
    ld    A, E          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    sbc   A, L          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    ld    A, D          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    sbc   A, H          ; 1:4       max_32   HL>DE --> 0>DE-HL --> carry if hi_2 is max
    rra                 ; 1:4       max_32   carry --> sign
    xor   H             ; 1:4       max_32
    xor   D             ; 1:4       max_32
    jp    p, $+6        ; 3:10      max_32
    ex   DE, HL         ; 1:4       max_32   DE = hi_2
    pop  HL             ; 1:10      max_32   removing lo_1 from the stack
    push BC             ; 1:11      max_32
    pop  HL             ; 1:10      max_32
    ret                 ; 1:10      max_32}){}dnl
dnl
dnl
dnl
ifdef({USE_DMIN},{
;==============================================================================
; ( 5 3 -- 3 )
; ( -5 -3 -- -5 )
; ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_min HL:lo_min )
MIN_32:                ;[21:104/129]min_32   ( AF:hi_2 BC:lo_2 DE:hi_1 HL:lo_1 -- DE:hi_min HL:lo_min )
    push AF             ; 1:11      min_32   BC = lo_2
    ld    A, C          ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    sub   L             ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    ld    A, B          ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    sbc   A, H          ; 1:4       min_32   BC<HL --> BC-HL<0 --> carry if lo_2 is min
    ex  (SP),HL         ; 1:19      min_32   HL = hi_2
    ld    A, L          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    sbc   A, E          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    ld    A, H          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    sbc   A, D          ; 1:4       min_32   HL<DE --> HL-DE<0 --> carry if hi_2 is min
    rra                 ; 1:4       min_32   carry --> sign
    xor   H             ; 1:4       min_32
    xor   D             ; 1:4       min_32
    jp    p, $+6        ; 3:10      min_32
    ex   DE, HL         ; 1:4       min_32   DE = hi_2
    pop  HL             ; 1:10      min_32   removing lo_1 from the stack
    push BC             ; 1:11      min_32
    pop  HL             ; 1:10      min_32
    ret                 ; 1:10      min_32}){}dnl
dnl
dnl
dnl
ifdef({USE_FCE_4DUP_DEQ},{ifdef({USE_FCE_DEQ},,define({USE_FCE_DEQ},{yes}))
;==============================================================================
; ( d2 ret d1 -- d2 d1 )
;  In: (SP+4) = h2, (SP+2) = l2, (SP) = ret
; Out: (SP+2) = h2, (SP)   = l2, (SP) = ret, AF = h2, BC = l2
FCE_4DUP_DEQ:           ;[9:75]     fce_4dup_deq   ( d2 ret d1 -- d2 d1 )
    pop  AF             ; 1:10      fce_4dup_deq   h2 l2 .. ..  AF = ret
    pop  BC             ; 1:10      fce_4dup_deq   h2 .. .. ..  BC = l2
    ex   AF, AF'        ; 1:4       fce_4dup_deq   h2 .. .. ..
    pop  AF             ; 1:10      fce_4dup_deq   .. .. .. ..  AF'= h2
    push AF             ; 1:11      fce_4dup_deq   h2 .. .. ..
    push BC             ; 1:11      fce_4dup_deq   h2 l2 .. ..
    ex   AF, AF'        ; 1:4       fce_4dup_deq   h2 l2 .. ..
    push AF             ; 1:11      fce_4dup_deq   h2 l2 rt ..
    ex   AF, AF'        ; 1:4       fce_4dup_deq   h2 l2 rt ..  AF = h2
    ; fall to fce_deq}){}dnl
ifdef({USE_FCE_DEQ},{
;==============================================================================
; ( d2 ret d1 -- d1 )
; set zero if d2==d1 is true
;  In: AF = h2, BC = l2, DE = h1, HL = l1
; Out:          BC = h2, DE = h1, HL = l1, set zero if true
ifelse(USE_FCE_DEQ,{small},{dnl
__{}FCE_DEQ:           ;[11:100/70,100] fce_deq   ( d2 ret d1 -- d2 d1 )   # small version because "define({_USE_FCE_DEQ},{small})"
__{}    push AF             ; 1:11      fce_deq   h2 l2 rt h2 h1 l1
__{}    ex  (SP),HL         ; 1:19      fce_deq   h2 l2 rt l1 h1 h2
__{}    or    A             ; 1:4       fce_deq   h2 l2 rt l1 h1 h2
__{}    sbc  HL, DE         ; 2:15      fce_deq   h2 l2 rt l1 h1 --  hi16(d2)-hi16(d1) --> nz if false
__{}    pop  HL             ; 1:10      fce_deq   h2 l2 rt .. h1 l1
__{}    ret  nz             ; 1:5/11    fce_deq   h2 l2 .. .. h1 l1
__{}    sbc  HL, BC         ; 2:15      fce_deq   h2 l2 rt .. h1 --  lo16(d1)-lo16(d2) --> nz if false
__{}    add  HL, BC         ; 1:11      fce_deq   h2 l2 rt .. h1 l1
__{}    ret                 ; 1:10      fce_deq   h2 l2 .. .. h1 l1},
USE_FCE_DEQ,{fast},{dnl
__{}FCE_DEQ:       ;[16:86/23,36,74,86] fce_deq   ( d2 ret d1 -- d2 d1 )   # fast version because "define({_USE_FCE_DEQ},{fast})"
__{}    ex   AF, AF'        ; 1:4       fce_deq   h2 l2 rt .. h1 l1
__{}    ld    A, L          ; 1:4       fce_deq   h2 l2 rt .. h1 l1  lo8(d1) ^ lo8(d2) --> nz if false
__{}    xor   C             ; 1:4       fce_deq   h2 l2 rt .. h1 l1
__{}    ret  nz             ; 1:5/11    fce_deq   h2 l2 .. .. h1 l1
__{}    ld    A, H          ; 1:4       fce_deq   h2 l2 rt .. h1 l1  lo16(d1)^lo16(d2) --> nz if false
__{}    xor   B             ; 1:4       fce_deq   h2 l2 rt .. h1 l1
__{}    ret  nz             ; 1:5/11    fce_deq   h2 l2 .. .. h1 l1
__{}    ex   AF, AF'        ; 1:4       fce_deq   h2 l2 rt .. h1 l1
__{}    push AF             ; 1:11      fce_deq   h2 l2 rt h2 h1 l1
__{}    pop  BC             ; 1:10      fce_deq   h2 l2 rt .. h1 l1
__{}    ld    A, E          ; 1:4       fce_deq   h2 l2 rt .. h1 l1  lo24(d1)^lo24(d2) --> nz if false
__{}    xor   C             ; 1:4       fce_deq   h2 l2 rt .. h1 l1
__{}    ret  nz             ; 1:5/11    fce_deq   h2 l2 .. .. h1 l1
__{}    ld    A, D          ; 1:4       fce_deq   h2 l2 rt .. h1 l1       d1 ^ d2      --> nz if false
__{}    xor   B             ; 1:4       fce_deq   h2 l2 rt .. h1 l1
__{}    ret                 ; 1:10      fce_deq   h2 l2 .. .. h1 l1},
__{}{dnl
__{}FCE_DEQ:          ;[13:95/70,83,95] fce_deq   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DEQ},{small})" or fast
__{}    push AF             ; 1:11      fce_deq   h2 l2 rt h2 h1 l1
__{}    ex  (SP),HL         ; 1:19      fce_deq   h2 l2 rt l1 h1 h2
__{}    or    A             ; 1:4       fce_deq   h2 l2 rt l1 h1 h2
__{}    sbc  HL, DE         ; 2:15      fce_deq   h2 l2 rt l1 h1 --  hi16(d2)-hi16(d1) --> nz if false
__{}    pop  HL             ; 1:10      fce_deq   h2 l2 rt .. h1 l1
__{}    ret  nz             ; 1:5/11    fce_deq   h2 l2 .. .. h1 l1
__{}    ld    A, L          ; 1:4       fce_deq   h2 l2 rt .. h1 l1  lo8(d1) ^ lo8(d2) --> nz if false
__{}    xor   C             ; 1:4       fce_deq   h2 l2 rt .. h1 l1
__{}    ret  nz             ; 1:5/11    fce_deq   h2 l2 .. .. h1 l1
__{}    ld    A, H          ; 1:4       fce_deq   h2 l2 rt .. h1 l1  lo16(d1)^lo16(d2) --> nz if false
__{}    xor   B             ; 1:4       fce_deq   h2 l2 rt .. h1 l1
__{}    ret                 ; 1:10      fce_deq   h2 l2 .. .. h1 l1})}){}dnl
dnl
dnl
dnl
ifdef({USE_FCE_4DUP_DLT},{ifdef({USE_FCE_DLT},,define({USE_FCE_DLT},{yes}))
;==============================================================================
; ( d2 ret d1 -- d2 d1 )
;  In: (SP+4) = h2, (SP+2) = l2, (SP) = ret
; Out: (SP+2) = h2, (SP)   = l2, (SP) = ret, AF = h2, BC = l2
FCE_4DUP_DLT:           ;[9:75]     fce_4dup_dlt   ( d2 ret d1 -- d2 d1 )
    pop  AF             ; 1:10      fce_4dup_dlt   h2 l2 .. ..  AF = ret
    pop  BC             ; 1:10      fce_4dup_dlt   h2 .. .. ..  BC = l2
    ex   AF, AF'        ; 1:4       fce_4dup_dlt   h2 .. .. ..
    pop  AF             ; 1:10      fce_4dup_dlt   .. .. .. ..  AF'= h2
    push AF             ; 1:11      fce_4dup_dlt   h2 .. .. ..
    push BC             ; 1:11      fce_4dup_dlt   h2 l2 .. ..
    ex   AF, AF'        ; 1:4       fce_4dup_dlt   h2 l2 .. ..
    push AF             ; 1:11      fce_4dup_dlt   h2 l2 rt ..
    ex   AF, AF'        ; 1:4       fce_4dup_dlt   h2 l2 rt ..  AF = h2
    ; fall to fce_dlt}){}dnl
ifdef({USE_FCE_DLT},{
;==============================================================================
; ( d2 ret d1 -- d1 )
; set carry if d2<d1 is true
;  In: AF = h2, BC = l2, DE = h1, HL = l1
; Out:          BC = h2, DE = h1, HL = l1, set carry if true
ifelse(eval(ifelse(USE_FCE_DLT,{small},{1},{0}) && ifdef({USE_FCE_DULT},{0},{1})),{1},{dnl
__{}FCE_DLT:               ;[15:79]     fce_dlt   ( d2 ret d1 -- d2 d1 )   # small version because "define({_USE_FCE_DLT},{small})"
__{}    push AF             ; 1:11      fce_dlt   h2 l2 rt h2 h1 l1
__{}    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  d2<d1 --> d2-d1<0 --> AFBC-DEHL<0 --> carry if true
__{}    sub   L             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  C-L<0 --> carry if true
__{}    ld    A, B          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1
__{}    sbc   A, H          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  B-H<0 --> carry if true
__{}    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1
__{}    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}    sbc   A, E          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1  C-E<0 --> carry if true
__{}    ld    A, B          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}    sbc   A, D          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1  B-D<0 --> carry if true
__{}    rra                 ; 1:4       fce_dlt   h2 l2 rt .. h1 l1        --> sign  if true
__{}    xor   B             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}    xor   D             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}    add   A, A          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1        --> carry if true
__{}    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1},
__{}{dnl
__{}ifdef({USE_FCE_DULT},{dnl
__{}__{}FCE_DLT:               ;[10:58,71]  fce_dlt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DLT},{small})"
__{}__{}    push AF             ; 1:11      fce_dlt   h2 l2 rt h2 h1 l1  d2<d1 --> d2-d1<0 --> AFBC-DEHL<0 --> carry if true
__{}__{}    sub   D             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  A-D<0 --> carry if true
__{}__{}    jr    z, FCE_DULT_2 ; 2:7/12    fce_dlt   h2 l2 rt h2 h1 l1
__{}__{}    rra                 ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1        --> sign  if true
__{}__{}    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1
__{}__{}    xor   B             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}__{}    xor   D             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}__{}    add   A, A          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1        --> carry if true
__{}__{}    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1},
__{}{dnl
__{}__{}FCE_DLT:               ;[18:58,71]  fce_dlt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DLT},{small})"
__{}__{}    push AF             ; 1:11      fce_dlt   h2 l2 rt h2 h1 l1  d2<d1 --> d2-d1<0 --> AFBC-DEHL<0 --> carry if true
__{}__{}    sub   D             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  A-D<0 --> carry if true
__{}__{}    jr    z, $+8        ; 2:7/12    fce_dlt   h2 l2 rt h2 h1 l1
__{}__{}    rra                 ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1        --> sign  if true
__{}__{}    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1
__{}__{}    xor   B             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}__{}    xor   D             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}__{}    add   A, A          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1        --> carry if true
__{}__{}    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1
__{}__{}    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1
__{}__{}    sub   L             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  C-L<0 --> carry if true
__{}__{}    ld    A, B          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1
__{}__{}    sbc   A, H          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  B-H<0 --> carry if true
__{}__{}    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1  BC = hi16(d2)
__{}__{}    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}__{}    sbc   A, E          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1  C-E<0 --> carry if true
__{}__{}    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1})})}){}dnl
dnl
ifdef({USE_FCE_DULT},{
;==============================================================================
; ( d2 ret d1 -- d1 )
; set carry if d2 u< d1 is true
;  In: AF = h2, BC = l2, DE = h1, HL = l1
; Out:          BC = h2, DE = h1, HL = l1, set carry if true
FCE_DULT:              ;[14:42,71]  fce_dult   ( d2 ret d1 -- d2 d1 )
    push AF             ; 1:11      fce_dult   h2 l2 rt h2 h1 l1  d2<d1 --> d2-d1<0 --> AFBC-DEHL<0 --> carry if true
    sub   D             ; 1:4       fce_dult   h2 l2 rt h2 h1 l1  A-D<0 --> carry if true
    jr    z, FCE_DULT_2 ; 2:7/12    fce_dult   h2 l2 rt h2 h1 l1
    pop  BC             ; 1:10      fce_dult   h2 l2 rt .. h1 l1
    ret                 ; 1:10      fce_dult   h2 l2 .. .. h1 l1
FCE_DULT_2:             ;           fce_dult   h2 l2 rt h2 h1 l1
    ld    A, C          ; 1:4       fce_dult   h2 l2 rt h2 h1 l1
    sub   L             ; 1:4       fce_dult   h2 l2 rt h2 h1 l1  C-L<0 --> carry if true
    ld    A, B          ; 1:4       fce_dult   h2 l2 rt h2 h1 l1
    sbc   A, H          ; 1:4       fce_dult   h2 l2 rt h2 h1 l1  B-H<0 --> carry if true
    pop  BC             ; 1:10      fce_dult   h2 l2 rt .. h1 l1  BC = hi16(d2)
    ld    A, C          ; 1:4       fce_dult   h2 l2 rt .. h1 l1
    sbc   A, E          ; 1:4       fce_dult   h2 l2 rt .. h1 l1  C-E<0 --> carry if true
    ret                 ; 1:10      fce_dult   h2 l2 .. .. h1 l1}){}dnl
dnl
dnl
dnl
dnl
dnl
ifdef({USE_FCE_4DUP_DGT},{ifdef({USE_FCE_DGT},,define({USE_FCE_DGT},{yes}))
;==============================================================================
; ( d2 ret d1 -- d2 d1 )
;  In: (SP+4) = h2, (SP+2) = l2, (SP) = ret
; Out: (SP+2) = h2, (SP)   = l2, (SP) = ret, AF = h2, BC = l2
FCE_4DUP_DGT:           ;[9:75]     fce_4dup_dgt   ( d2 ret d1 -- d2 d1 )
    pop  AF             ; 1:10      fce_4dup_dgt   h2 l2 .. ..  AF = ret
    pop  BC             ; 1:10      fce_4dup_dgt   h2 .. .. ..  BC = l2
    ex   AF, AF'        ; 1:4       fce_4dup_dgt   h2 .. .. ..
    pop  AF             ; 1:10      fce_4dup_dgt   .. .. .. ..  AF'= h2
    push AF             ; 1:11      fce_4dup_dgt   h2 .. .. ..
    push BC             ; 1:11      fce_4dup_dgt   h2 l2 .. ..
    ex   AF, AF'        ; 1:4       fce_4dup_dgt   h2 l2 .. ..
    push AF             ; 1:11      fce_4dup_dgt   h2 l2 rt ..
    ex   AF, AF'        ; 1:4       fce_4dup_dgt   h2 l2 rt ..  AF = h2
    ; fall to fce_dgt}){}dnl
ifdef({USE_FCE_DGT},{
;==============================================================================
; ( d2 ret d1 -- d1 )
; carry if d2>d1 is true
;  In: AF = h2, BC = l2, DE = h1, HL = l1
; Out:          BC = h2, DE = h1, HL = l1, set carry if true
ifelse(eval(ifelse(USE_FCE_DGT,{small},{1},{0}) && ifdef({USE_FCE_DUGT},{0},{1})),{1},{dnl
__{}FCE_DGT:               ;[15:79]     fce_dgt   ( d2 ret d1 -- d2 d1 )   # small version because "define({_USE_FCE_DGT},{small})"
__{}    push AF             ; 1:11      fce_dgt   h2 l2 rt h2 h1 l1  d2>d1 --> 0>d1-d2 --> 0>DEHL-AFBC --> carry if true
__{}    ld    A, L          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
__{}    sub   C             ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>L-C --> carry if true
__{}    ld    A, H          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
__{}    sbc   A, B          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>H-B --> carry if true
__{}    pop  BC             ; 1:10      fce_dgt   h2 l2 rt .. h1 l1
__{}    ld    A, E          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1
__{}    sbc   A, C          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>E-C --> carry if true
__{}    ld    A, D          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1
__{}    sbc   A, B          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>D-B --> carry if true
__{}    rra                 ; 1:4       fce_dgt   h2 l2 rt .. h1 l1        --> sign  if true
__{}    xor   B             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1
__{}    xor   D             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1
__{}    add   A, A          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1        --> carry if true
__{}    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1},
__{}{dnl
__{}ifdef({USE_FCE_DUGT},{dnl
__{}__{}FCE_DGT:               ;[14:60,71]  fce_dgt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DGT},{small})"
__{}__{}    push AF             ; 1:11      fce_dgt   h2 l2 rt h2 h1 l1  d2>d1 --> 0>d1-d2 --> 0>DEHL-AFBC --> carry if true
__{}__{}    xor   D             ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  A==D?
__{}__{}    jr    z, FCE_DUGT_2 ; 2:7/12    fce_dgt   h2 l2 rt h2 h1 l1
__{}__{}    pop  BC             ; 1:10      fce_dgt   h2 l2 rt .. h1 l1
__{}__{}    jp    p, $+6        ; 3:10      fce_dgt   h2 l2 rt .. h1 l1
__{}__{}    ld    A, B          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  opposite signs
__{}__{}    sub   D             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>B-D --> carry if true
__{}__{}    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
__{}__{}    ld    A, D          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  identical signs
__{}__{}    sub   B             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>D-B --> carry if true
__{}__{}    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1},
__{}{dnl
__{}__{}FCE_DGT:               ;[22:60,71]  fce_dgt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DGT},{small})"
__{}__{}    push AF             ; 1:11      fce_dgt   h2 l2 rt h2 h1 l1  d2>d1 --> 0>d1-d2 --> 0>DEHL-AFBC --> carry if true
__{}__{}    xor   D             ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  A==D?
__{}__{}    jr    z, $+12       ; 2:7/12    fce_dgt   h2 l2 rt h2 h1 l1
__{}__{}    pop  BC             ; 1:10      fce_dgt   h2 l2 rt .. h1 l1
__{}__{}    jp    p, $+6        ; 3:10      fce_dgt   h2 l2 rt .. h1 l1
__{}__{}    ld    A, B          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  opposite signs
__{}__{}    sub   D             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>B-D --> carry if true
__{}__{}    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
__{}__{}    ld    A, D          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  identical signs
__{}__{}    sub   B             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>D-B --> carry if true
__{}__{}    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
__{}__{}    ld    A, L          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
__{}__{}    sub   C             ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>L-C --> carry if true
__{}__{}    ld    A, H          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
__{}__{}    sbc   A, B          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>H-B --> carry if true
__{}__{}    pop  BC             ; 1:10      fce_dgt   h2 l2 rt .. h1 l1
__{}__{}    ld    A, E          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1
__{}__{}    sbc   A, C          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>E-C --> carry if true
__{}__{}    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1})})}){}dnl
dnl
ifdef({USE_FCE_DUGT},{
;==============================================================================
; ( d2 ret d1 -- d1 )
; carry if d2 u> d1 is true
;  In: AF = h2, BC = l2, DE = h1, HL = l1
; Out:          BC = h2, DE = h1, HL = l1, set carry if true
FCE_DUGT:              ;[15:46,71]  fce_dugt   ( d2 ret d1 -- d2 d1 )
    push AF             ; 1:11      fce_dugt   h2 l2 rt h2 h1 l1  d2>d1 --> 0>d1-d2 --> 0>DEHL-AFBC --> carry if true
    sub   D             ; 1:4       fce_dugt   h2 l2 rt h2 h1 l1  A==D?
    jr    z, FCE_DUGT_2 ; 2:7/12    fce_dugt   h2 l2 rt h2 h1 l1
    pop  BC             ; 1:10      fce_dugt   h2 l2 rt .. h1 l1
    ccf                 ; 1:4       fce_dugt   h2 l2 rt .. h1 l1
    ret                 ; 1:10      fce_dugt   h2 l2 .. .. h1 l1
FCE_DUGT_2:             ;           fce_dugt   h2 l2 rt h2 h1 l1
    ld    A, L          ; 1:4       fce_dugt   h2 l2 rt h2 h1 l1
    sub   C             ; 1:4       fce_dugt   h2 l2 rt h2 h1 l1  0>L-C --> carry if true
    ld    A, H          ; 1:4       fce_dugt   h2 l2 rt h2 h1 l1
    sbc   A, B          ; 1:4       fce_dugt   h2 l2 rt h2 h1 l1  0>H-B --> carry if true
    pop  BC             ; 1:10      fce_dugt   h2 l2 rt .. h1 l1
    ld    A, E          ; 1:4       fce_dugt   h2 l2 rt .. h1 l1
    sbc   A, C          ; 1:4       fce_dugt   h2 l2 rt .. h1 l1  0>E-C --> carry if true
    ret                 ; 1:10      fce_dugt   h2 l2 .. .. h1 l1}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
ifdef({USE_PUMUL},{
;==============================================================================
include(M4PATH{}divmul/pumul.m4){}dnl
}){}dnl
dnl
dnl
dnl
ifdef({USE_PUDIVMOD},{
;==============================================================================
include(M4PATH{}divmul/pudivmod.m4){}dnl
}){}dnl
dnl
dnl
dnl
ifdef({USE_MUL},{
;==============================================================================
include(M4PATH{}divmul/mul.m4){}dnl
}){}dnl
dnl
dnl
dnl
ifdef({USE_DIV},{__def({USE_UDIV})
;==============================================================================
include(M4PATH{}divmul/div.m4){}dnl
}){}dnl
dnl
dnl
dnl
ifdef({USE_UDIV},{
;==============================================================================
include(M4PATH{}divmul/udiv.m4){}dnl
}){}dnl
dnl
dnl
dnl
ifdef({USE_S16MUL},{define({USE_U16MUL},{})
;==============================================================================
S16MUL:
; ( x1 x2 -- d )
; DE       * HL        = DE * HL
; DE       *(HL-65536) = DE * HL - DE<<16
;(DE-65536)* HL        = DE * HL          - HL<<16
;(DE-65536)*(HL-65536) = DE * HL - DE<<16 - HL<<16 + 0
;   DEHL = DE * HL
; Out: A = 0, BC = HL, DEHL = DE * HL
    push DE             ; 1:11      s16mul
    push HL             ; 1:11      s16mul
    call U16MUL         ; 3:17      s16mul
    pop  AF             ; 1:10      s16mul   HL original
    pop  BC             ; 1:10      s16mul   DE original
    push HL             ; 1:11      s16mul   save LO
    ex   DE, HL         ; 1:4       s16mul
    push AF             ; 1:11      s16mul   HL
    or    A             ; 1:4       s16mul   sign HL original
    jp    p, $+5        ; 3:10      s16mul
    sbc  HL, BC         ; 2:15      s16mul   hi(result) - DE original
    ld    A, B          ; 1:4       s16mul
    or    A             ; 1:4       s16mul   sign DE original
    pop  BC             ; 1:4       s16mul
    jp    p, $+5        ; 3:10      s16mul
    sbc  HL, BC         ; 2:15      s16mul   hi(result) - HL original
    ex   DE, HL         ; 1:4       s16mul
    pop  HL             ; 1:10      s16mul   load LO
    ret                 ; 1:10      s16mul}){}dnl
dnl
dnl
dnl
ifdef({USE_U16MUL},{
;==============================================================================
U16MUL:
; ( u1 u2 -- ud )
;   DEHL = DE * HL
; Out: A = 0, BC = HL, DEHL = DE * HL
    ld    B, H          ; 1:4       u16mul
    ld    C, L          ; 1:4       u16mul
    ld   HL, 0x0000     ; 3:10      u16mul
    ld    A, 0x10       ; 2:7       u16mul
    add  HL, HL         ; 1:11      u16mul
    rl    E             ; 2:8       u16mul
    rl    D             ; 2:8       u16mul
    jr   nc, $+6        ; 2:7/12    u16mul
    add  HL, BC         ; 1:11      u16mul
    jr   nc, $+3        ; 2:7/12    u16mul
    inc  DE             ; 1:6       u16mul
    dec   A             ; 1:4       u16mul
    jp   nz, $-12       ; 3:10      u16mul
    ret                 ; 1:10      u16mul}){}dnl
dnl
dnl
dnl
ifdef({zzzUSE_U16MUL},{
;==============================================================================
_U16MUL:
; ( u1 u2 -- ud )
;   DEHL = DE * HL
; Out: A = 0, BC = HL, DEHL = DE * HL
    ld    C, H          ; 1:4       u16mul
    ld    A, L          ; 1:4       u16mul
    ld   HL, 0x0000     ; 3:10      u16mul
    ld    B, 0x10       ; 2:7       u16mul
U16MUL_L:               ;           u16mul
    add  HL, HL         ; 1:11      u16mul
    adc   A, A          ; 1:4       u16mul
    rl    C             ; 2:8       u16mul   CAHL << 1
    jr   nc, $+8        ; 2:7/12    u16mul
    add  HL, DE         ; 1:11      u16mul
    adc   A, 0x00       ; 2:7       u16mul
    jr   nc, $+3        ; 2:7/12    u16mul
    inc   C             ; 1:4       u16mul
    djnz U16MUL_L       ; 3:10      u16mul
    ld    D, C          ; 1:4       u16mul
    ld    E, A          ; 1:4       u16mul
    ret                 ; 1:10      u16mul}){}dnl
dnl
dnl
dnl
ifdef({USE_F32DIV16},{define({USE_S32DIV16},{})
;==============================================================================
F32DIV16:
; ( lo n -- floored_remainder floored_quotient ), BC = hi
; fm/mod ( d n -- rem quot )
; ( d x -- d%x d/x )
    push HL             ; 1:11      f32div16    ret n DE=lo HL=n, BC = hi
    call  S32DIV16      ; 3:17      f32div16
    pop  BC             ; 1:10      f32div16    n
    ld    A, D          ; 1:4       f32div16
    or    E             ; 1:4       f32div16
    ret   z             ; 1:5/11    f32div16    remainder is 0
    ld    A, D          ; 1:4       f32div16
    xor   B             ; 1:4       f32div16
    ret   p             ; 1:5/11    f32div16    remainder has a same sign than the divisor
    ex   DE, HL         ; 1:4       f32div16
    add  HL, BC         ; 1:11      f32div16
    ex   DE, HL         ; 1:4       f32div16
    dec  HL             ; 1:6       f32div16
    ret                 ; 1:10      f32div16}){}dnl
dnl
dnl
dnl
ifdef({USE_S32DIV16},{define({USE_U31DIV15},{})
;==============================================================================
S32DIV16:
; ( lo n -- symmetric_remainder symmetric_quotient ), BC = hi
; sm/rem ( d n -- rem quot )
; ( d x -- d%x d/x )

    ld    A, B          ; 1:4       s32div16
    xor   H             ; 1:4       s32div16
    push AF             ; 1:11      s32div16   save sign product
    xor   H             ; 1:4       s32div16
    push AF             ; 1:11      s32div16   save sign "d" = sign remainder
    jp    p, $+17       ; 3:10      s32div16
    xor   A             ; 1:4       s32div16   negate_32
    sub   E             ; 1:4       s32div16   negate_32
    ld    E, A          ; 1:4       s32div16   negate_32
    ld    A, 0x00       ; 2:7       s32div16   negate_32
    sbc   A, D          ; 1:4       s32div16   negate_32
    ld    D, A          ; 1:4       s32div16   negate_32
    ld    A, 0x00       ; 2:7       s32div16   negate_32
    sbc   A, C          ; 1:4       s32div16   negate_32
    ld    C, A          ; 1:4       s32div16   negate_32
    sbc   A, B          ; 1:4       s32div16   negate_32
    sub   C             ; 1:4       s32div16   negate_32
    ld    B, A          ; 1:4       s32div16   negate_32
    xor   A             ; 1:4       s32div16
    or    H             ; 1:4       s32div16   sign "n"
    jp    p, $+9        ; 3:10      s32div16
    xor   A             ; 1:4       s32div16   negate
    sub   L             ; 1:4       s32div16   negate
    ld    L, A          ; 1:4       s32div16   negate
    sbc   A, H          ; 1:4       s32div16   negate
    sub   L             ; 1:4       s32div16   negate
    ld    H, A          ; 1:4       s32div16   negate
    call  U31DIV15      ; 3:17      s32div16
    pop   AF            ; 1:10      s32div16   load sign remainder
    jp    p, $+9        ; 3:10      s32div16
    xor   A             ; 1:4       s32div16   negate
    sub   E             ; 1:4       s32div16   negate
    ld    E, A          ; 1:4       s32div16   negate
    sbc   A, D          ; 1:4       s32div16   negate
    sub   E             ; 1:4       s32div16   negate
    ld    D, A          ; 1:4       s32div16   negate
    pop   AF            ; 1:10      s32div16   load sign product
    ret   p             ; 1:5/11    s32div16
    xor   A             ; 1:4       s32div16   negate
    sub   L             ; 1:4       s32div16   negate
    ld    L, A          ; 1:4       s32div16   negate
    sbc   A, H          ; 1:4       s32div16   negate
    sub   L             ; 1:4       s32div16   negate
    ld    H, A          ; 1:4       s32div16   negate
    ret                 ; 1:10      s32div16}){}dnl
dnl
dnl
dnl
ifdef({USE_U31DIV15},{ifelse(TYP_U31DIV15,{fast},{
;==============================================================================
U31DIV15:               ;[86:604+16*(quot bit 0:1=22:12)]
; 796..956 tclock
; # fast version can be changed with "define({TYP_U31DIV15},{name})", name=fast,small,default
; ( lo u -- remainder quotient ), BC = hi
; um/mod ( ud u -- rem quot )
; ( ud u -- ud%u ud/u )
; HL = BCDE / HL, DE = BCDE % HL, "u" <= 0x8000, hi("ud") < 0x8000, "u" > hi("ud")
; vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
; HL = HLDE / BC, DE = HLDE % BC
    xor   A             ; 1:4       u31div15
    sub   L             ; 1:4       u31div15
    ld    L, C          ; 1:4       u31div15
    ld    C, A          ; 1:4       u31div15
    sbc   A, A          ; 1:4       u31div15
    sub   H             ; 1:4       u31div15
    ld    H, B          ; 1:4       u31div15
    ld    B, A          ; 1:4       u31div15   BC = -"u"
U31DIV15_L              ;           u31div15
    ld    A, D          ; 1:4       u31div15
    call U31DIV15_BYTE  ; 3:17      u31div15
    ld    D, A          ; 1:4       u31div15
    ld    A, E          ; 1:4       u31div15
    call U31DIV15_BYTE  ; 3:17      u31div15
    ld    E, A          ; 1:4       u31div15
    ex   DE, HL         ; 1:4       u31div15
    ret                 ; 1:10      u31div15

U31DIV15_BYTE:          ;[66:254+8*(quot bit 0:1=22:12)]
    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    jr    c, $+4        ; 2:7/12    u31div15
    sbc  HL, BC         ; 2:15      u31div15

    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    jr    c, $+4        ; 2:7/12    u31div15
    sbc  HL, BC         ; 2:15      u31div15

    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    jr    c, $+4        ; 2:7/12    u31div15
    sbc  HL, BC         ; 2:15      u31div15

    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    jr    c, $+4        ; 2:7/12    u31div15
    sbc  HL, BC         ; 2:15      u31div15

    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    jr    c, $+4        ; 2:7/12    u31div15
    sbc  HL, BC         ; 2:15      u31div15

    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    jr    c, $+4        ; 2:7/12    u31div15
    sbc  HL, BC         ; 2:15      u31div15

    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    jr    c, $+4        ; 2:7/12    u31div15
    sbc  HL, BC         ; 2:15      u31div15

    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    jr    c, $+4        ; 2:7/12    u31div15
    sbc  HL, BC         ; 2:15      u31div15

    adc   A, A          ; 1:4       u31div15     A << 1
    ret                 ; 1:10      u31div15},
TYP_U31DIV15,{small},{
;==============================================================================
U31DIV15:               ;[26:48+16*(quot bit 0:1=81:71)]
; 1184..1344 tclock
; # small version can be changed with "define({TYP_U31DIV15},{name})", name=fast,small,default
; ( lo u -- remainder quotient ), BC = hi
; um/mod ( ud u -- rem quot )
; ( ud u -- ud%u ud/u )
; HL = BCDE / HL, DE = BCDE % HL, "u" <= 0x8000, hi("ud") < 0x8000, "u" > hi("ud")
; vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
; HL = HLBC / DE, DE = HLBC % DE
    ex   DE, HL         ; 1:4       u31div15
    ld    A, L          ; 1:4       u31div15
    ld    L, C          ; 1:4       u31div15
    ld    C, A          ; 1:4       u31div15
    ld    A, H          ; 1:4       u31div15
    ld    H, B          ; 1:4       u31div15   HLAC = "ud"
    ld    B, 0x10       ; 2:7       u31div15
U31DIV15_L              ;           u31div15
    sla   C             ; 2:8       u31div15
    rla                 ; 1:4       u31div15     AC << 1
    adc  HL, HL         ; 2:15      u31div15   HLAC << 1
    sbc  HL, DE         ; 2:15      u31div15   HL/DE
    inc   C             ; 1:4       u31div15
    jr   nc, $+4        ; 2:7/12    u31div15
    add  HL, DE         ; 1:11      u31div15
    dec   C             ; 1:4       u31div15
    djnz U31DIV15_L     ; 2:13/8    u31div15
    ld    E, C          ; 1:4       u31div15
    ld    D, A          ; 1:4       u31div15
    ex   DE, HL         ; 1:4       u31div15
    ret                 ; 1:10      u31div15},
{
;==============================================================================
U31DIV15:               ;[44:206+8*(quot bit 00,01,10,11:112,93,102,83)]
; 870..950..1022..1102 tclock
; # default version can be changed with "define({TYP_U31DIV15},{name})", name=fast,small,default
; ( lo u -- remainder quotient ), BC = hi
; um/mod ( ud u -- rem quot )
; ( ud u -- ud%u ud/u )
; HL = BCDE / HL, DE = BCDE % HL, "u" <= 0x8000, hi("ud") < 0x8000, "u" > hi("ud")
; vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
; HL = HLDE / BC, DE = HLDE % BC
    xor   A             ; 1:4       u31div15
    sub   L             ; 1:4       u31div15
    ld    L, C          ; 1:4       u31div15
    ld    C, A          ; 1:4       u31div15
    sbc   A, A          ; 1:4       u31div15
    sub   H             ; 1:4       u31div15
    ld    H, B          ; 1:4       u31div15
    ld    B, A          ; 1:4       u31div15   BC = -"u"
U31DIV15_L              ;           u31div15
    ld    A, D          ; 1:4       u31div15
    call U31DIV15_BYTE  ; 3:17      u31div15
    adc   A, A          ; 1:4       u31div15
    ld    D, A          ; 1:4       u31div15
    ld    A, E          ; 1:4       u31div15
    call U31DIV15_BYTE  ; 3:17      u31div15
    adc   A, A          ; 1:4       u31div15
    ld    E, A          ; 1:4       u31div15
    ex   DE, HL         ; 1:4       u31div15
    ret                 ; 1:10      u31div15

U31DIV15_BYTE:          ;[22:51+4*(quot bit 00,01,10,11:112,93,102,83)]
    call  $+3           ; 3:17      u31div15   4x
    call  $+3           ; 3:17      u31div15   2x

U31DIV15_2BIT:          ;[16:quot bit 00,01,10,11:112,93,102,83]
    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    jr    c, $+4        ; 2:7/12    u31div15
    sbc  HL, BC         ; 2:15      u31div15

    adc   A, A          ; 1:4       u31div15     A << 1
    adc  HL, HL         ; 2:15      u31div15   HLA << 1
    add  HL, BC         ; 1:11      u31div15   HL/BC
    ret   c             ; 1:5/11    u31div15
    sbc  HL, BC         ; 2:15      u31div15
    ret                 ; 1:10      u31div15}){}dnl
}){}dnl
dnl
dnl
dnl
ifdef({USE_U32DIV16},{ifelse(TYP_U32DIV16,{small},{
;==============================================================================
U32DIV16:               ;[37:60+16*(quot bit 0:1/carry=88:78/73)]
; 1308..1468 tclock, average 1388 tclock
; # small version can be changed with "define({TYP_U32DIV16},{name})", name=default,small,test,test2,...
; ( lo u -- remainder quotient ), BC = hi
; um/mod ( ud u -- rem quot )
; ( ud u -- ud%u ud/u )
; HL = BCDE / HL, DE = BCDE % HL, "u" > hi("ud")
; vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
; HL = HLAC / DE, DE = HLAC % DE
    ex   DE, HL         ; 1:4       u32div16
    ld    A, L          ; 1:4       u32div16
    ld    L, C          ; 1:4       u32div16
    ld    C, A          ; 1:4       u32div16
    ld    A, H          ; 1:4       u32div16
    ld    H, B          ; 1:4       u32div16   HLAC = "ud"
    ld    B, 0x10       ; 2:7       u32div16
    jr   U32DIV16_L     ; 2:12      u32div16
U32DIV16_C              ;           u32div16
    or    A             ; 1:4       u32div16
    sbc  HL, DE         ; 2:15      u32div16   1HL/DE
    inc   C             ; 1:4       u32div16
    dec   B             ; 1:4       u32div16
    jr    z, U32DIV16_E ; 2:7/12    u32div16
U32DIV16_L              ;           u32div16
    sla   C             ; 2:8       u32div16
    rla                 ; 1:4       u32div16     AC << 1
    adc  HL, HL         ; 2:15      u32div16   HLAC << 1
    jr    c, U32DIV16_C ; 2:7/12    u32div16
    sbc  HL, DE         ; 2:15      u32div16   0HL/DE
    inc   C             ; 1:4       u32div16
    jr   nc, $+4        ; 2:7/12    u32div16
    add  HL, DE         ; 1:11      u32div16
    dec   C             ; 1:4       u32div16
    djnz U32DIV16_L     ; 2:13/8    u32div16
U32DIV16_E:             ;           u32div16
    ld    E, C          ; 1:4       u32div16
    ld    D, A          ; 1:4       u32div16
    ex   DE, HL         ; 1:4       u32div16
    ret                 ; 1:10      u32div16},
TYP_U32DIV16,{test},{
;==============================================================================
U32DIV16:               ;[42:60+16*(quot bit 0:1/carry=83:73/75)]
; 1228..1388 tclock, average 1308 tclock
; # test version can be changed with "define({TYP_U32DIV16},{name})", name=default,small,test,test2,...
; ( lo u -- remainder quotient ), BC = hi
; um/mod ( ud u -- rem quot )
; ( ud u -- ud%u ud/u )
; HL = BCDE / HL, DE = BCDE % HL, "u" > hi("ud")
; vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
; HL = HLAC / DE, DE = HLAC % DE
    ex   DE, HL         ; 1:4       u32div16
    ld    A, L          ; 1:4       u32div16
    ld    L, C          ; 1:4       u32div16
    ld    C, A          ; 1:4       u32div16
    ld    A, H          ; 1:4       u32div16
    ld    H, B          ; 1:4       u32div16   HLAC = "ud"
    ld    B, 0x10       ; 2:7       u32div16
    jr   U32DIV16_L     ; 2:12      u32div16
U32DIV16_0              ;           u32div16
    add  HL, DE         ; 1:11      u32div16
    dec   B             ; 1:4       u32div16
    jr    z, U32DIV16_E ; 2:7/12    u32div16
U32DIV16_L              ;           u32div16
    sla   C             ; 2:8       u32div16
    rla                 ; 1:4       u32div16     AC << 1
    adc  HL, HL         ; 2:15      u32div16   HLAC << 1
    jr    c, U32DIV16_C ; 2:7/12    u32div16
    sbc  HL, DE         ; 2:15      u32div16   0HL/DE
    jr    c, U32DIV16_0 ; 2:7/12    u32div16
    inc   C             ; 1:4       u32div16
    djnz U32DIV16_L     ; 2:13/8    u32div16
U32DIV16_E:             ;           u32div16
    ld    E, C          ; 1:4       u32div16
    ld    D, A          ; 1:4       u32div16
    ex   DE, HL         ; 1:4       u32div16
    ret                 ; 1:10      u32div16
U32DIV16_C              ;           u32div16
    or    A             ; 1:4       u32div16
    sbc  HL, DE         ; 2:15      u32div16   1HL/DE
    inc   C             ; 1:4       u32div16
    djnz U32DIV16_L     ; 2:13/8    u32div16
    ld    E, C          ; 1:4       u32div16
    ld    D, A          ; 1:4       u32div16
    ex   DE, HL         ; 1:4       u32div16
    ret                 ; 1:10      u32div16},
TYP_U32DIV16,{test2},{
;==============================================================================
U32DIV16:               ;[45:80+16*(quot bit 0:1/carry=83:69/67)]
; 1184..1408 tclock, average 1296 tclock
; # test2 version can be changed with "define({TYP_U32DIV16},{name})", name=default,small,test,test2,...
; ( lo u -- remainder quotient ), BC = hi
; um/mod ( ud u -- rem quot )
; ( ud u -- ud%u ud/u )
; HL = BCDE / HL, DE = BCDE % HL, "u" > hi("ud")
; vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
; HL = HLAC / DE, DE = HLAC % DE
    xor   A             ; 1:4       u32div16
    sub   L             ; 1:4       u32div16
    ld    L, C          ; 1:4       u32div16
    ld    C, E          ; 1:4       u32div16
    ld    E, A          ; 1:4       u32div16
    sbc   A, A          ; 1:4       u32div16
    sub   H             ; 1:4       u32div16
    ld    H, B          ; 1:4       u32div16
    ld    B, D          ; 1:4       u32div16
    ld    D, A          ; 1:4       u32div16   DE = -"u"
    ld    A, B          ; 1:4       u32div16
    ld    B, 0x10       ; 2:7       u32div16
    jr   U32DIV16_L     ; 2:12      u32div16
U32DIV16_0              ;           u32div16
    sbc  HL, DE         ; 2:15      u32div16
    dec   B             ; 1:4       u32div16
    jr    z, U32DIV16_E ; 2:7/12    u32div16
U32DIV16_L              ;           u32div16
    sla   C             ; 2:8       u32div16
    rla                 ; 1:4       u32div16     AC << 1
    adc  HL, HL         ; 2:15      u32div16   HLAC << 1
    jr    c, U32DIV16_C ; 2:7/12    u32div16
    add  HL, DE         ; 1:11      u32div16   0HL/DE
    jr   nc, U32DIV16_0 ; 2:7/12    u32div16
    inc   C             ; 1:4       u32div16
    djnz U32DIV16_L     ; 2:13/8    u32div16
U32DIV16_E:             ;           u32div16
    ld    E, C          ; 1:4       u32div16
    ld    D, A          ; 1:4       u32div16
    ex   DE, HL         ; 1:4       u32div16
    ret                 ; 1:10      u32div16
U32DIV16_C              ;           u32div16
    add  HL, DE         ; 1:11      u32div16   1HL/DE
    inc   C             ; 1:4       u32div16
    djnz U32DIV16_L     ; 2:13/8    u32div16
    ld    E, C          ; 1:4       u32div16
    ld    D, A          ; 1:4       u32div16
    ex   DE, HL         ; 1:4       u32div16
    ret                 ; 1:10      u32div16},
TYP_U32DIV16,{test3},{
;==============================================================================
U32DIV16:               ;[39:83+16*(quot bit 0:1/carry=80:70/67)]
; 1203..1363 tclock, average 1283 tclock
; # test3 version can be changed with "define({TYP_U32DIV16},{name})", name=default,small,test,test2,...
; ( lo u -- remainder quotient ), BC = hi
; um/mod ( ud u -- rem quot )
; ( ud u -- ud%u ud/u )
; HL = BCDE / HL, DE = BCDE % HL, "u" > hi("ud")
; vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
; HL = HLAC / DE, DE = HLAC % DE
    xor   A             ; 1:4       u32div16
    sub   L             ; 1:4       u32div16
    ld    L, C          ; 1:4       u32div16
    ld    C, E          ; 1:4       u32div16
    ld    E, A          ; 1:4       u32div16
    sbc   A, A          ; 1:4       u32div16
    sub   H             ; 1:4       u32div16
    ld    H, B          ; 1:4       u32div16
    ld    B, D          ; 1:4       u32div16
    ld    D, A          ; 1:4       u32div16   DE = -"u"
    ld    A, B          ; 1:4       u32div16
    ld    B, 0x10       ; 2:7       u32div16
U32DIV16_L              ;           u32div16
    rl    C             ; 2:8       u32div16
    rla                 ; 1:4       u32div16     AC << 1
    adc  HL, HL         ; 2:15      u32div16   HLAC << 1
    jr    c, U32DIV16_C ; 2:7/12    u32div16
    add  HL, DE         ; 1:11      u32div16   0HL/DE
    jr    c, $+4        ; 2:7/12    u32div16
    sbc  HL, DE         ; 2:15      u32div16
    djnz U32DIV16_L     ; 2:13/8    u32div16
U32DIV16_E:             ;           u32div16
    ld    E, C          ; 1:4       u32div16
    ld    D, A          ; 1:4       u32div16
    ex   DE, HL         ; 1:4       u32div16
    adc  HL, HL         ; 2:15      u32div16
    ret                 ; 1:10      u32div16
U32DIV16_C              ;           u32div16
    add  HL, DE         ; 1:11      u32div16   1HL/DE
    scf                 ; 1:4       u32div16
    djnz U32DIV16_L     ; 2:13/8    u32div16
    jr   U32DIV16_E     ; 2:12      u32div16},
{
;==============================================================================
U32DIV16:               ;[46:144+16*(quot bit 0:1/carry=72:62/59)]
; 1136..1296 tclock, average 1216 tclock
; # default version can be changed with "define({TYP_U32DIV16},{name})", name=default,small,test,test2,...
; ( lo u -- remainder quotient ), BC = hi
; um/mod ( ud u -- rem quot )
; ( ud u -- ud%u ud/u )
; HL = BCDE / HL, DE = BCDE % HL, "u" > hi("ud")
; vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
; HL = HLAC / DE, DE = HLAC % DE
    xor   A             ; 1:4       u32div16
    sub   L             ; 1:4       u32div16
    ld    L, C          ; 1:4       u32div16
    ld    C, E          ; 1:4       u32div16
    ld    E, A          ; 1:4       u32div16
    sbc   A, A          ; 1:4       u32div16
    sub   H             ; 1:4       u32div16
    ld    H, B          ; 1:4       u32div16
    ld    B, D          ; 1:4       u32div16
    ld    D, A          ; 1:4       u32div16   DE = -"u"
    ld    A, B          ; 1:4       u32div16
    call U32DIV16_BYTE  ; 3:17      u32div16
    adc   A, A          ; 1:4       u32div16
    ld    B, A          ; 1:4       u32div16
    ld    A, C          ; 1:4       u32div16
    ld    C, B          ; 1:4       u32div16
    call U32DIV16_BYTE  ; 3:17      u32div16
    adc   A, A          ; 1:4       u32div16
    ld    E, A          ; 1:4       u32div16
    ld    D, C          ; 1:4       u32div16
    ex   DE, HL         ; 1:4       u32div16
    ret                 ; 1:10      u32div16

U32DIV16_BYTE:          ;[20:12+8*(quot bit 0:1/carry=72:62/59)]
    ld    B, 0x08       ; 2:7       u32div16
U32DIV16_L              ;           u32div16
    rla                 ; 1:4       u32div16     AC << 1
    adc  HL, HL         ; 2:15      u32div16   HLAC << 1
    jr    c, U32DIV16_C ; 2:7/12    u32div16
    add  HL, DE         ; 1:11      u32div16   0HL/DE
    jr    c, $+4        ; 2:7/12    u32div16
    sbc  HL, DE         ; 2:15      u32div16
    djnz U32DIV16_L     ; 2:13/8    u32div16
    ret                 ; 1:10      u32div16
U32DIV16_C              ;           u32div16
    add  HL, DE         ; 1:11      u32div16   1HL/DE
    scf                 ; 1:4       u32div16
    djnz U32DIV16_L     ; 2:13/8    u32div16
    ret                 ; 1:10      u32div16}){}dnl
}){}dnl
dnl
dnl
dnl
ifdef({USE_Fill3},{__def({USE_Fill2})
;==============================================================================
; ( address u char ret -- ret address+u x ) (address..address+u-1) = char
;  In: (SP+2) = address, DE = u, L = char 
; Out:  A = char
;      BC = 0
;      DE = address+u
Fill3:                  ;[4:37]     Fill3
    ld    A, L          ; 1:4       Fill3
    pop  HL             ; 1:10      Fill3   ret
    ex  (SP),HL         ; 1:19      Fill3   address
    ex   DE, HL         ; 1:4       Fill3
;   ...fall down to Fill2}){}dnl
dnl
dnl
dnl
ifdef({USE_Fill2},{__def({USE_Fill}){}dnl
__{}ifdef({USE_Fill_Over},,{
__{}  .error Not activate {USE_Fill_Over}!}){}dnl
__{}ifdef({USE_Fill_Unknown_Addr},,{
__{}  .error Not activate {USE_Fill_Unknown_Addr}!})
;==============================================================================
; ( -- ) (DE..DE+HL-1) = A
;  In: DE = address, HL = u, A=char
; Out: BC = 0
;      DE+= HL, HL>>=3
Fill2:                 ;[26:108]    Fill2
    ex   AF, AF'        ; 1:4       Fill2
    xor   A             ; 1:4       Fill2
    sub   L             ; 1:4       Fill2  -0,-1,-2,-3,-4,-5,-6,-7
    and  0x07           ; 2:7       Fill2   0, 7, 6, 5, 4, 3, 2, 1
    add   A, A          ; 1:4       Fill2   0,14,12,10, 8, 6, 4, 2
    ld  (Fill2_self+1),A; 3:13      Fill2
    dec  HL             ; 1:6       Fill2   if B=0=256 --> C--
    ld    A, L          ; 1:4       Fill2
    srl   H             ; 2:8       Fill2
    rra                 ; 1:4       Fill2   HA >> 1
    srl   H             ; 2:8       Fill2
    rra                 ; 1:4       Fill2   HA >> 2
    srl   H             ; 2:8       Fill2
    rra                 ; 1:4       Fill2   HA >> 3
    ld    C, H          ; 1:4       Fill2
    ld    B, A          ; 1:4       Fill2
    inc   C             ; 1:4       Fill2
    inc   B             ; 1:4       Fill2   B=255->256=0 ok
    ex   AF, AF'        ; 1:4       Fill2
Fill2_self:             ;           Fill2
    jr  $+0             ; 2:12      Fill2
;   ...fall down to Fill}){}dnl
ifdef({USE_Fill},{
;==============================================================================
; ( -- ) (DE_in..DE_out-1) = A{}dnl
ifelse(
__{}ifdef({USE_Fill_Over},1,0):ifdef({USE_Fill_Unknown_Addr},1,0),1:1,{
__{};  In: DE = address, A=char, u = (C-1)*2048 + B*8 - (start_address-Fill)/2
__{}; Out: BC = 0
__{};      DE+= (C-1)*2048+(B-1)*8+(Fill+16-start_address)/2
__{}Fill:    ;[22:B*117+(C-1)*29963+16] Fill
__{}    ld  (DE),A          ; 1:7       Fill  +0
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +2
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +4
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +6
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +8
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill +10
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill +12
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill +14
__{}    inc  DE             ; 1:6       Fill
__{}    djnz Fill           ; 2:8/13    Fill
__{}    dec   C             ; 1:4       Fill
__{}    jr   nz, Fill       ; 2:7/12    Fill},
__{}ifdef({USE_Fill_Over},1,0),1,{
__{};  In: DE = address, A=char, u = (C-1)*2048 + B*8 - (start_address-Fill)/2
__{}; Out: BC = 0
__{};      DE+= (C-1)*2048+(B-1)*8+(Fill+16-start_address)/2
__{}Fill:    ;[22:B*109+(C-1)*27915+16] Fill
__{}    ld  (DE),A          ; 1:7       Fill  +0
__{}    inc   E             ; 1:4       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +2
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +4
__{}    inc   E             ; 1:4       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +6
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +8
__{}    inc   E             ; 1:4       Fill
__{}    ld  (DE),A          ; 1:7       Fill +10
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill +12
__{}    inc   E             ; 1:4       Fill
__{}    ld  (DE),A          ; 1:7       Fill +14
__{}    inc  DE             ; 1:6       Fill
__{}    djnz Fill           ; 2:8/13    Fill   DE = even address
__{}    dec   C             ; 1:4       Fill
__{}    jr   nz, Fill       ; 2:7/12    Fill},
__{}ifdef({USE_Fill_Unknown_Addr},1),1,{
__{};  In: DE = address, A=char, u = B*8 - (start_address-Fill)/2
__{}; Out:  B = 0
__{};      DE+= B*8 + (Fill-start_address)/2
__{}Fill:                  ;[19:B*117+5]Fill
__{}    ld  (DE),A          ; 1:7       Fill  +0
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +2
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +4
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +6
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +8
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill +10
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill +12
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill +14
__{}    inc  DE             ; 1:6       Fill
__{}    djnz Fill           ; 2:8/13    Fill},
__{}{
__{};  In: DE = address, A=char, u = B*8 - (start_address-Fill)/2
__{}; Out:  B = 0
__{};      DE+= B*8 + (Fill-start_address)/2
__{}Fill:                  ;[19:B*109+5]Fill
__{}    ld  (DE),A          ; 1:7       Fill  +0
__{}    inc   E             ; 1:4       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +2
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +4
__{}    inc   E             ; 1:4       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +6
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill  +8
__{}    inc   E             ; 1:4       Fill
__{}    ld  (DE),A          ; 1:7       Fill +10
__{}    inc  DE             ; 1:6       Fill
__{}    ld  (DE),A          ; 1:7       Fill +12
__{}    inc   E             ; 1:4       Fill
__{}    ld  (DE),A          ; 1:7       Fill +14
__{}    inc  DE             ; 1:6       Fill
__{}    djnz Fill           ; 2:8/13    Fill   DE = even address})
    ret                 ; 1:10      Fill
}){}dnl
dnl
dnl
dnl
dnl
ifdef({USE_Random},{ifdef({USE_Rnd},,define({USE_Rnd},{}))
;==============================================================================
; ( max -- rand )
; 16-bit pseudorandom generator
; HL = random < max, or HL = 0
Random:                 ;[41:]      Random
    ld    A, H          ; 1:4       Random
    or    A             ; 1:4       Random
    jr    z, Random_0L  ; 2:7/11    Random
    ld    C, 0xFF       ; 2:7       Random
    xor   A             ; 1:4       Random
    adc   A, A          ; 1:4       Random
    cp    H             ; 1:4       Random
    jr    c, $-2        ; 2:7/11    Random
    ld    B, A          ; 1:4       Random   BC = mask = 0x??FF
    jr   Random_Begin   ; 2:12      Random
Random_0L:              ;           Random
    ld    B, A          ; 1:4       Random
    or    L             ; 1:4       Random
    ret   z             ; 1:5/11    Random
    xor   A             ; 1:4       Random
    adc   A, A          ; 1:4       Random
    cp    L             ; 1:4       Random
    jr    c, $-2        ; 2:7/11    Random
    ld    C, A          ; 1:4       Random   BC = mask = 0x00??
;------------------------------------------------------------------------------
; In: BC = mask, HL = max
; Out: HL = 0..max-1
Random_Begin:           ;           Random
    push  DE            ; 1:11      Random
    ex    DE, HL        ; 1:4       Random   DE = max
Random_Next:            ;           Random
    call Rnd            ; 3:17      Random
    ld    A, C          ; 1:4       Random
    and   L             ; 1:4       Random
    ld    L, A          ; 1:4       Random
    ld    A, B          ; 1:4       Random
    and   H             ; 1:4       Random
    ld    H, A          ; 1:4       Random
    sbc  HL, DE         ; 2:15      Random
    jr   nc, Random_Next; 2:7/11    Random
    add  HL, DE         ; 1:11      Random
    pop  DE             ; 1:10      Random
    ret                 ; 1:10      Random}){}dnl
dnl
dnl
dnl
ifdef({USE_Rnd},{
;==============================================================================
; ( -- rand )
; 16-bit pseudorandom generator
; Out: HL = 0..65535
; Pollutes: AF, AF', HL
Rnd:                    ;[44:182]   rnd
SEED_8BIT EQU $+1
    ld    L, 0x01       ; 2:7       rnd   seed must not be 0
    ld    A, L          ; 1:4       rnd
    rrca                ; 1:4       rnd
    rrca                ; 1:4       rnd
    rrca                ; 1:4       rnd
    xor  0x1F           ; 2:7       rnd   A = 32*L
    add   A, L          ; 2:7       rnd   A = 33*L
    sbc   A, 0xFF       ; 2:7       rnd   carry
    ld  (SEED_8BIT), A  ; 3:13      rnd   save new 8bit number
    ex   AF, AF'        ; 1:4       rnd
SEED EQU $+1
    ld   HL, 0x0001     ; 3:10      rnd   seed must not be 0
    ld    A, H          ; 1:4       rnd
    rra                 ; 1:4       rnd   hi.0 bit to carry
    ld    A, L          ; 1:4       rnd
    rra                 ; 1:4       rnd
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd   hi(xs) ^= hi(xs << 7);
    ld    A, L          ; 1:4       rnd
    rra                 ; 1:4       rnd   lo.0 bit to carry
    ld    A, H          ; 1:4       rnd
    rra                 ; 1:4       rnd
    xor   L             ; 1:4       rnd
    ld    L, A          ; 1:4       rnd   lo(xs) ^= lo(xs << 7) + (xs >> 9);
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd   xs ^= xs << 8;
    ld  (SEED), HL      ; 3:16      rnd   save new 16bit number
    ex   AF, AF'        ; 1:4       rnd
    xor   L             ; 1:4       rnd
    ld    L, A          ; 1:4       rnd
    ld    A, R          ; 2:9       rnd
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd
    ret                 ; 1:10      rnd}){}dnl
dnl
dnl
dnl
ifdef({USE_ACCEPT},{ifdef({USE_CLEARKEY},,define({USE_CLEARKEY},{}))
;==============================================================================
; Read string from keyboard
;  In: DE = addr_string, HL = max_length
; Out: pop stack, TOP = HL = loaded
READSTRING:
__{}ifdef({USE_ACCEPT_Z},{dnl
__{}    dec  HL             ; 1:6       readstring_z
__{}}){}dnl
    ld   BC, 0x0000     ; 3:10      readstring   loaded
    call CLEARBUFF      ; 3:17      readstring
READSTRING2:
    ld    A,(0x5C08)    ; 3:13      readstring   read new value of {LAST K}
    or    A             ; 1:4       readstring   is it still zero?
    jr    z, READSTRING2; 2:7/12    readstring

    call CLEARBUFF      ; 3:17      readstring
    ld  (DE),A          ; 1:7       readstring   save char

    cp  0x0C            ; 2:7       readstring   delete?
    jr   nz, READSTRING3; 2:7/12    readstring
    ld    A, B          ; 1:4       readstring
    or    C             ; 1:4       readstring
    jr    z, READSTRING2; 2:7/12    readstring   empty string?
    dec  DE             ; 1:6       readstring   addr--
    dec  BC             ; 1:6       readstring   loaded--
    inc  HL             ; 1:6       readstring   space++
    ld    A, 0x08       ; 2:7       readstring
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      readstring},
__{}{dnl
__{}    rst   0x10          ; 1:11      readstring   putchar(reg A) with {ZX 48K ROM}})   
    ld    A, 0x20       ; 2:7       readstring
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      readstring},
__{}{dnl
__{}    rst   0x10          ; 1:11      readstring   putchar(reg A) with {ZX 48K ROM}})   
    ld    A, 0x08       ; 2:7       readstring
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      readstring},
__{}{dnl
__{}    rst   0x10          ; 1:11      readstring   putchar(reg A) with {ZX 48K ROM}})   
    jr   READSTRING2    ; 2:12      readstring
READSTRING3:
    cp  0x0D            ; 2:7       readstring   enter?
    jr    z, READSTRING4; 2:7/12    readstring
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      readstring},
__{}{dnl
__{}    rst   0x10          ; 1:11      readstring   putchar(reg A) with {ZX 48K ROM}})   
    inc  DE             ; 1:6       readstring   addr++
    inc  BC             ; 1:6       readstring   loaded++
    dec  HL             ; 1:6       readstring   space--
    ld    A, H          ; 1:4       readstring
    or    L             ; 1:4       readstring
    jr   nz, READSTRING2; 2:7/12    readstring

READSTRING4:            ;           readstring   A = 0, flag: z, nc
__{}ifdef({USE_ACCEPT_Z},{dnl
__{}    xor   A             ; 1:7       readstring_z
__{}    ld  (DE),A          ; 1:7       readstring_z  set zero char
__{}}){}dnl
    pop  HL             ; 1:10      readstring   ret
    pop  DE             ; 1:10      readstring
    push HL             ; 1:11      readstring   ret
    ld    H, B          ; 1:4       readstring
    ld    L, C          ; 1:4       readstring
    ret                 ; 1:10      readstring}){}dnl
dnl
dnl
dnl
ifdef({USE_KEY},{ifdef({USE_CLEARKEY},,define({USE_CLEARKEY},{}))
;==============================================================================
; Read key from keyboard
; In:
; Out: push stack, TOP = HL = key
READKEY:
    ex   DE, HL         ; 1:4       readkey   ( ret . old _DE old_HL -- old_DE ret . old_HL key )
    ex  (SP),HL         ; 1:19      readkey
    push HL             ; 1:11      readkey

    ld    A,(0x5C08)    ; 3:13      readkey   read new value of {LAST K}
    or    A             ; 1:4       readkey   is it still zero?
    jr    z, $-4        ; 2:7/12    readkey
    ld    L, A          ; 1:4       readkey
    ld    H, 0x00       ; 2:7       readkey
;   ...fall down to clearbuff}){}dnl
ifdef({USE_CLEARKEY},{
;==============================================================================
; Clear key buffer
; In:
; Out: {(LAST_K)} = 0
CLEARBUFF:
    push HL             ; 1:11      clearbuff
    ld   HL, 0x5C08     ; 3:10      clearbuff   {ZX Spectrum LAST K} system variable
    ld  (HL),0x00       ; 2:10      clearbuff
    pop  HL             ; 1:10      clearbuff
    ret                 ; 1:10      clearbuff}){}dnl
dnl
dnl
dnl
ifdef({USE_TYPE},{
;==============================================================================
; ( addr n -- )
; print n chars from addr
;  Input: HL, DE
; Output: Print decimal number in HL
; Pollutes: AF, BC, DE
PRINT_TYPE:             ;[10:76]    print_string
    ld    B, H          ; 1:4       print_string
    ld    C, L          ; 1:4       print_string   BC = length of string to print
    call 0x203C         ; 3:17      print_string   Use {ZX 48K ROM}
    pop  AF             ; 1:10      print_string   load ret
    pop  HL             ; 1:10      print_string
    pop  DE             ; 1:10      print_string
    push AF             ; 1:11      print_string   save ret
    ret                 ; 1:10      print_string}){}dnl
dnl
dnl
dnl
ifdef({USE_TYPE_Z},{define({USE_PRINT_Z},{})
;==============================================================================
; Print C-style stringZ
; In: HL = addr stringZ
; Out: BC = addr zero
PRINT_TYPE_Z:           ;           print_type_z
    ld    B, H          ; 1:4       print_type_z
    ld    C, L          ; 1:4       print_type_z   BC = addr stringZ
__{}ifdef({USE_FONT_5x8},{dnl
__{}    jr   $+5            ; 2:7/12    print_type_z},
__{}{dnl
__{}    db   0x3E           ; 1:7       print_type_z   ld    A, 0xD7
__{}    ; fall to PRINT_STRING_Z}){}dnl
}){}dnl
dnl
ifdef({USE_PRINT_Z},{
;------------------------------------------------------------------------------
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero + 1
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      print_string_z
__{}PRINT_STRING_Z:         ;           print_string_z
__{}    ld    A,(BC)        ; 1:7       print_string_z
__{}    inc  BC             ; 1:6       print_string_z
__{}    or    A             ; 1:4       print_string_z
__{}    jp   nz, $-6        ; 3:10      print_string_z
__{}    ret                 ; 1:10      print_string_z},
__{}{dnl
__{}    rst  0x10           ; 1:11      print_string_z putchar with {ZX 48K ROM} in, this will print char in A
__{}PRINT_STRING_Z:         ;           print_string_z
__{}    ld    A,(BC)        ; 1:7       print_string_z
__{}    inc  BC             ; 1:6       print_string_z
__{}    or    A             ; 1:4       print_string_z
__{}    jp   nz, $-4        ; 3:10      print_string_z
__{}    ret                 ; 1:10      print_string_z}){}dnl
}){}dnl   
dnl
dnl
dnl
ifdef({USE_TYPE_I},{__def({USE_PRINT_I})
;==============================================================================
; Print string ending with inverted most significant bit
; In: HL = addr string_imsb
; Out: BC = addr last_char + 1
PRINT_TYPE_I:           ;           print_type_i
    ld    B, H          ; 1:4       print_type_i
    ld    C, L          ; 1:4       print_type_i   BC = addr string_imsb
__{}ifdef({USE_FONT_5x8},{dnl
__{}    jr   $+5            ; 2:7/12    print_type_i},
__{}{dnl
__{}    db   0x3E           ; 1:7       print_type_i   ld    A, 0xD7
__{}    ; fall to PRINT_STRING_Z}){}dnl
}){}dnl
dnl
ifdef({USE_PRINT_I},{
;------------------------------------------------------------------------------
; Print string ending with inverted most significant bit
; In: BC = addr string_imsb
; Out: BC = addr last_char + 1
__{}ifdef({USE_FONT_5x8},{dnl
__{}    call  draw_char     ; 3:17      print_string_i
__{}PRINT_STRING_I:         ;           print_string_i
__{}    ld    A,(BC)        ; 1:7       print_string_i
__{}    inc  BC             ; 1:6       print_string_i
__{}    or    A             ; 1:4       print_string_i
__{}    jp    p, $-6        ; 3:10      print_string_i
__{}    and  0x7f           ; 2:7       print_string_i
__{}    call  draw_char     ; 3:17      print_string_i
__{}    ret                 ; 1:10      print_string_i},
__{}{dnl
__{}    rst  0x10           ; 1:11      print_string_i putchar with {ZX 48K ROM} in, this will print char in A
__{}PRINT_STRING_I:         ;           print_string_i
__{}    ld    A,(BC)        ; 1:7       print_string_i
__{}    inc  BC             ; 1:6       print_string_i
__{}    or    A             ; 1:4       print_string_i
__{}    jp    p, $-4        ; 3:10      print_string_i
__{}    and  0x7f           ; 2:7       print_string_i
__{}    rst  0x10           ; 1:11      print_string_i putchar with {ZX 48K ROM} in, this will print char in A
__{}    ret                 ; 1:10      print_string_i}){}dnl
}){}dnl
dnl
dnl
dnl
ifdef({USE_FONT_5x8},{
;==============================================================================
; Print text with 5x8 font
; entry point is draw_char

MAX_X           equ 51       ; x = 0..50
MAX_Y           equ 24       ; y = 0..23

set_ink:                ;           putchar
    exx                 ; 1:4       putchar
    ld   BC,(self_attr) ; 4:20      putchar   load origin attr
    xor   C             ; 1:4       putchar
    and 0x07            ; 2:7       putchar
    xor   C             ; 1:4       putchar
    jr   set_clean_exx  ; 2:12      putchar
    
set_paper:              ;           putchar          
    exx                 ; 1:4       putchar
    ld   BC,(self_attr) ; 4:20      putchar   load origin attr
    add   A, A          ; 1:4       putchar   2x
    add   A, A          ; 1:4       putchar   4x
    add   A, A          ; 1:4       putchar   8x
    xor   C             ; 1:4       putchar
    and 0x38            ; 2:7       putchar
    xor   C             ; 1:4       putchar
    jr   set_clean_exx  ; 2:12      putchar
    
set_flash:              ;           putchar
    rra                 ; 1:4       putchar   carry = flash
    ld    A,(self_attr) ; 3:13      putchar   load origin attr
    adc   A, A          ; 1:4       putchar
    rrca                ; 1:4       putchar
    jr  set_clean_save_A; 2:12      putchar
    
set_bright:             ;           putchar
    exx                 ; 1:4       putchar
    ld   BC,(self_attr) ; 4:20      putchar   load origin attr   
    rrca                ; 1:4       putchar
    rrca                ; 1:4       putchar
    xor   C             ; 1:4       putchar
    and 0x40            ; 2:7       putchar
    xor   C             ; 1:4       putchar
    jr   set_clean_exx  ; 2:12      putchar
    
set_inverse:            ;           putchar
    exx                 ; 1:4       putchar
    ld   BC,(self_attr) ; 4:20      putchar
    ld    A, C          ; 1:4       putchar   inverse
    and  0x38           ; 2:7       putchar   A = 00pp p000
    add   A, A          ; 1:4       putchar
    add   A, A          ; 1:4       putchar   A = ppp0 0000
    xor   C             ; 1:4       putchar
    and  0xF8           ; 2:7       putchar
    xor   C             ; 1:4       putchar   A = ppp0 0iii
    rlca                ; 1:4       putchar
    rlca                ; 1:4       putchar
    rlca                ; 1:4       putchar   A = 00ii ippp
    xor   C             ; 1:4       putchar
    and  0x3F           ; 2:7       putchar
    xor   C             ; 1:4       putchar   A = fbii ippp

set_clean_exx:          ;           putchar
    exx                 ; 1:4       putchar
    
set_clean_save_A:       ;           putchar
    ld  (self_attr),A   ; 3:13      putchar   save new attr
    
clean_spec:             ;           putchar
    xor   A             ; 1:4       putchar
    
clean_set_A:            ;           putchar
    ld  (jump_from-1),A ; 3:13      putchar
    ret                 ; 1:10      putchar
    
set_over:               ;           putchar
    jr   clean_spec     ; 2:12      putchar

set_at:                 ;           putchar
    ld (self_cursor+1),A; 3:13      putchar   save new Y
    neg                 ; 2:8       putchar
    add   A, 0x18       ; 2:7       putchar
    ld  (0x5C89),A      ; 3:13      putchar
    ld   A,$+4-jump_from; 2:7       putchar
    jr   clean_set_A    ; 2:12      putchar

; set_at_x:             ;           putchar
    ld  (self_cursor),A ; 3:13      putchar   save new X
    jr   clean_spec     ; 2:12      putchar


    jr   set_ink        ; 2:12      putchar
    jr   set_paper      ; 2:12      putchar
    jr   set_flash      ; 2:12      putchar
    jr   set_bright     ; 2:12      putchar
    jr   set_inverse    ; 2:12      putchar
    jr   set_over       ; 2:12      putchar
    jr   set_at         ; 2:12      putchar
;   jr   set_tab        ; 2:12      putchar

set_tab:                ;           putchar
    push HL             ; 1:11      putchar   save HL
    ld  HL,(self_cursor); 3:16      putchar   load origin cursor
    sub  MAX_X          ; 2:7       putchar
    jr   nc,$-2         ; 2:7/12    putchar
    add   A, MAX_X      ; 2:7       putchar   (new x) mod MAX_X
    cp    L             ; 1:4       putchar
    call  c, next_line  ; 3:10/17   putchar   new x < (old x+1)    
    ld    L, A          ; 1:4       putchar
    ld  (self_cursor),HL; 3:16      putchar   save new cursor
    pop  HL             ; 1:10      putchar   load HL
    jr   clean_spec     ; 2:12      putchar

;------------------------------------------------------------------------------
;  Input: A = char
; Output: DE = next char
; Poluttes: AF, AF', DE', BC'
draw_char:
    jr   jump_from          ; 2:7/12    self-modifying
jump_from:
    cp  0xA5                ; 2:7       token RND
    jr   nc, print_token    ; 2:7/12

    cp  0x20                ; 2:7
    jr   nc, print_char     ; 2:7/12

    sub  0x08               ; 2:7       left
    ret   c                 ; 1:10
    jr   nz, check_eol      ; 2:7/12

    push HL                 ; 1:11
    ld   HL,(self_cursor)   ; 3:16
    ld    A, L              ; 1:4
    dec  HL                 ; 1:6
    or    A                 ; 1:4
    jp   nz, next_exit      ; 3:10
    ld    L, MAX_X-1        ; 2:7
    jp   next_exit          ; 3:10

check_eol:
    sub  0x05               ; 2:7       eol
    ret   c                 ; 1:10
    jr   nz, draw_spec      ; 2:7/12

    push HL                 ; 1:11
    call next_line          ; 3:17
    jp   next_exit          ; 3:10

draw_spec:

    sub  0x03               ; 2:7       ZX_INK-ZX_EOL
    ret   c                 ; 1:5/11    0x00..0x0F
    add   A, 0xF8           ; 2:7       ZX_INK-ZX_TAB
    ret   c                 ; 1:5/11    0x18..0x1F
    
    add   A,A               ; 1:4       2x
    sub   jump_from-set_tab-2 ; 2:7
    ld  (jump_from-1),A     ; 3:13
    ret                     ; 1:10
    
print_token:
    push DE                 ; 1:11

    ld   DE, 0x0095	        ; 3:10      The base address of the token table
    sub  0xA5               ; 2:7
    push AF	                ; 1:11      Save the code on the stack. (Range +00 to +5A, RND to COPY).
    
; Input
;   A   Message table entry number
;   DE  Message table start address
; Output
;   DE  Address of the first character of message number A
;   F   Carry flag: suppress (set) or allow (reset) a leading space
    call 0x0C41             ; 3:17      {THE 'TABLE SEARCH' SUBROUTINE} 
    ld    A,' '	            ; 2:7       A 'space' will be printed before the message/token if required (bit 0 of FLAGS reset).
    bit   0,(IY+0x01)       ;
    call  z, print_char     ; 3:17

; The characters of the message/token are printed in turn.

token_loop:
    ld    A,(DE)            ; 1:7       Collect a code.
    and  0x7F               ; 2:7       Cancel any 'inverted bit'.
    call print_char         ; 3:17      Print the character.
    ld    A,(DE)            ; 1:7       Collect the code again.
    inc  DE                 ; 1:6       Advance the pointer.
    add   A, A              ; 1:4       The 'inverted bit' goes to the carry flag and signals the end of the message/token; otherwise jump back.
    jr   nc, token_loop     ; 2:7/12
    
; Now consider whether a 'trailing space' is required.

    pop  DE                 ; 1:10      For messages, D holds +00; for tokens, D holds +00 to +5A.
    cp   0x48               ; 2:7       Jump forward if the last character was a '$'
    jr    z, $+6            ; 2:7/12
    cp   0x82               ; 2:7       Return if the last character was any other before 'A'.
    jr    c, $+7            ; 2:7/12
    ld    A, D              ; 1:4       Examine the value in D and return if it indicates a message, RND, INKEY$ or PI.
    cp   0x03               ; 2:7
    ld    A, ' '            ; 2:7       All other cases will require a 'trailing space'.    
    pop  DE                 ; 1:10
    ret   c                 ; 1:5/11

print_char:
    push HL                 ; 1:11    uschovat HL na zásobník
    push DE                 ; 1:11    uschovat DE na zásobník
    push BC                 ; 1:11    uschovat BC na zásobník    
    
    exx                     ; 1:4
    push HL                 ; 1:11    uschovat HL na zásobník

    ld    BC, FONT_ADR      ; 3:10    adresa, od níž začínají masky znaků

    add   A, A              ; 1:4
    ld    L, A              ; 1:4     2x
    ld    H, 0x00           ; 1:4     C je nenulové
    add  HL, HL             ; 1:11    4x
    add  HL, BC             ; 1:11    přičíst bázovou adresu masek znaků    
    exx                     ; 1:4

;# YX -> ATTR

self_cursor     equ     $+1
    ld   DE, 0x0000         ; 3:10
    ld    A, E              ; 1:4     X
    add   A, A              ; 1:4     2*X
    add   A, A              ; 1:4     4*X
    add   A, E              ; 1:4     5*X
    ld    B, A              ; 1:4     save 5*X
    
    xor   D                 ; 1:4
    and 0xF8                ; 2:7
    xor   D                 ; 1:4
    rrca                    ; 1:4
    rrca                    ; 1:4
    rrca                    ; 1:4
    ld    L, A              ; 1:4

    ld    A, D              ; 1:4   
    or  0xC7                ; 2:7     110y y111, reset carry
    rra                     ; 1:4     0110 yy11, set carry
    rrca                    ; 1:4     1011 0yy1, set carry
    ccf                     ; 1:4     reset carry
    rra                     ; 1:4     0101 10yy
    ld    H, A              ; 1:4

self_attr       equ $+1
    ld  (HL),0x38           ; 2:10    uložení atributu znaku

    ld    A, D              ; 1:4
    and 0x18                ; 2:7
    or  0x40                ; 2:7
    ld    H, A              ; 1:4
    
    ld    A, B              ; 1:4     load 5*X
    and 0x07                ; 2:7
    cpl                     ; 1:4
    add   A, 0x09           ; 2:7         
    ld    B, A              ; 2:7     pocitadlo pro pocatecni posun vlevo masky znaku
    exx                     ; 1:4
    ld    C, A              ; 1:4
    exx                     ; 1:4
    ex   DE, HL             ; 1:4
    ld   HL, 0x00F0         ; 3:10
    add  HL, HL             ; 1:11    pocatecni posun masky
    djnz  $-1               ; 2:8/13        
    ex   DE, HL             ; 1:4

    ld    C, 4              ; 2:7        
loop_c:
    exx                     ; 1:4
    ld    A,(HL)            ; 1:7
    inc  HL                 ; 1:6
    ld    B, C              ; 1:4
    rlca                    ; 1:4
    djnz  $-1               ; 2:8/13
    ld    B, A              ; 1:4
    exx                     ; 1:4
    ld    B, 2              ; 2:7        
loop_b:
    xor (HL)                ; 1:7
    and   D                 ; 1:4
    xor (HL)                ; 1:7
    ld  (HL),A              ; 1:4     ulozeni jednoho bajtu z masky

    exx                     ; 1:4
    ld    A, B              ; 1:4     načtení druhe poloviny "bajtu" z masky
    exx                     ; 1:4

    inc   L                 ; 1:4
    xor (HL)                ; 1:7
    and   E                 ; 1:4
    xor (HL)                ; 1:7
    ld  (HL),A              ; 1:4     ulozeni jednoho bajtu z masky
    dec   L                 ; 1:4
    inc   H                 ; 1:4

    exx                     ; 1:4
    ld    A, B              ; 1:4     načtení jednoho bajtu z masky
    rlca                    ; 1:4
    rlca                    ; 1:4
    rlca                    ; 1:4
    rlca                    ; 1:4
    ld    B, A              ; 1:4
    exx                     ; 1:4

;     halt
    
    djnz loop_b             ; 2:8/13
    
    dec   C                 ; 2:7        
    jr   nz, loop_c         ; 2/7/12
    
    exx                     ; 1:4
    pop  HL                 ; 1:10    obnovit obsah HL ze zásobníku
    exx                     ; 1:4

    pop  BC                 ; 1:10    obnovit obsah BC ze zásobníku
    pop  DE                 ; 1:10    obnovit obsah DE ze zásobníku    
;   fall to next cursor    


    ld   HL,(self_cursor)   ; 3:16
; Input: HL = YX
; Output: HL = cursor = next cursor
next_cursor:
    inc   L                 ; 1:4     0..50
    ld    A, L              ; 1:4
    sub  MAX_X              ; 2:7     -51
    call nc, next_line      ; 3:10/17
next_exit:
    ld  (self_cursor),HL    ; 3:16
    pop  HL                 ; 1:10    obnovit obsah HL ze zásobníku
    ret                     ; 1:10

; Input:
; Output: H = Y+1/Y+scroll, L=0
next_line:
    push AF                 ; 1:11
    ld   HL, 0x5C88         ; 3:10
    ld  (HL), 0x01          ; 2:10
    ld    A, 0x15           ; 2:7     over
    rst  0x10               ; 1:11
    ld    A, 0x01           ; 2:7     over 1
    rst  0x10               ; 1:11
    ld    A, ' '            ; 2:7     space and check bios scroll
    rst  0x10               ; 1:11
    ld    A, 0x18           ; 2:7
    inc   L                 ; 1:4
    sub (HL)                ; 1:7
    ld    H, A              ; 1:7
    ld    L, 0x00           ; 2:7
    pop  AF                 ; 1:10
    ret                     ; 1:10


FONT_ADR    equ     FONT_5x8-32*4
FONT_5x8:
    db %00000000,%00000000,%00000000,%00000000 ; 0x20 space
    db %00000010,%00100010,%00100000,%00100000 ; 0x21 !
    db %00000101,%01010000,%00000000,%00000000 ; 0x22 "
    db %00000000,%01011111,%01011111,%01010000 ; 0x23 #
    db %00000010,%01110110,%00110111,%00100000 ; 0x24 $
    db %00001100,%11010010,%01001011,%00110000 ; 0x25 %
    db %00000000,%11101010,%01011010,%11010000 ; 0x26 &
    db %00000011,%00010010,%00000000,%00000000 ; 0x27 '    
    db %00000010,%01000100,%01000100,%00100000 ; 0x28 (
    db %00000100,%00100010,%00100010,%01000000 ; 0x29 )
    
    db %00000000,%00001010,%01001010,%00000000 ; 0x2A *
    db %00000000,%00000100,%11100100,%00000000 ; 0x2B +
    db %00000000,%00000000,%00000010,%00100100 ; 0x2C ,
    db %00000000,%00000000,%11100000,%00000000 ; 0x2D -
    db %00000000,%00000000,%00000000,%01000000 ; 0x2E .
    db %00000000,%00010010,%01001000,%00000000 ; 0x2F /
    
    db %00000110,%10011011,%11011001,%01100000 ; 0x30 0
    db %00000010,%01100010,%00100010,%01110000 ; 0x31 1
    db %00000110,%10010001,%01101000,%11110000 ; 0x32 2
    db %00000110,%10010010,%00011001,%01100000 ; 0x33 3
    db %00000010,%01101010,%11110010,%00100000 ; 0x34 4
    db %00001111,%10001110,%00011001,%01100000 ; 0x35 5
    db %00000110,%10001110,%10011001,%01100000 ; 0x36 6
    db %00001111,%00010010,%01000100,%01000000 ; 0x37 7
    db %00000110,%10010110,%10011001,%01100000 ; 0x38 8
    db %00000110,%10011001,%01110001,%01100000 ; 0x39 9
    db %00000000,%00000010,%00000010,%00000000 ; 0x3A :
    db %00000000,%00000010,%00000010,%01000000 ; 0x3B ;
    db %00000000,%00010010,%01000010,%00010000 ; 0x3C <
    db %00000000,%00000111,%00000111,%00000000 ; 0x3D =
    db %00000000,%01000010,%00010010,%01000000 ; 0x3E >
    db %00001110,%00010010,%01000000,%01000000 ; 0x3F ?
    
    db %00000000,%01101111,%10111000,%01100000 ; 0x40 @
    db %00000110,%10011001,%11111001,%10010000 ; 0x41 A
    db %00001110,%10011110,%10011001,%11100000 ; 0x42 B
    db %00000110,%10011000,%10001001,%01100000 ; 0x43 C
    db %00001110,%10011001,%10011001,%11100000 ; 0x44 D
    db %00001111,%10001110,%10001000,%11110000 ; 0x45 E
    db %00001111,%10001110,%10001000,%10000000 ; 0x46 F
    db %00000110,%10011000,%10111001,%01110000 ; 0x47 G
    db %00001001,%10011111,%10011001,%10010000 ; 0x48 H
    db %00000111,%00100010,%00100010,%01110000 ; 0x49 {I}
    db %00000111,%00010001,%00011001,%01100000 ; 0x4A {J}
    db %00001001,%10101100,%10101001,%10010000 ; 0x4B {K}
    db %00001000,%10001000,%10001000,%11110000 ; 0x4C L
    db %00001001,%11111001,%10011001,%10010000 ; 0x4D M
    db %00001001,%11011011,%10011001,%10010000 ; 0x4E N
    db %00000110,%10011001,%10011001,%01100000 ; 0x4F O
    
    db %00001110,%10011001,%11101000,%10000000 ; 0x50 P
    db %00000110,%10011001,%10011010,%01010000 ; 0x51 Q
    db %00001110,%10011001,%11101001,%10010000 ; 0x52 R
    db %00000111,%10000110,%00010001,%11100000 ; 0x53 S
    db %00001111,%00100010,%00100010,%00100000 ; 0x54 T
    db %00001001,%10011001,%10011001,%01100000 ; 0x55 U
    db %00001001,%10011001,%10010101,%00100000 ; 0x56 V
    db %00001001,%10011001,%10011111,%10010000 ; 0x57 W
    db %00001001,%10010110,%10011001,%10010000 ; 0x58 X
    db %00001001,%10010101,%00100010,%00100000 ; 0x59 Y
    db %00001111,%00010010,%01001000,%11110000 ; 0x5A Z
    db %00000111,%01000100,%01000100,%01110000 ; 0x5B [
    db %00000000,%10000100,%00100001,%00000000 ; 0x5C \
    db %00001110,%00100010,%00100010,%11100000 ; 0x5D ]
    db %00000010,%01010000,%00000000,%00000000 ; 0x5E ^
    db %00000000,%00000000,%00000000,%11110000 ; 0x5F _
    
    db %00000011,%01001110,%01000100,%11110000 ; 0x60 ` GBP
    db %00000000,%01100001,%01111001,%01110000 ; 0x61 a
    db %00001000,%11101001,%10011001,%11100000 ; 0x62 b
    db %00000000,%01101001,%10001001,%01100000 ; 0x63 c
    db %00000001,%01111001,%10011001,%01110000 ; 0x64 d
    db %00000000,%01101001,%11111000,%01110000 ; 0x65 e
    db %00110100,%11100100,%01000100,%01000000 ; 0x66 f
    db %00000000,%01111001,%10010111,%00010110 ; 0x67 g
    db %00001000,%11101001,%10011001,%10010000 ; 0x68 h
    db %00100000,%01100010,%00100010,%01110000 ; 0x69 i
    db %00010000,%00110001,%00010001,%10010110 ; 0x6A j
    db %00001000,%10011010,%11001010,%10010000 ; 0x6B k
    db %00001100,%01000100,%01000100,%11100000 ; 0x6C l
    db %00000000,%11001011,%10111011,%10010000 ; 0x6D m
    db %00000000,%10101101,%10011001,%10010000 ; 0x6E n
    db %00000000,%01101001,%10011001,%01100000 ; 0x6F o
   
    db %00000000,%11101001,%10011001,%11101000 ; 0x70 p
    db %00000000,%01111001,%10011001,%01110001 ; 0x71 q
    db %00000000,%10101101,%10001000,%10000000 ; 0x72 r
    db %00000000,%01111000,%01100001,%11100000 ; 0x73 s
    db %00000100,%11100100,%01000100,%00110000 ; 0x74 t
    db %00000000,%10011001,%10011001,%01100000 ; 0x75 u
    db %00000000,%10011001,%10010101,%00100000 ; 0x76 v
    db %00000000,%10011001,%10011111,%10010000 ; 0x77 w
    db %00000000,%10011001,%01101001,%10010000 ; 0x78 x
    db %00000000,%10011001,%10010111,%00010110 ; 0x79 y
    db %00000000,%11110010,%01001000,%11110000 ; 0x7A z
    db %00010010,%00100100,%00100010,%00010000 ; 0x7B {
    db %01000100,%01000100,%01000100,%01000000 ; 0x7C |
    db %10000100,%01000010,%01000100,%10000000 ; 0x7D }
    db %00000101,%10100000,%00000000,%00000000 ; 0x7E ~
    db %00000110,%10011011,%10111001,%01100000 ; 0x7F (c)}){}dnl
dnl
dnl
dnl
ifdef({__STRING_NUM_STACK},{

STRING_SECTION:{}PRINT_STRING_STACK
}){}dnl
dnl
dnl
dnl
ifelse(ALL_VARIABLE,{},,{

VARIABLE_SECTION:
}ALL_VARIABLE
){}dnl
dnl
dnl
dnl
