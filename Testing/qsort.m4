include(`../M4/FIRST.M4')dnl 
ORG 0x8000
    INIT(60000)
    ld  hl, stack_test
    push hl

;#  PUSH2(orig,test) PUSH(2*10) CMOVE
;#  PUSH2(test,10) CALL(print)
    PUSH2(test,10) CALL(generate)
;#  PUSH2(test,10) CALL(print)
    PUSH2(test,10) CALL(sort)
    PUSH2(test,10) CALL(print)
    CR

    PRINT({"RAS:"})
    exx
    push HL
    exx
    pop HL
    DUP_UDOT
    ret
    
COLON(generate,(addr len -- ))
    _2MUL OVER ADD SWAP ; ( addr+len addr )
    DO 
        RND
        DUP_DOT I STORE
    _2ADDLOOP
    CR
SEMICOLON
    
COLON(print,(addr len -- ))
    _2MUL OVER ADD SWAP ; ( addr+len addr )
    DO 
        I FETCH DOT
    _2ADDLOOP
    CR
SEMICOLON

COLON(mid) ;( l r -- mid )
    OVER SUB _2DIV PUSH(-2) AND ADD 
SEMICOLON
 
COLON(exch_slow,( addr1 addr2 -- ))
    DUP FETCH TO_R OVER FETCH SWAP STORE R_FROM SWAP STORE 
SEMICOLON

COLON(exch,( addr1 addr2 -- )) 
    OVER FETCH OVER FETCH        ;( read values)
    SWAP ROT STORE SWAP STORE    ;( exchange values)
SEMICOLON  

COLON(partition,( l r -- l r r2 l2 ))
    _2DUP CALL(mid) FETCH TO_R ;( r: pivot )
    _2DUP BEGIN
        SWAP BEGIN 
            DUP FETCH  R_FETCH LT WHILE _2ADD 
        REPEAT
        SWAP BEGIN 
            R_FETCH OVER FETCH LT WHILE _2SUB 
        REPEAT
        _2DUP_LE_IF 
            _2DUP CALL(exch) TO_R _2ADD R_FROM _2SUB 
        THEN
    _2DUP GT UNTIL  
    R_FROM DROP 
SEMICOLON
 
COLON(qsort,( l r -- ))
    CALL(partition) SWAP ROT
  ; 2over 2over - + < if 2swap then
    _2DUP_LT_IF CALL(qsort) ELSE _2DROP THEN
    _2DUP_LT_IF CALL(qsort) ELSE _2DROP THEN 
SEMICOLON
 
COLON(sort),( array len -- ))
    DUP_PUSH_LT_IF(2) 
        _2DROP EXIT 
    THEN
    _1SUB _2MUL OVER ADD CALL(qsort) 
SEMICOLON

SCOLON(stack_test)
    PRINT({0xD, "Data stack OK!", 0xD})
    STOP
SSEMICOLON

include({../M4/LAST.M4})dnl

test:
dw 700 , 3 , 0 , 2 , 9 , 1 , 6 , 8 , 4 , 5

orig:
dw 7 , 3 , 0 , 2 , 9 , 1 , 6 , 8 , 4 , 5
