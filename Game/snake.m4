;# Forth program from https://skilldrick.github.io/easyforth/
;# by Nick Morgan

include(`../M4/FIRST.M4')dnl 
    ORG 0x8000
    INIT(60000)
    SCALL(start)
    STOP

VARIABLE(apple_x)  
VARIABLE(apple_y)  
CONSTANT(left,0)  
CONSTANT(up,1)  
CONSTANT(right,2)  
CONSTANT(down,3)  
CONSTANT(width,32)  
CONSTANT(height,24)  
CONSTANT(white,0x3F)
CONSTANT(red,0x24) 
CONSTANT(black,0)  
VARIABLE(direction)  
VARIABLE(length)  
CONSTANT(graphics,0x5800)
CONSTANT(last_key,0x5C08)

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
    ld   DE, graphics   ; 3:10
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
    ld   DE, graphics   ; 3:10
    add  HL, DE         ; 1:11      
    ld   L, (HL)        ; 1:7
    ld   H, 0x00        ; 2:7
    ret                 ; 1:10

COLON(draw_white,( x y -- ))
    ld    C, white      ; 2:7
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10
SEMICOLON  

COLON(draw_black,( x y -- ))
    ld    C, black      ; 2:7
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10
SEMICOLON  

COLON(draw,( color x y -- ))
    pop   BC            ; 1:10
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10
SEMICOLON  

SCOLON(draw_walls) 
    PUSH(width-1) SFOR 
        SI PUSH(0)        CALL(draw_black) 
        SI PUSH(height-1) CALL(draw_black) 
    SNEXT

    PUSH(height-1) SFOR 
        PUSH(0)       OVER CALL(draw_black) 
        PUSH(width-1) OVER CALL(draw_black) 
    SNEXT
SSEMICOLON

COLON(snake_x,( offset -- address ))
  _2MUL PUSH_ADD(snake_x_head) 
SEMICOLON
  
COLON(snake_y,( offset -- address ))
  _2MUL PUSH_ADD(snake_y_head)
SEMICOLON  

SCOLON(initialize_snake) 
    PUSH2_STORE(4,length) 
    XDO(4+1,0)  
        PUSH(12) XI SUB XI CALL(snake_x) STORE 
        PUSH(12) XI        CALL(snake_y) STORE 
    XLOOP 
    PUSH2_STORE(right,direction) 
SSEMICOLON  

COLON(set_apple_position,( y x -- ))
    PUSH_STORE(apple_x) PUSH_STORE(apple_y) 
SEMICOLON  

SCOLON(initialize_apple)  
    PUSH2(4,4) CALL(set_apple_position) 
SSEMICOLON  

SCOLON(initialize) 
    PUSH(width-1) FOR 
        PUSH(height-1) FOR 
            J I CALL(draw_white) 
        NEXT 
    NEXT
    SCALL(draw_walls) 
    SCALL(initialize_snake) 
    SCALL(initialize_apple)
SSEMICOLON  

SCOLON(move_up)  
    PUSH2_ADDSTORE(-1,snake_y_head) 
SSEMICOLON  

SCOLON(move_left)  
    PUSH2_ADDSTORE(-1,snake_x_head) 
SSEMICOLON  

SCOLON(move_down)  
    PUSH2_ADDSTORE(1,snake_y_head) 
SSEMICOLON  

SCOLON(move_right)  
    PUSH2_ADDSTORE(1,snake_x_head) 
SSEMICOLON  

SCOLON(move_snake_head)  
    PUSH_FETCH(direction) 
    DUP_PUSH_EQ_IF(left)  SCALL(move_left)  ELSE 
    DUP_PUSH_EQ_IF(up)    SCALL(move_up)    ELSE 
    DUP_PUSH_EQ_IF(right) SCALL(move_right) ELSE 
    DUP_PUSH_EQ_IF(down)  SCALL(move_down) 
    THEN THEN THEN THEN DROP 
SSEMICOLON  

; Move each segment of the snake forward by one  
SCOLON(move_snake_tail)  
    PUSH_FETCH(length) SFOR 
        SI DUP CALL(snake_x) FETCH SWAP _1ADD CALL(snake_x) STORE 
        SI DUP CALL(snake_y) FETCH SWAP _1ADD CALL(snake_y) STORE 
    SNEXT 
SSEMICOLON  

COLON(is_horizontal,( -- flag ))  
    PUSH_FETCH(direction) DUP 
    PUSH(left)  EQ SWAP 
    PUSH(right) EQ OR 
SEMICOLON

COLON(is_vertical,( -- flag ))
    PUSH_FETCH(direction) DUP 
    PUSH(up)    EQ SWAP 
    PUSH(down)  EQ OR 
SEMICOLON  

SCOLON(turn_up)    CALL(is_horizontal) IF PUSH2_STORE(up   ,direction) THEN SSEMICOLON  

SCOLON(turn_left)  CALL(is_vertical)   IF PUSH2_STORE(left ,direction) THEN SSEMICOLON  

SCOLON(turn_down)  CALL(is_horizontal) IF PUSH2_STORE(down ,direction) THEN SSEMICOLON  

SCOLON(turn_right) CALL(is_vertical)   IF PUSH2_STORE(right,direction) THEN SSEMICOLON  

COLON(change_direction,( key -- ))
  DUP_PUSH_EQ_IF('o') SCALL(turn_left)  ELSE 
  DUP_PUSH_EQ_IF('q') SCALL(turn_up)    ELSE 
  DUP_PUSH_EQ_IF('p') SCALL(turn_right) ELSE 
  DUP_PUSH_EQ_IF('a') SCALL(turn_down) 
  THEN THEN THEN THEN DROP 
SEMICOLON  

SCOLON(check_input) 
    PUSH_CFETCH(last_key)
    CALL(change_direction)
    PUSH2_CSTORE(0,last_key)
SSEMICOLON  

; get random x or y position within playable area  
SCOLON(random_position,( n -- 2..n-3 ))
    PUSH_SUB(4) RANDOM _2ADD 
SSEMICOLON  

SCOLON(move_apple) 
    PUSH(24) SCALL(random_position) PUSH(32) SCALL(random_position) 
    CALL(set_apple_position) 
SSEMICOLON  

SCOLON(grow_snake)  
    PUSH2_ADDSTORE(1,length) 
SSEMICOLON  

SCOLON(check_apple) 
    PUSH_FETCH(snake_x_head) PUSH_FETCH(apple_x) EQ 
    PUSH_FETCH(snake_y_head) PUSH_FETCH(apple_y) EQ 

    AND IF
        SCALL(move_apple) 
        SCALL(grow_snake) 
    THEN
SSEMICOLON

COLON(check_collision) ;( -- flag )
    ; get current x/y position 
    PUSH_FETCH(snake_x_head) PUSH_FETCH(snake_y_head) 

    ; get color at current position 
    call get_color      ; 3:17
    pop  DE             ; 1:10
 
    ; leave boolean flag on stack 
    _0EQ
SEMICOLON

SCOLON(draw_snake) 
    PUSH_FETCH(length) PUSH(0) DO 
        I CALL(snake_x) FETCH I CALL(snake_y) FETCH CALL(draw_black) 
    LOOP 

    PUSH_FETCH(length) CALL(snake_x) FETCH 
    PUSH_FETCH(length) CALL(snake_y) FETCH 
    CALL(draw_white)
SSEMICOLON  

SCOLON(draw_apple) 
    PUSH(red) PUSH_FETCH(apple_x) PUSH_FETCH(apple_y) CALL(draw)
SSEMICOLON  

; x = 20*x ms
COLON(sleep, ( x -- ))
    SFOR
        halt
    SNEXT
SEMICOLON  

SCOLON(game_loop) ;( -- )
    BEGIN 
        SCALL(draw_snake) 
        SCALL(draw_apple) 
        PUSH(7) CALL(sleep) 
        SCALL(check_input)
        SCALL(move_snake_tail) 
        SCALL(move_snake_head) 
        SCALL(check_apple) 
        CALL(check_collision) 
    UNTIL    
    PRINT({"Game Over", 0xD})
SSEMICOLON  

SCOLON(start) SCALL(initialize) SCALL(game_loop) SSEMICOLON 

include({../M4/LAST.M4})dnl

snake_x_head EQU $
snake_y_head EQU snake_x_head + 2*500 
