include(`../M4/FIRST.M4')dnl
    ORG 32768
    INIT(60000)

    CONSTANT(ZX_LEFT,0x08)
    CONSTANT(ZX_RIGHT,0x09)

    CONSTANT(ZX_INK,0x10)
    CONSTANT(ZX_PAPER,0x11)
    CONSTANT(ZX_FLASH,0x12)
    CONSTANT(ZX_BRIGHT,0x13)
    CONSTANT(ZX_INVERSE,0x14)
    CONSTANT(ZX_OVER,0x15)
    CONSTANT(ZX_AT,0x16)
    CONSTANT(ZX_TAB,0x17)
    CONSTANT(ZX_CR,0x0D)

    CONSTANT(ZX_INK_BLACK,0x00)
    CONSTANT(ZX_INK_BLUE,0x01)
    CONSTANT(ZX_INK_RED,0x02)
    CONSTANT(ZX_INK_MAGENTA,0x03)
    CONSTANT(ZX_INK_GREEN,0x04)
    CONSTANT(ZX_INK_CYAN,0x05)
    CONSTANT(ZX_INK_YELLOW,0x06)
    CONSTANT(ZX_INK_WHITE,0x07)

    CONSTANT(ZX_PAPER_BLACK,0x00)
    CONSTANT(ZX_PAPER_BLUE,0x08)
    CONSTANT(ZX_PAPER_RED,0x10)
    CONSTANT(ZX_PAPER_MAGENTA,0x18)
    CONSTANT(ZX_PAPER_GREEN,0x20)
    CONSTANT(ZX_PAPER_CYAN,0x028)
    CONSTANT(ZX_PAPER_YELLOW,0x30)
    CONSTANT(ZX_PAPER_WHITE,0x38)

    CONSTANT(ZX_FLASHING,0x80)
    CONSTANT(ZX_BRIGHTNESS,0x40)

    ; set 0 lines in the lower section of the screen
    PUSH2_CSTORE(0,23659)

    PRINT_Z(dnl
{"Lorem ipsum dolor sit amet, cons}dnl
{ectetur adipiscing elit. Etiam p}dnl
{ellentesque, purus a tincidunt e}dnl
{uismod, turpis neque pretium ant}dnl
{e, et tempor purus metus a nisl.}dnl
{Aenean dictum tortor hendrerit n}dnl
{ibh luctus condimentum. Pellente}dnl
{sque vel urna eget risus digniss}dnl
{im volutpat. Praesent semper nis}dnl
{i quam, id egestas odio luctus u}dnl
{t. Suspendisse dignissim loborti}dnl
{s massa nec maximus. Interdum et}dnl
{malesuada fames ac ante ipsum pr}dnl
{imis in faucibus. Curabitur quis}dnl
{dui a lacus fringilla venenatis }dnl
{sed vel lacus. Duis scelerisque }dnl
{orci a risus cursus, in facilisi}dnl
{s metus condimentum. Sed ultrici}dnl
{es nibh vitae pretium placerat. }dnl
{Fusce et nibh at ante vehicula p}dnl
{haretra sed quis nisi. Aliquam t}dnl
{incidunt nulla at enim efficitur}dnl
{laoreet. Maecenas aliquam libero}dnl
{metus, nec commodo lacus vestibu"})
;lum ultrices.

    ; set 2 lines in the lower section of the screen
    PUSH2_CSTORE(2,23659)

    ; blue shadow
    PUSH3_FILL(0x5A85,23,ZX_PAPER_BLUE+ZX_INK_BLACK)
    PUSH(0x589C)
    PUSH_FOR(15)
       PUSH_ADD(32)
       PUSH_OVER_CSTORE(ZX_PAPER_BLUE+ZX_INK_BLACK)
    NEXT
    DROP

    ; cyan
    PUSH3_FILL(0x5884,24,ZX_PAPER_CYAN+ZX_INK_CYAN)

    ; light cyan
    PUSH(0x58A4)
    PUSH_FOR(14)
        DUP
        PUSH2_FILL(24,ZX_BRIGHTNESS+ZX_PAPER_CYAN+ZX_INK_CYAN)
        PUSH_ADD(32)
    NEXT
    DROP


    PRINT_Z({ZX_AT,4,4,ZX_PAPER,ZX_INK_CYAN}) DEPTH DOT PRINT_Z({" values in data stack"})

    PRINT_Z({ZX_BRIGHT,1,}dnl
dnl          123456789012345678901234
{ZX_AT, 5,4,"                        ",}dnl
{ZX_AT, 6,4,"Lorem ipsum dolor sit a-",}dnl
{ZX_AT, 7,4,"met, consectetur adipis-",}dnl
{ZX_AT, 8,4,"cing elit. Etiam pellen-",}dnl
{ZX_AT, 9,4,"tesque,  purus a  tinci-",}dnl
{ZX_AT,10,4,"dunt euismod, turpis ne-",}dnl
{ZX_AT,11,4,"que  pretium   ante,  et",}dnl
{ZX_AT,12,4,"tempor purus metus a ni-",}dnl
{ZX_AT,13,4,"sl. Aenean dictum tortor",}dnl
{ZX_AT,14,4,"hendrerit  nibh   luctus",}dnl
{ZX_AT,15,4,"condimentum.",ZX_AT,1,1})


    PUSH2(40*256+31,8)
    call(up)
    PUSH(192)
    call(right)
    PUSH(8)
    call(down)
    PUSH(192)
    call(left)
    PUSH(119)
    call(down)
    PUSH(192)
    call(right)
    PUSH(119)
    call(up)
    DROP

    STOP

;#COLON(diagonala,{})
;# diagonala(y,x) 0,0 --> 99,99
;#    XDO(25700,0)
;#        XI
;#        PUTPIXEL   ; ( Y*256+X -- addr )
;#        DROP
;#    PUSH_ADDXLOOP(256+1)
;#SEMICOLON

COLON(left,{( yx n -- yx )})
    ;( yx n -- yx )
    FOR
        PUTPIXEL
         ; x--
        _1SUB
    NEXT
SEMICOLON

COLON(right,{( yx n -- yx )})
    ;( yx n -- yx )
    FOR
        PUTPIXEL
         ; x++
        _1ADD
    NEXT
SEMICOLON

COLON(up,{( yx n -- yx )})
    ;( yx n -- yx )
    FOR
        PUTPIXEL
        ; y--
        PUSH_SUB(256)
    NEXT
SEMICOLON

COLON(down,{( yx n -- yx )})
    ;( yx n -- yx )
    FOR
        PUTPIXEL
        ; y++
        PUSH_ADD(256)
    NEXT
SEMICOLON
