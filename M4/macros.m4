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
dnl
dnl ============================================
dnl Input parameters:
dnl   $1 = 32 bit number
dnl   $2 = +-bytes no jump
dnl   $3 = +-clocks no jump
dnl   $4 = +-bytes jump
dnl   $5 = +-clocks jump
dnl _TMP_INFO = info
dnl _TMP_STACK_INFO = stack info
dnl _TMP_R1 .. _TMP_R4  Rx = D,E,H,L
dnl _TMP_N1 .. _TMP_N4  Nx = 1..256
dnl reg with 0(=256) must by last
dnl reg with 255 must by last
dnl
dnl Out:
dnl ____DEQ_CODE
dnl ____DEQ_CLOCKS_TRUE
dnl ____DEQ_CLOCKS_FAIL
dnl ____DEQ_CLOCKS
dnl ____DEQ_BYTES
dnl
dnl zero flag if const == DEHL
dnl A = 0 if const == DEHL, because the "cp" instruction can be the last instruction only with a non-zero result.
dnl
define({____DEQ_MAKE_CODE},{dnl
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}define({____R1},_TMP_R1){}dnl Protoze obcas muzeme udelat prohozeni registru tak si udelame kopii
__{}define({____R2},_TMP_R2){}dnl
__{}define({____R3},_TMP_R3){}dnl
__{}define({____R4},_TMP_R4){}dnl
__{}define({____N1},_TMP_N1){}dnl
__{}define({____N2},_TMP_N2){}dnl
__{}define({____N3},_TMP_N3){}dnl
__{}define({____N4},_TMP_N4){}dnl
__{}dnl
__{}dnl --------------- 4 ---------------
__{}dnl
__{}define({_TMP_OR3},{cp }){}dnl
__{}dnl
__{}dnl 0 - - -    + send signal 0
__{}dnl
__{}ifelse(____N4,256,{dnl
__{}__{}define({_TMP_OR3},{xor}){}dnl
__{}__{}define({_TMP_B4},1){}dnl
__{}__{}define({_TMP_T4},4){}dnl
__{}__{}define({_TMP_J3},4){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    or    ____R4             ; 1:4       _TMP_INFO   x[4] = 0})},
__{}dnl
__{}dnl 255 - - -    need 255
__{}dnl
__{}____N4,{255},{dnl
__{}__{}define({_TMP_OR3},{xor}){}dnl
__{}__{}define({_TMP_B4},2){}dnl
__{}__{}define({_TMP_T4},8){}dnl
__{}__{}define({_TMP_J3},8){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_4},{
__{}__{}__{}    and   ____R4             ; 1:4       _TMP_INFO   x[4] = 0xFF
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl 1 - - -    + send signal 0
__{}dnl
__{}____N4,{1},{dnl
__{}__{}define({_TMP_OR3},{xor}){}dnl
__{}__{}define({_TMP_B4},3){}dnl
__{}__{}define({_TMP_T4},12){}dnl
__{}__{}define({_TMP_J3},12){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    ld    C{,} ____R4          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[4] = 1})},
__{}dnl
__{}dnl a a - -    termination of identical values
__{}dnl
__{}____N4,____N3,{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},14){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    xor   format({0x%02X},____N4)          ; 2:7       _TMP_INFO   x[4] = format({0x%02X},____N4)  termination of identical values})},
__{}dnl
__{}dnl a+1 a - -
__{}dnl
__{}eval(____N4==(____N3+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}    xor   ____R4             ; 1:4       _TMP_INFO   x[4] = x[3] + 1})},
__{}dnl
__{}dnl c-1 c - -
__{}dnl
__{}eval(____N4==(____N3-1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    xor   ____R4             ; 1:4       _TMP_INFO   x[4] = x[3] - 1})},
__{}dnl
__{}dnl c+a c - a
__{}dnl
__{}eval(____N4==(____N3+____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    xor   ____R4             ; 1:4       _TMP_INFO   x[4] = x[3] + x[1]})},
__{}dnl
__{}dnl c-a c - a
__{}dnl
__{}eval(____N4==(____N3-____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    sub   ____R1             ; 1:4       _TMP_INFO
__{}__{}    xor   ____R4             ; 1:4       _TMP_INFO   x[4] = x[3] - x[1]})},
__{}dnl
__{}dnl c+b c b -
__{}dnl
__{}eval(____N4==(____N3+____N2 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} ____R2          ; 1:4       _TMP_INFO
__{}__{}    xor   ____R4             ; 1:4       _TMP_INFO   x[4] = x[3] + x[2]})},
__{}dnl
__{}dnl c-b c b -
__{}dnl
__{}eval(____N4==(____N3-____N2 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    sub   ____R2             ; 1:4       _TMP_INFO
__{}__{}    xor   ____R4             ; 1:4       _TMP_INFO   x[4] = x[3] - x[2]})},
__{}dnl
__{}dnl c+c c - -
__{}dnl
__{}eval(____N4==(____N3+____N3 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} ____R3          ; 1:4       _TMP_INFO
__{}__{}    xor   ____R4             ; 1:4       _TMP_INFO   x[4] = x[3] + x[3]})},
__{}dnl
__{}dnl   default version
__{}{dnl
__{}__{}define({_TMP_B4},5){}dnl
__{}__{}define({_TMP_T4},18){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} format({0x%02X},____N4)       ; 2:7       _TMP_INFO
__{}__{}    xor   ____R4             ; 1:4       _TMP_INFO   x[4] = format({0x%02X},____N4)})}){}dnl
__{}dnl
__{}dnl --------------- 3 ---------------
__{}dnl
__{}define({_TMP_OR2},{cp }){}dnl
__{}dnl
__{}dnl - 0 - -    + send signal 0
__{}dnl
__{}ifelse(____N3,256,{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+1)){}dnl
__{}__{}define({_TMP_T3},4){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    or    ____R3             ; 1:4       _TMP_INFO   x[3] = 0})},
__{}dnl
__{}dnl 255 255 - -    need 255
__{}dnl
__{}____N4{-}____N3,{255-255},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+1)){}dnl
__{}__{}define({_TMP_T3},4){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    and   ____R3             ; 1:4       _TMP_INFO   x[3] = 0xFF})},
__{}dnl
__{}dnl 0 255 - -     need 255
__{}dnl
__{}____N4{-}____N3,{256-255},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+2)){}dnl
__{}__{}define({_TMP_T3},8){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    and   ____R3             ; 1:4       _TMP_INFO   x[3] = 0xFF
__{}__{}    inc   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl 255 a a -    termination of identical values
__{}dnl
__{}____N4{-}____N3{-}____N2,{255-}____N2{-}____N2,{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},14){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(____N3 ^    0xFF))          ; 2:7       _TMP_INFO   x[3] = format({0x%02X},____N3) = 0xFF ^ format({0x%02X},eval(____N3 ^ 0xFF))  termination of identical values})},
__{}dnl
__{}dnl 255 1 - -    + send signal 0
__{}dnl
__{}____N4{-}____N3,{255-1},{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},16){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    ld    C{,} ____R3          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[3] = 1
__{}__{}    dec   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl 255 254 - -
__{}dnl
__{}____N4{-}____N3,{255-254},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} ____R3          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[3] + 1 = 0xFF})},
__{}dnl
__{}dnl 255 - - -
__{}dnl
__{}____N4,{255},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+5)){}dnl
__{}__{}define({_TMP_T3},18){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} ____R3          ; 1:4       _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(____N3 ^ 0xFF))          ; 2:7       _TMP_INFO   x[3] = format({0x%02X},____N3) = 0xFF ^ format({0x%02X},eval(____N3 ^ 0xFF))})},
__{}dnl
__{}dnl 0 1 - -    + send signal 0
__{}dnl
__{}eval(((____N4 == 256) || (____N4 == 1)) && (____N3 == 1)),{1},{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+3)){}dnl
__{}__{}define({_TMP_T3},12){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    ld    C{,} ____R3          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[3] = 1})},
__{}dnl
__{}dnl b b b -    continuation of identical values
__{}dnl
__{}____N4{-}____N3{-}____N2,____N2{-}____N2{-}____N2,{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+3)){}dnl
__{}__{}define({_TMP_T3},11){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    cp    ____R4             ; 1:4       _TMP_INFO   x[3] = x[4]  continuation of identical values})},
__{}dnl
__{}dnl c c - -    the beginning of identical values (preserves value)
__{}dnl
__{}____N4,____N3,{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} ____R3          ; 1:4       _TMP_INFO
__{}__{}    cp    ____R4             ; 1:4       _TMP_INFO   x[3] = x[4] the beginning of identical values})},
__{}dnl
__{}dnl - b b -    termination of identical values
__{}dnl
__{}____N3{-}____N2,____N2{-}____N2,{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},14){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    _TMP_OR3  format({0x%02X},____N3)           ; 2:7       _TMP_INFO   x[3] = format({0x%02X},____N3)  termination of identical values})},
__{}dnl
__{}dnl - b+1 b -
__{}dnl
__{}eval(____N3==(____N2+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}__{}    _TMP_OR3   ____R3             ; 1:4       _TMP_INFO   x[3] = x[2] + 1})},
__{}dnl
__{}dnl - b-1 b -
__{}dnl
__{}eval(____N3==(____N2-1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}__{}    _TMP_OR3   ____R3             ; 1:4       _TMP_INFO   x[3] = x[2] - 1})},
__{}dnl
__{}dnl - b+a b a
__{}dnl
__{}eval(____N3==(____N2+____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   ____R3             ; 1:4       _TMP_INFO   x[3] = x[2] + x[1]})},
__{}dnl
__{}dnl - b-a b a
__{}dnl
__{}eval(____N3==(____N2-____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    sub   ____R1             ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   ____R3             ; 1:4       _TMP_INFO   x[3] = x[2] - x[1]})},
__{}dnl
__{}dnl - b+b b -
__{}dnl
__{}eval(____N3==(____N2+____N2 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} ____R2          ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   ____R3             ; 1:4       _TMP_INFO   x[3] = x[2] + x[2]})},
__{}dnl
__{}dnl  default version
__{}{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+5)){}dnl
__{}__{}define({_TMP_T3},18){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} format({0x%02X},____N3)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR3   ____R3             ; 1:4       _TMP_INFO   x[3] = format({0x%02X},____N3)})}){}dnl
__{}dnl
__{}dnl --------------- 2 ---------------
__{}dnl
__{}define({_TMP_OR1},{cp }){}dnl
__{}dnl
__{}dnl - - 0 -    + send signal 0
__{}dnl
__{}ifelse(____N2,256,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+1)){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    or    ____R2             ; 1:4       _TMP_INFO   x[2] = 0})},
__{}dnl
__{}dnl - 255 255 -   + need 255
__{}dnl
__{}____N3{-}____N2,{255-255},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+1)){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    and   ____R2             ; 1:4       _TMP_INFO   x[2] = 0xFF})},
__{}dnl
__{}dnl - 0 255 -    + need 255
__{}dnl
__{}____N3{-}____N2,{256-255},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+2)){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    and   ____R2             ; 1:4       _TMP_INFO   x[2] = 0xFF
__{}__{}    inc   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl - 255 a a    termination of identical values
__{}dnl
__{}____N3{-}____N2{-}____N1,{255-}____N1{-}____N1,{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},14){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(____N2 ^    0xFF))          ; 2:7       _TMP_INFO   x[2] = format({0x%02X},____N2) = 0xFF ^ format({0x%02X},eval(____N2 ^ 0xFF))      termination of identical values})},
__{}dnl
__{}dnl - 255 1 -  and ____R1!=L  + send signal 0
__{}dnl
__{}eval((____N3==255) && (____N2==1) && (ifelse(____R1,{L},{0},{1}))),{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},16){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    ld    C{,} ____R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1
__{}__{}    dec   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl  - 255 254 -    + send signal 0
__{}dnl
__{}____N3{-}____N2,{255-254},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} ____R2          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[2] + 1 = 0xFF})},
__{}dnl
__{}dnl  - 255 - -    + send signal 0
__{}dnl
__{}____N3,{255},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+5)){}dnl
__{}__{}define({_TMP_T2},18){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} ____R2          ; 1:4       _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(____N2 ^    0xFF))          ; 2:7       _TMP_INFO   x[2] = format({0x%02X},____N2) = 0xFF ^ format({0x%02X},eval(____N2 ^ 0xFF))})},
__{}dnl
__{}dnl 0 0 1 -    + send signal 0
__{}dnl
__{}eval(((____N4==256)||(____N4==1)) && ((____N3==256)||(____N3==1)) && (____N2 == 1)),{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+3)){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    ld    C{,} ____R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}dnl
__{}dnl - a a a    continuation of identical values (preserves value)
__{}dnl
__{}____N3{-}____N2{-}____N1,____N1{-}____N1{-}____N1,{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+3)){}dnl
__{}__{}define({_TMP_T2},11){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    cp    ____R3             ; 1:4       _TMP_INFO   x[2] = x[3]  continuation of identical values})},
__{}dnl
__{}dnl - a a -    + send signal 0 because it can be shorter in number 1, the beginning of identical values (preserves value)
__{}dnl
__{}____N3,____N2,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} ____R2          ; 1:4       _TMP_INFO   the beginning of identical values
__{}__{}    cp    ____R3             ; 1:4       _TMP_INFO   x[2] = x[3]})},
__{}dnl
__{}dnl - - a a    termination of identical values
__{}____N2,____N1,{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},14){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    _TMP_OR2   format({0x%02X},____N2)          ; 2:7       _TMP_INFO   x[2] = format({0x%02X},____N2)  termination of identical values})},
__{}dnl
__{}dnl - - a+1 a
__{}dnl
__{}eval(____N2==(____N1+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   ____R2             ; 1:4       _TMP_INFO   x[2] = x[1] + 1})},
__{}dnl
__{}dnl - - a-1 a
__{}dnl
__{}eval(____N2==(____N1-1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   ____R2             ; 1:4       _TMP_INFO   x[2] = x[1] - 1})},
__{}dnl
__{}dnl - - a+a a
__{}dnl
__{}eval(____N2==(____N1+____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   ____R2             ; 1:4       _TMP_INFO   x[2] = x[1] + x[1]})},
__{}dnl
__{}dnl - - - -     default version
__{}{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+5)){}dnl
__{}__{}define({_TMP_T2},18){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} format({0x%02X},____N2)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR2   ____R2             ; 1:4       _TMP_INFO   x[2] = format({0x%02X},____N2)})}){}dnl
__{}dnl
__{}dnl --------------- 1 ---------------
__{}dnl
__{}dnl 0 0 0 0    zeros and ones and 0xFF have a different code for a series of equal values
__{}dnl
__{}ifelse(____N1,256,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO   x[1] = 0})},
__{}dnl
__{}dnl - - 255 255    need 255
__{}dnl
__{}____N2{-}____N1,{255-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO   x[1] = 0xFF})},
__{}dnl
__{}dnl - - 0 255    need for zero optimization
__{}dnl
__{}____N2{-}____N1,{256-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = 0xFF})},
__{}dnl
__{}dnl - - 255 254    need 255
__{}dnl
__{}____N2{-}____N1,{255-254},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] + 1 = 0xFF})},
__{}dnl
__{}dnl - - 255 x    need 255
__{}dnl
__{}____N2,{255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(____N1 ^ 0xFF))          ; 2:7       _TMP_INFO   x[1] = format({0x%02X},____N1) = 0xFF ^ format({0x%02X},eval(____N1 ^ 0xFF))})},
__{}dnl
__{}dnl - - - 1    + need 0, need for zero optimization
__{}dnl
__{}_TMP_OR1{-}____N1,{xor-1},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[1] = 1})},
__{}dnl
__{}dnl - - a a    the beginning of identical values (preserves value)
__{}dnl
__{}____N2,____N1,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO   the beginning of identical values
__{}__{}    cp    ____R2             ; 1:4       _TMP_INFO   x[1] = x[2]})},
__{}dnl
__{}dnl - - - -    default version
__{}{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({____DEQ_CODE_1},{
__{}__{}    ld    A{,} format({0x%02X},____N1)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR1   ____R1             ; 1:4       _TMP_INFO   x[1] = format({0x%02X},____N1)})}){}dnl
__{}dnl
__{}dnl ---------------------------------
__{}dnl
__{}define({_TMP_J1},eval(_TMP_J1+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({_TMP_J2},eval(_TMP_J2+_TMP_T1+_TMP_T2+ifelse($3,{},{0},{$3}))){}dnl
__{}define({_TMP_J3},eval(_TMP_J3+_TMP_T1+_TMP_T2+_TMP_T3+ifelse($3,{},{0},{$3}))){}dnl
__{}define({_TMP_J4},eval(_TMP_T4+_TMP_T3+_TMP_T2+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({____DEQ_CLOCKS_TRUE},eval(_TMP_J4)){}dnl                                     the longest, full-pass variant
__{}define({____DEQ_CLOCKS_FAIL},eval(4*_TMP_J1+2*_TMP_J2+_TMP_J3+_TMP_J4)){}dnl         It is calculated that each jump has half the chance to be performed, so the probability of the next jump is always half less.
__{}define({____DEQ_PRICE},eval(8*____DEQ_CLOCKS_TRUE+____DEQ_CLOCKS_FAIL)){}dnl         The TRUE variant is calculated to have the same probability as the FALSE variant.
__{}define({____DEQ_CLOCKS_FAIL},eval((____DEQ_CLOCKS_FAIL+4)/8)){}dnl                   0.5 round up
__{}define({____DEQ_CLOCKS},eval((____DEQ_PRICE+8)/16)){}dnl                             0.5 round up
__{}define({____DEQ_BYTES},eval(_TMP_B1+ifelse($2,{},{0},{$2}))){}dnl
__{}define({____DEQ_PRICE},eval(____DEQ_PRICE+(64*____DEQ_BYTES)+ifelse(____R1,{L},{0},{1}))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}define({____DEQ_CODE},format({%47s},;[eval(____DEQ_BYTES):____DEQ_CLOCKS_TRUE/_TMP_J1{{{,}}}_TMP_J2{{{,}}}_TMP_J3{{{,}}}_TMP_J4]){_TMP_STACK_INFO{}____DEQ_CODE_1{}____DEQ_CODE_2{}____DEQ_CODE_3{}____DEQ_CODE_4}){}dnl
__{}dnl
__{}dnl debug:
__{}dnl ____DEQ_CODE
__{}dnl ifelse(____N1,16,____DEQ_CODE{})
}){}dnl
dnl
dnl
dnl
dnl
dnl
define({____CHEAPER},{dnl
__{}eval(_TMP_BEST_P>____DEQ_PRICE)}){}dnl
dnl
dnl
dnl
dnl
define({____SMALLER},{dnl
__{}ifelse(eval(_TMP_BEST_B>____DEQ_BYTES),{1},{1},
__{}eval(_TMP_BEST_B==____DEQ_BYTES),{1},{dnl
__{}__{}ifelse(eval(_TMP_BEST_C>____DEQ_CLOCKS),{1},{1},
__{}__{}eval(_TMP_BEST_C==____DEQ_CLOCKS),{1},{dnl
__{}__{}__{}ifelse(_TMP_R1,{L},{1},{0})},
__{}__{}{0})},
__{}{0}){}dnl
}){}dnl
dnl
dnl
dnl
define({____DEQ_VARIATION_21},{dnl
__{}dnl debug:
__{}dnl format({0x%02X},_TMP_N4)-format({0x%02X},_TMP_N3)-format({0x%02X},_TMP_N2)-format({0x%02X},_TMP_N1)
__{}dnl
__{}____DEQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}__{}ifelse(____CHEAPER,{1},{dnl
__{}__{}__{}define({_TMP_BEST_P},____DEQ_PRICE){}dnl
__{}__{}__{}define({_TMP_BEST_B},____DEQ_BYTES){}dnl
__{}__{}__{}define({_TMP_BEST_C},____DEQ_CLOCKS){}dnl
__{}__{}__{}define({_TMP_BEST_CODE},____DEQ_CODE)}){}dnl
__{}ifelse(eval(_TMP_N2<255),{1},{dnl
__{}____SWAP2DEF({_TMP_N2},{_TMP_N1}){}dnl
__{}____SWAP2DEF({_TMP_R2},{_TMP_R1}){}dnl
__{}dnl debug:
__{}dnl format({0x%02X},_TMP_N4)-format({0x%02X},_TMP_N3)-format({0x%02X},_TMP_N2)-format({0x%02X},_TMP_N1)
__{}dnl
__{}____DEQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}__{}ifelse(____CHEAPER,{1},{dnl
__{}__{}__{}define({_TMP_BEST_P},____DEQ_PRICE){}dnl
__{}__{}__{}define({_TMP_BEST_B},____DEQ_BYTES){}dnl
__{}__{}__{}define({_TMP_BEST_C},____DEQ_CLOCKS){}dnl
__{}__{}__{}define({_TMP_BEST_CODE},____DEQ_CODE)})})}){}dnl
dnl
dnl
dnl
define({____DEQ_VARIATION_32},{dnl
__{}____DEQ_VARIATION_21($1,$2,$3,$4,$5){}dnl
__{}ifelse(eval(_TMP_N3<255),{1},{dnl
__{}____SWAP2DEF({_TMP_N3},{_TMP_N2}){}dnl
__{}____SWAP2DEF({_TMP_R3},{_TMP_R2}){}dnl
__{}____DEQ_VARIATION_21($1,$2,$3,$4,$5){}dnl
__{}____SWAP2DEF({_TMP_N3},{_TMP_N2}){}dnl
__{}____SWAP2DEF({_TMP_R3},{_TMP_R2}){}dnl
__{}____DEQ_VARIATION_21($1,$2,$3,$4,$5)})}){}dnl
dnl
dnl
dnl
dnl
dnl ============================================
dnl Input parameters:
dnl               $1 = 32 bit number
dnl               $2 = +-bytes no jump
dnl               $3 = +-clocks no jump
dnl               $4 = +-bytes jump
dnl               $5 = +-clocks jump
dnl        _TMP_INFO = info
dnl  _TMP_STACK_INFO = stack info
dnl
dnl
dnl Out:
dnl   _TMP_BEST_CODE = code
dnl      _TMP_BEST_P = price = 16*(clocks + 4*bytes)
dnl      _TMP_BEST_B = bytes
dnl      _TMP_BEST_C = clocks
dnl
dnl  zero flag if const == DEHL
dnl  A = 0 if const == DEHL, because the "cp" instruction can be the last instruction only with a non-zero result.
dnl
define({____DEQ_MAKE_BEST_CODE},{dnl
____DEQ_INIT_CODE($1){}dnl
__{}define({_TMP_BEST_P},10000000){}dnl    price = 16*(clocks + 4*bytes)
__{}define({_TMP_BEST_B},10000000){}dnl    bytes
__{}define({_TMP_BEST_C},10000000){}dnl    clocks
__{}____DEQ_VARIATION_32($1,$2,$3,$4,$5){}dnl
__{}ifelse(eval(_TMP_N4<255),{1},{dnl
__{}____SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}____SWAP2DEF({_TMP_R4},{_TMP_R3}){}dnl
__{}____DEQ_VARIATION_32($1,$2,$3,$4,$5){}dnl
__{}____SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}____SWAP2DEF({_TMP_R4},{_TMP_R3}){}dnl
__{}____DEQ_VARIATION_32($1,$2,$3,$4,$5){}dnl
__{}____SWAP2DEF({_TMP_N4},{_TMP_N1}){}dnl
__{}____SWAP2DEF({_TMP_R4},{_TMP_R1}){}dnl
__{}____DEQ_VARIATION_32($1,$2,$3,$4,$5)})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl ============================================
dnl Input parameters:
dnl   $1 = 16 bit number
dnl   $2 = +-bytes no jump
dnl   $3 = +-clocks no jump
dnl   $4 = +-bytes jump
dnl   $5 = +-clocks jump
dnl   _TMP_INFO = info
dnl   _TMP_STACK_INFO = stack info
dnl   _TMP_INFO = { _TMP_INFO   ( $5 )   format({0x%04X},eval($1)) == HL}
dnl   _TMP_INFO = { _TMP_INFO   ( $5 )   format({0x%04X},eval($1)) == HL}
dnl
dnl Out:
dnl ____EQ_CODE
dnl zero flag if const == DEHL
dnl A = 0 if const == HL, because the "cp" instruction can be the last instruction only with a non-zero result.
dnl
define({____EQ_MAKE_CODE},{dnl
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}define({____R1},{L}){}dnl
__{}define({____R2},{H}){}dnl
__{}define({____N1},eval(($1) & 0xFF)){}dnl
__{}define({____N2},eval((($1)>>8) & 0xFF)){}dnl
__{}ifelse(eval(____N2<____N1),{1},{dnl
__{}__{}____SWAP2DEF({____N1},{____N2}){}dnl
__{}__{}____SWAP2DEF({____R1},{____R2})}){}dnl
__{}ifelse(eval((____N2+____N2) & 0xFF),____N1,{dnl    0x952A --> 0x2A95  = 42, 149
__{}__{}ifelse(____N2{-}____N1,255{-}254,,{dnl
__{}__{}__{}____SWAP2DEF({____N1},{____N2}){}dnl
__{}__{}__{}____SWAP2DEF({____R1},{____R2})})}){}dnl
__{}ifelse(____N1,{0},{dnl                       0x..00 --> 0x00..
__{}__{}____SWAP2DEF({____N1},{____N2}){}dnl
__{}__{}____SWAP2DEF({____R1},{____R2})}){}dnl
__{}dnl --------------- 2 ---------------
__{}dnl
__{}define({_TMP_OR1},{cp }){}dnl
__{}ifelse(____N2,0,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},1){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},4){}dnl      No jump! Multibyte solution
__{}__{}define({____EQ_CODE},{
__{}__{}    or    ____R2             ; 1:4       _TMP_INFO   x[2] = 0})},
__{}____N2{-}____N1,{2-1},{dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},11){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[2] = 2})},
__{}____N2,{255},{dnl
__{}__{}define({_TMP_B2},2){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},8){}dnl      No jump! Multibyte solution
__{}__{}define({____EQ_CODE},{
__{}__{}    and   ____R2             ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[2] = 0xFF})},
__{}____N2{-}____N1,{1-1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},12){}dnl      No jump! Multibyte solution
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    C{{,}} ____R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}____N2,{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},12){}dnl      No jump! Multibyte solution
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    C{{,}} ____R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}____N2,____N1,{dnl
__{}__{}define({_TMP_B2},4){}dnl
__{}__{}define({_TMP_T2},14){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    xor   format({0x%02X},____N2)          ; 2:7       _TMP_INFO   x[2] = format({0x%02X},____N2)})},
__{}eval(____N2==(____N1+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},4){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}    xor   ____R2             ; 1:4       _TMP_INFO   x[2] = x[1] + 1})},
__{}eval(____N2==(____N1+____N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},4){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    add   A{{,}} ____R1          ; 1:4       _TMP_INFO
__{}__{}    xor   ____R2             ; 1:4       _TMP_INFO   x[2] = x[1] + x[1]})},
__{}{dnl
__{}__{}define({_TMP_B2},5){}dnl
__{}__{}define({_TMP_T2},18){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{{,}} format({0x%02X},____N2)       ; 2:7       _TMP_INFO
__{}__{}    xor   ____R2             ; 1:4       _TMP_INFO   x[2] = format({0x%02X},____N2)})}){}dnl
__{}dnl
__{}dnl --------------- 1 ---------------
__{}dnl
__{}ifelse(____N1,0,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO   x[1] = 0}____EQ_CODE)},
__{}____N2{-}____N1,{255-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO   x[1] = 0xFF}____EQ_CODE)},
__{}____N2{-}____N1,{255-254},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = x[2] - 1}____EQ_CODE)},
__{}____N2,{255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(____N1 ^ 0xFF))          ; 2:7       _TMP_INFO   x[1] = 0xFF ^ format({0x%02X},eval(____N1 ^ 0xFF))}____EQ_CODE)},
__{}____N2{-}____N1,{0-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = 0xFF}____EQ_CODE)},
__{}____N2{-}____N1,{2-1},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},12){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    A{,} ____R2          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    cp    ____R1             ; 1:4       _TMP_INFO   x[1] = x[2] - 1}____EQ_CODE)},
__{}____N1,{1},{dnl    255-1 --> 255-x rule priority!
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[1] = 1}____EQ_CODE)},
__{}____N2,____N1,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    A{,} ____R1          ; 1:4       _TMP_INFO
__{}__{}    cp    ____R2             ; 1:4       _TMP_INFO   x[1] = x[2]}____EQ_CODE)},
__{}{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({____EQ_CODE},{
__{}__{}    ld    A{,} format({0x%02X},____N1)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR1   ____R1             ; 1:4       _TMP_INFO   x[1] = format({0x%02X},____N1)}____EQ_CODE)}){}dnl
__{}dnl
__{}dnl ---------------------------------
__{}dnl
__{}define({_TMP_J1},eval(_TMP_J1+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({_TMP_J2},eval(_TMP_T2+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({____EQ_CLOCKS_TRUE},eval(_TMP_J2)){}dnl
__{}define({____EQ_CLOCKS_FAIL},eval((1+_TMP_J1+_TMP_J2)/2)){}dnl
__{}define({____EQ_CLOCKS},eval((____EQ_CLOCKS_TRUE+____EQ_CLOCKS_FAIL)/2)){}dnl
__{}define({____EQ_BYTES},eval(_TMP_B1+ifelse($2,{},{0},{$2}))){}dnl
__{}define({____EQ_CODE},format({%37s},;[eval(____EQ_BYTES):____EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2])_TMP_STACK_INFO{}____EQ_CODE){}dnl
__{}dnl
__{}dnl debug:____EQ_CODE
}){}dnl
dnl
dnl
dnl
define({TEST_DUP_PUSH_EQ_IF},{dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}define({_TMP_INFO},{dup $1 = if})dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( x1 -- x1 )   format({0x%04X},eval($1)) == HL})dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(index({$1},{(}),{0},{
__{}__{}__{}                       ;[12:70]     _TMP_INFO   ( x1 -- x1 )   (addr) == HL
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    sbc  HL, BC         ; 2:15      _TMP_INFO
__{}__{}__{}    pop  HL             ; 1:10      _TMP_INFO
__{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO},
__{}__{}{____EQ_MAKE_CODE($1,3,10,0,0)dnl
__{}__{}__{}ifelse(eval((____EQ_CLOCKS+4*____EQ_BYTES)<=((42+(21+42)/2)/2+4*12)),{1},{
__{}__{}__{}__{}____EQ_CODE
__{}__{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO},
__{}__{}__{}{
__{}__{}__{}__{}                     ;[12:42/21,42]{}_TMP_STACK_INFO
__{}__{}__{}__{}    ld    A, low format({%-7s},$1); 2:7       _TMP_INFO
__{}__{}__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO
__{}__{}__{}__{}    ld    A, high format({%-6s},$1); 2:7       _TMP_INFO
__{}__{}__{}__{}    xor   H             ; 1:4       _TMP_INFO
__{}__{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO})})},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
define({TEST_DUP_PUSH_NE_IF},{dnl
__{}define({IF_COUNT}, incr(IF_COUNT))dnl
__{}pushdef({ELSE_STACK}, IF_COUNT)dnl
__{}pushdef({THEN_STACK}, IF_COUNT)dnl
__{}define({_TMP_INFO},{dup $1 <> if})dnl
__{}define({_TMP_STACK_INFO},{ _TMP_INFO   ( x1 -- x1 )   format({0x%04X},eval($1)) <> HL})dnl
__{}ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},{dnl
__{}__{}ifelse(index({$1},{(}),{0},{
__{}__{}__{}                       ;[12:70]     _TMP_INFO   ( x1 -- x1 )   (addr) == HL
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    sbc  HL, BC         ; 2:15      _TMP_INFO
__{}__{}__{}    pop  HL             ; 1:10      _TMP_INFO
__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      _TMP_INFO},
__{}__{}{____EQ_MAKE_CODE($1,3,10,3,-10)dnl
__{}__{}__{}ifelse(eval((____EQ_CLOCKS+4*____EQ_BYTES)<=((39+(23+39)/2)/2+4*11)),{1},{
__{}__{}__{}__{}____EQ_CODE
__{}__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      _TMP_INFO},
__{}__{}__{}{
__{}__{}__{}__{}                     ;[11:39/23,39]{}_TMP_STACK_INFO
__{}__{}__{}__{}    ld    A, low format({%-7s},$1); 2:7       _TMP_INFO
__{}__{}__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}__{}__{}    jr   nz, $+8        ; 2:7/12    _TMP_INFO
__{}__{}__{}__{}    ld    A, high format({%-6s},$1); 2:7       _TMP_INFO
__{}__{}__{}__{}    xor   H             ; 1:4       _TMP_INFO
__{}__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      _TMP_INFO})})},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl
define({____TEST},{dnl
__{}define({_TMP_R4},{D})define({_TMP_N4},eval((($1)>>24) & 0xFF)){}dnl
__{}define({_TMP_R3},{E})define({_TMP_N3},eval((($1)>>16) & 0xFF)){}dnl
__{}define({_TMP_R2},{H})define({_TMP_N2},eval((($1)>>8) & 0xFF)){}dnl
__{}define({_TMP_R1},{L})define({_TMP_N1},eval(($1) & 0xFF)){}dnl
__{}ifelse(_TMP_N4,{0},{define({_TMP_N4},256)}){}dnl
__{}ifelse(_TMP_N3,{0},{define({_TMP_N3},256)}){}dnl
__{}ifelse(_TMP_N2,{0},{define({_TMP_N2},256)}){}dnl
__{}ifelse(_TMP_N1,{0},{define({_TMP_N1},256)}){}dnl
____DEQ_MAKE_CODE($1,0,0,0,0){}dnl
____DEQ_CODE{}dnl
}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl ============================================
dnl Input parameters:
dnl        $1 = 32 bit number
dnl        $2 = add bytes relative jump
dnl _TMP_INFO = info
dnl
dnl Out:
dnl        _TMP_B = bytes
dnl        _TMP_J = clocks jump
dnl       _TMP_NJ = clocks no jump
dnl     _TMP_ZERO = zero A after
dnl  _TMP_HL_CODE = code
dnl
define({____DEQ_MAKE_HL_CODE},{ifelse(dnl
__{}eval((($1)>>16) & 0xFFFF),{0},{dnl
__{}__{}define({_TMP_B},11){}dnl
__{}__{}define({_TMP_J},35){}dnl
__{}__{}define({_TMP_NJ},55){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HL_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO    # 0x0000????
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} L          ; 1:4       _TMP_INFO
__{}__{}__{}    or    H             ; 1:4       _TMP_INFO
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{{,}} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   HL-lo16(d1)})},
__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}define({_TMP_B},11){}dnl
__{}__{}define({_TMP_J},35){}dnl
__{}__{}define({_TMP_NJ},55){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HL_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO    # 0x????0000
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} E          ; 1:4       _TMP_INFO
__{}__{}__{}    or    D             ; 1:4       _TMP_INFO
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{{,}} format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{{,}} BC         ; 2:15      _TMP_INFO   HL-hi16(d1)})},
__{}eval(($1) & 0xFFFF),eval((($1)>>16) & 0xFFFF),{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},46){}dnl
__{}__{}define({_TMP_NJ},66){}dnl
__{}__{}define({_TMP_ZERO},{1}){}dnl
__{}__{}define({_TMP_HL_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO    # hi16(d1) == lo16(d1)
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO   A = 0
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   hi16(d1)-lo16(d1)
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{{,}} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   hi16(d1)-lo16(d1)})},
__{}eval(($1) & 0xFF000000),{0},{dnl
__{}__{}define({_TMP_B},13){}dnl
__{}__{}define({_TMP_J},42){}dnl
__{}__{}define({_TMP_NJ},62){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HL_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO    # 4th byte zero
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} format({0x%02X},eval((($1)>>16) & 0xFF))       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   L             ; 1:4       _TMP_INFO   L = format({0x%02X},eval((($1)>>16) & 0xFF))
__{}__{}__{}    or    H             ; 1:4       _TMP_INFO   H = 0
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{{,}} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   HL-lo16(d1)})},
__{}eval(($1) & 0xFF0000),{0},{dnl
__{}__{}define({_TMP_B},13){}dnl
__{}__{}define({_TMP_J},42){}dnl
__{}__{}define({_TMP_NJ},62){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HL_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO    # 3th byte zero
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} format({0x%02X},eval((($1)>>24) & 0xFF))       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = format({0x%02X},eval((($1)>>24) & 0xFF))
__{}__{}__{}    or    L             ; 1:4       _TMP_INFO   L = 0
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{{,}} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   HL-lo16(d1)})},
__{}{dnl
__{}__{}define({_TMP_B},15){}dnl
__{}__{}define({_TMP_J},56){}dnl
__{}__{}define({_TMP_NJ},76){}dnl
__{}__{}define({_TMP_ZERO},{1}){}dnl
__{}__{}define({_TMP_HL_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO    # default version
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    ld   BC{{,}} format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{{,}} BC         ; 2:15      _TMP_INFO   hi16(d1)-BC
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{{,}} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   HL-lo16(d1)})})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
