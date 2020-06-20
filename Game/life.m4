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

SCOLON(_left,( -- ))
    PUSH2(_stop,_screen) SDO
        SI SI PUSH(buff-_screen+1) ADD PUSH(_w-1) CMOVE
        SI PUSH(_w-1) ADD CFETCH OVER PUSH(buff-_screen) ADD CSTORE
    PUSH_ADDSLOOP(_w)
SSEMICOLON

SCOLON(_right,( -- ))
    PUSH2(_stop,_screen) SDO
        SI _1ADD OVER PUSH(buff-_screen) ADD PUSH(_w-1) CMOVE
        SI CFETCH OVER PUSH(buff-_screen+_w-1) ADD CSTORE
    PUSH_ADDSLOOP(_w)
SSEMICOLON

SCOLON(_down,( -- ))
    PUSH(_screen+_w) PUSH2(buff       , _wh-_w) CMOVE
    PUSH(_screen   ) PUSH2(buff+_wh-_w, _w    ) CMOVE
SSEMICOLON

SCOLON(_up,( -- ))
    PUSH(_screen  ) PUSH2(buff+_w, _wh-_w) CMOVE
    PUSH(_stop-_w ) PUSH2(buff   , _w    ) CMOVE
SSEMICOLON

SCOLON(_copy,( -- ))
    PUSH(buff) PUSH2(_screen, _wh) CMOVE
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
        PUSH2(0,last_key) CSTORE
        SWAP_CURSOR    
        DUP_PUSH_CEQ_IF('q') DROP_PUSH(0) SCALL(_up  )  THEN
        DUP_PUSH_CEQ_IF('a') DROP_PUSH(0) SCALL(_down)  THEN
        DUP_PUSH_CEQ_IF('p') DROP_PUSH(0) SCALL(_right) THEN
        DUP_PUSH_CEQ_IF('o') DROP_PUSH(0) SCALL(_left)  THEN
        DUP_PUSH_CEQ_IF('m') 
            DROP_PUSH(0)
            PUSH_CFETCH(buff+400) 
            PUSH(1) XOR 
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
    PUSH(0x4000) PUSH2(0x4800, 8*256) CMOVE
    PUSH(0x4800) PUSH2(0x5000, 8*256) CMOVE
    PUSH2(0,last_key) CSTORE
    PUSH2(_screen+_wh,_screen) SDO RND PUSH(1) AND OVER CSTORE SLOOP 
SSEMICOLON

SCOLON(_generation,( -- ))
    PUSH(_wh-1) SFOR 
        SI PUSH(_screen) ADD
        SCALL(_alive) 
        OVER PUSH(buff) ADD CSTORE
    SNEXT
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
        PUSH(-_wh) ADD
    THEN
    ; [+32]
    DUP  LEFT
    ; [+31]
    DUP  LEFT
    ; [-33]
    DUP PUSH(-2*_w) ADD
    DUP_PUSH_LT_IF(_screen)
        PUSH(_wh) ADD
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
