# M4 FORTH (ZX Spectrum, Z80)

A simple FORTH compiler created with M4 macros. Creates readable code in the Z80 assembler. No peephole optimization. The small Runtime library is intended for the ZX Spectrum computer.

The compiler is suitable for study purposes due to its simplicity. Can be easily edited. For the most part, this is a simple replacement for a FORTH word for a sequence of instructions. 

The more complex part is branching and loops.

## Use registers

Internal implementation of data stack and return address stack.

    Data Stack:

    HL                  TOP (top of stack)
    DE                  NOS (next on stack)
    (SP)                NNOS
    (SP+2)
    (SP+4)
    ...

    Return Stack or Loop stack:

    (HL')              
    (HL'+2)
    (HL'+4)
    (HL'+6)
    (HL'+8)
    ...

    Free registers: AF, AF', BC, DE', BC', IX, IY

    Pollutes register: AF, AF', BC, DE', BC'

## Branching

Branching internally creates new names for the label. This is a simple increase in numbers for `else100` and `endif100`. Numbers start with three digits for better alignment. At the end of the branch, it is determined whether the "else" part has been used. `if` always jumps on `else1..`. If `else1..` was not used it should stack the value with `endif1..`. `endif1..` always exists for potential use to jump out of a branch.`

## Loops

Looping internally creates new names for the label. `DO` increments the last number used at `do100`. And store it on the stack. `LOOP` reads the last stored number from the stack. This connects DO and LOOP whether they are used in parallel or in series. When the program is executed, the loops store the indexes on the return address stack.

## Creating new words

It is created using functions. The return value of the function is stored in the return address stack. Recursion is triggered by simply calling yourself.

## Compilation

    m4 my_program_name.m4 > my_program_name.asm
    pasmo -d my_program_name.asm my_program_name.bin > test.asm

## Hello World!

For clarity, macros are divided into several files and stored in the M4 directory.
To avoid having to manually include each file, a FIRST.M4 file is created that includes all other files.
So the first thing that needs to be done is to include this file using:

    include(`./M4/FIRST.M4')dnl

From now on, they are replaced with `' for {}.

LAST.M4 must be appended to the end of the file using:

    include ({./M4/LAST.M4})dnl

This file creates, among other things, the functions used at the end of the program. For example, to list a string or a number. Multiplication and division functions. Saves used strings, or allocates space for used variables.

Use the `INIT(xxx)` and `STOP` macros so that the program can be called from the Basic ZX spectrum and returned successfully. These save the shadow registers and set the value for the return address stack to xxx.

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
        ld   HL, 60000
        exx

        push DE             ; 1:11      print
        push HL             ; 1:11      print
        ld    L, 0x1A       ; 2:7       print Upper screen
        call 0x1605         ; 3:17      print Open channel
        ld   BC, size101    ; 3:10      print Length of string to print
        ld   DE, string101  ; 3:10      print Address of string
        call 0x203C         ; 3:17      print Print our string
        pop  HL             ; 1:10      print
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

Macro names cannot be just `.` or `>`, but an alphanumeric name. So must be renamed to `DOT` or `LT`. All FORTH words are in uppercase! Because `+` is written as `ADD`. This means that the assembler uses `add` for addition so that it is not interpreted as a macro.
    
Theoretically, your function name or variable may conflict with the name of the macro used. So check it out. The worse case is when you make a mistake in the name of the macro. Then it will not expand and will probably be hidden in the comment of the previous macro.

## Implemented words FORTH

### Stack manipulation

| original   |   M4 FORTH   |  optimization  |   data stack                     |  return address stack |
| :--------: | :----------: | :------------: | :------------------------------- | :-------------------- |
|    swap    |     SWAP     |                |     ( x2 x1 -- x1 x2 )           |                       |
|    dup     |      DUP     |                |        ( x1 -- x1 x1 )           |                       |
|    2dup    |     DUP2     |                |     ( x2 x1 -- x2 x1 x2 x1 )     |                       |
|    drop    |     DROP     |                |        ( x1 -- )                 |                       |
|   2drop    |     DROP2    |                |     ( x2 x1 -- )                 |                       |
|    nip     |      NIP     |                |     ( x2 x1 -- x1 )              |                       |
|   tuck     |     TUCK     |                |     ( x2 x1 -- x1 x2 x1 )        |                       |
|   over     |     OVER     |                |     ( x2 x1 -- x2 x1 x2 )        |                       |
|    rot     |      ROT     |                |  ( x3 x2 x1 -- x2 x1 x3 )        |                       |
|   -rot     |     RROT     |                |  ( x3 x2 x1 -- x1 x3 x2 )        |                       |
|   `123`    |  PUSH(`123`) |   PUSH2()      |           ( -- `123` )           |                       |
|   `2` `1`  |PUSH2(`2`,`1`)|                |           ( -- `2` `1` )         |                       |
| addr `7` ! | PUSH((addr)) |                | *addr = 7 --> ( -- `7`)          |                       |
|            |              | PUSH2((A),`2`) | *A = 4 --> ( -- `4` `2` )        |                       |
| drop `5`   |              | DROP_PUSH(`5`) |        ( x1 -- `5`)              |                       |
|  dup `4`   |              |  DUP_PUSH(`4`) |        ( x1 -- x1 x1 `4`)        |                       |
|   0 pick   |              |     XPICK0     |         ( a -- a a )             |                       |
|   1 pick   |              |     XPICK1     |       ( b a -- b a b )           |                       |
|   2 pick   |              |     XPICK2     |     ( c b a -- c b a c )         |                       |
|   3 pick   |              |     XPICK3     |   ( d c b a -- d c b a d )       |                       |
|     >r     |   RAS_PUSH   |                |        ( x1 -- )                 |    ( -- x1 )          |
|     r>     |    RAS_POP   |                |           ( -- x1 )              | ( x1 -- )             |

### Arithmetic

| original   |   M4 FORTH   |  optimization  |   data stack                     |  return address stack |
| :--------: | :----------: | :------------: | :------------------------------- | :-------------------- |
|     +      |     ADD      |                |     ( x2 x1 -- x )               |                       |
|     -      |     SUB      |                |     ( x2 x1 -- x )               |                       |
|   negate   |    NEGATE    |                |        ( x1 -- -x1 )             |                       |
|    abs     |     ABS      |                |         ( n -- u )               |                       |
|     *      |  i am lazy   |                |     ( x2 x1 -- x )               |                       |
|     /      |  i am lazy   |                |     ( x2 x1 -- x )               |                       |
|    mod     |  i am lazy   |                |     ( x2 x1 -- x )               |                       |
|    /mod    |  i am lazy   |                |     ( x2 x1 -- x )               |                       |
|     u*     |     UMUL     |                |     ( x2 x1 -- x )               |                       |
|     u/     |     UDIV     |                |     ( x2 x1 -- x )               |                       |
|    umod    |     UMOD     |                |     ( x2 x1 -- x )               |                       |
|    u/mod   |    UDIVMOD   |                |     ( x2 x1 -- rem quot )        |                       |
|     1+     |    ONE_ADD   |                |        ( x1 -- x1++ )            |                       |
|     1-     |    ONE_SUB   |                |        ( x1 -- x1-- )            |                       |
|     2+     |    TWO_ADD   |                |        ( x1 -- x1+2 )            |                       |
|     2-     |    TWO_SUB   |                |        ( x1 -- x1-2 )            |                       |
|     2*     |    TWO_MUL   |                |        ( x1 -- x1*2 )            |                       |
|     2/     |    TWO_DIV   |                |        ( x1 -- x1/2 )            |                       |

### Logic

| original   |   M4 FORTH   |  optimization  |  data stack           |  return address stack | comment      |
| :--------: | :----------: | :------------: | :-------------------- | :-------------------- | :----------- |
|    and     |     AND      |                |    ( x2 x1 -- x )     |                       |              |
|     or     |      OR      |                |    ( x2 x1 -- x )     |                       |
|    xor     |     XOR      |                |       ( x1 -- -x1 )   |                       |
|    abs     |     ABS      |                |        ( n -- u )     |                       |
|   invert   |    INVERT    |                |       ( x1 -- ~x1 )   |                       |
|    true    |     TRUE     |                |          ( -- -1 )    |                       |
|   false    |    FALSE     |                |          ( -- 0 )     |                       |
|            |              |      CP0       |       ( x1 -- x1 )    |                       | x1-0 --> set zero flag
|            |              |     DCP0       |    ( x2 x1 -- x2 x1 ) |                       | x2x1-0 --> set zero flag
|   `0` =    |              |      EQ0       |       ( x1 -- x )     |                       |
|  `0` <>    |              |      NE0       |       ( x1 -- x )     |                       | Do not use! Change True `3` to True `-1`
|      =     |      EQ      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
|     <>     |      NE      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
|      <     |      LT      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
|     <=     |      LE      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
|      >     |      GT      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
|     >=     |      GE      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
|      <     |     ULT      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
|     <=     |     ULE      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
|      >     |     UGT      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
|     >=     |     UGE      |                |    ( x2 x1 -- flag )  |                       | TRUE=-1 FALSE=0
| x1 u >> x  |  i am lazy   |                |    ( x1 u -- x1>>u )  |                       |
| x1 u << x  |  i am lazy   |                |    ( x1 u -- x1<<u )  |                       |
| x1 1 >> x  |              |    XRSHIFT1    |      ( x1 -- x1>>1 )  |                       | signed
| x1 1 << x  |              |    XLSHIFT1    |      ( x1 -- x1<<1 )  |                       |
| u1 1 >> u  |              |   XURSHIFT1    |      ( u1 -- u1>>1 )  |                       | unsigned
| u1 1 << u  |              |   XULSHIFT1    |      ( u1 -- u1<<1 )  |                       |

### Device

| original   |   M4 FORTH   |  optimization  |   data stack                     |  return address stack |
| :--------: | :----------: | :------------: | :------------------------------- | :-------------------- |
|     .      |     DOT      |                |        ( x1 -- )                 |                       |
|     .s     |     DOTS     |                |  ( x3 x2 x1 -- x3 x2 x1 )        |                       |
|   DUP .    |    DUP_DOT   |                |        ( x1 -- x1 )              |                       |
|     cr     |      CR      |                |           ( -- )                 |                       |
|            | PUTCHAR('a') |                |           ( -- )                 |                       |
|    type    |     TYPE     |                |    ( addr n -- )                 |                       |
| dup2 type  |  DUP2_TYPE   |                |    ( addr n -- addr n )          |                       |
| .( Hello)  |PRINT("Hello")|                |           ( -- )                 |                       |

The problem with PRINT is that M4 ignores the `"`. M4 does not understand that `"` it introduces a string. So if there is a comma in the string, it would save only the part before the comma, because the comma introduces another parameter.
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

| original   |   M4 FORTH   |  optimization  |   data stack                     |  return address stack | comment          |
| :--------: | :----------: | :------------: | :------------------------------- | :-------------------- | :--------------- |
|     if     |      IF      |                |      ( flag -- )                 |                       |
|            |     IFNZ     |                |           ( -- )                 |                       | IF not zero flag
|            |     IFZ      |                |           ( -- )                 |                       | IF zero flag
|    else    |     ELSE     |                |           ( -- )                 |                       |
|    then    |     THEN     |                |           ( -- )                 |                       |

### Function

| original   |     M4 FORTH     |    optimization   |   data stack                     |  return address stack |
| :--------: | :--------------: | :---------------: | :------------------------------- | :-------------------- |
|    name    |    CALL(name)    |                   |     ( x2 x1 -- ret x2 x1 )       | ( -- )                |
|     :      |COLON(name,coment)|                   | ( ret x2 x1 -- x2 x1 )           | ( -- ret )            |
|     ;      |     SEMICOLON    |                   |           ( -- )                 | ( ret -- )            |
|    exit    |       EXIT       |                   |           ( -- )                 | ( ret -- )            |
|    name    |                  |    SCALL(name)    |     ( x2 x1 -- ret x2 x1 )       | ( -- )                |
|     :      |                  |SCOLON(name,coment)| ( ret x2 x1 -- ret x2 x1 )       | ( -- )                |
|     ;      |                  |     SSEMICOLON    | ( ret x2 x1 -- x2 x1 )           | ( -- )                |
|    exit    |                  |       SEXIT       | ( ret x2 x1 -- x2 x1 )           | ( -- )                |


### LOOP

| original   |   M4 FORTH   |  optimization  |   data stack                     |  return address stack |
| :--------: | :----------: | :------------: | :------------------------------- | :-------------------- |
|     do     |      DO      |                | ( stop index -- )                | ( -- stop index )     |
|    loop    |     LOOP     |                |            ( -- )                | ( stop index -- )     |
|   unloop   |    UNLOOP    |                |            ( -- )                | ( x -- )              |
|      i     |       I      |                |            ( -- index )          | ( index -- index )    |
|      j     |       J      |                |            ( -- j )              | ( j s i -- j s i )    |
|            |              |      SDO       | ( stop index -- stop index )     | ( -- )                |
|            |              |     SLOOP      | ( stop index -- )                | ( -- )                |
|            |              |    UNSLOOP     | ( stop index -- )                | ( -- )                |
|            |              |       SI       |        ( s i -- s i i )          | ( -- )                |
| `5` `1` do |              |  XDO(`5`,`1`)  |            ( -- )                | ( -- `1` )            |
|            |              |     XLOOP      |            ( -- )                | ( index -- index++ )  |
| `2` +LOOP  |              | PLUSXLOOP(`2`) |            ( -- )                | ( index -- index+`2` )|
|            |              |    UNXLOOP     |            ( -- )                | ( index -- )          |
|     i      |              |       XI       |            ( -- i )              | ( i -- i )            |
|     j      |              |       XJ       |            ( -- j )              | ( j i -- j i )        |
|     k      |              |       XK       |            ( -- k )              | ( k j i -- k j i )    |
|   begin    |    BEGIN     |                |            ( -- )                |                       |
|   while    |    WHILE     |                |       ( flag -- )                |                       |
|   repeat   |    REPEAT    |                |            ( -- )                |                       |
|   again    |    AGAIN     |                |            ( -- )                |                       |
|   until    |    UNTIL     |                |       ( flag -- )                |                       |


### Other

| original   |    M4 FORTH   |  optimization  |   data stack                     |  return address stack | comment      |
| :--------: | :-----------: | :------------: | :------------------------------- | :-------------------- | :----------- |
|            | INIT(RAS_addr)|                |                                  |  Init HL' = RAS_addr  |              |
|            |     STOP      |                |            ( -- )                |  Load orig. HL'       |
|  constant  |   CONSTANT    |                |            ( -- )                |                       |
|  variable  | VARIABLE(PI)  |                |            ( -- index )          |                       |
|   addr @   |    FETCH      |                |       ( addr -- x )              |                       |
|            |               |  XFETCH(addr)  |            ( -- x )              |                       |
|  addr x !  |    STORE      |                |     ( addr x -- )                |                       | (addr) --> x |
|            |               |  XSTORE(addr)  |          ( x -- )                |                       |  x --> (addr)|

## External links

http://wiki.laptop.org/go/Forth_Lessons

http://astro.pas.rochester.edu/Forth/forth-words.html

https://www.tutorialspoint.com/execute_forth_online.php

https://www.gnu.org/software/m4/manual/m4-1.4.15/html_node/index.html#Top
