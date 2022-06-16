define({__},{})dnl
dnl
dnl
define({_HEX_HI},{format({0x%02X},eval((($1)>>8) & 0xFF))}){}dnl
define({_HEX_LO},{format({0x%02X},eval((($1)>>0) & 0xFF))}){}dnl
dnl
dnl
dnl
dnl
define({____SWAP2DEF},{dnl
__{}define({____SWAP2DEF_TMP},$1)define({$1},$2)define({$2},____SWAP2DEF_TMP)}){}dnl
dnl
dnl
dnl
define({____DEQ_INIT_CODE},{dnl
__{}__{}define({_TMP_R1},{D})define({_TMP_N1},eval((($1)>>24) & 0xFF)){}dnl
__{}__{}define({_TMP_R2},{E})define({_TMP_N2},eval((($1)>>16) & 0xFF)){}dnl
__{}__{}define({_TMP_R3},{H})define({_TMP_N3},eval((($1)>>8) & 0xFF)){}dnl
__{}__{}define({_TMP_R4},{L})define({_TMP_N4},eval(($1) & 0xFF)){}dnl
__{}__{}ifelse(_TMP_N4,{0},{define({_TMP_N4},256)}){}dnl
__{}__{}ifelse(_TMP_N3,{0},{define({_TMP_N3},256)}){}dnl
__{}__{}ifelse(_TMP_N2,{0},{define({_TMP_N2},256)}){}dnl
__{}__{}ifelse(_TMP_N1,{0},{define({_TMP_N1},256)}){}dnl
__{}__{}ifelse(eval(_TMP_N4<_TMP_N3),{1},{dnl
__{}__{}____SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__{}____SWAP2DEF({_TMP_R4},{_TMP_R3})}){}dnl
__{}__{}ifelse(eval(_TMP_N3<_TMP_N2),{1},{dnl
__{}__{}____SWAP2DEF({_TMP_N3},{_TMP_N2}){}dnl
__{}__{}____SWAP2DEF({_TMP_R3},{_TMP_R2}){}dnl
__{}__{}__{}ifelse(eval(_TMP_N4<_TMP_N3),{1},{dnl
__{}__{}__{}____SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__{}__{}____SWAP2DEF({_TMP_R4},{_TMP_R3})})}){}dnl
__{}__{}ifelse(eval(_TMP_N2<_TMP_N1),{1},{dnl
__{}__{}____SWAP2DEF({_TMP_N2},{_TMP_N1}){}dnl
__{}__{}____SWAP2DEF({_TMP_R2},{_TMP_R1}){}dnl
__{}__{}__{}ifelse(eval(_TMP_N3<_TMP_N2),{1},{dnl
__{}__{}__{}____SWAP2DEF({_TMP_N3},{_TMP_N2}){}dnl
__{}__{}__{}____SWAP2DEF({_TMP_R3},{_TMP_R2}){}dnl
__{}__{}__{}__{}ifelse(eval(_TMP_N4<_TMP_N3),{1},{dnl
__{}__{}__{}__{}____SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__{}__{}__{}____SWAP2DEF({_TMP_R4},{_TMP_R3})})})})}){}dnl
dnl
dnl
dnl
define({____DEQ_PARAMETER_ROTATION},{dnl
__{}dnl 4 3 2 1 --> 3 2 1 4
__{}dnl z 3 2 1 --> z 1 2 3
__{}dnl z z 2 1 --> z z 1 2
__{}ifelse(eval(_TMP_N4<255),{1},{dnl
__{}____SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}____SWAP2DEF({_TMP_R4},{_TMP_R3})}){}dnl
__{}ifelse(eval(_TMP_N3<255),{1},{dnl
__{}____SWAP2DEF({_TMP_N3},{_TMP_N2}){}dnl
__{}____SWAP2DEF({_TMP_R3},{_TMP_R2})}){}dnl
__{}ifelse(eval(_TMP_N2<255),{1},{dnl
__{}____SWAP2DEF({_TMP_N2},{_TMP_N1}){}dnl
__{}____SWAP2DEF({_TMP_R2},{_TMP_R1})}){}dnl
}){}dnl
dnl
dnl
dnl ============================================
dnl Input parameters:
dnl   1 = 32 bit number
dnl   2 = +bytes
dnl   3 = +clocks
dnl   4 = info
dnl   5 = stack info
dnl _TMP_R1 .. _TMP_R4  Rx = D,E,H,L
dnl _TMP_N1 .. _TMP_N4  Nx = 1..256
dnl reg with 0(=256) must by last
dnl reg with 255 must by last
dnl
dnl Out:
dnl ____DEQ_CODE_0{}____DEQ_CODE_1{}____DEQ_CODE_2{}____DEQ_CODE_3{}____DEQ_CODE_4
dnl zero flag if const == DEHL
dnl A = 0 if const == DEHL, because the "cp" instruction can be the last instruction only with a non-zero result. 
dnl
define({____DEQ_MAKE_CODE},{dnl
__{}define({____R1},_TMP_R1){}dnl Protoze obcas muzeme udelat prohozeni registru tak si udelame kopii
__{}define({____R2},_TMP_R2){}dnl
__{}define({____R3},_TMP_R3){}dnl
__{}define({____R4},_TMP_R4){}dnl
__{}define({____N1},_TMP_N1){}dnl
__{}define({____N2},_TMP_N2){}dnl
__{}define({____N3},_TMP_N3){}dnl
__{}define({____N4},_TMP_N4){}dnl
__{}dnl --------------------------------------------
__{}dnl
__{}define({_TMP_OR3},{cp }){}dnl
__{}ifelse(____N4,256,{dnl
__{}__{}define({_TMP_OR3},{xor}){}dnl
__{}__{}define({_TMP_B4},1){}dnl
__{}__{}define({_TMP_T4},4){}dnl
__{}__{}define({_TMP_J3},4){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    or    ____R4             ; 1:4       $4   x[4] = 0})},
__{}____N4{-}____N3,{255-255},{dnl
__{}__{}define({_TMP_B4},2){}dnl
__{}__{}define({_TMP_T4},8){}dnl
__{}__{}define({_TMP_J3},8){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}__{}    and   ____R4             ; 1:4       $4   x[4] = 0xFF
__{}__{}__{}    inc   A             ; 1:4       $4})},
__{}____N4,255,{dnl
__{}__{}define({_TMP_OR3},{xor}){}dnl
__{}__{}define({_TMP_B4},3){}dnl
__{}__{}define({_TMP_T4},12){}dnl
__{}__{}define({_TMP_J3},12){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}__{}    dec   A             ; 1:4       $4
__{}__{}__{}    and   ____R4             ; 1:4       $4   x[4] = 0xFF
__{}__{}__{}    inc   A             ; 1:4       $4})},
__{}____N4,{1},{dnl
__{}__{}define({_TMP_OR3},{xor}){}dnl
__{}__{}define({_TMP_B4},3){}dnl
__{}__{}define({_TMP_T4},12){}dnl
__{}__{}define({_TMP_J3},12){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    ld    C{,} ____R4          ; 1:4       $4
__{}__{}    dec   C             ; 1:4       $4
__{}__{}    or    C             ; 1:4       $4   x[4] = 1})},
__{}eval(____N4==____N3),{1},{dnl
__{}__{}define({_TMP_B4},3){}dnl
__{}__{}define({_TMP_T4},11){}dnl
__{}__{}define({_TMP_J3},12){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+_TMP_B4        ; 2:7/12    $4
__{}__{}    xor   ____R4             ; 1:4       $4   x[4] = x[3]})},
__{}eval(____N4==(____N3+1 & 0xFF)),{1},{dnl
__{}__{}dnl 10 20 3F 40 --> 10 20 40 3F --> 10 10+10 20+20 40-1
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},12){}dnl
__{}__{}ifelse(ifelse(eval(____N3==____N2),{1},{1},
__{}__{}__{}eval(____N3==(____N2+1 & 0xFF)),{1},{1},
__{}__{}__{}eval(____N3==(____N2+____N1 & 0xFF)),{1},{1},
__{}__{}__{}eval(____N3==(____N2+____N2 & 0xFF)),{1},{1},{0}),{1},{dnl
__{}__{}dnl No swap! 10 3F 3F 40 --> 10 3F 3F 3F+1
__{}__{}define({____DEQ_CODE_4},{
__{}__{}__{}    jr   nz{,} $+_TMP_B4        ; 2:7/12    $4
__{}__{}__{}    inc   A             ; 1:4       $4
__{}__{}__{}    xor   ____R4             ; 1:4       $4   x[4] = x[3] + 1})},
__{}__{}{dnl Swap!
__{}__{}__{}____SWAP2DEF({____N3},{____N4}){}dnl
__{}__{}__{}____SWAP2DEF({____R3},{____R4}){}dnl
__{}__{}__{}define({____DEQ_CODE_4},{
__{}__{}__{}    jr   nz{,} $+_TMP_B4        ; 2:7/12    $4
__{}__{}__{}    dec   A             ; 1:4       $4
__{}__{}__{}    xor   ____R4             ; 1:4       $4   x[4] = x[3] - 1})})},
__{}eval(____N4==(____N3+____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},12){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+_TMP_B4        ; 2:7/12    $4
__{}__{}    add   A{,} ____R1          ; 1:4       $4
__{}__{}    xor   ____R4             ; 1:4       $4   x[4] = x[3] + x[1]})},
__{}eval(____N4==(____N3+____N2 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},12){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+_TMP_B4        ; 2:7/12    $4
__{}__{}    add   A{,} ____R2          ; 1:4       $4
__{}__{}    xor   ____R4             ; 1:4       $4   x[4] = x[3] + x[2]})},
__{}eval(____N4==(____N3+____N3 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},12){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+_TMP_B4        ; 2:7/12    $4
__{}__{}    add   A{,} ____R3          ; 1:4       $4
__{}__{}    xor   ____R4             ; 1:4       $4   x[4] = x[3] + x[3]})},
__{}{dnl
__{}__{}define({_TMP_B4},5){}dnl
__{}__{}define({_TMP_T4},18){}dnl
__{}__{}define({_TMP_J3},12){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+_TMP_B4        ; 2:7/12    $4
__{}__{}    ld    A{,} format({0x%02X},____N4)       ; 2:7       $4
__{}__{}    xor   ____R4             ; 1:4       $4   x[4] = format({0x%02X},____N4)})}){}dnl
__{}dnl
__{}dnl --------------------------------------------
__{}dnl
__{}define({_TMP_OR2},{or }){}dnl
__{}ifelse(____N3,256,{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+1)){}dnl
__{}__{}define({_TMP_T3},4){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    or    ____R3             ; 1:4       $4   x[3] = 0})},
__{}____N4{-}____N3{-}____N2,{255-255-255},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+1)){}dnl
__{}__{}define({_TMP_T3},4){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    and   ____R3             ; 1:4       $4   x[3] = 0xFF})},
__{}____N4{-}____N3{-}____N2,{256-255-255},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+2)){}dnl
__{}__{}define({_TMP_T3},8){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    and   ____R3             ; 1:4       $4   x[3] = 0xFF
__{}__{}    inc   A             ; 1:4       $4})},
__{}____N4{-}____N3,{255-255},{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+2)){}dnl
__{}__{}define({_TMP_T3},8){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    dec   A             ; 1:4       $4
__{}__{}    and   ____R3             ; 1:4       $4   x[3] = 0xFF})},
__{}____N4{-}____N3,{256-255},{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+3)){}dnl
__{}__{}define({_TMP_T3},12){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    dec   A             ; 1:4       $4
__{}__{}    and   ____R3             ; 1:4       $4   x[3] = 0xFF
__{}__{}    inc   A             ; 1:4       $4})},
__{}eval(((____N4 == 256) || (____N4 == 255) || (____N4 == 1)) && (____N3 == 1)),{1},{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+3)){}dnl
__{}__{}define({_TMP_T3},12){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    ld    C{,} ____R3          ; 1:4       $4
__{}__{}    dec   C             ; 1:4       $4
__{}__{}    or    C             ; 1:4       $4   x[3] = 1})},
__{}eval(____N3==____N2),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+3)){}dnl
__{}__{}define({_TMP_T3},11){}dnl
__{}__{}define({_TMP_J2},12){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B3); 2:7/12    $4
__{}__{}    _TMP_OR3   ____R3             ; 1:4       $4   x[3] = x[2]})},
__{}eval(____N3==(____N2+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},12){}dnl
__{}__{}dnl Test 10 1F 20 77 --> 10 20 1F 77
__{}__{}dnl Test 10 1F 20 20 --> 10 20 1F 20 fail
__{}__{}ifelse(ifelse(eval(_TMP_T4<15),{1},{1},
__{}__{}eval(____N2==____N1),{1},{1},
__{}__{}eval(____N2==(____N1+1 & 0xFF)),{1},{1},
__{}__{}eval(____N2==(____N1+____N1 & 0xFF)),{1},{1},{0}),{1},{dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B3); 2:7/12    $4
__{}__{}__{}    inc   A             ; 1:4       $4
__{}__{}__{}    _TMP_OR3   ____R3             ; 1:4       $4   x[3] = x[2] + 1})},
__{}__{}{dnl The third to the fourth byte must not be optimized! There must be no optimization from the first to the fourth byte!
__{}__{}__{}____SWAP2DEF({____N2},{____N3}){}dnl
__{}__{}__{}____SWAP2DEF({____R2},{____R3}){}dnl
__{}__{}__{}define({____DEQ_CODE_3},{
__{}__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B3); 2:7/12    $4
__{}__{}__{}    dec   A             ; 1:4       $4
__{}__{}__{}    _TMP_OR3   ____R3             ; 1:4       $4   x[3] = x[2] - 1})})},
__{}eval(____N3==(____N2+____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},12){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B3); 2:7/12    $4
__{}__{}    add   A{,} ____R1          ; 1:4       $4
__{}__{}    _TMP_OR3   ____R3             ; 1:4       $4   x[3] = x[2] + x[1]})},
__{}eval(____N3==(____N2+____N2 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},12){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B3); 2:7/12    $4
__{}__{}    add   A{,} ____R2          ; 1:4       $4
__{}__{}    _TMP_OR3   ____R3             ; 1:4       $4   x[3] = x[2] + x[2]})},
__{}{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+5)){}dnl
__{}__{}define({_TMP_T3},18){}dnl
__{}__{}define({_TMP_J2},12){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B3); 2:7/12    $4
__{}__{}    ld    A{,} format({0x%02X},____N3)       ; 2:7       $4
__{}__{}    _TMP_OR3   ____R3             ; 1:4       $4   x[3] = format({0x%02X},____N3)})}){}dnl
__{}dnl
__{}dnl --------------------------------------------
__{}dnl
__{}define({_TMP_OR1},{cp }){}dnl
__{}ifelse(____N2,256,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+1)){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    or    ____R2             ; 1:4       $4   x[2] = 0})},
__{}____N3{-}____N2{-}____N1,{255-255-255},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+1)){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    and   ____R2             ; 1:4       $4   x[2] = 0xFF})},
__{}____N3{-}____N2{-}____N1,{256-255-255},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+2)){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    and   ____R2             ; 1:4       $4   x[2] = 0xFF
__{}__{}    inc   A             ; 1:4       $4})},
__{}____N3{-}____N2,{255-255},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+2)){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    dec   A             ; 1:4       $4
__{}__{}    and   ____R2             ; 1:4       $4   x[2] = 0xFF})},
__{}____N3{-}____N2,{256-255},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+3)){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    dec   A             ; 1:4       $4
__{}__{}    and   ____R2             ; 1:4       $4   x[2] = 0xFF
__{}__{}    inc   A             ; 1:4       $4})},
__{}eval(((____N4==256)||(____N4==255)||(____N4==1)) && ((____N3==256)||(____N3==255)||(____N3==1)) && (____N2 == 1) && (____N1 == 1)),{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+3)){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    ld    C{,} ____R2          ; 1:4       $4
__{}__{}    dec   C             ; 1:4       $4
__{}__{}    or    C             ; 1:4       $4   x[2] = 1})},
__{}eval(____N2==____N1),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+3)){}dnl
__{}__{}define({_TMP_T2},11){}dnl
__{}__{}define({_TMP_J1},12){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B2); 2:7/12    $4
__{}__{}    _TMP_OR2   ____R2             ; 1:4       $4   x[2] = x[1]})},
__{}eval(((____N4==256)||(____N4==255)||(____N4==1)) && ((____N3==256)||(____N3==255)||(____N3==1)) && (____N2 == 1)),{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+3)){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    ld    C{,} ____R2          ; 1:4       $4
__{}__{}    dec   C             ; 1:4       $4
__{}__{}    or    C             ; 1:4       $4   x[2] = 1})},
__{}eval(____N2==(____N1+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},12){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B2); 2:7/12    $4
__{}__{}    inc   A             ; 1:4       $4
__{}__{}    _TMP_OR2   ____R2             ; 1:4       $4   x[2] = x[1] + 1})},
__{}eval(____N2==(____N1+____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},12){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B2); 2:7/12    $4
__{}__{}    add   A{,} ____R1          ; 1:4       $4
__{}__{}    _TMP_OR2   ____R2             ; 1:4       $4   x[2] = x[1] + x[1]})},
__{}{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+5)){}dnl
__{}__{}define({_TMP_T2},18){}dnl
__{}__{}define({_TMP_J1},12){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B2); 2:7/12    $4
__{}__{}    ld    A{,} format({0x%02X},____N2)       ; 2:7       $4
__{}__{}    _TMP_OR2   ____R2             ; 1:4       $4   x[2] = format({0x%02X},____N2)})}){}dnl
__{}dnl
__{}dnl --------------------------------------------
__{}dnl
__{}ifelse(____N1,256,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       $4   x[1] = 0})},
__{}____N2{-}____N1,{255-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       $4   x[1] = 0xFF})},
__{}____N2{-}____N1,{256-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       $4
__{}__{}    inc   A             ; 1:4       $4   x[1] = 0xFF})},
__{}eval(((____N4==256)||(____N4==255)||(____N4==1)) && ((____N3==256)||(____N3==255)||(____N3==1)) && ((____N2==256)||(____N2==255)||(____N2==1)) && (____N1==1)),{1},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       $4
__{}__{}    dec   A             ; 1:4       $4   x[1] = 1})},
__{}{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} format({0x%02X},____N1)       ; 2:7       $4
__{}__{}    _TMP_OR1   ____R1             ; 1:4       $4   x[1] = format({0x%02X},____N1)})}){}dnl
__{}dnl
__{}dnl --------------------------------------------
__{}dnl
__{}define({_TMP_J1},eval(_TMP_J1+_TMP_T1+$3)){}dnl
__{}define({_TMP_J2},eval(_TMP_J2+_TMP_T1+_TMP_T2+$3)){}dnl
__{}define({_TMP_J3},eval(_TMP_J3+_TMP_T1+_TMP_T2+_TMP_T3+$3)){}dnl
__{}define({_TMP_J4},eval(_TMP_T4+_TMP_T3+_TMP_T2+_TMP_T1+$3)){}dnl
__{}define({____DEQ_CLOCKS_TRUE},eval(_TMP_J4)){}dnl
__{}define({____DEQ_CLOCKS_FAIL},eval((1+_TMP_J1+_TMP_J2+_TMP_J3+_TMP_J4)/4)){}dnl       0.5 down round / 0.75 up round
__{}define({____DEQ_CLOCKS},eval((____DEQ_CLOCKS_TRUE+____DEQ_CLOCKS_FAIL)/2)){}dnl
__{}define({____DEQ_BYTES},eval(_TMP_B1+$2)){}dnl
__{}define({____DEQ_CODE_0},ifelse(eval(____DEQ_BYTES<10),{1},{ }){               ;[eval(____DEQ_BYTES):____DEQ_CLOCKS_TRUE/_TMP_J1{,}_TMP_J2{,}_TMP_J3{,}_TMP_J4] $4   ( $5 )   format({0x%08X},eval($1)) == DEHL}){}dnl
__{}dnl
__{}dnl debug:____DEQ_CODE_0{}____DEQ_CODE_1{}____DEQ_CODE_2{}____DEQ_CODE_3{}____DEQ_CODE_4{}
}){}dnl
dnl
dnl
dnl
dnl
dnl
define({____DEQ_MAKE_BEST_CODE},{dnl
____DEQ_INIT_CODE($1){}dnl
____DEQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}define({_TMP_BEST_B},____DEQ_BYTES){}dnl
__{}define({_TMP_BEST_C},____DEQ_CLOCKS){}dnl
__{}define({_TMP_BEST_CODE},____DEQ_CODE_0{}____DEQ_CODE_1{}____DEQ_CODE_2{}____DEQ_CODE_3{}____DEQ_CODE_4){}dnl
____DEQ_PARAMETER_ROTATION{}dnl
____DEQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}ifelse(eval((_TMP_BEST_B>____DEQ_BYTES) || ((_TMP_BEST_B==____DEQ_BYTES) && (_TMP_BEST_C>____DEQ_CLOCKS))),{1},{dnl
__{}__{}define({_TMP_BEST_B},____DEQ_BYTES){}dnl
__{}__{}define({_TMP_BEST_C},____DEQ_CLOCKS){}dnl
__{}__{}define({_TMP_BEST_CODE},____DEQ_CODE_0{}____DEQ_CODE_1{}____DEQ_CODE_2{}____DEQ_CODE_3{}____DEQ_CODE_4)}){}dnl
____DEQ_PARAMETER_ROTATION{}dnl
____DEQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}ifelse(eval((_TMP_BEST_B>____DEQ_BYTES) || ((_TMP_BEST_B==____DEQ_BYTES) && (_TMP_BEST_C>____DEQ_CLOCKS))),{1},{dnl
__{}__{}define({_TMP_BEST_B},____DEQ_BYTES){}dnl
__{}__{}define({_TMP_BEST_C},____DEQ_CLOCKS){}dnl
__{}__{}define({_TMP_BEST_CODE},____DEQ_CODE_0{}____DEQ_CODE_1{}____DEQ_CODE_2{}____DEQ_CODE_3{}____DEQ_CODE_4)}){}dnl
____DEQ_PARAMETER_ROTATION{}dnl
____DEQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}ifelse(eval((_TMP_BEST_B>____DEQ_BYTES) || ((_TMP_BEST_B==____DEQ_BYTES) && (_TMP_BEST_C>____DEQ_CLOCKS))),{1},{dnl
__{}__{}define({_TMP_BEST_B},____DEQ_BYTES){}dnl
__{}__{}define({_TMP_BEST_C},____DEQ_CLOCKS){}dnl
__{}__{}define({_TMP_BEST_CODE},____DEQ_CODE_0{}____DEQ_CODE_1{}____DEQ_CODE_2{}____DEQ_CODE_3{}____DEQ_CODE_4)}){}dnl
}){}dnl
dnl
dnl
dnl
dnl ============================================
dnl Input parameters:
dnl   1 = 16 bit number
dnl   2 = +bytes
dnl   3 = +clocks
dnl   4 = info
dnl   5 = stack info
dnl
dnl Out:
dnl ____EQ_CODE_0{}____EQ_CODE_1{}____EQ_CODE_2{}
dnl zero flag if const == DEHL
dnl A = 0 if const == HL, because the "cp" instruction can be the last instruction only with a non-zero result. 
dnl
define({____EQ_MAKE_CODE},{dnl
__{}define({____R1},{L}){}dnl
__{}define({____R2},{H}){}dnl
__{}define({____N1},eval(($1) & 0xFF)){}dnl
__{}define({____N2},eval((($1)>>8) & 0xFF)){}dnl
__{}ifelse(eval(____N2<____N1),{1},{dnl
__{}__{}____SWAP2DEF({____N1},{____N2}){}dnl
__{}__{}____SWAP2DEF({____R1},{____R2})}){}dnl
__{}ifelse(eval((____N2+____N2) & 0xFF),____N1,{dnl    0x952A --> 0x2A95  = 42, 149
__{}__{}____SWAP2DEF({____N1},{____N2}){}dnl
__{}__{}____SWAP2DEF({____R1},{____R2})}){}dnl
__{}ifelse(____N1,{0},{dnl                       0x..00 --> 0x00..
__{}__{}____SWAP2DEF({____N1},{____N2}){}dnl
__{}__{}____SWAP2DEF({____R1},{____R2})}){}dnl
__{}dnl --------------------------------------------
__{}dnl
__{}define({_TMP_OR1},{cp }){}dnl
__{}ifelse(____N2,0,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},1){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},4){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    or    ____R2             ; 1:4       $4   x[2] = 0})},
__{}____N2{-}____N1,{255-255},{dnl
__{}__{}define({_TMP_B2},2){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},8){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    and   ____R2             ; 1:4       $4   x[2] = 0xFF
__{}__{}    inc   A             ; 1:4       $4})},
__{}____N2,{255},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},12){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    dec   A             ; 1:4       $4
__{}__{}    and   ____R2             ; 1:4       $4   x[2] = 0xFF
__{}__{}    inc   A             ; 1:4       $4})},
__{}____N2{-}____N1,{1-1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},12){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    ld    C{,} ____R2          ; 1:4       $4
__{}__{}    dec   C             ; 1:4       $4
__{}__{}    or    C             ; 1:4       $4   x[2] = 1})},
__{}eval(____N2==____N1),{1},{dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},11){}dnl
__{}__{}define({_TMP_J1},12){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B2); 2:7/12    $4
__{}__{}    xor   ____R2             ; 1:4       $4   x[2] = x[1]})},
__{}____N2,{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},12){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    ld    C{,} ____R2          ; 1:4       $4
__{}__{}    dec   C             ; 1:4       $4
__{}__{}    or    C             ; 1:4       $4   x[2] = 1})},
__{}eval(____N2==(____N1+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},4){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},12){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B2); 2:7/12    $4
__{}__{}    inc   A             ; 1:4       $4
__{}__{}    xor   ____R2             ; 1:4       $4   x[2] = x[1] + 1})},
__{}eval(____N2==(____N1+____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},4){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},12){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B2); 2:7/12    $4
__{}__{}    add   A{,} ____R1          ; 1:4       $4
__{}__{}    xor   ____R2             ; 1:4       $4   x[2] = x[1] + x[1]})},
__{}{dnl
__{}__{}define({_TMP_B2},5){}dnl
__{}__{}define({_TMP_T2},18){}dnl
__{}__{}define({_TMP_J1},12){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},_TMP_B2); 2:7/12    $4
__{}__{}    ld    A{,} format({0x%02X},____N2)       ; 2:7       $4
__{}__{}    xor   ____R2             ; 1:4       $4   x[2] = format({0x%02X},____N2)})}){}dnl
__{}dnl
__{}dnl --------------------------------------------
__{}dnl
__{}ifelse(____N1,0,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       $4   x[1] = 0})},
__{}____N2{-}____N1,{255-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       $4   x[1] = 0xFF})},
__{}____N2{-}____N1,{0-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       $4
__{}__{}    inc   A             ; 1:4       $4   x[1] = 0xFF})},
__{}eval(ifelse(_TMP_OR1,{xor},{1},{0}) && (____N1==1)),{1},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       $4
__{}__{}    dec   A             ; 1:4       $4   x[1] = 1})},
__{}{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} format({0x%02X},____N1)       ; 2:7       $4
__{}__{}    _TMP_OR1   ____R1             ; 1:4       $4   x[1] = format({0x%02X},____N1)})}){}dnl
__{}dnl
__{}dnl --------------------------------------------
__{}dnl
__{}define({_TMP_J1},eval(_TMP_J1+_TMP_T1+$3)){}dnl
__{}define({_TMP_J2},eval(_TMP_T2+_TMP_T1+$3)){}dnl
__{}define({____DEQ_CLOCKS_TRUE},eval(_TMP_J2)){}dnl
__{}define({____DEQ_CLOCKS_FAIL},eval((1+_TMP_J1+_TMP_J2)/4)){}dnl       0.5 down round / 0.75 up round
__{}define({____DEQ_CLOCKS},eval((____DEQ_CLOCKS_TRUE+____DEQ_CLOCKS_FAIL)/2)){}dnl
__{}define({____DEQ_BYTES},eval(_TMP_B1+$2)){}dnl
__{}define({____DEQ_CODE_0},ifelse(eval(____DEQ_BYTES<10),{1},{ }){                   ;[eval(____DEQ_BYTES):____DEQ_CLOCKS_TRUE/_TMP_J1{,}_TMP_J2] $4   ( $5 )   format({0x%04X},eval($1)) == HL}){}dnl
__{}dnl
__{}dnl debug:____DEQ_CODE_0{}____DEQ_CODE_1{}____DEQ_CODE_2
}){}dnl
dnl
dnl
dnl
dnl
