    ORG 32768
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init

    
ZX_LEFT              EQU 0x08
    
ZX_RIGHT             EQU 0x09

    
ZX_INK               EQU 0x10
    
ZX_PAPER             EQU 0x11
    
ZX_FLASH             EQU 0x12
    
ZX_BRIGHT            EQU 0x13
    
ZX_INVERSE           EQU 0x14
    
ZX_OVER              EQU 0x15
    
ZX_AT                EQU 0x16
    
ZX_TAB               EQU 0x17
    
ZX_CR                EQU 0x0D

    
ZX_INK_BLACK         EQU 0x00
    
ZX_INK_BLUE          EQU 0x01
    
ZX_INK_RED           EQU 0x02
    
ZX_INK_MAGENTA       EQU 0x03
    
ZX_INK_GREEN         EQU 0x04
    
ZX_INK_CYAN          EQU 0x05
    
ZX_INK_YELLOW        EQU 0x06
    
ZX_INK_WHITE         EQU 0x07

    
ZX_PAPER_BLACK       EQU 0x00
    
ZX_PAPER_BLUE        EQU 0x08
    
ZX_PAPER_RED         EQU 0x10
    
ZX_PAPER_MAGENTA     EQU 0x18
    
ZX_PAPER_GREEN       EQU 0x20
    
ZX_PAPER_CYAN        EQU 0x028
    
ZX_PAPER_YELLOW      EQU 0x30
    
ZX_PAPER_WHITE       EQU 0x38

    
ZX_FLASHING          EQU 0x80
    
ZX_BRIGHTNESS        EQU 0x40

    ; set 0 lines in the lower section of the screen
    
    ld    A, 0          ; 2:7       push2_cstore(0,23659)
    ld   (23659), A     ; 3:13      push2_cstore(0,23659)

    
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z
;lum ultrices.

    ; set 2 lines in the lower section of the screen
    
    ld    A, 2          ; 2:7       push2_cstore(2,23659)
    ld   (23659), A     ; 3:13      push2_cstore(2,23659)

    ; blue shadow
    
                        ;[15:450]   0x5A85 23 0x08+0x00 fill PUSH3_FILL(addr,u,char)   variant H: 2..513 byte
    push HL             ; 1:11      0x5A85 23 0x08+0x00 fill
    ld   HL, 0x5A85     ; 3:10      0x5A85 23 0x08+0x00 fill   HL = addr
    ld   BC, 2816+0x08+0x00; 3:10      0x5A85 23 0x08+0x00 fill   B = 11x, C = 0x08+0x00
    ld  (HL),C          ; 1:7       0x5A85 23 0x08+0x00 fill
    inc  HL             ; 1:6       0x5A85 23 0x08+0x00 fill
    ld  (HL),C          ; 1:7       0x5A85 23 0x08+0x00 fill
    inc   L             ; 1:4       0x5A85 23 0x08+0x00 fill
    djnz $-4            ; 2:13/8    0x5A85 23 0x08+0x00 fill
    ld  (HL),C          ; 1:7       0x5A85 23 0x08+0x00 fill
    pop  HL             ; 1:10      0x5A85 23 0x08+0x00 fill
    
    push DE             ; 1:11      push(0x589C)
    ex   DE, HL         ; 1:4       push(0x589C)
    ld   HL, 0x589C     ; 3:10      push(0x589C)
    
    ld   BC, 15         ; 3:10      15 for 101
for101:                 ;           15 for 101
    ld  (idx101),BC     ; 4:20      15 for 101 save index
       
    ld   BC, 0x0020     ; 3:10      32 +   ( x -- x+0x0020 )
    add  HL, BC         ; 1:11      32 +
       
                        ;[2:10]     0x08+0x00 over c!  push_over_cstore(0x08+0x00)   ( addr -- addr )   (addr)=0x08+0x00
    ld  (HL),low 0x08+0x00; 2:10      0x08+0x00 over c!  push_over_cstore(0x08+0x00)
    
idx101 EQU $+1          ;           next 101
    ld   BC, 0x0000     ; 3:10      next 101 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 101
    or    C             ; 1:4       next 101
    dec  BC             ; 1:6       next 101 index--, zero flag unaffected
    jp   nz, for101     ; 3:10      next 101
next101:                ;           next 101
    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )

    ; cyan
    
                        ;[16:404]   0x5884 24 0x028+0x05 fill PUSH3_FILL(addr,u,char)   variant G: u == 3*n bytes (3..+3..255) and hi(addr) == hi(addr_end)
    push HL             ; 1:11      0x5884 24 0x028+0x05 fill
    ld   HL, 0x5884     ; 3:10      0x5884 24 0x028+0x05 fill   HL = addr
    ld   BC, 2048+0x028+0x05; 3:10      0x5884 24 0x028+0x05 fill   B = 8x, C = 0x028+0x05
    ld  (HL),C          ; 1:7       0x5884 24 0x028+0x05 fill
    inc   L             ; 1:4       0x5884 24 0x028+0x05 fill
    ld  (HL),C          ; 1:7       0x5884 24 0x028+0x05 fill
    inc   L             ; 1:4       0x5884 24 0x028+0x05 fill
    ld  (HL),C          ; 1:7       0x5884 24 0x028+0x05 fill
    inc   L             ; 1:4       0x5884 24 0x028+0x05 fill
    djnz $-6            ; 2:13/8    0x5884 24 0x028+0x05 fill
    pop  HL             ; 1:10      0x5884 24 0x028+0x05 fill

    ; light cyan
    
    push DE             ; 1:11      push(0x58A4)
    ex   DE, HL         ; 1:4       push(0x58A4)
    ld   HL, 0x58A4     ; 3:10      push(0x58A4)
    
    ld   BC, 14         ; 3:10      14 for 102
for102:                 ;           14 for 102
    ld  (idx102),BC     ; 4:20      14 for 102 save index
        
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )
        
                        ;[13:435]   24 0x40+0x028+0x05 fill
    ld   BC, 8*256+0x40+0x028+0x05; 3:10      24 0x40+0x028+0x05 fill
    ld  (HL),C          ; 1:7       24 0x40+0x028+0x05 fill
    inc  HL             ; 1:6       24 0x40+0x028+0x05 fill
    ld  (HL),C          ; 1:7       24 0x40+0x028+0x05 fill
    inc  HL             ; 1:6       24 0x40+0x028+0x05 fill
    ld  (HL),C          ; 1:7       24 0x40+0x028+0x05 fill
    inc  HL             ; 1:6       24 0x40+0x028+0x05 fill
    djnz $-6            ; 2:13/8    24 0x40+0x028+0x05 fill
    ex   DE, HL         ; 1:4       24 0x40+0x028+0x05 fill
    pop  DE             ; 1:10      24 0x40+0x028+0x05 fill
        
    ld   BC, 0x0020     ; 3:10      32 +   ( x -- x+0x0020 )
    add  HL, BC         ; 1:11      32 +
    
idx102 EQU $+1          ;           next 102
    ld   BC, 0x0000     ; 3:10      next 102 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 102
    or    C             ; 1:4       next 102
    dec  BC             ; 1:6       next 102 index--, zero flag unaffected
    jp   nz, for102     ; 3:10      next 102
next102:                ;           next 102
    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )


    
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102
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
    call PRT_S16        ; 3:17      .   ( s -- ) 
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string103
    call PRINT_STRING_Z ; 3:17      print_z

    
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104
    call PRINT_STRING_Z ; 3:17      print_z


    
    push DE             ; 1:11      push2(40*256+31,8)
    ld   DE, 40*256+31  ; 3:10      push2(40*256+31,8)
    push HL             ; 1:11      push2(40*256+31,8)
    ld   HL, 8          ; 3:10      push2(40*256+31,8)
    call(up)
    
    push DE             ; 1:11      push(192)
    ex   DE, HL         ; 1:4       push(192)
    ld   HL, 192        ; 3:10      push(192)
    call(right)
    
    push DE             ; 1:11      push(8)
    ex   DE, HL         ; 1:4       push(8)
    ld   HL, 8          ; 3:10      push(8)
    call(down)
    
    push DE             ; 1:11      push(192)
    ex   DE, HL         ; 1:4       push(192)
    ld   HL, 192        ; 3:10      push(192)
    call(left)
    
    push DE             ; 1:11      push(119)
    ex   DE, HL         ; 1:4       push(119)
    ld   HL, 119        ; 3:10      push(119)
    call(down)
    
    push DE             ; 1:11      push(192)
    ex   DE, HL         ; 1:4       push(192)
    ld   HL, 192        ; 3:10      push(192)
    call(right)
    
    push DE             ; 1:11      push(119)
    ex   DE, HL         ; 1:4       push(119)
    ld   HL, 119        ; 3:10      push(119)
    call(up)
    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )

    
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====

;#COLON(diagonala,{})
;# diagonala(y,x) 0,0 --> 99,99
;#    XDO(25700,0)
;#        XI
;#        PUTPIXEL   ; ( Y*256+X -- addr )
;#        DROP
;#    PUSH_ADDXLOOP(256+1)
;#SEMICOLON


;   ---  the beginning of a non-recursive function  ---
left:                   ;           ( yx n -- yx )
    pop  BC             ; 1:10      : ret
    ld  (left_end+1),BC ; 4:20      : ( ret -- )
    ;( yx n -- yx )
    
    ld    B, H          ; 1:4       for 103
    ld    C, L          ; 1:4       for 103
    ex   DE, HL         ; 1:4       for 103
    pop  DE             ; 1:10      for 103 index
for103:                 ;           for 103
    ld  (idx103),BC     ; 4:20      for 103 save index
        
    call PIXEL          ; 3:17      pixel   ( yx -- yx )
         ; x--
        
    dec  HL             ; 1:6       1-
    
idx103 EQU $+1          ;           next 103
    ld   BC, 0x0000     ; 3:10      next 103 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 103
    or    C             ; 1:4       next 103
    dec  BC             ; 1:6       next 103 index--, zero flag unaffected
    jp   nz, for103     ; 3:10      next 103
next103:                ;           next 103

left_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
right:                  ;           ( yx n -- yx )
    pop  BC             ; 1:10      : ret
    ld  (right_end+1),BC; 4:20      : ( ret -- )
    ;( yx n -- yx )
    
    ld    B, H          ; 1:4       for 104
    ld    C, L          ; 1:4       for 104
    ex   DE, HL         ; 1:4       for 104
    pop  DE             ; 1:10      for 104 index
for104:                 ;           for 104
    ld  (idx104),BC     ; 4:20      for 104 save index
        
    call PIXEL          ; 3:17      pixel   ( yx -- yx )
         ; x++
        
    inc  HL             ; 1:6       1+
    
idx104 EQU $+1          ;           next 104
    ld   BC, 0x0000     ; 3:10      next 104 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 104
    or    C             ; 1:4       next 104
    dec  BC             ; 1:6       next 104 index--, zero flag unaffected
    jp   nz, for104     ; 3:10      next 104
next104:                ;           next 104

right_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
up:                     ;           ( yx n -- yx )
    pop  BC             ; 1:10      : ret
    ld  (up_end+1),BC   ; 4:20      : ( ret -- )
    ;( yx n -- yx )
    
    ld    B, H          ; 1:4       for 105
    ld    C, L          ; 1:4       for 105
    ex   DE, HL         ; 1:4       for 105
    pop  DE             ; 1:10      for 105 index
for105:                 ;           for 105
    ld  (idx105),BC     ; 4:20      for 105 save index
        
    call PIXEL          ; 3:17      pixel   ( yx -- yx )
        ; y--
        
    dec  H              ; 1:4       256 -   ( x -- x-0x0100 )
    
idx105 EQU $+1          ;           next 105
    ld   BC, 0x0000     ; 3:10      next 105 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 105
    or    C             ; 1:4       next 105
    dec  BC             ; 1:6       next 105 index--, zero flag unaffected
    jp   nz, for105     ; 3:10      next 105
next105:                ;           next 105

up_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
down:                   ;           ( yx n -- yx )
    pop  BC             ; 1:10      : ret
    ld  (down_end+1),BC ; 4:20      : ( ret -- )
    ;( yx n -- yx )
    
    ld    B, H          ; 1:4       for 106
    ld    C, L          ; 1:4       for 106
    ex   DE, HL         ; 1:4       for 106
    pop  DE             ; 1:10      for 106 index
for106:                 ;           for 106
    ld  (idx106),BC     ; 4:20      for 106 save index
        
    call PIXEL          ; 3:17      pixel   ( yx -- yx )
        ; y++
        
    inc  H              ; 1:4       256 +   ( x -- x+0x0100 )
    
idx106 EQU $+1          ;           next 106
    ld   BC, 0x0000     ; 3:10      next 106 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 106
    or    C             ; 1:4       next 106
    dec  BC             ; 1:6       next 106 index--, zero flag unaffected
    jp   nz, for106     ; 3:10      next 106
next106:                ;           next 106

down_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------

; Rutina ziska adresu bajtu s pixelem v HL a v A bude maska pro dany bajt
; Input: H = Y, L = X
; Y = bb rrr sss X = ccccc ...
; Output: HL = adresa bajtu, A = maska pixelu
; H = 010 bb sss L = rrr ccccc
; bb:    číslo bloku 0,1,2 (v bloku číslo 3 je atributová paměť)
; sss:   číslo řádky v jednom znaku, který je vysoký osm obrazových řádků
; rrr:   pozice textového řádku v bloku. Každý blok je vysoký 64 obrazových řádků, což odpovídá osmi řádkům textovým
; ccccc: index sloupce bajtu v rozmezí 0..31, kde je uložena osmice sousedních pixelů
PIXEL:
    push HL             ; 1:11
    ld    B, H          ; 1:4
    ld    C, L          ; 1:4

    ld    A, H          ; 1:4       bbrrrsss = Y
    or    0x01          ; 2:7       bbrrrss1 carry = 0
    rra                 ; 1:4       0bbrrrss carry = 1
    rra                 ; 1:4       10bbrrrs carry = s?
    and   A             ; 1:4       10bbrrrs carry = 0
    rra                 ; 1:4       010bbrrr
    ld    L, A          ; 1:4       .....rrr
    xor   H             ; 1:4       ????????
    and   0xF8          ; 2:7       ?????000
    xor   H             ; 1:4       010bbsss
    ld    H, A          ; 1:4       H = 64+8*INT (b/64)+(b mod 8)

    ld    A, L          ; 1:4       .....rrr
    xor   C             ; 1:4       ???????? provede se 2x takze zadna zmena, mezitim ale vynulujeme hornich 5 bitu
    and   0x07          ; 2:7       00000???
    xor   C             ; 1:4       cccccrrr
    rrca                ; 1:4       rcccccrr
    rrca                ; 1:4       rrcccccr
    rrca                ; 1:4       rrrccccc
    ld    L, A          ; 1:4       L = 32*INT (b/(b mod 64)/8)+INT (x/8).

    ld    A, C          ; 1:4
    and   0x07          ; 2:7       .....iii Index pixelu v bajtu, nejvyssi je 0, nejnizsi je 7, coz je opacne nez chceme
    rlca                ; 1:4       0000iii0
    rlca                ; 1:4       000iii00
    xor   %01111111     ; 2:7       0??xxx11, carry = 0, xxx = 7 - iii, ??: 11=set, 10=res, 01=bit
    rla                 ; 1:4       ??xxx110
    ld   ($+4), A       ; 3:13
PIXEL_MODE:
    set   0,(HL)        ; 2:15      0xCB 0xC6..+8..0xFE %11xx x110
;   bit   0,(HL)        ; 2:12      0xCB 0x46..+8..0x7E %01xx x110
;   res   0,(HL)        ; 2:15      0xCB 0x86..+8..0xBE %10xx x110
    pop  HL             ; 1:10
    ret                 ; 1:10
;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_S16:                ;           prt_s16
    ld    A, H          ; 1:4       prt_s16
    add   A, A          ; 1:4       prt_s16
    jr   nc, PRT_U16    ; 2:7/12    prt_s16
    ld    A, '-'        ; 2:7       prt_s16   putchar Pollutes: AF, DE', BC'
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
    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
;==============================================================================
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst  0x10           ; 1:11      print_string_z putchar with ZX 48K ROM in, this will print char in A
    inc  BC             ; 1:6       print_string_z
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z

STRING_SECTION:
string104:
db ZX_BRIGHT,1,ZX_AT, 5,4,"                        ",ZX_AT, 6,4,"Lorem ipsum dolor sit a-",ZX_AT, 7,4,"met, consectetur adipis-",ZX_AT, 8,4,"cing elit. Etiam pellen-",ZX_AT, 9,4,"tesque,  purus a  tinci-",ZX_AT,10,4,"dunt euismod, turpis ne-",ZX_AT,11,4,"que  pretium   ante,  et",ZX_AT,12,4,"tempor purus metus a ni-",ZX_AT,13,4,"sl. Aenean dictum tortor",ZX_AT,14,4,"hendrerit  nibh   luctus",ZX_AT,15,4,"condimentum.",ZX_AT,1,1, 0x00
size104 EQU $ - string104
string103:
db " values in data stack", 0x00
size103 EQU $ - string103
string102:
db ZX_AT,4,4,ZX_PAPER,ZX_INK_CYAN, 0x00
size102 EQU $ - string102
string101:
db "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pellentesque, purus a tincidunt euismod, turpis neque pretium ante, et tempor purus metus a nisl.Aenean dictum tortor hendrerit nibh luctus condimentum. Pellentesque vel urna eget risus dignissim volutpat. Praesent semper nisi quam, id egestas odio luctus ut. Suspendisse dignissim lobortis massa nec maximus. Interdum etmalesuada fames ac ante ipsum primis in faucibus. Curabitur quisdui a lacus fringilla venenatis sed vel lacus. Duis scelerisque orci a risus cursus, in facilisis metus condimentum. Sed ultricies nibh vitae pretium placerat. Fusce et nibh at ante vehicula pharetra sed quis nisi. Aliquam tincidunt nulla at enim efficiturlaoreet. Maecenas aliquam liberometus, nec commodo lacus vestibu", 0x00
size101 EQU $ - string101
