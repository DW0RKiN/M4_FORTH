    ORG 32768
    

                                                                                                                                                                           
                                                                                                                                                                     
                                                                                                                                                                            
                                                                                                                                                                                      
                                                                                                                                                                                         

                                                                                                                         
                                                                                                    
                                                                                                                         ;--> " 5, 4, 3, 2, 1, 0"
                                                                                                                                                   ;--> " 0, 1, 2, 3, 4"
                                                                                                                                                   ;--> " 0, 2, 4"

                
                                                                                         
                                                                                         
                                                                                             
                                                                                         
                                                                                         
                                                                                        
                                                                                      
                                                                                  
                                                                                  
                                                                                 
                                                                       

                                                                       


                
                                                                                                                                                         
                                                                                                                                                      
                                                                                                                                                             
                                                                                                                                                            
                                                                                                                                      
             
                                                                                                                                     
             
                                                                                                                                               
                                                                                                                                                                    
    
                
                                                              
                                                          
                                                                  
                                                              
                                                              
                                                             
                                                           
                                                       
                                                       
                                                      
                                                          

                                                          


                                              
                                                       
                

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    ld   BC, 0          ; 3:10      4 0 do_101(xm)
do101save:              ;           4 0 do_101(xm)
    ld  (idx101),BC     ; 4:20      4 0 do_101(xm)
do101:                  ;           4 0 do_101(xm)
    push DE             ; 1:11      i_101 0   ( -- i 0 )
    push HL             ; 1:11      i_101 0
    ld   DE, (idx101)   ; 4:20      i_101 0   idx always points to a 16-bit index
    ld   HL, 0          ; 3:10      i_101 0
    ld  (idx102), HL    ; 3:16      ?do_102(m)   ( stop index -- )
    or    A             ; 1:4       ?do_102(m)
    sbc  HL, DE         ; 2:15      ?do_102(m)
    ld    A, E          ; 1:4       ?do_102(m)
    ld  (stp_lo102), A  ; 3:13      ?do_102(m)   lo stop
    ld    A, D          ; 1:4       ?do_102(m)
    ld  (stp_hi102), A  ; 3:13      ?do_102(m)   hi stop
    pop  HL             ; 1:10      ?do_102(m)
    pop  DE             ; 1:10      ?do_102(m)
    jp    z, exit102    ; 3:10      ?do_102(m)
do102:                  ;           ?do_102(m)
    push DE             ; 1:11      j_101(m)   ( -- j )
    ex   DE, HL         ; 1:4       j_101(m)
    ld   HL, (idx101)   ; 3:16      j_101(m)   idx always points to a 16-bit index
    call PRT_S16        ; 3:17      .   ( s -- )
    push DE             ; 1:11      i_102(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_102(m)
    ld   HL, (idx102)   ; 3:16      i_102(m)   idx always points to a 16-bit index
    ld    A, '/'        ; 2:7       '/' emit   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit   putchar(reg A) with ZX 48K ROM
    call PRT_S16        ; 3:17      .   ( s -- )
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
idx102 EQU $+1          ;[20:78/57] loop_102(m)
    ld   BC, 0x0000     ; 3:10      loop_102(m)   idx always points to a 16-bit index
    inc  BC             ; 1:6       loop_102(m)   index++
    ld  (idx102), BC    ; 4:20      loop_102(m)   save index
    ld    A, C          ; 1:4       loop_102(m)   lo new index
stp_lo102 EQU $+1       ;           loop_102(m)
    xor  0x00           ; 2:7       loop_102(m)   lo stop
    jp   nz, do102      ; 3:10      loop_102(m)
    ld    A, B          ; 1:4       loop_102(m)   hi new index
stp_hi102 EQU $+1       ;           loop_102(m)
    xor  0x00           ; 2:7       loop_102(m)   hi stop
    jp   nz, do102      ; 3:10      loop_102(m)
leave102:               ;           loop_102(m)
exit102:                ;           loop_102(m)
                        ;[12:45]    loop_101   variant +1.B: 0 <= index < stop <= 256, run 4x
idx101 EQU $+1          ;           loop_101   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_101   0.. +1 ..(4), real_stop:0x0004
    nop                 ; 1:4       loop_101   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_101   index++
    ld  (idx101),A      ; 3:13      loop_101
    xor  0x04           ; 2:7       loop_101   lo(real_stop)
    jp   nz, do101      ; 3:10      loop_101   index-stop
leave101:               ;           loop_101
exit101:                ;           loop_101
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                        ;[7:40]     4 0 do_103(s)
    push DE             ; 1:11      4 0 do_103(s)   ( -- 4 0 )
    push HL             ; 1:11      4 0 do_103(s)
    ld   DE, 0x0004     ; 3:10      4 0 do_103(s)
    ld    L, D          ; 1:4       4 0 do_103(s)   L = D = 0x00
    ld    H, L          ; 1:4       4 0 do_103(s)   H = L = 0x00
do103:                  ;           4 0 do_103(s)   ( stop index -- stop index )
                        ;           i_103 0(s)   ( -- i 0 )
    push DE             ; 1:11      i_103 0(s)
    push HL             ; 1:11      i_103 0(s)
    ex   DE, HL         ; 1:4       i_103 0(s)
    ld   HL, 0          ; 3:10      i_103 0(s)
    or    A             ; 1:4       ?do_104(s)
    sbc  HL, DE         ; 2:15      ?do_104(s)
    add  HL, DE         ; 1:11      ?do_104(s)
    jp    z, leave104   ; 3:10      ?do_104(s)
do104:                  ;           ?do_104(s)   ( stop index -- stop index )
                        ;           j_103(s)   ( -- j )
                       ;[ 6:44]     j_103(s)   ( c b a -- c b a c )
    pop  BC             ; 1:10      j_103(s)
    push BC             ; 1:11      j_103(s)
    push DE             ; 1:11      j_103(s)
    ex   DE, HL         ; 1:4       j_103(s)
    ld    H, B          ; 1:4       j_103(s)
    ld    L, C          ; 1:4       j_103(s)
    call PRT_S16        ; 3:17      .   ( s -- )
                        ;           i_104(s)   ( -- i )
    push DE             ; 1:11      i_104(s)
    ld    D, H          ; 1:4       i_104(s)
    ld    E, L          ; 1:4       i_104(s)   ( a -- a a )
    ld    A, '/'        ; 2:7       '/' emit   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit   putchar(reg A) with ZX 48K ROM
    call PRT_S16        ; 3:17      .   ( s -- )
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
    inc  HL             ; 1:6       loop_104(s)   index++
    ld    A, L          ; 1:4       loop_104(s)
    xor   E             ; 1:4       loop_104(s)   lo(index - stop)
    jp   nz, do104      ; 3:10      loop_104(s)
    ld    A, H          ; 1:4       loop_104(s)
    xor   D             ; 1:4       loop_104(s)   hi(index - stop)
    jp   nz, do104      ; 3:10      loop_104(s)
leave104:               ;           loop_104(s)
    pop  HL             ; 1:10      unloop_104(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_104(s)
exit104:                ;           loop_104(s)
    inc  HL             ; 1:6       loop_103(s)   index++
    ld    A, L          ; 1:4       loop_103(s)
    xor   E             ; 1:4       loop_103(s)   lo(index - stop)
    jp   nz, do103      ; 3:10      loop_103(s)
    ld    A, H          ; 1:4       loop_103(s)
    xor   D             ; 1:4       loop_103(s)   hi(index - stop)
    jp   nz, do103      ; 3:10      loop_103(s)
leave103:               ;           loop_103(s)
    pop  HL             ; 1:10      unloop_103(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_103(s)
exit103:                ;           loop_103(s)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, 0          ; 3:10      do_105(xm)
do105save:              ;           do_105(xm)
    ld  (idx105),BC     ; 4:20      do_105(xm)
do105:                  ;           do_105(xm)
    push DE             ; 1:11      i_105 0   ( -- i 0 )
    push HL             ; 1:11      i_105 0
    ld   DE, (idx105)   ; 4:20      i_105 0   idx always points to a 16-bit index
    ld   HL, 0          ; 3:10      i_105 0
    or    A             ; 1:4       ?do_106(s)
    sbc  HL, DE         ; 2:15      ?do_106(s)
    add  HL, DE         ; 1:11      ?do_106(s)
    jp    z, leave106   ; 3:10      ?do_106(s)
do106:                  ;           ?do_106(s)   ( stop index -- stop index )
    push DE             ; 1:11      j_105(m)   ( -- j )
    ex   DE, HL         ; 1:4       j_105(m)
    ld   HL, (idx105)   ; 3:16      j_105(m)   idx always points to a 16-bit index
    call PRT_S16        ; 3:17      .   ( s -- )
                        ;           i_106(s)   ( -- i )
    push DE             ; 1:11      i_106(s)
    ld    D, H          ; 1:4       i_106(s)
    ld    E, L          ; 1:4       i_106(s)   ( a -- a a )
    ld    A, '/'        ; 2:7       '/' emit   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit   putchar(reg A) with ZX 48K ROM
    call PRT_S16        ; 3:17      .   ( s -- )
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
    inc  HL             ; 1:6       loop_106(s)   index++
    ld    A, L          ; 1:4       loop_106(s)
    xor   E             ; 1:4       loop_106(s)   lo(index - stop)
    jp   nz, do106      ; 3:10      loop_106(s)
    ld    A, H          ; 1:4       loop_106(s)
    xor   D             ; 1:4       loop_106(s)   hi(index - stop)
    jp   nz, do106      ; 3:10      loop_106(s)
leave106:               ;           loop_106(s)
    pop  HL             ; 1:10      unloop_106(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_106(s)
exit106:                ;           loop_106(s)
                        ;[12:45]    loop_105   variant +1.B: 0 <= index < stop <= 256, run 4x
idx105 EQU $+1          ;           loop_105   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_105   0.. +1 ..(4), real_stop:0x0004
    nop                 ; 1:4       loop_105   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_105   index++
    ld  (idx105),A      ; 3:13      loop_105
    xor  0x04           ; 2:7       loop_105   lo(real_stop)
    jp   nz, do105      ; 3:10      loop_105   index-stop
leave105:               ;           loop_105
exit105:                ;           loop_105
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                        ;[7:40]     3 0 do_107(s)
    push DE             ; 1:11      3 0 do_107(s)   ( -- 3 0 )
    push HL             ; 1:11      3 0 do_107(s)
    ld   DE, 0x0003     ; 3:10      3 0 do_107(s)
    ld    L, D          ; 1:4       3 0 do_107(s)   L = D = 0x00
    ld    H, L          ; 1:4       3 0 do_107(s)   H = L = 0x00
do107:                  ;           3 0 do_107(s)   ( stop index -- stop index )
                        ;           i_107(s)   ( -- i )
    push DE             ; 1:11      i_107(s)
    ld    D, H          ; 1:4       i_107(s)
    ld    E, L          ; 1:4       i_107(s)   ( a -- a a )
    ld    B, H          ; 1:4       for_108   ( i -- )
    ld    C, L          ; 1:4       for_108
    ex   DE, HL         ; 1:4       for_108
    pop  DE             ; 1:10      for_108   index
for108:                 ;           for_108
    ld  (idx108),BC     ; 4:20      for_108   save index
                        ;           j_107(s)   ( -- j )
    push DE             ; 1:11      j_107(s)
    ld    D, H          ; 1:4       j_107(s)
    ld    E, L          ; 1:4       j_107(s)   ( a -- a a )
    call PRT_S16        ; 3:17      .   ( s -- )
    push DE             ; 1:11      i_108(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_108(m)
    ld   HL, (idx108)   ; 3:16      i_108(m)   idx always points to a 16-bit index
    ld    A, '/'        ; 2:7       '/' emit   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit   putchar(reg A) with ZX 48K ROM
    call PRT_S16        ; 3:17      .   ( s -- )
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
idx108 EQU $+1          ;           next_108
    ld   BC, 0x0000     ; 3:10      next_108   idx always points to a 16-bit index
    ld    A, B          ; 1:4       next_108
    or    C             ; 1:4       next_108
    dec  BC             ; 1:6       next_108   index--, zero flag unaffected
    jp   nz, for108     ; 3:10      next_108
leave108:               ;           next_108
    inc  HL             ; 1:6       loop_107(s)   index++
    ld    A, L          ; 1:4       loop_107(s)
    xor   E             ; 1:4       loop_107(s)   lo(index - stop)
    jp   nz, do107      ; 3:10      loop_107(s)
    ld    A, H          ; 1:4       loop_107(s)
    xor   D             ; 1:4       loop_107(s)   hi(index - stop)
    jp   nz, do107      ; 3:10      loop_107(s)
leave107:               ;           loop_107(s)
    pop  HL             ; 1:10      unloop_107(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_107(s)
exit107:                ;           loop_107(s)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, 0          ; 3:10      3 0 do_109(xm)
do109save:              ;           3 0 do_109(xm)
    ld  (idx109),BC     ; 4:20      3 0 do_109(xm)
do109:                  ;           3 0 do_109(xm)
    push DE             ; 1:11      i_109(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_109(m)
    ld   HL, (idx109)   ; 3:16      i_109(m)   idx always points to a 16-bit index
    ld    B, H          ; 1:4       for_110   ( i -- )
    ld    C, L          ; 1:4       for_110
    ex   DE, HL         ; 1:4       for_110
    pop  DE             ; 1:10      for_110   index
for110:                 ;           for_110
    ld  (idx110),BC     ; 4:20      for_110   save index
    push DE             ; 1:11      j_109(m)   ( -- j )
    ex   DE, HL         ; 1:4       j_109(m)
    ld   HL, (idx109)   ; 3:16      j_109(m)   idx always points to a 16-bit index
    call PRT_S16        ; 3:17      .   ( s -- )
    push DE             ; 1:11      i_110(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_110(m)
    ld   HL, (idx110)   ; 3:16      i_110(m)   idx always points to a 16-bit index
    ld    A, '/'        ; 2:7       '/' emit   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      '/' emit   putchar(reg A) with ZX 48K ROM
    call PRT_S16        ; 3:17      .   ( s -- )
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
idx110 EQU $+1          ;           next_110
    ld   BC, 0x0000     ; 3:10      next_110   idx always points to a 16-bit index
    ld    A, B          ; 1:4       next_110
    or    C             ; 1:4       next_110
    dec  BC             ; 1:6       next_110   index--, zero flag unaffected
    jp   nz, for110     ; 3:10      next_110
leave110:               ;           next_110
                        ;[12:45]    loop_109   variant +1.B: 0 <= index < stop <= 256, run 3x
idx109 EQU $+1          ;           loop_109   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_109   0.. +1 ..(3), real_stop:0x0003
    nop                 ; 1:4       loop_109   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_109   index++
    ld  (idx109),A      ; 3:13      loop_109
    xor  0x03           ; 2:7       loop_109   lo(real_stop)
    jp   nz, do109      ; 3:10      loop_109   index-stop
leave109:               ;           loop_109
exit109:                ;           loop_109
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    push DE             ; 1:11      5
    ex   DE, HL         ; 1:4       5
    ld   HL, 5          ; 3:10      5
for111:                 ;           for_111(s) ( index -- index )
                        ;           i_111(s)   ( -- i )
    push DE             ; 1:11      i_111(s)
    ld    D, H          ; 1:4       i_111(s)
    ld    E, L          ; 1:4       i_111(s)   ( a -- a a )
    call PRT_S16        ; 3:17      .   ( s -- )
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
    ld   A, H           ; 1:4       next_111(s)
    or   L              ; 1:4       next_111(s)
    dec  HL             ; 1:6       next_111(s)   index--
    jp  nz, for111      ; 3:10      next_111(s)
leave111:               ;           next_111(s)
    ex   DE, HL         ; 1:4       unloop_111(s)   ( i -- )
    pop  DE             ; 1:10      unloop_111(s)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld    A, 5          ; 2:7       5 for_112 i_112   ( -- )
for112:                 ;           5 for_112 i_112
    ld  (idx112),A      ; 3:13      5 for_112 i_112   save index
    push DE             ; 1:11      5 for_112 i_112
    ex   DE, HL         ; 1:4       5 for_112 i_112
    ld    L, A          ; 1:4       5 for_112 i_112
    ld    H, 0x00       ; 2:7       5 for_112 i_112   copy index
    call PRT_S16        ; 3:17      .   ( s -- )
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
idx112 EQU $+1          ;           next_112
    ld    A, 0x00       ; 2:7       next_112   idx always points to a 16-bit index
    nop                 ; 1:4       next_112
    sub  0x01           ; 2:7       next_112   index--
    jp   nc, for112     ; 3:10      next_112
leave112:               ;           next_112
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    push DE             ; 1:11      5
    ex   DE, HL         ; 1:4       5
    ld   HL, 5          ; 3:10      5
begin101:               ;           begin 101
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    ld    A, H          ; 1:4       dup_while 101
    or    L             ; 1:4       dup_while 101
    jp    z, break101   ; 3:10      dup_while 101
    dec  HL             ; 1:6       1-
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    push DE             ; 1:11      0
    ex   DE, HL         ; 1:4       0
    ld   HL, 0          ; 3:10      0
begin102:               ;           begin 102
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    push DE             ; 1:11      dup 4
    push HL             ; 1:11      dup 4
    ex   DE, HL         ; 1:4       dup 4
    ld   HL, 4          ; 3:10      dup 4
                       ;[12:54]     <   ( x2 x1 -- flag x2<x1 )
    ld    A, E          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       <   carry --> sign
    xor   H             ; 1:4       <
    xor   D             ; 1:4       <
    add   A, A          ; 1:4       <   sign --> carry
    sbc   A, A          ; 1:4       <   0x00 or 0xff
    ld    H, A          ; 1:4       <
    ld    L, A          ; 1:4       <
    pop  DE             ; 1:10      <
    ld    A, H          ; 1:4       while 102
    or    L             ; 1:4       while 102
    ex   DE, HL         ; 1:4       while 102
    pop  DE             ; 1:10      while 102
    jp    z, break102   ; 3:10      while 102
    inc  HL             ; 1:6       1+
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
    jp   begin102       ; 3:10      repeat 102
break102:               ;           repeat 102
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    push DE             ; 1:11      0
    ex   DE, HL         ; 1:4       0
    ld   HL, 0          ; 3:10      0
begin103:               ;           begin 103
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    push DE             ; 1:11      dup 4
    push HL             ; 1:11      dup 4
    ex   DE, HL         ; 1:4       dup 4
    ld   HL, 4          ; 3:10      dup 4
                       ;[12:54]     <   ( x2 x1 -- flag x2<x1 )
    ld    A, E          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sub   L             ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    ld    A, D          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    sbc   A, H          ; 1:4       <   DE<HL --> DE-HL<0 --> carry if true
    rra                 ; 1:4       <   carry --> sign
    xor   H             ; 1:4       <
    xor   D             ; 1:4       <
    add   A, A          ; 1:4       <   sign --> carry
    sbc   A, A          ; 1:4       <   0x00 or 0xff
    ld    H, A          ; 1:4       <
    ld    L, A          ; 1:4       <
    pop  DE             ; 1:10      <
    ld    A, H          ; 1:4       while 103
    or    L             ; 1:4       while 103
    ex   DE, HL         ; 1:4       while 103
    pop  DE             ; 1:10      while 103
    jp    z, break103   ; 3:10      while 103
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+
    ld    A, ','        ; 2:7       putchar(',')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(',')   putchar(reg A) with ZX 48K ROM
    jp   begin103       ; 3:10      repeat 103
break103:               ;           repeat 103
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop   ( a -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    push DE             ; 1:11      print     "Exit:"
    ld   BC, size101    ; 3:10      print     Length of string101
    ld   DE, string101  ; 3:10      print     Address of string101
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    ld   BC, 0          ; 3:10      0 0 do_113(xm)
do113save:              ;           0 0 do_113(xm)
    ld  (idx113),BC     ; 4:20      0 0 do_113(xm)
do113:                  ;           0 0 do_113(xm)
    ld    A, 'a'        ; 2:7       putchar('a')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('a')   putchar(reg A) with ZX 48K ROM
    jp   leave113       ; 3:10      leave_113(m)
                        ;[9:54/34]  loop_113   variant +1.G: stop == 0, run 65536x
idx113 EQU $+1          ;           loop_113   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_113   0.. +1 ..(0), real_stop:0x0000
    inc  BC             ; 1:6       loop_113   index++
    ld    A, B          ; 1:4       loop_113
    or    C             ; 1:4       loop_113
    jp   nz, do113save  ; 3:10      loop_113
leave113:               ;           loop_113
exit113:                ;           loop_113
    ld   BC, 1          ; 3:10      0 1 do_114(xm)
do114save:              ;           0 1 do_114(xm)
    ld  (idx114),BC     ; 4:20      0 1 do_114(xm)
do114:                  ;           0 1 do_114(xm)
    ld    A, 'b'        ; 2:7       putchar('b')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('b')   putchar(reg A) with ZX 48K ROM
    jp   leave114       ; 3:10      leave_114(m)
                        ;[9:54/34]  loop_114   variant +1.G: stop == 0, run 65535x
idx114 EQU $+1          ;           loop_114   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_114   1.. +1 ..(0), real_stop:0x0000
    inc  BC             ; 1:6       loop_114   index++
    ld    A, B          ; 1:4       loop_114
    or    C             ; 1:4       loop_114
    jp   nz, do114save  ; 3:10      loop_114
leave114:               ;           loop_114
exit114:                ;           loop_114
    ld   BC, 0          ; 3:10      do_115(xm)
do115save:              ;           do_115(xm)
    ld  (idx115),BC     ; 4:20      do_115(xm)
do115:                  ;           do_115(xm)
    ld    A, 'c'        ; 2:7       putchar('c')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('c')   putchar(reg A) with ZX 48K ROM
    jp   leave115       ; 3:10      leave_115(m)
                        ;[9:54/34]  loop_115   variant +1.G: stop == 0, run 65536x
idx115 EQU $+1          ;           loop_115   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_115   0.. +1 ..(0), real_stop:0x0000
    inc  BC             ; 1:6       loop_115   index++
    ld    A, B          ; 1:4       loop_115
    or    C             ; 1:4       loop_115
    jp   nz, do115save  ; 3:10      loop_115
leave115:               ;           loop_115
exit115:                ;           loop_115
    ld   BC, 254        ; 3:10      do_116(xm)
do116save:              ;           do_116(xm)
    ld  (idx116),BC     ; 4:20      do_116(xm)
do116:                  ;           do_116(xm)
    ld    A, 'd'        ; 2:7       putchar('d')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('d')   putchar(reg A) with ZX 48K ROM
    jp   leave116       ; 3:10      leave_116(m)
                        ;[16:57/58] loop_116   variant +1.default: step one, run 65536x
idx116 EQU $+1          ;           loop_116   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_116   254.. +1 ..(254), real_stop:0x00FE
    inc  BC             ; 1:6       loop_116   index++
    ld    A, B          ; 1:4       loop_116
    xor  0x00           ; 2:7       loop_116   hi(real_stop) first (255<=255)
    jp   nz, do116save  ; 3:10      loop_116   255x false positive
    ld    A, C          ; 1:4       loop_116
    xor  0xFE           ; 2:7       loop_116   lo(real_stop)
    jp   nz, do116save  ; 3:10      loop_116   255x false positive if he was first
leave116:               ;           loop_116
exit116:                ;           loop_116
    ld   BC, 255        ; 3:10      do_117(xm)
do117save:              ;           do_117(xm)
    ld  (idx117),BC     ; 4:20      do_117(xm)
do117:                  ;           do_117(xm)
    ld    A, 'e'        ; 2:7       putchar('e')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('e')   putchar(reg A) with ZX 48K ROM
    jp   leave117       ; 3:10      leave_117(m)
                        ;[16:57/58] loop_117   variant +1.default: step one, run 65536x
idx117 EQU $+1          ;           loop_117   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_117   255.. +1 ..(255), real_stop:0x00FF
    inc  BC             ; 1:6       loop_117   index++
    ld    A, B          ; 1:4       loop_117
    xor  0x00           ; 2:7       loop_117   hi(real_stop) first (255<=255)
    jp   nz, do117save  ; 3:10      loop_117   255x false positive
    ld    A, C          ; 1:4       loop_117
    xor  0xFF           ; 2:7       loop_117   lo(real_stop)
    jp   nz, do117save  ; 3:10      loop_117   255x false positive if he was first
leave117:               ;           loop_117
exit117:                ;           loop_117
    ld   BC, 256        ; 3:10      do_118(xm)
do118save:              ;           do_118(xm)
    ld  (idx118),BC     ; 4:20      do_118(xm)
do118:                  ;           do_118(xm)
    ld    A, 'f'        ; 2:7       putchar('f')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('f')   putchar(reg A) with ZX 48K ROM
    jp   leave118       ; 3:10      leave_118(m)
                        ;[16:57/58] loop_118   variant +1.default: step one, run 65536x
idx118 EQU $+1          ;           loop_118   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_118   256.. +1 ..(256), real_stop:0x0100
    inc  BC             ; 1:6       loop_118   index++
    ld    A, B          ; 1:4       loop_118
    xor  0x01           ; 2:7       loop_118   hi(real_stop) first (255<=255)
    jp   nz, do118save  ; 3:10      loop_118   255x false positive
    ld    A, C          ; 1:4       loop_118
    xor  0x00           ; 2:7       loop_118   lo(real_stop)
    jp   nz, do118save  ; 3:10      loop_118   255x false positive if he was first
leave118:               ;           loop_118
exit118:                ;           loop_118
    push DE             ; 1:11      0 0 do_119(s)
    ex   DE, HL         ; 1:4       0 0 do_119(s)
    ld   HL, 0          ; 3:10      0 0 do_119(s)
do119:                  ;           0 0 do_119(s)   ( stop index -- index )  stop = 0
    ld    A, 'g'        ; 2:7       putchar('g')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('g')   putchar(reg A) with ZX 48K ROM
    jp   leave119       ; 3:10      leave_119(s)
    inc  HL             ; 1:6       loop_119(s)   index++
    ld    A, L          ; 1:4       loop_119(s)
    or    H             ; 1:4       loop_119(s)
    jp   nz, do119      ; 3:10      loop_119(s)
leave119:               ;           loop_119(s)
    ex   DE, HL         ; 1:4       unloop_119(s)   ( i -- )
    pop  DE             ; 1:10      unloop_119(s)
exit119:                ;           loop_119(s)
                        ;[7:40]     254 254 do_120(s)
    push DE             ; 1:11      254 254 do_120(s)   ( -- 254 254 )
    push HL             ; 1:11      254 254 do_120(s)
    ld   DE, 0x00FE     ; 3:10      254 254 do_120(s)
    ld    L, E          ; 1:4       254 254 do_120(s)   L = E = 0xFE
    ld    H, D          ; 1:4       254 254 do_120(s)   H = D = 0x00
do120:                  ;           254 254 do_120(s)   ( stop index -- stop index )
    ld    A, 'h'        ; 2:7       putchar('h')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('h')   putchar(reg A) with ZX 48K ROM
    jp   leave120       ; 3:10      leave_120(s)
    inc  HL             ; 1:6       loop_120(s)   index++
    ld    A, L          ; 1:4       loop_120(s)
    xor   E             ; 1:4       loop_120(s)   lo(index - stop)
    jp   nz, do120      ; 3:10      loop_120(s)
    ld    A, H          ; 1:4       loop_120(s)
    xor   D             ; 1:4       loop_120(s)   hi(index - stop)
    jp   nz, do120      ; 3:10      loop_120(s)
leave120:               ;           loop_120(s)
    pop  HL             ; 1:10      unloop_120(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_120(s)
exit120:                ;           loop_120(s)
                        ;[7:40]     255 255 do_121(s)
    push DE             ; 1:11      255 255 do_121(s)   ( -- 255 255 )
    push HL             ; 1:11      255 255 do_121(s)
    ld   DE, 0x00FF     ; 3:10      255 255 do_121(s)
    ld    L, E          ; 1:4       255 255 do_121(s)   L = E = 0xFF
    ld    H, D          ; 1:4       255 255 do_121(s)   H = D = 0x00
do121:                  ;           255 255 do_121(s)   ( stop index -- stop index )
    ld    A, 'i'        ; 2:7       putchar('i')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('i')   putchar(reg A) with ZX 48K ROM
    jp   leave121       ; 3:10      leave_121(s)
    inc  HL             ; 1:6       loop_121(s)   index++
    ld    A, L          ; 1:4       loop_121(s)
    xor   E             ; 1:4       loop_121(s)   lo(index - stop)
    jp   nz, do121      ; 3:10      loop_121(s)
    ld    A, H          ; 1:4       loop_121(s)
    xor   D             ; 1:4       loop_121(s)   hi(index - stop)
    jp   nz, do121      ; 3:10      loop_121(s)
leave121:               ;           loop_121(s)
    pop  HL             ; 1:10      unloop_121(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_121(s)
exit121:                ;           loop_121(s)
                        ;[7:40]     256 256 do_122(s)
    push DE             ; 1:11      256 256 do_122(s)   ( -- 256 256 )
    push HL             ; 1:11      256 256 do_122(s)
    ld   DE, 0x0100     ; 3:10      256 256 do_122(s)
    ld    L, E          ; 1:4       256 256 do_122(s)   L = E = 0x00
    ld    H, D          ; 1:4       256 256 do_122(s)   H = D = 0x01
do122:                  ;           256 256 do_122(s)   ( stop index -- stop index )
    ld    A, 'j'        ; 2:7       putchar('j')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('j')   putchar(reg A) with ZX 48K ROM
    jp   leave122       ; 3:10      leave_122(s)
    inc  HL             ; 1:6       loop_122(s)   index++
    ld    A, L          ; 1:4       loop_122(s)
    xor   E             ; 1:4       loop_122(s)   lo(index - stop)
    jp   nz, do122      ; 3:10      loop_122(s)
    ld    A, H          ; 1:4       loop_122(s)
    xor   D             ; 1:4       loop_122(s)   hi(index - stop)
    jp   nz, do122      ; 3:10      loop_122(s)
leave122:               ;           loop_122(s)
    pop  HL             ; 1:10      unloop_122(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_122(s)
exit122:                ;           loop_122(s)
    ld   BC, 60000      ; 3:10      do_123(xm)
do123save:              ;           do_123(xm)
    ld  (idx123),BC     ; 4:20      do_123(xm)
do123:                  ;           do_123(xm)
    ld    A, 'k'        ; 2:7       putchar('k')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('k')   putchar(reg A) with ZX 48K ROM
    jp   leave123       ; 3:10      leave_123(m)
                        ;[21:74/75] 5000 +loop_123(xm)   variant +X.I: positive step 3..255, hi(real_stop) has fewer duplicate,run 14x
idx123 EQU $+1          ;           5000 +loop_123(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      5000 +loop_123(xm)   60000.. +5000 ..(60000), real_stop:0xFBD0
    ld    A, C          ; 1:4       5000 +loop_123(xm)
    add   A, low 5000   ; 2:7       5000 +loop_123(xm)
    ld    C, A          ; 1:4       5000 +loop_123(xm)
    adc   A, B          ; 1:4       5000 +loop_123(xm)
    sub   C             ; 1:4       5000 +loop_123(xm)
    ld    B, A          ; 1:4       5000 +loop_123(xm)
    xor  0xFB           ; 2:7       5000 +loop_123(xm)   hi(real_stop) first (21*0<=4*14+21*0)
    jp   nz, do123save  ; 3:10      5000 +loop_123(xm)   0x false positive
    ld    A, C          ; 1:4       5000 +loop_123(xm)
    xor  0xD0           ; 2:7       5000 +loop_123(xm)   lo(real_stop)
    jp   nz, do123save  ; 3:10      5000 +loop_123(xm)   0x false positive if he was first
leave123:               ;           5000 +loop_123(xm)
exit123:                ;           5000 +loop_123(xm)
    ld   BC, 60000      ; 3:10      do_124(xm)
do124save:              ;           do_124(xm)
    ld  (idx124),BC     ; 4:20      do_124(xm)
do124:                  ;           do_124(xm)
    ld    A, 'l'        ; 2:7       putchar('l')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('l')   putchar(reg A) with ZX 48K ROM
    jp   leave124       ; 3:10      leave_124(m)
                        ;[21:74/75] 3100 +loop_124(xm)   variant +X.I: positive step 3..255, hi(real_stop) has fewer duplicate,run 22x
idx124 EQU $+1          ;           3100 +loop_124(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      3100 +loop_124(xm)   60000.. +3100 ..(60000), real_stop:0xF4C8
    ld    A, C          ; 1:4       3100 +loop_124(xm)
    add   A, low 3100   ; 2:7       3100 +loop_124(xm)
    ld    C, A          ; 1:4       3100 +loop_124(xm)
    adc   A, B          ; 1:4       3100 +loop_124(xm)
    sub   C             ; 1:4       3100 +loop_124(xm)
    ld    B, A          ; 1:4       3100 +loop_124(xm)
    xor  0xF4           ; 2:7       3100 +loop_124(xm)   hi(real_stop) first (21*0<=4*22+21*0)
    jp   nz, do124save  ; 3:10      3100 +loop_124(xm)   0x false positive
    ld    A, C          ; 1:4       3100 +loop_124(xm)
    xor  0xC8           ; 2:7       3100 +loop_124(xm)   lo(real_stop)
    jp   nz, do124save  ; 3:10      3100 +loop_124(xm)   0x false positive if he was first
leave124:               ;           3100 +loop_124(xm)
exit124:                ;           3100 +loop_124(xm)
    push DE             ; 1:11      print     0xD, "Leave >= 7", 0xD
    ld   BC, size102    ; 3:10      print     Length of string102
    ld   DE, string102  ; 3:10      print     Address of string102
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    ld   BC, 3          ; 3:10      12 3 do_125(xm)
do125save:              ;           12 3 do_125(xm)
    ld  (idx125),BC     ; 4:20      12 3 do_125(xm)
do125:                  ;           12 3 do_125(xm)
    push DE             ; 1:11      i_125(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_125(m)
    ld   HL, (idx125)   ; 3:16      i_125(m)   idx always points to a 16-bit index
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1
    push DE             ; 1:11      7
    ex   DE, HL         ; 1:4       7
    ld   HL, 7          ; 3:10      7
                       ;[13:57]     >=   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       >=   carry --> sign
    xor   H             ; 1:4       >=
    xor   D             ; 1:4       >=
    sub  0x80           ; 2:7       >=   sign --> invert carry
    sbc   A, A          ; 1:4       >=   0x00 or 0xff
    ld    H, A          ; 1:4       >=
    ld    L, A          ; 1:4       >=
    pop  DE             ; 1:10      >=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if
    jp   leave125       ; 3:10      leave_125(m)
else101  EQU $          ;           = endif
endif101:
                        ;[12:45]    loop_125   variant +1.B: 0 <= index < stop <= 256, run 9x
idx125 EQU $+1          ;           loop_125   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_125   3.. +1 ..(12), real_stop:0x000C
    nop                 ; 1:4       loop_125   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_125   index++
    ld  (idx125),A      ; 3:13      loop_125
    xor  0x0C           ; 2:7       loop_125   lo(real_stop)
    jp   nz, do125      ; 3:10      loop_125   index-stop
leave125:               ;           loop_125
exit125:                ;           loop_125
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
                        ;[8:42]     12 3 do_126(s)
    push DE             ; 1:11      12 3 do_126(s)   ( -- 12 3 )
    push HL             ; 1:11      12 3 do_126(s)
    ld   DE, 0x000C     ; 3:10      12 3 do_126(s)
    ld   HL, 0x0003     ; 3:10      12 3 do_126(s)
do126:                  ;           12 3 do_126(s)   ( stop index -- stop index )
                        ;           i_126(s)   ( -- i )
    push DE             ; 1:11      i_126(s)
    ld    D, H          ; 1:4       i_126(s)
    ld    E, L          ; 1:4       i_126(s)   ( a -- a a )
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1
    push DE             ; 1:11      7
    ex   DE, HL         ; 1:4       7
    ld   HL, 7          ; 3:10      7
                       ;[13:57]     >=   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       >=   carry --> sign
    xor   H             ; 1:4       >=
    xor   D             ; 1:4       >=
    sub  0x80           ; 2:7       >=   sign --> invert carry
    sbc   A, A          ; 1:4       >=   0x00 or 0xff
    ld    H, A          ; 1:4       >=
    ld    L, A          ; 1:4       >=
    pop  DE             ; 1:10      >=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else102    ; 3:10      if
    jp   leave126       ; 3:10      leave_126(s)
else102  EQU $          ;           = endif
endif102:
    inc  HL             ; 1:6       loop_126(s)   index++
    ld    A, L          ; 1:4       loop_126(s)
    xor   E             ; 1:4       loop_126(s)   lo(index - stop)
    jp   nz, do126      ; 3:10      loop_126(s)
    ld    A, H          ; 1:4       loop_126(s)
    xor   D             ; 1:4       loop_126(s)   hi(index - stop)
    jp   nz, do126      ; 3:10      loop_126(s)
leave126:               ;           loop_126(s)
    pop  HL             ; 1:10      unloop_126(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_126(s)
exit126:                ;           loop_126(s)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, 3          ; 3:10      do_127(xm)
do127save:              ;           do_127(xm)
    ld  (idx127),BC     ; 4:20      do_127(xm)
do127:                  ;           do_127(xm)
    push DE             ; 1:11      i_127(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_127(m)
    ld   HL, (idx127)   ; 3:16      i_127(m)   idx always points to a 16-bit index
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1
    push DE             ; 1:11      7
    ex   DE, HL         ; 1:4       7
    ld   HL, 7          ; 3:10      7
                       ;[13:57]     >=   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       >=   carry --> sign
    xor   H             ; 1:4       >=
    xor   D             ; 1:4       >=
    sub  0x80           ; 2:7       >=   sign --> invert carry
    sbc   A, A          ; 1:4       >=   0x00 or 0xff
    ld    H, A          ; 1:4       >=
    ld    L, A          ; 1:4       >=
    pop  DE             ; 1:10      >=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else103    ; 3:10      if
    jp   leave127       ; 3:10      leave_127(m)
else103  EQU $          ;           = endif
endif103:
                        ;[12:45]    loop_127   variant +1.B: 0 <= index < stop <= 256, run 9x
idx127 EQU $+1          ;           loop_127   idx always points to a 16-bit index
    ld    A, 0          ; 2:7       loop_127   3.. +1 ..(12), real_stop:0x000C
    nop                 ; 1:4       loop_127   hi(index) = 0 = nop -> idx always points to a 16-bit index.
    inc   A             ; 1:4       loop_127   index++
    ld  (idx127),A      ; 3:13      loop_127
    xor  0x0C           ; 2:7       loop_127   lo(real_stop)
    jp   nz, do127      ; 3:10      loop_127   index-stop
leave127:               ;           loop_127
exit127:                ;           loop_127
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, 3          ; 3:10      do_128(xm)
do128save:              ;           do_128(xm)
    ld  (idx128),BC     ; 4:20      do_128(xm)
do128:                  ;           do_128(xm)
    push DE             ; 1:11      i_128(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_128(m)
    ld   HL, (idx128)   ; 3:16      i_128(m)   idx always points to a 16-bit index
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1
    push DE             ; 1:11      7
    ex   DE, HL         ; 1:4       7
    ld   HL, 7          ; 3:10      7
                       ;[13:57]     >=   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       >=   carry --> sign
    xor   H             ; 1:4       >=
    xor   D             ; 1:4       >=
    sub  0x80           ; 2:7       >=   sign --> invert carry
    sbc   A, A          ; 1:4       >=   0x00 or 0xff
    ld    H, A          ; 1:4       >=
    ld    L, A          ; 1:4       >=
    pop  DE             ; 1:10      >=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else104    ; 3:10      if
    jp   leave128       ; 3:10      leave_128(m)
else104  EQU $          ;           = endif
endif104:
                        ;[16:57/58] loop_128   variant +1.default: step one, run 547x
idx128 EQU $+1          ;           loop_128   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      loop_128   3.. +1 ..(550), real_stop:0x0226
    inc  BC             ; 1:6       loop_128   index++
    ld    A, C          ; 1:4       loop_128
    xor  0x26           ; 2:7       loop_128   lo(real_stop) first (38>2)
    jp   nz, do128save  ; 3:10      loop_128   2x false positive
    ld    A, B          ; 1:4       loop_128
    xor  0x02           ; 2:7       loop_128   hi(real_stop)
    jp   nz, do128save  ; 3:10      loop_128   38x false positive if he was first
leave128:               ;           loop_128
exit128:                ;           loop_128
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, 3          ; 3:10      do_129(xm)
do129save:              ;           do_129(xm)
    ld  (idx129),BC     ; 4:20      do_129(xm)
do129:                  ;           do_129(xm)
    push DE             ; 1:11      i_129(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_129(m)
    ld   HL, (idx129)   ; 3:16      i_129(m)   idx always points to a 16-bit index
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1
    push DE             ; 1:11      7
    ex   DE, HL         ; 1:4       7
    ld   HL, 7          ; 3:10      7
                       ;[13:57]     >=   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       >=   carry --> sign
    xor   H             ; 1:4       >=
    xor   D             ; 1:4       >=
    sub  0x80           ; 2:7       >=   sign --> invert carry
    sbc   A, A          ; 1:4       >=   0x00 or 0xff
    ld    H, A          ; 1:4       >=
    ld    L, A          ; 1:4       >=
    pop  DE             ; 1:10      >=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else105    ; 3:10      if
    jp   leave129       ; 3:10      leave_129(m)
else105  EQU $          ;           = endif
endif105:
                        ;[11:61/41] 2 +loop_129(xm)   variant +2.C: step 2 with lo(real_stop) exclusivity, run 5x
idx129 EQU $+1          ;           2 +loop_129(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +loop_129(xm)   3.. +2 ..(12), real_stop:0x000D
    inc  BC             ; 1:6       2 +loop_129(xm)   index++
    inc   C             ; 1:4       2 +loop_129(xm)   index++
    ld    A, C          ; 1:4       2 +loop_129(xm)
    xor  0x0D           ; 2:7       2 +loop_129(xm)   lo(real_stop)
    jp   nz, do129save  ; 3:10      2 +loop_129(xm)
leave129:               ;           2 +loop_129(xm)
exit129:                ;           2 +loop_129(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld   BC, 3          ; 3:10      do_130(xm)
do130save:              ;           do_130(xm)
    ld  (idx130),BC     ; 4:20      do_130(xm)
do130:                  ;           do_130(xm)
    push DE             ; 1:11      i_130(m)   ( -- i )
    ex   DE, HL         ; 1:4       i_130(m)
    ld   HL, (idx130)   ; 3:16      i_130(m)   idx always points to a 16-bit index
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1
    push DE             ; 1:11      7
    ex   DE, HL         ; 1:4       7
    ld   HL, 7          ; 3:10      7
                       ;[13:57]     >=   ( x2 x1 -- flag x2>=x1 )
    ld    A, E          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sub   L             ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    ld    A, D          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    sbc   A, H          ; 1:4       >=   DE>=HL --> DE-HL>=0 --> no carry if true
    rra                 ; 1:4       >=   carry --> sign
    xor   H             ; 1:4       >=
    xor   D             ; 1:4       >=
    sub  0x80           ; 2:7       >=   sign --> invert carry
    sbc   A, A          ; 1:4       >=   0x00 or 0xff
    ld    H, A          ; 1:4       >=
    ld    L, A          ; 1:4       >=
    pop  DE             ; 1:10      >=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else106    ; 3:10      if
    jp   leave130       ; 3:10      leave_130(m)
else106  EQU $          ;           = endif
endif106:
                        ;[17:61/62] 2 +loop_130(xm)   variant +2.defaultB: positive step 2, run 274x
idx130 EQU $+1          ;           2 +loop_130(xm)   idx always points to a 16-bit index
    ld   BC, 0x0000     ; 3:10      2 +loop_130(xm)   3.. +2 ..(550), real_stop:0x0227
    inc  BC             ; 1:6       2 +loop_130(xm)   index++
    inc   C             ; 1:4       2 +loop_130(xm)   index++
    ld    A, C          ; 1:4       2 +loop_130(xm)
    xor  0x27           ; 2:7       2 +loop_130(xm)   lo(real_stop) first (19>2)
    jp   nz, do130save  ; 3:10      2 +loop_130(xm)   2x false positive
    ld    A, B          ; 1:4       2 +loop_130(xm)
    xor  0x02           ; 2:7       2 +loop_130(xm)   hi(real_stop)
    jp   nz, do130save  ; 3:10      2 +loop_130(xm)   19x false positive if he was first
leave130:               ;           2 +loop_130(xm)
exit130:                ;           2 +loop_130(xm)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    ld    A, 12         ; 2:7       12 for_131 i_131   ( -- )
for131:                 ;           12 for_131 i_131
    ld  (idx131),A      ; 3:13      12 for_131 i_131   save index
    push DE             ; 1:11      12 for_131 i_131
    ex   DE, HL         ; 1:4       12 for_131 i_131
    ld    L, A          ; 1:4       12 for_131 i_131
    ld    H, 0x00       ; 2:7       12 for_131 i_131   copy index
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1
    push DE             ; 1:11      7
    ex   DE, HL         ; 1:4       7
    ld   HL, 7          ; 3:10      7
                       ;[13:57]     <=   ( x2 x1 -- flag x2<=x1 )
    ld    A, L          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sub   E             ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    ld    A, H          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sbc   A, D          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    rra                 ; 1:4       <=   carry --> sign
    xor   H             ; 1:4       <=
    xor   D             ; 1:4       <=
    sub  0x80           ; 2:7       <=   sign --> invert carry
    sbc   A, A          ; 1:4       <=   0x00 or 0xff
    ld    H, A          ; 1:4       <=
    ld    L, A          ; 1:4       <=
    pop  DE             ; 1:10      <=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else107    ; 3:10      if
    jp   leave131       ; 3:10      leave_131(m)
else107  EQU $          ;           = endif
endif107:
idx131 EQU $+1          ;           next_131
    ld    A, 0x00       ; 2:7       next_131   idx always points to a 16-bit index
    nop                 ; 1:4       next_131
    sub  0x01           ; 2:7       next_131   index--
    jp   nc, for131     ; 3:10      next_131
leave131:               ;           next_131
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    push DE             ; 1:11      12
    ex   DE, HL         ; 1:4       12
    ld   HL, 12         ; 3:10      12
for132:                 ;           for_132(s) ( index -- index )
                        ;           i_132(s)   ( -- i )
    push DE             ; 1:11      i_132(s)
    ld    D, H          ; 1:4       i_132(s)
    ld    E, L          ; 1:4       i_132(s)   ( a -- a a )
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1
    push DE             ; 1:11      7
    ex   DE, HL         ; 1:4       7
    ld   HL, 7          ; 3:10      7
                       ;[13:57]     <=   ( x2 x1 -- flag x2<=x1 )
    ld    A, L          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sub   E             ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    ld    A, H          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    sbc   A, D          ; 1:4       <=   DE<=HL --> 0<=HL-DE --> no carry if true
    rra                 ; 1:4       <=   carry --> sign
    xor   H             ; 1:4       <=
    xor   D             ; 1:4       <=
    sub  0x80           ; 2:7       <=   sign --> invert carry
    sbc   A, A          ; 1:4       <=   0x00 or 0xff
    ld    H, A          ; 1:4       <=
    ld    L, A          ; 1:4       <=
    pop  DE             ; 1:10      <=
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else108    ; 3:10      if
    jp   leave132       ; 3:10      leave_132(s)
else108  EQU $          ;           = endif
endif108:
    ld   A, H           ; 1:4       next_132(s)
    or   L              ; 1:4       next_132(s)
    dec  HL             ; 1:6       next_132(s)   index--
    jp  nz, for132      ; 3:10      next_132(s)
leave132:               ;           next_132(s)
    ex   DE, HL         ; 1:4       unloop_132(s)   ( i -- )
    pop  DE             ; 1:10      unloop_132(s)
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
    push DE             ; 1:11      print     "Once:"
    ld   BC, size103    ; 3:10      print     Length of string103
    ld   DE, string103  ; 3:10      print     Address of string103
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    ld   BC, 0          ; 3:10      1 0 do_133(xm)
do133save:              ;           1 0 do_133(xm)
    ld  (idx133),BC     ; 4:20      1 0 do_133(xm)
do133:                  ;           1 0 do_133(xm)
    ld    A, 'a'        ; 2:7       putchar('a')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('a')   putchar(reg A) with ZX 48K ROM
idx133 EQU do133save-2  ;           loop_133   variant +1.null: positive step and no repeat
leave133:               ;           loop_133
exit133:                ;           loop_133
    ld   BC, 254        ; 3:10      255 254 do_134(xm)
do134save:              ;           255 254 do_134(xm)
    ld  (idx134),BC     ; 4:20      255 254 do_134(xm)
do134:                  ;           255 254 do_134(xm)
    ld    A, 'b'        ; 2:7       putchar('b')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('b')   putchar(reg A) with ZX 48K ROM
idx134 EQU do134save-2  ;           loop_134   variant +1.null: positive step and no repeat
leave134:               ;           loop_134
exit134:                ;           loop_134
    ld   BC, 0          ; 3:10      do_135(xm)
do135save:              ;           do_135(xm)
    ld  (idx135),BC     ; 4:20      do_135(xm)
do135:                  ;           do_135(xm)
    ld    A, 'c'        ; 2:7       putchar('c')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('c')   putchar(reg A) with ZX 48K ROM
idx135 EQU do135save-2  ;           loop_135   variant +1.null: positive step and no repeat
leave135:               ;           loop_135
exit135:                ;           loop_135
    ld   BC, 254        ; 3:10      do_136(xm)
do136save:              ;           do_136(xm)
    ld  (idx136),BC     ; 4:20      do_136(xm)
do136:                  ;           do_136(xm)
    ld    A, 'd'        ; 2:7       putchar('d')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('d')   putchar(reg A) with ZX 48K ROM
idx136 EQU do136save-2  ;           loop_136   variant +1.null: positive step and no repeat
leave136:               ;           loop_136
exit136:                ;           loop_136
    ld   BC, 255        ; 3:10      do_137(xm)
do137save:              ;           do_137(xm)
    ld  (idx137),BC     ; 4:20      do_137(xm)
do137:                  ;           do_137(xm)
    ld    A, 'e'        ; 2:7       putchar('e')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('e')   putchar(reg A) with ZX 48K ROM
idx137 EQU do137save-2  ;           loop_137   variant +1.null: positive step and no repeat
leave137:               ;           loop_137
exit137:                ;           loop_137
    ld   BC, 256        ; 3:10      do_138(xm)
do138save:              ;           do_138(xm)
    ld  (idx138),BC     ; 4:20      do_138(xm)
do138:                  ;           do_138(xm)
    ld    A, 'f'        ; 2:7       putchar('f')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('f')   putchar(reg A) with ZX 48K ROM
idx138 EQU do138save-2  ;           loop_138   variant +1.null: positive step and no repeat
leave138:               ;           loop_138
exit138:                ;           loop_138
    push DE             ; 1:11      1 0 do_139(s)
    ex   DE, HL         ; 1:4       1 0 do_139(s)
    ld   HL, 0          ; 3:10      1 0 do_139(s)
do139:                  ;           1 0 do_139(s)   ( stop index -- index )  stop = 1
    ld    A, 'g'        ; 2:7       putchar('g')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('g')   putchar(reg A) with ZX 48K ROM
    ld    A, L          ; 1:4       loop_139(s)
    or    H             ; 1:4       loop_139(s)
    inc  HL             ; 1:6       loop_139(s)   index++
    jp   nz, do139      ; 3:10      loop_139(s)
leave139:               ;           loop_139(s)
    ex   DE, HL         ; 1:4       unloop_139(s)   ( i -- )
    pop  DE             ; 1:10      unloop_139(s)
exit139:                ;           loop_139(s)
                        ;[8:42]     255 254 do_140(s)
    push DE             ; 1:11      255 254 do_140(s)   ( -- 255 254 )
    push HL             ; 1:11      255 254 do_140(s)
    ld   DE, 0x00FF     ; 3:10      255 254 do_140(s)
    ld   HL, 0x00FE     ; 3:10      255 254 do_140(s)
do140:                  ;           255 254 do_140(s)   ( stop index -- stop index )
    ld    A, 'h'        ; 2:7       putchar('h')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('h')   putchar(reg A) with ZX 48K ROM
    inc  HL             ; 1:6       loop_140(s)   index++
    ld    A, L          ; 1:4       loop_140(s)
    xor   E             ; 1:4       loop_140(s)   lo(index - stop)
    jp   nz, do140      ; 3:10      loop_140(s)
    ld    A, H          ; 1:4       loop_140(s)
    xor   D             ; 1:4       loop_140(s)   hi(index - stop)
    jp   nz, do140      ; 3:10      loop_140(s)
leave140:               ;           loop_140(s)
    pop  HL             ; 1:10      unloop_140(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_140(s)
exit140:                ;           loop_140(s)
                        ;[8:42]     256 255 do_141(s)
    push DE             ; 1:11      256 255 do_141(s)   ( -- 256 255 )
    push HL             ; 1:11      256 255 do_141(s)
    ld   DE, 0x0100     ; 3:10      256 255 do_141(s)
    ld   HL, 0x00FF     ; 3:10      256 255 do_141(s)
do141:                  ;           256 255 do_141(s)   ( stop index -- stop index )
    ld    A, 'i'        ; 2:7       putchar('i')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('i')   putchar(reg A) with ZX 48K ROM
    inc  HL             ; 1:6       loop_141(s)   index++
    ld    A, L          ; 1:4       loop_141(s)
    xor   E             ; 1:4       loop_141(s)   lo(index - stop)
    jp   nz, do141      ; 3:10      loop_141(s)
    ld    A, H          ; 1:4       loop_141(s)
    xor   D             ; 1:4       loop_141(s)   hi(index - stop)
    jp   nz, do141      ; 3:10      loop_141(s)
leave141:               ;           loop_141(s)
    pop  HL             ; 1:10      unloop_141(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_141(s)
exit141:                ;           loop_141(s)
                        ;[7:40]     257 256 do_142(s)
    push DE             ; 1:11      257 256 do_142(s)   ( -- 257 256 )
    push HL             ; 1:11      257 256 do_142(s)
    ld   HL, 0x0100     ; 3:10      257 256 do_142(s)
    ld    E, H          ; 1:4       257 256 do_142(s)   E = H = 0x01
    ld    D, E          ; 1:4       257 256 do_142(s)   D = E = 0x01
do142:                  ;           257 256 do_142(s)   ( stop index -- stop index )
    ld    A, 'j'        ; 2:7       putchar('j')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('j')   putchar(reg A) with ZX 48K ROM
    inc  HL             ; 1:6       loop_142(s)   index++
    ld    A, L          ; 1:4       loop_142(s)
    xor   E             ; 1:4       loop_142(s)   lo(index - stop)
    jp   nz, do142      ; 3:10      loop_142(s)
    ld    A, H          ; 1:4       loop_142(s)
    xor   D             ; 1:4       loop_142(s)   hi(index - stop)
    jp   nz, do142      ; 3:10      loop_142(s)
leave142:               ;           loop_142(s)
    pop  HL             ; 1:10      unloop_142(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_142(s)
exit142:                ;           loop_142(s)
    ld   BC, 30000      ; 3:10      do_143(xm)
do143save:              ;           do_143(xm)
    ld  (idx143),BC     ; 4:20      do_143(xm)
do143:                  ;           do_143(xm)
    ld    A, 'k'        ; 2:7       putchar('k')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('k')   putchar(reg A) with ZX 48K ROM
idx143 EQU do143save-2  ;           40000 +loop_143(xm)   variant +X.null: positive step and no repeat
leave143:               ;           40000 +loop_143(xm)
exit143:                ;           40000 +loop_143(xm)
    ld   BC, 30000      ; 3:10      do_144(xm)
do144save:              ;           do_144(xm)
    ld  (idx144),BC     ; 4:20      do_144(xm)
do144:                  ;           do_144(xm)
    ld    A, 'l'        ; 2:7       putchar('l')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('l')   putchar(reg A) with ZX 48K ROM
idx144 EQU do144save-2  ;           31000 +loop_144(xm)   variant +X.null: positive step and no repeat
leave144:               ;           31000 +loop_144(xm)
exit144:                ;           31000 +loop_144(xm)
    push DE             ; 1:11      print     0xD, "Data stack:"
    ld   BC, size104    ; 3:10      print     Length of string104
    ld   DE, string104  ; 3:10      print     Address of string104
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
                        ;[13:72]    depth   ( -- +n )
    push DE             ; 1:11      depth
    ex   DE, HL         ; 1:4       depth
    ld   HL,(Stop+1)    ; 3:16      depth
    or    A             ; 1:4       depth
    sbc  HL, SP         ; 2:15      depth
    srl   H             ; 2:8       depth
    rr    L             ; 2:8       depth
    dec  HL             ; 1:6       depth
    call PRT_S16        ; 3:17      .   ( s -- )
    push DE             ; 1:11      print     0xD, "RAS:"
    ld   BC, size105    ; 3:10      print     Length of string105
    ld   DE, string105  ; 3:10      print     Address of string105
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    ex   DE, HL         ; 1:4       ras   ( -- return_address_stack )
    exx                 ; 1:4       ras
    push HL             ; 1:11      ras
    exx                 ; 1:4       ras
    ex  (SP),HL         ; 1:19      ras
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;==============================================================================
; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_S16:             ;           prt_sp_s16
    ld    A, ' '        ; 2:7       prt_sp_s16   putchar Pollutes: AF, DE', BC'
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
    ld    A, '-'        ; 2:7       prt_s16   putchar Pollutes: AF, DE', BC'
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
    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
    ld    A, '0'        ; 2:7       bin16_dec   reset A to '0'
    ret                 ; 1:10      bin16_dec

STRING_SECTION:
string105:
    db 0xD, "RAS:"
  size105   EQU  $ - string105
string104:
    db 0xD, "Data stack:"
  size104   EQU  $ - string104
string103:
    db "Once:"
  size103   EQU  $ - string103
string102:
    db 0xD, "Leave >= 7", 0xD
  size102   EQU  $ - string102
string101:
    db "Exit:"
  size101   EQU  $ - string101
