    ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    
    call _init          ; 3:17      scall
    
begin101:
        
    call _generation    ; 3:17      scall
        
    call _readkey       ; 3:17      scall
        
    call _copy          ; 3:17      scall
    
    jp   begin101       ; 3:10      again 101
break101:               ;           again 101


_w                   EQU 32


_h                   EQU 24


_wh                  EQU 32*24


_screen              EQU 0x5800


_cursor              EQU 0x5990


_stop                EQU 0x5B00


last_key             EQU 0x5C08



;   ---  b e g i n  ---
_left:                  ;           ( -- )
    
    push DE             ; 1:11      push2(0x5B00,0x5800)
    ld   DE, 0x5B00     ; 3:10      push2(0x5B00,0x5800)
    push HL             ; 1:11      push2(0x5B00,0x5800)
    ld   HL, 0x5800     ; 3:10      push2(0x5B00,0x5800) 

sdo101:                 ;           sdo 101 ( stop index -- stop index )
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(buff-0x5800+1)
    ex   DE, HL         ; 1:4       push(buff-0x5800+1)
    ld   HL, buff-0x5800+1; 3:10      push(buff-0x5800+1) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      + 
    push DE             ; 1:11      push(32-1)
    ex   DE, HL         ; 1:4       push(32-1)
    ld   HL, 32-1       ; 3:10      push(32-1) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(32-1)
    ex   DE, HL         ; 1:4       push(32-1)
    ld   HL, 32-1       ; 3:10      push(32-1) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      + 
    ld    L, (HL)       ; 1:7       C@ cfetch 
    ld    H, 0x00       ; 2:7       C@ cfetch 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    push DE             ; 1:11      push(buff-0x5800)
    ex   DE, HL         ; 1:4       push(buff-0x5800)
    ld   HL, buff-0x5800; 3:10      push(buff-0x5800) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      + 
    ld  (HL), E         ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore
    
    ld   BC, 32         ; 3:10      push_addsloop(32) 101 BC = step
    or    A             ; 1:4       push_addsloop(32) 101
    sbc  HL, DE         ; 2:15      push_addsloop(32) 101 HL = index-stop
    ld    A, H          ; 1:4       push_addsloop(32) 101
    add  HL, BC         ; 1:11      push_addsloop(32) 101 HL = index-stop+step
    xor   H             ; 1:4       push_addsloop(32) 101 sign flag!
    add  HL, DE         ; 1:11      push_addsloop(32) 101 HL = index+step, sign flag unaffected
    jp    p, sdo101     ; 3:10      push_addsloop(32) 101
sleave101:              ;           push_addsloop(32) 101
    pop  HL             ; 1:10      unsloop 101 index out
    pop  DE             ; 1:10      unsloop 101 stop  out


_left_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


;   ---  b e g i n  ---
_right:                 ;           ( -- )
    
    push DE             ; 1:11      push2(0x5B00,0x5800)
    ld   DE, 0x5B00     ; 3:10      push2(0x5B00,0x5800)
    push HL             ; 1:11      push2(0x5B00,0x5800)
    ld   HL, 0x5800     ; 3:10      push2(0x5B00,0x5800) 

sdo102:                 ;           sdo 102 ( stop index -- stop index )
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    inc  HL             ; 1:6       1+ 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    push DE             ; 1:11      push(buff-0x5800)
    ex   DE, HL         ; 1:4       push(buff-0x5800)
    ld   HL, buff-0x5800; 3:10      push(buff-0x5800) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      + 
    push DE             ; 1:11      push(32-1)
    ex   DE, HL         ; 1:4       push(32-1)
    ld   HL, 32-1       ; 3:10      push(32-1) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    L, (HL)       ; 1:7       C@ cfetch 
    ld    H, 0x00       ; 2:7       C@ cfetch 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    push DE             ; 1:11      push(buff-0x5800+32-1)
    ex   DE, HL         ; 1:4       push(buff-0x5800+32-1)
    ld   HL, buff-0x5800+32-1; 3:10      push(buff-0x5800+32-1) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      + 
    ld  (HL), E         ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore
    
    ld   BC, 32         ; 3:10      push_addsloop(32) 102 BC = step
    or    A             ; 1:4       push_addsloop(32) 102
    sbc  HL, DE         ; 2:15      push_addsloop(32) 102 HL = index-stop
    ld    A, H          ; 1:4       push_addsloop(32) 102
    add  HL, BC         ; 1:11      push_addsloop(32) 102 HL = index-stop+step
    xor   H             ; 1:4       push_addsloop(32) 102 sign flag!
    add  HL, DE         ; 1:11      push_addsloop(32) 102 HL = index+step, sign flag unaffected
    jp    p, sdo102     ; 3:10      push_addsloop(32) 102
sleave102:              ;           push_addsloop(32) 102
    pop  HL             ; 1:10      unsloop 102 index out
    pop  DE             ; 1:10      unsloop 102 stop  out


_right_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


;   ---  b e g i n  ---
_down:                  ;           ( -- )
    
    push DE             ; 1:11      push(0x5800+32)
    ex   DE, HL         ; 1:4       push(0x5800+32)
    ld   HL, 0x5800+32  ; 3:10      push(0x5800+32) 
    push DE             ; 1:11      push2(buff       ,32*24-32)
    ld   DE, buff       ; 3:10      push2(buff       ,32*24-32)
    push HL             ; 1:11      push2(buff       ,32*24-32)
    ld   HL, 32*24-32   ; 3:10      push2(buff       ,32*24-32) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove
    
    push DE             ; 1:11      push(0x5800   )
    ex   DE, HL         ; 1:4       push(0x5800   )
    ld   HL, 0x5800     ; 3:10      push(0x5800   ) 
    push DE             ; 1:11      push2(buff+32*24-32,32    )
    ld   DE, buff+32*24-32; 3:10      push2(buff+32*24-32,32    )
    push HL             ; 1:11      push2(buff+32*24-32,32    )
    ld   HL, 32         ; 3:10      push2(buff+32*24-32,32    ) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove

_down_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


;   ---  b e g i n  ---
_up:                    ;           ( -- )
    
    push DE             ; 1:11      push(0x5800  )
    ex   DE, HL         ; 1:4       push(0x5800  )
    ld   HL, 0x5800     ; 3:10      push(0x5800  ) 
    push DE             ; 1:11      push2(buff+32,32*24-32)
    ld   DE, buff+32    ; 3:10      push2(buff+32,32*24-32)
    push HL             ; 1:11      push2(buff+32,32*24-32)
    ld   HL, 32*24-32   ; 3:10      push2(buff+32,32*24-32) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove
    
    push DE             ; 1:11      push(0x5B00-32 )
    ex   DE, HL         ; 1:4       push(0x5B00-32 )
    ld   HL, 0x5B00-32  ; 3:10      push(0x5B00-32 ) 
    push DE             ; 1:11      push2(buff   ,32    )
    ld   DE, buff       ; 3:10      push2(buff   ,32    )
    push HL             ; 1:11      push2(buff   ,32    )
    ld   HL, 32         ; 3:10      push2(buff   ,32    ) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove

_up_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


;   ---  b e g i n  ---
_copy:                  ;           ( -- )
    
    push DE             ; 1:11      push(buff)
    ex   DE, HL         ; 1:4       push(buff)
    ld   HL, buff       ; 3:10      push(buff) 
    push DE             ; 1:11      push2(0x5800,32*24)
    ld   DE, 0x5800     ; 3:10      push2(0x5800,32*24)
    push HL             ; 1:11      push2(0x5800,32*24)
    ld   HL, 32*24      ; 3:10      push2(0x5800,32*24) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove

_copy_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

    

;   ---  b e g i n  ---
_readkey:               ;           ( -- )
    
    push DE             ; 1:11      0x5C08 @ push(0x5C08) cfetch 
    ex   DE, HL         ; 1:4       0x5C08 @ push(0x5C08) cfetch
    ld   HL,(0x5C08)    ; 3:16      0x5C08 @ push(0x5C08) cfetch
    ld    H, 0x00       ; 2:7       0x5C08 @ push(0x5C08) cfetch
    
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else101    ; 3:10      if 
begin102:
        
    ld   BC, 0x5990     ; 3:10      swap_cursor
    ld    A,(BC)        ; 1:7       swap_cursor
    xor  0x09           ; 2:7       swap_cursor
    ld  (BC),A          ; 1:7       swap_cursor
        
begin103:
            
    push DE             ; 1:11      0x5C08 @ push(0x5C08) cfetch 
    ex   DE, HL         ; 1:4       0x5C08 @ push(0x5C08) cfetch
    ld   HL,(0x5C08)    ; 3:16      0x5C08 @ push(0x5C08) cfetch
    ld    H, 0x00       ; 2:7       0x5C08 @ push(0x5C08) cfetch
        
    ld    A, H          ; 1:4       until 103
    or    L             ; 1:4       until 103
    ex   DE, HL         ; 1:4       until 103
    pop  DE             ; 1:10      until 103
    jp    z, begin103   ; 3:10      until 103
break103:               ;           until 103
        
    push DE             ; 1:11      0x5C08 @ push(0x5C08) cfetch 
    ex   DE, HL         ; 1:4       0x5C08 @ push(0x5C08) cfetch
    ld   HL,(0x5C08)    ; 3:16      0x5C08 @ push(0x5C08) cfetch
    ld    H, 0x00       ; 2:7       0x5C08 @ push(0x5C08) cfetch 
        
    push DE             ; 1:11      push2(0,0x5C08)
    ld   DE, 0          ; 3:10      push2(0,0x5C08)
    push HL             ; 1:11      push2(0,0x5C08)
    ld   HL, 0x5C08     ; 3:10      push2(0,0x5C08) 
    ld  (HL), E         ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore
        
    ld   BC, 0x5990     ; 3:10      swap_cursor
    ld    A,(BC)        ; 1:7       swap_cursor
    xor  0x09           ; 2:7       swap_cursor
    ld  (BC),A          ; 1:7       swap_cursor    
        
    ld    A, 'q'        ; 2:7       dup 'q' = if
    xor   L             ; 1:4       dup 'q' = if
    or    H             ; 1:4       dup 'q' = if
    jp   nz, else102    ; 3:10      dup 'q' = if 
    ld   HL, 0          ; 3:10      drop 0 
    call _up            ; 3:17      scall  
else102  EQU $          ;           = endif
endif102:
        
    ld    A, 'a'        ; 2:7       dup 'a' = if
    xor   L             ; 1:4       dup 'a' = if
    or    H             ; 1:4       dup 'a' = if
    jp   nz, else103    ; 3:10      dup 'a' = if 
    ld   HL, 0          ; 3:10      drop 0 
    call _down          ; 3:17      scall  
else103  EQU $          ;           = endif
endif103:
        
    ld    A, 'p'        ; 2:7       dup 'p' = if
    xor   L             ; 1:4       dup 'p' = if
    or    H             ; 1:4       dup 'p' = if
    jp   nz, else104    ; 3:10      dup 'p' = if 
    ld   HL, 0          ; 3:10      drop 0 
    call _right         ; 3:17      scall 
else104  EQU $          ;           = endif
endif104:
        
    ld    A, 'o'        ; 2:7       dup 'o' = if
    xor   L             ; 1:4       dup 'o' = if
    or    H             ; 1:4       dup 'o' = if
    jp   nz, else105    ; 3:10      dup 'o' = if 
    ld   HL, 0          ; 3:10      drop 0 
    call _left          ; 3:17      scall  
else105  EQU $          ;           = endif
endif105:
        
    ld    A, 'm'        ; 2:7       dup 'm' = if
    xor   L             ; 1:4       dup 'm' = if
    or    H             ; 1:4       dup 'm' = if
    jp   nz, else106    ; 3:10      dup 'm' = if 
            
    ld   HL, 0          ; 3:10      drop 0
            
    push DE             ; 1:11      buff+400 @ push(buff+400) cfetch 
    ex   DE, HL         ; 1:4       buff+400 @ push(buff+400) cfetch
    ld   HL,(buff+400)  ; 3:16      buff+400 @ push(buff+400) cfetch
    ld    H, 0x00       ; 2:7       buff+400 @ push(buff+400) cfetch 
            
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ld    A, E          ; 1:4       xor
    xor   L             ; 1:4       xor
    ld    L, A          ; 1:4       xor
    ld    A, D          ; 1:4       xor
    xor   H             ; 1:4       xor
    ld    H, A          ; 1:4       xor
    pop  DE             ; 1:10      xor 
            
    ld    A, L          ; 1:4       buff+400 C! push(buff+400) cstore
    ld    (buff+400), A  ; 3:13      buff+400 C! push(buff+400) cstore
    ex   DE, HL         ; 1:4       buff+400 C! push(buff+400) cstore
    pop  DE             ; 1:10      buff+400 C! push(buff+400) cstore 
        
else106  EQU $          ;           = endif
endif106:
        
    ld    A, 'e'        ; 2:7       dup 'e' = if
    xor   L             ; 1:4       dup 'e' = if
    or    H             ; 1:4       dup 'e' = if
    jp   nz, else107    ; 3:10      dup 'e' = if
            
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====
        
else107  EQU $          ;           = endif
endif107:
        
    call _copy          ; 3:17      scall
        
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else108    ; 3:10      if 
    jp   break102       ; 3:10      break 102 
else108  EQU $          ;           = endif
endif108:
    
    jp   begin102       ; 3:10      again 102
break102:               ;           again 102 
else101  EQU $          ;           = endif
endif101:

_readkey_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----
    

;   ---  b e g i n  ---
_init:                  ;           ( -- )
    
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push(32*8)
    ex   DE, HL         ; 1:4       push(32*8)
    ld   HL, 32*8       ; 3:10      push(32*8) 
sfor103:                ;           sfor 103 ( index -- index ) 
    ld    A, 'O'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    ld   A, H           ; 1:4       snext 103
    or   L              ; 1:4       snext 103
    dec  HL             ; 1:6       snext 103 index--
    jp  nz, sfor103     ; 3:10      snext 103
snext103:               ;           snext 103
    ex   DE, HL         ; 1:4       sfor unloop 103
    pop  DE             ; 1:10      sfor unloop 103
    
    push DE             ; 1:11      push(0x4000)
    ex   DE, HL         ; 1:4       push(0x4000)
    ld   HL, 0x4000     ; 3:10      push(0x4000) 
    push DE             ; 1:11      push2(0x4800,8*256)
    ld   DE, 0x4800     ; 3:10      push2(0x4800,8*256)
    push HL             ; 1:11      push2(0x4800,8*256)
    ld   HL, 8*256      ; 3:10      push2(0x4800,8*256) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove
    
    push DE             ; 1:11      push(0x4800)
    ex   DE, HL         ; 1:4       push(0x4800)
    ld   HL, 0x4800     ; 3:10      push(0x4800) 
    push DE             ; 1:11      push2(0x5000,8*256)
    ld   DE, 0x5000     ; 3:10      push2(0x5000,8*256)
    push HL             ; 1:11      push2(0x5000,8*256)
    ld   HL, 8*256      ; 3:10      push2(0x5000,8*256) 
    ld    A, H          ; 1:4       cmove
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u
    pop  HL             ; 1:10      cmove HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove
    
    push DE             ; 1:11      push2(0,0x5C08)
    ld   DE, 0          ; 3:10      push2(0,0x5C08)
    push HL             ; 1:11      push2(0,0x5C08)
    ld   HL, 0x5C08     ; 3:10      push2(0,0x5C08) 
    ld  (HL), E         ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore
    
    push DE             ; 1:11      push2(0x5800+32*24,0x5800)
    ld   DE, 0x5800+32*24; 3:10      push2(0x5800+32*24,0x5800)
    push HL             ; 1:11      push2(0x5800+32*24,0x5800)
    ld   HL, 0x5800     ; 3:10      push2(0x5800+32*24,0x5800) 

sdo104:                 ;           sdo 104 ( stop index -- stop index ) 
    ex   DE, HL         ; 1:4       rnd
    push HL             ; 1:11      rnd
    call Rnd            ; 3:17      rnd 
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ld    A, E          ; 1:4       and
    and   L             ; 1:4       and
    ld    L, A          ; 1:4       and
    ld    A, D          ; 1:4       and
    and   H             ; 1:4       and
    ld    H, A          ; 1:4       and
    pop  DE             ; 1:10      and 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ld  (HL), E         ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore 
    inc  HL             ; 1:6       sloop 104 index++
    ld    A, E          ; 1:4       sloop 104
    xor   L             ; 1:4       sloop 104 lo index - stop
    jp   nz, sdo104     ; 3:10      sloop 104
    ld    A, D          ; 1:4       sloop 104
    xor   H             ; 1:4       sloop 104 hi index - stop
    jp   nz, sdo104     ; 3:10      sloop 104
sleave104:              ;           sloop 104
    pop  HL             ; 1:10      unsloop 104 index out
    pop  DE             ; 1:10      unsloop 104 stop  out
 

_init_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


;   ---  b e g i n  ---
_generation:            ;           ( -- )
    
    push DE             ; 1:11      push(32*24-1)
    ex   DE, HL         ; 1:4       push(32*24-1)
    ld   HL, 32*24-1    ; 3:10      push(32*24-1) 
sfor105:                ;           sfor 105 ( index -- index ) 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(0x5800)
    ex   DE, HL         ; 1:4       push(0x5800)
    ld   HL, 0x5800     ; 3:10      push(0x5800) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
        
    call _alive         ; 3:17      scall 
        
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    push DE             ; 1:11      push(buff)
    ex   DE, HL         ; 1:4       push(buff)
    ld   HL, buff       ; 3:10      push(buff) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      + 
    ld  (HL), E         ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore
    
    ld   A, H           ; 1:4       snext 105
    or   L              ; 1:4       snext 105
    dec  HL             ; 1:6       snext 105 index--
    jp  nz, sfor105     ; 3:10      snext 105
snext105:               ;           snext 105
    ex   DE, HL         ; 1:4       sfor unloop 105
    pop  DE             ; 1:10      sfor unloop 105

_generation_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----


;   ---  b e g i n  ---
_alive:                 ;           ( addr -- alive )
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )
    
    ld    L, (HL)       ; 1:7       C@ cfetch 
    ld    H, 0x00       ; 2:7       C@ cfetch 
    ld    A, H          ; 1:4       0= if
    or    L             ; 1:4       0= if
    ex   DE, HL         ; 1:4       0= if      
    pop  DE             ; 1:10      0= if
    jp   nz, else109    ; 3:10      0= if
        
    call sum_neighbors  ; 3:17      scall 
    push DE             ; 1:11      push(0x07)
    ex   DE, HL         ; 1:4       push(0x07)
    ld   HL, 0x07       ; 3:10      push(0x07) 
    ld    A, E          ; 1:4       and
    and   L             ; 1:4       and
    ld    L, A          ; 1:4       and
    ld    A, D          ; 1:4       and
    and   H             ; 1:4       and
    ld    H, A          ; 1:4       and
    pop  DE             ; 1:10      and
        
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    or    A             ; 1:4       = if
    sbc  HL, DE         ; 2:15      = if
    pop  HL             ; 1:10      = if
    pop  DE             ; 1:10      = if
    jp   nz, else110    ; 3:10      = if 
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    jp   _alive_end     ; 3:10      exit 
else110  EQU $          ;           = endif
endif110:
    
    jp   endif109       ; 3:10      else
else109:
        
    call sum_neighbors  ; 3:17      scall 
    push DE             ; 1:11      push(0x07)
    ex   DE, HL         ; 1:4       push(0x07)
    ld   HL, 0x07       ; 3:10      push(0x07) 
    ld    A, E          ; 1:4       and
    and   L             ; 1:4       and
    ld    L, A          ; 1:4       and
    ld    A, D          ; 1:4       and
    and   H             ; 1:4       and
    ld    H, A          ; 1:4       and
    pop  DE             ; 1:10      and 
        
    push DE             ; 1:11      push(0x01)
    ex   DE, HL         ; 1:4       push(0x01)
    ld   HL, 0x01       ; 3:10      push(0x01) 
    ld    A, E          ; 1:4       or
    or    L             ; 1:4       or
    ld    L, A          ; 1:4       or
    ld    A, D          ; 1:4       or
    or    H             ; 1:4       or
    ld    H, A          ; 1:4       or
    pop  DE             ; 1:10      or 
        
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3) 
    or    A             ; 1:4       = if
    sbc  HL, DE         ; 2:15      = if
    pop  HL             ; 1:10      = if
    pop  DE             ; 1:10      = if
    jp   nz, else111    ; 3:10      = if 
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    jp   _alive_end     ; 3:10      exit 
else111  EQU $          ;           = endif
endif111:
    
endif109:
    
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0)

_alive_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----

; dup 1- 0x1F and swap 0xFFE0 and + 

; dup 1+ 0x1F and swap 0xFFE0 and + 


;   ---  b e g i n  ---
sum_neighbors:          ;           ( addr -- sum )
    ; [-1]
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )  
    ld    A, L          ; 1:4       left
    dec   A             ; 1:4       left
    xor   L             ; 1:4       left
    and  0x1F           ; 2:7       left
    xor   L             ; 1:4       left
    ld    L, A          ; 1:4       left
    ; [+1]
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, L          ; 1:4       right
    inc   A             ; 1:4       right
    xor   L             ; 1:4       right
    and  0x1F           ; 2:7       right
    xor   L             ; 1:4       right
    ld    L, A          ; 1:4       right
    ; [+33]
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(32)
    ex   DE, HL         ; 1:4       push(32)
    ld   HL, 32         ; 3:10      push(32) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
    ld    A, H          ; 1:4       dup 0x5B00 >= if
    add   A, A          ; 1:4       dup 0x5B00 >= if
    jp    c, else112    ; 3:10      dup 0x5B00 >= if    positive constant
    ld    A, L          ; 1:4       dup 0x5B00 >= if    (HL>=0x5B00) --> (HL-0x5B00>=0) --> not carry if true
    sub   low 0x5B00    ; 2:7       dup 0x5B00 >= if    (HL>=0x5B00) --> (HL-0x5B00>=0) --> not carry if true
    ld    A, H          ; 1:4       dup 0x5B00 >= if    (HL>=0x5B00) --> (HL-0x5B00>=0) --> not carry if true
    sbc   A, high 0x5B00; 2:7       dup 0x5B00 >= if    (HL>=0x5B00) --> (HL-0x5B00>=0) --> not carry if true
    jp    c, else112    ; 3:10      dup 0x5B00 >= if
        
    push DE             ; 1:11      push(-32*24)
    ex   DE, HL         ; 1:4       push(-32*24)
    ld   HL, -32*24     ; 3:10      push(-32*24) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
else112  EQU $          ;           = endif
endif112:
    ; [+32]
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )  
    ld    A, L          ; 1:4       left
    dec   A             ; 1:4       left
    xor   L             ; 1:4       left
    and  0x1F           ; 2:7       left
    xor   L             ; 1:4       left
    ld    L, A          ; 1:4       left
    ; [+31]
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )  
    ld    A, L          ; 1:4       left
    dec   A             ; 1:4       left
    xor   L             ; 1:4       left
    and  0x1F           ; 2:7       left
    xor   L             ; 1:4       left
    ld    L, A          ; 1:4       left
    ; [-33]
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(-2*32)
    ex   DE, HL         ; 1:4       push(-2*32)
    ld   HL, -2*32      ; 3:10      push(-2*32) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
    ld    A, H          ; 1:4       dup 0x5800 < if
    add   A, A          ; 1:4       dup 0x5800 < if
    jr    c, $+11       ; 2:7/12    dup 0x5800 < if    positive constant
    ld    A, L          ; 1:4       dup 0x5800 < if    (HL<0x5800) --> (HL-0x5800<0) --> carry if true
    sub   low 0x5800    ; 2:7       dup 0x5800 < if    (HL<0x5800) --> (HL-0x5800<0) --> carry if true
    ld    A, H          ; 1:4       dup 0x5800 < if    (HL<0x5800) --> (HL-0x5800<0) --> carry if true
    sbc   A, high 0x5800; 2:7       dup 0x5800 < if    (HL<0x5800) --> (HL-0x5800<0) --> carry if true
    jp   nc, else113    ; 3:10      dup 0x5800 < if
        
    push DE             ; 1:11      push(32*24)
    ex   DE, HL         ; 1:4       push(32*24)
    ld   HL, 32*24      ; 3:10      push(32*24) 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
else113  EQU $          ;           = endif
endif113:
    ; [-32]
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )  
    ld    A, L          ; 1:4       right
    inc   A             ; 1:4       right
    xor   L             ; 1:4       right
    and  0x1F           ; 2:7       right
    xor   L             ; 1:4       right
    ld    L, A          ; 1:4       right
    ; [-31]
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a )  
    ld    A, L          ; 1:4       right
    inc   A             ; 1:4       right
    xor   L             ; 1:4       right
    and  0x1F           ; 2:7       right
    xor   L             ; 1:4       right
    ld    L, A          ; 1:4       right

    
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:4       +
    pop  DE             ; 1:10      +

sum_neighbors_end:
    ret                 ; 1:10      s;
;   -----  e n d  -----



; ( -- rand )
; 16-bit pseudorandom generator
; Out: HL = 0..65535
Rnd:
SEED EQU $+1
    ld   HL, 0x0001     ; 3:10      seed must not be 0
    ld    A, H          ; 1:4
    rra                 ; 1:4
    ld    A, L          ; 1:4
    rra                 ; 1:4
    xor   H             ; 1:4
    ld    H, A          ; 1:4       xs ^= xs << 7;
    rra                 ; 1:4
    xor   L             ; 1:4
    ld    L, A          ; 1:4       xs ^= xs >> 9;
    xor   H             ; 1:4
    ld    H, A          ; 1:4       xs ^= xs << 8;
    ld  (SEED), HL      ; 3:16

Rnd_8a EQU $+1
    ld    A, 0x01       ; 2:7
    rrca                ; 1:4       multiply by 32
    rrca                ; 1:4
    rrca                ; 1:4
    xor  0x1F           ; 2:7
Rnd_8b EQU $+1
    add   A, 0x01       ; 2:7
    sbc   A, 0xFF       ; 1:4       carry
    ld  (Rnd_8a), A     ; 3:13
    ld  (Rnd_8b), A     ; 3:13
    
    xor   H             ; 1:4
    ld    H, A          ; 1:4
    ld    A, R          ; 2:9
    xor   L             ; 1:4
    ld    L, A          ; 1:4
    ret                 ; 1:10
VARIABLE_SECTION:

STRING_SECTION:
string101:
db 0x16, 0, 0
size101 EQU $ - string101


buff:
