; vvvvv
include(`../M4/FIRST.M4')dnl
; ^^^^^
ORG 0x8000
    INIT(60000)
    SCALL(Init_stack_test)
        
    DVARIABLE(A_32,0x87432110)

    PRINT({"  unsigned 4287312975 = signed   -7654321", 0x0D}) 
    PUSHDOT(-7654321) 
       _2DUP DDOT PUTCHAR('=') _2DUP UDDOT CR
       PRINT({"test ABS: "}) DABS _2DUP DDOT CR
       PRINT({"test ABS: "}) DABS 
    DDOT CR
    
    SCALL(Check_stack)
    PRINT({"  number: "}) 
    PUSHDOT(0x0000FFFE)
      _2DUP DDOT CR
      PRINT({"test D1+: "}) D1ADD _2DUP DDOT CR
      PRINT({"test D1+: "}) D1ADD _2DUP DDOT CR
      PRINT({"test D1+: "}) D1ADD _2DUP DDOT CR
      PRINT({"test D1-: "}) D1SUB _2DUP DDOT CR
      PRINT({"test D1-: "}) D1SUB _2DUP DDOT CR
      PRINT({"test D1-: "}) D1SUB 
    DDOT CR    

    SCALL(Check_stack)
    PRINT({"  number: "}) 
    PUSHDOT(0xFFFFFFFE)
      _2DUP DDOT CR
      PRINT({"test D1+: "}) D1ADD _2DUP DDOT CR
      PRINT({"test D1+: "}) D1ADD _2DUP DDOT CR
      PRINT({"test D1+: "}) D1ADD _2DUP DDOT CR
      PRINT({"test D1-: "}) D1SUB _2DUP DDOT CR
      PRINT({"test D1-: "}) D1SUB _2DUP DDOT CR
      PRINT({"test D1-: "}) D1SUB 
    DDOT CR    
    
    SCALL(Check_stack)
    PRINT({"test D+:"})
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
      PRINT({"test D-:"})
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
      DSUB 
    UDDOT CR
    
    SCALL(Check_stack)
    PRINT_Z({"min("}) 
    PUSHDOT(123456789) 
      _2DUP UDDOT PUTCHAR({','})
      PUSHDOT(123456788) 
        _2DUP UDDOT PRINT_Z({")= ",0x0D}) 
      DMIN 
    UDDOT CR
    PRINT_Z({"min("}) 
    PUSHDOT(123456788) 
      _2DUP UDDOT PUTCHAR({','})
      PUSHDOT(123456789) 
        _2DUP UDDOT PRINT_Z({")= ",0x0D}) 
      DMIN 
    UDDOT CR
    PRINT_Z({"max("}) 
    PUSHDOT(123456789) 
      _2DUP UDDOT PUTCHAR({','})
      PUSHDOT(123456788) 
        _2DUP UDDOT PRINT_Z({")= ",0x0D}) 
      DMAX 
    UDDOT CR
    PRINT_Z({"max("}) 
    PUSHDOT(123456788) 
      _2DUP UDDOT PUTCHAR({','})
      PUSHDOT(123456789) 
        _2DUP UDDOT PRINT_Z({")= ",0x0D}) 
      DMAX 
    UDDOT CR

    SCALL(Check_stack)
    PUSHDOT(500000)
    PUSHDOT(100000)
    _4DUP
    PRINT_Z({"min("}) _4DUP DDOT PUTCHAR({','}) DDOT PRINT_Z({")="}) DMIN DDOT CR
    _4DUP DNEGATE
    PRINT_Z({"min("}) _4DUP DDOT PUTCHAR({','}) DDOT PRINT_Z({")="}) DMIN DDOT CR
    _4DUP _2SWAP DNEGATE _2SWAP
    PRINT_Z({"min("}) _4DUP DDOT PUTCHAR({','}) DDOT PRINT_Z({")="}) DMIN DDOT CR
    _4DUP _2SWAP DNEGATE _2SWAP DNEGATE
    PRINT_Z({"min("}) _4DUP DDOT PUTCHAR({','}) DDOT PRINT_Z({")="}) DMIN DDOT CR
    _4DUP
    PRINT_Z({"max("}) _4DUP DDOT PUTCHAR({','}) DDOT PRINT_Z({")="}) DMAX DDOT CR
    _4DUP DNEGATE
    PRINT_Z({"max("}) _4DUP DDOT PUTCHAR({','}) DDOT PRINT_Z({")="}) DMAX DDOT CR
    _4DUP _2SWAP DNEGATE _2SWAP
    PRINT_Z({"max("}) _4DUP DDOT PUTCHAR({','}) DDOT PRINT_Z({")="}) DMAX DDOT CR
    _4DUP _2SWAP DNEGATE _2SWAP DNEGATE
    PRINT_Z({"max("}) _4DUP DDOT PUTCHAR({','}) DDOT PRINT_Z({")="}) DMAX DDOT CR
    _2DROP _2DROP
    SCALL(Check_stack)

    exx
    push HL
    exx
    pop HL
    PRINT_Z({"RAS:"}) DUP_UDOT CR

    SCALL(Check_stack)
    STOP

SCOLON(Init_stack_test)
    push HL
    ld   HL, 0x0000
    add  HL, SP
    ld  (Check_stack_data), HL
    pop  HL
SSEMICOLON
    
SCOLON(Check_stack)
    push HL
    ld   HL, 0x0000
    add  HL, SP
    ld    B, H
    ld    C, L
Check_stack_data EQU $+1
    ld   HL, 0x0000
    or    A
    sbc  HL, BC             ; Ma byt, minus jest, nemohu se splest!
    PRINT_Z({"Stack contains"})
    DUP_DOT 
    PRINT_Z({" bytes", 0x0D})
    pop  HL
SSEMICOLON
