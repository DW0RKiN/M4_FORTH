dnl
dnl
ifdef({USE_PIXEL},{

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
})dnl
dnl
dnl
