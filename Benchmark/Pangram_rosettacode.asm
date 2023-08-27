    ORG 0x8000



    
    
    

     ;# -1

 
      
         
        
         
      
  
    

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
    push DE             ; 1:11      string    ( -- addr size )
    push HL             ; 1:11      string    "The five boxing wizards jump quickly."
    ld   DE, string101  ; 3:10      string    Address of string101
    ld   HL, size101    ; 3:10      string    Length of string101

    ld   BC, 9999       ; 3:10      9999 for_101   ( -- )
for101:                 ;           9999 for_101
    ld  [idx101],BC     ; 4:20      9999 for_101   save index
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    call _pangram_      ; 3:17      call ( -- )
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
idx101 EQU $+1          ;           next_101
    ld   BC, 0x0000     ; 3:10      next_101   idx always points to a 16-bit index
    ld    A, B          ; 1:4       next_101
    or    C             ; 1:4       next_101
    dec  BC             ; 1:6       next_101   index--, zero flag unaffected
    jp   nz, for101     ; 3:10      next_101
leave101:               ;           next_101
    call _pangram_      ; 3:17      call ( -- )
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
_pangram_:              ;           ( addr len -- ? )
    pop  BC             ; 1:10      : ret
    ld  (_pangram__end+1),BC; 4:20      : ( ret -- )
    ld   BC, 0x0000     ; 3:10      0. 2swap   hi word
    push BC             ; 1:11      0. 2swap
    push BC             ; 1:11      0. 2swap
    add  HL, DE         ; 1:11      over +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld  [idx102], HL    ; 3:16      do_102(m)   index  ( stop index -- )
    ld    A, E          ; 1:4       do_102(m)
    ld  [stp_lo102], A  ; 3:13      do_102(m)   lo stop
    ld    A, D          ; 1:4       do_102(m)
    ld  [stp_hi102], A  ; 3:13      do_102(m)   hi stop
    pop  HL             ; 1:10      do_102(m)
    pop  DE             ; 1:10      do_102(m)
do102:                  ;           do_102(m)
    push DE             ; 1:11      i_102(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_102(m)
    ld   HL, [idx102]   ; 3:16      i_102(m)   idx always points to a 16-bit index
    ld    L,[HL]        ; 1:7       c@   ( addr -- char )
    ld    H, 0x00       ; 2:7       c@
    set   5, L          ; 2:8       32 or
    ld   BC, 0xFF9F     ; 3:10      char 'a' -   ( x -- x-0x0061 )
    add  HL, BC         ; 1:11      char 'a' -
                        ;[9:32]     dup 0 26 within if   ( x -- x )  true=(0<=x<26)
    ld    A, L          ; 1:4       dup 0 26 within if
    sub  low 26         ; 2:7       dup 0 26 within if
    ld    A, H          ; 1:4       dup 0 26 within if
    sbc   A, high 26    ; 2:7       dup 0 26 within if   carry: HL - (26 - (0))
    jp   nc, else101    ; 3:10      dup 0 26 within if
    ld    C, L          ; 1:4       1. rot dlshift   ( u -- d )  d = 1 << u
    ld    B, H          ; 1:4       1. rot dlshift
    push  DE            ; 1:11      1. rot dlshift
                        ;[5:18]     1. rot dlshift   ( -- 0x0000 0x0001 )
    ld   HL, 0x0001     ; 3:10      1. rot dlshift
    ld    E, H          ; 1:4       1. rot dlshift   E = H = 0x00
    ld    D, E          ; 1:4       1. rot dlshift   D = E = 0x00
    call BC_LSHIFT32    ; 3:17      1. rot dlshift
    pop  BC             ; 1:10      dor   ( d2 d1 -- d )  d = d2 | d1
    ld    A, C          ; 1:4       dor
    or    L             ; 1:4       dor
    ld    L, A          ; 1:4       dor
    ld    A, B          ; 1:4       dor
    or    H             ; 1:4       dor
    ld    H, A          ; 1:4       dor
    pop  BC             ; 1:10      dor
    ld    A, C          ; 1:4       dor
    or    E             ; 1:4       dor
    ld    E, A          ; 1:4       dor
    ld    A, B          ; 1:4       dor
    or    D             ; 1:4       dor
    ld    D, A          ; 1:4       dor
    jp   endif101       ; 3:10      else
else101:                ;           else
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
endif101:               ;           then
idx102 EQU $+1          ;[20:78/57] loop_102(m)
    ld   BC, 0x0000     ; 3:10      loop_102(m)   idx always points to a 16-bit index
    inc  BC             ; 1:6       loop_102(m)   index++
    ld  [idx102], BC    ; 4:20      loop_102(m)   save index
    ld    A, C          ; 1:4       loop_102(m)   lo new index
stp_lo102 EQU $+1       ;           loop_102(m)
    xor  0x00           ; 2:7       loop_102(m)   lo stop
    jp   nz, do102      ; 3:10      loop_102(m)
    ld    A, B          ; 1:4       loop_102(m)   hi new index
stp_hi102 EQU $+1       ;           loop_102(m)
    xor  0x00           ; 2:7       loop_102(m)   hi stop
    jp   nz, do102      ; 3:10      loop_102(m)
leave102:               ;           loop_102(m)
exit102:                ;           loop_102(m)
               ;[13:56/56,56,56,56] 0x3FFFFFF. d=   ( d1 -- flag )  flag: d1 == 67108863
    ld    A, D          ; 1:4       0x3FFFFFF. d=
    xor   0xFC          ; 2:7       0x3FFFFFF. d=   x[1] = 0x03 = 0xFF ^ 0xFC
    and   E             ; 1:4       0x3FFFFFF. d=   x[2] = 0xFF
    and   H             ; 1:4       0x3FFFFFF. d=   x[3] = 0xFF
    and   L             ; 1:4       0x3FFFFFF. d=   x[4] = 0xFF
    inc   A             ; 1:4       0x3FFFFFF. d=
    sub  0x01           ; 2:7       0x3FFFFFF. d=
    sbc   A, A          ; 1:4       0x3FFFFFF. d=
    ld    L, A          ; 1:4       0x3FFFFFF. d=
    ld    H, A          ; 1:4       0x3FFFFFF. d=   HL = flag
    pop  DE             ; 1:10      0x3FFFFFF. d=
_pangram__end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;#==============================================================================
;# Input: HL
;# Output: Print space and signed decimal number in HL
;# Pollutes: AF, BC, HL <- DE, DE <- [SP]
PRT_SP_S16:             ;           prt_sp_s16
    ld    A, ' '        ; 2:7       prt_sp_s16   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      prt_sp_s16   putchar(reg A) with ZX 48K ROM
    ; fall to prt_s16
;#------------------------------------------------------------------------------
;# Input: HL
;# Output: Print signed decimal number in HL
;# Pollutes: AF, BC, HL <- DE, DE <- [SP]
PRT_S16:                ;           prt_s16
    ld    A, H          ; 1:4       prt_s16
    add   A, A          ; 1:4       prt_s16
    jr   nc, PRT_U16    ; 2:7/12    prt_s16
    ld    A, '-'        ; 2:7       prt_s16   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      prt_s16   putchar(reg A) with ZX 48K ROM
    xor   A             ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    L, A          ; 1:4       prt_s16   neg
    sbc   A, H          ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    H, A          ; 1:4       prt_s16   neg
    ; fall to prt_u16
;#------------------------------------------------------------------------------
;# Input: HL
;# Output: Print unsigned decimal number in HL
;# Pollutes: AF, BC, HL <- DE, DE <- [SP]
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
    ex  [SP],HL         ; 1:19      prt_u16
    ex   DE, HL         ; 1:4       prt_u16
    jr   BIN16_DEC_CHAR ; 2:12      prt_u16
;#------------------------------------------------------------------------------
;# Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
;# Output: if ((HL/(-BC) > 0) || (A >= '0')) print number -HL/BC
;# Pollutes: AF, HL
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
;#-------------------------------------------------------------------------------
;# ( d1 -- d )  d = d1<<BC
;# shifts d1 left BC places
;#  Input: BC=u, DEHL=d1, [SP]=ret
;# Output: DEHL <<=  BC
;# Pollutes: AF, BC, DE, HL
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
    ret                 ; 1:10      lshift32

STRING_SECTION:
string101:
    db "The five boxing wizards jump quickly."
size101              EQU $ - string101
