ORG 0x8000



BYTES_SIZE           EQU 18





_tmp3                EQU __create__tmp3






 
   
      
    

 
  
   



;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld  HL, PRINT_OUT   ; 3:10      init
    ld (CURCHL),HL      ; 3:16      init
    ld  HL, putchar     ; 3:10      init
    ld (PRINT_OUT),HL   ; 3:10      init
  if 0
    ld   HL, 0x0000     ; 3:10      init
    ld  (putchar_yx),HL ; 3:16      init
  else
    ld   HL, 0x1821     ; 3:10      init
    ld   DE,(0x5C88)    ; 4:20      init
    or    A             ; 1:4       init
    sbc  HL, DE         ; 2:15      init
    ld    A, L          ; 1:4       init   x
    add   A, A          ; 1:4       init   2*x
    inc   A             ; 1:4       init   2*2+1
    add   A, A          ; 1:4       init   4*x+2
    add   A, A          ; 1:4       init   8*x+4
    ld    L, 0xFF       ; 2:7       init
    inc   L             ; 1:4       init
    sub 0x05            ; 2:7       init
    jr   nc, $-3        ; 2:7/12    init
    ld  (putchar_yx),HL ; 3:16      init
  endif
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
                        ;           no_segment(18)
                        ;           no_segment(18)
                        ;           no_segment(18)
                        ;           no_segment(18)
                        ;           no_segment(18)
    push HL             ; 1:11      0x0001 , 0x0000 , ... 0x0000 ,   default version
    ld   HL, 0x0000     ; 3:10      0x0000 ,
    ld  (__create__tmp3+2),HL; 3:16      0x0000 ,
    ld  (__create__tmp3+4),HL; 3:16      0x0000 ,
    ld  (__create__tmp3+6),HL; 3:16      0x0000 ,
    ld  (__create__tmp3+8),HL; 3:16      0x0000 ,
    ld  (__create__tmp3+10),HL; 3:16      0x0000 ,
    ld  (__create__tmp3+12),HL; 3:16      0x0000 ,
    ld  (__create__tmp3+14),HL; 3:16      0x0000 ,
    ld  (__create__tmp3+16),HL; 3:16      0x0000 ,
    inc   L             ; 1:4       0x0001 ,
    ld  (__create__tmp3),HL; 3:16      0x0001 ,
    pop  HL             ; 1:10      0x0001 , 0x0000 , ... 0x0000 ,
                        ;[33:179]   0x0001 , 0x0000 , ... 0x0000 ,
    push DE             ; 1:11      _99 _tmp3 _tmp2 19 drop   ( -- _99 _tmp3 _tmp2 )  # DE DE HL
    push HL             ; 1:11      _99 _tmp3 _tmp2 19 drop
    ld   DE, _99        ; 3:10      _99 _tmp3 _tmp2 19 drop
    push DE             ; 1:11      _99 _tmp3 _tmp2 19 drop
    ld   DE, _tmp3      ; 3:10      _99 _tmp3 _tmp2 19 drop
    ld   HL, _tmp2      ; 3:10      _99 _tmp3 _tmp2 19 drop
    ld    A, 19         ; 2:7       19 for_101   ( -- )
for101:                 ;           19 for_101
    ld  (idx101),A      ; 3:13      19 for_101   save index
    pop  BC             ; 1:10      p144u*
    ld    A, 0x12       ; 2:7       p144u*
    call PXUMUL         ; 3:17      p144u*
    push BC             ; 1:11      p144u*
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
                        ;[8:785]    18 move   ( from_addr to_addr -- )   u = 18 words
    ld   BC, 0x0024     ; 3:10      18 move   BC = 36 chars
    ex   DE, HL         ; 1:4       18 move   HL = from_addr, DE = to_addr
    ldir                ; 2:u*42-5  18 move   addr++
    pop  HL             ; 1:10      18 move
    pop  DE             ; 1:10      18 move
    ld    A, 0x12       ; 2:7       dec pu.   ( p_num -- p_num ) p_10=_10 && p_temp=_tmp_print
    push DE             ; 1:11      dec pu.
    ex   DE, HL         ; 1:4       dec pu.
    ld   HL, _tmp_print ; 3:10      dec pu.
    ld   BC, _10        ; 3:10      dec pu.
    call PRT_PU         ; 3:17      dec pu.
    ex   DE, HL         ; 1:4       dec pu.
    pop  DE             ; 1:10      dec pu.   [p_num]==first number
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
idx101 EQU $+1          ;           next_101
    ld    A, 0x00       ; 2:7       next_101   idx always points to a 16-bit index
    nop                 ; 1:4       next_101
    sub  0x01           ; 2:7       next_101   index--
    jp   nc, for101     ; 3:10      next_101
leave101:               ;           next_101
    pop  HL             ; 1:10      drop drop drop   ( c b a -- )
    pop  HL             ; 1:10      drop drop drop
    pop  DE             ; 1:10      drop drop drop
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z
                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    srl   H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
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
    rst   0x10          ; 1:11      bin16_dec   putchar(reg A) with ZX 48K ROM 
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
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
    call  c, P256UDM    ; 3:17      prt_pu

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

    ex   DE, HL         ; 1:4       prt_pu
    or      $F0         ; 2:7       prt_pu   reset H flag
    daa                 ; 1:4       prt_pu   $F0..$F9 + $60 => $50..$59; $FA..$FF + $66 => $60..$65
    add   A, $A0        ; 2:7       prt_pu   $F0..$F9, $100..$105
    adc   A, $40        ; 2:7       prt_pu   $30..$39, $41..$46   = '0'..'9', 'A'..'F'
    rst   0x10          ; 1:11      prt_pu   putchar(reg A) with ZX 48K ROM
    pop  AF             ; 1:10      prt_pu
    jr    c, $-10       ; 2:7/12    prt_pu
    ret                 ; 1:10      prt_pu

;==============================================================================

; Multiplication 8..2048-bit unsigned value from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [BC] * [DE]
PXUMUL:                 ;           pxumul
    push BC             ; 1:11      pxumul
    ld    C, A          ; 1:4       pxumul   C = x bytes
    ex  (SP),HL         ; 1:19      pxumul
    add   A, L          ; 1:4       pxumul
    ld    L, A          ; 1:4       pxumul
    ex  (SP),HL         ; 1:19      pxumul   p3 += x
    ld    A, L          ; 1:4       pxumul
    add   A, C          ; 1:4       pxumul
    ld    L, A          ; 1:4       pxumul
    xor   A             ; 1:4       pxumul
    ld    B, C          ; 1:4       pxumul
    dec   L             ; 1:4       pxumul
    ld  (HL),A          ; 1:7       pxumul
    djnz $-2            ; 2:8/13    pxumul   [p1] = 0
    ld    A, C          ; 1:4       pxumul
PXMUL_L1:               ;           pxumul
    ex   AF, AF'        ; 1:4       pxumul
    ex  (SP),HL         ; 1:19      pxumul
    dec   L             ; 1:4       pxumul
    ld    A,(HL)        ; 1:7       pxumul
    ex  (SP),HL         ; 1:19      pxumul
    or    A             ; 1:4       pxumul
    jr   nz, PXMUL_J    ; 2:7/12    pxumul
    push BC             ; 1:11      pxumul
    push DE             ; 1:11      pxumul
    dec   C             ; 1:4       pxumul
    ld    B, 0x00       ; 2:7       pxumul
    ld    D, H          ; 1:4       pxumul
    ld    A, L          ; 1:4       pxumul
    add   A, C          ; 1:4       pxumul
    ld    E, A          ; 1:4       pxumul
    ld    L, E          ; 1:4       pxumul
    dec   L             ; 1:4       pxumul
    lddr                ; 2:16/21   pxumul   [DE]-- = [HL]--
    ex   DE, HL         ; 1:4       pxumul
    ld  (HL),B          ; 1:7       pxumul
    pop  DE             ; 1:10      pxumul
    pop  BC             ; 1:10      pxumul
    jr  PXMUL_N1        ; 2:12      pxumul
PXMUL_J:                ;           pxumul
    ld    B, 0x08       ; 2:7       pxumul
PXMUL_L2:               ;           pxumul
    push BC             ; 1:11      pxumul
    or    A             ; 1:4       pxumul
    ld    B, C          ; 1:4       pxumul
    ld    C, L          ; 1:4       pxumul
    rl  (HL)            ; 2:15      pxumul
    inc   L             ; 1:4       pxumul
    djnz $-3            ; 2:8/13    pxumul   result [p1] *= 2
    ld    L, C          ; 1:4       pxumul
    pop  BC             ; 1:10      pxumul
    ex  (SP),HL         ; 1:19      pxumul
    rlc (HL)            ; 2:15      pxumul   left rotation [p3] --> carry?
    ex  (SP),HL         ; 1:19      pxumul
    jr   nc, PXMUL_N2   ; 2:7/12    pxumul
    push BC             ; 1:11      pxumul
    push DE             ; 1:11      pxumul
    or    A             ; 1:4       pxumul
    ld    B, C          ; 1:4       pxumul
    ld    C, L          ; 1:4       pxumul
    ld    A,(DE)        ; 1:7       pxumul
    adc   A,(HL)        ; 1:7       pxumul
    ld  (HL),A          ; 1:7       pxumul
    inc   L             ; 1:4       pxumul
    inc   E             ; 1:4       pxumul
    djnz $-5            ; 2:8/13    pxumul
    ld    L, C          ; 1:4       pxumul
    pop  DE             ; 1:10      pxumul
    pop  BC             ; 1:10      pxumul
PXMUL_N2:               ;           pxumul
    djnz PXMUL_L2       ; 2:8/13    pxumul
PXMUL_N1:               ;           pxumul
    ex   AF, AF'        ; 1:4       pxumul
    dec   A             ; 1:4       pxumul
    jr   nz, PXMUL_L1   ; 2:7/12    pxumul
    pop  BC             ; 1:10      pxumul
    ret                 ; 1:10      pxumul
;==============================================================================

; Divide 8..256-bit unsigned value from pointer
; In: [BC], [DE], [HL]
;     A = sizeof(number) in bytes
; Out: [HL] = [DE] / [BC], [DE] = [DE] % [BC]
P256UDM:                ;           p256udm
    push BC             ; 1:11      p256udm
    ld    C, A          ; 1:4       p256udm   C = x bytes

    xor   A             ; 1:4       p256udm
    exx                 ; 1:4       p256udm
    ld    B, A          ; 1:4       p256udm   B' = shift_counter = 0
    exx                 ; 1:4       p256udm

    ld    B, C          ; 1:4       p256udm
    ld  (HL),A          ; 1:7       p256udm
    inc   L             ; 1:4       p256udm   px_res = 0
    djnz $-2            ; 2:8/13    p256udm
    ex   AF, AF'        ; 1:4       p256udm
    ld    A, L          ; 1:4       p256udm
    sub   C             ; 1:4       p256udm
    ld    L, A          ; 1:4       p256udm   return to original value

    ex  (SP),HL         ; 1:19      p256udm

    ld    A, L          ; 1:4       p256udm   A' = original value L
    ex   AF, AF'        ; 1:4       p256udm

    ld    B, C          ; 1:4       p256udm
    or  (HL)            ; 1:7       p256udm
    inc   L             ; 1:4       p256udm
    djnz $-2            ; 2:8/13    p256udm   px_3 == 0?

    or    A             ; 1:4       p256udm
    jr    z, P256UDM_E  ; 2:7/12    p256udm   exit with div 0

    ex   AF, AF'        ; 1:4       p256udm
    ld    L, A          ; 1:4       p256udm   return to original value
    ex   AF, AF'        ; 1:4       p256udm
    ld    B, C          ; 1:4       p256udm
    exx                 ; 1:4       p256udm
    inc   B             ; 1:4       p256udm   shift_counter++
    exx                 ; 1:4       p256udm

    rl  (HL)            ; 2:15      p256udm
    inc   L             ; 1:4       p256udm
    djnz $-3            ; 2:8/13    p256udm   px_3 *= 2

    jr   nc, $-12       ; 2:7/12    p256udm   px_3 overflow?

P256UDM_L:              ;           p256udm
    ld    B, C          ; 1:4       p256udm   L = orig L + $1
    dec   L             ; 1:4       p256udm
    rr  (HL)            ; 2:15      p256udm
    djnz $-3            ; 2:8/13    p256udm   px_3 >>= 1

    ex  (SP),HL         ; 1:19      p256udm
    ld    A, L          ; 1:4       p256udm
    ld    B, C          ; 1:4       p256udm
    rl  (HL)            ; 2:15      p256udm
    inc   L             ; 1:4       p256udm
    djnz $-3            ; 2:8/13    p256udm   result *= 2
    ld    L, A          ; 1:4       p256udm   return to original value
    ex  (SP),HL         ; 1:19      p256udm

    push  DE            ; 1:11      p256udm
    ld    B, C          ; 1:4       p256udm
    ld    A,(DE)        ; 1:7       p256udm
    sbc   A,(HL)        ; 1:7       p256udm
    inc   L             ; 1:4       p256udm
    inc   E             ; 1:4       p256udm
    djnz $-4            ; 2:8/13    p256udm   (px_mod < px_3)?
    pop  DE             ; 1:10      p256udm

    jr    c, P256UDM_N  ; 2:7/12    p256udm

    ex  (SP),HL         ; 1:19      p256udm
    inc (HL)            ; 1:11      p256udm   result += 1
    ex  (SP),HL         ; 1:19      p256udm

    push DE             ; 1:11      p256udm
    ex   AF, AF'        ; 1:4       p256udm
    ld    L, A          ; 1:4       p256udm   return to original value
    ex   AF, AF'        ; 1:4       p256udm
    ld    B, C          ; 1:4       p256udm
    ld    A,(DE)        ; 1:7       p256udm
    sbc   A,(HL)        ; 1:7       p256udm
    ld  (DE),A          ; 1:7       p256udm
    inc   L             ; 1:4       p256udm
    inc   E             ; 1:4       p256udm
    djnz $-5            ; 2:8/13    p256udm   px_mod -= px_3
    pop  DE             ; 1:10      p256udm
P256UDM_N:              ;           p256udm
    or    A             ; 1:4       p256udm
    exx                 ; 1:4       p256udm
    dec   B             ; 1:4       p256udm
    exx                 ; 1:4       p256udm
    jr   nz, P256UDM_L  ; 2:7/12    p256udm

P256UDM_E:              ;           p256udm
    ex   AF, AF'        ; 1:4       p256udm
    ld    L, A          ; 1:4       p256udm   return to original value
    ex  (SP),HL         ; 1:19      p256udm
    pop  BC             ; 1:10      p256udm
    ret                 ; 1:10      p256udm
;------------------------------------------------------------------------------
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero + 1
    rst   0x10          ; 1:11      print_string_z   putchar(reg A) with ZX 48K ROM
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    inc  BC             ; 1:6       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z
;==============================================================================
; Print text with 5x8 font
; entry point is "putchar"

MAX_X           equ 51       ; x = 0..50
MAX_Y           equ 24       ; y = 0..23
CURCHL          equ 0x5C51
PRINT_OUT       equ 0x5CBB
    
set_ink:                ;           putchar   0x10
    ld   HL, self_attr  ; 3:10      putchar
    xor (HL)            ; 1:7       putchar
    and 0x07            ; 2:7       putchar
    xor (HL)            ; 1:7       putchar
    jr  set_attr        ; 2:12      putchar
    
set_paper:              ;           putchar   0x11          
    ld   HL, self_attr  ; 3:10      putchar
    add   A, A          ; 1:4       putchar   2x
    add   A, A          ; 1:4       putchar   4x
    add   A, A          ; 1:4       putchar   8x
    xor (HL)            ; 1:7       putchar
    and 0x38            ; 2:7       putchar
    xor (HL)            ; 1:7       putchar
    jr  set_attr        ; 2:12      putchar
    
set_flash:              ;           putchar   0x12
    rra                 ; 1:4       putchar   carry = flash
    ld   HL, self_attr  ; 3:10      putchar
    ld    A,(HL)        ; 1:7       putchar
    adc   A, A          ; 1:4       putchar
    rrca                ; 1:4       putchar
    jr  set_attr        ; 2:12      putchar
    
set_bright:             ;           putchar   0x13
    ld   HL, self_attr  ; 3:10      putchar
    rrca                ; 1:4       putchar
    rrca                ; 1:4       putchar
    xor (HL)            ; 1:7       putchar
    and 0x40            ; 2:7       putchar
    xor (HL)            ; 1:7       putchar
    jr   set_attr       ; 2:12      putchar
    
set_inverse:            ;           putchar   0x14
    ld   HL, self_attr  ; 3:10      putchar
    ld    A,(HL)        ; 1:7       putchar
    and  0x38           ; 2:7       putchar   A = 00pp p000
    add   A, A          ; 1:4       putchar
    add   A, A          ; 1:4       putchar   A = ppp0 0000
    xor (HL)            ; 1:7       putchar
    and  0xF8           ; 2:7       putchar
    xor (HL)            ; 1:7       putchar   A = ppp0 0iii
    rlca                ; 1:4       putchar
    rlca                ; 1:4       putchar
    rlca                ; 1:4       putchar   A = 00ii ippp
    xor (HL)            ; 1:7       putchar
    and  0x3F           ; 2:7       putchar
    xor (HL)            ; 1:7       putchar   A = fbii ippp

set_attr:               ;           putchar
    ld  (HL),A          ; 1:7       putchar   save new attr   
clean_set_0:            ;           putchar
    xor   A             ; 1:4       putchar
clean_set_A:            ;           putchar
    ld  (self_jmp),A    ; 3:13      putchar
    pop  HL             ; 1:10      putchar
    ret                 ; 1:10      putchar
    
set_over:               ;           putchar   0x15
    jr   clean_set_0    ; 2:12      putchar

set_at:                 ;           putchar   0x16
    ld  (putchar_y),A   ; 3:13      putchar   save new Y
    neg                 ; 2:8       putchar
    add   A, 0x18       ; 2:7       putchar
    ld  (0x5C89),A      ; 3:13      putchar
    ld   A,$+4-jump_from; 2:7       putchar
    jr   clean_set_A    ; 2:12      putchar

set_at_x:               ;           putchar
    ld  (putchar_yx),A  ; 3:13      putchar   save new X
    jr   clean_set_0    ; 2:12      putchar

  if 0
    jr   print_comma    ; 2:12      putchar   0x06
    jr   print_edit     ; 2:12      putchar   0x07
    jr   cursor_left    ; 2:12      putchar   0x08
    jr   cursor_right   ; 2:12      putchar   0x09
    jr   cursor_down    ; 2:12      putchar   0x0A
    jr   cursor_up      ; 2:12      putchar   0x0B
    jr   delete         ; 2:12      putchar   0x0C
    jr   enter          ; 2:12      putchar   0x0D
    jr   not_used       ; 2:12      putchar   0x0E
    jr   not_used       ; 2:12      putchar   0x0F    
  endif
  
tab_spec:               ;           putchar 
    jr   set_ink        ; 2:12      putchar   0x10
    jr   set_paper      ; 2:12      putchar   0x11
    jr   set_flash      ; 2:12      putchar   0x12
    jr   set_bright     ; 2:12      putchar   0x13
    jr   set_inverse    ; 2:12      putchar   0x14
    jr   set_over       ; 2:12      putchar   0x15
    jr   set_at         ; 2:12      putchar   0x16
;   jr   set_tab        ; 2:12      putchar   0x17

set_tab:                ;           putchar
    ld   HL,(putchar_yx); 3:16      putchar   load origin cursor
    sub  MAX_X          ; 2:7       putchar
    jr   nc,$-2         ; 2:7/12    putchar
    add   A, MAX_X      ; 2:7       putchar   (new x) mod MAX_X
    cp    L             ; 1:4       putchar
    call  c, next_line  ; 3:10/17   putchar   new x < (old x+1) 
set_tab_A               ;           putchar
    ld    L, A          ; 1:4       putchar
    ld  (putchar_yx),HL ; 3:16      putchar   save new cursor
    jr   clean_set_0    ; 2:12      putchar

cursor_left:            ;           putchar   0x08
    ld   HL,(putchar_yx); 3:16      putchar
    inc   L             ; 1:4       putchar
    dec   L             ; 1:4       putchar
    dec  HL             ; 1:6       putchar
    jr   nz, $+4        ; 2:7/12    putchar
    ld    L, MAX_X-1    ; 2:7       putchar
    jr   enter_exit     ; 2:12      putchar

print_comma:            ;           putchar   0x06
    ld   HL,(putchar_yx); 3:16      putchar   H = next Y, L = next X
    ld    A, 17         ; 2:7       putchar
    cp    L             ; 1:4       putchar
    jr   nc, set_tab_A  ; 2:12      putchar
    add   A, A          ; 1:4       putchar
    cp    L             ; 1:4       putchar
    jr   nc, set_tab_A  ; 2:12      putchar
    xor   A             ; 1:4       putchar
    
enter:                  ;           putchar   0x0D
    call  z, next_line  ; 3:10/17   putchar
enter_exit:             ;           putchar
    ld  (putchar_yx),HL ; 3:16      putchar   save new cursor
    pop  HL             ; 1:10      putchar   load HL
    ret                 ; 3:10

    
print_edit:             ;           putchar   0x07
cursor_right:           ;           putchar   0x09
cursor_down:            ;           putchar   0x0A
cursor_up:              ;           putchar   0x0B
delete:                 ;           putchar   0x0C
not_used:               ;           putchar   0x0E, 0x0F

print_question          ;           putchar   0x00..0x05 + 0x0E..0x0F + 0x18..0x1F
    ld    A, '?'        ; 2:7       putchar
    jr   print_char_HL  ; 2:7/12    putchar

;------------------------------------------------------------------------------
;  Input: A = char
; Poluttes: AF, AF', DE', BC'
putchar:
    push HL                 ; 1:11
self_jmp    equ $+1
    jr   jump_from          ; 2:7/12    self-modifying
jump_from:
    cp   0xA5               ; 2:7       token 
    jr   nc, print_token    ; 2:7/12

    cp   0x20               ; 2:7
    jr   nc, print_char_HL  ; 2:7/12

    cp   0x06               ; 2:7       comma
    jr    z, print_comma    ; 2:7/12
    cp   0x08               ; 2:7       cursor_left
    jr    z, cursor_left    ; 2:7/12
    cp   0x09               ; 2:7       cursor_right
    jp    z, next_cursor    ; 3:10
    cp   0x0D               ; 2:7       enter
    jr    z, enter          ; 2:7/12

    sub  0x10               ; 2:7       set_ink
    jr    c, print_question ; 2:7/12

    cp   0x08               ; 2:7       >print_tab
    jr   nc, print_question ; 2:7/12

draw_spec:    
    add   A,A               ; 1:4       2x
    sub  jump_from-tab_spec ; 2:7
    ld  (self_jmp),A        ; 3:13
draw_spec_exit:             ;
    pop  HL                 ; 1:10
    ret                     ; 1:10
    
print_token:
    ex   DE, HL             ; 1:4
    ld   DE, 0x0095	        ; 3:10      The base address of the token table
    sub  0xA5               ; 2:7
    push AF                 ; 1:11      Save the code on the stack. (Range +00 to +5A,  to COPY).
    
; Input
;   A   Message table entry number
;   DE  Message table start address
; Output
;   DE  Address of the first character of message number A
;   F   Carry flag: suppress (set) or allow (reset) a leading space
    call 0x0C41             ; 3:17      THE 'TABLE SEARCH' SUBROUTINE 
    ex   DE, HL             ; 1:4

    ld    A,' '             ; 2:7       A 'space' will be printed before the message/token if required (bit 0 of FLAGS reset).
    bit   0,(IY+0x01)       ;
    call  z, print_char     ; 3:17

; The characters of the message/token are printed in turn.

token_loop:
    ld    A,(HL)            ; 1:7       Collect a code.
    and  0x7F               ; 2:7       Cancel any 'inverted bit'.
    call print_char         ; 3:17      Print the character.
    ld    A,(HL)            ; 1:7       Collect the code again.
    inc  HL                 ; 1:6       Advance the pointer.
    add   A, A              ; 1:4       The 'inverted bit' goes to the carry flag and signals the end of the message/token; otherwise jump back.
    jr   nc, token_loop     ; 2:7/12
    
; Now consider whether a 'trailing space' is required.

    pop  HL                 ; 1:10      For messages, H holds +00; for tokens, H holds +00 to +5A.
    cp   0x48               ; 2:7       Jump forward if the last character was a '$'
    jr    z, $+6            ; 2:7/12
    cp   0x82               ; 2:7       Return if the last character was any other before 'A'.
    jr    c, draw_spec_exit ; 2:7/12
    ld    A, H              ; 1:4       Examine the value in H and return if it indicates a message, , INKEY$ or PI.
    cp   0x03               ; 2:7
    ld    A, ' '            ; 2:7       All other cases will require a 'trailing space'.    
    ret   c                 ; 1:5/11
    pop  HL                 ; 1:10
print_char:
    push HL                 ; 1:11    uschovat HL na zásobník
print_char_HL:

    exx                     ; 1:4
    push DE                 ; 1:11    uschovat DE na zásobník
    push BC                 ; 1:11    uschovat BC na zásobník    

    push HL                 ; 1:11    uschovat HL na zásobník

    ld    BC, FONT_ADR      ; 3:10    adresa, od níž začínají masky znaků

    add   A, A              ; 1:4
    ld    L, A              ; 1:4     2x
    ld    H, 0x00           ; 1:4     C je nenulové
    add  HL, HL             ; 1:11    4x
    add  HL, BC             ; 1:11    přičíst bázovou adresu masek znaků    
    exx                     ; 1:4

;# YX -> ATTR

putchar_yx     equ     $+1
putchar_y      equ     $+2

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

    ld    C, 4          ; 2:7       putchar   draw        
putchar_c:              ;           putchar   draw
    exx                 ; 1:4       putchar   draw
    ld    A,(HL)        ; 1:7       putchar   draw
    inc  HL             ; 1:6       putchar   draw
    ld    B, C          ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    djnz  $-1           ; 2:8/13    putchar   draw
    ld    B, A          ; 1:4       putchar   draw
    exx                 ; 1:4       putchar   draw
    ld    B, 2          ; 2:7       putchar   draw 
putchar_b:              ;           putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    and   D             ; 1:4       putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    ld  (HL),A          ; 1:4       putchar   draw   ulozeni jednoho bajtu z masky

    exx                 ; 1:4       putchar   draw
    ld    A, B          ; 1:4       putchar   draw   načtení druhe poloviny "bajtu" z masky
    exx                 ; 1:4       putchar   draw

    inc   L             ; 1:4       putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    and   E             ; 1:4       putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    ld  (HL),A          ; 1:4       putchar   draw   ulozeni jednoho bajtu z masky
    dec   L             ; 1:4       putchar   draw
    inc   H             ; 1:4       putchar   draw

    exx                 ; 1:4       putchar   draw
    ld    A, B          ; 1:4       putchar   draw   načtení jednoho bajtu z masky
    rlca                ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    ld    B, A          ; 1:4       putchar   draw
    exx                 ; 1:4       putchar   draw

;     halt
    
    djnz putchar_b      ; 2:8/13    putchar   draw
    
    dec   C             ; 2:7       putchar   draw 
    jr   nz, putchar_c  ; 2/7/12    putchar   draw


    pop  HL             ; 1:10      putchar   obnovit obsah HL ze zásobníku

    pop  BC             ; 1:10      putchar   obnovit obsah BC ze zásobníku
    pop  DE             ; 1:10      putchar   obnovit obsah DE ze zásobníku    
    exx                 ; 1:4       putchar
;   fall to next cursor    

; Output: [putchar_yx] = cursor right
next_cursor:            ;
    ld   HL,(putchar_yx); 3:16
; Input: HL = YX
next_cursor_HL:         ;
    inc   L             ; 1:4     0..50
    ld    A, L          ; 1:4
    sub  MAX_X          ; 2:7     -51
    call nc, next_line  ; 3:10/17
next_exit:
    ld  (putchar_yx),HL ; 3:16
exit_hl:                ;
    pop  HL             ; 1:10    obnovit obsah HL ze zásobníku
    ret                 ; 1:10

; Input:
; Output: H = Y+1/Y+0+scroll, L=0
next_line:
    push AF             ; 1:11      putchar
    ld   HL, 0x5C88     ; 3:10      putchar
    ld  (HL), 0x01      ; 2:10      putchar
    ld    A, 0x09       ; 2:7       putchar   cursor_right
    push HL             ; 1:11      putchar
    call 0x09F4         ; 3:17      putchar   rst 0x10 --> call 0x09F4
    ld   HL, putchar    ; 3:10      putchar
    ld  (PRINT_OUT),HL  ; 3:10      putchar
    pop  HL             ; 1:10      putchar
    ld    A, 0x18       ; 2:7       putchar
    inc   L             ; 1:4       putchar
    sub (HL)            ; 1:7       putchar
    ld    H, A          ; 1:7       putchar
    ld    L, 0x00       ; 2:7       putchar
    pop  AF             ; 1:10      putchar
    ret                 ; 1:10      putchar

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
    db %00000111,%00100010,%00100010,%01110000 ; 0x49 I
    db %00000111,%00010001,%00011001,%01100000 ; 0x4A J
    db %00001001,%10101100,%10101001,%10010000 ; 0x4B K
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
    db %00010010,%00100100,%00100010,%00010000 ; 0x7B 
    db %01000100,%01000100,%01000100,%01000000 ; 0x7C |
    db %10000100,%01000010,%01000100,%10000000 ; 0x7D 
    db %00000101,%10100000,%00000000,%00000000 ; 0x7E ~
    db %00000110,%10011011,%10111001,%01100000 ; 0x7F (c)

STRING_SECTION:
string101:
    db "Depth: ", 0x00
size101              EQU $ - string101


VARIABLE_SECTION:

; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 18 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
_10:                    ; = 10
    dw 0x000a
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 18 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
_99:                    ; = 99
    dw 0x0063
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 18 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
_tmp_print:             ; = 0
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 18 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
_tmp2:                  ; = 0
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
; The padding will fill if the following X bytes overflow the 256 byte segment.
; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
if  ((($ + 18 - 1) / 256) != ($/256))
  DEFS    (($/256)+1)*256 - $
endif
__create__tmp3:         ;
    dw 0x0001           ;           0x0001 comma
    dw 0x0000           ;           0x0000 comma
    dw 0x0000           ;           0x0000 comma
    dw 0x0000           ;           0x0000 comma
    dw 0x0000           ;           0x0000 comma
    dw 0x0000           ;           0x0000 comma
    dw 0x0000           ;           0x0000 comma
    dw 0x0000           ;           0x0000 comma
    dw 0x0000           ;           0x0000 comma
