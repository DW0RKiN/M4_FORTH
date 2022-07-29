define({__},{})dnl
dnl
dnl
dnl
dnl
dnl
define({__def},{ifdef({$1},,{define({$1},{$2})})}){}dnl
dnl
dnl
define({__HEX_L},{ifelse($1,{},,{format({0x%02X},eval(($1) & 0xFF))})}){}dnl
define({__HEX_H},{ifelse($1,{},,{format({0x%02X},eval((($1)>>8) & 0xFF))})}){}dnl
define({__HEX_E},{ifelse($1,{},,{format({0x%02X},eval((($1)>>16) & 0xFF))})}){}dnl
define({__HEX_D},{ifelse($1,{},,{format({0x%02X},eval((($1)>>24) & 0xFF))})}){}dnl
define({__HEX_HL},{ifelse($1,{},,{format({0x%04X},eval(($1) & 0xFFFF))})}){}dnl
define({__HEX_DE},{ifelse($1,{},,{format({0x%04X},eval((($1)>>16) & 0xFFFF))})}){}dnl
define({__HEX_DEHL},{ifelse($1,{},,{format({0x%08X},eval($1))})}){}dnl
dnl
dnl
dnl
define({__IS_MEM_REF},{dnl
dnl # (abc) --> 1
dnl # (123) --> 1
dnl # ()+() --> 1 fail
dnl # ()    --> 0
dnl # other --> 0
__{}eval( 1 + regexp({$1},{^\s*(.+)\s*$}) )}){}dnl
dnl
dnl
dnl
define({__IS_NUM},{dnl
dnl # (abc)   --> 0
dnl # (123)   --> 0
dnl # (1)+(2) --> 0 fail
dnl # ()      --> 0
dnl #         --> 0
dnl # abc     --> 0
dnl # 0a      --> 0
dnl # 0g      --> 0
dnl # 0xa     --> 1
dnl # 5       --> 1
dnl # 25*3    --> 1
__{}ifelse(dnl
__{}$1,{},{0},
__{}$1,(),{0},
__{}eval( regexp({$1},{[yzYZ_g-wG-W]}) != -1 ),{1},{0},dnl # Any letter and underscore _ except a,b,c,d,e,f,x
__{}eval( regexp({$1},{\(^\|[^0]\)[xX]}) != -1 ),{1},{0},dnl # x without leading zero
__{}eval( regexp({$1},{[a-fA-F0-9]0[xX]}) != -1 ),{1},{0},dnl # 0x inside hex characters or numbers, like 3210x or abc0x
__{}eval( regexp({$1},{\(^\|[^xX0-9a-fA-F]+\)[0-9a-fA-F]*[a-fA-F]}) != -1 ),{1},{0},dnl # hex characters without leading 0x
__{}{dnl
__{}__{}eval( __IS_MEM_REF($1)==0 && ifelse(eval($1),{},{0},{1}) ){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # a  --> 1
dnl # Hl --> 1
dnl # aF --> 1
dnl # dh --> 0
dnl # ix --> 1
define({__IS_REG},{dnl
__{}eval(1+regexp({$1},{^\([a-eA-E]\|[Aa][Ff]\|[Bb][Cc]\|[Dd][Ee]\|[Hh][Ll]\|[Ii][Xx]\|[Ii][Yy]\)$}))}){}dnl
dnl
dnl
dnl
dnl # ld   --> 1
dnl # Xor  --> 1
dnl # cP   --> 1
dnl # jmp  --> 0
dnl # xchg --> 0
define({__IS_INSTRUCTION},{eval(1+regexp(translit({$1},{ABCDEFGHIJKLMNOPQRSTUVWXYZ},{abcdefghijklmnopqrstuvwxyz}),{^\(ad[cd]\|and\|bit\|call\|ccf\|cp[dil]?\|cpdr\|cpir\|daa\|dec\|di\|djnz\|ei\|ex[x]?\|halt\|im\|in[cdi]?\|indr\|inir\|j[pr]\|ld[di]?\|lddr\|ldir\|neg\|nop\|or\|otdr\|otir\|out[di]?\|pop\|push\|res\|ret[in]?\|rl[acd]?\|rlca\|rr[acd]?\|rrca\|rst\|sbc\|scf\|set\|sla\|sr[al]\|sub\|xor\)$}))}){}dnl
dnl
dnl
define({__SORT_SET},{define({$1[$2]},{$3})}){}dnl
define({__SORT_GET},{defn({$1[$2]})}){}dnl
dnl
dnl # for the heap calculations, it's easier if origin is 0, so set value first
define({__SORT_NEW},{__SORT_SET($1,size,0)}){}dnl
dnl
dnl
define({__SORT_APPEND},{__SORT_SET($1,size,incr(__SORT_GET($1,size))){}__SORT_SET($1,__SORT_GET($1,size),$2)}){}dnl
dnl
dnl
dnl # __SORT_SWAP(<name>,<j>,<name>[<j>],<k>)  using arg stack for the temporary
define({__SORT_SWAP},{__SORT_SET($1,$2,__SORT_GET($1,$4)){}__SORT_SET($1,$4,$3)}){}dnl
dnl
dnl
define({__SORT_VAL},$1){}dnl
define({__SORT_OFFSET},$2){}dnl
define({__SORT_ARG1_1},{__SORT_VAL$1}){}dnl
dnl
dnl
define({__SORT_INIT},{ifelse($#,3,
    {__SORT_APPEND({$1},($3,$2))},
    eval($#>3),{1},{__SORT_APPEND({$1},($3,{eval($2)})){}$0($1,eval($2+2),shift(shift(shift($@))))})}){}dnl
dnl
dnl
dnl # Input
dnl #   $1 counter_name
dnl #   $2 from
dnl #   $3 to
dnl #   $4 what
define({__FOR},{ifelse($#,0,
{{$0}},
{ifelse(eval($2<=$3),1,
    {pushdef({$1},$2)$4{}popdef({$1})$0({$1},incr($2),$3,{$4})})})}){}dnl
dnl
dnl
define({__SORT_ONCE},{__FOR({x},1,$2,
    {ifelse(eval(__SORT_ARG1_1(__SORT_GET($1,x))>__SORT_ARG1_1(__SORT_GET($1,incr(x)))),1,
        {__SORT_SWAP($1,x,__SORT_GET($1,x),incr(x)){}1})})0}){}dnl
dnl
dnl
define({__SORT_UP_TO},
    {ifelse(__SORT_ONCE($1,$2),0,
        {},
        {__SORT_UP_TO($1,decr($2))})}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 = array name
dnl #   $2 = offset first value
dnl #   $3,$4,$5,... = values
define({__SORT},
    {__SORT_NEW({$1}){}__SORT_INIT($@){}__SORT_UP_TO($1,decr(__SORT_GET($1,size)))}){}dnl
dnl
dnl
define({__SORT_SHOW},
   {__SORT_GET($1,1){}__FOR({x},2,__SORT_GET($1,size),{,__SORT_GET($1,x)})}){}dnl
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
define({__RAS},{
    ex   DE, HL         ; 1:4       __ras   ( -- return_address_stack )
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    push HL             ; 1:11      __ras
    exx                 ; 1:4       __ras
    pop  HL             ; 1:10      __ras}){}dnl
dnl
dnl
dnl
define({__XOR_REG8_8BIT},{dnl
dnl # Input
dnl #   $1 name reg
dnl #   $2 8bit value
__{}ifelse(__HEX_L($2),{0x00},{},
__{}__HEX_L($2),{0xFF},{
__{}__{}    ld    A, $1          ; 1:4       _TMP_INFO
__{}__{}    cpl                 ; 1:4       _TMP_INFO
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO   ($1 xor 0xFF) = invert $1},
__{}{
__{}__{}    ld    A, __HEX_L($2)       ; 2:7       _TMP_INFO
__{}__{}    xor   $1             ; 1:4       _TMP_INFO
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO})}){}dnl
dnl
dnl
dnl
define({__XOR_REG16_16BIT},{dnl
dnl # Input
dnl #   $1 name reg pair
dnl #   $2 16bit value
__{}__XOR_REG8_8BIT(substr($1,1,1),__HEX_L($2)){}dnl
__{}__XOR_REG8_8BIT(substr($1,0,1),__HEX_H($2)){}dnl
}){}dnl
dnl
dnl
define({__OR_REG8_8BIT},{dnl
dnl # Input
dnl #   $1 name reg
dnl #   $2 8bit value
__{}ifelse(__HEX_L($2),{0x00},{},
__{}__HEX_L($2),{0xFF},{
__{}__{}    ld    $1, 0xFF       ; 2:7       _TMP_INFO},
__{}__HEX_L($2),{0x01},{
__{}__{}    set   0, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x02},{
__{}__{}    set   1, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x04},{
__{}__{}    set   2, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x08},{
__{}__{}    set   3, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x10},{
__{}__{}    set   4, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x20},{
__{}__{}    set   5, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x40},{
__{}__{}    set   6, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x80},{
__{}__{}    set   7, $1          ; 2:8       _TMP_INFO},
__{}{
__{}__{}    ld    A, __HEX_L($2)       ; 2:7       _TMP_INFO
__{}__{}    or    $1             ; 1:4       _TMP_INFO
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO})}){}dnl
dnl
dnl
dnl
define({__OR_REG16_16BIT},{dnl
dnl # Input
dnl #   $1 name reg pair
dnl #   $2 16bit value
__{}ifelse(__HEX_HL($2),0xFFFF,{
__{}    ld   $1, 0xFFFF     ; 3:10      _TMP_INFO},
__{}{dnl
__{}__{}__OR_REG8_8BIT(substr($1,1,1),__HEX_L($2)){}dnl
__{}__{}__OR_REG8_8BIT(substr($1,0,1),__HEX_H($2)){}dnl
})}){}dnl
dnl
dnl
dnl
define({__AND_REG8_8BIT},{dnl
dnl # Input
dnl #   $1 name reg
dnl #   $2 8bit value
__{}ifelse(__HEX_L($2),{0xFF},{},
__{}__HEX_L($2),{0x00},{
__{}__{}    ld    $1, 0x00       ; 2:7       _TMP_INFO},
__{}__HEX_L($2),{0x01},{
__{}__{}    res   0, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x02},{
__{}__{}    res   1, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x04},{
__{}__{}    res   2, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x08},{
__{}__{}    res   3, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x10},{
__{}__{}    res   4, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x20},{
__{}__{}    res   5, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x40},{
__{}__{}    res   6, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x80},{
__{}__{}    res   7, $1          ; 2:8       _TMP_INFO},
__{}{
__{}__{}    ld    A, __HEX_L($2)       ; 2:7       _TMP_INFO
__{}__{}    and   $1             ; 1:4       _TMP_INFO
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO})}){}dnl
dnl
dnl
dnl
define({__AND_REG16_16BIT},{dnl
dnl # Input
dnl #   $1 name reg pair
dnl #   $2 16bit value
__{}ifelse(__HEX_HL($2),{0x0000},{
__{}    ld   $1, 0x0000     ; 3:10      _TMP_INFO},
__{}{dnl
__{}__{}__AND_REG8_8BIT(substr($1,1,1),__HEX_L($2)){}dnl
__{}__{}__AND_REG8_8BIT(substr($1,0,1),__HEX_H($2)){}dnl
})}){}dnl
dnl
dnl
dnl
define({__LD4},{dnl
dnl $2->$1 && $3=$4
dnl # Input:
dnl #  __CLOCKS
dnl #  $1 Name of the target registry
dnl #  $2 Searched value that is needed
dnl #  $3 Source registry name
dnl #  $4 Source registry value
dnl # Output:
dnl #  __CLOCKS
dnl #  __BYTES
dnl #  __CODE
__{}ifelse(dnl
__{}$1,{},{dnl # no target register
__{}},
__{}$2,{},{dnl # no target value
__{}},
__{}$3,{},{dnl # no source register
__{}__{}ifelse(eval(__CLOCKS>7),{1},{dnl
__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    $1{{,}} $2       ; 2:7       {_TMP_INFO}})})},
__{}$4,{},{dnl # no source value
__{}__{}ifelse(eval(__CLOCKS>7),{1},{dnl
__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    $1{{,}} $2       ; 2:7       {_TMP_INFO}})})},
__{}$1,$3,{dnl # Identical register
__{}__{}ifelse($4,{},{dnl # empty value because 0xFF==__HEX_L({}-1) or 0x01==__HEX_L({}+1)
__{}__{}__{}ifelse(eval(__CLOCKS>7 && len($1)>0 && len($2)>0),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} $2       ; 2:7       {_TMP_INFO}})})},
__{}__{}$2,$4,{dnl # match found
__{}__{}__{}define({__CLOCKS},0){}dnl
__{}__{}__{}define({__BYTES},0){}dnl
__{}__{}__{}define({__CODE},{})},
__{}__{}$2,__HEX_L($4+1),{dnl
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    inc   $1             ; 1:4       {_TMP_INFO}})})},
__{}__{}$2,__HEX_L($4-1),{dnl
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    dec   $1             ; 1:4       {_TMP_INFO}})})},
__{}__{}{dnl # no match found
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} $2       ; 2:7       {_TMP_INFO}})})})},
__{}{dnl # different register
__{}__{}ifelse($2,$4,{dnl # match found
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} $3          ; 1:4       {_TMP_INFO}   $1 = $3 = $4})})},
__{}__{}{dnl # no match found
__{}__{}__{}ifelse(eval(__CLOCKS>7),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} $2       ; 2:7       {_TMP_INFO}})})}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__LD_REG8},{dnl
dnl $2->$1 from ($4,$6,$8,$10,$12,$14,$16,$18)
dnl
dnl # Input:
dnl #  _TMP_INFO
dnl #   $1  $2 Target registr name and value that is needed
dnl #   $3  $4 Source registry name and value
dnl #   $5  $6 Source registry name and value
dnl #   $7  $8 Source registry name and value
dnl #   $9 $10 Source registry name and value
dnl #  $11 $12 Source registry name and value
dnl #  $13 $14 Source registry name and value
dnl #  $15 $16 Source registry name and value
dnl #  $17 $18 Source registry name and value
dnl # Output:
dnl #  __CLOCKS
dnl #  __BYTES
dnl #  write best code "LD reg8, ...  ; bytes:clocks    _TMP_INFO"
dnl
__{}define({__CLOCKS},100000){}dnl
__{}__LD4($1,$2,$3,$4){}dnl
__{}__LD4($1,$2,$5,$6){}dnl
__{}__LD4($1,$2,$7,$8){}dnl
__{}__LD4($1,$2,$9,$10){}dnl
__{}__LD4($1,$2,$11,$12){}dnl
__{}__LD4($1,$2,$13,$14){}dnl
__{}__LD4($1,$2,$15,$16){}dnl
__{}__LD4($1,$2,$17,$18){}dnl
__{}__CODE{}dnl
}){}dnl
dnl
dnl
dnl
define({__LD_REG8_REG8},{dnl
dnl # Only accepts numeric values or an empty string. It does not specify pointers or variable names.
dnl # __ld_reg16_8bit_8bit:$1 $2 $3 $4 $5 $6 $7 $8
__{}define({__GARBAGE},__LD_REG8(substr($1,1,1),__HEX_L($2),substr($3,0,1),__HEX_H($4),substr($3,1,1),__HEX_L($4),substr($5,0,1),__HEX_H($6),substr($5,1,1),__HEX_L($6),substr($7,0,1),__HEX_H($8),substr($7,1,1),__HEX_L($8))){}dnl
__{}define({__CLOCKS_GARBAGE},__CLOCKS){}dnl
__{}define({__CODE_FIRST},__LD_REG8(substr($1,0,1),__HEX_H($2),substr($3,0,1),__HEX_H($4),substr($3,1,1),__HEX_L($4),substr($5,0,1),__HEX_H($6),substr($5,1,1),__HEX_L($6),substr($7,0,1),__HEX_H($8),substr($7,1,1),__HEX_L($8))){}dnl
__{}dnl
__{}ifelse(eval(__CLOCKS_GARBAGE>__CLOCKS),{1},{dnl
__{}__{}define({__CLOCKS_FIRST},__CLOCKS){}dnl
__{}__{}define({__BYTES_FIRST},__BYTES){}dnl
__{}__{}dnl # hi target value is entry now for lo target
__{}__{}define({__CODE_SECOND},__LD_REG8(substr($1,1,1),__HEX_L($2),substr($1,0,1),__HEX_H($2),ifelse($1,$3,,substr($3,0,1)),__HEX_H($4),substr($3,1,1),__HEX_L($4),ifelse($1,$5,,substr($5,0,1)),__HEX_H($6),substr($5,1,1),__HEX_L($6),ifelse($1,$7,,substr($7,0,1)),__HEX_H($8),substr($7,1,1),__HEX_L($8))){}dnl
__{}__{}define({__CLOCKS_SECOND},__CLOCKS){}dnl
__{}__{}define({__BYTES_SECOND},__BYTES){}dnl
__{}},{dnl
__{}__{}define({__CODE_FIRST},__LD_REG8(substr($1,1,1),__HEX_L($2),substr($3,0,1),__HEX_H($4),substr($3,1,1),__HEX_L($4),substr($5,0,1),__HEX_H($6),substr($5,1,1),__HEX_L($6),substr($7,0,1),__HEX_H($8),substr($7,1,1),__HEX_L($8))){}dnl
__{}__{}define({__CLOCKS_FIRST},__CLOCKS){}dnl
__{}__{}define({__BYTES_FIRST},__BYTES){}dnl
__{}__{}dnl # lo target value is entry now for hi target
__{}__{}define({__CODE_SECOND},__LD_REG8(substr($1,0,1),__HEX_H($2),substr($1,1,1),__HEX_L($2),substr($3,0,1),__HEX_H($4),ifelse($1,$3,,substr($3,1,1)),__HEX_L($4),substr($5,0,1),__HEX_H($6),ifelse($1,$5,,substr($5,1,1)),__HEX_L($6),substr($7,0,1),__HEX_H($8),ifelse($1,$7,,substr($7,1,1)),__HEX_L($8))){}dnl
__{}__{}define({__CLOCKS_SECOND},__CLOCKS){}dnl
__{}__{}define({__BYTES_SECOND},__BYTES){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
define({__LD_MEM16},{dnl
__{}ifelse($2,$4,{dnl
__{}__{}ifelse($1,$3,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},0){}dnl
__{}__{}__{}define({__BYTES_16BIT},0)},
__{}__{}{dnl
__{}__{}__{}define({__CLOCKS_16BIT},8){}dnl
__{}__{}__{}define({__BYTES_16BIT},2)
__{}__{}__{}    ld    substr($1,1,1){,} substr($3,1,1)          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    substr($1,0,1){,} substr($3,0,1)          ; 1:4       _TMP_INFO})},
__{}$1,{HL},{dnl
__{}__{}define({__CLOCKS_16BIT},16){}dnl
__{}__{}define({__BYTES_16BIT},3)
__{}__{}    ld   $1{,} format({%-11s},$2); 3:16      _TMP_INFO},
__{}{dnl
__{}__{}define({__CLOCKS_16BIT},20){}dnl
__{}__{}define({__BYTES_16BIT},4)
__{}__{}    ld   $1{,} format({%-11s},$2); 4:20      _TMP_INFO})}){}dnl
dnl
dnl
dnl
define({__LD_REG16},{dnl
dnl # __ld_reg16_16bit $1,$2,$3,$4,$5,$6,$7,$8
__{}undefine({__COMMA}){}dnl
ifelse(__IS_MEM_REF($2),{1},{dnl
__{}ifelse(dnl # memory reference
__{}$1{_}$2,$3{_}$4,{define({__CODE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$1{_}$2,$5{_}$6,{define({__CODE_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}$1{_}$2,$7{_}$8,{define({__CODE_16BIT},__LD_MEM16($1,$2,$7,$8))},
__{}$2,$4,{define({__CODE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$2,$6,{define({__CODE_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}$2,$8,{define({__CODE_16BIT},__LD_MEM16($1,$2,$7,$8))},
__{}{define({__CODE_16BIT},__LD_MEM16($1,$2,,))})},
$2,{},{dnl
__{}__{}define({__CLOCKS_16BIT},0){}dnl
__{}__{}define({__BYTES_16BIT},0){}dnl
__{}__{}define({__CODE_16BIT},{})},
__IS_NUM($2),{0},{dnl # unknown number
__{}ifelse(dnl
__{}$1{_}$2,$3{_}$4,{define({__CODE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$1{_}$2,$5{_}$6,{define({__CODE_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}$1{_}$2,$7{_}$8,{define({__CODE_16BIT},__LD_MEM16($1,$2,$7,$8))},
__{}$2,$4,{define({__CODE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$2,$6,{define({__CODE_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}$2,$8,{define({__CODE_16BIT},__LD_MEM16($1,$2,$7,$8))},
__{}{dnl
__{}__{}define({__CLOCKS_16BIT},10){}dnl
__{}__{}define({__BYTES_16BIT},3){}dnl
__{}__{}define({__CODE_16BIT},{
__{}__{}    ld   $1{,} format({%-11s},$2); 3:10      }_TMP_INFO)})},{dnl
dnl # Use: __LD_REG16({HL},0x2200,{DE},1,{BC},0x3322,{HL},-1)
dnl # Input:
dnl # _TMP_INFO
dnl #  $1 Name of target register pair
dnl #  $2 Searched 16-bit value that is needed
dnl
dnl #  $3 Source registry name
dnl #  $4 Source registry 16-bit value
dnl #  $5 Source registry name
dnl #  $6 Source registry 16-bit value
dnl #  $7 Source registry name
dnl #  $8 Source registry 16-bit value
dnl
dnl # Output:
dnl # __CLOCKS_16BIT
dnl # __BYTES_16BIT
dnl # __CODE_16BIT
dnl # __PRICE_16BIT = __CLOCKS_16BIT+4*__BYTES_16BIT
dnl
__{}__LD_REG8_REG8($1,$2,ifelse(__IS_NUM($4),{1},$3{,}$4{,}){}ifelse(__IS_NUM($6),{1},$5{,}$6{,}){}ifelse(__IS_NUM($8),{1},$7{,}$8)){}dnl
__{}define({__CLOCKS_16BIT},eval(__CLOCKS_FIRST+__CLOCKS_SECOND)){}dnl
__{}define({__BYTES_16BIT},eval(__BYTES_FIRST+__BYTES_SECOND)){}dnl
__{}define({__CODE_16BIT},__CODE_FIRST{}__CODE_SECOND){}dnl
__{}dnl
__{}ifelse($1,$3,{define({__LD_REG16_ORIG},$4)},
__{}$1,$5,{define({__LD_REG16_ORIG},$6)},
__{}$1,$7,{define({__LD_REG16_ORIG},$8)},
__{}{define({__LD_REG16_ORIG},{})}){}dnl
__{}ifelse(__IS_NUM(__LD_REG16_ORIG),{0},{define({__LD_REG16_ORIG},{})}){}dnl
__{}dnl
__{}ifelse(__LD_REG16_ORIG,{},,{dnl
__{}__{}__LD_REG8_REG8($1,$2,ifelse(__IS_NUM($4),{1},$3{,}ifelse($1,$3,$4+1,$4){,}){}ifelse(__IS_NUM($6),{1},$5{,}ifelse($1,$5,$6+1,$6){,}){}ifelse(__IS_NUM($8),{1},$7{,}ifelse($1,$7,$8+1,$8){,})){}dnl
__{}__{}ifelse(eval(__CLOCKS_16BIT>(6+__CLOCKS_FIRST+__CLOCKS_SECOND)),{1},{dnl
__{}__{}__{}define({__CLOCKS_16BIT},eval(6+__CLOCKS_FIRST+__CLOCKS_SECOND)){}dnl
__{}__{}__{}define({__BYTES_16BIT},eval(1+__BYTES_FIRST+__BYTES_SECOND)){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    inc  $1             ; 1:6       }_TMP_INFO{}__CODE_FIRST{}__CODE_SECOND){}dnl # before ++16bit
__{}__{}}){}dnl
__{}__{}__LD_REG8_REG8($1,$2,ifelse(__IS_NUM($4),{1},$3{,}ifelse($1,$3,$4-1,$4){,}){}ifelse(__IS_NUM($6),{1},$5{,}ifelse($1,$5,$6-1,$6){,}){}ifelse(__IS_NUM($8),{1},$7{,}ifelse($1,$7,$8-1,$8){,})){}dnl
__{}__{}ifelse(eval(__CLOCKS_16BIT>(6+__CLOCKS_FIRST+__CLOCKS_SECOND)),{1},{dnl
__{}__{}__{}define({__CLOCKS_16BIT},eval(6+__CLOCKS_FIRST+__CLOCKS_SECOND)){}dnl
__{}__{}__{}define({__BYTES_16BIT},eval(1+__BYTES_FIRST+__BYTES_SECOND)){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    dec  $1             ; 1:6       }_TMP_INFO{}__CODE_FIRST{}__CODE_SECOND){}dnl # before --16bit
__{}__{}}){}dnl
__{}__{}__LD_REG8_REG8($1,$2-1,ifelse(__IS_NUM($4),{1},$3{,}$4{,}){}ifelse(__IS_NUM($6),{1},$5{,}$6{,}){}ifelse(__IS_NUM($8),{1},$7{,}$8)){}dnl
__{}__{}ifelse(eval(__CLOCKS_16BIT>(6+__CLOCKS_FIRST+__CLOCKS_SECOND)),{1},{dnl
__{}__{}__{}define({__CLOCKS_16BIT},eval(6+__CLOCKS_FIRST+__CLOCKS_SECOND)){}dnl
__{}__{}__{}define({__BYTES_16BIT},eval(1+__BYTES_FIRST+__BYTES_SECOND)){}dnl
__{}__{}__{}define({__CODE_16BIT},__CODE_FIRST{}__CODE_SECOND{
__{}__{}__{}    inc  $1             ; 1:6       }_TMP_INFO{   $2 = __HEX_HL($2-1)+1}){}dnl # after 16bit++
__{}__{}}){}dnl
__{}__{}__LD_REG8_REG8($1,$2+1,ifelse(__IS_NUM($4),{1},$3{,}$4{,}){}ifelse(__IS_NUM($6),{1},$5{,}$6{,}){}ifelse(__IS_NUM($8),{1},$7{,}$8)){}dnl
__{}__{}ifelse(eval(__CLOCKS_16BIT>(6+__CLOCKS_FIRST+__CLOCKS_SECOND)),{1},{dnl
__{}__{}__{}define({__CLOCKS_16BIT},eval(6+__CLOCKS_FIRST+__CLOCKS_SECOND)){}dnl
__{}__{}__{}define({__BYTES_16BIT},eval(1+__BYTES_FIRST+__BYTES_SECOND)){}dnl
__{}__{}__{}define({__CODE_16BIT},__CODE_FIRST{}__CODE_SECOND{
__{}__{}__{}    dec  $1             ; 1:6       }_TMP_INFO{   $2 = __HEX_HL($2+1)-1}){}dnl # after 16bit--
__{}__{}}){}dnl
__{}}){}dnl
__{}ifelse(eval(((__CLOCKS_16BIT+4*__BYTES_16BIT)>15)&&ifelse(__LD_REG16_ORIG,{},{0},{1})&&ifelse($1,{HL},{1},{0})),{1},{dnl
__{}__{}ifelse(__IS_NUM($4),{1},{ifelse(__HEX_HL($2),__HEX_HL(__LD_REG16_ORIG+$4),{dnl
__{}__{}__{}__{}define({__CLOCKS_16BIT},11){}dnl
__{}__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}__{}    add  $1, $3         ; 1:11      _TMP_INFO   $2 = __LD_REG16_ORIG+$4})})}){}dnl
__{}__{}ifelse(__IS_NUM($6),{1},{ifelse(__HEX_HL($2),__HEX_HL(__LD_REG16_ORIG+$6),{dnl
__{}__{}__{}__{}define({__CLOCKS_16BIT},11){}dnl
__{}__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}__{}    add  $1, $5         ; 1:11      _TMP_INFO   $2 = __LD_REG16_ORIG+$6})})}){}dnl
__{}__{}ifelse(__IS_NUM($8),{1},{ifelse(__HEX_HL($2),__HEX_HL(__LD_REG16_ORIG+$8),{dnl
__{}__{}__{}__{}define({__CLOCKS_16BIT},11){}dnl
__{}__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}__{}    add  $1, $7         ; 1:11      _TMP_INFO   $2 = __LD_REG16_ORIG+$8})})}){}dnl
__{}}){}dnl
__{}ifelse(eval((__CLOCKS_16BIT+4*__BYTES_16BIT)>22),{1},{dnl
__{}__{}define({__CLOCKS_16BIT},10){}dnl
__{}__{}define({__BYTES_16BIT},3){}dnl
__{}__{}define({__CODE_16BIT},{
__{}__{}    ld   $1{,} __HEX_HL($2)     ; 3:10      }_TMP_INFO)}){}dnl
__{}}){}dnl
__{}define({__PRICE_16BIT},eval(__CLOCKS_16BIT+4*__BYTES_16BIT)){}dnl
}){}dnl
dnl
dnl
dnl
define({__LD_REG16_BEFORE_AFTER},{dnl
__{}undefine({__COMMA}){}dnl
ifelse(__IS_MEM_REF($2),{1},{dnl
__{}define({__CODE_BEFORE_16BIT},{}){}dnl
__{}define({__CODE_AFTER_16BIT},{}){}dnl
__{}ifelse(dnl # memory reference
__{}$1{_}$2,$3{_}$4,{define({__CODE_BEFORE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$1{_}$2,$5{_}$6,{define({__CODE_AFTER_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}$2,$4,{define({__CODE_BEFORE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$2,$6,{define({__CODE_AFTER_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}{define({__CODE_AFTER_16BIT},__LD_MEM16($1,$2,,))})},
$2,{},{dnl
__{}define({__CLOCKS_16BIT},0){}dnl
__{}define({__BYTES_16BIT},0){}dnl
__{}define({__CODE_BEFORE_16BIT},{}){}dnl
__{}define({__CODE_AFTER_16BIT},{})},
__IS_NUM($2),{0},{dnl # unknown number
__{}define({__CODE_BEFORE_16BIT},{}){}dnl
__{}define({__CODE_AFTER_16BIT},{}){}dnl
__{}ifelse(dnl
__{}$1{_}$2,$3{_}$4,{define({__CODE_BEFORE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$1{_}$2,$5{_}$6,{define({__CODE_AFTER_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}$2,$4,{define({__CODE_BEFORE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$2,$6,{define({__CODE_AFTER_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}{dnl
__{}__{}define({__CLOCKS_16BIT},10){}dnl
__{}__{}define({__BYTES_16BIT},3){}dnl
__{}__{}define({__CODE_BEFORE_16BIT},{
__{}__{}    ld   $1{,} format({%-11s},$2); 3:10      }_TMP_INFO)})},{dnl
dnl # Input:
dnl # _TMP_INFO
dnl #  $1 Name of target register pair
dnl #  $2 Searched 16-bit value that is needed
dnl
dnl #  $3 Source registry name
dnl #  $4 Source registry 16-bit value before
dnl #  $5 Source registry name
dnl #  $6 Source registry 16-bit value after
dnl
dnl # Output:
dnl # __CLOCKS_16BIT
dnl # __BYTES_16BIT
dnl # __CODE_BEFORE_16BIT
dnl # __CODE_AFTER_16BIT
dnl # __PRICE_16BIT = __CLOCKS_16BIT+4*__BYTES_16BIT
dnl
__{}define({__CODE_BEFORE_HI},__LD_REG8(substr($1,0,1),__HEX_H($2),ifelse(__IS_NUM($4),{1},substr($3,0,1){,}__HEX_H($4){,}substr($3,1,1){,}__HEX_L($4)))){}dnl
__{}define({__CLOCKS_BEFORE_HI},__CLOCKS){}dnl
__{}define({__BYTES_BEFORE_HI},__BYTES){}dnl
__{}define({__CODE_BEFORE_LO},__LD_REG8(substr($1,1,1),__HEX_L($2),ifelse(__IS_NUM($4),{1},substr($3,0,1){,}__HEX_H($4){,}substr($3,1,1){,}__HEX_L($4)))){}dnl
__{}define({__CLOCKS_BEFORE_LO},__CLOCKS){}dnl
__{}define({__BYTES_BEFORE_LO},__BYTES){}dnl
__{}define({__CODE_AFTER_HI},__LD_REG8(substr($1,0,1),__HEX_H($2),ifelse(__IS_NUM($6),{1},substr($5,0,1){,}__HEX_H($6){,}substr($5,1,1){,}__HEX_L($6)))){}dnl
__{}define({__CLOCKS_AFTER_HI},__CLOCKS){}dnl
__{}define({__BYTES_AFTER_HI},__BYTES){}dnl
__{}define({__CODE_AFTER_LO},__LD_REG8(substr($1,1,1),__HEX_L($2),ifelse(__IS_NUM($6),{1},substr($5,0,1){,}__HEX_H($6){,}substr($5,1,1){,}__HEX_L($6)))){}dnl
__{}define({__CLOCKS_AFTER_LO},__CLOCKS){}dnl
__{}define({__BYTES_AFTER_LO},__BYTES){}dnl
__{}ifelse(eval((__CLOCKS_BEFORE_HI<__CLOCKS_AFTER_HI) && (__CLOCKS_BEFORE_LO<__CLOCKS_AFTER_LO)),{1},{dnl
__{}__{}define({__CLOCKS_16BIT},eval(__CLOCKS_BEFORE_HI+__CLOCKS_BEFORE_LO)){}dnl
__{}__{}define({__BYTES_16BIT},eval(__BYTES_BEFORE_HI+__BYTES_BEFORE_LO)){}dnl
__{}__{}define({__CODE_BEFORE_16BIT},{__CODE_BEFORE_HI{}__CODE_BEFORE_LO}){}dnl
__{}__{}define({__CODE_AFTER_16BIT},{})},
__{}eval((__CLOCKS_BEFORE_HI<__CLOCKS_AFTER_HI) && (__CLOCKS_BEFORE_LO>=__CLOCKS_AFTER_LO)),{1},{dnl
__{}__{}define({__CLOCKS_16BIT},eval(__CLOCKS_BEFORE_HI+__CLOCKS_AFTER_LO)){}dnl
__{}__{}define({__BYTES_16BIT},eval(__BYTES_BEFORE_HI+__BYTES_AFTER_LO)){}dnl
__{}__{}define({__CODE_BEFORE_16BIT},{__CODE_BEFORE_HI}){}dnl
__{}__{}define({__CODE_AFTER_16BIT},{__CODE_AFTER_LO})},
__{}eval((__CLOCKS_BEFORE_HI>=__CLOCKS_AFTER_HI) && (__CLOCKS_BEFORE_LO>=__CLOCKS_AFTER_LO)),{1},{dnl
__{}__{}define({__CLOCKS_16BIT},eval(__CLOCKS_AFTER_HI+__CLOCKS_AFTER_LO)){}dnl
__{}__{}define({__BYTES_16BIT},eval(__BYTES_AFTER_HI+__BYTES_AFTER_LO)){}dnl
__{}__{}define({__CODE_BEFORE_16BIT},{}){}dnl
__{}__{}define({__CODE_AFTER_16BIT},{__CODE_AFTER_HI{}__CODE_AFTER_LO})},
__{}eval((__CLOCKS_BEFORE_HI>=__CLOCKS_AFTER_HI) && (__CLOCKS_BEFORE_LO<__CLOCKS_AFTER_LO)),{1},{dnl
__{}__{}define({__CLOCKS_16BIT},eval(__CLOCKS_AFTER_HI+__CLOCKS_BEFORE_LO)){}dnl
__{}__{}define({__BYTES_16BIT},eval(__BYTES_AFTER_HI+__BYTES_BEFORE_LO)){}dnl
__{}__{}define({__CODE_BEFORE_16BIT},__CODE_BEFORE_LO){}dnl
__{}__{}define({__CODE_AFTER_16BIT},__CODE_AFTER_HI)}){}dnl
__{}ifelse(eval(__CLOCKS_16BIT>10),{1},{dnl
__{}__{}define({__CLOCKS_16BIT},10){}dnl
__{}__{}define({__BYTES_16BIT},3){}dnl
__{}__{}define({__CODE_BEFORE_16BIT},{}){}dnl
__{}__{}define({__CODE_AFTER_16BIT},{
__{}__{}    ld   $1{,} __HEX_HL($2)     ; 3:10      _TMP_INFO})}){}dnl
__{}}){}dnl
__{}define({__PRICE_16BIT},eval(__CLOCKS_16BIT+4*__BYTES_16BIT)){}dnl
}){}dnl
dnl
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
__{}__{}    xor   __HEX_L(__N4)          ; 2:7       _TMP_INFO   x[4] = __HEX_L(__N4)  termination of identical values})},
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
__{}dnl c/2 c - -
__{}dnl
__{}eval(__N4==(__N3/2)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = x[3]/2})},
__{}dnl
__{}dnl   default version
__{}{dnl
__{}__{}define({_TMP_B4},5){}dnl
__{}__{}define({_TMP_T4},18){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __HEX_L(__N4)       ; 2:7       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = __HEX_L(__N4)})}){}dnl
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
__{}__{}    xor   __HEX_L(__N3 ^ 0xFF)          ; 2:7       _TMP_INFO   x[3] = __HEX_L(__N3) = 0xFF ^ __HEX_L(__N3 ^ 0xFF)  termination of identical values})},
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
__{}__{}    xor   __HEX_L(__N3 ^ 0xFF)          ; 2:7       _TMP_INFO   x[3] = __HEX_L(__N3) = 0xFF ^ __HEX_L(__N3 ^ 0xFF)})},
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
__{}__{}    _TMP_OR3  __HEX_L(__N3)           ; 2:7       _TMP_INFO   x[3] = __HEX_L(__N3)  termination of identical values})},
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
__{}dnl - b/2 b -
__{}dnl
__{}eval(__N3==(__N2/2)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = x[2]/2})},
__{}dnl
__{}dnl  default version
__{}{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+5)){}dnl
__{}__{}define({_TMP_T3},18){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __HEX_L(__N3)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = __HEX_L(__N3)})}){}dnl
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
__{}__{}    xor   __HEX_L(__N2 ^    0xFF)          ; 2:7       _TMP_INFO   x[2] = __HEX_L(__N2) = 0xFF ^ __HEX_L(__N2 ^ 0xFF)      termination of identical values})},
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
__{}__{}    xor   __HEX_L(__N2 ^    0xFF)          ; 2:7       _TMP_INFO   x[2] = __HEX_L(__N2) = 0xFF ^ __HEX_L(__N2 ^ 0xFF)})},
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
__{}__{}    _TMP_OR2   __HEX_L(__N2)          ; 2:7       _TMP_INFO   x[2] = __HEX_L(__N2)  termination of identical values})},
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
__{}dnl - - a/2 a
__{}dnl
__{}eval(__N2==(__N1/2)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   __R2             ; 1:4       _TMP_INFO   x[2] = x[1]/2})},
__{}dnl
__{}dnl - - - -     default version
__{}{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+5)){}dnl
__{}__{}define({_TMP_T2},18){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __HEX_L(__N2)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR2   __R2             ; 1:4       _TMP_INFO   x[2] = __HEX_L(__N2)})}){}dnl
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
__{}__{}    xor   __HEX_L(__N1 ^ 0xFF)          ; 2:7       _TMP_INFO   x[1] = __HEX_L(__N1) = 0xFF ^ __HEX_L(__N1 ^ 0xFF)})},
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
__{}__{}    ld    A{,} __HEX_L(__N1)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR1   __R1             ; 1:4       _TMP_INFO   x[1] = __HEX_L(__N1)})}){}dnl
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
__{}dnl __HEX_L(_TMP_N4)-__HEX_L(_TMP_N3)-__HEX_L(_TMP_N2)-__HEX_L(_TMP_N1)
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
__{}dnl __HEX_L(_TMP_N4)-__HEX_L(_TMP_N3)-__HEX_L(_TMP_N2)-__HEX_L(_TMP_N1)
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
define({__EQ_MAKE_CODE},{dnl
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}dnl
__{}dnl --------------- 2 ---------------
__{}dnl
__{}define({_TMP_OR1},{cp }){}dnl
__{}ifelse(__N2,0,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},1){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},4){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE_2},{
__{}__{}    or    __R2             ; 1:4       _TMP_INFO   x[2] = 0})},
__{}__N2{-}__N1,{2-1},{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},3){}dnl
__{}__{}__{}define({_TMP_T2},11){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[2] = 2})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},14){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[2] = 2})})},
__{}__N2,{255},{dnl
__{}__{}define({_TMP_B2},2){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},8){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE_2},{
__{}__{}    and   __R2             ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[2] = 0xFF})},
__{}__N2{-}__N1,{1-1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},12){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE_2},{
__{}__{}    ld    C{{,}} __R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}__N2,{1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},12){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE_2},{
__{}__{}    ld    C{{,}} __R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}__N2,__N1,{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},14){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    xor   __HEX_L(__N2)          ; 2:7       _TMP_INFO   x[2] = __HEX_L(__N2)})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},17){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    xor   __HEX_L(__N2)          ; 2:7       _TMP_INFO   x[2] = __HEX_L(__N2)})})},
__{}eval(__N2==(__N1+1 & 0xFF)),{1},{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + 1})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + 1})})},
__{}eval(__N2==(__N1-1 & 0xFF)),{1},{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] - 1})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] - 1})})},
__{}eval(__N2==(__N1+__N1 & 0xFF)),{1},{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    add   A{{,}} __R1          ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + x[1]})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    add   A{{,}} __R1          ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1] + x[1]})})},
__{}eval(__N2==(__N1/2)),{1},{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1]/2})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = x[1]/2})})},
__{}{dnl
__{}__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval(_TMP_B0+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld    A{{,}} __HEX_L(__N2)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = __HEX_L(__N2)})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},6){}dnl
__{}__{}__{}define({_TMP_T2},21){}dnl
__{}__{}__{}define({_TMP_J1},eval(10-$3)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}__{}    ld    A{{,}} __HEX_L(__N2)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   __R2             ; 1:4       _TMP_INFO   x[2] = __HEX_L(__N2)})})}){}dnl
__{}dnl
__{}dnl --------------- 1 ---------------
__{}dnl
__{}ifelse(__N1,0,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO   x[1] = 0})},
__{}__N2{-}__N1,{255-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO   x[1] = 0xFF})},
__{}__N2{-}__N1,{255-254},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = x[2] - 1})},
__{}__N2,{255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    xor   __HEX_L(__N1 ^ 0xFF)          ; 2:7       _TMP_INFO   x[1] = 0xFF ^ __HEX_L(__N1 ^ 0xFF)})},
__{}__N2{-}__N1,{0-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = 0xFF})},
__{}__N2{-}__N1,{2-1},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},12){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __R2          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    cp    __R1             ; 1:4       _TMP_INFO   x[1] = x[2] - 1})},
__{}__N1,{1},{dnl    255-1 --> 255-x rule priority!
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[1] = 1})},
__{}__N2,__N1,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __R1          ; 1:4       _TMP_INFO
__{}__{}    cp    __R2             ; 1:4       _TMP_INFO   x[1] = x[2]})},
__{}{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __HEX_L(__N1)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR1   __R1             ; 1:4       _TMP_INFO   x[1] = __HEX_L(__N1)})}){}dnl
__{}dnl
__{}dnl ---------------------------------
__{}dnl
__{}define({_TMP_J1},eval(_TMP_J1+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({_TMP_J2},eval(_TMP_T2+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J2)){}dnl
__{}define({__EQ_CLOCKS_FAIL},eval(_TMP_J1+_TMP_J2)){}dnl
__{}define({__EQ_PRICE},eval(8*__EQ_CLOCKS_TRUE+4*__EQ_CLOCKS_FAIL)){}dnl
__{}define({__EQ_CLOCKS_FAIL},eval((1+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}define({__EQ_CLOCKS},eval((8+__EQ_PRICE)/16)){}dnl
__{}define({__EQ_BYTES},eval(_TMP_B1+ifelse($2,{},{0},{$2}))){}dnl
__{}define({__EQ_PRICE},eval(__EQ_PRICE+(64*__EQ_BYTES)+ifelse(__R1,{L},{0},{1}))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}define({__EQ_CODE},format({%39s},;[eval(__EQ_BYTES):__EQ_CLOCKS_TRUE/_TMP_J1{{{,}}}_TMP_J2]){_TMP_STACK_INFO{}__EQ_CODE_1{}__EQ_CODE_2}){}dnl
__{}dnl
__{}dnl debug:__EQ_CODE
}){}dnl
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
dnl #   _TMP_BEST_P       price = 16*(clocks + 4*bytes)
dnl #   _TMP_BEST_B       bytes
dnl #   _TMP_BEST_C       clocks
dnl #   _TMP_BEST_CODE    asm code
dnl #   zero flag if const == DEHL
dnl #   A = 0 if const == HL, because the "cp" instruction can be the last instruction only with a non-zero result.
dnl
define({__EQ_MAKE_BEST_CODE},{ifelse(__IS_MEM_REF($1),{1},{dnl
__{}dnl ---------------------------------
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}ifelse(_TYP_SINGLE,{small},{dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld   BC{,} format({%-11s},$1); 4:20      _TMP_INFO
__{}__{}    xor   A             ; 1:4       _TMP_INFO   cp HL{,} BC
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   cp HL{,} BC
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   cp HL{,} BC}){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(50+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},__EQ_CLOCKS_TRUE){}dnl
__{}__{}define({_TMP_BEST_C},__EQ_CLOCKS_TRUE){}dnl
__{}__{}define({_TMP_BEST_B},eval(8+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({_TMP_BEST_P},eval(16*_TMP_BEST_C+64*_TMP_BEST_B)){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},{                        ;}format({%-10s},[eval(_TMP_BEST_B):_TMP_BEST_C]){_TMP_STACK_INFO{}__EQ_CODE_1})},
__{}regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}define({_TMP_B1},10){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} format({%-11s},$1); 3:13      _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jr   nz{,} $+format({%-9s},eval(6+_TMP_B0)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({_TMP_J1},eval(29+ifelse($3,{},{0},{$3})+_TMP_J0)){}dnl
__{}__{}define({_TMP_J2},eval(41+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J1+_TMP_J2)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},_TMP_J2){}dnl
__{}__{}define({_TMP_BEST_P},eval(4*__EQ_CLOCKS_TRUE+8*__EQ_CLOCKS_FAIL)){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval((1+__EQ_CLOCKS_TRUE)/2)){}dnl
__{}__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}__{}define({_TMP_BEST_B},eval(10+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},format({%37s},;[eval(_TMP_BEST_B):_TMP_J1{{,}}_TMP_J2/__EQ_CLOCKS_FAIL]){_TMP_STACK_INFO{}__EQ_CODE_1})},
__{}{dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} format({%-11s},$1); 3:13      _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jp   nz{,} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({_TMP_J1},eval(27)){}dnl
__{}__{}define({_TMP_J2},eval(44+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},_TMP_J2){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval(_TMP_J1+_TMP_J2)){}dnl
__{}__{}define({_TMP_BEST_P},eval(8*__EQ_CLOCKS_TRUE+4*__EQ_CLOCKS_FAIL)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval((1+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}__{}define({_TMP_BEST_B},eval(11+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},format({%37s},;[eval(_TMP_BEST_B):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2]){_TMP_STACK_INFO{}__EQ_CODE_1})})},
__IS_NUM($1),{0},{dnl
__{}dnl ---------------------------------
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}ifelse(_TYP_SINGLE,{small},{dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld   BC{,} format({%-11s},$1); 3:10      _TMP_INFO
__{}__{}    xor   A             ; 1:4       _TMP_INFO   cp HL{,} BC
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   cp HL{,} BC
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   cp HL{,} BC}){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(40+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},__EQ_CLOCKS_TRUE){}dnl
__{}__{}define({_TMP_BEST_C},__EQ_CLOCKS_TRUE){}dnl
__{}__{}define({_TMP_BEST_B},eval(7+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({_TMP_BEST_P},eval(16*_TMP_BEST_C+64*_TMP_BEST_B)){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},{
__{}__{}__{}  .warning {$0}($@): M4 does not know the "$1" value and therefore cannot optimize the code.
__{}__{}__{}                        ;format({%-10s},[eval(_TMP_BEST_B):_TMP_BEST_C])_TMP_STACK_INFO{}__EQ_CODE_1})},
__{}regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}define({_TMP_B1},10){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} low format({%-7s},$1); 2:7       _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jr   nz{,} $+format({%-9s},eval(5+_TMP_B0)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} high format({%-6s},$1); 2:7       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({_TMP_J1},eval(23+ifelse($3,{},{0},{$3})+_TMP_J0)){}dnl
__{}__{}define({_TMP_J2},eval(29+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},_TMP_J2){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval(_TMP_J1+_TMP_J2)){}dnl
__{}__{}define({_TMP_BEST_P},eval(8*__EQ_CLOCKS_TRUE+4*__EQ_CLOCKS_FAIL)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval((1+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}__{}define({_TMP_BEST_B},eval(8+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},{
__{}__{}__{}  .warning {$0}($@): M4 does not know the "$1" value and therefore cannot optimize the code.
__{}__{}__{}format({%37s},;[eval(_TMP_BEST_B):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2])_TMP_STACK_INFO{}__EQ_CODE_1})},
__{}{dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} low format({%-7s},$1); 2:7       _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jp   nz{,} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}    ld    A{,} high format({%-6s},$1); 2:7       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({_TMP_J1},eval(21)){}dnl
__{}__{}define({_TMP_J2},eval(32+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},_TMP_J2){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval(_TMP_J1+_TMP_J2)){}dnl
__{}__{}define({_TMP_BEST_P},eval(8*__EQ_CLOCKS_TRUE+4*__EQ_CLOCKS_FAIL)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval((1+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}__{}define({_TMP_BEST_B},eval(9+ifelse($2,{},{0},{$2}))){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},{
__{}__{}__{}  .warning {$0}($@): M4 does not know the "$1" value and therefore cannot optimize the code.
__{}__{}__{}format({%37s},;[eval(_TMP_BEST_B):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2])_TMP_STACK_INFO{}__EQ_CODE_1})})},
_TYP_SINGLE,{L_first},{dnl
dnl # Input parameters:
dnl #   $1 = 16 bit number
dnl #   $2 = +-bytes no jump
dnl #   $3 = +-clocks no jump
dnl #   $4 = +-bytes jump
dnl #   $5 = +-clocks jump
dnl #   _TMP_INFO = info
dnl #   _TMP_STACK_INFO = stack info
__{}dnl ---------------------------------
__{}ifelse($4,{},{define({_TMP_B0},0)},{define({_TMP_B0},$4)}){}dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}ifelse(__HEX_L($1),{0x00},{dnl
__{}__{}define({_TMP_A1},{0x00}){}dnl
__{}__{}define({_TMP_B1},2){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    or    A             ; 1:4       _TMP_INFO   L = 0x00})},
__{}__HEX_L($1),{0x01},{dnl
__{}__{}define({_TMP_A1},{0x00}){}dnl
__{}__{}define({_TMP_B1},2){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO   L = 0x01})},
__{}__HEX_L($1),{0xFF},{dnl
__{}__{}define({_TMP_A1},{0x00}){}dnl
__{}__{}define({_TMP_B1},2){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   L = 0xFF})},
__{}eval(__HEX_H($1+1)<3),{1},{dnl
__{}__{}define({_TMP_A1},{0x00}){}dnl
__{}__{}define({_TMP_B1},3){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} _TMP_A1       ; 2:7       _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO   L = _TMP_A1})},
__{}{dnl
__{}__{}define({_TMP_A1},__HEX_L($1)){}dnl
__{}__{}define({_TMP_B1},3){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} _TMP_A1       ; 2:7       _TMP_INFO
__{}__{}    cp    L             ; 1:4       _TMP_INFO   L = _TMP_A1})}){}dnl
__{}dnl
__{}ifelse(__HEX_H($1),_TMP_A1,{dnl
__{}__{}define({_TMP_B3},1){}dnl
__{}__{}define({_TMP_T3},4){}dnl
__{}__{}define({__EQ_CODE_3},{
__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = __HEX_H($1)})},
__{}__HEX_H($1),__HEX_L(_TMP_A1-1),{dnl
__{}__{}define({_TMP_B3},2){}dnl
__{}__{}define({_TMP_T3},8){}dnl
__{}__{}define({__EQ_CODE_3},{
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = __HEX_H($1)})},
__{}__HEX_H($1),__HEX_L(_TMP_A1+1),{dnl
__{}__{}define({_TMP_B3},2){}dnl
__{}__{}define({_TMP_T3},8){}dnl
__{}__{}define({__EQ_CODE_3},{
__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = __HEX_H($1)})},
__{}__HEX_H($1),__HEX_L(2*_TMP_A1),{dnl
__{}__{}define({_TMP_B3},2){}dnl
__{}__{}define({_TMP_T3},8){}dnl
__{}__{}define({__EQ_CODE_3},{
__{}__{}    add   A, A          ; 1:4       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = __HEX_H($1)})},
__{}__HEX_H($1),__HEX_L(_TMP_A1>>1),{dnl
__{}__{}define({_TMP_B3},2){}dnl
__{}__{}define({_TMP_T3},8){}dnl
__{}__{}define({__EQ_CODE_3},{
__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = __HEX_H($1)})},
__{}{dnl
__{}__{}define({_TMP_B3},3){}dnl
__{}__{}define({_TMP_T3},11){}dnl
__{}__{}define({__EQ_CODE_3},{
__{}__{}    ld    A{,} __HEX_H($1)       ; 2:7       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = __HEX_H($1)})}){}dnl
__{}dnl
__{}ifelse(regexp({$4},{^[a-zA-Z_]}),{-1},{dnl
__{}__{}define({_TMP_B2},2){}dnl
__{}__{}define({_TMP_T2},7){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0+_TMP_T1+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval(_TMP_B0+_TMP_B2+_TMP_B3)); 2:7/12    _TMP_INFO})},
__{}{dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},10){}dnl
__{}__{}define({_TMP_J1},eval(10+_TMP_T1)){}dnl
__{}__{}define({__EQ_CODE_2},{
__{}__{}    jp   nz{,} format({%-11s},_TMP_B0); 3:10      _TMP_INFO})}){}dnl
__{}dnl
__{}ifelse(__HEX_HL($1),0x0000,{dnl
__{}__{}define({_TMP_B1},2){}dnl
__{}__{}define({_TMP_B2},0){}dnl
__{}__{}define({_TMP_B3},0){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({_TMP_T2},0){}dnl
__{}__{}define({_TMP_T3},0){}dnl
__{}__{}define({_TMP_J1},eval(8+ifelse($3,{},{0},{$3}))){}dnl
__{}__{}define({__EQ_CODE_3},{}){}dnl
__{}__{}define({__EQ_CODE_2},{}){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    or    H             ; 1:4       _TMP_INFO   L = H = 0x00})}){}dnl
__{}dnl
__{}dnl ---------------------------------
__{}dnl
__{}define({_TMP_J2},eval(_TMP_T1+_TMP_T2+_TMP_T3+ifelse($3,{},{0},{$3}))){}dnl
__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J2)){}dnl
__{}define({__EQ_CLOCKS_FAIL},eval(_TMP_J1+_TMP_J2)){}dnl
__{}define({_TMP_BEST_P},eval(8*__EQ_CLOCKS_TRUE+4*__EQ_CLOCKS_FAIL)){}dnl
__{}define({__EQ_CLOCKS_FAIL},eval((1+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}define({_TMP_BEST_B},eval(_TMP_B1+_TMP_B2+_TMP_B3+ifelse($2,{},{0},{$2}))){}dnl
__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes)
__{}define({_TMP_BEST_CODE},format({%39s},;[eval(_TMP_BEST_B):__EQ_CLOCKS_TRUE/_TMP_J1{{{,}}}_TMP_J2]){_TMP_STACK_INFO   L_first variant{}__EQ_CODE_1{}__EQ_CODE_2{}__EQ_CODE_3})},
{dnl
__{}define({__R1},{L}){}dnl
__{}define({__R2},{H}){}dnl
__{}define({__N1},eval(($1) & 0xFF)){}dnl
__{}define({__N2},eval((($1)>>8) & 0xFF)){}dnl
__{}ifelse(__N1,{0},{dnl
__{}__{}__SWAP2DEF({__N1},{__N2}){}dnl
__{}__{}__SWAP2DEF({__R1},{__R2})}){}dnl
__{}__EQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}define({_TMP_BEST_P},__EQ_PRICE){}dnl
__{}define({_TMP_BEST_B},__EQ_BYTES){}dnl
__{}define({_TMP_BEST_C},__EQ_CLOCKS){}dnl
__{}define({_TMP_BEST_CODE},__EQ_CODE){}dnl
__{}ifelse(eval(__N2>0),{1},{dnl
__{}__SWAP2DEF({__N1},{__N2}){}dnl
__{}__SWAP2DEF({__R1},{__R2}){}dnl
__{}__EQ_MAKE_CODE($1,$2,$3,$4,$5){}dnl
__{}__{}ifelse(ifelse(_TYP_SINGLE,{small},{eval((_TMP_BEST_B>__EQ_BYTES) || ((_TMP_BEST_B==__EQ_BYTES) && (_TMP_BEST_P>__EQ_PRICE)))},{eval(_TMP_BEST_P>__EQ_PRICE)}),{1},{dnl
__{}__{}__{}define({_TMP_BEST_P},__EQ_PRICE){}dnl
__{}__{}__{}define({_TMP_BEST_B},__EQ_BYTES){}dnl
__{}__{}__{}define({_TMP_BEST_C},__EQ_CLOCKS){}dnl
__{}__{}__{}define({_TMP_BEST_CODE},__EQ_CODE)})})})}){}dnl
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
__{}__{}__{}    ld   HL{{,}} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
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
__{}__{}__{}    ld   BC{{,}} __HEX_DE($1)     ; 3:10      _TMP_INFO   hi16($1)
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
__{}__{}__{}    ld   HL{{,}} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   hi16(d1)-lo16(d1)})},
__{}eval(($1) & 0xFF000000),{0},{dnl
__{}__{}define({_TMP_B},13){}dnl
__{}__{}define({_TMP_J},42){}dnl
__{}__{}define({_TMP_NJ},62){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 4th byte zero
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} __HEX_E($1)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   L             ; 1:4       _TMP_INFO   L = __HEX_E($1)
__{}__{}__{}    or    H             ; 1:4       _TMP_INFO   H = 0
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{{,}} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   HL-lo16(d1)})},
__{}eval(($1) & 0xFF0000),{0},{dnl
__{}__{}define({_TMP_B},13){}dnl
__{}__{}define({_TMP_J},42){}dnl
__{}__{}define({_TMP_NJ},62){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 3th byte zero
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} __HEX_D($1)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = __HEX_D($1)
__{}__{}__{}    or    L             ; 1:4       _TMP_INFO   L = 0
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{{,}} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{{,}} DE         ; 2:15      _TMP_INFO   HL-lo16(d1)})},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}define({_TMP_B},13){}dnl
__{}__{}define({_TMP_J},42){}dnl
__{}__{}define({_TMP_NJ},62){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 2nd byte zero
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} __HEX_L($1)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   E             ; 1:4       _TMP_INFO   E = __HEX_L($1)
__{}__{}__{}    or    D             ; 1:4       _TMP_INFO   D = 0
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{{,}} __HEX_DE($1)     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{{,}} BC         ; 2:15      _TMP_INFO   HL-hi16(d1)})},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}define({_TMP_B},13){}dnl
__{}__{}define({_TMP_J},42){}dnl
__{}__{}define({_TMP_NJ},62){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HLDE_CODE},{dnl
__{}__{}__{}    ex   DE{{,}} HL         ; 1:4       _TMP_INFO   # 1st byte zero
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld    A{{,}} __HEX_H($1)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   D             ; 1:4       _TMP_INFO   D = __HEX_H($1)
__{}__{}__{}    or    E             ; 1:4       _TMP_INFO   E = 0
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{{,}} __HEX_DE($1)     ; 3:10      _TMP_INFO   hi16($1)
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
__{}__{}__{}    ld   BC{{,}} __HEX_DE($1)     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{{,}} BC         ; 2:15      _TMP_INFO   hi16(d1)-BC
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},$2); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{{,}} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
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
__{}__{}__{}    ld   BC{,} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
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
__{}__{}__{}    ld   HL{,} __HEX_DE($1)     ; 3:10      _TMP_INFO   hi16($1)
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
__{}__{}__{}    ld   BC{,} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFF000000),{0},{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},eval(27+$3)){}dnl
__{}__{}define({_TMP_NJ},58){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 4th byte zero
__{}__{}__{}    ld    A{,} __HEX_E($1)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   E             ; 1:4       _TMP_INFO   E = __HEX_E($1)
__{}__{}__{}    or    D             ; 1:4       _TMP_INFO   D = 0
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{,} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFF0000),{0},{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},eval(27+$3)){}dnl
__{}__{}define({_TMP_NJ},58){}dnl
__{}__{}define({_TMP_ZERO},{0}){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 3th byte zero
__{}__{}__{}    ld    A{,} __HEX_D($1)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   D             ; 1:4       _TMP_INFO   D = __HEX_D($1)
__{}__{}__{}    or    E             ; 1:4       _TMP_INFO   E = 0
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   BC{,} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFF00),{0},{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},eval(27+$3)){}dnl
__{}__{}define({_TMP_NJ},58){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 2nd byte zero
__{}__{}__{}    ld    A{,} __HEX_L($1)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   L             ; 1:4       _TMP_INFO   L = __HEX_L($1)
__{}__{}__{}    or    H             ; 1:4       _TMP_INFO   H = 0
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{,} __HEX_DE($1)     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      _TMP_INFO   HL-hi16(d1)
__{}__{}__{}    add  HL{,} DE         ; 1:11      _TMP_INFO})},
__{}eval(($1) & 0xFF),{0},{dnl
__{}__{}define({_TMP_B},12){}dnl
__{}__{}define({_TMP_J},eval(27+$3)){}dnl
__{}__{}define({_TMP_NJ},58){}dnl
__{}__{}define({_TMP_HL_CODE},{   # 1st byte zero
__{}__{}__{}    ld    A{,} __HEX_H($1)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   H             ; 1:4       _TMP_INFO   H = __HEX_H($1)
__{}__{}__{}    or    L             ; 1:4       _TMP_INFO   L = 0
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval(8+$2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{,} __HEX_DE($1)     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      _TMP_INFO   HL-hi16(d1)
__{}__{}__{}    add  HL{,} DE         ; 1:11      _TMP_INFO})},
__{}{dnl
__{}__{}define({_TMP_B},15){}dnl
__{}__{}define({_TMP_J},52){}dnl
__{}__{}define({_TMP_NJ},82){}dnl
__{}__{}define({_TMP_HL_CODE},{   # default version
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    xor   A             ; 1:4       _TMP_INFO
__{}__{}__{}    ld   BC{,} __HEX_HL($1)     ; 3:10      _TMP_INFO   lo16($1)
__{}__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL-lo16(d1)
__{}__{}__{}    jr   nz{,} $+7        ; 2:7/12    _TMP_INFO
__{}__{}__{}    ld   HL{,} __HEX_DE($1)     ; 3:10      _TMP_INFO   hi16($1)
__{}__{}__{}    sbc  HL{,} DE         ; 2:15      _TMP_INFO   hi16(d1)-DE
__{}__{}__{}    pop  HL             ; 1:10      _TMP_INFO})})}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 <= HL < $2
dnl #   _TMP_INFO
dnl #   _TMP_MAIN_INFO
dnl #   __WITHIN_ADD_BYTES
dnl #   __WITHIN_ADD_CLOCK
dnl # Output:
dnl #   carry if true, (HL-$1) U< ($2-$1)
dnl # Pollutes:
dnl #   A,BC,HL
define({__WITHIN},{ifelse($1,{},{
__{}  .error {{$0}}(): Missing parameters!},
$#,{1},{
__{}  .error {{$0}}($@): The second parameter is missing!},
eval($#>2),{1},{
__{}  .error {{$0}}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{define({__WITHIN_B},20){}define({__WITHIN_C},ifelse(__IS_MEM_REF($2),{0},{116},{122}))
__{}    ld   BC{,} format({%-11s},$1); 4:20      _TMP_INFO   BC = $1
__{}    or    A             ; 1:4       _TMP_INFO
__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   HL = {TOS}-$1
__{}    push HL             ; 1:11      _TMP_INFO
__{}    ld   HL{,} format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{3:16},{3:10})      _TMP_INFO
__{}    or    A             ; 1:4       _TMP_INFO
__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO
__{}    ld    C{,} L          ; 1:4       _TMP_INFO
__{}    ld    B{,} H          ; 1:4       _TMP_INFO   BC = $2-$1
__{}    pop  HL             ; 1:10      _TMP_INFO
__{}    or    A             ; 1:4       _TMP_INFO
__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   carry: HL-BC},
__IS_NUM($1),{0},{dnl
__{}ifelse(__IS_MEM_REF($2),{1},{
__{}__{}    ld   BC{,} format({%-11s},-($1)); 3:10      _TMP_INFO   BC = -($1)
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   HL = {TOS}-($1)
__{}__{}ifelse(_TYP_SINGLE,{small},{define({__WITHIN_B},15){}define({__WITHIN_C},96)dnl
__{}__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}__{}    ld   HL{,} format({%-11s},$2); 3:16      _TMP_INFO
__{}__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO
__{}__{}__{}    ld    C{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO   BC = $2-($1)
__{}__{}__{}    pop  HL             ; 1:10      _TMP_INFO},
__{}__{}{define({__WITHIN_B},17){}define({__WITHIN_C},82)dnl
__{}__{}__{}    ld    A{,} format({%-11s},$2); 3:13      _TMP_INFO
__{}__{}__{}    add   A{,} C          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    C{,} A          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    A{,} format({%-11s},($2+1)); 3:13      _TMP_INFO
__{}__{}__{}    adc   A{,} B          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    B{,} A          ; 1:4       _TMP_INFO   BC = $2-($1)})
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   carry: HL-BC},
__{}{define({__WITHIN_B},10){}define({__WITHIN_C},43)
__{}__{}    ld   BC{,} format({%-11s},-($1)); 3:10      _TMP_INFO   BC = -($1)
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   HL = {TOS}-($1)
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    sub  low format({%-11s},$2-($1)); 2:7       _TMP_INFO
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,}high format({%-7s},$2-($1)); 2:7       _TMP_INFO   carry: HL-($2-($1))})},
__IS_MEM_REF($2),{1},{dnl
__{}ifelse(eval($1),{0},{define({__WITHIN_B},7){}define({__WITHIN_C},39)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   carry: HL - BC},
__{}eval($1),{1},{define({__WITHIN_B},9){}define({__WITHIN_C},51)
__{}__{}    dec  HL             ; 1:6       _TMP_INFO   HL = {TOS}-($1)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO
__{}__{}    dec  BC             ; 1:6       _TMP_INFO   BC = $2-1
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   carry: HL - BC},
__{}__HEX_HL($1),{0xFFFF},{define({__WITHIN_B},9){}define({__WITHIN_C},51)
__{}__{}    inc  HL             ; 1:6       _TMP_INFO   HL = {TOS}-($1)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO
__{}__{}    inc  BC             ; 1:6       _TMP_INFO   BC = $2+1
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   carry: HL - BC},
__{}eval($1),{2},{define({__WITHIN_B},11){}define({__WITHIN_C},63)
__{}__{}    dec  HL             ; 1:6       _TMP_INFO
__{}__{}    dec  HL             ; 1:6       _TMP_INFO   HL = {TOS}-($1)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO
__{}__{}    dec  BC             ; 1:6       _TMP_INFO
__{}__{}    dec  BC             ; 1:6       _TMP_INFO   BC = $2-2
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   carry: HL - BC},
__{}__HEX_HL($1),{0xFFFE},{define({__WITHIN_B},11){}define({__WITHIN_C},63)
__{}__{}    inc  HL             ; 1:6       _TMP_INFO
__{}__{}    inc  HL             ; 1:6       _TMP_INFO   HL = {TOS}-($1)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO
__{}__{}    inc  BC             ; 1:6       _TMP_INFO
__{}__{}    inc  BC             ; 1:6       _TMP_INFO   BC = $2+2
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   carry: HL - BC},
__{}eval($1),{3},{define({__WITHIN_B},13){}define({__WITHIN_C},75)
__{}__{}    dec  HL             ; 1:6       _TMP_INFO
__{}__{}    dec  HL             ; 1:6       _TMP_INFO
__{}__{}    dec  HL             ; 1:6       _TMP_INFO   HL = {TOS}-($1)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO
__{}__{}    dec  BC             ; 1:6       _TMP_INFO
__{}__{}    dec  BC             ; 1:6       _TMP_INFO
__{}__{}    dec  BC             ; 1:6       _TMP_INFO   BC = $2-3
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   carry: HL - BC},
__{}__HEX_HL($1),{0xFFFD},{define({__WITHIN_B},13){}define({__WITHIN_C},75)
__{}__{}    inc  HL             ; 1:6       _TMP_INFO
__{}__{}    inc  HL             ; 1:6       _TMP_INFO
__{}__{}    inc  HL             ; 1:6       _TMP_INFO   HL = {TOS}-($1)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO
__{}__{}    inc  BC             ; 1:6       _TMP_INFO
__{}__{}    inc  BC             ; 1:6       _TMP_INFO
__{}__{}    inc  BC             ; 1:6       _TMP_INFO   BC = $2+3
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   carry: HL - BC},
__{}{define({__WITHIN_B},14){}define({__WITHIN_C},86)
__{}__{}    ld   BC{,} __HEX_HL(-($1))     ; 3:10      _TMP_INFO   BC = -($1)
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld   HL{,} format({%-11s},$2); 3:16      _TMP_INFO
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   HL = $2-($1)
__{}__{}    pop  BC             ; 1:11      _TMP_INFO   BC = {TOS}-($1)
__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO
__{}__{}    sub   L             ; 1:4       _TMP_INFO
__{}__{}    ld    A{,} B          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} H          ; 1:4       _TMP_INFO   carry: BC - HL})},
{dnl
__{}ifelse(eval($1),{0},{define({__WITHIN_B},6){}define({__WITHIN_C},22)},
__{}eval($1),{1},{define({__WITHIN_B},7){}define({__WITHIN_C},28)
__{}__{}    dec  HL             ; 1:6       _TMP_INFO   HL = ({TOS}-($1))},
__{}eval($1),{-1},{define({__WITHIN_B},7){}define({__WITHIN_C},28)
__{}__{}    inc  HL             ; 1:6       _TMP_INFO   HL = ({TOS}-($1))},
__{}eval($1),{2},{define({__WITHIN_B},8){}define({__WITHIN_C},34)
__{}__{}    dec  HL             ; 1:6       _TMP_INFO
__{}__{}    dec  HL             ; 1:6       _TMP_INFO   HL = ({TOS}-($1))},
__{}eval($1),{-2},{define({__WITHIN_B},8){}define({__WITHIN_C},34)
__{}__{}    inc  HL             ; 1:6       _TMP_INFO
__{}__{}    inc  HL             ; 1:6       _TMP_INFO   HL = ({TOS}-($1))},
__{}eval($1),{3},{define({__WITHIN_B},9){}define({__WITHIN_C},40)
__{}__{}    dec  HL             ; 1:6       _TMP_INFO
__{}__{}    dec  HL             ; 1:6       _TMP_INFO
__{}__{}    dec  HL             ; 1:6       _TMP_INFO   HL = ({TOS}-($1))},
__{}eval($1),{-3},{define({__WITHIN_B},9){}define({__WITHIN_C},40)
__{}__{}    inc  HL             ; 1:6       _TMP_INFO
__{}__{}    inc  HL             ; 1:6       _TMP_INFO
__{}__{}    inc  HL             ; 1:6       _TMP_INFO   HL = ({TOS}-($1))},
__{}{define({__WITHIN_B},10){}define({__WITHIN_C},43)
__{}__{}    ld   BC{,} __HEX_HL(-($1))     ; 3:10      _TMP_INFO   BC = -($1)
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   HL = {TOS}-($1)})
__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}ifelse(__IS_NUM($2),{0},{dnl
__{}__{}    sub  low format({%-11s},$2-($1)); 2:7       _TMP_INFO
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} high format({%-6s},$2-($1)); 2:7       _TMP_INFO   carry: HL-($2-($1))},
__{}{dnl
__{}__{}    sub  __HEX_L($2-($1))           ; 2:7       _TMP_INFO
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} __HEX_H($2-($1))       ; 2:7       _TMP_INFO   carry: HL-($2-($1))})}){}dnl
})dnl
dnl
dnl
dnl
dnl # Input:
dnl #   $1 <= HL < $2
dnl #   _TMP_INFO
dnl #   _TMP_MAIN_INFO
dnl #   __WITHIN_ADD_BYTES
dnl #   __WITHIN_ADD_CLOCK
dnl # Output:
dnl # carry if true, (HL-$1) U< ($2-$1)
dnl # Pollutes:
dnl #   A,BC
define({__SAVE_HL_WITHIN},{ifelse($1,{},{
__{}  .error {{$0}}(): Missing parameters!},
$#,{1},{
__{}  .error {{$0}}($@): The second parameter is missing!},
eval($#>2),{1},{
   __{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{define({__SAVE_HL_WITHIN_B},0){}define({__SAVE_HL_WITHIN_C},0)
__{}  .error "{{$0}}($@): does not support first variable parameter stored in memory."},
__IS_NUM($1),{0},{ifelse(dnl
__{}__IS_MEM_REF($2),{1},{define({__SAVE_HL_WITHIN_B},16){}define({__SAVE_HL_WITHIN_C},107)
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld   BC{,} format({%-11s},-($1)); 3:10      _TMP_INFO   BC = -($1)
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld   HL{,} format({%-11s},$2); 3:16      _TMP_INFO
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   HL = $2-($1)
__{}__{}    pop  BC             ; 1:11      _TMP_INFO   BC = {TOS}-($1)
__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO
__{}__{}    sub   L             ; 1:4       _TMP_INFO
__{}__{}    ld    A{,} B          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} H          ; 1:4       _TMP_INFO   carry: BC - HL
__{}__{}    pop  HL             ; 1:10      _TMP_INFO},
__{}{dnl
__{}__{}define({__SAVE_HL_WITHIN_B},14){}define({__SAVE_HL_WITHIN_C},52)
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    sub   low format({%-10s},$1); 2:7       _TMP_INFO
__{}__{}    ld    C{,} A          ; 1:4       _TMP_INFO
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} high format({%-6s},$1); 2:7       _TMP_INFO
__{}__{}    ld    B{,} A          ; 1:4       _TMP_INFO   BC = {TOS} - ($1)
__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO
__{}__{}    sub  low format({%-11s},$2-($1)); 2:7       _TMP_INFO
__{}__{}    ld    A{,} B          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,}high format({%-7s},$2-($1)); 2:7       _TMP_INFO   carry: BC - ($2 - ($1))})},
__IS_MEM_REF($2),{1},{ifelse(dnl
__{}eval($1),{0},{define({__SAVE_HL_WITHIN_B},10){}define({__SAVE_HL_WITHIN_C},42)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO   BC = $2 - ($1)
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    sub   C             ; 2:7       _TMP_INFO
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} B          ; 2:7       _TMP_INFO   carry: HL - BC},
__{}__{}__HEX_HL($1),{0x0001},{define({__SAVE_HL_WITHIN_B},13){}define({__SAVE_HL_WITHIN_C},60)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO
__{}__{}    dec  BC             ; 1:6       _TMP_INFO   BC = $2 - ($1)
__{}__{}    dec  HL             ; 1:6       _TMP_INFO   HL = {TOS} - ($1)
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    sub   C             ; 2:7       _TMP_INFO
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} B          ; 2:7       _TMP_INFO   carry: HL - BC
__{}__{}    inc  HL             ; 1:6       _TMP_INFO},
__{}__{}__HEX_HL($1),{0xFFFF},{define({__SAVE_HL_WITHIN_B},13){}define({__SAVE_HL_WITHIN_C},60)
__{}__{}    ld   BC{,} format({%-11s},$2); 4:20      _TMP_INFO
__{}__{}    inc  BC             ; 1:6       _TMP_INFO   BC = $2 - ($1)
__{}__{}    inc  HL             ; 1:6       _TMP_INFO   HL = {TOS} - ($1)
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    sub   C             ; 2:7       _TMP_INFO
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} B          ; 2:7       _TMP_INFO   carry: HL - BC
__{}__{}    dec  HL             ; 1:6       _TMP_INFO},
__{}{define({__SAVE_HL_WITHIN_B},16){}define({__SAVE_HL_WITHIN_C},107)
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld   BC{,} format({%-11s},-($1)); 3:10      _TMP_INFO   BC = -($1)
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO
__{}__{}    push HL             ; 1:11      _TMP_INFO
__{}__{}    ld   HL{,} format({%-11s},$2); 3:16      _TMP_INFO
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   HL = $2-($1)
__{}__{}    pop  BC             ; 1:11      _TMP_INFO   BC = {TOS}-($1)
__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO
__{}__{}    sub   L             ; 1:4       _TMP_INFO
__{}__{}    ld    A{,} B          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} H          ; 1:4       _TMP_INFO   carry: BC - HL
__{}__{}    pop  HL             ; 1:10      _TMP_INFO})},
{dnl
__{}ifelse(eval($1),{0},{define({__SAVE_HL_WITHIN_B},6){}define({__SAVE_HL_WITHIN_C},22)
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    sub  low format({%-11s},$2); 2:7       _TMP_INFO
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    sbc   A{,} high format({%-6s},$2); 2:7       _TMP_INFO   carry: HL - ($2 - ($1))},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__HEX_HL($1),{0x0001},{define({__SAVE_HL_WITHIN_B},9){}define({__SAVE_HL_WITHIN_C},36)
__{}__{}__{}    ld    C{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    dec  BC             ; 1:6       _TMP_INFO   BC = {TOS} - ($1)
__{}__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO},
__{}__{}__HEX_HL($1),{0xFFFF},{define({__SAVE_HL_WITHIN_B},9){}define({__SAVE_HL_WITHIN_C},36)
__{}__{}__{}    ld    C{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    inc  BC             ; 1:6       _TMP_INFO   BC = {TOS} - ($1)
__{}__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO},
__{}__{}__HEX_HL($1),{0x0002},{define({__SAVE_HL_WITHIN_B},10){}define({__SAVE_HL_WITHIN_C},42)
__{}__{}__{}    ld    C{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    dec  BC             ; 1:6       _TMP_INFO
__{}__{}__{}    dec  BC             ; 1:6       _TMP_INFO   BC = {TOS} - ($1)
__{}__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO},
__{}__{}__HEX_HL($1),{0xFFFE},{define({__SAVE_HL_WITHIN_B},10){}define({__SAVE_HL_WITHIN_C},42)
__{}__{}__{}    ld    C{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    inc  BC             ; 1:6       _TMP_INFO
__{}__{}__{}    inc  BC             ; 1:6       _TMP_INFO   BC = {TOS} - ($1)
__{}__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO},
__{}__{}__HEX_HL($1),{0x0003},{define({__SAVE_HL_WITHIN_B},11){}define({__SAVE_HL_WITHIN_C},48)
__{}__{}__{}    ld    C{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    dec  BC             ; 1:6       _TMP_INFO
__{}__{}__{}    dec  BC             ; 1:6       _TMP_INFO
__{}__{}__{}    dec  BC             ; 1:6       _TMP_INFO   BC = {TOS} - ($1)
__{}__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO},
__{}__{}__HEX_HL($1),{0xFFFD},{define({__SAVE_HL_WITHIN_B},11){}define({__SAVE_HL_WITHIN_C},48)
__{}__{}__{}    ld    C{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    inc  BC             ; 1:6       _TMP_INFO
__{}__{}__{}    inc  BC             ; 1:6       _TMP_INFO
__{}__{}__{}    inc  BC             ; 1:6       _TMP_INFO   BC = {TOS} - ($1)
__{}__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO},
__{}__{}__HEX_H($1),{0x00},{define({__SAVE_HL_WITHIN_B},12){}define({__SAVE_HL_WITHIN_C},44)
__{}__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    sub   __HEX_L($1)          ; 2:7       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    jr   nc{,} $+3        ; 2:7/12    _TMP_INFO
__{}__{}__{}    dec   B             ; 1:4       _TMP_INFO},
__{}__{}__HEX_H($1),{0xFF},{define({__SAVE_HL_WITHIN_B},12){}define({__SAVE_HL_WITHIN_C},44)
__{}__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    sub   __HEX_L($1)          ; 2:7       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    jr    c{,} $+3        ; 2:7/12    _TMP_INFO
__{}__{}__{}    inc   B             ; 1:4       _TMP_INFO},
__{}__{}{define({__SAVE_HL_WITHIN_B},14){}define({__SAVE_HL_WITHIN_C},52)
__{}__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    sub   __HEX_L($1)          ; 2:7       _TMP_INFO
__{}__{}__{}    ld    C{,} A          ; 1:4       _TMP_INFO
__{}__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    sbc   A{,} __HEX_H($1)       ; 2:7       _TMP_INFO
__{}__{}__{}    ld    B{,} A          ; 1:4       _TMP_INFO   BC = {TOS} - ($1)
__{}__{}__{}    ld    A{,} C          ; 1:4       _TMP_INFO})
__{}__{}ifelse(__IS_NUM($2),{0},{dnl
__{}__{}__{}    sub  low format({%-11s},$2-($1)); 2:7       _TMP_INFO
__{}__{}__{}    ld    A{,} B          ; 1:4       _TMP_INFO
__{}__{}__{}    sbc   A,high format({%-7s},$2-($1)); 2:7       _TMP_INFO   carry: BC - ($2 - ($1))},
__{}__{}{dnl
__{}__{}__{}    sub  __HEX_L($2-($1))           ; 2:7       _TMP_INFO
__{}__{}__{}    ld    A{,} B          ; 1:4       _TMP_INFO
__{}__{}__{}    sbc   A{,} __HEX_H($2-($1))       ; 2:7       _TMP_INFO   carry: BC - ($2 - ($1))}){}dnl
__{}}){}dnl
})})dnl
dnl
dnl
dnl
