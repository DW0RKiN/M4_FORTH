dnl ## Device
define({__},{})dnl
dnl
dnl
dnl # . bs
dnl # ( x -- )
dnl # prints a 16-bit number with no spaces
define({DOT},{__def({USE_PRT_S16})
    call PRT_S16        ; 3:17      .   ( s -- )})dnl
dnl
dnl
dnl # dup . bs
dnl # ( x -- x )
dnl # prints without deletion a 16-bit number without spaces
define({DUP_DOT},{
    push HL             ; 1:11      dup .   x3 x1 x2 x1{}dnl
__{}DOT
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1})dnl
dnl
dnl
dnl # u. bs
dnl # ( u -- )
dnl # prints a 16-bit unsigned number with no spaces
define({UDOT},{__def({USE_PRT_U16})
    call PRT_U16        ; 3:17      u.   ( u -- )})dnl
dnl
dnl
dnl # dup u. bs
dnl # ( u -- u )
dnl # prints without deletion a 16-bit unsigned number without spaces
define({DUP_UDOT},{
    push HL             ; 1:11      dup u.   x3 x1 x2 x1{}dnl
__{}UDOT
    ex   DE, HL         ; 1:4       dup u.   x3 x2 x1})dnl
dnl
dnl
dnl # space . bs
dnl # ( x -- )
dnl # prints a space and a 16-bit number
define({SPACE_DOT},{__def({USE_PRT_SP_S16})
    call PRT_SP_S16     ; 3:17      space .   ( s -- )})dnl
dnl
dnl
dnl # dup space . bs
dnl # ( x -- x )
dnl # prints a space and without deletion a 16-bit number
define({DUP_SPACE_DOT},{
    push HL             ; 1:11      dup space .   x3 x1 x2 x1{}dnl
__{}SPACE_DOT
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1})dnl
dnl
define({SPACE_DUP_DOT},{DUP_SPACE_DOT}){}dnl
dnl
dnl
dnl # space u. bs
dnl # ( u -- )
dnl # prints a space and a 16-bit number
define({SPACE_UDOT},{__def({USE_PRT_SP_U16})
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )})dnl
dnl
dnl
dnl # space dup u. bs
dnl # ( u -- u )
dnl # print space and non-destructively number
define({DUP_SPACE_UDOT},{
    push HL             ; 1:11      dup space u.   x3 x1 x2 x1{}dnl
__{}SPACE_UDOT
    ex   DE, HL         ; 1:4       dup space u.   x3 x2 x1})dnl
dnl
define({SPACE_DUP_UDOT},{DUP_SPACE_UDOT}){}dnl
dnl
dnl
dnl # hex u. bs
dnl # ( u -- )
dnl # prints a 16-bit unsigned hex number with no spaces
define({HEX_UDOT},{__def({USE_PRT_HEX_U16})
    call PRT_HEX_U16    ; 3:17      hex u.   ( u -- )
    pop  HL             ; 1:10      hex u.
    pop  DE             ; 1:10      hex u.})dnl
dnl
dnl
dnl # dup hex u. bs
dnl # ( u -- u )
dnl # prints without deletion a 16-bit unsigned hex number with no spaces
define({DUP_HEX_UDOT},{__def({USE_PRT_HEX_U16})
    call PRT_HEX_U16    ; 3:17      dup hex u.   ( u -- u )})dnl
dnl
define({HEX_DUP_UDOT},{DUP_HEX_UDOT}){}dnl
dnl
dnl
dnl # space hex u. bs
dnl # ( u -- )
dnl # prints a space and a 16-bit unsigned hex number
define({SPACE_HEX_UDOT},{__def({USE_PRT_SP_HEX_U16})
    call PRT_SP_HEX_U16 ; 3:17      space hex u.   ( u -- )
    pop  HL             ; 1:10      space hex u.
    pop  DE             ; 1:10      space hex u.})dnl
dnl
define({HEX_SPACE_UDOT},{SPACE_HEX_UDOT}){}dnl
dnl
dnl # space dup hex u. bs
dnl # ( u -- u )
dnl # prints a space and without deletion a 16-bit unsigned hex number
define({SPACE_DUP_HEX_UDOT},{__def({USE_PRT_SP_HEX_U16})
    call PRT_SP_HEX_U16 ; 3:17      space dup hex u.   ( u -- u )})dnl
dnl
define({SPACE_HEX_DUP_UDOT},{SPACE_DUP_HEX_UDOT}){}dnl
define({DUP_SPACE_HEX_UDOT},{SPACE_DUP_HEX_UDOT}){}dnl
define({DUP_HEX_SPACE_UDOT},{SPACE_DUP_HEX_UDOT}){}dnl
define({HEX_SPACE_DUP_UDOT},{SPACE_DUP_HEX_UDOT}){}dnl
define({HEX_DUP_SPACE_UDOT},{SPACE_DUP_HEX_UDOT}){}dnl
dnl
dnl # -------vvv zx rom routines vvv---------
dnl
dnl
dnl # u.
dnl # ( u -- )
dnl # print spaces and unsigned 16-bit number
define({SPACE_UDOTZXROM},{__def({USE_ZXPRT_SP_U16})
    call ZXPRT_SP_U16   ; 3:17      space u.zxrom   ( u -- )})dnl
dnl
dnl # u.
dnl # ( u -- )
dnl # print unsigned 16-bit number
define({UDOTZXROM},{__def({USE_ZXPRT_U16})
    call ZXPRT_U16      ; 3:17      u.zxrom   ( u -- )})dnl
dnl
dnl
dnl # dup u.
dnl # ( u -- u )
dnl # dup and print space and unsigned 16-bit number
define({DUP_SPACE_UDOTZXROM},{__def({USE_DUP_ZXPRT_SP_U16})
    call DUP_ZXPRT_SP_U16; 3:17      dup space u.zxrom   ( u -- u )})dnl
dnl
dnl
dnl # dup u.
dnl # ( u -- u )
dnl # dup and print unsigned 16-bit number
define({DUP_UDOTZXROM},{__def({USE_DUP_ZXPRT_U16})
    call DUP_ZXPRT_U16  ; 3:17      dup u.zxrom   ( u -- u )})dnl
dnl
dnl
dnl # .
dnl # ( x -- )
dnl # print space and 16-bit number
define({SPACE_DOTZXROM},{__def({USE_ZXPRT_SP_S16})
    call ZXPRT_SP_S16   ; 3:17      space .zxrom   ( x -- )})dnl
dnl
dnl # .
dnl # ( x -- )
dnl # print 16-bit number
define({DOTZXROM},{__def({USE_ZXPRT_S16})
    call ZXPRT_S16      ; 3:17      .zxrom   ( x -- )})dnl
dnl
dnl # -------^^^ zx rom routines ^^^---------
dnl
dnl # -------------- 32-bit number --------------
dnl
dnl
dnl # d. bs
dnl # ( d -- )
dnl # prints a 32-bit number with no spaces
define({DDOT},{__def({USE_PRT_S32})
    call PRT_S32        ; 3:17      d.   ( d -- )})dnl
dnl
dnl # space d. bs
dnl # ( d -- )
dnl # prints a space and a 32-bit number
define({SPACE_DDOT},{__def({USE_PRT_SP_S32})
    call PRT_SP_S32     ; 3:17      space d.   ( d -- )})dnl
dnl
dnl
dnl # ud. bs
dnl # ( ud -- )
dnl # prints a 32-bit unsigned number with no spaces
define({UDDOT},{__def({USE_PRT_U32})
    call PRT_U32        ; 3:17      ud.   ( ud -- )})dnl
dnl
dnl
dnl # space ud. bs
dnl # ( ud -- )
dnl # prints a space and a 32-bit unsigned number
define({SPACE_UDDOT},{__def({USE_PRT_SP_U32})
    call PRT_SP_U32     ; 3:17      space ud.   ( ud -- )})dnl
dnl
dnl
dnl # hex ud.
dnl # ( ud -- )
dnl # prints a 32-bit unsigned hex number with no spaces
define({HEX_UDDOT},{__def({USE_PRT_HEX_U32})
    call PRT_HEX_U32    ; 3:17      hex ud.   ( ud -- )
    pop  HL             ; 1:10      hex ud.
    pop  DE             ; 1:10      hex ud.})dnl
dnl
dnl
dnl # 2dup hex ud.
dnl # ( ud -- ud )
dnl # prints without deletion a 32-bit unsigned hex number with no spaces
define({_2DUP_HEX_UDDOT},{__def({USE_PRT_HEX_U32})
    call PRT_HEX_U32    ; 3:17      2dup hex ud.   ( ud -- ud )})dnl
dnl
define({HEX_2DUP_UDDOT},{_2DUP_HEX_UDDOT}){}dnl
dnl
dnl
dnl # space hex ud. bs
dnl # ( ud -- )
dnl # prints space and a 32-bit unsigned hex number
define({SPACE_HEX_UDDOT},{__def({USE_PRT_SP_HEX_U32})
    call PRT_SP_HEX_U32 ; 3:17      space hex ud.   ( ud -- )
    pop  HL             ; 1:10      space hex ud.
    pop  DE             ; 1:10      space hex ud.})dnl
dnl
define({HEX_SPACE_UDDOT},{SPACE_HEX_UDDOT}){}dnl
dnl
dnl
dnl # space 2dup hex ud. bs
dnl # ( ud -- ud )
dnl # prints space and without deletion a 32-bit unsigned hex number
define({SPACE_2DUP_HEX_UDDOT},{__def({USE_PRT_SP_HEX_U32})
    call PRT_SP_HEX_U32 ; 3:17      space 2dup hex ud.   ( ud -- ud )})dnl
dnl
define({SPACE_HEX_2DUP_UDDOT},{SPACE_2DUP_HEX_UDDOT}){}dnl
define({HEX_SPACE_2DUP_UDDOT},{SPACE_2DUP_HEX_UDDOT}){}dnl
define({HEX_2DUP_SPACE_UDDOT},{SPACE_2DUP_HEX_UDDOT}){}dnl
define({_2DUP_HEX_SPACE_UDDOT},{SPACE_2DUP_HEX_UDDOT}){}dnl
define({_2DUP_SPACE_HEX_UDDOT},{SPACE_2DUP_HEX_UDDOT}){}dnl
dnl
dnl # -------------------------------------------
dnl
dnl # .S
dnl # ( x3 x2 x1 -- x3 x2 x1 )
dnl # print 3 stack number
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
dnl # ( -- )
dnl # new line
define({CR},{
    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with {48K ROM} in, this will print char in A})dnl
dnl
dnl
dnl # ( 'a' -- )
dnl # print char 'a'
define({EMIT},{
    ld    A, L          ; 1:4       emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      emit    with {48K ROM} in, this will print char in A{}dnl
__{}DROP})dnl
dnl
dnl
dnl # ( 'a' -- 'a' )
dnl # print char 'a'
define({DUP_EMIT},{
    ld    A, L          ; 1:4       dup emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      dup emit    with {48K ROM} in, this will print char in A})dnl
dnl
dnl
dnl # ( addr -- addr )
dnl # print char from address
define({DUP_FETCH_EMIT},{
    ld    A,(HL)        ; 1:7       dup @ emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      dup @ emit    with {48K ROM} in, this will print char in A})dnl
dnl
dnl
dnl # ( -- )
dnl # print space
define({SPACE},{
    ld    A, 0x20       ; 2:7       space   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      space   with {48K ROM} in, this will print space})dnl
dnl
dnl
dnl # ( -- )
dnl # .( char )
define({PUTCHAR},{ifelse($2,{},,{
.error More parameters found in macro putchar, if you want to print a comma you have to write putchar({{,}})})
    ld    A, format({%-11s},{{$1}})  ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar(reg A) with {ZX 48K ROM}})dnl
dnl
dnl
dnl # ( -- )
dnl # .( char )
define({PUSH_EMIT},{ifelse($2,{},,{
.error More parameters found in macro putchar, if you want to print a comma you have to write putchar({{,}})})
    ld    A, format({%-11s},{{$1}})  ; 2:7       $1 emit  push_emit($1)   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      $1 emit  push_emit($1)   putchar(reg A) with {ZX 48K ROM}})dnl
dnl
dnl
dnl # ( addr n -- )
dnl # print n chars from addr
define({TYPE},{
__{}define({USE_TYPE},{})dnl
    call PRINT_TYPE     ; 3:17      type   ( addr n -- )})dnl
dnl
dnl
dnl # ( addr n -- addr n )
dnl # non-destructively print string
define({_2DUP_TYPE},{
    push DE             ; 1:11      2dup type   ( addr n -- addr n )
    ld    B, H          ; 1:4       2dup type
    ld    C, L          ; 1:4       2dup type   BC = length of string to print
    call 0x203C         ; 3:17      2dup type   Use {ZX 48K ROM} for print string
    pop  DE             ; 1:10      2dup type})dnl
dnl
dnl
dnl # ( addr -- )
dnl # print stringZ
define({TYPE_Z},{
__{}define({USE_TYPE_Z},{})dnl
    call PRINT_TYPE_Z   ; 3:17      type_z   ( addr -- )
    ex   DE, HL         ; 1:4       type_z
    pop  DE             ; 1:10      type_z})dnl
dnl
dnl
dnl # ( -- )  $1 = addr
dnl # print stringZ
define({PUSH_TYPE_Z},{ifelse($1,{},{
__{}__{}    .error {$0}(): Missing parameter!},
{define({USE_PRINT_Z},{})
    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 type_z   ( -- )
    call PRINT_STRING_Z ; 3:17      $1 type_z})})dnl
dnl
dnl
dnl # ( addr -- addr )
dnl # non-destructively print stringZ
define({DUP_TYPE_Z},{
__{}define({USE_TYPE_Z},{})dnl
    call PRINT_TYPE_Z   ; 3:17      dup type_z   ( addr -- addr )})dnl
dnl
dnl
dnl # ( addr -- )
dnl # print inverted_msb-terminated string
define({TYPE_I},{
__{}define({USE_TYPE_I},{})dnl
    call PRINT_TYPE_I   ; 3:17      type_i   ( addr -- )
    ex   DE, HL         ; 1:4       type_i
    pop  DE             ; 1:10      type_i})dnl
dnl
dnl
dnl # ( -- )  $1 = addr
dnl # print inverted_msb-terminated string
define({PUSH_TYPE_I},{ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
{define({USE_PRINT_I},{})
    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 type_i   ( -- )
    call PRINT_STRING_I ; 3:17      $1 type_i})})dnl
dnl
dnl
dnl # ( addr -- addr )
dnl # non-destructively print inverted_msb-terminated string
define({DUP_TYPE_I},{
__{}define({USE_TYPE_I},{})dnl
    call PRINT_TYPE_I   ; 3:17      dup type_i   ( addr -- addr )})dnl
dnl
dnl
dnl
define({RECURSIVE_REVERSE_STACK},{ifdef({__STRING_NUM_STACK},{dnl
__{}pushdef({REVERSE_NUM_STACK},⸨__STRING_NUM_STACK⸩)dnl
__{}pushdef({REVERSE_STACK},⸨__STRING_STACK⸩)dnl
__{}popdef({__STRING_NUM_STACK})dnl
__{}popdef({__STRING_STACK})dnl
__{}RECURSIVE_REVERSE_STACK})})dnl
dnl
dnl
dnl
define({RECURSIVE_COPY_STACK},{ifdef({REVERSE_NUM_STACK},{dnl
__{}changequote({⸨}, {⸩})dnl
__⸨⸩pushdef(⸨__STRING_NUM_STACK⸩,{REVERSE_NUM_STACK})dnl
__⸨⸩pushdef(⸨TEMP_NUM_STACK⸩,{{REVERSE_NUM_STACK}})dnl
__⸨⸩pushdef(⸨__STRING_STACK⸩,{REVERSE_STACK})dnl
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
__{}__{}__{}define({__STRING_MATCH},TEMP_NUM_STACK)}dnl
__{}__{},{dnl
__{}__{}__{}popdef({TEMP_NUM_STACK}){}popdef({TEMP_STACK}){}RECURSIVE_CHECK_STACK({$1})dnl
__{}__{}})dnl
__{}})dnl
})dnl
dnl
dnl
dnl
define({PRINT_STRING_STACK},{ifdef({__STRING_NUM_STACK},{
__{}ifelse(substr(__STRING_STACK,0,7),{    db },{string{}__STRING_NUM_STACK:
__{}__{}__STRING_STACK
__{}__{}  size{}__STRING_NUM_STACK   EQU  $ - string{}__STRING_NUM_STACK},
__{}{dnl
__{}__{}__STRING_STACK}){}dnl
__{}popdef({__STRING_NUM_STACK}){}popdef({__STRING_STACK}){}PRINT_STRING_STACK})})dnl
dnl
dnl
dnl
define({SEARCH_FOR_MATCHING_STRING},{dnl
__{}undefine({REVERSE_STACK})dnl
__{}undefine({REVERSE_NUM_STACK})dnl
__{}define({__STRING_MATCH},__STRING_LAST)dnl
__{}RECURSIVE_REVERSE_STACK{}dnl
__{}RECURSIVE_COPY_STACK{}dnl
__{}RECURSIVE_CHECK_STACK({$1}){}dnl
})dnl
dnl
dnl
dnl
define({__STRING_LAST},100)dnl
dnl
dnl
dnl
dnl # Allocate string
define({__ALLOCATE_STRING},{dnl
__{}define({__STRING_LAST}, incr(__STRING_LAST)){}dnl
__{}SEARCH_FOR_MATCHING_STRING({{    db $*}}){}dnl
__{}ifelse(__STRING_MATCH,__STRING_LAST,{dnl
__{}__{}pushdef({__STRING_STACK},{{    db $*}})},
__{}{dnl
__{}__{}pushdef({__STRING_STACK},{dnl
__{}__{}__{}string}__STRING_LAST{   EQU  string}__STRING_MATCH{
__{}__{}__{}  size}__STRING_LAST{   EQU    size}__STRING_MATCH)}){}dnl
__{}pushdef({__STRING_NUM_STACK},__STRING_LAST){}dnl
})dnl
dnl
dnl
dnl
dnl # conversion to string
dnl # "T","e","x","t",,"",,       --> "T","e","x","t"
dnl # "Text",,"",,                --> "Text"
dnl # "Text",0x0D,"",,            --> "Text",0x0D
define({__CONVERSION_TO_STRING},{regexp({$*},{^\(.*\)\([^"]"\|[^", ]+\)\s*\(,\(""\|\)\s*\)*$},{{\1\2}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # conversion to string_z
dnl # "T","e","x","t",,"",,       --> "T","e","x","t", 0x00
dnl # "Text",,"",,                --> "Text", 0x00
dnl # "Text",0x0D,"",,            --> "Text",0x0D, 0x00
define({__CONVERSION_TO_STRING_Z},{regexp({$*},{^\(.*\)\([^"]"\|[^", ]+\)\s*\(,\(""\|\)\s*\)*$},{{\1\2, 0x00}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # conversion to string_i
dnl # "T","e","x","t",,"",,       --> "T","e","x","t" + 0x80
dnl # "Text",,"",,                --> "Tex","t" + 0x80
dnl # "Text",0x0D,"",,            --> "Text",0x0D + 0x80
define({__CONVERSION_TO_STRING_I},{ifelse(dnl
__{}__{}regexp({$*},     {^\(.*\)\("[^"]"\)\s*\(,\(""\|\)\s*\)*\s*$},{{"x","x"}}),{"x","x"},
__{}__{}__{}{regexp({$*},{^\(.*\)\("[^"]"\)\s*\(,\(""\|\)\s*\)*\s*$},{{\1\2 + 0x80}})},dnl           # "H","e","l","l","o"      --> "H","e","l","l","o" + 0x80
__{}__{}regexp({$*},     {^\(.*".*[^"]\)\([^"]\)"\s*\(,\(""\|\)\s*\)*\s*$},{{"...xx"}}),{"...xx"},
__{}__{}__{}{regexp({$*},{^\(.*".*[^"]\)\([^"]\)"\s*\(,\(""\|\)\s*\)*\s*$},{{\1","\2" + 0x80}})},dnl # "Hello"                  --> "Hell","o"+0x80
__{}__{}regexp({$*},     {^\(.*\)\s*\([^",]*[^", ]+\)\s*\(,\(""\|\)\s*\)*\s*$},{{x,x}}),{x,x},
__{}__{}__{}{regexp({$*},{^\(.*\)\s*\([^",]*[^", ]+\)\s*\(,\(""\|\)\s*\)*\s*$},{{\1\2 + 0x80}})},dnl # 0x48,0x65,0x6c,0x6c,0x6f --> 0x48,0x65,0x6c,0x6c,0x6f+0x80
__{}__{}{dnl
__{}__{}__{}regexp({$*},{^\(.+[^ ]\)\s*$},{{\1 + 0x80}}){}errprint({
__{}__{}__{}  .warning {$0}: $# Unexpected text string, last character not found.})}){}dnl           # ???                      --> ??? + 0x80
}){}dnl
dnl
dnl
dnl
dnl # ." string"
dnl # .( string)
dnl # ( -- )
dnl # print string
define({PRINT},{ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING({$*}))
__{}    push DE             ; 1:11      print     ifelse(eval(len({$*})<60),{1},{$*},{substr({$*},0,57)...})
__{}    ld   BC, size{}__STRING_MATCH    ; 3:10      print     Length of string{}__STRING_LAST{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH})
__{}    ld   DE, string{}__STRING_MATCH  ; 3:10      print     Address of string{}__STRING_LAST{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH})
__{}    call 0x203C         ; 3:17      print     Print our string with {ZX 48K ROM}
__{}    pop  DE             ; 1:10      print{}dnl
})})dnl
dnl
dnl
dnl
dnl # ." string\x00"
dnl # .( string\x00)
dnl # ( -- )
dnl # print null-terminated string
define({PRINT_Z},{ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_Z({$*})){}dnl
__{}define({USE_PRINT_Z},{})
__{}    ld   BC, string{}__STRING_MATCH  ; 3:10      print_z   Address of null-terminated string{}__STRING_LAST{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH})
__{}    call PRINT_STRING_Z ; 3:17      print_z{}dnl
})}){}dnl
dnl
dnl
dnl
dnl # ." strin\xE7"
dnl # .( strin\xE7)
dnl # ( -- )
dnl # print string ending with inverted most significant bit
define({PRINT_I},{ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_I({$*})){}dnl
__{}define({USE_PRINT_I},{})
__{}    ld   BC, string{}__STRING_MATCH  ; 3:10      print_i   Address of string{}__STRING_LAST ending with inverted most significant bit{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH})
__{}    call PRINT_STRING_I ; 3:17      print_i{}dnl
})})dnl
dnl
dnl
dnl
dnl # s" string"
dnl # ( -- addr n )
dnl # addr = address string, n = lenght(string)
define({STRING},{ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING({$*}))
__{}    push DE             ; 1:11      string    ( -- addr size )
__{}    push HL             ; 1:11      string    ifelse(eval(len({$*})<60),{1},{$*},{substr({$*},0,57)...})
__{}    ld   DE, string{}__STRING_MATCH  ; 3:10      string    Address of string{}__STRING_LAST{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH})
__{}    ld   HL, size{}__STRING_MATCH    ; 3:10      string    Length of string{}__STRING_LAST{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH}){}dnl
})})dnl
dnl
dnl
dnl
dnl # s" string\x00" drop
dnl # ( -- addr )
dnl # store null-terminated string
define({STRING_Z},{ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_Z({$*}))
__{}    push DE             ; 1:11      string_z   ( -- addr )
__{}    ex   DE, HL         ; 1:4       string_z   ifelse(eval(len({$*})<60),{1},{$*},{substr({$*},0,57)...})
__{}    ld   HL, format({%-11s},string{}__STRING_MATCH); 3:10      string_z   Address of null-terminated string{}__STRING_LAST{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH}){}dnl
})})dnl
dnl
dnl
dnl
dnl # s" string\x00" 2drop
dnl # ( -- )
dnl # store null-terminated string
define({STRING_Z_DROP},{ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_Z({$*}))
__{}                        ;           string_z drop   ( -- )   {}dnl
__{}ifelse(__STRING_LAST,__STRING_MATCH,{dnl
__{}__{}Allocate null-terminated string{}__STRING_LAST},
__{}{dnl
__{}__{}         null-terminated string{}__STRING_LAST == string{}__STRING_MATCH}){}dnl
})})dnl
dnl
dnl
dnl
dnl # s" strin\xE7" drop
dnl # ( -- addr )
dnl # store inverted_msb-terminated string
define({STRING_I},{ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_I({$*}))
__{}    push DE             ; 1:11      string_i   ( -- addr )
__{}    ex   DE, HL         ; 1:4       string_i   ifelse(eval(len({$*})<60),{1},{$*},{substr({$*},0,57)...})
__{}    ld   HL, format({%-11s},string{}__STRING_MATCH); 3:10      string_i   Address of string{}__STRING_LAST ending with inverted most significant bit{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH}){}dnl
})})dnl
dnl
dnl
dnl # s" strin\xE7" 2drop
dnl # ( -- )
dnl # store inverted_msb-terminated string
define({STRING_I_DROP},{ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_I({$*}))
__{}                        ;           string_i drop   ( -- )   {}dnl
__{}ifelse(__STRING_LAST,__STRING_MATCH,{dnl
__{}__{}Allocate string{}__STRING_LAST ending with inverted most significant bit},
__{}{dnl
__{}__{}         string{}__STRING_LAST ending with inverted most significant bit == string{}__STRING_MATCH}){}dnl
})})dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # Clear key buff
define({CLEARKEY},{ifdef({USE_CLEARKEY},,define({USE_CLEARKEY},{}))
    call CLEARBUFF      ; 3:17      clearkey})dnl
dnl
dnl
dnl
dnl # ( -- key )
dnl # readchar
define({KEY},{ifdef({USE_KEY},,define({USE_KEY},{}))
    call READKEY        ; 3:17      key})dnl
dnl
dnl
dnl
dnl # ( -- flag )
dnl # key?
define({KEYQUESTION},{
    ex   DE, HL         ; 1:4       key?
    push HL             ; 1:11      key?
    ld    A,(0x5C08)    ; 3:13      key?   read new value of {LAST K}
    add   A, 0xFF       ; 2:7       key?   carry if non zero value
    sbc  HL, HL         ; 2:15      key?})dnl
dnl
dnl
dnl
dnl # ( addr umax -- uloaded )
dnl # readstring
define({ACCEPT},{ifdef({USE_ACCEPT},,define({USE_ACCEPT},{}))
    call READSTRING     ; 3:17      accept})dnl
dnl
dnl
dnl # ( addr umax -- uloaded )
dnl # readstring
define({ACCEPT_Z},{ifdef({USE_ACCEPT},,define({USE_ACCEPT},{})){}ifdef({USE_ACCEPT_Z},,define({USE_ACCEPT_Z},{}))
    call READSTRING     ; 3:17      accept_z})dnl
dnl
dnl
dnl
