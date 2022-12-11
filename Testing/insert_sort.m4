include(`../M4/FIRST.M4')dnl 

    ORG 0x8000
    INIT(60000)
    CREATE(test)
    PUSH_ALLOT(20)

    PUSH2(orig,test) PUSH(2*10) CMOVE
    PUSH2(test,10) CALL(print)
    PUSH2(test,10) CALL(sort)
    PUSH2(test,10) CALL(print)
    CR
       
    DEPTH UDOT PRINT_Z({" values in data stack.", 0xD})
    RAS
    PRINT_Z({"RAS:"}) UDOT CR
    STOP
    
COLON(print,(addr len -- ))
  PUSH(0) ; addr len 1
  DO 
    DUP I _2MUL ADD FETCH SPACE_UDOT
  LOOP 
  DROP CR
SEMICOLON

COLON(insert,( start end -- start ))
    DUP FETCH TO_R ;( r: v ) v = a[i]
    BEGIN
        _2DUP LT			; j>0
    WHILE
        R_FETCH OVER _2SUB FETCH LT		; a[j-1] > v
    WHILE
        _2SUB			; j--
        DUP FETCH OVER _2ADD STORE		; a[j] = a[j-1]
    REPEAT
    R_FROM SWAP STORE 
SEMICOLON		; a[j] = v
 
COLON(sort,( array len -- ))
    PUSH(1) DO 
        DUP I _2MUL ADD CALL(insert) 
    LOOP 
    DROP 
SEMICOLON

;# I need to have label test and orig at the end.
include({../M4/LAST.M4})dnl

orig:
dw 7 , 3 , 0 , 2 , 9 , 1 , 6 , 8 , 4 , 5

