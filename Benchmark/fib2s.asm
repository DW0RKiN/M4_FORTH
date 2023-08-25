        ORG 32768
    
    
       
    
            
            
         
              
        
        
    
    
           
                  
        
    

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0x88B8     ; 3:10      init   Return address stack = 35000
    exx                 ; 1:4       init
    call fib2s_bench    ; 3:17      scall
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a data stack function  ---
fib2s:                  ;           ( n1 -- n2 )
                        ;[5:18]     dup 0= if   ( x -- x )  flag: x == 0
    ld    A, H          ; 1:4       dup 0= if
    or    L             ; 1:4       dup 0= if
    jp   nz, else101    ; 3:10      dup 0= if
    ret                 ; 1:10      sexit
else101  EQU $          ;           then  = endif
endif101:               ;           then
                        ;[6:36]     0 1 rot   ( x -- 0 1 x )
    push DE             ; 1:11      0 1 rot
    ld   DE, 0x0000     ; 3:10      0 1 rot
    push DE             ; 1:11      0 1 rot
    inc   E             ; 1:4       0 1 rot
    dec  HL             ; 1:6       1-   ( x -- x-1 )
    ld    B, H          ; 1:4       for_101   ( i -- )
    ld    C, L          ; 1:4       for_101
    ex   DE, HL         ; 1:4       for_101
    pop  DE             ; 1:10      for_101   index
for101:                 ;           for_101
    ld  [idx101],BC     ; 4:20      for_101   save index
    add  HL, DE         ; 1:11      over +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
idx101 EQU $+1          ;           next_101
    ld   BC, 0x0000     ; 3:10      next_101   idx always points to a 16-bit index
    ld    A, B          ; 1:4       next_101
    or    C             ; 1:4       next_101
    dec  BC             ; 1:6       next_101   index--, zero flag unaffected
    jp   nz, for101     ; 3:10      next_101
leave101:               ;           next_101
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
fib2s_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
fib2s_bench:            ;           ( -- )
    ld   BC, 0x0000     ; 3:10      1000 0 do_102(xm)
do102save:              ;           1000 0 do_102(xm)
    ld  [idx102],BC     ; 4:20      1000 0 do_102(xm)
do102:                  ;           1000 0 do_102(xm)
    ld   BC, 0x0000     ; 3:10      20 0 do_103(xm)
do103save:              ;           20 0 do_103(xm)
    ld  [idx103],BC     ; 4:20      20 0 do_103(xm)
do103:                  ;           20 0 do_103(xm)
    push DE             ; 1:11      i_103(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_103(m)
    ld   HL, [idx103]   ; 3:16      i_103(m)   idx always points to a 16-bit index
    call fib2s          ; 3:17      scall
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
                        ;[12:45]    loop_103   variant +1.B: 0 <= index < stop <= 256, run 20x
idx103 EQU $+1          ;           loop_103   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_103   0.. +1 ..(20), real_stop:0x0014
    nop                 ; 1:4       loop_103   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_103   index++
    ld  [idx103],A      ; 3:13      loop_103
    xor  0x14           ; 2:7       loop_103   lo(real_stop)
    jp   nz, do103      ; 3:10      loop_103   index-stop
leave103:               ;           loop_103
exit103:                ;           loop_103
                        ;[16:57/58] loop_102   variant +1.default: step one, run 1000x
idx102 EQU $+1          ;           loop_102   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_102   0.. +1 ..(1000), real_stop:0x03E8
    inc  BC             ; 1:6       loop_102   index++
    ld    A, C          ; 1:4       loop_102
    xor  0xE8           ; 2:7       loop_102   lo(real_stop) first (232>3)
    jp   nz, do102save  ; 3:10      loop_102   3x false positive
    ld    A, B          ; 1:4       loop_102
    xor  0x03           ; 2:7       loop_102   hi(real_stop)
    jp   nz, do102save  ; 3:10      loop_102   232x false positive if he was first
leave102:               ;           loop_102
exit102:                ;           loop_102
fib2s_bench_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------