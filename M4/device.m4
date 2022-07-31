dnl ## Device
define({__},{})dnl
dnl
dnl .
dnl ( x -- )
dnl print space and 16 bit number
define({SPACE_DOT},{__def({USE_PRT_SP_S16})
    call PRT_SP_S16     ; 3:17      space .   ( s -- )})dnl
dnl
dnl
dnl .
dnl ( x -- )
dnl print 16 bit number
define({DOT},{__def({USE_PRT_S16})
    call PRT_S16        ; 3:17      .   ( s -- )})dnl
dnl
dnl
dnl u.
dnl ( u -- )
dnl print space and unsigned 16 bit number
define({SPACE_UDOT},{__def({USE_PRT_SP_U16})
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )})dnl
dnl
dnl
dnl u.
dnl ( u -- )
dnl print unsigned 16 bit number
define({UDOT},{__def({USE_PRT_U16})
    call PRT_U16        ; 3:17      u.   ( u -- )})dnl
dnl
dnl
dnl ------- zx rom routines ---------
dnl
dnl
dnl u.
dnl ( u -- )
dnl print spaces and unsigned 16 bit number
define({SPACE_UDOTZXROM},{__def({USE_ZXPRT_SP_U16})
    call ZXPRT_SP_U16   ; 3:17      space u.zxrom   ( u -- )})dnl
dnl
dnl u.
dnl ( u -- )
dnl print unsigned 16 bit number
define({UDOTZXROM},{__def({USE_ZXPRT_U16})
    call ZXPRT_U16      ; 3:17      u.zxrom   ( u -- )})dnl
dnl
dnl
dnl dup u.
dnl ( u -- u )
dnl dup and print space and unsigned 16 bit number
define({DUP_SPACE_UDOTZXROM},{__def({USE_DUP_ZXPRT_SP_U16})
    call DUP_ZXPRT_SP_U16; 3:17      dup space u.zxrom   ( u -- u )})dnl
dnl
dnl
dnl dup u.
dnl ( u -- u )
dnl dup and print unsigned 16 bit number
define({DUP_UDOTZXROM},{__def({USE_DUP_ZXPRT_U16})
    call DUP_ZXPRT_U16  ; 3:17      dup u.zxrom   ( u -- u )})dnl
dnl
dnl
dnl .
dnl ( x -- )
dnl print space and 16 bit number
define({SPACE_DOTZXROM},{__def({USE_ZXPRT_SP_S16})
    call ZXPRT_SP_S16   ; 3:17      space .zxrom   ( x -- )})dnl
dnl
dnl .
dnl ( x -- )
dnl print 16 bit number
define({DOTZXROM},{__def({USE_ZXPRT_S16})
    call ZXPRT_S16      ; 3:17      .zxrom   ( x -- )})dnl
dnl
dnl ----------------------
dnl
dnl dup .
dnl ( x -- )
dnl print space and non-destructively number
define({DUP_SPACE_DOT},{
    push HL             ; 1:11      dup space .   x3 x1 x2 x1{}dnl
__{}SPACE_DOT
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1})dnl
dnl
dnl
dnl dup .
dnl ( x -- )
dnl non-destructively print number
define({DUP_DOT},{
    push HL             ; 1:11      dup .   x3 x1 x2 x1{}dnl
__{}DOT
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1})dnl
dnl
dnl
dnl dup u.
dnl ( x -- )
dnl print space and non-destructively number
define({DUP_SPACE_UDOT},{
    push HL             ; 1:11      dup space u.   x3 x1 x2 x1{}dnl
__{}SPACE_UDOT
    ex   DE, HL         ; 1:4       dup space u.   x3 x2 x1})dnl
dnl
dnl
dnl dup u. bs
dnl ( x -- )
dnl non-destructively print number
define({DUP_UDOT},{
    push HL             ; 1:11      dup u.   x3 x1 x2 x1{}dnl
__{}UDOT
    ex   DE, HL         ; 1:4       dup u.   x3 x2 x1})dnl
dnl
dnl
dnl
dnl d.
dnl ( d -- )
dnl print space and 32 bit number
define({SPACE_DDOT},{__def({USE_PRT_SP_S32})
    call PRT_SP_S32     ; 3:17      space d.   ( d -- )})dnl
dnl
dnl
dnl d.
dnl ( d -- )
dnl print 32 bit number
define({DDOT},{__def({USE_PRT_S32})
    call PRT_S32        ; 3:17      d.   ( d -- )})dnl
dnl
dnl
dnl
dnl ud.
dnl ( ud -- )
dnl print space and unsigned 32 bit number
define({SPACE_UDDOT},{__def({USE_PRT_SP_U32})
    call PRT_SP_U32     ; 3:17      space ud.   ( ud -- )})dnl
dnl
dnl
dnl ud.
dnl ( ud -- )
dnl print unsigned 32 bit number
define({UDDOT},{__def({USE_PRT_U32})
    call PRT_U32        ; 3:17      ud.   ( ud -- )})dnl
dnl
dnl
dnl
dnl .S
dnl ( x3 x2 x1 -- x3 x2 x1 )
dnl print 3 stack number
define({DOTS},{
    ex  (SP), HL        ; 1:19      .S  ( x1 x2 x3 )
    push HL             ; 1:11      .S  ( x1 x3 x2 x3 )
__{}DOT
    push HL             ; 1:11      .S  ( x1 x2 x3 x2 )
__{}SPACE_DOT
    ex  (SP), HL        ; 1:19      .S  ( x3 x2 x1 )
__{}DUP_SPACE_DOT})dnl
dnl
dnl
dnl ( -- )
dnl new line
define({CR},{
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with {48K ROM} in, this will print char in A})dnl
dnl
dnl
dnl ( 'a' -- )
dnl print char 'a'
define({EMIT},{
    ld    A, L          ; 1:4       emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      emit    with {48K ROM} in, this will print char in A{}dnl
__{}DROP})dnl
dnl
dnl
dnl ( 'a' -- 'a' )
dnl print char 'a'
define({DUP_EMIT},{
    ld    A, L          ; 1:4       dup emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      dup emit    with {48K ROM} in, this will print char in A})dnl
dnl
dnl
dnl ( addr -- addr )
dnl print char from address
define({DUP_FETCH_EMIT},{
    ld    A,(HL)        ; 1:7       dup @ emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      dup @ emit    with {48K ROM} in, this will print char in A})dnl
dnl
dnl
dnl ( -- )
dnl print space
define({SPACE},{
    ld    A, 0x20       ; 2:7       space   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      space   with {48K ROM} in, this will print space})dnl
dnl
dnl
dnl ( -- )
dnl .( char )
define({PUTCHAR},{ifelse($2,{},,{
.error More parameters found in macro putchar, if you want to print a comma you have to write putchar({{,}})})
    ld    A, format({%-11s},{{$1}})  ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with {ZX 48K ROM}})dnl
dnl
dnl
dnl ( -- )
dnl .( char )
define({PUSH_EMIT},{ifelse($2,{},,{
.error More parameters found in macro putchar, if you want to print a comma you have to write putchar({{,}})})
    ld    A, format({%-11s},{{$1}})  ; 2:7       $1 emit  push_emit($1)   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      $1 emit  push_emit($1)   putchar(reg A) with {ZX 48K ROM}})dnl
dnl
dnl
dnl ( addr n -- )
dnl print n chars from addr
define({TYPE},{
__{}define({USE_TYPE},{})dnl
    call PRINT_TYPE     ; 3:17      type   ( addr n -- )})dnl
dnl
dnl
dnl ( addr n -- addr n )
dnl non-destructively print string
define({_2DUP_TYPE},{
    push DE             ; 1:11      2dup type   ( addr n -- addr n )
    ld    B, H          ; 1:4       2dup type
    ld    C, L          ; 1:4       2dup type   BC = length of string to print
    call 0x203C         ; 3:17      2dup type   Use {ZX 48K ROM} for print string
    pop  DE             ; 1:10      2dup type})dnl
dnl
dnl
dnl ( addr -- )
dnl print stringZ
define({TYPE_Z},{
__{}define({USE_TYPE_Z},{})dnl
    call PRINT_TYPE_Z   ; 3:17      type_z   ( addr -- )
    ex   DE, HL         ; 1:4       type_z
    pop  DE             ; 1:10      type_z})dnl
dnl
dnl
dnl ( -- )  $1 = addr
dnl print stringZ
define({PUSH_TYPE_Z},{
__{}define({USE_STRING_Z},{})dnl
    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 type_z   ( -- )
    call PRINT_STRING_Z ; 3:17      $1 type_z})dnl
dnl
dnl
dnl ( addr -- addr )
dnl non-destructively print stringZ
define({DUP_TYPE_Z},{
__{}define({USE_TYPE_Z},{})dnl
    call PRINT_TYPE_Z   ; 3:17      dup type_z   ( addr -- addr )})dnl
dnl
dnl
define({RECURSIVE_REVERSE_STACK},{ifdef({STRING_NUM_STACK},{dnl
__{}pushdef({REVERSE_NUM_STACK},⸨STRING_NUM_STACK⸩)dnl
__{}pushdef({REVERSE_STACK},⸨STRING_STACK⸩)dnl
__{}popdef({STRING_NUM_STACK})dnl
__{}popdef({STRING_STACK})dnl
__{}RECURSIVE_REVERSE_STACK})})dnl
dnl
dnl
dnl
define({RECURSIVE_COPY_STACK},{ifdef({REVERSE_NUM_STACK},{dnl
__{}changequote({⸨}, {⸩})dnl
__⸨⸩pushdef(⸨STRING_NUM_STACK⸩,{REVERSE_NUM_STACK})dnl
__⸨⸩pushdef(⸨TEMP_NUM_STACK⸩,{{REVERSE_NUM_STACK}})dnl
__⸨⸩pushdef(⸨STRING_STACK⸩,{REVERSE_STACK})dnl
__⸨⸩pushdef(⸨TEMP_STACK⸩,{{REVERSE_STACK}})dnl
__⸨⸩popdef(⸨REVERSE_NUM_STACK⸩)dnl
__⸨⸩popdef(⸨REVERSE_STACK⸩)dnl
__⸨⸩changequote(⸨{⸩, ⸨}⸩)dnl
__{}RECURSIVE_COPY_STACK})})dnl
dnl
dnl
dnl
define({RECURSIVE_CHECK_STACK},{dnl
__{}ifdef({TEMP_NUM_STACK},{dnl
__{}__{}ifelse(TEMP_STACK,{$1},{dnl
__{}__{}__{}define({TEMP_FOUND},TEMP_NUM_STACK)}dnl
__{}__{},{dnl
__{}__{}__{}popdef({TEMP_NUM_STACK}){}popdef({TEMP_STACK}){}RECURSIVE_CHECK_STACK({$1})dnl
__{}__{}})dnl
__{}})dnl
})dnl
dnl
dnl
dnl
define({PRINT_STRING_STACK},{ifdef({STRING_NUM_STACK},{
__{}string{}STRING_NUM_STACK:
__{}db STRING_STACK
__{}size{}STRING_NUM_STACK EQU $ - string{}STRING_NUM_STACK{}dnl
__{}popdef({STRING_NUM_STACK}){}popdef({STRING_STACK}){}PRINT_STRING_STACK})})dnl
dnl
dnl
dnl
define({SEARCH_FOR_MATCHING_STRING},{dnl
__{}undefine({REVERSE_STACK})dnl
__{}undefine({REVERSE_NUM_STACK})dnl
__{}define({TEMP_FOUND},PRINT_COUNT)dnl
__{}RECURSIVE_REVERSE_STACK{}dnl
__{}RECURSIVE_COPY_STACK{}dnl
__{}RECURSIVE_CHECK_STACK({$1}){}dnl
})dnl
dnl
dnl
dnl
define({PRINT_COUNT},100)dnl
pushdef({ALL_STRING_STACK},{})dnl
dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- )
dnl print string
define({PRINT},{define({PRINT_COUNT}, incr(PRINT_COUNT)){}SEARCH_FOR_MATCHING_STRING({{$*}}){}ifelse({$#},1,,{
    .error {$0}({$@}): Text containing a comma and not closed in {{}}. {$0}($*) --> {$0}({{$*}})})
    push DE             ; 1:11      print     {$*}
    ld   BC, size{}TEMP_FOUND    ; 3:10      print     Length of string{}TEMP_FOUND{}ifelse(eval(TEMP_FOUND<PRINT_COUNT),1,{ == string{}PRINT_COUNT})
    ld   DE, string{}TEMP_FOUND  ; 3:10      print     Address of string{}TEMP_FOUND{}ifelse(eval(TEMP_FOUND<PRINT_COUNT),1,{ == string{}PRINT_COUNT})
    call 0x203C         ; 3:17      print     Print our string with {ZX 48K ROM}
    pop  DE             ; 1:10      print{}dnl
__{}ifelse(TEMP_FOUND,PRINT_COUNT,{dnl
__{}__{}pushdef({STRING_STACK},{{$*}}){}pushdef({STRING_NUM_STACK},PRINT_COUNT)}){}dnl
})dnl
dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- )
dnl print null-terminated string
define({_PRINT_Z},{define({USE_STRING_Z},{})define({PRINT_COUNT}, incr(PRINT_COUNT)){}SEARCH_FOR_MATCHING_STRING({{$*}})
    ld   BC, string{}TEMP_FOUND  ; 3:10      print_z   Address of null-terminated string{}TEMP_FOUND{}ifelse(eval(TEMP_FOUND<PRINT_COUNT),1,{ == string{}PRINT_COUNT})
    call PRINT_STRING_Z ; 3:17      print_z{}dnl
__{}ifelse(TEMP_FOUND,PRINT_COUNT,{dnl
__{}__{}pushdef({STRING_STACK},{{$*}}){}pushdef({STRING_NUM_STACK},PRINT_COUNT)}){}dnl
})dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- )
dnl print null-terminated string
define({PRINT_Z},{_PRINT_Z({$1, 0x00})})dnl
dnl
dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- )
dnl print string ending with inverted most significant bit
define({_PRINT_I},{define({USE_STRING_I},{})define({PRINT_COUNT}, incr(PRINT_COUNT)){}SEARCH_FOR_MATCHING_STRING({{$*}})
    ld   BC, string{}TEMP_FOUND  ; 3:10      print_i   Address of string{}TEMP_FOUND ending with inverted most significant bit{}ifelse(eval(TEMP_FOUND<PRINT_COUNT),1,{ == string{}PRINT_COUNT})
    call PRINT_STRING_I ; 3:17      print_i{}dnl
__{}ifelse(TEMP_FOUND,PRINT_COUNT,{dnl
__{}__{}pushdef({STRING_STACK},{{$*}}){}pushdef({STRING_NUM_STACK},PRINT_COUNT)}){}dnl
})dnl
dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- )
dnl print string ending with inverted most significant bit
define({PRINT_I},{dnl
__{}ifelse(dnl
__{}regexp({$*},{^\(.*\)\("[^"]"\)\s*$},{{"text","x"}}),{"text","x"},
__{}__{}{_PRINT_I(regexp({$*},{^\(.*\)\("[^"]"\)\s*$},{{\1\2 + 0x80}}))},
__{}regexp({$*},{"\s*$},{"text"}),{"text"},
__{}__{}{_PRINT_I(regexp({$*},{^\(.+\)\(.\)"\s*$},{{\1","\2"+0x80}}))},
__{}{dnl
__{}__{}_PRINT_I(regexp({$*},{^\(.+\)"\([^"]+[^" ]\)\s*$},{{\1"\2 + 0x80}})){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
dnl s" string"
dnl ( -- addr n )
dnl addr = address string, n = lenght(string)
define({STRING},{define({PRINT_COUNT}, incr(PRINT_COUNT)){}SEARCH_FOR_MATCHING_STRING({{$*}}){}ifelse({$#},1,,{
    .error {$0}({$@}): Text containing a comma and not closed in {{}}. {$0}($*) --> {$0}({{$*}})})
    push DE             ; 1:11      string    ( -- addr size )
    push HL             ; 1:11      string    {$*}
    ld   DE, string{}TEMP_FOUND  ; 3:10      string    Address of string{}TEMP_FOUND{}ifelse(eval(TEMP_FOUND<PRINT_COUNT),1,{ == string{}PRINT_COUNT})
    ld   HL, size{}TEMP_FOUND    ; 3:10      string    Length of string{}TEMP_FOUND{}ifelse(eval(TEMP_FOUND<PRINT_COUNT),1,{ == string{}PRINT_COUNT}){}dnl
__{}ifelse(TEMP_FOUND,PRINT_COUNT,{dnl
__{}__{}pushdef({STRING_STACK},{{$*}}){}pushdef({STRING_NUM_STACK},PRINT_COUNT)}){}dnl
})dnl
dnl
dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- addr )
dnl store null-terminated string
define({_STRING_Z},{define({USE_STRING_Z},{})define({PRINT_COUNT}, incr(PRINT_COUNT)){}SEARCH_FOR_MATCHING_STRING({{$*}})
    push DE             ; 1:11      string_z   ( -- addr )
    ex   DE, HL         ; 1:4       string_z   {$*}
    ld   HL, string{}TEMP_FOUND  ; 3:10      string_z   Address of null-terminated string{}TEMP_FOUND{}ifelse(eval(TEMP_FOUND<PRINT_COUNT),1,{ == string{}PRINT_COUNT}){}dnl
__{}ifelse(TEMP_FOUND,PRINT_COUNT,{dnl
__{}__{}pushdef({STRING_STACK},{{$*}}){}pushdef({STRING_NUM_STACK},PRINT_COUNT)}){}dnl
})dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- addr )
dnl store null-terminated string
define({STRING_Z},{_STRING_Z({$*, 0x00})})dnl
dnl
dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- addr )
dnl store inverted_msb-terminated string
define({_STRING_I},{define({USE_STRING_I},{})define({PRINT_COUNT}, incr(PRINT_COUNT)){}SEARCH_FOR_MATCHING_STRING({{$*}})
    push DE             ; 1:11      string_i   ( -- addr )
    ex   DE, HL         ; 1:4       string_i   {$*}
    ld   HL, string{}TEMP_FOUND  ; 3:10      string_i   Address of null-terminated string{}TEMP_FOUND{}ifelse(eval(TEMP_FOUND<PRINT_COUNT),1,{ == string{}PRINT_COUNT}){}dnl
__{}ifelse(TEMP_FOUND,PRINT_COUNT,{dnl
__{}__{}pushdef({STRING_STACK},{{$*}}){}pushdef({STRING_NUM_STACK},PRINT_COUNT)}){}dnl
})dnl
dnl
dnl
dnl ." string"
dnl .( string)
dnl ( -- addr )
dnl store inverted_msb-terminated string
define({STRING_I},{dnl
__{}ifelse(dnl
__{}regexp({$*},{^\(.*\)\("[^"]"\)\s*$},{{"text","x"}}),{"text","x"},
__{}__{}{_STRING_I(regexp({$*},{^\(.*\)\("[^"]"\)\s*$},{{\1",\2 + 0x80}}))},
__{}regexp({$*},{"\s*$},{"text"}),{"text"},
__{}__{}{_STRING_I(regexp({$*},{^\(.+\)\(.\)"\s*$},{{\1","\2"+0x80}}))},
__{}{dnl
__{}__{}_STRING_I(regexp({$*},{^\(.+\)"\([^"]+[^" ]\)\s*$},{{\1"\2 + 0x80}})){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
dnl ( -- )
dnl Clear key buff
define({CLEARKEY},{ifdef({USE_CLEARKEY},,define({USE_CLEARKEY},{}))
    call CLEARBUFF      ; 3:17      clearkey})dnl
dnl
dnl
dnl
dnl ( -- key )
dnl readchar
define({KEY},{ifdef({USE_KEY},,define({USE_KEY},{}))
    call READKEY        ; 3:17      key})dnl
dnl
dnl
dnl
dnl ( -- flag )
dnl key?
define({KEYQUESTION},{
    ex   DE, HL         ; 1:4       key?
    push HL             ; 1:11      key?
    ld    A,(0x5C08)    ; 3:13      key?   read new value of {LAST K}
    add   A, 0xFF       ; 2:7       key?   carry if non zero value
    sbc  HL, HL         ; 2:15      key?})dnl
dnl
dnl
dnl
dnl ( addr umax -- uloaded )
dnl readstring
define({ACCEPT},{ifdef({USE_ACCEPT},,define({USE_ACCEPT},{}))
    call READSTRING     ; 3:17      accept})dnl
dnl
dnl
dnl ( addr umax -- uloaded )
dnl readstring
define({ACCEPT_Z},{ifdef({USE_ACCEPT},,define({USE_ACCEPT},{})){}ifdef({USE_ACCEPT_Z},,define({USE_ACCEPT_Z},{}))
    call READSTRING     ; 3:17      accept_z})dnl
dnl
dnl
dnl
