include(`../M4/FIRST.M4')dnl 
    ORG 0x8000
    INIT(60000)
    
    CONSTANT(max,10)
    CREATE(data)
    PUSH_ALLOT(2*max)

    PUSH2(data,max) CALL(generate)
    PUSH2(data,max) CALL(print)
    PUSH2(data,max) CALL(sort)
    PUSH2(data,max) CALL(print)
    CR

    DEPTH DOT PRINT_Z({" values in data stack.", 0x0D})
    __RAS
    PRINT({"RAS:"}) UDOT CR
    STOP
    
COLON(generate,(addr len -- ))
    _2MUL OVER ADD SWAP ; ( addr+len addr )
    DO 
        RND I STORE
    PUSH_ADDLOOP(2)
    CR
SEMICOLON
    
COLON(print,(addr len -- ))
    _2MUL OVER ADD SWAP ; ( addr+len addr )
    DO 
        I FETCH SPACE_DOT
    PUSH_ADDLOOP(2)
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
 
RCOLON(qsort,( l r -- ))
    CALL(partition) SWAP ROT
  ; 2over 2over - + < if 2swap then
    _2DUP_LT_IF RCALL(qsort) ELSE _2DROP THEN
    _2DUP_LT_IF RCALL(qsort) ELSE _2DROP THEN 
RSEMICOLON
 
COLON(sort),( array len -- ))
    DUP_PUSH_LT_IF(2) 
        _2DROP EXIT 
    THEN
    _1SUB _2MUL OVER ADD RCALL(qsort) 
SEMICOLON

