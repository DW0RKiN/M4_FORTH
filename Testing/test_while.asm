; vvvvv
; ^^^^^
ORG 0x8000
    
    
    
    
     
     
     
     
    
      
      
      
      
    
     
     
    
     
     

    
      
    
        

    ; signed
           
         
          
           
         
          
           
         
          
           
         
          
           
         
          
           
         
          
         
    ; unsigned
          
        
         
          
        
         
          
        
         
          
        
         
          
        
         
          
        
         
       




    ; signed
           
         
          
           
         
          
           
         
          
           
         
          
           
         
          
           
         
          
          
    ; unsigned
          
        
         
          
        
         
          
        
         
          
        
         
          
        
         
          
        
         
       





    ; signed
        
        
        
        
        
        
     
    ; unsigned
        
        
        
        
        
        
     




    ; signed
        
        
        
        
        
        
     
    ; unsigned
        
        
        
        
        
        
       


;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld  HL, PRINT_OUT   ; 3:10      init
    ld (CURCHL),HL      ; 3:16      init
    ld  HL, putchar     ; 3:10      init
    ld (PRINT_OUT),HL   ; 3:10      init
  if 0
    ld   HL, 0x0000     ; 3:10      init
    ld  (putchar_yx),HL ; 3:16      init
  else
    ld   HL, 0x1821     ; 3:10      init
    ld   DE,(0x5C88)    ; 4:20      init
    or    A             ; 1:4       init
    sbc  HL, DE         ; 2:15      init
    ld    A, L          ; 1:4       init   x
    add   A, A          ; 1:4       init   2*x
    inc   A             ; 1:4       init   2*2+1
    add   A, A          ; 1:4       init   4*x+2
    add   A, A          ; 1:4       init   8*x+4
    ld    L, 0xFF       ; 2:7       init
    inc   L             ; 1:4       init
    sub 0x05            ; 2:7       init
    jr   nc, $-3        ; 2:7/12    init
    ld  (putchar_yx),HL ; 3:16      init
  endif
    ld   HL, 0xEA60     ; 3:10      init   Return address stack = 60000
    exx                 ; 1:4       init
    ld   BC, string101  ; 3:10      print_i   Address of string101 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
                        ;[8:42]     5 -5   ( -- 5 -5 )
    push DE             ; 1:11      5 -5
    push HL             ; 1:11      5 -5
    ld   DE, 0x0005     ; 3:10      5 -5
    ld   HL, 0xFFFB     ; 3:10      5 -5
    call x_x_test       ; 3:17      call ( -- )
                        ;[7:40]     5 5   ( -- 5 5 )
    push DE             ; 1:11      5 5
    push HL             ; 1:11      5 5
    ld   DE, 0x0005     ; 3:10      5 5
    ld    H, D          ; 1:4       5 5   H = D = 0x00
    ld    L, E          ; 1:4       5 5   L = E = 0x05
    call x_x_test       ; 3:17      call ( -- )
                        ;[7:40]     -5 -5   ( -- -5 -5 )
    push DE             ; 1:11      -5 -5
    push HL             ; 1:11      -5 -5
    ld   DE, 0xFFFB     ; 3:10      -5 -5
    ld    H, D          ; 1:4       -5 -5   H = D = 0xFF
    ld    L, E          ; 1:4       -5 -5   L = E = 0xFB
    call x_x_test       ; 3:17      call ( -- )
                        ;[8:42]     -5 5   ( -- -5 5 )
    push DE             ; 1:11      -5 5
    push HL             ; 1:11      -5 5
    ld   DE, 0xFFFB     ; 3:10      -5 5
    ld   HL, 0x0005     ; 3:10      -5 5
    call x_x_test       ; 3:17      call ( -- )
    ld   BC, string102  ; 3:10      print_i   Address of string102 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    push DE             ; 1:11      5. -5.
    push HL             ; 1:11      5. -5.
    ld   DE, 0x0000     ; 3:10      5. -5.
    push DE             ; 1:11      5. -5.
    ld    E, 0x05       ; 2:7       5. -5.
    push DE             ; 1:11      5. -5.
    dec   D             ; 1:4       5. -5.
    ld    E, D          ; 1:4       5. -5.   E = D = 0xFF
    ld   HL, 0xFFFB     ; 3:10      5. -5.
    call d_d_test       ; 3:17      call ( -- )
    push DE             ; 1:11      5. 5.
    push HL             ; 1:11      5. 5.
    ld   HL, 0x0005     ; 3:10      5. 5.
    ld    E, H          ; 1:4       5. 5.   E = H = 0x00
    ld    D, E          ; 1:4       5. 5.   D = E = 0x00
    push DE             ; 1:11      5. 5.
    push HL             ; 1:11      5. 5.
    call d_d_test       ; 3:17      call ( -- )
    push DE             ; 1:11      -5. -5.
    push HL             ; 1:11      -5. -5.
    ld   HL, 0xFFFB     ; 3:10      -5. -5.
    ld    E, H          ; 1:4       -5. -5.   E = H = 0xFF
    ld    D, E          ; 1:4       -5. -5.   D = E = 0xFF
    push DE             ; 1:11      -5. -5.
    push HL             ; 1:11      -5. -5.
    call d_d_test       ; 3:17      call ( -- )
    push DE             ; 1:11      -5. 5.
    push HL             ; 1:11      -5. 5.
    ld   DE, 0xFFFF     ; 3:10      -5. 5.
    push DE             ; 1:11      -5. 5.
    ld    E, 0xFB       ; 2:7       -5. 5.
    push DE             ; 1:11      -5. 5.
    inc   D             ; 1:4       -5. 5.
    ld    E, D          ; 1:4       -5. 5.   E = D = 0x00
    ld   HL, 0x0005     ; 3:10      -5. 5.
    call d_d_test       ; 3:17      call ( -- )
    ld   BC, string103  ; 3:10      print_i   Address of string103 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    push DE             ; 1:11      3
    ex   DE, HL         ; 1:4       3
    ld   HL, 3          ; 3:10      3
    call x_p3_test      ; 3:17      call ( -- )
    push DE             ; 1:11      -3
    ex   DE, HL         ; 1:4       -3
    ld   HL, 0-3        ; 3:10      -3
    call x_p3_test      ; 3:17      call ( -- )
    ld   BC, string104  ; 3:10      print_i   Address of string104 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    push DE             ; 1:11      3
    ex   DE, HL         ; 1:4       3
    ld   HL, 3          ; 3:10      3
    call x_m3_test      ; 3:17      call ( -- )
    push DE             ; 1:11      -3
    ex   DE, HL         ; 1:4       -3
    ld   HL, 0-3        ; 3:10      -3
    call x_m3_test      ; 3:17      call ( -- )
    ld   BC, string105  ; 3:10      print_i   Address of string105 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
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
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
;   ---  the beginning of a non-recursive function  ---
x_x_test:               ;           
    pop  BC             ; 1:10      : ret
    ld  (x_x_test_end+1),BC; 4:20      : ( ret -- )
begin101:               ;           begin 101
    ld    A, E          ; 1:4       2dup = while 101
    sub   L             ; 1:4       2dup = while 101
    jp   nz, break101   ; 3:10      2dup = while 101
    ld    A, D          ; 1:4       2dup = while 101
    sub   H             ; 1:4       2dup = while 101
    jp   nz, break101   ; 3:10      2dup = while 101
    ld   BC, string106  ; 3:10      print_i   Address of string106 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break101       ; 3:10      break 101
    jp   begin101       ; 3:10      again 101
break101:               ;           again 101
begin102:               ;           begin 102
    ld    A, E          ; 1:4       2dup = while 102
    sub   L             ; 1:4       2dup = while 102
    jp   nz, break102   ; 3:10      2dup = while 102
    ld    A, D          ; 1:4       2dup = while 102
    sub   H             ; 1:4       2dup = while 102
    jp   nz, break102   ; 3:10      2dup = while 102
    ld   BC, string106  ; 3:10      print_i   Address of string107 ending with inverted most significant bit == string106
    call PRINT_STRING_I ; 3:17      print_i
    jp   break102       ; 3:10      break 102
    jp   begin102       ; 3:10      again 102
break102:               ;           again 102
begin103:               ;           begin 103
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       = while 103
    sbc  HL, DE         ; 2:15      = while 103
    pop  HL             ; 1:10      = while 103
    pop  DE             ; 1:10      = while 103
    jp   nz, break103   ; 3:10      = while 103
    ld   BC, string108  ; 3:10      print_i   Address of string108 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break103       ; 3:10      break 103
    jp   begin103       ; 3:10      again 103
break103:               ;           again 103
begin104:               ;           begin 104
    ld    A, E          ; 1:4       2dup <> while 104
    sub   L             ; 1:4       2dup <> while 104
    jr   nz, $+7        ; 2:7/12    2dup <> while 104
    ld    A, D          ; 1:4       2dup <> while 104
    sub   H             ; 1:4       2dup <> while 104
    jp    z, break104   ; 3:10      2dup <> while 104
    ld   BC, string109  ; 3:10      print_i   Address of string109 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break104       ; 3:10      break 104
    jp   begin104       ; 3:10      again 104
break104:               ;           again 104
begin105:               ;           begin 105
    ld    A, E          ; 1:4       2dup <> while 105
    sub   L             ; 1:4       2dup <> while 105
    jr   nz, $+7        ; 2:7/12    2dup <> while 105
    ld    A, D          ; 1:4       2dup <> while 105
    sub   H             ; 1:4       2dup <> while 105
    jp    z, break105   ; 3:10      2dup <> while 105
    ld   BC, string109  ; 3:10      print_i   Address of string110 ending with inverted most significant bit == string109
    call PRINT_STRING_I ; 3:17      print_i
    jp   break105       ; 3:10      break 105
    jp   begin105       ; 3:10      again 105
break105:               ;           again 105
begin106:               ;           begin 106
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       <> while 106
    sbc  HL, DE         ; 2:15      <> while 106
    pop  HL             ; 1:10      <> while 106
    pop  DE             ; 1:10      <> while 106
    jp    z, break106   ; 3:10      <> while 106
    ld   BC, string111  ; 3:10      print_i   Address of string111 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break106       ; 3:10      break 106
    jp   begin106       ; 3:10      again 106
break106:               ;           again 106
begin107:               ;           begin 107
    ld    A, E          ; 1:4       2dup < while 107    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       2dup < while 107    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       2dup < while 107    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       2dup < while 107    DE<HL --> DE-HL<0 --> no carry if false
    rra                 ; 1:4       2dup < while 107
    xor   D             ; 1:4       2dup < while 107
    xor   H             ; 1:4       2dup < while 107
    jp    p, break107   ; 3:10      2dup < while 107
    ld   BC, string112  ; 3:10      print_i   Address of string112 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break107       ; 3:10      break 107
    jp   begin107       ; 3:10      again 107
break107:               ;           again 107
begin108:               ;           begin 108
    ld    A, E          ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       2dup < while 108    DE<HL --> DE-HL<0 --> no carry if false
    rra                 ; 1:4       2dup < while 108
    xor   D             ; 1:4       2dup < while 108
    xor   H             ; 1:4       2dup < while 108
    jp    p, break108   ; 3:10      2dup < while 108
    ld   BC, string112  ; 3:10      print_i   Address of string113 ending with inverted most significant bit == string112
    call PRINT_STRING_I ; 3:17      print_i
    jp   break108       ; 3:10      break 108
    jp   begin108       ; 3:10      again 108
break108:               ;           again 108
begin109:               ;           begin 109
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       < while 109    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       < while 109    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       < while 109    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       < while 109    DE<HL --> DE-HL<0 --> no carry if false
    rra                 ; 1:4       < while 109
    xor   D             ; 1:4       < while 109
    xor   H             ; 1:4       < while 109
    pop  HL             ; 1:10      < while 109
    pop  DE             ; 1:10      < while 109
    jp    p, break109   ; 3:10      < while 109
    ld   BC, string114  ; 3:10      print_i   Address of string114 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break109       ; 3:10      break 109
    jp   begin109       ; 3:10      again 109
break109:               ;           again 109
begin110:               ;           begin 110
    ld    A, L          ; 1:4       2dup <= while 110    DE<=HL --> HL-DE>=0 --> carry if false
    sub   E             ; 1:4       2dup <= while 110    DE<=HL --> HL-DE>=0 --> carry if false
    ld    A, H          ; 1:4       2dup <= while 110    DE<=HL --> HL-DE>=0 --> carry if false
    sbc   A, D          ; 1:4       2dup <= while 110    DE<=HL --> HL-DE>=0 --> carry if false
    rra                 ; 1:4       2dup <= while 110
    xor   D             ; 1:4       2dup <= while 110
    xor   H             ; 1:4       2dup <= while 110
    jp    m, break110   ; 3:10      2dup <= while 110
    ld   BC, string115  ; 3:10      print_i   Address of string115 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break110       ; 3:10      break 110
    jp   begin110       ; 3:10      again 110
break110:               ;           again 110
begin111:               ;           begin 111
    ld    A, L          ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> carry if false
    sub   E             ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> carry if false
    ld    A, H          ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> carry if false
    sbc   A, D          ; 1:4       2dup <= while 111    DE<=HL --> HL-DE>=0 --> carry if false
    rra                 ; 1:4       2dup <= while 111
    xor   D             ; 1:4       2dup <= while 111
    xor   H             ; 1:4       2dup <= while 111
    jp    m, break111   ; 3:10      2dup <= while 111
    ld   BC, string115  ; 3:10      print_i   Address of string116 ending with inverted most significant bit == string115
    call PRINT_STRING_I ; 3:17      print_i
    jp   break111       ; 3:10      break 111
    jp   begin111       ; 3:10      again 111
break111:               ;           again 111
begin112:               ;           begin 112
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       <= while 112    DE<=HL --> HL-DE>=0 --> carry if false
    sub   E             ; 1:4       <= while 112    DE<=HL --> HL-DE>=0 --> carry if false
    ld    A, H          ; 1:4       <= while 112    DE<=HL --> HL-DE>=0 --> carry if false
    sbc   A, D          ; 1:4       <= while 112    DE<=HL --> HL-DE>=0 --> carry if false
    rra                 ; 1:4       <= while 112
    xor   D             ; 1:4       <= while 112
    xor   H             ; 1:4       <= while 112
    pop  HL             ; 1:10      <= while 112
    pop  DE             ; 1:10      <= while 112
    jp    m, break112   ; 3:10      <= while 112
    ld   BC, string117  ; 3:10      print_i   Address of string117 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break112       ; 3:10      break 112
    jp   begin112       ; 3:10      again 112
break112:               ;           again 112
begin113:               ;           begin 113
    ld    A, L          ; 1:4       2dup > while 113    DE>HL --> HL-DE<0 --> no carry if false
    sub   E             ; 1:4       2dup > while 113    DE>HL --> HL-DE<0 --> no carry if false
    ld    A, H          ; 1:4       2dup > while 113    DE>HL --> HL-DE<0 --> no carry if false
    sbc   A, D          ; 1:4       2dup > while 113    DE>HL --> HL-DE<0 --> no carry if false
    rra                 ; 1:4       2dup > while 113
    xor   D             ; 1:4       2dup > while 113
    xor   H             ; 1:4       2dup > while 113
    jp    p, break113   ; 3:10      2dup > while 113
    ld   BC, string118  ; 3:10      print_i   Address of string118 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break113       ; 3:10      break 113
    jp   begin113       ; 3:10      again 113
break113:               ;           again 113
begin114:               ;           begin 114
    ld    A, L          ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> no carry if false
    sub   E             ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> no carry if false
    ld    A, H          ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> no carry if false
    sbc   A, D          ; 1:4       2dup > while 114    DE>HL --> HL-DE<0 --> no carry if false
    rra                 ; 1:4       2dup > while 114
    xor   D             ; 1:4       2dup > while 114
    xor   H             ; 1:4       2dup > while 114
    jp    p, break114   ; 3:10      2dup > while 114
    ld   BC, string118  ; 3:10      print_i   Address of string119 ending with inverted most significant bit == string118
    call PRINT_STRING_I ; 3:17      print_i
    jp   break114       ; 3:10      break 114
    jp   begin114       ; 3:10      again 114
break114:               ;           again 114
begin115:               ;           begin 115
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       > while 115    DE>HL --> HL-DE<0 --> no carry if false
    sub   E             ; 1:4       > while 115    DE>HL --> HL-DE<0 --> no carry if false
    ld    A, H          ; 1:4       > while 115    DE>HL --> HL-DE<0 --> no carry if false
    sbc   A, D          ; 1:4       > while 115    DE>HL --> HL-DE<0 --> no carry if false
    rra                 ; 1:4       > while 115
    xor   D             ; 1:4       > while 115
    xor   H             ; 1:4       > while 115
    pop  HL             ; 1:10      > while 115
    pop  DE             ; 1:10      > while 115
    jp    p, break115   ; 3:10      > while 115
    ld   BC, string120  ; 3:10      print_i   Address of string120 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break115       ; 3:10      break 115
    jp   begin115       ; 3:10      again 115
break115:               ;           again 115
begin116:               ;           begin 116
    ld    A, E          ; 1:4       2dup >= while 116    DE>=HL --> DE-HL>=0 --> carry if false
    sub   L             ; 1:4       2dup >= while 116    DE>=HL --> DE-HL>=0 --> carry if false
    ld    A, D          ; 1:4       2dup >= while 116    DE>=HL --> DE-HL>=0 --> carry if false
    sbc   A, H          ; 1:4       2dup >= while 116    DE>=HL --> DE-HL>=0 --> carry if false
    rra                 ; 1:4       2dup >= while 116
    xor   D             ; 1:4       2dup >= while 116
    xor   H             ; 1:4       2dup >= while 116
    jp    m, break116   ; 3:10      2dup >= while 116
    ld   BC, string121  ; 3:10      print_i   Address of string121 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break116       ; 3:10      break 116
    jp   begin116       ; 3:10      again 116
break116:               ;           again 116
begin117:               ;           begin 117
    ld    A, E          ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> carry if false
    sub   L             ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> carry if false
    ld    A, D          ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> carry if false
    sbc   A, H          ; 1:4       2dup >= while 117    DE>=HL --> DE-HL>=0 --> carry if false
    rra                 ; 1:4       2dup >= while 117
    xor   D             ; 1:4       2dup >= while 117
    xor   H             ; 1:4       2dup >= while 117
    jp    m, break117   ; 3:10      2dup >= while 117
    ld   BC, string121  ; 3:10      print_i   Address of string122 ending with inverted most significant bit == string121
    call PRINT_STRING_I ; 3:17      print_i
    jp   break117       ; 3:10      break 117
    jp   begin117       ; 3:10      again 117
break117:               ;           again 117
begin118:               ;           begin 118
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       >= while 118    DE>=HL --> DE-HL>=0 --> carry if false
    sub   L             ; 1:4       >= while 118    DE>=HL --> DE-HL>=0 --> carry if false
    ld    A, D          ; 1:4       >= while 118    DE>=HL --> DE-HL>=0 --> carry if false
    sbc   A, H          ; 1:4       >= while 118    DE>=HL --> DE-HL>=0 --> carry if false
    rra                 ; 1:4       >= while 118
    xor   D             ; 1:4       >= while 118
    xor   H             ; 1:4       >= while 118
    pop  HL             ; 1:10      >= while 118
    pop  DE             ; 1:10      >= while 118
    jp    m, break118   ; 3:10      >= while 118
    ld   BC, string123  ; 3:10      print_i   Address of string123 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
    jp   break118       ; 3:10      break 118
    jp   begin118       ; 3:10      again 118
break118:               ;           again 118
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    call PRT_S16        ; 3:17      .   ( s -- )
    push HL             ; 1:11      dup space .   x3 x1 x2 x1
    call PRT_SP_S16     ; 3:17      space .   ( s -- )
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
begin119:               ;           begin 119
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
                        ;[9:48/49]  ueq
    xor   A             ; 1:4       ueq   A = 0x00
    sbc  HL, DE         ; 2:15      ueq
    jr   nz, $+3        ; 2:7/12    ueq
    dec   A             ; 1:4       ueq   A = 0xFF
    ld    L, A          ; 1:4       ueq
    ld    H, A          ; 1:4       ueq   HL= flag
    pop  DE             ; 1:10      ueq
    ld    A, H          ; 1:4       while 119
    or    L             ; 1:4       while 119
    ex   DE, HL         ; 1:4       while 119
    pop  DE             ; 1:10      while 119
    jp    z, break119   ; 3:10      while 119
    ld   BC, string106  ; 3:10      print_i   Address of string124 ending with inverted most significant bit == string106
    call PRINT_STRING_I ; 3:17      print_i
    jp   break119       ; 3:10      break 119
    jp   begin119       ; 3:10      again 119
break119:               ;           again 119
begin120:               ;           begin 120
    ld    A, E          ; 1:4       2dup u= while 120
    sub   L             ; 1:4       2dup u= while 120
    jp   nz, break120   ; 3:10      2dup u= while 120
    ld    A, D          ; 1:4       2dup u= while 120
    sub   H             ; 1:4       2dup u= while 120
    jp   nz, break120   ; 3:10      2dup u= while 120
    ld   BC, string106  ; 3:10      print_i   Address of string125 ending with inverted most significant bit == string106
    call PRINT_STRING_I ; 3:17      print_i
    jp   break120       ; 3:10      break 120
    jp   begin120       ; 3:10      again 120
break120:               ;           again 120
begin121:               ;           begin 121
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       u= while 121
    sbc  HL, DE         ; 2:15      u= while 121
    pop  HL             ; 1:10      u= while 121
    pop  DE             ; 1:10      u= while 121
    jp   nz, break121   ; 3:10      u= while 121
    ld   BC, string108  ; 3:10      print_i   Address of string126 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
    jp   break121       ; 3:10      break 121
    jp   begin121       ; 3:10      again 121
break121:               ;           again 121
begin122:               ;           begin 122
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       une
    sbc  HL, DE         ; 2:15      une
    jr    z, $+5        ; 2:7/12    une
    ld   HL, 0xFFFF     ; 3:10      une
    pop  DE             ; 1:10      une
    ld    A, H          ; 1:4       while 122
    or    L             ; 1:4       while 122
    ex   DE, HL         ; 1:4       while 122
    pop  DE             ; 1:10      while 122
    jp    z, break122   ; 3:10      while 122
    ld   BC, string109  ; 3:10      print_i   Address of string127 ending with inverted most significant bit == string109
    call PRINT_STRING_I ; 3:17      print_i
    jp   break122       ; 3:10      break 122
    jp   begin122       ; 3:10      again 122
break122:               ;           again 122
begin123:               ;           begin 123
    ld    A, E          ; 1:4       2dup u<> while 123
    sub   L             ; 1:4       2dup u<> while 123
    jr   nz, $+7        ; 2:7/12    2dup u<> while 123
    ld    A, D          ; 1:4       2dup u<> while 123
    sbc   A, H          ; 1:4       2dup u<> while 123
    jp    z, break123   ; 3:10      2dup u<> while 123
    ld   BC, string109  ; 3:10      print_i   Address of string128 ending with inverted most significant bit == string109
    call PRINT_STRING_I ; 3:17      print_i
    jp   break123       ; 3:10      break 123
    jp   begin123       ; 3:10      again 123
break123:               ;           again 123
begin124:               ;           begin 124
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    or    A             ; 1:4       u<> while 124
    sbc  HL, DE         ; 2:15      u<> while 124
    pop  HL             ; 1:10      u<> while 124
    pop  DE             ; 1:10      u<> while 124
    jp    z, break124   ; 3:10      u<> while 124
    ld   BC, string111  ; 3:10      print_i   Address of string129 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
    jp   break124       ; 3:10      break 124
    jp   begin124       ; 3:10      again 124
break124:               ;           again 124
begin125:               ;           begin 125
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       u< while 125    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       u< while 125    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       u< while 125    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       u< while 125    DE<HL --> DE-HL<0 --> no carry if false
    pop  HL             ; 1:10      u< while 125
    pop  DE             ; 1:10      u< while 125
    jp   nc, break125   ; 3:10      u< while 125
    ld   BC, string112  ; 3:10      print_i   Address of string130 ending with inverted most significant bit == string112
    call PRINT_STRING_I ; 3:17      print_i
    jp   break125       ; 3:10      break 125
    jp   begin125       ; 3:10      again 125
break125:               ;           again 125
begin126:               ;           begin 126
    ld    A, E          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       2dup u< while 126    DE<HL --> DE-HL<0 --> no carry if false
    jp   nc, break126   ; 3:10      2dup u< while 126
    ld   BC, string112  ; 3:10      print_i   Address of string131 ending with inverted most significant bit == string112
    call PRINT_STRING_I ; 3:17      print_i
    jp   break126       ; 3:10      break 126
    jp   begin126       ; 3:10      again 126
break126:               ;           again 126
begin127:               ;           begin 127
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> no carry if false
    sub   L             ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> no carry if false
    ld    A, D          ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> no carry if false
    sbc   A, H          ; 1:4       u< while 127    DE<HL --> DE-HL<0 --> no carry if false
    pop  HL             ; 1:10      u< while 127
    pop  DE             ; 1:10      u< while 127
    jp   nc, break127   ; 3:10      u< while 127
    ld   BC, string114  ; 3:10      print_i   Address of string132 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
    jp   break127       ; 3:10      break 127
    jp   begin127       ; 3:10      again 127
break127:               ;           again 127
begin128:               ;           begin 128
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       u<= while 128    DE<=HL --> 0<=HL-DE --> carry if false
    sub   E             ; 1:4       u<= while 128    DE<=HL --> 0<=HL-DE --> carry if false
    ld    A, H          ; 1:4       u<= while 128    DE<=HL --> 0<=HL-DE --> carry if false
    sbc   A, D          ; 1:4       u<= while 128    DE<=HL --> 0<=HL-DE --> carry if false
    pop  HL             ; 1:10      u<= while 128
    pop  DE             ; 1:10      u<= while 128
    jp    c, break128   ; 3:10      u<= while 128
    ld   BC, string115  ; 3:10      print_i   Address of string133 ending with inverted most significant bit == string115
    call PRINT_STRING_I ; 3:17      print_i
    jp   break128       ; 3:10      break 128
    jp   begin128       ; 3:10      again 128
break128:               ;           again 128
begin129:               ;           begin 129
    ld    A, L          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> carry if false
    sub   E             ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> carry if false
    ld    A, H          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> carry if false
    sbc   A, D          ; 1:4       2dup u<= while 129    DE<=HL --> 0<=HL-DE --> carry if false
    jp    c, break129   ; 3:10      2dup u<= while 129
    ld   BC, string115  ; 3:10      print_i   Address of string134 ending with inverted most significant bit == string115
    call PRINT_STRING_I ; 3:17      print_i
    jp   break129       ; 3:10      break 129
    jp   begin129       ; 3:10      again 129
break129:               ;           again 129
begin130:               ;           begin 130
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> carry if false
    sub   E             ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> carry if false
    ld    A, H          ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> carry if false
    sbc   A, D          ; 1:4       u<= while 130    DE<=HL --> 0<=HL-DE --> carry if false
    pop  HL             ; 1:10      u<= while 130
    pop  DE             ; 1:10      u<= while 130
    jp    c, break130   ; 3:10      u<= while 130
    ld   BC, string117  ; 3:10      print_i   Address of string135 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
    jp   break130       ; 3:10      break 130
    jp   begin130       ; 3:10      again 130
break130:               ;           again 130
begin131:               ;           begin 131
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       u> while 131    DE>HL --> 0>HL-DE --> no carry if false
    sub   E             ; 1:4       u> while 131    DE>HL --> 0>HL-DE --> no carry if false
    ld    A, H          ; 1:4       u> while 131    DE>HL --> 0>HL-DE --> no carry if false
    sbc   A, D          ; 1:4       u> while 131    DE>HL --> 0>HL-DE --> no carry if false
    pop  HL             ; 1:10      u> while 131
    pop  DE             ; 1:10      u> while 131
    jp   nc, break131   ; 3:10      u> while 131
    ld   BC, string118  ; 3:10      print_i   Address of string136 ending with inverted most significant bit == string118
    call PRINT_STRING_I ; 3:17      print_i
    jp   break131       ; 3:10      break 131
    jp   begin131       ; 3:10      again 131
break131:               ;           again 131
begin132:               ;           begin 132
    ld    A, L          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> no carry if false
    sub   E             ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> no carry if false
    ld    A, H          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> no carry if false
    sbc   A, D          ; 1:4       2dup u> while 132    DE>HL --> 0>HL-DE --> no carry if false
    jp   nc, break132   ; 3:10      2dup u> while 132
    ld   BC, string118  ; 3:10      print_i   Address of string137 ending with inverted most significant bit == string118
    call PRINT_STRING_I ; 3:17      print_i
    jp   break132       ; 3:10      break 132
    jp   begin132       ; 3:10      again 132
break132:               ;           again 132
begin133:               ;           begin 133
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, L          ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> no carry if false
    sub   E             ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> no carry if false
    ld    A, H          ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> no carry if false
    sbc   A, D          ; 1:4       u> while 133    DE>HL --> 0>HL-DE --> no carry if false
    pop  HL             ; 1:10      u> while 133
    pop  DE             ; 1:10      u> while 133
    jp   nc, break133   ; 3:10      u> while 133
    ld   BC, string120  ; 3:10      print_i   Address of string138 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
    jp   break133       ; 3:10      break 133
    jp   begin133       ; 3:10      again 133
break133:               ;           again 133
begin134:               ;           begin 134
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       u>= while 134    DE>=HL --> DE-HL>=0 --> carry if false
    sub   L             ; 1:4       u>= while 134    DE>=HL --> DE-HL>=0 --> carry if false
    ld    A, D          ; 1:4       u>= while 134    DE>=HL --> DE-HL>=0 --> carry if false
    sbc   A, H          ; 1:4       u>= while 134    DE>=HL --> DE-HL>=0 --> carry if false
    pop  HL             ; 1:10      u>= while 134
    pop  DE             ; 1:10      u>= while 134
    jp    c, break134   ; 3:10      u>= while 134
    ld   BC, string121  ; 3:10      print_i   Address of string139 ending with inverted most significant bit == string121
    call PRINT_STRING_I ; 3:17      print_i
    jp   break134       ; 3:10      break 134
    jp   begin134       ; 3:10      again 134
break134:               ;           again 134
begin135:               ;           begin 135
    ld    A, E          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> carry if false
    sub   L             ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> carry if false
    ld    A, D          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> carry if false
    sbc   A, H          ; 1:4       2dup u>= while 135    DE>=HL --> DE-HL>=0 --> carry if false
    jp    c, break135   ; 3:10      2dup u>= while 135
    ld   BC, string121  ; 3:10      print_i   Address of string140 ending with inverted most significant bit == string121
    call PRINT_STRING_I ; 3:17      print_i
    jp   break135       ; 3:10      break 135
    jp   begin135       ; 3:10      again 135
break135:               ;           again 135
begin136:               ;           begin 136
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    ld    A, E          ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> carry if false
    sub   L             ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> carry if false
    ld    A, D          ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> carry if false
    sbc   A, H          ; 1:4       u>= while 136    DE>=HL --> DE-HL>=0 --> carry if false
    pop  HL             ; 1:10      u>= while 136
    pop  DE             ; 1:10      u>= while 136
    jp    c, break136   ; 3:10      u>= while 136
    ld   BC, string123  ; 3:10      print_i   Address of string141 ending with inverted most significant bit == string123
    call PRINT_STRING_I ; 3:17      print_i
    jp   break136       ; 3:10      break 136
    jp   begin136       ; 3:10      again 136
break136:               ;           again 136
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    call PRT_U16        ; 3:17      u.   ( u -- )
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
x_x_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
d_d_test:               ;           
    pop  BC             ; 1:10      : ret
    ld  (d_d_test_end+1),BC; 4:20      : ( ret -- )
begin137:               ;           begin 137
                   ;[16:132/73,132] 4dup D= while 137   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= while 137   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= while 137   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= while 137   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= while 137   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= while 137   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= while 137   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= while 137   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= while 137   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= while 137   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= while 137   h2 l2 . h1 l1
    jp   nz, break137   ; 3:10      4dup D= while 137   h2 l2 . h1 l1
    ld   BC, string106  ; 3:10      print_i   Address of string142 ending with inverted most significant bit == string106
    call PRINT_STRING_I ; 3:17      print_i
    jp   break137       ; 3:10      break 137
    jp   begin137       ; 3:10      again 137
break137:               ;           again 137
begin138:               ;           begin 138
                   ;[16:132/73,132] 4dup D= while 138   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= while 138   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= while 138   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= while 138   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= while 138   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= while 138   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= while 138   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= while 138   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= while 138   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= while 138   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= while 138   h2 l2 . h1 l1
    jp   nz, break138   ; 3:10      4dup D= while 138   h2 l2 . h1 l1
    ld   BC, string106  ; 3:10      print_i   Address of string143 ending with inverted most significant bit == string106
    call PRINT_STRING_I ; 3:17      print_i
    jp   break138       ; 3:10      break 138
    jp   begin138       ; 3:10      again 138
break138:               ;           again 138
begin139:               ;           begin 139
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[14:91]     D= while 139   ( d2 d1 -- )
    pop  BC             ; 1:10      D= while 139   lo_2
    or    A             ; 1:4       D= while 139
    sbc  HL, BC         ; 2:15      D= while 139   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> no zero if false
    pop  HL             ; 1:10      D= while 139   hi_2
    jr   nz, $+4        ; 2:7/12    D= while 139
    sbc  HL, DE         ; 2:15      D= while 139   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> no zero if false
    pop  HL             ; 1:10      D= while 139
    pop  DE             ; 1:10      D= while 139
    jp   nz, break139   ; 3:10      D= while 139
    ld   BC, string108  ; 3:10      print_i   Address of string144 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
    jp   break139       ; 3:10      break 139
    jp   begin139       ; 3:10      again 139
break139:               ;           again 139
begin140:               ;           begin 140
            ;[21:51,66,123,122/122] 4dup D<> while 140   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast
    pop  BC             ; 1:10      4dup D<> while 140   h2       . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while 140   h2       . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while 140   h2       . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> while 140   h2       . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> while 140   h2       . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while 140   h2       . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> while 140   h2       . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> while 140   l1       . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> while 140   l1       . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while 140   l1       . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> while 140   l1       . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> while 140   h2       . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> while 140   h2       . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> while 140   h2       . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> while 140   h2 l2    . h1 l1
    jp    z, break140   ; 3:10      4dup D<> while 140
    ld   BC, string109  ; 3:10      print_i   Address of string145 ending with inverted most significant bit == string109
    call PRINT_STRING_I ; 3:17      print_i
    jp   break140       ; 3:10      break 140
    jp   begin140       ; 3:10      again 140
break140:               ;           again 140
begin141:               ;           begin 141
            ;[21:51,66,123,122/122] 4dup D<> while 141   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast
    pop  BC             ; 1:10      4dup D<> while 141   h2       . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while 141   h2       . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while 141   h2       . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> while 141   h2       . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> while 141   h2       . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while 141   h2       . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> while 141   h2       . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> while 141   l1       . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> while 141   l1       . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while 141   l1       . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> while 141   l1       . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> while 141   h2       . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> while 141   h2       . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> while 141   h2       . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> while 141   h2 l2    . h1 l1
    jp    z, break141   ; 3:10      4dup D<> while 141
    ld   BC, string109  ; 3:10      print_i   Address of string146 ending with inverted most significant bit == string109
    call PRINT_STRING_I ; 3:17      print_i
    jp   break141       ; 3:10      break 141
    jp   begin141       ; 3:10      again 141
break141:               ;           again 141
begin142:               ;           begin 142
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[14:91]     D<> while 142   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> while 142   lo_2
    or    A             ; 1:4       D<> while 142
    sbc  HL, BC         ; 2:15      D<> while 142   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> zero if false
    pop  HL             ; 1:10      D<> while 142   hi_2
    jr   nz, $+4        ; 2:7/12    D<> while 142
    sbc  HL, DE         ; 2:15      D<> while 142   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> zero if false
    pop  HL             ; 1:10      D<> while 142
    pop  DE             ; 1:10      D<> while 142
    jp    z, break142   ; 3:10      D<> while 142
    ld   BC, string111  ; 3:10      print_i   Address of string147 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
    jp   break142       ; 3:10      break 142
    jp   begin142       ; 3:10      again 142
break142:               ;           again 142
begin143:               ;           begin 143
                        ;[6:27]     4dup D< while 143   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< while 143   no carry if false
    jp   nc, break143   ; 3:10      4dup D< while 143
    ld   BC, string112  ; 3:10      print_i   Address of string148 ending with inverted most significant bit == string112
    call PRINT_STRING_I ; 3:17      print_i
    jp   break143       ; 3:10      break 143
    jp   begin143       ; 3:10      again 143
break143:               ;           again 143
begin144:               ;           begin 144
                        ;[6:27]     4dup D< while 144   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D< while 144   no carry if false
    jp   nc, break144   ; 3:10      4dup D< while 144
    ld   BC, string112  ; 3:10      print_i   Address of string149 ending with inverted most significant bit == string112
    call PRINT_STRING_I ; 3:17      print_i
    jp   break144       ; 3:10      break 144
    jp   begin144       ; 3:10      again 144
break144:               ;           again 144
begin145:               ;           begin 145
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[10:67]     D< while 145   ( d2 d1 -- )
    pop  BC             ; 1:10      D< while 145   l2
    pop  AF             ; 1:10      D< while 145   h2
    call FCE_DLT        ; 3:17      D< while 145   no carry if false
    pop  HL             ; 1:10      D< while 145
    pop  DE             ; 1:10      D< while 145
    jp   nc, break145   ; 3:10      D< while 145
    ld   BC, string114  ; 3:10      print_i   Address of string150 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
    jp   break145       ; 3:10      break 145
    jp   begin145       ; 3:10      again 145
break145:               ;           again 145
begin146:               ;           begin 146
                        ;[6:27]     4dup D<= while 146   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= while 146   D> carry if true --> D<= carry if false
    jp    c, break146   ; 3:10      4dup D<= while 146
    ld   BC, string115  ; 3:10      print_i   Address of string151 ending with inverted most significant bit == string115
    call PRINT_STRING_I ; 3:17      print_i
    jp   break146       ; 3:10      break 146
    jp   begin146       ; 3:10      again 146
break146:               ;           again 146
begin147:               ;           begin 147
                        ;[6:27]     4dup D<= while 147   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D<= while 147   D> carry if true --> D<= carry if false
    jp    c, break147   ; 3:10      4dup D<= while 147
    ld   BC, string115  ; 3:10      print_i   Address of string152 ending with inverted most significant bit == string115
    call PRINT_STRING_I ; 3:17      print_i
    jp   break147       ; 3:10      break 147
    jp   begin147       ; 3:10      again 147
break147:               ;           again 147
begin148:               ;           begin 148
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[10:67]     D<= while 148   ( d2 d1 -- )
    pop  BC             ; 1:10      D<= while 148   l2
    pop  AF             ; 1:10      D<= while 148   h2
    call FCE_DGT        ; 3:17      D<= while 148   D> carry if true --> D<= carry if false
    pop  HL             ; 1:10      D<= while 148
    pop  DE             ; 1:10      D<= while 148
    jp    c, break148   ; 3:10      D<= while 148
    ld   BC, string117  ; 3:10      print_i   Address of string153 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
    jp   break148       ; 3:10      break 148
    jp   begin148       ; 3:10      again 148
break148:               ;           again 148
begin149:               ;           begin 149
                        ;[6:27]     4dup D> while 149   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> while 149   no carry if false
    jp   nc, break149   ; 3:10      4dup D> while 149
    ld   BC, string118  ; 3:10      print_i   Address of string154 ending with inverted most significant bit == string118
    call PRINT_STRING_I ; 3:17      print_i
    jp   break149       ; 3:10      break 149
    jp   begin149       ; 3:10      again 149
break149:               ;           again 149
begin150:               ;           begin 150
                        ;[6:27]     4dup D> while 150   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DGT   ; 3:17      4dup D> while 150   no carry if false
    jp   nc, break150   ; 3:10      4dup D> while 150
    ld   BC, string118  ; 3:10      print_i   Address of string155 ending with inverted most significant bit == string118
    call PRINT_STRING_I ; 3:17      print_i
    jp   break150       ; 3:10      break 150
    jp   begin150       ; 3:10      again 150
break150:               ;           again 150
begin151:               ;           begin 151
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[10:67]     D> while 151   ( d2 d1 -- )
    pop  BC             ; 1:10      D> while 151   l2
    pop  AF             ; 1:10      D> while 151   h2
    call FCE_DGT        ; 3:17      D> while 151   no carry if false
    pop  HL             ; 1:10      D> while 151
    pop  DE             ; 1:10      D> while 151
    jp   nc, break151   ; 3:10      D> while 151
    ld   BC, string120  ; 3:10      print_i   Address of string156 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
    jp   break151       ; 3:10      break 151
    jp   begin151       ; 3:10      again 151
break151:               ;           again 151
begin152:               ;           begin 152
                        ;[6:27]     4dup D>= while 152   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= while 152   D< carry if true --> D>= carry if false
    jp    c, break152   ; 3:10      4dup D>= while 152
    ld   BC, string121  ; 3:10      print_i   Address of string157 ending with inverted most significant bit == string121
    call PRINT_STRING_I ; 3:17      print_i
    jp   break152       ; 3:10      break 152
    jp   begin152       ; 3:10      again 152
break152:               ;           again 152
begin153:               ;           begin 153
                        ;[6:27]     4dup D>= while 153   ( d2 d1 -- d2 d1 )
    call FCE_4DUP_DLT   ; 3:17      4dup D>= while 153   D< carry if true --> D>= carry if false
    jp    c, break153   ; 3:10      4dup D>= while 153
    ld   BC, string121  ; 3:10      print_i   Address of string158 ending with inverted most significant bit == string121
    call PRINT_STRING_I ; 3:17      print_i
    jp   break153       ; 3:10      break 153
    jp   begin153       ; 3:10      again 153
break153:               ;           again 153
begin154:               ;           begin 154
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[10:67]     D>= while 154   ( d2 d1 -- )
    pop  BC             ; 1:10      D>= while 154   l2
    pop  AF             ; 1:10      D>= while 154   h2
    call FCE_DLT        ; 3:17      D>= while 154   D< carry if true --> D>= carry if false
    pop  HL             ; 1:10      D>= while 154
    pop  DE             ; 1:10      D>= while 154
    jp    c, break154   ; 3:10      D>= while 154
    ld   BC, string123  ; 3:10      print_i   Address of string159 ending with inverted most significant bit == string123
    call PRINT_STRING_I ; 3:17      print_i
    jp   break154       ; 3:10      break 154
    jp   begin154       ; 3:10      again 154
break154:               ;           again 154
                        ;[9:91]     2over   ( d c b a -- d c b a d c )
    pop  AF             ; 1:10      2over   d       . b a     AF = c
    pop  BC             ; 1:10      2over           . b a     BC = d
    push BC             ; 1:11      2over   d       . b a
    push AF             ; 1:11      2over   d c     . b a
    push DE             ; 1:11      2over   d c b   . b a
    push AF             ; 1:11      2over   d c b c . b a
    ex  (SP),HL         ; 1:19      2over   d c b a . b c
    ld    D, B          ; 1:4       2over
    ld    E, C          ; 1:4       2over   d c b a . d c
    call PRT_S32        ; 3:17      d.   ( d -- )
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup   ( b a -- b a b a )
    call PRT_SP_S32     ; 3:17      space d.   ( d -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
begin155:               ;           begin 155
                   ;[16:132/73,132] 4dup D= while 155   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= while 155   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= while 155   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= while 155   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= while 155   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= while 155   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= while 155   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= while 155   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= while 155   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= while 155   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= while 155   h2 l2 . h1 l1
    jp   nz, break155   ; 3:10      4dup D= while 155   h2 l2 . h1 l1
    ld   BC, string106  ; 3:10      print_i   Address of string160 ending with inverted most significant bit == string106
    call PRINT_STRING_I ; 3:17      print_i
    jp   break155       ; 3:10      break 155
    jp   begin155       ; 3:10      again 155
break155:               ;           again 155
begin156:               ;           begin 156
                   ;[16:132/73,132] 4dup D= while 156   ( d2 d1 -- d2 d1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    or   A              ; 1:4       4dup D= while 156   h2 l2 . h1 l1
    pop  BC             ; 1:10      4dup D= while 156   h2    . h1 l1  BC = l2 = lo16(d2)
    sbc  HL, BC         ; 2:15      4dup D= while 156   h2    . h1 --  cp l1-l2
    add  HL, BC         ; 1:11      4dup D= while 156   h2    . h1 l1  cp l1-l2
    jr   nz, $+7        ; 2:7/12    4dup D= while 156   h2    . h1 h2
    ex  (SP),HL         ; 1:19      4dup D= while 156   l1    . h1 h2  HL = h2 = hi16(d2)
    sbc  HL, DE         ; 2:15      4dup D= while 156   l1    . h1 --  cp h2-h1
    add  HL, DE         ; 1:11      4dup D= while 156   l1    . h1 h2  cp h2-h1
    ex  (SP),HL         ; 1:19      4dup D= while 156   h2    . h1 l1  HL = l1
    push BC             ; 1:11      4dup D= while 156   h2 l2 . h1 l1
    jp   nz, break156   ; 3:10      4dup D= while 156   h2 l2 . h1 l1
    ld   BC, string106  ; 3:10      print_i   Address of string161 ending with inverted most significant bit == string106
    call PRINT_STRING_I ; 3:17      print_i
    jp   break156       ; 3:10      break 156
    jp   begin156       ; 3:10      again 156
break156:               ;           again 156
begin157:               ;           begin 157
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[14:91]     D= while 157   ( d2 d1 -- )
    pop  BC             ; 1:10      D= while 157   lo_2
    or    A             ; 1:4       D= while 157
    sbc  HL, BC         ; 2:15      D= while 157   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> no zero if false
    pop  HL             ; 1:10      D= while 157   hi_2
    jr   nz, $+4        ; 2:7/12    D= while 157
    sbc  HL, DE         ; 2:15      D= while 157   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> no zero if false
    pop  HL             ; 1:10      D= while 157
    pop  DE             ; 1:10      D= while 157
    jp   nz, break157   ; 3:10      D= while 157
    ld   BC, string108  ; 3:10      print_i   Address of string162 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
    jp   break157       ; 3:10      break 157
    jp   begin157       ; 3:10      again 157
break157:               ;           again 157
begin158:               ;           begin 158
            ;[21:51,66,123,122/122] 4dup D<> while 158   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast
    pop  BC             ; 1:10      4dup D<> while 158   h2       . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while 158   h2       . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while 158   h2       . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> while 158   h2       . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> while 158   h2       . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while 158   h2       . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> while 158   h2       . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> while 158   l1       . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> while 158   l1       . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while 158   l1       . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> while 158   l1       . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> while 158   h2       . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> while 158   h2       . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> while 158   h2       . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> while 158   h2 l2    . h1 l1
    jp    z, break158   ; 3:10      4dup D<> while 158
    ld   BC, string109  ; 3:10      print_i   Address of string163 ending with inverted most significant bit == string109
    call PRINT_STRING_I ; 3:17      print_i
    jp   break158       ; 3:10      break 158
    jp   begin158       ; 3:10      again 158
break158:               ;           again 158
begin159:               ;           begin 159
            ;[21:51,66,123,122/122] 4dup D<> while 159   ( d2 d1 -- d2 d1 )   # "define({_TYP_DOUBLE},{default})" version can be changed with function,small,fast
    pop  BC             ; 1:10      4dup D<> while 159   h2       . h1 l1  BC= lo(d2) = l2
    ld    A, C          ; 1:4       4dup D<> while 159   h2       . h1 l1  A = lo(l2)
    sub   L             ; 1:4       4dup D<> while 159   h2       . h1 l1  lo(l2) - lo(l1)
    jr   nz, $+14       ; 2:7/12    4dup D<> while 159   h2       . h1 l1  --> push bc
    ld    A, B          ; 1:4       4dup D<> while 159   h2       . h1 l1  A = hi(l2)
    sub   H             ; 1:4       4dup D<> while 159   h2       . h1 l1  hi(l2) - hi(l1)
    jr   nz, $+10       ; 2:7/12    4dup D<> while 159   h2       . h1 l1  --> push bc
    ex (SP), HL         ; 1:19      4dup D<> while 159   l1       . h1 h2  HL= hi(d2) = h2
    ld    A, L          ; 1:4       4dup D<> while 159   l1       . h1 h2  A = lo(h2)
    sub   E             ; 1:4       4dup D<> while 159   l1       . h1 h2  lo(h2) - lo(l1)
    ld    A, H          ; 1:4       4dup D<> while 159   l1       . h1 h2  A = hi(h2)
    ex (SP), HL         ; 1:19      4dup D<> while 159   h2       . h1 l1
    jr   nz, $+3        ; 2:7/12    4dup D<> while 159   h2       . h1 l1  --> push bc
    sub   D             ; 1:4       4dup D<> while 159   h2       . h1 l1  hi(h2) - hi(h1)
    push BC             ; 1:11      4dup D<> while 159   h2 l2    . h1 l1
    jp    z, break159   ; 3:10      4dup D<> while 159
    ld   BC, string109  ; 3:10      print_i   Address of string164 ending with inverted most significant bit == string109
    call PRINT_STRING_I ; 3:17      print_i
    jp   break159       ; 3:10      break 159
    jp   begin159       ; 3:10      again 159
break159:               ;           again 159
begin160:               ;           begin 160
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[14:91]     D<> while 160   ( d2 d1 -- )
    pop  BC             ; 1:10      D<> while 160   lo_2
    or    A             ; 1:4       D<> while 160
    sbc  HL, BC         ; 2:15      D<> while 160   lo_2=lo_1 --> BC=HL --> 0=HL-BC --> zero if false
    pop  HL             ; 1:10      D<> while 160   hi_2
    jr   nz, $+4        ; 2:7/12    D<> while 160
    sbc  HL, DE         ; 2:15      D<> while 160   hi_2=hi_1 --> DE=HL --> 0=HL-DE --> zero if false
    pop  HL             ; 1:10      D<> while 160
    pop  DE             ; 1:10      D<> while 160
    jp    z, break160   ; 3:10      D<> while 160
    ld   BC, string111  ; 3:10      print_i   Address of string165 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
    jp   break160       ; 3:10      break 160
    jp   begin160       ; 3:10      again 160
break160:               ;           again 160
begin161:               ;           begin 161
                       ;[15:101]    4dup Du< while 161   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du< while 161   ud2 < ud1 --> ud2-ud1<0 --> (SP)BC-DEHL<0 --> no carry if false
    ld    A, C          ; 1:4       4dup Du< while 161
    sub   L             ; 1:4       4dup Du< while 161   C-L<0 --> no carry if false
    ld    A, B          ; 1:4       4dup Du< while 161
    sbc   A, H          ; 1:4       4dup Du< while 161   B-H<0 --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du< while 161   HL = hi2
    ld    A, L          ; 1:4       4dup Du< while 161   HLBC-DE(SP)<0 -- no carry if false
    sbc   A, E          ; 1:4       4dup Du< while 161   L-E<0 --> no carry if false
    ld    A, H          ; 1:4       4dup Du< while 161
    sbc   A, D          ; 1:4       4dup Du< while 161   H-D<0 --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du< while 161
    push BC             ; 1:11      4dup Du< while 161
    jp   nc, break161   ; 3:10      4dup Du< while 161
    ld   BC, string112  ; 3:10      print_i   Address of string166 ending with inverted most significant bit == string112
    call PRINT_STRING_I ; 3:17      print_i
    jp   break161       ; 3:10      break 161
    jp   begin161       ; 3:10      again 161
break161:               ;           again 161
begin162:               ;           begin 162
                       ;[15:101]    4dup Du< while 162   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du< while 162   ud2 < ud1 --> ud2-ud1<0 --> (SP)BC-DEHL<0 --> no carry if false
    ld    A, C          ; 1:4       4dup Du< while 162
    sub   L             ; 1:4       4dup Du< while 162   C-L<0 --> no carry if false
    ld    A, B          ; 1:4       4dup Du< while 162
    sbc   A, H          ; 1:4       4dup Du< while 162   B-H<0 --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du< while 162   HL = hi2
    ld    A, L          ; 1:4       4dup Du< while 162   HLBC-DE(SP)<0 -- no carry if false
    sbc   A, E          ; 1:4       4dup Du< while 162   L-E<0 --> no carry if false
    ld    A, H          ; 1:4       4dup Du< while 162
    sbc   A, D          ; 1:4       4dup Du< while 162   H-D<0 --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du< while 162
    push BC             ; 1:11      4dup Du< while 162
    jp   nc, break162   ; 3:10      4dup Du< while 162
    ld   BC, string112  ; 3:10      print_i   Address of string167 ending with inverted most significant bit == string112
    call PRINT_STRING_I ; 3:17      print_i
    jp   break162       ; 3:10      break 162
    jp   begin162       ; 3:10      again 162
break162:               ;           again 162
begin163:               ;           begin 163
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[13:81]     Du< while 163   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du< while 163   lo_2
    ld    A, C          ; 1:4       Du< while 163   d2<d1 --> d2-d1<0 --> (SP)BC-DEHL<0 --> no carry if false
    sub   L             ; 1:4       Du< while 163   C-L<0 --> no carry if false
    ld    A, B          ; 1:4       Du< while 163
    sbc   A, H          ; 1:4       Du< while 163   B-H<0 --> no carry if false
    pop  HL             ; 1:10      Du< while 163   hi_2
    sbc  HL, DE         ; 2:15      Du< while 163   HL-DE<0 --> no carry if false
    pop  HL             ; 1:10      Du< while 163
    pop  DE             ; 1:10      Du< while 163
    jp   nc, break163   ; 3:10      Du< while 163
    ld   BC, string114  ; 3:10      print_i   Address of string168 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
    jp   break163       ; 3:10      break 163
    jp   begin163       ; 3:10      again 163
break163:               ;           again 163
begin164:               ;           begin 164
                       ;[15:101]    4dup Du<= while 164   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du<= while 164   ud2 <= ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> carry if false
    ld    A, L          ; 1:4       4dup Du<= while 164
    sub   C             ; 1:4       4dup Du<= while 164   0<=L-C --> carry if false
    ld    A, H          ; 1:4       4dup Du<= while 164
    sbc   A, B          ; 1:4       4dup Du<= while 164   0<=H-B --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du<= while 164   HL = hi2
    ld    A, E          ; 1:4       4dup Du<= while 164   0<=DE(SP)-HLBC -- carry if false
    sbc   A, L          ; 1:4       4dup Du<= while 164   0<=E-L --> carry if false
    ld    A, D          ; 1:4       4dup Du<= while 164
    sbc   A, H          ; 1:4       4dup Du<= while 164   0<=D-H --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du<= while 164
    push BC             ; 1:11      4dup Du<= while 164
    jp    c, break164   ; 3:10      4dup Du<= while 164
    ld   BC, string115  ; 3:10      print_i   Address of string169 ending with inverted most significant bit == string115
    call PRINT_STRING_I ; 3:17      print_i
    jp   break164       ; 3:10      break 164
    jp   begin164       ; 3:10      again 164
break164:               ;           again 164
begin165:               ;           begin 165
                       ;[15:101]    4dup Du<= while 165   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du<= while 165   ud2 <= ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> carry if false
    ld    A, L          ; 1:4       4dup Du<= while 165
    sub   C             ; 1:4       4dup Du<= while 165   0<=L-C --> carry if false
    ld    A, H          ; 1:4       4dup Du<= while 165
    sbc   A, B          ; 1:4       4dup Du<= while 165   0<=H-B --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du<= while 165   HL = hi2
    ld    A, E          ; 1:4       4dup Du<= while 165   0<=DE(SP)-HLBC -- carry if false
    sbc   A, L          ; 1:4       4dup Du<= while 165   0<=E-L --> carry if false
    ld    A, D          ; 1:4       4dup Du<= while 165
    sbc   A, H          ; 1:4       4dup Du<= while 165   0<=D-H --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du<= while 165
    push BC             ; 1:11      4dup Du<= while 165
    jp    c, break165   ; 3:10      4dup Du<= while 165
    ld   BC, string115  ; 3:10      print_i   Address of string170 ending with inverted most significant bit == string115
    call PRINT_STRING_I ; 3:17      print_i
    jp   break165       ; 3:10      break 165
    jp   begin165       ; 3:10      again 165
break165:               ;           again 165
begin166:               ;           begin 166
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[13:88]     Du<= while 166   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du<= while 166   lo_2
    or    A             ; 1:4       Du<= while 166
    sbc  HL, BC         ; 2:15      Du<= while 166   ud2<=ud1 --> 0<=ud1-ud2 --> 0<=DEHL-(SP)BC --> carry if false
    pop  BC             ; 1:10      Du<= while 166   hi_2
    ex   DE, HL         ; 1:4       Du<= while 166
    sbc  HL, BC         ; 2:15      Du<= while 166   hi_2<=hi_1 --> BC<=HL --> 0<=HL-BC --> carry if false
    pop  HL             ; 1:10      Du<= while 166
    pop  DE             ; 1:10      Du<= while 166
    jp    c, break166   ; 3:10      Du<= while 166
    ld   BC, string117  ; 3:10      print_i   Address of string171 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
    jp   break166       ; 3:10      break 166
    jp   begin166       ; 3:10      again 166
break166:               ;           again 166
begin167:               ;           begin 167
                       ;[15:101]    4dup Du> while 167   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du> while 167   ud2 > ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> no carry if false
    ld    A, L          ; 1:4       4dup Du> while 167
    sub   C             ; 1:4       4dup Du> while 167   0>L-C --> no carry if false
    ld    A, H          ; 1:4       4dup Du> while 167
    sbc   A, B          ; 1:4       4dup Du> while 167   0>H-B --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du> while 167   HL = hi2
    ld    A, E          ; 1:4       4dup Du> while 167   0>DE(SP)-HLBC -- no carry if false
    sbc   A, L          ; 1:4       4dup Du> while 167   0>E-L --> no carry if false
    ld    A, D          ; 1:4       4dup Du> while 167
    sbc   A, H          ; 1:4       4dup Du> while 167   0>D-H --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du> while 167
    push BC             ; 1:11      4dup Du> while 167
    jp   nc, break167   ; 3:10      4dup Du> while 167
    ld   BC, string118  ; 3:10      print_i   Address of string172 ending with inverted most significant bit == string118
    call PRINT_STRING_I ; 3:17      print_i
    jp   break167       ; 3:10      break 167
    jp   begin167       ; 3:10      again 167
break167:               ;           again 167
begin168:               ;           begin 168
                       ;[15:101]    4dup Du> while 168   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du> while 168   ud2 > ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> no carry if false
    ld    A, L          ; 1:4       4dup Du> while 168
    sub   C             ; 1:4       4dup Du> while 168   0>L-C --> no carry if false
    ld    A, H          ; 1:4       4dup Du> while 168
    sbc   A, B          ; 1:4       4dup Du> while 168   0>H-B --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du> while 168   HL = hi2
    ld    A, E          ; 1:4       4dup Du> while 168   0>DE(SP)-HLBC -- no carry if false
    sbc   A, L          ; 1:4       4dup Du> while 168   0>E-L --> no carry if false
    ld    A, D          ; 1:4       4dup Du> while 168
    sbc   A, H          ; 1:4       4dup Du> while 168   0>D-H --> no carry if false
    ex  (SP),HL         ; 1:19      4dup Du> while 168
    push BC             ; 1:11      4dup Du> while 168
    jp   nc, break168   ; 3:10      4dup Du> while 168
    ld   BC, string118  ; 3:10      print_i   Address of string173 ending with inverted most significant bit == string118
    call PRINT_STRING_I ; 3:17      print_i
    jp   break168       ; 3:10      break 168
    jp   begin168       ; 3:10      again 168
break168:               ;           again 168
begin169:               ;           begin 169
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[13:88]     Du> while 169   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du> while 169   lo_2
    or    A             ; 1:4       Du> while 169
    sbc  HL, BC         ; 2:15      Du> while 169   ud2>ud1 --> 0>ud1-ud2 --> 0>DEHL-(SP)BC --> no carry if false
    pop  BC             ; 1:10      Du> while 169   hi_2
    ex   DE, HL         ; 1:4       Du> while 169
    sbc  HL, BC         ; 2:15      Du> while 169   hi_2>hi_1 --> BC>HL --> 0>HL-BC --> no carry if false
    pop  HL             ; 1:10      Du> while 169
    pop  DE             ; 1:10      Du> while 169
    jp   nc, break169   ; 3:10      Du> while 169
    ld   BC, string120  ; 3:10      print_i   Address of string174 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
    jp   break169       ; 3:10      break 169
    jp   begin169       ; 3:10      again 169
break169:               ;           again 169
begin170:               ;           begin 170
                       ;[15:101]    4dup Du>= while 170   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du>= while 170   ud2 >= ud1 --> ud2-ud1>=0 --> (SP)BC-DEHL>=0 --> carry if false
    ld    A, C          ; 1:4       4dup Du>= while 170
    sub   L             ; 1:4       4dup Du>= while 170   C-L>=0 --> carry if false
    ld    A, B          ; 1:4       4dup Du>= while 170
    sbc   A, H          ; 1:4       4dup Du>= while 170   B-H>=0 --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du>= while 170   HL = hi2
    ld    A, L          ; 1:4       4dup Du>= while 170   HLBC-DE(SP)>=0 -- carry if false
    sbc   A, E          ; 1:4       4dup Du>= while 170   L-E>=0 --> carry if false
    ld    A, H          ; 1:4       4dup Du>= while 170
    sbc   A, D          ; 1:4       4dup Du>= while 170   H-D>=0 --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du>= while 170
    push BC             ; 1:11      4dup Du>= while 170
    jp    c, break170   ; 3:10      4dup Du>= while 170
    ld   BC, string121  ; 3:10      print_i   Address of string175 ending with inverted most significant bit == string121
    call PRINT_STRING_I ; 3:17      print_i
    jp   break170       ; 3:10      break 170
    jp   begin170       ; 3:10      again 170
break170:               ;           again 170
begin171:               ;           begin 171
                       ;[15:101]    4dup Du>= while 171   ( ud2 ud1 -- ud2 ud1 )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      4dup Du>= while 171   ud2 >= ud1 --> ud2-ud1>=0 --> (SP)BC-DEHL>=0 --> carry if false
    ld    A, C          ; 1:4       4dup Du>= while 171
    sub   L             ; 1:4       4dup Du>= while 171   C-L>=0 --> carry if false
    ld    A, B          ; 1:4       4dup Du>= while 171
    sbc   A, H          ; 1:4       4dup Du>= while 171   B-H>=0 --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du>= while 171   HL = hi2
    ld    A, L          ; 1:4       4dup Du>= while 171   HLBC-DE(SP)>=0 -- carry if false
    sbc   A, E          ; 1:4       4dup Du>= while 171   L-E>=0 --> carry if false
    ld    A, H          ; 1:4       4dup Du>= while 171
    sbc   A, D          ; 1:4       4dup Du>= while 171   H-D>=0 --> carry if false
    ex  (SP),HL         ; 1:19      4dup Du>= while 171
    push BC             ; 1:11      4dup Du>= while 171
    jp    c, break171   ; 3:10      4dup Du>= while 171
    ld   BC, string121  ; 3:10      print_i   Address of string176 ending with inverted most significant bit == string121
    call PRINT_STRING_I ; 3:17      print_i
    jp   break171       ; 3:10      break 171
    jp   begin171       ; 3:10      again 171
break171:               ;           again 171
begin172:               ;           begin 172
                        ;[8:86]     4dup   ( d c b a -- d c b a d c b a )
    pop  BC             ; 1:10      4dup
    pop  AF             ; 1:10      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
    push DE             ; 1:11      4dup
    push HL             ; 1:11      4dup
    push AF             ; 1:11      4dup
    push BC             ; 1:11      4dup
                       ;[13:81]     Du>= while 172   ( ud2 ud1 -- )   # default version can be changed with "define({_TYP_DOUBLE},{function})"
    pop  BC             ; 1:10      Du>= while 172   lo_2
    ld    A, C          ; 1:4       Du>= while 172   d2>=d1 --> d2-d1>=0 --> (SP)BC-DEHL>=0 --> carry if false
    sub   L             ; 1:4       Du>= while 172   C-L>=0 --> carry if false
    ld    A, B          ; 1:4       Du>= while 172
    sbc   A, H          ; 1:4       Du>= while 172   B-H>=0 --> carry if false
    pop  HL             ; 1:10      Du>= while 172   hi_2
    sbc  HL, DE         ; 2:15      Du>= while 172   HL-DE>=0 --> carry if false
    pop  HL             ; 1:10      Du>= while 172
    pop  DE             ; 1:10      Du>= while 172
    jp    c, break172   ; 3:10      Du>= while 172
    ld   BC, string123  ; 3:10      print_i   Address of string177 ending with inverted most significant bit == string123
    call PRINT_STRING_I ; 3:17      print_i
    jp   break172       ; 3:10      break 172
    jp   begin172       ; 3:10      again 172
break172:               ;           again 172
                        ;[6:67]     2swap   ( d c b a -- b a d c ) # default version can be changed with "define({TYP_2SWAP},{name})", name=fast
    ex  (SP),HL         ; 1:19      2swap   d a . b c
    ex   DE, HL         ; 1:4       2swap   d a . c b
    pop  AF             ; 1:10      2swap   d   . c b     AF = a
    ex  (SP),HL         ; 1:19      2swap   b   . c d
    ex   DE, HL         ; 1:4       2swap   b   . d c
    push AF             ; 1:11      2swap   b a . d c
    call PRT_U32        ; 3:17      ud.   ( ud -- )
    call PRT_SP_U32     ; 3:17      space ud.   ( ud -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
d_d_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
x_p3_test:              ;           
    pop  BC             ; 1:10      : ret
    ld  (x_p3_test_end+1),BC; 4:20      : ( ret -- )
begin173:               ;           begin 173
                        ;[7:25]     dup 3 = while 173   ( x1 -- x1 )   3 == HL
    ld    A, 0x03       ; 2:7       dup 3 = while 173
    xor   L             ; 1:4       dup 3 = while 173   x[1] = 0x03
    or    H             ; 1:4       dup 3 = while 173   x[2] = 0
    jp   nz, break173   ; 3:10      dup 3 = while 173
    ld   BC, string108  ; 3:10      print_i   Address of string178 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
    jp   break173       ; 3:10      break 173
    jp   begin173       ; 3:10      again 173
break173:               ;           again 173
begin174:               ;           begin 174
                        ;[7:25]     dup 3 <> while 174   ( x1 -- x1 )   3 <> HL
    ld    A, 0x03       ; 2:7       dup 3 <> while 174
    xor   L             ; 1:4       dup 3 <> while 174   x[1] = 0x03
    or    H             ; 1:4       dup 3 <> while 174   x[2] = 0
    jp    z, break174   ; 3:10      dup 3 <> while 174
    ld   BC, string111  ; 3:10      print_i   Address of string179 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
    jp   break174       ; 3:10      break 174
    jp   begin174       ; 3:10      again 174
break174:               ;           again 174
begin175:               ;           begin 175
                       ;[11:40]     dup 3 < while 175    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
    ld    A, L          ; 1:4       dup 3 < while 175    HL<3 --> HL-3<0 --> no carry if false
    sub   low 3         ; 2:7       dup 3 < while 175    HL<3 --> HL-3<0 --> no carry if false
    ld    A, H          ; 1:4       dup 3 < while 175    HL<3 --> HL-3<0 --> no carry if false
    sbc   A, high 3     ; 2:7       dup 3 < while 175    HL<3 --> HL-3<0 --> no carry if false
    rra                 ; 1:4       dup 3 < while 175
    xor   H             ; 1:4       dup 3 < while 175    invert sign if x is negative
    jp    p, break175   ; 3:10      dup 3 < while 101    positive constant --> no sign if false
    ld   BC, string114  ; 3:10      print_i   Address of string180 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
    jp   break175       ; 3:10      break 175
    jp   begin175       ; 3:10      again 175
break175:               ;           again 175
begin176:               ;           begin 176
                       ;[11:40]     dup 3 <= while 176    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
    ld    A, low 3      ; 2:7       dup 3 <= while 176    HL<=3 --> 0<=3-HL --> carry if false
    sub   L             ; 1:4       dup 3 <= while 176    HL<=3 --> 0<=3-HL --> carry if false
    ld    A, high 3     ; 2:7       dup 3 <= while 176    HL<=3 --> 0<=3-HL --> carry if false
    sbc   A, H          ; 1:4       dup 3 <= while 176    HL<=3 --> 0<=3-HL --> carry if false
    rra                 ; 1:4       dup 3 <= while 176
    xor   H             ; 1:4       dup 3 <= while 176    invert sign if x is negative
    jp    m, break176   ; 3:10      dup 3 <= while 101    positive constant --> sign if false
    ld   BC, string117  ; 3:10      print_i   Address of string181 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
    jp   break176       ; 3:10      break 176
    jp   begin176       ; 3:10      again 176
break176:               ;           again 176
begin177:               ;           begin 177
                       ;[11:40]     dup 3 > while 177    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
    ld    A, low 3      ; 2:7       dup 3 > while 177    HL>3 --> 0>3-HL --> no carry if false
    sub   L             ; 1:4       dup 3 > while 177    HL>3 --> 0>3-HL --> no carry if false
    ld    A, high 3     ; 2:7       dup 3 > while 177    HL>3 --> 0>3-HL --> no carry if false
    sbc   A, H          ; 1:4       dup 3 > while 177    HL>3 --> 0>3-HL --> no carry if false
    rra                 ; 1:4       dup 3 > while 177
    xor   H             ; 1:4       dup 3 > while 177    invert sign if x is negative
    jp    p, break177   ; 3:10      dup 3 > while 101    positive constant --> no sign if false
    ld   BC, string120  ; 3:10      print_i   Address of string182 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
    jp   break177       ; 3:10      break 177
    jp   begin177       ; 3:10      again 177
break177:               ;           again 177
begin178:               ;           begin 178
                       ;[11:40]     dup 3 >= while 178    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
    ld    A, L          ; 1:4       dup 3 >= while 178    HL>=3 --> HL-3>=0 --> carry if false
    sub   low 3         ; 2:7       dup 3 >= while 178    HL>=3 --> HL-3>=0 --> carry if false
    ld    A, H          ; 1:4       dup 3 >= while 178    HL>=3 --> HL-3>=0 --> carry if false
    sbc   A, high 3     ; 2:7       dup 3 >= while 178    HL>=3 --> HL-3>=0 --> carry if false
    rra                 ; 1:4       dup 3 >= while 178
    xor   H             ; 1:4       dup 3 >= while 178    invert sign if x is negative
    jp    m, break178   ; 3:10      dup 3 >= while 101    positive constant --> sign if false
    ld   BC, string123  ; 3:10      print_i   Address of string183 ending with inverted most significant bit == string123
    call PRINT_STRING_I ; 3:17      print_i
    jp   break178       ; 3:10      break 178
    jp   begin178       ; 3:10      again 178
break178:               ;           again 178
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    ld   BC, string184  ; 3:10      print_i   Address of string184 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
begin179:               ;           begin 179
                        ;[7:25]     dup 3 u= while   ( x1 -- x1 )   3 == HL
    ld    A, 0x03       ; 2:7       dup 3 u= while
    xor   L             ; 1:4       dup 3 u= while   x[1] = 0x03
    or    H             ; 1:4       dup 3 u= while   x[2] = 0
    jp   nz, break179   ; 3:10      dup 3 u= while
    ld   BC, string108  ; 3:10      print_i   Address of string185 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
    jp   break179       ; 3:10      break 179
    jp   begin179       ; 3:10      again 179
break179:               ;           again 179
begin180:               ;           begin 180
                        ;[7:25]     dup 3 u<> while   ( x1 -- x1 )   3 <> HL
    ld    A, 0x03       ; 2:7       dup 3 u<> while
    xor   L             ; 1:4       dup 3 u<> while   x[1] = 0x03
    or    H             ; 1:4       dup 3 u<> while   x[2] = 0
    jp    z, break180   ; 3:10      dup 3 u<> while
    ld   BC, string111  ; 3:10      print_i   Address of string186 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
    jp   break180       ; 3:10      break 180
    jp   begin180       ; 3:10      again 180
break180:               ;           again 180
begin181:               ;           begin 181
    ld    A, L          ; 1:4       dup 3 u< while 181    HL<3 --> HL-3<0 --> no carry if false
    sub   low 3         ; 2:7       dup 3 u< while 181    HL<3 --> HL-3<0 --> no carry if false
    ld    A, H          ; 1:4       dup 3 u< while 181    HL<3 --> HL-3<0 --> no carry if false
    sbc   A, high 3     ; 2:7       dup 3 u< while 181    HL<3 --> HL-3<0 --> no carry if false
    jp   nc, break181   ; 3:10      dup 3 u< while 181
    ld   BC, string114  ; 3:10      print_i   Address of string187 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
    jp   break181       ; 3:10      break 181
    jp   begin181       ; 3:10      again 181
break181:               ;           again 181
begin182:               ;           begin 182
    ld    A, low 3      ; 2:7       dup 3 u<= while 182    HL<=3 --> 0<=3-HL --> carry if false
    sub   L             ; 1:4       dup 3 u<= while 182    HL<=3 --> 0<=3-HL --> carry if false
    ld    A, high 3     ; 2:7       dup 3 u<= while 182    HL<=3 --> 0<=3-HL --> carry if false
    sbc   A, H          ; 1:4       dup 3 u<= while 182    HL<=3 --> 0<=3-HL --> carry if false
    jp    c, break182   ; 3:10      dup 3 u<= while 182
    ld   BC, string117  ; 3:10      print_i   Address of string188 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
    jp   break182       ; 3:10      break 182
    jp   begin182       ; 3:10      again 182
break182:               ;           again 182
begin183:               ;           begin 183
    ld    A, low 3      ; 2:7       dup 3 u> while 183    HL>3 --> 0>3-HL --> no carry if false
    sub   L             ; 1:4       dup 3 u> while 183    HL>3 --> 0>3-HL --> no carry if false
    ld    A, high 3     ; 2:7       dup 3 u> while 183    HL>3 --> 0>3-HL --> no carry if false
    sbc   A, H          ; 1:4       dup 3 u> while 183    HL>3 --> 0>3-HL --> no carry if false
    jp   nc, break183   ; 3:10      dup 3 u> while 183
    ld   BC, string120  ; 3:10      print_i   Address of string189 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
    jp   break183       ; 3:10      break 183
    jp   begin183       ; 3:10      again 183
break183:               ;           again 183
begin184:               ;           begin 184
    ld    A, L          ; 1:4       dup 3 u>= while 184    HL>=3 --> HL-3>=0 --> carry if false
    sub   low 3         ; 2:7       dup 3 u>= while 184    HL>=3 --> HL-3>=0 --> carry if false
    ld    A, H          ; 1:4       dup 3 u>= while 184    HL>=3 --> HL-3>=0 --> carry if false
    sbc   A, high 3     ; 2:7       dup 3 u>= while 184    HL>=3 --> HL-3>=0 --> carry if false
    jp    c, break184   ; 3:10      dup 3 u>= while 184
    ld   BC, string123  ; 3:10      print_i   Address of string190 ending with inverted most significant bit == string123
    call PRINT_STRING_I ; 3:17      print_i
    jp   break184       ; 3:10      break 184
    jp   begin184       ; 3:10      again 184
break184:               ;           again 184
    call PRT_U16        ; 3:17      u.   ( u -- )
    ld   BC, string184  ; 3:10      print_i   Address of string191 ending with inverted most significant bit == string184
    call PRINT_STRING_I ; 3:17      print_i
x_p3_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;   ---  the beginning of a non-recursive function  ---
x_m3_test:              ;           
    pop  BC             ; 1:10      : ret
    ld  (x_m3_test_end+1),BC; 4:20      : ( ret -- )
begin185:               ;           begin 185
                        ;[8:29]     dup -3 = while 185   ( x1 -- x1 )   -3 == HL
    ld    A, L          ; 1:4       dup -3 = while 185
    xor   0x02          ; 2:7       dup -3 = while 185   x[1] = 0xFF ^ 0x02
    and   H             ; 1:4       dup -3 = while 185
    inc   A             ; 1:4       dup -3 = while 185   x[2] = 0xFF
    jp   nz, break185   ; 3:10      dup -3 = while 185
    ld   BC, string108  ; 3:10      print_i   Address of string192 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
    jp   break185       ; 3:10      break 185
    jp   begin185       ; 3:10      again 185
break185:               ;           again 185
begin186:               ;           begin 186
                        ;[8:29]     dup -3 <> while 186   ( x1 -- x1 )   -3 <> HL
    ld    A, L          ; 1:4       dup -3 <> while 186
    xor   0x02          ; 2:7       dup -3 <> while 186   x[1] = 0xFF ^ 0x02
    and   H             ; 1:4       dup -3 <> while 186
    inc   A             ; 1:4       dup -3 <> while 186   x[2] = 0xFF
    jp    z, break186   ; 3:10      dup -3 <> while 186
    ld   BC, string111  ; 3:10      print_i   Address of string193 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
    jp   break186       ; 3:10      break 186
    jp   begin186       ; 3:10      again 186
break186:               ;           again 186
begin187:               ;           begin 187
                       ;[11:40]     dup -3 < while 187    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
    ld    A, L          ; 1:4       dup -3 < while 187    HL<-3 --> HL--3<0 --> no carry if false
    sub   low -3        ; 2:7       dup -3 < while 187    HL<-3 --> HL--3<0 --> no carry if false
    ld    A, H          ; 1:4       dup -3 < while 187    HL<-3 --> HL--3<0 --> no carry if false
    sbc   A, high -3    ; 2:7       dup -3 < while 187    HL<-3 --> HL--3<0 --> no carry if false
    rra                 ; 1:4       dup -3 < while 187
    xor   H             ; 1:4       dup -3 < while 187    invert sign if x is negative
    jp    m, break187   ; 3:10      dup -3 < while 101    negative constant --> sign if false
    ld   BC, string114  ; 3:10      print_i   Address of string194 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
    jp   break187       ; 3:10      break 187
    jp   begin187       ; 3:10      again 187
break187:               ;           again 187
begin188:               ;           begin 188
                       ;[11:40]     dup -3 <= while 188    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
    ld    A, low -3     ; 2:7       dup -3 <= while 188    HL<=-3 --> 0<=-3-HL --> carry if false
    sub   L             ; 1:4       dup -3 <= while 188    HL<=-3 --> 0<=-3-HL --> carry if false
    ld    A, high -3    ; 2:7       dup -3 <= while 188    HL<=-3 --> 0<=-3-HL --> carry if false
    sbc   A, H          ; 1:4       dup -3 <= while 188    HL<=-3 --> 0<=-3-HL --> carry if false
    rra                 ; 1:4       dup -3 <= while 188
    xor   H             ; 1:4       dup -3 <= while 188    invert sign if x is negative
    jp    p, break188   ; 3:10      dup -3 <= while 101    negative constant --> no sign if false
    ld   BC, string117  ; 3:10      print_i   Address of string195 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
    jp   break188       ; 3:10      break 188
    jp   begin188       ; 3:10      again 188
break188:               ;           again 188
begin189:               ;           begin 189
                       ;[11:40]     dup -3 > while 189    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
    ld    A, low -3     ; 2:7       dup -3 > while 189    HL>-3 --> 0>-3-HL --> no carry if false
    sub   L             ; 1:4       dup -3 > while 189    HL>-3 --> 0>-3-HL --> no carry if false
    ld    A, high -3    ; 2:7       dup -3 > while 189    HL>-3 --> 0>-3-HL --> no carry if false
    sbc   A, H          ; 1:4       dup -3 > while 189    HL>-3 --> 0>-3-HL --> no carry if false
    rra                 ; 1:4       dup -3 > while 189
    xor   H             ; 1:4       dup -3 > while 189    invert sign if x is negative
    jp    m, break189   ; 3:10      dup -3 > while 101    negative constant --> sign if false
    ld   BC, string120  ; 3:10      print_i   Address of string196 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
    jp   break189       ; 3:10      break 189
    jp   begin189       ; 3:10      again 189
break189:               ;           again 189
begin190:               ;           begin 190
                       ;[11:40]     dup -3 >= while 190    ( x -- x )    # default version, changes using "define({_TYP_SINGLE},{sign_first})"
    ld    A, L          ; 1:4       dup -3 >= while 190    HL>=-3 --> HL--3>=0 --> carry if false
    sub   low -3        ; 2:7       dup -3 >= while 190    HL>=-3 --> HL--3>=0 --> carry if false
    ld    A, H          ; 1:4       dup -3 >= while 190    HL>=-3 --> HL--3>=0 --> carry if false
    sbc   A, high -3    ; 2:7       dup -3 >= while 190    HL>=-3 --> HL--3>=0 --> carry if false
    rra                 ; 1:4       dup -3 >= while 190
    xor   H             ; 1:4       dup -3 >= while 190    invert sign if x is negative
    jp    p, break190   ; 3:10      dup -3 >= while 101    negative constant --> no sign if false
    ld   BC, string123  ; 3:10      print_i   Address of string197 ending with inverted most significant bit == string123
    call PRINT_STRING_I ; 3:17      print_i
    jp   break190       ; 3:10      break 190
    jp   begin190       ; 3:10      again 190
break190:               ;           again 190
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRT_S16        ; 3:17      .   ( s -- )
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    ld   BC, string198  ; 3:10      print_i   Address of string198 ending with inverted most significant bit
    call PRINT_STRING_I ; 3:17      print_i
begin191:               ;           begin 191
                        ;[8:29]     dup -3 u= while   ( x1 -- x1 )   -3 == HL
    ld    A, L          ; 1:4       dup -3 u= while
    xor   0x02          ; 2:7       dup -3 u= while   x[1] = 0xFF ^ 0x02
    and   H             ; 1:4       dup -3 u= while
    inc   A             ; 1:4       dup -3 u= while   x[2] = 0xFF
    jp   nz, break191   ; 3:10      dup -3 u= while
    ld   BC, string108  ; 3:10      print_i   Address of string199 ending with inverted most significant bit == string108
    call PRINT_STRING_I ; 3:17      print_i
    jp   break191       ; 3:10      break 191
    jp   begin191       ; 3:10      again 191
break191:               ;           again 191
begin192:               ;           begin 192
                        ;[8:29]     dup -3 u<> while   ( x1 -- x1 )   -3 <> HL
    ld    A, L          ; 1:4       dup -3 u<> while
    xor   0x02          ; 2:7       dup -3 u<> while   x[1] = 0xFF ^ 0x02
    and   H             ; 1:4       dup -3 u<> while
    inc   A             ; 1:4       dup -3 u<> while   x[2] = 0xFF
    jp    z, break192   ; 3:10      dup -3 u<> while
    ld   BC, string111  ; 3:10      print_i   Address of string200 ending with inverted most significant bit == string111
    call PRINT_STRING_I ; 3:17      print_i
    jp   break192       ; 3:10      break 192
    jp   begin192       ; 3:10      again 192
break192:               ;           again 192
begin193:               ;           begin 193
    ld    A, L          ; 1:4       dup -3 u< while 193    HL<-3 --> HL--3<0 --> no carry if false
    sub   low -3        ; 2:7       dup -3 u< while 193    HL<-3 --> HL--3<0 --> no carry if false
    ld    A, H          ; 1:4       dup -3 u< while 193    HL<-3 --> HL--3<0 --> no carry if false
    sbc   A, high -3    ; 2:7       dup -3 u< while 193    HL<-3 --> HL--3<0 --> no carry if false
    jp   nc, break193   ; 3:10      dup -3 u< while 193
    ld   BC, string114  ; 3:10      print_i   Address of string201 ending with inverted most significant bit == string114
    call PRINT_STRING_I ; 3:17      print_i
    jp   break193       ; 3:10      break 193
    jp   begin193       ; 3:10      again 193
break193:               ;           again 193
begin194:               ;           begin 194
    ld    A, low -3     ; 2:7       dup -3 u<= while 194    HL<=-3 --> 0<=-3-HL --> carry if false
    sub   L             ; 1:4       dup -3 u<= while 194    HL<=-3 --> 0<=-3-HL --> carry if false
    ld    A, high -3    ; 2:7       dup -3 u<= while 194    HL<=-3 --> 0<=-3-HL --> carry if false
    sbc   A, H          ; 1:4       dup -3 u<= while 194    HL<=-3 --> 0<=-3-HL --> carry if false
    jp    c, break194   ; 3:10      dup -3 u<= while 194
    ld   BC, string117  ; 3:10      print_i   Address of string202 ending with inverted most significant bit == string117
    call PRINT_STRING_I ; 3:17      print_i
    jp   break194       ; 3:10      break 194
    jp   begin194       ; 3:10      again 194
break194:               ;           again 194
begin195:               ;           begin 195
    ld    A, low -3     ; 2:7       dup -3 u> while 195    HL>-3 --> 0>-3-HL --> no carry if false
    sub   L             ; 1:4       dup -3 u> while 195    HL>-3 --> 0>-3-HL --> no carry if false
    ld    A, high -3    ; 2:7       dup -3 u> while 195    HL>-3 --> 0>-3-HL --> no carry if false
    sbc   A, H          ; 1:4       dup -3 u> while 195    HL>-3 --> 0>-3-HL --> no carry if false
    jp   nc, break195   ; 3:10      dup -3 u> while 195
    ld   BC, string120  ; 3:10      print_i   Address of string203 ending with inverted most significant bit == string120
    call PRINT_STRING_I ; 3:17      print_i
    jp   break195       ; 3:10      break 195
    jp   begin195       ; 3:10      again 195
break195:               ;           again 195
begin196:               ;           begin 196
    ld    A, L          ; 1:4       dup -3 u>= while 196    HL>=-3 --> HL--3>=0 --> carry if false
    sub   low -3        ; 2:7       dup -3 u>= while 196    HL>=-3 --> HL--3>=0 --> carry if false
    ld    A, H          ; 1:4       dup -3 u>= while 196    HL>=-3 --> HL--3>=0 --> carry if false
    sbc   A, high -3    ; 2:7       dup -3 u>= while 196    HL>=-3 --> HL--3>=0 --> carry if false
    jp    c, break196   ; 3:10      dup -3 u>= while 196
    ld   BC, string123  ; 3:10      print_i   Address of string204 ending with inverted most significant bit == string123
    call PRINT_STRING_I ; 3:17      print_i
    jp   break196       ; 3:10      break 196
    jp   begin196       ; 3:10      again 196
break196:               ;           again 196
    call PRT_U16        ; 3:17      u.   ( u -- )
    push DE             ; 1:11      -3
    ex   DE, HL         ; 1:4       -3
    ld   HL, 0-3        ; 3:10      -3
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )
    ld    A, 0x0D       ; 2:7       cr   Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      cr   putchar(reg A) with ZX 48K ROM
x_m3_test_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
;==============================================================================
; ( hi lo -- )
; Input: DEHL
; Output: Print space and signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_SP_S32:             ;           prt_sp_s32
    ld    A, ' '        ; 2:7       prt_sp_s32   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      prt_sp_s32   putchar(reg A) with ZX 48K ROM
    ; fall to prt_s32
;------------------------------------------------------------------------------
; ( hi lo -- )
; Input: DEHL
; Output: Print signed decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_S32:                ;           prt_s32
    ld    A, D          ; 1:4       prt_s32
    add   A, A          ; 1:4       prt_s32
    jr   nc, PRT_U32    ; 2:7/12    prt_s32
    ld    A, '-'        ; 2:7       prt_s32   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      prt_s32   putchar(reg A) with ZX 48K ROM
    call NEGATE_32      ; 3:17      prt_s32
    jr   PRT_U32        ; 2:12      prt_s32
;==============================================================================
; Input: DEHL
; Output: Print space and unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_SP_U32:             ;           prt_sp_u32
    ld    A, ' '        ; 2:7       prt_sp_u32   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      prt_sp_u32   putchar(reg A) with ZX 48K ROM
    ; fall to prt_u32
;------------------------------------------------------------------------------
; Input: DEHL
; Output: Print unsigned decimal number in DEHL
; Pollutes: AF, BC, HL <- (SP), DE <- (SP-2)
PRT_U32:                ;           prt_u32
    xor   A             ; 1:4       prt_u32   HL = 103 & A=0 => 103, HL = 103 & A='0' => 00103
    push IX             ; 2:15      prt_u32
    ex   DE, HL         ; 1:4       prt_u32   HL = hi word
    ld  IXl, E          ; 2:8       prt_u32
    ld  IXh, D          ; 2:8       prt_u32   IX = lo word
    ld   DE, 0x3600     ; 3:10      prt_u32   C4 65 36 00 = -1000000000
    ld   BC, 0xC465     ; 3:10      prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld    D, 0x1F       ; 2:7       prt_u32   FA 0A 1F 00 = -100000000
    ld   BC, 0xFA0A     ; 3:10      prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0x6980     ; 3:10      prt_u32   FF 67 69 80 = -10000000
    ld   BC, 0xFF67     ; 3:10      prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xBDC0     ; 3:10      prt_u32   FF F0 BD C0 = -1000000
    ld    C, 0xF0       ; 2:7       prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0x7960     ; 3:10      prt_u32   FF FE 79 60 = -100000
    ld    C, 0xFE       ; 2:7       prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xD8F0     ; 3:10      prt_u32   FF FF D8 F0 = -10000
    ld    C, B          ; 1:4       prt_u32
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xFC18     ; 3:10      prt_u32   FF FF FC 18 = -1000
    call BIN32_DEC      ; 3:17      prt_u32
    ld   DE, 0xFF9C     ; 3:10      prt_u32   FF FF FF 9C = -100
    call BIN32_DEC      ; 3:17      prt_u32
    ld    E, 0xF6       ; 2:7       prt_u32   FF FF FF F6 = -10
    call BIN32_DEC      ; 3:17      prt_u32
    ld    A, IXl        ; 2:8       prt_u32
    pop  IX             ; 2:14      prt_u32
    pop  BC             ; 1:10      prt_u32   load ret
    pop  HL             ; 1:10      prt_u32
    pop  DE             ; 1:10      prt_u32
    push BC             ; 1:11      prt_u32   save ret
    jr   BIN32_DEC_CHAR ; 2:12      prt_u32
;------------------------------------------------------------------------------
; Input: A = 0 or A = '0' = 0x30 = 48, HL, IX, BC, DE
; Output: if ((HLIX/(-BCDE) > 0) || (A >= '0')) print number HLIX/(-BCDE)
; Pollutes: AF, AF', IX, HL
BIN32_DEC:              ;           bin32_dec
    add  IX, DE         ; 2:15      bin32_dec   lo word
    adc  HL, BC         ; 2:15      bin32_dec   hi word
    inc   A             ; 1:4       bin32_dec
    jr    c, $-5        ; 2:7/12    bin32_dec
    ex   AF, AF'        ; 1:4       bin32_dec
    ld    A, IXl        ; 2:8       bin32_dec
    sub   E             ; 1:4       bin32_dec
    ld  IXl, A          ; 2:8       bin32_dec
    ld    A, IXh        ; 2:8       bin32_dec
    sbc   A, D          ; 1:4       bin32_dec
    ld  IXh, A          ; 2:8       bin32_dec
    sbc  HL, BC         ; 2:15      bin32_dec   hi word
    ex   AF, AF'        ; 1:4       bin32_dec
    dec   A             ; 1:4       bin32_dec
    ret   z             ; 1:5/11    bin32_dec   does not print leading zeros
BIN32_DEC_CHAR:         ;           bin32_dec
    or   '0'            ; 2:7       bin32_dec   1..9 --> '1'..'9', unchanged '0'..'9'
    rst   0x10          ; 1:11      bin32_dec   putchar(reg A) with ZX 48K ROM
    ld    A, '0'        ; 2:7       bin32_dec   reset A to '0'
    ret                 ; 1:10      bin32_dec
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
    jr   PRT_U16        ; 2:12      prt_s16
;==============================================================================
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, BC, HL <- DE, DE <- (SP)
PRT_SP_U16:             ;           prt_sp_u16
    ld    A, ' '        ; 2:7       prt_sp_u16   putchar Pollutes: AF, AF', DE', BC'
    rst   0x10          ; 1:11      prt_sp_u16   putchar(reg A) with ZX 48K ROM
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
; ( d -- -d )
NEGATE_32:              ;[14:62]    negate_32   ( hi lo -- 0-hi-carry 0-lo )
    xor   A             ; 1:4       negate_32
    ld    C, A          ; 1:4       negate_32
    sub   L             ; 1:4       negate_32
    ld    L, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, H          ; 1:4       negate_32
    ld    H, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, E          ; 1:4       negate_32
    ld    E, A          ; 1:4       negate_32
    ld    A, C          ; 1:4       negate_32
    sbc   A, D          ; 1:4       negate_32
    ld    D, A          ; 1:4       negate_32
    ret                 ; 1:10      negate_32
;==============================================================================
; ( d2 ret d1 -- d2 d1 )
;  In: (SP+4) = h2, (SP+2) = l2, (SP) = ret
; Out: (SP+2) = h2, (SP)   = l2, (SP) = ret, AF = h2, BC = l2
FCE_4DUP_DLT:           ;[9:75]     fce_4dup_dlt   ( d2 ret d1 -- d2 d1 )
    pop  AF             ; 1:10      fce_4dup_dlt   h2 l2 .. ..  AF = ret
    pop  BC             ; 1:10      fce_4dup_dlt   h2 .. .. ..  BC = l2
    ex   AF, AF'        ; 1:4       fce_4dup_dlt   h2 .. .. ..
    pop  AF             ; 1:10      fce_4dup_dlt   .. .. .. ..  AF'= h2
    push AF             ; 1:11      fce_4dup_dlt   h2 .. .. ..
    push BC             ; 1:11      fce_4dup_dlt   h2 l2 .. ..
    ex   AF, AF'        ; 1:4       fce_4dup_dlt   h2 l2 .. ..
    push AF             ; 1:11      fce_4dup_dlt   h2 l2 rt ..
    ex   AF, AF'        ; 1:4       fce_4dup_dlt   h2 l2 rt ..  AF = h2
    ; fall to fce_dlt
;==============================================================================
; ( d2 ret d1 -- d1 )
; set carry if d2<d1 is true
;  In: AF = h2, BC = l2, DE = h1, HL = l1
; Out:          BC = h2, DE = h1, HL = l1, set carry if true
FCE_DLT:               ;[18:58,71]  fce_dlt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DLT},{small})"
    push AF             ; 1:11      fce_dlt   h2 l2 rt h2 h1 l1  d2<d1 --> d2-d1<0 --> AFBC-DEHL<0 --> carry if true
    sub   D             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  A-D<0 --> carry if true
    jr    z, $+8        ; 2:7/12    fce_dlt   h2 l2 rt h2 h1 l1
    rra                 ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1        --> sign  if true
    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1
    xor   B             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
    xor   D             ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
    add   A, A          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1        --> carry if true
    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1
    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1
    sub   L             ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  C-L<0 --> carry if true
    ld    A, B          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1
    sbc   A, H          ; 1:4       fce_dlt   h2 l2 rt h2 h1 l1  B-H<0 --> carry if true
    pop  BC             ; 1:10      fce_dlt   h2 l2 rt .. h1 l1  BC = hi16(d2)
    ld    A, C          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1
    sbc   A, E          ; 1:4       fce_dlt   h2 l2 rt .. h1 l1  C-E<0 --> carry if true
    ret                 ; 1:10      fce_dlt   h2 l2 .. .. h1 l1
;==============================================================================
; ( d2 ret d1 -- d2 d1 )
;  In: (SP+4) = h2, (SP+2) = l2, (SP) = ret
; Out: (SP+2) = h2, (SP)   = l2, (SP) = ret, AF = h2, BC = l2
FCE_4DUP_DGT:           ;[9:75]     fce_4dup_dgt   ( d2 ret d1 -- d2 d1 )
    pop  AF             ; 1:10      fce_4dup_dgt   h2 l2 .. ..  AF = ret
    pop  BC             ; 1:10      fce_4dup_dgt   h2 .. .. ..  BC = l2
    ex   AF, AF'        ; 1:4       fce_4dup_dgt   h2 .. .. ..
    pop  AF             ; 1:10      fce_4dup_dgt   .. .. .. ..  AF'= h2
    push AF             ; 1:11      fce_4dup_dgt   h2 .. .. ..
    push BC             ; 1:11      fce_4dup_dgt   h2 l2 .. ..
    ex   AF, AF'        ; 1:4       fce_4dup_dgt   h2 l2 .. ..
    push AF             ; 1:11      fce_4dup_dgt   h2 l2 rt ..
    ex   AF, AF'        ; 1:4       fce_4dup_dgt   h2 l2 rt ..  AF = h2
    ; fall to fce_dgt
;==============================================================================
; ( d2 ret d1 -- d1 )
; carry if d2>d1 is true
;  In: AF = h2, BC = l2, DE = h1, HL = l1
; Out:          BC = h2, DE = h1, HL = l1, set carry if true
FCE_DGT:               ;[22:60,71]  fce_dgt   ( d2 ret d1 -- d2 d1 )   # default version, changes using "define({_USE_FCE_DGT},{small})"
    push AF             ; 1:11      fce_dgt   h2 l2 rt h2 h1 l1  d2>d1 --> 0>d1-d2 --> 0>DEHL-AFBC --> carry if true
    xor   D             ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  A==D?
    jr    z, $+12       ; 2:7/12    fce_dgt   h2 l2 rt h2 h1 l1
    pop  BC             ; 1:10      fce_dgt   h2 l2 rt .. h1 l1
    jp    p, $+6        ; 3:10      fce_dgt   h2 l2 rt .. h1 l1
    ld    A, B          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  opposite signs
    sub   D             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>B-D --> carry if true
    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
    ld    A, D          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  identical signs
    sub   B             ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>D-B --> carry if true
    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
    ld    A, L          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
    sub   C             ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>L-C --> carry if true
    ld    A, H          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1
    sbc   A, B          ; 1:4       fce_dgt   h2 l2 rt h2 h1 l1  0>H-B --> carry if true
    pop  BC             ; 1:10      fce_dgt   h2 l2 rt .. h1 l1
    ld    A, E          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1
    sbc   A, C          ; 1:4       fce_dgt   h2 l2 rt .. h1 l1  0>E-C --> carry if true
    ret                 ; 1:10      fce_dgt   h2 l2 .. .. h1 l1
;------------------------------------------------------------------------------
; Print string ending with inverted most significant bit
; In: BC = addr string_imsb
; Out: BC = addr last_char + 1
    rst   0x10          ; 1:11      print_string_i   putchar(reg A) with ZX 48K ROM
PRINT_STRING_I:         ;           print_string_i
    ld    A,(BC)        ; 1:7       print_string_i
    inc  BC             ; 1:6       print_string_i
    or    A             ; 1:4       print_string_i
    jp    p, $-4        ; 3:10      print_string_i
    and  0x7f           ; 2:7       print_string_i
    rst   0x10          ; 1:11      print_string_i   putchar(reg A) with ZX 48K ROM
    ret                 ; 1:10      print_string_i
;==============================================================================
; Print text with 5x8 font
; entry point is "putchar"

MAX_X           equ 51       ; x = 0..50
MAX_Y           equ 24       ; y = 0..23
CURCHL          equ 0x5C51
PRINT_OUT       equ 0x5CBB
    
set_ink:                ;           putchar   0x10
    ld   HL, self_attr  ; 3:10      putchar
    xor (HL)            ; 1:7       putchar
    and 0x07            ; 2:7       putchar
    xor (HL)            ; 1:7       putchar
    jr  set_attr        ; 2:12      putchar
    
set_paper:              ;           putchar   0x11          
    ld   HL, self_attr  ; 3:10      putchar
    add   A, A          ; 1:4       putchar   2x
    add   A, A          ; 1:4       putchar   4x
    add   A, A          ; 1:4       putchar   8x
    xor (HL)            ; 1:7       putchar
    and 0x38            ; 2:7       putchar
    xor (HL)            ; 1:7       putchar
    jr  set_attr        ; 2:12      putchar
    
set_flash:              ;           putchar   0x12
    rra                 ; 1:4       putchar   carry = flash
    ld   HL, self_attr  ; 3:10      putchar
    ld    A,(HL)        ; 1:7       putchar
    adc   A, A          ; 1:4       putchar
    rrca                ; 1:4       putchar
    jr  set_attr        ; 2:12      putchar
    
set_bright:             ;           putchar   0x13
    ld   HL, self_attr  ; 3:10      putchar
    rrca                ; 1:4       putchar
    rrca                ; 1:4       putchar
    xor (HL)            ; 1:7       putchar
    and 0x40            ; 2:7       putchar
    xor (HL)            ; 1:7       putchar
    jr   set_attr       ; 2:12      putchar
    
set_inverse:            ;           putchar   0x14
    ld   HL, self_attr  ; 3:10      putchar
    ld    A,(HL)        ; 1:7       putchar
    and  0x38           ; 2:7       putchar   A = 00pp p000
    add   A, A          ; 1:4       putchar
    add   A, A          ; 1:4       putchar   A = ppp0 0000
    xor (HL)            ; 1:7       putchar
    and  0xF8           ; 2:7       putchar
    xor (HL)            ; 1:7       putchar   A = ppp0 0iii
    rlca                ; 1:4       putchar
    rlca                ; 1:4       putchar
    rlca                ; 1:4       putchar   A = 00ii ippp
    xor (HL)            ; 1:7       putchar
    and  0x3F           ; 2:7       putchar
    xor (HL)            ; 1:7       putchar   A = fbii ippp

set_attr:               ;           putchar
    ld  (HL),A          ; 1:7       putchar   save new attr   
clean_set_0:            ;           putchar
    xor   A             ; 1:4       putchar
clean_set_A:            ;           putchar
    ld  (self_jmp),A    ; 3:13      putchar
    pop  HL             ; 1:10      putchar
    ret                 ; 1:10      putchar
    
set_over:               ;           putchar   0x15
    jr   clean_set_0    ; 2:12      putchar

set_at:                 ;           putchar   0x16
    ld  (putchar_y),A   ; 3:13      putchar   save new Y
    neg                 ; 2:8       putchar
    add   A, 0x18       ; 2:7       putchar
    ld  (0x5C89),A      ; 3:13      putchar
    ld   A,$+4-jump_from; 2:7       putchar
    jr   clean_set_A    ; 2:12      putchar

set_at_x:               ;           putchar
    ld  (putchar_yx),A  ; 3:13      putchar   save new X
    jr   clean_set_0    ; 2:12      putchar

  if 0
    jr   print_comma    ; 2:12      putchar   0x06
    jr   print_edit     ; 2:12      putchar   0x07
    jr   cursor_left    ; 2:12      putchar   0x08
    jr   cursor_right   ; 2:12      putchar   0x09
    jr   cursor_down    ; 2:12      putchar   0x0A
    jr   cursor_up      ; 2:12      putchar   0x0B
    jr   delete         ; 2:12      putchar   0x0C
    jr   enter          ; 2:12      putchar   0x0D
    jr   not_used       ; 2:12      putchar   0x0E
    jr   not_used       ; 2:12      putchar   0x0F    
  endif
  
tab_spec:               ;           putchar 
    jr   set_ink        ; 2:12      putchar   0x10
    jr   set_paper      ; 2:12      putchar   0x11
    jr   set_flash      ; 2:12      putchar   0x12
    jr   set_bright     ; 2:12      putchar   0x13
    jr   set_inverse    ; 2:12      putchar   0x14
    jr   set_over       ; 2:12      putchar   0x15
    jr   set_at         ; 2:12      putchar   0x16
;   jr   set_tab        ; 2:12      putchar   0x17

set_tab:                ;           putchar
    ld   HL,(putchar_yx); 3:16      putchar   load origin cursor
    sub  MAX_X          ; 2:7       putchar
    jr   nc,$-2         ; 2:7/12    putchar
    add   A, MAX_X      ; 2:7       putchar   (new x) mod MAX_X
    cp    L             ; 1:4       putchar
    call  c, next_line  ; 3:10/17   putchar   new x < (old x+1) 
set_tab_A               ;           putchar
    ld    L, A          ; 1:4       putchar
    ld  (putchar_yx),HL ; 3:16      putchar   save new cursor
    jr   clean_set_0    ; 2:12      putchar

cursor_left:            ;           putchar   0x08
    ld   HL,(putchar_yx); 3:16      putchar
    inc   L             ; 1:4       putchar
    dec   L             ; 1:4       putchar
    dec  HL             ; 1:6       putchar
    jr   nz, $+4        ; 2:7/12    putchar
    ld    L, MAX_X-1    ; 2:7       putchar
    jr   enter_exit     ; 2:12      putchar

print_comma:            ;           putchar   0x06
    ld   HL,(putchar_yx); 3:16      putchar   H = next Y, L = next X
    ld    A, 17         ; 2:7       putchar
    cp    L             ; 1:4       putchar
    jr   nc, set_tab_A  ; 2:12      putchar
    add   A, A          ; 1:4       putchar
    cp    L             ; 1:4       putchar
    jr   nc, set_tab_A  ; 2:12      putchar
    xor   A             ; 1:4       putchar
    
enter:                  ;           putchar   0x0D
    call  z, next_line  ; 3:10/17   putchar
enter_exit:             ;           putchar
    ld  (putchar_yx),HL ; 3:16      putchar   save new cursor
    pop  HL             ; 1:10      putchar   load HL
    ret                 ; 3:10

    
print_edit:             ;           putchar   0x07
cursor_right:           ;           putchar   0x09
cursor_down:            ;           putchar   0x0A
cursor_up:              ;           putchar   0x0B
delete:                 ;           putchar   0x0C
not_used:               ;           putchar   0x0E, 0x0F

print_question          ;           putchar   0x00..0x05 + 0x0E..0x0F + 0x18..0x1F
    ld    A, '?'        ; 2:7       putchar
    jr   print_char_HL  ; 2:7/12    putchar

;------------------------------------------------------------------------------
;  Input: A = char
; Poluttes: AF, AF', DE', BC'
putchar:
    push HL                 ; 1:11
self_jmp    equ $+1
    jr   jump_from          ; 2:7/12    self-modifying
jump_from:
    cp   0xA5               ; 2:7       token 
    jr   nc, print_token    ; 2:7/12

    cp   0x20               ; 2:7
    jr   nc, print_char_HL  ; 2:7/12

    cp   0x06               ; 2:7       comma
    jr    z, print_comma    ; 2:7/12
    cp   0x08               ; 2:7       cursor_left
    jr    z, cursor_left    ; 2:7/12
    cp   0x09               ; 2:7       cursor_right
    jp    z, next_cursor    ; 3:10
    cp   0x0D               ; 2:7       enter
    jr    z, enter          ; 2:7/12

    sub  0x10               ; 2:7       set_ink
    jr    c, print_question ; 2:7/12

    cp   0x08               ; 2:7       >print_tab
    jr   nc, print_question ; 2:7/12

draw_spec:    
    add   A,A               ; 1:4       2x
    sub  jump_from-tab_spec ; 2:7
    ld  (self_jmp),A        ; 3:13
draw_spec_exit:             ;
    pop  HL                 ; 1:10
    ret                     ; 1:10
    
print_token:
    ex   DE, HL             ; 1:4
    ld   DE, 0x0095	        ; 3:10      The base address of the token table
    sub  0xA5               ; 2:7
    push AF                 ; 1:11      Save the code on the stack. (Range +00 to +5A,  to COPY).
    
; Input
;   A   Message table entry number
;   DE  Message table start address
; Output
;   DE  Address of the first character of message number A
;   F   Carry flag: suppress (set) or allow (reset) a leading space
    call 0x0C41             ; 3:17      THE 'TABLE SEARCH' SUBROUTINE 
    ex   DE, HL             ; 1:4

    ld    A,' '             ; 2:7       A 'space' will be printed before the message/token if required (bit 0 of FLAGS reset).
    bit   0,(IY+0x01)       ;
    call  z, print_char     ; 3:17

; The characters of the message/token are printed in turn.

token_loop:
    ld    A,(HL)            ; 1:7       Collect a code.
    and  0x7F               ; 2:7       Cancel any 'inverted bit'.
    call print_char         ; 3:17      Print the character.
    ld    A,(HL)            ; 1:7       Collect the code again.
    inc  HL                 ; 1:6       Advance the pointer.
    add   A, A              ; 1:4       The 'inverted bit' goes to the carry flag and signals the end of the message/token; otherwise jump back.
    jr   nc, token_loop     ; 2:7/12
    
; Now consider whether a 'trailing space' is required.

    pop  HL                 ; 1:10      For messages, H holds +00; for tokens, H holds +00 to +5A.
    cp   0x48               ; 2:7       Jump forward if the last character was a '$'
    jr    z, $+6            ; 2:7/12
    cp   0x82               ; 2:7       Return if the last character was any other before 'A'.
    jr    c, draw_spec_exit ; 2:7/12
    ld    A, H              ; 1:4       Examine the value in H and return if it indicates a message, , INKEY$ or PI.
    cp   0x03               ; 2:7
    ld    A, ' '            ; 2:7       All other cases will require a 'trailing space'.    
    ret   c                 ; 1:5/11
    pop  HL                 ; 1:10
print_char:
    push HL                 ; 1:11    uschovat HL na zásobník
print_char_HL:

    exx                     ; 1:4
    push DE                 ; 1:11    uschovat DE na zásobník
    push BC                 ; 1:11    uschovat BC na zásobník    

    push HL                 ; 1:11    uschovat HL na zásobník

    ld    BC, FONT_ADR      ; 3:10    adresa, od níž začínají masky znaků

    add   A, A              ; 1:4
    ld    L, A              ; 1:4     2x
    ld    H, 0x00           ; 1:4     C je nenulové
    add  HL, HL             ; 1:11    4x
    add  HL, BC             ; 1:11    přičíst bázovou adresu masek znaků    
    exx                     ; 1:4

;# YX -> ATTR

putchar_yx     equ     $+1
putchar_y      equ     $+2

    ld   DE, 0x0000         ; 3:10
    ld    A, E              ; 1:4     X
    add   A, A              ; 1:4     2*X
    add   A, A              ; 1:4     4*X
    add   A, E              ; 1:4     5*X
    ld    B, A              ; 1:4     save 5*X
    
    xor   D                 ; 1:4
    and 0xF8                ; 2:7
    xor   D                 ; 1:4
    rrca                    ; 1:4
    rrca                    ; 1:4
    rrca                    ; 1:4
    ld    L, A              ; 1:4

    ld    A, D              ; 1:4   
    or  0xC7                ; 2:7     110y y111, reset carry
    rra                     ; 1:4     0110 yy11, set carry
    rrca                    ; 1:4     1011 0yy1, set carry
    ccf                     ; 1:4     reset carry
    rra                     ; 1:4     0101 10yy
    ld    H, A              ; 1:4

self_attr       equ $+1
    ld  (HL),0x38           ; 2:10    uložení atributu znaku

    ld    A, D              ; 1:4
    and 0x18                ; 2:7
    or  0x40                ; 2:7
    ld    H, A              ; 1:4
    
    ld    A, B              ; 1:4     load 5*X
    and 0x07                ; 2:7
    cpl                     ; 1:4
    add   A, 0x09           ; 2:7         
    ld    B, A              ; 2:7     pocitadlo pro pocatecni posun vlevo masky znaku
    exx                     ; 1:4
    ld    C, A              ; 1:4
    exx                     ; 1:4
    ex   DE, HL             ; 1:4
    ld   HL, 0x00F0         ; 3:10
    add  HL, HL             ; 1:11    pocatecni posun masky
    djnz  $-1               ; 2:8/13        
    ex   DE, HL             ; 1:4

    ld    C, 4          ; 2:7       putchar   draw        
putchar_c:              ;           putchar   draw
    exx                 ; 1:4       putchar   draw
    ld    A,(HL)        ; 1:7       putchar   draw
    inc  HL             ; 1:6       putchar   draw
    ld    B, C          ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    djnz  $-1           ; 2:8/13    putchar   draw
    ld    B, A          ; 1:4       putchar   draw
    exx                 ; 1:4       putchar   draw
    ld    B, 2          ; 2:7       putchar   draw 
putchar_b:              ;           putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    and   D             ; 1:4       putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    ld  (HL),A          ; 1:4       putchar   draw   ulozeni jednoho bajtu z masky

    exx                 ; 1:4       putchar   draw
    ld    A, B          ; 1:4       putchar   draw   načtení druhe poloviny "bajtu" z masky
    exx                 ; 1:4       putchar   draw

    inc   L             ; 1:4       putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    and   E             ; 1:4       putchar   draw
    xor (HL)            ; 1:7       putchar   draw
    ld  (HL),A          ; 1:4       putchar   draw   ulozeni jednoho bajtu z masky
    dec   L             ; 1:4       putchar   draw
    inc   H             ; 1:4       putchar   draw

    exx                 ; 1:4       putchar   draw
    ld    A, B          ; 1:4       putchar   draw   načtení jednoho bajtu z masky
    rlca                ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    rlca                ; 1:4       putchar   draw
    ld    B, A          ; 1:4       putchar   draw
    exx                 ; 1:4       putchar   draw

;     halt
    
    djnz putchar_b      ; 2:8/13    putchar   draw
    
    dec   C             ; 2:7       putchar   draw 
    jr   nz, putchar_c  ; 2/7/12    putchar   draw


    pop  HL             ; 1:10      putchar   obnovit obsah HL ze zásobníku

    pop  BC             ; 1:10      putchar   obnovit obsah BC ze zásobníku
    pop  DE             ; 1:10      putchar   obnovit obsah DE ze zásobníku    
    exx                 ; 1:4       putchar
;   fall to next cursor    

; Output: [putchar_yx] = cursor right
next_cursor:            ;
    ld   HL,(putchar_yx); 3:16
; Input: HL = YX
next_cursor_HL:         ;
    inc   L             ; 1:4     0..50
    ld    A, L          ; 1:4
    sub  MAX_X          ; 2:7     -51
    call nc, next_line  ; 3:10/17
next_exit:
    ld  (putchar_yx),HL ; 3:16
exit_hl:                ;
    pop  HL             ; 1:10    obnovit obsah HL ze zásobníku
    ret                 ; 1:10

; Input:
; Output: H = Y+1/Y+0+scroll, L=0
next_line:
    push AF             ; 1:11      putchar
    ld   HL, 0x5C88     ; 3:10      putchar
    ld  (HL), 0x01      ; 2:10      putchar
    ld    A, 0x09       ; 2:7       putchar   cursor_right
    push HL             ; 1:11      putchar
    call 0x09F4         ; 3:17      putchar   rst 0x10 --> call 0x09F4
    ld   HL, putchar    ; 3:10      putchar
    ld  (PRINT_OUT),HL  ; 3:10      putchar
    pop  HL             ; 1:10      putchar
    ld    A, 0x18       ; 2:7       putchar
    inc   L             ; 1:4       putchar
    sub (HL)            ; 1:7       putchar
    ld    H, A          ; 1:7       putchar
    ld    L, 0x00       ; 2:7       putchar
    pop  AF             ; 1:10      putchar
    ret                 ; 1:10      putchar

FONT_ADR    equ     FONT_5x8-32*4
FONT_5x8:
    db %00000000,%00000000,%00000000,%00000000 ; 0x20 space
    db %00000010,%00100010,%00100000,%00100000 ; 0x21 !
    db %00000101,%01010000,%00000000,%00000000 ; 0x22 "
    db %00000000,%01011111,%01011111,%01010000 ; 0x23 #
    db %00000010,%01110110,%00110111,%00100000 ; 0x24 $
    db %00001100,%11010010,%01001011,%00110000 ; 0x25 %
    db %00000000,%11101010,%01011010,%11010000 ; 0x26 &
    db %00000011,%00010010,%00000000,%00000000 ; 0x27 '    
    db %00000010,%01000100,%01000100,%00100000 ; 0x28 (
    db %00000100,%00100010,%00100010,%01000000 ; 0x29 )
    db %00000000,%00001010,%01001010,%00000000 ; 0x2A *
    db %00000000,%00000100,%11100100,%00000000 ; 0x2B +
    db %00000000,%00000000,%00000010,%00100100 ; 0x2C ,
    db %00000000,%00000000,%11100000,%00000000 ; 0x2D -
    db %00000000,%00000000,%00000000,%01000000 ; 0x2E .
    db %00000000,%00010010,%01001000,%00000000 ; 0x2F /
    
    db %00000110,%10011011,%11011001,%01100000 ; 0x30 0
    db %00000010,%01100010,%00100010,%01110000 ; 0x31 1
    db %00000110,%10010001,%01101000,%11110000 ; 0x32 2
    db %00000110,%10010010,%00011001,%01100000 ; 0x33 3
    db %00000010,%01101010,%11110010,%00100000 ; 0x34 4
    db %00001111,%10001110,%00011001,%01100000 ; 0x35 5
    db %00000110,%10001110,%10011001,%01100000 ; 0x36 6
    db %00001111,%00010010,%01000100,%01000000 ; 0x37 7
    db %00000110,%10010110,%10011001,%01100000 ; 0x38 8
    db %00000110,%10011001,%01110001,%01100000 ; 0x39 9
    db %00000000,%00000010,%00000010,%00000000 ; 0x3A :
    db %00000000,%00000010,%00000010,%01000000 ; 0x3B ;
    db %00000000,%00010010,%01000010,%00010000 ; 0x3C <
    db %00000000,%00000111,%00000111,%00000000 ; 0x3D =
    db %00000000,%01000010,%00010010,%01000000 ; 0x3E >
    db %00001110,%00010010,%01000000,%01000000 ; 0x3F ?
    
    db %00000000,%01101111,%10111000,%01100000 ; 0x40 @
    db %00000110,%10011001,%11111001,%10010000 ; 0x41 A
    db %00001110,%10011110,%10011001,%11100000 ; 0x42 B
    db %00000110,%10011000,%10001001,%01100000 ; 0x43 C
    db %00001110,%10011001,%10011001,%11100000 ; 0x44 D
    db %00001111,%10001110,%10001000,%11110000 ; 0x45 E
    db %00001111,%10001110,%10001000,%10000000 ; 0x46 F
    db %00000110,%10011000,%10111001,%01110000 ; 0x47 G
    db %00001001,%10011111,%10011001,%10010000 ; 0x48 H
    db %00000111,%00100010,%00100010,%01110000 ; 0x49 I
    db %00000111,%00010001,%00011001,%01100000 ; 0x4A J
    db %00001001,%10101100,%10101001,%10010000 ; 0x4B K
    db %00001000,%10001000,%10001000,%11110000 ; 0x4C L
    db %00001001,%11111001,%10011001,%10010000 ; 0x4D M
    db %00001001,%11011011,%10011001,%10010000 ; 0x4E N
    db %00000110,%10011001,%10011001,%01100000 ; 0x4F O
    
    db %00001110,%10011001,%11101000,%10000000 ; 0x50 P
    db %00000110,%10011001,%10011010,%01010000 ; 0x51 Q
    db %00001110,%10011001,%11101001,%10010000 ; 0x52 R
    db %00000111,%10000110,%00010001,%11100000 ; 0x53 S
    db %00001111,%00100010,%00100010,%00100000 ; 0x54 T
    db %00001001,%10011001,%10011001,%01100000 ; 0x55 U
    db %00001001,%10011001,%10010101,%00100000 ; 0x56 V
    db %00001001,%10011001,%10011111,%10010000 ; 0x57 W
    db %00001001,%10010110,%10011001,%10010000 ; 0x58 X
    db %00001001,%10010101,%00100010,%00100000 ; 0x59 Y
    db %00001111,%00010010,%01001000,%11110000 ; 0x5A Z
    db %00000111,%01000100,%01000100,%01110000 ; 0x5B [
    db %00000000,%10000100,%00100001,%00000000 ; 0x5C \
    db %00001110,%00100010,%00100010,%11100000 ; 0x5D ]
    db %00000010,%01010000,%00000000,%00000000 ; 0x5E ^
    db %00000000,%00000000,%00000000,%11110000 ; 0x5F _
    
    db %00000011,%01001110,%01000100,%11110000 ; 0x60 ` GBP
    db %00000000,%01100001,%01111001,%01110000 ; 0x61 a
    db %00001000,%11101001,%10011001,%11100000 ; 0x62 b
    db %00000000,%01101001,%10001001,%01100000 ; 0x63 c
    db %00000001,%01111001,%10011001,%01110000 ; 0x64 d
    db %00000000,%01101001,%11111000,%01110000 ; 0x65 e
    db %00110100,%11100100,%01000100,%01000000 ; 0x66 f
    db %00000000,%01111001,%10010111,%00010110 ; 0x67 g
    db %00001000,%11101001,%10011001,%10010000 ; 0x68 h
    db %00100000,%01100010,%00100010,%01110000 ; 0x69 i
    db %00010000,%00110001,%00010001,%10010110 ; 0x6A j
    db %00001000,%10011010,%11001010,%10010000 ; 0x6B k
    db %00001100,%01000100,%01000100,%11100000 ; 0x6C l
    db %00000000,%11001011,%10111011,%10010000 ; 0x6D m
    db %00000000,%10101101,%10011001,%10010000 ; 0x6E n
    db %00000000,%01101001,%10011001,%01100000 ; 0x6F o
   
    db %00000000,%11101001,%10011001,%11101000 ; 0x70 p
    db %00000000,%01111001,%10011001,%01110001 ; 0x71 q
    db %00000000,%10101101,%10001000,%10000000 ; 0x72 r
    db %00000000,%01111000,%01100001,%11100000 ; 0x73 s
    db %00000100,%11100100,%01000100,%00110000 ; 0x74 t
    db %00000000,%10011001,%10011001,%01100000 ; 0x75 u
    db %00000000,%10011001,%10010101,%00100000 ; 0x76 v
    db %00000000,%10011001,%10011111,%10010000 ; 0x77 w
    db %00000000,%10011001,%01101001,%10010000 ; 0x78 x
    db %00000000,%10011001,%10010111,%00010110 ; 0x79 y
    db %00000000,%11110010,%01001000,%11110000 ; 0x7A z
    db %00010010,%00100100,%00100010,%00010000 ; 0x7B 
    db %01000100,%01000100,%01000100,%01000000 ; 0x7C |
    db %10000100,%01000010,%01000100,%10000000 ; 0x7D 
    db %00000101,%10100000,%00000000,%00000000 ; 0x7E ~
    db %00000110,%10011011,%10111001,%01100000 ; 0x7F (c)

STRING_SECTION:
string204   EQU  string123
  size204   EQU    size123
string203   EQU  string120
  size203   EQU    size120
string202   EQU  string117
  size202   EQU    size117
string201   EQU  string114
  size201   EQU    size114
string200   EQU  string111
  size200   EQU    size111
string199   EQU  string108
  size199   EQU    size108
string198:
    db " -3", 0x0D + 0x80
size198              EQU $ - string198
string197   EQU  string123
  size197   EQU    size123
string196   EQU  string120
  size196   EQU    size120
string195   EQU  string117
  size195   EQU    size117
string194   EQU  string114
  size194   EQU    size114
string193   EQU  string111
  size193   EQU    size111
string192   EQU  string108
  size192   EQU    size108
string191   EQU  string184
  size191   EQU    size184
string190   EQU  string123
  size190   EQU    size123
string189   EQU  string120
  size189   EQU    size120
string188   EQU  string117
  size188   EQU    size117
string187   EQU  string114
  size187   EQU    size114
string186   EQU  string111
  size186   EQU    size111
string185   EQU  string108
  size185   EQU    size108
string184:
    db " 3", 0x0D + 0x80
size184              EQU $ - string184
string183   EQU  string123
  size183   EQU    size123
string182   EQU  string120
  size182   EQU    size120
string181   EQU  string117
  size181   EQU    size117
string180   EQU  string114
  size180   EQU    size114
string179   EQU  string111
  size179   EQU    size111
string178   EQU  string108
  size178   EQU    size108
string177   EQU  string123
  size177   EQU    size123
string176   EQU  string121
  size176   EQU    size121
string175   EQU  string121
  size175   EQU    size121
string174   EQU  string120
  size174   EQU    size120
string173   EQU  string118
  size173   EQU    size118
string172   EQU  string118
  size172   EQU    size118
string171   EQU  string117
  size171   EQU    size117
string170   EQU  string115
  size170   EQU    size115
string169   EQU  string115
  size169   EQU    size115
string168   EQU  string114
  size168   EQU    size114
string167   EQU  string112
  size167   EQU    size112
string166   EQU  string112
  size166   EQU    size112
string165   EQU  string111
  size165   EQU    size111
string164   EQU  string109
  size164   EQU    size109
string163   EQU  string109
  size163   EQU    size109
string162   EQU  string108
  size162   EQU    size108
string161   EQU  string106
  size161   EQU    size106
string160   EQU  string106
  size160   EQU    size106
string159   EQU  string123
  size159   EQU    size123
string158   EQU  string121
  size158   EQU    size121
string157   EQU  string121
  size157   EQU    size121
string156   EQU  string120
  size156   EQU    size120
string155   EQU  string118
  size155   EQU    size118
string154   EQU  string118
  size154   EQU    size118
string153   EQU  string117
  size153   EQU    size117
string152   EQU  string115
  size152   EQU    size115
string151   EQU  string115
  size151   EQU    size115
string150   EQU  string114
  size150   EQU    size114
string149   EQU  string112
  size149   EQU    size112
string148   EQU  string112
  size148   EQU    size112
string147   EQU  string111
  size147   EQU    size111
string146   EQU  string109
  size146   EQU    size109
string145   EQU  string109
  size145   EQU    size109
string144   EQU  string108
  size144   EQU    size108
string143   EQU  string106
  size143   EQU    size106
string142   EQU  string106
  size142   EQU    size106
string141   EQU  string123
  size141   EQU    size123
string140   EQU  string121
  size140   EQU    size121
string139   EQU  string121
  size139   EQU    size121
string138   EQU  string120
  size138   EQU    size120
string137   EQU  string118
  size137   EQU    size118
string136   EQU  string118
  size136   EQU    size118
string135   EQU  string117
  size135   EQU    size117
string134   EQU  string115
  size134   EQU    size115
string133   EQU  string115
  size133   EQU    size115
string132   EQU  string114
  size132   EQU    size114
string131   EQU  string112
  size131   EQU    size112
string130   EQU  string112
  size130   EQU    size112
string129   EQU  string111
  size129   EQU    size111
string128   EQU  string109
  size128   EQU    size109
string127   EQU  string109
  size127   EQU    size109
string126   EQU  string108
  size126   EQU    size108
string125   EQU  string106
  size125   EQU    size106
string124   EQU  string106
  size124   EQU    size106
string123:
    db ">=","," + 0x80
size123              EQU $ - string123
string122   EQU  string121
  size122   EQU    size121
string121:
    db ">","=" + 0x80
size121              EQU $ - string121
string120:
    db ">","," + 0x80
size120              EQU $ - string120
string119   EQU  string118
  size119   EQU    size118
string118:
    db ">" + 0x80
size118              EQU $ - string118
string117:
    db "<=","," + 0x80
size117              EQU $ - string117
string116   EQU  string115
  size116   EQU    size115
string115:
    db "<","=" + 0x80
size115              EQU $ - string115
string114:
    db "<","," + 0x80
size114              EQU $ - string114
string113   EQU  string112
  size113   EQU    size112
string112:
    db "<" + 0x80
size112              EQU $ - string112
string111:
    db "<>","," + 0x80
size111              EQU $ - string111
string110   EQU  string109
  size110   EQU    size109
string109:
    db "<",">" + 0x80
size109              EQU $ - string109
string108:
    db "=","," + 0x80
size108              EQU $ - string108
string107   EQU  string106
  size107   EQU    size106
string106:
    db "=" + 0x80
size106              EQU $ - string106
string105:
    db "Depth",":" + 0x80
size105              EQU $ - string105
string104:
    db "( x1 -3 -- ) and ( u1 -3 -- ):",0x0D + 0x80
size104              EQU $ - string104
string103:
    db "( x1 3 -- ) and ( u1 3 -- ):",0x0D + 0x80
size103              EQU $ - string103
string102:
    db "( d2 d1 -- ) and ( ud2 ud1 -- ):",0x0D + 0x80
size102              EQU $ - string102
string101:
    db "( x2 x1 -- ) and ( u2 u1 -- ):",0x0D + 0x80
size101              EQU $ - string101
