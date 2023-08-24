        ORG 32768
    
    
       
    
               
            
           
    
    
         
                 
        
    

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0x88B8     ; 3:10      init   Return address stack = 35000
    exx                 ; 1:4       init
    call fib1_bench     ; 3:17      scall
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a recursive function  ---
fib1:                   ;           ( a -- b )
    exx                 ; 1:4       : rcolon
    pop  DE             ; 1:10      : rcolon ret
    dec  HL             ; 1:6       : rcolon
    ld  [HL],D          ; 1:7       : rcolon
    dec   L             ; 1:4       : rcolon
    ld  [HL],E          ; 1:7       : rcolon (HL') = ret
    exx                 ; 1:4       : rcolon ( R: -- ret )
                        ;[9:34]     dup 2 < if   ( x -- x )  flag: x < 2 variant: <2
    ld    A, L          ; 1:4       dup 2 < if
    srl   A             ; 2:8       dup 2 < if
    or    H             ; 1:4       dup 2 < if
    dec   A             ; 1:4       dup 2 < if
    or    H             ; 1:4       dup 2 < if
    jp    p, else101    ; 3:10      dup 2 < if
    ld   HL, 1          ; 3:10      drop 1
    jp   fib1_end       ; 3:10      rexit
else101  EQU $          ;           then  = endif
endif101:               ;           then
    push DE             ; 1:11      dup   ( a -- a a )
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup
    dec  HL             ; 1:6       1-   ( x -- x-1 )
    call fib1           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    dec  HL             ; 1:6       2-
    dec  HL             ; 1:6       2-
    call fib1           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
fib1_end:
    exx                 ; 1:4       ; rsemicilon
    ld    E,[HL]        ; 1:7       ; rsemicilon
    inc   L             ; 1:4       ; rsemicilon
    ld    D,[HL]        ; 1:7       ; rsemicilon DE = ret
    inc  HL             ; 1:6       ; rsemicilon
    ex   DE, HL         ; 1:4       ; rsemicilon
    jp  [HL]            ; 1:4       ; rsemicilon
;   ---------  end of recursive function  ---------
;   ---  the beginning of a data stack function  ---
fib1_bench:             ;           ( -- )
    push DE             ; 1:11      999
    ex   DE, HL         ; 1:4       999
    ld   HL, 999        ; 3:10      999
for101:                 ;           for_101(s) ( index -- index )
    push DE             ; 1:11      19
    ex   DE, HL         ; 1:4       19
    ld   HL, 19         ; 3:10      19
for102:                 ;           for_102(s) ( index -- index )
                        ;           i_102(s)   ( -- i )
    push DE             ; 1:11      i_102(s)   ( a -- a a )
    ld    D, H          ; 1:4       i_102(s)
    ld    E, L          ; 1:4       i_102(s)
    call fib1           ; 3:17      rcall
    ex   DE, HL         ; 1:4       rcall
    exx                 ; 1:4       rcall ( R: ret -- )
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    ld    A, H          ; 1:4       next_102(s)
    or    L             ; 1:4       next_102(s)
    dec  HL             ; 1:6       next_102(s)   index--
    jp  nz, for102      ; 3:10      next_102(s)
leave102:               ;           next_102(s)
    ex   DE, HL         ; 1:4       unloop_102(s)   ( i -- )
    pop  DE             ; 1:10      unloop_102(s)
    ld    A, H          ; 1:4       next_101(s)
    or    L             ; 1:4       next_101(s)
    dec  HL             ; 1:6       next_101(s)   index--
    jp  nz, for101      ; 3:10      next_101(s)
leave101:               ;           next_101(s)
    ex   DE, HL         ; 1:4       unloop_101(s)   ( i -- )
    pop  DE             ; 1:10      unloop_101(s)
fib1_bench_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------