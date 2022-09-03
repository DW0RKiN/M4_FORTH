ORG 0x8000

;--- +1 ---
;       12345678901234567890123456789012
                                                                                               
                                                                                               
                                                                                         
                                                                                         
                                                                                         
                                                                                         
                                                                                                  
                                                                                                  
                                                                                                                                        
                                                                                                                                           
;--- -1 ---
                                                                           
             
                                                                           
             
                                                                       
             
                                                                           
                                        
                                                                             
                                        
                                                                            
                                        
                                                                            
                                        
                                                                             
                                        
                                                                             
                                        
;--- 2 ---
                                                                          
             
                                                                           
             
                                                                           
             
                                                                              
                                        
                                                                               
                                        
                                                                              
                                        
;--- -2 ---
                                                                           
             
                                                                           
             
                                                                          
             
                                                                       
             
                                                                       
             
                                                                            
                                        
                                                                            
                                        
                                                                            
                                        
                                                                            
                                        
;--- -x ---
                                                                          
             
                                                                         
             
                                                                      
             
                                                                    
             
                                                                            
                                        
                                                                            
                                        
;--- +x ---
                                                                          
             
                                                                  
             
                                                                      
             
                                                                          
             
                                                                          
             
                                                                        
             
                                                                         
             
                                                                    
             
                                                                              
                                        
                                                                      
             
                                                                      
             
                                                                              
                                        
;---xxx---
            

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    ld   BC, string101  ; 3:10      print_i   Address of string101 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 251        ; 3:10      do_101(xm)
do101save:              ;           do_101(xm)
    ld  (idx101),BC     ; 4:20      do_101(xm)
do101:                  ;           do_101(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[10:38]    loop_101   variant +1.A: 0 <= index < stop == 256, run 5x
idx101 EQU $+1          ;           loop_101   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_101   251.. +1 ..(256), real_stop:0x0100
    nop                 ; 1:4       loop_101   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_101   index++
    ld  (idx101),A      ; 3:13      loop_101
    jp   nz, do101      ; 3:10      loop_101   index-stop
leave101:               ;           loop_101
exit101:                ;           loop_101
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string102  ; 3:10      print_i   Address of string102 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 241        ; 3:10      do_102(xm)
do102save:              ;           do_102(xm)
    ld  (idx102),BC     ; 4:20      do_102(xm)
do102:                  ;           do_102(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[12:45]    loop_102   variant +1.B: 0 <= index < stop <= 256, run 5x
idx102 EQU $+1          ;           loop_102   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_102   241.. +1 ..(246), real_stop:0x00F6
    nop                 ; 1:4       loop_102   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_102   index++
    ld  (idx102),A      ; 3:13      loop_102
    xor  0xF6           ; 2:7       loop_102   lo(real_stop)
    jp   nz, do102      ; 3:10      loop_102   index-stop
leave102:               ;           loop_102
exit102:                ;           loop_102
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string103  ; 3:10      print_i   Address of string103 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 0x3CFB     ; 3:10      do_103(xm)
do103save:              ;           do_103(xm)
    ld  (idx103),BC     ; 4:20      do_103(xm)
do103:                  ;           do_103(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[9:34]     loop_103   variant +1.C: 0x3C00 <=index < stop == 0x3D00, run 5x
idx103 EQU $+1          ;           loop_103   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_103   0x3CFB.. +1 ..(0x3D00), real_stop:0x3D00
    inc   A             ; 1:4       loop_103   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
    ld  (idx103),A      ; 3:13      loop_103   save index
    jp   nz, do103      ; 3:10      loop_103
leave103:               ;           loop_103
exit103:                ;           loop_103
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 0x3C05     ; 3:10      do_104(xm)
do104save:              ;           do_104(xm)
    ld  (idx104),BC     ; 4:20      do_104(xm)
do104:                  ;           do_104(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[11:41]    loop_104   variant +1.D: 0x3C00 <=index < stop <= 0x3D00, run 5x
idx104 EQU $+1          ;           loop_104   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_104   0x3C05.. +1 ..(0x3C0A), real_stop:0x3C0A
    inc   A             ; 1:4       loop_104   = hi(index) = 0x3c = inc A -> idx always points to a 16-bit index
    ld  (idx104),A      ; 3:13      loop_104   save index
    xor  0x0A           ; 2:7       loop_104   lo(real_stop)
    jp   nz, do104      ; 3:10      loop_104
leave104:               ;           loop_104
exit104:                ;           loop_104
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string105  ; 3:10      print_i   Address of string105 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 0x65FB     ; 3:10      do_105(xm)
do105save:              ;           do_105(xm)
    ld  (idx105),BC     ; 4:20      do_105(xm)
do105:                  ;           do_105(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[11:41]    loop_105   variant +1.E: 256*(1+hi(index)) == stop, run 5x
idx105 EQU $+1          ;           loop_105   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_105   0x65FB.. +1 ..(0x6600), real_stop:0x6600
    ld    A, C          ; 1:4       loop_105
    inc   A             ; 1:4       loop_105   index++
    ld  (idx105),A      ; 3:13      loop_105   save index
    jp   nz, do105      ; 3:10      loop_105
leave105:               ;           loop_105
exit105:                ;           loop_105
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 0x4050     ; 3:10      do_106(xm)
do106save:              ;           do_106(xm)
    ld  (idx106),BC     ; 4:20      do_106(xm)
do106:                  ;           do_106(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[13:48]    loop_106   variant +1.F: hi(index) == hi(stop-1) && index < stop, run 5x
idx106 EQU $+1          ;           loop_106   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_106   0x4050.. +1 ..(0x4055), real_stop:0x4055
    ld    A, C          ; 1:4       loop_106
    inc   A             ; 1:4       loop_106   index++
    ld  (idx106),A      ; 3:13      loop_106   save index
    xor  0x55           ; 2:7       loop_106   lo(real_stop)
    jp   nz, do106      ; 3:10      loop_106
leave106:               ;           loop_106
exit106:                ;           loop_106
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string107  ; 3:10      print_i   Address of string107 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, -5         ; 3:10      do_107(xm)
do107save:              ;           do_107(xm)
    ld  (idx107),BC     ; 4:20      do_107(xm)
do107:                  ;           do_107(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[9:54/34]  loop_107   variant +1.G: stop == 0, run 5x
idx107 EQU $+1          ;           loop_107   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_107   -5.. +1 ..(0), real_stop:0x0000
    inc  BC             ; 1:6       loop_107   index++
    ld    A, B          ; 1:4       loop_107
    or    C             ; 1:4       loop_107
    jp   nz, do107save  ; 3:10      loop_107
leave107:               ;           loop_107
exit107:                ;           loop_107
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string108  ; 3:10      print_i   Address of string108 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, -3         ; 3:10      do_108(xm)
do108save:              ;           do_108(xm)
    ld  (idx108),BC     ; 4:20      do_108(xm)
do108:                  ;           do_108(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[10:57/37] loop_108   variant +1.H: step one with lo(real_stop) exclusivity, run 5x
idx108 EQU $+1          ;           loop_108   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_108   -3.. +1 ..(2), real_stop:0x0002
    inc  BC             ; 1:6       loop_108   index++
    ld    A, C          ; 1:4       loop_108
    xor  0x02           ; 2:7       loop_108   lo(real_stop)
    jp   nz, do108save  ; 3:10      loop_108
leave108:               ;           loop_108
exit108:                ;           loop_108
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 0x6318     ; 3:10      do_109(xm)
do109save:              ;           do_109(xm)
    ld  (idx109),BC     ; 4:20      do_109(xm)
do109:                  ;           do_109(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_109(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_109(m)
    ld   HL, (idx109)   ; 3:16      i_109(m)   idx always points to a 16-bit index
                        ;[10:57/37] loop_109   variant +1.I: step one with hi(real_stop) exclusivity, run 1000x
idx109 EQU $+1          ;           loop_109   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_109   0x6318.. +1 ..(0x6700), real_stop:0x6700
    inc  BC             ; 1:6       loop_109   index++
    ld    A, B          ; 1:4       loop_109
    xor  0x67           ; 2:7       loop_109   hi(real_stop)
    jp   nz, do109save  ; 3:10      loop_109
leave109:               ;           loop_109
exit109:                ;           loop_109
    call PRT_U16        ; 3:17      u.   ( u -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string110  ; 3:10      print_i   Address of string110 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, -700       ; 3:10      do_110(xm)
do110save:              ;           do_110(xm)
    ld  (idx110),BC     ; 4:20      do_110(xm)
do110:                  ;           do_110(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_110(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_110(m)
    ld   HL, (idx110)   ; 3:16      i_110(m)   idx always points to a 16-bit index
                        ;[16:57/58] loop_110   variant +1.default: step one, run 1000x
idx110 EQU $+1          ;           loop_110   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_110   -700.. +1 ..(300), real_stop:0x012C
    inc  BC             ; 1:6       loop_110   index++
    ld    A, C          ; 1:4       loop_110
    xor  0x2C           ; 2:7       loop_110   lo(real_stop) first (44>3)
    jp   nz, do110save  ; 3:10      loop_110   3x false positive
    ld    A, B          ; 1:4       loop_110
    xor  0x01           ; 2:7       loop_110   hi(real_stop)
    jp   nz, do110save  ; 3:10      loop_110   44x false positive if he was first
leave110:               ;           loop_110
exit110:                ;           loop_110
    call PRT_U16        ; 3:17      u.   ( u -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string111  ; 3:10      print_i   Address of string111 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 4          ; 3:10      do_111(xm)
do111save:              ;           do_111(xm)
    ld  (idx111),BC     ; 4:20      do_111(xm)
do111:                  ;           do_111(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[9:54/34]  -1 +loop_111(xm)   variant -1.A: step -1 and stop 0, run 5x
idx111 EQU $+1          ;           -1 +loop_111(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +loop_111(xm)   4.. -1 ..0, real_stop:0xFFFF
    ld    A, C          ; 1:4       -1 +loop_111(xm)
    or    B             ; 1:4       -1 +loop_111(xm)
    dec  BC             ; 1:6       -1 +loop_111(xm)   index--
    jp   nz, do111save  ; 3:10      -1 +loop_111(xm)
leave111:               ;           -1 +loop_111(xm)
exit111:                ;           xloop LOOP_STACK
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 5          ; 3:10      do_112(xm)
do112save:              ;           do_112(xm)
    ld  (idx112),BC     ; 4:20      do_112(xm)
do112:                  ;           do_112(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[9:54/34]  -1 +loop_112(xm)   variant -1.B: step -1 and stop 1, run 5x
idx112 EQU $+1          ;           -1 +loop_112(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +loop_112(xm)   5.. -1 ..1, real_stop:0x0000
    dec  BC             ; 1:6       -1 +loop_112(xm)   index--
    ld    A, C          ; 1:4       -1 +loop_112(xm)
    or    B             ; 1:4       -1 +loop_112(xm)
    jp   nz, do112save  ; 3:10      -1 +loop_112(xm)
leave112:               ;           -1 +loop_112(xm)
exit112:                ;           xloop LOOP_STACK
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string113  ; 3:10      print_i   Address of string113 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 258        ; 3:10      do_113(xm)
do113save:              ;           do_113(xm)
    ld  (idx113),BC     ; 4:20      do_113(xm)
do113:                  ;           do_113(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[10:57/37] -1 +loop_113(xm)   variant -1.C: step -1 with lo(real_stop) exclusivity, run 5x
idx113 EQU $+1          ;           -1 +loop_113(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +loop_113(xm)   258.. -1 ..254, real_stop:0x00FD
    dec  BC             ; 1:6       -1 +loop_113(xm)   index--
    ld    A, C          ; 1:4       -1 +loop_113(xm)
    xor  0xFD           ; 2:7       -1 +loop_113(xm)   lo(real_stop)
    jp   nz, do113save  ; 3:10      -1 +loop_113(xm)
leave113:               ;           -1 +loop_113(xm)
exit113:                ;           xloop LOOP_STACK
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string114  ; 3:10      print_i   Address of string114 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 1255       ; 3:10      do_114(xm)
do114save:              ;           do_114(xm)
    ld  (idx114),BC     ; 4:20      do_114(xm)
do114:                  ;           do_114(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_114 -1 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_114 -1 drop(m)
    ld   HL, (idx114)   ; 3:16      i_114 -1 drop(m)   idx always points to a 16-bit index
                        ;[10:57/37] -1 +loop_114(xm)   variant -1.D: step -1 with hi(real_stop) exclusivity, run 1000x
idx114 EQU $+1          ;           -1 +loop_114(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +loop_114(xm)   1255.. -1 ..256, real_stop:0x00FF
    dec  BC             ; 1:6       -1 +loop_114(xm)   index--
    ld    A, B          ; 1:4       -1 +loop_114(xm)
    xor  0x00           ; 2:7       -1 +loop_114(xm)   hi(real_stop)
    jp   nz, do114save  ; 3:10      -1 +loop_114(xm)
leave114:               ;           -1 +loop_114(xm)
exit114:                ;           xloop LOOP_STACK
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 998        ; 3:10      do_115(xm)
do115save:              ;           do_115(xm)
    ld  (idx115),BC     ; 4:20      do_115(xm)
do115:                  ;           do_115(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_115 -1 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_115 -1 drop(m)
    ld   HL, (idx115)   ; 3:16      i_115 -1 drop(m)   idx always points to a 16-bit index
                       ;[10:58/38]  -1 +loop_115(xm)   variant -1.E: step -1 and stop -1, run 1000x
idx115 EQU $+1          ;           -1 +loop_115(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +loop_115(xm)   998.. -1 ..-1, real_stop:0xFFFE
    ld    A, C          ; 1:4       -1 +loop_115(xm)
    and   B             ; 1:4       -1 +loop_115(xm)   0xFF & 0xFF = 0xFF
    dec  BC             ; 1:6       -1 +loop_115(xm)   index--
    inc   A             ; 1:4       -1 +loop_115(xm)   0xFF + 1 = zero
    jp   nz, do115save  ; 3:10      -1 +loop_115(xm)
leave115:               ;           -1 +loop_115(xm)
exit115:                ;           xloop LOOP_STACK
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string116  ; 3:10      print_i   Address of string116 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 1001       ; 3:10      do_116(xm)
do116save:              ;           do_116(xm)
    ld  (idx116),BC     ; 4:20      do_116(xm)
do116:                  ;           do_116(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_116 -1 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_116 -1 drop(m)
    ld   HL, (idx116)   ; 3:16      i_116 -1 drop(m)   idx always points to a 16-bit index
                        ;[10:58/38] -1 +loop_116(xm)   variant -1.F: step -1 and stop 2, run 1000x
idx116 EQU $+1          ;           -1 +loop_116(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +loop_116(xm)   1001.. -1 ..2, real_stop:0x0001
    dec  BC             ; 1:6       -1 +loop_116(xm)   index--
    ld    A, C          ; 1:4       -1 +loop_116(xm)
    dec   A             ; 1:4       -1 +loop_116(xm)
    or    B             ; 1:4       -1 +loop_116(xm)
    jp   nz, do116save  ; 3:10      -1 +loop_116(xm)
leave116:               ;           -1 +loop_116(xm)
exit116:                ;           xloop LOOP_STACK
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string117  ; 3:10      print_i   Address of string117 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 1199       ; 3:10      do_117(xm)
do117save:              ;           do_117(xm)
    ld  (idx117),BC     ; 4:20      do_117(xm)
do117:                  ;           do_117(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_117 -1 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_117 -1 drop(m)
    ld   HL, (idx117)   ; 3:16      i_117 -1 drop(m)   idx always points to a 16-bit index
                        ;[11:61/41] -1 +loop_117(xm)   variant -1.G: step -1 and hi(real_stop) = 0, run 1000x
idx117 EQU $+1          ;           -1 +loop_117(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +loop_117(xm)   1199.. -1 ..200, real_stop:0x00C7
    dec  BC             ; 1:6       -1 +loop_117(xm)   index--
    ld    A, C          ; 1:4       -1 +loop_117(xm)
    xor  0xC7           ; 2:7       -1 +loop_117(xm)   lo(real_stop)
    or    B             ; 1:4       -1 +loop_117(xm)
    jp   nz, do117save  ; 3:10      -1 +loop_117(xm)
leave117:               ;           -1 +loop_117(xm)
exit117:                ;           xloop LOOP_STACK
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 375        ; 3:10      do_118(xm)
do118save:              ;           do_118(xm)
    ld  (idx118),BC     ; 4:20      do_118(xm)
do118:                  ;           do_118(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_118 -1 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_118 -1 drop(m)
    ld   HL, (idx118)   ; 3:16      i_118 -1 drop(m)   idx always points to a 16-bit index
                        ;[16:57/58] -1 +loop_118(xm)   variant -1.defaultA: step -1, LO first, run 1000x
idx118 EQU $+1          ;           -1 +loop_118(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +loop_118(xm)   375.. -1 ..-624, real_stop:0xFD8F
    dec  BC             ; 1:6       -1 +loop_118(xm)   index--
    ld    A, C          ; 1:4       -1 +loop_118(xm)
    xor  0x8F           ; 2:7       -1 +loop_118(xm)   lo(real_stop)
    jp   nz, do118save  ; 3:10      -1 +loop_118(xm)   3x false positive
    ld    A, B          ; 1:4       -1 +loop_118(xm)
    xor  0xFD           ; 2:7       -1 +loop_118(xm)   hi(real_stop)
    jp   nz, do118save  ; 3:10      -1 +loop_118(xm)   112x false positive if he was first
leave118:               ;           -1 +loop_118(xm)
exit118:                ;           xloop LOOP_STACK
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string119  ; 3:10      print_i   Address of string119 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 486        ; 3:10      do_119(xm)
do119save:              ;           do_119(xm)
    ld  (idx119),BC     ; 4:20      do_119(xm)
do119:                  ;           do_119(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_119 -1 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_119 -1 drop(m)
    ld   HL, (idx119)   ; 3:16      i_119 -1 drop(m)   idx always points to a 16-bit index
                        ;[16:57/58] -1 +loop_119(xm)   variant -1.defaultB: step -1, HI first, run 1000x
idx119 EQU $+1          ;           -1 +loop_119(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -1 +loop_119(xm)   486.. -1 ..-513, real_stop:0xFDFE
    dec  BC             ; 1:6       -1 +loop_119(xm)   index--
    ld    A, B          ; 1:4       -1 +loop_119(xm)
    xor  0xFD           ; 2:7       -1 +loop_119(xm)   hi(real_stop)
    jp   nz, do119save  ; 3:10      -1 +loop_119(xm)   1x false positive
    ld    A, C          ; 1:4       -1 +loop_119(xm)
    xor  0xFE           ; 2:7       -1 +loop_119(xm)   lo(real_stop)
    jp   nz, do119save  ; 3:10      -1 +loop_119(xm)   3x false positive if he was first
leave119:               ;           -1 +loop_119(xm)
exit119:                ;           xloop LOOP_STACK
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string120  ; 3:10      print_i   Address of string120 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, -10        ; 3:10      do_120(xm)
do120save:              ;           do_120(xm)
    ld  (idx120),BC     ; 4:20      do_120(xm)
do120:                  ;           do_120(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[10:58/38] 2 +loop_120(xm)   variant +2.A: step 2 and real_stop is zero, run 5x
idx120 EQU $+1          ;           2 +loop_120(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +loop_120(xm)   -10.. +2 ..(0), real_stop:0x0000
    inc   C             ; 1:4       2 +loop_120(xm)   index++
    inc  BC             ; 1:6       2 +loop_120(xm)   index++
    ld    A, C          ; 1:4       2 +loop_120(xm)
    or    B             ; 1:4       2 +loop_120(xm)
    jp   nz, do120save  ; 3:10      2 +loop_120(xm)
leave120:               ;           2 +loop_120(xm)
exit120:                ;           2 +loop_120(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, -9         ; 3:10      do_121(xm)
do121save:              ;           do_121(xm)
    ld  (idx121),BC     ; 4:20      do_121(xm)
do121:                  ;           do_121(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[10:58/38] 2 +loop_121(xm)   variant +2.B: step 2 and real_stop is one, run 5x
idx121 EQU $+1          ;           2 +loop_121(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +loop_121(xm)   -9.. +2 ..(1), real_stop:0x0001
    inc  BC             ; 1:6       2 +loop_121(xm)   index++
    ld    A, C          ; 1:4       2 +loop_121(xm)
    inc   C             ; 1:4       2 +loop_121(xm)   index++
    or    B             ; 1:4       2 +loop_121(xm)
    jp   nz, do121save  ; 3:10      2 +loop_121(xm)
leave121:               ;           2 +loop_121(xm)
exit121:                ;           2 +loop_121(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string122  ; 3:10      print_i   Address of string122 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, -5         ; 3:10      do_122(xm)
do122save:              ;           do_122(xm)
    ld  (idx122),BC     ; 4:20      do_122(xm)
do122:                  ;           do_122(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[11:61/41] 2 +loop_122(xm)   variant +2.C: step 2 with lo(real_stop) exclusivity, run 5x
idx122 EQU $+1          ;           2 +loop_122(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +loop_122(xm)   -5.. +2 ..(5), real_stop:0x0005
    inc  BC             ; 1:6       2 +loop_122(xm)   index++
    inc   C             ; 1:4       2 +loop_122(xm)   index++
    ld    A, C          ; 1:4       2 +loop_122(xm)
    xor  0x05           ; 2:7       2 +loop_122(xm)   lo(real_stop)
    jp   nz, do122save  ; 3:10      2 +loop_122(xm)
leave122:               ;           2 +loop_122(xm)
exit122:                ;           2 +loop_122(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string123  ; 3:10      print_i   Address of string123 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 304        ; 3:10      do_123(xm)
do123save:              ;           do_123(xm)
    ld  (idx123),BC     ; 4:20      do_123(xm)
do123:                  ;           do_123(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_123 2 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_123 2 drop(m)
    ld   HL, (idx123)   ; 3:16      i_123 2 drop(m)   idx always points to a 16-bit index
                        ;[11:61/41] 2 +loop_123(xm)   variant +2.D: step 2 with hi(real_stop) exclusivity, run 1000x
idx123 EQU $+1          ;           2 +loop_123(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +loop_123(xm)   304.. +2 ..(2304), real_stop:0x0900
    inc   C             ; 1:4       2 +loop_123(xm)   index++
    inc  BC             ; 1:6       2 +loop_123(xm)   index++
    ld    A, B          ; 1:4       2 +loop_123(xm)
    xor  0x09           ; 2:7       2 +loop_123(xm)   hi(real_stop)
    jp   nz, do123save  ; 3:10      2 +loop_123(xm)
leave123:               ;           2 +loop_123(xm)
exit123:                ;           2 +loop_123(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string124  ; 3:10      print_i   Address of string124 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 50         ; 3:10      do_124(xm)
do124save:              ;           do_124(xm)
    ld  (idx124),BC     ; 4:20      do_124(xm)
do124:                  ;           do_124(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_124 2 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_124 2 drop(m)
    ld   HL, (idx124)   ; 3:16      i_124 2 drop(m)   idx always points to a 16-bit index
                        ;[17:61/62] 2 +loop_124(xm)   variant +2.defaultA: positive step 2, run 1000x
idx124 EQU $+1          ;           2 +loop_124(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +loop_124(xm)   50.. +2 ..(2050), real_stop:0x0802
    inc   C             ; 1:4       2 +loop_124(xm)   index++
    inc  BC             ; 1:6       2 +loop_124(xm)   index++
    ld    A, B          ; 1:4       2 +loop_124(xm)
    xor  0x08           ; 2:7       2 +loop_124(xm)   hi(real_stop) first (1<=7)
    jp   nz, do124save  ; 3:10      2 +loop_124(xm)   1x false positive
    ld    A, C          ; 1:4       2 +loop_124(xm)
    xor  0x02           ; 2:7       2 +loop_124(xm)   lo(real_stop)
    jp   nz, do124save  ; 3:10      2 +loop_124(xm)   7x false positive if he was first
leave124:               ;           2 +loop_124(xm)
exit124:                ;           2 +loop_124(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string125  ; 3:10      print_i   Address of string125 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, -10        ; 3:10      do_125(xm)
do125save:              ;           do_125(xm)
    ld  (idx125),BC     ; 4:20      do_125(xm)
do125:                  ;           do_125(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_125 2 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_125 2 drop(m)
    ld   HL, (idx125)   ; 3:16      i_125 2 drop(m)   idx always points to a 16-bit index
                        ;[17:61/62] 2 +loop_125(xm)   variant +2.defaultB: positive step 2, run 1000x
idx125 EQU $+1          ;           2 +loop_125(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +loop_125(xm)   -10.. +2 ..(1990), real_stop:0x07C6
    inc   C             ; 1:4       2 +loop_125(xm)   index++
    inc  BC             ; 1:6       2 +loop_125(xm)   index++
    ld    A, C          ; 1:4       2 +loop_125(xm)
    xor  0xC6           ; 2:7       2 +loop_125(xm)   lo(real_stop) first (99>7)
    jp   nz, do125save  ; 3:10      2 +loop_125(xm)   7x false positive
    ld    A, B          ; 1:4       2 +loop_125(xm)
    xor  0x07           ; 2:7       2 +loop_125(xm)   hi(real_stop)
    jp   nz, do125save  ; 3:10      2 +loop_125(xm)   99x false positive if he was first
leave125:               ;           2 +loop_125(xm)
exit125:                ;           2 +loop_125(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string126  ; 3:10      print_i   Address of string126 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 8          ; 3:10      do_126(xm)
do126save:              ;           do_126(xm)
    ld  (idx126),BC     ; 4:20      do_126(xm)
do126:                  ;           do_126(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[10:58/38] -2 +loop_126(xm)   variant -2.A: step -2 and real_stop is -2, run 5x
idx126 EQU $+1          ;           -2 +loop_126(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +loop_126(xm)   8.. -2 ..0, real_stop:0xFFFE
    ld    A, B          ; 1:4       -2 +loop_126(xm)
    dec  BC             ; 1:6       -2 +loop_126(xm)   index--
    dec   C             ; 1:4       -2 +loop_126(xm)   index--
    sub   B             ; 1:4       -2 +loop_126(xm)
    jp   nc, do126save  ; 3:10      -2 +loop_126(xm)
leave126:               ;           -2 +loop_126(xm)
exit126:                ;           -2 +loop_126(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string127  ; 3:10      print_i   Address of string127 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 9          ; 3:10      do_127(xm)
do127save:              ;           do_127(xm)
    ld  (idx127),BC     ; 4:20      do_127(xm)
do127:                  ;           do_127(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[10:58/38] -2 +loop_127(xm)   variant -2.B: step -2 and real_stop is -1, run 5x
idx127 EQU $+1          ;           -2 +loop_127(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +loop_127(xm)   9.. -2 ..1, real_stop:0xFFFF
    dec   C             ; 1:4       -2 +loop_127(xm)   index--
    ld    A, C          ; 1:4       -2 +loop_127(xm)
    or    B             ; 1:4       -2 +loop_127(xm)
    dec  BC             ; 1:6       -2 +loop_127(xm)   index--
    jp   nz, do127save  ; 3:10      -2 +loop_127(xm)
leave127:               ;           -2 +loop_127(xm)
exit127:                ;           -2 +loop_127(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string128  ; 3:10      print_i   Address of string128 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 10         ; 3:10      do_128(xm)
do128save:              ;           do_128(xm)
    ld  (idx128),BC     ; 4:20      do_128(xm)
do128:                  ;           do_128(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[10:58/38] -2 +loop_128(xm)   variant -2.C: step -2 and real_stop is zero, run 5x
idx128 EQU $+1          ;           -2 +loop_128(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +loop_128(xm)   10.. -2 ..2, real_stop:0x0000
    dec  BC             ; 1:6       -2 +loop_128(xm)   index--
    dec   C             ; 1:4       -2 +loop_128(xm)   index--
    ld    A, C          ; 1:4       -2 +loop_128(xm)
    or    B             ; 1:4       -2 +loop_128(xm)
    jp   nz, do128save  ; 3:10      -2 +loop_128(xm)
leave128:               ;           -2 +loop_128(xm)
exit128:                ;           -2 +loop_128(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string129  ; 3:10      print_i   Address of string129 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 264        ; 3:10      do_129(xm)
do129save:              ;           do_129(xm)
    ld  (idx129),BC     ; 4:20      do_129(xm)
do129:                  ;           do_129(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[11:61/41] -2 +loop_129(xm)   variant -2.D: step -2 with hi(real_stop) exclusivity, run 5x
idx129 EQU $+1          ;           -2 +loop_129(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +loop_129(xm)   264.. -2 ..256, real_stop:0x00FE
    dec  BC             ; 1:6       -2 +loop_129(xm)   index--
    dec   C             ; 1:4       -2 +loop_129(xm)   index--
    ld    A, B          ; 1:4       -2 +loop_129(xm)
    xor  0x00           ; 2:7       -2 +loop_129(xm)   hi(real_stop)
    jp   nz, do129save  ; 3:10      -2 +loop_129(xm)
leave129:               ;           -2 +loop_129(xm)
exit129:                ;           -2 +loop_129(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string130  ; 3:10      print_i   Address of string130 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 308        ; 3:10      do_130(xm)
do130save:              ;           do_130(xm)
    ld  (idx130),BC     ; 4:20      do_130(xm)
do130:                  ;           do_130(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[11:61/41] -2 +loop_130(xm)   variant -2.E: step -2 with lo(real_stop) exclusivity, run 5x
idx130 EQU $+1          ;           -2 +loop_130(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +loop_130(xm)   308.. -2 ..300, real_stop:0x012A
    dec  BC             ; 1:6       -2 +loop_130(xm)   index--
    dec   C             ; 1:4       -2 +loop_130(xm)   index--
    ld    A, C          ; 1:4       -2 +loop_130(xm)
    xor  0x2A           ; 2:7       -2 +loop_130(xm)   lo(real_stop)
    jp   nz, do130save  ; 3:10      -2 +loop_130(xm)
leave130:               ;           -2 +loop_130(xm)
exit130:                ;           -2 +loop_130(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string131  ; 3:10      print_i   Address of string131 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 2001       ; 3:10      do_131(xm)
do131save:              ;           do_131(xm)
    ld  (idx131),BC     ; 4:20      do_131(xm)
do131:                  ;           do_131(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_131 -2 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_131 -2 drop(m)
    ld   HL, (idx131)   ; 3:16      i_131 -2 drop(m)   idx always points to a 16-bit index
                        ;[11:62/42] -2 +loop_131(xm)   variant -2.F: step -2 and real_stop is one, run 1000x
idx131 EQU $+1          ;           -2 +loop_131(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +loop_131(xm)   2001.. -2 ..3, real_stop:0x0001
    dec   C             ; 1:4       -2 +loop_131(xm)   index--
    dec  BC             ; 1:6       -2 +loop_131(xm)   index--
    ld    A, C          ; 1:4       -2 +loop_131(xm)
    dec   A             ; 1:4       -2 +loop_131(xm)
    or    B             ; 1:4       -2 +loop_131(xm)
    jp   nz, do131save  ; 3:10      -2 +loop_131(xm)
leave131:               ;           -2 +loop_131(xm)
exit131:                ;           -2 +loop_131(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string132  ; 3:10      print_i   Address of string132 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 2232       ; 3:10      do_132(xm)
do132save:              ;           do_132(xm)
    ld  (idx132),BC     ; 4:20      do_132(xm)
do132:                  ;           do_132(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_132 -2 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_132 -2 drop(m)
    ld   HL, (idx132)   ; 3:16      i_132 -2 drop(m)   idx always points to a 16-bit index
                        ;[12:65/45] -2 +loop_132(xm)   variant -2.G: step -2 and real_stop 2..255, run 1000x
idx132 EQU $+1          ;           -2 +loop_132(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +loop_132(xm)   2232.. -2 ..234, real_stop:0x00E8
    dec  BC             ; 1:6       -2 +loop_132(xm)   index--
    dec   C             ; 1:4       -2 +loop_132(xm)   index--
    ld    A, C          ; 1:4       -2 +loop_132(xm)
    xor  0xE8           ; 2:7       -2 +loop_132(xm)   lo(real_stop)
    or    B             ; 1:4       -2 +loop_132(xm)
    jp   nz, do132save  ; 3:10      -2 +loop_132(xm)
leave132:               ;           -2 +loop_132(xm)
exit132:                ;           -2 +loop_132(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string133  ; 3:10      print_i   Address of string133 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 196        ; 3:10      do_133(xm)
do133save:              ;           do_133(xm)
    ld  (idx133),BC     ; 4:20      do_133(xm)
do133:                  ;           do_133(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_133 -2 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_133 -2 drop(m)
    ld   HL, (idx133)   ; 3:16      i_133 -2 drop(m)   idx always points to a 16-bit index
                        ;[17:61/62] -2 +loop_133(xm)   variant -2.defaultA: positive step -2, run 1000x
idx133 EQU $+1          ;           -2 +loop_133(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +loop_133(xm)   196.. -2 ..-1802, real_stop:0xF8F4
    dec  BC             ; 1:6       -2 +loop_133(xm)   index--
    dec   C             ; 1:4       -2 +loop_133(xm)   index--
    ld    A, B          ; 1:4       -2 +loop_133(xm)
    xor  0xF8           ; 2:7       -2 +loop_133(xm)   hi(real_stop) first (5<=7)
    jp   nz, do133save  ; 3:10      -2 +loop_133(xm)   5x false positive
    ld    A, C          ; 1:4       -2 +loop_133(xm)
    xor  0xF4           ; 2:7       -2 +loop_133(xm)   lo(real_stop)
    jp   nz, do133save  ; 3:10      -2 +loop_133(xm)   7x false positive if he was first
leave133:               ;           -2 +loop_133(xm)
exit133:                ;           -2 +loop_133(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string134  ; 3:10      print_i   Address of string134 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 250        ; 3:10      do_134(xm)
do134save:              ;           do_134(xm)
    ld  (idx134),BC     ; 4:20      do_134(xm)
do134:                  ;           do_134(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_134 -2 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_134 -2 drop(m)
    ld   HL, (idx134)   ; 3:16      i_134 -2 drop(m)   idx always points to a 16-bit index
                        ;[17:61/62] -2 +loop_134(xm)   variant -2.defaultB: positive step -2, run 1000x
idx134 EQU $+1          ;           -2 +loop_134(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -2 +loop_134(xm)   250.. -2 ..-1748, real_stop:0xF92A
    dec  BC             ; 1:6       -2 +loop_134(xm)   index--
    dec   C             ; 1:4       -2 +loop_134(xm)   index--
    ld    A, C          ; 1:4       -2 +loop_134(xm)
    xor  0x2A           ; 2:7       -2 +loop_134(xm)   lo(real_stop) first (106>7)
    jp   nz, do134save  ; 3:10      -2 +loop_134(xm)   7x false positive
    ld    A, B          ; 1:4       -2 +loop_134(xm)
    xor  0xF9           ; 2:7       -2 +loop_134(xm)   hi(real_stop)
    jp   nz, do134save  ; 3:10      -2 +loop_134(xm)   106x false positive if he was first
leave134:               ;           -2 +loop_134(xm)
exit134:                ;           -2 +loop_134(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string135  ; 3:10      print_i   Address of string135 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 13         ; 3:10      do_135(xm)
do135save:              ;           do_135(xm)
    ld  (idx135),BC     ; 4:20      do_135(xm)
do135:                  ;           do_135(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[11:66/46] -3 +loop_135(xm)   variant -X.A: step -3 and stop 0, run 5x
idx135 EQU $+1          ;           -3 +loop_135(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -3 +loop_135(xm)   13.. -3 ..0, real_stop:0xFFFE
    ld    A, B          ; 1:4       -3 +loop_135(xm)   hi old index
    dec  BC             ; 1:6       -3 +loop_135(xm)   index--
    dec  BC             ; 1:6       -3 +loop_135(xm)   index--
    dec  BC             ; 1:6       -3 +loop_135(xm)   index--
    sub   B             ; 1:4       -3 +loop_135(xm)   old-new = carry if index: positive -> negative
    jp   nc, do135save  ; 3:10      -3 +loop_135(xm)   carry if postivie index -> negative index
leave135:               ;           -3 +loop_135(xm)
exit135:                ;           -3 +loop_135(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string136  ; 3:10      print_i   Address of string136 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 43         ; 3:10      do_136(xm)
do136save:              ;           do_136(xm)
    ld  (idx136),BC     ; 4:20      do_136(xm)
do136:                  ;           do_136(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[14:70/50] -10 +loop_136(xm)   variant -X.B: negative step and stop 0, run 5x
idx136 EQU $+1          ;           -10 +loop_136(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -10 +loop_136(xm)   43.. -10 ..0, real_stop:0xFFF9
    ld    A, C          ; 1:4       -10 +loop_136(xm)
    sub  low 10         ; 2:7       -10 +loop_136(xm)
    ld    C, A          ; 1:4       -10 +loop_136(xm)
    ld    A, B          ; 1:4       -10 +loop_136(xm)
    sbc   A, high 10    ; 2:7       -10 +loop_136(xm)
    ld    B, A          ; 1:4       -10 +loop_136(xm)
    jp   nc, do136save  ; 3:10      -10 +loop_136(xm)   carry if postivie index -> negative index
leave136:               ;           -10 +loop_136(xm)
exit136:                ;           -10 +loop_136(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string137  ; 3:10      print_i   Address of string137 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 671        ; 3:10      do_137(xm)
do137save:              ;           do_137(xm)
    ld  (idx137),BC     ; 4:20      do_137(xm)
do137:                  ;           do_137(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM

                        ;[17:55/60] -33 +loop_137(xm)   variant +X.C: negative step 3..255 and hi(real_stop) exclusivity, run 5x
idx137 EQU $+1          ;           -33 +loop_137(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -33 +loop_137(xm)   671.. -33 ..510, real_stop:0x01FA
    ld    A, C          ; 1:4       -33 +loop_137(xm)
    sub  low 33         ; 2:7       -33 +loop_137(xm)
    ld    C, A          ; 1:4       -33 +loop_137(xm)
    jp   nc, do137save  ; 3:10      -33 +loop_137(xm)
    dec   B             ; 1:4       -33 +loop_137(xm)
    ld    A, B          ; 1:4       -33 +loop_137(xm)
    xor  0x01           ; 2:7       -33 +loop_137(xm)   hi(real_stop)
    jp   nz, do137save  ; 3:10      -33 +loop_137(xm)
leave137:               ;           -33 +loop_137(xm)
exit137:                ;           -33 +loop_137(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string138  ; 3:10      print_i   Address of string138 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 50         ; 3:10      do_138(xm)
do138save:              ;           do_138(xm)
    ld  (idx138),BC     ; 4:20      do_138(xm)
do138:                  ;           do_138(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM

                        ;[16:77/57] -300 +loop_138(xm)   variant +X.D: negative step 256+ and hi(real_stop) exclusivity, run 5x
idx138 EQU $+1          ;           -300 +loop_138(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -300 +loop_138(xm)   50.. -300 ..-1160, real_stop:0xFA56
    ld    A, C          ; 1:4       -300 +loop_138(xm)
    sub  low 300        ; 2:7       -300 +loop_138(xm)
    ld    C, A          ; 1:4       -300 +loop_138(xm)
    ld    A, B          ; 1:4       -300 +loop_138(xm)
    sbc   A, high 300   ; 2:7       -300 +loop_138(xm)
    ld    B, A          ; 1:4       -300 +loop_138(xm)
    xor  0xFA           ; 2:7       -300 +loop_138(xm)   hi(real_stop)
    jp   nz, do138save  ; 3:10      -300 +loop_138(xm)
leave138:               ;           -300 +loop_138(xm)
exit138:                ;           -300 +loop_138(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string139  ; 3:10      print_i   Address of string139 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 7027       ; 3:10      do_139(xm)
do139save:              ;           do_139(xm)
    ld  (idx139),BC     ; 4:20      do_139(xm)
do139:                  ;           do_139(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_139 -7 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_139 -7 drop(m)
    ld   HL, (idx139)   ; 3:16      i_139 -7 drop(m)   idx always points to a 16-bit index
                        ;[20:70/71] -7 +loop_139(xm)   variant -X.E: negative step and real_stop 0..255, run 1000x
idx139 EQU $+1          ;           -7 +loop_139(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -7 +loop_139(xm)   7027.. -7 ..30, real_stop:0x001B
    ld    A, C          ; 1:4       -7 +loop_139(xm)
    sub  low 7          ; 2:7       -7 +loop_139(xm)
    ld    C, A          ; 1:4       -7 +loop_139(xm)
    ld    A, B          ; 1:4       -7 +loop_139(xm)
    sbc   A, high 7     ; 2:7       -7 +loop_139(xm)
    ld    B, A          ; 1:4       -7 +loop_139(xm)
    jp   nz, do139save  ; 3:10      -7 +loop_139(xm)
    ld    A, C          ; 1:4       -7 +loop_139(xm)   A = last_index
    xor  low 27         ; 2:7       -7 +loop_139(xm)
    jp   nz, do139save  ; 3:10      -7 +loop_139(xm)
leave139:               ;           -7 +loop_139(xm)
exit139:                ;           -7 +loop_139(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string140  ; 3:10      print_i   Address of string140 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 6927       ; 3:10      do_140(xm)
do140save:              ;           do_140(xm)
    ld  (idx140),BC     ; 4:20      do_140(xm)
do140:                  ;           do_140(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_140 -7 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_140 -7 drop(m)
    ld   HL, (idx140)   ; 3:16      i_140 -7 drop(m)   idx always points to a 16-bit index
                        ;[23:81/82] -7 +loop_140(xm)   variant -X.default: negative step, run 1000x
idx140 EQU $+1          ;           -7 +loop_140(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      -7 +loop_140(xm)   6927.. -7 ..-70, real_stop:0xFFB7
    ld    A, C          ; 1:4       -7 +loop_140(xm)
    sub  low 7          ; 2:7       -7 +loop_140(xm)
    ld    C, A          ; 1:4       -7 +loop_140(xm)
    ld    A, B          ; 1:4       -7 +loop_140(xm)
    sbc   A, high 7     ; 2:7       -7 +loop_140(xm)
    ld    B, A          ; 1:4       -7 +loop_140(xm)
    ld    A, C          ; 1:4       -7 +loop_140(xm)
    xor  0xB7           ; 2:7       -7 +loop_140(xm)   lo(real_stop)
    jp   nz, do140save  ; 3:10      -7 +loop_140(xm)   3x
    ld    A, B          ; 1:4       -7 +loop_140(xm)
    xor  0xFF           ; 2:7       -7 +loop_140(xm)   hi(real_stop)
    jp   nz, do140save  ; 3:10      -7 +loop_140(xm)   10x
leave140:               ;           -7 +loop_140(xm)
exit140:                ;           -7 +loop_140(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string141  ; 3:10      print_i   Address of string141 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 10         ; 3:10      do_141(xm)
do141save:              ;           do_141(xm)
    ld  (idx141),BC     ; 4:20      do_141(xm)
do141:                  ;           do_141(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[13:48]    3 +loop_141(xm)   variant +X.A: positive step and 0 <= index < stop < 256, run 5x
idx141 EQU $+1          ;           3 +loop_141(xm)   idx always points to a 16-bit index
    ld    A, 0x00       ; 2:7       3 +loop_141(xm)   10.. +3 ..(25), real_stop:0x0019
    nop                 ; 1:4       3 +loop_141(xm)   Contains a zero value because idx always points to a 16-bit index.
    add   A, low 3      ; 2:7       3 +loop_141(xm)   A = index+step
    ld  (idx141), A     ; 3:13      3 +loop_141(xm)   save new index
    xor  0x19           ; 2:7       3 +loop_141(xm)   lo(real_stop)
    jp   nz, do141      ; 3:10      3 +loop_141(xm)
leave141:               ;           3 +loop_141(xm)
exit141:                ;           3 +loop_141(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string142  ; 3:10      print_i   Address of string142 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 0xC601     ; 3:10      do_142(xm)
do142save:              ;           do_142(xm)
    ld  (idx142),BC     ; 4:20      do_142(xm)
do142:                  ;           do_142(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[12:44]    3 +loop_142(xm)   variant +X.B: positive step and 0xC600 <= index < stop < 0xC700, run 5x
idx142 EQU $+1          ;           3 +loop_142(xm)   idx always points to a 16-bit index
    ld    A, 0x00       ; 2:7       3 +loop_142(xm)   0xC601.. +3 ..(0xC610), real_stop:0xC610
    add   A, low 3      ; 2:7       3 +loop_142(xm)   First byte contains a 0xC6 value because idx always points to a 16-bit index.
    ld  (idx142), A     ; 3:13      3 +loop_142(xm)   save new index
    xor  0x10           ; 2:7       3 +loop_142(xm)   lo(real_stop)
    jp   nz, do142      ; 3:10      3 +loop_142(xm)
leave142:               ;           3 +loop_142(xm)
exit142:                ;           3 +loop_142(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string143  ; 3:10      print_i   Address of string143 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 25         ; 3:10      do_143(xm)
do143save:              ;           do_143(xm)
    ld  (idx143),BC     ; 4:20      do_143(xm)
do143:                  ;           do_143(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[14:51]    512 +loop_143(xm)   variant +X.C: positive step = n*256, run 5x
idx143 EQU $+1          ;           512 +loop_143(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      512 +loop_143(xm)   25.. +512 ..(2500), real_stop:0x0A19
    ld    A, B          ; 1:4       512 +loop_143(xm)
    add   A, 0x02       ; 2:7       512 +loop_143(xm)   hi(step)
    ld  (idx143+1),A    ; 3:13      512 +loop_143(xm)   save index
    xor  0x0A           ; 2:7       512 +loop_143(xm)   hi(real_stop)
    jp   nz, do143      ; 3:10      512 +loop_143(xm)
leave143:               ;           512 +loop_143(xm)
exit143:                ;           512 +loop_143(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string144  ; 3:10      print_i   Address of string144 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, -15        ; 3:10      do_144(xm)
do144save:              ;           do_144(xm)
    ld  (idx144),BC     ; 4:20      do_144(xm)
do144:                  ;           do_144(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[14:55/49] 3 +loop_144(xm)   variant +X.D: positive step 3..255 and stop 0, run 5x
idx144 EQU $+1          ;           3 +loop_144(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      3 +loop_144(xm)   -15.. +3 ..(0), real_stop:0x0000
    ld    A, C          ; 1:4       3 +loop_144(xm)
    add   A, low 3      ; 2:7       3 +loop_144(xm)
    ld    C, A          ; 1:4       3 +loop_144(xm)
    jp   nc, do144save  ; 3:10      3 +loop_144(xm)
    inc   B             ; 1:4       3 +loop_144(xm)
    jp   nc, do144save  ; 3:10      3 +loop_144(xm)
leave144:               ;           3 +loop_144(xm)
exit144:                ;           3 +loop_144(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string145  ; 3:10      print_i   Address of string145 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, -29        ; 3:10      do_145(xm)
do145save:              ;           do_145(xm)
    ld  (idx145),BC     ; 4:20      do_145(xm)
do145:                  ;           do_145(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[14:55/49] 7 +loop_145(xm)   variant +X.E: positive step 3..255 and hi(real_stop) = exclusivity zero, run 5x
idx145 EQU $+1          ;           7 +loop_145(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      7 +loop_145(xm)   -29.. +7 ..(5), real_stop:0x0006
    ld    A, C          ; 1:4       7 +loop_145(xm)
    add   A, low 7      ; 2:7       7 +loop_145(xm)
    ld    C, A          ; 1:4       7 +loop_145(xm)
    jp   nc, do145save  ; 3:10      7 +loop_145(xm)
    inc   B             ; 1:4       7 +loop_145(xm)
    jp   nz, do145save  ; 3:10      7 +loop_145(xm)
leave145:               ;           7 +loop_145(xm)
exit145:                ;           7 +loop_145(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string146  ; 3:10      print_i   Address of string146 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 227        ; 3:10      do_146(xm)
do146save:              ;           do_146(xm)
    ld  (idx146),BC     ; 4:20      do_146(xm)
do146:                  ;           do_146(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[17:55/60] 7 +loop_146(xm)   variant +X.F: positive step 3..255 and hi(real_stop) exclusivity, run 5x
idx146 EQU $+1          ;           7 +loop_146(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      7 +loop_146(xm)   227.. +7 ..(260), real_stop:0x0106
    ld    A, C          ; 1:4       7 +loop_146(xm)
    add   A, low 7      ; 2:7       7 +loop_146(xm)
    ld    C, A          ; 1:4       7 +loop_146(xm)
    jp   nc, do146save  ; 3:10      7 +loop_146(xm)
    inc   B             ; 1:4       7 +loop_146(xm)
    ld    A, B          ; 1:4       7 +loop_146(xm)
    xor  0x01           ; 2:7       7 +loop_146(xm)   hi(real_stop)
    jp   nz, do146save  ; 3:10      7 +loop_146(xm)
leave146:               ;           7 +loop_146(xm)
exit146:                ;           7 +loop_146(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string147  ; 3:10      print_i   Address of string147 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, -23        ; 3:10      do_147(xm)
do147save:              ;           do_147(xm)
    ld  (idx147),BC     ; 4:20      do_147(xm)
do147:                  ;           do_147(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[19:67/68] 7 +loop_147(xm)   variant +X.G: positive step 3..255 and real_stop 0..255, run 5x
idx147 EQU $+1          ;           7 +loop_147(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      7 +loop_147(xm)   -23.. +7 ..(10), real_stop:0x000C
    ld    A, C          ; 1:4       7 +loop_147(xm)
    add   A, low 7      ; 2:7       7 +loop_147(xm)
    ld    C, A          ; 1:4       7 +loop_147(xm)
    adc   A, B          ; 1:4       7 +loop_147(xm)
    sub   C             ; 1:4       7 +loop_147(xm)
    ld    B, A          ; 1:4       7 +loop_147(xm)
    jp   nz, do147save  ; 3:10      7 +loop_147(xm)
    ld    A, C          ; 1:4       7 +loop_147(xm)
    xor  0x0C           ; 2:7       7 +loop_147(xm)   lo(real_stop)
    jp   nz, do147save  ; 3:10      7 +loop_147(xm)
leave147:               ;           7 +loop_147(xm)
exit147:                ;           7 +loop_147(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string148  ; 3:10      print_i   Address of string148 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, -1485      ; 3:10      do_148(xm)
do148save:              ;           do_148(xm)
    ld  (idx148),BC     ; 4:20      do_148(xm)
do148:                  ;           do_148(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[14:70/50] 345 +loop_148(xm)   variant +X.H: positive step 256+ and hi(real_stop) exclusivity zero, run 5x
idx148 EQU $+1          ;           345 +loop_148(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      345 +loop_148(xm)   -1485.. +345 ..(230), real_stop:0x00F0
    ld    A, C          ; 1:4       345 +loop_148(xm)
    add   A, low 345    ; 2:7       345 +loop_148(xm)
    ld    C, A          ; 1:4       345 +loop_148(xm)
    ld    A, B          ; 1:4       345 +loop_148(xm)
    adc   A, high 345   ; 2:7       345 +loop_148(xm)
    ld    B, A          ; 1:4       345 +loop_148(xm)
    jp   nz, do148save  ; 3:10      345 +loop_148(xm)
leave148:               ;           345 +loop_148(xm)
exit148:                ;           345 +loop_148(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string149  ; 3:10      print_i   Address of string149 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 516        ; 3:10      do_149(xm)
do149save:              ;           do_149(xm)
    ld  (idx149),BC     ; 4:20      do_149(xm)
do149:                  ;           do_149(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_149 4 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_149 4 drop(m)
    ld   HL, (idx149)   ; 3:16      i_149 4 drop(m)   idx always points to a 16-bit index
                        ;[21:74/75] 4 +loop_149(xm)   variant +X.I: positive step 3..255, hi(real_stop) has fewer duplicate,run 1000x
idx149 EQU $+1          ;           4 +loop_149(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      4 +loop_149(xm)   516.. +4 ..(4516), real_stop:0x11A4
    ld    A, C          ; 1:4       4 +loop_149(xm)
    add   A, low 4      ; 2:7       4 +loop_149(xm)
    ld    C, A          ; 1:4       4 +loop_149(xm)
    adc   A, B          ; 1:4       4 +loop_149(xm)
    sub   C             ; 1:4       4 +loop_149(xm)
    ld    B, A          ; 1:4       4 +loop_149(xm)
    xor  0x11           ; 2:7       4 +loop_149(xm)   hi(real_stop) first (21*41<=4*1000+21*15)
    jp   nz, do149save  ; 3:10      4 +loop_149(xm)   41x false positive
    ld    A, C          ; 1:4       4 +loop_149(xm)
    xor  0xA4           ; 2:7       4 +loop_149(xm)   lo(real_stop)
    jp   nz, do149save  ; 3:10      4 +loop_149(xm)   15x false positive if he was first
leave149:               ;           4 +loop_149(xm)
exit149:                ;           4 +loop_149(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string150  ; 3:10      print_i   Address of string150 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 33         ; 3:10      do_150(xm)
do150save:              ;           do_150(xm)
    ld  (idx150),BC     ; 4:20      do_150(xm)
do150:                  ;           do_150(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[16:77/57] 300 +loop_150(xm)   variant +X.J: positive step 256+ and hi(real_stop) exclusivity, run 5x
idx150 EQU $+1          ;           300 +loop_150(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      300 +loop_150(xm)   33.. +300 ..(1234), real_stop:0x05FD
    ld    A, C          ; 1:4       300 +loop_150(xm)
    add   A, low 300    ; 2:7       300 +loop_150(xm)
    ld    C, A          ; 1:4       300 +loop_150(xm)
    ld    A, B          ; 1:4       300 +loop_150(xm)
    adc   A, high 300   ; 2:7       300 +loop_150(xm)
    ld    B, A          ; 1:4       300 +loop_150(xm)
    xor  0x05           ; 2:7       300 +loop_150(xm)   hi(real_stop)
    jp   nz, do150save  ; 3:10      300 +loop_150(xm)
leave150:               ;           300 +loop_150(xm)
exit150:                ;           300 +loop_150(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string151  ; 3:10      print_i   Address of string151 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    ld   BC, 1019       ; 3:10      do_151(xm)
do151save:              ;           do_151(xm)
    ld  (idx151),BC     ; 4:20      do_151(xm)
do151:                  ;           do_151(xm)
    ld    A, '.'        ; 2:7       putchar('.')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('.')   putchar(reg A) with ZX 48K ROM
                        ;[16:78/58] 3 +loop_151(xm)   variant +X.K : positive step 3..255 and lo(real_stop) exclusivity, run 5x
idx151 EQU $+1          ;           3 +loop_151(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      3 +loop_151(xm)   1019.. +3 ..(1034), real_stop:0x040A
    ld    A, C          ; 1:4       3 +loop_151(xm)
    add   A, low 3      ; 2:7       3 +loop_151(xm)
    ld    C, A          ; 1:4       3 +loop_151(xm)
    adc   A, B          ; 1:4       3 +loop_151(xm)
    sub   C             ; 1:4       3 +loop_151(xm)
    ld    B, A          ; 1:4       3 +loop_151(xm)
    ld    A, C          ; 1:4       3 +loop_151(xm)
    xor  0x0A           ; 2:7       3 +loop_151(xm)   lo(real_stop)
    jp   nz, do151save  ; 3:10      3 +loop_151(xm)
leave151:               ;           3 +loop_151(xm)
exit151:                ;           3 +loop_151(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, string152  ; 3:10      print_i   Address of string152 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[7:40]     0 0
    push DE             ; 1:11      0 0   ( -- 0 0 )
    push HL             ; 1:11      0 0
    ld   DE, 0x0000     ; 3:10      0 0
    ld    L, D          ; 1:4       0 0   L = D = 0x00
    ld    H, L          ; 1:4       0 0   H = L = 0x00
    ld   BC, 100        ; 3:10      do_152(xm)
do152save:              ;           do_152(xm)
    ld  (idx152),BC     ; 4:20      do_152(xm)
do152:                  ;           do_152(xm)
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      i_152 4 drop(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_152 4 drop(m)
    ld   HL, (idx152)   ; 3:16      i_152 4 drop(m)   idx always points to a 16-bit index
                        ;[22:78/79] 4 +loop_152(xm)   variant +X.L: positive step 3..255, lo(real_stop) has fewer duplicate, run 100x
idx152 EQU $+1          ;           4 +loop_152(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      4 +loop_152(xm)   100.. +4 ..(500), real_stop:0x01F4
    ld    A, C          ; 1:4       4 +loop_152(xm)
    add   A, low 4      ; 2:7       4 +loop_152(xm)
    ld    C, A          ; 1:4       4 +loop_152(xm)
    adc   A, B          ; 1:4       4 +loop_152(xm)
    sub   C             ; 1:4       4 +loop_152(xm)
    ld    B, A          ; 1:4       4 +loop_152(xm)
    ld    A, C          ; 1:4       4 +loop_152(xm)
    xor  0xF4           ; 2:7       4 +loop_152(xm)   lo(real_stop) first (21*61>4*100+21*1)
    jp   nz, do152save  ; 3:10      4 +loop_152(xm)   1x false positive
    ld    A, B          ; 1:4       4 +loop_152(xm)
    xor  0x01           ; 2:7       4 +loop_152(xm)   hi(real_stop)
    jp   nz, do152save  ; 3:10      4 +loop_152(xm)   61x false positive if he was first
leave152:               ;           4 +loop_152(xm)
exit152:                ;           4 +loop_152(xm)
    call PRT_S16        ; 3:17      .   ( s -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;------------------------------------------------------------------------------
; Input: HL
; Output: Print signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_S16:                ;           prt_s16
    ld    A, H          ; 1:4       prt_s16
    add   A, A          ; 1:4       prt_s16
    jr   nc, PRT_U16    ; 2:7/12    prt_s16
    ld    A, '-'        ; 2:7       prt_s16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_s16   putchar(reg A) with ZX 48K ROM
    xor   A             ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    L, A          ; 1:4       prt_s16   neg
    sbc   A, H          ; 1:4       prt_s16   neg
    sub   L             ; 1:4       prt_s16   neg
    ld    H, A          ; 1:4       prt_s16   neg
    jr   PRT_U16        ; 2:12      prt_s16
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_U16:             ;           prt_sp_u16
    ld    A, ' '        ; 2:7       prt_sp_u16   putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      prt_sp_u16   putchar with ZX 48K ROM in, this will print char in A
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
    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec
;------------------------------------------------------------------------------
; Print string ending with inverted most significant bit
; In: BC = addr string_imsb
; Out: BC = addr last_char + 1
    rst  0x10           ; 1:11      print_string_i putchar with ZX 48K ROM in, this will print char in A
PRINT_STRING_I:         ;           print_string_i
    ld    A,(BC)        ; 1:7       print_string_i
    inc  BC             ; 1:6       print_string_i
    or    A             ; 1:4       print_string_i
    jp    p, $-4        ; 3:10      print_string_i
    and  0x7f           ; 2:7       print_string_i
    rst  0x10           ; 1:11      print_string_i putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10      print_string_i

STRING_SECTION:
string152:
    db "+X.L 4  100..(500)  "," " + 0x80
  size152   EQU  $ - string152
string151:
    db "+X.K 3 1019..(1034)   "," " + 0x80
  size151   EQU  $ - string151
string150:
    db "+X.J 300 33..1234     "," " + 0x80
  size150   EQU  $ - string150
string149:
    db "+X.I 4  516..(4516)"," " + 0x80
  size149   EQU  $ - string149
string148:
    db "+X.H 345 -1485..(230) "," " + 0x80
  size148   EQU  $ - string148
string147:
    db "+X.G 7  -23..(10)     "," " + 0x80
  size147   EQU  $ - string147
string146:
    db "+X.F 7  227..(260)    "," " + 0x80
  size146   EQU  $ - string146
string145:
    db "+X.E 7  -29..(5)      "," " + 0x80
  size145   EQU  $ - string145
string144:
    db "+X.D 3  -15..(0)      "," " + 0x80
  size144   EQU  $ - string144
string143:
    db "+X.C 512 25..(2500)   "," " + 0x80
  size143   EQU  $ - string143
string142:
    db "+X.B 3 0xC601..(0xC610",")" + 0x80
  size142   EQU  $ - string142
string141:
    db "+X.A 3   10..(25)     "," " + 0x80
  size141   EQU  $ - string141
string140:
    db "-X.def -7 6927..-70 "," " + 0x80
  size140   EQU  $ - string140
string139:
    db "-X.E -7   7027..30   "," " + 0x80
  size139   EQU  $ - string139
string138:
    db "-X.D -300 50..-1160   "," " + 0x80
  size138   EQU  $ - string138
string137:
    db "-X.C -33 671..510     "," " + 0x80
  size137   EQU  $ - string137
string136:
    db "-X.B -10  43..0       "," " + 0x80
  size136   EQU  $ - string136
string135:
    db "-X.A -3   13..0       "," " + 0x80
  size135   EQU  $ - string135
string134:
    db "-2.defB  250..-1748"," " + 0x80
  size134   EQU  $ - string134
string133:
    db "-2.defA  196..-1802"," " + 0x80
  size133   EQU  $ - string133
string132:
    db "-2.G    2232..234   "," " + 0x80
  size132   EQU  $ - string132
string131:
    db "-2.F    2001..3       "," " + 0x80
  size131   EQU  $ - string131
string130:
    db "-2.E     308..300     "," " + 0x80
  size130   EQU  $ - string130
string129:
    db "-2.D     264..256     "," " + 0x80
  size129   EQU  $ - string129
string128:
    db "-2.C      10..2       "," " + 0x80
  size128   EQU  $ - string128
string127:
    db "-2.B       9..1       "," " + 0x80
  size127   EQU  $ - string127
string126:
    db "-2.A       8..0       "," " + 0x80
  size126   EQU  $ - string126
string125:
    db "+2.defB -10..(1990)"," " + 0x80
  size125   EQU  $ - string125
string124:
    db "+2.defA  50..(2050)"," " + 0x80
  size124   EQU  $ - string124
string123:
    db "+2.D    304..(2304)"," " + 0x80
  size123   EQU  $ - string123
string122:
    db "+2.C     -5..(5)      "," " + 0x80
  size122   EQU  $ - string122
string121:
    db "+2.B     -9..(1)      "," " + 0x80
  size121   EQU  $ - string121
string120:
    db "+2.A    -10..(0)      "," " + 0x80
  size120   EQU  $ - string120
string119:
    db "-1.defB 486..-513  "," " + 0x80
  size119   EQU  $ - string119
string118:
    db "-1.defA 375..-624  "," " + 0x80
  size118   EQU  $ - string118
string117:
    db "-1.G   1199..200    "," " + 0x80
  size117   EQU  $ - string117
string116:
    db "-1.F   1001..2        "," " + 0x80
  size116   EQU  $ - string116
string115:
    db "-1.E    998..-1      "," " + 0x80
  size115   EQU  $ - string115
string114:
    db "-1.D   1255..256    "," " + 0x80
  size114   EQU  $ - string114
string113:
    db "-1.C    258..254      "," " + 0x80
  size113   EQU  $ - string113
string112:
    db "-1.B      5..1        "," " + 0x80
  size112   EQU  $ - string112
string111:
    db "-1.A      4..0        "," " + 0x80
  size111   EQU  $ - string111
string110:
    db "+1.def -700..(300)  "," " + 0x80
  size110   EQU  $ - string110
string109:
    db "+1.I 6318h..(26368",")" + 0x80
  size109   EQU  $ - string109
string108:
    db "+1.H     -3..(2)      "," " + 0x80
  size108   EQU  $ - string108
string107:
    db "+1.G     -5..(0)      "," " + 0x80
  size107   EQU  $ - string107
string106:
    db "+1.F 0x4050..(0x4055) "," " + 0x80
  size106   EQU  $ - string106
string105:
    db "+1.E 0x65FB..(0x6600) "," " + 0x80
  size105   EQU  $ - string105
string104:
    db "+1.D 0x3C05..(0x3C0A) "," " + 0x80
  size104   EQU  $ - string104
string103:
    db "+1.C 0x3CFB..(0x3D00) "," " + 0x80
  size103   EQU  $ - string103
string102:
    db "+1.B    241..(246)    "," " + 0x80
  size102   EQU  $ - string102
string101:
    db "+1.A    251..(256)    "," " + 0x80
  size101   EQU  $ - string101
