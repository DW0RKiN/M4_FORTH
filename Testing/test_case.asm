;vvvvv
;^^^^^
ORG 0x8000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 0xF500     ; 3:10      Init Return address stack
    exx                 ; 1:4


    push DE             ; 1:11      push2(0,1)
    ld   DE, 0          ; 3:10      push2(0,1)
    push HL             ; 1:11      push2(0,1)
    ld   HL, 1          ; 3:10      push2(0,1)

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
    ld   DE, 5+4*256    ; 3:10      push2(5+4*256,5+5*256)
    push HL             ; 1:11      push2(5+4*256,5+5*256)
    ld   HL, 5+5*256    ; 3:10      push2(5+4*256,5+5*256)

    push DE             ; 1:11      push2(6,7)
    ld   DE, 6          ; 3:10      push2(6,7)
    push HL             ; 1:11      push2(6,7)
    ld   HL, 7          ; 3:10      push2(6,7)

    push DE             ; 1:11      push2(8,9)
    ld   DE, 8          ; 3:10      push2(8,9)
    push HL             ; 1:11      push2(8,9)
    ld   HL, 9          ; 3:10      push2(8,9)

    push DE             ; 1:11      push2(10,11)
    ld   DE, 10         ; 3:10      push2(10,11)
    push HL             ; 1:11      push2(10,11)
    ld   HL, 11         ; 3:10      push2(10,11)


begin101:
    
    call check_prime    ; 3:17      scall

    ld    A, H          ; 1:4       while 101
    or    L             ; 1:4       while 101
    ex   DE, HL         ; 1:4       while 101
    pop  DE             ; 1:10      while 101
    jp    z, break101   ; 3:10      while 101

    jp   begin101       ; 3:10      repeat 101
break101:               ;           repeat 101



Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====



;   ---  the beginning of a data stack function  ---
check_prime:            ;           
    
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
;   v---v---v case 101 v---v---v
                        ;           case 101
        
                        ;[5:18]     push_of(0) 1 from case 101   version: 0 = 0
    ld    A, H          ; 1:4       push_of(0) 1 from case 101
    or    L             ; 1:4       push_of(0) 1 from case 101
    jp   nz, endof101001; 3:10      push_of(0) 1 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size102    ; 3:10      print Length of string to print
    ld   DE, string102  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print   
    jp   endcase101     ; 3:10      endof 1 from case 101
endof101001:            ;           endof 1 from case 101
        
                        ;[7:25]     push_of(1) 2 from case 101   version: hi(1) = 0
    ld    A, low 1      ; 2:7       push_of(1) 2 from case 101
    xor   L             ; 1:4       push_of(1) 2 from case 101
    or    H             ; 1:4       push_of(1) 2 from case 101
    jp   nz, endof101002; 3:10      push_of(1) 2 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size103    ; 3:10      print Length of string to print
    ld   DE, string103  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print    
    jp   endcase101     ; 3:10      endof 2 from case 101
endof101002:            ;           endof 2 from case 101
        
                        ;[7:25]     push_of(2) 3 from case 101   version: hi(2) = 0
    ld    A, low 2      ; 2:7       push_of(2) 3 from case 101
    xor   L             ; 1:4       push_of(2) 3 from case 101
    or    H             ; 1:4       push_of(2) 3 from case 101
    jp   nz, endof101003; 3:10      push_of(2) 3 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size104    ; 3:10      print Length of string to print
    ld   DE, string104  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print    
    jp   endcase101     ; 3:10      endof 3 from case 101
endof101003:            ;           endof 3 from case 101
        
                        ;[7:25]     push_of(3) 4 from case 101   version: hi(3) = 0
    ld    A, low 3      ; 2:7       push_of(3) 4 from case 101
    xor   L             ; 1:4       push_of(3) 4 from case 101
    or    H             ; 1:4       push_of(3) 4 from case 101
    jp   nz, endof101004; 3:10      push_of(3) 4 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size105    ; 3:10      print Length of string to print
    ld   DE, string105  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print  
    jp   endcase101     ; 3:10      endof 4 from case 101
endof101004:            ;           endof 4 from case 101
        
                        ;[7:25]     push_of(4) 5 from case 101   version: hi(4) = 0
    ld    A, low 4      ; 2:7       push_of(4) 5 from case 101
    xor   L             ; 1:4       push_of(4) 5 from case 101
    or    H             ; 1:4       push_of(4) 5 from case 101
    jp   nz, endof101005; 3:10      push_of(4) 5 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size106    ; 3:10      print Length of string to print
    ld   DE, string106  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print   
    jp   endcase101     ; 3:10      endof 5 from case 101
endof101005:            ;           endof 5 from case 101
        
                        ;[7:25]     push_of(5) 6 from case 101   version: hi(5) = 0
    ld    A, low 5      ; 2:7       push_of(5) 6 from case 101
    xor   L             ; 1:4       push_of(5) 6 from case 101
    or    H             ; 1:4       push_of(5) 6 from case 101
    jp   nz, endof101006; 3:10      push_of(5) 6 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size107    ; 3:10      print Length of string to print
    ld   DE, string107  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print   
    jp   endcase101     ; 3:10      endof 6 from case 101
endof101006:            ;           endof 6 from case 101
        
                        ;[7:25]     push_of(6) 7 from case 101   version: hi(6) = 0
    ld    A, low 6      ; 2:7       push_of(6) 7 from case 101
    xor   L             ; 1:4       push_of(6) 7 from case 101
    or    H             ; 1:4       push_of(6) 7 from case 101
    jp   nz, endof101007; 3:10      push_of(6) 7 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size108    ; 3:10      print Length of string to print
    ld   DE, string108  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print    
    jp   endcase101     ; 3:10      endof 7 from case 101
endof101007:            ;           endof 7 from case 101
        
                        ;[7:25]     push_of(7) 8 from case 101   version: hi(7) = 0
    ld    A, low 7      ; 2:7       push_of(7) 8 from case 101
    xor   L             ; 1:4       push_of(7) 8 from case 101
    or    H             ; 1:4       push_of(7) 8 from case 101
    jp   nz, endof101008; 3:10      push_of(7) 8 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size109    ; 3:10      print Length of string to print
    ld   DE, string109  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print  
    jp   endcase101     ; 3:10      endof 8 from case 101
endof101008:            ;           endof 8 from case 101
        
                        ;[7:25]     push_of(8) 9 from case 101   version: hi(8) = 0
    ld    A, low 8      ; 2:7       push_of(8) 9 from case 101
    xor   L             ; 1:4       push_of(8) 9 from case 101
    or    H             ; 1:4       push_of(8) 9 from case 101
    jp   nz, endof101009; 3:10      push_of(8) 9 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size110    ; 3:10      print Length of string to print
    ld   DE, string110  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print  
    jp   endcase101     ; 3:10      endof 9 from case 101
endof101009:            ;           endof 9 from case 101
        
                        ;[7:25]     push_of(9) 10 from case 101   version: hi(9) = 0
    ld    A, low 9      ; 2:7       push_of(9) 10 from case 101
    xor   L             ; 1:4       push_of(9) 10 from case 101
    or    H             ; 1:4       push_of(9) 10 from case 101
    jp   nz, endof101010; 3:10      push_of(9) 10 from case 101

  
    push DE             ; 1:11      print
    ld   BC, size111    ; 3:10      print Length of string to print
    ld   DE, string111  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print   
    jp   endcase101     ; 3:10      endof 10 from case 101
endof101010:            ;           endof 10 from case 101
        
                        ;[7:25]     push_of(10) 11 from case 101   version: hi(10) = 0
    ld    A, low 10     ; 2:7       push_of(10) 11 from case 101
    xor   L             ; 1:4       push_of(10) 11 from case 101
    or    H             ; 1:4       push_of(10) 11 from case 101
    jp   nz, endof101011; 3:10      push_of(10) 11 from case 101

 
    push DE             ; 1:11      print
    ld   BC, size112    ; 3:10      print Length of string to print
    ld   DE, string112  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print    
    jp   endcase101     ; 3:10      endof 11 from case 101
endof101011:            ;           endof 11 from case 101
        
                        ;[7:25]     push_of(11) 12 from case 101   version: hi(11) = 0
    ld    A, low 11     ; 2:7       push_of(11) 12 from case 101
    xor   L             ; 1:4       push_of(11) 12 from case 101
    or    H             ; 1:4       push_of(11) 12 from case 101
    jp   nz, endof101012; 3:10      push_of(11) 12 from case 101

 
    push DE             ; 1:11      print
    ld   BC, size113    ; 3:10      print Length of string to print
    ld   DE, string113  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   endcase101     ; 3:10      endof 12 from case 101
endof101012:            ;           endof 12 from case 101
        
                        ;[7:25]     push_of(12) 13 from case 101   version: hi(12) = 0
    ld    A, low 12     ; 2:7       push_of(12) 13 from case 101
    xor   L             ; 1:4       push_of(12) 13 from case 101
    or    H             ; 1:4       push_of(12) 13 from case 101
    jp   nz, endof101013; 3:10      push_of(12) 13 from case 101

 
    push DE             ; 1:11      print
    ld   BC, size114    ; 3:10      print Length of string to print
    ld   DE, string114  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   endcase101     ; 3:10      endof 13 from case 101
endof101013:            ;           endof 13 from case 101
        
                        ;[10:37]    push_of(5+5*256) 14 from case 101   version: hi(5+5*256) = lo(5+5*256) = 5
    ld    A, low 5+5*256; 2:7       push_of(5+5*256) 14 from case 101
    xor   H             ; 1:4       push_of(5+5*256) 14 from case 101
    ld    B, A          ; 1:4       push_of(5+5*256) 14 from case 101
    xor   H             ; 1:4       push_of(5+5*256) 14 from case 101
    xor   L             ; 1:4       push_of(5+5*256) 14 from case 101
    or    B             ; 1:4       push_of(5+5*256) 14 from case 101
    jp   nz, endof101014; 3:10      push_of(5+5*256) 14 from case 101

 
    push DE             ; 1:11      print
    ld   BC, size115    ; 3:10      print Length of string to print
    ld   DE, string115  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   endcase101     ; 3:10      endof 14 from case 101
endof101014:            ;           endof 14 from case 101
        
    push HL             ; 1:11      dup .   x3 x1 x2 x1
    call PRINT_S16      ; 3:17      .
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1
    
endcase101:             ;           endcase 101
;   ^---^---^ endcase 101 ^---^---^    
    push DE             ; 1:11      print
    ld   BC, size116    ; 3:10      print Length of string to print
    ld   DE, string116  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    H, 0x00       ; 2:7       255 and 
    call PRINT_S16      ; 3:17      .
    
    push DE             ; 1:11      print
    ld   BC, size117    ; 3:10      print Length of string to print
    ld   DE, string117  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
;   v---v---v lo_case 102 v---v---v
    ld    A, L          ; 1:4       lo_case 102
        
                        ;[5:17]     lo_of(2) 1 from lo_case 102
    cp   low 2          ; 2:7       lo_of(2) 1 from lo_case 102
    jp   nz, endof102001; 3:10      lo_of(2) 1 from lo_case 102
  
    jp   endcase102     ; 3:10      lo_endof 1 from lo_case 102
endof102001:            ;           lo_endof 1 from lo_case 102
        
                        ;[5:17]     lo_of(3) 2 from lo_case 102
    cp   low 3          ; 2:7       lo_of(3) 2 from lo_case 102
    jp   nz, endof102002; 3:10      lo_of(3) 2 from lo_case 102
  
    jp   endcase102     ; 3:10      lo_endof 2 from lo_case 102
endof102002:            ;           lo_endof 2 from lo_case 102
        
                        ;[5:17]     lo_of(5) 3 from lo_case 102
    cp   low 5          ; 2:7       lo_of(5) 3 from lo_case 102
    jp   nz, endof102003; 3:10      lo_of(5) 3 from lo_case 102

            
    push DE             ; 1:11      print
    ld   BC, size118    ; 3:10      print Length of string to print
    ld   DE, string118  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
            
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )
            
;   v---v---v case 103 v---v---v
                        ;           case 103
                      
                        ;[5:18]     zero_of 1 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 1 from case 103
    or    L             ; 1:4       zero_of 1 from case 103
    jp   nz, endof103001; 3:10      zero_of 1 from case 103 
    push DE             ; 1:11      print
    ld   BC, size119    ; 3:10      print Length of string to print
    ld   DE, string119  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print   
    jp   endcase103     ; 3:10      endof 1 from case 103
endof103001:            ;           endof 1 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 2 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 2 from case 103
    or    L             ; 1:4       zero_of 2 from case 103
    jp   nz, endof103002; 3:10      zero_of 2 from case 103 
    push DE             ; 1:11      print
    ld   BC, size120    ; 3:10      print Length of string to print
    ld   DE, string120  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print    
    jp   endcase103     ; 3:10      endof 2 from case 103
endof103002:            ;           endof 2 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 3 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 3 from case 103
    or    L             ; 1:4       zero_of 3 from case 103
    jp   nz, endof103003; 3:10      zero_of 3 from case 103 
    push DE             ; 1:11      print
    ld   BC, size121    ; 3:10      print Length of string to print
    ld   DE, string121  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print    
    jp   endcase103     ; 3:10      endof 3 from case 103
endof103003:            ;           endof 3 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 4 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 4 from case 103
    or    L             ; 1:4       zero_of 4 from case 103
    jp   nz, endof103004; 3:10      zero_of 4 from case 103 
    push DE             ; 1:11      print
    ld   BC, size122    ; 3:10      print Length of string to print
    ld   DE, string122  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print  
    jp   endcase103     ; 3:10      endof 4 from case 103
endof103004:            ;           endof 4 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 5 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 5 from case 103
    or    L             ; 1:4       zero_of 5 from case 103
    jp   nz, endof103005; 3:10      zero_of 5 from case 103 
    push DE             ; 1:11      print
    ld   BC, size123    ; 3:10      print Length of string to print
    ld   DE, string123  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print   
    jp   endcase103     ; 3:10      endof 5 from case 103
endof103005:            ;           endof 5 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 6 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 6 from case 103
    or    L             ; 1:4       zero_of 6 from case 103
    jp   nz, endof103006; 3:10      zero_of 6 from case 103 
    push DE             ; 1:11      print
    ld   BC, size124    ; 3:10      print Length of string to print
    ld   DE, string124  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print   
    jp   endcase103     ; 3:10      endof 6 from case 103
endof103006:            ;           endof 6 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 7 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 7 from case 103
    or    L             ; 1:4       zero_of 7 from case 103
    jp   nz, endof103007; 3:10      zero_of 7 from case 103 
    push DE             ; 1:11      print
    ld   BC, size125    ; 3:10      print Length of string to print
    ld   DE, string125  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print    
    jp   endcase103     ; 3:10      endof 7 from case 103
endof103007:            ;           endof 7 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 8 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 8 from case 103
    or    L             ; 1:4       zero_of 8 from case 103
    jp   nz, endof103008; 3:10      zero_of 8 from case 103 
    push DE             ; 1:11      print
    ld   BC, size126    ; 3:10      print Length of string to print
    ld   DE, string126  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print  
    jp   endcase103     ; 3:10      endof 8 from case 103
endof103008:            ;           endof 8 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 9 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 9 from case 103
    or    L             ; 1:4       zero_of 9 from case 103
    jp   nz, endof103009; 3:10      zero_of 9 from case 103 
    push DE             ; 1:11      print
    ld   BC, size127    ; 3:10      print Length of string to print
    ld   DE, string127  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print  
    jp   endcase103     ; 3:10      endof 9 from case 103
endof103009:            ;           endof 9 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 10 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 10 from case 103
    or    L             ; 1:4       zero_of 10 from case 103
    jp   nz, endof103010; 3:10      zero_of 10 from case 103 
    push DE             ; 1:11      print
    ld   BC, size128    ; 3:10      print Length of string to print
    ld   DE, string128  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print   
    jp   endcase103     ; 3:10      endof 10 from case 103
endof103010:            ;           endof 10 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 11 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 11 from case 103
    or    L             ; 1:4       zero_of 11 from case 103
    jp   nz, endof103011; 3:10      zero_of 11 from case 103 
    push DE             ; 1:11      print
    ld   BC, size129    ; 3:10      print Length of string to print
    ld   DE, string129  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print    
    jp   endcase103     ; 3:10      endof 11 from case 103
endof103011:            ;           endof 11 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 12 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 12 from case 103
    or    L             ; 1:4       zero_of 12 from case 103
    jp   nz, endof103012; 3:10      zero_of 12 from case 103 
    push DE             ; 1:11      print
    ld   BC, size130    ; 3:10      print Length of string to print
    ld   DE, string130  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   endcase103     ; 3:10      endof 12 from case 103
endof103012:            ;           endof 12 from case 103
                
    dec  HL             ; 1:6       1- 
                        ;[5:18]     zero_of 13 from case 103   version: zero check
    ld    A, H          ; 1:4       zero_of 13 from case 103
    or    L             ; 1:4       zero_of 13 from case 103
    jp   nz, endof103013; 3:10      zero_of 13 from case 103 
    push DE             ; 1:11      print
    ld   BC, size131    ; 3:10      print Length of string to print
    ld   DE, string131  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print 
    jp   endcase103     ; 3:10      endof 13 from case 103
endof103013:            ;           endof 13 from case 103
                
    ld   BC, 12         ; 3:10      12 +
    add  HL, BC         ; 1:11      12 + 
    call PRINT_S16      ; 3:17      . 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )
            
endcase103:             ;           endcase 103
;   ^---^---^ endcase 103 ^---^---^
            
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- )
            
    push DE             ; 1:11      print
    ld   BC, size132    ; 3:10      print Length of string to print
    ld   DE, string132  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print            
            
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
                        ;[3:11]     256/   Variant HL/256 = HL >> 8
    ld    L, H          ; 1:4       256/
    ld    H, 0x00       ; 2:7       256/ 
    call PRINT_S16      ; 3:17      .
            
    push DE             ; 1:11      print
    ld   BC, size133    ; 3:10      print Length of string to print
    ld   DE, string133  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
            
;   v---v---v hi_case 104 v---v---v
    ld    A, H          ; 1:4       hi_case 104
                
                        ;[5:17]     hi_of(2) 1 from hi_case 104
    cp   low 2          ; 2:7       hi_of(2) 1 from hi_case 104
    jp   nz, endof104001; 3:10      hi_of(2) 1 from hi_case 104
  
    jp   endcase104     ; 3:10      hi_endof 1 from hi_case 104
endof104001:            ;           hi_endof 1 from hi_case 104
                
                        ;[5:17]     hi_of(3) 2 from hi_case 104
    cp   low 3          ; 2:7       hi_of(3) 2 from hi_case 104
    jp   nz, endof104002; 3:10      hi_of(3) 2 from hi_case 104
  
    jp   endcase104     ; 3:10      hi_endof 2 from hi_case 104
endof104002:            ;           hi_endof 2 from hi_case 104
                
                        ;[5:17]     hi_of(5) 3 from hi_case 104
    cp   low 5          ; 2:7       hi_of(5) 3 from hi_case 104
    jp   nz, endof104003; 3:10      hi_of(5) 3 from hi_case 104
  
    jp   endcase104     ; 3:10      hi_endof 3 from hi_case 104
endof104003:            ;           hi_endof 3 from hi_case 104
                
                        ;[5:17]     hi_of(7) 4 from hi_case 104
    cp   low 7          ; 2:7       hi_of(7) 4 from hi_case 104
    jp   nz, endof104004; 3:10      hi_of(7) 4 from hi_case 104
  
    jp   endcase104     ; 3:10      hi_endof 4 from hi_case 104
endof104004:            ;           hi_endof 4 from hi_case 104
                
                        ;[5:17]     hi_of(11) 5 from hi_case 104
    cp   low 11         ; 2:7       hi_of(11) 5 from hi_case 104
    jp   nz, endof104005; 3:10      hi_of(11) 5 from hi_case 104
 
    jp   endcase104     ; 3:10      hi_endof 5 from hi_case 104
endof104005:            ;           hi_endof 5 from hi_case 104
                
                        ;[5:17]     hi_of(13) 6 from hi_case 104
    cp   low 13         ; 2:7       hi_of(13) 6 from hi_case 104
    jp   nz, endof104006; 3:10      hi_of(13) 6 from hi_case 104
 
    jp   endcase104     ; 3:10      hi_endof 6 from hi_case 104
endof104006:            ;           hi_endof 6 from hi_case 104
                    
    push DE             ; 1:11      print
    ld   BC, size134    ; 3:10      print Length of string to print
    ld   DE, string134  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
            
endcase104:             ;           hi_endcase 104
;   ^---^---^ hi_endcase 104 ^---^---^
        
    jp   endcase102     ; 3:10      lo_endof 3 from lo_case 102
endof102003:            ;           lo_endof 3 from lo_case 102
        
                        ;[5:17]     lo_of(7) 4 from lo_case 102
    cp   low 7          ; 2:7       lo_of(7) 4 from lo_case 102
    jp   nz, endof102004; 3:10      lo_of(7) 4 from lo_case 102
  
    jp   endcase102     ; 3:10      lo_endof 4 from lo_case 102
endof102004:            ;           lo_endof 4 from lo_case 102
        
                        ;[5:17]     lo_of(11) 5 from lo_case 102
    cp   low 11         ; 2:7       lo_of(11) 5 from lo_case 102
    jp   nz, endof102005; 3:10      lo_of(11) 5 from lo_case 102
 
    jp   endcase102     ; 3:10      lo_endof 5 from lo_case 102
endof102005:            ;           lo_endof 5 from lo_case 102
        
                        ;[5:17]     lo_of(13) 6 from lo_case 102
    cp   low 13         ; 2:7       lo_of(13) 6 from lo_case 102
    jp   nz, endof102006; 3:10      lo_of(13) 6 from lo_case 102
 
    jp   endcase102     ; 3:10      lo_endof 6 from lo_case 102
endof102006:            ;           lo_endof 6 from lo_case 102
            
    push DE             ; 1:11      print
    ld   BC, size135    ; 3:10      print Length of string to print
    ld   DE, string135  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
endcase102:             ;           lo_endcase 102
;   ^---^---^ lo_endcase 102 ^---^---^
    
    push DE             ; 1:11      print
    ld   BC, size136    ; 3:10      print Length of string to print
    ld   DE, string136  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A

check_prime_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_S16:
    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    jr   nc, PRINT_U16  ; 2:7/12
    
    xor   A             ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    L, A          ; 1:4       neg
    sbc   A, H          ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    H, A          ; 1:4       neg
    
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      ld   BC, ** 
    
    ; fall to print_u16
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, AF', BC, DE, HL = DE, DE = (SP)
PRINT_U16:
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A

; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_U16_ONLY:
    call BIN2DEC        ; 3:17
    pop  BC             ; 1:10      ret
    ex   DE, HL         ; 1:4
    pop  DE             ; 1:10
    push BC             ; 1:10      ret
    ret                 ; 1:10

; Input: HL = number
; Output: print number
; Pollutes: AF, HL, BC
BIN2DEC:
    xor   A             ; 1:4       A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10
    call BIN2DEC_CHAR+2 ; 3:17    
    ld   BC, -1000      ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld   BC, -100       ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld    C, -10        ; 2:7
    call BIN2DEC_CHAR   ; 3:17
    ld    A, L          ; 1:4
    add   A,'0'         ; 2:7
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10
    
BIN2DEC_CHAR:
    and  0xF0           ; 2:7       '0'..'9' => '0', unchanged 0
    
    add  HL, BC         ; 1:11
    inc   A             ; 1:4
    jr    c, $-2        ; 2:7/12
    sbc  HL, BC         ; 2:15
    dec   A             ; 1:4
    ret   z             ; 1:5/11
    
    or   '0'            ; 2:7       0 => '0', unchanged '0'..'9'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10
VARIABLE_SECTION:

STRING_SECTION:
string136:
db " a prime."
size136 EQU $ - string136
string135:
db " not"
size135 EQU $ - string135
string134:
db " not"
size134 EQU $ - string134
string133:
db " is"
size133 EQU $ - string133
string132:
db ")="
size132 EQU $ - string132
string131:
db "twelve"
size131 EQU $ - string131
string130:
db "eleven"
size130 EQU $ - string130
string129:
db "ten"
size129 EQU $ - string129
string128:
db "nine"
size128 EQU $ - string128
string127:
db "eight"
size127 EQU $ - string127
string126:
db "seven"
size126 EQU $ - string126
string125:
db "six"
size125 EQU $ - string125
string124:
db "five"
size124 EQU $ - string124
string123:
db "four"
size123 EQU $ - string123
string122:
db "three"
size122 EQU $ - string122
string121:
db "two"
size121 EQU $ - string121
string120:
db "one"
size120 EQU $ - string120
string119:
db "zero"
size119 EQU $ - string119
string118:
db " a prime and high("
size118 EQU $ - string118
string117:
db " is"
size117 EQU $ - string117
string116:
db ")="
size116 EQU $ - string116
string115:
db "five+five*256"
size115 EQU $ - string115
string114:
db "twelve"
size114 EQU $ - string114
string113:
db "eleven"
size113 EQU $ - string113
string112:
db "ten"
size112 EQU $ - string112
string111:
db "nine"
size111 EQU $ - string111
string110:
db "eight"
size110 EQU $ - string110
string109:
db "seven"
size109 EQU $ - string109
string108:
db "six"
size108 EQU $ - string108
string107:
db "five"
size107 EQU $ - string107
string106:
db "four"
size106 EQU $ - string106
string105:
db "three"
size105 EQU $ - string105
string104:
db "two"
size104 EQU $ - string104
string103:
db "one"
size103 EQU $ - string103
string102:
db "zero"
size102 EQU $ - string102
string101:
db "lo("
size101 EQU $ - string101

