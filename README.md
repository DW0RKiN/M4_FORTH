# M4 FORTH (ZX Spectrum, Z80)

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
        ld  (Stop+1), SP    ; 4:20      not need
        ld    L, 0x1A       ; 2:7       Upper screen
        call 0x1605         ; 3:17      Open channel
        ld   HL, 60000      ; 3:10      Init Return address stack
        exx                 ; 1:4

        push DE             ; 1:11      print
        ld   BC, size101    ; 3:10      print Length of string to print
        ld   DE, string101  ; 3:10      print Address of string
        call 0x203C         ; 3:17      print Print our string with ZX 48K ROM
        pop  DE             ; 1:10      print


    Stop:
        ld   SP, 0x0000     ; 3:10      not need
        ld   HL, 0x2758     ; 3:10
        exx                 ; 1:4
        ret                 ; 1:10
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

https://github.com/DW0RKiN/M4_FORTH/blob/master/forth2m4.sh

This is a compiler from Forth to M4 FORTH written in bash. Manual adjustments are still needed. For example, move functions below STOP. Unknown words will try to be called as function names. It will try to find and combine optimized words, but only if they are on the same line and are separated only by white characters.

## Implemented words FORTH

### Stack manipulation

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/stack.m4

|<sub>       original         |<sub>    M4 FORTH         |<sub> optimization     |<sub>  data stack                  |<sub>  r. a. stack |
| :-------------------------: | :----------------------: | :-------------------: | :-------------------------------- | :---------------- |
|<sub>          swap          |<sub>         SWAP        |<sub>                  |<sub>      ( x2 x1 -- x1 x2 )      |<sub>              |
|<sub>        swap over       |<sub>       SWAP OVER     |<sub>     SWAP_OVER    |<sub>      ( x2 x1 -- x1 x2 x1 )   |<sub>              |
|<sub>        swap `7`        |<sub>    SWAP PUSH(`7`)   |<sub>  SWAP_PUSH(`7`)  |<sub>      ( x2 x1 -- x1 x2 `7` )  |<sub>              |
|<sub>        `6` swap        |<sub>    PUSH(`6`) SWAP   |<sub>  PUSH_SWAP(`6`)  |<sub>         ( x1 -- `6` x1 )     |<sub>              |
|<sub>      dup `5` swap      |<sub>  DUP PUSH(`5`) SWAP |<sub>DUP_PUSH_SWAP(`5`)|<sub>         ( x1 -- x1 `5` x1 )  |<sub>              |
|<sub>         2swap          |<sub>        _2SWAP       |<sub>                  |<sub> (x1 x2 x3 x4 -- x3 x4 x1 x2) |<sub>              |
|<sub>           dup          |<sub>          DUP        |<sub>                  |<sub>         ( x1 -- x1 x1 )      |<sub>              |
|<sub>          ?dup          |<sub>     QUESTIONDUP     |<sub>                  |<sub>         ( x1 -- 0 \| x1 x1 ) |<sub>              |
|<sub>          2dup          |<sub>        _2DUP        |<sub>                  |<sub>      ( x2 x1 -- x2 x1 x2 x1 )|<sub>              |
|<sub>          drop          |<sub>         DROP        |<sub>                  |<sub>         ( x1 -- )            |<sub>              |
|<sub>         2drop          |<sub>        _2DROP       |<sub>                  |<sub>      ( x2 x1 -- )            |<sub>              |
|<sub>          nip           |<sub>          NIP        |<sub>                  |<sub>      ( x2 x1 -- x1 )         |<sub>              |
|<sub>          2nip          |<sub>         2NIP        |<sub>                  |<sub>    ( d c b a -- b a )        |<sub>              |
|<sub>          tuck          |<sub>         TUCK        |<sub>                  |<sub>      ( x2 x1 -- x1 x2 x1 )   |<sub>              |
|<sub>         2tuck          |<sub>       _2TUCK        |<sub>                  |<sub>    ( d c b a -- b a d c b a )|<sub>              |
|<sub>          over          |<sub>         OVER        |<sub>                  |<sub>      ( x2 x1 -- x2 x1 x2 )   |<sub>              |
|<sub>        over swap       |<sub>       OVER SWAP     |<sub>     OVER_SWAP    |<sub>      ( x2 x1 -- x2 x2 x1 )   |<sub>              |
|<sub>         2over          |<sub>       _2OVER        |<sub>                  |<sub>    ( a b c d -- a b c d a b )|<sub>              |
|<sub>          rot           |<sub>         ROT         |<sub>                  |<sub>   ( x3 x2 x1 -- x2 x1 x3 )   |<sub>              |
|<sub>         2rot           |<sub>        _2ROT        |<sub>                  |<sub>( f e d c b a -- d c b a f e )|<sub>              |
|<sub>         -rot           |<sub>         NROT        |<sub>                  |<sub>   ( x3 x2 x1 -- x1 x3 x2 )   |<sub>              |
|<sub>       -rot 2swap       |<sub>     NROT _2SWAP     |<sub>    NROT_2SWAP    |<sub>( x4 x3 x2 x1 -- x3 x2 x4 x1 )|<sub>              |
|<sub>  nrot swap 2swap swap  |<sub>NROT SWAP _2SWAP SWAP|<sub>    STACK_BCAD    |<sub>    ( d c b a -- b c a d )    |<sub>              |
|<sub>     over 2over drop    |<sub>  OVER _2OVER DROP   |<sub>    STACK_CBABC   |<sub>      ( c b a -- c b a b c )  |<sub>              |
|<sub>     over `3` pick      |<sub> OVER PUSH(`3`) PICK |<sub>    STACK_CBABC   |<sub>      ( c b a -- c b a b c )  |<sub>              |
|<sub> `2` pick `2` pick swap |<sub>         ....        |<sub>    STACK_CBABC   |<sub>      ( c b a -- c b a b c )  |<sub>              |
|<sub>2over nip 2over nip swap|<sub>         ....        |<sub>    STACK_CBABC   |<sub>      ( c b a -- c b a b c )  |<sub>              |
|<sub>         `123`          |<sub>      PUSH(`123`)    |<sub>                  |<sub>            ( -- `123` )      |<sub>              |
|<sub>         `2` `1`        |<sub> PUSH(`2`) PUSH(`1`) |<sub>  PUSH2(`2`,`1`)  |<sub>            ( -- `2` `1` )    |<sub>              |
|<sub>       addr `7` @       |<sub>     PUSH((addr))    |<sub>                  |<sub>    *addr = 7 --> ( -- `7`)   |<sub>              |
|<sub>                        |<sub>                     |<sub>  PUSH2((A),`2`)  |<sub>    *A = 4 --> ( -- `4` `2` ) |<sub>              |
|<sub>       drop `5`         |<sub>                     |<sub>  DROP_PUSH(`5`)  |<sub>         ( x1 -- `5`)         |<sub>              |
|<sub>        dup `4`         |<sub>                     |<sub>   DUP_PUSH(`4`)  |<sub>         ( x1 -- x1 x1 `4`)   |<sub>              |
|<sub>          pick          |<sub>         PICK        |<sub>                  |<sub>          ( u -- xu )         |<sub>              |
|<sub>        `2` pick        |<sub>                     |<sub>  PUSH_PICK(`2`)  |<sub>   ( x2 x1 x0 -- x2 x1 x0 x2 )|<sub>              |
|<sub>           >r           |<sub>         TO_R        |<sub>                  |<sub>         ( x1 -- )            |<sub>    ( -- x1 ) |
|<sub>           r>           |<sub>        R_FROM       |<sub>                  |<sub>            ( -- x1 )         |<sub> ( x1 -- )    |
|<sub>           r@           |<sub>        R_FETCH      |<sub>                  |<sub>            ( -- x1 )         |<sub> ( x1 -- x1 ) |
|<sub>         rdrop          |<sub>         RDROP       |<sub>                  |<sub>            ( -- )            |<sub> ( x1 -- )    |

### Arithmetic

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/arithmetic.m4

|<sub> original   |<sub>   M4 FORTH   |<sub>  optimization  |<sub>  data stack                 |<sub>  r. a. stack |
|<sub> :--------: |<sub> :----------: |<sub> :------------: |<sub> :-------------------------- |<sub> :----------- |
|<sub>     +      |<sub>      ADD     |<sub>                |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>   `3` +    |<sub>              |<sub>  PUSH_ADD(`3`) |<sub>        ( x -- x+`3` )       |<sub>              |
|<sub>   dup +    |<sub>              |<sub>     DUP_ADD    |<sub>        ( x -- x+x )         |<sub>              |
|<sub>   over +   |<sub>              |<sub>    OVER_ADD    |<sub>    ( x2 x1 -- x2 x1+x2  )   |<sub>              |
|<sub>     -      |<sub>      SUB     |<sub>                |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>   `3` -    |<sub>              |<sub>  PUSH_SUB(`3`) |<sub>        ( x -- x-`3` )       |<sub>              |
|<sub>   over -   |<sub>              |<sub>    OVER_SUB    |<sub>    ( x2 x1 -- x2 x1-x2  )   |<sub>              |
|<sub>    max     |<sub>      MAX     |<sub>                |<sub>    ( x2 x1 -- max )         |<sub>              |
|<sub>  `3` max   |<sub> PUSH_MAX(`3`)|<sub>                |<sub>       ( x1 -- max )         |<sub>              |
|<sub>    min     |<sub>      MIN     |<sub>                |<sub>    ( x2 x1 -- min )         |<sub>              |
|<sub>  `3` min   |<sub> PUSH_MIN(`3`)|<sub>                |<sub>       ( x1 -- min )         |<sub>              |
|<sub>   negate   |<sub>     NEGATE   |<sub>                |<sub>       ( x1 -- -x1 )         |<sub>              |
|<sub>    abs     |<sub>      ABS     |<sub>                |<sub>        ( n -- u )           |<sub>              |
|<sub>     *      |<sub>      MUL     |<sub>                |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>     /      |<sub>      DIV     |<sub>                |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>    mod     |<sub>      MOD     |<sub>                |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>    /mod    |<sub>    DIVMOD    |<sub>                |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>     u*     |<sub>      MUL     |<sub>                |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>  `+12` *   |<sub>              |<sub> PUSH_MUL(`12`) |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>     u/     |<sub>     UDIV     |<sub>                |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>    umod    |<sub>     UMOD     |<sub>                |<sub>    ( x2 x1 -- x )           |<sub>              |
|<sub>    u/mod   |<sub>    UDIVMOD   |<sub>                |<sub>    ( x2 x1 -- rem quot )    |<sub>              |
|<sub>     1+     |<sub>    _1ADD     |<sub>                |<sub>       ( x1 -- x1++ )        |<sub>              |
|<sub>     1-     |<sub>    _1SUB     |<sub>                |<sub>       ( x1 -- x1-- )        |<sub>              |
|<sub>     2+     |<sub>    _2ADD     |<sub>                |<sub>       ( x1 -- x1+2 )        |<sub>              |
|<sub>     2-     |<sub>    _2SUB     |<sub>                |<sub>       ( x1 -- x1-2 )        |<sub>              |
|<sub>     2*     |<sub>    _2MUL     |<sub>                |<sub>       ( x1 -- x1*2 )        |<sub>              |
|<sub>     2/     |<sub>    _2DIV     |<sub>                |<sub>       ( x1 -- x1/2 )        |<sub>              |
|<sub>    256*    |<sub>   _256MUL    |<sub>                |<sub>       ( x1 -- x1*256 )      |<sub>              |
|<sub>    256/    |<sub>   _256DIV    |<sub>                |<sub>       ( x1 -- x1/256 )      |<sub>              |

### Floating-point

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/floating.m4

Danagy format `S EEE EEEE MMMM MMMM`

https://github.com/DW0RKiN/Floating-point-Library-for-Z80

For a logical comparison of two numbers as f1> f2, exactly the same result applies as for a comparison of two integer numbers with a sign.

|<sub> original   |<sub>   M4 FORTH   |<sub>  optimization  |<sub>  data stack          |<sub>  comment                   |
|<sub> :--------: |<sub> :----------: |<sub> :------------: |<sub> :------------------- |<sub> :------------------------- |
|<sub>    s>f     |<sub>      S2F     |<sub>                |<sub>       ( s1 -- f1 )   |<sub>                            |
|<sub>    u>f     |<sub>      U2F     |<sub>                |<sub>       ( u1 -- f1 )   |<sub>                            |
|<sub>    f>s     |<sub>      F2S     |<sub>                |<sub>       ( f1 -- s1 )   |<sub>                            |
|<sub>    f>u     |<sub>      F2U     |<sub>                |<sub>       ( f1 -- u1 )   |<sub>                            |
|<sub>     f+     |<sub>     FADD     |<sub>                |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 + f1               |
|<sub>     f-     |<sub>     FSUB     |<sub>                |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 - f1               |
|<sub>  fnegate   |<sub>    FNEGATE   |<sub>                |<sub>       ( f1 -- f2 )   |<sub> f2 = -f1                   |
|<sub>    fabs    |<sub>     FABS     |<sub>                |<sub>       ( f1 -- f2 )   |<sub> f2 = abs(f1)               |
|<sub>     f.     |<sub>     FDOT     |<sub>                |<sub>       ( f1 -- )      |<sub>                            |
|<sub>     f*     |<sub>     FMUL     |<sub>                |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 * f1               |
|<sub>     f/     |<sub>     FDIV     |<sub>                |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 / f1               |
|<sub>   fsqrt    |<sub>    FSQRT     |<sub>                |<sub>       ( f1 -- f2 )   |<sub>                            |
|<sub>   ftrunc   |<sub>    FTRUNC    |<sub>                |<sub>       ( f1 -- f2 )   |<sub> f2 = int(f1), round to zero|
|<sub>            |<sub>    FFRAC     |<sub>                |<sub>       ( f1 -- f2 )   |<sub> f2 = f1 % 1.0              |
|<sub>    fexp    |<sub>     FEXP     |<sub>                |<sub>       ( f1 -- f2 )   |<sub> f2 = e^(f1)                |
|<sub>     fln    |<sub>      FLN     |<sub>                |<sub>       ( f1 -- f2 )   |<sub> f2 = ln(f1)                |
|<sub>    fmod    |<sub>     FMOD     |<sub>                |<sub>    ( f2 f1 -- f3 )   |<sub> f3 = f2 % f1               |
|<sub>     f2*    |<sub>     F2MUL    |<sub>                |<sub>       ( f1 -- f2 )   |<sub> f2 = f1 * 2.0              |
|<sub>     f2/    |<sub>     F2DIV    |<sub>                |<sub>       ( f1 -- f2 )   |<sub> f2 = f1 / 2.0              |
|<sub>    fsin    |<sub>     FSIN     |<sub>                |<sub>       ( f1 -- f2 )   |<sub> f2 = sin(f1), f1 <= ±π/2   |

### Logic

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/logic.m4

|<sub> original   |<sub>   M4 FORTH   |<sub>  optimization  |<sub>  data stack            |<sub>  r.a.s. |<sub> comment      |
|<sub> :--------: |<sub> :----------: |<sub> :------------: |<sub> :--------------------- |<sub> :------ |<sub> :----------- |
|<sub>    and     |<sub>     AND      |<sub>                |<sub>    ( x2 x1 -- x )      |<sub>         |<sub>              |
|<sub>   `3` and  |<sub>              |<sub>  PUSH_AND(`3`) |<sub>        ( x -- x & `3`) |<sub>         |<sub>              |
|<sub>     or     |<sub>      OR      |<sub>                |<sub>    ( x2 x1 -- x )      |<sub>         |<sub>              |
|<sub>   `3` or   |<sub>              |<sub>  PUSH_OR(`3`)  |<sub>        ( x -- x \| `3`)|<sub>         |<sub>              |
|<sub>    xor     |<sub>     XOR      |<sub>                |<sub>       ( x1 -- -x1 )    |<sub>         |<sub>              |
|<sub>   `3` xor  |<sub>              |<sub>  PUSH_XOR(`3`) |<sub>        ( x -- x ^ `3`) |<sub>         |<sub>              |
|<sub>    abs     |<sub>     ABS      |<sub>                |<sub>        ( n -- u )      |<sub>         |<sub>
|<sub>   invert   |<sub>    INVERT    |<sub>                |<sub>       ( x1 -- ~x1 )    |<sub>         |<sub>
|<sub>   within   |<sub>    WITHIN    |<sub>                |<sub>    ( c b a -- flag )   |<sub>         |<sub>(a-b) (c-b) U<
|<sub>    true    |<sub>     TRUE     |<sub>                |<sub>          ( -- -1 )     |<sub>         |<sub>
|<sub>   false    |<sub>    FALSE     |<sub>                |<sub>          ( -- 0 )      |<sub>         |<sub>
|<sub>      =     |<sub>      EQ      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub>     0=     |<sub>     _0EQ     |<sub>                |<sub>       ( x1 -- f )      |<sub>         |<sub> f=(x1 == 0)
|<sub>    D0=     |<sub>     D0EQ     |<sub>                |<sub>    ( x1 x2 -- f )      |<sub>         |<sub> f=((x1|x2) == 0)
|<sub>     <>     |<sub>      NE      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub>      <     |<sub>      LT      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub>     0<     |<sub>     _0LT     |<sub>                |<sub>       ( x1 -- f )      |<sub>         |<sub> f=(x1 < 0)
|<sub>     <=     |<sub>      LE      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub>      >     |<sub>      GT      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub>     >=     |<sub>      GE      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub>     0>=    |<sub>     _0GE     |<sub>                |<sub>       ( x1 -- f )      |<sub>         |<sub> f=(x1 >= 0)
|<sub>     u<     |<sub>     ULT      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub>    u<=     |<sub>     ULE      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub>     u>     |<sub>     UGT      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub>    u>=     |<sub>     UGE      |<sub>                |<sub>    ( x2 x1 -- flag )   |<sub>         |<sub> TRUE=-1 FALSE=0
|<sub> x1 u >> x  |<sub>    RSHIFT    |<sub>                |<sub>    ( x1 u -- x1>>u )   |<sub>         |<sub>
|<sub> x1 u << x  |<sub>    LSHIFT    |<sub>                |<sub>    ( x1 u -- x1<<u )   |<sub>         |<sub>
|<sub> x1 1 >> x  |<sub>              |<sub>    XRSHIFT1    |<sub>      ( x1 -- x1>>1 )   |<sub>         |<sub> signed
|<sub> x1 1 << x  |<sub>              |<sub>    XLSHIFT1    |<sub>      ( x1 -- x1<<1 )   |<sub>         |<sub>
|<sub> u1 1 >> u  |<sub>              |<sub>   XURSHIFT1    |<sub>      ( u1 -- u1>>1 )   |<sub>         |<sub> unsigned
|<sub> u1 1 << u  |<sub>              |<sub>   XULSHIFT1    |<sub>      ( u1 -- u1<<1 )   |<sub>         |<sub>


### Device

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/device.m4

| original   |   M4 FORTH    |  optimization  |  data stack              |  r. a. stack |
| :--------: | :-----------: | :------------: | :----------------------- | :----------- |
|     .      |      DOT      |   UDOT if > 0  |       ( x1 -- )          |              |
|     u.     |     UDOT      |                |       ( x1 -- )          |              |
|   dup .    |               |    DUP_DOT     |       ( x1 -- x1 )       |              |
|   dup u.   |               |    DUP_UDOT    |       ( x1 -- x1 )       |              |
|     .s     |     DOTS      |                | ( x3 x2 x1 -- x3 x2 x1 ) |              |
|     cr     |      CR       |                |          ( -- )          |              |
|    emit    |     EMIT      |                |      ( 'a' -- )          |              |
|  'a' emit  |               |  PUTCHAR('a')  |          ( -- )          |              |
|    type    |     TYPE      |                |   ( addr n -- )          |              |
| 2dup type  |               |   _2DUP_TYPE   |   ( addr n -- addr n )   |              |
| .( Hello)  | PRINT("Hello")|                |          ( -- )          |              |
| ." Hello"  | PRINT("Hello")|                |          ( -- )          |              |
| s" Hello"  |STRING("Hello")|                |          ( -- addr n )   |              |
|     key    |      KEY      |                |          ( -- key )      |              |
|   accept   |     ACCEPT    |                | ( addr max -- loaded )   |              |

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
|     =  if    |              |       EQ_IF        |    (x1 x2 -- )      |         |
|     <> if    |              |       NE_IF        |    (x1 x2 -- )      |         |
|     <  if    |              |       LT_IF        |    (x1 x2 -- )      |         |
|     <= if    |              |       LE_IF        |    (x1 x2 -- )      |         |
|     >  if    |              |       GT_IF        |    (x1 x2 -- )      |         |
|     >= if    |              |       GE_IF        |    (x1 x2 -- )      |         |
|    u=  if    |              |       UEQ_IF       |    (x1 x2 -- )      |         |
|    u<> if    |              |       UNE_IF       |    (x1 x2 -- )      |         |
|    u<  if    |              |       ULT_IF       |    (x1 x2 -- )      |         |
|    u<= if    |              |       ULE_IF       |    (x1 x2 -- )      |         |
|    u>  if    |              |       UGT_IF       |    (x1 x2 -- )      |         |
|    u>= if    |              |       UGE_IF       |    (x1 x2 -- )      |         |
|  `3` =  if   |              |    PUSH_EQ_IF      |       (x1 -- )      |         |
|  `3` <> if   |              |    PUSH_NE_IF      |       (x1 -- )      |         |
|dup `5`  =  if|              |DUP_PUSH_CEQ_IF(`5`)|         ( -- )      |         |unsigned char
|dup `5`  <> if|              |DUP_PUSH_CNE_IF(`5`)|         ( -- )      |         |unsigned char
|dup `5`  =  if|              |DUP_PUSH_EQ_IF(`5`) |         ( -- )      |         |
|dup `5`  <> if|              |DUP_PUSH_NE_IF(`5`) |         ( -- )      |         |
|dup `5`  <  if|              |DUP_PUSH_LT_IF(`5`) |         ( -- )      |         |
|dup `5`  <= if|              |DUP_PUSH_LE_IF(`5`) |         ( -- )      |         |
|dup `5`  >  if|              |DUP_PUSH_GT_IF(`5`) |         ( -- )      |         |
|dup `5`  >= if|              |DUP_PUSH_GE_IF(`5`) |         ( -- )      |         |
|dup `5` u=  if|              |DUP_PUSH_UEQ_IF(`5`)|         ( -- )      |         |
|dup `5` u<> if|              |DUP_PUSH_UNE_IF(`5`)|         ( -- )      |         |
|dup `5` u<  if|              |DUP_PUSH_ULT_IF(`5`)|         ( -- )      |         |
|dup `5` u<= if|              |DUP_PUSH_ULE_IF(`5`)|         ( -- )      |         |
|dup `5` u>  if|              |DUP_PUSH_UGT_IF(`5`)|         ( -- )      |         |
|dup `5` u>= if|              |DUP_PUSH_UGE_IF(`5`)|         ( -- )      |         |
|`3` over <> if|              | DUP_PUSH_NE_IF(`3`)|       (x1 -- )      |         |
|     dtto     |              |        dtto        |                     |         |
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

| original   |     M4 FORTH      |    optimization   |   data stack               |  return address stack |
| :--------: | :---------------: | :---------------: | :------------------------- | :-------------------- |
|    name    |    RCALL(name)    |                   |     ( x2 x1 -- ret x2 x1 ) | ( -- )                |
|    name    |                   |    SCALL(name)    |     ( x2 x1 -- ret x2 x1 ) | ( -- )                |
|    name    |                   |     CALL(name)    |           ( -- ret )       | ( -- ) non-recursive  |
|     :      |RCOLON(name,coment)|                   | ( ret x2 x1 -- x2 x1 )     | ( -- ret )            |
|     :      |                   |SCOLON(name,coment)| ( ret x2 x1 -- ret x2 x1 ) | ( -- )                |
|     :      |                   | COLON(name,coment)|       ( ret -- )           | ( -- ) non-recursive  |
|     ;      |     RSEMICOLON    |                   |           ( -- )           | ( ret -- )            |
|     ;      |                   |     SSEMICOLON    | ( ret x2 x1 -- x2 x1 )     | ( -- )                |
|     ;      |                   |     SEMICOLON     |           ( -- )           | ( -- ) non-recursive  |
|    exit    |       REXIT       |                   |           ( -- )           | ( ret -- )            |
|    exit    |                   |       SEXIT       | ( ret x2 x1 -- x2 x1 )     | ( -- )                |
|    exit    |                   |        EXIT       |           ( -- )           | ( -- ) non-recursive  |


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

|     original    |   M4 FORTH   |     optimization      |  data stack                |  return address stack |
| :-------------: | :----------: | :-------------------: | :------------------------- | :-------------------- |
|     unloop      |    UNLOOP    |                       |         ( ? -- )           | ( ? -- )              |
|     leave       |    LEAVE     |                       |         ( ? -- )           | ( ? -- )              |
|        i        |       I      |                       |           ( -- index )     | ( -- ) non-recursive  |
|        j        |       J      |                       |           ( -- j )         | ( -- ) non-recursive  |
|        k        |       K      |                       |           ( -- k )         | ( -- ) non-recursive  |
|       do        |      DO      |                       |( stop index -- )           | ( -- ) non-recursive  |
|      ?do        |  QUESTIONDO  |                       |( stop index -- )           | ( -- ) non-recursive  |
|      loop       |     LOOP     |                       |           ( -- )           | ( -- ) non-recursive  |
|     +loop       |    ADDLOOP   |                       |      ( step -- )           | ( -- ) non-recursive  |
|   `3` +loop     |              |    PUSH_ADDLOOP(`3`)  |           ( -- )           | ( -- ) non-recursive  |
|      for        |     FOR      |                       |     ( index -- )           | ( -- ) non-recursive  |
|     `7` for     |              |      PUSH_FOR(`7`)    |           ( -- )           | ( -- ) non-recursive  |
|      next       |     NEXT     |                       |           ( -- )           | ( -- ) non-recursive  |
|   `5` `1` do    |              |      XDO(`5`,`1`)     |           ( -- )           | ( -- ) non-recursive  |
|   `5` `1` ?do   |              |  QUESTIONXDO(`5`,`1`) |           ( -- )           | ( -- ) non-recursive  |
|                 |              |         XLOOP         |           ( -- )           | ( -- ) non-recursive  |
|   `2` +loop     |              |   PUSH_ADDXLOOP(`2`)  |           ( -- )           | ( -- ) non-recursive  |

#### Recursive
The variables are stored in the return address stack.

|     original    |   M4 FORTH   |     optimization      |  data stack                |  return address stack |
| :-------------: | :----------: | :-------------------: | :------------------------- | :-------------------- |
|     unloop      |    UNLOOP    |                       |         ( ? -- )           | ( ? -- )              |
|      leave      |    LEAVE     |                       |         ( ? -- )           | ( ? -- )              |
|        i        |              |          RI           |           ( -- i )         | ( i -- i )            |
|        j        |              |          RJ           |           ( -- j )         | ( j i -- j i )        |
|        k        |              |          RK           |           ( -- k )         | ( k j i -- k j i )    |
|       do        |      RDO     |                       |( stop index -- )           | ( -- stop index )     |
|      ?do        |  QUESTIONRDO |                       |( stop index -- )           | ( -- stop index )     |
|      loop       |     RLOOP    |                       |           ( -- )           | ( s i -- s i+1 )      |
|     +loop       |   ADDRLOOP   |                       |      ( step -- )           | ( s i -- s i+step )   |
|   `3` +loop     |              |  PUSH_ADDRLOOP(`3`)   |           ( -- )           | ( s i -- s i+`3` )    |
|      for        |     RFOR     |                       |     ( index -- )           | ( -- index )          |
|      next       |     RNEXT    |                       |           ( -- )           | ( -- index-1)         |
|   `5` `1` do    |              |     RXDO(`5`,`1`)     |           ( -- )           | ( -- `5` `1` )        |
|   `5` `1` ?do   |              | QUESTIONRXDO(`5`,`1`) |           ( -- )           | ( -- `5` `1` )        |
|                 |              |         RLOOP         |           ( -- )           | ( index -- index+1 )  |
|   `2` +loop     |              |  PUSH_ADDXRLOOP(`2`)  |           ( -- )           | ( index -- index+`2` )|

The variables are stored in the data stack.

|     original    |   M4 FORTH   |     optimization      |  data stack                |  r. a. stack |
| :-------------: | :----------: | :-------------------: | :------------------------- | :----------- |
|      unloop     |    UNLOOP    |                       |         ( ? -- )           | ( ? -- )     |
|      leave      |    LEAVE     |                       |         ( ? -- )           | ( ? -- )     |
|        i        |              |           SI          |         ( i -- i i )       | ( -- )       |
|       do        |              |          SDO          |    ( stop i -- stop i )    | ( -- )       |
|       ?do       |              |      QUESTIONSDO      |    ( stop i -- stop i )    | ( -- )       |
|      loop       |              |         SLOOP         |    ( stop i -- stop i+1)   | ( -- )       |
|      +loop      |              |        ADDSLOOP       |( end i step -- end i+step )| ( -- )       |
|    `4` +loop    |              |   PUSH_ADDSLOOP(`4`)  |     ( end i -- end i+`4` ) | ( -- )       |
|       for       |              |          SFOR         |     ( index -- index )     | ( -- )       |
|      next       |              |         SNEXT         |     ( index -- index-1 )   | ( -- )       |
|      begin      |    BEGIN     |                       |           ( -- )           |              |
|                 |    BREAK     |                       |           ( -- )           |              |
|     while       |    WHILE     |                       |      ( flag -- )           |              |
|   dup while     |              |       DUP_WHILE       |      ( flag -- flag )      |              |
|     =  while    |              |       EQ_WHILE        |     ( x2 x1 -- )           |              |
|     <> while    |              |       NE_WHILE        |     ( x2 x1 -- )           |              |
|     <  while    |              |       LT_WHILE        |     ( x2 x1 -- )           |              |
|     <= while    |              |       LE_WHILE        |     ( x2 x1 -- )           |              |
|     >  while    |              |       GT_WHILE        |     ( x2 x1 -- )           |              |
|     >= while    |              |       GE_WHILE        |     ( x2 x1 -- )           |              |
|    u=  while    |              |      UEQ_WHILE        |     ( x2 x1 -- )           |              |
|    u<> while    |              |      UNE_WHILE        |     ( x2 x1 -- )           |              |
|    u<  while    |              |      ULT_WHILE        |     ( x2 x1 -- )           |              |
|    u<= while    |              |      ULE_WHILE        |     ( x2 x1 -- )           |              |
|    u>  while    |              |      UGT_WHILE        |     ( x2 x1 -- )           |              |
|    u>= while    |              |      UGE_WHILE        |     ( x2 x1 -- )           |              |
|dup `2`  =  while|              | DUP_PUSH_EQ_WHILE(`2`)|           ( -- )           |              |
|dup `2`  <> while|              | DUP_PUSH_NE_WHILE(`2`)|           ( -- )           |              |
|dup `2`  <  while|              | DUP_PUSH_LT_WHILE(`2`)|           ( -- )           |              |
|dup `2`  <= while|              | DUP_PUSH_LE_WHILE(`2`)|           ( -- )           |              |
|dup `2`  >  while|              | DUP_PUSH_GT_WHILE(`2`)|           ( -- )           |              |
|dup `2`  >= while|              | DUP_PUSH_GE_WHILE(`2`)|           ( -- )           |              |
|dup `2` u=  while|              |DUP_PUSH_UEQ_WHILE(`2`)|           ( -- )           |              |
|dup `2` u<> while|              |DUP_PUSH_UNE_WHILE(`2`)|           ( -- )           |              |
|dup `2` u<  while|              |DUP_PUSH_ULT_WHILE(`2`)|           ( -- )           |              |
|dup `2` u<= while|              |DUP_PUSH_ULE_WHILE(`2`)|           ( -- )           |              |
|dup `2` u>  while|              |DUP_PUSH_UGT_WHILE(`2`)|           ( -- )           |              |
|dup `2` u>= while|              |DUP_PUSH_UGE_WHILE(`2`)|           ( -- )           |              |
| 2dup  =  while  |              |    _2DUP_EQ_WHILE     |           ( -- )           |              |
| 2dup  <> while  |              |    _2DUP_NE_WHILE     |           ( -- )           |              |
| 2dup  <  while  |              |    _2DUP_LT_WHILE     |           ( -- )           |              |
| 2dup  <= while  |              |    _2DUP_LE_WHILE     |           ( -- )           |              |
| 2dup  >  while  |              |    _2DUP_GT_WHILE     |           ( -- )           |              |
| 2dup  >= while  |              |    _2DUP_GE_WHILE     |           ( -- )           |              |
| 2dup u=  while  |              |   _2DUP_UEQ_WHILE     |           ( -- )           |              |
| 2dup u<> while  |              |   _2DUP_UNE_WHILE     |           ( -- )           |              |
| 2dup u<  while  |              |   _2DUP_ULT_WHILE     |           ( -- )           |              |
| 2dup u<= while  |              |   _2DUP_ULE_WHILE     |           ( -- )           |              |
| 2dup u>  while  |              |   _2DUP_UGT_WHILE     |           ( -- )           |              |
| 2dup u>= while  |              |   _2DUP_UGE_WHILE     |           ( -- )           |              |
|     repeat      |    REPEAT    |                       |           ( -- )           |              |
|     again       |    AGAIN     |                       |           ( -- )           |              |
|     until       |    UNTIL     |                       |      ( flag -- )           |              |

### Other

https://github.com/DW0RKiN/M4_FORTH/blob/master/M4/other.m4

|    original    |      M4 FORTH     |    optimization    |   data stack          | comment          |
| :------------: | :---------------: | :----------------: | :-------------------- | :--------------- |
|                |   INIT(RAS_addr)  |                    |                       | save SP, set RAS |
|      bye       |        BYE        |                    |          ( -- )       | goto STOP        |
|                |       STOP        |                    |          ( -- )       | load SP & HL'    |
|`1` constant ONE| CONSTANT(ONE,`1`) |                    |          ( -- )       | ONE equ `1`      |
|    `3` var X   |  VARIABLE(X,`3`)  |                    |          ( -- )       | X: dw `3`        |
|   variable X   |    VARIABLE(X)    |                    |          ( -- )       | X: dw 0x0000     |
|   'a' cvar X   |  CVARIABLE(X,'a') |                    |          ( -- )       | X: db 'a'        |
|   `4` dvar X   |  DVARIABLE(X,`4`) |                    |          ( -- )       | X: dw `4`, 0x0000|
|        @       |       FETCH       |                    |     ( addr -- x )     | TOP = (addr)     |
|     addr @     |                   |  PUSH_FETCH(addr)  |          ( -- x )     | TOP = (addr)     |
|        !       |       STORE       |                    |   ( x addr -- )       | (addr) = x       |
|     addr !     |                   |  PUSH_STORE(addr)  |        ( x -- )       | (addr) = x       |
|    x addr !    |                   |PUSH2_STORE(x,addr) |          ( -- )       | (addr) = x       |
|       C@       |       CFETCH      |                    |     ( addr -- char )  | TOP = (addr)     |
|     addr C@    |                   | PUSH_CFETCH(addr)  |          ( -- char )  | TOP = (addr)     |
|       C!       |       CSTORE      |                    |( char addr -- )       | (addr) = char    |
|     addr C!    |                   | PUSH_CSTORE(addr)  |     ( char -- )       | (addr) = char    |
|    x addr C!   |                   |PUSH2_CSTORE(x,addr)|          ( -- )       | (addr) = char    |
|       2@       |      _2FETCH      |                    |     ( addr -- hi lo ) |                  |
|     addr 2@    |                   | PUSH_2FETCH(addr)  |          ( -- hi lo ) |                  |
|       2!       |      _2STORE      |                    |( hi lo adr -- )       | (addr) = 32 bit  |
|     addr 2!    |                   | PUSH_2STORE(addr)  |    ( hi lo -- )       | (addr) = 32 bit  |
|    x addr 2!   |                   |PUSH2_2STORE(x,addr)|       ( hi -- )       | (addr) = 32 bit  |
|       +!       |      ADDSTORE     |                    |   ( x addr -- )       | (addr) += x      |
|   x addr +!    |PUSH2_ADDSTORE(x,a)|                    |          ( -- )       | (a) += x         |
|     cmove      |       CMOVE       |                    |( from to u -- )       | 8bit, addr++     |
|    `3` cmove   |                   |  PUSH_CMOVE(`3`)   |  ( from to -- )       | 8bit, addr++     |
|     cmove>     |      CMOVEGT      |                    |( from to u -- )       | 8bit, addr--     |
|      move      |        MOVE       |                    |( from to u -- )       | 16bit, addr++    |
|      move>     |       MOVEGT      |                    |( from to u -- )       | 16bit, addr--    |
|      fill      |        FILL       |                    | ( addr u c -- )       | 8bit, addr++     |
|     c fill     |  PUSH_FILL(u,c)   |                    |   ( addr u -- )       | 8bit, addr++     |
|    u c fill    |  PUSH2_FILL(u,c)  |                    |     ( addr -- )       | 8bit, addr++     |
|   a u c fill   | PUSH3_FILL(a,u,c) |                    |          ( -- )       | 8bit, addr++     |
| `seed` seed !  |                   |  PUSH_STORE(SEED)  |     ( seed -- )       |                  |
|       rnd      |        RND        |                    |          ( -- random )|                  |
|     random     |       RANDOM      |                    |      ( max -- random )| random < max     |
|                |      PUTPIXEL     |                    |       ( yx -- HL )    |                  |
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
