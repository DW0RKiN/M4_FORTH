; vvvvv
include(`../M4/FIRST.M4')dnl
; ^^^^^
    define({USE_FONT_5x8})
    ORG 0x8000
    INIT(60000)

    PRINT_I({"( x2 x1 -- ) and ( u2 u1 -- ): ",0x0D})
    PUSH2( 5,-5) CALL(x_x_test)
    PUSH2( 5, 5) CALL(x_x_test)
    PUSH2(-5,-5) CALL(x_x_test)
    PUSH2(-5, 5) CALL(x_x_test)
    PRINT_I({"( d2 d1 -- ) and ( ud2 ud1 -- ): ",0x0D})
    PUSHDOT( 5) PUSHDOT(-5) CALL(d_d_test)
    PUSHDOT( 5) PUSHDOT( 5) CALL(d_d_test)
    PUSHDOT(-5) PUSHDOT(-5) CALL(d_d_test)
    PUSHDOT(-5) PUSHDOT( 5) CALL(d_d_test)
    
    PUSH( 3) CALL(x_p3_test)
    PUSH(-3) CALL(x_p3_test)
    PUSH( 3) CALL(x_m3_test)
    PUSH(-3) CALL(x_m3_test)
    
    PRINT_I({0x0D, "m d e f 1 0 1 2 3 4 M ", 0x0D})

    VARIABLE(_max,0x7FFF)
    VARIABLE(_p0x3334,0x3334)
    VARIABLE(_p0x3333,0x3333)
    VARIABLE(_p0x3332,0x3332)
    VARIABLE(_p1,1)
    VARIABLE(_zero,0)
    VARIABLE(_m1,-1)
    VARIABLE(_xFEFF,0xFEFF)
    VARIABLE(_xFEFE,0xFEFE)
    VARIABLE(_xFEFD,0xFEFD)
    VARIABLE(_min,0x8000)

min equ 0x8000
xFEFD equ 0xFEFD
xFEFE equ 0xFEFE
xFEFF equ 0xFEFF
m1 equ -1
zero equ 0
p1 equ 1
x3332 equ 0x3332
x3333 equ 0x3333
x3334 equ 0x3334
max equ 0x7FFF

__ASM({; ---- min ------})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < 0x8000})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE( 0x8000,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < 0x8000 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < 0x8000})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(0x8000,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < 0x8000 ",0x0D})
    

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < min})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(    min,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < min ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < min})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(   min,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < min ", 0x10, 0x02, 0x0D})
    
__ASM({; ---- 0xFEFD = 65277 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +65277})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(   65277,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < +65277 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +65277})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(  65277,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < +65277 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < xFEFD})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE( xFEFD,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < xFEFD ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < xFEFD})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE( xFEFD,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < xFEFD ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0xFEFE = 65278 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +65278})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(   65278,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < +65278 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +65278})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(  65278,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < +65278 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < xFEFE})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE( xFEFE,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < xFEFE ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < xFEFE})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE( xFEFE,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < xFEFE ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0xFEFF = 65279 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +65279})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(   65279,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < +65279 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +65279})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(  65279,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < +65279 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < xFEFF})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE( xFEFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < xFEFF ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < xFEFF})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE( xFEFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < xFEFF ", 0x10, 0x00, 0x0D})

__ASM({; ---- -1 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < -1})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(     -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < -1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < -1})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(    -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < -1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < m1})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(     m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < m1 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < m1})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(    m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < m1 ", 0x10, 0x02, 0x0D})
    
__ASM({; ---- 0 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < 0})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(      0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < 0 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < 0})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(     0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < 0 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < zero})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(   zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < zero ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < zero})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(  zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < zero ", 0x10, 0x00, 0x0D})

__ASM({; ---- 1 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +1})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(      1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < +1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +1})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(     1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < +1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < p1})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(     p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < p1 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < p1})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(    p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < p1 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3332 = 13106 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +13106})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(   13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < +13106 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +13106})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(  13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < +13106 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < x3332})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < x3332 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < x3332})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < x3332 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3333 = 13107 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +13107})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(   13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < +13107 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +13107})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(  13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < +13107 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < x3333})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < x3333 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < x3333})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < x3333 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3334 = 13108 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +13108})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(   13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < +13108 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < +13108})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(  13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < +13108 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < x3334})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < x3334 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < x3334})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < x3334 ", 0x10, 0x00, 0x0D})
    
__ASM({; ---- max ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < 0x7FFF})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE( 0x7FFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < 0x7FFF ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < 0x7FFF})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(0x7FFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < 0x7FFF ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < max})
         __MAKE_CODE_DUP_PUSH_LT_JP_FALSE(    max,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" < max ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ < max})
         __MAKE_CODE_PUSH_LT_DROP_JP_FALSE(   max,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" < max ", 0x10, 0x02, 0x0D})

__ASM({; ---- min ------})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=0x8000})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE( 0x8000,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=0x8000 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=0x8000})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(0x8000,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=0x8000 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=min})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(    min,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=min ",0x0D})
        
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=min})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(   min,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=min ", 0x10, 0x00, 0x0D})
    
__ASM({; ---- 0xFEFD = 65277 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+65277})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(   65277,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=+65277 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+65277})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(  65277,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=+65277 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=xFEFD})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE( xFEFD,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=xFEFD ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=xFEFD})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE( xFEFD,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=xFEFD ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0xFEFE = 65278 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+65278})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(   65278,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=+65278 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+65278})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(  65278,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=+65278 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=xFEFE})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE( xFEFE,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=xFEFE ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=xFEFE})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE( xFEFE,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=xFEFE ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0xFEFF = 65279 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+65279})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(   65279,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=+65279 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+65279})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(  65279,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=+65279 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=xFEFF})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE( xFEFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=xFEFF ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=xFEFF})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE( xFEFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=xFEFF ", 0x10, 0x02, 0x0D})

__ASM({; ---- -1 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=-1})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(     -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=-1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=-1})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(    -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=-1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=m1})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(     m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=m1 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=m1})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(    m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=m1 ", 0x10, 0x00, 0x0D})
    
__ASM({; ---- 0 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=0})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(      0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=0 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=0})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(     0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=0 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=zero})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(   zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=zero ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=zero})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(  zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=zero ", 0x10, 0x02, 0x0D})

__ASM({; ---- 1 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+1})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(      1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=+1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+1})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(     1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=+1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=p1})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(     p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=p1 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=p1})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(    p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=p1 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3332 = 13106 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+13106})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(   13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=+13106 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+13106})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(  13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=+13106 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=x3332})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=x3332 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=x3332})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=x3332 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3333 = 13107 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+13107})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(   13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=+13107 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+13107})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(  13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=+13107 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=x3333})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=x3333 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=x3333})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=x3333 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3334 = 13108 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+13108})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(   13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=+13108 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=+13108})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(  13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=+13108 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=x3334})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=x3334 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=x3334})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=x3334 ", 0x10, 0x02, 0x0D})
    
__ASM({; ---- max ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=0x7FFF})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE( 0x7FFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=0x7FFF ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=0x7FFF})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(0x7FFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=0x7FFF ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=max})
         __MAKE_CODE_DUP_PUSH_LE_JP_FALSE(    max,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" <=max ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ <=max})
         __MAKE_CODE_PUSH_LE_DROP_JP_FALSE(   max,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" <=max ", 0x10, 0x00, 0x0D})

__ASM({; ---- min ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=0x8000})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE( 0x8000,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=0x8000 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=0x8000})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(0x8000,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=0x8000 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=min})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(    min,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=min ",0x0D})
        
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=min})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(   min,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=min ", 0x10, 0x02, 0x0D})
    
__ASM({; ---- 0xFEFD = 65277 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+65277})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(   65277,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=+65277 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+65277})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(  65277,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=+65277 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=xFEFD})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE( xFEFD,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=xFEFD ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=xFEFD})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE( xFEFD,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=xFEFD ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0xFEFE = 65278 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+65278})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(   65278,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=+65278 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+65278})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(  65278,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=+65278 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=xFEFE})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE( xFEFE,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=xFEFE ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=xFEFE})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE( xFEFE,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=xFEFE ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0xFEFF = 65279 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+65279})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(   65279,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=+65279 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+65279})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(  65279,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=+65279 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=xFEFF})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE( xFEFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=xFEFF ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=xFEFF})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE( xFEFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=xFEFF ", 0x10, 0x00, 0x0D})

__ASM({; ---- -1 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=-1})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(     -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=-1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=-1})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(    -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=-1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=m1})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(     m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=m1 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=m1})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(    m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=m1 ", 0x10, 0x02, 0x0D})
    
__ASM({; ---- 0 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=0})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(      0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=0 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=0})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(     0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=0 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=zero})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(   zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=zero ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=zero})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(  zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=zero ", 0x10, 0x00, 0x0D})

__ASM({; ---- 1 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+1})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(      1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=+1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+1})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(     1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=+1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=p1})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(     p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=p1 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=p1})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(    p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=p1 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3332 = 13106 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+13106})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(   13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=+13106 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+13106})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(  13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=+13106 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=x3332})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=x3332 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=x3332})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=x3332 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3333 = 13107 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+13107})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(   13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=+13107 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+13107})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(  13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=+13107 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=x3333})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=x3333 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=x3333})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=x3333 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3334 = 13108 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+13108})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(   13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=+13108 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=+13108})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(  13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=+13108 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=x3334})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=x3334 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=x3334})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=x3334 ", 0x10, 0x00, 0x0D})
    
__ASM({; ---- max ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=0x7FFF})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE( 0x7FFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=0x7FFF ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=0x7FFF})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(0x7FFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=0x7FFF ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=max})
         __MAKE_CODE_DUP_PUSH_GE_JP_FALSE(    max,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" >=max ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ >=max})
         __MAKE_CODE_PUSH_GE_DROP_JP_FALSE(   max,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" >=max ", 0x10, 0x02, 0x0D})

__ASM({; ---- min ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > 0x8000})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE( 0x8000,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > 0x8000 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > 0x8000})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(0x8000,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > 0x8000 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > min})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(    min,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > min ",0x0D})
        
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > min})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(   min,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > min ", 0x10, 0x00, 0x0D})
    
__ASM({; ---- 0xFEFD = 65277 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +65277})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(   65277,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > +65277 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +65277})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(  65277,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > +65277 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > xFEFD})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE( xFEFD,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > xFEFD ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > xFEFD})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE( xFEFD,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > xFEFD ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0xFEFE = 65278 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +65278})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(   65278,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > +65278 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +65278})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(  65278,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > +65278 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > xFEFE})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE( xFEFE,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > xFEFE ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > xFEFE})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE( xFEFE,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > xFEFE ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0xFEFF = 65279 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +65279})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(   65279,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > +65279 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +65279})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(  65279,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > +65279 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > xFEFF})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE( xFEFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > xFEFF ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > xFEFF})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE( xFEFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > xFEFF ", 0x10, 0x02, 0x0D})

__ASM({; ---- -1 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > -1})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(     -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > -1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > -1})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(    -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > -1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > m1})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(     m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > m1 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > m1})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(    m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > m1 ", 0x10, 0x00, 0x0D})
    
__ASM({; ---- 0 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > 0})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(      0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > 0 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > 0})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(     0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > 0 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > zero})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(   zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > zero ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > zero})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(  zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > zero ", 0x10, 0x02, 0x0D})

__ASM({; ---- 1 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +1})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(      1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > +1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +1})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(     1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > +1 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > p1})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(     p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > p1 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > p1})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(    p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > p1 ", 0x10, 0x00, 0x0D})
    
__ASM({; ---- 0x3332 = 13106 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +13106})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(   13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > +13106 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +13106})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(  13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > +13106 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > x3332})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > x3332 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > x3332})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > x3332 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3333 = 13107 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +13107})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(   13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > +13107 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +13107})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(  13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > +13107 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > x3333})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > x3333 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > x3333})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > x3333 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3334 = 13108 ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +13108})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(   13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > +13108 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > +13108})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(  13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > +13108 ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > x3334})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > x3334 ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > x3334})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > x3334 ", 0x10, 0x02, 0x0D})
       
__ASM({; ---- max ------})
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > 0x7FFF})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE( 0x7FFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > 0x7FFF ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > 0x7FFF})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(0x7FFF,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > 0x7FFF ",0x0D})

    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > max})
         __MAKE_CODE_DUP_PUSH_GT_JP_FALSE(    max,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" > max ",0x0D})
    
    PUSH(0) PUSH(10) DO I _2MUL PUSH(_max) ADD FETCH 
      __ASM({
         define({__INFO},{ > max})
         __MAKE_CODE_PUSH_GT_DROP_JP_FALSE(   max,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" > max ", 0x10, 0x00, 0x0D})

; ----- unsigned --------

m2 equ -2

    VARIABLE(_umax,   0xFFFF)
    VARIABLE(_m2,     0xFFFE)
    VARIABLE(_u0x3334,0x3334)
    VARIABLE(_u0x3333,0x3333)
    VARIABLE(_u0x3332,0x3332)
    VARIABLE(_u1,          1)
    VARIABLE(_uzero,       0)

    PRINT_I({"0 1 2 3 4 m M ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< 0})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(      0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< 0 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< 0})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(     0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< 0 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< zero})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(   zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< zero ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< zero})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(  zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< zero ", 0x10, 0x00, 0x0D})

__ASM({; ---- 1 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< +1})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(      1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< +1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< +1})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(     1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< +1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< p1})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(     p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< p1 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< p1})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(    p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< p1 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3332 = 13106 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< +13106})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(   13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< +13106 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< +13106})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(  13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< +13106 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< x3332})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< x3332 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< x3332})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< x3332 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3333 = 13107 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< +13107})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(   13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< +13107 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< +13107})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(  13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< +13107 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< x3333})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< x3333 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< x3333})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< x3333 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3334 = 13108 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< +13108})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(   13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< +13108 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< +13108})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(  13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< +13108 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< x3334})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< x3334 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< x3334})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< x3334 ", 0x10, 0x00, 0x0D})

__ASM({; ---- -2 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< -2})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(     -2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< -2 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< -2})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(    -2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< -2 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< m2})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(     m2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< m2 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< m2})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(    m2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< m2 ", 0x10, 0x02, 0x0D})
    
__ASM({; ---- -1 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< -1})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(     -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< -1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< -1})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(    -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< -1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< m1})
         __MAKE_CODE_DUP_PUSH_ULT_JP_FALSE(     m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u< m1 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u< m1})
         __MAKE_CODE_PUSH_ULT_DROP_JP_FALSE(    m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u< m1 ", 0x10, 0x00, 0x0D})

    
__ASM({; ---- 0 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=0})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(      0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=0 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=0})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(     0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=0 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=zero})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(   zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=zero ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=zero})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(  zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=zero ", 0x10, 0x02, 0x0D})

__ASM({; ---- 1 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=+1})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(      1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=+1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=+1})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(     1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=+1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=p1})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(     p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=p1 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=p1})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(    p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=p1 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3332 = 13106 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=+13106})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(   13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=+13106 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=+13106})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(  13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=+13106 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=x3332})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=x3332 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=x3332})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=x3332 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3333 = 13107 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=+13107})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(   13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=+13107 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=+13107})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(  13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=+13107 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=x3333})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=x3333 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=x3333})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=x3333 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3334 = 13108 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=+13108})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(   13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=+13108 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=+13108})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(  13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=+13108 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=x3334})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=x3334 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=x3334})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=x3334 ", 0x10, 0x02, 0x0D})

__ASM({; ---- -2 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=-2})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(     -2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=-2 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=-2})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(    -2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=-2 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=m2})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(     m2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=m2 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=m2})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(    m2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=m2 ", 0x10, 0x00, 0x0D})

__ASM({; ---- -1 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=-1})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(     -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=-1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=-1})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(    -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=-1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=m1})
         __MAKE_CODE_DUP_PUSH_ULE_JP_FALSE(     m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u<=m1 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u<=m1})
         __MAKE_CODE_PUSH_ULE_DROP_JP_FALSE(    m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u<=m1 ", 0x10, 0x02, 0x0D})
    
__ASM({; ---- 0 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=0})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(      0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=0 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=0})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(     0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=0 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=zero})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(   zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=zero ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=zero})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(  zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=zero ", 0x10, 0x00, 0x0D})

__ASM({; ---- 1 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=+1})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(      1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=+1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=+1})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(     1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=+1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=p1})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(     p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=p1 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=p1})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(    p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=p1 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3332 = 13106 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=+13106})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(   13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=+13106 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=+13106})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(  13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=+13106 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=x3332})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=x3332 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=x3332})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=x3332 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3333 = 13107 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=+13107})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(   13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=+13107 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=+13107})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(  13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=+13107 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=x3333})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=x3333 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=x3333})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=x3333 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3334 = 13108 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=+13108})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(   13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=+13108 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=+13108})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(  13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=+13108 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=x3334})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=x3334 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=x3334})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=x3334 ", 0x10, 0x00, 0x0D})

__ASM({; ---- -2 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=-2})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(     -2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=-2 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=-2})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(    -2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=-2 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=m2})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(     m2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=m2 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=m2})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(    m2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=m2 ", 0x10, 0x02, 0x0D})

__ASM({; ---- -1 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=-1})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(     -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=-1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=-1})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(    -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=-1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=m1})
         __MAKE_CODE_DUP_PUSH_UGE_JP_FALSE(     m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u>=m1 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u>=m1})
         __MAKE_CODE_PUSH_UGE_DROP_JP_FALSE(    m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u>=m1 ", 0x10, 0x00, 0x0D})
    
__ASM({; ---- 0 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> 0})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(      0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> 0 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> 0})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(     0,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> 0 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> zero})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(   zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> zero ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> zero})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(  zero,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> zero ", 0x10, 0x02, 0x0D})

__ASM({; ---- 1 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> +1})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(      1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> +1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> +1})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(     1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> +1 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> p1})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(     p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> p1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> p1})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(    p1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> p1 ", 0x10, 0x00, 0x0D})
    
__ASM({; ---- 0x3332 = 13106 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> +13106})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(   13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> +13106 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> +13106})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(  13106,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> +13106 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> x3332})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> x3332 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> x3332})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE( x3332,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> x3332 ", 0x10, 0x02, 0x0D})

__ASM({; ---- 0x3333 = 13107 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> +13107})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(   13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> +13107 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> +13107})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(  13107,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> +13107 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> x3333})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> x3333 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> x3333})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE( x3333,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> x3333 ", 0x10, 0x00, 0x0D})

__ASM({; ---- 0x3334 = 13108 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> +13108})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(   13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> +13108 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> +13108})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(  13108,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> +13108 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> x3334})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> x3334 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> x3334})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE( x3334,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> x3334 ", 0x10, 0x02, 0x0D})

__ASM({; ---- -2 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> -2})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(     -2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> -2 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> -2})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(    -2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> -2 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> m2})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(     m2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> m2 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> m2})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(    m2,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> m2 ", 0x10, 0x00, 0x0D})

__ASM({; ---- -1 ------})
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> -1})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(     -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> -1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> -1})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(    -1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> -1 ",0x0D})

    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> m1})
         __MAKE_CODE_DUP_PUSH_UGT_JP_FALSE(     m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE DROP
    PUSH(-1) ADDLOOP PRINT_I({" u> m1 ",0x0D})
    
    PUSH(0) PUSH(6) DO I _2MUL PUSH(_umax) ADD FETCH 
      __ASM({
         define({__INFO},{u> m1})
         __MAKE_CODE_PUSH_UGT_DROP_JP_FALSE(    m1,else{}incr(IF_COUNT))})
      PUSH(-1) IF PUSH('+') EMIT ELSE PUSH('-') EMIT THEN SPACE
    PUSH(-1) ADDLOOP PRINT_I({" u> m1 ", 0x10, 0x02, 0x0D})

; -------------
    PRINT_I({0x0D, "Data stack:"}) DEPTH DOT
    PRINT_I({0x0D, 0x10, 0x00, "R.A.S:"}) RAS UDOT CR
    STOP
    
COLON(x_x_test)
    ; signed
     _2DUP         EQ         IF PRINT_I( {"=" }) THEN
     _2DUP         EQ __ASM() IF PRINT_I( {"=" }) THEN
     _2DUP __ASM() EQ         IF PRINT_I( {"=" }) THEN
     _2DUP __ASM() EQ __ASM() IF PRINT_I( {"=,"}) THEN
     _2DUP         NE         IF PRINT_I({"<>" }) THEN
     _2DUP         NE __ASM() IF PRINT_I({"<>" }) THEN
     _2DUP __ASM() NE         IF PRINT_I({"<>" }) THEN
     _2DUP __ASM() NE __ASM() IF PRINT_I({"<>,"}) THEN
     _2DUP         LT         IF PRINT_I( {"<" }) THEN
     _2DUP         LT __ASM() IF PRINT_I( {"<" }) THEN
     _2DUP __ASM() LT         IF PRINT_I( {"<" }) THEN
     _2DUP __ASM() LT __ASM() IF PRINT_I( {"<,"}) THEN
     _2DUP         LE         IF PRINT_I({"<=" }) THEN
     _2DUP         LE __ASM() IF PRINT_I({"<=" }) THEN
     _2DUP __ASM() LE         IF PRINT_I({"<=" }) THEN
     _2DUP __ASM() LE __ASM() IF PRINT_I({"<=,"}) THEN
     _2DUP         GT         IF PRINT_I( {">" }) THEN
     _2DUP         GT __ASM() IF PRINT_I( {">" }) THEN
     _2DUP __ASM() GT         IF PRINT_I( {">" }) THEN
     _2DUP __ASM() GT __ASM() IF PRINT_I( {">,"}) THEN
     _2DUP         GE         IF PRINT_I({">=" }) THEN
     _2DUP         GE __ASM() IF PRINT_I({">=" }) THEN
     _2DUP __ASM() GE         IF PRINT_I({">=" }) THEN
     _2DUP __ASM() GE __ASM() IF PRINT_I({">=,"}) THEN
    OVER DOT DUP SPACE_DOT CR  
    ; unsigned
    _2DUP         UEQ         IF PRINT_I( {"=" }) THEN
    _2DUP         UEQ __ASM() IF PRINT_I( {"=" }) THEN
    _2DUP __ASM() UEQ         IF PRINT_I( {"=" }) THEN
    _2DUP __ASM() UEQ __ASM() IF PRINT_I( {"=,"}) THEN
    _2DUP         UNE         IF PRINT_I({"<>" }) THEN
    _2DUP         UNE __ASM() IF PRINT_I({"<>" }) THEN
    _2DUP __ASM() UNE         IF PRINT_I({"<>" }) THEN
    _2DUP __ASM() UNE __ASM() IF PRINT_I({"<>,"}) THEN
    _2DUP         ULT         IF PRINT_I( {"<" }) THEN
    _2DUP         ULT __ASM() IF PRINT_I( {"<" }) THEN
    _2DUP __ASM() ULT         IF PRINT_I( {"<" }) THEN
    _2DUP __ASM() ULT __ASM() IF PRINT_I( {"<,"}) THEN
    _2DUP         ULE         IF PRINT_I({"<=" }) THEN
    _2DUP         ULE __ASM() IF PRINT_I({"<=" }) THEN
    _2DUP __ASM() ULE         IF PRINT_I({"<=" }) THEN
    _2DUP __ASM() ULE __ASM() IF PRINT_I({"<=,"}) THEN
    _2DUP         UGT         IF PRINT_I( {">" }) THEN
    _2DUP         UGT __ASM() IF PRINT_I( {">" }) THEN
    _2DUP __ASM() UGT         IF PRINT_I( {">" }) THEN
    _2DUP __ASM() UGT __ASM() IF PRINT_I( {">,"}) THEN
    _2DUP         UGE         IF PRINT_I({">=" }) THEN
    _2DUP         UGE __ASM() IF PRINT_I({">=" }) THEN
    _2DUP __ASM() UGE         IF PRINT_I({">=" }) THEN
    _2DUP __ASM() UGE __ASM() IF PRINT_I({">=,"}) THEN
    SWAP UDOT SPACE_UDOT CR
SEMICOLON

COLON(d_d_test)
    ;# signed
     _4DUP DEQ IF PRINT_I( {"=" }) THEN
     _4DUP_DEQ_IF PRINT_I( {"=" }) THEN
     _4DUP DEQ_IF PRINT_I( {"=,"}) THEN
     _4DUP DNE IF PRINT_I({"<>" }) THEN
     _4DUP_DNE_IF PRINT_I({"<>" }) THEN
     _4DUP DNE_IF PRINT_I({"<>,"}) THEN
     _4DUP DLT IF PRINT_I( {"<" }) THEN
     _4DUP_DLT_IF PRINT_I( {"<" }) THEN
     _4DUP DLT_IF PRINT_I( {"<,"}) THEN
     _4DUP DLE IF PRINT_I({"<=" }) THEN
     _4DUP_DLE_IF PRINT_I({"<=" }) THEN
     _4DUP DLE_IF PRINT_I({"<=,"}) THEN
     _4DUP DGT IF PRINT_I( {">" }) THEN
     _4DUP_DGT_IF PRINT_I( {">" }) THEN
     _4DUP DGT_IF PRINT_I( {">,"}) THEN
     _4DUP DGE IF PRINT_I({">=" }) THEN
     _4DUP_DGE_IF PRINT_I({">=" }) THEN
     _4DUP DGE_IF PRINT_I({">=,"}) THEN
    _2OVER DDOT _2DUP SPACE_DDOT CR
    ;# unsigned
    _4DUP DUEQ IF PRINT_I( {"=" }) THEN
    _4DUP_DUEQ_IF PRINT_I( {"=" }) THEN
    _4DUP DUEQ_IF PRINT_I( {"=,"}) THEN
    _4DUP DUNE IF PRINT_I({"<>" }) THEN
    _4DUP_DUNE_IF PRINT_I({"<>" }) THEN
    _4DUP DUNE_IF PRINT_I({"<>,"}) THEN
    _4DUP DULT IF PRINT_I( {"<" }) THEN
    _4DUP_DULT_IF PRINT_I( {"<" }) THEN
    _4DUP DULT_IF PRINT_I( {"<,"}) THEN
    _4DUP DULE IF PRINT_I({"<=" }) THEN
    _4DUP_DULE_IF PRINT_I({"<=" }) THEN
    _4DUP DULE_IF PRINT_I({"<=,"}) THEN
    _4DUP DUGT IF PRINT_I( {">" }) THEN
    _4DUP_DUGT_IF PRINT_I( {">" }) THEN
    _4DUP DUGT_IF PRINT_I( {">,"}) THEN
    _4DUP DUGE IF PRINT_I({">=" }) THEN
    _4DUP_DUGE_IF PRINT_I({">=" }) THEN
    _4DUP DUGE_IF PRINT_I({">=,"}) THEN
    _2SWAP UDDOT SPACE_UDDOT CR
SEMICOLON


COLON(x_p3_test)
    DUP_PUSH_EQ_IF(3) PRINT_I( {"=,"}) THEN
    DUP_PUSH_NE_IF(3) PRINT_I({"<>,"}) THEN
    DUP_PUSH_LT_IF(3) PRINT_I( {"<,"}) THEN
    DUP_PUSH_LE_IF(3) PRINT_I({"<=,"}) THEN
    DUP_PUSH_GT_IF(3) PRINT_I( {">,"}) THEN
    DUP_PUSH_GE_IF(3) PRINT_I({">=,"}) THEN
    DUP DOT PUSH(3) SPACE_DOT CR 
    DUP_PUSH_UEQ_IF(3) PRINT_I( {"=,"}) THEN
    DUP_PUSH_UNE_IF(3) PRINT_I({"<>,"}) THEN
    DUP_PUSH_ULT_IF(3) PRINT_I( {"<,"}) THEN
    DUP_PUSH_ULE_IF(3) PRINT_I({"<=,"}) THEN
    DUP_PUSH_UGT_IF(3) PRINT_I( {">,"}) THEN
    DUP_PUSH_UGE_IF(3) PRINT_I({">=,"}) THEN
    UDOT PUSH(3) SPACE_UDOT CR
SEMICOLON


COLON(x_m3_test)
    DUP_PUSH_EQ_IF(-3) PRINT_I( {"=,"}) THEN
    DUP_PUSH_NE_IF(-3) PRINT_I({"<>,"}) THEN
    DUP_PUSH_LT_IF(-3) PRINT_I( {"<,"}) THEN
    DUP_PUSH_LE_IF(-3) PRINT_I({"<=,"}) THEN
    DUP_PUSH_GT_IF(-3) PRINT_I( {">,"}) THEN
    DUP_PUSH_GE_IF(-3) PRINT_I({">=,"}) THEN
    DUP DOT PUSH(-3) SPACE_DOT CR 
    DUP_PUSH_UEQ_IF(-3) PRINT_I( {"=,"}) THEN
    DUP_PUSH_UNE_IF(-3) PRINT_I({"<>,"}) THEN
    DUP_PUSH_ULT_IF(-3) PRINT_I( {"<,"}) THEN
    DUP_PUSH_ULE_IF(-3) PRINT_I({"<=,"}) THEN
    DUP_PUSH_UGT_IF(-3) PRINT_I( {">,"}) THEN
    DUP_PUSH_UGE_IF(-3) PRINT_I({">=,"}) THEN
    UDOT PUSH(-3) SPACE_UDOT CR
SEMICOLON
