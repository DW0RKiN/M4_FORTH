include(`../M4/FIRST.M4')dnl 
ORG 0x8000
INIT(60000)
CALL(do_prime)
STOP
CONSTANT(_size,8190)
CONSTANT(_size_add1,8191)

COLON(do_prime)
PUSH3_FILL(flags,_size_add1,1)
PUSH(0) PUSH2(_size,0) DO 
    PUSH(flags) I ADD CFETCH
    IF I DUP _1ADD DUP_ADD _1ADD SWAP OVER ADD
        BEGIN 
        DUP_PUSH_ULT_WHILE(_size_add1)
            PUSH(0) OVER PUSH_ADD(flags) CSTORE OVER ADD 
        REPEAT
        _2DROP _1ADD
    THEN
LOOP
DOT PRINT({" PRIMES"}) CR
SEMICOLON

include({../M4/LAST.M4})dnl


flags:
