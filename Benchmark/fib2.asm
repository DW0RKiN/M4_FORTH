        ORG 32768
    
    
       
    
             
                
        
    
    
           
                  
        
    

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0x88B8     ; 3:10      init   Return address stack = 35000
    exx                 ; 1:4       init
    call fib2_bench     ; 3:17      call ( -- )
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
fib2:                   ;           ( n1 -- n2 )
    pop  BC             ; 1:10      : ret
    ld  (fib2_end+1),BC ; 4:20      : ( ret -- )
                        ;[6:36]     0 1 rot   ( x -- 0 1 x )
    push DE             ; 1:11      0 1 rot
    ld   DE, 0x0000     ; 3:10      0 1 rot
    push DE             ; 1:11      0 1 rot
    inc   E             ; 1:4       0 1 rot
    ld    A, L          ; 1:4       0 ?do_101(m)   ( stop 0 -- )
    ld  [stp_lo101], A  ; 3:13      0 ?do_101(m)   lo stop
    ld    A, H          ; 1:4       0 ?do_101(m)
    ld  [stp_hi101], A  ; 3:13      0 ?do_101(m)   hi stop
    or    L             ; 1:4       0 ?do_101(m)
    ld   HL, 0          ; 3:10      0 ?do_101(m)
    ld  [idx101], HL    ; 3:16      0 ?do_101(m)
    pop  HL             ; 1:10      0 ?do_101(m)
    ex   DE, HL         ; 1:4       0 ?do_101(m)
    jp    z, exit101    ; 3:10      0 ?do_101(m)
do101:                  ;           0 ?do_101(m)
    add  HL, DE         ; 1:11      over +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
idx101 EQU $+1          ;[20:78/57] loop_101(m)
    ld   BC, 0x0000     ; 3:10      loop_101(m)   idx always points to a 16-bit index
    inc  BC             ; 1:6       loop_101(m)   index++
    ld  [idx101], BC    ; 4:20      loop_101(m)   save index
    ld    A, C          ; 1:4       loop_101(m)   lo new index
stp_lo101 EQU $+1       ;           loop_101(m)
    xor  0x00           ; 2:7       loop_101(m)   lo stop
    jp   nz, do101      ; 3:10      loop_101(m)
    ld    A, B          ; 1:4       loop_101(m)   hi new index
stp_hi101 EQU $+1       ;           loop_101(m)
    xor  0x00           ; 2:7       loop_101(m)   hi stop
    jp   nz, do101      ; 3:10      loop_101(m)
leave101:               ;           loop_101(m)
exit101:                ;           loop_101(m)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
fib2_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
fib2_bench:             ;           ( -- )
    pop  BC             ; 1:10      : ret
    ld  (fib2_bench_end+1),BC; 4:20      : ( ret -- )
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
    call fib2           ; 3:17      call ( -- )
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
                        ;[12:45]    loop_103(xm)   variant +1.B: 0 <= index < stop <= 256, run 20x
idx103 EQU $+1          ;           loop_103(xm)   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_103(xm)   0.. +1 ..(20), real_stop:0x0014
    nop                 ; 1:4       loop_103(xm)   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_103(xm)   index++
    ld  [idx103],A      ; 3:13      loop_103(xm)
    xor  0x14           ; 2:7       loop_103(xm)   lo(real_stop)
    jp   nz, do103      ; 3:10      loop_103(xm)   index-stop
leave103:               ;           loop_103(xm)
exit103:                ;           loop_103(xm)
                        ;[16:57/58] loop_102(xm)   variant +1.default: step one, run 1000x
idx102 EQU $+1          ;           loop_102(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_102(xm)   0.. +1 ..(1000), real_stop:0x03E8
    inc  BC             ; 1:6       loop_102(xm)   index++
    ld    A, C          ; 1:4       loop_102(xm)
    xor  0xE8           ; 2:7       loop_102(xm)   lo(real_stop) first (232>3)
    jp   nz, do102save  ; 3:10      loop_102(xm)   3x false positive
    ld    A, B          ; 1:4       loop_102(xm)
    xor  0x03           ; 2:7       loop_102(xm)   hi(real_stop)
    jp   nz, do102save  ; 3:10      loop_102(xm)   232x false positive if he was first
leave102:               ;           loop_102(xm)
exit102:                ;           loop_102(xm)
fib2_bench_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------