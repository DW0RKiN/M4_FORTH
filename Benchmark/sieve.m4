include(`../M4/FIRST.M4')dnl 
  ifdef __ORG
    org __ORG
  else
    org 24576
  endif
INIT(60000)
CALL(do_prime)
STOP
CONSTANT(_size,8190)
CONSTANT(_size_add1,8191)

COLON(do_prime)
PUSH(flags,_size_add1,1) FILL
PUSH(0,_size,0) DO 
    PUSH(flags) I ADD CFETCH
    IF I DUP _1ADD DUP ADD _1ADD SWAP OVER ADD
        BEGIN 
        DUP PUSH(_size_add1) ULT WHILE
            PUSH(0) OVER PUSH(flags) ADD CSTORE OVER ADD 
        REPEAT
        _2DROP _1ADD
    THEN
LOOP
DOT PRINT({" PRIMES"}) CR
SEMICOLON

;# I need to have label flags at the end.
include({../M4/LAST.M4})dnl

flags:
