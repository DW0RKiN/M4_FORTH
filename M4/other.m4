define({__},{})dnl
dnl
dnl
dnl ( -- )
dnl Save shadow reg.
define({INIT},{
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
define({STOP},{
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
dnl test_start 1 2 3 swap        test_eq 1 3 2             test_end
dnl test_start ...max255stack... test_eq ...max255stack... test_end
dnl ( -- )
define({TEST_START},{define({USE_TESTING},{})
    call T_OPEN         ; 3:17      test_start}){}dnl
dnl
dnl
dnl test_start 1 2 3 swap test_eq 1 3 2 test_end
dnl ( -- )
define({TEST_EQ},{define({USE_TESTING},{})
    call T_EQ           ; 3:17      test_eq}){}dnl
dnl
dnl
dnl test_start 1 2 3 swap test_eq 1 3 2 test_end
dnl ( -- )
define({TEST_END},{define({USE_TESTING},{})
    call T_CLOSE        ; 3:17      test_end}){}dnl
dnl
dnl
dnl
