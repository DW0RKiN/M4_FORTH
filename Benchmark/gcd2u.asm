    ORG 32768
    
    
       
        

                                                       
                                                                  
                                                              
     
        
           
                                                                       
         
                ; swap                                              
                                                                       
     
    
          


      
           
                
        
    


;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
    call gcd2_bench     ; 3:17      call ( -- )
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
gcd2:                   ;           ( a b -- gcd )
    pop  BC             ; 1:10      : ret
    ld  (gcd2_end+1),BC ; 4:20      : ( ret -- )
    ld    A, H          ; 1:4       2dup d0= if  ( d -- d )
    or    L             ; 1:4       2dup d0= if
    or    D             ; 1:4       2dup d0= if
    or    E             ; 1:4       2dup d0= if
    jp   nz, else101    ; 3:10      2dup d0= if
    pop  DE             ; 1:10      2drop 1
    ld   HL, 1          ; 3:10      2drop 1
    jp   gcd2_end       ; 3:10      exit
else101  EQU $          ;           then  = endif
endif101:               ;           then
                        ;[5:18]     dup 0= if   ( x -- x )  flag: x == 0
    ld    A, H          ; 1:4       dup 0= if
    or    L             ; 1:4       dup 0= if
    jp   nz, else102    ; 3:10      dup 0= if
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    jp   gcd2_end       ; 3:10      exit
else102  EQU $          ;           then  = endif
endif102:               ;           then
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
                        ;[5:18]     dup 0= if   ( x -- x )  flag: x == 0
    ld    A, H          ; 1:4       dup 0= if
    or    L             ; 1:4       dup 0= if
    jp   nz, else103    ; 3:10      dup 0= if
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    jp   gcd2_end       ; 3:10      exit
else103  EQU $          ;           then  = endif
endif103:               ;           then
begin101:               ;           begin 101
    ld    A, E          ; 1:4       2dup <> while 101
    sub   L             ; 1:4       2dup <> while 101
    jr   nz, $+7        ; 2:7/12    2dup <> while 101
    ld    A, D          ; 1:4       2dup <> while 101
    sub   H             ; 1:4       2dup <> while 101
    jp    z, break101   ; 3:10      2dup <> while 101
    ld    A, E          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       2dup u< if    DE<HL --> DE-HL<0 --> carry if true
    jp   nc, else104    ; 3:10      2dup u< if
    or    A             ; 1:4       over -
    sbc  HL, DE         ; 2:15      over -
    jp   endif104       ; 3:10      else
else104:                ;           else
    ex   DE, HL         ; 1:4       swap over -   ( b a -- a b )
    or    A             ; 1:4       swap over -
    sbc  HL, DE         ; 2:15      swap over -
endif104:               ;           then
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
    pop  DE             ; 1:10      nip   ( b a -- a )
gcd2_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
gcd2_bench:             ;           ( -- )
    pop  BC             ; 1:10      : ret
    ld  (gcd2_bench_end+1),BC; 4:20      : ( ret -- )
    ld   BC, 0          ; 3:10      100 0 do_101(xm)
do101save:              ;           100 0 do_101(xm)
    ld  (idx101),BC     ; 4:20      100 0 do_101(xm)
do101:                  ;           100 0 do_101(xm)
    ld   BC, 0          ; 3:10      100 0 do_102(xm)
do102save:              ;           100 0 do_102(xm)
    ld  (idx102),BC     ; 4:20      100 0 do_102(xm)
do102:                  ;           100 0 do_102(xm)
    push DE             ; 1:11      j_101(m)   ( -- j )
    ex   DE, HL         ; 1:4       j_101(m)
    ld   HL, (idx101)   ; 3:16      j_101(m)   idx always points to a 16-bit index
    push DE             ; 1:11      i_102(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_102(m)
    ld   HL, (idx102)   ; 3:16      i_102(m)   idx always points to a 16-bit index
    call gcd2           ; 3:17      call ( -- )
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
                        ;[12:45]    loop_102   variant +1.B: 0 <= index < stop <= 256, run 100x
idx102 EQU $+1          ;           loop_102   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_102   0.. +1 ..(100), real_stop:0x0064
    nop                 ; 1:4       loop_102   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_102   index++
    ld  (idx102),A      ; 3:13      loop_102
    xor  0x64           ; 2:7       loop_102   lo(real_stop)
    jp   nz, do102      ; 3:10      loop_102   index-stop
leave102:               ;           loop_102
exit102:                ;           loop_102
                        ;[12:45]    loop_101   variant +1.B: 0 <= index < stop <= 256, run 100x
idx101 EQU $+1          ;           loop_101   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_101   0.. +1 ..(100), real_stop:0x0064
    nop                 ; 1:4       loop_101   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_101   index++
    ld  (idx101),A      ; 3:13      loop_101
    xor  0x64           ; 2:7       loop_101   lo(real_stop)
    jp   nz, do101      ; 3:10      loop_101   index-stop
leave101:               ;           loop_101
exit101:                ;           loop_101
gcd2_bench_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------