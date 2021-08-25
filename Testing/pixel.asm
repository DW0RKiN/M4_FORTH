; vvvv
; ^^^^
    ORG 32768  
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10      Init Return address stack
    exx                 ; 1:4
    ld  hl, stack_test
    push hl

    
    call test           ; 3:17      call ( -- ret ) R:( -- )
    
    
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
    ret
    

;   ---  the beginning of a data stack function  ---
stack_test:             ;           
    
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print    
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====

stack_test_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


;   ---  the beginning of a non-recursive function  ---
test:                   ;           
    pop  BC             ; 1:10      : ret
    ld  (test_end+1),BC ; 4:20      : ( ret -- ) R:( -- )
; diagonala(y,x) 0,0 --> 99,99
    

    ld   BC, 0          ; 3:10      xdo(25700,0) 101
    ld  (idx101),BC     ; 4:20      xdo(25700,0) 101
xdo101:                 ;           xdo(25700,0) 101  
        
    push DE             ; 1:11      index xi 101
    ex   DE, HL         ; 1:4       index xi 101
    ld   HL, (idx101)   ; 3:16      index xi 101 idx always points to a 16-bit index 
        
    call PIXEL          ; 3:17      pixel 
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    push HL             ; 1:11      256+1 +xloop 101
idx101 EQU $+1          ;           256+1 +xloop 101
    ld   HL, 0x0000     ; 3:10      256+1 +xloop 101
    ld   BC, 256+1      ; 3:10      256+1 +xloop 101 BC = step
    add  HL, BC         ; 1:11      256+1 +xloop 101 HL = index+step
    ld  (idx101), HL    ; 3:16      256+1 +xloop 101 save index
    ld    A, low 25699  ; 2:7       256+1 +xloop 101
    sub   L             ; 1:4       256+1 +xloop 101
    ld    L, A          ; 1:4       256+1 +xloop 101
    ld    A, high 25699 ; 2:7       256+1 +xloop 101
    sbc   A, H          ; 1:4       256+1 +xloop 101
    ld    H, A          ; 1:4       256+1 +xloop 101 HL = stop-(index+step)
    add  HL, BC         ; 1:11      256+1 +xloop 101 HL = stop-index
    pop  HL             ; 1:10      256+1 +xloop 101
    jp   nc, xdo101     ; 3:10      256+1 +xloop 101 positive step
xleave101:              ;           256+1 +xloop 101
xexit101:               ;           256+1 +xloop 101
    
; horizontalni(y,x) 50,0 -> 50,199
    

    ld   BC, 256*50     ; 3:10      xdo(256*50+200,256*50) 102
    ld  (idx102),BC     ; 4:20      xdo(256*50+200,256*50) 102
xdo102:                 ;           xdo(256*50+200,256*50) 102
        
    push DE             ; 1:11      index xi 102
    ex   DE, HL         ; 1:4       index xi 102
    ld   HL, (idx102)   ; 3:16      index xi 102 idx always points to a 16-bit index 
        
    call PIXEL          ; 3:17      pixel 
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
idx102 EQU $+1          ;           xloop 102 hi index == hi stop && index < stop
    ld   BC, 0x0000     ; 3:10      xloop 102 idx always points to a 16-bit index
    ld    A, C          ; 1:4       xloop 102
    inc   A             ; 1:4       xloop 102 index++
    ld  (idx102),A      ; 3:13      xloop 102 save index
    sub  low 256*50+200 ; 2:7       xloop 102 index - stop
    jp    c, xdo102     ; 3:10      xloop 102
xleave102:              ;           xloop 102
xexit102:               ;           xloop 102
    
; vertikalni(y,x) 0,200 -> 49,200
    

    ld   BC, 200        ; 3:10      xdo(256*50+200,200) 103
    ld  (idx103),BC     ; 4:20      xdo(256*50+200,200) 103
xdo103:                 ;           xdo(256*50+200,200) 103
        
    push DE             ; 1:11      index xi 103
    ex   DE, HL         ; 1:4       index xi 103
    ld   HL, (idx103)   ; 3:16      index xi 103 idx always points to a 16-bit index 
        
    call PIXEL          ; 3:17      pixel 
        
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    push HL             ; 1:11      256 +xloop 103
idx103 EQU $+1          ;           256 +xloop 103
    ld   HL, 0x0000     ; 3:10      256 +xloop 103
    ld   BC, 256        ; 3:10      256 +xloop 103 BC = step
    add  HL, BC         ; 1:11      256 +xloop 103 HL = index+step
    ld  (idx103), HL    ; 3:16      256 +xloop 103 save index
    ld    A, low 12999  ; 2:7       256 +xloop 103
    sub   L             ; 1:4       256 +xloop 103
    ld    L, A          ; 1:4       256 +xloop 103
    ld    A, high 12999 ; 2:7       256 +xloop 103
    sbc   A, H          ; 1:4       256 +xloop 103
    ld    H, A          ; 1:4       256 +xloop 103 HL = stop-(index+step)
    add  HL, BC         ; 1:11      256 +xloop 103 HL = stop-index
    pop  HL             ; 1:10      256 +xloop 103
    jp   nc, xdo103     ; 3:10      256 +xloop 103 positive step
xleave103:              ;           256 +xloop 103
xexit103:               ;           256 +xloop 103
    

test_end:
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

