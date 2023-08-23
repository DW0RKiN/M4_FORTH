include(`../M4/FIRST.M4')dnl 
ORG 0x8000
INIT(60000)
SCALL(_bench)
STOP

define({TYPMUL},{fast})
define({TYPDIV},{old_fast})

COLON(_decomp,( n -- ))
    PUSH(2)
    BEGIN  
        _2DUP DUP MUL 
    UGE WHILE  
        _2DUP UDIVMOD 
        SWAP IF 
            DROP _1ADD PUSH(1) OR ; next odd number
        ELSE 
            NROT NIP
        THEN
    REPEAT
    _2DROP 
SEMICOLON

SCOLON(_bench,( -- ))
    PUSH(10000) FOR(S) I CALL(_decomp) NEXT
SSEMICOLON

