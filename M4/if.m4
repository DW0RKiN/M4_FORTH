define(IF_COUNT,100)dnl
dnl
dnl
define(IF,{
define({IF_COUNT}, incr(IF_COUNT))dnl
pushdef({ELSE_STACK}, IF_COUNT)dnl
pushdef({THEN_STACK}, IF_COUNT)dnl
    ld    A, H          ; 1:4       if
    or    L             ; 1:4       if
    ex   DE, HL         ; 1:4       if
    pop  DE             ; 1:10      if
    jp    z, else{}IF_COUNT}    ; 3:10      if)dnl
dnl
define({ELSE},{
    jp   endif{}THEN_STACK       ; 3:10      else
else{}ELSE_STACK:popdef({ELSE_STACK})})dnl
dnl
define(THEN,{
ifelse(ELSE_STACK, THEN_STACK,{else{}ELSE_STACK  EQU $          ;           = endif
popdef({ELSE_STACK})})endif{}THEN_STACK:dnl
popdef({THEN_STACK})})dnl
dnl
dnl
