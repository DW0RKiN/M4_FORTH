; vvvv
; ^^^^
    ORG 32768  
    ld  hl, stack_test
    push hl
    
;   ===  b e g i n  ===
    exx                 ; 1:4
    push HL             ; 1:11
    push DE             ; 1:11
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    
    call test           ; 3:17      call
    ex   DE, HL         ; 1:4       call    
    exx                 ; 1:4       call R:( ret -- )
    
    
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print

    exx
    push HL
    exx
    pop HL
    
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_U16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    
    pop  DE             ; 1:10
    pop  HL             ; 1:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====
    

;   ---  b e g i n  ---
stack_test:             ;           
    
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    

stack_test_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


;   ---  b e g i n  ---
test:                   ;           
    exx                 ; 1:4       :
    pop  DE             ; 1:10      : ret
    dec  HL             ; 1:6       :
    ld  (HL),D          ; 1:7       :
    dec   L             ; 1:4       :
    ld  (HL),E          ; 1:7       : (HL') = ret
    exx                 ; 1:4       : R:( -- ret )
; diagonala(y,x) 0,0 --> 99,99
    

    exx                 ; 1:4       xdo(25700,0) 101
    dec  HL             ; 1:6       xdo(25700,0) 101
    ld  (HL),high 0     ; 2:10      xdo(25700,0) 101
    dec   L             ; 1:4       xdo(25700,0) 101
    ld  (HL),low 0      ; 2:10      xdo(25700,0) 101
    exx                 ; 1:4       xdo(25700,0) 101 R:( -- 0 )
xdo101:                 ;           xdo(25700,0) 101  
        
    exx                 ; 1:4       index xi 101
    ld    E,(HL)        ; 1:7       index xi 101
    inc   L             ; 1:4       index xi 101
    ld    D,(HL)        ; 1:7       index xi 101
    push DE             ; 1:11      index xi 101
    dec   L             ; 1:4       index xi 101
    exx                 ; 1:4       index xi 101 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 101
    ex  (SP),HL         ; 1:19      index xi 101 ( -- x ) 
        
    call PIXEL          ; 3:17      pixel 
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    exx                 ; 1:4       xaddloop 101
    ld    A, low 256+1  ; 2:7       xaddloop 101
    add   A, (HL)       ; 1:7       xaddloop 101
    ld    E, A          ; 1:4       xaddloop 101 lo index
    inc   L             ; 1:4       xaddloop 101
    ld    A, high 256+1 ; 2:7       xaddloop 101
    adc   A, (HL)       ; 1:7       xaddloop 101
    ld  (HL), A         ; 1:7       xaddloop 101 hi index
    ld    A, E          ; 1:4       xaddloop 101
    sub   low 25700     ; 2:7       xaddloop 101
    ld    A, (HL)       ; 1:7       xaddloop 101
    sbc   A, high 25700 ; 2:7       xaddloop 101 index - stop
    jr   nc, xleave101  ; 2:7/12    xaddloop 101
    dec   L             ; 1:4       xaddloop 101
    ld  (HL), E         ; 1:7       xaddloop 101
    exx                 ; 1:4       xaddloop 101
    jp   xdo101         ; 3:10      xaddloop 101
xleave101:
    inc  HL             ; 1:6       xaddloop 101
    exx                 ; 1:4       xaddloop 101 R:( index -- )
    
; horizontalni(y,x) 50,0 -> 50,199
    

    exx                 ; 1:4       xdo(256*50+200,256*50) 102
    dec  HL             ; 1:6       xdo(256*50+200,256*50) 102
    ld  (HL),high 256*50; 2:10      xdo(256*50+200,256*50) 102
    dec   L             ; 1:4       xdo(256*50+200,256*50) 102
    ld  (HL),low 256*50 ; 2:10      xdo(256*50+200,256*50) 102
    exx                 ; 1:4       xdo(256*50+200,256*50) 102 R:( -- 256*50 )
xdo102:                 ;           xdo(256*50+200,256*50) 102
        
    exx                 ; 1:4       index xi 102
    ld    E,(HL)        ; 1:7       index xi 102
    inc   L             ; 1:4       index xi 102
    ld    D,(HL)        ; 1:7       index xi 102
    push DE             ; 1:11      index xi 102
    dec   L             ; 1:4       index xi 102
    exx                 ; 1:4       index xi 102 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 102
    ex  (SP),HL         ; 1:19      index xi 102 ( -- x ) 
        
    call PIXEL          ; 3:17      pixel 
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    exx                 ; 1:4       xloop(256*50+200,256*50) 102

    ld    E,(HL)        ; 1:7       xloop(256*50+200,256*50) 102
    inc   L             ; 1:4       xloop(256*50+200,256*50) 102
    ld    D,(HL)        ; 1:7       xloop(256*50+200,256*50) 102
    inc  DE             ; 1:6       xloop(256*50+200,256*50) 102 index++
    ld    A, low 256*50+200; 2:7       xloop(256*50+200,256*50) 102
    scf                 ; 1:4       xloop(256*50+200,256*50) 102
    sbc   A, E          ; 1:4       xloop(256*50+200,256*50) 102 stop_lo - index_lo - 1
    ld    A, high 256*50+200; 2:7       xloop(256*50+200,256*50) 102
    sbc   A, D          ; 1:4       xloop(256*50+200,256*50) 102 stop_hi - index_hi - 1
    jr    c, xleave102  ; 2:7/12    xloop(256*50+200,256*50) 102 exit
    ld  (HL), D         ; 1:7       xloop(256*50+200,256*50) 102
    dec   L             ; 1:4       xloop(256*50+200,256*50) 102
    ld  (HL), E         ; 1:6       xloop(256*50+200,256*50) 102
    exx                 ; 1:4       xloop(256*50+200,256*50) 102
    jp   xdo102         ; 3:10      xloop 102
xleave102:              ;           xloop(256*50+200,256*50) 102
    inc  HL             ; 1:6       xloop(256*50+200,256*50) 102
    exx                 ; 1:4       xloop(256*50+200,256*50) 102 R:( index -- )
    
; vertikalni(y,x) 0,200 -> 49,200
    

    exx                 ; 1:4       xdo(256*50+200,200) 103
    dec  HL             ; 1:6       xdo(256*50+200,200) 103
    ld  (HL),high 200   ; 2:10      xdo(256*50+200,200) 103
    dec   L             ; 1:4       xdo(256*50+200,200) 103
    ld  (HL),low 200    ; 2:10      xdo(256*50+200,200) 103
    exx                 ; 1:4       xdo(256*50+200,200) 103 R:( -- 200 )
xdo103:                 ;           xdo(256*50+200,200) 103
        
    exx                 ; 1:4       index xi 103
    ld    E,(HL)        ; 1:7       index xi 103
    inc   L             ; 1:4       index xi 103
    ld    D,(HL)        ; 1:7       index xi 103
    push DE             ; 1:11      index xi 103
    dec   L             ; 1:4       index xi 103
    exx                 ; 1:4       index xi 103 R:( x -- x )
    ex   DE, HL         ; 1:4       index xi 103
    ex  (SP),HL         ; 1:19      index xi 103 ( -- x ) 
        
    call PIXEL          ; 3:17      pixel 
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    exx                 ; 1:4       xaddloop 103
    ld    A, low 256    ; 2:7       xaddloop 103
    add   A, (HL)       ; 1:7       xaddloop 103
    ld    E, A          ; 1:4       xaddloop 103 lo index
    inc   L             ; 1:4       xaddloop 103
    ld    A, high 256   ; 2:7       xaddloop 103
    adc   A, (HL)       ; 1:7       xaddloop 103
    ld  (HL), A         ; 1:7       xaddloop 103 hi index
    ld    A, E          ; 1:4       xaddloop 103
    sub   low 256*50+200; 2:7       xaddloop 103
    ld    A, (HL)       ; 1:7       xaddloop 103
    sbc   A, high 256*50+200; 2:7       xaddloop 103 index - stop
    jr   nc, xleave103  ; 2:7/12    xaddloop 103
    dec   L             ; 1:4       xaddloop 103
    ld  (HL), E         ; 1:7       xaddloop 103
    exx                 ; 1:4       xaddloop 103
    jp   xdo103         ; 3:10      xaddloop 103
xleave103:
    inc  HL             ; 1:6       xaddloop 103
    exx                 ; 1:4       xaddloop 103 R:( index -- )
    

test_end:
    exx                 ; 1:4       ;
    ld    E,(HL)        ; 1:7       ;
    inc   L             ; 1:4       ;
    ld    D,(HL)        ; 1:7       ; DE = ret
    inc  HL             ; 1:6       ;
    ex   DE, HL         ; 1:4       ;
    jp  (HL)            ; 1:4       ;
;   -----  e n d  -----
    


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
    ret                 ; 1:10

; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, AF', BC, DE, HL = DE, DE = (SP)
PRINT_U16:
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A

; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_U16_ONLY:
    call BIN2DEC        ; 3:17
    pop  BC             ; 1:10      ret
    ex   DE, HL         ; 1:4
    pop  DE             ; 1:10
    push BC             ; 1:10      ret
    ret                 ; 1:10
STRNUM:
DB      "65536 "

; Input: HL = number
; Output: print number
; Pollutes: AF, HL, BC
BIN2DEC:
    xor   A             ; 1:4       A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10
    call BIN2DEC_CHAR+2 ; 3:17    
    ld   BC, -1000      ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld   BC, -100       ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld    C, -10        ; 2:7
    call BIN2DEC_CHAR   ; 3:17
    ld    A, L          ; 1:4
    add   A,'0'         ; 2:7
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10
    
BIN2DEC_CHAR:
    and  0xF0           ; 2:7       '0'..'9' => '0', unchanged 0
    
    add  HL, BC         ; 1:11
    inc   A             ; 1:4
    jr    c, $-2        ; 2:7/12
    sbc  HL, BC         ; 2:15
    dec   A             ; 1:4
    ret   z             ; 1:5/11
    
    or   '0'            ; 2:7       0 => '0', unchanged '0'..'9'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10
VARIABLE_SECTION:

STRING_SECTION:
string102:
db 0xD, "Data stack OK!", 0xD
size102 EQU $ - string102
string101:
db "RAS:"
size101 EQU $ - string101

