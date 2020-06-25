;# Forth program from https://skilldrick.github.io/easyforth/
;# by Nick Morgan

    ORG 0x8000
    
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      not need
    ld    L, 0x1A       ; 2:7       Upper screen
    call 0x1605         ; 3:17      Open channel
    ld   HL, 60000
    exx
    
    call start          ; 3:17      scall
    
Stop:
    ld   SP, 0x0000     ; 3:10      not need
    ld   HL, 0x2758     ; 3:10
    exx                 ; 1:4
    ret                 ; 1:10
;   =====  e n d  =====

  
  

left                 EQU 0
  

up                   EQU 1
  

right                EQU 2
  

down                 EQU 3
  

width                EQU 32
  

height               EQU 24
  

white                EQU 0x3F


red                  EQU 0x24
 

black                EQU 0
  
  
  

graphics             EQU 0x5800


last_key             EQU 0x5C08


;( x y -- )
; C = color
put_color:
    ld    A, L          ; 1:4
    add   A, A          ; 1:4       2x 24->48
    add   A, A          ; 1:4       4x 48->96
    add   A, A          ; 1:4       8x 96->192
    ld    L, A          ; 1:4
    add  HL, HL         ; 1:11      16x 192->384
    add  HL, HL         ; 1:11      32x 384->768
    add  HL, DE         ; 1:11      
    ld   DE, 0x5800   ; 3:10
    add  HL, DE         ; 1:11      
    ld   (HL), C        ; 1:7
    ret                 ; 1:10

;( x y -- color )
get_color:
    ld    A, L          ; 1:4
    add   A, A          ; 1:4       2x 24->48
    add   A, A          ; 1:4       4x 48->96
    add   A, A          ; 1:4       8x 96->192
    ld    L, A          ; 1:4
    add  HL, HL         ; 1:11      16x 192->384
    add  HL, HL         ; 1:11      32x 384->768
    add  HL, DE         ; 1:11      
    ld   DE, 0x5800   ; 3:10
    add  HL, DE         ; 1:11      
    ld   L, (HL)        ; 1:7
    ld   H, 0x00        ; 2:7
    ret                 ; 1:10


;   ---  the beginning of a non-recursive function  ---
draw_white:             ;           ( x y -- )
    pop  BC             ; 1:10      : ret
    ld  (draw_white_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    ld    C, 0x3F      ; 2:7
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10

draw_white_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  


;   ---  the beginning of a non-recursive function  ---
draw_black:             ;           ( x y -- )
    pop  BC             ; 1:10      : ret
    ld  (draw_black_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    ld    C, 0      ; 2:7
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10

draw_black_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  


;   ---  the beginning of a non-recursive function  ---
draw:                   ;           ( color x y -- )
    pop  BC             ; 1:10      : ret
    ld  (draw_end+1),BC ; 4:20      : ( ret -- ) R:( -- )
    pop   BC            ; 1:10
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10

draw_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  


;   ---  the beginning of a data stack function  ---
draw_walls:             ;            
    
    push DE             ; 1:11      push(32-1)
    ex   DE, HL         ; 1:4       push(32-1)
    ld   HL, 32-1       ; 3:10      push(32-1) 
sfor101:                ;           sfor 101 ( index -- index ) 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0)        
    call draw_black     ; 3:17      call ( -- ret ) R:( -- ) 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      push(24-1)
    ex   DE, HL         ; 1:4       push(24-1)
    ld   HL, 24-1       ; 3:10      push(24-1) 
    call draw_black     ; 3:17      call ( -- ret ) R:( -- ) 
    
    ld   A, H           ; 1:4       snext 101
    or   L              ; 1:4       snext 101
    dec  HL             ; 1:6       snext 101 index--
    jp  nz, sfor101     ; 3:10      snext 101
snext101:               ;           snext 101
    ex   DE, HL         ; 1:4       sfor unloop 101
    pop  DE             ; 1:10      sfor unloop 101

    
    push DE             ; 1:11      push(24-1)
    ex   DE, HL         ; 1:4       push(24-1)
    ld   HL, 24-1       ; 3:10      push(24-1) 
sfor102:                ;           sfor 102 ( index -- index ) 
        
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0)       
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call draw_black     ; 3:17      call ( -- ret ) R:( -- ) 
        
    push DE             ; 1:11      push(32-1)
    ex   DE, HL         ; 1:4       push(32-1)
    ld   HL, 32-1       ; 3:10      push(32-1) 
    push DE             ; 1:11      over
    ex   DE, HL         ; 1:4       over ( b a -- b a b ) 
    call draw_black     ; 3:17      call ( -- ret ) R:( -- ) 
    
    ld   A, H           ; 1:4       snext 102
    or   L              ; 1:4       snext 102
    dec  HL             ; 1:6       snext 102 index--
    jp  nz, sfor102     ; 3:10      snext 102
snext102:               ;           snext 102
    ex   DE, HL         ; 1:4       sfor unloop 102
    pop  DE             ; 1:10      sfor unloop 102

draw_walls_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


;   ---  the beginning of a non-recursive function  ---
snake_x:                ;           ( offset -- address )
    pop  BC             ; 1:10      : ret
    ld  (snake_x_end+1),BC; 4:20      : ( ret -- ) R:( -- )
  
    add  HL, HL         ; 1:11      2* 
    ; warning The condition (snake_x_head) cannot be evaluated
    ld   BC, snake_x_head; 3:10      snake_x_head +
    add  HL, BC         ; 1:11      snake_x_head + 

snake_x_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------
  

;   ---  the beginning of a non-recursive function  ---
snake_y:                ;           ( offset -- address )
    pop  BC             ; 1:10      : ret
    ld  (snake_y_end+1),BC; 4:20      : ( ret -- ) R:( -- )
  
    add  HL, HL         ; 1:11      2* 
    ; warning The condition (snake_y_head) cannot be evaluated
    ld   BC, snake_y_head; 3:10      snake_y_head +
    add  HL, BC         ; 1:11      snake_y_head +

snake_y_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  


;   ---  the beginning of a data stack function  ---
initialize_snake:       ;            
    
    ld   BC, 4          ; 3:10      push2_store(4,length)
    ld   (length), BC   ; 4:20      push2_store(4,length) 
    
    push DE             ; 1:11      push2(4+1,0)
    ld   DE, 4+1        ; 3:10      push2(4+1,0)
    push HL             ; 1:11      push2(4+1,0)
    ld   HL, 0          ; 3:10      push2(4+1,0) 
    push HL             ; 1:11      do 103 index
    push DE             ; 1:11      do 103 stop
    exx                 ; 1:4       do 103
    pop  DE             ; 1:10      do 103 stop
    dec  HL             ; 1:6       do 103
    ld  (HL),D          ; 1:7       do 103
    dec  L              ; 1:4       do 103
    ld  (HL),E          ; 1:7       do 103 stop
    pop  DE             ; 1:10      do 103 index
    dec  HL             ; 1:6       do 103
    ld  (HL),D          ; 1:7       do 103
    dec  L              ; 1:4       do 103
    ld  (HL),E          ; 1:7       do 103 index
    exx                 ; 1:4       do 103
    pop  HL             ; 1:10      do 103
    pop  DE             ; 1:10      do 103 ( stop index -- ) R: ( -- stop index )
do103: 
        
    push DE             ; 1:11      push(12)
    ex   DE, HL         ; 1:4       push(12)
    ld   HL, 12         ; 3:10      push(12) 
    exx                 ; 1:4       index 103 i    
    ld    E,(HL)        ; 1:7       index 103 i
    inc   L             ; 1:4       index 103 i
    ld    D,(HL)        ; 1:7       index 103 i
    push DE             ; 1:11      index 103 i
    dec   L             ; 1:4       index 103 i
    exx                 ; 1:4       index 103 i
    ex   DE, HL         ; 1:4       index 103 i
    ex  (SP),HL         ; 1:19      index 103 i 
    ex   DE, HL         ; 1:4       -
    or    A             ; 1:4       -
    sbc  HL, DE         ; 2:15      -
    pop  DE             ; 1:10      - 
    exx                 ; 1:4       index 103 i    
    ld    E,(HL)        ; 1:7       index 103 i
    inc   L             ; 1:4       index 103 i
    ld    D,(HL)        ; 1:7       index 103 i
    push DE             ; 1:11      index 103 i
    dec   L             ; 1:4       index 103 i
    exx                 ; 1:4       index 103 i
    ex   DE, HL         ; 1:4       index 103 i
    ex  (SP),HL         ; 1:19      index 103 i 
    call snake_x        ; 3:17      call ( -- ret ) R:( -- ) 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store 
        
    push DE             ; 1:11      push(12)
    ex   DE, HL         ; 1:4       push(12)
    ld   HL, 12         ; 3:10      push(12) 
    exx                 ; 1:4       index 103 i    
    ld    E,(HL)        ; 1:7       index 103 i
    inc   L             ; 1:4       index 103 i
    ld    D,(HL)        ; 1:7       index 103 i
    push DE             ; 1:11      index 103 i
    dec   L             ; 1:4       index 103 i
    exx                 ; 1:4       index 103 i
    ex   DE, HL         ; 1:4       index 103 i
    ex  (SP),HL         ; 1:19      index 103 i       
    call snake_y        ; 3:17      call ( -- ret ) R:( -- ) 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store 
    
    exx                 ; 1:4       loop 103
    ld    E,(HL)        ; 1:7       loop 103
    inc   L             ; 1:4       loop 103
    ld    D,(HL)        ; 1:7       loop 103 DE = index   
    inc  HL             ; 1:6       loop 103
    inc  DE             ; 1:6       loop 103 index++
    ld    A,(HL)        ; 1:4       loop 103
    xor   E             ; 1:4       loop 103 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 103
    ld    A, D          ; 1:4       loop 103
    inc   L             ; 1:4       loop 103
    xor (HL)            ; 1:7       loop 103 hi index - stop
    jr    z, leave103   ; 2:7/12    loop 103 exit    
    dec   L             ; 1:4       loop 103
    dec  HL             ; 1:6       loop 103
    ld  (HL), D         ; 1:7       loop 103
    dec   L             ; 1:4       loop 103
    ld  (HL), E         ; 1:7       loop 103
    exx                 ; 1:4       loop 103
    jp   do103          ; 3:10      loop 103
leave103:
    inc  HL             ; 1:6       loop 103
    exx                 ; 1:4       loop 103
exit103 EQU $ 
    
    ld   BC, 2          ; 3:10      push2_store(2,direction)
    ld   (direction), BC; 4:20      push2_store(2,direction) 

initialize_snake_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a non-recursive function  ---
set_apple_position:     ;           ( y x -- )
    pop  BC             ; 1:10      : ret
    ld  (set_apple_position_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    ld   (apple_x), HL  ; 3:16      apple_x ! push(apple_x) store
    ex   DE, HL         ; 1:4       apple_x ! push(apple_x) store
    pop  DE             ; 1:10      apple_x ! push(apple_x) store 
    ld   (apple_y), HL  ; 3:16      apple_y ! push(apple_y) store
    ex   DE, HL         ; 1:4       apple_y ! push(apple_y) store
    pop  DE             ; 1:10      apple_y ! push(apple_y) store 

set_apple_position_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  


;   ---  the beginning of a data stack function  ---
initialize_apple:       ;             
    
    push DE             ; 1:11      push2(4,4)
    ld   DE, 4          ; 3:10      push2(4,4)
    push HL             ; 1:11      push2(4,4)
    ld   HL, 4          ; 3:10      push2(4,4) 
    call set_apple_position; 3:17      call ( -- ret ) R:( -- ) 

initialize_apple_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
initialize:             ;            
    
    push DE             ; 1:11      push(32-1)
    ex   DE, HL         ; 1:4       push(32-1)
    ld   HL, 32-1       ; 3:10      push(32-1) 
    ex  (SP),HL         ; 1:19      for 104
    ex   DE, HL         ; 1:4       for 104
    exx                 ; 1:4       for 104
    pop  DE             ; 1:10      for 104 index
    dec  HL             ; 1:6       for 104
    ld  (HL),D          ; 1:7       for 104
    dec  L              ; 1:4       for 104
    ld  (HL),E          ; 1:7       for 104 stop
    exx                 ; 1:4       for 104 ( index -- ) R: ( -- index )
for104:                 ;           for 104 
        
    push DE             ; 1:11      push(24-1)
    ex   DE, HL         ; 1:4       push(24-1)
    ld   HL, 24-1       ; 3:10      push(24-1) 
    ex  (SP),HL         ; 1:19      for 105
    ex   DE, HL         ; 1:4       for 105
    exx                 ; 1:4       for 105
    pop  DE             ; 1:10      for 105 index
    dec  HL             ; 1:6       for 105
    ld  (HL),D          ; 1:7       for 105
    dec  L              ; 1:4       for 105
    ld  (HL),E          ; 1:7       for 105 stop
    exx                 ; 1:4       for 105 ( index -- ) R: ( -- index )
for105:                 ;           for 105 
            
    exx                 ; 1:4       index 105 j
    ld   DE, 0x0004     ; 3:10      index 105 j
    ex   DE, HL         ; 1:4       index 105 j
    add  HL, DE         ; 1:11      index 105 j
    ld    C,(HL)        ; 1:7       index 105 j lo    
    inc   L             ; 1:4       index 105 j
    ld    B,(HL)        ; 1:7       index 105 j hi
    ex   DE, HL         ; 1:4       index 105 j
    push BC             ; 1:11      index 105 j
    exx                 ; 1:4       index 105 j
    ex   DE, HL         ; 1:4       index 105 j
    ex  (SP),HL         ; 1:19      index 105 j 
    exx                 ; 1:4       index 105 i    
    ld    E,(HL)        ; 1:7       index 105 i
    inc   L             ; 1:4       index 105 i
    ld    D,(HL)        ; 1:7       index 105 i
    push DE             ; 1:11      index 105 i
    dec   L             ; 1:4       index 105 i
    exx                 ; 1:4       index 105 i
    ex   DE, HL         ; 1:4       index 105 i
    ex  (SP),HL         ; 1:19      index 105 i 
    call draw_white     ; 3:17      call ( -- ret ) R:( -- ) 
        
    exx                 ; 1:4       next 105
    ld    E,(HL)        ; 1:7       next 105
    inc   L             ; 1:4       next 105
    ld    D,(HL)        ; 1:7       next 105 DE = index   
    ld    A, E          ; 1:4       next 105
    or    D             ; 1:4       next 105
    jr    z, next105    ; 2:7/12    next 105 exit
    dec  DE             ; 1:6       next 105 index--
    ld  (HL),D          ; 1:7       next 105
    dec   L             ; 1:4       next 105
    ld  (HL),E          ; 1:7       next 105
    exx                 ; 1:4       next 105
    jp   for105         ; 3:10      next 105
next105:                ;           next 105
    inc  HL             ; 1:6       next 105
    exx                 ; 1:4       next 105 
    
    exx                 ; 1:4       next 104
    ld    E,(HL)        ; 1:7       next 104
    inc   L             ; 1:4       next 104
    ld    D,(HL)        ; 1:7       next 104 DE = index   
    ld    A, E          ; 1:4       next 104
    or    D             ; 1:4       next 104
    jr    z, next104    ; 2:7/12    next 104 exit
    dec  DE             ; 1:6       next 104 index--
    ld  (HL),D          ; 1:7       next 104
    dec   L             ; 1:4       next 104
    ld  (HL),E          ; 1:7       next 104
    exx                 ; 1:4       next 104
    jp   for104         ; 3:10      next 104
next104:                ;           next 104
    inc  HL             ; 1:6       next 104
    exx                 ; 1:4       next 104
    
    call draw_walls     ; 3:17      scall 
    
    call initialize_snake; 3:17      scall 
    
    call initialize_apple; 3:17      scall

initialize_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
move_up:                ;             
    
    push HL             ; 1:11      push2_addstore(-1,snake_y_head)
    ld   BC, -1         ; 3:10      push2_addstore(-1,snake_y_head)
    ld   HL, (snake_y_head); 3:16      push2_addstore(-1,snake_y_head)
    add  HL, BC         ; 1:11      push2_addstore(-1,snake_y_head)
    ld   (snake_y_head), HL; 3:16      push2_addstore(-1,snake_y_head)
    pop  HL             ; 1:10      push2_addstore(-1,snake_y_head) 

move_up_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
move_left:              ;             
    
    push HL             ; 1:11      push2_addstore(-1,snake_x_head)
    ld   BC, -1         ; 3:10      push2_addstore(-1,snake_x_head)
    ld   HL, (snake_x_head); 3:16      push2_addstore(-1,snake_x_head)
    add  HL, BC         ; 1:11      push2_addstore(-1,snake_x_head)
    ld   (snake_x_head), HL; 3:16      push2_addstore(-1,snake_x_head)
    pop  HL             ; 1:10      push2_addstore(-1,snake_x_head) 

move_left_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
move_down:              ;             
    
    push HL             ; 1:11      push2_addstore(1,snake_y_head)
    ld   BC, 1          ; 3:10      push2_addstore(1,snake_y_head)
    ld   HL, (snake_y_head); 3:16      push2_addstore(1,snake_y_head)
    add  HL, BC         ; 1:11      push2_addstore(1,snake_y_head)
    ld   (snake_y_head), HL; 3:16      push2_addstore(1,snake_y_head)
    pop  HL             ; 1:10      push2_addstore(1,snake_y_head) 

move_down_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
move_right:             ;             
    
    push HL             ; 1:11      push2_addstore(1,snake_x_head)
    ld   BC, 1          ; 3:10      push2_addstore(1,snake_x_head)
    ld   HL, (snake_x_head); 3:16      push2_addstore(1,snake_x_head)
    add  HL, BC         ; 1:11      push2_addstore(1,snake_x_head)
    ld   (snake_x_head), HL; 3:16      push2_addstore(1,snake_x_head)
    pop  HL             ; 1:10      push2_addstore(1,snake_x_head) 

move_right_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
move_snake_head:        ;             
    
    push DE             ; 1:11      direction @ push(direction) fetch 
    ex   DE, HL         ; 1:4       direction @ push(direction) fetch
    ld   HL,(direction) ; 3:16      direction @ push(direction) fetch 
    
    ld    A, high 0     ; 2:7       dup 0 = if
    xor   H             ; 1:4       dup 0 = if
    ld    B, A          ; 1:4       dup 0 = if
    ld    A, low 0      ; 2:7       dup 0 = if
    xor   L             ; 1:4       dup 0 = if
    or    B             ; 1:4       dup 0 = if
    jp   nz, else101    ; 3:10      dup 0 = if  
    call move_left      ; 3:17      scall  
    jp   endif101       ; 3:10      else
else101: 
    
    ld    A, high 1     ; 2:7       dup 1 = if
    xor   H             ; 1:4       dup 1 = if
    ld    B, A          ; 1:4       dup 1 = if
    ld    A, low 1      ; 2:7       dup 1 = if
    xor   L             ; 1:4       dup 1 = if
    or    B             ; 1:4       dup 1 = if
    jp   nz, else102    ; 3:10      dup 1 = if    
    call move_up        ; 3:17      scall    
    jp   endif102       ; 3:10      else
else102: 
    
    ld    A, high 2     ; 2:7       dup 2 = if
    xor   H             ; 1:4       dup 2 = if
    ld    B, A          ; 1:4       dup 2 = if
    ld    A, low 2      ; 2:7       dup 2 = if
    xor   L             ; 1:4       dup 2 = if
    or    B             ; 1:4       dup 2 = if
    jp   nz, else103    ; 3:10      dup 2 = if 
    call move_right     ; 3:17      scall 
    jp   endif103       ; 3:10      else
else103: 
    
    ld    A, high 3     ; 2:7       dup 3 = if
    xor   H             ; 1:4       dup 3 = if
    ld    B, A          ; 1:4       dup 3 = if
    ld    A, low 3      ; 2:7       dup 3 = if
    xor   L             ; 1:4       dup 3 = if
    or    B             ; 1:4       dup 3 = if
    jp   nz, else104    ; 3:10      dup 3 = if  
    call move_down      ; 3:17      scall 
    
else104  EQU $          ;           = endif
endif104: 
endif103: 
endif102: 
endif101: 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 

move_snake_head_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  

; Move each segment of the snake forward by one  

;   ---  the beginning of a data stack function  ---
move_snake_tail:        ;             
    
    push DE             ; 1:11      length @ push(length) fetch 
    ex   DE, HL         ; 1:4       length @ push(length) fetch
    ld   HL,(length)    ; 3:16      length @ push(length) fetch 
sfor106:                ;           sfor 106 ( index -- index ) 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call snake_x        ; 3:17      call ( -- ret ) R:( -- ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    inc  HL             ; 1:6       1+ 
    call snake_x        ; 3:17      call ( -- ret ) R:( -- ) 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store 
        
    
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    call snake_y        ; 3:17      call ( -- ret ) R:( -- ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    inc  HL             ; 1:6       1+ 
    call snake_y        ; 3:17      call ( -- ret ) R:( -- ) 
    ld  (HL),E          ; 1:7       ! store
    inc  HL             ; 1:6       ! store
    ld  (HL),D          ; 1:7       ! store
    pop  HL             ; 1:10      ! store
    pop  DE             ; 1:10      ! store 
    
    ld   A, H           ; 1:4       snext 106
    or   L              ; 1:4       snext 106
    dec  HL             ; 1:6       snext 106 index--
    jp  nz, sfor106     ; 3:10      snext 106
snext106:               ;           snext 106
    ex   DE, HL         ; 1:4       sfor unloop 106
    pop  DE             ; 1:10      sfor unloop 106 

move_snake_tail_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a non-recursive function  ---
is_horizontal:          ;           ( -- flag )
    pop  BC             ; 1:10      : ret
    ld  (is_horizontal_end+1),BC; 4:20      : ( ret -- ) R:( -- )  
    
    push DE             ; 1:11      direction @ push(direction) fetch 
    ex   DE, HL         ; 1:4       direction @ push(direction) fetch
    ld   HL,(direction) ; 3:16      direction @ push(direction) fetch 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0)  
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    
    push DE             ; 1:11      push(2)
    ex   DE, HL         ; 1:4       push(2)
    ld   HL, 2          ; 3:10      push(2) 
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ld    A, E          ; 1:4       or
    or    L             ; 1:4       or
    ld    L, A          ; 1:4       or
    ld    A, D          ; 1:4       or
    or    H             ; 1:4       or
    ld    H, A          ; 1:4       or
    pop  DE             ; 1:10      or 

is_horizontal_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a non-recursive function  ---
is_vertical:            ;           ( -- flag )
    pop  BC             ; 1:10      : ret
    ld  (is_vertical_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
    push DE             ; 1:11      direction @ push(direction) fetch 
    ex   DE, HL         ; 1:4       direction @ push(direction) fetch
    ld   HL,(direction) ; 3:16      direction @ push(direction) fetch 
    push DE             ; 1:11      dup
    ld    D, H          ; 1:4       dup
    ld    E, L          ; 1:4       dup ( a -- a a ) 
    
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)    
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ex   DE, HL         ; 1:4       swap ( b a -- a b ) 
    
    push DE             ; 1:11      push(3)
    ex   DE, HL         ; 1:4       push(3)
    ld   HL, 3          ; 3:10      push(3)  
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    ld    A, E          ; 1:4       or
    or    L             ; 1:4       or
    ld    L, A          ; 1:4       or
    ld    A, D          ; 1:4       or
    or    H             ; 1:4       or
    ld    H, A          ; 1:4       or
    pop  DE             ; 1:10      or 

is_vertical_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  


;   ---  the beginning of a data stack function  ---
turn_up:                ;               
    call is_horizontal  ; 3:17      call ( -- ret ) R:( -- ) 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else105    ; 3:10      if 
    ld   BC, 1          ; 3:10      push2_store(1   ,direction)
    ld   (direction), BC; 4:20      push2_store(1   ,direction) 
else105  EQU $          ;           = endif
endif105: 
turn_up_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
turn_left:              ;             
    call is_vertical    ; 3:17      call ( -- ret ) R:( -- )   
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else106    ; 3:10      if 
    ld   BC, 0          ; 3:10      push2_store(0 ,direction)
    ld   (direction), BC; 4:20      push2_store(0 ,direction) 
else106  EQU $          ;           = endif
endif106: 
turn_left_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
turn_down:              ;             
    call is_horizontal  ; 3:17      call ( -- ret ) R:( -- ) 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else107    ; 3:10      if 
    ld   BC, 3          ; 3:10      push2_store(3 ,direction)
    ld   (direction), BC; 4:20      push2_store(3 ,direction) 
else107  EQU $          ;           = endif
endif107: 
turn_down_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
turn_right:             ;            
    call is_vertical    ; 3:17      call ( -- ret ) R:( -- )   
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else108    ; 3:10      if 
    ld   BC, 2          ; 3:10      push2_store(2,direction)
    ld   (direction), BC; 4:20      push2_store(2,direction) 
else108  EQU $          ;           = endif
endif108: 
turn_right_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a non-recursive function  ---
change_direction:       ;           ( key -- )
    pop  BC             ; 1:10      : ret
    ld  (change_direction_end+1),BC; 4:20      : ( ret -- ) R:( -- )
  
    ld    A, high 'o'   ; 2:7       dup 'o' = if
    xor   H             ; 1:4       dup 'o' = if
    ld    B, A          ; 1:4       dup 'o' = if
    ld    A, low 'o'    ; 2:7       dup 'o' = if
    xor   L             ; 1:4       dup 'o' = if
    or    B             ; 1:4       dup 'o' = if
    jp   nz, else109    ; 3:10      dup 'o' = if 
    call turn_left      ; 3:17      scall  
    jp   endif109       ; 3:10      else
else109: 
  
    ld    A, high 'q'   ; 2:7       dup 'q' = if
    xor   H             ; 1:4       dup 'q' = if
    ld    B, A          ; 1:4       dup 'q' = if
    ld    A, low 'q'    ; 2:7       dup 'q' = if
    xor   L             ; 1:4       dup 'q' = if
    or    B             ; 1:4       dup 'q' = if
    jp   nz, else110    ; 3:10      dup 'q' = if 
    call turn_up        ; 3:17      scall    
    jp   endif110       ; 3:10      else
else110: 
  
    ld    A, high 'p'   ; 2:7       dup 'p' = if
    xor   H             ; 1:4       dup 'p' = if
    ld    B, A          ; 1:4       dup 'p' = if
    ld    A, low 'p'    ; 2:7       dup 'p' = if
    xor   L             ; 1:4       dup 'p' = if
    or    B             ; 1:4       dup 'p' = if
    jp   nz, else111    ; 3:10      dup 'p' = if 
    call turn_right     ; 3:17      scall 
    jp   endif111       ; 3:10      else
else111: 
  
    ld    A, high 'a'   ; 2:7       dup 'a' = if
    xor   H             ; 1:4       dup 'a' = if
    ld    B, A          ; 1:4       dup 'a' = if
    ld    A, low 'a'    ; 2:7       dup 'a' = if
    xor   L             ; 1:4       dup 'a' = if
    or    B             ; 1:4       dup 'a' = if
    jp   nz, else112    ; 3:10      dup 'a' = if 
    call turn_down      ; 3:17      scall 
  
else112  EQU $          ;           = endif
endif112: 
endif111: 
endif110: 
endif109: 
    ex   DE, HL         ; 1:4       drop
    pop  DE             ; 1:10      drop ( a -- ) 

change_direction_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  


;   ---  the beginning of a data stack function  ---
check_input:            ;            
    
    push DE             ; 1:11      0x5C08 @ push(0x5C08) cfetch 
    ex   DE, HL         ; 1:4       0x5C08 @ push(0x5C08) cfetch
    ld   HL,(0x5C08)    ; 3:16      0x5C08 @ push(0x5C08) cfetch
    ld    H, 0x00       ; 2:7       0x5C08 @ push(0x5C08) cfetch
    
    call change_direction; 3:17      call ( -- ret ) R:( -- )
    
    ld    A, 0          ; 2:7       push2_cstore(0,0x5C08)
    ld   (0x5C08), A    ; 3:13      push2_cstore(0,0x5C08)

check_input_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  

; get random x or y position within playable area  

;   ---  the beginning of a data stack function  ---
random_position:        ;           ( n -- 2..n-3 )
    
    ld   BC, -4         ; 3:10      4 -
    add  HL, BC         ; 1:11      4 - 
    call Random         ; 3:17      random 
    inc  HL             ; 1:6       2+
    inc  HL             ; 1:6       2+ 

random_position_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
move_apple:             ;            
    
    push DE             ; 1:11      push(24)
    ex   DE, HL         ; 1:4       push(24)
    ld   HL, 24         ; 3:10      push(24) 
    call random_position; 3:17      scall 
    push DE             ; 1:11      push(32)
    ex   DE, HL         ; 1:4       push(32)
    ld   HL, 32         ; 3:10      push(32) 
    call random_position; 3:17      scall 
    
    call set_apple_position; 3:17      call ( -- ret ) R:( -- ) 

move_apple_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
grow_snake:             ;             
    
    push HL             ; 1:11      push2_addstore(1,length)
    ld   BC, 1          ; 3:10      push2_addstore(1,length)
    ld   HL, (length)   ; 3:16      push2_addstore(1,length)
    add  HL, BC         ; 1:11      push2_addstore(1,length)
    ld   (length), HL   ; 3:16      push2_addstore(1,length)
    pop  HL             ; 1:10      push2_addstore(1,length) 

grow_snake_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
check_apple:            ;            
    
    push DE             ; 1:11      snake_x_head @ push(snake_x_head) fetch 
    ex   DE, HL         ; 1:4       snake_x_head @ push(snake_x_head) fetch
    ld   HL,(snake_x_head); 3:16      snake_x_head @ push(snake_x_head) fetch 
    push DE             ; 1:11      apple_x @ push(apple_x) fetch 
    ex   DE, HL         ; 1:4       apple_x @ push(apple_x) fetch
    ld   HL,(apple_x)   ; 3:16      apple_x @ push(apple_x) fetch 
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 
    
    push DE             ; 1:11      snake_y_head @ push(snake_y_head) fetch 
    ex   DE, HL         ; 1:4       snake_y_head @ push(snake_y_head) fetch
    ld   HL,(snake_y_head); 3:16      snake_y_head @ push(snake_y_head) fetch 
    push DE             ; 1:11      apple_y @ push(apple_y) fetch 
    ex   DE, HL         ; 1:4       apple_y @ push(apple_y) fetch
    ld   HL,(apple_y)   ; 3:16      apple_y @ push(apple_y) fetch 
    or    A             ; 1:4       =
    sbc  HL, DE         ; 2:15      =
    ld   HL, 0x0000     ; 3:10      =
    jr   nz, $+3        ; 2:7/12    =
    dec  HL             ; 1:6       =
    pop  DE             ; 1:10      = 

    
    ld    A, E          ; 1:4       and
    and   L             ; 1:4       and
    ld    L, A          ; 1:4       and
    ld    A, D          ; 1:4       and
    and   H             ; 1:4       and
    ld    H, A          ; 1:4       and
    pop  DE             ; 1:10      and 
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else113    ; 3:10      if
        
    call move_apple     ; 3:17      scall 
        
    call grow_snake     ; 3:17      scall 
    
else113  EQU $          ;           = endif
endif113:

check_apple_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------


;   ---  the beginning of a non-recursive function  ---
check_collision:        ;           
    pop  BC             ; 1:10      : ret
    ld  (check_collision_end+1),BC; 4:20      : ( ret -- ) R:( -- ) ;( -- flag )
    ; get current x/y position 
    
    push DE             ; 1:11      snake_x_head @ push(snake_x_head) fetch 
    ex   DE, HL         ; 1:4       snake_x_head @ push(snake_x_head) fetch
    ld   HL,(snake_x_head); 3:16      snake_x_head @ push(snake_x_head) fetch 
    push DE             ; 1:11      snake_y_head @ push(snake_y_head) fetch 
    ex   DE, HL         ; 1:4       snake_y_head @ push(snake_y_head) fetch
    ld   HL,(snake_y_head); 3:16      snake_y_head @ push(snake_y_head) fetch 

    ; get color at current position 
    call get_color      ; 3:17
    pop  DE             ; 1:10
 
    ; leave boolean flag on stack 
    
    ld    A, H          ; 1:4       0=
    or    L             ; 1:4       0=
    ld   HL, 0x0000     ; 3:10      0=
    jr   nz, $+3        ; 2:7/12    0=
    dec  HL             ; 1:6       0=

check_collision_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------


;   ---  the beginning of a data stack function  ---
draw_snake:             ;            
    
    push DE             ; 1:11      length @ push(length) fetch 
    ex   DE, HL         ; 1:4       length @ push(length) fetch
    ld   HL,(length)    ; 3:16      length @ push(length) fetch 
    push DE             ; 1:11      push(0)
    ex   DE, HL         ; 1:4       push(0)
    ld   HL, 0          ; 3:10      push(0) 
    push HL             ; 1:11      do 107 index
    push DE             ; 1:11      do 107 stop
    exx                 ; 1:4       do 107
    pop  DE             ; 1:10      do 107 stop
    dec  HL             ; 1:6       do 107
    ld  (HL),D          ; 1:7       do 107
    dec  L              ; 1:4       do 107
    ld  (HL),E          ; 1:7       do 107 stop
    pop  DE             ; 1:10      do 107 index
    dec  HL             ; 1:6       do 107
    ld  (HL),D          ; 1:7       do 107
    dec  L              ; 1:4       do 107
    ld  (HL),E          ; 1:7       do 107 index
    exx                 ; 1:4       do 107
    pop  HL             ; 1:10      do 107
    pop  DE             ; 1:10      do 107 ( stop index -- ) R: ( -- stop index )
do107: 
        
    exx                 ; 1:4       index 107 i    
    ld    E,(HL)        ; 1:7       index 107 i
    inc   L             ; 1:4       index 107 i
    ld    D,(HL)        ; 1:7       index 107 i
    push DE             ; 1:11      index 107 i
    dec   L             ; 1:4       index 107 i
    exx                 ; 1:4       index 107 i
    ex   DE, HL         ; 1:4       index 107 i
    ex  (SP),HL         ; 1:19      index 107 i 
    call snake_x        ; 3:17      call ( -- ret ) R:( -- ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    exx                 ; 1:4       index 107 i    
    ld    E,(HL)        ; 1:7       index 107 i
    inc   L             ; 1:4       index 107 i
    ld    D,(HL)        ; 1:7       index 107 i
    push DE             ; 1:11      index 107 i
    dec   L             ; 1:4       index 107 i
    exx                 ; 1:4       index 107 i
    ex   DE, HL         ; 1:4       index 107 i
    ex  (SP),HL         ; 1:19      index 107 i 
    call snake_y        ; 3:17      call ( -- ret ) R:( -- ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    call draw_black     ; 3:17      call ( -- ret ) R:( -- ) 
    
    exx                 ; 1:4       loop 107
    ld    E,(HL)        ; 1:7       loop 107
    inc   L             ; 1:4       loop 107
    ld    D,(HL)        ; 1:7       loop 107 DE = index   
    inc  HL             ; 1:6       loop 107
    inc  DE             ; 1:6       loop 107 index++
    ld    A,(HL)        ; 1:4       loop 107
    xor   E             ; 1:4       loop 107 lo index - stop
    jr   nz, $+8        ; 2:7/12    loop 107
    ld    A, D          ; 1:4       loop 107
    inc   L             ; 1:4       loop 107
    xor (HL)            ; 1:7       loop 107 hi index - stop
    jr    z, leave107   ; 2:7/12    loop 107 exit    
    dec   L             ; 1:4       loop 107
    dec  HL             ; 1:6       loop 107
    ld  (HL), D         ; 1:7       loop 107
    dec   L             ; 1:4       loop 107
    ld  (HL), E         ; 1:7       loop 107
    exx                 ; 1:4       loop 107
    jp   do107          ; 3:10      loop 107
leave107:
    inc  HL             ; 1:6       loop 107
    exx                 ; 1:4       loop 107
exit107 EQU $ 

    
    push DE             ; 1:11      length @ push(length) fetch 
    ex   DE, HL         ; 1:4       length @ push(length) fetch
    ld   HL,(length)    ; 3:16      length @ push(length) fetch 
    call snake_x        ; 3:17      call ( -- ret ) R:( -- ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    
    push DE             ; 1:11      length @ push(length) fetch 
    ex   DE, HL         ; 1:4       length @ push(length) fetch
    ld   HL,(length)    ; 3:16      length @ push(length) fetch 
    call snake_y        ; 3:17      call ( -- ret ) R:( -- ) 
    ld    A, (HL)       ; 1:7       @ fetch 
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch 
    
    call draw_white     ; 3:17      call ( -- ret ) R:( -- )

draw_snake_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
draw_apple:             ;            
    
    push DE             ; 1:11      push(0x24)
    ex   DE, HL         ; 1:4       push(0x24)
    ld   HL, 0x24       ; 3:10      push(0x24) 
    push DE             ; 1:11      apple_x @ push(apple_x) fetch 
    ex   DE, HL         ; 1:4       apple_x @ push(apple_x) fetch
    ld   HL,(apple_x)   ; 3:16      apple_x @ push(apple_x) fetch 
    push DE             ; 1:11      apple_y @ push(apple_y) fetch 
    ex   DE, HL         ; 1:4       apple_y @ push(apple_y) fetch
    ld   HL,(apple_y)   ; 3:16      apple_y @ push(apple_y) fetch 
    call draw           ; 3:17      call ( -- ret ) R:( -- )

draw_apple_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  

; x = 20*x ms

;   ---  the beginning of a non-recursive function  ---
sleep:                  ;           ( x -- )
    pop  BC             ; 1:10      : ret
    ld  (sleep_end+1),BC; 4:20      : ( ret -- ) R:( -- )
    
sfor108:                ;           sfor 108 ( index -- index )
        halt
    
    ld   A, H           ; 1:4       snext 108
    or   L              ; 1:4       snext 108
    dec  HL             ; 1:6       snext 108 index--
    jp  nz, sfor108     ; 3:10      snext 108
snext108:               ;           snext 108
    ex   DE, HL         ; 1:4       sfor unloop 108
    pop  DE             ; 1:10      sfor unloop 108

sleep_end:
    jp   0x0000         ; 3:10      ;
;   ---------  end of non-recursive function  ---------  


;   ---  the beginning of a data stack function  ---
game_loop:              ;            ;( -- )
    
begin101: 
        
    call draw_snake     ; 3:17      scall 
        
    call draw_apple     ; 3:17      scall 
        
    push DE             ; 1:11      push(7)
    ex   DE, HL         ; 1:4       push(7)
    ld   HL, 7          ; 3:10      push(7) 
    call sleep          ; 3:17      call ( -- ret ) R:( -- ) 
        
    call check_input    ; 3:17      scall
        
    call move_snake_tail; 3:17      scall 
        
    call move_snake_head; 3:17      scall 
        
    call check_apple    ; 3:17      scall 
        
    call check_collision; 3:17      call ( -- ret ) R:( -- ) 
    
    ld    A, H          ; 1:4       until 101
    or    L             ; 1:4       until 101
    ex   DE, HL         ; 1:4       until 101
    pop  DE             ; 1:10      until 101
    jp    z, begin101   ; 3:10      until 101
break101:               ;           until 101    
    
    push DE             ; 1:11      print
    ld   BC, size101    ; 3:10      print Length of string to print
    ld   DE, string101  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print

game_loop_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  ---------  


;   ---  the beginning of a data stack function  ---
start:                  ;            
    call initialize     ; 3:17      scall 
    call game_loop      ; 3:17      scall 
start_end:
    ret                 ; 1:10      s;
;   ---------  end of data stack function  --------- 



; ( max -- rand )
; 16-bit pseudorandom generator
; HL = random < max, or HL = 0
Random:
    ld    A, H          ; 1:4
    or    A             ; 1:4
    jr    z, Random_H0  ; 2:7/11
    
    ld    C, 0xFF       ; 2:7
    xor   A             ; 1:4
    adc   A, A          ; 1:4
    cp    H             ; 1:4
    jr    c, $-2        ; 2:7/11
    ld    B, A          ; 1:4       BC = mask = 0x??FF
    jr   Random_Begin   ; 2:12
    
Random_H0:
    ld    B, A          ; 1:4
    or    L             ; 1:4
    ret   z             ; 1:5/11

    xor   A             ; 1:4
    adc   A, A          ; 1:4
    cp    L             ; 1:4
    jr    c, $-2        ; 2:7/11
    ld    C, A          ; 1:4       BC = mask = 0x00??
    
Random_Begin:
    push  DE            ; 1:11
    ex    DE, HL        ; 1:4
Random_new:
    call Rnd            ; 3:17
    
    ld    A, C          ; 1:4
    and   L             ; 1:4
    ld    L, A          ; 1:4
    ld    A, B          ; 1:4
    and   H             ; 1:4
    ld    H, A          ; 1:4
    
    sbc  HL, DE         ; 2:15
    jr   nc, Random_new ; 2:7/11
    
Rnd_Exit:
    add  HL, DE         ; 1:11
    pop  DE             ; 1:10
    ret                 ; 1:10
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

apple_x: dw 0x0000
apple_y: dw 0x0000
direction: dw 0x0000
length: dw 0x0000
STRING_SECTION:
string101:
db "Game Over", 0xD
size101 EQU $ - string101


snake_x_head EQU $
snake_y_head EQU snake_x_head + 2*500 
