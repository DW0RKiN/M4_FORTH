include(`../M4/FIRST.M4')dnl 
  ifdef __ORG
    org __ORG
  else
    org 24576
  endif
INIT(60000)
SCALL(_bench)
STOP

define({TYPMUL},{})
define({TYPDIV},{})

COLON(_decomp,( n -- ))
    PUSH(2)
    BEGIN  
        _2DUP DUP MUL 
    UGE_WHILE  
        _2DUP UDIVMOD 
        SWAP_IF 
            DROP _1ADD PUSH(1) OR ; next odd number
        ELSE 
            NROT_NIP
        THEN
    REPEAT
    _2DROP 
SEMICOLON

SCOLON(_bench,( -- ))
    PUSH(10000) FOR(S) I CALL(_decomp) NEXT
SSEMICOLON
