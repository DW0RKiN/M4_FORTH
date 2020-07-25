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
ifdef({USE_LINE},{
line:
    call  Pixel_addr    ; 3:17

    ld    A, H          ; 1:4    
    sub   D             ; 1:4
    jr   nc, $+4        ; 2:8
    neg                 ; 1:4
    ld    C, A          ; 1:4       C = abs(dy)
    
    ld    A, L          ; 1:4
    sub   E             ; 1:4
    jr   nc, $+4        ; 2:8
    neg                 ; 1:4
    ld    B, A          ; 1:4       B = abs(dx)
    
    cp    C             ; 1:4       abs(dx) - abs(dy)
    jr   nc, line_hor   ; 2:7/12

;------ vertical line ------

    ld    A, H          ; 1:4
    sub   D             ; 1:4       y1-y0
    ld    A, L          ; 1:4    
    jr   nc, line_ver_d ; 2:8

line_ver_u:
    ld   HL, Pixel_U    ; 3:10
    ld  (line_n_adr), HL; 3:16

    sub   E             ; 1:4       x1-x0
    ld   HL, Pixel_RU   ; 3:10
    jr   nc, line_ver_c ; 2:8
    ld   HL, Pixel_LU   ; 3:10
    jp   line_ver_c     ; 3:10

line_ver_d:
    ld   HL, Pixel_D    ; 3:10
    ld  (line_n_adr), HL; 3:16

    sub   E             ; 1:4       x1-x0
    ld   HL, Pixel_RD   ; 3:10
    jr   nc, line_ver_c ; 2:8
    ld   HL, Pixel_LD   ; 3:10

line_ver_c:
    ld  (line_p_adr), HL; 3:16

    ld    A, C          ; 1:4       abs(dy)
    ld    C, B          ; 1:4
    ld    B, A          ; 1:4       B <-> C
    sub   C             ; 1:4       abs(dy)-abs(dx)
    ld    E, A          ; 1:4
    
    ld    A, B          ; 1:4       abs(dy)
    rra                 ; 1:4       dy/2
    ld    D, A          ; 1:4
    ld    A, C          ; 1:4       abs(dx)
    sub   D             ; 1:4       abs(dx)-abs(dy)/2

    inc   B             ; 1:4 

    ccf                 ; 1:4
;-----------

line_n_loop:
    jr    c, line_p_in  ; 2:7/12
line_n_in:
    exx                 ; 1:4
    ex   AF, AF'        ; 1:4
    ld    A,(DE)        ; 1:7
    or    C             ; 1:4
    ld  (DE),A          ; 1:7
line_n_adr EQU $+1
    call 0x0000         ; 3:17
    ex   AF, AF'        ; 1:4
    exx                 ; 1:4
    
    add   A, C          ; 1:4       +dy
    
    djnz line_n_loop    ; 2:8/13
    ret                 ; 1:10

;------ horizontal line ------

line_hor:

    ld    A, L          ; 1:4
    sub   E             ; 1:4       x1-x0
    ld    A, H          ; 1:4    
    jr   nc, line_hor_r ; 2:8

line_hor_l:
    ld   HL, Pixel_L    ; 3:10
    ld  (line_n_adr), HL; 3:16

    sub   D             ; 1:4       y1-y0
    ld   HL, Pixel_LD   ; 3:10
    jr   nc, line_hor_c ; 2:8
    ld   HL, Pixel_LU   ; 3:10
    jp   line_hor_c     ; 3:10

line_hor_r:
    ld   HL, Pixel_R    ; 3:10
    ld  (line_n_adr), HL; 3:16

    sub   D             ; 1:4       y1-y0
    ld   HL, Pixel_RD   ; 3:10
    jr   nc, line_hor_c ; 2:8
    ld   HL, Pixel_RU   ; 3:10

line_hor_c:
    ld  (line_p_adr), HL; 3:16

    ld    A, B          ; 1:4       abs(dx)
    sub   C             ; 1:4       abs(dx)-abs(dy)
    ld    E, A          ; 1:4

    ld    A, B          ; 1:4       abs(dx)
    rra                 ; 1:4       dx/2
    ld    D, A          ; 1:4
    ld    A, C          ; 1:4       abs(dy)
    sub   D             ; 1:4       abs(dy)-abs(dx)/2
        
    inc   B             ; 1:4

;-----------
    
line_p_loop:
    jr    c, line_n_in  ; 2:7/12
line_p_in:
    exx                 ; 1:4
    ex   AF, AF'        ; 1:4
    ld    A,(DE)        ; 1:7
    or    C             ; 1:4
    ld  (DE),A          ; 1:7
line_p_adr EQU $+1
    call 0x0000         ; 3:17
    ex   AF, AF'        ; 1:4
    exx                 ; 1:4

    sub   E             ; 1:4       error-(dx-dy)
    
    djnz line_p_loop    ; 2:8/13
    ret                 ; 1:10

;==================


Pixel_LD:     
    rlc   C             ; 2:8
    jr   nc, $+3        ; 2:7/12    
    dec   E             ; 1:4

    inc   D             ; 1:4       Go down onto the next pixel line
    ld    A, D          ; 1:4       
    and  0x07           ; 2:7
    ret  nz             ; 1:5/11    
                        ;           
    ld    A, E          ; 1:4       next char line
    add   A, 0x20       ; 2:7       
    ld    E, A          ; 1:4
    ret   c             ; 1:5/11    
                        ;           
    ld    A, D          ; 1:4       not cross a third
    sub  0x08           ; 2:7
    ld    D, A          ; 1:4
    ret                 ; 1:10


Pixel_LU:     
    rlc   C             ; 2:8
    jr   nc, $+3        ; 2:7/12    
    dec   E             ; 1:4

    ld    A, D          ; 1:4    
    dec   D             ; 1:4       Go up onto the next pixel line
    and  0x07           ; 2:7
    ret  nz             ; 1:5/11
                        ;           
    ld    A, E          ; 1:4       next char line
    sub  0x20           ; 2:7
    ld    E, A          ; 1:4
    ret   c             ; 1:5/11
                        ;
    ld    A, D          ; 1:4       not cross a third
    add   A, 0x08       ; 2:7
    ld    D, A          ; 1:4
    ret                 ; 1:10

Pixel_RD:     
    rrc   C             ; 2:8
    jr   nc, $+3        ; 2:7/12    
    inc   E             ; 1:4

    inc   D             ; 1:4       Go down onto the next pixel line
    ld    A, D          ; 1:4       
    and  0x07           ; 2:7
    ret  nz             ; 1:5/11    
                        ;           
    ld    A, E          ; 1:4       next char line
    add   A, 0x20       ; 2:7       
    ld    E, A          ; 1:4
    ret   c             ; 1:5/11    
                        ;           
    ld    A, D          ; 1:4       not cross a third
    sub  0x08           ; 2:7
    ld    D, A          ; 1:4
    ret                 ; 1:10

Pixel_RU:     
    rrc   C             ; 2:8
    jr   nc, $+3        ; 2:7/12    
    inc   E             ; 1:4

    ld    A, D          ; 1:4    
    dec   D             ; 1:4       Go up onto the next pixel line
    and  0x07           ; 2:7
    ret  nz             ; 1:5/11
                        ;           
    ld    A, E          ; 1:4       next char line
    sub  0x20           ; 2:7
    ld    E, A          ; 1:4
    ret   c             ; 1:5/11
                        ;
    ld    A, D          ; 1:4       not cross a third
    add   A, 0x08       ; 2:7
    ld    D, A          ; 1:4
    ret                 ; 1:10

Pixel_L:     
    rlc   C             ; 2:8
    ret  nc             ; 1:5/11
    
    dec   E             ; 1:4
    ret                 ; 1:10

Pixel_R:     
    rrc   C             ; 2:8
    ret  nc             ; 1:5/11
    
    inc   E             ; 1:4
    ret                 ; 1:10

Pixel_D:     
    inc   D             ; 1:4       Go down onto the next pixel line
    ld    A, D          ; 1:4       
    and  0x07           ; 2:7
    ret  nz             ; 1:5/11    
                        ;           
    ld    A, E          ; 1:4       next char line
    add   A, 0x20       ; 2:7       
    ld    E, A          ; 1:4
    ret   c             ; 1:5/11    
                        ;           
    ld    A, D          ; 1:4       not cross a third
    sub  0x08           ; 2:7
    ld    D, A          ; 1:4
    ret                 ; 1:10

Pixel_U:
    ld    A, D          ; 1:4    
    dec   D             ; 1:4       Go up onto the next pixel line
    and  0x07           ; 2:7
    ret  nz             ; 1:5/11
                        ;           
    ld    A, E          ; 1:4       next char line
    sub  0x20           ; 2:7
    ld    E, A          ; 1:4
    ret   c             ; 1:5/11
                        ;
    ld    A, D          ; 1:4       not cross a third
    add   A, 0x08       ; 2:7
    ld    D, A          ; 1:4
    ret                 ; 1:10


; Rutina ziska adresu bajtu s pixelem v HL a v A bude maska pro dany bajt
; Input: H = Y, L = X
; Y = bb rrr sss X = ccccc ...
; Output: HL = adresa bajtu, A = maska pixelu
; H = 010 bb sss L = rrr ccccc
; bb:    číslo bloku 0,1,2 (v bloku číslo 3 je atributová paměť)
; sss:   číslo řádky v jednom znaku, který je vysoký osm obrazových řádků
; rrr:   pozice textového řádku v bloku. Každý blok je vysoký 64 obrazových řádků, což odpovídá osmi řádkům textovým
; ccccc: index sloupce bajtu v rozmezí 0..31, kde je uložena osmice sousedních pixelů

Pixel_addr:
    push DE             ; 1:11      YX
    exx                 ; 1:4
    pop  BC             ; 1:10      B = Y, C = X
    
    ld    A, B          ; 1:4       bbrrrsss = Y
    or   0x01           ; 2:7       bbrrrss1 carry = 0
    rra                 ; 1:4       0bbrrrss carry = 1
    rra                 ; 1:4       10bbrrrs carry = s?
    and   A             ; 1:4       10bbrrrs carry = 0
    rra                 ; 1:4       010bbrrr
    ld    E, A          ; 1:4       .....rrr
    xor   B             ; 1:4       ???????? 
    and  0xF8           ; 2:7       ?????000
    xor   B             ; 1:4       010bbsss 
    ld    D, A          ; 1:4       D = 64+8*INT (b/64)+(b mod 8)

    ld    A, E          ; 1:4       .....rrr
    xor   C             ; 1:4       ???????? provede se 2x takze zadna zmena, mezitim ale vynulujeme hornich 5 bitu
    and  0x07           ; 2:7       00000???
    xor   C             ; 1:4       cccccrrr
    rrca                ; 1:4       rcccccrr
    rrca                ; 1:4       rrcccccr
    rrca                ; 1:4       rrrccccc
    ld    E, A          ; 1:4       E = 32*INT (b/(b mod 64)/8)+INT (x/8).
 
    ld    A, C          ; 1:4
    and  0x07           ; 2:7       .....iii Index pixelu v bajtu, nejvyssi je 0, nejnizsi je 7, coz je opacne nez chceme
    ld    B, A          ; 1:4
    inc   B             ; 1:4
    ld    A, 0x01       ; 2:7
    rrca                ; 1:4
    djnz $-1            ; 2:13/8
    ld    C, A          ; 1:11
    exx                 ; 1:4
    ret                 ; 1:10})dnl
dnl
dnl
