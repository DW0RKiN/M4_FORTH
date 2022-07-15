;vvvvv
;^^^^^
ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xF500     ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init


    ld   BC, 7          ; 3:10      7 for 101
for101:                 ;           7 for 101
    ld  (idx101),BC     ; 4:20      7 for 101 save index
    
    push DE             ; 1:11      index i 101
    ex   DE, HL         ; 1:4       index i 101
    ld   HL, (idx101)   ; 3:16      index i 101 idx always points to a 16-bit index
    
;   v---v---v lo_case 101 v---v---v
    ld    A, L          ; 1:4       lo_case 101
        
                        ;[5:17]     lo_of(1) 1 from lo_case 101
    cp   low 1          ; 2:7       lo_of(1) 1 from lo_case 101
    jp   nz, endof101001; 3:10      lo_of(1) 1 from lo_case 101 
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   endcase101     ; 3:10      lo_endof 1 from lo_case 101
endof101001:            ;           lo_endof 1 from lo_case 101
        
                        ;[5:17]     lo_of(2) 2 from lo_case 101
    cp   low 2          ; 2:7       lo_of(2) 2 from lo_case 101
    jp   nz, endof101002; 3:10      lo_of(2) 2 from lo_case 101 
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   endcase101     ; 3:10      lo_endof 2 from lo_case 101
endof101002:            ;           lo_endof 2 from lo_case 101
        
                        ;[8:28]     lo_within_of(3) 3 from lo_within_case 101   ( a -- flag=(3<=a<6) )
    sub  low 3          ; 2:7       lo_within_of(3) 3 from lo_within_case 101   A = a - {3}
    sub  low 6-(3)      ; 2:7       lo_within_of(3) 3 from lo_within_case 101   carry: (a - {3}) - (6 - {3})
    ld    A, L          ; 1:4       lo_within_of(3) 3 from lo_within_case 101
    jp   nc, endof101003; 3:10      lo_within_of(3) 3 from lo_within_case 101 
    ld   BC, string103  ; 3:10      print_z   Address of null-terminated string103
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   endcase101     ; 3:10      lo_endof 3 from lo_case 101
endof101003:            ;           lo_endof 3 from lo_case 101
        
                        ;[5:17]     lo_of(2) 4 from lo_case 101
    cp   low 2          ; 2:7       lo_of(2) 4 from lo_case 101
    jp   nz, endof101004; 3:10      lo_of(2) 4 from lo_case 101 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   endcase101     ; 3:10      lo_endof 4 from lo_case 101
endof101004:            ;           lo_endof 4 from lo_case 101
        
    push HL             ; 1:11      dup u.   x3 x1 x2 x1
    call PRT_U16        ; 3:17      u.   ( u -- )
    ex   DE, HL         ; 1:4       dup u.   x3 x2 x1
    
endcase101:             ;           lo_endcase 101
;   ^---^---^ lo_endcase 101 ^---^---^
    
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
    
    ld    A, 0x20       ; 2:7       space   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      space   with 48K ROM in, this will print space

idx101 EQU $+1          ;           next 101
    ld   BC, 0x0000     ; 3:10      next 101 idx always points to a 16-bit index
    ld    A, B          ; 1:4       next 101
    or    C             ; 1:4       next 101
    dec  BC             ; 1:6       next 101 index--, zero flag unaffected
    jp   nz, for101     ; 3:10      next 101
next101:                ;           next 101

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A


    push DE             ; 1:11      push2(0,1)
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1)
    ld    D, H          ; 1:4       push2(0,1)
    ld    E, H          ; 1:4       push2(0,1)

    push DE             ; 1:11      push2(2,3)
    ld   DE, 2          ; 3:10      push2(2,3)
    push HL             ; 1:11      push2(2,3)
    ld   HL, 3          ; 3:10      push2(2,3)

    push DE             ; 1:11      push2(4,5)
    ld   DE, 4          ; 3:10      push2(4,5)
    push HL             ; 1:11      push2(4,5)
    ld   HL, 5          ; 3:10      push2(4,5)

    push DE             ; 1:11      push2(5+1*256,5+2*256)
    ld   DE, 5+1*256    ; 3:10      push2(5+1*256,5+2*256)
    push HL             ; 1:11      push2(5+1*256,5+2*256)
    ld   HL, 5+2*256    ; 3:10      push2(5+1*256,5+2*256)

    push DE             ; 1:11      push2(5+4*256,5+5*256)
    push HL             ; 1:11      push2(5+4*256,5+5*256)
    ld   DE, 5+4*256    ; 3:10      push2(5+4*256,5+5*256)
    ld    H, E          ; 1:4       push2(5+4*256,5+5*256)
    ld    L, E          ; 1:4       push2(5+4*256,5+5*256)

    push DE             ; 1:11      push2(6,7)
    ld   DE, 6          ; 3:10      push2(6,7)
    push HL             ; 1:11      push2(6,7)
    ld   HL, 7          ; 3:10      push2(6,7)

    push DE             ; 1:11      push2(8,9)
    ld   DE, 8          ; 3:10      push2(8,9)
    push HL             ; 1:11      push2(8,9)
    ld   HL, 9          ; 3:10      push2(8,9)


begin101:               ;           begin 101
    
    call check_prime    ; 3:17      scall

    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101

    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101


Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====



;   ---  the beginning of a data stack function  ---
check_prime:            ;           
    
    ld   BC, string105  ; 3:10      print_z   Address of null-terminated string105
    call PRINT_STRING_Z ; 3:17      print_z
    
;   v---v---v case 102 v---v---v
                        ;           case 102
        
                        ;[5:18]     push_of(0) 1 from case 102   version: 0 = 0
    ld    A, H          ; 1:4       push_of(0) 1 from case 102
    or    L             ; 1:4       push_of(0) 1 from case 102
    jp   nz, endof102001; 3:10      push_of(0) 1 from case 102       
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106
    call PRINT_STRING_Z ; 3:17      print_z   
    jp   endcase102     ; 3:10      endof 1 from case 102
endof102001:            ;           endof 1 from case 102
        
                        ;[7:25]     push_of(1) 2 from case 102   version: hi(1) = 0
    ld    A, low 1      ; 2:7       push_of(1) 2 from case 102
    xor   L             ; 1:4       push_of(1) 2 from case 102
    or    H             ; 1:4       push_of(1) 2 from case 102
    jp   nz, endof102002; 3:10      push_of(1) 2 from case 102       
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101 == string107
    call PRINT_STRING_Z ; 3:17      print_z    
    jp   endcase102     ; 3:10      endof 2 from case 102
endof102002:            ;           endof 2 from case 102
        
                        ;[7:25]     push_of(2) 3 from case 102   version: hi(2) = 0
    ld    A, low 2      ; 2:7       push_of(2) 3 from case 102
    xor   L             ; 1:4       push_of(2) 3 from case 102
    or    H             ; 1:4       push_of(2) 3 from case 102
    jp   nz, endof102003; 3:10      push_of(2) 3 from case 102       
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102 == string108
    call PRINT_STRING_Z ; 3:17      print_z    
    jp   endcase102     ; 3:10      endof 3 from case 102
endof102003:            ;           endof 3 from case 102
        
                        ;[14:58]    within_of(3) 4 from within_case 102   ( a -- flag=(3<=a<7) )
    ld    C, L          ; 1:4       within_of(3) 4 from within_case 102
    ld    B, H          ; 1:4       within_of(3) 4 from within_case 102
    dec  BC             ; 1:6       within_of(3) 4 from within_case 102
    dec  BC             ; 1:6       within_of(3) 4 from within_case 102
    dec  BC             ; 1:6       within_of(3) 4 from within_case 102   BC = a - {3}
    ld    A, C          ; 1:4       within_of(3) 4 from within_case 102
    sub  4              ; 2:7       within_of(3) 4 from within_case 102
    ld    A, B          ; 1:4       within_of(3) 4 from within_case 102
    sbc   A, 0          ; 2:7       within_of(3) 4 from within_case 102   carry:(a - {3}) - (7 - {3})
    jp   nc, endof102004; 3:10      within_of(3) 4 from within_case 102   
    ld   BC, string109  ; 3:10      print_z   Address of null-terminated string109
    call PRINT_STRING_Z ; 3:17      print_z   
    jp   endcase102     ; 3:10      endof 4 from case 102
endof102004:            ;           endof 4 from case 102
        
                        ;[7:25]     push_of(7) 5 from case 102   version: hi(7) = 0
    ld    A, low 7      ; 2:7       push_of(7) 5 from case 102
    xor   L             ; 1:4       push_of(7) 5 from case 102
    or    H             ; 1:4       push_of(7) 5 from case 102
    jp   nz, endof102005; 3:10      push_of(7) 5 from case 102       
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110
    call PRINT_STRING_Z ; 3:17      print_z  
    jp   endcase102     ; 3:10      endof 5 from case 102
endof102005:            ;           endof 5 from case 102
        
                        ;[7:25]     push_of(8) 6 from case 102   version: hi(8) = 0
    ld    A, low 8      ; 2:7       push_of(8) 6 from case 102
    xor   L             ; 1:4       push_of(8) 6 from case 102
    or    H             ; 1:4       push_of(8) 6 from case 102
    jp   nz, endof102006; 3:10      push_of(8) 6 from case 102       
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111
    call PRINT_STRING_Z ; 3:17      print_z  
    jp   endcase102     ; 3:10      endof 6 from case 102
endof102006:            ;           endof 6 from case 102
        
                        ;[7:25]     push_of(9) 7 from case 102   version: hi(9) = 0
    ld    A, low 9      ; 2:7       push_of(9) 7 from case 102
    xor   L             ; 1:4       push_of(9) 7 from case 102
    or    H             ; 1:4       push_of(9) 7 from case 102
    jp   nz, endof102007; 3:10      push_of(9) 7 from case 102       
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112
    call PRINT_STRING_Z ; 3:17      print_z   
    jp   endcase102     ; 3:10      endof 7 from case 102
endof102007:            ;           endof 7 from case 102
        
                        ;[10:36/30] push_of(5+5*256) 8 from case 102   version: hi(5+5*256) = lo(5+5*256) = 5
    ld    A, L          ; 1:4       push_of(5+5*256) 8 from case 102
    xor   H             ; 1:4       push_of(5+5*256) 8 from case 102
    jr   nz, $+5        ; 2:7/12    push_of(5+5*256) 8 from case 102
    ld    A, low 5+5*256; 2:7       push_of(5+5*256) 8 from case 102
    xor   H             ; 1:4       push_of(5+5*256) 8 from case 102
    jp   nz, endof102008; 3:10      push_of(5+5*256) 8 from case 102 
    ld   BC, string113  ; 3:10      print_z   Address of null-terminated string113
    call PRINT_STRING_Z ; 3:17      print_z 
    jp   endcase102     ; 3:10      endof 8 from case 102
endof102008:            ;           endof 8 from case 102
        
    push HL             ; 1:11      dup u.   x3 x1 x2 x1
    call PRT_U16        ; 3:17      u.   ( u -- )
    ex   DE, HL         ; 1:4       dup u.   x3 x2 x1
    
endcase102:             ;           endcase 102
;   ^---^---^ endcase 102 ^---^---^    
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114
    call PRINT_STRING_Z ; 3:17      print_z
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    H, 0x00       ; 2:7       255 and
                        ;           255 and   (L and 0xFF) = L 
    call PRT_U16        ; 3:17      u.   ( u -- )
    
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115
    call PRINT_STRING_Z ; 3:17      print_z
    
;   v---v---v lo_case 103 v---v---v
    ld    A, L          ; 1:4       lo_case 103
        
                        ;[5:17]     lo_of(2) 1 from lo_case 103
    cp   low 2          ; 2:7       lo_of(2) 1 from lo_case 103
    jp   nz, endof103001; 3:10      lo_of(2) 1 from lo_case 103  
    jp   endcase103     ; 3:10      lo_endof 1 from lo_case 103
endof103001:            ;           lo_endof 1 from lo_case 103
        
                        ;[5:17]     lo_of(3) 2 from lo_case 103
    cp   low 3          ; 2:7       lo_of(3) 2 from lo_case 103
    jp   nz, endof103002; 3:10      lo_of(3) 2 from lo_case 103  
    jp   endcase103     ; 3:10      lo_endof 2 from lo_case 103
endof103002:            ;           lo_endof 2 from lo_case 103
        
                        ;[5:17]     lo_of(5) 3 from lo_case 103
    cp   low 5          ; 2:7       lo_of(5) 3 from lo_case 103
    jp   nz, endof103003; 3:10      lo_of(5) 3 from lo_case 103
            
    ld   BC, string116  ; 3:10      print_z   Address of null-terminated string116
    call PRINT_STRING_Z ; 3:17      print_z
            
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )
            
;   v---v---v case 104 v---v---v
                        ;           case 104
                      
                        ;[5:18]     zero_of 1 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 1 from case 104
    or    L             ; 1:4       zero_of 1 from case 104
    jp   nz, endof104001; 3:10      zero_of 1 from case 104 
    ld   BC, string106  ; 3:10      print_z   Address of null-terminated string106 == string117
    call PRINT_STRING_Z ; 3:17      print_z   
    jp   endcase104     ; 3:10      endof 1 from case 104
endof104001:            ;           endof 1 from case 104
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 2 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 2 from case 104
    or    L             ; 1:4       zero_of 2 from case 104
    jp   nz, endof104002; 3:10      zero_of 2 from case 104 
    ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101 == string118
    call PRINT_STRING_Z ; 3:17      print_z    
    jp   endcase104     ; 3:10      endof 2 from case 104
endof104002:            ;           endof 2 from case 104
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 3 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 3 from case 104
    or    L             ; 1:4       zero_of 3 from case 104
    jp   nz, endof104003; 3:10      zero_of 3 from case 104 
    ld   BC, string102  ; 3:10      print_z   Address of null-terminated string102 == string119
    call PRINT_STRING_Z ; 3:17      print_z    
    jp   endcase104     ; 3:10      endof 3 from case 104
endof104003:            ;           endof 3 from case 104
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 4 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 4 from case 104
    or    L             ; 1:4       zero_of 4 from case 104
    jp   nz, endof104004; 3:10      zero_of 4 from case 104 
    ld   BC, string120  ; 3:10      print_z   Address of null-terminated string120
    call PRINT_STRING_Z ; 3:17      print_z  
    jp   endcase104     ; 3:10      endof 4 from case 104
endof104004:            ;           endof 4 from case 104
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 5 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 5 from case 104
    or    L             ; 1:4       zero_of 5 from case 104
    jp   nz, endof104005; 3:10      zero_of 5 from case 104 
    ld   BC, string121  ; 3:10      print_z   Address of null-terminated string121
    call PRINT_STRING_Z ; 3:17      print_z   
    jp   endcase104     ; 3:10      endof 5 from case 104
endof104005:            ;           endof 5 from case 104
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 6 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 6 from case 104
    or    L             ; 1:4       zero_of 6 from case 104
    jp   nz, endof104006; 3:10      zero_of 6 from case 104 
    ld   BC, string122  ; 3:10      print_z   Address of null-terminated string122
    call PRINT_STRING_Z ; 3:17      print_z   
    jp   endcase104     ; 3:10      endof 6 from case 104
endof104006:            ;           endof 6 from case 104
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 7 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 7 from case 104
    or    L             ; 1:4       zero_of 7 from case 104
    jp   nz, endof104007; 3:10      zero_of 7 from case 104 
    ld   BC, string104  ; 3:10      print_z   Address of null-terminated string104 == string123
    call PRINT_STRING_Z ; 3:17      print_z    
    jp   endcase104     ; 3:10      endof 7 from case 104
endof104007:            ;           endof 7 from case 104
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 8 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 8 from case 104
    or    L             ; 1:4       zero_of 8 from case 104
    jp   nz, endof104008; 3:10      zero_of 8 from case 104 
    ld   BC, string110  ; 3:10      print_z   Address of null-terminated string110 == string124
    call PRINT_STRING_Z ; 3:17      print_z  
    jp   endcase104     ; 3:10      endof 8 from case 104
endof104008:            ;           endof 8 from case 104
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 9 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 9 from case 104
    or    L             ; 1:4       zero_of 9 from case 104
    jp   nz, endof104009; 3:10      zero_of 9 from case 104 
    ld   BC, string111  ; 3:10      print_z   Address of null-terminated string111 == string125
    call PRINT_STRING_Z ; 3:17      print_z  
    jp   endcase104     ; 3:10      endof 9 from case 104
endof104009:            ;           endof 9 from case 104
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 10 from case 104   version: zero check
    ld    A, H          ; 1:4       zero_of 10 from case 104
    or    L             ; 1:4       zero_of 10 from case 104
    jp   nz, endof104010; 3:10      zero_of 10 from case 104 
    ld   BC, string112  ; 3:10      print_z   Address of null-terminated string112 == string126
    call PRINT_STRING_Z ; 3:17      print_z   
    jp   endcase104     ; 3:10      endof 10 from case 104
endof104010:            ;           endof 10 from case 104
                
    ld   BC, 0x0009     ; 3:10      9 +   ( x -- x+0x0009 )
    add  HL, BC         ; 1:11      9 + 
    call PRT_U16        ; 3:17      u.   ( u -- ) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )
            
endcase104:             ;           endcase 104
;   ^---^---^ endcase 104 ^---^---^
            
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
            
    ld   BC, string114  ; 3:10      print_z   Address of null-terminated string114 == string127
    call PRINT_STRING_Z ; 3:17      print_z
            
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
                        ;[3:11]     256/   Variant HL/256 = HL >> 8
    ld    L, H          ; 1:4       256/
    ld    H, 0x00       ; 2:7       256/ 
    call PRT_U16        ; 3:17      u.   ( u -- )
            
    ld   BC, string115  ; 3:10      print_z   Address of null-terminated string115 == string128
    call PRINT_STRING_Z ; 3:17      print_z
            
;   v---v---v hi_case 105 v---v---v
    ld    A, H          ; 1:4       hi_case 105
                
                        ;[5:17]     hi_of(2) 1 from hi_case 105
    cp   low 2          ; 2:7       hi_of(2) 1 from hi_case 105
    jp   nz, endof105001; 3:10      hi_of(2) 1 from hi_case 105  
    jp   endcase105     ; 3:10      hi_endof 1 from hi_case 105
endof105001:            ;           hi_endof 1 from hi_case 105
                
                        ;[5:17]     hi_of(3) 2 from hi_case 105
    cp   low 3          ; 2:7       hi_of(3) 2 from hi_case 105
    jp   nz, endof105002; 3:10      hi_of(3) 2 from hi_case 105  
    jp   endcase105     ; 3:10      hi_endof 2 from hi_case 105
endof105002:            ;           hi_endof 2 from hi_case 105
                
                        ;[5:17]     hi_of(5) 3 from hi_case 105
    cp   low 5          ; 2:7       hi_of(5) 3 from hi_case 105
    jp   nz, endof105003; 3:10      hi_of(5) 3 from hi_case 105  
    jp   endcase105     ; 3:10      hi_endof 3 from hi_case 105
endof105003:            ;           hi_endof 3 from hi_case 105
                
                        ;[5:17]     hi_of(7) 4 from hi_case 105
    cp   low 7          ; 2:7       hi_of(7) 4 from hi_case 105
    jp   nz, endof105004; 3:10      hi_of(7) 4 from hi_case 105  
    jp   endcase105     ; 3:10      hi_endof 4 from hi_case 105
endof105004:            ;           hi_endof 4 from hi_case 105
                
                        ;[5:17]     hi_of(11) 5 from hi_case 105
    cp   low 11         ; 2:7       hi_of(11) 5 from hi_case 105
    jp   nz, endof105005; 3:10      hi_of(11) 5 from hi_case 105 
    jp   endcase105     ; 3:10      hi_endof 5 from hi_case 105
endof105005:            ;           hi_endof 5 from hi_case 105
                
                        ;[5:17]     hi_of(13) 6 from hi_case 105
    cp   low 13         ; 2:7       hi_of(13) 6 from hi_case 105
    jp   nz, endof105006; 3:10      hi_of(13) 6 from hi_case 105 
    jp   endcase105     ; 3:10      hi_endof 6 from hi_case 105
endof105006:            ;           hi_endof 6 from hi_case 105
                    
    ld   BC, string129  ; 3:10      print_z   Address of null-terminated string129
    call PRINT_STRING_Z ; 3:17      print_z
            
endcase105:             ;           hi_endcase 105
;   ^---^---^ hi_endcase 105 ^---^---^
        
    jp   endcase103     ; 3:10      lo_endof 3 from lo_case 103
endof103003:            ;           lo_endof 3 from lo_case 103
        
                        ;[5:17]     lo_of(7) 4 from lo_case 103
    cp   low 7          ; 2:7       lo_of(7) 4 from lo_case 103
    jp   nz, endof103004; 3:10      lo_of(7) 4 from lo_case 103  
    jp   endcase103     ; 3:10      lo_endof 4 from lo_case 103
endof103004:            ;           lo_endof 4 from lo_case 103
        
                        ;[5:17]     lo_of(11) 5 from lo_case 103
    cp   low 11         ; 2:7       lo_of(11) 5 from lo_case 103
    jp   nz, endof103005; 3:10      lo_of(11) 5 from lo_case 103 
    jp   endcase103     ; 3:10      lo_endof 5 from lo_case 103
endof103005:            ;           lo_endof 5 from lo_case 103
        
                        ;[5:17]     lo_of(13) 6 from lo_case 103
    cp   low 13         ; 2:7       lo_of(13) 6 from lo_case 103
    jp   nz, endof103006; 3:10      lo_of(13) 6 from lo_case 103 
    jp   endcase103     ; 3:10      lo_endof 6 from lo_case 103
endof103006:            ;           lo_endof 6 from lo_case 103
            
    ld   BC, string129  ; 3:10      print_z   Address of null-terminated string129 == string130
    call PRINT_STRING_Z ; 3:17      print_z
    
endcase103:             ;           lo_endcase 103
;   ^---^---^ lo_endcase 103 ^---^---^
    
    ld   BC, string131  ; 3:10      print_z   Address of null-terminated string131
    call PRINT_STRING_Z ; 3:17      print_z
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

check_prime_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------

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
;==============================================================================
; Print C-style stringZ
; In: BC = addr
; Out: BC = addr zero
    rst  0x10           ; 1:11      print_string_z putchar with ZX 48K ROM in, this will print char in A
    inc  BC             ; 1:6       print_string_z
PRINT_STRING_Z:         ;           print_string_z
    ld    A,(BC)        ; 1:7       print_string_z
    or    A             ; 1:4       print_string_z
    jp   nz, $-4        ; 3:10      print_string_z
    ret                 ; 1:10      print_string_z

STRING_SECTION:
string131:
db " a prime.", 0x00
size131 EQU $ - string131
string129:
db " not", 0x00
size129 EQU $ - string129
string122:
db "five", 0x00
size122 EQU $ - string122
string121:
db "four", 0x00
size121 EQU $ - string121
string120:
db "three", 0x00
size120 EQU $ - string120
string116:
db " a prime and high(", 0x00
size116 EQU $ - string116
string115:
db " is", 0x00
size115 EQU $ - string115
string114:
db ")=", 0x00
size114 EQU $ - string114
string113:
db "five+five*256", 0x00
size113 EQU $ - string113
string112:
db "nine", 0x00
size112 EQU $ - string112
string111:
db "eight", 0x00
size111 EQU $ - string111
string110:
db "seven", 0x00
size110 EQU $ - string110
string109:
db "3..6", 0x00
size109 EQU $ - string109
string106:
db "zero", 0x00
size106 EQU $ - string106
string105:
db "lo(", 0x00
size105 EQU $ - string105
string104:
db "six", 0x00
size104 EQU $ - string104
string103:
db "3..5", 0x00
size103 EQU $ - string103
string102:
db "two", 0x00
size102 EQU $ - string102
string101:
db "one", 0x00
size101 EQU $ - string101
