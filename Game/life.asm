    ORG 0x8000
    
    
    
        
        
        
    








buff                 EQU __create_buff


; kurzor doleva, pozadi doprava

     
             
               
     




     
              
             
     




      
      



      
      



      


    

     
     
        

        
             
        
         
        
        
    
             
             
            
             
            
            
             
             
         
             
              
              
              
        
           
            
        
        
          
     



           



            




    
       
      
      
     
    



      
          
         
           
    



    
     
        
             
    
         
          
             
    
    


;# dup 1- 0x1F and swap 0xFFE0 and + 

;# dup 1+ 0x1F and swap 0xFFE0 and + 


    ; [-1]
      
    ; [+1]
     
    ; [+33]
      
       
         
    
    ; [+32]
      
    ; [+31]
      
    ; [-33]
      
       
         
    
    ; [-32]
      
    ; [-31]
      

     
      
      
      
      
      
      
      
    ; 16 bit --> 8 bit
     



;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 60000      ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
    call _init          ; 3:17      scall
begin101:               ;           begin 101
    call _copy          ; 3:17      scall
    call _generation    ; 3:17      scall
    call _readkey       ; 3:17      scall
    jp   begin101       ; 3:10      again 101
break101:               ;           again 101
_w                   EQU 32
_h                   EQU 24
_wh                  EQU 32*24
_screen              EQU 0x5800
_cursor              EQU 0x5990
_stop                EQU 0x5B00
last_key             EQU 0x5C08
;   ---  the beginning of a data stack function  ---
_left:                  ;           ( -- )
                        ;[8:42]     0x5B00 0x5800 do_101(s)   ( -- 0x5B00 0x5800 )
    push DE             ; 1:11      0x5B00 0x5800 do_101(s)
    push HL             ; 1:11      0x5B00 0x5800 do_101(s)
    ld   DE, 0x5B00     ; 3:10      0x5B00 0x5800 do_101(s)
    ld   HL, 0x5800     ; 3:10      0x5B00 0x5800 do_101(s)
do101:                  ;           0x5B00 0x5800 do_101(s)   ( stop index -- stop index )
                        ;           i_101(s)   ( -- i )
    push DE             ; 1:11      i_101(s)   ( a -- a a )
    ld    D, H          ; 1:4       i_101(s)
    ld    E, L          ; 1:4       i_101(s)
    ; warning The condition >>>buff-0x5800+1<<< cannot be evaluated
    push DE             ; 1:11      i_101 buff-0x5800+1 +   ( x -- x x+buff-0x5800+1 )
    ex   DE, HL         ; 1:4       i_101 buff-0x5800+1 +
    ld   HL, buff-0x5800+1; 3:10      i_101 buff-0x5800+1 +
    add  HL, DE         ; 1:11      i_101 buff-0x5800+1 +
                        ;[8:680]    32-1 cmove   ( from_addr to_addr -- )   u = 32-1 chars
    ld   BC, 32-1       ; 3:10      32-1 cmove   BC = 0x001F
    ex   DE, HL         ; 1:4       32-1 cmove   HL = from_addr, DE = to_addr
    ldir                ; 2:u*21/16 32-1 cmove
    pop  HL             ; 1:10      32-1 cmove
    pop  DE             ; 1:10      32-1 cmove
    push DE             ; 1:11      i_101 32-1 +   ( x -- x x+0x001F )
    ex   DE, HL         ; 1:4       i_101 32-1 +
    ld   HL, 0x001F     ; 3:10      i_101 32-1 +
    add  HL, DE         ; 1:11      i_101 32-1 +
    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch
    push DE             ; 1:11      over buff-0x5800 +   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over buff-0x5800 +
    ; warning M4 does not know the numerical value of >>>buff-0x5800<<<
    ld   BC, buff-0x5800; 3:10      over buff-0x5800 +
    add  HL, BC         ; 1:11      over buff-0x5800 +
    ld  (HL),E          ; 1:7       c!   ( char addr -- )
    pop  HL             ; 1:10      c!
    pop  DE             ; 1:10      c!
    or    A             ; 1:4       32 +loop_101(s)
    sbc  HL, DE         ; 2:15      32 +loop_101(s)   HL = index-stop
    ld   BC, 32         ; 3:10      32 +loop_101(s)   BC = step
    ld    A, H          ; 1:4       32 +loop_101(s)
    add  HL, BC         ; 1:11      32 +loop_101(s)   HL = index-stop+step
    xor   H             ; 1:4       32 +loop_101(s)   sign flag!
    add  HL, DE         ; 1:11      32 +loop_101(s)   HL = index+step, sign flag unaffected
    jp    p, do101      ; 3:10      32 +loop_101(s)
leave101:               ;           32 +loop_101(s)
    pop  HL             ; 1:10      unloop_101(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_101(s)
exit101:                ;           32 +loop_101(s)
_left_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_right:                 ;           ( -- )
                        ;[8:42]     0x5B00 0x5800 do_102(s)   ( -- 0x5B00 0x5800 )
    push DE             ; 1:11      0x5B00 0x5800 do_102(s)
    push HL             ; 1:11      0x5B00 0x5800 do_102(s)
    ld   DE, 0x5B00     ; 3:10      0x5B00 0x5800 do_102(s)
    ld   HL, 0x5800     ; 3:10      0x5B00 0x5800 do_102(s)
do102:                  ;           0x5B00 0x5800 do_102(s)   ( stop index -- stop index )
                        ;           i_102(s)   ( -- i )
    push DE             ; 1:11      i_102(s)   ( a -- a a )
    ld    D, H          ; 1:4       i_102(s)
    ld    E, L          ; 1:4       i_102(s)
    inc  HL             ; 1:6       1+
    push DE             ; 1:11      over buff-0x5800 +   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over buff-0x5800 +
    ; warning M4 does not know the numerical value of >>>buff-0x5800<<<
    ld   BC, buff-0x5800; 3:10      over buff-0x5800 +
    add  HL, BC         ; 1:11      over buff-0x5800 +
                        ;[8:680]    32-1 cmove   ( from_addr to_addr -- )   u = 32-1 chars
    ld   BC, 32-1       ; 3:10      32-1 cmove   BC = 0x001F
    ex   DE, HL         ; 1:4       32-1 cmove   HL = from_addr, DE = to_addr
    ldir                ; 2:u*21/16 32-1 cmove
    pop  HL             ; 1:10      32-1 cmove
    pop  DE             ; 1:10      32-1 cmove
                        ;           i_102(s)   ( -- i )
    push DE             ; 1:11      i_102(s)   ( a -- a a )
    ld    D, H          ; 1:4       i_102(s)
    ld    E, L          ; 1:4       i_102(s)
    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch
    push DE             ; 1:11      over buff-0x5800+32-1 +   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over buff-0x5800+32-1 +
    ; warning M4 does not know the numerical value of >>>buff-0x5800+32-1<<<
    ld   BC, buff-0x5800+32-1; 3:10      over buff-0x5800+32-1 +
    add  HL, BC         ; 1:11      over buff-0x5800+32-1 +
    ld  (HL),E          ; 1:7       c!   ( char addr -- )
    pop  HL             ; 1:10      c!
    pop  DE             ; 1:10      c!
    or    A             ; 1:4       32 +loop_102(s)
    sbc  HL, DE         ; 2:15      32 +loop_102(s)   HL = index-stop
    ld   BC, 32         ; 3:10      32 +loop_102(s)   BC = step
    ld    A, H          ; 1:4       32 +loop_102(s)
    add  HL, BC         ; 1:11      32 +loop_102(s)   HL = index-stop+step
    xor   H             ; 1:4       32 +loop_102(s)   sign flag!
    add  HL, DE         ; 1:11      32 +loop_102(s)   HL = index+step, sign flag unaffected
    jp    p, do102      ; 3:10      32 +loop_102(s)
leave102:               ;           32 +loop_102(s)
    pop  HL             ; 1:10      unloop_102(s)   ( stop_i i -- )
    pop  DE             ; 1:10      unloop_102(s)
exit102:                ;           32 +loop_102(s)
_right_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_down:                  ;           ( -- )
    push DE             ; 1:11      0x5800+32 buff        32*24-32 cmove   ( 0x5800+32 buff        32*24-32 -- )
    push HL             ; 1:11      0x5800+32 buff        32*24-32 cmove
    ld   HL, 0x5820     ; 3:10      0x5800+32 buff        32*24-32 cmove   from_addr
    ld   DE, buff       ; 3:10      0x5800+32 buff        32*24-32 cmove   to_addr
    ld   BC, 0x02E0     ; 3:10      0x5800+32 buff        32*24-32 cmove   u_times
    ldir                ; 2:u*21/16 0x5800+32 buff        32*24-32 cmove
    pop  HL             ; 1:10      0x5800+32 buff        32*24-32 cmove
    pop  DE             ; 1:10      0x5800+32 buff        32*24-32 cmove
    push DE             ; 1:11      0x5800    buff+32*24-32 32     cmove   ( 0x5800    buff+32*24-32 32     -- )
    push HL             ; 1:11      0x5800    buff+32*24-32 32     cmove
    ld   HL, 0x5800     ; 3:10      0x5800    buff+32*24-32 32     cmove   from_addr
    ld   DE, buff+32*24-32; 3:10      0x5800    buff+32*24-32 32     cmove   to_addr
    ld   BC, 0x0020     ; 3:10      0x5800    buff+32*24-32 32     cmove   u_times
    ldir                ; 2:u*21/16 0x5800    buff+32*24-32 32     cmove
    pop  HL             ; 1:10      0x5800    buff+32*24-32 32     cmove
    pop  DE             ; 1:10      0x5800    buff+32*24-32 32     cmove
_down_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_up:                    ;           ( -- )
    push DE             ; 1:11      0x5800  buff+32 32*24-32 cmove   ( 0x5800  buff+32 32*24-32 -- )
    push HL             ; 1:11      0x5800  buff+32 32*24-32 cmove
    ld   HL, 0x5800     ; 3:10      0x5800  buff+32 32*24-32 cmove   from_addr
    ld   DE, buff+32    ; 3:10      0x5800  buff+32 32*24-32 cmove   to_addr
    ld   BC, 0x02E0     ; 3:10      0x5800  buff+32 32*24-32 cmove   u_times
    ldir                ; 2:u*21/16 0x5800  buff+32 32*24-32 cmove
    pop  HL             ; 1:10      0x5800  buff+32 32*24-32 cmove
    pop  DE             ; 1:10      0x5800  buff+32 32*24-32 cmove
    push DE             ; 1:11      0x5B00-32 buff    32     cmove   ( 0x5B00-32 buff    32     -- )
    push HL             ; 1:11      0x5B00-32 buff    32     cmove
    ld   HL, 0x5AE0     ; 3:10      0x5B00-32 buff    32     cmove   from_addr
    ld   DE, buff       ; 3:10      0x5B00-32 buff    32     cmove   to_addr
    ld   BC, 0x0020     ; 3:10      0x5B00-32 buff    32     cmove   u_times
    ldir                ; 2:u*21/16 0x5B00-32 buff    32     cmove
    pop  HL             ; 1:10      0x5B00-32 buff    32     cmove
    pop  DE             ; 1:10      0x5B00-32 buff    32     cmove
_up_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_copy:                  ;           ( -- )
    push DE             ; 1:11      buff 0x5800 32*24 cmove   ( buff 0x5800 32*24 -- )
    push HL             ; 1:11      buff 0x5800 32*24 cmove
    ld   HL, buff       ; 3:10      buff 0x5800 32*24 cmove   from_addr
    ld   DE, 0x5800     ; 3:10      buff 0x5800 32*24 cmove   to_addr
    ld   BC, 0x0300     ; 3:10      buff 0x5800 32*24 cmove   u_times
    ldir                ; 2:u*21/16 buff 0x5800 32*24 cmove
    pop  HL             ; 1:10      buff 0x5800 32*24 cmove
    pop  DE             ; 1:10      buff 0x5800 32*24 cmove
_copy_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_readkey:               ;           ( -- )
    push DE             ; 1:11      0x5C08
    ex   DE, HL         ; 1:4       0x5C08
    ld   HL, 0x5C08     ; 3:10      0x5C08
    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if
begin102:               ;           begin 102
    ld   BC, 0x5990     ; 3:10      swap_cursor
    ld    A,(BC)        ; 1:7       swap_cursor
    xor  0x09           ; 2:7       swap_cursor
    ld  (BC),A          ; 1:7       swap_cursor
begin103:               ;           begin 103
    push DE             ; 1:11      0x5C08
    ex   DE, HL         ; 1:4       0x5C08
    ld   HL, 0x5C08     ; 3:10      0x5C08
    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch
    ld    A, H          ; 1:4       until 103   ( flag -- )
    or    L             ; 1:4       until 103
    ex   DE, HL         ; 1:4       until 103
    pop  DE             ; 1:10      until 103
    jp    z, begin103   ; 3:10      until 103
break103:               ;           until 103
    push DE             ; 1:11      0x5C08 @  push_cfetch(0x5C08)
    ex   DE, HL         ; 1:4       0x5C08 @  push_cfetch(0x5C08)
    ld   HL,(0x5C08)    ; 3:16      0x5C08 @  push_cfetch(0x5C08)
    ld    H, 0x00       ; 2:7       0x5C08 @  push_cfetch(0x5C08)
    xor   A             ; 1:4       0 0x5C08 c!   lo(0) = 0x00
    ld   (0x5C08), A    ; 3:13      0 0x5C08 c!
    ld   BC, 0x5990     ; 3:10      swap_cursor
    ld    A,(BC)        ; 1:7       swap_cursor
    xor  0x09           ; 2:7       swap_cursor
    ld  (BC),A          ; 1:7       swap_cursor
    ld    A, 'q'        ; 2:7       dup 'q' c= if   ( char -- char )
    xor   L             ; 1:4       dup 'q' c= if
    or    H             ; 1:4       dup 'q' c= if
    jp   nz, else102    ; 3:10      dup 'q' c= if
    ld   HL, 0          ; 3:10      drop 0
    call _up            ; 3:17      scall
else102  EQU $          ;           = endif
endif102:
    ld    A, 'a'        ; 2:7       dup 'a' c= if   ( char -- char )
    xor   L             ; 1:4       dup 'a' c= if
    or    H             ; 1:4       dup 'a' c= if
    jp   nz, else103    ; 3:10      dup 'a' c= if
    ld   HL, 0          ; 3:10      drop 0
    call _down          ; 3:17      scall
else103  EQU $          ;           = endif
endif103:
    ld    A, 'p'        ; 2:7       dup 'p' c= if   ( char -- char )
    xor   L             ; 1:4       dup 'p' c= if
    or    H             ; 1:4       dup 'p' c= if
    jp   nz, else104    ; 3:10      dup 'p' c= if
    ld   HL, 0          ; 3:10      drop 0
    call _right         ; 3:17      scall
else104  EQU $          ;           = endif
endif104:
    ld    A, 'o'        ; 2:7       dup 'o' c= if   ( char -- char )
    xor   L             ; 1:4       dup 'o' c= if
    or    H             ; 1:4       dup 'o' c= if
    jp   nz, else105    ; 3:10      dup 'o' c= if
    ld   HL, 0          ; 3:10      drop 0
    call _left          ; 3:17      scall
else105  EQU $          ;           = endif
endif105:
    ld    A, 'r'        ; 2:7       dup 'r' c= if   ( char -- char )
    xor   L             ; 1:4       dup 'r' c= if
    or    H             ; 1:4       dup 'r' c= if
    jp   nz, else106    ; 3:10      dup 'r' c= if
    ld   HL, 0          ; 3:10      drop 0
    call _random_all    ; 3:17      scall
else106  EQU $          ;           = endif
endif106:
    ld    A, 'i'        ; 2:7       dup 'i' c= if   ( char -- char )
    xor   L             ; 1:4       dup 'i' c= if
    or    H             ; 1:4       dup 'i' c= if
    jp   nz, else107    ; 3:10      dup 'i' c= if
    ld   HL, 0          ; 3:10      drop 0
    call _invert_all    ; 3:17      scall
else107  EQU $          ;           = endif
endif107:
    ld    A, 'c'        ; 2:7       dup 'c' c= if   ( char -- char )
    xor   L             ; 1:4       dup 'c' c= if
    or    H             ; 1:4       dup 'c' c= if
    jp   nz, else108    ; 3:10      dup 'c' c= if
    ld   HL, 0          ; 3:10      drop 0
                        ;[18:11364] buff 32*24 0 fill __ASM_TOKEN_PUSH3_FILL(addr,u,char)   variant I: 4..1027 byte
    push HL             ; 1:11      buff 32*24 0 fill
    ld   HL, buff       ; 3:10      buff 32*24 0 fill   HL = addr
    ld   BC, 49152+0    ; 3:10      buff 32*24 0 fill   B = 192x, C = 0
    ld  (HL),C          ; 1:7       buff 32*24 0 fill
  if 0x03 & (buff+1)
    inc   L             ; 1:4       buff 32*24 0 fill
  else
    inc  HL             ; 1:6       buff 32*24 0 fill
  endif
    ld  (HL),C          ; 1:7       buff 32*24 0 fill
  if 0x03 & (buff+2)
    inc   L             ; 1:4       buff 32*24 0 fill
  else
    inc  HL             ; 1:6       buff 32*24 0 fill
  endif
    ld  (HL),C          ; 1:7       buff 32*24 0 fill
  if 0x03 & (buff+3)
    inc   L             ; 1:4       buff 32*24 0 fill
  else
    inc  HL             ; 1:6       buff 32*24 0 fill
  endif
    ld  (HL),C          ; 1:7       buff 32*24 0 fill
  if 0x03 & (buff+0)
    inc   L             ; 1:4       buff 32*24 0 fill
  else
    inc  HL             ; 1:6       buff 32*24 0 fill
  endif
    djnz $-8            ; 2:13/8    buff 32*24 0 fill
    pop  HL             ; 1:10      buff 32*24 0 fill
else108  EQU $          ;           = endif
endif108:
    ld    A, 'f'        ; 2:7       dup 'f' c= if   ( char -- char )
    xor   L             ; 1:4       dup 'f' c= if
    or    H             ; 1:4       dup 'f' c= if
    jp   nz, else109    ; 3:10      dup 'f' c= if
    ld   HL, 0          ; 3:10      drop 0
                        ;[18:11364] buff 32*24 1 fill __ASM_TOKEN_PUSH3_FILL(addr,u,char)   variant I: 4..1027 byte
    push HL             ; 1:11      buff 32*24 1 fill
    ld   HL, buff       ; 3:10      buff 32*24 1 fill   HL = addr
    ld   BC, 49152+1    ; 3:10      buff 32*24 1 fill   B = 192x, C = 1
    ld  (HL),C          ; 1:7       buff 32*24 1 fill
  if 0x03 & (buff+1)
    inc   L             ; 1:4       buff 32*24 1 fill
  else
    inc  HL             ; 1:6       buff 32*24 1 fill
  endif
    ld  (HL),C          ; 1:7       buff 32*24 1 fill
  if 0x03 & (buff+2)
    inc   L             ; 1:4       buff 32*24 1 fill
  else
    inc  HL             ; 1:6       buff 32*24 1 fill
  endif
    ld  (HL),C          ; 1:7       buff 32*24 1 fill
  if 0x03 & (buff+3)
    inc   L             ; 1:4       buff 32*24 1 fill
  else
    inc  HL             ; 1:6       buff 32*24 1 fill
  endif
    ld  (HL),C          ; 1:7       buff 32*24 1 fill
  if 0x03 & (buff+0)
    inc   L             ; 1:4       buff 32*24 1 fill
  else
    inc  HL             ; 1:6       buff 32*24 1 fill
  endif
    djnz $-8            ; 2:13/8    buff 32*24 1 fill
    pop  HL             ; 1:10      buff 32*24 1 fill
else109  EQU $          ;           = endif
endif109:
    ld    A, 's'        ; 2:7       dup 's' c= if   ( char -- char )
    xor   L             ; 1:4       dup 's' c= if
    or    H             ; 1:4       dup 's' c= if
    jp   nz, else110    ; 3:10      dup 's' c= if
    ld   HL, 0          ; 3:10      drop 0
    push DE             ; 1:11      buff+400
    ex   DE, HL         ; 1:4       buff+400
    ld   HL, buff+400   ; 3:10      buff+400
    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch
    ld    A, 0x01       ; 2:7       1 xor
    xor   L             ; 1:4       1 xor
    ld    L, A          ; 1:4       1 xor
    ld    A, L          ; 1:4       buff+400 c!
    ld   (buff+400), A  ; 3:13      buff+400 c!
    ex   DE, HL         ; 1:4       buff+400 c!
    pop  DE             ; 1:10      buff+400 c!
else110  EQU $          ;           = endif
endif110:
    ld    A, 'e'        ; 2:7       dup 'e' c= if   ( char -- char )
    xor   L             ; 1:4       dup 'e' c= if
    or    H             ; 1:4       dup 'e' c= if
    jp   nz, else111    ; 3:10      dup 'e' c= if
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====
else111  EQU $          ;           = endif
endif111:
    call _copy          ; 3:17      scall
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else112    ; 3:10      if
    jp   break102       ; 3:10      break 102
else112  EQU $          ;           = endif
endif112:
    jp   begin102       ; 3:10      again 102
break102:               ;           again 102
else101  EQU $          ;           = endif
endif101:
_readkey_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_random_all:            ;           ( -- )
                        ;[8:42]     buff+32*24 buff do_103(s)   ( -- buff+32*24 buff )
    push DE             ; 1:11      buff+32*24 buff do_103(s)
    push HL             ; 1:11      buff+32*24 buff do_103(s)
    ld   DE, buff+32*24 ; 3:10      buff+32*24 buff do_103(s)
    ld   HL, buff       ; 3:10      buff+32*24 buff do_103(s)
do103:                  ;           buff+32*24 buff do_103(s)   ( stop index -- stop index )
    ex   DE, HL         ; 1:4       rnd
    push HL             ; 1:11      rnd
    call Rnd            ; 3:17      rnd
    ld    A, 0x01       ; 2:7       1 and
    and   L             ; 1:4       1 and
    ld    L, A          ; 1:4       1 and
    ld    H, 0x00       ; 2:7       1 and
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    ld  (HL),E          ; 1:7       c!   ( char addr -- )
    pop  HL             ; 1:10      c!
    pop  DE             ; 1:10      c!
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
_random_all_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_invert_all:            ;           ( -- )
                        ;[8:42]     buff+32*24 buff do_104(s)   ( -- buff+32*24 buff )
    push DE             ; 1:11      buff+32*24 buff do_104(s)
    push HL             ; 1:11      buff+32*24 buff do_104(s)
    ld   DE, buff+32*24 ; 3:10      buff+32*24 buff do_104(s)
    ld   HL, buff       ; 3:10      buff+32*24 buff do_104(s)
do104:                  ;           buff+32*24 buff do_104(s)   ( stop index -- stop index )
                        ;           i_104(s)   ( -- i )
    push DE             ; 1:11      i_104(s)   ( a -- a a )
    ld    D, H          ; 1:4       i_104(s)
    ld    E, L          ; 1:4       i_104(s)
    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch
    ld    A, 0x01       ; 2:7       1 xor
    xor   L             ; 1:4       1 xor
    ld    L, A          ; 1:4       1 xor
    push DE             ; 1:11      over   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over
    ld  (HL),E          ; 1:7       c!   ( char addr -- )
    pop  HL             ; 1:10      c!
    pop  DE             ; 1:10      c!
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
_invert_all_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_init:                  ;           ( -- )
    push DE             ; 1:11      print     0x16, 0, 0
    ld   BC, size101    ; 3:10      print     Length of string101
    ld   DE, string101  ; 3:10      print     Address of string101
    call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    ld   BC, 32*8       ; 3:10      32*8 for_105   ( -- )
for105:                 ;           32*8 for_105
    ld  (idx105),BC     ; 4:20      32*8 for_105   save index
    ld    A, 'O'        ; 2:7       putchar('O')   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar('O')   putchar(reg A) with ZX 48K ROM
idx105 EQU $+1          ;           next_105
    ld   BC, 0x0000     ; 3:10      next_105   idx always points to a 16-bit index
    ld    A, B          ; 1:4       next_105
    or    C             ; 1:4       next_105
    dec  BC             ; 1:6       next_105   index--, zero flag unaffected
    jp   nz, for105     ; 3:10      next_105
leave105:               ;           next_105
    push DE             ; 1:11      0x4000 0x4800 8*256 cmove   ( 0x4000 0x4800 8*256 -- )
    push HL             ; 1:11      0x4000 0x4800 8*256 cmove
    ld   HL, 0x4000     ; 3:10      0x4000 0x4800 8*256 cmove   from_addr
    ld   DE, 0x4800     ; 3:10      0x4000 0x4800 8*256 cmove   to_addr
    ld   BC, 0x0800     ; 3:10      0x4000 0x4800 8*256 cmove   u_times
    ldir                ; 2:u*21/16 0x4000 0x4800 8*256 cmove
    pop  HL             ; 1:10      0x4000 0x4800 8*256 cmove
    pop  DE             ; 1:10      0x4000 0x4800 8*256 cmove
    push DE             ; 1:11      0x4800 0x5000 8*256 cmove   ( 0x4800 0x5000 8*256 -- )
    push HL             ; 1:11      0x4800 0x5000 8*256 cmove
    ld   HL, 0x4800     ; 3:10      0x4800 0x5000 8*256 cmove   from_addr
    ld   DE, 0x5000     ; 3:10      0x4800 0x5000 8*256 cmove   to_addr
    ld   BC, 0x0800     ; 3:10      0x4800 0x5000 8*256 cmove   u_times
    ldir                ; 2:u*21/16 0x4800 0x5000 8*256 cmove
    pop  HL             ; 1:10      0x4800 0x5000 8*256 cmove
    pop  DE             ; 1:10      0x4800 0x5000 8*256 cmove
    xor   A             ; 1:4       0 0x5C08 c!   lo(0) = 0x00
    ld   (0x5C08), A    ; 3:13      0 0x5C08 c!
    call _random_all    ; 3:17      scall
_init_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_generation:            ;           ( -- )
    push DE             ; 1:11      32*24-1
    ex   DE, HL         ; 1:4       32*24-1
    ld   HL, 32*24-1    ; 3:10      32*24-1
for106:                 ;           for_106(s) ( index -- index )
    push DE             ; 1:11      i_106 0x5800 +   ( x -- x x+0x5800 )
    ex   DE, HL         ; 1:4       i_106 0x5800 +   default version
    ld   HL, 0x5800     ; 3:10      i_106 0x5800 +
    add  HL, DE         ; 1:11      i_106 0x5800 +
    call _alive         ; 3:17      scall
    push DE             ; 1:11      over buff +   ( b a -- b a b )
    ex   DE, HL         ; 1:4       over buff +
    ; warning M4 does not know the numerical value of >>>buff<<<
    ld   BC, buff       ; 3:10      over buff +
    add  HL, BC         ; 1:11      over buff +
    ld  (HL),E          ; 1:7       c!   ( char addr -- )
    pop  HL             ; 1:10      c!
    pop  DE             ; 1:10      c!
    ld    A, H          ; 1:4       next_106(s)
    or    L             ; 1:4       next_106(s)
    dec  HL             ; 1:6       next_106(s)   index--
    jp  nz, for106      ; 3:10      next_106(s)
leave106:               ;           next_106(s)
    ex   DE, HL         ; 1:4       unloop_106(s)   ( i -- )
    pop  DE             ; 1:10      unloop_106(s)
_generation_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
_alive:                 ;           ( addr -- alive )
                        ;[5:29]     dup C@ dup_cfetch ( addr -- addr char )
    push DE             ; 1:11      dup C@ dup_cfetch
    ld    E,(HL)        ; 1:7       dup C@ dup_cfetch
    ld    D, 0x00       ; 2:7       dup C@ dup_cfetch
    ex   DE, HL         ; 1:4       dup C@ dup_cfetch
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if
    pop  DE             ; 1:10      0= if
    jp   nz, else113    ; 3:10      0= if
    call sum_neighbors  ; 3:17      scall
                        ;[9:39]     3 = if   variant: hi(3) = zero
    ld    A, low 3      ; 2:7       3 = if
    xor   L             ; 1:4       3 = if
    or    H             ; 1:4       3 = if
    ex   DE, HL         ; 1:4       3 = if
    pop  DE             ; 1:10      3 = if
    jp   nz, else114    ; 3:10      3 = if
    push DE             ; 1:11      1
    ex   DE, HL         ; 1:4       1
    ld   HL, 1          ; 3:10      1
    ret                 ; 1:10      sexit
else114  EQU $          ;           = endif
endif114:
    jp   endif113       ; 3:10      else
else113:
    call sum_neighbors  ; 3:17      scall
    set   0, L          ; 2:8       0x01 or
                        ;[9:39]     3 = if   variant: hi(3) = zero
    ld    A, low 3      ; 2:7       3 = if
    xor   L             ; 1:4       3 = if
    or    H             ; 1:4       3 = if
    ex   DE, HL         ; 1:4       3 = if
    pop  DE             ; 1:10      3 = if
    jp   nz, else115    ; 3:10      3 = if
    push DE             ; 1:11      1
    ex   DE, HL         ; 1:4       1
    ld   HL, 1          ; 3:10      1
    ret                 ; 1:10      sexit
else115  EQU $          ;           = endif
endif115:
endif113:
    push DE             ; 1:11      0
    ex   DE, HL         ; 1:4       0
    ld   HL, 0          ; 3:10      0
_alive_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;   ---  the beginning of a data stack function  ---
sum_neighbors:          ;           ( addr -- sum )
    push DE             ; 1:11      dup   ( a -- a a )
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup
    ld    A, L          ; 1:4       left
    dec   A             ; 1:4       left
    xor   L             ; 1:4       left
    and  0x1F           ; 2:7       left
    xor   L             ; 1:4       left
    ld    L, A          ; 1:4       left
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    A, L          ; 1:4       right
    inc   A             ; 1:4       right
    xor   L             ; 1:4       right
    and  0x1F           ; 2:7       right
    xor   L             ; 1:4       right
    ld    L, A          ; 1:4       right
    push DE             ; 1:11      dup 32 +   ( x -- x x+0x0020 )
    ex   DE, HL         ; 1:4       dup 32 +
    ld   HL, 0x0020     ; 3:10      dup 32 +
    add  HL, DE         ; 1:11      dup 32 +
    ld    A, L          ; 1:4       dup 0x5B00 u>= if    HL>=0x5B00 --> HL-0x5B00>=0 --> not carry if true
    sub   low 0x5B00    ; 2:7       dup 0x5B00 u>= if    HL>=0x5B00 --> HL-0x5B00>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 0x5B00 u>= if    HL>=0x5B00 --> HL-0x5B00>=0 --> not carry if true
    sbc   A, high 0x5B00; 2:7       dup 0x5B00 u>= if    HL>=0x5B00 --> HL-0x5B00>=0 --> not carry if true
    jp    c, else116    ; 3:10      dup 0x5B00 u>= if
    dec  H              ; 1:4       -32*24 +   ( x -- x+0xFD00 )
    dec  H              ; 1:4       -32*24 +
    dec  H              ; 1:4       -32*24 +
else116  EQU $          ;           = endif
endif116:
    push DE             ; 1:11      dup   ( a -- a a )
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup
    ld    A, L          ; 1:4       left
    dec   A             ; 1:4       left
    xor   L             ; 1:4       left
    and  0x1F           ; 2:7       left
    xor   L             ; 1:4       left
    ld    L, A          ; 1:4       left
    push DE             ; 1:11      dup   ( a -- a a )
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup
    ld    A, L          ; 1:4       left
    dec   A             ; 1:4       left
    xor   L             ; 1:4       left
    and  0x1F           ; 2:7       left
    xor   L             ; 1:4       left
    ld    L, A          ; 1:4       left
    push DE             ; 1:11      dup -2*32 +   ( x -- x x+0xFFC0 )
    ex   DE, HL         ; 1:4       dup -2*32 +
    ld   HL, 0xFFC0     ; 3:10      dup -2*32 +
    add  HL, DE         ; 1:11      dup -2*32 +
    ld    A, L          ; 1:4       dup 0x5800 u< if    HL<0x5800 --> HL-0x5800<0 --> carry if true
    sub   low 0x5800    ; 2:7       dup 0x5800 u< if    HL<0x5800 --> HL-0x5800<0 --> carry if true
    ld    A, H          ; 1:4       dup 0x5800 u< if    HL<0x5800 --> HL-0x5800<0 --> carry if true
    sbc   A, high 0x5800; 2:7       dup 0x5800 u< if    HL<0x5800 --> HL-0x5800<0 --> carry if true
    jp   nc, else117    ; 3:10      dup 0x5800 u< if
    inc  H              ; 1:4       32*24 +   ( x -- x+0x0300 )
    inc  H              ; 1:4       32*24 +
    inc  H              ; 1:4       32*24 +
else117  EQU $          ;           = endif
endif117:
    push DE             ; 1:11      dup   ( a -- a a )
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup
    ld    A, L          ; 1:4       right
    inc   A             ; 1:4       right
    xor   L             ; 1:4       right
    and  0x1F           ; 2:7       right
    xor   L             ; 1:4       right
    ld    L, A          ; 1:4       right
    push DE             ; 1:11      dup   ( a -- a a )
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup
    ld    A, L          ; 1:4       right
    inc   A             ; 1:4       right
    xor   L             ; 1:4       right
    and  0x1F           ; 2:7       right
    xor   L             ; 1:4       right
    ld    L, A          ; 1:4       right
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    ex   DE, HL         ; 1:4       swap   ( b a -- a b )
    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    ld    H, 0x00       ; 2:7       0xFF and
sum_neighbors_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------
;==============================================================================
; ( -- rand )
; 16-bit pseudorandom generator
; Out: HL = 0..65535
; Pollutes: AF, AF', HL
Rnd:                    ;[44:182]   rnd
SEED_8BIT EQU $+1
    ld    L, 0x01       ; 2:7       rnd   seed must not be 0
    ld    A, L          ; 1:4       rnd
    rrca                ; 1:4       rnd
    rrca                ; 1:4       rnd
    rrca                ; 1:4       rnd
    xor  0x1F           ; 2:7       rnd   A = 32*L
    add   A, L          ; 2:7       rnd   A = 33*L
    sbc   A, 0xFF       ; 2:7       rnd   carry
    ld  (SEED_8BIT), A  ; 3:13      rnd   save new 8bit number
    ex   AF, AF'        ; 1:4       rnd
SEED EQU $+1
    ld   HL, 0x0001     ; 3:10      rnd   seed must not be 0
    ld    A, H          ; 1:4       rnd
    rra                 ; 1:4       rnd   hi.0 bit to carry
    ld    A, L          ; 1:4       rnd
    rra                 ; 1:4       rnd
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd   hi(xs) ^= hi(xs << 7);
    ld    A, L          ; 1:4       rnd
    rra                 ; 1:4       rnd   lo.0 bit to carry
    ld    A, H          ; 1:4       rnd
    rra                 ; 1:4       rnd
    xor   L             ; 1:4       rnd
    ld    L, A          ; 1:4       rnd   lo(xs) ^= lo(xs << 7) + (xs >> 9);
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd   xs ^= xs << 8;
    ld  (SEED), HL      ; 3:16      rnd   save new 16bit number
    ex   AF, AF'        ; 1:4       rnd
    xor   L             ; 1:4       rnd
    ld    L, A          ; 1:4       rnd
    ld    A, R          ; 2:9       rnd
    xor   H             ; 1:4       rnd
    ld    H, A          ; 1:4       rnd
    ret                 ; 1:10      rnd

STRING_SECTION:
string101:
    db 0x16, 0, 0
  size101   EQU  $ - string101


VARIABLE_SECTION:

__create_buff:
