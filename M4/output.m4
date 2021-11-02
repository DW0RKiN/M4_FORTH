dnl ## Runtime enviroment
define({__},{})dnl
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
    call BIN2DEC        ; 3:17      print_u16_only
    pop  AF             ; 1:10      print_u16_only   load ret
    ex   DE, HL         ; 1:4       print_u16_only
    pop  DE             ; 1:10      print_u16_only
    push AF             ; 1:10      print_u16_only   save ret
    ret                 ; 1:10      print_u16_only
;------------------------------------------------------------------------------
; Input: HL = number
; Output: print number
; Pollutes: AF, HL, BC
BIN2DEC:                ;           bin2dec
    xor   A             ; 1:4       bin2dec   A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10      bin2dec
    call BIN2DEC_CHAR+2 ; 3:17      bin2dec
    ld   BC, -1000      ; 3:10      bin2dec
    call BIN2DEC_CHAR   ; 3:17      bin2dec
    ld   BC, -100       ; 3:10      bin2dec
    call BIN2DEC_CHAR   ; 3:17      bin2dec
    ld    C, -10        ; 2:7       bin2dec
    call BIN2DEC_CHAR   ; 3:17      bin2dec
    ld    A, L          ; 1:4       bin2dec
    add   A,'0'         ; 2:7       bin2dec
    rst   0x10          ; 1:11      bin2dec   putchar with {ZX 48K ROM} in, this will print char in A
    ret                 ; 1:10      bin2dec
;------------------------------------------------------------------------------
; Input: A = '0'..'9' or 0..9, HL, BC
; Output: if ((HL/BC > 0) || (A >= '0')) print number HL/BC
; Pollutes: AF, HL
BIN2DEC_CHAR:           ;           bin2dec_char
    and  0xF0           ; 2:7       bin2dec_char   '0'..'9' => '0', unchanged 0
    add  HL, BC         ; 1:11      bin2dec_char
    inc   A             ; 1:4       bin2dec_char
    jr    c, $-2        ; 2:7/12    bin2dec_char
    sbc  HL, BC         ; 2:15      bin2dec_char
    dec   A             ; 1:4       bin2dec_char
    ret   z             ; 1:5/11    bin2dec_char
    or   '0'            ; 2:7       bin2dec_char   0 => '0', unchanged '0'..'9'
    rst   0x10          ; 1:11      bin2dec_char   putchar with {ZX 48K ROM} in, this will print char in A
    ret                 ; 1:10      bin2dec_char}){}dnl
dnl
dnl
dnl
ifdef({USE_LSHIFT},{
;==============================================================================
; ( x u -- x)
; shifts x left u places
;  Input: HL, DE
; Output: HL = DE << HL
; Pollutes: AF, BC, DE, HL
DE_LSHIFT:              ;[26:]      de_lshift
    ld    A, L          ; 1:4       de_lshift
    ld   BC, 0x0010     ; 3:10      de_lshift
    sbc  HL, BC         ; 2:15      de_lshift
    jr   nc, DE_LSHIFTZ ; 2:7/12    de_lshift
    ex   DE, HL         ; 1:4       de_lshift   HL = x
    cp    0x08          ; 2:7       de_lshift
    jr    c, $+6        ; 2:7/12    de_lshift
    sub   0x08          ; 2:7       de_lshift
    ld    H, L          ; 1:4       de_lshift
    ld    L, B          ; 1:4       de_lshift   HL = HL << 8
    ret   z             ; 1:5/11    de_lshift
    ld    B, A          ; 1:4       de_lshift
    add  HL, HL         ; 1:11      de_lshift   HL = HL << 1
    djnz $-1            ; 2:8/13    de_lshift
    ret                 ; 1:10      de_lshift
DE_LSHIFTZ:             ;           de_lshift
    ld    H, B          ; 1:4       de_lshift
    ld    L, B          ; 1:4       de_lshift   HL = 0
    ret                 ; 1:10      de_lshift}){}dnl
dnl
dnl
dnl
ifdef({USE_RSHIFT},{
;==============================================================================
; ( x u -- x)
; shifts x right u places
;  Input: HL, DE
; Output: HL = DE >> HL
; Pollutes: AF, BC, DE, HL
DE_RSHIFT:              ;[ifdef({USE_LSHIFT},{27},{30}):]      de_rshift
    ld    A, L          ; 1:4       de_rshift
    ld   BC, 0x0010     ; 3:10      de_rshift
    sbc  HL, BC         ; 2:15      de_rshift
    jr   nc, ifdef({USE_LSHIFT},{DE_LSHIFTZ},{DE_RSHIFTZ}) ; 2:7/12    de_rshift
    ex   DE, HL         ; 1:4       de_lshift   HL = x
    cp    0x08          ; 2:7       de_rshift
    jr    c, $+6        ; 2:7/12    de_rshift
    sub   0x08          ; 2:7       de_rshift
    ld    L, H          ; 1:4       de_rshift
    ld    H, B          ; 1:4       de_rshift   HL = HL >> 8
    ret   z             ; 1:5/11    de_rshift
    ld    B, A          ; 1:4       de_rshift
    ld    A, L          ; 1:4       de_rshift
    srl   H             ; 2:8       de_rshift   unsigned
    rra                 ; 1:4       de_rshift   HA = HA >> 1
    djnz $-3            ; 2:8/13    de_rshift
    ld    L, A          ; 1:4       de_rshift
    ret                 ; 1:10      de_rshift{}ifdef({USE_LSHIFT},,{
DE_RSHIFTZ:             ;           de_rshift
    ld    H, B          ; 1:4       de_rshift
    ld    L, B          ; 1:4       de_rshift   HL = 0
    ret                 ; 1:10      de_rshift})}){}dnl
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
ifdef({USE_KEY},{
;==============================================================================
; Read key from keyboard
; In:
; Out: push stack, TOP = HL = key
READKEY:
    ex   DE, HL         ; 1:4       readkey
    ex  (SP),HL         ; 1:19      readkey
    push HL             ; 1:11      readkey
    ld   BC, 0x5C08     ; 3:10      readkey {ZX Spectrum LAST K} system variable
    xor   A             ; 1:4       readkey
    ld    H, A          ; 1:4       readkey
    ld  (BC),A          ; 1:7       readkey
    ld    A,(BC)        ; 1:7       readkey read new value of {LAST K}
    cp    H             ; 1:4       readkey is it still zero?
    jr    z, $-2        ; 2:7/12    readkey
    ld    L, A          ; 1:4       readkey
    ret                 ; 1:10      readkey}){}dnl
dnl
dnl
dnl
ifdef({USE_ACCEPT},{
;==============================================================================
; Read string from keyboard
; In: DE = addr, HL = length
; Out: 2x pop stack, TOP = HL = loaded
READSTRING:
    ld    B, D          ; 1:4       readstring
    ld    C, E          ; 1:4       readstring BC = addr
    ex   DE, HL         ; 1:4       readstring
READSTRING2:
    xor   A             ; 1:4       readstring
    ld    (0x5C08),A    ; 3:13      readstring {ZX Spectrum LAST K} system variable

    ld    A,(0x5C08)    ; 3:13      readstring read new value of {LAST K}
    or    A             ; 1:4       readstring is it still zero?
    jr    z, $-4        ; 2:7/12    readstring

    cp  0x0D            ; 2:7       readstring enter?
    jr    z, READSTRING3; 2:7/12    readstring
    ld  (HL),A          ; 1:7       readstring
    inc  HL             ; 1:6       readstring
    dec  DE             ; 1:6       readstring
    rst   0x10          ; 1:11      putchar with {ZX 48K ROM} in, this will print char in A
    ld    A, D          ; 1:4       readstring
    or    E             ; 1:4       readstring
    jr   nz, READSTRING2; 2:7/12    readstring
READSTRING3:
    or    A             ; 1:4       readstring
    sbc  HL, BC         ; 2:15      readstring

    pop  BC             ; 1:10      readstring ret
    pop  DE             ; 1:10      readstring
    push BC             ; 1:11      readstring ret
    ret                 ; 1:10      readstring}){}dnl
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
    ; fall to print_string_z
}){}dnl
dnl
dnl
dnl
ifdef({USE_STRING_Z},{
;==============================================================================
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst   0x10          ; 1:11      print_string_z putchar with {ZX 48K ROM} in, this will print char in A
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
