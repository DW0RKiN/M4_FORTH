include(`../M4/FIRST.M4')dnl 
    ORG 0x8000
    INIT(60000)
    SCALL(_init)
    BEGIN
        SCALL(_copy)
        SCALL(_generation)
        SCALL(_readkey)
    AGAIN

CONSTANT(_w,32)
CONSTANT(_h,24)
CONSTANT(_wh,_w*_h)
CONSTANT(_screen,0x5800)
CONSTANT(_cursor,0x5990)
CONSTANT(_stop,0x5B00)
CONSTANT(last_key,0x5C08)
CREATE(buff)

; kurzor doleva, pozadi doprava
SCOLON(_left,( -- ))
    PUSH2(_stop,_screen) DO(S)
        I I PUSH(buff-_screen+1) ADD PUSH(_w-1) CMOVE
        I PUSH(_w-1) ADD CFETCH OVER PUSH(buff-_screen) ADD CSTORE
    PUSH(_w) ADDLOOP
SSEMICOLON

SCOLON(_right,( -- ))
    PUSH2(_stop,_screen) DO(S)
        I _1ADD OVER PUSH(buff-_screen) ADD PUSH(_w-1) CMOVE
        I CFETCH OVER PUSH(buff-_screen+_w-1) ADD CSTORE
    PUSH(_w) ADDLOOP
SSEMICOLON

SCOLON(_down,( -- ))
    PUSH2(_screen+_w, buff       ) PUSH(_wh-_w) CMOVE
    PUSH2(_screen   , buff+_wh-_w) PUSH(_w    ) CMOVE
SSEMICOLON

SCOLON(_up,( -- ))
    PUSH2(_screen , buff+_w) PUSH(_wh-_w) CMOVE
    PUSH2(_stop-_w, buff   ) PUSH(_w    ) CMOVE
SSEMICOLON

SCOLON(_copy,( -- ))
    PUSH2(buff, _screen) PUSH(_wh) CMOVE
SSEMICOLON

define({SWAP_CURSOR},{
__{}__ADD_TOKEN({__TOKEN_SWAP_CURSOR},{swap cursor},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SWAP_CURSOR},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld   BC, format({%-11s},_cursor); 3:10      swap_cursor
    ld    A,(BC)        ; 1:7       swap_cursor
    xor  0x09           ; 2:7       swap_cursor
    ld  (BC),A          ; 1:7       swap_cursor})dnl
    
SCOLON(_readkey,( -- ))
    PUSH(last_key) CFETCH
    IF BEGIN
        SWAP_CURSOR
        BEGIN
            PUSH(last_key) CFETCH
        UNTIL
        PUSH_CFETCH(last_key) 
        PUSH2_CSTORE(0,last_key)
        SWAP_CURSOR    
        DUP_PUSH_CEQ_IF('q') DROP PUSH(0) SCALL(_up  )  THEN
        DUP_PUSH_CEQ_IF('a') DROP PUSH(0) SCALL(_down)  THEN
        DUP_PUSH_CEQ_IF('p') DROP PUSH(0) SCALL(_right) THEN
        DUP_PUSH_CEQ_IF('o') DROP PUSH(0) SCALL(_left)  THEN
        DUP_PUSH_CEQ_IF('r') DROP PUSH(0) SCALL(_random_all) THEN
        DUP_PUSH_CEQ_IF('i') DROP PUSH(0) SCALL(_invert_all) THEN
        DUP_PUSH_CEQ_IF('c') DROP PUSH(0) PUSH3(buff,_wh, 0) FILL THEN
        DUP_PUSH_CEQ_IF('f') DROP PUSH(0) PUSH3(buff,_wh, 1) FILL THEN
        DUP_PUSH_CEQ_IF('s') 
            DROP PUSH(0)
            PUSH(buff+400) CFETCH 
            PUSH(1) XOR 
            PUSH(buff+400) CSTORE 
        THEN
        DUP PUSH('e') CEQ IF
            STOP
        THEN
        SCALL(_copy)
        IF BREAK THEN
    AGAIN THEN
SSEMICOLON

SCOLON(_random_all,( -- ))
    PUSH2(buff+_wh,buff) DO(S) RND PUSH(1) AND OVER CSTORE LOOP
SSEMICOLON

SCOLON(_invert_all,( -- ))
    PUSH2(buff+_wh,buff) DO(S) I CFETCH PUSH(1) XOR OVER CSTORE LOOP
SSEMICOLON


SCOLON(_init,( -- ))
    PRINT({0x16, 0, 0})
    PUSH(_w*8) FOR PUTCHAR('O') NEXT
    PUSH2(0x4000, 0x4800) PUSH(8*256) CMOVE
    PUSH2(0x4800, 0x5000) PUSH(8*256) CMOVE
    PUSH2_CSTORE(0,last_key) 
    SCALL(_random_all)
SSEMICOLON

SCOLON(_generation,( -- ))
    PUSH(_wh-1) FOR(S) 
        I PUSH(_screen) ADD
        SCALL(_alive) 
        OVER PUSH(buff) ADD CSTORE
    NEXT
SSEMICOLON

SCOLON(_alive,( addr -- alive ))
    DUP
    CFETCH _0EQ_IF
        SCALL(sum_neighbors)
        PUSH(3) EQ IF PUSH(1) SEXIT THEN
    ELSE
        SCALL(sum_neighbors) 
        PUSH(0x01) OR 
        PUSH(3) EQ IF PUSH(1) SEXIT THEN
    THEN
    PUSH(0)
SSEMICOLON

;# dup 1- 0x1F and swap 0xFFE0 and + 
define({LEFT},{dnl
__{}__ADD_TOKEN({__TOKEN_LEFT},{<--},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_LEFT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, L          ; 1:4       left
    dec   A             ; 1:4       left
    xor   L             ; 1:4       left
    and  0x1F           ; 2:7       left
    xor   L             ; 1:4       left
    ld    L, A          ; 1:4       left})dnl

;# dup 1+ 0x1F and swap 0xFFE0 and + 
define({RIGHT},{dnl
__{}__ADD_TOKEN({__TOKEN_RIGHT},{-->},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_RIGHT},{dnl
__{}define({__INFO},__COMPILE_INFO)
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
    DUP PUSH(_stop) UGE IF
        PUSH(-_wh) ADD
    THEN
    ; [+32]
    DUP  LEFT
    ; [+31]
    DUP  LEFT
    ; [-33]
    DUP PUSH(-2*_w) ADD
    DUP PUSH(_screen) ULT IF
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
    ; 16 bit --> 8 bit
    PUSH(0xFF) AND
SSEMICOLON

