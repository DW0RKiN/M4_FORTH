      ifdef __ORG
    org __ORG
  else
    org 24576
  endif
    
    
       
    
             
    

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
    call Fillin         ; 3:17      scall
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a data stack function  ---
Fillin:                 ;           ( -- )
    ld   BC, 0x4000     ; 3:10      23296 16384 do_101(xm)
do101save:              ;           23296 16384 do_101(xm)
    ld  [idx101],BC     ; 4:20      23296 16384 do_101(xm)
do101:                  ;           23296 16384 do_101(xm)
                        ;[10:51]    255 i_101 !   ( -- )  val=255, addr=i
    ld    A, 0xFF       ; 2:7       255 i_101 !   lo(255) = 0xFF
    ld   BC, [idx101]   ; 4:20      255 i_101 !   idx always points to a 16-bit index
    ld  [BC],A          ; 1:7       255 i_101 !
    inc   A             ; 1:4       255 i_101 !   hi(255) = 0x00
    inc  BC             ; 1:6       255 i_101 !
    ld  [BC],A          ; 1:7       255 i_101 !
                        ;[10:57/37] loop_101(xm)   variant +1.I: step one with hi(real_stop) exclusivity, run 6912x
idx101 EQU $+1          ;           loop_101(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_101(xm)   16384.. +1 ..(23296), real_stop:0x5B00
    inc  BC             ; 1:6       loop_101(xm)   index++
    ld    A, B          ; 1:4       loop_101(xm)
    xor  0x5B           ; 2:7       loop_101(xm)   hi(real_stop)
    jp   nz, do101save  ; 3:10      loop_101(xm)
leave101:               ;           loop_101(xm)
exit101:                ;           loop_101(xm)
Fillin_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------