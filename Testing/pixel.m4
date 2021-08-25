; vvvv
include(`../M4/FIRST.M4')dnl
; ^^^^
    ORG 32768  
    INIT(60000)
    ld  hl, stack_test
    push hl

    CALL(test)
    
    PRINT({"RAS:"})
    exx
    push HL
    exx
    pop HL
    DUP_UDOT
    ret
    
SCOLON(stack_test)
    PRINT({0xD, "Data stack OK!", 0xD})    
    STOP
SSEMICOLON

COLON(test)
; diagonala(y,x) 0,0 --> 99,99
    XDO(25700,0)  
        XI 
        PUTPIXEL 
        DROP
    PUSH_ADDXLOOP(256+1)
    
; horizontalni(y,x) 50,0 -> 50,199
    XDO(256*50+200,256*50)
        XI 
        PUTPIXEL 
        DROP
    XLOOP
    
; vertikalni(y,x) 0,200 -> 49,200
    XDO(256*50+200,200)
        XI 
        PUTPIXEL 
        DROP
    PUSH_ADDXLOOP(256)
    
SEMICOLON
