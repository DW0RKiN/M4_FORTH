dnl ## Device
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
  .warning $0:($*) Last character not found. Check if you have an even number of characters "})}){}dnl           # ???                      --> ??? + 0x80
}){}dnl
dnl
dnl
dnl
dnl # -------------------------------------------
dnl
dnl # . bs
dnl # ( x -- )
dnl # prints a 16-bit number with no spaces
define({DOT},{dnl
__{}__ADD_TOKEN({__TOKEN_DOT},{.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DOT},{dnl
__{}define({__INFO},{.}){}dnl
__def({USE_PRT_S16})
    call PRT_S16        ; 3:17      .   ( s -- )})dnl
dnl
dnl
dnl # dup . bs
dnl # ( x -- x )
dnl # prints without deletion a 16-bit number without spaces
define({DUP_DOT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_DOT},{dup .},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_DOT},{dnl
__{}define({__INFO},{dup .}){}dnl

    push HL             ; 1:11      dup .   x3 x1 x2 x1{}dnl
__{}__ASM_TOKEN_DOT
    ex   DE, HL         ; 1:4       dup .   x3 x2 x1})dnl
dnl
dnl
dnl # u. bs
dnl # ( u -- )
dnl # prints a 16-bit unsigned number with no spaces
define({UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_UDOT},{u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UDOT},{dnl
__{}define({__INFO},{u.}){}dnl
__def({USE_PRT_U16})
    call PRT_U16        ; 3:17      u.   ( u -- )})dnl
dnl
dnl
dnl # dup u. bs
dnl # ( u -- u )
dnl # prints without deletion a 16-bit unsigned number without spaces
define({DUP_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_UDOT},{dup u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_UDOT},{dnl
__{}define({__INFO},{dup u.}){}dnl

    push HL             ; 1:11      dup u.   x3 x1 x2 x1{}dnl
__{}__ASM_TOKEN_UDOT
    ex   DE, HL         ; 1:4       dup u.   x3 x2 x1})dnl
dnl
dnl
dnl # space . bs
dnl # ( x -- )
dnl # prints a space and a 16-bit number
define({SPACE_DOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_DOT},{space .},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_DOT},{dnl
__{}define({__INFO},{space .}){}dnl
__def({USE_PRT_SP_S16})
    call PRT_SP_S16     ; 3:17      space .   ( s -- )})dnl
dnl
dnl
dnl # dup space . bs
dnl # ( x -- x )
dnl # prints a space and without deletion a 16-bit number
define({DUP_SPACE_DOT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_SPACE_DOT},{dup space .},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_SPACE_DOT},{dnl
__{}define({__INFO},{dup space .}){}dnl

    push HL             ; 1:11      dup space .   x3 x1 x2 x1{}dnl
__{}__ASM_TOKEN_SPACE_DOT
    ex   DE, HL         ; 1:4       dup space .   x3 x2 x1})dnl
dnl
define({SPACE_DUP_DOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_DUP_DOT},{space dup .},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_DUP_DOT},{dnl
__{}define({__INFO},{space dup .}){}dnl
__{}__ASM_TOKEN_DUP_SPACE_DOT}){}dnl
dnl
dnl
dnl # space u. bs
dnl # ( u -- )
dnl # prints a space and a 16-bit number
define({SPACE_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_UDOT},{space u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_UDOT},{dnl
__{}define({__INFO},{space u.}){}dnl
__def({USE_PRT_SP_U16})
    call PRT_SP_U16     ; 3:17      space u.   ( u -- )})dnl
dnl
dnl
dnl # space dup u. bs
dnl # ( u -- u )
dnl # print space and non-destructively number
define({DUP_SPACE_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_SPACE_UDOT},{dup space u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_SPACE_UDOT},{dnl
__{}define({__INFO},{dup space u.}){}dnl

    push HL             ; 1:11      dup space u.   x3 x1 x2 x1{}dnl
__{}__ASM_TOKEN_SPACE_UDOT
    ex   DE, HL         ; 1:4       dup space u.   x3 x2 x1})dnl
dnl
define({SPACE_DUP_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_DUP_UDOT},{space dup u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_DUP_UDOT},{dnl
__{}define({__INFO},{space dup u.}){}dnl
__{}__ASM_TOKEN_DUP_SPACE_UDOT}){}dnl
dnl
dnl
dnl # hex u. bs
dnl # ( u -- )
dnl # prints a 16-bit unsigned hex number with no spaces
define({HEX_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_UDOT},{hex u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_UDOT},{dnl
__{}define({__INFO},{hex u.}){}dnl
__def({USE_PRT_HEX_U16})
    call PRT_HEX_U16    ; 3:17      hex u.   ( u -- )
    pop  HL             ; 1:10      hex u.
    pop  DE             ; 1:10      hex u.})dnl
dnl
dnl
dnl # dup hex u. bs
dnl # ( u -- u )
dnl # prints without deletion a 16-bit unsigned hex number with no spaces
define({DUP_HEX_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_HEX_UDOT},{dup hex u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_HEX_UDOT},{dnl
__{}define({__INFO},{dup hex u.}){}dnl
__def({USE_PRT_HEX_U16})
    call PRT_HEX_U16    ; 3:17      dup hex u.   ( u -- u )})dnl
dnl
define({HEX_DUP_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_DUP_UDOT},{hex dup u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_DUP_UDOT},{dnl
__{}define({__INFO},{hex dup u.}){}dnl
__{}__ASM_TOKEN_DUP_HEX_UDOT}){}dnl
dnl
dnl
dnl # space hex u. bs
dnl # ( u -- )
dnl # prints a space and a 16-bit unsigned hex number
define({SPACE_HEX_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_HEX_UDOT},{space hex u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_HEX_UDOT},{dnl
__{}define({__INFO},{space hex u.}){}dnl
__def({USE_PRT_SP_HEX_U16})
    call PRT_SP_HEX_U16 ; 3:17      space hex u.   ( u -- )
    pop  HL             ; 1:10      space hex u.
    pop  DE             ; 1:10      space hex u.})dnl
dnl
define({HEX_SPACE_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_SPACE_UDOT},{hex space u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_SPACE_UDOT},{dnl
__{}define({__INFO},{hex space u.}){}dnl
__{}__ASM_TOKEN_SPACE_HEX_UDOT}){}dnl
dnl
dnl # space dup hex u. bs
dnl # ( u -- u )
dnl # prints a space and without deletion a 16-bit unsigned hex number
define({SPACE_DUP_HEX_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_DUP_HEX_UDOT},{space dup hex u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_DUP_HEX_UDOT},{dnl
__{}define({__INFO},{space dup hex u.}){}dnl
__def({USE_PRT_SP_HEX_U16})
    call PRT_SP_HEX_U16 ; 3:17      space dup hex u.   ( u -- u )})dnl
dnl
define({SPACE_HEX_DUP_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_HEX_DUP_UDOT},{space hex dup u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_HEX_DUP_UDOT},{dnl
__{}define({__INFO},{space hex dup u.}){}dnl
__{}__ASM_TOKEN_SPACE_DUP_HEX_UDOT}){}dnl
define({DUP_SPACE_HEX_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_SPACE_HEX_UDOT},{dup space hex u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_SPACE_HEX_UDOT},{dnl
__{}define({__INFO},{dup space hex u.}){}dnl
__{}__ASM_TOKEN_SPACE_DUP_HEX_UDOT}){}dnl
define({DUP_HEX_SPACE_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_HEX_SPACE_UDOT},{dup hex space u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_HEX_SPACE_UDOT},{dnl
__{}define({__INFO},{dup hex space u.}){}dnl
__{}__ASM_TOKEN_SPACE_DUP_HEX_UDOT}){}dnl
define({HEX_SPACE_DUP_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_SPACE_DUP_UDOT},{hex space dup u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_SPACE_DUP_UDOT},{dnl
__{}define({__INFO},{hex space dup u.}){}dnl
__{}__ASM_TOKEN_SPACE_DUP_HEX_UDOT}){}dnl
define({HEX_DUP_SPACE_UDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_DUP_SPACE_UDOT},{hex dup space u.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_DUP_SPACE_UDOT},{dnl
__{}define({__INFO},{hex dup space u.}){}dnl
__{}__ASM_TOKEN_SPACE_DUP_HEX_UDOT}){}dnl
dnl
dnl # -------vvv zx rom routines vvv---------
dnl
dnl
dnl # u.
dnl # ( u -- )
dnl # print spaces and unsigned 16-bit number
define({SPACE_UDOTZXROM},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_UDOTZXROM},{space u.zxrom},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_UDOTZXROM},{dnl
__{}define({__INFO},{space u.zxrom}){}dnl
__def({USE_ZXPRT_SP_U16})
    call ZXPRT_SP_U16   ; 3:17      space u.zxrom   ( u -- )})dnl
dnl
dnl # u.
dnl # ( u -- )
dnl # print unsigned 16-bit number
define({UDOTZXROM},{dnl
__{}__ADD_TOKEN({__TOKEN_UDOTZXROM},{u.zxrom},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UDOTZXROM},{dnl
__{}define({__INFO},{u.zxrom}){}dnl
__def({USE_ZXPRT_U16})
    call ZXPRT_U16      ; 3:17      u.zxrom   ( u -- )})dnl
dnl
dnl
dnl # dup u.
dnl # ( u -- u )
dnl # dup and print space and unsigned 16-bit number
define({DUP_SPACE_UDOTZXROM},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_SPACE_UDOTZXROM},{dup space u.zxrom},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_SPACE_UDOTZXROM},{dnl
__{}define({__INFO},{dup space u.zxrom}){}dnl
__def({USE_DUP_ZXPRT_SP_U16})
    call DUP_ZXPRT_SP_U16; 3:17      dup space u.zxrom   ( u -- u )})dnl
dnl
dnl
dnl # dup u.
dnl # ( u -- u )
dnl # dup and print unsigned 16-bit number
define({DUP_UDOTZXROM},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_UDOTZXROM},{dup u.zxrom},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_UDOTZXROM},{dnl
__{}define({__INFO},{dup u.zxrom}){}dnl
__def({USE_DUP_ZXPRT_U16})
    call DUP_ZXPRT_U16  ; 3:17      dup u.zxrom   ( u -- u )})dnl
dnl
dnl
dnl # .
dnl # ( x -- )
dnl # print space and 16-bit number
define({SPACE_DOTZXROM},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_DOTZXROM},{space .zxrom},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_DOTZXROM},{dnl
__{}define({__INFO},{space .zxrom}){}dnl
__def({USE_ZXPRT_SP_S16})
    call ZXPRT_SP_S16   ; 3:17      space .zxrom   ( x -- )})dnl
dnl
dnl # .
dnl # ( x -- )
dnl # print 16-bit number
define({DOTZXROM},{dnl
__{}__ADD_TOKEN({__TOKEN_DOTZXROM},{.zxrom},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DOTZXROM},{dnl
__{}define({__INFO},{.zxrom}){}dnl
__def({USE_ZXPRT_S16})
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
define({DDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_DDOT},{d.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DDOT},{dnl
__{}define({__INFO},{d.}){}dnl
__def({USE_PRT_S32})
    call PRT_S32        ; 3:17      d.   ( d -- )})dnl
dnl
dnl # space d. bs
dnl # ( d -- )
dnl # prints a space and a 32-bit number
define({SPACE_DDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_DDOT},{space d.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_DDOT},{dnl
__{}define({__INFO},{space d.}){}dnl
__def({USE_PRT_SP_S32})
    call PRT_SP_S32     ; 3:17      space d.   ( d -- )})dnl
dnl
dnl
dnl # ud. bs
dnl # ( ud -- )
dnl # prints a 32-bit unsigned number with no spaces
define({UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_UDDOT},{ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_UDDOT},{dnl
__{}define({__INFO},{ud.}){}dnl
__def({USE_PRT_U32})
    call PRT_U32        ; 3:17      ud.   ( ud -- )})dnl
dnl
dnl
dnl # space ud. bs
dnl # ( ud -- )
dnl # prints a space and a 32-bit unsigned number
define({SPACE_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_UDDOT},{space ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_UDDOT},{dnl
__{}define({__INFO},{space ud.}){}dnl
__def({USE_PRT_SP_U32})
    call PRT_SP_U32     ; 3:17      space ud.   ( ud -- )})dnl
dnl
dnl
dnl # hex ud.
dnl # ( ud -- )
dnl # prints a 32-bit unsigned hex number with no spaces
define({HEX_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_UDDOT},{hex ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_UDDOT},{dnl
__{}define({__INFO},{hex ud.}){}dnl
__def({USE_PRT_HEX_U32})
    call PRT_HEX_U32    ; 3:17      hex ud.   ( ud -- )
    pop  HL             ; 1:10      hex ud.
    pop  DE             ; 1:10      hex ud.})dnl
dnl
dnl
dnl # 2dup hex ud.
dnl # ( ud -- ud )
dnl # prints without deletion a 32-bit unsigned hex number with no spaces
define({_2DUP_HEX_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HEX_UDDOT},{2dup hex ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HEX_UDDOT},{dnl
__{}define({__INFO},{2dup hex ud.}){}dnl
__def({USE_PRT_HEX_U32})
    call PRT_HEX_U32    ; 3:17      2dup hex ud.   ( ud -- ud )})dnl
dnl
define({HEX_2DUP_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_2DUP_UDDOT},{hex 2dup ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_2DUP_UDDOT},{dnl
__{}define({__INFO},{hex 2dup ud.}){}dnl
__{}__ASM_TOKEN_2DUP_HEX_UDDOT}){}dnl
dnl
dnl
dnl # space hex ud. bs
dnl # ( ud -- )
dnl # prints space and a 32-bit unsigned hex number
define({SPACE_HEX_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_HEX_UDDOT},{space hex ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_HEX_UDDOT},{dnl
__{}define({__INFO},{space hex ud.}){}dnl
__def({USE_PRT_SP_HEX_U32})
    call PRT_SP_HEX_U32 ; 3:17      space hex ud.   ( ud -- )
    pop  HL             ; 1:10      space hex ud.
    pop  DE             ; 1:10      space hex ud.})dnl
dnl
define({HEX_SPACE_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_SPACE_UDDOT},{hex space ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_SPACE_UDDOT},{dnl
__{}define({__INFO},{hex space ud.}){}dnl
__{}__ASM_TOKEN_SPACE_HEX_UDDOT}){}dnl
dnl
dnl
dnl # space 2dup hex ud. bs
dnl # ( ud -- ud )
dnl # prints space and without deletion a 32-bit unsigned hex number
define({SPACE_2DUP_HEX_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_2DUP_HEX_UDDOT},{space 2dup hex ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_2DUP_HEX_UDDOT},{dnl
__{}define({__INFO},{space 2dup hex ud.}){}dnl
__def({USE_PRT_SP_HEX_U32})
    call PRT_SP_HEX_U32 ; 3:17      space 2dup hex ud.   ( ud -- ud )})dnl
dnl
define({SPACE_HEX_2DUP_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE_HEX_2DUP_UDDOT},{space hex 2dup ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE_HEX_2DUP_UDDOT},{dnl
__{}define({__INFO},{space hex 2dup ud.}){}dnl
__{}__ASM_TOKEN_SPACE_2DUP_HEX_UDDOT}){}dnl
define({HEX_SPACE_2DUP_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_SPACE_2DUP_UDDOT},{hex space 2dup ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_SPACE_2DUP_UDDOT},{dnl
__{}define({__INFO},{hex space 2dup ud.}){}dnl
__{}__ASM_TOKEN_SPACE_2DUP_HEX_UDDOT}){}dnl
define({HEX_2DUP_SPACE_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_HEX_2DUP_SPACE_UDDOT},{hex 2dup space ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HEX_2DUP_SPACE_UDDOT},{dnl
__{}define({__INFO},{hex 2dup space ud.}){}dnl
__{}__ASM_TOKEN_SPACE_2DUP_HEX_UDDOT}){}dnl
define({_2DUP_HEX_SPACE_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HEX_SPACE_UDDOT},{2dup hex space ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HEX_SPACE_UDDOT},{dnl
__{}define({__INFO},{2dup hex space ud.}){}dnl
__{}__ASM_TOKEN_SPACE_2DUP_HEX_UDDOT}){}dnl
define({_2DUP_SPACE_HEX_UDDOT},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_SPACE_HEX_UDDOT},{2dup space hex ud.},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_SPACE_HEX_UDDOT},{dnl
__{}define({__INFO},{2dup space hex ud.}){}dnl
__{}__ASM_TOKEN_SPACE_2DUP_HEX_UDDOT}){}dnl
dnl
dnl # -------------------------------------------
dnl
dnl # .S
dnl # ( x3 x2 x1 -- x3 x2 x1 )
dnl # print 3 stack number
define({DOTS},{dnl
__{}__ADD_TOKEN({__TOKEN_DOTS},{.s},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DOTS},{dnl
__{}define({__INFO},{.s}){}dnl

    ex  (SP), HL        ; 1:19      .S  ( x1 x2 x3 )
    push HL             ; 1:11      .S  ( x1 x3 x2 x3 )
__{}__ASM_TOKEN_DOT
    push HL             ; 1:11      .S  ( x1 x2 x3 x2 )
__{}__ASM_TOKEN_SPACE_DOT
    ex  (SP), HL        ; 1:19      .S  ( x3 x2 x1 )
__{}__ASM_TOKEN_DUP_SPACE_DOT})dnl
dnl
dnl
dnl # ( -- )
dnl # new line
define({CR},{dnl
__{}__ADD_TOKEN({__TOKEN_CR},{cr},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CR},{dnl
__{}define({__INFO},{cr}){}dnl

    ld    A, 0x0D       ; 2:7       cr      Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      cr      with {48K ROM} in, this will print char in A})dnl
dnl
dnl
dnl # ( 'a' -- )
dnl # print char 'a'
define({EMIT},{dnl
__{}__ADD_TOKEN({__TOKEN_EMIT},{emit},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_EMIT},{dnl
__{}define({__INFO},{emit}){}dnl

    ld    A, L          ; 1:4       emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      emit    with {48K ROM} in, this will print char in A{}dnl
__{}DROP})dnl
dnl
dnl
dnl # ( 'a' -- 'a' )
dnl # print char 'a'
define({DUP_EMIT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_EMIT},{dup emit},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_EMIT},{dnl
__{}define({__INFO},{dup emit}){}dnl

    ld    A, L          ; 1:4       dup emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      dup emit    with {48K ROM} in, this will print char in A})dnl
dnl
dnl
dnl # ( addr -- addr )
dnl # print char from address
define({DUP_FETCH_EMIT},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_FETCH_EMIT},{dup fetch_emit},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_FETCH_EMIT},{dnl
__{}define({__INFO},{dup fetch_emit}){}dnl

    ld    A,(HL)        ; 1:7       dup @ emit    Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      dup @ emit    with {48K ROM} in, this will print char in A})dnl
dnl
dnl
dnl # ( -- )
dnl # print space
define({SPACE},{dnl
__{}__ADD_TOKEN({__TOKEN_SPACE},{space},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_SPACE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, 0x20       ; 2:7       __INFO   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      __INFO   with {48K ROM} in, this will print space})dnl
dnl
dnl
dnl # dup space
dnl # ( x -- x x )
dnl # duplicate tos and prints a space
define({DUP_SPACE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_SPACE},{dup space},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_SPACE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}__ASM_TOKEN_DUP{}dnl
__{}__ASM_TOKEN_SPACE}){}dnl
dnl
dnl
dnl
dnl # ( -- )
dnl # .( char )
define({PUTCHAR},{dnl
__{}__ADD_TOKEN({__TOKEN_PUTCHAR},{putchar({$1})},{$@}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUTCHAR},{dnl
ifelse({$1},{},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter! If you want to print a comma you have to write putchar({{','}})},
{define({__INFO},__COMPILE_INFO)
    ld    A, format({%-11s},{{$1}})  ; 2:7       __INFO   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      __INFO   putchar(reg A) with {ZX 48K ROM}}){}dnl
}){}dnl
dnl
dnl
dnl # ( -- )
dnl # .( char )
define({PUSH_EMIT},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_EMIT},{{$1} emit},{$@}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_EMIT},{dnl
ifelse({$1},{},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter! If you want to print a comma you have to write push({{','}}) emit},
{define({__INFO},__COMPILE_INFO)
    ld    A, format({%-11s},{{$1}})  ; 2:7       __INFO   Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      __INFO   putchar(reg A) with {ZX 48K ROM}})dnl
}){}dnl
dnl
dnl
dnl
dnl # ( addr n -- )
dnl # print n chars from addr
define({TYPE},{dnl
__{}__ADD_TOKEN({__TOKEN_TYPE},{type},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TYPE},{dnl
__{}define({__INFO},{type}){}dnl

__{}define({USE_TYPE},{})dnl
    call PRINT_TYPE     ; 3:17      type   ( addr n -- )})dnl
dnl
dnl
dnl # ( addr n -- addr n )
dnl # non-destructively print string
define({_2DUP_TYPE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_TYPE},{2dup type},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_TYPE},{dnl
__{}define({__INFO},{2dup type}){}dnl

    push DE             ; 1:11      2dup type   ( addr n -- addr n )
    ld    B, H          ; 1:4       2dup type
    ld    C, L          ; 1:4       2dup type   BC = length of string to print
    call 0x203C         ; 3:17      2dup type   Use {ZX 48K ROM} for print string
    pop  DE             ; 1:10      2dup type})dnl
dnl
dnl
dnl # ( addr -- )
dnl # print stringZ
define({TYPE_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_TYPE_Z},{type_z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TYPE_Z},{dnl
__{}define({__INFO},{type_z}){}dnl

__{}define({USE_TYPE_Z},{})dnl
    call PRINT_TYPE_Z   ; 3:17      type_z   ( addr -- )
    ex   DE, HL         ; 1:4       type_z
    pop  DE             ; 1:10      type_z})dnl
dnl
dnl
dnl # ( -- )  $1 = addr
dnl # print stringZ
define({PUSH_TYPE_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_TYPE_Z},{$1 type_z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_TYPE_Z},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}    .error {$0}(): Missing parameter!},
{define({USE_PRINT_Z},{})
    ld   BC, ifelse(__IS_MEM_REF($1),{1},{format({%-11s},$1); 4:20},{__FORM({%-11s},$1); 3:10})      __INFO   ( -- )
    call PRINT_STRING_Z ; 3:17      __INFO})})dnl
dnl
dnl
dnl # ( addr -- addr )
dnl # non-destructively print stringZ
define({DUP_TYPE_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_TYPE_Z},{dup type_z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_TYPE_Z},{dnl
__{}define({__INFO},{dup type_z}){}dnl

__{}define({USE_TYPE_Z},{})dnl
    call PRINT_TYPE_Z   ; 3:17      dup type_z   ( addr -- addr )})dnl
dnl
dnl
dnl # ( addr -- )
dnl # print inverted_msb-terminated string
define({TYPE_I},{dnl
__{}__ADD_TOKEN({__TOKEN_TYPE_I},{type_i},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TYPE_I},{dnl
__{}define({__INFO},{type_i}){}dnl

__{}define({USE_TYPE_I},{})dnl
    call PRINT_TYPE_I   ; 3:17      type_i   ( addr -- )
    ex   DE, HL         ; 1:4       type_i
    pop  DE             ; 1:10      type_i})dnl
dnl
dnl
dnl # ( -- )  $1 = addr
dnl # print inverted_msb-terminated string
define({PUSH_TYPE_I},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_TYPE_I},{$1 type_i},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_TYPE_I},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
{define({USE_PRINT_I},{})
    ld   BC, ifelse(__IS_MEM_REF($1),{1},{format({%-11s},$1); 4:20},{__FORM({%-11s},$1); 3:10})      __INFO   ( -- )
    call PRINT_STRING_I ; 3:17      __INFO})})dnl
dnl
dnl
dnl # ( addr -- addr )
dnl # non-destructively print inverted_msb-terminated string
define({DUP_TYPE_I},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_TYPE_I},{dup type_i},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_TYPE_I},{dnl
__{}define({__INFO},{dup type_i}){}dnl

__{}define({USE_TYPE_I},{})dnl
    call PRINT_TYPE_I   ; 3:17      dup type_i   ( addr -- addr )})dnl
dnl
dnl
dnl
dnl # ." string"
dnl # .( string)
dnl # ( -- )
dnl # print string
define({PRINT},{dnl
__{}__ADD_TOKEN({__TOKEN_PRINT},{print},{{$@}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PRINT},{dnl
__{}define({__INFO},{print}){}dnl
ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING($*))
__{}    push DE             ; 1:11      print     ifelse(eval(len({$*})<60),{1},{$*})
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
define({PRINT_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_PRINT_Z},{print_z},{{$@}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PRINT_Z},{dnl
__{}define({__INFO},{print_z}){}dnl
ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}define({USE_PRINT_Z},{}){}dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_Z($*))
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
define({PRINT_I},{dnl
__{}__ADD_TOKEN({__TOKEN_PRINT_I},{print_i},{{$@}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PRINT_I},{dnl
__{}define({__INFO},{print_i}){}dnl
ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_I($*)){}dnl
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
define({STRING},{dnl
__{}__ADD_TOKEN({__TOKEN_STRING},{string},{{$@}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STRING},{dnl
__{}define({__INFO},{string}){}dnl
ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING($*))
__{}    push DE             ; 1:11      string    ( -- addr size )
__{}    push HL             ; 1:11      string    ifelse(eval(len({$*})<60),{1},{$*})
__{}    ld   DE, string{}__STRING_MATCH  ; 3:10      string    Address of string{}__STRING_LAST{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH})
__{}    ld   HL, size{}__STRING_MATCH    ; 3:10      string    Length of string{}__STRING_LAST{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH}){}dnl
})})dnl
dnl
dnl
dnl
dnl # s" string\x00" drop
dnl # ( -- addr )
dnl # store null-terminated string
define({STRING_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_STRING_Z},{string_z},{{$@}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STRING_Z},{dnl
__{}define({__INFO},{string_z}){}dnl
ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_Z($*))
__{}    push DE             ; 1:11      string_z   ( -- addr )
__{}    ex   DE, HL         ; 1:4       string_z   ifelse(eval(len({$*})<60),{1},{$*})
__{}    ld   HL, format({%-11s},string{}__STRING_MATCH); 3:10      string_z   Address of null-terminated string{}__STRING_LAST{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH}){}dnl
})})dnl
dnl
dnl
dnl
dnl # s" string\x00" 2drop
dnl # ( -- )
dnl # store null-terminated string
define({STRING_Z_DROP},{dnl
__{}__ADD_TOKEN({__TOKEN_STRING_Z_DROP},{string_z_drop},{{$@}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STRING_Z_DROP},{dnl
__{}define({__INFO},{string_z_drop}){}dnl
ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_Z($*))
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
define({STRING_I},{dnl
__{}__ADD_TOKEN({__TOKEN_STRING_I},{string_i},{{$@}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STRING_I},{dnl
__{}define({__INFO},{string_i}){}dnl
ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_I($*))
__{}    push DE             ; 1:11      string_i   ( -- addr )
__{}    ex   DE, HL         ; 1:4       string_i   ifelse(eval(len({$*})<60),{1},{$*})
__{}    ld   HL, format({%-11s},string{}__STRING_MATCH); 3:10      string_i   Address of string{}__STRING_LAST ending with inverted most significant bit{}ifelse(__STRING_MATCH,__STRING_LAST,,{ == string{}__STRING_MATCH}){}dnl
})})dnl
dnl
dnl
dnl # s" strin\xE7" 2drop
dnl # ( -- )
dnl # store inverted_msb-terminated string
define({STRING_I_DROP},{dnl
__{}__ADD_TOKEN({__TOKEN_STRING_I_DROP},{string_i_drop},{{$@}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STRING_I_DROP},{dnl
__{}define({__INFO},{string_i_drop}){}dnl
ifelse($#,0,{
__{}  .error {$0}: Missing parameter!},
eval($#!=1),{1},{
__{}  .error {$0}(...): Received $# instead of one parameter! Text containing a comma and not closed in {{}}. Use it {$0}({{"A","B,C",0x0D}})},
{$1},{},{
__{}  .error {$0}(): An empty parameter was received!},
{dnl
__{}__ALLOCATE_STRING(__CONVERSION_TO_STRING_I($*))
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
define({CLEARKEY},{dnl
__{}__ADD_TOKEN({__TOKEN_CLEARKEY},{clearkey},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CLEARKEY},{dnl
__{}define({__INFO},{clearkey}){}dnl
ifdef({USE_CLEARKEY},,define({USE_CLEARKEY},{}))
    call CLEARBUFF      ; 3:17      clearkey})dnl
dnl
dnl
dnl
dnl # ( -- key )
dnl # readchar
define({KEY},{dnl
__{}__ADD_TOKEN({__TOKEN_KEY},{key},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_KEY},{dnl
__{}define({__INFO},{key}){}dnl
ifdef({USE_KEY},,define({USE_KEY},{}))
    call READKEY        ; 3:17      key})dnl
dnl
dnl
dnl
dnl # ( -- flag )
dnl # key?
define({KEYQUESTION},{dnl
__{}__ADD_TOKEN({__TOKEN_KEYQUESTION},{keyquestion},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_KEYQUESTION},{dnl
__{}define({__INFO},{keyquestion}){}dnl

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
define({ACCEPT},{dnl
__{}__ADD_TOKEN({__TOKEN_ACCEPT},{accept},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ACCEPT},{dnl
__{}define({__INFO},{accept}){}dnl
ifdef({USE_ACCEPT},,define({USE_ACCEPT},{}))
    call READSTRING     ; 3:17      accept})dnl
dnl
dnl
dnl # ( addr umax -- uloaded )
dnl # readstring
define({ACCEPT_Z},{dnl
__{}__ADD_TOKEN({__TOKEN_ACCEPT_Z},{accept_z},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ACCEPT_Z},{dnl
__{}define({__INFO},{accept_z}){}dnl
ifdef({USE_ACCEPT},,define({USE_ACCEPT},{})){}ifdef({USE_ACCEPT_Z},,define({USE_ACCEPT_Z},{}))
    call READSTRING     ; 3:17      accept_z})dnl
dnl
dnl
dnl
dnl # ZX Spectrum set border color
define({ZX_BORDER},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX_BORDER},{zx_border},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX_BORDER},{
__{}define({__INFO},__COMPILE_INFO)
    ld    A, L          ; 1:4       __INFO   ( color -- )
    out (254),A         ; 2:11      __INFO   0=blk,1=blu,2=red,3=mag,4=grn,5=cyn,6=yel,7=wht
    pop  HL             ; 1:10      __INFO
    ex   DE, HL         ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # ZX Spectrum ROM routine clear srceen
define({ZX_CLS},{dnl
__{}__ADD_TOKEN({__TOKEN_ZX_CLS},{zx_cls},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ZX_CLS},{
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO   ( -- )
    push HL             ; 1:11      __INFO
    call 0x0DAF         ; 3:17      __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
