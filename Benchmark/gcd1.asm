        ORG 32768
    
    
       

                                                                    
                                                                                  
                                                                                     
                                                                                
                                                                    
              
                                                                       
                                                                     
         
    

    
         
              
                    
            
        
    

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
    call gcd1_bench     ; 3:17      call ( -- )
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
gcd1:                   ;           ( a b -- gcd )
    pop  BC             ; 1:10      : ret
    ld  (gcd1_end+1),BC ; 4:20      : ( ret -- )
    ld    A, D          ; 1:4       over if
    or    E             ; 1:4       over if
    jp    z, else101    ; 3:10      over if
begin101:               ;           begin(101)
    ld    A, H          ; 1:4       dup_while 101
    or    L             ; 1:4       dup_while 101
    jp    z, break101   ; 3:10      dup_while 101
    ld    A, L          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sub   E             ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    ld    A, H          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    sbc   A, D          ; 1:4       2dup u> if    DE>HL --> 0>HL-DE --> carry if true
    jp   nc, else102    ; 3:10      2dup u> if
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
else102  EQU $          ;           then  = endif
endif102:               ;           then
    or    A             ; 1:4       over -
    sbc  HL, DE         ; 2:15      over -
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    jp   endif101       ; 3:10      else
else101:                ;           else
    ld    A, H          ; 1:4       dup if
    or    L             ; 1:4       dup if
    jp    z, else103    ; 3:10      dup if
    pop  DE             ; 1:10      nip   ( b a -- a )
    jp   endif103       ; 3:10      else
else103:                ;           else
    pop  DE             ; 1:10      2drop 1
    ld   HL, 1          ; 3:10      2drop 1
endif103:               ;           then
endif101:               ;           then
gcd1_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
gcd1_bench:             ;           ( -- )
    pop  BC             ; 1:10      : ret
    ld  (gcd1_bench_end+1),BC; 4:20      : ( ret -- )
    ld   BC, 0x0000     ; 3:10      100 0 do_101(xm)
do101save:              ;           100 0 do_101(xm)
    ld  [idx101],BC     ; 4:20      100 0 do_101(xm)
do101:                  ;           100 0 do_101(xm)
    ld   BC, 0x0000     ; 3:10      100 0 do_102(xm)
do102save:              ;           100 0 do_102(xm)
    ld  [idx102],BC     ; 4:20      100 0 do_102(xm)
do102:                  ;           100 0 do_102(xm)
    push DE             ; 1:11      j_101(m)   ( -- j )
    ex   DE, HL         ; 1:4       j_101(m)
    ld   HL, [idx101]   ; 3:16      j_101(m)   idx always points to a 16-bit index
    push DE             ; 1:11      i_102(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_102(m)
    ld   HL, [idx102]   ; 3:16      i_102(m)   idx always points to a 16-bit index
    call gcd1           ; 3:17      call ( -- )
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
                        ;[12:45]    loop_102(xm)   variant +1.B: 0 <= index < stop <= 256, run 100x
idx102 EQU $+1          ;           loop_102(xm)   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_102(xm)   0.. +1 ..(100), real_stop:0x0064
    nop                 ; 1:4       loop_102(xm)   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_102(xm)   index++
    ld  [idx102],A      ; 3:13      loop_102(xm)
    xor  0x64           ; 2:7       loop_102(xm)   lo(real_stop)
    jp   nz, do102      ; 3:10      loop_102(xm)   index-stop
leave102:               ;           loop_102(xm)
exit102:                ;           loop_102(xm)
                        ;[12:45]    loop_101(xm)   variant +1.B: 0 <= index < stop <= 256, run 100x
idx101 EQU $+1          ;           loop_101(xm)   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_101(xm)   0.. +1 ..(100), real_stop:0x0064
    nop                 ; 1:4       loop_101(xm)   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_101(xm)   index++
    ld  [idx101],A      ; 3:13      loop_101(xm)
    xor  0x64           ; 2:7       loop_101(xm)   lo(real_stop)
    jp   nz, do101      ; 3:10      loop_101(xm)   index-stop
leave101:               ;           loop_101(xm)
exit101:                ;           loop_101(xm)
gcd1_bench_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------