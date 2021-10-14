;vvvvv
include(`../M4/FIRST.M4')dnl
;^^^^^
ORG 0x8000
INIT(0xF500)

PUSH_FOR(7)
I
LO_CASE
    LO_OF(1) PRINT_Z(" one") LO_ENDOF
    LO_OF(2) PRINT_Z(" two") LO_ENDOF
    LO_WITHIN_OF(3,6) PRINT_Z(" 3..5") LO_ENDOF
    LO_OF(2) PRINT_Z(" six") LO_ENDOF
    DUP_DOT
LO_ENDCASE
DROP
NEXT
CR

PUSH2(0,1)
PUSH2(2,3)
PUSH2(4,5)
PUSH2(5+1*256,5+2*256)
PUSH2(5+4*256,5+5*256)
PUSH2(6,7)
PUSH2(8,9)

BEGIN
    SCALL(check_prime)
WHILE
REPEAT

STOP


SCOLON(check_prime)
    PRINT_Z({"lo("})
    CASE
        PUSH_OF(0)       PRINT_Z("zero")   ENDOF
        PUSH_OF(1)       PRINT_Z("one")    ENDOF
        PUSH_OF(2)       PRINT_Z("two")    ENDOF
        WITHIN_OF(3,7)   PRINT_Z("3..6")   ENDOF
        PUSH_OF(7)       PRINT_Z("seven")  ENDOF
        PUSH_OF(8)       PRINT_Z("eight")  ENDOF
        PUSH_OF(9)       PRINT_Z("nine")   ENDOF
        PUSH_OF(5+5*256) PRINT_Z("five+five*256") ENDOF
        DUP_DOT
    ENDCASE    PRINT_Z({")="})
    DUP PUSH_AND(255) DOT
    PRINT_Z({" is"})
    LO_CASE
        LO_OF(2)  LO_ENDOF
        LO_OF(3)  LO_ENDOF
        LO_OF(5)
            PRINT_Z({" a prime and high("})
            DUP
            CASE
                      ZERO_OF PRINT_Z("zero")   ENDOF
                _1SUB ZERO_OF PRINT_Z("one")    ENDOF
                _1SUB ZERO_OF PRINT_Z("two")    ENDOF
                _1SUB ZERO_OF PRINT_Z("three")  ENDOF
                _1SUB ZERO_OF PRINT_Z("four")   ENDOF
                _1SUB ZERO_OF PRINT_Z("five")   ENDOF
                _1SUB ZERO_OF PRINT_Z("six")    ENDOF
                _1SUB ZERO_OF PRINT_Z("seven")  ENDOF
                _1SUB ZERO_OF PRINT_Z("eight")  ENDOF
                _1SUB ZERO_OF PRINT_Z("nine")   ENDOF
                PUSH_ADD(9) DOT DUP
            ENDCASE
            DROP
            PRINT_Z({")="})            
            DUP _256UDIV DOT
            PRINT_Z({" is"})
            HI_CASE
                HI_OF(2)  HI_ENDOF
                HI_OF(3)  HI_ENDOF
                HI_OF(5)  HI_ENDOF
                HI_OF(7)  HI_ENDOF
                HI_OF(11) HI_ENDOF
                HI_OF(13) HI_ENDOF
                    PRINT_Z(" not")
            HI_ENDCASE
        LO_ENDOF
        LO_OF(7)  LO_ENDOF
        LO_OF(11) LO_ENDOF
        LO_OF(13) LO_ENDOF
            PRINT_Z(" not")
    LO_ENDCASE
    PRINT_Z(" a prime.")
    CR
SSEMICOLON
