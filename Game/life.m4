include(`../M4/FIRST.M4')dnl 
    ORG 0x8000
    INIT(60000)
    SCALL(_init)
    BEGIN
        SCALL(_generation)
        SCALL(_readkey)
        SCALL(_copy)
    AGAIN

CONSTANT(_w,32)
CONSTANT(_h,24)
CONSTANT(_wh,_w*_h)
CONSTANT(_screen,0x5800)
CONSTANT(_cursor,0x5990)
CONSTANT(_stop,0x5B00)
CONSTANT(last_key,0x5C08)

; kurzor doleva, pozadi doprava
SCOLON(_left,( -- ))
    PUSH2(_stop,_screen) SDO
        SI SI PUSH_ADD(buff-_screen+1) PUSH_CMOVE(_w-1)
        SI PUSH_ADD(_w-1) CFETCH OVER PUSH_ADD(buff-_screen) CSTORE
    PUSH_ADDSLOOP(_w)
SSEMICOLON

SCOLON(_right,( -- ))
    PUSH2(_stop,_screen) SDO
        SI _1ADD OVER PUSH_ADD(buff-_screen) PUSH_CMOVE(_w-1)
        SI CFETCH OVER PUSH_ADD(buff-_screen+_w-1) CSTORE
    PUSH_ADDSLOOP(_w)
SSEMICOLON

SCOLON(_down,( -- ))
    PUSH2(_screen+_w, buff       ) PUSH_CMOVE(_wh-_w)
    PUSH2(_screen   , buff+_wh-_w) PUSH_CMOVE(_w    )
SSEMICOLON

SCOLON(_up,( -- ))
    PUSH2(_screen , buff+_w) PUSH_CMOVE(_wh-_w)
    PUSH2(_stop-_w, buff   ) PUSH_CMOVE(_w    )
SSEMICOLON

SCOLON(_copy,( -- ))
    PUSH2(buff, _screen) PUSH_CMOVE(_wh)
SSEMICOLON

define({SWAP_CURSOR},{
    ld   BC, format({%-11s},_cursor); 3:10      swap_cursor
    ld    A,(BC)        ; 1:7       swap_cursor
    xor  0x09           ; 2:7       swap_cursor
    ld  (BC),A          ; 1:7       swap_cursor})dnl
    
SCOLON(_readkey,( -- ))
    PUSH_CFETCH(last_key)
    IF BEGIN
        SWAP_CURSOR
        BEGIN
            PUSH_CFETCH(last_key)
        UNTIL
        PUSH_CFETCH(last_key) 
        PUSH2_CSTORE(0,last_key)
        SWAP_CURSOR    
        DUP_PUSH_CEQ_IF('q') DROP_PUSH(0) SCALL(_up  )  THEN
        DUP_PUSH_CEQ_IF('a') DROP_PUSH(0) SCALL(_down)  THEN
        DUP_PUSH_CEQ_IF('p') DROP_PUSH(0) SCALL(_right) THEN
        DUP_PUSH_CEQ_IF('o') DROP_PUSH(0) SCALL(_left)  THEN
        DUP_PUSH_CEQ_IF('m') 
            DROP_PUSH(0)
            PUSH_CFETCH(buff+400) 
            PUSH_XOR(1) 
            PUSH_CSTORE(buff+400) 
        THEN
        DUP_PUSH_CEQ_IF('e')
            STOP
        THEN
        SCALL(_copy)
        IF BREAK THEN
    AGAIN THEN
SSEMICOLON
    
SCOLON(_init,( -- ))
    PRINT({0x16, 0, 0})
    PUSH(_w*8) SFOR PUTCHAR('O') SNEXT
    PUSH2(0x4000, 0x4800) PUSH_CMOVE(8*256)
    PUSH2(0x4800, 0x5000) PUSH_CMOVE(8*256)
    PUSH2_CSTORE(0,last_key) 
    PUSH2(_screen+_wh,_screen) SDO RND PUSH_AND(1) OVER CSTORE SLOOP 
SSEMICOLON

SCOLON(_generation,( -- ))
    PUSH(_wh-1) SFOR 
        SI PUSH_ADD(_screen)
        SCALL(_alive) 
        OVER PUSH_ADD(buff) CSTORE
    SNEXT
SSEMICOLON

SCOLON(_alive,( addr -- alive ))
    DUP
    CFETCH _0EQ_IF
        SCALL(sum_neighbors)
        PUSH_EQ_IF(3) PUSH(1) SEXIT THEN
    ELSE
        SCALL(sum_neighbors) 
        PUSH_OR(0x01) 
        PUSH_EQ_IF(3) PUSH(1) SEXIT THEN
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
    DUP PUSH_ADD(_w)
    DUP_PUSH_UGE_IF(_stop)
        PUSH_ADD(-_wh)
    THEN
    ; [+32]
    DUP  LEFT
    ; [+31]
    DUP  LEFT
    ; [-33]
    DUP PUSH_ADD(-2*_w)
    DUP_PUSH_ULT_IF(_screen)
        PUSH_ADD(_wh)
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
    ; 16 bit --> 8 bit
    PUSH_AND(0xFF)
SSEMICOLON

include({../M4/LAST.M4})dnl

buff:
