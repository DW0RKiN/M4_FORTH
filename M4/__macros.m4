define({__},{})dnl
dnl
dnl
define({_HEX_HI},{format({0x%02X},eval((($1)>>8) & 0xFF))}){}dnl
define({_HEX_LO},{format({0x%02X},eval((($1)>>0) & 0xFF))}){}dnl
dnl
dnl
dnl # (abc) --> 1
dnl # (123) --> 1
dnl # ()+() --> 1 fail
dnl # ()    --> 0
dnl # other --> 0
dnl
define({__IS_MEM_REF},{dnl
__{}eval(1+regexp({$1},{^\s*(.+)\s*$}))}){}dnl
dnl
dnl
dnl
dnl -----------------------------------
dnl # parameters:
dnl #   1st cond
dnl #   2nd no_zero_variant_without_newline
dnl #   3th zero_variant_without_newline
dnl #
dnl # __IF starts on a new line
dnl #
dnl # use:
dnl # __IF({($1) == 5},{five},{no five})
dnl #
dnl # use:
dnl # __IF({($1) == 5},{dnl
dnl # __{}five},
dnl # {dnl
dnl # __{}{no five})
dnl
define({__IF},{define({__if_tmp},eval($1)){}ifelse(dnl
__if_tmp,{},{dnl
__{}  ; warning The condition >>>$1<<< cannot be evaluated
__{}  if ($1)
__{}__{}__{}$2
__{}  else
__{}__{}__{}$3
__{}  endif},
__if_tmp,{0},{dnl
__{}__{}$3},
__{}{dnl
__{}__{}$2})}){}dnl
dnl
dnl
dnl
define({__SWAP2DEF},{dnl
__{}define({__SWAP2DEF_TMP},$1)define({$1},$2)define({$2},__SWAP2DEF_TMP)}){}dnl
dnl
dnl
dnl
define({__DEQ_INIT_CODE},{dnl
__{}__{}define({_TMP_R1},{D})define({_TMP_N1},eval((($1)>>24) & 0xFF)){}dnl
__{}__{}define({_TMP_R2},{E})define({_TMP_N2},eval((($1)>>16) & 0xFF)){}dnl
__{}__{}define({_TMP_R3},{H})define({_TMP_N3},eval((($1)>>8) & 0xFF)){}dnl
__{}__{}define({_TMP_R4},{L})define({_TMP_N4},eval(($1) & 0xFF)){}dnl
__{}__{}ifelse(_TMP_N4,{0},{define({_TMP_N4},256)}){}dnl
__{}__{}ifelse(_TMP_N3,{0},{define({_TMP_N3},256)}){}dnl
__{}__{}ifelse(_TMP_N2,{0},{define({_TMP_N2},256)}){}dnl
__{}__{}ifelse(_TMP_N1,{0},{define({_TMP_N1},256)}){}dnl
__{}__{}ifelse(eval(_TMP_N4<_TMP_N3),{1},{dnl
__{}__{}__SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__{}__SWAP2DEF({_TMP_R4},{_TMP_R3})}){}dnl
__{}__{}ifelse(eval(_TMP_N3<_TMP_N2),{1},{dnl
__{}__{}__SWAP2DEF({_TMP_N3},{_TMP_N2}){}dnl
__{}__{}__SWAP2DEF({_TMP_R3},{_TMP_R2}){}dnl
__{}__{}__{}ifelse(eval(_TMP_N4<_TMP_N3),{1},{dnl
__{}__{}__{}__SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__{}__{}__SWAP2DEF({_TMP_R4},{_TMP_R3})})}){}dnl
__{}__{}ifelse(eval(_TMP_N2<_TMP_N1),{1},{dnl
__{}__{}__SWAP2DEF({_TMP_N2},{_TMP_N1}){}dnl
__{}__{}__SWAP2DEF({_TMP_R2},{_TMP_R1}){}dnl
__{}__{}__{}ifelse(eval(_TMP_N3<_TMP_N2),{1},{dnl
__{}__{}__{}__SWAP2DEF({_TMP_N3},{_TMP_N2}){}dnl
__{}__{}__{}__SWAP2DEF({_TMP_R3},{_TMP_R2}){}dnl
__{}__{}__{}__{}ifelse(eval(_TMP_N4<_TMP_N3),{1},{dnl
__{}__{}__{}__{}__SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__{}__{}__{}__SWAP2DEF({_TMP_R4},{_TMP_R3})})})})}){}dnl
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
dnl __DEQ_CODE
dnl __DEQ_CLOCKS_TRUE
dnl __DEQ_CLOCKS_FAIL
dnl __DEQ_CLOCKS
dnl __DEQ_BYTES
dnl
dnl zero flag if const == DEHL
dnl A = 0 if const == DEHL, because the "cp" instruction can be the last instruction only with a non-zero result.
dnl
define({__DEQ_MAKE_CODE},{dnl
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}define({__R1},_TMP_R1){}dnl Protoze obcas muzeme udelat prohozeni registru tak si udelame kopii
__{}define({__R2},_TMP_R2){}dnl
__{}define({__R3},_TMP_R3){}dnl
__{}define({__R4},_TMP_R4){}dnl
__{}define({__N1},_TMP_N1){}dnl
__{}define({__N2},_TMP_N2){}dnl
__{}define({__N3},_TMP_N3){}dnl
__{}define({__N4},_TMP_N4){}dnl
__{}dnl
__{}dnl --------------- 4 ---------------
__{}dnl
__{}define({_TMP_OR3},{cp }){}dnl
__{}dnl
__{}dnl 0 - - -    + send signal 0
__{}dnl
__{}ifelse(__N4,256,{dnl
__{}__{}define({_TMP_OR3},{xor}){}dnl
__{}__{}define({_TMP_B4},1){}dnl
__{}__{}define({_TMP_T4},4){}dnl
__{}__{}define({_TMP_J3},4){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    or    __R4             ; 1:4       _TMP_INFO   x[4] = 0})},
__{}dnl
__{}dnl 255 - - -    need 255
__{}dnl
__{}__N4,{255},{dnl
__{}__{}define({_TMP_OR3},{xor}){}dnl
__{}__{}define({_TMP_B4},2){}dnl
__{}__{}define({_TMP_T4},8){}dnl
__{}__{}define({_TMP_J3},8){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_4},{
__{}__{}__{}    and   __R4             ; 1:4       _TMP_INFO   x[4] = 0xFF
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl 1 - - -    + send signal 0
__{}dnl
__{}__N4,{1},{dnl
__{}__{}define({_TMP_OR3},{xor}){}dnl
__{}__{}define({_TMP_B4},3){}dnl
__{}__{}define({_TMP_T4},12){}dnl
__{}__{}define({_TMP_J3},12){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    ld    C{,} __R4          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[4] = 1})},
__{}dnl
__{}dnl a a - -    termination of identical values
__{}dnl
__{}__N4,__N3,{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},14){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    xor   format({0x%02X},__N4)          ; 2:7       _TMP_INFO   x[4] = format({0x%02X},__N4)  termination of identical values})},
__{}dnl
__{}dnl a+1 a - -
__{}dnl
__{}eval(__N4==(__N3+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = x[3] + 1})},
__{}dnl
__{}dnl c-1 c - -
__{}dnl
__{}eval(__N4==(__N3-1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = x[3] - 1})},
__{}dnl
__{}dnl c+a c - a
__{}dnl
__{}eval(__N4==(__N3+__N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = x[3] + x[1]})},
__{}dnl
__{}dnl c-a c - a
__{}dnl
__{}eval(__N4==(__N3-__N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    sub   __R1             ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = x[3] - x[1]})},
__{}dnl
__{}dnl c+b c b -
__{}dnl
__{}eval(__N4==(__N3+__N2 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} __R2          ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = x[3] + x[2]})},
__{}dnl
__{}dnl c-b c b -
__{}dnl
__{}eval(__N4==(__N3-__N2 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    sub   __R2             ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = x[3] - x[2]})},
__{}dnl
__{}dnl c+c c - -
__{}dnl
__{}eval(__N4==(__N3+__N3 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} __R3          ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = x[3] + x[3]})},
__{}dnl
__{}dnl   default version
__{}{dnl
__{}__{}define({_TMP_B4},5){}dnl
__{}__{}define({_TMP_T4},18){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} format({0x%02X},__N4)       ; 2:7       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = format({0x%02X},__N4)})}){}dnl
__{}dnl
__{}dnl --------------- 3 ---------------
__{}dnl
__{}define({_TMP_OR2},{cp }){}dnl
__{}dnl
__{}dnl - 0 - -    + send signal 0
__{}dnl
__{}ifelse(__N3,256,{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+1)){}dnl
__{}__{}define({_TMP_T3},4){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    or    __R3             ; 1:4       _TMP_INFO   x[3] = 0})},
__{}dnl
__{}dnl 255 255 - -    need 255
__{}dnl
__{}__N4{-}__N3,{255-255},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+1)){}dnl
__{}__{}define({_TMP_T3},4){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    and   __R3             ; 1:4       _TMP_INFO   x[3] = 0xFF})},
__{}dnl
__{}dnl 0 255 - -     need 255
__{}dnl
__{}__N4{-}__N3,{256-255},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+2)){}dnl
__{}__{}define({_TMP_T3},8){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    and   __R3             ; 1:4       _TMP_INFO   x[3] = 0xFF
__{}__{}    inc   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl 255 a a -    termination of identical values
__{}dnl
__{}__N4{-}__N3{-}__N2,{255-}__N2{-}__N2,{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},14){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(__N3 ^    0xFF))          ; 2:7       _TMP_INFO   x[3] = format({0x%02X},__N3) = 0xFF ^ format({0x%02X},eval(__N3 ^ 0xFF))  termination of identical values})},
__{}dnl
__{}dnl 255 1 - -    + send signal 0
__{}dnl
__{}__N4{-}__N3,{255-1},{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},16){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    ld    C{,} __R3          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[3] = 1
__{}__{}    dec   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl 255 254 - -
__{}dnl
__{}__N4{-}__N3,{255-254},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __R3          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[3] + 1 = 0xFF})},
__{}dnl
__{}dnl 255 - - -
__{}dnl
__{}__N4,{255},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+5)){}dnl
__{}__{}define({_TMP_T3},18){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __R3          ; 1:4       _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(__N3 ^ 0xFF))          ; 2:7       _TMP_INFO   x[3] = format({0x%02X},__N3) = 0xFF ^ format({0x%02X},eval(__N3 ^ 0xFF))})},
__{}dnl
__{}dnl 0 1 - -    + send signal 0
__{}dnl
__{}eval(((__N4 == 256) || (__N4 == 1)) && (__N3 == 1)),{1},{dnl
__{}__{}define({_TMP_OR2},{xor}){}dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+3)){}dnl
__{}__{}define({_TMP_T3},12){}dnl
__{}__{}define({_TMP_J2},eval(_TMP_T4+_TMP_T3)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    ld    C{,} __R3          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[3] = 1})},
__{}dnl
__{}dnl b b b -    continuation of identical values
__{}dnl
__{}__N4{-}__N3{-}__N2,__N2{-}__N2{-}__N2,{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+3)){}dnl
__{}__{}define({_TMP_T3},11){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    cp    __R4             ; 1:4       _TMP_INFO   x[3] = x[4]  continuation of identical values})},
__{}dnl
__{}dnl c c - -    the beginning of identical values (preserves value)
__{}dnl
__{}__N4,__N3,{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __R3          ; 1:4       _TMP_INFO
__{}__{}    cp    __R4             ; 1:4       _TMP_INFO   x[3] = x[4] the beginning of identical values})},
__{}dnl
__{}dnl - b b -    termination of identical values
__{}dnl
__{}__N3{-}__N2,__N2{-}__N2,{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},14){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    _TMP_OR3  format({0x%02X},__N3)           ; 2:7       _TMP_INFO   x[3] = format({0x%02X},__N3)  termination of identical values})},
__{}dnl
__{}dnl - b+1 b -
__{}dnl
__{}eval(__N3==(__N2+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = x[2] + 1})},
__{}dnl
__{}dnl - b-1 b -
__{}dnl
__{}eval(__N3==(__N2-1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = x[2] - 1})},
__{}dnl
__{}dnl - b+a b a
__{}dnl
__{}eval(__N3==(__N2+__N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = x[2] + x[1]})},
__{}dnl
__{}dnl - b-a b a
__{}dnl
__{}eval(__N3==(__N2-__N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    sub   __R1             ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = x[2] - x[1]})},
__{}dnl
__{}dnl - b+b b -
__{}dnl
__{}eval(__N3==(__N2+__N2 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} __R2          ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = x[2] + x[2]})},
__{}dnl
__{}dnl  default version
__{}{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+5)){}dnl
__{}__{}define({_TMP_T3},18){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} format({0x%02X},__N3)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = format({0x%02X},__N3)})}){}dnl
__{}dnl
__{}dnl --------------- 2 ---------------
__{}dnl
__{}define({_TMP_OR1},{cp }){}dnl
__{}dnl
__{}dnl - - 0 -    + send signal 0
__{}dnl
__{}ifelse(__N2,256,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+1)){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    or    __R2             ; 1:4       _TMP_INFO   x[2] = 0})},
__{}dnl
__{}dnl - 255 255 -   + need 255
__{}dnl
__{}__N3{-}__N2,{255-255},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+1)){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    and   __R2             ; 1:4       _TMP_INFO   x[2] = 0xFF})},
__{}dnl
__{}dnl - 0 255 -    + need 255
__{}dnl
__{}__N3{-}__N2,{256-255},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+2)){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    and   __R2             ; 1:4       _TMP_INFO   x[2] = 0xFF
__{}__{}    inc   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl - 255 a a    termination of identical values
__{}dnl
__{}__N3{-}__N2{-}__N1,{255-}__N1{-}__N1,{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},14){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(__N2 ^    0xFF))          ; 2:7       _TMP_INFO   x[2] = format({0x%02X},__N2) = 0xFF ^ format({0x%02X},eval(__N2 ^ 0xFF))      termination of identical values})},
__{}dnl
__{}dnl - 255 1 -  and __R1!=L  + send signal 0
__{}dnl
__{}eval((__N3==255) && (__N2==1) && (ifelse(__R1,{L},{0},{1}))),{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},16){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    ld    C{,} __R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1
__{}__{}    dec   A             ; 1:4       _TMP_INFO})},
__{}dnl
__{}dnl  - 255 254 -    + send signal 0
__{}dnl
__{}__N3{-}__N2,{255-254},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __R2          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[2] + 1 = 0xFF})},
__{}dnl
__{}dnl  - 255 - -    + send signal 0
__{}dnl
__{}__N3,{255},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+5)){}dnl
__{}__{}define({_TMP_T2},18){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __R2          ; 1:4       _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(__N2 ^    0xFF))          ; 2:7       _TMP_INFO   x[2] = format({0x%02X},__N2) = 0xFF ^ format({0x%02X},eval(__N2 ^ 0xFF))})},
__{}dnl
__{}dnl 0 0 1 -    + send signal 0
__{}dnl
__{}eval(((__N4==256)||(__N4==1)) && ((__N3==256)||(__N3==1)) && (__N2 == 1)),{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+3)){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},eval(_TMP_T4+_TMP_T3+_TMP_T2)){}dnl      No jump! Multibyte solution
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    ld    C{,} __R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}dnl
__{}dnl - a a a    continuation of identical values (preserves value)
__{}dnl
__{}__N3{-}__N2{-}__N1,__N1{-}__N1{-}__N1,{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+3)){}dnl
__{}__{}define({_TMP_T2},11){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    cp    __R3             ; 1:4       _TMP_INFO   x[2] = x[3]  continuation of identical values})},
__{}dnl
__{}dnl - a a -    + send signal 0 because it can be shorter in number 1, the beginning of identical values (preserves value)
__{}dnl
__{}__N3,__N2,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __R2          ; 1:4       _TMP_INFO   the beginning of identical values
__{}__{}    cp    __R3             ; 1:4       _TMP_INFO   x[2] = x[3]})},
__{}dnl
__{}dnl - - a a    termination of identical values
__{}__N2,__N1,{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},14){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    _TMP_OR2   format({0x%02X},__N2)          ; 2:7       _TMP_INFO   x[2] = format({0x%02X},__N2)  termination of identical values})},
__{}dnl
__{}dnl - - a+1 a
__{}dnl
__{}eval(__N2==(__N1+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + 1})},
__{}dnl
__{}dnl - - a-1 a
__{}dnl
__{}eval(__N2==(__N1-1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] - 1})},
__{}dnl
__{}dnl - - a+a a
__{}dnl
__{}eval(__N2==(__N1+__N1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    add   A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + x[1]})},
__{}dnl
__{}dnl - - - -     default version
__{}{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+5)){}dnl
__{}__{}define({_TMP_T2},18){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} format({0x%02X},__N2)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR2   __R2             ; 1:4       _TMP_INFO   x[2] = format({0x%02X},__N2)})}){}dnl
__{}dnl
__{}dnl --------------- 1 ---------------
__{}dnl
__{}dnl 0 0 0 0    zeros and ones and 0xFF have a different code for a series of equal values
__{}dnl
__{}ifelse(__N1,256,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({__DEQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO   x[1] = 0})},
__{}dnl
__{}dnl - - 255 255    need 255
__{}dnl
__{}__N2{-}__N1,{255-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({__DEQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO   x[1] = 0xFF})},
__{}dnl
__{}dnl - - 0 255    need for zero optimization
__{}dnl
__{}__N2{-}__N1,{256-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__DEQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = 0xFF})},
__{}dnl
__{}dnl - - 255 254    need 255
__{}dnl
__{}__N2{-}__N1,{255-254},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__DEQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] + 1 = 0xFF})},
__{}dnl
__{}dnl - - 255 x    need 255
__{}dnl
__{}__N2,{255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__DEQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(__N1 ^ 0xFF))          ; 2:7       _TMP_INFO   x[1] = format({0x%02X},__N1) = 0xFF ^ format({0x%02X},eval(__N1 ^ 0xFF))})},
__{}dnl
__{}dnl - - - 1    + need 0, need for zero optimization
__{}dnl
__{}_TMP_OR1{-}__N1,{xor-1},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__DEQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[1] = 1})},
__{}dnl
__{}dnl - - a a    the beginning of identical values (preserves value)
__{}dnl
__{}__N2,__N1,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__DEQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO   the beginning of identical values
__{}__{}    cp    __R2             ; 1:4       _TMP_INFO   x[1] = x[2]})},
__{}dnl
__{}dnl - - - -    default version
__{}{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__DEQ_CODE_1},{
__{}__{}    ld    A{,} format({0x%02X},__N1)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR1   __R1             ; 1:4       _TMP_INFO   x[1] = format({0x%02X},__N1)})}){}dnl
__{}dnl
__{}dnl ---------------------------------
__{}dnl
__{}define({_TMP_J1},eval(_TMP_J1+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({_TMP_J2},eval(_TMP_J2+_TMP_T1+_TMP_T2+ifelse($3,{},{0},{$3}))){}dnl
__{}define({_TMP_J3},eval(_TMP_J3+_TMP_T1+_TMP_T2+_TMP_T3+ifelse($3,{},{0},{$3}))){}dnl
__{}define({_TMP_J4},eval(_TMP_T4+_TMP_T3+_TMP_T2+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({__DEQ_CLOCKS_TRUE},eval(_TMP_J4)){}dnl                                     the longest, full-pass variant
__{}define({__DEQ_CLOCKS_FAIL},eval(4*_TMP_J1+2*_TMP_J2+_TMP_J3+_TMP_J4)){}dnl         It is calculated that each jump has half the chance to be performed, so the probability of the next jump is always half less.
__{}define({__DEQ_PRICE},eval(8*__DEQ_CLOCKS_TRUE+__DEQ_CLOCKS_FAIL)){}dnl         The TRUE variant is calculated to have the same probability as the FALSE variant.
__{}define({__DEQ_CLOCKS_FAIL},eval((__DEQ_CLOCKS_FAIL+4)/8)){}dnl                   0.5 round up
__{}define({__DEQ_CLOCKS},eval((__DEQ_PRICE+8)/16)){}dnl                             0.5 round up
__{}define({__DEQ_BYTES},eval(_TMP_B1+ifelse($2,{},{0},{$2}))){}dnl
__{}define({__DEQ_PRICE},eval(__DEQ_PRICE+(64*__DEQ_BYTES)+ifelse(__R1,{L},{0},{1}))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}define({__DEQ_CODE},format({%47s},;[eval(__DEQ_BYTES):__DEQ_CLOCKS_TRUE/_TMP_J1{{{,}}}_TMP_J2{{{,}}}_TMP_J3{{{,}}}_TMP_J4]){_TMP_STACK_INFO{}__DEQ_CODE_1{}__DEQ_CODE_2{}__DEQ_CODE_3{}__DEQ_CODE_4}){}dnl
__{}dnl
__{}dnl debug:
__{}dnl __DEQ_CODE
__{}dnl ifelse(__N1,16,__DEQ_CODE{})
}){}dnl
dnl
dnl
dnl
dnl
dnl
define({__CHEAPER},{dnl
__{}eval(_TMP_BEST_P>__DEQ_PRICE)}){}dnl
dnl
dnl
dnl
define({__SMALLER},{dnl
__{}ifelse(eval(_TMP_BEST_B>__DEQ_BYTES),{1},{1},
__{}eval(_TMP_BEST_B==__DEQ_BYTES),{1},{dnl
__{}__{}ifelse(eval(_TMP_BEST_C>__DEQ_CLOCKS),{1},{1},
__{}__{}eval(_TMP_BEST_C==__DEQ_CLOCKS),{1},{dnl
__{}__{}__{}ifelse(_TMP_R1,{L},{1},{0})},
__{}__{}{0})},
__{}{0}){}dnl
}){}dnl
dnl
dnl
dnl
define({__BETTER},{dnl
__{}ifelse(_TYP_DOUBLE,{small},{eval((_TMP_BEST_B>__DEQ_BYTES) || ((_TMP_BEST_B==__DEQ_BYTES) && (_TMP_BEST_P>__DEQ_PRICE)))},{eval(_TMP_BEST_P>__DEQ_PRICE)})}){}dnl
dnl
dnl
dnl
define({__DEQ_VARIATION_21},{dnl
__{}dnl debug:
__{}dnl format({0x%02X},_TMP_N4)-format({0x%02X},_TMP_N3)-format({0x%02X},_TMP_N2)-format({0x%02X},_TMP_N1)
__{}dnl
__{}__DEQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}__{}ifelse(__BETTER,{1},{dnl
__{}__{}__{}define({_TMP_BEST_P},__DEQ_PRICE){}dnl
__{}__{}__{}define({_TMP_BEST_B},__DEQ_BYTES){}dnl
__{}__{}__{}define({_TMP_BEST_C},__DEQ_CLOCKS){}dnl
__{}__{}__{}define({_TMP_BEST_CODE},__DEQ_CODE)}){}dnl
__{}ifelse(eval(_TMP_N2<255),{1},{dnl
__{}__SWAP2DEF({_TMP_N2},{_TMP_N1}){}dnl
__{}__SWAP2DEF({_TMP_R2},{_TMP_R1}){}dnl
__{}dnl debug:
__{}dnl format({0x%02X},_TMP_N4)-format({0x%02X},_TMP_N3)-format({0x%02X},_TMP_N2)-format({0x%02X},_TMP_N1)
__{}dnl
__{}__DEQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}__{}ifelse(__BETTER,{1},{dnl
__{}__{}__{}define({_TMP_BEST_P},__DEQ_PRICE){}dnl
__{}__{}__{}define({_TMP_BEST_B},__DEQ_BYTES){}dnl
__{}__{}__{}define({_TMP_BEST_C},__DEQ_CLOCKS){}dnl
__{}__{}__{}define({_TMP_BEST_CODE},__DEQ_CODE)})})}){}dnl
dnl
dnl
dnl
define({__DEQ_VARIATION_32},{dnl
__{}__DEQ_VARIATION_21($1,$2,$3,$4,$5){}dnl
__{}ifelse(eval(_TMP_N3<255),{1},{dnl
__{}__SWAP2DEF({_TMP_N3},{_TMP_N2}){}dnl
__{}__SWAP2DEF({_TMP_R3},{_TMP_R2}){}dnl
__{}__DEQ_VARIATION_21($1,$2,$3,$4,$5){}dnl
__{}__SWAP2DEF({_TMP_N3},{_TMP_N2}){}dnl
__{}__SWAP2DEF({_TMP_R3},{_TMP_R2}){}dnl
__{}__DEQ_VARIATION_21($1,$2,$3,$4,$5)})}){}dnl
dnl
dnl
dnl
dnl
dnl ============================================
dnl # Input parameters:
dnl #               $1 = 32 bit number
dnl #               $2 = +-bytes no jump
dnl #               $3 = +-clocks no jump
dnl #               $4 = +-bytes jump
dnl #               $5 = +-clocks jump
dnl #        _TMP_INFO = info
dnl #  _TMP_STACK_INFO = stack info
dnl #
dnl #
dnl # Out:
dnl #   _TMP_BEST_CODE = code
dnl #      _TMP_BEST_P = price = 16*(clocks + 4*bytes)
dnl #      _TMP_BEST_B = bytes
dnl #      _TMP_BEST_C = clocks
dnl #
dnl #  zero flag if const == DEHL
dnl #  A = 0 if const == DEHL, because the "cp" instruction can be the last instruction only with a non-zero result.
dnl
define({__DEQ_MAKE_BEST_CODE},{dnl
__DEQ_INIT_CODE($1){}dnl
__{}define({_TMP_BEST_P},10000000){}dnl    price = 16*(clocks + 4*bytes)
__{}define({_TMP_BEST_B},10000000){}dnl    bytes
__{}define({_TMP_BEST_C},10000000){}dnl    clocks
__{}__DEQ_VARIATION_32($1,$2,$3,$4,$5){}dnl
__{}ifelse(eval(_TMP_N4<255),{1},{dnl
__{}__SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__SWAP2DEF({_TMP_R4},{_TMP_R3}){}dnl
__{}__DEQ_VARIATION_32($1,$2,$3,$4,$5){}dnl
__{}__SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__SWAP2DEF({_TMP_R4},{_TMP_R3}){}dnl
__{}__DEQ_VARIATION_32($1,$2,$3,$4,$5){}dnl
__{}__SWAP2DEF({_TMP_N4},{_TMP_N1}){}dnl
__{}__SWAP2DEF({_TMP_R4},{_TMP_R1}){}dnl
__{}__DEQ_VARIATION_32($1,$2,$3,$4,$5)})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl ============================================
dnl # Input parameters:
dnl #   $1 = 16 bit number
dnl #   $2 = +-bytes no jump
dnl #   $3 = +-clocks no jump
dnl #   $4 = +-bytes jump
dnl #   $5 = +-clocks jump
dnl #   _TMP_INFO = info
dnl #   _TMP_STACK_INFO = stack info
dnl #
dnl # Out:
dnl # __EQ_CODE
dnl # zero flag if const == DEHL
dnl # A = 0 if const == HL, because the "cp" instruction can be the last instruction only with a non-zero result.
dnl
define({__EQ_MAKE_CODE},{ifelse(__IS_MEM_REF($1),{1},{dnl
__{}dnl ---------------------------------
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}ifelse(_TYP_SINGLE,{small},{dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld   BC{{,}} format({%-11s},$1); 4:20      _TMP_INFO
__{}__{}    xor   A             ; 1:4       _TMP_INFO   cp HL{{,}} BC
__{}__{}    sbc  HL{{,}} BC         ; 2:15      _TMP_INFO   cp HL{{,}} BC
__{}__{}    add  HL{{,}} BC         ; 1:11      _TMP_INFO   cp HL{{,}} BC}){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(50+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},__EQ_CLOCKS_TRUE){}dnl
__{}__{}define({__EQ_CLOCKS},__EQ_CLOCKS_TRUE){}dnl
__{}__{}define({__EQ_BYTES},eval(8+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({__EQ_CODE},{                        ;}format({%-10s},[eval(__EQ_BYTES):__EQ_CLOCKS])_TMP_STACK_INFO{}__EQ_CODE)},
__{}regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}define({_TMP_B1},10){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{{,}} format({%-11s},$1); 3:13      _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jr   nz{{,}} $+format({%-9s},eval(6+_TMP_B0)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{{,}}format({%-12s},(1+$1)); 3:13      _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval(41+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({_TMP_J1},eval(29+ifelse($3,{},{0},{$3})+_TMP_J0)){}dnl
__{}__{}define({_TMP_J2},eval(41+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval((1+_TMP_J1+_TMP_J2)/2)){}dnl
__{}__{}define({__EQ_CLOCKS},eval((1+__EQ_CLOCKS_TRUE+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}__{}define({__EQ_BYTES},eval(10+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({__EQ_CODE},format({%37s},;[eval(__EQ_BYTES):_TMP_J1{{,}}_TMP_J2/__EQ_CLOCKS_FAIL])_TMP_STACK_INFO{}__EQ_CODE)},
__{}{dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{{,}} format({%-11s},$1); 3:13      _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}    ld    A{{,}}format({%-12s},(1+$1)); 3:13      _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(44+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({_TMP_J1},eval(27)){}dnl
__{}__{}define({_TMP_J2},eval(44+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval((1+_TMP_J1+_TMP_J2)/2)){}dnl
__{}__{}define({__EQ_CLOCKS},eval((1+__EQ_CLOCKS_TRUE+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}__{}define({__EQ_BYTES},eval(11+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({__EQ_CODE},format({%37s},;[eval(__EQ_BYTES):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2])_TMP_STACK_INFO{}__EQ_CODE)})},
eval($1),{},{dnl
__{}dnl ---------------------------------
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}define({_TMP_B1},10){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{{,}} low format({%-7s},$1); 2:7       _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jr   nz{{,}} $+format({%-9s},eval(5+_TMP_B0)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{{,}} high format({%-6s},$1); 2:7       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval(41+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({_TMP_J1},eval(23+ifelse($3,{},{0},{$3})+_TMP_J0)){}dnl
__{}__{}define({_TMP_J2},eval(29+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},_TMP_J2){}dnl
__{}__{}define({__EQ_CLOCKS},eval((1+__EQ_CLOCKS_TRUE+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}__{}define({__EQ_BYTES},eval(8+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({__EQ_CODE},format({%37s},;[eval(__EQ_BYTES):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2])_TMP_STACK_INFO{}__EQ_CODE)},
__{}{dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{{,}} low format({%-7s},$1); 2:7       _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}    ld    A{{,}} high format({%-6s},$1); 2:7       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({_TMP_J1},eval(21)){}dnl
__{}__{}define({_TMP_J2},eval(32+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},_TMP_J2){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval((1+_TMP_J1+_TMP_J2)/2)){}dnl
__{}__{}define({__EQ_CLOCKS},eval((1+__EQ_CLOCKS_TRUE+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}__{}define({__EQ_BYTES},eval(9+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({__EQ_CODE},format({%37s},;[eval(__EQ_BYTES):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2])_TMP_STACK_INFO{}__EQ_CODE)})},
{dnl
__{}dnl ---------------------------------
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}define({__R1},{L}){}dnl
__{}define({__R2},{H}){}dnl
__{}define({__N1},eval(($1) & 0xFF)){}dnl
__{}define({__N2},eval((($1)>>8) & 0xFF)){}dnl
__{}ifelse(eval(__N2<__N1),{1},{dnl
__{}__{}__SWAP2DEF({__N1},{__N2}){}dnl
__{}__{}__SWAP2DEF({__R1},{__R2})}){}dnl
__{}ifelse(eval((__N2+__N2) & 0xFF),__N1,{dnl    0x952A --> 0x2A95  = 42, 149
__{}__{}ifelse(__N2{-}__N1,255{-}254,,{dnl
__{}__{}__{}__SWAP2DEF({__N1},{__N2}){}dnl
__{}__{}__{}__SWAP2DEF({__R1},{__R2})})}){}dnl
__{}ifelse(__N1,{0},{dnl                       0x..00 --> 0x00..
__{}__{}__SWAP2DEF({__N1},{__N2}){}dnl
__{}__{}__SWAP2DEF({__R1},{__R2})}){}dnl
__{}dnl --------------- 2 ---------------
__{}dnl
__{}define({_TMP_OR1},{cp }){}dnl
__{}ifelse(__N2,0,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},1){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},4){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE},{
__{}__{}    or    __R2             ; 1:4       _TMP_INFO   x[2] = 0})},
__{}__N2{-}__N1,{2-1},{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},3){}dnl
__{}__{}__{}define({_TMP_T2},11){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[2] = 2})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},14){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[2] = 2})})},
__{}__N2,{255},{dnl
__{}__{}define({_TMP_B2},2){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},8){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE},{
__{}__{}    and   __R2             ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[2] = 0xFF})},
__{}__N2{-}__N1,{1-1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},12){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    C{{,}} __R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}__N2,{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},12){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    C{{,}} __R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}__N2,__N1,{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},14){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    xor   format({0x%02X},__N2)          ; 2:7       _TMP_INFO   x[2] = format({0x%02X},__N2)})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},17){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    xor   format({0x%02X},__N2)          ; 2:7       _TMP_INFO   x[2] = format({0x%02X},__N2)})})},
__{}eval(__N2==(__N1+1 & 0xFF)),{1},{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + 1})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10     _TMP_INFO
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + 1})})},
__{}eval(__N2==(__N1+__N1 & 0xFF)),{1},{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    add   A{{,}} __R1          ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + x[1]})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    add   A{{,}} __R1          ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + x[1]})})},
__{}{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld    A{{,}} format({0x%02X},__N2)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = format({0x%02X},__N2)})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},6){}dnl
__{}__{}__{}define({_TMP_T2},21){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    ld    A{{,}} format({0x%02X},__N2)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = format({0x%02X},__N2)})})}){}dnl
__{}dnl
__{}dnl --------------- 1 ---------------
__{}dnl
__{}ifelse(__N1,0,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO   x[1] = 0}__EQ_CODE)},
__{}__N2{-}__N1,{255-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO   x[1] = 0xFF}__EQ_CODE)},
__{}__N2{-}__N1,{255-254},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = x[2] - 1}__EQ_CODE)},
__{}__N2,{255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    xor   format({0x%02X},eval(__N1 ^ 0xFF))          ; 2:7       _TMP_INFO   x[1] = 0xFF ^ format({0x%02X},eval(__N1 ^ 0xFF))}__EQ_CODE)},
__{}__N2{-}__N1,{0-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = 0xFF}__EQ_CODE)},
__{}__N2{-}__N1,{2-1},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},12){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{,} __R2          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    cp    __R1             ; 1:4       _TMP_INFO   x[1] = x[2] - 1}__EQ_CODE)},
__{}__N1,{1},{dnl    255-1 --> 255-x rule priority!
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[1] = 1}__EQ_CODE)},
__{}__N2,__N1,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    cp    __R2             ; 1:4       _TMP_INFO   x[1] = x[2]}__EQ_CODE)},
__{}{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__EQ_CODE},{
__{}__{}    ld    A{,} format({0x%02X},__N1)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR1   __R1             ; 1:4       _TMP_INFO   x[1] = format({0x%02X},__N1)}__EQ_CODE)}){}dnl
__{}dnl
__{}dnl ---------------------------------
__{}dnl
__{}define({_TMP_J1},eval(_TMP_J1+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({_TMP_J2},eval(_TMP_T2+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J2)){}dnl
__{}define({__EQ_CLOCKS_FAIL},eval((1+_TMP_J1+_TMP_J2)/2)){}dnl
__{}define({__EQ_CLOCKS},eval((__EQ_CLOCKS_TRUE+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}define({__EQ_BYTES},eval(_TMP_B1+ifelse($2,{},{0},{$2}))){}dnl
__{}define({__EQ_CODE},format({%37s},;[eval(__EQ_BYTES):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2])_TMP_STACK_INFO{}__EQ_CODE){}dnl
__{}dnl
__{}dnl debug:__EQ_CODE
})}){}dnl
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
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}                       ;[11:60]     _TMP_INFO   ( x1 -- x1 )   (addr) == HL
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO   cp HL, BC
__{}__{}__{}    sbc  HL, BC         ; 2:15      _TMP_INFO   cp HL, BC
__{}__{}__{}    add  HL, BC         ; 1:11      _TMP_INFO   cp HL, BC
__{}__{}__{}    jp   nz, else{}IF_COUNT    ; 3:10      _TMP_INFO},
__{}__{}{__EQ_MAKE_CODE($1,3,10,0,0)dnl
__{}__{}__{}ifelse(eval((__EQ_CLOCKS+4*__EQ_BYTES)<=((42+(21+42)/2)/2+4*12)),{1},{
__{}__{}__{}__{}__EQ_CODE
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
__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}                       ;[11:60]     _TMP_INFO   ( x1 -- x1 )   (addr) == HL
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO   cp HL, BC
__{}__{}__{}    sbc  HL, BC         ; 2:15      _TMP_INFO   cp HL, BC
__{}__{}__{}    add  HL, BC         ; 1:11      _TMP_INFO   cp HL, BC
__{}__{}__{}    jp    z, else{}IF_COUNT    ; 3:10      _TMP_INFO},
__{}__{}{__EQ_MAKE_CODE($1,3,10,3,-10)dnl
__{}__{}__{}ifelse(eval((__EQ_CLOCKS+4*__EQ_BYTES)<=((39+(23+39)/2)/2+4*11)),{1},{
__{}__{}__{}__{}__EQ_CODE
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
define({__TEST},{dnl
__{}define({_TMP_R4},{D})define({_TMP_N4},eval((($1)>>24) & 0xFF)){}dnl
__{}define({_TMP_R3},{E})define({_TMP_N3},eval((($1)>>16) & 0xFF)){}dnl
__{}define({_TMP_R2},{H})define({_TMP_N2},eval((($1)>>8) & 0xFF)){}dnl
__{}define({_TMP_R1},{L})define({_TMP_N1},eval(($1) & 0xFF)){}dnl
__{}ifelse(_TMP_N4,{0},{define({_TMP_N4},256)}){}dnl
__{}ifelse(_TMP_N3,{0},{define({_TMP_N3},256)}){}dnl
__{}ifelse(_TMP_N2,{0},{define({_TMP_N2},256)}){}dnl
__{}ifelse(_TMP_N1,{0},{define({_TMP_N1},256)}){}dnl
__DEQ_MAKE_CODE($1,0,0,0,0){}dnl
__DEQ_CODE{}dnl
}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl ============================================
dnl # Input parameters:
dnl #        $1 = 32 bit number
dnl #        $2 = add bytes relative jump
dnl # _TMP_INFO = info
dnl #
dnl # Out:
dnl #          _TMP_B = bytes
dnl #          _TMP_J = clocks jump
dnl #         _TMP_NJ = clocks no jump
dnl #       _TMP_ZERO = zero A after
dnl #  _TMP_HLDE_CODE = code
dnl
define({__DEQ_MAKE_HLDE_CODE},{ifelse(dnl
__{}eval((($1)>>16) & 0xFFFF),{0},{dnl
__{}__{}define({_TMP_B},11){}dnl
__{}__{}define({_TMP_J},35){}dnl
__{}__{}define({_TMP_NJ},55){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 0x0000????
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
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 0x????0000
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
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # hi16(d1) == lo16(d1)
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
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 4th byte zero
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
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 3th byte zero
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} format({0x%02X},eval((($1)>>24) & 0xFF))       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = format({0x%02X},eval((($1)>>24) & 0xFF))
__{}__{}__{}    or    L             ; 1:4       _TMP_INFO   L = 0
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{{,}} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   HL-lo16(d1)})},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}define({_TMP_B},13){}dnl
__{}__{}define({_TMP_J},42){}dnl
__{}__{}define({_TMP_NJ},62){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 2nd byte zero
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} format({0x%02X},eval(($1) & 0xFF))       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   E             ; 1:4       _TMP_INFO   E = format({0x%02X},eval(($1) & 0xFF))
__{}__{}__{}    or    D             ; 1:4       _TMP_INFO   D = 0
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{{,}} format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{{,}} BC         ; 2:15      _TMP_INFO   HL-hi16(d1)})},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}define({_TMP_B},13){}dnl
__{}__{}define({_TMP_J},42){}dnl
__{}__{}define({_TMP_NJ},62){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 1st byte zero
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} format({0x%02X},eval((($1)>>8) & 0xFF))       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   D             ; 1:4       _TMP_INFO   D = format({0x%02X},eval((($1)>>8) & 0xFF))
__{}__{}__{}    or    E             ; 1:4       _TMP_INFO   E = 0
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{{,}} format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{{,}} BC         ; 2:15      _TMP_INFO   HL-hi16(d1)})},
__{}{dnl
__{}__{}define({_TMP_B},15){}dnl
__{}__{}define({_TMP_J},56){}dnl
__{}__{}define({_TMP_NJ},76){}dnl
__{}__{}define({_TMP_ZERO},{1}){}dnl
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # default version
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
dnl ============================================
dnl # Input parameters:
dnl #        $1 = 32 bit number
dnl #        $2 = add bytes relative jump
dnl # _TMP_INFO = info
dnl #
dnl # Out:
dnl #        _TMP_B = bytes
dnl #        _TMP_J = clocks jump
dnl #       _TMP_NJ = clocks no jump
dnl #     _TMP_ZERO = zero A after
dnl #  _TMP_HL_CODE = code
dnl
define({__DEQ_MAKE_HL_CODE},{ifelse(dnl
__{}eval((($1)>>16) & 0xFFFF),{0},{dnl
__{}__{}define({_TMP_B},10){}dnl
__{}__{}define({_TMP_J},eval(20+$3)){}dnl
__{}__{}define({_TMP_NJ},51){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 0x0000????
__{}__{}__{}    ld    A{,} E          ; 1:4       _TMP_INFO
__{}__{}__{}    or    D             ; 1:4       _TMP_INFO
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{,} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFFFF),{0},{dnl
__{}__{}define({_TMP_B},10){}dnl
__{}__{}define({_TMP_J},eval(20+$3)){}dnl
__{}__{}define({_TMP_NJ},51){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 0x????0000
__{}__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    or    H             ; 1:4       _TMP_INFO
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{,} format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      _TMP_INFO   HL-hi16(d1)
__{}__{}__{}    add  HL{,} DE         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFFFF),eval((($1)>>16) & 0xFFFF),{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},eval(42+$3)){}dnl
__{}__{}define({_TMP_NJ},73){}dnl
__{}__{}define({_TMP_HL_CODE},{   # hi16(d1) == lo16(d1)
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO   A = 0
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      _TMP_INFO   lo16(d1)-hi16(d1)
__{}__{}__{}    add  HL{,} DE         ; 1:11      _TMP_INFO
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{,} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFF000000),{0},{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},eval(27+$3)){}dnl
__{}__{}define({_TMP_NJ},58){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 4th byte zero
__{}__{}__{}    ld    A{,} format({0x%02X},eval((($1)>>16) & 0xFF))       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   E             ; 1:4       _TMP_INFO   E = format({0x%02X},eval((($1)>>16) & 0xFF))
__{}__{}__{}    or    D             ; 1:4       _TMP_INFO   D = 0
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{,} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFF0000),{0},{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},eval(27+$3)){}dnl
__{}__{}define({_TMP_NJ},58){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 3th byte zero
__{}__{}__{}    ld    A{,} format({0x%02X},eval((($1)>>24) & 0xFF))       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   D             ; 1:4       _TMP_INFO   D = format({0x%02X},eval((($1)>>24) & 0xFF))
__{}__{}__{}    or    E             ; 1:4       _TMP_INFO   E = 0
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{,} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},eval(27+$3)){}dnl
__{}__{}define({_TMP_NJ},58){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 2nd byte zero
__{}__{}__{}    ld    A{,} format({0x%02X},eval(($1) & 0xFF))       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   L             ; 1:4       _TMP_INFO   L = format({0x%02X},eval(($1) & 0xFF))
__{}__{}__{}    or    H             ; 1:4       _TMP_INFO   H = 0
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{,} format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      _TMP_INFO   HL-hi16(d1)
__{}__{}__{}    add  HL{,} DE         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},eval(27+$3)){}dnl
__{}__{}define({_TMP_NJ},58){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 1st byte zero
__{}__{}__{}    ld    A{,} format({0x%02X},eval((($1)>>8) & 0xFF))       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = format({0x%02X},eval((($1)>>8) & 0xFF))
__{}__{}__{}    or    L             ; 1:4       _TMP_INFO   L = 0
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{,} format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      _TMP_INFO   HL-hi16(d1)
__{}__{}__{}    add  HL{,} DE         ; 1:11      _TMP_INFO})},
__{}{dnl
__{}__{}define({_TMP_B},15){}dnl
__{}__{}define({_TMP_J},52){}dnl
__{}__{}define({_TMP_NJ},82){}dnl
__{}__{}define({_TMP_HL_CODE},{   # default version
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    ld   BC{,} format({0x%04X},eval(($1) & 0xFFFF))     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    jr   nz{,} $+7        ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{,} format({0x%04X},eval((($1)>>16) & 0xFFFF))     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      _TMP_INFO   hi16(d1)-DE
__{}__{}__{}    pop  HL             ; 1:10      _TMP_INFO})})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl
dnl