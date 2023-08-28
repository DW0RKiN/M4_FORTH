      ifdef __ORG
    org __ORG
  else
    org 24576
  endif




   
   
   

    ;# -1

 
  
   
  
              
       
       
      
      
  
     

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
    push DE             ; 1:11      string_z   ( -- addr )
    ex   DE, HL         ; 1:4       string_z   "The five boxing wizards jump quickly."
    ld   HL, string101  ; 3:10      string_z   Address of null-terminated string101

    ld   BC, 9999       ; 3:10      9999 for_101   ( -- )
for101:                 ;           9999 for_101
    ld  [idx101],BC     ; 4:20      9999 for_101   save index
    push DE             ; 1:11      dup   ( a -- a a )
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup
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
_pangram_:              ;           ( addr -- ? )
    pop  BC             ; 1:10      : ret
    ld  (_pangram__end+1),BC; 4:20      : ( ret -- )
    dec  HL             ; 1:6       1-   ( x -- x-1 )
                        ;[7:40]     0.   ( -- 0x0000 0x0000 )
    push DE             ; 1:11      0.
    push HL             ; 1:11      0.
    ld   DE, 0x0000     ; 3:10      0.
    ld    H, E          ; 1:4       0.   H = E = 0x00
    ld    L, H          ; 1:4       0.   L = H = 0x00
begin101:               ;           begin(101)
                       ;[13:74]     rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@   ( addr d -- addr++ d )
    pop  BC             ; 1:10      rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@
    inc  BC             ; 1:6       rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@   BC = addr++
    push BC             ; 1:11      rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@
    ld    A,[BC]        ; 1:7       rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@
    or    A             ; 1:4       rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@
    jp    z, break101   ; 3:10      rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@
    push DE             ; 1:11      rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@
    ex   DE, HL         ; 1:4       rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@
    ld    L, A          ; 1:4       rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@
    ld    H, 0x00       ; 2:7       rot 1+ -rot 2over nip c@ 0 c<> while 101 2over nip c@
    set   5, L          ; 2:8       32 or
    ld   BC, 0xFF9F     ; 3:10      char 'a' -   ( x -- x-0x0061 )
    add  HL, BC         ; 1:11      char 'a' -
                        ;[9:32]     dup 0 26 within if   ( x -- x )  true=(0<=x<26)
    ld    A, L          ; 1:4       dup 0 26 within if
    sub  low 26         ; 2:7       dup 0 26 within if
    ld    A, H          ; 1:4       dup 0 26 within if
    sbc   A, high 26    ; 2:7       dup 0 26 within if   carry: HL - (26 - (0))
    jp   nc, else101    ; 3:10      dup 0 26 within if
                       ;[26:108/45] dbitset   ( d1 u -- d )  d = d1 | 2**u   fast version
    ld    A, 0xE0       ; 2:7       dbitset
    and   L             ; 1:4       dbitset
    or    H             ; 1:4       dbitset
    ld    A, L          ; 1:4       dbitset   A = 000r rnnn
    pop  HL             ; 1:10      dbitset
    ex   DE, HL         ; 1:4       dbitset
    jr   nz, $+19       ; 2:7/12    dbitset   out of range 0..31
    rlca                ; 1:4       dbitset   2x
    rlca                ; 1:4       dbitset   4x
    rlca                ; 1:4       dbitset   8x
    ld    C, A          ; 1:4       dbitset   C = rrnn n000, nnn = 0..7, rr=(L:0,H:1,E:2,D:3) --> 5-rr=(L:5,H:4,E:3,D:2)
    rlca                ; 1:4       dbitset
    rlca                ; 1:4       dbitset
    and  0x03           ; 1:4       dbitset
    ld    B, A          ; 1:4       dbitset   B = 0000 00rr
    ld    A, C          ; 1:4       dbitset   A = rrnn n000
    or   0xC5           ; 2:7       dbitset   A = 11nn n101     = set n, L
    sub   B             ; 1:4       dbitset   A = 11nn n101 - B = set n, DEHL
    ld  ($+4), A        ; 3:13      dbitset
    set   0, L          ; 2:8       dbitset
    jp   endif101       ; 3:10      else
else101:                ;           else
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
endif101:               ;           then
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
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
    pop  DE             ; 1:10      nip   ( b a -- a )
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

STRING_SECTION:
string101:
    db "The five boxing wizards jump quickly.", 0x00
size101              EQU $ - string101
