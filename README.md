# M4 FORTH (ZX Spectrum, Z80)

A simple FORTH compiler created using M4 macros. Creates human readable and annotated code in the Z80 assembler. No peephole optimization is used, but a new word with optimized code is created for some frequently related words. For example, for the `dup number condition if`.
The small Runtime library for listing numbers and text is intended for the ZX Spectrum computer.

Due to its simplicity, the compiler is suitable for study purposes. Can be easily edited. For the most part, it is merely a substitution of the FORTH word for a sequence of instructions.

The more complex parts are branches and loops.

## Use registers

Internal implementation of data stack and return address stack.

    Data Stack:

    HL                  TOP (top of stack)
    DE                  NOS (next on stack)
    (SP)                NNOS
    (SP+2)
    (SP+4)
    ...

    Return Address Stack or Loop stack:

    (HL')              
    (HL'+2)
    (HL'+4)
    (HL'+6)
    (HL'+8)
    ...

    Free registers: AF, AF', BC, DE', BC', IX, IY

    Pollutes register: AF, AF', BC, DE', BC'

## Branching

Branching internally creates new names for the label. This is a simple increase in numbers for `else100` and `endif100`. Numbers start with three digits for better alignment. At the end of the branch, it is determined whether the `else` part has been used. `if` always jumps on `else1..`. If `else1..` was not used it should stack the value with `endif1..`. `endif1..` always exists for potential use to jump out of a branch.`

## Loops

Looping internally creates new names for the label. `DO` increments the last number used at `do100`. And store it on the stack. `LOOP` reads the last stored number from the stack. This connects DO and LOOP whether they are used in parallel or in series. When the program is executed, the loops store the indexes on the return address stack.

## Creating new words

It is converted to the creation of new functions. The return value of the function is stored in the return address stack. Recursion is triggered by simply calling yourself.

## Compilation

    m4 my_program_name.m4 > my_program_name.asm
    pasmo -d my_program_name.asm my_program_name.bin > test.asm

## Hello World!

For clarity, macros are divided into several files and stored in the M4 directory.
To avoid having to manually include each file, a `FIRST.M4` file is created that includes all other files.
So the first thing that needs to be done is to include this file using:

    include(`./M4/FIRST.M4')dnl

On the first line immediately change quotes to `{` and `}`. All M4 macros use these new quotes.

`LAST.M4` must be appended to the end of the file using:

    include({./M4/LAST.M4})dnl

Among other things, this file lists all used runtime library functions. For example, to list a string or a number. Multiplication and division functions. Lists the strings used or allocates space for used variables.

In order to be able to call a program from Basic and return it again without error, the `INIT()` and `STOP` macros must be used.
`INIT(xxx)` stores shadow registers and sets the initial value of the return address stack.

In order for the compiler not to compile the program from the zero address, it must still contain the ORG value. For example, ORG 0x8000.

File Hello.m4

    include(`./M4/FIRST.M4')dnl
    ORG 0x8000
    INIT(60000)
    PRINT("Hello World!")
    STOP
    include({./M4/LAST.M4})dnl

m4 Hello.m4

    ORG 0x8000
    
    ;   ===  b e g i n  ===
        exx
        push HL
        push DE
        ld    L, 0x1A       ; 2:7       Upper screen
        call 0x1605         ; 3:17      Open channel
        ld   HL, 60000
        exx
    
        push DE             ; 1:11      print
        ld   BC, size101    ; 3:10      print Length of string to print
        ld   DE, string101  ; 3:10      print Address of string
        call 0x203C         ; 3:17      print Print our string
        pop  DE             ; 1:10      print
    
    
        pop  DE
        pop  HL
        exx
        ret
    ;   =====  e n d  =====
    
    VARIABLE_SECTION:
    
    STRING_SECTION:
    string101:
    db "Hello World!"
    size101 EQU $ - string101

## Limitations of the M4 markup language

Macro names cannot be just `.` or `>`, but an alphanumeric name. So must be renamed to `DOT` or `LT`. `2dup` to `_2DUP`. `3` to `PUSH(3)`.
All FORTH words must be capitalized! Because `+` is written as `ADD`. And `add` is reserved for assembler instructions.
    
Theoretically, your function name or variable may conflict with the name of the macro used. So check it out. The worse case is when you make a mistake in the name of the macro. Then it will not expand and will probably be hidden in the comment of the previous macro.

https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/forth2m4.sh

This is a compiler from Forth to M4 FORTH written in bash. Manual adjustments are still needed. For example, move functions below STOP. Unknown words will try to be called as function names. It will try to find and combine optimized words, but only if they are on the same line and are separated only by white characters.

## Implemented words FORTH

### Stack manipulation

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/stack.m4

| original   |   M4 FORTH   |  optimization  |  data stack                  |  return address stack |
| :--------: | :----------: | :------------: | :--------------------------- | :-------------------- |
|    swap    |     SWAP     |                |      ( x2 x1 -- x1 x2 )      |                       |
|   2swap    |    _2SWAP    |                | (x1 x2 x3 x4 -- x3 x4 x1 x2) |                       |
|     dup    |      DUP     |                |         ( x1 -- x1 x1 )      |                       |
|    2dup    |    _2DUP     |                |      ( x2 x1 -- x2 x1 x2 x1 )|                       |
|    drop    |     DROP     |                |         ( x1 -- )            |                       |
|   2drop    |    _2DROP    |                |      ( x2 x1 -- )            |                       |
|    nip     |      NIP     |                |      ( x2 x1 -- x1 )         |                       |
|    2nip    |     2NIP     |                |    ( d c b a -- b a )        |                       |
|    tuck    |     TUCK     |                |      ( x2 x1 -- x1 x2 x1 )   |                       |
|   2tuck    |   _2TUCK     |                |    ( d c b a -- b a d c b a )|                       |
|    over    |     OVER     |                |      ( x2 x1 -- x2 x1 x2 )   |                       |
|   2over    |   _2OVER     |                |    ( a b c d -- a b c d a b )|                       |
|    rot     |     ROT      |                |   ( x3 x2 x1 -- x2 x1 x3 )   |                       |
|   2rot     |    _2ROT     |                |( f e d c b a -- d c b a f e )|                       |
|   -rot     |     NROT     |                |   ( x3 x2 x1 -- x1 x3 x2 )   |                       |
|   `123`    |  PUSH(`123`) |   PUSH2()      |            ( -- `123` )      |                       |
|   `2` `1`  |PUSH2(`2`,`1`)|                |            ( -- `2` `1` )    |                       |
| addr `7` @ | PUSH((addr)) |                |    *addr = 7 --> ( -- `7`)   |                       |
|            |              | PUSH2((A),`2`) |    *A = 4 --> ( -- `4` `2` ) |                       |
| drop `5`   |              | DROP_PUSH(`5`) |         ( x1 -- `5`)         |                       |
|  dup `4`   |              |  DUP_PUSH(`4`) |         ( x1 -- x1 x1 `4`)   |                       |
|    pick    |     PICK     |                |          ( u -- xu )         |                       |
|  `2` pick  |              | PUSH_PICK(`2`) |   ( x2 x1 x0 -- x2 x1 x0 x2 )|                       |
|     >r     |     TO_R     |                |         ( x1 -- )            |    ( -- x1 )          |
|     r>     |    R_FROM    |                |            ( -- x1 )         | ( x1 -- )             |
|     r@     |    R_FETCH   |                |            ( -- x1 )         |  (x1 -- x1 )          |
|   rdrop    |     RDROP    |                |            ( -- )            | ( x1 -- )             |

### Arithmetic

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/arithmetic.m4

| original   |   M4 FORTH   |  optimization  |  data stack                 |  return address stack |
| :--------: | :----------: | :------------: | :-------------------------- | :-------------------- |
|     +      |      ADD     |                |    ( x2 x1 -- x )           |                       |
|     -      |      SUB     |                |    ( x2 x1 -- x )           |                       |
|   negate   |     NEGATE   |                |       ( x1 -- -x1 )         |                       |
|    abs     |      ABS     |                |        ( n -- u )           |                       |
|     *      |      MUL     |                |    ( x2 x1 -- x )           |                       |
|     /      |      DIV     |                |    ( x2 x1 -- x )           |                       |
|    mod     |      MOD     |                |    ( x2 x1 -- x )           |                       |
|    /mod    |    DIVMOD    |                |    ( x2 x1 -- x )           |                       |
|     u*     |      MUL     |                |    ( x2 x1 -- x )           |                       |
|  `+12` *   |              | PUSH_MUL(`12`) |    ( x2 x1 -- x )           |                       |
|     u/     |     UDIV     |                |    ( x2 x1 -- x )           |                       |
|    umod    |     UMOD     |                |    ( x2 x1 -- x )           |                       |
|    u/mod   |    UDIVMOD   |                |    ( x2 x1 -- rem quot )    |                       |
|     1+     |    _1ADD     |                |       ( x1 -- x1++ )        |                       |
|     1-     |    _1SUB     |                |       ( x1 -- x1-- )        |                       |
|     2+     |    _2ADD     |                |       ( x1 -- x1+2 )        |                       |
|     2-     |    _2SUB     |                |       ( x1 -- x1-2 )        |                       |
|     2*     |    _2MUL     |                |       ( x1 -- x1*2 )        |                       |
|     2/     |    _2DIV     |                |       ( x1 -- x1/2 )        |                       |
|    256*    |   _256MUL    |                |       ( x1 -- x1*256 )      |                       |
|    256/    |   _256DIV    |                |       ( x1 -- x1/256 )      |                       |

### Floating-point

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/floating.m4

Danagy format `S EEE EEEE MMMM MMMM`

https://github.com/DW0RKiN/Floating-point-Library-for-Z80

For a logical comparison of two numbers as f1> f2, exactly the same result applies as for a comparison of two integer numbers with a sign. 

| original   |   M4 FORTH   |  optimization  |  data stack          |  comment                   |
| :--------: | :----------: | :------------: | :------------------- | :------------------------- |
|    s>f     |      S2F     |                |       ( s1 -- f1 )   |                            |
|    u>f     |      U2F     |                |       ( u1 -- f1 )   |                            |
|    f>s     |      F2S     |                |       ( f1 -- s1 )   |                            |
|    f>u     |      F2U     |                |       ( f1 -- u1 )   |                            |
|     f+     |     FADD     |                |    ( f2 f1 -- f3 )   | f3 = f2 + f1               |
|     f-     |     FSUB     |                |    ( f2 f1 -- f3 )   | f3 = f2 - f1               |
|  fnegate   |    FNEGATE   |                |       ( f1 -- f2 )   | f2 = -f1                   |
|    fabs    |     FABS     |                |       ( f1 -- f2 )   | f2 = abs(f1)               |
|     f.     |     FDOT     |                |       ( f1 -- )      |                            |
|     f*     |     FMUL     |                |    ( f2 f1 -- f3 )   | f3 = f2 * f1               |
|     f/     |     FDIV     |                |    ( f2 f1 -- f3 )   | f3 = f2 / f1               |
|   fsqrt    |    FSQRT     |                |       ( f1 -- f2 )   |                            |
|   ftrunc   |    FTRUNC    |                |       ( f1 -- f2 )   | f2 = int(f1), round to zero|
|            |    FFRAC     |                |       ( f1 -- f2 )   | f2 = f1 % 1.0              |
|    fexp    |     FEXP     |                |       ( f1 -- f2 )   | f2 = e^(f1)                |
|     fln    |      FLN     |                |       ( f1 -- f2 )   | f2 = ln(f1)                |
|    fmod    |     FMOD     |                |    ( f2 f1 -- f3 )   | f3 = f2 % f1               |
|     f2*    |     F2MUL    |                |       ( f1 -- f2 )   | f2 = f1 * 2.0              |
|     f2/    |     F2DIV    |                |       ( f1 -- f2 )   | f2 = f1 / 2.0              |
|    fsin    |     FSIN     |                |       ( f1 -- f2 )   | f2 = sin(f1), f1 <= ±π/2   |

### Logic

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/logic.m4

| original   |   M4 FORTH   |  optimization  |  data stack           |  r.a.s. | comment      |
| :--------: | :----------: | :------------: | :-------------------- | :------ | :----------- |
|    and     |     AND      |                |    ( x2 x1 -- x )     |         |              |
|     or     |      OR      |                |    ( x2 x1 -- x )     |         |
|    xor     |     XOR      |                |       ( x1 -- -x1 )   |         |
|    abs     |     ABS      |                |        ( n -- u )     |         |
|   invert   |    INVERT    |                |       ( x1 -- ~x1 )   |         |
|    true    |     TRUE     |                |          ( -- -1 )    |         |
|   false    |    FALSE     |                |          ( -- 0 )     |         |
|      =     |      EQ      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
|     0=     |     _0EQ     |                |       ( x1 -- f )     |         | f=(x1 == 0)
|    D0=     |     D0EQ     |                |    ( x1 x2 -- f )     |         | f=((x1|x2) == 0)
|     <>     |      NE      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
|      <     |      LT      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
|     0<     |     _0LT     |                |       ( x1 -- f )     |         | f=(x1 < 0)
|     <=     |      LE      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
|      >     |      GT      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
|     >=     |      GE      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
|     0>=    |     _0GE     |                |       ( x1 -- f )     |         | f=(x1 >= 0)
|     u<     |     ULT      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
|    u<=     |     ULE      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
|     u>     |     UGT      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
|    u>=     |     UGE      |                |    ( x2 x1 -- flag )  |         | TRUE=-1 FALSE=0
| x1 u >> x  |    RSHIFT    |                |    ( x1 u -- x1>>u )  |         |
| x1 u << x  |    LSHIFT    |                |    ( x1 u -- x1<<u )  |         |
| x1 1 >> x  |              |    XRSHIFT1    |      ( x1 -- x1>>1 )  |         | signed
| x1 1 << x  |              |    XLSHIFT1    |      ( x1 -- x1<<1 )  |         |
| u1 1 >> u  |              |   XURSHIFT1    |      ( u1 -- u1>>1 )  |         | unsigned
| u1 1 << u  |              |   XULSHIFT1    |      ( u1 -- u1<<1 )  |         |

### Device

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/device.m4

| original   |   M4 FORTH   |  optimization  |  data stack              |  return address stack |
| :--------: | :----------: | :------------: | :----------------------- | :-------------------- |
|     .      |     DOT      |   UDOT if > 0  |       ( x1 -- )          |                       |
|     u.     |     UDOT     |                |       ( x1 -- )          |                       |
|   dup .    |              |    DUP_DOT     |       ( x1 -- x1 )       |                       |
|   dup u.   |              |    DUP_UDOT    |       ( x1 -- x1 )       |                       |
|     .s     |     DOTS     |                | ( x3 x2 x1 -- x3 x2 x1 ) |                       |
|     cr     |      CR      |                |          ( -- )          |                       |
|    emit    |     EMIT     |                |      ( 'a' -- )          |                       |
|  'a' emit  |              |  PUTCHAR('a')  |          ( -- )          |                       |
|    type    |     TYPE     |                |   ( addr n -- )          |                       |
| 2dup type  |              |   _2DUP_TYPE   |   ( addr n -- addr n )   |                       |
| .( Hello)  |PRINT("Hello")|                |          ( -- )          |                       |
|     key    |      KEY     |                |          ( -- key )      |                       |
|   accept   |    ACCEPT    |                | ( addr max -- loaded )   |                       |

The problem with PRINT is that M4 ignores the `"`. M4 does not understand that `"` it introduces a string. So if there is a comma in the string, it would save only the part before the comma, because a comma separates another parameter.
Therefore, if there is a comma in the string, the inside must be wrapped in `{` `}`.

    PRINT(  "1. Hello{,} World! Use {,} {{1,2,3}} {{4}}")
    PRINT(  "2. Hello{, World! Use , {1,2,3} {4}}")
    PRINT( {"3. Hello, World! Use , {1,2,3} {4}"})

    STRING_SECTION:
    string103:
    db "3. Hello, World! Use , {1,2,3} {4}"
    size103 EQU $ - string103
    string102:
    db "2. Hello, World! Use , {1,2,3} {4}"
    size102 EQU $ - string102
    string101:
    db "1. Hello, World! Use , {1,2,3} {4}"
    size101 EQU $ - string101

And every `{` in the string must have a matching `}`. Otherwise, the macro will end in error.

### IF

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/if.m4

|   original   |   M4 FORTH   |    optimization    |   data stack        |  r.a.s. | comment          |
| :----------: | :----------: |  :---------------: | :------------------ | :------ | :--------------- |
|      if      |      IF      |                    |    ( flag -- )      |         |
|    dup if    |              |      DUP_IF        |    ( flag -- flag ) |         |
|     else     |     ELSE     |                    |         ( -- )      |         |
|     then     |     THEN     |                    |         ( -- )      |         |
|     0= if    |              |      _0EQ_IF       |      ( x1 -- )      |         |
|  dup 0= if   |              |     DUP_0EQ_IF     |      ( x1 -- x1 )   |         |
|     0< if    |              |      _0LT_IF       |      ( x1 -- )      |         |
|  dup 0< if   |              |     DUP_0LT_IF     |      ( x1 -- x1 )   |         |
|     0>= if   |              |      _0GE_IF       |      ( x1 -- )      |         |
|  dup 0>= if  |              |     DUP_0GE_IF     |      ( x1 -- x1 )   |         |
|    D0= if    |              |      D0EQ_IF       |    (x1 x2 -- )      |         |
| 2dup D0= if  |              |   _2DUP_D0EQ_IF    |    (x1 x2 -- x1 x2) |         |
|dup `5`  <  if|              |DUP_PUSH_LT_IF(`5`) |         ( -- )      |         |`(addr)` not supported
|dup `5`  <= if|              |DUP_PUSH_LE_IF(`5`) |         ( -- )      |         |`(addr)` not supported
|dup `5`  >  if|              |DUP_PUSH_GT_IF(`5`) |         ( -- )      |         |`(addr)` not supported
|dup `5`  >= if|              |DUP_PUSH_GE_IF(`5`) |         ( -- )      |         |`(addr)` not supported
|dup `5` u<  if|              |DUP_PUSH_ULT_IF(`5`)|         ( -- )      |         |`(addr)` not supported
|dup `5` u<= if|              |DUP_PUSH_ULE_IF(`5`)|         ( -- )      |         |`(addr)` not supported
|dup `5` u>  if|              |DUP_PUSH_UGT_IF(`5`)|         ( -- )      |         |`(addr)` not supported
|dup `5` u>= if|              |DUP_PUSH_UGE_IF(`5`)|         ( -- )      |         |`(addr)` not supported
|  2dup  =  if |              |    _2DUP_EQ_IF     |         ( -- )      |         |
|  2dup  <> if |              |    _2DUP_NE_IF     |         ( -- )      |         |
|  2dup  <  if |              |    _2DUP_LT_IF     |         ( -- )      |         |
|  2dup  <= if |              |    _2DUP_LE_IF     |         ( -- )      |         |
|  2dup  >  if |              |    _2DUP_GT_IF     |         ( -- )      |         |
|  2dup  >= if |              |    _2DUP_GE_IF     |         ( -- )      |         |
|  2dup u=  if |              |    _2DUP_UEQ_IF    |         ( -- )      |         |
|  2dup u<> if |              |    _2DUP_UNE_IF    |         ( -- )      |         |
|  2dup u<  if |              |    _2DUP_ULT_IF    |         ( -- )      |         |
|  2dup u<= if |              |    _2DUP_ULE_IF    |         ( -- )      |         |
|  2dup u>  if |              |    _2DUP_UGT_IF    |         ( -- )      |         |
|  2dup u>= if |              |    _2DUP_UGE_IF    |         ( -- )      |         |

### Function

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/function.m4

| original   |     M4 FORTH     |    optimization   |   data stack               |  return address stack |
| :--------: | :--------------: | :---------------: | :------------------------- | :-------------------- |
|    name    |    CALL(name)    |                   |     ( x2 x1 -- ret x2 x1 ) | ( -- )                |
|     :      |COLON(name,coment)|                   | ( ret x2 x1 -- x2 x1 )     | ( -- ret )            |
|     ;      |     SEMICOLON    |                   |           ( -- )           | ( ret -- )            |
|    exit    |       EXIT       |                   |           ( -- )           | ( ret -- )            |
|    name    |                  |    SCALL(name)    |     ( x2 x1 -- ret x2 x1 ) | ( -- )                |
|     :      |                  |SCOLON(name,coment)| ( ret x2 x1 -- ret x2 x1 ) | ( -- )                |
|     ;      |                  |     SSEMICOLON    | ( ret x2 x1 -- x2 x1 )     | ( -- )                |
|    exit    |                  |       SEXIT       | ( ret x2 x1 -- x2 x1 )     | ( -- )                |


### LOOP

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/loop.m4

    PUSH2(5,0)  DO        I DOT PUTCHAR({','})     LOOP             --> " 0, 1, 2, 3, 4,"
                XDO(5,0) XI DOT PUTCHAR({','})    XLOOP             --> " 0, 1, 2, 3, 4,"
                XDO(5,0) XI DOT PUTCHAR({','}) XADDLOOP(2)          --> " 0, 2, 4,"
    PUSH2(5,0) SDO       SI DOT PUTCHAR({','})    SLOOP             --> " 0, 1, 2, 3, 4,"
    PUSH(5)   SFOR       SI DOT PUTCHAR({','})    SNEXT             --> " 5, 4, 3, 2, 1, 0,"
    PUSH(5)    FOR        I DOT PUTCHAR({','})     NEXT             --> " 5, 4, 3, 2, 1, 0,"
    
    PUSH(5) BEGIN DUP_DOT            DUP_WHILE _1SUB PUTCHAR({','}) REPEAT DROP CR ;--> " 5, 4, 3, 2, 1, 0"
    PUSH(0) BEGIN DUP_DOT DUP PUSH(4) LT WHILE _1ADD PUTCHAR({','}) REPEAT DROP CR ;--> " 0, 1, 2, 3, 4"
    PUSH(0) BEGIN DUP_DOT DUP PUSH(4) LT WHILE _2ADD PUTCHAR({','}) REPEAT DROP CR ;--> " 0, 2, 4"
    
    BEGIN ... flag WHILE ... flag WHILE ... BREAK ... REPEAT|AGAIN|flag UNTIL

|  original    |   M4 FORTH   |  optimization  |   data stack                 |  return address stack |
|  :--------:  | :----------: | :------------: | :--------------------------- | :-------------------- |
|      do      |      DO      |                | ( stop index -- )            | ( -- stop index )     |
|     loop     |     LOOP     |                |            ( -- )            | ( s i -- s i+1 )      |
|   `2` +loop  |              |   _2ADDLOOP    |            ( -- )            | ( s i -- s i+2 )      |
|    unloop    |    UNLOOP    |                |          ( ? -- )            | ( ? -- )              |
|    leave     |    LEAVE     |                |          ( ? -- )            | ( ? -- )              |
|       i      |       I      |                |            ( -- index )      | ( index -- index )    |
|       j      |       J      |                |            ( -- j )          | ( j s i -- j s i )    |
|              |              |       SDO      | ( stop index -- stop index ) | ( -- )                |
|              |              |      SLOOP     | ( stop index -- stop index+1)| ( -- )                |
|              |              |       SI       |          ( i -- i i )        | ( -- )                |
|     for      |     FOR      |                |      ( index -- )            | ( -- index )          |
|     next     |     NEXT     |                |            ( -- )            | ( index -- index-1 )  |
|              |              |      SFOR      |      ( index -- index )      | ( -- )                |
|              |              |      SNEXT     |      ( index -- index-1 )    | ( -- )                |
|  `5` `1` do  |              |  XDO(`5`,`1`)  |            ( -- )            | ( -- `1` )            |
|              |              |     XLOOP      |            ( -- )            | ( index -- index+1 )  |
|  `2` +loop   |              |  XADDLOOP(`2`) |            ( -- )            | ( index -- index+`2` )|
|      i       |              |       XI       |            ( -- i )          | ( i -- i )            |
|      j       |              |       XJ       |            ( -- j )          | ( j i -- j i )        |
|      k       |              |       XK       |            ( -- k )          | ( k j i -- k j i )    |
|    begin     |    BEGIN     |                |            ( -- )            |                       |
|              |    BREAK     |                |            ( -- )            |                       |
|    while     |    WHILE     |                |       ( flag -- )            |                       |
|  dup while   |              |   DUP_WHILE    |       ( flag -- flag )       |                       |
|2dup  =  while|              | _2DUP_EQ_WHILE |            ( -- )            |                       |
|2dup  <> while|              | _2DUP_NE_WHILE |            ( -- )            |                       |
|2dup  <  while|              | _2DUP_LT_WHILE |            ( -- )            |                       |
|2dup  <= while|              | _2DUP_LE_WHILE |            ( -- )            |                       |
|2dup  >  while|              | _2DUP_GT_WHILE |            ( -- )            |                       |
|2dup  >= while|              | _2DUP_GE_WHILE |            ( -- )            |                       |
|2dup u=  while|              |_2DUP_UEQ_WHILE |            ( -- )            |                       |
|2dup u<> while|              |_2DUP_UNE_WHILE |            ( -- )            |                       |
|2dup u<  while|              |_2DUP_ULT_WHILE |            ( -- )            |                       |
|2dup u<= while|              |_2DUP_ULE_WHILE |            ( -- )            |                       |
|2dup u>  while|              |_2DUP_UGT_WHILE |            ( -- )            |                       |
|2dup u>= while|              |_2DUP_UGE_WHILE |            ( -- )            |                       |
|    repeat    |    REPEAT    |                |            ( -- )            |                       |
|    again     |    AGAIN     |                |            ( -- )            |                       |
|    until     |    UNTIL     |                |       ( flag -- )            |                       |


### Other

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/other.m4

|    original    |     M4 FORTH    |  optimization   |   data stack          | comment          |
| :------------: | :-------------: | :-------------: | :-------------------- | :--------------- |
|                |  INIT(RAS_addr) |                 |                       | save SP, set RAS |
|                |      STOP       |                 |          ( -- )       | load SP & HL'    |
|`1` constant ONE|CONSTANT(ONE,`1`)|                 |          ( -- )       |                  |
|    `3` var X   | VARIABLE(X,`1`) |                 |          ( -- )       |                  |
|   variable X   |   VARIABLE(X)   |                 |          ( -- )       |                  |
|        @       |      FETCH      |                 |     ( addr -- x )     | TOP = (addr)     |
|     addr @     |                 | PUSH_FETCH(addr)|          ( -- x )     | TOP = (addr)     |
|        !       |      STORE      |                 |   ( x addr -- )       | (addr) = x       |
|     addr !     |                 | PUSH_STORE(addr)|        ( x -- )       | (addr) = x       |
|       C@       |      CFETCH     |                 |     ( addr -- char )  | TOP = (addr)     |
|     addr C@    |                 |PUSH_CFETCH(addr)|          ( -- char )  | TOP = (addr)     |
|       C!       |      CSTORE     |                 |( char addr -- )       | (addr) = char    |
|     addr C!    |                 |PUSH_CSTORE(addr)|     ( char -- )       | (addr) = char    |
|   x addr +!    |    PLUS_STORE   |                 |   ( x addr -- )       | (addr) += x      |
|     cmove      |      CMOVE      |                 |( from to u -- )       | 8bit, addr++     |
|     cmove>     |     CMOVEGT     |                 |( from to u -- )       | 8bit, addr--     |
|      move      |       MOVE      |                 |( from to u -- )       | 16bit, addr++    |
|      move>     |      MOVEGT     |                 |( from to u -- )       | 16bit, addr++    |
| `seed` seed !  |                 | PUSH_STORE(SEED)|     ( seed -- )       |                  |
|       rnd      |       RND       |                 |          ( -- random )|                  |
|     random     |      RANDOM     |                 |      ( max -- random )| random < max     |
|                |     PUTPIXEL    |                 |       ( yx -- HL )    |                  |
### Output

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/output.m4

The small Runtime library.
Variable section.
String section.

## External links

http://wiki.laptop.org/go/Forth_Lessons

http://astro.pas.rochester.edu/Forth/forth-words.html

https://www.tutorialspoint.com/execute_forth_online.php

https://www.gnu.org/software/m4/manual/m4-1.4.15/html_node/index.html#Top
