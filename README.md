# M4 FORTH: A Forth compiler for the Z80 CPU and ZX Spectrum

A simple FORTH compiler created using M4 macros. Creates human readable and annotated code in the Z80 assembler. No peephole optimization is used, but a new word with optimized code is created for some frequently related words. For example, for the `dup number condition if`.
The small Runtime library for listing numbers and text is intended for the ZX Spectrum computer.

Despite its primitivity, M4 FORTH produces a shorter code and 2-4 times faster code than zd88k, probably the best compiler for the Z80.

https://github.com/DW0RKiN/M4_FORTH/tree/master/Benchmark

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

Or use a bash script:

    ./compile.sh my_program_name

## Hello World!

For clarity, macros are divided into several files and stored in the M4 directory.
To avoid having to manually include each file, a `FIRST.M4` file is created that includes all other files.
So the first thing that needs to be done is to include this file using:

    include(`./M4/FIRST.M4')dnl

On the first line immediately change quotes to `{` and `}`. All M4 macros use these new quotes.

All used library functions are automatically added at the end of the file. For example, listing a number, multiplying or dividing. Others add variables and strings. If you need to place something else behind them, you have to manually write:

    include({./M4/LAST.M4})dnl

And everything he writes underneath will be the last.

In order to be able to call a program from Basic and return it again without error, the `INIT()` and `STOP` macros must be used.
`INIT(xxx)` stores shadow registers and sets the initial value of the return address stack.

In order for the compiler not to compile the program from the zero address, it must still contain the ORG value. For example, ORG 0x8000.

File Hello.m4

    include(`./M4/FIRST.M4')dnl
    ORG 0x8000
    INIT(60000)
    PRINT("Hello World!")
    STOP

m4 Hello.m4

    ORG 0x8000

    ;   ===  b e g i n  ===
        ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
        ld    L, 0x1A       ; 2:7       init   Upper screen
        call 0x1605         ; 3:17      init   Open channel
        ld   HL, 60000      ; 3:10      init   Init Return address stack
        exx                 ; 1:4       init

        push DE             ; 1:11      print     "Hello World!"
        ld   BC, size101    ; 3:10      print     Length of string101
        ld   DE, string101  ; 3:10      print     Address of string101
        call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
        pop  DE             ; 1:10      print

    Stop:                   ;           stop
        ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
        ld   HL, 0x2758     ; 3:10      stop
        exx                 ; 1:4       stop
        ret                 ; 1:10      stop
    ;   =====  e n d  =====

    STRING_SECTION:
    string101:
    db "Hello World!"
    size101 EQU $ - string101


## Limitations of the M4 markup language

Macro names cannot be just `.` or `>`, but an alphanumeric name. So must be renamed to `DOT` or `LT`. `2dup` to `_2DUP`. `3` to `PUSH(3)`.
All FORTH words must be capitalized! Because `+` is written as `ADD`. And `add` is reserved for assembler instructions.

Theoretically, your function name or variable may conflict with the name of the macro used. So check it out. The worse case is when you make a mistake in the name of the macro. Then it will not expand and will probably be hidden in the comment of the previous macro.

https://github.com/DW0RKiN/M4_FORTH/blob/master/forth2m4.sh

This is a compiler from Forth to M4 FORTH written in bash. Manual adjustments are still needed. For example, move functions below STOP. Unknown words will try to be called as function names. It will try to find and combine optimized words, but only if they are on the same line and are separated only by white characters.

## Implemented words FORTH

### Stack manipulation

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/stack.m4

|<sub>       Original         |<sub>    M4 FORTH         |<sub> Optimization     |<sub>  Data stack                  |
| :-------------------------: | :----------------------: | :-------------------: | :-------------------------------- |
|<sub>          swap          |<sub>         SWAP        |<sub>                  |<sub>      ( x2 x1 -- x1 x2 )      |
|<sub>        swap over       |<sub>       SWAP OVER     |<sub>     SWAP_OVER    |<sub>      ( x2 x1 -- x1 x2 x1 )   |
|<sub>        swap `7`        |<sub>    SWAP PUSH(`7`)   |<sub>  SWAP_PUSH(`7`)  |<sub>      ( x2 x1 -- x1 x2 `7` )  |
|<sub>        `6` swap        |<sub>    PUSH(`6`) SWAP   |<sub>  PUSH_SWAP(`6`)  |<sub>         ( x1 -- `6` x1 )     |
|<sub>      dup `5` swap      |<sub>  DUP PUSH(`5`) SWAP |<sub>DUP_PUSH_SWAP(`5`)|<sub>         ( x1 -- x1 `5` x1 )  |
|<sub>         2swap          |<sub>        _2SWAP       |<sub>                  |<sub> (x1 x2 x3 x4 -- x3 x4 x1 x2) |
|<sub>           dup          |<sub>          DUP        |<sub>                  |<sub>         ( x1 -- x1 x1 )      |
|<sub>          ?dup          |<sub>     QUESTIONDUP     |<sub>                  |<sub>         ( x1 -- 0 \| x1 x1 ) |
|<sub>          2dup          |<sub>        _2DUP        |<sub>                  |<sub>      ( x2 x1 -- x2 x1 x2 x1 )|
|<sub>          drop          |<sub>         DROP        |<sub>                  |<sub>         ( x1 -- )            |
|<sub>         2drop          |<sub>        _2DROP       |<sub>                  |<sub>      ( x2 x1 -- )            |
|<sub>          nip           |<sub>          NIP        |<sub>                  |<sub>      ( x2 x1 -- x1 )         |
|<sub>          2nip          |<sub>         2NIP        |<sub>                  |<sub>    ( d c b a -- b a )        |
|<sub>          tuck          |<sub>         TUCK        |<sub>                  |<sub>      ( x2 x1 -- x1 x2 x1 )   |
|<sub>         2tuck          |<sub>       _2TUCK        |<sub>                  |<sub>    ( d c b a -- b a d c b a )|
|<sub>          over          |<sub>         OVER        |<sub>                  |<sub>      ( x2 x1 -- x2 x1 x2 )   |
|<sub>        over swap       |<sub>       OVER SWAP     |<sub>     OVER_SWAP    |<sub>      ( x2 x1 -- x2 x2 x1 )   |
|<sub>         2over          |<sub>       _2OVER        |<sub>                  |<sub>    ( a b c d -- a b c d a b )|
|<sub>          rot           |<sub>         ROT         |<sub>                  |<sub>   ( x3 x2 x1 -- x2 x1 x3 )   |
|<sub>        rot drop        |<sub>       ROT DROP      |<sub>     ROT_DROP     |<sub>   ( x3 x2 x1 -- x2 x1 )      |
|<sub>         2rot           |<sub>        _2ROT        |<sub>                  |<sub>( f e d c b a -- d c b a f e )|
|<sub>         -rot           |<sub>         NROT        |<sub>                  |<sub>   ( x3 x2 x1 -- x1 x3 x2 )   |
|<sub>        -2rot           |<sub>        N2ROT        |<sub>                  |<sub>( f e d c b a -- b a f e d c )|
|<sub>       -rot nip         |<sub>       NROT NIP      |<sub>     NROT_NIP     |<sub>   ( x3 x2 x1 -- x1 x2 )      |
|<sub>       -rot 2swap       |<sub>     NROT _2SWAP     |<sub>    NROT_2SWAP    |<sub>( x4 x3 x2 x1 -- x3 x2 x4 x1 )|
|<sub>  -rot swap 2swap swap  |<sub>NROT SWAP _2SWAP SWAP|<sub>    STACK_BCAD    |<sub>    ( d c b a -- b c a d )    |
|<sub>     over 2over drop    |<sub>  OVER _2OVER DROP   |<sub>    STACK_CBABC   |<sub>      ( c b a -- c b a b c )  |
|<sub>     over `3` pick      |<sub> OVER PUSH(`3`) PICK |<sub>    STACK_CBABC   |<sub>      ( c b a -- c b a b c )  |
|<sub> `2` pick `2` pick swap |<sub>         ....        |<sub>    STACK_CBABC   |<sub>      ( c b a -- c b a b c )  |
|<sub>2over nip 2over nip swap|<sub>         ....        |<sub>    STACK_CBABC   |<sub>      ( c b a -- c b a b c )  |
|<sub>         `123`          |<sub>      PUSH(`123`)    |<sub>                  |<sub>            ( -- `123` )      |
|<sub>         `2` `1`        |<sub> PUSH(`2`) PUSH(`1`) |<sub>  PUSH2(`2`,`1`)  |<sub>            ( -- `2` `1` )    |
|<sub>       addr `7` @       |<sub>     PUSH((addr))    |<sub>                  |<sub>    *addr = 7 --> ( -- `7`)   |
|<sub>                        |<sub>                     |<sub>  PUSH2((A),`2`)  |<sub>    *A = 4 --> ( -- `4` `2` ) |
|<sub>       drop `5`         |<sub>                     |<sub>  DROP_PUSH(`5`)  |<sub>         ( x1 -- `5`)         |
|<sub>        dup `4`         |<sub>                     |<sub>   DUP_PUSH(`4`)  |<sub>         ( x1 -- x1 x1 `4`)   |
|<sub>          pick          |<sub>         PICK        |<sub>                  |<sub>          ( u -- xu )         |
|<sub>        `2` pick        |<sub>                     |<sub>  PUSH_PICK(`2`)  |<sub>   ( x2 x1 x0 -- x2 x1 x0 x2 )|

|<sub>       Original         |<sub>    M4 FORTH         |<sub>  Data stack                  |<sub> Return address stack |
| :-------------------------: | :----------------------: | :-------------------------------- | :------------------------ |
|<sub>           >r           |<sub>         TO_R        |<sub>         ( x1 -- )            |<sub>        ( -- x1 )     |
|<sub>           r>           |<sub>        R_FROM       |<sub>            ( -- x1 )         |<sub>     ( x1 -- )        |
|<sub>           r@           |<sub>        R_FETCH      |<sub>            ( -- x1 )         |<sub>     ( x1 -- x1 )     |
|<sub>         rdrop          |<sub>         RDROP       |<sub>            ( -- )            |<sub>     ( x1 -- )        |
|<sub>    r> r> swap >r >r    |<sub>         RSWAP       |<sub>            ( -- )            |<sub>    ( b a -- a b )    |
|<sub>          2>r           |<sub>       _2TO_R        |<sub>        ( b a -- )            |<sub>        ( -- b a )    |
|<sub>          2r>           |<sub>      _2R_FROM       |<sub>            ( -- b a )        |<sub>    ( b a -- )        |
|<sub>          2r@           |<sub>      _2R_FETCH      |<sub>            ( -- b a )        |<sub>    ( b a -- b a )    |
|<sub>        2rdrop          |<sub>       _2RDROP       |<sub>            ( -- )            |<sub>    ( b a -- )        |
|<sub> 2r> 2r> 2swap 2>r 2>r  |<sub>       _2RSWAP       |<sub>            ( -- )            |<sub>( d c b a -- b a d c )|

### Arithmetic

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/arithmetic.m4

Support for fast multiplication or division by a constant is here:

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/divmul

|<sub> Original   |<sub>   M4 FORTH   |<sub>  Optimization  |<sub>  Data stack               |
| :-------------: | :---------------: | :-----------------: | :----------------------------- |
|<sub>     +      |<sub>      ADD     |<sub>                |<sub>   ( x2 x1 -- x )          |
|<sub>   `3` +    |<sub>              |<sub>  PUSH_ADD(`3`) |<sub>       ( x -- x+`3` )      |
|<sub>   dup +    |<sub>              |<sub>     DUP_ADD    |<sub>       ( x -- x+x )        |
|<sub>   over +   |<sub>              |<sub>    OVER_ADD    |<sub>   ( x2 x1 -- x2 x1+x2  )  |
|<sub>     -      |<sub>      SUB     |<sub>                |<sub>   ( x2 x1 -- x )          |
|<sub>   `3` -    |<sub>              |<sub>  PUSH_SUB(`3`) |<sub>       ( x -- x-`3` )      |
|<sub>   over -   |<sub>              |<sub>    OVER_SUB    |<sub>   ( x2 x1 -- x2 x1-x2  )  |
|<sub>    max     |<sub>      MAX     |<sub>                |<sub>   ( x2 x1 -- max )        |
|<sub>  `3` max   |<sub> PUSH_MAX(`3`)|<sub>                |<sub>      ( x1 -- max )        |
|<sub>    min     |<sub>      MIN     |<sub>                |<sub>   ( x2 x1 -- min )        |
|<sub>  `3` min   |<sub> PUSH_MIN(`3`)|<sub>                |<sub>      ( x1 -- min )        |
|<sub>   negate   |<sub>     NEGATE   |<sub>                |<sub>      ( x1 -- -x1 )        |
|<sub>    abs     |<sub>      ABS     |<sub>                |<sub>       ( n -- u )          |
|<sub>     *      |<sub>      MUL     |<sub>                |<sub>   ( x2 x1 -- x )          |
|<sub>     /      |<sub>      DIV     |<sub>                |<sub>   ( x2 x1 -- x )          |
|<sub>    mod     |<sub>      MOD     |<sub>                |<sub>   ( x2 x1 -- x )          |
|<sub>    /mod    |<sub>    DIVMOD    |<sub>                |<sub>   ( x2 x1 -- x )          |
|<sub>     u*     |<sub>      MUL     |<sub>                |<sub>   ( x2 x1 -- x )          |
|<sub>  `+12` *   |<sub>              |<sub> PUSH_MUL(`12`) |<sub>   ( x2 x1 -- x )          |
|<sub>     u/     |<sub>     UDIV     |<sub>                |<sub>   ( x2 x1 -- x )          |
|<sub>    umod    |<sub>     UMOD     |<sub>                |<sub>   ( x2 x1 -- x )          |
|<sub>    u/mod   |<sub>    UDIVMOD   |<sub>                |<sub>   ( x2 x1 -- rem quot )   |
|<sub>     1+     |<sub>    _1ADD     |<sub>                |<sub>      ( x1 -- x1++ )       |
|<sub>     1-     |<sub>    _1SUB     |<sub>                |<sub>      ( x1 -- x1-- )       |
|<sub>     2+     |<sub>    _2ADD     |<sub>                |<sub>      ( x1 -- x1+2 )       |
|<sub>     2-     |<sub>    _2SUB     |<sub>                |<sub>      ( x1 -- x1-2 )       |
|<sub>     2*     |<sub>    _2MUL     |<sub>                |<sub>      ( x1 -- x1*2 )       |
|<sub>     2/     |<sub>    _2DIV     |<sub>                |<sub>      ( x1 -- x1/2 )       |
|<sub>    256*    |<sub>   _256MUL    |<sub>                |<sub>      ( x1 -- x1*256 )     |
|<sub>    256/    |<sub>   _256DIV    |<sub>                |<sub>      ( x1 -- x1/256 )     |

### Floating-point

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/floating.m4

Danagy format `S EEE EEEE MMMM MMMM`

https://github.com/DW0RKiN/Floating-point-Library-for-Z80

For a logical comparison of two numbers as f1> f2, exactly the same result applies as for a comparison of two integer numbers with a sign.

|<sub> Original   |<sub>   M4 FORTH   |<sub>  Data stack          |<sub>  Comment                   |
| :-------------: | :---------------: | :------------------------ | :------------------------------ |
|<sub>    s>f     |<sub>      S2F     |<sub>       ( s1 -- f1 )   |<sub>                            |
|<sub>    u>f     |<sub>      U2F     |<sub>       ( u1 -- f1 )   |<sub>                            |
|<sub>    f>s     |<sub>      F2S     |<sub>       ( f1 -- s1 )   |<sub>                            |
|<sub>    f>u     |<sub>      F2U     |<sub>       ( f1 -- u1 )   |<sub>                            |
|<sub>     f+     |<sub>     FADD     |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 + f1               |
|<sub>     f-     |<sub>     FSUB     |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 - f1               |
|<sub>  fnegate   |<sub>    FNEGATE   |<sub>       ( f1 -- f2 )   |<sub> f2 = -f1                   |
|<sub>    fabs    |<sub>     FABS     |<sub>       ( f1 -- f2 )   |<sub> f2 = abs(f1)               |
|<sub>     f.     |<sub>     FDOT     |<sub>       ( f1 -- )      |<sub>                            |
|<sub>     f*     |<sub>     FMUL     |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 * f1               |
|<sub>     f/     |<sub>     FDIV     |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 / f1               |
|<sub>   fsqrt    |<sub>    FSQRT     |<sub>       ( f1 -- f2 )   |<sub>                            |
|<sub>   ftrunc   |<sub>    FTRUNC    |<sub>       ( f1 -- f2 )   |<sub> f2 = int(f1), round to zero|
|<sub>            |<sub>    FFRAC     |<sub>       ( f1 -- f2 )   |<sub> f2 = f1 % 1.0              |
|<sub>    fexp    |<sub>     FEXP     |<sub>       ( f1 -- f2 )   |<sub> f2 = e^(f1)                |
|<sub>     fln    |<sub>      FLN     |<sub>       ( f1 -- f2 )   |<sub> f2 = ln(f1)                |
|<sub>    fmod    |<sub>     FMOD     |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 % f1               |
|<sub>     f2*    |<sub>     F2MUL    |<sub>       ( f1 -- f2 )   |<sub> f2 = f1 * 2.0              |
|<sub>     f2/    |<sub>     F2DIV    |<sub>       ( f1 -- f2 )   |<sub> f2 = f1 / 2.0              |
|<sub>    fsin    |<sub>     FSIN     |<sub>       ( f1 -- f2 )   |<sub> f2 = sin(f1), f1 <= ±π/2   |

### Logic

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/logic.m4

|<sub>   Original   |<sub>      M4 FORTH       |<sub>    Optimization     |<sub>  Data stack           |<sub> Comment             |
| :---------------: | :----------------------: | :----------------------: | :------------------------- | :----------------------- |
|<sub>     and      |<sub>         AND         |<sub>                     |<sub>   ( x2 x1 -- x )      |<sub>                     |
|<sub>    `3` and   |<sub>                     |<sub>    PUSH_AND(`3`)    |<sub>       ( x -- x & `3`) |<sub>                     |
|<sub>      or      |<sub>          OR         |<sub>                     |<sub>   ( x2 x1 -- x )      |<sub>                     |
|<sub>    `3` or    |<sub>                     |<sub>    PUSH_OR(`3`)     |<sub>       ( x -- x \| `3`)|<sub>                     |
|<sub>     xor      |<sub>         XOR         |<sub>                     |<sub>      ( x1 -- -x1 )    |<sub>                     |
|<sub>    `3` xor   |<sub>                     |<sub>    PUSH_XOR(`3`)    |<sub>       ( x -- x ^ `3`) |<sub>                     |
|<sub>     abs      |<sub>         ABS         |<sub>                     |<sub>       ( n -- u )      |<sub>
|<sub>    invert    |<sub>        INVERT       |<sub>                     |<sub>      ( x1 -- ~x1 )    |<sub>
|<sub>    within    |<sub>        WITHIN       |<sub>                     |<sub>   ( c b a -- flag )   |<sub>(a-b) (c-b) U<
|<sub>`4` `7` within|<sub>PUSH2(`4`,`7`) WITHIN|<sub>PUSH2_WITHIN(`4`,`7`)|<sub>   ( a -- flag )       |<sub>4..6
|<sub>     true     |<sub>         TRUE        |<sub>                     |<sub>         ( -- -1 )     |<sub>
|<sub>    false     |<sub>        FALSE        |<sub>                     |<sub>         ( -- 0 )      |<sub>
|<sub>       =      |<sub>          EQ         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>      0=      |<sub>         _0EQ        |<sub>                     |<sub>      ( x1 -- f )      |<sub> f=(x1 == 0)
|<sub>     D0=      |<sub>         D0EQ        |<sub>                     |<sub>   ( x1 x2 -- f )      |<sub> f=((x1|x2) == 0)
|<sub>      <>      |<sub>          NE         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>       <      |<sub>          LT         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>      0<      |<sub>         _0LT        |<sub>                     |<sub>      ( x1 -- f )      |<sub> f=(x1 < 0)
|<sub>      <=      |<sub>          LE         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>       >      |<sub>          GT         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>      >=      |<sub>          GE         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>      0>=     |<sub>         _0GE        |<sub>                     |<sub>      ( x1 -- f )      |<sub> f=(x1 >= 0)
|<sub>      u<      |<sub>         ULT         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>     u<=      |<sub>         ULE         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>      u>      |<sub>         UGT         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>     u>=      |<sub>         UGE         |<sub>                     |<sub>   ( x2 x1 -- flag )   |<sub> TRUE=-1 FALSE=0
|<sub>  x1 u >> x   |<sub>        RSHIFT       |<sub>                     |<sub>   ( x1 u -- x1>>u )   |<sub>
|<sub>  x1 u << x   |<sub>        LSHIFT       |<sub>                     |<sub>   ( x1 u -- x1<<u )   |<sub>
|<sub>  x1 1 >> x   |<sub>                     |<sub>       XRSHIFT1      |<sub>     ( x1 -- x1>>1 )   |<sub> signed
|<sub>  x1 1 << x   |<sub>                     |<sub>       XLSHIFT1      |<sub>     ( x1 -- x1<<1 )   |<sub>
|<sub>  u1 1 >> u   |<sub>                     |<sub>      XURSHIFT1      |<sub>     ( u1 -- u1>>1 )   |<sub> unsigned
|<sub>  u1 1 << u   |<sub>                     |<sub>      XULSHIFT1      |<sub>     ( u1 -- u1<<1 )   |<sub>


### Device

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/device.m4

|<sub> Original   |<sub>    M4 FORTH     |<sub>   Optimization   |<sub>  Data stack              |<sub>   Comment    |
| :-------------: | :------------------: | :-------------------: | :---------------------------- | :---------------- |
|<sub>     .      |<sub>       DOT       |<sub>    UDOT if > 0   |<sub>       ( x1 -- )          |<sub>              |
|<sub>     u.     |<sub>      UDOT       |<sub>                  |<sub>       ( x1 -- )          |<sub>              |
|<sub>   dup .    |<sub>                 |<sub>     DUP_DOT      |<sub>       ( x1 -- x1 )       |<sub>              |
|<sub>   dup u.   |<sub>                 |<sub>     DUP_UDOT     |<sub>       ( x1 -- x1 )       |<sub>              |
|<sub>     .s     |<sub>      DOTS       |<sub>                  |<sub> ( x3 x2 x1 -- x3 x2 x1 ) |<sub>              |
|<sub>     cr     |<sub>       CR        |<sub>                  |<sub>          ( -- )          |<sub>              |
|<sub>    emit    |<sub>      EMIT       |<sub>                  |<sub>      ( 'a' -- )          |<sub>              |
|<sub>  dup emit  |<sub>    DUP  EMIT    |<sub>    DUP_EMIT      |<sub>      ( 'a' -- 'a' )      |<sub>              |
|<sub>   space    |<sub>      SPACE      |<sub>                  |<sub>          ( -- )          |<sub>              |
|<sub>  'a' emit  |<sub>                 |<sub>   PUTCHAR('a')   |<sub>          ( -- )          |<sub>              |
|<sub>    type    |<sub>      TYPE       |<sub>                  |<sub>   ( addr n -- )          |<sub>              |
|<sub> 2dup type  |<sub>                 |<sub>    _2DUP_TYPE    |<sub>   ( addr n -- addr n )   |<sub>              |
|<sub> .( Hello)  |<sub> PRINT({"Hello"})|<sub>                  |<sub>          ( -- )          |<sub>              |
|<sub> ." Hello"  |<sub> PRINT({"Hello"})|<sub>                  |<sub>          ( -- )          |<sub>              |
|<sub> .( Hello)  |<sub>                 |<sub>PRINT_Z({"Hello"})|<sub>          ( -- )          |<sub>C-style string|
|<sub> ." Hello"  |<sub>                 |<sub>PRINT_Z({"Hello"})|<sub>          ( -- )          |<sub>C-style string|
|<sub> s" Hello"  |<sub>STRING({"Hello"})|<sub>                  |<sub>          ( -- addr n )   |<sub>              |
|<sub>     key    |<sub>       KEY       |<sub>                  |<sub>          ( -- key )      |<sub>              |
|<sub>   accept   |<sub>     ACCEPT      |<sub>                  |<sub> ( addr max -- loaded )   |<sub>              |

The non-standard PRINT_Z extends each text string by zero bytes, but in return it cuts each string print by 5 bytes. An eight-byte routine to print zero-terminated strings must be added to the code, making it more convenient from printing 2 strings.

./check_word.sh 'PRINT_Z({"Hello!"})'

        ld   BC, string101  ; 3:10      print_z   Address of null-terminated string101
        call PRINT_STRING_Z ; 3:17      print_z
    ; Print C-style stringZ
    ; In: BC = addr
    ; Out: BC = addr zero
        rst   0x10          ; 1:11      print_string_z putchar with ZX 48K ROM in, this will print char in A
        inc  BC             ; 1:6       print_string_z
    PRINT_STRING_Z:         ;           print_string_z
        ld    A,(BC)        ; 1:7       print_string_z
        or    A             ; 1:4       print_string_z
        jp   nz, $-4        ; 3:10      print_string_z
        ret                 ; 1:10      print_string_z

    STRING_SECTION:
    string101:
    db "Hello!", 0x00
    size101 EQU $ - string101

./check_word 'PRINT({"Hello!"})'

        push DE             ; 1:11      print     "Hello!"
        ld   BC, size101    ; 3:10      print     Length of string101
        ld   DE, string101  ; 3:10      print     Address of string101
        call 0x203C         ; 3:17      print     Print our string with ZX 48K ROM
        pop  DE             ; 1:10      print

    STRING_SECTION:
    string101:
    db "Hello!"
    size101 EQU $ - string101

ZX ROM

    0x203C:
        ld    A, B          ; 1:4
        or    C             ; 1:4
        dec  BC             ; 1:6
        ret  z              ; 1:5/11
        ld    A,(DE)        ; 1:7
        inc  DE             ; 1:6
        rst   0x10          ; 1:11
        jr  0x203C          ; 2:12

The problem with PRINT is that M4 ignores the `"`. M4 does not understand that `"` it introduces a string. The M4 is set as an opening character `{` and as an ending character `}`.

So everything will only work if:

- The string contains no comma. Because a comma completely breaks the definition of a macro, and then on the output you read something like:

      m4:stdin:1: ERROR: end of file in string

- The text contains no reserved Forth word such as `SWAP`. Because it would change the word to instruction `ex DE,HL`

- The text has no more closing braces than opening braces in any section. Such as `} {`. And there's not a single closing brace missing at the end. `{ }} `. Because it would break the definition of a macro again.

- The same goes for brackets: `())`.

So if there is a comma in the string, it would save only the part before the comma, because a comma separates another parameter.
Therefore, if there is a comma in the string, the inside must be wrapped in `{` `}`.

    PRINT(  "1. Hello{,} World! {SWAP} {,} {{1,2,3}} {{4}}")
    PRINT(  "2. Hello{, World! {SWAP} , {1,2,3} {4}}")

And the easiest method is:

    PRINT( {"3. Hello, World! SWAP , {1,2,3} {4}"})

    STRING_SECTION:
    string103:
    db "3. Hello, World! SWAP , {1,2,3} {4}"
    size103 EQU $ - string103
    string102:
    db "2. Hello, World! SWAP , {1,2,3} {4}"
    size102 EQU $ - string102
    string101:
    db "1. Hello, World! SWAP , {1,2,3} {4}"
    size101 EQU $ - string101

This is going to solve all the problems except one problem. An odd number of braces, or more opening braces at any given moment.
Fortunately, the odd number of braces can be solved by writing `{` as `0x7b` and `}` as `0x7D`.

    PRINT({"Text, ",0x7d," next text"})

If you're trying to insert duplicate text, the translator recognizes it and doesn't create a copy, but a link to the first use. And that includes the word STRING, so watch out if you edit a chain like that. Same sentences where one is terminated by a zero character and the other has no terminating zero character are understood as different strings.

### IF

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/if.m4

|<sub>   Original   |<sub>   M4 FORTH   |<sub>    Optimization    |<sub>   Data stack        |<sub> Comment     |
| :---------------: | :---------------: | :---------------------: | :----------------------- | :--------------- |
|<sub>      if      |<sub>      IF      |<sub>                    |<sub>    ( flag -- )      |                  |
|<sub>    dup if    |<sub>              |<sub>      DUP_IF        |<sub>    ( flag -- flag ) |                  |
|<sub>     else     |<sub>     ELSE     |<sub>                    |<sub>         ( -- )      |                  |
|<sub>     then     |<sub>     THEN     |<sub>                    |<sub>         ( -- )      |                  |
|<sub>     0= if    |<sub>              |<sub>      _0EQ_IF       |<sub>      ( x1 -- )      |                  |
|<sub>  dup 0= if   |<sub>              |<sub>     DUP_0EQ_IF     |<sub>      ( x1 -- x1 )   |                  |
|<sub>     0< if    |<sub>              |<sub>      _0LT_IF       |<sub>      ( x1 -- )      |                  |
|<sub>  dup 0< if   |<sub>              |<sub>     DUP_0LT_IF     |<sub>      ( x1 -- x1 )   |                  |
|<sub>     0>= if   |<sub>              |<sub>      _0GE_IF       |<sub>      ( x1 -- )      |                  |
|<sub>  dup 0>= if  |<sub>              |<sub>     DUP_0GE_IF     |<sub>      ( x1 -- x1 )   |                  |
|<sub>    D0= if    |<sub>              |<sub>      D0EQ_IF       |<sub>    (x1 x2 -- )      |                  |
|<sub> 2dup D0= if  |<sub>              |<sub>   _2DUP_D0EQ_IF    |<sub>    (x1 x2 -- x1 x2) |                  |
|<sub>     =  if    |<sub>              |<sub>       EQ_IF        |<sub>    (x1 x2 -- )      |                  |
|<sub>     <> if    |<sub>              |<sub>       NE_IF        |<sub>    (x1 x2 -- )      |                  |
|<sub>     <  if    |<sub>              |<sub>       LT_IF        |<sub>    (x1 x2 -- )      |                  |
|<sub>     <= if    |<sub>              |<sub>       LE_IF        |<sub>    (x1 x2 -- )      |                  |
|<sub>     >  if    |<sub>              |<sub>       GT_IF        |<sub>    (x1 x2 -- )      |                  |
|<sub>     >= if    |<sub>              |<sub>       GE_IF        |<sub>    (x1 x2 -- )      |                  |
|<sub>    u=  if    |<sub>              |<sub>       UEQ_IF       |<sub>    (x1 x2 -- )      |                  |
|<sub>    u<> if    |<sub>              |<sub>       UNE_IF       |<sub>    (x1 x2 -- )      |                  |
|<sub>    u<  if    |<sub>              |<sub>       ULT_IF       |<sub>    (x1 x2 -- )      |                  |
|<sub>    u<= if    |<sub>              |<sub>       ULE_IF       |<sub>    (x1 x2 -- )      |                  |
|<sub>    u>  if    |<sub>              |<sub>       UGT_IF       |<sub>    (x1 x2 -- )      |                  |
|<sub>    u>= if    |<sub>              |<sub>       UGE_IF       |<sub>    (x1 x2 -- )      |                  |
|<sub>  `3` =  if   |<sub>              |<sub>    PUSH_EQ_IF      |<sub>       (x1 -- )      |                  |
|<sub>  `3` <> if   |<sub>              |<sub>    PUSH_NE_IF      |<sub>       (x1 -- )      |                  |
|<sub>dup `5`  =  if|<sub>              |<sub>DUP_PUSH_CEQ_IF(`5`)|<sub>         ( -- )      |<sub>unsigned char|
|<sub>dup `5`  <> if|<sub>              |<sub>DUP_PUSH_CNE_IF(`5`)|<sub>         ( -- )      |<sub>unsigned char|
|<sub>dup `5`  =  if|<sub>              |<sub>DUP_PUSH_EQ_IF(`5`) |<sub>         ( -- )      |                  |
|<sub>dup `5`  <> if|<sub>              |<sub>DUP_PUSH_NE_IF(`5`) |<sub>         ( -- )      |                  |
|<sub>dup `5`  <  if|<sub>              |<sub>DUP_PUSH_LT_IF(`5`) |<sub>         ( -- )      |                  |
|<sub>dup `5`  <= if|<sub>              |<sub>DUP_PUSH_LE_IF(`5`) |<sub>         ( -- )      |                  |
|<sub>dup `5`  >  if|<sub>              |<sub>DUP_PUSH_GT_IF(`5`) |<sub>         ( -- )      |                  |
|<sub>dup `5`  >= if|<sub>              |<sub>DUP_PUSH_GE_IF(`5`) |<sub>         ( -- )      |                  |
|<sub>dup `5` u=  if|<sub>              |<sub>DUP_PUSH_UEQ_IF(`5`)|<sub>         ( -- )      |                  |
|<sub>dup `5` u<> if|<sub>              |<sub>DUP_PUSH_UNE_IF(`5`)|<sub>         ( -- )      |                  |
|<sub>dup `5` u<  if|<sub>              |<sub>DUP_PUSH_ULT_IF(`5`)|<sub>         ( -- )      |                  |
|<sub>dup `5` u<= if|<sub>              |<sub>DUP_PUSH_ULE_IF(`5`)|<sub>         ( -- )      |                  |
|<sub>dup `5` u>  if|<sub>              |<sub>DUP_PUSH_UGT_IF(`5`)|<sub>         ( -- )      |                  |
|<sub>dup `5` u>= if|<sub>              |<sub>DUP_PUSH_UGE_IF(`5`)|<sub>         ( -- )      |                  |
|<sub>`3` over <> if|<sub>              |<sub> DUP_PUSH_NE_IF(`3`)|<sub>       (x1 -- )      |                  |
|<sub>     dtto     |<sub>              |<sub>        dtto        |<sub>                     |                  |
|<sub>  2dup  =  if |<sub>              |<sub>    _2DUP_EQ_IF     |<sub>         ( -- )      |                  |
|<sub>  2dup  <> if |<sub>              |<sub>    _2DUP_NE_IF     |<sub>         ( -- )      |                  |
|<sub>  2dup  <  if |<sub>              |<sub>    _2DUP_LT_IF     |<sub>         ( -- )      |                  |
|<sub>  2dup  <= if |<sub>              |<sub>    _2DUP_LE_IF     |<sub>         ( -- )      |                  |
|<sub>  2dup  >  if |<sub>              |<sub>    _2DUP_GT_IF     |<sub>         ( -- )      |                  |
|<sub>  2dup  >= if |<sub>              |<sub>    _2DUP_GE_IF     |<sub>         ( -- )      |                  |
|<sub>  2dup u=  if |<sub>              |<sub>    _2DUP_UEQ_IF    |<sub>         ( -- )      |                  |
|<sub>  2dup u<> if |<sub>              |<sub>    _2DUP_UNE_IF    |<sub>         ( -- )      |                  |
|<sub>  2dup u<  if |<sub>              |<sub>    _2DUP_ULT_IF    |<sub>         ( -- )      |                  |
|<sub>  2dup u<= if |<sub>              |<sub>    _2DUP_ULE_IF    |<sub>         ( -- )      |                  |
|<sub>  2dup u>  if |<sub>              |<sub>    _2DUP_UGT_IF    |<sub>         ( -- )      |                  |
|<sub>  2dup u>= if |<sub>              |<sub>    _2DUP_UGE_IF    |<sub>         ( -- )      |                  |

### CASE OF ENDOF ENDCASE

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/case.m4

The CASE statement is defined in the standard to remove the tested value. It does that every successful OF calls DROP and if there's no OF success and the program gets to the start of ENDCASE then DROP calls him. The default part of the code is supposed to make the test value accessible.
This prevents any optimization of the repeating code unless we create OF as a procedure. Because sometimes I need to preserve the value, and the only advantage of standard implementation is that the source code looks simpler, I decided to deviate from the norm and create a CASE statement that doesn't change the stack.

Non standard CASE ( n -- n ):

    CASE
       n1 OF       code1 ENDOF
       PUSH_OF(n2) code2 ENDOF
       ...
           default-code
     ENDCASE

In order to write directly in FORTH another way CASE I created the word ZERO_OF. That's just testing to see if the TOS is zero. If we don't care that the test value is undefined at the end, then a very efficient but messy CASE can be written:

     DUP
     CASE
                    ZERO_OF PRINT("zero")   ENDOF
        _1SUB       ZERO_OF PRINT("one")    ENDOF
        _1SUB       ZERO_OF PRINT("two")    ENDOF
        _1SUB       ZERO_OF PRINT("three")  ENDOF
        _1SUB       ZERO_OF PRINT("four")   ENDOF
        _1SUB       ZERO_OF PRINT("five")   ENDOF
        _1SUB       ZERO_OF PRINT("six")    ENDOF
        _1SUB       ZERO_OF PRINT("seven")  ENDOF
        PUSH_SUB(3) ZERO_OF PRINT("ten")    ENDOF
        _1SUB       ZERO_OF PRINT("eleven") ENDOF
        _1SUB       ZERO_OF PRINT("twelve") ENDOF
        PUSH_ADD(12) DOT DUP
     ENDCASE
     DROP

Because 16-bit CASE is very inefficient on the Z80 I also added 8-bit CASE. For both the lower apartment and the higher. Both options ignore the second TOS byte.
The CASE reads the test value into the accumulator A at the beginning and uses the "cp number" instruction to perform the OF part.

Non standard 8-bit CASE ( n -- n ) ignores hi byte:

     LO_CASE
       LO_OF(n1) code1 LO_ENDOF
       LO_OF(n2) code2 LO_ENDOF
       ...
           default-code
     LO_ENDCASE ( n -- n )

Non standard 8-bit CASE ( n -- n ) ignores lo byte:

     HI_CASE
       HI_OF(n1) code1 HI_ENDOF
       HI_OF(n2) code2 HI_ENDOF
       ...
           default-code
     HI_ENDCASE

For compatibility with standard CASE ( n -- ) must use DROP:

     CASE
       n1 OF DROP code1 ENDOF
       n2 OF DROP code2 ENDOF
       ...
           default-code
       DROP
     ENDCASE ( n -- )

     LO_CASE
       LO_OF DROP code1 LO_ENDOF
       LO_OF DROP code2 LO_ENDOF
       ...
           default-code
       DROP
     LO_ENDCASE

     HI_CASE
       HI_OF DROP code1 HI_ENDOF
       HI_OF DROP code2 HI_ENDOF
       ...
           default-code
       DROP
     HI_ENDCASE ( n -- )

Or define a new words:

     define({ANSI_OF},{
     OF
     DROP})dnl

     define({ANSI_PUSH_OF},{
     PUSH_OF($1)
     DROP})dnl

     define({ANSI_ENDCASE},{
     DROP
     ENDCASE})dnl

     ( n -- )
     CASE
       n1 ANSI_OF       code1 ENDOF
       ANSI_PUSH_OF(n2) code2 ENDOF
       ...
           default-code
     ANSI_ENDCASE


https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/case.m4

|<sub>   Original   |<sub>      M4 FORTH       |<sub> Optimization |<sub> Data stack |<sub> Comment       |
| :---------------: | :----------------------: | :---------------: | :-------------- | :----------------- |
|<sub>     case     |<sub>         CASE        |<sub>              |<sub> ( n -- n ) |                    |
|<sub>      of      |<sub>                     |<sub>              |<sub> ( n -- n ) |                    |
|<sub>    `0` of    |<sub>     PUSH(`0`) OF    |<sub>   ZERO_OF    |<sub> ( n -- n ) |                    |
|<sub>    `3` of    |<sub>     PUSH(`3`) OF    |<sub>  PUSH_OF(`3`)|<sub> ( n -- n ) |                    |
|<sub>              |<sub>  WITHIN_OF(`4`,`7`) |<sub>              |<sub> ( n -- n ) |<sub>4..6           |
|<sub>     endof    |<sub>         ENDOF       |<sub>              |<sub> ( n -- n ) |                    |
|<sub>              |<sub>   DECLINING_ENDOF   |<sub>              |<sub> ( n -- n ) | C-style switch     |
|<sub>`255` and case|<sub> PUSH(`255`) AND CASE|<sub>   LO_CASE    |<sub> ( n -- n ) |                    |
|<sub>   `3` of     |<sub>     PUSH(`3`) OF    |<sub>   LO_OF(`3`) |<sub> ( n -- n ) |<sub>ignores hi byte|
|<sub>              |<sub>WITHIN_LO_OF(`4`,`7`)|<sub>              |<sub> ( n -- n ) |<sub>ignores hi byte|
|<sub>     endof    |<sub>         ENDOF       |<sub>   LO_ENDOF   |<sub> ( n -- n ) |                    |
|<sub>              |<sub>  LO_DECLINING_ENDOF |<sub>              |<sub> ( n -- n ) | C-style switch     |
|<sub>`256` u/ case |<sub>    _256UDIV CASE    |<sub>   HI_CASE    |<sub> ( n -- n ) |                    |
|<sub>   `3` of     |<sub>     PUSH(`3`) OF    |<sub>   HI_OF(`3`) |<sub> ( n -- n ) |<sub>ignores lo byte|
|<sub>              |<sub>WITHIN_HI_OF(`4`,`7`)|<sub>              |<sub> ( n -- n ) |<sub>ignores lo byte|
|<sub>     endof    |<sub>         ENDOF       |<sub>   HI_ENDOF   |<sub> ( n -- n ) |                    |
|<sub>              |<sub>  LO_DECLINING_ENDOF |<sub>              |<sub> ( n -- n ) | C-style switch     |

### Function

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/function.m4

|<sub> Original   |<sub>     M4 FORTH      |<sub>    Optimization   |<sub>   Data stack               |<sub>  Return address stack |
| :-------------: | :--------------------: | :--------------------: | :------------------------------ | :------------------------- |
|<sub>    name    |<sub>    RCALL(name)    |<sub>                   |<sub>     ( x2 x1 -- ret x2 x1 ) |<sub> ( -- )                |
|<sub>    name    |<sub>                   |<sub>    SCALL(name)    |<sub>     ( x2 x1 -- ret x2 x1 ) |<sub> ( -- )                |
|<sub>    name    |<sub>                   |<sub>     CALL(name)    |<sub>           ( -- ret )       |<sub> ( -- ) non-recursive  |
|<sub>     :      |<sub>RCOLON(name,coment)|<sub>                   |<sub> ( ret x2 x1 -- x2 x1 )     |<sub> ( -- ret )            |
|<sub>     :      |<sub>                   |<sub>SCOLON(name,coment)|<sub> ( ret x2 x1 -- ret x2 x1 ) |<sub> ( -- )                |
|<sub>     :      |<sub>                   |<sub> COLON(name,coment)|<sub>       ( ret -- )           |<sub> ( -- ) non-recursive  |
|<sub>     ;      |<sub>     RSEMICOLON    |<sub>                   |<sub>           ( -- )           |<sub> ( ret -- )            |
|<sub>     ;      |<sub>                   |<sub>     SSEMICOLON    |<sub> ( ret x2 x1 -- x2 x1 )     |<sub> ( -- )                |
|<sub>     ;      |<sub>                   |<sub>     SEMICOLON     |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |
|<sub>    exit    |<sub>       REXIT       |<sub>                   |<sub>           ( -- )           |<sub> ( ret -- )            |
|<sub>    exit    |<sub>                   |<sub>       SEXIT       |<sub> ( ret x2 x1 -- x2 x1 )     |<sub> ( -- )                |
|<sub>    exit    |<sub>                   |<sub>        EXIT       |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |


### LOOP

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/loop.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/loop/

    PUSH2(5,0)  DO        I DOT PUTCHAR({','})          LOOP       --> " 0, 1, 2, 3, 4,"
                XDO(5,0)  I DOT PUTCHAR({','})         XLOOP       --> " 0, 1, 2, 3, 4,"
                XDO(5,0)  I DOT PUTCHAR({','}) PUSH_ADDXLOOP(2)    --> " 0, 2, 4,"
    PUSH2(5,0) SDO       SI DOT PUTCHAR({','})         SLOOP       --> " 0, 1, 2, 3, 4,"
    PUSH(5)   SFOR       SI DOT PUTCHAR({','})         SNEXT       --> " 5, 4, 3, 2, 1, 0,"
    PUSH(5)    FOR        I DOT PUTCHAR({','})          NEXT       --> " 5, 4, 3, 2, 1, 0,"
          PUSH_FOR(5)     I DOT PUTCHAR({','})          NEXT       --> " 5, 4, 3, 2, 1, 0,"


    PUSH(5) BEGIN DUP_DOT            DUP_WHILE _1SUB PUTCHAR({','}) REPEAT DROP CR ;--> " 5, 4, 3, 2, 1, 0"
    PUSH(0) BEGIN DUP_DOT DUP PUSH(4) LT WHILE _1ADD PUTCHAR({','}) REPEAT DROP CR ;--> " 0, 1, 2, 3, 4"
    PUSH(0) BEGIN DUP_DOT DUP PUSH(4) LT WHILE _2ADD PUTCHAR({','}) REPEAT DROP CR ;--> " 0, 2, 4"

    BEGIN ... flag WHILE ... flag WHILE ... BREAK ... REPEAT|AGAIN|flag UNTIL

#### Non-recursive
The variables are stored in the function memory.

|<sub>     Original    |<sub>   M4 FORTH   |<sub>     Optimization      |<sub>  Data stack                |<sub>  Return address stack |
| :------------------: | :---------------: | :------------------------: | :------------------------------ | :------------------------- |
|<sub>     unloop      |<sub>    UNLOOP    |<sub>                       |<sub>         ( ? -- )           |<sub> ( ? -- )              |
|<sub>     leave       |<sub>    LEAVE     |<sub>                       |<sub>         ( ? -- )           |<sub> ( ? -- )              |
|<sub>        i        |<sub>       I      |<sub>                       |<sub>           ( -- index )     |<sub> ( -- ) non-recursive  |
|<sub>        j        |<sub>       J      |<sub>                       |<sub>           ( -- j )         |<sub> ( -- ) non-recursive  |
|<sub>        k        |<sub>       K      |<sub>                       |<sub>           ( -- k )         |<sub> ( -- ) non-recursive  |
|<sub>       do        |<sub>      DO      |<sub>                       |<sub>( stop index -- )           |<sub> ( -- ) non-recursive  |
|<sub>      ?do        |<sub>  QUESTIONDO  |<sub>                       |<sub>( stop index -- )           |<sub> ( -- ) non-recursive  |
|<sub>      loop       |<sub>     LOOP     |<sub>                       |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |
|<sub>     +loop       |<sub>    ADDLOOP   |<sub>                       |<sub>      ( step -- )           |<sub> ( -- ) non-recursive  |
|<sub>   `3` +loop     |<sub>              |<sub>    PUSH_ADDLOOP(`3`)  |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |
|<sub>      for        |<sub>     FOR      |<sub>                       |<sub>     ( index -- )           |<sub> ( -- ) non-recursive  |
|<sub>     `7` for     |<sub>              |<sub>      PUSH_FOR(`7`)    |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |
|<sub>      next       |<sub>     NEXT     |<sub>                       |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |
|<sub>   `5` `1` do    |<sub>              |<sub>      XDO(`5`,`1`)     |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |
|<sub>   `5` `1` ?do   |<sub>              |<sub>  QUESTIONXDO(`5`,`1`) |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |
|<sub>                 |<sub>              |<sub>         XLOOP         |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |
|<sub>   `2` +loop     |<sub>              |<sub>   PUSH_ADDXLOOP(`2`)  |<sub>           ( -- )           |<sub> ( -- ) non-recursive  |

#### Recursive
The variables are stored in the return address stack.

|<sub>     Original    |<sub>   M4 FORTH   |<sub>     Optimization      |<sub>  Data stack                |<sub>  Return address stack |
| :------------------: | :---------------: | :------------------------: | :------------------------------ | :------------------------- |
|<sub>     unloop      |<sub>    UNLOOP    |<sub>                       |<sub>         ( ? -- )           |<sub> ( ? -- )              |
|<sub>      leave      |<sub>    LEAVE     |<sub>                       |<sub>         ( ? -- )           |<sub> ( ? -- )              |
|<sub>        i        |<sub>              |<sub>          RI           |<sub>           ( -- i )         |<sub> ( i -- i )            |
|<sub>        j        |<sub>              |<sub>          RJ           |<sub>           ( -- j )         |<sub> ( j i -- j i )        |
|<sub>        k        |<sub>              |<sub>          RK           |<sub>           ( -- k )         |<sub> ( k j i -- k j i )    |
|<sub>       do        |<sub>      RDO     |<sub>                       |<sub>( stop index -- )           |<sub> ( -- stop index )     |
|<sub>      ?do        |<sub>  QUESTIONRDO |<sub>                       |<sub>( stop index -- )           |<sub> ( -- stop index )     |
|<sub>      loop       |<sub>     RLOOP    |<sub>                       |<sub>           ( -- )           |<sub> ( s i -- s i+1 )      |
|<sub>     +loop       |<sub>   ADDRLOOP   |<sub>                       |<sub>      ( step -- )           |<sub> ( s i -- s i+step )   |
|<sub>   `3` +loop     |<sub>              |<sub>  PUSH_ADDRLOOP(`3`)   |<sub>           ( -- )           |<sub> ( s i -- s i+`3` )    |
|<sub>      for        |<sub>     RFOR     |<sub>                       |<sub>     ( index -- )           |<sub> ( -- index )          |
|<sub>      next       |<sub>     RNEXT    |<sub>                       |<sub>           ( -- )           |<sub> ( -- index-1)         |
|<sub>   `5` `1` do    |<sub>              |<sub>     RXDO(`5`,`1`)     |<sub>           ( -- )           |<sub> ( -- `5` `1` )        |
|<sub>   `5` `1` ?do   |<sub>              |<sub> QUESTIONRXDO(`5`,`1`) |<sub>           ( -- )           |<sub> ( -- `5` `1` )        |
|<sub>                 |<sub>              |<sub>         RLOOP         |<sub>           ( -- )           |<sub> ( index -- index+1 )  |
|<sub>   `2` +loop     |<sub>              |<sub>  PUSH_ADDXRLOOP(`2`)  |<sub>           ( -- )           |<sub> ( index -- index+`2` )|

The variables are stored in the data stack.

|<sub>     Original    |<sub>   M4 FORTH   |<sub>     Optimization      |<sub>  Data stack                |<sub>  R. a. stack |
| :------------------: | :---------------: | :------------------------: | :------------------------------ | :---------------- |
|<sub>      unloop     |<sub>    UNLOOP    |<sub>                       |<sub>         ( ? -- )           |<sub> ( ? -- )     |
|<sub>      leave      |<sub>    LEAVE     |<sub>                       |<sub>         ( ? -- )           |<sub> ( ? -- )     |
|<sub>        i        |<sub>              |<sub>           SI          |<sub>         ( i -- i i )       |<sub> ( -- )       |
|<sub>       do        |<sub>              |<sub>          SDO          |<sub>    ( stop i -- stop i )    |<sub> ( -- )       |
|<sub>       ?do       |<sub>              |<sub>      QUESTIONSDO      |<sub>    ( stop i -- stop i )    |<sub> ( -- )       |
|<sub>      loop       |<sub>              |<sub>         SLOOP         |<sub>    ( stop i -- stop i+1)   |<sub> ( -- )       |
|<sub>      +loop      |<sub>              |<sub>        ADDSLOOP       |<sub>( end i step -- end i+step )|<sub> ( -- )       |
|<sub>    `4` +loop    |<sub>              |<sub>   PUSH_ADDSLOOP(`4`)  |<sub>     ( end i -- end i+`4` ) |<sub> ( -- )       |
|<sub>       for       |<sub>              |<sub>          SFOR         |<sub>     ( index -- index )     |<sub> ( -- )       |
|<sub>      next       |<sub>              |<sub>         SNEXT         |<sub>     ( index -- index-1 )   |<sub> ( -- )       |
|<sub>      begin      |<sub>    BEGIN     |<sub>                       |<sub>           ( -- )           |<sub>              |
|<sub>                 |<sub>    BREAK     |<sub>                       |<sub>           ( -- )           |<sub>              |
|<sub>     while       |<sub>    WHILE     |<sub>                       |<sub>      ( flag -- )           |<sub>              |
|<sub>   dup while     |<sub>              |<sub>       DUP_WHILE       |<sub>      ( flag -- flag )      |<sub>              |
|<sub>     =  while    |<sub>              |<sub>       EQ_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>     <> while    |<sub>              |<sub>       NE_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>     <  while    |<sub>              |<sub>       LT_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>     <= while    |<sub>              |<sub>       LE_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>     >  while    |<sub>              |<sub>       GT_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>     >= while    |<sub>              |<sub>       GE_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>    u=  while    |<sub>              |<sub>      UEQ_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>    u<> while    |<sub>              |<sub>      UNE_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>    u<  while    |<sub>              |<sub>      ULT_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>    u<= while    |<sub>              |<sub>      ULE_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>    u>  while    |<sub>              |<sub>      UGT_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>    u>= while    |<sub>              |<sub>      UGE_WHILE        |<sub>     ( x2 x1 -- )           |<sub>              |
|<sub>dup `2`  =  while|<sub>              |<sub> DUP_PUSH_EQ_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2`  <> while|<sub>              |<sub> DUP_PUSH_NE_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2`  <  while|<sub>              |<sub> DUP_PUSH_LT_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2`  <= while|<sub>              |<sub> DUP_PUSH_LE_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2`  >  while|<sub>              |<sub> DUP_PUSH_GT_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2`  >= while|<sub>              |<sub> DUP_PUSH_GE_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2` u=  while|<sub>              |<sub>DUP_PUSH_UEQ_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2` u<> while|<sub>              |<sub>DUP_PUSH_UNE_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2` u<  while|<sub>              |<sub>DUP_PUSH_ULT_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2` u<= while|<sub>              |<sub>DUP_PUSH_ULE_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2` u>  while|<sub>              |<sub>DUP_PUSH_UGT_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub>dup `2` u>= while|<sub>              |<sub>DUP_PUSH_UGE_WHILE(`2`)|<sub>           ( -- )           |<sub>              |
|<sub> 2dup  =  while  |<sub>              |<sub>    _2DUP_EQ_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup  <> while  |<sub>              |<sub>    _2DUP_NE_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup  <  while  |<sub>              |<sub>    _2DUP_LT_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup  <= while  |<sub>              |<sub>    _2DUP_LE_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup  >  while  |<sub>              |<sub>    _2DUP_GT_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup  >= while  |<sub>              |<sub>    _2DUP_GE_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup u=  while  |<sub>              |<sub>   _2DUP_UEQ_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup u<> while  |<sub>              |<sub>   _2DUP_UNE_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup u<  while  |<sub>              |<sub>   _2DUP_ULT_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup u<= while  |<sub>              |<sub>   _2DUP_ULE_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup u>  while  |<sub>              |<sub>   _2DUP_UGT_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub> 2dup u>= while  |<sub>              |<sub>   _2DUP_UGE_WHILE     |<sub>           ( -- )           |<sub>              |
|<sub>     repeat      |<sub>    REPEAT    |<sub>                       |<sub>           ( -- )           |<sub>              |
|<sub>     again       |<sub>    AGAIN     |<sub>                       |<sub>           ( -- )           |<sub>              |
|<sub>     until       |<sub>    UNTIL     |<sub>                       |<sub>      ( flag -- )           |<sub>              |

### Other

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/other.m4

|<sub>    Original    |<sub>      M4 FORTH     |<sub>    Optimization    |<sub>   Data stack          |<sub> Comment          |
| :-----------------: | :--------------------: | :---------------------: | :------------------------- | :-------------------- |
|<sub>                |<sub>   INIT(RAS_addr)  |<sub>                    |<sub>                       |<sub> save SP, set RAS |
|<sub>      bye       |<sub>        BYE        |<sub>                    |<sub>          ( -- )       |<sub> goto STOP        |
|<sub>                |<sub>       STOP        |<sub>                    |<sub>          ( -- )       |<sub> load SP & HL'    |
|<sub>`1` constant ONE|<sub> CONSTANT(ONE,`1`) |<sub>                    |<sub>          ( -- )       |<sub> ONE equ `1`      |
|<sub>    `3` var X   |<sub>  VARIABLE(X,`3`)  |<sub>                    |<sub>          ( -- )       |<sub> X: dw `3`        |
|<sub>   variable X   |<sub>    VARIABLE(X)    |<sub>                    |<sub>          ( -- )       |<sub> X: dw 0x0000     |
|<sub>   'a' cvar X   |<sub>  CVARIABLE(X,'a') |<sub>                    |<sub>          ( -- )       |<sub> X: db 'a'        |
|<sub>   `4` dvar X   |<sub>  DVARIABLE(X,`4`) |<sub>                    |<sub>          ( -- )       |<sub> X: dw `4`, 0x0000|
|<sub>        @       |<sub>       FETCH       |<sub>                    |<sub>     ( addr -- x )     |<sub> TOP = (addr)     |
|<sub>     addr @     |<sub>                   |<sub>  PUSH_FETCH(addr)  |<sub>          ( -- x )     |<sub> TOP = (addr)     |
|<sub>        !       |<sub>       STORE       |<sub>                    |<sub>   ( x addr -- )       |<sub> (addr) = x       |
|<sub>     addr !     |<sub>                   |<sub>  PUSH_STORE(addr)  |<sub>        ( x -- )       |<sub> (addr) = x       |
|<sub>    x addr !    |<sub>                   |<sub>PUSH2_STORE(x,addr) |<sub>          ( -- )       |<sub> (addr) = x       |
|<sub>       C@       |<sub>       CFETCH      |<sub>                    |<sub>     ( addr -- char )  |<sub> TOP = (addr)     |
|<sub>     addr C@    |<sub>                   |<sub> PUSH_CFETCH(addr)  |<sub>          ( -- char )  |<sub> TOP = (addr)     |
|<sub>       C!       |<sub>       CSTORE      |<sub>                    |<sub>( char addr -- )       |<sub> (addr) = char    |
|<sub>     addr C!    |<sub>                   |<sub> PUSH_CSTORE(addr)  |<sub>     ( char -- )       |<sub> (addr) = char    |
|<sub>    x addr C!   |<sub>                   |<sub>PUSH2_CSTORE(x,addr)|<sub>          ( -- )       |<sub> (addr) = char    |
|<sub>       2@       |<sub>      _2FETCH      |<sub>                    |<sub>     ( addr -- hi lo ) |<sub>                  |
|<sub>     addr 2@    |<sub>                   |<sub> PUSH_2FETCH(addr)  |<sub>          ( -- hi lo ) |<sub>                  |
|<sub>       2!       |<sub>      _2STORE      |<sub>                    |<sub>( hi lo adr -- )       |<sub> (addr) = 32 bit  |
|<sub>     addr 2!    |<sub>                   |<sub> PUSH_2STORE(addr)  |<sub>    ( hi lo -- )       |<sub> (addr) = 32 bit  |
|<sub>    x addr 2!   |<sub>                   |<sub>PUSH2_2STORE(x,addr)|<sub>       ( hi -- )       |<sub> (addr) = 32 bit  |
|<sub>       +!       |<sub>      ADDSTORE     |<sub>                    |<sub>   ( x addr -- )       |<sub> (addr) += x      |
|<sub>   x addr +!    |<sub>PUSH2_ADDSTORE(x,a)|<sub>                    |<sub>          ( -- )       |<sub> (a) += x         |
|<sub>     cmove      |<sub>       CMOVE       |<sub>                    |<sub>( from to u -- )       |<sub> 8bit, addr++     |
|<sub>    `3` cmove   |<sub>                   |<sub>  PUSH_CMOVE(`3`)   |<sub>  ( from to -- )       |<sub> 8bit, addr++     |
|<sub>     cmove>     |<sub>      CMOVEGT      |<sub>                    |<sub>( from to u -- )       |<sub> 8bit, addr--     |
|<sub>      move      |<sub>        MOVE       |<sub>                    |<sub>( from to u -- )       |<sub> 16bit, addr++    |
|<sub>      move>     |<sub>       MOVEGT      |<sub>                    |<sub>( from to u -- )       |<sub> 16bit, addr--    |
|<sub>      fill      |<sub>        FILL       |<sub>                    |<sub> ( addr u c -- )       |<sub> 8bit, addr++     |
|<sub>     c fill     |<sub>  PUSH_FILL(u,c)   |<sub>                    |<sub>   ( addr u -- )       |<sub> 8bit, addr++     |
|<sub>    u c fill    |<sub>  PUSH2_FILL(u,c)  |<sub>                    |<sub>     ( addr -- )       |<sub> 8bit, addr++     |
|<sub>   a u c fill   |<sub> PUSH3_FILL(a,u,c) |<sub>                    |<sub>          ( -- )       |<sub> 8bit, addr++     |
|<sub> `seed` seed !  |<sub>                   |<sub>  PUSH_STORE(SEED)  |<sub>     ( seed -- )       |<sub>                  |
|<sub>       rnd      |<sub>        RND        |<sub>                    |<sub>          ( -- random )|<sub>                  |
|<sub>     random     |<sub>       RANDOM      |<sub>                    |<sub>      ( max -- random )|<sub> random < max     |
|<sub>                |<sub>      PUTPIXEL     |<sub>                    |<sub>       ( yx -- HL )    |<sub>                  |
### Output

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/output.m4

The small Runtime library.
Variable section.
String section.

## External links

http://wiki.laptop.org/go/Forth_Lessons

http://astro.pas.rochester.edu/Forth/forth-words.html

https://www.tutorialspoint.com/execute_forth_online.php

http://www.retroprogramming.com/2012/04/itsy-forth-primitives.html

https://www.gnu.org/software/m4/manual/m4-1.4.15/html_node/index.html#Top
