include(`../M4/FIRST.M4')dnl 
ORG 0x8000
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
        _2DUP UDIVMOD SWAP 
        IF 
            DROP _1ADD PUSH_OR(1) ; next odd number
        ELSE 
            NROT_NIP
        THEN
    REPEAT
    _2DROP 
SEMICOLON

SCOLON(_bench,( -- ))
    PUSH(10000) SFOR SI CALL(_decomp) SNEXT
SSEMICOLON
