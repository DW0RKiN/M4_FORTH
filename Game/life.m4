include(`../M4/FIRST.M4')dnl 
    ORG 0x8000
    INIT(60000)
    SCALL(_init)
    BEGIN
        SCALL(_generation)
        PUSH_CFETCH(last_key) IF BREAK THEN
    AGAIN
    STOP

CONSTANT(_w,32)
CONSTANT(_h,24)
CONSTANT(_screen,0x5800)
CONSTANT(_stop,0x5B00)
CONSTANT(last_key,0x5C08)

SCOLON(_copy,( -- ))
    PUSH(buff) PUSH2(_screen, _w*_h) CMOVE
SSEMICOLON

SCOLON(_init,( -- ))
    PRINT({0x16, 0, 0})
    PUSH(_w*8) SFOR PUTCHAR('O') SNEXT
    PUSH(0x4000) PUSH2(0x4800, 8*256) CMOVE
    PUSH(0x4800) PUSH2(0x5000, 8*256) CMOVE
    PUSH2(0,last_key) CSTORE
    PUSH2(_screen+_w*_h,_screen) SDO RND PUSH(1) AND OVER CSTORE SLOOP 
SSEMICOLON

SCOLON(_generation,( -- ))
    PUSH(_w*_h-1) SFOR 
        SI PUSH(_screen) ADD
        SCALL(_alive) 
        OVER PUSH(buff) ADD CSTORE
    SNEXT
    SCALL(_copy)
SSEMICOLON

SCOLON(_alive,( addr -- alive ))
    DUP
    CFETCH _0EQ_IF
        SCALL(sum_neighbors) PUSH(0x07) AND
        PUSH(3) EQ_IF PUSH(1) EXIT THEN
    ELSE
        SCALL(sum_neighbors) PUSH(0x07) AND 
        PUSH(0x01) OR 
        PUSH(3) EQ_IF PUSH(1) EXIT THEN
    THEN
    PUSH(0)
SSEMICOLON

; dup 1- 0x1F and swap 0xFFE0 and + 
define({LEFT},{
    ld    A, L          ; 1:4       left
    dec   A             ; 1:4       left
    xor   L             ; 1:4       left
    and  0x1F           ; 2:7       left
    xor   L             ; 1:4       left
    ld    L, A          ; 1:4       left})dnl

; dup 1+ 0x1F and swap 0xFFE0 and + 
define({RIGHT},{
    ld    A, L          ; 1:4       right
    inc   A             ; 1:4       right
    xor   L             ; 1:4       right
    and  0x1F           ; 2:7       right
    xor   L             ; 1:4       right
    ld    L, A          ; 1:4       right})dnl

SCOLON(sum_neighbors,( addr -- sum ))
    ; [-1]
    DUP  LEFT
    ; [+1]
    SWAP RIGHT
    ; [+33]
    DUP PUSH(_w) ADD
    DUP_PUSH_GE_IF(_stop)
        PUSH(-_w*_h) ADD
    THEN
    ; [+32]
    DUP  LEFT
    ; [+31]
    DUP  LEFT
    ; [-33]
    DUP PUSH(-2*_w) ADD
    DUP_PUSH_LT_IF(_screen)
        PUSH(_w*_h) ADD
    THEN
    ; [-32]
    DUP  RIGHT
    ; [-31]
    DUP  RIGHT

    FETCH 
    SWAP FETCH ADD
    SWAP FETCH ADD
    SWAP FETCH ADD
    SWAP FETCH ADD
    SWAP FETCH ADD
    SWAP FETCH ADD
    SWAP FETCH ADD
SSEMICOLON

include({../M4/LAST.M4})dnl

buff:
