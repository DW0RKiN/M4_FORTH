    ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000      ; 3:10
    exx                 ; 1:4
    
    call _init          ; 3:17      scall
    
begin101:
        
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


; kurzor doleva, pozadi doprava

;   ---  the beginning of a data stack function  ---
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
    ; warning The condition >>>buff-0x5800+1<<< cannot be evaluated
    ld   BC, buff-0x5800+1; 3:10      buff-0x5800+1 +
    add  HL, BC         ; 1:11      buff-0x5800+1 + 
    ld   BC, 32-1       ; 3:10      32-1 cmove BC = u
    ex   DE, HL         ; 1:4       32-1 cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 32-1 cmove
    pop  HL             ; 1:10      32-1 cmove
    pop  DE             ; 1:10      32-1 cmove
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   BC, 32-1       ; 3:10      32-1 +
    add  HL, BC         ; 1:11      32-1 + 
    ld    L, (HL)       ; 1:7       C@ cfetch 
    ld    H, 0x00       ; 2:7       C@ cfetch 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ; warning The condition >>>buff-0x5800<<< cannot be evaluated
    ld   BC, buff-0x5800; 3:10      buff-0x5800 +
    add  HL, BC         ; 1:11      buff-0x5800 + 
    ld  (HL),E          ; 1:7       C! cstore
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
;   ---------  end of data stack function  ---------


;   ---  the beginning of a data stack function  ---
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
    ; warning The condition >>>buff-0x5800<<< cannot be evaluated
    ld   BC, buff-0x5800; 3:10      buff-0x5800 +
    add  HL, BC         ; 1:11      buff-0x5800 + 
    ld   BC, 32-1       ; 3:10      32-1 cmove BC = u
    ex   DE, HL         ; 1:4       32-1 cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 32-1 cmove
    pop  HL             ; 1:10      32-1 cmove
    pop  DE             ; 1:10      32-1 cmove
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    L, (HL)       ; 1:7       C@ cfetch 
    ld    H, 0x00       ; 2:7       C@ cfetch 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ; warning The condition >>>buff-0x5800+32-1<<< cannot be evaluated
    ld   BC, buff-0x5800+32-1; 3:10      buff-0x5800+32-1 +
    add  HL, BC         ; 1:11      buff-0x5800+32-1 + 
    ld  (HL),E          ; 1:7       C! cstore
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
;   ---------  end of data stack function  ---------


;   ---  the beginning of a data stack function  ---
_down:                  ;           ( -- )
    
    push DE             ; 1:11      push2(0x5800+32,buff       )
    ld   DE, 0x5800+32  ; 3:10      push2(0x5800+32,buff       )
    push HL             ; 1:11      push2(0x5800+32,buff       )
    ld   HL, buff       ; 3:10      push2(0x5800+32,buff       ) 
    ld   BC, 32*24-32   ; 3:10      32*24-32 cmove BC = u
    ex   DE, HL         ; 1:4       32*24-32 cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 32*24-32 cmove
    pop  HL             ; 1:10      32*24-32 cmove
    pop  DE             ; 1:10      32*24-32 cmove
    
    push DE             ; 1:11      push2(0x5800   ,buff+32*24-32)
    ld   DE, 0x5800     ; 3:10      push2(0x5800   ,buff+32*24-32)
    push HL             ; 1:11      push2(0x5800   ,buff+32*24-32)
    ld   HL, buff+32*24-32; 3:10      push2(0x5800   ,buff+32*24-32) 
    ld   BC, 32         ; 3:10      32     cmove BC = u
    ex   DE, HL         ; 1:4       32     cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 32     cmove
    pop  HL             ; 1:10      32     cmove
    pop  DE             ; 1:10      32     cmove

_down_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


;   ---  the beginning of a data stack function  ---
_up:                    ;           ( -- )
    
    push DE             ; 1:11      push2(0x5800 ,buff+32)
    ld   DE, 0x5800     ; 3:10      push2(0x5800 ,buff+32)
    push HL             ; 1:11      push2(0x5800 ,buff+32)
    ld   HL, buff+32    ; 3:10      push2(0x5800 ,buff+32) 
    ld   BC, 32*24-32   ; 3:10      32*24-32 cmove BC = u
    ex   DE, HL         ; 1:4       32*24-32 cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 32*24-32 cmove
    pop  HL             ; 1:10      32*24-32 cmove
    pop  DE             ; 1:10      32*24-32 cmove
    
    push DE             ; 1:11      push2(0x5B00-32,buff   )
    ld   DE, 0x5B00-32  ; 3:10      push2(0x5B00-32,buff   )
    push HL             ; 1:11      push2(0x5B00-32,buff   )
    ld   HL, buff       ; 3:10      push2(0x5B00-32,buff   ) 
    ld   BC, 32         ; 3:10      32     cmove BC = u
    ex   DE, HL         ; 1:4       32     cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 32     cmove
    pop  HL             ; 1:10      32     cmove
    pop  DE             ; 1:10      32     cmove

_up_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


;   ---  the beginning of a data stack function  ---
_copy:                  ;           ( -- )
    
    push DE             ; 1:11      push2(buff,0x5800)
    ld   DE, buff       ; 3:10      push2(buff,0x5800)
    push HL             ; 1:11      push2(buff,0x5800)
    ld   HL, 0x5800     ; 3:10      push2(buff,0x5800) 
    ld   BC, 32*24      ; 3:10      32*24 cmove BC = u
    ex   DE, HL         ; 1:4       32*24 cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 32*24 cmove
    pop  HL             ; 1:10      32*24 cmove
    pop  DE             ; 1:10      32*24 cmove

_copy_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------

    

;   ---  the beginning of a data stack function  ---
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
        
    ld    A, 0          ; 2:7       push2_cstore(0,0x5C08)
    ld   (0x5C08), A    ; 3:13      push2_cstore(0,0x5C08)
        
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
        
    ld    A, 'r'        ; 2:7       dup 'r' = if
    xor   L             ; 1:4       dup 'r' = if
    or    H             ; 1:4       dup 'r' = if
    jp   nz, else106    ; 3:10      dup 'r' = if 
    ld   HL, 0          ; 3:10      drop 0 
    call _random_all    ; 3:17      scall 
else106  EQU $          ;           = endif
endif106:
        
    ld    A, 'i'        ; 2:7       dup 'i' = if
    xor   L             ; 1:4       dup 'i' = if
    or    H             ; 1:4       dup 'i' = if
    jp   nz, else107    ; 3:10      dup 'i' = if 
    ld   HL, 0          ; 3:10      drop 0 
    call _invert_all    ; 3:17      scall 
else107  EQU $          ;           = endif
endif107:
        
    ld    A, 'c'        ; 2:7       dup 'c' = if
    xor   L             ; 1:4       dup 'c' = if
    or    H             ; 1:4       dup 'c' = if
    jp   nz, else108    ; 3:10      dup 'c' = if 
    ld   HL, 0          ; 3:10      drop 0 
    push DE             ; 1:11      buff 32*24 0 fill
    push HL             ; 1:11      buff 32*24 0 fill
    ld   HL, buff       ; 3:10      buff 32*24 0 fill HL = from
    ld   DE, buff+1     ; 3:10      buff 32*24 0 fill DE = to
    ld   BC, 32*24-1    ; 3:10      buff 32*24 0 fill
    ld  (HL),0          ; 2:10      buff 32*24 0 fill
    ldir                ; 2:u*21/16 buff 32*24 0 fill
    pop  HL             ; 1:10      buff 32*24 0 fill
    pop  DE             ; 1:10      buff 32*24 0 fill 
else108  EQU $          ;           = endif
endif108:
        
    ld    A, 'f'        ; 2:7       dup 'f' = if
    xor   L             ; 1:4       dup 'f' = if
    or    H             ; 1:4       dup 'f' = if
    jp   nz, else109    ; 3:10      dup 'f' = if 
    ld   HL, 0          ; 3:10      drop 0 
    push DE             ; 1:11      buff 32*24 1 fill
    push HL             ; 1:11      buff 32*24 1 fill
    ld   HL, buff       ; 3:10      buff 32*24 1 fill HL = from
    ld   DE, buff+1     ; 3:10      buff 32*24 1 fill DE = to
    ld   BC, 32*24-1    ; 3:10      buff 32*24 1 fill
    ld  (HL),1          ; 2:10      buff 32*24 1 fill
    ldir                ; 2:u*21/16 buff 32*24 1 fill
    pop  HL             ; 1:10      buff 32*24 1 fill
    pop  DE             ; 1:10      buff 32*24 1 fill 
else109  EQU $          ;           = endif
endif109:
        
    ld    A, 's'        ; 2:7       dup 's' = if
    xor   L             ; 1:4       dup 's' = if
    or    H             ; 1:4       dup 's' = if
    jp   nz, else110    ; 3:10      dup 's' = if 
            
    ld   HL, 0          ; 3:10      drop 0
            
    push DE             ; 1:11      buff+400 @ push(buff+400) cfetch 
    ex   DE, HL         ; 1:4       buff+400 @ push(buff+400) cfetch
    ld   HL,(buff+400)  ; 3:16      buff+400 @ push(buff+400) cfetch
    ld    H, 0x00       ; 2:7       buff+400 @ push(buff+400) cfetch 
            
    ld    A, low 1      ; 2:7       1 xor
    xor   L             ; 1:4       1 xor
    ld    L, A          ; 1:4       1 xor 
            
    ld    A, L          ; 1:4       buff+400 C! push(buff+400) cstore
    ld   (buff+400), A  ; 3:13      buff+400 C! push(buff+400) cstore
    ex   DE, HL         ; 1:4       buff+400 C! push(buff+400) cstore
    pop  DE             ; 1:10      buff+400 C! push(buff+400) cstore 
        
else110  EQU $          ;           = endif
endif110:
        
    ld    A, 'e'        ; 2:7       dup 'e' = if
    xor   L             ; 1:4       dup 'e' = if
    or    H             ; 1:4       dup 'e' = if
    jp   nz, else111    ; 3:10      dup 'e' = if
            
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
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
    
    push DE             ; 1:11      push2(buff+32*24,buff)
    ld   DE, buff+32*24 ; 3:10      push2(buff+32*24,buff)
    push HL             ; 1:11      push2(buff+32*24,buff)
    ld   HL, buff       ; 3:10      push2(buff+32*24,buff) 

sdo103:                 ;           sdo 103 ( stop index -- stop index ) 
    ex   DE, HL         ; 1:4       rnd
    push HL             ; 1:11      rnd
    call Rnd            ; 3:17      rnd 
    ld    H, 0x00       ; 2:7       1 and
    ld    A, low 1      ; 2:7       1 and
    and   L             ; 1:4       1 and
    ld    L, A          ; 1:4       1 and 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ld  (HL),E          ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore 
    inc  HL             ; 1:6       sloop 103 index++
    ld    A, E          ; 1:4       sloop 103
    xor   L             ; 1:4       sloop 103 lo index - stop
    jp   nz, sdo103     ; 3:10      sloop 103
    ld    A, D          ; 1:4       sloop 103
    xor   H             ; 1:4       sloop 103 hi index - stop
    jp   nz, sdo103     ; 3:10      sloop 103
sleave103:              ;           sloop 103
    pop  HL             ; 1:10      unsloop 103 index out
    pop  DE             ; 1:10      unsloop 103 stop  out


_random_all_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


;   ---  the beginning of a data stack function  ---
_invert_all:            ;           ( -- )
    
    push DE             ; 1:11      push2(buff+32*24,buff)
    ld   DE, buff+32*24 ; 3:10      push2(buff+32*24,buff)
    push HL             ; 1:11      push2(buff+32*24,buff)
    ld   HL, buff       ; 3:10      push2(buff+32*24,buff) 

sdo104:                 ;           sdo 104 ( stop index -- stop index ) 
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld    L, (HL)       ; 1:7       C@ cfetch 
    ld    H, 0x00       ; 2:7       C@ cfetch 
    ld    A, low 1      ; 2:7       1 xor
    xor   L             ; 1:4       1 xor
    ld    L, A          ; 1:4       1 xor 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ld  (HL),E          ; 1:7       C! cstore
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


_invert_all_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------



;   ---  the beginning of a data stack function  ---
_init:                  ;           ( -- )
    
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
    
    push DE             ; 1:11      push(32*8)
    ex   DE, HL         ; 1:4       push(32*8)
    ld   HL, 32*8       ; 3:10      push(32*8) 
sfor105:                ;           sfor 105 ( index -- index ) 
    ld    A, 'O'        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A 
    ld   A, H           ; 1:4       snext 105
    or   L              ; 1:4       snext 105
    dec  HL             ; 1:6       snext 105 index--
    jp  nz, sfor105     ; 3:10      snext 105
snext105:               ;           snext 105
    ex   DE, HL         ; 1:4       sfor unloop 105
    pop  DE             ; 1:10      sfor unloop 105
    
    push DE             ; 1:11      push2(0x4000,0x4800)
    ld   DE, 0x4000     ; 3:10      push2(0x4000,0x4800)
    push HL             ; 1:11      push2(0x4000,0x4800)
    ld   HL, 0x4800     ; 3:10      push2(0x4000,0x4800) 
    ld   BC, 8*256      ; 3:10      8*256 cmove BC = u
    ex   DE, HL         ; 1:4       8*256 cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 8*256 cmove
    pop  HL             ; 1:10      8*256 cmove
    pop  DE             ; 1:10      8*256 cmove
    
    push DE             ; 1:11      push2(0x4800,0x5000)
    ld   DE, 0x4800     ; 3:10      push2(0x4800,0x5000)
    push HL             ; 1:11      push2(0x4800,0x5000)
    ld   HL, 0x5000     ; 3:10      push2(0x4800,0x5000) 
    ld   BC, 8*256      ; 3:10      8*256 cmove BC = u
    ex   DE, HL         ; 1:4       8*256 cmove HL = from = addr1, DE = to
    ldir                ; 2:u*21/16 8*256 cmove
    pop  HL             ; 1:10      8*256 cmove
    pop  DE             ; 1:10      8*256 cmove
    
    ld    A, 0          ; 2:7       push2_cstore(0,0x5C08)
    ld   (0x5C08), A    ; 3:13      push2_cstore(0,0x5C08) 
    
    call _random_all    ; 3:17      scall

_init_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


;   ---  the beginning of a data stack function  ---
_generation:            ;           ( -- )
    
    push DE             ; 1:11      push(32*24-1)
    ex   DE, HL         ; 1:4       push(32*24-1)
    ld   HL, 32*24-1    ; 3:10      push(32*24-1) 
sfor106:                ;           sfor 106 ( index -- index ) 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    ld   BC, 0x5800     ; 3:10      0x5800 +
    add  HL, BC         ; 1:11      0x5800 +
        
    call _alive         ; 3:17      scall 
        
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    ; warning The condition >>>buff<<< cannot be evaluated
    ld   BC, buff       ; 3:10      buff +
    add  HL, BC         ; 1:11      buff + 
    ld  (HL),E          ; 1:7       C! cstore
    pop  HL             ; 1:10      C! cstore
    pop  DE             ; 1:10      C! cstore
    
    ld   A, H           ; 1:4       snext 106
    or   L              ; 1:4       snext 106
    dec  HL             ; 1:6       snext 106 index--
    jp  nz, sfor106     ; 3:10      snext 106
snext106:               ;           snext 106
    ex   DE, HL         ; 1:4       sfor unloop 106
    pop  DE             ; 1:10      sfor unloop 106

_generation_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


;   ---  the beginning of a data stack function  ---
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
    jp   nz, else113    ; 3:10      0= if
        
    call sum_neighbors  ; 3:17      scall
        
    ld   BC, 3          ; 3:10      3 = if
    or    A             ; 1:4       3 = if
    sbc  HL, BC         ; 2:15      3 = if
    ex   DE, HL         ; 1:4       3 = if
    pop  DE             ; 1:10      3 = if
    jp   nz, else114    ; 3:10      3 = if 
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ret                 ; 1:10      sexit 
else114  EQU $          ;           = endif
endif114:
    
    jp   endif113       ; 3:10      else
else113:
        
    call sum_neighbors  ; 3:17      scall 
        
    set   0, L          ; 2:8       0x01 or 
        
    ld   BC, 3          ; 3:10      3 = if
    or    A             ; 1:4       3 = if
    sbc  HL, BC         ; 2:15      3 = if
    ex   DE, HL         ; 1:4       3 = if
    pop  DE             ; 1:10      3 = if
    jp   nz, else115    ; 3:10      3 = if 
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1) 
    ret                 ; 1:10      sexit 
else115  EQU $          ;           = endif
endif115:
    
endif113:
    
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0)

_alive_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------

; dup 1- 0x1F and swap 0xFFE0 and + 

; dup 1+ 0x1F and swap 0xFFE0 and + 


;   ---  the beginning of a data stack function  ---
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
    ld   BC, 32         ; 3:10      32 +
    add  HL, BC         ; 1:11      32 +
    
    ld    A, L          ; 1:4       dup 0x5B00 (u)>= if    HL>=0x5B00 --> HL-0x5B00>=0 --> not carry if true
    sub   low 0x5B00    ; 2:7       dup 0x5B00 (u)>= if    HL>=0x5B00 --> HL-0x5B00>=0 --> not carry if true
    ld    A, H          ; 1:4       dup 0x5B00 (u)>= if    HL>=0x5B00 --> HL-0x5B00>=0 --> not carry if true
    sbc   A, high 0x5B00; 2:7       dup 0x5B00 (u)>= if    HL>=0x5B00 --> HL-0x5B00>=0 --> not carry if true
    jp    c, else116    ; 3:10      dup 0x5B00 (u)>= if
        
    ld   BC, -32*24     ; 3:10      -32*24 +
    add  HL, BC         ; 1:11      -32*24 +
    
else116  EQU $          ;           = endif
endif116:
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
    ld   BC, -2*32      ; 3:10      -2*32 +
    add  HL, BC         ; 1:11      -2*32 +
    
    ld    A, L          ; 1:4       dup 0x5800 (u)< if    HL<0x5800 --> HL-0x5800<0 --> carry if true
    sub   low 0x5800    ; 2:7       dup 0x5800 (u)< if    HL<0x5800 --> HL-0x5800<0 --> carry if true
    ld    A, H          ; 1:4       dup 0x5800 (u)< if    HL<0x5800 --> HL-0x5800<0 --> carry if true
    sbc   A, high 0x5800; 2:7       dup 0x5800 (u)< if    HL<0x5800 --> HL-0x5800<0 --> carry if true
    jp   nc, else117    ; 3:10      dup 0x5800 (u)< if
        
    ld   BC, 32*24      ; 3:10      32*24 +
    add  HL, BC         ; 1:11      32*24 +
    
else117  EQU $          ;           = endif
endif117:
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
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    add  HL, DE         ; 1:11      +
    pop  DE             ; 1:10      +
    ; 16 bit --> 8 bit
    
    ld    H, 0x00       ; 2:7       0xFF and

sum_neighbors_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------



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
