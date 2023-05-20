        ORG 0x8000
    

    max                  EQU 10
    
data               EQU __create_data
    

     
     
     
     
    

      
    
      
    


       
    
    
          
     
    



       
    
    
          
     
    



         



             



    
       
    
        



    
       
     
         
                  
        
         
                 
        
          
                 
        
      
     



      
    
          
          



       
         
    
        


;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
                        ;           create data
                        ;           2*10 allot
                        ;[8:42]     data 10   ( -- data 10 )
    push DE             ; 1:11      data 10
    push HL             ; 1:11      data 10
    ld   DE, data       ; 3:10      data 10
    ld   HL, 0x000A     ; 3:10      data 10
    call generate       ; 3:17      call ( -- )
                        ;[8:42]     data 10   ( -- data 10 )
    push DE             ; 1:11      data 10
    push HL             ; 1:11      data 10
    ld   DE, data       ; 3:10      data 10
    ld   HL, 0x000A     ; 3:10      data 10
    call print          ; 3:17      call ( -- )
                        ;[8:42]     data 10   ( -- data 10 )
    push DE             ; 1:11      data 10
    push HL             ; 1:11      data 10
    ld   DE, data       ; 3:10      data 10
    ld   HL, 0x000A     ; 3:10      data 10
    call sort           ; 3:17      call ( -- )
                        ;[8:42]     data 10   ( -- data 10 )
    push DE             ; 1:11      data 10
    push HL             ; 1:11      data 10
    ld   DE, data       ; 3:10      data 10
    ld   HL, 0x000A     ; 3:10      data 10
    call print          ; 3:17      call ( -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    rr    H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth
    call PRT_S16        ; 3:17      .   ( s -- )
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z
    ex   DE, HL         ; 1:4       ras   ( -- return_address_stack )
    exx                 ; 1:4       ras
    push HL             ; 1:11      ras
    exx                 ; 1:4       ras
    ex  (SP),HL         ; 1:19      ras
    push DE             ; 1:11      print     "RAS:"
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
generate:               ;           (addr len -- )
    pop  BC             ; 1:10      : ret
    ld  (generate_end+1),BC; 4:20      : ( ret -- )
    add  HL, HL         ; 1:11      2*
    add  HL, DE         ; 1:11      over +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
; ( addr+len addr )
    ld  (idx101), HL    ; 3:16      do_101(m)   ( stop index -- )
    dec  DE             ; 1:6       do_101(m)
    ld    A, E          ; 1:4       do_101(m)
    ld  (stp_lo101), A  ; 3:13      do_101(m)   lo stop-1
    ld    A, D          ; 1:4       do_101(m)
    ld  (stp_hi101), A  ; 3:13      do_101(m)   hi stop-1
    pop  DE             ; 1:10      do_101(m)
    pop  HL             ; 1:10      do_101(m)
do101:                  ;           do_101(m)
    ex   DE, HL         ; 1:4       rnd
    push HL             ; 1:11      rnd
    call Rnd            ; 3:17      rnd
    push DE             ; 1:11      i_101(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_101(m)
    ld   HL, (idx101)   ; 3:16      i_101(m)   idx always points to a 16-bit index
                        ;[3:20]     !   ( x addr -- x addr+1 )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !   ( b a -- )
    pop  DE             ; 1:10      !
idx101 EQU $+1          ;           2 +loop_101(m)
    ld   BC, 0x0000     ; 3:10      2 +loop_101(m)   idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +loop_101(m)   index++
    ld    A, C          ; 1:4       2 +loop_101(m)
stp_lo101 EQU $+1       ;           2 +loop_101(m)
    sub  0xFF           ; 2:7       2 +loop_101(m)   lo index - stop-1
    rra                 ; 1:4       2 +loop_101(m)
    add   A, A          ; 1:4       2 +loop_101(m)   and 0xFE with save carry
    ld    A, B          ; 1:4       2 +loop_101(m)
    inc  BC             ; 1:6       2 +loop_101(m)   index++
    ld  (idx101),BC     ; 4:20      2 +loop_101(m)   save index
    jp   nz, do101      ; 3:10      2 +loop_101(m)
stp_hi101 EQU $+1       ;           2 +loop_101(m)
    sbc   A, 0xFF       ; 2:7       2 +loop_101(m)   hi index - stop-1
    jp   nz, do101      ; 3:10      2 +loop_101(m)
leave101:               ;           2 +loop_101(m)
exit101:                ;           2 +loop_101(m)
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
generate_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
print:                  ;           (addr len -- )
    pop  BC             ; 1:10      : ret
    ld  (print_end+1),BC; 4:20      : ( ret -- )
    add  HL, HL         ; 1:11      2*
    add  HL, DE         ; 1:11      over +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
; ( addr+len addr )
    ld  (idx102), HL    ; 3:16      do_102(m)   ( stop index -- )
    dec  DE             ; 1:6       do_102(m)
    ld    A, E          ; 1:4       do_102(m)
    ld  (stp_lo102), A  ; 3:13      do_102(m)   lo stop-1
    ld    A, D          ; 1:4       do_102(m)
    ld  (stp_hi102), A  ; 3:13      do_102(m)   hi stop-1
    pop  DE             ; 1:10      do_102(m)
    pop  HL             ; 1:10      do_102(m)
do102:                  ;           do_102(m)
    push DE             ; 1:11      i_102(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_102(m)
    ld   HL, (idx102)   ; 3:16      i_102(m)   idx always points to a 16-bit index
    ld    A, (HL)       ; 1:7       @   ( addr -- x )
    inc  HL             ; 1:6       @
    ld    H, (HL)       ; 1:7       @
    ld    L, A          ; 1:4       @
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
idx102 EQU $+1          ;           2 +loop_102(m)
    ld   BC, 0x0000     ; 3:10      2 +loop_102(m)   idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +loop_102(m)   index++
    ld    A, C          ; 1:4       2 +loop_102(m)
stp_lo102 EQU $+1       ;           2 +loop_102(m)
    sub  0xFF           ; 2:7       2 +loop_102(m)   lo index - stop-1
    rra                 ; 1:4       2 +loop_102(m)
    add   A, A          ; 1:4       2 +loop_102(m)   and 0xFE with save carry
    ld    A, B          ; 1:4       2 +loop_102(m)
    inc  BC             ; 1:6       2 +loop_102(m)   index++
    ld  (idx102),BC     ; 4:20      2 +loop_102(m)   save index
    jp   nz, do102      ; 3:10      2 +loop_102(m)
stp_hi102 EQU $+1       ;           2 +loop_102(m)
    sbc   A, 0xFF       ; 2:7       2 +loop_102(m)   hi index - stop-1
    jp   nz, do102      ; 3:10      2 +loop_102(m)
leave102:               ;           2 +loop_102(m)
exit102:                ;           2 +loop_102(m)
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
print_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
mid:                    ;           ( l r -- mid )
    pop  BC             ; 1:10      : ret
    ld  (mid_end+1),BC  ; 4:20      : ( ret -- )
    or    A             ; 1:4       over -
    sbc  HL, DE         ; 2:15      over -
    sra   H             ; 2:8       2/   with sign
    rr    L             ; 2:8       2/
    res   0, L          ; 2:8       -2 and
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
mid_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
exch_slow:              ;           ( addr1 addr2 -- )
    pop  BC             ; 1:10      : ret
    ld  (exch_slow_end+1),BC; 4:20      : ( ret -- )
                        ;[6:41]     dup @   ( addr -- addr x )
    push DE             ; 1:11      dup @
    ld    E, (HL)       ; 1:7       dup @
    inc  HL             ; 1:6       dup @
    ld    D, (HL)       ; 1:7       dup @
    dec  HL             ; 1:6       dup @
    ex   DE, HL         ; 1:4       dup @
                        ;[9:65]     >r   ( c b a -- c b ) ( R: -- a )
    ex  (SP), HL        ; 1:19      >r   a . b c
    ex   DE, HL         ; 1:4       >r   a . c b
    exx                 ; 1:4       >r
    pop  DE             ; 1:10      >r
    dec  HL             ; 1:6       >r
    ld  (HL),D          ; 1:7       >r
    dec   L             ; 1:4       >r
    ld  (HL),E          ; 1:7       >r
    exx                 ; 1:4       >r
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    ld    A, (HL)       ; 1:7       @   ( addr -- x )
    inc  HL             ; 1:6       @
    ld    H, (HL)       ; 1:7       @
    ld    L, A          ; 1:4       @
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
                        ;[3:20]     !   ( x addr -- x addr+1 )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !   ( b a -- )
    pop  DE             ; 1:10      !
                        ;[9:66]     r>   ( b a -- b a i ) ( R: i -- )
    exx                 ; 1:4       r>
    ld    E,(HL)        ; 1:7       r>
    inc   L             ; 1:4       r>
    ld    D,(HL)        ; 1:7       r>
    inc  HL             ; 1:6       r>
    push DE             ; 1:11      r>
    exx                 ; 1:4       r>   i . b a
    ex   DE, HL         ; 1:4       r>   i . a b
    ex  (SP), HL        ; 1:19      r>   b . a i
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
                        ;[3:20]     !   ( x addr -- x addr+1 )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !   ( b a -- )
    pop  DE             ; 1:10      !
exch_slow_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
exch:                   ;           ( addr1 addr2 -- )
    pop  BC             ; 1:10      : ret
    ld  (exch_end+1),BC ; 4:20      : ( ret -- )
;( read values)
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    ld    A, (HL)       ; 1:7       @   ( addr -- x )
    inc  HL             ; 1:6       @
    ld    H, (HL)       ; 1:7       @
    ld    L, A          ; 1:4       @
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    ld    A, (HL)       ; 1:7       @   ( addr -- x )
    inc  HL             ; 1:6       @
    ld    H, (HL)       ; 1:7       @
    ld    L, A          ; 1:4       @
;( exchange values)
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ex   DE, HL         ; 1:4       rot   ( c b a -- b a c )
    ex  (SP),HL         ; 1:19      rot
                        ;[3:20]     !   ( x addr -- x addr+1 )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !   ( b a -- )
    pop  DE             ; 1:10      !
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
                        ;[3:20]     !   ( x addr -- x addr+1 )
    ld  (HL),E          ; 1:7       !
    inc  HL             ; 1:6       !
    ld  (HL),D          ; 1:7       !
    pop  HL             ; 1:10      !   ( b a -- )
    pop  DE             ; 1:10      !
exch_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
partition:              ;           ( l r -- l r r2 l2 )
    pop  BC             ; 1:10      : ret
    ld  (partition_end+1),BC; 4:20      : ( ret -- )
;( r: pivot )
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    call mid            ; 3:17      call ( -- )
    ld    A, (HL)       ; 1:7       @   ( addr -- x )
    inc  HL             ; 1:6       @
    ld    H, (HL)       ; 1:7       @
    ld    L, A          ; 1:4       @
                        ;[9:65]     >r   ( c b a -- c b ) ( R: -- a )
    ex  (SP), HL        ; 1:19      >r   a . b c
    ex   DE, HL         ; 1:4       >r   a . c b
    exx                 ; 1:4       >r
    pop  DE             ; 1:10      >r
    dec  HL             ; 1:6       >r
    ld  (HL),D          ; 1:7       >r
    dec   L             ; 1:4       >r
    ld  (HL),E          ; 1:7       >r
    exx                 ; 1:4       >r
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
begin101:               ;           begin 101
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
begin102:               ;           begin 102
                        ;[6:41]     dup @   ( addr -- addr x )
    push DE             ; 1:11      dup @
    ld    E, (HL)       ; 1:7       dup @
    inc  HL             ; 1:6       dup @
    ld    D, (HL)       ; 1:7       dup @
    dec  HL             ; 1:6       dup @
    ex   DE, HL         ; 1:4       dup @
                        ;[9:64]     r@   ( -- i ) ( R: i -- i )
    exx                 ; 1:4       r@
    ld    E,(HL)        ; 1:7       r@
    inc   L             ; 1:4       r@
    ld    D,(HL)        ; 1:7       r@
    dec   L             ; 1:4       r@
    push DE             ; 1:11      r@
    exx                 ; 1:4       r@
    ex   DE, HL         ; 1:4       r@
    ex  (SP), HL        ; 1:19      r@
                       ;[12:58]     < while 102   ( x2 x1 -- )  flag: x2 < x1
    ld    A, E          ; 1:4       < while 102   DE<HL --> DE-HL<0 --> false if not carry
    sub   L             ; 1:4       < while 102   DE<HL --> DE-HL<0 --> false if not carry
    ld    A, D          ; 1:4       < while 102   DE<HL --> DE-HL<0 --> false if not carry
    sbc   A, H          ; 1:4       < while 102   DE<HL --> DE-HL<0 --> false if not carry
    rra                 ; 1:4       < while 102
    xor   H             ; 1:4       < while 102
    xor   D             ; 1:4       < while 102
    pop  HL             ; 1:10      < while 102
    pop  DE             ; 1:10      < while 102
    jp    p, break102   ; 3:10      < while 102
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+
    jp   begin102       ; 3:10      repeat 102
break102:               ;           repeat 102
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
begin103:               ;           begin 103
                        ;[9:64]     r@   ( -- i ) ( R: i -- i )
    exx                 ; 1:4       r@
    ld    E,(HL)        ; 1:7       r@
    inc   L             ; 1:4       r@
    ld    D,(HL)        ; 1:7       r@
    dec   L             ; 1:4       r@
    push DE             ; 1:11      r@
    exx                 ; 1:4       r@
    ex   DE, HL         ; 1:4       r@
    ex  (SP), HL        ; 1:19      r@
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    ld    A, (HL)       ; 1:7       @   ( addr -- x )
    inc  HL             ; 1:6       @
    ld    H, (HL)       ; 1:7       @
    ld    L, A          ; 1:4       @
                       ;[12:58]     < while 103   ( x2 x1 -- )  flag: x2 < x1
    ld    A, E          ; 1:4       < while 103   DE<HL --> DE-HL<0 --> false if not carry
    sub   L             ; 1:4       < while 103   DE<HL --> DE-HL<0 --> false if not carry
    ld    A, D          ; 1:4       < while 103   DE<HL --> DE-HL<0 --> false if not carry
    sbc   A, H          ; 1:4       < while 103   DE<HL --> DE-HL<0 --> false if not carry
    rra                 ; 1:4       < while 103
    xor   H             ; 1:4       < while 103
    xor   D             ; 1:4       < while 103
    pop  HL             ; 1:10      < while 103
    pop  DE             ; 1:10      < while 103
    jp    p, break103   ; 3:10      < while 103
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2-
    jp   begin103       ; 3:10      repeat 103
break103:               ;           repeat 103
    ld    A, L          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sub   E             ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    ld    A, H          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    sbc   A, D          ; 1:4       2dup <= if    DE<=HL --> HL-DE>=0 --> not carry if true
    rra                 ; 1:4       2dup <= if
    xor   D             ; 1:4       2dup <= if
    xor   H             ; 1:4       2dup <= if
    jp    m, else101    ; 3:10      2dup <= if
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    call exch           ; 3:17      call ( -- )
                        ;[9:65]     >r   ( c b a -- c b ) ( R: -- a )
    ex  (SP), HL        ; 1:19      >r   a . b c
    ex   DE, HL         ; 1:4       >r   a . c b
    exx                 ; 1:4       >r
    pop  DE             ; 1:10      >r
    dec  HL             ; 1:6       >r
    ld  (HL),D          ; 1:7       >r
    dec   L             ; 1:4       >r
    ld  (HL),E          ; 1:7       >r
    exx                 ; 1:4       >r
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+
                        ;[9:66]     r>   ( b a -- b a i ) ( R: i -- )
    exx                 ; 1:4       r>
    ld    E,(HL)        ; 1:7       r>
    inc   L             ; 1:4       r>
    ld    D,(HL)        ; 1:7       r>
    inc  HL             ; 1:6       r>
    push DE             ; 1:11      r>
    exx                 ; 1:4       r>   i . b a
    ex   DE, HL         ; 1:4       r>   i . a b
    ex  (SP), HL        ; 1:19      r>   b . a i
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2-
else101  EQU $          ;           then  = endif
endif101:               ;           then
    push DE             ; 1:11      2dup >
    push HL             ; 1:11      2dup >   ( b a -- b a b a )
                       ;[12:54]     2dup >   ( x2 x1 -- flag x2>x1 )
    ld    A, L          ; 1:4       2dup >   DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup >   DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup >   DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup >   DE>HL --> 0>HL-DE --> carry if true
    rra                 ; 1:4       2dup >   carry --> sign
    xor   H             ; 1:4       2dup >
    xor   D             ; 1:4       2dup >
    add   A, A          ; 1:4       2dup >   sign --> carry
    sbc   A, A          ; 1:4       2dup >   0x00 or 0xff
    ld    H, A          ; 1:4       2dup >
    ld    L, A          ; 1:4       2dup >
    pop  DE             ; 1:10      2dup >
    ld    A, H          ; 1:4       until 101   ( flag -- )
    or    L             ; 1:4       until 101
    ex   DE, HL         ; 1:4       until 101
    pop  DE             ; 1:10      until 101
    jp    z, begin101   ; 3:10      until 101
break101:               ;           until 101
                        ;[9:66]     r>   ( b a -- b a i ) ( R: i -- )
    exx                 ; 1:4       r>
    ld    E,(HL)        ; 1:7       r>
    inc   L             ; 1:4       r>
    ld    D,(HL)        ; 1:7       r>
    inc  HL             ; 1:6       r>
    push DE             ; 1:11      r>
    exx                 ; 1:4       r>   i . b a
    ex   DE, HL         ; 1:4       r>   i . a b
    ex  (SP), HL        ; 1:19      r>   b . a i
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
partition_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a recursive function  ---
qsort:                  ;           ( l r -- )
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  (HL),D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  (HL),E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon R:( -- ret )
    call partition      ; 3:17      call ( -- )
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ex   DE, HL         ; 1:4       rot   ( c b a -- b a c )
    ex  (SP),HL         ; 1:19      rot
  ; 2over 2over - + < if 2swap then
    ld    A, E          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    xor   H             ; 1:4       2dup < if
    jp    p, else102    ; 3:10      2dup < if
    call qsort          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall R:( ret -- )
    jp   endif102       ; 3:10      else
else102:                ;           else
    pop  HL             ; 1:10      2drop   ( b a -- )
    pop  DE             ; 1:10      2drop
endif102:               ;           then
    ld    A, E          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup < if    DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       2dup < if
    xor   D             ; 1:4       2dup < if
    xor   H             ; 1:4       2dup < if
    jp    p, else103    ; 3:10      2dup < if
    call qsort          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall R:( ret -- )
    jp   endif103       ; 3:10      else
else103:                ;           else
    pop  HL             ; 1:10      2drop   ( b a -- )
    pop  DE             ; 1:10      2drop
endif103:               ;           then
qsort_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,(HL)        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,(HL)        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  (HL)            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
sort:                   ;           ( array len -- )
    pop  BC             ; 1:10      : ret
    ld  (sort_end+1),BC ; 4:20      : ( ret -- )
                       ;[11:40]     dup 2 < if   ( x -- x )  flag: x < 2 #variant: default, change: "define({_TYP_SINGLE},{sign_first})"
    ld    A, L          ; 1:4       dup 2 < if   HL<2 --> L-0x02<0 --> false if not carry
    sub  0x02           ; 2:7       dup 2 < if   HL<2 --> L-0x02<0 --> false if not carry
    ld    A, H          ; 1:4       dup 2 < if   HL<2 --> H-0x00<0 --> false if not carry
    sbc   A, 0x00       ; 2:7       dup 2 < if   HL<2 --> H-0x00<0 --> false if not carry
    rra                 ; 1:4       dup 2 < if
    xor   H             ; 1:4       dup 2 < if   invert sign if HL is negative
    jp    p, else104    ; 3:10      dup 2 < if   positive constant --> false if not sign
    pop  HL             ; 1:10      2drop   ( b a -- )
    pop  DE             ; 1:10      2drop
    jp   sort_end       ; 3:10      exit
else104  EQU $          ;           then  = endif
endif104:               ;           then
    dec  HL             ; 1:6       1-   ( x -- x-1 )
    add  HL, HL         ; 1:11      2*
    add  HL, DE         ; 1:11      over +
    call qsort          ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall R:( ret -- )
sort_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_S16:             ;           prt_sp_s16
    ld    A, ' '        ; 2:7       prt_sp_s16   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      prt_sp_s16   putchar(reg A) with ZX 48K ROM
    ; fall to prt_s16
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
    ret                 ; 1:10      rnd
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

STRING_SECTION:
string102:
    db "RAS:"
size102              EQU $ - string102
string101:
    db " values in data stack.", 0x0D, 0x00
size101              EQU $ - string101


VARIABLE_SECTION:

__create_data:          ;           create data
    ds 2*10             ;           2*10 allot
