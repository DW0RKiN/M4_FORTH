    ORG 0x8000







    
    
   

         

   

        

   

 
   

   

 

 

  

   


    

   


   

    
    

   
   



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
                        ;           zvariable zvar1 7.0366596661249E+13
    push DE             ; 1:11      0x5C65 @
    ex   DE, HL         ; 1:4       0x5C65 @
    ld   HL,(0x5C65)    ; 3:16      0x5C65 @
    call PRT_HEX_U16    ; 3:17      hex u.   ( u -- )
    ex   DE, HL         ; 1:4       hex u.
    pop  DE             ; 1:10      hex u.
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z
    push DE             ; 1:11      0x5C63 @
    ex   DE, HL         ; 1:4       0x5C63 @
    ld   HL,(0x5C63)    ; 3:16      0x5C63 @
    call PRT_HEX_U16    ; 3:17      hex u.   ( u -- )
    ex   DE, HL         ; 1:4       hex u.
    pop  DE             ; 1:10      hex u.
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102
    call PRINT_STRING_Z ; 3:17      print_z
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string103
    call PRINT_STRING_Z ; 3:17      print_z
    call _ZDEPTH        ; 3:17      zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    push DE             ; 1:11      2147483647. 2dup
    push HL             ; 1:11      2147483647. 2dup
    ld   DE, 0x7FFF     ; 3:10      2147483647. 2dup
    push DE             ; 1:11      2147483647. 2dup
    ld    L, E          ; 1:4       2147483647. 2dup   L = E = 0xFF
    ld    H, L          ; 1:4       2147483647. 2dup   H = L = 0xFF
    push HL             ; 1:11      2147483647. 2dup
    call PRT_S32        ; 3:17      d.   ( d -- )
    ld    A, '='        ; 2:7       '=' emit   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      '=' emit   putchar(reg A) with ZX 48K ROM
    call _D_TO_Z        ; 3:17      d>z   ( d -- ) ( Z: -- z )
    call _ZDUP          ; 3:17      zdup   ( Z: z -- z z )
    call _ZDOT          ; 3:17      z.   ( Z: z -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string104 == string103
    call PRINT_STRING_Z ; 3:17      print_z
    call _ZDEPTH        ; 3:17      zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
                        ;[7:40]     32767 dup   ( -- 32767 32767 )
    push DE             ; 1:11      32767 dup
    push HL             ; 1:11      32767 dup
    ld   DE, 0x7FFF     ; 3:10      32767 dup
    ld    H, D          ; 1:4       32767 dup   H = D = 0x7F
    ld    L, E          ; 1:4       32767 dup   L = E = 0xFF
    call PRT_S16        ; 3:17      .   ( s -- )
    ld    A, '='        ; 2:7       '=' emit   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      '=' emit   putchar(reg A) with ZX 48K ROM
    call _S_TO_Z        ; 3:17      s>z   ( x -- ) ( Z: -- z )
    call _ZDUP          ; 3:17      zdup   ( Z: z -- z z )
    call _ZDOT          ; 3:17      z.   ( Z: z -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string105 == string103
    call PRINT_STRING_Z ; 3:17      print_z
    call _ZDEPTH        ; 3:17      zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106
    call PRINT_STRING_Z ; 3:17      print_z
    call _ZMUL          ; 3:17      z*   ( Z: z1 z2 -- z1*z2 )
    call _ZDUP          ; 3:17      zdup   ( Z: z -- z z )
    call _ZDOT          ; 3:17      z.   ( Z: z -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string107 == string103
    call PRINT_STRING_Z ; 3:17      print_z
    call _ZDEPTH        ; 3:17      zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    ld   BC, string108  ; 3:10      print_z   Address of null-terminated string108
    call PRINT_STRING_Z ; 3:17      print_z
    push DE             ; 1:11      zvar1
    ex   DE, HL         ; 1:4       zvar1
    ld   HL, zvar1      ; 3:10      zvar1
    call _ZFETCH        ; 3:17      z@   ( addr -- ) ( Z: -- z )
    call _ZDUP          ; 3:17      zdup   ( Z: z -- z z )
    call _ZDOT          ; 3:17      z.   ( Z: z -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string109 == string103
    call PRINT_STRING_Z ; 3:17      print_z
    call _ZDEPTH        ; 3:17      zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    call _ZSUB          ; 3:17      z-   ( Z: z1 z2 -- z1-z2 )
    ld    A, '='        ; 2:7       '=' emit   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      '=' emit   putchar(reg A) with ZX 48K ROM
    call _ZDUP          ; 3:17      zdup   ( Z: z -- z z )
    call _ZDOT          ; 3:17      z.   ( Z: z -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string110 == string103
    call PRINT_STRING_Z ; 3:17      print_z
    call _ZDEPTH        ; 3:17      zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    call _ZDROP         ; 3:17      zdrop   ( Z: z -- )
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string111 == string103
    call PRINT_STRING_Z ; 3:17      print_z
    call _ZDEPTH        ; 3:17      zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    push DE             ; 1:11      0x5C65 @
    ex   DE, HL         ; 1:4       0x5C65 @
    ld   HL,(0x5C65)    ; 3:16      0x5C65 @
    call PRT_HEX_U16    ; 3:17      hex u.   ( u -- )
    ex   DE, HL         ; 1:4       hex u.
    pop  DE             ; 1:10      hex u.
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string112 == string101
    call PRINT_STRING_Z ; 3:17      print_z
    push DE             ; 1:11      0x5C63 @
    ex   DE, HL         ; 1:4       0x5C63 @
    ld   HL,(0x5C63)    ; 3:16      0x5C63 @
    call PRT_HEX_U16    ; 3:17      hex u.   ( u -- )
    ex   DE, HL         ; 1:4       hex u.
    pop  DE             ; 1:10      hex u.
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string113 == string102
    call PRINT_STRING_Z ; 3:17      print_z
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string114 == string103
    call PRINT_STRING_Z ; 3:17      print_z
    call _ZDEPTH        ; 3:17      zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115
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
                     ;[26:688..736] _zdepth   # small version can be changed with "define({_TYP_SINGLE},{default})"
_ZDEPTH:                ;           _zdepth   ( -- n ) if ( Z: zn .. z1 -- zn .. z1 )
    ex   DE, HL         ; 1:4       _zdepth
    ex  (SP),HL         ; 1:19      _zdepth   ret
    push HL             ; 1:11      _zdepth   back ret
    ld   HL, (0x5C65)   ; 3:16      _zdepth   STKEND - Address of temporary work space = address of top of calculator stack
    ld   BC, (0x5C63)   ; 4:20      _zdepth   STKBOT - Address of bottom of calculator stack
    xor   A             ; 1:4       _zdepth
    sbc  HL, BC         ; 2:15      _zdepth   HL = 5*n
  if 1
    jr   nc, _ZDEPTH_D5 ; 2:7/12    _zdepth
    sub   L             ; 1:4       _zdepth
    ld    L, A          ; 1:4       _zdepth
    sbc   A, H          ; 1:4       _zdepth
    sub   L             ; 1:4       _zdepth
    ld    H, A          ; 1:4       _zdepth
    ld    A, '-'        ; 2:7       _zdepth   -
    rst   0x10          ; 1:11      _zdepth   putchar(reg A) with ZX 48K ROM
    xor   A             ; 1:4       _zdepth
_ZDEPTH_D5:             ;           _zdepth
  endif
    ld   BC, 0x1005     ; 3:10      _zdepth
    add  HL, HL         ; 1:11      _zdepth
    adc   A, A          ; 1:4       _zdepth
    cp    C             ; 1:4       _zdepth
    jr    c, $+4        ; 2:7/12    _zdepth
    sub   C             ; 1:4       _zdepth
    inc   L             ; 1:4       _zdepth
    djnz $-7            ; 2:8/13    _zdepth
    ret                 ; 1:10      _zdepth
_ZFETCH:                ;           _z@
    push DE             ; 1:11      _z@   ( addr -- ) ( F: -- z )
    ld   DE,(0x5C65)    ; 4:20      _z@   STKEND
    call 0x33C0         ; 3:17      _z@   call ZX ROM move floating-point number routine HL->DE
    ld  (0x5C65),DE     ; 4:20      _z@   STKEND+5
    pop  HL             ; 1:10      _z@
    pop  BC             ; 1:10      _z@   ret
    pop  DE             ; 1:10      _z@
    push BC             ; 1:11      _z@   ret
    ret                 ; 1:10      _z@

_S_TO_Z:                ;           _s>z   ( num ret . de hl -- ret . num de )
    ld    B, H          ; 1:4       _s>z
    ld    C, L          ; 1:4       _s>z
    pop  HL             ; 1:10      _s>z   ( num . de ret )
    ex  (SP),HL         ; 1:19      _s>z   ( ret . de num )
    ex   DE, HL         ; 1:4       _s>z   ( ret . num de )
    ; fall to _sign_bc_to_z

_SIGN_BC_TO_Z:          ;[2:8]      _sign_bc>z
    ld    A, B          ; 1:4       _sign_bc>z
    add   A, A          ; 1:4       _sign_bc>z
    ; fall to _cf_bc_to_z

if 1
_CF_BC_TO_Z:           ;[14:200]    _cf_bc>z
    sbc   A, A          ; 1:4       _cf_bc>z   0x00 or 0xff
    push HL             ; 1:11      _cf_bc>z
    push DE             ; 1:11      _cf_bc>z
    ld    E, A          ; 1:4       _cf_bc>z
    ld    D, C          ; 1:4       _cf_bc>z
    ld    C, B          ; 1:4       _cf_bc>z
    xor   A             ; 1:4       _cf_bc>z
    ld    B, A          ; 1:4       _cf_bc>z
    call 0x2ABB         ; 3:124     _cf_bc>z   new float = a,e,d,c,b = 0,0-sign,lo,hi,0
    pop  DE             ; 1:10      _cf_bc>z
else
_CF_BC_TO_Z:           ;[22:138]    _cf_bc>z
    sbc   A, A          ; 1:4       _cf_bc>z   0x00 or 0xff
    push HL             ; 1:11      _cf_bc>z
    ld   HL,(0x5C65)    ; 3:16      _cf_bc>z   load STKEND
    ld  (HL),0x00       ; 2:10      _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (HL), A         ; 1:7       _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (HL), C         ; 1:7       _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (HL), B         ; 1:7       _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (HL),0x00       ; 2:10      _cf_bc>z
    inc  HL             ; 1:6       _cf_bc>z
    ld  (0x5C65),HL     ; 3:16      _cf_bc>z   save STKEND+5
endif
    pop  HL             ; 1:10      _cf_bc>z
    ret                 ; 1:10      _cf_bc>z

_D_TO_Z:                ;           _d>z   ( num2 num1 ret . de hl -- ret . num2 num1 )
    ld    A, D          ; 1:4       _d>z
    or    E             ; 1:4       _d>z
    or    H             ; 1:4       _d>z
    or    L             ; 1:4       _d>z
    jr    z, _ZERO_TO_Z ; 2:7/12    _d>z   zero?
    ld    A, 0x7F       ; 2:7       _d>z
    or    D             ; 1:4       _d>z
    push AF             ; 1:11      _d>z   save sign 0x7f or 0xff
    call  m, NEGATE_32  ; 3:17      _d>z
    ld    B, 0xA0       ; 2:7       _d>z
    jp    m, $+12       ; 3:10      _d>z   0x80000000

    dec   B             ; 1:4       _d>z   exp--
    add  HL, HL         ; 1:11      _d>z
    rl    E             ; 2:8       _d>z
    rl    D             ; 2:8       _d>z
    jp    p, $-6        ; 3:10      _d>z   wait for sign

    pop  AF             ; 1:11      _d>z   load sign 0x7f or 0xff
    and   D             ; 1:4       _d>z
    ld    D, E          ; 1:4       _d>z
    ld    E, A          ; 1:4       _d>z   swap D and E
    ld    A, B          ; 1:4       _d>z   exp
_ZERO_TO_Z:             ;           _d>z   zero entry
    ld    B, L          ; 1:4       _d>z
    ld    C, H          ; 1:4       _d>z
    call 0x2ABB         ; 3:124     _d>z   new float = a,e,d,c,b
    pop  BC             ; 1:10      _d>z   ret
    pop  HL             ; 1:10      _d>z
    pop  DE             ; 1:10      _d>z
    push BC             ; 1:10      _d>z   ret
    ret                 ; 1:10      _d>z

_ZDOT:                  ;           _z.
    push DE             ; 1:11      _z.
    push HL             ; 1:11      _z.
    call 0x35bf         ; 3:17      _z.   call ZX ROM stk-pntrs, DE= stkend, HL = DE-5
    push HL             ; 1:11      _z.
    call 0x2de3         ; 3:17      _z.   call ZX ROM print a floating-point number routine
    pop  HL             ; 1:10      _z.
    ld  (0x5C65),HL     ; 3:16      _z.   save STKEND
    ld    A, ' '        ; 2:7       _z.   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      _z.   putchar(reg A) with ZX 48K ROM
    pop  HL             ; 1:10      _z.
    pop  DE             ; 1:10      _z.
    ret                 ; 1:10      _z.

_ZDROP:                 ;           _zdrop
    push DE             ; 1:11      _zdrop
    push HL             ; 1:11      _zdrop
    rst 0x28            ; 1:11      Use the calculator
    db  0x02            ; 1:        calc-delete
    db  0x38            ; 1:        calc-end    Pollutes: AF, BC, BC', DE'(=DE)
    pop  HL             ; 1:10      _zdrop
    pop  DE             ; 1:10      _zdrop
    ret                 ; 1:10      _zdrop

_ZSUB:                  ;           _z-
    push DE             ; 1:11      _z-
    push HL             ; 1:11      _z-
    rst 0x28            ; 1:11      Use the calculator
    db  0x03            ; 1:        calc-sub
    db  0x38            ; 1:        calc-end    Pollutes: AF, BC, BC', DE'(=DE)
    pop  HL             ; 1:10      _z-
    pop  DE             ; 1:10      _z-
    ret                 ; 1:10      _z-

_ZMUL:                  ;           _z*
    push DE             ; 1:11      _z*
    push HL             ; 1:11      _z*
if 1
    rst 0x28            ; 1:11      Use the calculator
    db  0x04            ; 1:        calc-mul
    db  0x38            ; 1:        calc-end    Pollutes: AF, BC', DE'(=DE)
else
    call 0x35bf         ; 3:17      _z*   call ZX ROM stk-pntrs, DE= stkend, HL = DE-5
    ld  (0x5C65),HL     ; 3:16      _z*   save STKEND
    call 0x35c2         ; 3:17      _z*   call ZX ROM            DE= HL    , HL = HL-5
    call 0x30ca         ; 3:17      _z*   call ZX ROM fmul, adr_HL = adr_DE * adr_HL
endif
    pop  HL             ; 1:10      _z*
    pop  DE             ; 1:10      _z*
    ret                 ; 1:10      _z*

_ZDUP:                  ;           _zdup
    push DE             ; 1:11      _zdup
    push HL             ; 1:11      _zdup
    rst 0x28            ; 1:11      Use the calculator
    db  0x31            ; 1:        calc-duplicate
    db  0x38            ; 1:        calc-end
    pop  HL             ; 1:10      _zdup
    pop  DE             ; 1:10      _zdup
    ret                 ; 1:10      _zdup

;------------------------------------------------------------------------------
;   Input: 16-bit unsigned number in HL
;   Output: Print Hex HL
; Pollutes: A
PRT_HEX_U16:            ;           prt_hex_u16
    ld    A, H          ;  1:4      prt_hex_u16
    call PRT_HEX_A      ;  3:17     prt_hex_u16
    ld    A, L          ;  1:4      prt_hex_u16
    ; fall to prt_hex_a
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
    ; fall to prt_hex_nibble
;------------------------------------------------------------------------------
;    Input: A = number, DE = adr
;   Output: (A & $0F) => '0'..'9','A'..'F'
; Pollutes: AF, AF',BC',DE'
PRT_HEX_NIBBLE:         ;           prt_hex_nibble
    or      $F0         ; 2:7       prt_hex_nibble   reset H flag
    daa                 ; 1:4       prt_hex_nibble   $F0..$F9 + $60 => $50..$59; $FA..$FF + $66 => $60..$65
    add   A, $A0        ; 2:7       prt_hex_nibble   $F0..$F9, $100..$105
    adc   A, $40        ; 2:7       prt_hex_nibble   $30..$39, $41..$46   = '0'..'9', 'A'..'F'
    rst   0x10          ; 1:11      prt_hex_nibble   putchar(reg A) with ZX 48K ROM
    ret                 ; 1:10
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
    rst   0x10          ; 1:11      prt_s32   putchar(reg A) with ZX 48K ROM
    call NEGATE_32      ; 3:17      prt_s32
    ; fall to prt_u32
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
    rst   0x10          ; 1:11      bin32_dec   putchar(reg A) with ZX 48K ROM
    ld    A, '0'        ; 2:7       bin32_dec   reset A to '0'
    ret                 ; 1:10      bin32_dec
;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
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
    ret                 ; 1:10      negate_32
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
string115:
    db "Depth: ", 0x00
size115              EQU $ - string115
string114   EQU  string103
  size114   EQU    size103
string113   EQU  string102
  size113   EQU    size102
string112   EQU  string101
  size112   EQU    size101
string111   EQU  string103
  size111   EQU    size103
string110   EQU  string103
  size110   EQU    size103
string109   EQU  string103
  size109   EQU    size103
string108:
    db '-',0x0D, 0x00
size108              EQU $ - string108
string107   EQU  string103
  size107   EQU    size103
string106:
    db '*',0x0D, 0x00
size106              EQU $ - string106
string105   EQU  string103
  size105   EQU    size103
string104   EQU  string103
  size104   EQU    size103
string103:
    db "ZDepth: ", 0x00
size103              EQU $ - string103
string102:
    db " = STKBOT:Addr. of bottom of calculator stack",0x0D, 0x00
size102              EQU $ - string102
string101:
    db " = STKEND:Address of top of calculator stack",0x0D, 0x00
size101              EQU $ - string101


VARIABLE_SECTION:

zvar1:                  ;           zvariable zvar1 7.0366596661249E+13   = 7.0366596661249E+13 = 0x1.fffbfffc0008p+45
    db 0xAE             ;           zvariable zvar1 7.0366596661249E+13   = exp
    db 0x7f             ;           zvariable zvar1 7.0366596661249E+13   = sign + high 7 bits mantissa (big-endien)
    db 0xFD,0xFF,0xFE   ;           zvariable zvar1 7.0366596661249E+13   = low mantissa (big-endien)
