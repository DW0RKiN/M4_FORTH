;vvvv
include(`../M4/FIRST.M4')dnl
;^^^^
    define({USE_FONT_5x8})
    define({SUFFIX},.zx0)
    define({BUFFERPLAY_SIZE},14581)
; max unpacked file data is USE_PLAY

__LIMITED_TIMES_LOOP_MUSIC equ 1

  ifndef __BUFFER
__BUFFER equ 0xC000
  endif

  ifdef __ORG
    org __ORG
  else
    org 24576
  endif



text_y equ (24+10-1)/2
text_x equ (51-24)/2
         
    INIT(28000)
    ZX_CONSTANT
    
    PUSH(0x5800,3*256,ZX_BLUE) FILL
    PUSH(ZX_BLACK) ZX_BORDER

    BEGIN
        PRINT_I({ZX_INK, ZX_BLUE, ZX_PAPER, ZX_BLACK})
        PRINT_I({ZX_AT,text_y-0,text_x," 0: exit "})
        PRINT_I({ZX_AT,text_y-1,text_x," 1: octode     test "})
        PRINT_I({ZX_AT,text_y-2,text_x," 2: octode2k15 test "})
        PRINT_I({ZX_AT,text_y-3,text_x," 3: octode2k16 test "})
        PRINT_I({ZX_AT,text_y-4,text_x," 4: alf2_zalza "})
        PRINT_I({ZX_AT,text_y-5,text_x," 5: pd_dawn "})
        PRINT_I({ZX_AT,text_y-6,text_x," 6: algar_thegermansroom "})
        PRINT_I({ZX_AT,text_y-7,text_x," 7: bacon_sandwich "})
        PRINT_I({ZX_AT,text_y-8,text_x," 8: cja_h_what_is_love "})
        PRINT_I({ZX_AT,text_y-9,text_x," 9: _first_last_ "})
        PRINT_I({ZX_INK, ZX_RED})

        PUSH(__TESTKEY_0) TESTKEY 
    IF     
        PRINT_I({ZX_AT,text_y-0,text_x," 0: exit "})
        BREAK 
    ELSE
        PUSH(__TESTKEY_1) TESTKEY 
    IF 
        PRINT_I({ZX_AT,text_y-1,text_x," 1: octode     test "})
        VARIABLEBINFILE_UNPACK_BUFFERPLAY(../Compression/Output/,octode,SUFFIX,__BUFFER) 
    ELSE
        PUSH(__TESTKEY_2) TESTKEY 
    IF 
        PRINT_I({ZX_AT,text_y-2,text_x," 2: octode2k15 test "})
        VARIABLEBINFILE_UNPACK_BUFFERPLAY(../Compression/Output/,octode2k15,SUFFIX,__BUFFER) 
    ELSE
        PUSH(__TESTKEY_3) TESTKEY 
    IF 
        PRINT_I({ZX_AT,text_y-3,text_x," 3: octode2k16 test "})
        VARIABLEBINFILE_UNPACK_BUFFERPLAY(../Compression/Output/,octode2k16,SUFFIX,__BUFFER) 
    ELSE
        PUSH(__TESTKEY_4) TESTKEY 
    IF 
        PRINT_I({ZX_AT,text_y-4,text_x," 4: alf2_zalza "})
        VARIABLEBINFILE_UNPACK_BUFFERPLAY(../Compression/Output/,alf2_zalza,SUFFIX,__BUFFER) 
    ELSE
        PUSH(__TESTKEY_5) TESTKEY 
    IF 
        PRINT_I({ZX_AT,text_y-5,text_x," 5: pd_dawn "})
        VARIABLEBINFILE_UNPACK_BUFFERPLAY(../Compression/Output/,pd_dawn,SUFFIX,__BUFFER) 
    ELSE
        PUSH(__TESTKEY_6) TESTKEY 
    IF 
        PRINT_I({ZX_AT,text_y-6,text_x," 6: algar_thegermansroom "})
        VARIABLEBINFILE_UNPACK_BUFFERPLAY(../Compression/Output/,algar_thegermansroom,SUFFIX,__BUFFER) 
    ELSE
        PUSH(__TESTKEY_7) TESTKEY 
    IF 
        PRINT_I({ZX_AT,text_y-7,text_x," 7: bacon_sandwich "})
        VARIABLEBINFILE_UNPACK_BUFFERPLAY(../Compression/Output/,bacon_sandwich,SUFFIX,__BUFFER) 
    ELSE
        PUSH(__TESTKEY_8) TESTKEY 
    IF 
        PRINT_I({ZX_AT,text_y-8,text_x," 8: cja_h_what_is_love "})
        VARIABLEBINFILE_UNPACK_BUFFERPLAY(../Compression/Output/,cja_h_what_is_love,SUFFIX,__BUFFER) 
    ELSE
        PUSH(__TESTKEY_9) TESTKEY 
    IF 
        PRINT_I({ZX_AT,text_y-9,text_x," 9: _first_last_ "})
        VARIABLEBINFILE_UNPACK_BUFFERPLAY(../Compression/Output/,_first_last_,SUFFIX,__BUFFER) 
    ELSE
    THEN THEN THEN THEN THEN THEN THEN THEN THEN THEN
    AGAIN

    DEPTH
    PRINT_I({0x0D, "Depth: "}) DOT CR
    STOP
