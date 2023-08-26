        ORG 32768
    
    
       

    
          
              
                 

    
                
    
            
        
    

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0x88B8     ; 3:10      init   Return address stack = 35000
    exx                 ; 1:4       init
    call fib2a_bench    ; 3:17      scall
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a data stack function  ---
fib2a_bench:            ;           ( -- )
    ld   BC, 0x0000     ; 3:10      1000 0 do_101(xm)
do101save:              ;           1000 0 do_101(xm)
    ld  [idx101],BC     ; 4:20      1000 0 do_101(xm)
do101:                  ;           1000 0 do_101(xm)
    ld   BC, 0x0000     ; 3:10      20 0 do_102(xm)
do102save:              ;           20 0 do_102(xm)
    ld  [idx102],BC     ; 4:20      20 0 do_102(xm)
do102:                  ;           20 0 do_102(xm)
    push DE             ; 1:11      i_102(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_102(m)
    ld   HL, [idx102]   ; 3:16      i_102(m)   idx always points to a 16-bit index

    push DE             ; 1:11      ( n1 -- n2 )
    ld    B, L          ; 1:4
    ld    C, H          ; 1:4       CB = counter
    ld   HL, 0x0000     ; 3:10
    ld   DE, 0x0001     ; 3:10
    inc   C             ; 1:4
    inc   B             ; 1:4
    dec   B             ; 1:4
    jr    z, $+6        ; 2:7/12    
    ex   DE, HL         ; 1:4
    add  HL, DE         ; 1:11      +
    djnz $-2            ; 2:13/8
    dec  C              ; 1:4
    jr  nz, $-5         ; 2:12/7
    pop  DE             ; 1:10
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
                        ;[12:45]    loop_102(xm)   variant +1.B: 0 <= index < stop <= 256, run 20x
idx102 EQU $+1          ;           loop_102(xm)   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_102(xm)   0.. +1 ..(20), real_stop:0x0014
    nop                 ; 1:4       loop_102(xm)   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_102(xm)   index++
    ld  [idx102],A      ; 3:13      loop_102(xm)
    xor  0x14           ; 2:7       loop_102(xm)   lo(real_stop)
    jp   nz, do102      ; 3:10      loop_102(xm)   index-stop
leave102:               ;           loop_102(xm)
exit102:                ;           loop_102(xm)
                        ;[16:57/58] loop_101(xm)   variant +1.default: step one, run 1000x
idx101 EQU $+1          ;           loop_101(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_101(xm)   0.. +1 ..(1000), real_stop:0x03E8
    inc  BC             ; 1:6       loop_101(xm)   index++
    ld    A, C          ; 1:4       loop_101(xm)
    xor  0xE8           ; 2:7       loop_101(xm)   lo(real_stop) first (232>3)
    jp   nz, do101save  ; 3:10      loop_101(xm)   3x false positive
    ld    A, B          ; 1:4       loop_101(xm)
    xor  0x03           ; 2:7       loop_101(xm)   hi(real_stop)
    jp   nz, do101save  ; 3:10      loop_101(xm)   232x false positive if he was first
leave101:               ;           loop_101(xm)
exit101:                ;           loop_101(xm)
fib2a_bench_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------