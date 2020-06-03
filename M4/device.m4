dnl ## Device
dnl
dnl .
dnl ( x -- )
dnl print number
define(DOT,{ifdef({USE_S16},,define({USE_S16},{}))
    call PRINT_S16      ; 3:17      .})dnl
dnl
dnl u.
dnl ( x -- )
dnl print number
define(UDOT,{ifdef({USE_U16},,define({USE_U16},{}))
    call PRINT_U16      ; 3:17      .})dnl
dnl
dnl
dnl dup .
dnl ( x -- )
dnl non-destructively print number
define(DUP_DOT,{
    push HL             ; 1:11      dup .   x3 x1 x2 x1{}dnl
{}{}DOT
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1})dnl
dnl
dnl
dnl dup u.
dnl ( x -- )
dnl non-destructively print number
define(DUP_UDOT,{
    push HL             ; 1:11      dup .   x3 x1 x2 x1{}dnl
{}{}UDOT
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1})dnl
dnl
dnl
dnl .S
dnl ( x3 x2 x1 -- x3 x2 x1 )
dnl print 3 stack number 
define(DOTS,{
    ex  (SP), HL        ; 1:19      .S  ( x1 x2 x3 )
    push HL             ; 1:11      .S  ( x1 x3 x2 x3 ){}DOT                 
    push HL             ; 1:11      .S  ( x1 x2 x3 x2 ){}DOT                    
    ex  (SP), HL        ; 1:19      .S  ( x3 x2 x1 ){}DUP_DOT})dnl
dnl
dnl
dnl ( -- )
dnl new line
define(CR,{
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with 48K ROM in, this will print char in A})dnl
dnl
dnl
dnl ( 'a' -- )
dnl new line
define(EMIT,{
    ld    A, L          ; 1:4       emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      emit    with 48K ROM in, this will print char in A{}DROP})dnl
dnl
dnl
dnl ( -- )
dnl .( char )
define(PUTCHAR,{ifelse($2,{},,{
.error More parameters found in macro putchar, if you want to print a comma you have to write putchar({{,}})})
    ld    A, format({%-11s},{{$1}})  ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A})dnl
dnl
dnl
dnl ( addr n -- )
dnl print n chars from addr 
define(TYPE,{
ifdef({USE_TYPE},,define({USE_TYPE},{}))dnl
    call PRINT_STRING   ; 3:17      type
    pop  HL             ; 1:10      type
    pop  DE             ; 1:10      type})dnl
dnl
dnl
dnl ( addr n -- addr n )
dnl non-destructively print string 
define(_2DUP_TYPE,{
    push DE             ; 1:11      2dup
    push HL             ; 1:11      2dup{}TYPE
    pop  HL             ; 1:10      2dup
    pop  DE             ; 1:10      2dup})dnl
dnl
dnl
define(PRINT_COUNT,100)dnl
pushdef({ALL_STRING_STACK},{})dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- )
dnl print string
define(PRINT,{define({PRINT_COUNT}, incr(PRINT_COUNT))
    push DE             ; 1:11      print
    ld   BC, size{}PRINT_COUNT    ; 3:10      print Length of string to print
    ld   DE, string{}PRINT_COUNT  ; 3:10      print Address of string
    call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
    pop  DE             ; 1:10      print
pushdef({STRING_STACK},{$@})define({ALL_STRING_STACK},{string}PRINT_COUNT{:
db STRING_POP
size}PRINT_COUNT{ EQU $ - string}PRINT_COUNT
ALL_STRING_STACK)})dnl
dnl
dnl 
dnl ( -- key )
dnl readchar
define(KEY,{ifdef({USE_KEY},,define({USE_KEY},{}))
    call READKEY        ; 3:17      key})dnl
dnl
dnl
dnl 
dnl ( addr umax -- uloaded )
dnl readstring
define(ACCEPT,{ifdef({USE_ACCEPT},,define({USE_ACCEPT},{}))
    call READSTRING     ; 3:17      accept})dnl
dnl
dnl
dnl
