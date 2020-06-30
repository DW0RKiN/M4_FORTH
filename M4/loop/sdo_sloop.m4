dnl ## recursive sdo si sloop
define({__},{})dnl
dnl
dnl
dnl ---------  sdo ... sloop  -----------
dnl 5 0 sdo . sloop --> 0 1 2 3 4 
dnl ( stop index -- stop index )
define({SDO}, {ifelse($#,{0},,{
.error Unexpected parameter: sdo($@) --> push($@) sdo ?})
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   sleave{}LOOP_STACK      ; 3:10      sleave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}    pop  HL             ; 1:10      unsloop LOOP_STACK index out
__{}    pop  DE             ; 1:10      unsloop LOOP_STACK stop  out})
sdo{}LOOP_STACK:                 ;           sdo LOOP_STACK ( stop index -- stop index )})dnl
dnl
dnl
dnl ---------  ?sdo ... sloop  -----------
dnl 5 0 sdo . sloop --> 0 1 2 3 4 
dnl ( stop index -- stop index )
define({QUESTIONSDO}, {ifelse($#,{0},,{
.error Unexpected parameter: sdo($@) --> push($@) sdo ?})
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   sleave{}LOOP_STACK      ; 3:10      sleave LOOP_STACK})dnl
__{}pushdef({UNLOOP_STACK},{
__{}    pop  HL             ; 1:10      unsloop LOOP_STACK index out
__{}    pop  DE             ; 1:10      unsloop LOOP_STACK stop  out})
    push HL             ; 1:10      ?sdo LOOP_STACK
    or    A             ; 1:4       ?sdo LOOP_STACK
    sbc  HL, DE         ; 2:15      ?sdo LOOP_STACK
    pop  HL             ; 1:10      ?sdo LOOP_STACK
    jp    z, sleave{}LOOP_STACK  ; 3:10      ?sdo LOOP_STACK   
sdo{}LOOP_STACK:                 ;           sdo LOOP_STACK ( stop index -- stop index )})dnl
dnl
dnl
dnl ( i -- i i )
dnl To same co DUP
dnl dalsi indexy nejsou definovany, protoze neni jiste jak to na zasobniku vypada. Pokud je tam hned dalsi smycka tak J lezi na (SP), K lezi na (SP+4)
define({SI}, {
    DUP})dnl
dnl
dnl
dnl ( j s i -- j s i j )
dnl 2 pick 
dnl dalsi indexy nejsou definovany, protoze neni jiste jak to na zasobniku vypada. Pokud je tam hned dalsi smycka tak J lezi na (SP), K lezi na (SP+4)
define({SJ}, {
    PUSH_PICK(2)})dnl
dnl
dnl
dnl
dnl ( stop index -- stop index++ )
define({SLOOP},{
    inc  HL             ; 1:6       sloop LOOP_STACK index++
    ld    A, E          ; 1:4       sloop LOOP_STACK
    xor   L             ; 1:4       sloop LOOP_STACK lo index - stop
    jp   nz, sdo{}LOOP_STACK     ; 3:10      sloop LOOP_STACK
    ld    A, D          ; 1:4       sloop LOOP_STACK
    xor   H             ; 1:4       sloop LOOP_STACK hi index - stop
    jp   nz, sdo{}LOOP_STACK     ; 3:10      sloop LOOP_STACK
sleave{}LOOP_STACK:              ;           sloop LOOP_STACK{}dnl
__{}UNLOOP_STACK
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK})})dnl
dnl
dnl
dnl
dnl ( stop index -- stop index++ )
define({SUB1_ADDSLOOP},{
    ld    A, L          ; 1:4       -1 +sloop LOOP_STACK
    xor   E             ; 1:4       -1 +sloop LOOP_STACK lo index - stop
    ld    A, H          ; 1:4       -1 +sloop LOOP_STACK
    dec  HL             ; 1:6       -1 +sloop LOOP_STACK index--
    jp   nz, sdo{}LOOP_STACK     ; 3:10      -1 +sloop LOOP_STACK
    xor   D             ; 1:4       -1 +sloop LOOP_STACK hi index - stop
    jp   nz, sdo{}LOOP_STACK     ; 3:10      -1 +sloop LOOP_STACK
sleave{}LOOP_STACK:              ;           -1 +sloop LOOP_STACK{}dnl
__{}UNLOOP_STACK
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK})})dnl
dnl
dnl
dnl +loop
dnl ( stop index step -- stop index+step )
define({ADDSLOOP},{ifelse({slow},{slow},{
__{}    pop  BC             ; 1:10      +sloop LOOP_STACK BC = stop
__{}    ex   DE, HL         ; 1:4       +sloop LOOP_STACK
__{}    or    A             ; 1:4       +sloop LOOP_STACK
__{}    sbc  HL, BC         ; 2:15      +sloop LOOP_STACK HL = index-stop
__{}    ld    A, H          ; 1:4       +sloop LOOP_STACK
__{}    add  HL, DE         ; 1:11      +sloop LOOP_STACK HL = index-stop+step
__{}    xor   H             ; 1:4       +sloop LOOP_STACK sign flag!
__{}    add  HL, BC         ; 1:11      +sloop LOOP_STACK HL = index+step, sign flag unaffected},{
dnl                           9:63
__{}    pop  BC             ; 1:10      +sloop LOOP_STACK BC = stop
__{}    add  HL, DE         ; 1:11      +sloop LOOP_STACK index+step
__{}    ld    A, E          ; 1:4       +sloop LOOP_STACK
__{}    sub   C             ; 1:4       +sloop LOOP_STACK
__{}    ld    A, D          ; 1:4       +sloop LOOP_STACK
__{}    sbc   A, B          ; 1:4       +sloop LOOP_STACK
__{}    ld    E, A          ; 1:4       +sloop LOOP_STACK E = hi index-stop
__{}    ld    A, L          ; 1:4       +sloop LOOP_STACK
__{}    sub   C             ; 1:4       +sloop LOOP_STACK
__{}    ld    A, H          ; 1:4       +sloop LOOP_STACK
__{}    sbc   A, B          ; 1:4       +sloop LOOP_STACK
__{}    xor   E             ; 1:4       +sloop LOOP_STACK})
dnl                          12:61
    ld    D, B          ; 1:4       +sloop LOOP_STACK
    ld    E, C          ; 1:4       +sloop LOOP_STACK
    jp    p, sdo{}LOOP_STACK     ; 3:10      +sloop LOOP_STACK
sleave{}LOOP_STACK:              ;           +sloop LOOP_STACK{}dnl
__{}UNLOOP_STACK
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl 2 +loop
dnl ( stop index -- stop index+step )
define({_2_ADDSLOOP},{ifelse({fast},{fast},{
__{}    inc  HL             ; 1:6       2 +sloop LOOP_STACK
__{}    inc  HL             ; 1:6       2 +sloop LOOP_STACK HL = index+2
__{}    ld    A, L          ; 1:4       2 +sloop LOOP_STACK
__{}    sub   E             ; 1:4       2 +sloop LOOP_STACK
__{}    rra                 ; 1:4       2 +sloop LOOP_STACK
__{}    add   A, A          ; 1:4       2 +sloop LOOP_STACK
__{}    jp   nz, sdo{}LOOP_STACK     ; 3:10      2 +sloop LOOP_STACK
__{}    ld    A, H          ; 1:4       2 +sloop LOOP_STACK
__{}    sbc   A, D          ; 1:4       2 +sloop LOOP_STACK
__{}    jp   nz, sdo{}LOOP_STACK     ; 3:10      2 +sloop LOOP_STACK},{
dnl                          14:38/56
__{}    or    A             ; 1:4       2 +sloop LOOP_STACK
__{}    sbc  HL, DE         ; 2:15      2 +sloop LOOP_STACK HL = index-stop
__{}    ld    A, H          ; 1:4       2 +sloop LOOP_STACK
__{}    inc  HL             ; 1:6       2 +sloop LOOP_STACK
__{}    inc  HL             ; 1:6       2 +sloop LOOP_STACK HL = index+2-stop
__{}    xor   H             ; 1:4       2 +sloop LOOP_STACK sign flag!
__{}    add  HL, DE         ; 1:11      2 +sloop LOOP_STACK HL = index+step, sign flag unaffected
__{}    jp    p, sdo{}LOOP_STACK     ; 3:10      2 +sloop LOOP_STACK})
dnl                          11:60
sleave{}LOOP_STACK:              ;           2 +sloop LOOP_STACK{}dnl
__{}UNLOOP_STACK
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl step +loop
dnl ( stop index -- stop index+step )
define({PUSHX_ADDSLOOP},{
    ld   BC, format({%-11s},eval($1)); 3:10      push_addsloop($1) LOOP_STACK BC = step
    or    A             ; 1:4       push_addsloop($1) LOOP_STACK
    sbc  HL, DE         ; 2:15      push_addsloop($1) LOOP_STACK HL = index-stop
    ld    A, H          ; 1:4       push_addsloop($1) LOOP_STACK
    add  HL, BC         ; 1:11      push_addsloop($1) LOOP_STACK HL = index-stop+step
    xor   H             ; 1:4       push_addsloop($1) LOOP_STACK sign flag!
    add  HL, DE         ; 1:11      push_addsloop($1) LOOP_STACK HL = index+step, sign flag unaffected
    jp    p, sdo{}LOOP_STACK     ; 3:10      push_addsloop($1) LOOP_STACK
sleave{}LOOP_STACK:              ;           push_addsloop($1) LOOP_STACK{}dnl
__{}UNLOOP_STACK
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
})dnl
dnl
dnl
dnl
dnl step +loop
dnl ( -- )
define({PUSH_ADDSLOOP},{ifelse(eval($1),{1},{
                        ;           push_addsloop($1) LOOP_STACK{}SLOOP},
eval($1),{-1},{
                        ;           push_addsloop($1) LOOP_STACK{}SUB1_ADDSLOOP},
eval($1),{2},{
                        ;           push_addsloop($1) LOOP_STACK{}_2_ADDSLOOP},
{$#},{1},{PUSHX_ADDSLOOP($1)},{
.error push_addsloop without parameter!})})dnl
dnl
dnl
dnl
dnl
