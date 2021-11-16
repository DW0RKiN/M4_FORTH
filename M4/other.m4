define({__},{})dnl
dnl
dnl
dnl ( -- )
dnl Save shadow reg.
define(INIT,{
;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, ifelse($1,{},{60000
    .warning "Missing value for return address stack. The init() macro has no parameter!"},{format({%-11s},$1); 3:10      init   Init Return address stack}){}dnl
__{}ifelse(eval(($1+0) & 1),{1},{
    .error "Return address stack must be at an odd address!"})
    exx                 ; 1:4       init})dnl
dnl
dnl ( -- )
dnl Load shadow reg.
define(STOP,{
Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====})dnl
dnl
dnl
dnl
dnl ( ? ? ? -- )
dnl Fix back stack and register. Return to Basic.
define({BYE},{
    jp   Stop           ; 3:10      bye})dnl
dnl
dnl
dnl
dnl ( -- random )
define({RND},{ifdef({USE_Rnd},,define({USE_Rnd},{}))
    ex   DE, HL         ; 1:4       rnd
    push HL             ; 1:11      rnd
    call Rnd            ; 3:17      rnd})dnl
dnl
dnl
dnl ( max -- random )
define({RANDOM},{ifdef({USE_Random},,define({USE_Random},{}))
    call Random         ; 3:17      random})dnl
dnl
dnl
dnl
dnl ( yx -- addr )
define({PUTPIXEL},{ifdef({USE_PIXEL},,define({USE_PIXEL},{}))
    call PIXEL          ; 3:17      pixel})dnl
dnl
dnl
dnl
dnl ( yx_from yx_to -- )
define({LINE},{ifdef({USE_LINE},,define({USE_LINE},{}))
    call line          ; 3:17       line
    pop  HL            ; 1:10       line
    pop  DE            ; 1:10       line})dnl
dnl
dnl
dnl
define({TEST_LAST},1000){}dnl
dnl
dnl
dnl test_start 1 2 3 swap test_eq 1 3 2 test_end
dnl test_start max_255word test_eq max_255word test_end
dnl ( -- )
define({TEST_START},{pushdef({TEST_NUM},TEST_LAST){}define({TEST_LAST},eval(TEST_LAST+1))
    push DE             ; 1:11      test_start
    push HL             ; 1:11      test_start
    ld   (test{}TEST_NUM{}A),SP ; 4:20      test_start
    ld   (test{}TEST_NUM{}Z),SP ; 4:20      test_start
    pop  HL             ; 1:10      test_start
    pop  DE             ; 1:10      test_start}){}dnl
dnl
dnl
dnl test_start 1 2 3 swap test_eq 1 3 2 test_end
dnl ( -- )
define({TEST_EQ},{
    push DE             ; 1:11      test_eq
    push HL             ; 1:11      test_eq
    ld   (test{}TEST_NUM{}B),SP ; 4:20      test_eq
    ld   (test{}TEST_NUM{}C),SP ; 4:20      test_eq
test{}TEST_NUM{}A EQU $+1
    ld   HL, 0x0000     ; 3:10      test_eq
    or    A             ; 1:4       test_eq
    sbc  HL, SP         ; 2:15      test_eq
    ld   (test{}TEST_NUM{}D),HL ; 3:16      test_eq
    pop  HL             ; 1:10      test_eq
    pop  DE             ; 1:10      test_eq}){}dnl
dnl
dnl
dnl test_start 1 2 3 swap test_eq 1 3 2 test_end
dnl ( -- )
define({TEST_END},{
    push DE             ; 1:11      test_end
    push HL             ; 1:11      test_end
test{}TEST_NUM{}B EQU $+1
    ld   HL, 0x0000     ; 3:10      test_end
test{}TEST_NUM{}D EQU $+1
    ld   DE, 0x0000     ; 3:10      test_end
    or    A             ; 1:4       test_end
    sbc  HL, SP         ; 2:15      test_end
    or    A             ; 1:4       test_end
    sbc  HL, DE         ; 2:15      test_end{}STRING_Z({"WRONG NUMBER OF RESULTS", 0x0D})
    call nz, PRINT_STRING_Z; 3:10/17 test_end
    rr    D             ; 2:8       test_end
    rr    E             ; 2:8       test_end
    ld    B, E          ; 1:4       test_end
    ld    C, 0x00       ; 2:7       test_end
test{}TEST_NUM{}C EQU $+1
    ld   HL, 0x0000     ; 3:10      test_end
    pop  DE             ; 1:10      test_end
    ld    A,(HL)        ; 1:7       test_end
    xor   E             ; 1:4       test_end
    or    C             ; 1:4       test_end
    ld    C, A          ; 1:4       test_end
    inc  HL             ; 1:6       test_end
    ld    A,(HL)        ; 1:7       test_end
    xor   D             ; 1:4       test_end
    or    C             ; 1:4       test_end
    ld    C, A          ; 1:4       test_end
    inc  HL             ; 1:6       test_end
    djnz $-11           ; 2:8/13    test_end{}STRING_Z({"INCORRECT RESULT", 0x0D})
    call nz, PRINT_STRING_Z; 3:10/17 test_end
test{}TEST_NUM{}Z EQU $+1
    ld   SP, 0x0000     ; 3:10      test_end
    pop  HL             ; 1:10      test_end
    pop  DE             ; 1:10      test_end{}popdef({TEST_NUM})}){}dnl
dnl
dnl
dnl
