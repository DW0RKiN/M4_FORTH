dnl ## Runtime enviroment
define({__},{})dnl
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
ifdef({USE_DUP_ZXROM_U16},{
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC
PRINT_DUP_ZXROM_U16:    ;           print_dup_zxrom_u16
    ld    A, ' '        ; 2:7       print_dup_zxrom_u16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_dup_zxrom_u16   putchar with {ZX 48K ROM} in, this will print char in A
    ; fall to print_dup_zxrom_u16_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC
PRINT_DUP_ZXROM_U16_ONLY:;          print_dup_zxrom_u16_only   ( u -- )
    ld    B, H          ; 1:4       print_dup_zxrom_u16_only
    ld    C, L          ; 1:4       print_dup_zxrom_u16_only
    push DE             ; 1:11      print_dup_zxrom_u16_only
    push HL             ; 1:11      print_dup_zxrom_u16_only   save ret

    call 0x2D2B         ; 3:17      print_dup_zxrom_u16_only   {call ZX ROM stack BC routine}
    call 0x2DE3         ; 3:17      print_dup_zxrom_u16_only   {call ZX ROM print a floating-point number routine}

    pop  HL             ; 1:10      print_dup_zxrom_u16_only
    pop  DE             ; 1:10      print_dup_zxrom_u16_only
    ret                 ; 1:10      print_dup_zxrom_u16_only}){}dnl
dnl
dnl
dnl
ifdef({USE_ZXROM_U16},{
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_ZXROM_U16:        ;           print_zxrom_u16
    ld    A, ' '        ; 2:7       print_zxrom_u16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_zxrom_u16   putchar with {ZX 48K ROM} in, this will print char in A
    ; fall to print_zxrom_u16_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_ZXROM_U16_ONLY:   ;           print_zxrom_u16_only   ( u -- )
    push DE             ; 1:11      print_zxrom_u16_only
    ld    B, H          ; 1:4       print_zxrom_u16_only
    ld    C, L          ; 1:4       print_zxrom_u16_only
    call 0x2D2B         ; 3:17      print_zxrom_u16_only   {call ZX ROM stack BC routine}
    call 0x2DE3         ; 3:17      print_zxrom_u16_only   {call ZX ROM print a floating-point number routine}

    pop  HL             ; 1:10      print_zxrom_u16_only
    pop  BC             ; 1:10      print_zxrom_u16_only   load ret
    pop  DE             ; 1:10      print_zxrom_u16_only
    push BC             ; 1:11      print_zxrom_u16_only   save ret
    ret                 ; 1:10      print_zxrom_u16_only}){}dnl
dnl
dnl
dnl
ifdef({USE_ZXROM_S16},{
;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_ZXROM_S16:        ;           print_zxrom_s16
    ld    A, ' '        ; 2:7       print_zxrom_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_zxrom_s16   putchar with {ZX 48K ROM} in, this will print char in A
    ; fall to print_zxrom_s16_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_ZXROM_S16_ONLY:   ;           print_zxrom_s16_only   ( x -- )
    push DE             ; 1:11      print_zxrom_s16_only
    ld    A, H          ; 1:4       print_zxrom_s16_only
    add   A, A          ; 1:4       print_zxrom_s16_only
    sbc   A, A          ; 1:4       print_zxrom_s16_only   sign
    ld    E, A          ; 1:4       print_zxrom_s16_only   2. byte sign
    xor   A             ; 1:4       print_zxrom_s16_only   1. byte = 0
    ld    D, L          ; 1:4       print_zxrom_s16_only   3. byte lo
    ld    C, H          ; 1:4       print_zxrom_s16_only   4. byte hi
    ld    B, A          ; 1:4       print_zxrom_s16_only   5. byte = 0

    ld   IY, 0x5C3A     ; 4:14      print_zxrom_s16_only   {Re-initialise IY to ERR-NR.}

    call 0x2AB6         ; 3:17      print_zxrom_s16_only   {call ZX ROM STK store routine}
    call 0x2DE3         ; 3:17      print_zxrom_s16_only   {call ZX ROM print a floating-point number routine}
    pop  HL             ; 1:10      print_zxrom_s16_only
    pop  BC             ; 1:10      print_zxrom_s16_only   load ret
    pop  DE             ; 1:10      print_zxrom_s16_only
    push BC             ; 1:11      print_zxrom_s16_only   save ret
    ret                 ; 1:10      print_zxrom_u16_only}){}dnl
dnl
dnl
dnl
ifdef({USE_S32},{define({USE_DNEGATE},{}){}define({USE_U32},{})
;==============================================================================
; ( hi lo -- )
; Input: HL
; Output: Print space and signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRINT_S32:              ;           print_s32
    ld    A, D          ; 1:4       print_s32
    add   A, A          ; 1:4       print_s32
    jr   nc, PRINT_U32  ; 2:7/12    print_s32
    call NEGATE_32      ; 3:17      print_s32
    ld    A, ' '        ; 2:7       print_s32   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_s32   putchar with {ZX 48K ROM} in, this will print char in A
    ld    A, '-'        ; 2:7       print_s32   putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      print_s32   ld   BC, **
    ; fall to print_u32})dnl
dnl
dnl
ifdef({USE_U32},{
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRINT_U32:              ;           print_u32
    ld    A, ' '        ; 2:7       print_u32   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_u32   putchar with {ZX 48K ROM} in, this will print char in A
    ; fall to print_u32_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRINT_U32_ONLY:         ;           print_u32_only
    xor   A             ; 1:4       print_u32_only   A=0 => 103, A='0' => 00103
    push IX             ; 2:15      print_u32_only
    ex   DE, HL         ; 1:4       print_u32_only   HL = hi word
    ld  IXl, E          ; 2:8       print_u32_only
    ld  IXh, D          ; 2:8       print_u32_only   IX = lo word
    ld   DE, 0x3600     ; 3:10      print_u32_only   C4 65 36 00 = -1000000000
    ld   BC, 0xC465     ; 3:10      print_u32_only
    call BIN32_DEC+2    ; 3:17      print_u32_only
    ld    D, 0x1F       ; 2:7       print_u32_only   FA 0A 1F 00 = -100000000
    ld   BC, 0xFA0A     ; 3:10      print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0x6980     ; 3:10      print_u32_only   FF 67 69 80 = -10000000
    ld   BC, 0xFF67     ; 3:10      print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xBDC0     ; 3:10      print_u32_only   FF F0 BD C0 = -1000000
    ld    C, 0xF0       ; 2:7       print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0x7960     ; 3:10      print_u32_only   FF FE 79 60 = -100000
    ld    C, 0xFE       ; 2:7       print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xD8F0     ; 3:10      print_u32_only   FF FF D8 F0 = -10000
    ld    C, B          ; 1:4       print_u32_only
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xFC18     ; 3:10      print_u32_only   FF FF FC 18 = -1000
    call BIN32_DEC      ; 3:17      print_u32_only
    ld   DE, 0xFF9C     ; 3:10      print_u32_only   FF FF FF 9C = -100
    call BIN32_DEC      ; 3:17      print_u32_only
    ld    E, 0xF6       ; 2:7       print_u32_only   FF FF FF F6 = -10
    call BIN32_DEC      ; 3:17      print_u32_only
    ld    A, IXl        ; 2:8       print_u32_only
    pop  IX             ; 2:14      print_u32_only
    pop  BC             ; 1:10      print_u32_only   load ret
    pop  HL             ; 1:10      print_u32_only
    pop  DE             ; 1:10      print_u32_only
    push BC             ; 1:10      print_u32_only   save ret
    jr   BIN32_DEC_CHAR ; 2:12      print_u32_only
;------------------------------------------------------------------------------
; Input: A = 0..9 or '0'..'9' = 0x30..0x39 = 48..57, HL, IX, BC, DE
; Output: if ((HLIX/(-BCDE) > 0) || (A >= '0')) print number HLIX/(-BCDE)
; Pollutes: AF, AF', IX, HL
BIN32_DEC:              ;           bin32_dec
    and  0xF0           ; 2:7       bin32_dec   reset A to 0 or '0'
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
    rst  0x10           ; 1:11      bin32_dec   putchar with {ZX 48K ROM} in, this will print char in A
    ret                 ; 1:10      bin32_dec}){}dnl
dnl
dnl
ifdef({USE_S16},{
;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_S16:              ;           print_s16
    ld    A, H          ; 1:4       print_s16
    add   A, A          ; 1:4       print_s16
    jr   nc, PRINT_U16  ; 2:7/12    print_s16
    xor   A             ; 1:4       print_s16   neg
    sub   L             ; 1:4       print_s16   neg
    ld    L, A          ; 1:4       print_s16   neg
    sbc   A, H          ; 1:4       print_s16   neg
    sub   L             ; 1:4       print_s16   neg
    ld    H, A          ; 1:4       print_s16   neg
    ld    A, ' '        ; 2:7       print_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_s16   putchar with {ZX 48K ROM} in, this will print char in A
    ld    A, '-'        ; 2:7       print_s16   putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      print_s16   ld   BC, **
__{}define({USE_U16},{}){}dnl
    ; fall to print_u16}){}dnl
dnl
dnl
ifdef({USE_U16},{
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_U16:              ;           print_u16
    ld    A, ' '        ; 2:7       print_u16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      print_u16   putchar with {ZX 48K ROM} in, this will print char in A
    ; fall to print_u16_only
;------------------------------------------------------------------------------
; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRINT_U16_ONLY:         ;           print_u16_only
    xor   A             ; 1:4       print_u16_only   A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10      print_u16_only
    call BIN16_DEC+2    ; 3:17      print_u16_only
    ld   BC, -1000      ; 3:10      print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld   BC, -100       ; 3:10      print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld    C, -10        ; 2:7       print_u16_only
    call BIN16_DEC      ; 3:17      print_u16_only
    ld    A, L          ; 1:4       print_u16_only
    pop  BC             ; 1:10      print_u16_only   load ret
    ex   DE, HL         ; 1:4       print_u16_only
    pop  DE             ; 1:10      print_u16_only
    push BC             ; 1:10      print_u16_only   save ret
    jr   BIN16_DEC_CHAR ; 2:12      print_u16_only
;------------------------------------------------------------------------------
; Input: A = 0..9 or '0'..'9' = 0x30..0x39 = 48..57, HL, IX, BC, DE
; Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
; Pollutes: AF, HL
BIN16_DEC:              ;           bin16_dec
    and  0xF0           ; 2:7       bin16_dec   reset A to 0 or '0'
    add  HL, BC         ; 1:11      bin16_dec
    inc   A             ; 1:4       bin16_dec
    jr    c, $-2        ; 2:7/12    bin16_dec
    sbc  HL, BC         ; 2:15      bin16_dec
    dec   A             ; 1:4       bin16_dec
    ret   z             ; 1:5/11    bin16_dec   does not print leading zeros
BIN16_DEC_CHAR:         ;           bin16_dec
    or   '0'            ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    rst   0x10          ; 1:11      bin16_dec   putchar with {ZX 48K ROM} in, this will print char in A
    ret                 ; 1:10      bin16_dec}){}dnl
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
DE_LSHIFT:              ;[28:]      de_lshift
    ld    A, 15         ; 2:7       de_lshift
    sub   L             ; 1:4       de_lshift
    sbc   A, A          ; 1:4       de_lshift
    or    H             ; 1:4       de_lshift
    jr   nz, DE_LSHIFTZ ; 2:7/12    de_lshift
    or    L             ; 1:4       de_lshift
    ex   DE, HL         ; 1:4       de_lshift   HL = x
    ret   z             ; 1:5/11    de_lshift    A = u
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
ifelse(USE_FCE_DLT,{small},{dnl
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
__{}FCE_DLT:               ;[18:58,71]  fce_dlt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DLT},{small})"
__{}    push AF             ; 1:11      fce_dlt   h2 l2 rt h2 h1 l1  d2<d1 --> d2-d1<0 --> AFBC-DEHL<0 --> carry if true
__{}    sub   D             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  A-D<0 --> carry if true
__{}    jr    z, $+8        ; 2:7/12    fce_dlt   h2 l2 rt h2 h1 l1
__{}    rra                 ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1        --> sign  if true
__{}    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1
__{}    xor   B             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}    xor   D             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}    add   A, A          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1        --> carry if true
__{}    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1
__{}    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1
__{}    sub   L             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  C-L<0 --> carry if true
__{}    ld    A, B          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1
__{}    sbc   A, H          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  B-H<0 --> carry if true
__{}    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1  BC = hi16(d2)
__{}    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
__{}    sbc   A, E          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1  C-E<0 --> carry if true
__{}    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1})}){}dnl
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
ifelse(USE_FCE_DGT,{small},{dnl
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
__{}FCE_DGT:               ;[22:60,71]  fce_dgt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DGT},{small})"
__{}    push AF             ; 1:11      fce_dgt   h2 l2 rt h2 h1 l1  d2>d1 --> 0>d1-d2 --> 0>DEHL-AFBC --> carry if true
__{}    xor   D             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  A==D?
__{}    jr    z, $+12       ; 2:7/12    fce_dlt   h2 l2 rt h2 h1 l1
__{}    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1
__{}    jp    p, $+6        ; 3:10      fce_dlt   h2 l2 rt .. h1 l1
__{}    ld    A, B          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  opposite signs
__{}    sub   D             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1  0>B-D --> carry if true
__{}    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
__{}    ld    A, D          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  identical signs
__{}    sub   B             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1  0>D-B --> carry if true
__{}    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
__{}    ld    A, L          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
__{}    sub   C             ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>L-C --> carry if true
__{}    ld    A, H          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
__{}    sbc   A, B          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>H-B --> carry if true
__{}    pop  BC             ; 1:10      fce_dgt   h2 l2 rt .. h1 l1
__{}    ld    A, E          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1
__{}    sbc   A, C          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>E-C --> carry if true
__{}    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1})}){}dnl
dnl
dnl
dnl
ifdef({USE_MUL},{
;==============================================================================
include(M4PATH{}divmul/mul.m4){}dnl
})dnl
dnl
dnl
dnl
ifdef({USE_DIV},{ifdef({USE_UDIV},,define({USE_UDIV},{}))
;==============================================================================
include(M4PATH{}divmul/div.m4){}dnl
})dnl
dnl
dnl
dnl
ifdef({USE_UDIV},{
;==============================================================================
include(M4PATH{}divmul/udiv.m4){}dnl
})dnl
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
; In: DE = addr_string, HL = max_length
; Out: pop stack, TOP = HL = loaded
READSTRING:
__{}ifdef({USE_ACCEPT_Z},{dnl
__{}    dec  HL             ; 1:6       readstring_z
__{}})dnl
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
    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A
    ld    A, 0x20       ; 2:7       readstring
    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A
    ld    A, 0x08       ; 2:7       readstring
    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A
    jr   READSTRING2    ; 2:12      readstring
READSTRING3:

    cp  0x0D            ; 2:7       readstring   enter?
    jr    z, READSTRING4; 2:7/12    readstring

    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A
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
__{}})dnl
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
ifdef({USE_TYPE_Z},{
;==============================================================================
; Print C-style stringZ
; In: HL = addr stringZ
; Out: BC = addr zero
PRINT_TYPE_Z:           ;           print_type_z
    ld    B, H          ; 1:4       print_type_z
    ld    C, L          ; 1:4       print_type_z   BC = addr stringZ
__{}define({USE_STRING_Z},{})dnl
    jr    PRINT_STRING_Z; 2:12      print_type_z
}){}dnl
dnl
dnl
dnl
ifdef({USE_STRING_Z},{
;==============================================================================
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst  0x10           ; 1:11      print_string_z putchar with {ZX 48K ROM} in, this will print char in A
    inc  BC             ; 1:6       print_string_z
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z
}){}dnl
dnl
dnl
dnl
ifdef({USE_TYPE_I},{
;==============================================================================
; Print string ending with inverted most significant bit
; In: HL = addr string_imsb
; Out: BC = addr last_char + 1
PRINT_TYPE_I:           ;           print_type_i
    ld    B, H          ; 1:4       print_type_i
    ld    C, L          ; 1:4       print_type_i   BC = addr string_imsb
__{}define({USE_STRING_I},{})dnl
}){}dnl
dnl
dnl
dnl
ifdef({USE_STRING_I},{
;==============================================================================
; Print string ending with inverted most significant bit
; In: BC = addr string_imsb
; Out: BC = addr last_char + 1
PRINT_STRING_I:         ;           print_string_i
    ld    A,(BC)        ; 1:7       print_string_i
    and  0x7f           ; 2:7       print_string_i
    rst  0x10           ; 1:11      print_string_i putchar with {ZX 48K ROM} in, this will print char in A
    ld    A,(BC)        ; 1:7       print_string_i
    add   A, A          ; 1:4       print_string_i
    inc  BC             ; 1:6       print_string_i
    jp   nc, $-7        ; 3:10      print_string_i
    ret                 ; 1:10      print_string_i
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
ifdef({STRING_NUM_STACK},{
STRING_SECTION:{}PRINT_STRING_STACK
})dnl
dnl
dnl
dnl
