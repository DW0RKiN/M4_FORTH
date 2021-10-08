;vvvvv
include(`../M4/FIRST.M4')dnl
;^^^^^
ORG 0x8000
INIT(0xF500)

PUSH2(0,1)
PUSH2(2,3)
PUSH2(4,5)
PUSH2(5+1*256,5+2*256)
PUSH2(5+4*256,5+5*256)
PUSH2(6,7)
PUSH2(8,9)
PUSH2(10,11)

BEGIN
    SCALL(check_prime)
WHILE
REPEAT


STOP


SCOLON(check_prime)
    PRINT({"lo("})
    CASE
        PUSH_OF(0)  PRINT("zero")   ENDOF
        PUSH_OF(1)  PRINT("one")    ENDOF
        PUSH_OF(2)  PRINT("two")    ENDOF
        PUSH_OF(3)  PRINT("three")  ENDOF
        PUSH_OF(4)  PRINT("four")   ENDOF
        PUSH_OF(5)  PRINT("five")   ENDOF
        PUSH_OF(6)  PRINT("six")    ENDOF
        PUSH_OF(7)  PRINT("seven")  ENDOF
        PUSH_OF(8)  PRINT("eight")  ENDOF
        PUSH_OF(9)  PRINT("nine")   ENDOF
        PUSH_OF(10) PRINT("ten")    ENDOF
        PUSH_OF(11) PRINT("eleven") ENDOF
        PUSH_OF(12) PRINT("twelve") ENDOF
        PUSH_OF(5+5*256) PRINT("five+five*256") ENDOF
        DUP_DOT
    ENDCASE    PRINT({")="})
    DUP PUSH_AND(255) DOT
    PRINT({" is"})
    LO_CASE
        LO_OF(2)  LO_ENDOF
        LO_OF(3)  LO_ENDOF
        LO_OF(5)
            PRINT({" a prime and high("})
            DUP
            CASE
                      ZERO_OF PRINT("zero")   ENDOF
                _1SUB ZERO_OF PRINT("one")    ENDOF
                _1SUB ZERO_OF PRINT("two")    ENDOF
                _1SUB ZERO_OF PRINT("three")  ENDOF
                _1SUB ZERO_OF PRINT("four")   ENDOF
                _1SUB ZERO_OF PRINT("five")   ENDOF
                _1SUB ZERO_OF PRINT("six")    ENDOF
                _1SUB ZERO_OF PRINT("seven")  ENDOF
                _1SUB ZERO_OF PRINT("eight")  ENDOF
                _1SUB ZERO_OF PRINT("nine")   ENDOF
                _1SUB ZERO_OF PRINT("ten")    ENDOF
                _1SUB ZERO_OF PRINT("eleven") ENDOF
                _1SUB ZERO_OF PRINT("twelve") ENDOF
                PUSH_ADD(12) DOT DUP
            ENDCASE
            DROP
            PRINT({")="})            
            DUP _256UDIV DOT
            PRINT({" is"})
            HI_CASE
                HI_OF(2)  HI_ENDOF
                HI_OF(3)  HI_ENDOF
                HI_OF(5)  HI_ENDOF
                HI_OF(7)  HI_ENDOF
                HI_OF(11) HI_ENDOF
                HI_OF(13) HI_ENDOF
                    PRINT(" not")
            HI_ENDCASE
        LO_ENDOF
        LO_OF(7)  LO_ENDOF
        LO_OF(11) LO_ENDOF
        LO_OF(13) LO_ENDOF
            PRINT(" not")
    LO_ENDCASE
    PRINT(" a prime.")
    CR
SSEMICOLON
