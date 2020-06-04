; vvvv
include(`./FIRST.M4')dnl
; ^^^^
    ORG 32768  
    ld  hl, stack_test
    push hl
    INIT(60000)
    CALL(test)
    
    PRINT({"RAS:"})
    exx
    push HL
    exx
    pop HL
    DUP_UDOT
    STOP
    
SCOLON(stack_test)
    PRINT({0xD, "Data stack OK!", 0xD})    
SSEMICOLON

COLON(test)
; diagonala(y,x) 0,0 --> 99,99
    XDO(25700,0)  
        XI 
        PUTPIXEL 
        DROP
    XADDLOOP(256+1)
    
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
    XADDLOOP(256)
    
SEMICOLON
    
include({./LAST.M4})dnl
