include(`../M4/FIRST.M4')dnl 
  ifdef __ORG
    org __ORG
  else
    org 24576
  endif
INIT(60000)
STRING_Z({"The five boxing wizards jump quickly."})
define({_TYP_DOUBLE},{fast})
PUSH_FOR(9999)
   DUP
   CALL(_pangram_)
   DROP
NEXT
CALL(_pangram_) SPACE_DOT CR  ;# -1
STOP
COLON(_pangram_,( addr -- ? )) 
  _1SUB
  PUSHDOT(0) 
  BEGIN
    ROT _1ADD NROT _2OVER NIP CFETCH _0CNE WHILE _2OVER NIP CFETCH
    PUSH(32) OR PUSH('a') SUB
    DUP PUSH2(0,26) WITHIN IF
      DBITSET
dnl #  _2OVER_NIP_CFETCH EMIT SPACE_2DUP_HEX_UDDOT CR
    ELSE DROP THEN
  REPEAT
  PUSHDOT(0x3FFFFFF) DEQ NIP SEMICOLON
