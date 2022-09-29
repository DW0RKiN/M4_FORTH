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
CREATE(snake_x_head)
CONSTANT(snake_y_head,snake_x_head+2*500)

__ASM({
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
    ret                 ; 1:10})

__ASM({
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
    ret                 ; 1:10})

COLON(draw_white,( x y -- ))
__ASM({
    ld    C, white      ; 2:7
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10})
SEMICOLON

COLON(draw_black,( x y -- ))
__ASM({
    ld    C, black      ; 2:7
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10})
SEMICOLON

COLON(draw,( color x y -- ))
__ASM({
    pop   BC            ; 1:10
    call put_color      ; 3:17
    pop  HL             ; 1:10
    pop  DE             ; 1:10})
SEMICOLON

SCOLON(draw_walls)
    PUSH(width-1) FOR(S)
        I PUSH(0)        CALL(draw_black)
        I PUSH(height-1) CALL(draw_black)
    NEXT

    PUSH(height-1) FOR(S)
        PUSH(0)       OVER CALL(draw_black)
        PUSH(width-1) OVER CALL(draw_black)
    NEXT
SSEMICOLON

COLON(snake_x,( offset -- address ))
  _2MUL PUSH(snake_x_head) ADD
SEMICOLON

COLON(snake_y,( offset -- address ))
  _2MUL PUSH(snake_y_head) ADD
SEMICOLON

SCOLON(initialize_snake)
    PUSH(4) PUSH(length) STORE
    DO(M,4+1,0)
        PUSH(12) I SUB I CALL(snake_x) STORE
        PUSH(12) I       CALL(snake_y) STORE
    LOOP
    PUSH(right) PUSH(direction) STORE
SSEMICOLON

COLON(set_apple_position,( y x -- ))
    PUSH(apple_x) STORE PUSH(apple_y) STORE
SEMICOLON

SCOLON(initialize_apple)
    PUSH(4) PUSH(4) CALL(set_apple_position)
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
    PUSH2(-1,snake_y_head) ADDSTORE
SSEMICOLON

SCOLON(move_left)
    PUSH2(-1,snake_x_head) ADDSTORE
SSEMICOLON

SCOLON(move_down)
    PUSH2(1,snake_y_head) ADDSTORE
SSEMICOLON

SCOLON(move_right)
    PUSH2(1,snake_x_head) ADDSTORE
SSEMICOLON

SCOLON(move_snake_head)
    PUSH(direction) FETCH
    DUP PUSH(left)  EQ IF SCALL(move_left)  ELSE
    DUP PUSH(up)    EQ IF SCALL(move_up)    ELSE
    DUP PUSH(right) EQ IF SCALL(move_right) ELSE
    DUP PUSH(down)  EQ IF SCALL(move_down)
    THEN THEN THEN THEN DROP
SSEMICOLON

; Move each segment of the snake forward by one
SCOLON(move_snake_tail)
    PUSH(length) FETCH FOR(S)
        I DUP CALL(snake_x) FETCH SWAP _1ADD CALL(snake_x) STORE
        I DUP CALL(snake_y) FETCH SWAP _1ADD CALL(snake_y) STORE
    NEXT
SSEMICOLON

COLON(is_horizontal,( -- flag ))
    PUSH(direction) FETCH DUP
    PUSH(left)  EQ SWAP
    PUSH(right) EQ OR
SEMICOLON

COLON(is_vertical,( -- flag ))
    PUSH(direction) FETCH DUP
    PUSH(up)    EQ SWAP
    PUSH(down)  EQ OR
SEMICOLON

SCOLON(turn_up)    CALL(is_horizontal) IF PUSH(   up) PUSH(direction) STORE THEN SSEMICOLON

SCOLON(turn_left)  CALL(is_vertical)   IF PUSH( left) PUSH(direction) STORE THEN SSEMICOLON

SCOLON(turn_down)  CALL(is_horizontal) IF PUSH( down) PUSH(direction) STORE THEN SSEMICOLON

SCOLON(turn_right) CALL(is_vertical)   IF PUSH(right) PUSH(direction) STORE THEN SSEMICOLON

COLON(change_direction,( key -- ))
  DUP PUSH('o') EQ IF SCALL(turn_left)  ELSE
  DUP PUSH('q') EQ IF SCALL(turn_up)    ELSE
  DUP PUSH('p') EQ IF SCALL(turn_right) ELSE
  DUP PUSH('a') EQ IF SCALL(turn_down)
  THEN THEN THEN THEN DROP
SEMICOLON

SCOLON(check_input)
    PUSH(last_key) CFETCH
    CALL(change_direction)
    PUSH(0) PUSH(last_key) CSTORE
SSEMICOLON

; get random x or y position within playable area
SCOLON(random_position,( n -- 2..n-3 ))
    PUSH(4) SUB RANDOM _2ADD
SSEMICOLON

SCOLON(move_apple)
    PUSH(24) SCALL(random_position) PUSH(32) SCALL(random_position)
    CALL(set_apple_position)
SSEMICOLON

SCOLON(grow_snake)
    PUSH2(1,length) ADDSTORE
SSEMICOLON

SCOLON(check_apple)
    PUSH(snake_x_head) FETCH PUSH(apple_x) FETCH EQ
    PUSH(snake_y_head) FETCH PUSH(apple_y) FETCH EQ

    AND IF
        SCALL(move_apple)
        SCALL(grow_snake)
    THEN
SSEMICOLON

COLON(check_collision) ;( -- flag )
    ; get current x/y position
    PUSH(snake_x_head) FETCH PUSH(snake_y_head) FETCH

    __ASM({
    ; get color at current position
    call get_color      ; 3:17
    pop  DE             ; 1:10})

    ; leave boolean flag on stack
    _0EQ
SEMICOLON

SCOLON(draw_snake)
    PUSH(length) FETCH PUSH(0) DO
        I CALL(snake_x) FETCH I CALL(snake_y) FETCH CALL(draw_black)
    LOOP

    PUSH(length) FETCH CALL(snake_x) FETCH
    PUSH(length) FETCH CALL(snake_y) FETCH
    CALL(draw_white)
SSEMICOLON

SCOLON(draw_apple)
    PUSH(red) PUSH(apple_x) FETCH PUSH(apple_y) FETCH CALL(draw)
SSEMICOLON

; x = 20*x ms
COLON(sleep, ( x -- ))
    FOR(S)
    __ASM({
        halt})
    NEXT
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
