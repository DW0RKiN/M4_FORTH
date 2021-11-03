; vvvvv
include(`../M4/FIRST.M4')dnl
; ^^^^^
ORG 0x8000
    INIT(60000)
    ld  hl, stack_test
    push hl
    
    DVARIABLE(A_32,0x87432110)

    PUSHDOT(-7654321) _2DUP DDOT PUTCHAR('=') _2DUP UDDOT CR
    DABS DDOT CR
    
    
    PUSHDOT(0) 
         _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT PUTCHAR('+') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DADD _2DUP UDDOT CR
         _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB _2DUP UDDOT PUTCHAR('-') PUSHDOT(111111111) _2DUP UDDOT  PUTCHAR('=') CR
    DSUB UDDOT CR
    
    PRINT_Z({"min("}) PUSHDOT(123456789) _2DUP UDDOT PUTCHAR({','})
    PUSHDOT(123456788) _2DUP UDDOT PRINT_Z({")= ",0x0D}) 
    DMIN UDDOT CR
    PRINT_Z({"min("}) PUSHDOT(123456788) _2DUP UDDOT PUTCHAR({','})
    PUSHDOT(123456789) _2DUP UDDOT PRINT_Z({")= ",0x0D}) 
    DMIN UDDOT CR
    PRINT_Z({"max("}) PUSHDOT(123456789) _2DUP UDDOT PUTCHAR({','})
    PUSHDOT(123456788) _2DUP UDDOT PRINT_Z({")= ",0x0D}) 
    DMAX UDDOT CR
    PRINT_Z({"max("}) PUSHDOT(123456788) _2DUP UDDOT PUTCHAR({','})
    PUSHDOT(123456789) _2DUP UDDOT PRINT_Z({")= ",0x0D}) 
    DMAX UDDOT CR

    PRINT_Z({"min("}) PUSHDOT(500000) _2DUP DDOT PUTCHAR({','})
    PUSHDOT(100000) _2DUP DDOT PRINT_Z({")= "}) 
    DMIN DDOT CR
    PRINT_Z({"min("}) PUSHDOT(500000) _2DUP DDOT PUTCHAR({','})
    PUSHDOT(-100000) _2DUP DDOT PRINT_Z({")= "}) 
    DMIN DDOT CR
    PRINT_Z({"min("}) PUSHDOT(-500000) _2DUP DDOT PUTCHAR({','})
    PUSHDOT(100000) _2DUP DDOT PRINT_Z({")= "}) 
    DMIN DDOT CR
    PRINT_Z({"min("}) PUSHDOT(-500000) _2DUP DDOT PUTCHAR({','})
    PUSHDOT(-100000) _2DUP DDOT PRINT_Z({")= "}) 
    DMIN DDOT CR
    
    PRINT_Z({"max("}) PUSHDOT(500000) _2DUP DDOT PUTCHAR({','})
    PUSHDOT(100000) _2DUP DDOT PRINT_Z({")= "}) 
    DMAX DDOT CR
    PRINT_Z({"max("}) PUSHDOT(500000) _2DUP DDOT PUTCHAR({','})
    PUSHDOT(-100000) _2DUP DDOT PRINT_Z({")= "}) 
    DMAX DDOT CR
    PRINT_Z({"max("}) PUSHDOT(-500000) _2DUP DDOT PUTCHAR({','})
    PUSHDOT(100000) _2DUP DDOT PRINT_Z({")= "}) 
    DMAX DDOT CR
    PRINT_Z({"max("}) PUSHDOT(-500000) _2DUP DDOT PUTCHAR({','})
    PUSHDOT(-100000) _2DUP DDOT PRINT_Z({")= "}) 
    DMAX DDOT CR


    
    PRINT_Z({"RAS:"})
    exx
    push HL
    exx
    pop HL
    DUP_UDOT
    ret
    
SCOLON(stack_test)
    PRINT_Z({0xD, "Data stack OK!", 0xD})
    STOP
SSEMICOLON
