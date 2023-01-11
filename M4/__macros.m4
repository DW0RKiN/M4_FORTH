define({__},{})dnl
dnl
dnl
dnl
dnl
dnl
define({__def},{ifdef({$1},,{define({$1},{$2})})}){}dnl
dnl
dnl
dnl # Empty string, pointer like "(0x8000)", unknown value --> ""
dnl #
dnl # Other:        D     E     H     L     DE       HL      DEHL
dnl # +(0x8000)     0x00  0x00  0x80  0x00  0x0000   0x8000  0x00008000
dnl # 0x8000        0x00  0x00  0x80  0x00  0x0000   0x8000  0x00008000
dnl # 32768         0x00  0x00  0x80  0x00  0x0000   0x8000  0x00008000
dnl # 32769-1       0x00  0x00  0x80  0x00  0x0000   0x8000  0x00008000
dnl # 4*8192        0x00  0x00  0x80  0x00  0x0000   0x8000  0x00008000
dnl # 5*100+32268   0x00  0x00  0x80  0x00  0x0000   0x8000  0x00008000
dnl # ...
define({__HEX_L},   {ifelse(__IS_NUM($1),{0},,{format({0x%02X},eval(0xFF   &  ($1)     ))})}){}dnl
define({__HEX_H},   {ifelse(__IS_NUM($1),{0},,{format({0x%02X},eval(0xFF   & (($1)>> 8)))})}){}dnl
define({__HEX_E},   {ifelse(__IS_NUM($1),{0},,{format({0x%02X},eval(0xFF   & (($1)>>16)))})}){}dnl
define({__HEX_D},   {ifelse(__IS_NUM($1),{0},,{format({0x%02X},eval(0xFF   & (($1)>>24)))})}){}dnl
define({__HEX_HL},  {ifelse(__IS_NUM($1),{0},,{format({0x%04X},eval(0xFFFF &  ($1)     ))})}){}dnl
define({__HEX_DE},  {ifelse(__IS_NUM($1),{0},,{format({0x%04X},eval(0xFFFF & (($1)>>16)))})}){}dnl
define({__HEX_DEHL},{ifelse(__IS_NUM($1),{0},,{format({0x%08X},eval(           $1      ))})}){}dnl
define({__HEX_DE_HL},{ifelse(__IS_NUM($1):__IS_NUM($2),{1:1},{format({0x%04X},eval($1)){}format({%04X},eval($2))},)}){}dnl
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
dnl # (abc)     --> 0
dnl # (123)     --> 0
dnl # (1)+(2)   --> 0 fail
dnl # ()        --> 0
dnl # 0xFF & () --> 0
dnl #           --> 0
dnl # abc       --> 0
dnl # 0a        --> 0
dnl # 0g        --> 0
dnl # 0xa       --> 1
dnl # 5         --> 1
dnl # 25*3      --> 1
__{}ifelse(dnl
__{}eval($#!=1),{1},{0},
__{}{$1},{},{0},
__{}{$1},(),{0},
__{}eval( regexp({$1},{[0-9]}) == -1 ),{1},{0},dnl # ( -- )
__{}eval( regexp({$1},{()}) != -1 ),{1},{0},dnl #
__{}eval( regexp({$1},{[?'",yzYZ_g-wG-W]}) != -1 ),{1},{0},dnl # Any letter and underscore _ except a,b,c,d,e,f,x
__{}eval( regexp({$1},{\(^\|[^0]\)[xX]}) != -1 ),{1},{0},dnl # x without leading zero
__{}eval( regexp({$1},{[a-fA-F0-9]0[xX]}) != -1 ),{1},{0},dnl # 0x inside hex characters or numbers, like 3210x or abc0x
__{}eval( regexp({$1},{\(^\|[^xX0-9a-fA-F]+\)[0-9a-fA-F]*[a-fA-F]}) != -1 ),{1},{0},dnl # hex characters without leading 0x
__{}{dnl
__{}__{}eval( __IS_MEM_REF($1)==0 && ifelse(eval($1),{},{0},{1}) ){}dnl
})}){}dnl
dnl
dnl
dnl
define({__16BIT_TO_ABS},{dnl
dnl # abc       --> (((abc)>>15)?-(abc):abc)
dnl # abc+5     --> (((abc+5)>>15)?-(abc+5):abc+5)
dnl # (123)     --> .error __16bit_to_abs(pointer)
dnl # (1)+(2)   --> fail --> .error __16bit_to_abs(pointer)
dnl # +(123)    --> 123
dnl # +(10-50)  --> 40
dnl # -1        --> 1
dnl # 5-6       --> 1
dnl # 6-5       --> 1
dnl # -25*4     --> 100
dnl # 0xFFFE    --> 2
dnl # 65535     --> 1
__{}ifelse(__IS_NUM($1),1,{define({__TEMP},eval(__HEX_HL($1)))},{define({__TEMP},{($1)})}){}dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($1),1,{
  .error __16bit_to_abs(pointer)},
__{}__IS_NUM($1):__LINKER,0:sjasmplus,{(abs(__TEMP<<16)>>16)},
__{}__IS_NUM($1),0,{((__TEMP>>15)?-__TEMP:$1)},
__{}{dnl
__{}ifelse(eval((__TEMP&0xFFFF)>0x8000),1,{eval(0x10000-(__TEMP&0xFFFF))},
__{}{eval(__TEMP&0xFFFF)})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # input: hi16,lo16
dnl #    warning! if the input is not a number, it must be in brackets!
dnl # output: (abs(hi16*65536+lo16)>>16)
define({__ABS32BIT_SHR_16},{dnl
__{}ifelse(__IS_NUM($1),1,{define({__TEMP_HI},eval(__HEX_HL($1)))},{define({__TEMP_HI},{($1)})}){}dnl
__{}ifelse(__IS_NUM($2),1,{define({__TEMP_LO},eval(__HEX_HL($2)))},{define({__TEMP_LO},{($2)})}){}dnl
__{}ifelse(dnl
__{}eval(__IS_MEM_REF($1)|__IS_MEM_REF($2)),1,{
   .error __abs32bit_shr_16(pointer)},
__{}eval(__IS_NUM($1)&__IS_NUM($2)):__LINKER,0:sjasmplus,{(abs((__TEMP_HI<<16)+(__TEMP_LO&0xFFFF))>>>16)},
__{}__IS_NUM($1):__IS_NUM($2),{0:0},{(__TEMP_HI>>15?~(__TEMP_HI+(__TEMP_LO=0)):$1)},
__{}__IS_NUM($1):__IS_NUM($2),{0:1},{(__TEMP_HI>>15?~__TEMP_HI{}ifelse(eval($2),0,-1):$1)},
__{}__IS_NUM($1):__IS_NUM($2),{1:0},{dnl
__{}__{}ifelse(eval(($1)&32768),32768,
__{}__{}{(eval(__HEX_HL(~($1)))-(__TEMP_LO=0))},
__{}__{}{eval($1)})},
__{}{dnl # FFFF 0000 -> 0000 FFFF + 1
__{}__{}ifelse(eval(__HEX_HL($1)>0x8000),1,
__{}__{}{eval(__HEX_DE(-__HEX_HL($1)*65536-__HEX_HL($2)))},
__{}__{}{eval(__HEX_HL($1))}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # input: hi16,lo16
dnl #    hi16 = 0x000?
dnl #    hi16 = 0xFFF?
dnl #    warning! if the input is not a number, it must be in brackets!
dnl # output: (abs(hi16*65536+lo16)>>4)
define({__ABS20BIT_SHR_4},{dnl
__{}ifelse(__IS_NUM($1),1,{define({__TEMP_HI},eval(__HEX_HL($1)))},{define({__TEMP_HI},{($1)})}){}dnl
__{}ifelse(__IS_NUM($2),1,{define({__TEMP_LO},eval(__HEX_HL($2)))},{define({__TEMP_LO},{($2)})}){}dnl
__{}ifelse(dnl
__{}eval(__IS_MEM_REF($1)|__IS_MEM_REF($2)),1,{
  .error __abs20bit_shr_4(pointer)},
__{}eval(__IS_NUM($1)&__IS_NUM($2)):__LINKER,0:sjasmplus,{(abs((__TEMP_HI<<16)+(__TEMP_LO&0xFFFF))>>>4)},
__{}__IS_NUM($1):__IS_NUM($2),{0:0},{(__TEMP_HI>>15?~(__TEMP_HI<<12+__TEMP_LO>>4+((15& __TEMP_LO)=0)):__TEMP_HI<<12+__TEMP_LO>>4)},
__{}__IS_NUM($1):__IS_NUM($2),{0:1},{(__TEMP_HI>>15?~(__TEMP_HI<<12+eval((($2)&0xFFFF)>>4)ifelse(eval(($2)&15),0,-1)):__TEMP_HI<<12+eval((($2)&0xFFFF)>>4))},
__{}__IS_NUM($1):__IS_NUM($2),{1:0},{dnl
__{}__{}ifelse(eval(($1)&32768),32768,
__{}__{}{(~(__HEX_HL((($1)&15)<<12)+__TEMP_LO>>4+((15& __TEMP_LO)=0)))},
__{}__{}{(__HEX_HL((($1)&15)<<12)+__TEMP_LO>>4)})},
__{}{dnl # FFFF 0000 -> 0000 FFFF + 1
__{}__{}ifelse(eval(__HEX_HL($1)>0x8000),1,
__{}__{}{eval(__HEX_HL((-(__HEX_HL($1)*65536+__HEX_HL($2)))>>4))},
__{}__{}{eval(((($1)&15)<<12)+(__HEX_HL($2)>>4))}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # input: hi16,lo16
dnl #    warning! if the input is not a number, it must be in brackets!
dnl # output: (abs(hi16*65536+lo16)&0xFFFF)
define({__ABS32BIT_AND_0xFFFF},{dnl
__{}ifelse(__IS_NUM($1),1,{define({__TEMP_HI},eval(__HEX_HL($1)))},{define({__TEMP_HI},{($1)})}){}dnl
__{}ifelse(__IS_NUM($2),1,{define({__TEMP_LO},eval(__HEX_HL($2)))},{define({__TEMP_LO},{($2)})}){}dnl
__{}ifelse(dnl
__{}eval(__IS_MEM_REF($1)|__IS_MEM_REF($2)),1,{
  .error __abs32bit_and_0xffff(pointer)},
__{}eval(__IS_NUM($1)&__IS_NUM($2)):__LINKER,0:sjasmplus,{(abs((__TEMP_HI<<16)+(__TEMP_LO&0xFFFF))&0xFFFF)},
__{}__IS_NUM($1):__IS_NUM($2),{0:0},{(__TEMP_HI>>15?-__TEMP_LO:$2)},
__{}__IS_NUM($1):__IS_NUM($2),{0:1},{(__TEMP_HI>>15? eval(__HEX_HL(-($2))):eval(__HEX_HL($2)))},
__{}__IS_NUM($1):__IS_NUM($2),{1:0},{dnl
__{}__{}ifelse(eval(($1)&32768),32768,(-__TEMP_LO),$2)},
__{}{dnl
__{}__{}ifelse(eval(__HEX_HL($1)>0x8000),1,
__{}__{}{eval(__HEX_HL(-($2)))},
__{}__{}{eval(__HEX_HL($2))}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__32BIT_TO_SIGN},{dnl
dnl # abc       --> abc
dnl # abc+5     --> abc+5
dnl # (123)     --> .error __32bit_to_sign(pointer)
dnl # (1)+(2)   --> fail --> .error __32bit_to_sign(pointer)
dnl # +(123)    --> 123
dnl # +(10-50)  --> -40
dnl # -1        --> -1
dnl # 5-6       --> -1
dnl # 6-5       --> 1
dnl # -25*4     --> -100
dnl # 0xFFFE    --> -2
dnl # 65535     --> -1
dnl # 0x8000    --> -32768
__{}ifelse(dnl
__{}__IS_MEM_REF($1),1,{
  .error __32bit_to_sign(pointer)},
__{}__IS_NUM($1),0,{$1},
__{}{dnl
__{}ifelse(eval((($1)>>31)&1),1,{eval(__HEX_DEHL($1)-0x100000000)},
__{}{eval($1)})}){}dnl
}){}dnl
dnl
dnl
dnl
define({__16BIT_TO_SIGN},{dnl
dnl # abc       --> abc
dnl # abc+5     --> abc+5
dnl # (123)     --> .error __16bit_to_sign(pointer)
dnl # (1)+(2)   --> fail --> .error __16bit_to_sign(pointer)
dnl # +(123)    --> 123
dnl # +(10-50)  --> -40
dnl # -1        --> -1
dnl # 5-6       --> -1
dnl # 6-5       --> 1
dnl # -25*4     --> -100
dnl # 0xFFFE    --> -2
dnl # 65535     --> -1
dnl # 0x8000    --> -32768
__{}ifelse(dnl
__{}__IS_MEM_REF($1),1,{
  .error __16bit_to_sign(pointer)},
__{}__IS_NUM($1):__LINKER,0:sjasmplus,{((($1)<<16)>>16)},
__{}__IS_NUM($1),0,{$1},
__{}{dnl
__{}ifelse(eval((($1)&0xFFFF)>0x7FFF),1,{eval((($1)&0xFFFF)-0x10000)},
__{}{eval(($1)&0xFFFF)})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # a  --> 1
dnl # Hl --> 1
dnl # aF --> 1
dnl # dh --> 0
dnl # ix --> 1
define({__IS_REG},{dnl
__{}eval(1+regexp({$1},{^\([a-ehA-EH]\|[Aa][Ff]\|[Bb][Cc]\|[Dd][Ee]\|[Hh][Ll]\|[Ii][XxYy]\|[Ii][XxYy][HhLl]\)$}))}){}dnl
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
define({__SAVE_EVAL},{ifelse(dnl
__{}eval($#>1),{1},{NO_ONE_NUMBERS},
__{}__IS_NUM($1),{1},{eval($1)},
__{}{NO_NUMBER})}){}dnl
dnl
dnl
dnl
dnl
dnl # Fix Pasmo problem with math expression starting with a negative value.
dnl # )+(0+  -->  +
dnl # )+(0-  -->  -
define({__FORM_REC3},{ifelse(regexp($1,{)\+(0[\+-]}),-1,$1,{dnl
__{}__FORM_REC3(regexp($1,{\(^.*\))\+(0\([\+-]\)\(.*\)$},{\1\2\3}))}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Fix Pasmo problem with math expression starting with a negative value.
dnl # (-  -->  (0-
define({__FORM_REC2},{ifelse(regexp($1,{(-}),-1,__FORM_REC3($1),{dnl
__{}__FORM_REC2(regexp($1,{\(^.*\)(-\(.*\)$},{\1(0-\2}))}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Fix Pasmo problem with math expression starting with a negative value.
dnl # ++  -->  +
dnl # +-  -->  -
dnl # -+  -->  -
dnl # --  -->  +
define({__FORM_REC},{ifelse(regexp($1,{[\+-][\+-]}),-1,__FORM_REC2($1),{ifelse(dnl
__{}eval(regexp($1,{\+\+})>-1),1,{__FORM_REC(regexp($1,{\(^.*\)\+\+\(.*\)$},{\1\+\2}))},
__{}eval(regexp($1,{\+-})>-1), 1,{__FORM_REC(regexp($1,{\(^.*\)\+-\(.*\)$}, {\1-\2}))},
__{}eval(regexp($1,{-\+})>-1), 1,{__FORM_REC(regexp($1,{\(^.*\)-\+\(.*\)$}, {\1-\2}))},
__{}eval(regexp($1,{--})>-1),  1,{__FORM_REC(regexp($1,{\(^.*\)--\(.*\)$},  {\1\+\2}))},
__{}{  .error $0})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Fix Pasmo problem with math expression starting with a negative value.
dnl # ld A,-4-4 --> ld A,0 !!!???
dnl # Input:
dnl #   $1 ...{%-11s}
dnl #   $2 ...math formula
dnl # __FORM({%-11s},-($2));
define({__FORM},{ifelse(dnl
__{}regexp({$2},{^-}),0,{format($1,0{}__FORM_REC($2))},
__{}regexp({$2},{^(}),0,{format($1,+{}__FORM_REC($2))},
__{}{format($1,__FORM_REC($2))}){}dnl
}){}dnl
dnl
dnl
dnl
define({__add},{define({$1},eval(}$1{+}$2{))}){}dnl
dnl
dnl
dnl
dnl # print array without comma
define({__REMOVE_COMMA},{dnl
__{}$1{}ifelse(eval($#>1),1,{ $0(shift($@))}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #    $1 = { }
dnl #    $2 = par1
dnl #    $3 = ...
dnl # Output:
dnl #    ignore empty par or "__dtto"
dnl #    par1{ }par2{ }par3
define({__CONCATENATE_WITH},{dnl
__{}ifelse(dnl
__{}$#,1,,
__{}$#:$2,2:__dtto,,
__{}$#,2,$2,
__{}$2,,{$0({$1},shift(shift($@)))},
__{}$2,__dtto,{$0({$1},shift(shift($@)))},
__{}{$2{}__CONCATENATE_WITH_LOOP({$1},shift(shift($@)))}){}dnl
}){}dnl
dnl
define({__CONCATENATE_WITH_LOOP},{dnl
__{}ifelse(dnl
__{}$#{:}$2,2:,{},
__{}$#{:}$2,2:__dtto,{},
__{}$#,2,{{$1}$2},
__{}$2,,{$0({$1},shift(shift($@)))},
__{}$2,__dtto,{$0({$1},shift(shift($@)))},
__{}{{$1}$2{}$0({$1},shift(shift($@)))}){}dnl
}){}dnl
dnl
dnl
define({__IS_ARRAY_NUM},{dnl
__{}ifelse(dnl
__{}__IS_NUM($1),{0},0,
__{}$#,1,1,
__{}{$0(shift($@))}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # without $
define({__ARRAY2HEXSTRING},{dnl
__{}ifelse(__IS_NUM($1),{0},,{format({%04X},eval(0xFFFF & ($1)))}){}dnl
__{}ifelse(eval($#>1),1,{$0(shift($@))}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # print last $1 parameters from array
dnl # __LAST_X_PAR(-1,10,20,30,40,50,60) -->
dnl # __LAST_X_PAR( 0,10,20,30,40,50,60) -->
dnl # __LAST_X_PAR( 1,10,20,30,40,50,60) --> 60
dnl # __LAST_X_PAR( 3,10,20,30,40,50,60) --> 40,50,60
dnl # __LAST_X_PAR( 8,10,20,30,40,50,60) --> 10,20,30,40,50,60
define({__LAST_X_PAR},{dnl
__{}ifelse(dnl
__{}eval($#<2),1,{},
__{}{ifelse(dnl
__{}__{}eval($1<=0),1,{},
__{}__{}eval($#>($1+1)),1,{$0($1,shift(shift($@)))},{shift($@)}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # print first $1 parameters from array
dnl # __FIRST_X_PAR(-1,10,20,30,40,50,60) -->
dnl # __FIRST_X_PAR( 0,10,20,30,40,50,60) -->
dnl # __FIRST_X_PAR( 1,10,20,30,40,50,60) --> 10
dnl # __FIRST_X_PAR( 3,10,20,30,40,50,60) --> 10,20,30
dnl # __FIRST_X_PAR( 8,10,20,30,40,50,60) --> 10,20,30,40,50,60
define({__FIRST_X_PAR},{dnl
__{}ifelse(dnl
__{}eval($#<2),1,{},
__{}{ifelse(dnl
__{}__{}eval($1<=0),1,{},
__{}__{}$#,2,{$2},
__{}__{}$1,1,{$2},
__{}__{}{$2{,}$0(eval($1-1),shift(shift($@)))}){}dnl
__{}}){}dnl
}){}dnl
dnl
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
define({__DIM},{ifelse({$#},1,{ifelse({$1},{},0,1)},{$#})}){}dnl
dnl
dnl
dnl
define({__SET_LOOP_TYPE},{dnl
__{}define({__LOOP[$1].TYPE},{$2})}){}dnl
dnl
define({__SET_LOOP_END},{dnl
__{}define({__LOOP[$1].END},{$2})}){}dnl
dnl
define({__SET_LOOP_BEGIN},{dnl
__{}define({__LOOP[$1].BEGIN},{$2})}){}dnl
dnl
define({__SET_LOOP_STEP},{dnl
__{}define({__LOOP[$1].STEP},{$2})}){}dnl
dnl
define({__SET_LOOP},{dnl
__{}define({__LOOP[$1].TYPE},{$2}){}dnl # M,R,S = memory, recursive, stack
__{}define({__LOOP[$1].END},{$3}){}dnl
__{}define({__LOOP[$1].BEGIN},{$4}){}dnl
__{}define({__LOOP[$1].STEP},{$5}){}dnl
}){}dnl
dnl
define({__SHOW_LOOP},{
__{};   id: $1
__{}; type: defn({__LOOP[$1].TYPE})   # M,R,S = memory, recursive, stack
__{};  end: defn({__LOOP[$1].END})
__{};begin: defn({__LOOP[$1].BEGIN})
__{}; step: defn({__LOOP[$1].STEP}){}dnl
}){}dnl
dnl
define({__GET_LOOP_TYPE},  {defn({__LOOP[$1].TYPE})}){}dnl   # M,R,S = memory, recursive, stack
define({__GET_LOOP_END},   {defn({__LOOP[$1].END})}){}dnl    #
define({__GET_LOOP_BEGIN}, {defn({__LOOP[$1].BEGIN})}){}dnl  #
define({__GET_LOOP_STEP},  {defn({__LOOP[$1].STEP})}){}dnl   #
dnl
dnl
dnl
define({__PARAM_X},{ifelse(eval($1>1),{1},{$0(eval($1-1),shift(shift($@)))},{$2})}){}dnl
dnl
define({__SET_TOKEN_NAME},{dnl
__{}define({__TOKEN[$1].NAME},{$2})}){}dnl
dnl
define({__SET_TOKEN},{dnl
__{}define({__TOKEN[}__COUNT_TOKEN{].NAME},{$1}){}dnl
__{}define({__TOKEN[}__COUNT_TOKEN{].INFO},{$2}){}dnl
__{}define({__TOKEN[}__COUNT_TOKEN{].PARAM},(shift(shift($@))))}){}dnl
dnl
define({__SET_TOKEN_X},{dnl
__{}define({__TOKEN[}$1{].NAME},{$2}){}dnl
__{}define({__TOKEN[}$1{].INFO},{$3}){}dnl
__{}define({__TOKEN[}$1{].PARAM},(shift(shift(shift($@)))))}){}dnl
dnl
define({__SHOW_TOKEN},{
__{}; name: defn({__TOKEN[$1].NAME})
__{}; info: defn({__TOKEN[$1].INFO})
__{};items: __GET_TOKEN_ITEMS($1)
__{};param: defn({__TOKEN[$1].PARAM}){}dnl
__{}ifelse(__GET_TOKEN_ARRAY_1($1),,,{
;array1: >__GET_TOKEN_ARRAY_1($1)<}){}dnl
__{}ifelse(__GET_TOKEN_ARRAY_2($1),,,{
;array2: >__GET_TOKEN_ARRAY_2($1)<}){}dnl
__{}ifelse(__GET_TOKEN_ARRAY_3($1),,,{
;array3: >__GET_TOKEN_ARRAY_3($1)<}){}dnl
__{}ifelse(__GET_TOKEN_ARRAY_4($1),,,{
;array4: >__GET_TOKEN_ARRAY_4($1)<}){}dnl
__{}ifelse(__GET_TOKEN_ITEMS($1),0,,{
;array: __GET_TOKEN_ARRAY($1)}){}dnl
}){}dnl
dnl
dnl # Fail with multiline...
define({__BOXING},{regexp({$@},{^\(.\)\(.*\)\(.\)$},{\1\1\2\3\3})}){}dnl
define({__UNBOXING},$*){}dnl
dnl
define({__ALL},$@){}dnl
define({__1},{$1}){}dnl
define({__2},{$2}){}dnl
define({__3},{$3}){}dnl
define({__4},{$4}){}dnl
define({__5},{$5}){}dnl
define({__6},{$6}){}dnl
define({__SPOJ},{$1$2}){}dnl
dnl
define({__GET_TOKEN_NAME},  {defn({__TOKEN[$1].NAME})}){}dnl                 # __TOKEN_PUSH2
define({__GET_TOKEN_INFO},  {defn({__TOKEN[$1].INFO})}){}dnl                 # {1 2}
define({__GET_TOKEN_ITEMS}, {__DIM(__SPOJ({__ALL},defn(__TOKEN[}$1{].PARAM)))}){}dnl  # 2
define({__GET_TOKEN_PARAM}, {defn({__TOKEN[$1].PARAM})}){}dnl                # (1,2)
dnl
dnl # Fail with multiline...
define({__GET_TOKEN_ARRAY}, {regexp(defn({__TOKEN[$1].PARAM}),{^(\(.*\))$},{\1})}){}dnl
define({__GET_TOKEN_ARRAY_1},{regexp(defn({__TOKEN[$1].PARAM}),{^(\([^,]*\)[,)]},{\1})}){}dnl
define({__GET_TOKEN_ARRAY_2},{regexp(defn({__TOKEN[$1].PARAM}),{^([^,]*,\([^,]*\)[,)]},{\1})}){}dnl
define({__GET_TOKEN_ARRAY_3},{regexp(defn({__TOKEN[$1].PARAM}),{^([^,]*,[^,]*,\([^,]*\)[,)]},{\1})}){}dnl
dnl # Work with multiline
define({__GET_TOKEN_ARRAY},{__SPOJ({__ALL},defn(__TOKEN[}$1{].PARAM))}){}dnl
define({__GET_TOKEN_ARRAY_1},{__SPOJ({__1},defn(__TOKEN[}$1{].PARAM))}){}dnl
define({__GET_TOKEN_ARRAY_2},{__SPOJ({__2},defn(__TOKEN[}$1{].PARAM))}){}dnl
define({__GET_TOKEN_ARRAY_3},{__SPOJ({__3},defn(__TOKEN[}$1{].PARAM))}){}dnl
define({__GET_TOKEN_ARRAY_4},{__SPOJ({__4},defn(__TOKEN[}$1{].PARAM))}){}dnl
define({__GET_TOKEN_ARRAY_5},{__SPOJ({__5},defn(__TOKEN[}$1{].PARAM))}){}dnl
define({__GET_TOKEN_ARRAY_6},{__SPOJ({__6},defn(__TOKEN[}$1{].PARAM))}){}dnl
dnl
dnl
dnl # __DROP_2_PAR(1,2,3,4,5) --> 1,2,3
define({__DROP_1_PAR},{ifelse(eval($#>2),1,{$1,$0(shift($@))},{ifelse($#,2,{$1})})}){}dnl
define({__DROP_2_PAR},{ifelse(eval($#>3),1,{$1,$0(shift($@))},{ifelse($#,3,{$1})})}){}dnl
define({__DROP_3_PAR},{ifelse(eval($#>4),1,{$1,$0(shift($@))},{ifelse($#,4,{$1})})}){}dnl
define({__DROP_4_PAR},{ifelse(eval($#>5),1,{$1,$0(shift($@))},{ifelse($#,5,{$1})})}){}dnl
dnl
define({__DROP_1_PAR_COMMA},{ifelse(eval($#>2),1,{$1,$0(shift($@))},{ifelse($#,2,{$1})})}){}dnl
define({__DROP_2_PAR_COMMA},{ifelse(eval($#>3),1,{$1,$0(shift($@))},{ifelse($#,3,{$1})})}){}dnl
define({__DROP_3_PAR_COMMA},{ifelse(eval($#>4),1,{$1,$0(shift($@))},{ifelse($#,4,{$1})})}){}dnl
define({__DROP_4_PAR_COMMA},{ifelse(eval($#>5),1,{$1,$0(shift($@))},{ifelse($#,5,{$1})})}){}dnl
dnl
dnl # __LAST_2_PAR_1(1,2,3) --> 2,3
define({__LAST_1_PAR},{ifelse($#,0,{},$#,1,{$1},                                                {$0(shift($@))})}){}dnl
define({__LAST_2_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},                                   {$0(shift($@))})}){}dnl
define({__LAST_3_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},$#,3,{$1,$2,$3},                   {$0(shift($@))})}){}dnl
define({__LAST_4_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},$#,3,{$1,$2,$3},$#,4,{$1,$2,$3,$4},{$0(shift($@))})}){}dnl
dnl
dnl # __REVERSE_2_PAR(1,2,3) --> 2
define({__REVERSE_1_PAR},    {ifelse($#,0,{},$#,1,{$1},$#,2,{$2},$#,3,{$3},$#,4,{$4},$#,5,{$5},$#,6,{$6},{$0(shift(shift(shift(shift(shift(shift($@)))))))})}){}dnl
define({__REVERSE_2_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,{$1},$#,3,{$2},$#,4,{$3},$#,5,{$4},$#,6,{$5},{$0(shift(shift(shift(shift(shift($@))))))})}){}dnl
define({__REVERSE_3_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,  {},$#,3,{$1},$#,4,{$2},$#,5,{$3},$#,6,{$4},{$0(shift(shift(shift(shift($@)))))})}){}dnl
define({__REVERSE_4_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,  {},$#,3,  {},$#,4,{$1},$#,5,{$2},$#,6,{$3},{$0(shift(shift(shift($@))))})}){}dnl
define({__REVERSE_5_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,  {},$#,3,  {},$#,4,  {},$#,5,{$1},$#,6,{$2},{$0(shift(shift($@)))})}){}dnl
define({__REVERSE_6_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,  {},$#,3,  {},$#,4,  {},$#,5,  {},$#,6,{$1},{$0(shift($@))})}){}dnl
dnl
define({__FIRST_TOKEN_NAME}, {defn({__TOKEN[1].NAME})}){}dnl
define({__FIRST_TOKEN_INFO}, {defn({__TOKEN[1].INFO})}){}dnl
define({__FIRST_TOKEN_PARAM},{defn({__TOKEN[1].PARAM})}){}dnl
dnl
define({__T_NAME},   {ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{defn({__TOKEN[}eval(__COUNT_TOKEN-$1){].NAME})})}){}dnl
define({__T_INFO},   {ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{defn({__TOKEN[}eval(__COUNT_TOKEN-$1){].INFO})})}){}dnl
define({__T_ITEMS},  {ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{__DIM(__SPOJ({__ALL},defn(__TOKEN[}eval(__COUNT_TOKEN-$1){].PARAM)))})}){}dnl
define({__T_PARAM},  {ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{defn({__TOKEN[}eval(__COUNT_TOKEN-$1){].PARAM})})}){}dnl
define({__T_ARRAY},  {ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1))})}){}dnl
define({__T_ARRAY_1},{ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{__GET_TOKEN_ARRAY_1(eval(__COUNT_TOKEN-$1))})}){}dnl
define({__T_ARRAY_2},{ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{__GET_TOKEN_ARRAY_2(eval(__COUNT_TOKEN-$1))})}){}dnl
define({__T_ARRAY_3},{ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{__GET_TOKEN_ARRAY_3(eval(__COUNT_TOKEN-$1))})}){}dnl
define({__T_ARRAY_4},{ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{__GET_TOKEN_ARRAY_4(eval(__COUNT_TOKEN-$1))})}){}dnl
define({__T_ARRAY_5},{ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{__GET_TOKEN_ARRAY_5(eval(__COUNT_TOKEN-$1))})}){}dnl
define({__T_ARRAY_6},{ifelse(__SAVE_EVAL(}__COUNT_TOKEN{>$1),1,{__GET_TOKEN_ARRAY_6(eval(__COUNT_TOKEN-$1))})}){}dnl
dnl
define({__T_HEX_1},{ifelse(__IS_NUM(__T_ARRAY_1($1)),1,{__HEX_HL(__T_ARRAY_1($1))})}){}dnl
define({__T_HEX_2},{ifelse(__IS_NUM(__T_ARRAY_2($1)),1,{__HEX_HL(__T_ARRAY_2($1))})}){}dnl
define({__T_HEX_3},{ifelse(__IS_NUM(__T_ARRAY_3($1)),1,{__HEX_HL(__T_ARRAY_3($1))})}){}dnl
define({__T_HEX_4},{ifelse(__IS_NUM(__T_ARRAY_4($1)),1,{__HEX_HL(__T_ARRAY_4($1))})}){}dnl
define({__T_HEX_5},{ifelse(__IS_NUM(__T_ARRAY_5($1)),1,{__HEX_HL(__T_ARRAY_5($1))})}){}dnl
define({__T_HEX_6},{ifelse(__IS_NUM(__T_ARRAY_6($1)),1,{__HEX_HL(__T_ARRAY_6($1))})}){}dnl
dnl
define({__T_REVERSE_1},{__REVERSE_1_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_REVERSE_2},{__REVERSE_2_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_REVERSE_3},{__REVERSE_3_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_REVERSE_4},{__REVERSE_4_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_REVERSE_5},{__REVERSE_5_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_REVERSE_6},{__REVERSE_6_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_LAST_1_PAR},{__LAST_1_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_LAST_2_PAR},{__LAST_2_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_LAST_3_PAR},{__LAST_3_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_LAST_4_PAR},{__LAST_4_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
dnl
define({__T_HEX_REVERSE_1},{ifelse(__IS_NUM(__T_REVERSE_1($1)),1,{__HEX_HL(__T_REVERSE_1($1))})}){}dnl
define({__T_HEX_REVERSE_2},{ifelse(__IS_NUM(__T_REVERSE_2($1)),1,{__HEX_HL(__T_REVERSE_2($1))})}){}dnl
define({__T_HEX_REVERSE_3},{ifelse(__IS_NUM(__T_REVERSE_3($1)),1,{__HEX_HL(__T_REVERSE_3($1))})}){}dnl
define({__T_HEX_REVERSE_4},{ifelse(__IS_NUM(__T_REVERSE_4($1)),1,{__HEX_HL(__T_REVERSE_4($1))})}){}dnl
define({__T_HEX_REVERSE_5},{ifelse(__IS_NUM(__T_REVERSE_5($1)),1,{__HEX_HL(__T_REVERSE_5($1))})}){}dnl
define({__T_HEX_REVERSE_6},{ifelse(__IS_NUM(__T_REVERSE_6($1)),1,{__HEX_HL(__T_REVERSE_6($1))})}){}dnl
dnl
define({__T_IS_PTR_REVERSE_1},{__IS_MEM_REF(__T_REVERSE_1($1))}){}dnl
define({__T_IS_PTR_REVERSE_2},{__IS_MEM_REF(__T_REVERSE_2($1))}){}dnl
define({__T_IS_PTR_REVERSE_3},{__IS_MEM_REF(__T_REVERSE_3($1))}){}dnl
define({__T_IS_PTR_REVERSE_4},{__IS_MEM_REF(__T_REVERSE_4($1))}){}dnl
define({__T_IS_PTR_REVERSE_5},{__IS_MEM_REF(__T_REVERSE_5($1))}){}dnl
define({__T_IS_PTR_REVERSE_6},{__IS_MEM_REF(__T_REVERSE_6($1))}){}dnl
define({__T_IS_PTR_REVERSE_2_1},    {eval(                                                                __IS_MEM_REF(__T_REVERSE_2($1))|__IS_MEM_REF(__T_REVERSE_1($1)))}){}dnl
define({__T_IS_PTR_REVERSE_3_1},    {eval(                                __IS_MEM_REF(__T_REVERSE_3($1))|                                __IS_MEM_REF(__T_REVERSE_1($1)))}){}dnl
define({__T_IS_PTR_REVERSE_4_1},    {eval(__IS_MEM_REF(__T_REVERSE_4($1))|                                                                __IS_MEM_REF(__T_REVERSE_1($1)))}){}dnl
define({__T_IS_PTR_REVERSE_3_2},    {eval(                                __IS_MEM_REF(__T_REVERSE_3($1))|__IS_MEM_REF(__T_REVERSE_2($1))                                )}){}dnl
define({__T_IS_PTR_REVERSE_4_2},    {eval(__IS_MEM_REF(__T_REVERSE_4($1))|                                __IS_MEM_REF(__T_REVERSE_2($1))                                )}){}dnl
define({__T_IS_PTR_REVERSE_4_3},    {eval(__IS_MEM_REF(__T_REVERSE_4($1))|__IS_MEM_REF(__T_REVERSE_3($1))                                                                )}){}dnl
define({__T_IS_PTR_REVERSE_3_2_1},  {eval(                                __IS_MEM_REF(__T_REVERSE_3($1))|__IS_MEM_REF(__T_REVERSE_2($1))|__IS_MEM_REF(__T_REVERSE_1($1)))}){}dnl
define({__T_IS_PTR_REVERSE_4_3_2_1},{eval(__IS_MEM_REF(__T_REVERSE_4($1))|__IS_MEM_REF(__T_REVERSE_3($1))|__IS_MEM_REF(__T_REVERSE_2($1))|__IS_MEM_REF(__T_REVERSE_1($1)))}){}dnl
dnl # __IS_NUM() --> 0
define({__T_IS_NUM_REVERSE_1},{__IS_NUM(__T_REVERSE_1($1))}){}dnl
define({__T_IS_NUM_REVERSE_2},{__IS_NUM(__T_REVERSE_2($1))}){}dnl
define({__T_IS_NUM_REVERSE_3},{__IS_NUM(__T_REVERSE_3($1))}){}dnl
define({__T_IS_NUM_REVERSE_4},{__IS_NUM(__T_REVERSE_4($1))}){}dnl
define({__T_IS_NUM_REVERSE_5},{__IS_NUM(__T_REVERSE_5($1))}){}dnl
define({__T_IS_NUM_REVERSE_6},{__IS_NUM(__T_REVERSE_6($1))}){}dnl
define({__T_IS_NUM_REVERSE_2_1},    {eval(                                                        __IS_NUM(__T_REVERSE_2($1))&__IS_NUM(__T_REVERSE_1($1)))}){}dnl
define({__T_IS_NUM_REVERSE_3_1},    {eval(                            __IS_NUM(__T_REVERSE_3($1))&                            __IS_NUM(__T_REVERSE_1($1)))}){}dnl
define({__T_IS_NUM_REVERSE_4_1},    {eval(__IS_NUM(__T_REVERSE_4($1))&                                                        __IS_NUM(__T_REVERSE_1($1)))}){}dnl
define({__T_IS_NUM_REVERSE_3_2},    {eval(                            __IS_NUM(__T_REVERSE_3($1))&__IS_NUM(__T_REVERSE_2($1))                            )}){}dnl
define({__T_IS_NUM_REVERSE_4_2},    {eval(__IS_NUM(__T_REVERSE_4($1))&                            __IS_NUM(__T_REVERSE_2($1))                            )}){}dnl
define({__T_IS_NUM_REVERSE_4_3},    {eval(__IS_NUM(__T_REVERSE_4($1))&__IS_NUM(__T_REVERSE_3($1))                                                        )}){}dnl
define({__T_IS_NUM_REVERSE_3_2_1},  {eval(                            __IS_NUM(__T_REVERSE_3($1))&__IS_NUM(__T_REVERSE_2($1))&__IS_NUM(__T_REVERSE_1($1)))}){}dnl
define({__T_IS_NUM_REVERSE_4_3_2_1},{eval(__IS_NUM(__T_REVERSE_4($1))&__IS_NUM(__T_REVERSE_3($1))&__IS_NUM(__T_REVERSE_2($1))&__IS_NUM(__T_REVERSE_1($1)))}){}dnl
dnl # __IS_MEM_REF() --> 0
define({__T_IS_PTR_1},{__IS_MEM_REF(__T_ARRAY_1($1))}){}dnl
define({__T_IS_PTR_2},{__IS_MEM_REF(__T_ARRAY_2($1))}){}dnl
define({__T_IS_PTR_3},{__IS_MEM_REF(__T_ARRAY_3($1))}){}dnl
define({__T_IS_PTR_4},{__IS_MEM_REF(__T_ARRAY_4($1))}){}dnl
define({__T_IS_PTR_5},{__IS_MEM_REF(__T_ARRAY_5($1))}){}dnl
define({__T_IS_PTR_6},{__IS_MEM_REF(__T_ARRAY_6($1))}){}dnl
define({__T_IS_PTR_1_2},    {eval(__IS_MEM_REF(__T_ARRAY_1($1))|__IS_MEM_REF(__T_ARRAY_2($1))                                                            )}){}dnl
define({__T_IS_PTR_1_3},    {eval(__IS_MEM_REF(__T_ARRAY_1($1))|                              __IS_MEM_REF(__T_ARRAY_3($1))                              )}){}dnl
define({__T_IS_PTR_1_4},    {eval(__IS_MEM_REF(__T_ARRAY_1($1))|                                                            __IS_MEM_REF(__T_ARRAY_4($1)))}){}dnl
define({__T_IS_PTR_2_3},    {eval(                              __IS_MEM_REF(__T_ARRAY_2($1))|__IS_MEM_REF(__T_ARRAY_3($1))                              )}){}dnl
define({__T_IS_PTR_2_4},    {eval(                              __IS_MEM_REF(__T_ARRAY_2($1))|                              __IS_MEM_REF(__T_ARRAY_4($1)))}){}dnl
define({__T_IS_PTR_3_4},    {eval(                                                            __IS_MEM_REF(__T_ARRAY_3($1))|__IS_MEM_REF(__T_ARRAY_4($1)))}){}dnl
define({__T_IS_PTR_1_2_3},  {eval(__IS_MEM_REF(__T_ARRAY_1($1))|__IS_MEM_REF(__T_ARRAY_2($1))|__IS_MEM_REF(__T_ARRAY_3($1))                              )}){}dnl
define({__T_IS_PTR_1_2_3_4},{eval(__IS_MEM_REF(__T_ARRAY_1($1))|__IS_MEM_REF(__T_ARRAY_2($1))|__IS_MEM_REF(__T_ARRAY_3($1))|__IS_MEM_REF(__T_ARRAY_4($1)))}){}dnl
dnl
define({__T_IS_NUM_1},{__IS_NUM(__T_ARRAY_1($1))}){}dnl
define({__T_IS_NUM_2},{__IS_NUM(__T_ARRAY_2($1))}){}dnl
define({__T_IS_NUM_3},{__IS_NUM(__T_ARRAY_3($1))}){}dnl
define({__T_IS_NUM_4},{__IS_NUM(__T_ARRAY_4($1))}){}dnl
define({__T_IS_NUM_5},{__IS_NUM(__T_ARRAY_5($1))}){}dnl
define({__T_IS_NUM_6},{__IS_NUM(__T_ARRAY_6($1))}){}dnl
define({__T_IS_NUM_1_2},    {eval(__IS_NUM(__T_ARRAY_1($1))&__IS_NUM(__T_ARRAY_2($1))                                                    )}){}dnl
define({__T_IS_NUM_1_3},    {eval(__IS_NUM(__T_ARRAY_1($1))&                          __IS_NUM(__T_ARRAY_3($1))                          )}){}dnl
define({__T_IS_NUM_1_4},    {eval(__IS_NUM(__T_ARRAY_1($1))&                                                    __IS_NUM(__T_ARRAY_4($1)))}){}dnl
define({__T_IS_NUM_2_3},    {eval(                          __IS_NUM(__T_ARRAY_2($1))&__IS_NUM(__T_ARRAY_3($1))                          )}){}dnl
define({__T_IS_NUM_2_4},    {eval(                          __IS_NUM(__T_ARRAY_2($1))&                          __IS_NUM(__T_ARRAY_4($1)))}){}dnl
define({__T_IS_NUM_3_4},    {eval(                                                    __IS_NUM(__T_ARRAY_3($1))&__IS_NUM(__T_ARRAY_4($1)))}){}dnl
define({__T_IS_NUM_1_2_3},  {eval(__IS_NUM(__T_ARRAY_1($1))&__IS_NUM(__T_ARRAY_2($1))&__IS_NUM(__T_ARRAY_3($1))                          )}){}dnl
define({__T_IS_NUM_1_2_3_4},{eval(__IS_NUM(__T_ARRAY_1($1))&__IS_NUM(__T_ARRAY_2($1))&__IS_NUM(__T_ARRAY_3($1))&__IS_NUM(__T_ARRAY_4($1)))}){}dnl
dnl
define({__T_IS_NUM_4_5},    {eval(__IS_NUM(__T_ARRAY_4($1))&__IS_NUM(__T_ARRAY_5($1)))}){}dnl
define({__T_IS_NUM_5_6},    {eval(__IS_NUM(__T_ARRAY_5($1))&__IS_NUM(__T_ARRAY_6($1)))}){}dnl
define({__T_IS_NUM_2_3_4},  {eval(__IS_NUM(__T_ARRAY_2($1))&__IS_NUM(__T_ARRAY_3($1))&__IS_NUM(__T_ARRAY_4($1)))}){}dnl
define({__T_IS_NUM_3_4_5},  {eval(__IS_NUM(__T_ARRAY_3($1))&__IS_NUM(__T_ARRAY_4($1))&__IS_NUM(__T_ARRAY_5($1)))}){}dnl
define({__T_IS_NUM_4_5_6},  {eval(__IS_NUM(__T_ARRAY_4($1))&__IS_NUM(__T_ARRAY_5($1))&__IS_NUM(__T_ARRAY_6($1)))}){}dnl
dnl
dnl
dnl
define({__DELETE_LAST_TOKEN},{dnl
__{}undefine({__TOKEN[}__COUNT_TOKEN{].NAME}){}dnl
__{}undefine({__TOKEN[}__COUNT_TOKEN{].INFO}){}dnl
__{}undefine({__TOKEN[}__COUNT_TOKEN{].PARAM}){}dnl
__{}ifelse(__COUNT_TOKEN,1,{undefine({__COUNT_TOKEN})},{define({__COUNT_TOKEN},eval(__COUNT_TOKEN-1))})}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #    operation num_1 num_2
dnl #    operation num_1 num_2 num_3
dnl # Output:
dnl #    eval(            (num_1) operation (num_2))
dnl #    eval(((num_3)<<16+num_1) operation (num_2))
define({__EVAL_OP_NUM_XXX_SJASMPLUS},{dnl
__{}ifelse(__IS_MEM_REF($2),1,{define({__TEMP_A},$2)},__HEX_HL($2),{},{define({__TEMP_A},{($2)})},{define({__TEMP_A},{eval($2)})}){}dnl
__{}ifelse(__IS_MEM_REF($3),1,{define({__TEMP_B},$3)},__HEX_HL($3),{},{define({__TEMP_B},{($3)})},{define({__TEMP_B},{eval($3)})}){}dnl
__{}ifelse(__IS_NUM($4),               1,{define({__TEMP_C}, {eval($4)})},           {define({__TEMP_C}, {($4)})}){}dnl
__{}ifelse(__IS_NUM($2):__IS_NUM($4),1:1,{define({__TEMP_CA},{eval((($4)<<16)+$2)})},  {define({__TEMP_CA},{(($4)<<16+$2)})}){}dnl
__{}ifelse(__IS_NUM($4),               1,{define({__TEMP_C_SIGN},{eval((($4)>>15)&1)})}, {define({__TEMP_C_SIGN},{((($4)>>15)&1)})}){}dnl
__{}ifelse(__IS_NUM($3),               1,{define({__TEMP_B_SIGN},{eval((($3)>>15)&1)})}, {define({__TEMP_B_SIGN},{((($3)>>15)&1)})}){}dnl
__{}ifelse(__IS_NUM($2),               1,{define({__TEMP_SA},{__16BIT_TO_SIGN($2)})},{define({__TEMP_SA},{((($2)<<16)>>16)})}){}dnl
__{}ifelse(__IS_NUM($3),               1,{define({__TEMP_SB},{__16BIT_TO_SIGN($3)})},{define({__TEMP_SB},{((($3)<<16)>>16)})}){}dnl
__{}ifelse(__IS_NUM($2),               1,{define({__TEMP_UA},{__HEX_HL($2)})},       {define({__TEMP_UA},{(($2)&0xFFFF)})}){}dnl
__{}ifelse(__IS_NUM($3),               1,{define({__TEMP_UB},{__HEX_HL($3)})},       {define({__TEMP_UB},{(($3)&0xFFFF)})}){}dnl
__{}ifelse(__HEX_HL($2),{},{define({__TEMP_HL_A},{(low($2))})},{define({__TEMP_HL_A},{eval(($2)&0xFFFF)})}){}dnl
ifelse(1,0,{errprint({
{$0}($@)
}__TEMP_A{ $1 }__TEMP_B{ ca=}__TEMP_CA{
})}){}dnl
__{}ifelse(dnl

__{}__{}$1,  {=}, {+(($2)<<16)= (($3)<<16)},
__{}__{}$1, {<>}, {+(($2)<<16)!=(($3)<<16)},
__{}__{}$1,  {<}, {+(($2)<<16)< (($3)<<16)},
__{}__{}$1, {<=}, {+(($2)<<16)<=(($3)<<16)},
__{}__{}$1, {>=}, {+(($2)<<16)>=(($3)<<16)},
__{}__{}$1,  {>}, {+(($2)<<16)> (($3)<<16)},

__{}__{}$1:__IS_NUM($2), {u=:1}, {__HEX_HL($2)= (($3)&0xFFFF)},
__{}__{}$1:__IS_NUM($2),{u<>:1}, {__HEX_HL($2)!=(($3)&0xFFFF)},
__{}__{}$1:__IS_NUM($2), {u<:1}, {__HEX_HL($2)< (($3)&0xFFFF)},
__{}__{}$1:__IS_NUM($2),{u<=:1}, {__HEX_HL($2)<=(($3)&0xFFFF)},
__{}__{}$1:__IS_NUM($2),{u>=:1}, {__HEX_HL($2)>=(($3)&0xFFFF)},
__{}__{}$1:__IS_NUM($2), {u>:1}, {__HEX_HL($2)> (($3)&0xFFFF)},
__{}__{}$1:__IS_NUM($2), {u=:1}, {__HEX_HL($3)= (($2)&0xFFFF)},
__{}__{}$1:__IS_NUM($2),{u<>:1}, {__HEX_HL($3)!=(($2)&0xFFFF)},
__{}__{}$1:__IS_NUM($2), {u<:1}, {__HEX_HL($3)> (($2)&0xFFFF)},
__{}__{}$1:__IS_NUM($2),{u<=:1}, {__HEX_HL($3)>=(($2)&0xFFFF)},
__{}__{}$1:__IS_NUM($2),{u>=:1}, {__HEX_HL($3)<=(($2)&0xFFFF)},
__{}__{}$1:__IS_NUM($2), {u>:1}, {__HEX_HL($3)< (($2)&0xFFFF)},
__{}__{}$1, {u=}, {+(($2)&0xFFFF)= (($3)&0xFFFF)},
__{}__{}$1,{u<>}, {+(($2)&0xFFFF)!=(($3)&0xFFFF)},
__{}__{}$1, {u<}, {+(($2)&0xFFFF)< (($3)&0xFFFF)},
__{}__{}$1,{u<=}, {+(($2)&0xFFFF)<=(($3)&0xFFFF)},
__{}__{}$1,{u>=}, {+(($2)&0xFFFF)>=(($3)&0xFFFF)},
__{}__{}$1, {u>}, {+(($2)&0xFFFF)> (($3)&0xFFFF)},

__{}__{}$1:__HEX_HL($2):__IS_NUM(__TEMP_B), {&:0xFFFF:0},{$3},
__{}__{}$1:__HEX_HL($3):__IS_NUM(__TEMP_A), {&:0xFFFF:0},{$2},
__{}__{}$1:__HEX_HL($2),{&:0x0000},{0},
__{}__{}$1:__HEX_HL($3),{&:0x0000},{0},
__{}__{}$1, {&},{__TEMP_A&__TEMP_B},

__{}__{}$1:__HEX_HL($2):__IS_NUM(__TEMP_B), {|:0x0000:0},{$3},
__{}__{}$1:__HEX_HL($3):__IS_NUM(__TEMP_A), {|:0x0000:0},{$2},
__{}__{}$1:__HEX_HL($2),{|:0xFFFF},{0xFFFF},
__{}__{}$1:__HEX_HL($3),{|:0xFFFF},{0xFFFF},
__{}__{}$1, {|},{__TEMP_A|__TEMP_B},

__{}__{}$1:__TEMP_A, {^:0},{__TEMP_B},
__{}__{}$1:__TEMP_B, {^:0},{__TEMP_A},
__{}__{}$1,          {^},{__TEMP_A^__TEMP_B},

__{}__{}$1:__TEMP_A, {*:0},{0},
__{}__{}$1:__TEMP_B, {*:0},{0},
__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {*:1:0},{$3},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {*:1:0},{$2},
__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {*:-1:0},{-($3)},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {*:-1:0},{-($2)},
__{}__{}$1,  {*},{((__TEMP_A<<16)>>16)*((__TEMP_B<<16)>>16)},
__{}__{}$1:__TEMP_A, {u*:0},{0},
__{}__{}$1:__TEMP_B, {u*:0},{0},
__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B),{u*:1:0},{$3},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A),{u*:1:0},{$2},
__{}__{}$1, {u*},{__TEMP_UA*__TEMP_UB},
__{}__{}$1, {m*},{(__TEMP_SA*__TEMP_SB)>>16,(__TEMP_SA*__TEMP_SB)&0xFFFF},
__{}__{}$1,{um*},{(__TEMP_UA*__TEMP_UB)>>16,(__TEMP_UA*__TEMP_UB)&0xFFFF},
__{}__{}$1,{sm*},{+__TEMP_SA*__TEMP_SB},
__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {/:0:0},{0},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {/:1:0},{$2},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {/:-1:0},{-($2)},
__{}__{}$1, {/},{(__TEMP_A<<16)/(__TEMP_B<<16)},
__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {u/:0:0},{0},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {u/:1:0},{$2},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {u/:-1:0},{-($2)},
__{}__{}$1,{u/},{__TEMP_UA/__TEMP_UB},
__{}__{}$1,{um/},{+(__TEMP_CA&-1)/__TEMP_UB},
__{}__{}$1,{sm/},{+__TEMP_CA/__TEMP_SB},
__{}__{}$1,{fm/},+__TEMP_CA/__TEMP_SB-(((__TEMP_CA%__TEMP_SB)!=0)&((((__TEMP_CA%__TEMP_SB)^__TEMP_B)>>15)&1)),

__{}__{}$1, {%},{(__TEMP_A<<16)mod(__TEMP_B<<16)},
__{}__{}$1,{u%},{__TEMP_UA/__TEMP_UB},
__{}__{}$1,{um%},{+(__TEMP_CA&-1)%__TEMP_UB},
__{}__{}$1,{sm%},{+__TEMP_CA%__TEMP_SB},
__{}__{}$1,{fm%},+((__TEMP_CA%__TEMP_SB)!=0)&(((((__TEMP_CA%__TEMP_SB)^__TEMP_B)>>15)&1)*__TEMP_SB+(__TEMP_CA%__TEMP_SB)),

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {+:0:0},{$3},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {+:0:0},{$2},
__{}__{}$1, {+},{__TEMP_SA+__TEMP_SB},
__{}__{}$1,{m+},{(__TEMP_CA+__TEMP_SB)>>16},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {-:0:0},{-($3)},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {-:0:0},{$2},
__{}__{}$1, {-},{__TEMP_A-__TEMP_B},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {u+:0:0},{abs($3)},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {u+:0:0},{abs($2)},
__{}__{}$1,{u+},{__TEMP_UA+__TEMP_UB},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {u-:0:0},{-abs($3)},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {u-:0:0},{abs($2)},
__{}__{}$1,{u-},{__TEMP_UA-__TEMP_UB},

__{}__{}$1,{<?},{+((($2)<<16)<?(($3)<<16))>>16},
__{}__{}$1,{>?},{+((($2)<<16)>?(($3)<<16))>>16},

__{}{
__{}__{}  .error __eval_s16 $1 $2 $3}){}dnl
}){}dnl
dnl
dnl
ifelse(1,0,{
define({__TEMP_A},65535){}dnl
define({__TEMP_B},65535){}dnl
; AAaa*BBbb = ((0x100*AA)+aa)*((0x100*BB)+bb) = 0x10000*AA*BB + 0x100*AA*bb + 0x100*aa*BB + aa*bb
ld bc,__TEMP_A
ld bc,__TEMP_B
ld ix,+((high __TEMP_A)*(high __TEMP_B))
ld ix,+((low __TEMP_A)*(__TEMP_B>>15*0xFF00+__TEMP_B>>8))>>15*0xFF00 + ((low __TEMP_A)*(__TEMP_B>>15*0xFF00+__TEMP_B>>8))>>8
ld ix,+((low __TEMP_B)*(__TEMP_A>>15*0xFF00+__TEMP_A>>8))>>15*0xFF00 + ((low __TEMP_B)*(__TEMP_A>>15*0xFF00+__TEMP_A>>8))>>8
ld de,+((high __TEMP_A)*(high __TEMP_B))+((low __TEMP_A)*(__TEMP_B>>15*0xFF00+__TEMP_B>>8))>>15*0xFF00 + ((low __TEMP_A)*(__TEMP_B>>15*0xFF00+__TEMP_B>>8))>>8+((low __TEMP_B)*(__TEMP_A>>15*0xFF00+__TEMP_A>>8))>>15*0xFF00 + ((low __TEMP_B)*(__TEMP_A>>15*0xFF00+__TEMP_A>>8))>>8
ld bc,+(low((low __TEMP_A)*(high __TEMP_B)))
ld bc,+(low((high __TEMP_A)*(low __TEMP_B)))
ld bc,+(low __TEMP_A)*(low __TEMP_B)>>8
ld ix,+((low((low __TEMP_A)*(high __TEMP_B)))+(low((high __TEMP_A)*(low __TEMP_B)))+(low __TEMP_A)*(low __TEMP_B)>>8)>>8
ld de,+((high __TEMP_A)*(high __TEMP_B))+((low __TEMP_A)*(__TEMP_B>>15*0xFF00+__TEMP_B>>8))>>15*0xFF00 + ((low __TEMP_A)*(__TEMP_B>>15*0xFF00+__TEMP_B>>8))>>8+((low __TEMP_B)*(__TEMP_A>>15*0xFF00+__TEMP_A>>8))>>15*0xFF00 + ((low __TEMP_B)*(__TEMP_A>>15*0xFF00+__TEMP_A>>8))>>8+((low((low __TEMP_A)*(high __TEMP_B)))+(low((high __TEMP_A)*(low __TEMP_B)))+(low __TEMP_A)*(low __TEMP_B)>>8)>>8
ld hl,+__TEMP_A*__TEMP_B
if 0
endif
ld bc,+(__TEMP_A>>8)*(__TEMP_B>>8)
ld de,+(low __TEMP_A)*(__TEMP_B>>8)>>8
ld de,+(low __TEMP_B)*(__TEMP_A>>8)>>8
ld hl,+((low((low __TEMP_A)*(__TEMP_B>>8)))+(low((__TEMP_A>>8)*(low __TEMP_B)))+(low __TEMP_A)*(low __TEMP_B)>>8)>>8
ld bc,+(__TEMP_A>>8)*(__TEMP_B>>8)+(low __TEMP_A)*(__TEMP_B>>8)>>8+(low __TEMP_B)*(__TEMP_A>>8)>>8+((low((low __TEMP_A)*(__TEMP_B>>8)))+(low((__TEMP_A>>8)*(low __TEMP_B)))+(low __TEMP_A)*(low __TEMP_B)>>8)>>8
if 0
endif
ld hl,+(__TEMP_A>>8)*(__TEMP_B>>8)+(low __TEMP_A)*(__TEMP_B>>8)>>8+(low __TEMP_B)*(__TEMP_A>>8)>>8+((low((low __TEMP_A)*(__TEMP_B>>8)))+(low((__TEMP_A>>8)*(low __TEMP_B)))+(low __TEMP_A)*(low __TEMP_B)>>8)>>8-((__TEMP_A)>>15)*(__TEMP_B)-((__TEMP_B)>>15)*(__TEMP_A)

}){}dnl
dnl
dnl
dnl
dnl # Pasmo: Tabulka operátorů podle pořadí priority, operátory na stejném řádku mají stejnou prioritu:
dnl #
dnl # ## (see note)
dnl # $, NUL, DEFINED
dnl # *, /, MOD, %, SHL, SHR, <<, >>
dnl # +, - (binary)
dnl # EQ, NE, LT, LE, GT, GE, =, !=, <, >, <=, >=
dnl # NOT, ~, !, +, - (unary)
dnl # AND, &
dnl # OR, |, XOR
dnl # &&
dnl # ||
dnl # HIGH, LOW
dnl # ?
dnl
dnl # Input:
dnl #    operation num_1 num_2
dnl #    operation num_1 num_2 num_3
dnl # Output:
dnl #    eval(            (num_1) operation (num_2))
dnl #    eval(((num_3)<<16+num_1) operation (num_2))
define({__EVAL_OP_NUM_XXX_PASMO},{dnl
__{}ifelse(__IS_MEM_REF($2),1,{define({__TEMP_A},$2)},__HEX_HL($2),{},{define({__TEMP_A},{($2)})},{define({__TEMP_A},{eval(($2)&0xFFFF)})}){}dnl
__{}ifelse(__IS_MEM_REF($3),1,{define({__TEMP_B},$3)},__HEX_HL($3),{},{define({__TEMP_B},{($3)})},{define({__TEMP_B},{eval(($3)&0xFFFF)})}){}dnl
__{}ifelse(__HEX_HL($4),{},{define({__TEMP_C},{($4)})},{define({__TEMP_C},{eval(($4)&0xFFFF)})}){}dnl
__{}ifelse(__HEX_HL($2),{},{define({__TEMP_LO_A},{(low($2))})},{define({__TEMP_LO_A},{eval(($2)&0xFF)})}){}dnl
__{}ifelse(__HEX_HL($3),{},{define({__TEMP_LO_B},{(low($3))})},{define({__TEMP_LO_B},{eval(($3)&0xFF)})}){}dnl
__{}ifelse(__HEX_HL($2),{},{define({__TEMP_HI_A},{(($2)>>8)})},{define({__TEMP_HI_A},{eval((($2)>>8)&0xFF)})}){}dnl
__{}ifelse(__HEX_HL($3),{},{define({__TEMP_HI_B},{(($3)>>8)})},{define({__TEMP_HI_B},{eval((($3)>>8)&0xFF)})}){}dnl
__{}ifelse(__HEX_HL($2),{},{define({__TEMP_SIGN_A},{(($2)>>15)})},{define({__TEMP_SIGN_A},{eval((($2)>>15)&0x01)})}){}dnl
__{}ifelse(__HEX_HL($3),{},{define({__TEMP_SIGN_B},{(($3)>>15)})},{define({__TEMP_SIGN_B},{eval((($3)>>15)&0x01)})}){}dnl
__{}ifelse(__HEX_HL($4),{},{define({__TEMP_SIGN_C},{(($4)>>15)})},{define({__TEMP_SIGN_C},{eval((($4)>>15)&0x01)})}){}dnl
ifelse(1,0,{errprint({
__eval_op_num_xxx_pasmo($@)
})}){}dnl
__{}ifelse(dnl
__{}__{}$1:__IS_NUM($2),  {=:1}, {__HEX_HL($2+0x8000)= (($3)+0x8000)},
__{}__{}$1:__IS_NUM($2), {<>:1}, {__HEX_HL($2+0x8000)!=(($3)+0x8000)},
__{}__{}$1:__IS_NUM($2),  {<:1}, {__HEX_HL($2+0x8000)< (($3)+0x8000)},
__{}__{}$1:__IS_NUM($2), {<=:1}, {__HEX_HL($2+0x8000)<=(($3)+0x8000)},
__{}__{}$1:__IS_NUM($2), {>=:1}, {__HEX_HL($2+0x8000)>=(($3)+0x8000)},
__{}__{}$1:__IS_NUM($2),  {>:1}, {__HEX_HL($2+0x8000)> (($3)+0x8000)},
__{}__{}$1:__IS_NUM($3),  {=:1}, {__HEX_HL($3+0x8000)= (($2)+0x8000)},
__{}__{}$1:__IS_NUM($3), {<>:1}, {__HEX_HL($3+0x8000)!=(($2)+0x8000)},
__{}__{}$1:__IS_NUM($3),  {<:1}, {__HEX_HL($3+0x8000)> (($2)+0x8000)},
__{}__{}$1:__IS_NUM($3), {<=:1}, {__HEX_HL($3+0x8000)>=(($2)+0x8000)},
__{}__{}$1:__IS_NUM($3), {>=:1}, {__HEX_HL($3+0x8000)<=(($2)+0x8000)},
__{}__{}$1:__IS_NUM($3),  {>:1}, {__HEX_HL($3+0x8000)< (($2)+0x8000)},
__{}__{}$1,  {=}, {+(($2)+0x8000)= (($3)+0x8000)},
__{}__{}$1, {<>}, {+(($2)+0x8000)!=(($3)+0x8000)},
__{}__{}$1,  {<}, {+(($2)+0x8000)< (($3)+0x8000)},
__{}__{}$1, {<=}, {+(($2)+0x8000)<=(($3)+0x8000)},
__{}__{}$1, {>=}, {+(($2)+0x8000)>=(($3)+0x8000)},
__{}__{}$1,  {>}, {+(($2)+0x8000)> (($3)+0x8000)},

__{}__{}$1:__IS_NUM($2), {u=:1}, {__HEX_HL($2)= ($3)},
__{}__{}$1:__IS_NUM($2),{u<>:1}, {__HEX_HL($2)!=($3)},
__{}__{}$1:__IS_NUM($2), {u<:1}, {__HEX_HL($2)< ($3)},
__{}__{}$1:__IS_NUM($2),{u<=:1}, {__HEX_HL($2)<=($3)},
__{}__{}$1:__IS_NUM($2),{u>=:1}, {__HEX_HL($2)>=($3)},
__{}__{}$1:__IS_NUM($2), {u>:1}, {__HEX_HL($2)> ($3)},
__{}__{}$1:__IS_NUM($3), {u=:1}, {__HEX_HL($3)= ($2)},
__{}__{}$1:__IS_NUM($3),{u<>:1}, {__HEX_HL($3)!=($2)},
__{}__{}$1:__IS_NUM($3), {u<:1}, {__HEX_HL($3)> ($2)},
__{}__{}$1:__IS_NUM($3),{u<=:1}, {__HEX_HL($3)>=($2)},
__{}__{}$1:__IS_NUM($3),{u>=:1}, {__HEX_HL($3)<=($2)},
__{}__{}$1:__IS_NUM($3), {u>:1}, {__HEX_HL($3)< ($2)},
__{}__{}$1, {u=}, {+($2)= ($3)},
__{}__{}$1,{u<>}, {+($2)!=($3)},
__{}__{}$1, {u<}, {+($2)< ($3)},
__{}__{}$1,{u<=}, {+($2)<=($3)},
__{}__{}$1,{u>=}, {+($2)>=($3)},
__{}__{}$1, {u>}, {+($2)> ($3)},

__{}__{}$1:__HEX_HL($2):__IS_NUM(__TEMP_B), {&:0xFFFF:0},{$3},
__{}__{}$1:__HEX_HL($3):__IS_NUM(__TEMP_A), {&:0xFFFF:0},{$2},
__{}__{}$1:__HEX_HL($2),{&:0x0000},{0},
__{}__{}$1:__HEX_HL($3),{&:0x0000},{0},
__{}__{}$1, {&},{__TEMP_A&__TEMP_B},

__{}__{}$1:__HEX_HL($2):__IS_NUM(__TEMP_B), {|:0x0000:0},{$3},
__{}__{}$1:__HEX_HL($3):__IS_NUM(__TEMP_A), {|:0x0000:0},{$2},
__{}__{}$1:__HEX_HL($2),{|:0xFFFF},{0xFFFF},
__{}__{}$1:__HEX_HL($3),{|:0xFFFF},{0xFFFF},
__{}__{}$1, {|},{__TEMP_A|__TEMP_B},


__{}__{}$1:__TEMP_A, {^:0},{__TEMP_B},
__{}__{}$1:__TEMP_B, {^:0},{__TEMP_A},
__{}__{}$1,          {^},{__TEMP_A^__TEMP_B},

__{}__{}$1:__TEMP_A, {*:0},{0},
__{}__{}$1:__TEMP_B, {*:0},{0},
__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {*:1:0},{$3},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {*:1:0},{$2},
__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {*:65535:0},{-($3)},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {*:65535:0},{-($2)},
__{}__{}$1, {*},{__TEMP_A*__TEMP_B},


__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {+:0:0},{$3},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {+:0:0},{$2},
__{}__{}$1,  {+},{__TEMP_A+__TEMP_B},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {-:0:0},{-($3)},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {-:0:0},{$2},
__{}__{}$1,  {-},{__TEMP_A-__TEMP_B},

__{}__{}$1:__TEMP_A, {u*:0},{0},
__{}__{}$1:__TEMP_B, {u*:0},{0},
__{}__{}$1, {u*},{__TEMP_A*__TEMP_B},
__{}__{}$1, {m*},{ifelse(dnl
__{}__{}__{}__TEMP_HI_A,0,0,
__{}__{}__{}__TEMP_HI_B,0,0,
__{}__{}__{}__TEMP_HI_A,1,+__TEMP_HI_B,
__{}__{}__{}__TEMP_HI_B,1,+__TEMP_HI_A,
__{}__{}__{}+__TEMP_HI_A*__TEMP_HI_B){}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_LO_A,0,{},
__{}__{}__{}__TEMP_HI_B,0,{},
__{}__{}__{}__TEMP_LO_A,1,{},
__{}__{}__{}__TEMP_HI_B,1,{},
__{}__{}__{}+__TEMP_LO_A*__TEMP_HI_B>>8){}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_HI_A,0,{},
__{}__{}__{}__TEMP_LO_B,0,{},
__{}__{}__{}__TEMP_HI_A,1,{},
__{}__{}__{}__TEMP_LO_B,1,{},
__{}__{}__{}+__TEMP_HI_A*__TEMP_LO_B>>8){}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_LO_A,0,{},
__{}__{}__{}__TEMP_LO_B,0,{},
__{}__{}__{}__TEMP_HI_A:__TEMP_HI_B,0:0,{},
__{}__{}__{}__TEMP_A,1,{},
__{}__{}__{}__TEMP_B,1,{},
__{}__{}__{}__TEMP_HI_A,0,+((low(__TEMP_LO_A*__TEMP_HI_B))+__TEMP_LO_A*__TEMP_LO_B>>8)>>8,
__{}__{}__{}__TEMP_HI_B,0,+((low(__TEMP_HI_A*__TEMP_LO_B))+__TEMP_LO_A*__TEMP_LO_B>>8)>>8,
__{}__{}__{}+((low(__TEMP_LO_A*__TEMP_HI_B))+(low(__TEMP_HI_A*__TEMP_LO_B))+__TEMP_LO_A*__TEMP_LO_B>>8)>>8){}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_SIGN_A,0,{},
__{}__{}__{}__TEMP_SIGN_A,1,-__TEMP_B,
__{}__{}__{}-__TEMP_SIGN_A*__TEMP_B){}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_SIGN_B,0,{},
__{}__{}__{}__TEMP_SIGN_B,1,-__TEMP_A,
__{}__{}__{}-__TEMP_SIGN_B*__TEMP_A){}dnl
__{}__{}__{},dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_A,0,0,
__{}__{}__{}__TEMP_B,0,0,
__{}__{}__{}__TEMP_A,1,+__TEMP_B,
__{}__{}__{}__TEMP_B,1,+__TEMP_A,
__{}__{}__{}+__TEMP_A*__TEMP_B)},

__{}__{}$1,{um*},{ifelse(dnl
__{}__{}__{}__TEMP_HI_A,0,0,
__{}__{}__{}__TEMP_HI_B,0,0,
__{}__{}__{}__TEMP_HI_A,1,+__TEMP_HI_B,
__{}__{}__{}__TEMP_HI_B,1,+__TEMP_HI_A,
__{}__{}__{}+__TEMP_HI_A*__TEMP_HI_B){}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_LO_A,0,{},
__{}__{}__{}__TEMP_HI_B,0,{},
__{}__{}__{}__TEMP_LO_A,1,{},
__{}__{}__{}__TEMP_HI_B,1,{},
__{}__{}__{}+__TEMP_LO_A*__TEMP_HI_B>>8){}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_HI_A,0,{},
__{}__{}__{}__TEMP_LO_B,0,{},
__{}__{}__{}__TEMP_HI_A,1,{},
__{}__{}__{}__TEMP_LO_B,1,{},
__{}__{}__{}+__TEMP_HI_A*__TEMP_LO_B>>8){}dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_LO_A,0,{},
__{}__{}__{}__TEMP_LO_B,0,{},
__{}__{}__{}__TEMP_HI_A:__TEMP_HI_B,0:0,{},
__{}__{}__{}__TEMP_A,1,{},
__{}__{}__{}__TEMP_B,1,{},
__{}__{}__{}__TEMP_HI_A,0,+((low(__TEMP_LO_A*__TEMP_HI_B))+__TEMP_LO_A*__TEMP_LO_B>>8)>>8,
__{}__{}__{}__TEMP_HI_B,0,+((low(__TEMP_HI_A*__TEMP_LO_B))+__TEMP_LO_A*__TEMP_LO_B>>8)>>8,
__{}__{}__{}+((low(__TEMP_LO_A*__TEMP_HI_B))+(low(__TEMP_HI_A*__TEMP_LO_B))+__TEMP_LO_A*__TEMP_LO_B>>8)>>8){}dnl
__{}__{}__{},dnl
__{}__{}__{}ifelse(dnl
__{}__{}__{}__TEMP_A,0,0,
__{}__{}__{}__TEMP_B,0,0,
__{}__{}__{}__TEMP_A,1,+__TEMP_B,
__{}__{}__{}__TEMP_B,1,+__TEMP_A,
__{}__{}__{}+__TEMP_A*__TEMP_B)},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {/:0:0},{0},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {/:1:0},{$2},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {/:65535:0},{-($2)},
__{}__{}$1:__SAVE_EVAL($2>=0),{/:1},{+((~($3))>>15)*__16BIT_TO_ABS($2)/($3)-(($3)>>15)*__16BIT_TO_ABS($2)/(-($3))},
__{}__{}$1:__SAVE_EVAL($2<0), {/:1},{+(($3)>>15)*__16BIT_TO_ABS($2)/(-($3))-((~($3))>>15)*__16BIT_TO_ABS($2)/($3)},
__{}__{}$1:__SAVE_EVAL($3>=0),{/:1},{+((($2)>>15) xor 1)*($2)/__16BIT_TO_ABS($3)-(($2)>>15)*(-($2))/__16BIT_TO_ABS($3)},
__{}__{}$1:__SAVE_EVAL($3<0), {/:1},{+(($2)>>15)*(-($2))/__16BIT_TO_ABS($3)-((~($2))>>15)*($2)/__16BIT_TO_ABS($3)},
__{}__{}$1, {/},{dnl
__{}__{}__{}+(((($2)|($3))>>15) xor 1)*($2)/($3)dnl   # + +
__{}__{}__{}-(((~($2))&($3))>>15)*($2)/(-($3))dnl     # + -
__{}__{}__{}-((($2)&(~($3)))>>15)*(-($2))/($3)dnl     # - +
__{}__{}__{}+((($2)&($3))>>15)*(-($2))/(-($3))},

__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFFFF),{sm/:0},{dnl
__{}__{}__{}+((($3)>>15) xor 1)*($2)/($3)dnl   # + +
__{}__{}__{}-(($3)>>15)*($2)/(-($3))},

__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFFFF),{sm/:65535},{dnl
__{}__{}__{}+(($3)>>15)*(-($2))/(-($3))dnl     # - -
__{}__{}__{}-((~($3))>>15)*(-($2))/($3)},

__{}__{}$1:__SAVE_EVAL(((__TEMP_B&0xF000)!=0xF000)&&((__TEMP_B&0xF000)!=0x0000)), {sm/:1},{dnl
__{}__{}__{}+(((__TEMP_C|($3))>>15) xor 1)*($2)/($3)dnl   # + +
__{}__{}__{}-(((~__TEMP_C)&($3))>>15)*($2)/(-($3))dnl     # + -
__{}__{}__{}-((__TEMP_C&(~($3)))>>15)*(-($2))/($3)dnl     # - +
__{}__{}__{}+((__TEMP_C&($3))>>15)*(-($2))/(-($3))},

__{}__{}$1,{sm/},{dnl
__{}__{}__{}+(((__ABS32BIT_SHR_16($4,$2) mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)>>12)/__16BIT_TO_ABS($3)<<12+dnl
__{}__{}__{}((__ABS32BIT_SHR_16($4,$2) mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)>>12)mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)<<4>>12)/__16BIT_TO_ABS($3)<<8+dnl
__{}__{}__{}(((__ABS32BIT_SHR_16($4,$2) mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)>>12)mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)<<4>>12)mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)<<8>>12)/__16BIT_TO_ABS($3)<<4+dnl
__{}__{}__{}((((__ABS32BIT_SHR_16($4,$2) mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)>>12)mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)<<4>>12)mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)<<8>>12)mod __16BIT_TO_ABS($3)<<4+(15& __ABS32BIT_AND_0xFFFF($4,$2)))/__16BIT_TO_ABS($3)dnl
__{}__{}__{})xor((__TEMP_C xor __TEMP_B)>>15*(-1)))+((__TEMP_C xor __TEMP_B)>>15)},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {u/:0:0},{0},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {u/:1:0},{$2},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {u/:-1:0},{-($2)},
__{}__{}$1, {u/},{+__TEMP_A/__TEMP_B},

__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFFFF),{um/:0},{+__TEMP_A/__TEMP_B},

__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFFF0),{um/:0},{dnl
__{}__{}__{}+(__TEMP_C<<12+__TEMP_A>>4)/__TEMP_B<<4+dnl
__{}__{}__{}((__TEMP_C<<12+__TEMP_A>>4)mod __TEMP_B<<4+(15& __TEMP_A))/__TEMP_B},

__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFF00),{um/:0},{dnl
__{}__{}__{}+(__TEMP_C<<8+__TEMP_A>>8)/__TEMP_B<<8+dnl
__{}__{}__{}((__TEMP_C<<8+__TEMP_A>>8)mod __TEMP_B<<4+__TEMP_A<<8>>12)/__TEMP_B<<4+dnl
__{}__{}__{}(((__TEMP_C<<8+__TEMP_A>>8)mod __TEMP_B<<4+__TEMP_A<<8>>12)mod __TEMP_B<<4+(15& __TEMP_A))/__TEMP_B},

__{}__{}$1,{um/},{dnl
__{}__{}__{}+(__TEMP_C mod __TEMP_B<<4+__TEMP_A>>12)/__TEMP_B<<12+dnl
__{}__{}__{}((__TEMP_C mod __TEMP_B<<4+__TEMP_A>>12)mod __TEMP_B<<4+__TEMP_A<<4>>12)/__TEMP_B<<8+dnl
__{}__{}__{}(((__TEMP_C mod __TEMP_B<<4+__TEMP_A>>12)mod __TEMP_B<<4+__TEMP_A<<4>>12)mod __TEMP_B<<4+__TEMP_A<<8>>12)/__TEMP_B<<4+dnl
__{}__{}__{}((((__TEMP_C mod __TEMP_B<<4+__TEMP_A>>12)mod __TEMP_B<<4+__TEMP_A<<4>>12)mod __TEMP_B<<4+__TEMP_A<<8>>12)mod __TEMP_B<<4+(15& __TEMP_A))/__TEMP_B},

__{}__{}$1,{fm/},{dnl
__{}__{}__{}+(((__TEMP_C|($3))>>15) xor 1)*($2)/($3)dnl   # + +
__{}__{}__{}-(((~__TEMP_C)&($3))>>15)*(($2)/(-($3))-((($2)mod($3))!=0))dnl     # + -
__{}__{}__{}-((__TEMP_C&(~($3)))>>15)*((-($2))/($3)-((($2)mod($3))!=0))dnl     # - +
__{}__{}__{}+((__TEMP_C&($3))>>15)*(-($2))/(-($3))},

__{}__{}$1, {%},{dnl
__{}__{}__{}+(((($2)|($3))>>15) xor 1)*($2)mod($3)dnl   # + +
__{}__{}__{}+(((~($2))&($3))>>15)*($2)mod(-($3))dnl     # + -
__{}__{}__{}-((($2)&(~($3)))>>15)*(-($2))mod($3)dnl     # - +
__{}__{}__{}-((($2)&($3))>>15)*(-($2))mod(-($3))},

__{}__{}$1, {u%},{__TEMP_A mod __TEMP_B},

__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFFFF),{sm%:0},{dnl     # 16bit/16bit
__{}__{}__{}+((~($3))>>15)*($2)mod($3)dnl                # + +
__{}__{}__{}+(($3)>>15)*($2)mod(-($3))},

__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFFFF),{sm%:65535},{dnl # -16bit/16bit
__{}__{}__{}0-((~($3))>>15)*(-($2))mod($3)dnl            # - +
__{}__{}__{}-(($3)>>15)*(-($2))mod(-($3))},

__{}__{}$1:__SAVE_EVAL(((__TEMP_B&0xF000)!=0xF000)&&(((__TEMP_B>>15)&1)==1)), {sm%:1},{dnl # ??bit/16bit
__{}__{}__{}+((~__TEMP_C)>>15)*($2)mod eval(__HEX_HL(-($3)))dnl                            # + -
__{}__{}__{}-(__TEMP_C>>15)*(-($2))mod eval(__HEX_HL(-($3)))},

__{}__{}$1:__SAVE_EVAL(((__TEMP_B&0xF000)!=0x0000)&&(((__TEMP_B>>15)&1)==0)), {sm%:1},{dnl # ??bit/16bit
__{}__{}__{}+((~__TEMP_C)>>15)*($2)mod eval(__HEX_HL($3))dnl                               # + +
__{}__{}__{}-(__TEMP_C>>15)*(-($2))mod eval(__HEX_HL($3))},

__{}__{}$1:__IS_NUM(__TEMP_C):__IS_NUM(__TEMP_A),
                                      {sm%:1:1},{+((((((__ABS32BIT_SHR_16($4,$2) mod __16BIT_TO_ABS($3)<<4+eval(__ABS32BIT_AND_0xFFFF($4,$2)>>12))mod __16BIT_TO_ABS($3)<<4+eval((__ABS32BIT_AND_0xFFFF($4,$2)>>8)&15))mod __16BIT_TO_ABS($3)<<4+eval((__ABS32BIT_AND_0xFFFF($4,$2)>>4)&15))mod __16BIT_TO_ABS($3)<<4+eval(__ABS32BIT_AND_0xFFFF($4,$2)&15))mod __16BIT_TO_ABS($3){}dnl
__{}__{}__{})xor(__TEMP_C>>15*(-1)))+(__TEMP_C>>15)},
__{}__{}$1,                               {sm%},{+(((((((__ABS32BIT_SHR_16($4,$2) mod __16BIT_TO_ABS($3)<<4)mod __16BIT_TO_ABS($3)<<4)mod __16BIT_TO_ABS($3)<<4)mod __16BIT_TO_ABS($3)<<4)mod __16BIT_TO_ABS($3)+__ABS32BIT_AND_0xFFFF($4,$2) mod __16BIT_TO_ABS($3))mod __16BIT_TO_ABS($3){}dnl
__{}__{}__{})xor(__TEMP_C>>15*(-1)))+(__TEMP_C>>15)},
__{}__{}$1,                {sm%-longer_version},{+((((((__ABS32BIT_SHR_16($4,$2) mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)>>12)mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)<<4>>12)mod __16BIT_TO_ABS($3)<<4+__ABS32BIT_AND_0xFFFF($4,$2)<<8>>12)mod __16BIT_TO_ABS($3)<<4+(15& __ABS32BIT_AND_0xFFFF($4,$2)))mod __16BIT_TO_ABS($3)dnl
__{}__{}__{})xor(__TEMP_C>>15*(-1)))+(__TEMP_C>>15)},

__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFFFF),{um%:0},{+__TEMP_A mod __TEMP_B},
__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFFF0),{um%:0},{+(((__TEMP_C<<12+__TEMP_A>>4))mod __TEMP_B<<4+(15& __TEMP_A))mod __TEMP_B},
__{}__{}$1:__SAVE_EVAL(__TEMP_C&0xFF00),{um%:0},{+(((__TEMP_C<<8+__TEMP_A>>8)mod __TEMP_B<<4+__TEMP_A<<8>>12)mod __TEMP_B<<4+(15& __TEMP_A))mod __TEMP_B},
__{}__{}$1:__IS_NUM(__TEMP_A),          {um%:1},{+((((__TEMP_C mod __TEMP_B<<4+eval(__TEMP_A>>12))mod __TEMP_B<<4+eval((__TEMP_A>>8)&15))mod __TEMP_B<<4+eval((__TEMP_A>>4)&15))mod __TEMP_B<<4+eval(__TEMP_A&15))mod __TEMP_B},

__{}__{}$1,                               {um%},{+(((((__TEMP_C mod __TEMP_B<<4)mod __TEMP_B<<4)mod __TEMP_B<<4)mod __TEMP_B<<4)mod __TEMP_B+__TEMP_A mod __TEMP_B)mod __TEMP_B},
__{}__{}$1,                {um%-longer_version},{+((((__TEMP_C mod __TEMP_B<<4+__TEMP_A>>12)mod __TEMP_B<<4+__TEMP_A<<4>>12)mod __TEMP_B<<4+__TEMP_A<<8>>12)mod __TEMP_B<<4+(15& __TEMP_A))mod __TEMP_B},

__{}__{}$1,{fm%},{dnl
__{}__{}__{}+(((__TEMP_C|($3))>>15) xor 1)*($2)mod($3)dnl   # + +
__{}__{}__{}+(((~__TEMP_C)&($3))>>15)*((($2)mod(-($3))!=0)&(__TEMP_B+($2)mod(-($3))))dnl     # + -
__{}__{}__{}+((__TEMP_C&(~($3)))>>15)*((((-($2))mod($3))!=0)&(__TEMP_B-(-($2))mod($3)))dnl     # - +
__{}__{}__{}-((__TEMP_C&($3))>>15)*(-($2))mod(-($3))},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {u+:0:0},__TEMP_B,
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {u+:0:0},__TEMP_A,
__{}__{}$1, {u+},__TEMP_A+__TEMP_B,

__{}__{}$1, {m+},{__TEMP_C+__TEMP_SIGN_B*0xFFFF+(__TEMP_HI_A+__TEMP_HI_B+(__TEMP_LO_A+__TEMP_LO_B)>>8)>>8},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {u-:0:0},-__TEMP_B,
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {u-:0:0},__TEMP_A,
__{}__{}$1, {u-},__TEMP_A-__TEMP_B,

__{}__{}$1:__IS_NUM(__TEMP_A),{<?:1},{__HEX_HL($2+0x8000)<=($3+0x8000)?($2):($3)},
__{}__{}$1:__IS_NUM(__TEMP_B),{<?:1},{__HEX_HL($3+0x8000)>=($2+0x8000)?($2):($3)},
__{}__{}$1, {<?},{+(($2+0x8000)<=($3+0x8000))?($2):($3)},

__{}__{}$1:__IS_NUM(__TEMP_A),{>?:1},{__HEX_HL($2+0x8000)>=($3+0x8000)?($2):($3)},
__{}__{}$1:__IS_NUM(__TEMP_B),{>?:1},{__HEX_HL($3+0x8000)<=($2+0x8000)?($2):($3)},
__{}__{}$1, {>?},{+(($2+0x8000)>=($3+0x8000))?($2):($3)},

__{}{
__{}__{}  .error {{{$0}}} $1 $2 $3}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #    operation num_1 num_2
dnl #    operation num_1 num_2 num_3
dnl # Output:
dnl #    eval(            (num_1) operation (num_2))
dnl #    eval(((num_3)<<16+num_1) operation (num_2))
define({__EVAL_OP_NUM_NUM},{dnl
ifelse(debug,,{
debug: {$0}($@)
}){}dnl
__{}ifelse(dnl
__{}__{}$1, {d=}, {define({__TEMP},eval(0-((__HEX_HL($2)*65536+__HEX_HL($3)) ==(__HEX_HL($4)*65536+__HEX_HL($5)))))},
__{}__{}$1,{d<>}, {define({__TEMP},eval(0-((__HEX_HL($2)*65536+__HEX_HL($3)) !=(__HEX_HL($4)*65536+__HEX_HL($5)))))},
__{}__{}$1, {d<}, {define({__TEMP},eval(0-((__HEX_HL($2)*65536+__HEX_HL($3)) < (__HEX_HL($4)*65536+__HEX_HL($5)))))},
__{}__{}$1,{d<=}, {define({__TEMP},eval(0-((__HEX_HL($2)*65536+__HEX_HL($3)) <=(__HEX_HL($4)*65536+__HEX_HL($5)))))},
__{}__{}$1,{d>=}, {define({__TEMP},eval(0-((__HEX_HL($2)*65536+__HEX_HL($3)) >=(__HEX_HL($4)*65536+__HEX_HL($5)))))},
__{}__{}$1, {d>}, {define({__TEMP},eval(0-((__HEX_HL($2)*65536+__HEX_HL($3)) > (__HEX_HL($4)*65536+__HEX_HL($5)))))},

__{}__{}$1, {du=}, {define({__TEMP},ifelse(eval($2==$4),1,eval(0-(__HEX_HL($3) ==__HEX_HL($5))),0))},
__{}__{}$1,{du<>}, {define({__TEMP},ifelse(eval($2==$4),1,eval(0-(__HEX_HL($3) !=__HEX_HL($5))),1))},
__{}__{}$1, {du<}, {define({__TEMP},ifelse(eval($2==$4),1,eval(0-(__HEX_HL($3) < __HEX_HL($5))),eval(0-(__HEX_HL($2) < __HEX_HL($4)))))},
__{}__{}$1,{du<=}, {define({__TEMP},ifelse(eval($2==$4),1,eval(0-(__HEX_HL($3) <=__HEX_HL($5))),eval(0-(__HEX_HL($2) <=__HEX_HL($4)))))},
__{}__{}$1,{du>=}, {define({__TEMP},ifelse(eval($2==$4),1,eval(0-(__HEX_HL($3) >=__HEX_HL($5))),eval(0-(__HEX_HL($2) >=__HEX_HL($4)))))},
__{}__{}$1, {du>}, {define({__TEMP},ifelse(eval($2==$4),1,eval(0-(__HEX_HL($3) > __HEX_HL($5))),eval(0-(__HEX_HL($2) > __HEX_HL($4)))))},

__{}__{}$1,  {=}, {define({__TEMP},eval(0-(__16BIT_TO_SIGN($2) ==__16BIT_TO_SIGN($3))))},
__{}__{}$1, {<>}, {define({__TEMP},eval(0-(__16BIT_TO_SIGN($2) !=__16BIT_TO_SIGN($3))))},
__{}__{}$1,  {<}, {define({__TEMP},eval(0-(__16BIT_TO_SIGN($2) < __16BIT_TO_SIGN($3))))},
__{}__{}$1, {<=}, {define({__TEMP},eval(0-(__16BIT_TO_SIGN($2) <=__16BIT_TO_SIGN($3))))},
__{}__{}$1, {>=}, {define({__TEMP},eval(0-(__16BIT_TO_SIGN($2) >=__16BIT_TO_SIGN($3))))},
__{}__{}$1,  {>}, {define({__TEMP},eval(0-(__16BIT_TO_SIGN($2) > __16BIT_TO_SIGN($3))))},

__{}__{}$1, {u=}, {define({__TEMP},eval(0-(       __HEX_HL($2) =        __HEX_HL($3))))},
__{}__{}$1,{u<>}, {define({__TEMP},eval(0-(       __HEX_HL($2) !=       __HEX_HL($3))))},
__{}__{}$1, {u<}, {define({__TEMP},eval(0-(       __HEX_HL($2) <        __HEX_HL($3))))},
__{}__{}$1,{u<=}, {define({__TEMP},eval(0-(       __HEX_HL($2) <=       __HEX_HL($3))))},
__{}__{}$1,{u>=}, {define({__TEMP},eval(0-(       __HEX_HL($2) >=       __HEX_HL($3))))},
__{}__{}$1, {u>}, {define({__TEMP},eval(0-(       __HEX_HL($2) >        __HEX_HL($3))))},

__{}__{}$1,  {&}, {define({__TEMP},eval(       __HEX_HL($2) &        __HEX_HL($3)))},
__{}__{}$1,  {|}, {define({__TEMP},eval(       __HEX_HL($2) |        __HEX_HL($3)))},
__{}__{}$1,  {^}, {define({__TEMP},eval(       __HEX_HL($2) ^        __HEX_HL($3)))},

__{}__{}$1,  {*}, {define({__TEMP},eval(__16BIT_TO_SIGN($2) * __16BIT_TO_SIGN($3)))},
__{}__{}$1, {u*}, {define({__TEMP},eval(       __HEX_HL($2) *        __HEX_HL($3)))},
__{}__{}$1, {m*}, {define({__TEMP},eval(__16BIT_TO_SIGN($2) * __16BIT_TO_SIGN($3)))},
__{}__{}$1,{um*}, {define({__TEMP},eval(       __HEX_HL($2) *        __HEX_HL($3)))},

__{}__{}$1,  {/}, {define({__TEMP},eval(__16BIT_TO_SIGN($2) / __16BIT_TO_SIGN($3)))},
__{}__{}$1, {u/}, {define({__TEMP},eval(       __HEX_HL($2) /        __HEX_HL($3)))},
__{}__{}$1,{um/}, {define({__TEMP},eval(     __HEX_DEHL((($4)<<16)+$2) / __HEX_HL($3)))},
__{}__{}$1,{sm/}, {define({__TEMP},eval(__32BIT_TO_SIGN((($4)<<16)+$2) / __16BIT_TO_SIGN($3)))},
__{}__{}$1,{fm/}, {define({__TEMP},eval(__32BIT_TO_SIGN((($4)<<16)+$2) / __16BIT_TO_SIGN($3))){}dnl
__{}__{}__{}__{}__{}__{}define({__REM},eval(__32BIT_TO_SIGN((($4)<<16)+$2) % __16BIT_TO_SIGN($3))){}dnl
__{}__{}__{}__{}__{}__{}ifelse(__REM,0,{},
__{}__{}__{}__{}__{}__{}eval((__REM ^ ($3)) & 0x8000),{0},{},
__{}__{}__{}__{}__{}__{}{define({__TEMP},eval(__TEMP-1))})},

__{}__{}$1,  {%}, {define({__TEMP},eval(__16BIT_TO_SIGN($2) % __16BIT_TO_SIGN($3)))},
__{}__{}$1, {u%}, {define({__TEMP},eval(       __HEX_HL($2) %        __HEX_HL($3)))},
__{}__{}$1,{um%}, {define({__TEMP},eval(     __HEX_DEHL((($4)<<16)+$2) % __HEX_HL($3)))},
__{}__{}$1,{sm%}, {define({__TEMP},eval(__32BIT_TO_SIGN((($4)<<16)+$2) % __16BIT_TO_SIGN($3)))},
__{}__{}$1,{fm%}, {define({__TEMP},eval(__32BIT_TO_SIGN((($4)<<16)+$2) % __16BIT_TO_SIGN($3))){}dnl
__{}__{}__{}__{}__{}__{}ifelse(__TEMP,0,{},
__{}__{}__{}__{}__{}__{}eval((__TEMP ^ ($3)) & 0x8000),{0},{},
__{}__{}__{}__{}__{}__{}{define({__TEMP},eval($3+__TEMP))})},

__{}__{}$1,  {+}, {define({__TEMP},eval(__16BIT_TO_SIGN($2) + __16BIT_TO_SIGN($3)))},
__{}__{}$1, {u+}, {define({__TEMP},eval(       __HEX_HL($2) +        __HEX_HL($3)))},
__{}__{}$1, {m+}, {define({__TEMP},__HEX_DE(__32BIT_TO_SIGN((($4)<<16)+$2) + __16BIT_TO_SIGN($3)))},

__{}__{}$1,  {-}, {define({__TEMP},eval(__16BIT_TO_SIGN($2) - __16BIT_TO_SIGN($3)))},
__{}__{}$1, {u-}, {define({__TEMP},eval(       __HEX_HL($2) -        __HEX_HL($3)))},

__{}__{}$1, {<?}, {define({__TEMP},ifelse(eval(__16BIT_TO_SIGN($2)<=__16BIT_TO_SIGN($3)),{1},__16BIT_TO_SIGN($2),__16BIT_TO_SIGN($3)))},
__{}__{}$1, {>?}, {define({__TEMP},ifelse(eval(__16BIT_TO_SIGN($2)>=__16BIT_TO_SIGN($3)),{1},__16BIT_TO_SIGN($2),__16BIT_TO_SIGN($3)))},

__{}{define({__TEMP},{})
__{}__{}  .error {$0} __REMOVE_COMMA($@)}){}dnl
ifelse(1,0,{errprint({
$0($@)
__TEMP:>}__TEMP{<
})}){}dnl
__{}ifelse(dnl
__{}__{}$1,{um*},{__HEX_DE(__TEMP),__HEX_HL(__TEMP)},
__{}__{}$1,{m*},{__HEX_DE(__TEMP),__16BIT_TO_SIGN(__TEMP)},
__{}__{}substr($1,0,1),{u},__TEMP,
__{}__{}__16BIT_TO_SIGN(__TEMP)){}dnl
}){}dnl
dnl
dnl
dnl
dnl # define({__LINKER},{sjasmplus}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #    operation num_1 num_2
dnl #    operation num_1 num_2 num_3
dnl # Output:
dnl #    eval(            (num_1) operation (num_2))
dnl #    eval(            (num_1) operation (num_2)),eval(            (num_1) operation (num_2))
dnl #    eval(((num_1)<<16+num_2) operation (num_3))
dnl #    eval(((num_1)<<16+num_2) operation (num_3)),eval(((num_1)<<16+num_2) operation (num_3))
define({__EVAL_S16},{dnl
ifelse(1,0,{errprint(dnl
__{}define({__TEMP_A},{__HEX_HL($2)}){}dnl
__{}define({__TEMP_B},{__HEX_HL($3)}){}dnl
__{}define({__TEMP_C},{__HEX_HL($4)}){}dnl
__{}ifelse(__TEMP_A,,{define({__TEMP_A},{($2)})}){}dnl
__{}ifelse(__TEMP_B,,{define({__TEMP_B},{($3)})}){}dnl
__{}ifelse(__TEMP_C,,{define({__TEMP_C},{($4)})}){}dnl
{
$0($*)
  IS_NUM __TEMP_A: }__IS_NUM($2){ >}__TEMP_A{<
  IS_NUM __TEMP_B: }__IS_NUM($3){ >}__TEMP_B{<
  IS_NUM __TEMP_C: }ifelse($#,4,__IS_NUM($4),1){ >} __TEMP_C{<
  __LINKER:>}__LINKER{<
})}){}dnl
__{}ifelse(__IS_NUM($2):__IS_NUM($3){:}ifelse($#,4,__IS_NUM($4),1),{1:1:1},{dnl
__{}__{}ifelse(dnl
__{}__{}__{}$1,    {m+},{__EVAL_OP_NUM_NUM( m+,$3,$4,$2),__EVAL_OP_NUM_NUM(  +,$3,$4,$2)},
__{}__{}__{}$1,{um/mod},{__EVAL_OP_NUM_NUM(um%,$3,$4,$2),__EVAL_OP_NUM_NUM(um/,$3,$4,$2)},
__{}__{}__{}$1,{sm/rem},{__EVAL_OP_NUM_NUM(sm%,$3,$4,$2),__EVAL_OP_NUM_NUM(sm/,$3,$4,$2)},
__{}__{}__{}$1,{fm/mod},{__EVAL_OP_NUM_NUM(fm%,$3,$4,$2),__EVAL_OP_NUM_NUM(fm/,$3,$4,$2)},
__{}__{}__{}$1,  {/mod},{__EVAL_OP_NUM_NUM(  %,   $2,$3),__EVAL_OP_NUM_NUM(  /,   $2,$3)},
__{}__{}__{}$1, {u/mod},{__EVAL_OP_NUM_NUM( u%,   $2,$3),__EVAL_OP_NUM_NUM( u/,   $2,$3)},
__{}__{}__{}            {__EVAL_OP_NUM_NUM( $1,   $2,$3)}){}dnl
__{}},
__{}__LINKER,{sjasmplus},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__{}$1,    {m+},{__EVAL_OP_NUM_XXX_SJASMPLUS( m+,$3,$4,$2),__EVAL_OP_NUM_XXX_SJASMPLUS(  +,$3,$4,$2)},
__{}__{}__{}$1,{um/mod},{__EVAL_OP_NUM_XXX_SJASMPLUS(um%,$3,$4,$2),__EVAL_OP_NUM_XXX_SJASMPLUS(um/,$3,$4,$2)},
__{}__{}__{}$1,{sm/rem},{__EVAL_OP_NUM_XXX_SJASMPLUS(sm%,$3,$4,$2),__EVAL_OP_NUM_XXX_SJASMPLUS(sm/,$3,$4,$2)},
__{}__{}__{}$1,{fm/mod},{__EVAL_OP_NUM_XXX_SJASMPLUS(fm%,$3,$4,$2),__EVAL_OP_NUM_XXX_SJASMPLUS(fm/,$3,$4,$2)},
__{}__{}__{}$1,  {/mod},{__EVAL_OP_NUM_XXX_SJASMPLUS(  %,   $2,$3),__EVAL_OP_NUM_XXX_SJASMPLUS(  /,   $2,$3)},
__{}__{}__{}$1, {u/mod},{__EVAL_OP_NUM_XXX_SJASMPLUS( u%,   $2,$3),__EVAL_OP_NUM_XXX_SJASMPLUS( u/,   $2,$3)},
__{}__{}__{}            {__EVAL_OP_NUM_XXX_SJASMPLUS( $1,   $2,$3)}){}dnl
__{}},
__{}{dnl
__{}__{}ifelse(dnl
__{}__{}__{}$1,    {m+},{__EVAL_OP_NUM_XXX_PASMO( m+,$3,$4,$2),__EVAL_OP_NUM_XXX_PASMO(  +,$3,$4,$2)},
__{}__{}__{}$1,{um/mod},{__EVAL_OP_NUM_XXX_PASMO(um%,$3,$4,$2),__EVAL_OP_NUM_XXX_PASMO(um/,$3,$4,$2)errprint({
  .warning: Pasmo does not support 32 bit numbers and M4 does not know all values(They can only emulate 28-bit/12-bit or 16-bit/16-bit without checking the range): "}$2<<16+$3 $4 um/mod{"
})},
__{}__{}__{}$1,{sm/rem},{__EVAL_OP_NUM_XXX_PASMO(sm%,$3,$4,$2),__EVAL_OP_NUM_XXX_PASMO(sm/,$3,$4,$2)errprint({
  .warning: Pasmo does not support 32 bit numbers and M4 does not know all values(They can only emulate 28-bit/12-bit or 16-bit/16-bit without checking the range): "}$2<<16+$3 $4 sm/rem{"
})},
__{}__{}__{}$1,{fm/mod},{__EVAL_OP_NUM_XXX_PASMO(fm%,$3,$4,$2),__EVAL_OP_NUM_XXX_PASMO(fm/,$3,$4,$2)errprint({
  .warning: Pasmo does not support 32 bit numbers and M4 does not know all values(They can only emulate 16-bit/16-bit without checking the range): "}$2<<16+$3 $4 fm/mod{"
})},
__{}__{}__{}$1,  {/mod},{__EVAL_OP_NUM_XXX_PASMO(  %,   $2,$3),__EVAL_OP_NUM_XXX_PASMO(  /,   $2,$3)},
__{}__{}__{}$1, {u/mod},{__EVAL_OP_NUM_XXX_PASMO( u%,   $2,$3),__EVAL_OP_NUM_XXX_PASMO( u/,   $2,$3)},
__{}__{}__{}            {__EVAL_OP_NUM_XXX_PASMO( $1,   $2,$3)}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #    $1 ...operation
dnl #    $2 ...hi16(num_1)
dnl #    $3 ...lo16(num_1)
dnl #    $4 ...hi16(num_2)
dnl #    $5 ...lo16(num_2)
dnl # Output:
dnl #    eval(            (num_1) operation (num_2))
define({__EVAL_S32},{dnl
ifelse(debug,,{
debug: __eval_s32($@)}){}dnl
__{}
__{}ifelse(__IS_NUM($2):__IS_NUM($3):ifelse($#,3,1,__IS_NUM($4)):ifelse($#,3,1,__IS_NUM($5)),{1:1:1:1},{dnl
__{}__{}ifelse(dnl
__{}__{}__{}$1,   {d&},{__HEX_DE(__HEX_DEHL(__HEX_HL($2)*65536+__HEX_HL($3)) & __HEX_DEHL(__HEX_HL($4)*65536+__HEX_HL($5))),__HEX_HL(__HEX_HL($3) & __HEX_HL($5))},
__{}__{}__{}$1,   {d|},{__HEX_DE(__HEX_DEHL(__HEX_HL($2)*65536+__HEX_HL($3)) | __HEX_DEHL(__HEX_HL($4)*65536+__HEX_HL($5))),__HEX_HL(__HEX_HL($3) | __HEX_HL($5))},
__{}__{}__{}$1,   {d^},{__HEX_DE(__HEX_DEHL(__HEX_HL($2)*65536+__HEX_HL($3)) ^ __HEX_DEHL(__HEX_HL($4)*65536+__HEX_HL($5))),__HEX_HL(__HEX_HL($3) ^ __HEX_HL($5))},
__{}__{}__{}$1,   {d+},{__HEX_DE((__HEX_HL($2)+__HEX_HL($4))*65536+__HEX_HL($3)+__HEX_HL($5)),__HEX_HL(__HEX_HL($3)+__HEX_HL($5))},
__{}__{}__{}$1,   {d-},{__HEX_DE((__HEX_HL($2)-__HEX_HL($4))*65536+__HEX_HL($3)-__HEX_HL($5)),__HEX_HL(__HEX_HL($3)-__HEX_HL($5))},
__{}__{}__{}$1, {dabs},{ifelse(__HEX_HL(0x8000 & ($2)),0x0000,{$2,$3},{__HEX_DE(-(__HEX_HL($2)*65536+__HEX_HL($3))),__HEX_HL(-__HEX_HL($3))})},
__{}__{}__{}$1, {dneg},{__HEX_DE(-(__HEX_HL($2)*65536+__HEX_HL($3))),__HEX_HL(-__HEX_HL($3))},
__{}__{}__{}$1,  {d<?},{ifelse(eval(__HEX_DEHL(__HEX_HL($2)*65536+__HEX_HL($3))<=__HEX_DEHL(__HEX_HL($4)*65536+__HEX_HL($5))),{1},{$2,$3},{$4,$5})},
__{}__{}__{}$1,  {d>?},{ifelse(eval(__HEX_DEHL(__HEX_HL($2)*65536+__HEX_HL($3))>=__HEX_DEHL(__HEX_HL($4)*65536+__HEX_HL($5))),{1},{$2,$3},{$4,$5})},
__{}__{}__{}            {__EVAL_OP_NUM_NUM($@)}){}dnl
__{}},
__{}{.error {__EVAL_S32}{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__INC_TOKEN_COUNT},{define({__COUNT_TOKEN},eval(__COUNT_TOKEN+1))}){}dnl
dnl define({__INC_TOKEN_COUNT},ifdef({__COUNT_TOKEN},{define({__COUNT_TOKEN},eval(__COUNT_TOKEN+1))},{define({__COUNT_TOKEN},1)})){}dnl
dnl
dnl
define({__ADD_TOKEN},
    {ifdef({__COUNT_TOKEN},
        {ifelse(dnl
a,,,
            __T_NAME(0):$1,{__TOKEN_EQ:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_EQ_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_NE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_NE_WHILE},__T_INFO(0){ }$2)},

            __T_NAME(0):$1,{__TOKEN_LT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_LT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_GT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_GT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_LE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_LE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_GE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_GE_WHILE},__T_INFO(0){ }$2)},

            __T_NAME(0):$1,{__TOKEN_ULT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_ULT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_UGT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_UGT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_ULE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_ULE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_UGE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_UGE_WHILE},__T_INFO(0){ }$2)},

__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_EQ,                {__SET_TOKEN({__TOKEN_0EQ},  __T_INFO(0){ }$2)},
__T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,  __TOKEN_CFETCH:__TOKEN_PUSHS:1:0x0000:__TOKEN_CEQ,  {define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_CFETCH_0CEQ},__TEMP)},
__T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,  __TOKEN_CFETCH:__TOKEN_PUSHS:1:0x0000:__TOKEN_CNE,  {define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_CFETCH_0CNE},__TEMP)},
__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_CEQ,               {__SET_TOKEN({__TOKEN_0CEQ}, __T_INFO(0){ }$2)},
__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_CNE,               {__SET_TOKEN({__TOKEN_0CNE}, __T_INFO(0){ }$2)},

            __T_NAME(0):$1,{__TOKEN_EQ:__TOKEN_IF},{__SET_TOKEN({__TOKEN_EQ_IF},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_NE:__TOKEN_IF},{__SET_TOKEN({__TOKEN_NE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_LT:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSHS:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_LT_IF},__T_INFO(0){ <}$2, __T_ARRAY(0))},{__SET_TOKEN({__TOKEN_LT_IF},__T_INFO(0){ }$2)})},
            __T_NAME(0):$1,{__TOKEN_GT:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSHS:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_GT_IF},__T_INFO(0){ >}$2, __T_ARRAY(0))},{__SET_TOKEN({__TOKEN_GT_IF},__T_INFO(0){ }$2)})},
            __T_NAME(0):$1,{__TOKEN_LE:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSHS:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_LE_IF},__T_INFO(0){ <=}$2,__T_ARRAY(0))},{__SET_TOKEN({__TOKEN_LE_IF},__T_INFO(0){ }$2)})},
            __T_NAME(0):$1,{__TOKEN_GE:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSHS:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_GE_IF},__T_INFO(0){ >=}$2,__T_ARRAY(0))},{__SET_TOKEN({__TOKEN_GE_IF},__T_INFO(0){ }$2)})},

            __T_NAME(0):$1,{__TOKEN_UEQ:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_UEQ_IF},__T_INFO(0){ u=}$2, __T_ARRAY(0))},{__SET_TOKEN({__TOKEN_UEQ_IF},__T_INFO(0){ }$2)})},
            __T_NAME(0):$1,{__TOKEN_UNE:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_UNE_IF},__T_INFO(0){ u<>}$2,__T_ARRAY(0))},{__SET_TOKEN({__TOKEN_UNE_IF},__T_INFO(0){ }$2)})},
            __T_NAME(0):$1,{__TOKEN_ULT:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_ULT_IF},__T_INFO(0){ u<}$2, __T_ARRAY(0))},{__SET_TOKEN({__TOKEN_ULT_IF},__T_INFO(0){ }$2)})},
            __T_NAME(0):$1,{__TOKEN_UGT:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_UGT_IF},__T_INFO(0){ u>}$2, __T_ARRAY(0))},{__SET_TOKEN({__TOKEN_UGT_IF},__T_INFO(0){ }$2)})},
            __T_NAME(0):$1,{__TOKEN_ULE:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_ULE_IF},__T_INFO(0){ u<=}$2,__T_ARRAY(0))},{__SET_TOKEN({__TOKEN_ULE_IF},__T_INFO(0){ }$2)})},
            __T_NAME(0):$1,{__TOKEN_UGE:__TOKEN_IF},{ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_UGE_IF},__T_INFO(0){ u>=}$2,__T_ARRAY(0))},{__SET_TOKEN({__TOKEN_UGE_IF},__T_INFO(0){ }$2)})},

dnl # _1...
_1,,,

            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_ADD:1:__TOKEN_1ADD},   {__SET_TOKEN({__TOKEN_PUSH_ADD}, __T_INFO(0){ }$2,__T_ARRAY_1(0)+1)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_ADD:1:__TOKEN_2ADD},   {__SET_TOKEN({__TOKEN_PUSH_ADD}, __T_INFO(0){ }$2,__T_ARRAY_1(0)+2)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_SUB:1:__TOKEN_1ADD},   {__SET_TOKEN({__TOKEN_PUSH_SUB}, __T_INFO(0){ }$2,__T_ARRAY_1(0)-1)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_SUB:1:__TOKEN_2ADD},   {__SET_TOKEN({__TOKEN_PUSH_SUB}, __T_INFO(0){ }$2,__T_ARRAY_1(0)-2)},

            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_ADD:1:__TOKEN_1SUB},   {__SET_TOKEN({__TOKEN_PUSH_ADD}, __T_INFO(0){ }$2,__T_ARRAY_1(0)-1)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_ADD:1:__TOKEN_2SUB},   {__SET_TOKEN({__TOKEN_PUSH_ADD}, __T_INFO(0){ }$2,__T_ARRAY_1(0)-2)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_SUB:1:__TOKEN_1SUB},   {__SET_TOKEN({__TOKEN_PUSH_SUB}, __T_INFO(0){ }$2,__T_ARRAY_1(0)+1)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_SUB:1:__TOKEN_2SUB},   {__SET_TOKEN({__TOKEN_PUSH_SUB}, __T_INFO(0){ }$2,__T_ARRAY_1(0)+2)},

            __T_NAME(0):$1,{__TOKEN_2ADD:__TOKEN_1ADD},       {__SET_TOKEN({__TOKEN_PUSH_ADD}, __T_INFO(0){ }$2,3)},
            __T_NAME(0):$1,{__TOKEN_2SUB:__TOKEN_1SUB},       {__SET_TOKEN({__TOKEN_PUSH_SUB}, __T_INFO(0){ }$2,3)},

            __T_NAME(0):$1,{__TOKEN_2ADD:__TOKEN_2ADD},       {__SET_TOKEN({__TOKEN_PUSH_ADD}, __T_INFO(0){ }$2,4)},
            __T_NAME(0):$1,{__TOKEN_2SUB:__TOKEN_2SUB},       {__SET_TOKEN({__TOKEN_PUSH_SUB}, __T_INFO(0){ }$2,4)},

            __T_NAME(0):$1,{__TOKEN_1SUB:__TOKEN_2ADD},       {__SET_TOKEN({__TOKEN_1ADD}, __T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_2ADD:__TOKEN_1SUB},       {__SET_TOKEN({__TOKEN_1ADD}, __T_INFO(0){ }$2)},

            __T_NAME(0):$1,{__TOKEN_1ADD:__TOKEN_2SUB},       {__SET_TOKEN({__TOKEN_1SUB}, __T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_2SUB:__TOKEN_1ADD},       {__SET_TOKEN({__TOKEN_1SUB}, __T_INFO(0){ }$2)},

            __T_NAME(0):$1,{__TOKEN_1SUB:__TOKEN_1ADD},       {__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,{__TOKEN_1ADD:__TOKEN_1SUB},       {__DELETE_LAST_TOKEN},
            
            __T_NAME(0):$1,{__TOKEN_2SUB:__TOKEN_2ADD},       {__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,{__TOKEN_2ADD:__TOKEN_2SUB},       {__DELETE_LAST_TOKEN},

dnl # _2...
_2,,,
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_DADD},{__SET_TOKEN({__TOKEN_2DUP_DADD},__T_INFO(0){ }$2)},
            

            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CEQ}, {__SET_TOKEN({__TOKEN_2DUP_CEQ}, __T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CNE}, {__SET_TOKEN({__TOKEN_2DUP_CNE}, __T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CULT},{__SET_TOKEN({__TOKEN_2DUP_CULT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CUGT},{__SET_TOKEN({__TOKEN_2DUP_CUGT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CULE},{__SET_TOKEN({__TOKEN_2DUP_CULE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CUGE},{__SET_TOKEN({__TOKEN_2DUP_CUGE},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HEQ}, {__SET_TOKEN({__TOKEN_2DUP_HEQ}, __T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HNE}, {__SET_TOKEN({__TOKEN_2DUP_HNE}, __T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HULT},{__SET_TOKEN({__TOKEN_2DUP_HULT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HUGT},{__SET_TOKEN({__TOKEN_2DUP_HUGT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HULE},{__SET_TOKEN({__TOKEN_2DUP_HULE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HUGE},{__SET_TOKEN({__TOKEN_2DUP_HUGE},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_EQ},{__SET_TOKEN({__TOKEN_2DUP_EQ},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_NE},{__SET_TOKEN({__TOKEN_2DUP_NE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_LT},{__SET_TOKEN({__TOKEN_2DUP_LT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_GT},{__SET_TOKEN({__TOKEN_2DUP_GT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_LE},{__SET_TOKEN({__TOKEN_2DUP_LE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_GE},{__SET_TOKEN({__TOKEN_2DUP_GE},__T_INFO(0){ }$2)},

            __T_NAME(0):$1,{__TOKEN_2DUP_EQ:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_EQ_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_2DUP_NE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_NE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_2DUP_LT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_LT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_2DUP_GT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_GT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_2DUP_LE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_LE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_2DUP_GE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_GE_WHILE},__T_INFO(0){ }$2)},

            __T_NAME(0):$1,{__TOKEN_2DUP_EQ:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_2DUP_EQ_UNTIL},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_2DROP-__TOKEN_DROP},{__SET_TOKEN({__TOKEN_3DROP},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_2OVER-__TOKEN_2OVER},{__SET_TOKEN({__TOKEN_4DUP},__T_INFO(0){ }$2)},

            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT_1ADD_NROT:__TOKEN_2OVER:__TOKEN_NIP},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1ADD_NROT_2OVER_NIP},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT_1SUB_NROT:__TOKEN_2OVER:__TOKEN_NIP},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1SUB_NROT_2OVER_NIP},__TEMP)},
            __T_NAME(0)-$1,{__TOKEN_2OVER-__TOKEN_NIP},{__SET_TOKEN({__TOKEN_2OVER_NIP},__T_INFO(0){ }$2)},
            
            __T_NAME(0)-$1,{__TOKEN_2OVER-__TOKEN_DADD},{__SET_TOKEN({__TOKEN_2OVER_DADD},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2OVER-__TOKEN_DSUB},{__SET_TOKEN({__TOKEN_2OVER_DSUB},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_2DROP},{__SET_TOKEN({__TOKEN_2NIP},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DSUB},{__SET_TOKEN({__TOKEN_2SWAP_DSUB},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DEQ},{__SET_TOKEN({__TOKEN_DEQ},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DNE},{__SET_TOKEN({__TOKEN_DNE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DLT},{__SET_TOKEN({__TOKEN_DGT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DGT},{__SET_TOKEN({__TOKEN_DLT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DLE},{__SET_TOKEN({__TOKEN_DGE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DGE},{__SET_TOKEN({__TOKEN_DLE},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DUEQ},{__SET_TOKEN({__TOKEN_DUEQ},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DUNE},{__SET_TOKEN({__TOKEN_DUNE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DULT},{__SET_TOKEN({__TOKEN_DUGT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DUGT},{__SET_TOKEN({__TOKEN_DULT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DULE},{__SET_TOKEN({__TOKEN_DUGE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DUGE},{__SET_TOKEN({__TOKEN_DULE},__T_INFO(0){ }$2)},

            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,  __TOKEN_PUSHS:1:__TOKEN_2DUP, {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),__T_REVERSE_2(0),__T_REVERSE_1(0))},

dnl # _3..
_3,,,
            
            __T_NAME(0):$1,{__TOKEN_3_PICK:__TOKEN_3_PICK},{__SET_TOKEN({__TOKEN_2OVER},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_3DUP:__TOKEN_ROT},     {__SET_TOKEN({__TOKEN_3DUP_ROT},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_3DUP:__TOKEN_NROT},    {__SET_TOKEN({__TOKEN_3DUP_NROT},__T_INFO(0){ }$2)},

dnl # _4..
_4,,,
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DEQ},{__SET_TOKEN({__TOKEN_4DUP_DEQ},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DNE},{__SET_TOKEN({__TOKEN_4DUP_DNE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DLT},{__SET_TOKEN({__TOKEN_4DUP_DLT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DGT},{__SET_TOKEN({__TOKEN_4DUP_DGT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DLE},{__SET_TOKEN({__TOKEN_4DUP_DLE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DGE},{__SET_TOKEN({__TOKEN_4DUP_DGE},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DUEQ},{__SET_TOKEN({__TOKEN_4DUP_DEQ},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DUNE},{__SET_TOKEN({__TOKEN_4DUP_DNE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DULT},{__SET_TOKEN({__TOKEN_4DUP_DULT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DUGT},{__SET_TOKEN({__TOKEN_4DUP_DUGT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DULE},{__SET_TOKEN({__TOKEN_4DUP_DULE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DUGE},{__SET_TOKEN({__TOKEN_4DUP_DUGE},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DROP},{__SET_TOKEN({__TOKEN_4DUP_DROP},__T_INFO(0){ }$2)},

dnl # A...

dnl # B...

dnl # C...
c...,,,
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE:__TOKEN_2OVER_NIP:__TOKEN_CFETCH},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE_2OVER_NIP_CFETCH},__TEMP)},

           __T_NAME(0):$1,                              __TOKEN_CFETCH:__TOKEN_0CNE,               {__SET_TOKEN({__TOKEN_CFETCH_0CNE},__T_INFO(0){ }$2)},
           __T_NAME(0):$1,                              __TOKEN_CFETCH:__TOKEN_0CEQ,               {__SET_TOKEN({__TOKEN_CFETCH_0CEQ},__T_INFO(0){ }$2)},

dnl # DUP
dup,,,

__T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP:__TOKEN_DUP_TYPE_I:__TOKEN_DROP,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_TYPE_I},__T_INFO(1){ }__T_INFO(0),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},

            __T_NAME(0):$1,{__TOKEN_DUP:__TOKEN_DOT},               {__SET_TOKEN({__TOKEN_DUP_DOT},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_IF},                {__SET_TOKEN({__TOKEN_DUP_IF},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_I},                 {__SET_TOKEN({__TOKEN_DUP_I},__T_INFO(0){ }$2,$3)},

            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_DUP},               {__SET_TOKEN({__TOKEN_DUP_DUP},__T_INFO(0){ }$2)},
__T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP:__TOKEN_DUP_EMIT:__TOKEN_DROP,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_EMIT},__T_INFO(1){ }__T_INFO(0),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},

            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_TO_R},              {__SET_TOKEN({__TOKEN_DUP_TO_R},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_FETCH},             {__SET_TOKEN({__TOKEN_DUP_FETCH},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUP_FETCH-__TOKEN_SWAP},        {__SET_TOKEN({__TOKEN_DUP_FETCH_SWAP},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_CFETCH},            {__SET_TOKEN({__TOKEN_DUP_CFETCH},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUP_CFETCH-__TOKEN_SWAP},       {__SET_TOKEN({__TOKEN_DUP_CFETCH_SWAP},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_SPACE},         {__SET_TOKEN({__TOKEN_DUP_SPACE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUP_SPACE-__TOKEN_DOT},     {__SET_TOKEN({__TOKEN_DUP_SPACE_DOT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUP_SPACE-__TOKEN_UDOT},    {__SET_TOKEN({__TOKEN_DUP_SPACE_UDOT},__T_INFO(0){ }$2)},

            __T_NAME(0):$1,                         __TOKEN_DUP:__TOKEN_UNTIL,                   {__SET_TOKEN({__TOKEN_DUP_UNTIL},__T_INFO(0){ }$2)},
            __T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP:__TOKEN_0EQ:__TOKEN_UNTIL,       {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_0EQ_UNTIL},       __T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP_CFETCH:__TOKEN_0EQ:__TOKEN_UNTIL,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_CFETCH_0EQ_UNTIL},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP_CFETCH:__TOKEN_0EQ:__TOKEN_WHILE,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_CFETCH_0EQ_WHILE},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},

dnl # D...
d...,,,
            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_DROP},         {__SET_TOKEN({__TOKEN_2DROP},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_2DROP},        {__SET_TOKEN({__TOKEN_3DROP},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_RAS},          {__SET_TOKEN({__TOKEN_DROP_RAS},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_DUP},          {__SET_TOKEN({__TOKEN_DROP_DUP},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_OVER},         {__SET_TOKEN({__TOKEN_DROP_OVER},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_I},            {__SET_TOKEN({__TOKEN_DROP_I},__T_INFO(0){ }$2,$3)},
            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_J},            {__SET_TOKEN({__TOKEN_DROP_J},__T_INFO(0){ }$2,shift(shift($@)))},
            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_K},            {__SET_TOKEN({__TOKEN_DROP_K},__T_INFO(0){ }$2,shift(shift($@)))},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_R_FETCH},      {__SET_TOKEN({__TOKEN_DROP_R_FETCH},__T_INFO(0){ }$2)},



            __T_NAME(0)-$1,{__TOKEN_DEQ-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DEQ_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DNE-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DNE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DLT-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DLT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DGT-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DGT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DLE-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DLE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DGE-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DGE_IF},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DEQ-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DEQ_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DNE-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DNE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DLT-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DLT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DGT-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DGT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DLE-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DLE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DGE-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DGE_WHILE},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DUEQ-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DEQ_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUNE-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DNE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DULT-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DULT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUGT-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DUGT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DULE-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DULE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUGE-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DUGE_IF},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_DUEQ-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DEQ_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUNE-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DNE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DULT-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DULT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUGT-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DUGT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DULE-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DULE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_DUGE-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DUGE_WHILE},__T_INFO(0){ }$2)},

            __T_NAME(0):$1,   __TOKEN_PD0EQ:__TOKEN_WHILE, {__SET_TOKEN({__TOKEN_PD0EQ_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,   __TOKEN_PD0NE:__TOKEN_WHILE, {__SET_TOKEN({__TOKEN_PD0NE_WHILE},__T_INFO(0){ }$2)},

            __T_NAME(0):$1,   __TOKEN_PD0EQ:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PD0EQ_IF},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,   __TOKEN_PD0NE:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PD0NE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,   __TOKEN_PDEQ:__TOKEN_IF,  {__SET_TOKEN({__TOKEN_PDEQ_IF},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,   __TOKEN_PDNE:__TOKEN_IF,  {__SET_TOKEN({__TOKEN_PDNE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,   __TOKEN_PDULT:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PDULT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,   __TOKEN_PDUGT:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PDUGT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,   __TOKEN_PDULE:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PDULE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,   __TOKEN_PDUGE:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PDUGE_IF},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_D0EQ},         {__SET_TOKEN({__TOKEN_2DUP_D0EQ},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_D0NE},         {__SET_TOKEN({__TOKEN_2DUP_D0NE},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_2DUP_D0EQ-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_2DUP_D0EQ_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP_D0NE-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_2DUP_D0NE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP_D0EQ-__TOKEN_WHILE},      {__SET_TOKEN({__TOKEN_2DUP_D0EQ_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_2DUP_D0NE-__TOKEN_WHILE},      {__SET_TOKEN({__TOKEN_2DUP_D0NE_WHILE},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_D0EQ-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_D0EQ_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_D0NE-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_D0NE_IF},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_4DUP_DEQ-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DEQ_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DNE-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DNE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DLT-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DLT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DGT-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DGT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DLE-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DLE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DGE-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DGE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DULT-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_4DUP_DULT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DUGT-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_4DUP_DUGT_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DULE-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_4DUP_DULE_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DUGE-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_4DUP_DUGE_IF},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_4DUP_DEQ-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DEQ_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DNE-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DNE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DLT-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DLT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DGT-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DGT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DLE-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DLE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DGE-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DGE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DULT-__TOKEN_WHILE},   {__SET_TOKEN({__TOKEN_4DUP_DULT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DUGT-__TOKEN_WHILE},   {__SET_TOKEN({__TOKEN_4DUP_DUGT_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DULE-__TOKEN_WHILE},   {__SET_TOKEN({__TOKEN_4DUP_DULE_WHILE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DUGE-__TOKEN_WHILE},   {__SET_TOKEN({__TOKEN_4DUP_DUGE_WHILE},__T_INFO(0){ }$2)},

            __T_NAME(0)=__GET_LOOP_TYPE(LOOP_STACK):$1,__TOKEN_I=S:__TOKEN_DUP,  {__SET_TOKEN({__TOKEN_DUP_DUP},__T_INFO(0){ }$2)},

dnl # E...
dnl # F...
f...,,,
            __T_NAME(0)-$1,{__TOKEN_FOR-__TOKEN_I},             {__SET_TOKEN({__TOKEN_FOR_I},__T_INFO(0){ }$2,__T_ARRAY(0))},
dnl # G...
dnl # H...
h....,,,
            __T_NAME(0):$1,         __TOKEN_HEX:__TOKEN_UDOT,   {__SET_TOKEN({__TOKEN_HEX_UDOT},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,         __TOKEN_HEX:__TOKEN_UDDOT,  {__SET_TOKEN({__TOKEN_HEX_UDDOT},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,         __TOKEN_HEX:__TOKEN_PUDOT,  {__SET_TOKEN({__TOKEN_HEX_PUDOT},__T_INFO(0){ }$2,$3)},

dnl # I...
dnl # J...
dnl # K...
dnl # L...
dnl # M...
dnl # N...
n...,,,

            __T_NAME(0)-$1,{__TOKEN_NROT-__TOKEN_SWAP},{__SET_TOKEN({__TOKEN_NROT_SWAP},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_NROT-__TOKEN_NIP},{__SET_TOKEN({__TOKEN_NROT_NIP},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_NROT-__TOKEN_2SWAP},{__SET_TOKEN({__TOKEN_NROT_2SWAP},__T_INFO(0){ }$2)},

dnl # O...
o...,,,
            __T_NAME(0)-$1,{__TOKEN_OVER-__TOKEN_OVER},{__SET_TOKEN({__TOKEN_2DUP},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER-__TOKEN_SWAP},{__SET_TOKEN({__TOKEN_OVER_SWAP},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_AND}, {__SET_TOKEN({__TOKEN_OVER_SWAP_AND}, __T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_OR},  {__SET_TOKEN({__TOKEN_OVER_SWAP_OR},  __T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_XOR}, {__SET_TOKEN({__TOKEN_OVER_SWAP_XOR}, __T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_CAND},{__SET_TOKEN({__TOKEN_OVER_SWAP_CAND},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_COR}, {__SET_TOKEN({__TOKEN_OVER_SWAP_COR}, __T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_CXOR},{__SET_TOKEN({__TOKEN_OVER_SWAP_CXOR},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HAND},{__SET_TOKEN({__TOKEN_OVER_SWAP_HAND},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HOR}, {__SET_TOKEN({__TOKEN_OVER_SWAP_HOR}, __T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HXOR},{__SET_TOKEN({__TOKEN_OVER_SWAP_HXOR},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_ADD}, {__SET_TOKEN({__TOKEN_OVER_SWAP_ADD}, __T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_SUB}, {__SET_TOKEN({__TOKEN_OVER_SWAP_SUB}, __T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_CADD},{__SET_TOKEN({__TOKEN_OVER_SWAP_CADD},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_CSUB},{__SET_TOKEN({__TOKEN_OVER_SWAP_CSUB},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HADD},{__SET_TOKEN({__TOKEN_OVER_SWAP_HADD},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HSUB},{__SET_TOKEN({__TOKEN_OVER_SWAP_HSUB},__T_INFO(0){ }$2)},
            

            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1,
               __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_OVER:__TOKEN_CFETCH,
                  {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_OVER_CFETCH_OVER_CFETCH},__T_INFO(2){ }__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},

            __T_NAME(0)-$1,{__TOKEN_OVER_CFETCH_OVER_CFETCH-__TOKEN_CEQ},{__SET_TOKEN({__TOKEN_OVER_CFETCH_OVER_CFETCH_CEQ},__T_INFO(0){ }$2)},

            __T_NAME(0):$1,                              __TOKEN_OVER:__TOKEN_UNTIL,               {__SET_TOKEN({__TOKEN_OVER_UNTIL},__T_INFO(0){ }$2)},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_UNTIL,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_CFETCH_UNTIL},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_WHILE,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_CFETCH_WHILE},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1,  __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_0EQ:__TOKEN_UNTIL,   {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_OVER_CFETCH_0EQ_UNTIL},__T_INFO(2){ }__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1,  __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_0EQ:__TOKEN_WHILE,   {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_OVER_CFETCH_0EQ_WHILE},__T_INFO(2){ }__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},

            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_OVER:__TOKEN_0EQ:__TOKEN_UNTIL,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_0EQ_UNTIL},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                              __TOKEN_2OVER_NIP:__TOKEN_UNTIL,            {__SET_TOKEN({__TOKEN_2OVER_NIP_UNTIL},__T_INFO(0){ }$2)},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_2OVER_NIP:__TOKEN_0EQ:__TOKEN_UNTIL,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_NIP_0EQ_UNTIL},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_2OVER_NIP:__TOKEN_CFETCH_0CEQ:__TOKEN_UNTIL,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_NIP_CFETCH_0CEQ_UNTIL},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_2OVER_NIP:__TOKEN_CFETCH_0CEQ:__TOKEN_WHILE,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_NIP_CFETCH_0CEQ_WHILE},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},

dnl # P
p,,,

            __T_NAME(0):$1,   __TOKEN_PDSUB:__TOKEN_NEGATE, {__SET_TOKEN({__TOKEN_PDSUB_NEGATE},__T_INFO(0){ }$2)},

dnl # PUSHDOT
pushdot,,,
            __T_NAME(0):$1:__IS_NUM($3),                 __TOKEN_PUSHS:__TOKEN_PUSHDOT:1,                      {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),__HEX_DE($3),__HEX_HL($3))},
            __T_NAME(0):$1:__IS_MEM_REF($3),             __TOKEN_PUSHS:__TOKEN_PUSHDOT:1,                      {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),($3+2),$3)},
            $1:__IS_NUM($3),                             __TOKEN_PUSHDOT:1,                                    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSHS},$2,__HEX_DE($3),__HEX_HL($3))},
            $1:__IS_MEM_REF($3),                         __TOKEN_PUSHDOT:1,                                    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSHS},$2,($3+2),$3)},

dnl # PUSH
push,,,

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_DROP,                         {__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                              __TOKEN_PUSHS:__TOKEN_DROP,                           {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0)))},


            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_ADDLOOP,                      {__SET_LOOP_STEP(LOOP_STACK,__T_ARRAY(0)){}__SET_TOKEN({__TOKEN_PUSH_ADDLOOP},__T_INFO(0){ }$2,$3)},

            __T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,     __TOKEN_PUSHS:1:__TOKEN_DUP_EMIT:__TOKEN_DROP,        {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_EMIT},__T_INFO(1){ }__T_INFO(0),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},

            __T_NAME(0)-$1,                              __TOKEN_PUSH_FETCH-__TOKEN_1ADD,                      {__SET_TOKEN({__TOKEN_PUSH_FETCH_1ADD},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0)-$1,                              __TOKEN_PUSH_FETCH-__TOKEN_2ADD,                      {__SET_TOKEN({__TOKEN_PUSH_FETCH_2ADD},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_1(0):$1, __TOKEN_PUSH_FETCH:__TOKEN_PUSHS:1=0x0001:__TOKEN_ADD,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_FETCH_1ADD},__T_INFO(1){ }__T_INFO(0){ }$2,__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_1(0):$1, __TOKEN_PUSH_FETCH:__TOKEN_PUSHS:1=0x0002:__TOKEN_ADD,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_FETCH_2ADD},__T_INFO(1){ }__T_INFO(0){ }$2,__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSH_FETCH:__TOKEN_PUSHS:1:__TOKEN_ADD,         {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_FETCH_PUSH_ADD},__T_INFO(1){ }__T_INFO(0){ }$2,__T_ARRAY(1),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                                               __TOKEN_PUSH2_FETCH:__TOKEN_ADD,                        {__SET_TOKEN({__TOKEN_PUSH_FETCH_PUSH_ADD},__T_INFO(0){ }$2,__T_REVERSE_1(0),__T_REVERSE_2(0))},

            __T_NAME(0):$1:$#,                           __TOKEN_PUSH_FETCH_1ADD:__TOKEN_PUSHS:3,              {__SET_TOKEN({__TOKEN_PUSH_FETCH_1ADD_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},
            __T_NAME(0):$1:$#,                           __TOKEN_PUSH_FETCH_2ADD:__TOKEN_PUSHS:3,              {__SET_TOKEN({__TOKEN_PUSH_FETCH_2ADD_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},
            __T_NAME(0):$1:$#,                           __TOKEN_PUSH_FETCH_PUSH_ADD:__TOKEN_PUSHS:3,          {__SET_TOKEN({__TOKEN_PUSH_FETCH_PUSH_ADD_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},


            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_CFETCH,                       {__SET_TOKEN({__TOKEN_PUSH_CFETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                              __TOKEN_PUSH_CFETCH:__TOKEN_ADD,                      {__SET_TOKEN({__TOKEN_PUSH_CFETCH_ADD},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_FOR,                          {__SET_LOOP_BEGIN($3,__T_ARRAY_1(0)){}__SET_TOKEN({__TOKEN_PUSH_FOR},__T_INFO(0){ }$2,$3)},
            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_QFOR,                         {__SET_LOOP_BEGIN($3,__T_ARRAY_1(0)){}__SET_TOKEN({__TOKEN_PUSH_QFOR},__T_INFO(0){ }$2,$3)},
            __T_NAME(0)-$1,                              __TOKEN_PUSH_FOR-__TOKEN_I,                           {__SET_TOKEN({__TOKEN_PUSH_FOR_I},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0)-$1,                              __TOKEN_PUSH_QFOR-__TOKEN_I,                          {__SET_TOKEN({__TOKEN_PUSH_QFOR_I},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_I,                            {__SET_TOKEN({__TOKEN_PUSH_I},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},
            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_J,                            {__SET_TOKEN({__TOKEN_PUSH_J},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},
            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_K,                            {__SET_TOKEN({__TOKEN_PUSH_K},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},
            


!!!prehodit do druheho pruchodu vcetne nasledujichich!!!,,,
            __T_NAME(0):$1:$#,                   {__TOKEN_I:__TOKEN_PUSHS:3},              {ifelse(__GET_LOOP_TYPE(LOOP_STACK),S,{__SET_TOKEN({__TOKEN_DUP_PUSH},__T_INFO(0){ }$2,$3)},{__SET_TOKEN({__TOKEN_I_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),$3)})},
            __T_NAME(0)-$1,               dodelat{__TOKEN_J-__TOKEN_PUSH},                 {__SET_TOKEN({__TOKEN_J_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},
            __T_NAME(0)-$1,               dodelat{__TOKEN_K-__TOKEN_PUSH},                 {__SET_TOKEN({__TOKEN_K_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},
            __T_NAME(0)-$1,                      {__TOKEN_I_PUSH-__TOKEN_ADDLOOP},         {__SET_LOOP_STEP($3,__T_ARRAY_2(0)){}__SET_TOKEN({__TOKEN_I},__T_INFO(0){ drop},__T_ARRAY_1(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_PUSH_ADDLOOP,__GET_LOOP_STEP($3){ }$2,$3)},
            __T_NAME(0)-$1,               dodelat{__TOKEN_J_PUSH-__TOKEN_ADDLOOP},         {__SET_LOOP_STEP($3,__T_ARRAY_2(0)){}__SET_TOKEN({__TOKEN_J},__T_INFO(0){ drop},__T_ARRAY_1(0),__T_ARRAY_3(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_PUSH_ADDLOOP,__GET_LOOP_STEP($3){ }$2,$3)},
            __T_NAME(0)-$1,               dodelat{__TOKEN_K_PUSH-__TOKEN_ADDLOOP},         {__SET_LOOP_STEP($3,__T_ARRAY_2(0)){}__SET_TOKEN({__TOKEN_K},__T_INFO(0){ drop},__T_ARRAY_1(0),__T_ARRAY_3(0),__T_ARRAY_4(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_PUSH_ADDLOOP,__GET_LOOP_STEP($3){ }$2,$3)},
            __T_NAME(0)-$1,                      {__TOKEN_I_PUSH-__TOKEN_DO},              {__SET_LOOP_BEGIN($3,__T_ARRAY_2(0)){}__SET_TOKEN({__TOKEN_I},__T_INFO(0){ drop},__T_ARRAY_1(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_DO,__GET_LOOP_BEGIN($3){ }$2,$3)},
            __T_NAME(0)-$1,               dodelat{__TOKEN_J_PUSH-__TOKEN_DO},              {__SET_LOOP_BEGIN($3,__T_ARRAY_2(0)){}__SET_TOKEN({__TOKEN_J},__T_INFO(0){ drop},__T_ARRAY_1(0),__T_ARRAY_3(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_DO,__GET_LOOP_BEGIN($3){ }$2,$3)},
            __T_NAME(0)-$1,               dodelat{__TOKEN_K_PUSH-__TOKEN_DO},              {__SET_LOOP_BEGIN($3,__T_ARRAY_2(0)){}__SET_TOKEN({__TOKEN_K},__T_INFO(0){ drop},__T_ARRAY_1(0),__T_ARRAY_3(0),__T_ARRAY_4(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_DO,__GET_LOOP_BEGIN($3){ }$2,$3)},
            __T_NAME(0)-$1,                      {__TOKEN_I_PUSH-__TOKEN_QDO},             {__SET_LOOP_BEGIN($3,__T_ARRAY_2(0)){}__SET_TOKEN({__TOKEN_I},__T_INFO(0){ drop},__T_ARRAY_1(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_QDO,__GET_LOOP_BEGIN($3){ }$2,$3)},
            __T_NAME(0)-$1,               dodelat{__TOKEN_J_PUSH-__TOKEN_QDO},             {__SET_LOOP_BEGIN($3,__T_ARRAY_2(0)){}__SET_TOKEN({__TOKEN_J},__T_INFO(0){ drop},__T_ARRAY_1(0),__T_ARRAY_3(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_QDO,__GET_LOOP_BEGIN($3){ }$2,$3)},
            __T_NAME(0)-$1,               dodelat{__TOKEN_K_PUSH-__TOKEN_QDO},             {__SET_LOOP_BEGIN($3,__T_ARRAY_2(0)){}__SET_TOKEN({__TOKEN_K},__T_INFO(0){ drop},__T_ARRAY_1(0),__T_ARRAY_3(0),__T_ARRAY_4(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_QDO,__GET_LOOP_BEGIN($3){ }$2,$3)},



            __T_NAME(0)=__T_HEX_REVERSE_1(0):$1,         __TOKEN_PUSHS=0x0000:__TOKEN_QDUP,                    {},
            __T_NAME(0):__T_IS_NUM_REVERSE_1(0):$1,      __TOKEN_PUSHS:1:__TOKEN_QDUP,                         {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),__T_REVERSE_1(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_OVER,                         {__SET_TOKEN({__TOKEN_PUSH_OVER},     __T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_2OVER,                        {__SET_TOKEN({__TOKEN_PUSH_2OVER},    __T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                              __TOKEN_PUSH_2OVER:__TOKEN_NIP,                       {__SET_TOKEN({__TOKEN_OVER_PUSH_SWAP},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_PUSH,                         {__SET_TOKEN({__TOKEN_PUSH2},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_DO,                           {ifelse(__GET_LOOP_BEGIN($3),{},{dnl
__{}__{}__{}__{}__SET_LOOP_BEGIN($3,__T_ARRAY_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_DO},__T_INFO(0){ }$2,$3)},{__INC_TOKEN_COUNT{}__SET_TOKEN($@)})},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_QDO,                          {ifelse(__GET_LOOP_BEGIN($3),{},{dnl
__{}__{}__{}__{}__SET_LOOP_BEGIN($3,__T_ARRAY_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_QDO},__T_INFO(0){ }$2,$3)},{__INC_TOKEN_COUNT{}__SET_TOKEN($@)})},

            __T_NAME(0)-$1,                              __TOKEN_PUSH_SWAP-__TOKEN_DO,                         {ifelse(__GET_LOOP_END($3),{},{dnl
__{}__{}__{}__{}__SET_LOOP_END($3,__T_ARRAY_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_DO},__T_INFO(0){ }$2,$3)},{__INC_TOKEN_COUNT{}__SET_TOKEN($@)})},

            __T_NAME(0)-$1,                              __TOKEN_PUSH_SWAP-__TOKEN_QDO,                        {ifelse(__GET_LOOP_END($3),{},{dnl
__{}__{}__{}__{}__SET_LOOP_END($3,__T_ARRAY_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_QDO},__T_INFO(0){ }$2,$3)},{__INC_TOKEN_COUNT{}__SET_TOKEN($@)})},


            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_FILL,           {__SET_TOKEN({__TOKEN_PUSH_FILL},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_1(0):$1, __TOKEN_PUSHS:1=0x7FFF:__TOKEN_MAX,     {__SET_TOKEN({__TOKEN_DROP_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_1(0):$1, __TOKEN_PUSHS:1=0x8000:__TOKEN_MAX,     {__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_1(0):$1, __TOKEN_PUSHS:1=0x8000:__TOKEN_MIN,     {__SET_TOKEN({__TOKEN_DROP_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_1(0):$1, __TOKEN_PUSHS:1=0x7FFF:__TOKEN_MIN,     {__DELETE_LAST_TOKEN},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_MAX,            {__SET_TOKEN({__TOKEN_PUSH_MAX},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_MIN,            {__SET_TOKEN({__TOKEN_PUSH_MIN},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_N_TO_R,         {__SET_TOKEN({__TOKEN_PUSH_N_TO_R},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                                   __TOKEN_PUSH_N_TO_R:__TOKEN_RDROP,      {__SET_TOKEN({__TOKEN_PUSH_N_TO_R_RDROP},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_RPICK,          {__SET_TOKEN({__TOKEN_PUSH_RPICK},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                                   __TOKEN_PUSH_RPICK:__TOKEN_PUSH,        {__SET_TOKEN({__TOKEN_PUSH_RPICK_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_OF,             {__SET_TOKEN({__TOKEN_PUSH_OF},__T_INFO(0){ }$2,__T_ARRAY(0))},


            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0000:1:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_DUP},__T_INFO(0){ $2})},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):eval(__T_ITEMS(0)0>10):$1, __TOKEN_PUSHS=0x0000:1:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ $2},__DROP_1_PAR(__T_ARRAY(0)),__T_REVERSE_2(0))},

            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0001:1:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_OVER},__T_INFO(0){ }$2)},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0001:2:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_PUSH_OVER},__T_INFO(0){ $2},__DROP_1_PAR(__T_ARRAY(0)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):eval(__T_ITEMS(0)0>20):$1, __TOKEN_PUSHS=0x0001:1:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ $2},__DROP_1_PAR(__T_ARRAY(0)),__T_REVERSE_3(0))},

            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0002:1:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_2_PICK},__T_INFO(0){ }$2)},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0002:2:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_OVER_PUSH_SWAP},__T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0002:3:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP},__dtto,__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_SWAP},__T_INFO(1){ }$2,__DROP_1_PAR(__T_ARRAY(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):eval(__T_ITEMS(0)0>30):$1, __TOKEN_PUSHS=0x0002:1:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ $2},__DROP_1_PAR(__T_ARRAY(0)),__T_REVERSE_4(0))},

            __T_NAME(0):$1,                                            __TOKEN_2OVER:__TOKEN_3_PICK,             {__SET_TOKEN({__TOKEN_2OVER_3_PICK},__T_INFO(0){ }$2)},
__T_NAME(1):__T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_2OVER:__TOKEN_PUSHS=0x0003:1:__TOKEN_PICK, {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_3_PICK},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0003:1:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_3_PICK},__T_INFO(0){ }$2)},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0003:2:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP},          __dtto,__DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_2_PICK,__T_INFO(1){ }$2)},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0003:3:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP},          __dtto,__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_PUSH_SWAP,__T_INFO(1){ }$2,__DROP_2_PAR(__T_ARRAY(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0003:4:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP},__dtto,__T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_DUP_PUSH_SWAP,__T_INFO(1){ }$2,__DROP_3_PAR(__T_ARRAY(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):eval(__T_ITEMS(0)0>40):$1, __TOKEN_PUSHS=0x0003:1:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ $2},__DROP_1_PAR(__T_ARRAY(0)),__T_REVERSE_5(0))},
            
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0004:2:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP},                    __dtto,__DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_3_PICK,__T_INFO(1){ }$2)},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0004:3:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP},          __dtto,__DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_2_PICK,__T_INFO(1){ }$2)},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0004:4:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP},          __dtto,__T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_PUSH_SWAP,__T_INFO(1){ }$2,__DROP_3_PAR(__T_ARRAY(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS=0x0004:5:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},__dtto,__T_REVERSE_4(1),__T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_DUP_PUSH_SWAP,__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):eval(__T_ITEMS(0)0>50):$1, __TOKEN_PUSHS=0x0004:1:__TOKEN_PICK, {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ $2},__DROP_1_PAR(__T_ARRAY(0)),__T_REVERSE_6(0))},
            
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_PICK,           {__SET_TOKEN({__TOKEN_PUSH_PICK},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1:$#,                                __TOKEN_PUSH_PICK:__TOKEN_PUSHS:3,      {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},
            __T_NAME(0)-$1,                                   __TOKEN_PUSH_PICK_PUSH-__TOKEN_SWAP,    {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH_SWAP},__T_INFO(0){ }$2,__T_ARRAY(0))},
                        
            __T_NAME(0)-$1,                                   __TOKEN_2_PICK-__TOKEN_PUSH,            {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH},__T_INFO(0){ }$2,2,shift(shift($@)))},
            __T_NAME(0)-$1,                                   __TOKEN_3_PICK-__TOKEN_PUSH,            {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH},__T_INFO(0){ }$2,3,shift(shift($@)))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_R_FETCH,        {__SET_TOKEN({__TOKEN_PUSH_R_FETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},
            
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_2STORE,         {__SET_TOKEN({__TOKEN_PUSH_2STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_2FETCH,         {__SET_TOKEN({__TOKEN_PUSH_2FETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_ALLOT,          {__SET_TOKEN({__TOKEN_PUSH_ALLOT},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):$1,                       __TOKEN_PUSH_COMMA:__TOKEN_PUSH:__TOKEN_COMMA,
               {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSHS_COMMA},__T_INFO(1){ }__T_INFO(0),__T_ARRAY(1),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},

            __T_NAME(1):__T_NAME(0):$1,                       __TOKEN_PUSHS_COMMA:__TOKEN_PUSH:__TOKEN_COMMA,
               {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSHS_COMMA},__T_INFO(1){ }__T_INFO(0),__T_ARRAY(1),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_COMMA,          {__SET_TOKEN({__TOKEN_PUSH_COMMA},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_LSHIFT,         {__SET_TOKEN({__TOKEN_PUSH_LSHIFT},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_RSHIFT,         {__SET_TOKEN({__TOKEN_PUSH_RSHIFT},__T_INFO(0){ }$2,__T_ARRAY(0))},
                        
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,          __TOKEN_OVER:__TOKEN_PUSHS:1:__TOKEN_SWAP, {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_PUSH_SWAP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_SWAP,           {__SET_TOKEN({__TOKEN_PUSH_SWAP},__T_INFO(0){ }$2,__T_ARRAY(0))},
            
            __T_NAME(0)-$1,                                   __TOKEN_PUSH_COMMA-__TOKEN_PUSHS_COMMA, {__SET_TOKEN({__TOKEN_PUSHS_COMMA},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},
            __T_NAME(0)-$1,                                   __TOKEN_PUSHS_COMMA-__TOKEN_PUSHS_COMMA,{__SET_TOKEN({__TOKEN_PUSHS_COMMA},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1, __TOKEN_PUSHS:1:__TOKEN_DUP_TYPE_I:__TOKEN_DROP,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_TYPE_I},__T_INFO(1){ }__T_INFO(0),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_TYPE_Z,         {__SET_TOKEN({__TOKEN_PUSH_TYPE_Z},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_I_PUSH:__TOKEN_PUSH:__TOKEN_WITHIN},{dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSH2_WITHIN},__T_ARRAY_2(1){ }__T_INFO(0){ }$2,__T_ARRAY_2(1),__T_ARRAY(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_I,__T_INFO(1){ drop},__T_ARRAY_1(1))},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_I_PUSH:__TOKEN_PUSH:__TOKEN_LO_WITHIN},{dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSH2_LO_WITHIN},__T_ARRAY_2(1){ }__T_INFO(0){ }$2,__T_ARRAY_2(1),__T_ARRAY(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_I,__T_INFO(1){ drop},__T_ARRAY_1(1))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_VALUE,           {__SET_TOKEN({__TOKEN_PUSH_VALUE},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_WITHIN,          {__SET_TOKEN({__TOKEN_PUSH_WITHIN},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_LO_WITHIN,       {__SET_TOKEN({__TOKEN_PUSH_LO_WITHIN},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_EQ,              {__SET_TOKEN({__TOKEN_PUSH_EQ},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                                   __TOKEN_PUSH_EQ:__TOKEN_IF,              {__SET_TOKEN({__TOKEN_PUSH_EQ_IF},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_NE,              {__SET_TOKEN({__TOKEN_PUSH_NE},__T_INFO(0){ }$2,__T_ARRAY(0))},

dnl # PUSH2
push2,,,


            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,              __TOKEN_PUSHS:1:__TOKEN_ADDLOOP,
                {__SET_LOOP_STEP($3,__T_REVERSE_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ drop},__DROP_1_PAR(__T_ARRAY(0))){}dnl
__{}__{}__{}__{}__INC_TOKEN_COUNT{}dnl
__{}__{}__{}__{}__SET_TOKEN(__TOKEN_PUSH_ADDLOOP,__GET_LOOP_STEP($3){ }$2,shift(shift($@)))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_DO,              {ifelse(__GET_LOOP_BEGIN($3):__GET_LOOP_END($3),{:},{dnl
__{}__{}__{}__{}__SET_LOOP_END(  $3,__T_ARRAY_1(0)){}dnl
__{}__{}__{}__{}__SET_LOOP_BEGIN($3,__T_ARRAY_2(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_DO},__T_INFO(0){ }$2,$3)},{__INC_TOKEN_COUNT{}__SET_TOKEN($@)})},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSH:2:__TOKEN_QDO,              {ifelse(__GET_LOOP_BEGIN($3):__GET_LOOP_END($3),{:},{dnl
__{}__{}__{}__{}__SET_LOOP_END(  $3,__T_ARRAY_1(0)){}dnl
__{}__{}__{}__{}__SET_LOOP_BEGIN($3,__T_ARRAY_2(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_QDO},__T_INFO(0){ }$2,$3)},{__INC_TOKEN_COUNT{}__SET_TOKEN($@)})},


            __T_NAME(0):__T_ITEMS(0):$1:__T_IS_NUM_1_2(0),    __TOKEN_PUSHS:2:__TOKEN_WITHIN:1,        {ifelse(eval(__T_ARRAY_1(0)),eval(__T_ARRAY_2(0)),
                {__SET_TOKEN({__TOKEN_DROP_PUSH},   __T_INFO(0){ }$2,0)},
                {__SET_TOKEN({__TOKEN_PUSH2_WITHIN},__T_INFO(0){ }$2,__T_ARRAY(0))})},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_WITHIN,          {__SET_TOKEN({__TOKEN_PUSH2_WITHIN},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0)-$1,                                   __TOKEN_PUSH2_WITHIN-__TOKEN_IF,         {__SET_TOKEN({__TOKEN_PUSH2_WITHIN_IF},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0)-$1,                                   __TOKEN_PUSH2_WITHIN-__TOKEN_WHILE,      {__SET_TOKEN({__TOKEN_PUSH2_WITHIN_WHILE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0)-$1,                                   __TOKEN_PUSH2_WITHIN-__TOKEN_UNTIL,      {__SET_TOKEN({__TOKEN_PUSH2_WITHIN_UNTIL},__T_INFO(0){ }$2,__T_ARRAY(0))},


            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_2OVER,           {__SET_TOKEN({__TOKEN_PUSH2_2OVER},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0)-$1,                                   __TOKEN_PUSH2_2OVER-__TOKEN_NIP,         {__SET_TOKEN({__TOKEN_PUSH2_2OVER_NIP},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0)-$1,                                   __TOKEN_PUSH2_2OVER_NIP-__TOKEN_2STORE,  {__SET_TOKEN({__TOKEN_PUSH2_2OVER_NIP_2STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
           
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_2FETCH,          {__SET_TOKEN({__TOKEN_PUSH2_2FETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_ADDSTORE,        {__SET_TOKEN({__TOKEN_PUSH2_ADDSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_RPICK,           {__SET_TOKEN({__TOKEN_PUSH2_RPICK},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0)-$1,                 dodelat{__TOKEN_PUSH2_FETCH-__TOKEN_1ADD},     {__SET_TOKEN({__TOKEN_PUSH_FETCH_1ADD},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0)-$1,                 dodelat{__TOKEN_PUSH2_FETCH_1ADD-__TOKEN_PUSH},{__SET_TOKEN({__TOKEN_PUSH_FETCH_1ADD_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_CFETCH,          {__SET_TOKEN({__TOKEN_PUSH2_CFETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},


dnl # PUSH3
push3,,,

            __T_NAME(0):eval(__T_ITEMS(0)>2):$1,                          {__TOKEN_PUSHS:1:__TOKEN_DO},        {ifelse(dnl
__{}__{}__{}__GET_LOOP_BEGIN($3):__GET_LOOP_END($3),{:},{dnl
__{}__{}__{}__{}__SET_LOOP_END(  $3,__T_REVERSE_2(0)){}dnl
__{}__{}__{}__{}__SET_LOOP_BEGIN($3,__T_REVERSE_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ 2drop},__DROP_2_PAR(__T_ARRAY(0))){}dnl
__{}__{}__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN($1,__GET_LOOP_END($3){ }__GET_LOOP_BEGIN($3){ }$2,shift(shift($@)))},
__{}__{}__{}__GET_LOOP_BEGIN($3),{},{dnl
__{}__{}__{}__{}__SET_LOOP_BEGIN($3,__T_REVERSE_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ drop}, __DROP_1_PAR(__T_ARRAY(0))){}dnl
__{}__{}__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN($1,__GET_LOOP_END($3){ }__GET_LOOP_BEGIN($3){ }$2,shift(shift($@)))},
__{}__{}__{}__GET_LOOP_END($3),{},{dnl
__{}__{}__{}__{}__SET_LOOP_END(  $3,__T_REVERSE_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ drop}, __DROP_1_PAR(__T_ARRAY(0))){}dnl
__{}__{}__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN($1,__GET_LOOP_END($3){ }__GET_LOOP_BEGIN($3){ }$2,shift(shift($@)))},
__{}__{}__{}{__INC_TOKEN_COUNT{}__SET_TOKEN($@)})},

            __T_NAME(0):eval(__T_ITEMS(0)>2):$1,                          {__TOKEN_PUSHS:1:__TOKEN_QDO},        {ifelse(dnl
__{}__{}__{}__GET_LOOP_BEGIN($3):__GET_LOOP_END($3),{:},{dnl
__{}__{}__{}__{}__SET_LOOP_END(  $3,__T_REVERSE_2(0)){}dnl
__{}__{}__{}__{}__SET_LOOP_BEGIN($3,__T_REVERSE_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ 2drop},__DROP_2_PAR(__T_ARRAY(0))){}dnl
__{}__{}__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN($1,__GET_LOOP_END($3){ }__GET_LOOP_BEGIN($3){ }$2,shift(shift($@)))},
__{}__{}__{}__GET_LOOP_BEGIN($3),{},{dnl
__{}__{}__{}__{}__SET_LOOP_BEGIN($3,__T_REVERSE_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ drop}, __DROP_1_PAR(__T_ARRAY(0))){}dnl
__{}__{}__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN($1,__GET_LOOP_END($3){ }__GET_LOOP_BEGIN($3){ }$2,shift(shift($@)))},
__{}__{}__{}__GET_LOOP_END($3),{},{dnl
__{}__{}__{}__{}__SET_LOOP_END(  $3,__T_REVERSE_1(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ drop}, __DROP_1_PAR(__T_ARRAY(0))){}dnl
__{}__{}__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN($1,__GET_LOOP_END($3){ }__GET_LOOP_BEGIN($3){ }$2,shift(shift($@)))},
__{}__{}__{}{__INC_TOKEN_COUNT{}__SET_TOKEN($@)})},


__T_NAME(0):$1,                                                             __TOKEN_PUSHS:__TOKEN_DUP,         {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__T_ARRAY(0),__T_REVERSE_1(0))},
__T_NAME(0):$1,                                                             __TOKEN_PUSHS:__TOKEN_OVER,        {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__T_ARRAY(0),__T_REVERSE_2(0))},

dnl # PUSH4
push4,,,

__T_NAME(0):eval(__T_ITEMS(0)>2):$1:__T_IS_PTR_REVERSE_3_2_1(0),__TOKEN_PUSHS:1:__TOKEN_UMDIVMOD:0,{__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,ifelse(__T_ITEMS(0),3,,__DROP_3_PAR(__T_ARRAY(0)){,})__EVAL_S16(um/mod,__T_LAST_3_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1:__T_IS_PTR_REVERSE_3_2_1(0),__TOKEN_PUSHS:1:__TOKEN_SMDIVREM:0,{__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,ifelse(__T_ITEMS(0),3,,__DROP_3_PAR(__T_ARRAY(0)){,})__EVAL_S16(sm/rem,__T_LAST_3_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1:__T_IS_PTR_REVERSE_3_2_1(0),__TOKEN_PUSHS:1:__TOKEN_FMDIVMOD:0,{__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,ifelse(__T_ITEMS(0),3,,__DROP_3_PAR(__T_ARRAY(0)){,})__EVAL_S16(fm/mod,__T_LAST_3_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1:__T_IS_PTR_REVERSE_3_2_1(0),__TOKEN_PUSHS:1:__TOKEN_MADD:0,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,ifelse(__T_ITEMS(0),3,,__DROP_3_PAR(__T_ARRAY(0)){,})__EVAL_S16(    m+,__T_LAST_3_PAR(0)))},


__T_NAME(0):eval((__T_ITEMS(0)>1) && ifelse(__T_IS_PTR_REVERSE_2_1(0),0,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},
    __T_HEX_REVERSE_1(0),0xFFFF,{1},
    __T_HEX_REVERSE_2(0),0xFFFF,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_AND,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(&,__T_LAST_2_PAR(0)))},

__T_NAME(0):eval((__T_ITEMS(0)>1) && ifelse(__T_IS_PTR_REVERSE_2_1(0),0,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},
    __T_HEX_REVERSE_1(0),0xFFFF,{1},
    __T_HEX_REVERSE_2(0),0xFFFF,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_OR,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(|,__T_LAST_2_PAR(0)))},

__T_NAME(0):eval((__T_ITEMS(0)>1) && ifelse(__T_IS_PTR_REVERSE_2_1(0),0,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},{0})):$1,     __TOKEN_PUSHS:1:__TOKEN_XOR,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(^,__T_LAST_2_PAR(0)))},

            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,                                  __TOKEN_PUSHS:1:__TOKEN_AND,       {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_AND}, __T_INFO(1){ }$2,ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_2(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_2_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),2,,{,}){}ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_1(1),__T_REVERSE_2(1)))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,                                  __TOKEN_PUSHS:1:__TOKEN_OR,        {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_OR},  __T_INFO(1){ }$2,ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_2(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_2_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),2,,{,}){}ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_1(1),__T_REVERSE_2(1)))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,                                  __TOKEN_PUSHS:1:__TOKEN_XOR,       {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_XOR}, __T_INFO(1){ }$2,ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_2(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_2_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),2,,{,}){}ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_1(1),__T_REVERSE_2(1)))},

            __T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),               __TOKEN_PUSHS:1:__TOKEN_AND:0xFFFF,{__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,                                          __TOKEN_PUSHS:1:__TOKEN_AND,       {__SET_TOKEN({__TOKEN_PUSH_AND},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),                     __TOKEN_PUSHS:1:__TOKEN_OR:0x0000, {__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,                                          __TOKEN_PUSHS:1:__TOKEN_OR,        {__SET_TOKEN({__TOKEN_PUSH_OR},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),                     __TOKEN_PUSHS:1:__TOKEN_XOR:0x0000,{__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,                                          __TOKEN_PUSHS:1:__TOKEN_XOR,       {__SET_TOKEN({__TOKEN_PUSH_XOR},__T_INFO(0){ }$2,__T_ARRAY(0))},

__T_NAME(0):eval((__T_ITEMS(0)>1) && ifelse(__T_IS_PTR_REVERSE_2_1(0),0,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_ADD,          {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(+,__T_LAST_2_PAR(0)))},

            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,                                  __TOKEN_PUSHS:1:__TOKEN_ADD,       {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_ADD}, __T_INFO(1){ }$2,ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_2(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_2_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),2,,{,}){}ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_1(1),__T_REVERSE_2(1)))},

            __T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),                     __TOKEN_PUSHS:1:__TOKEN_ADD:0x0000,{__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,                                          __TOKEN_PUSHS:1:__TOKEN_ADD,       {__SET_TOKEN({__TOKEN_PUSH_ADD},__T_INFO(0){ }$2,__T_ARRAY(0))},

__T_NAME(0):eval((__T_ITEMS(0)>1) && ifelse(__T_IS_PTR_REVERSE_2_1(0),0,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_SUB,          {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(-,__T_LAST_2_PAR(0)))},

            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,                                  __TOKEN_PUSHS:1:__TOKEN_SUB,       {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SUB}, __T_INFO(1){ }$2,__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_1_PAR(__T_ARRAY(1)))},

            __T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),                     __TOKEN_PUSHS:1:__TOKEN_SUB:0x0000,{__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,                                          __TOKEN_PUSHS:1:__TOKEN_SUB,       {__SET_TOKEN({__TOKEN_PUSH_SUB},__T_INFO(0){ }$2,__T_ARRAY(0))},

__T_NAME(0):eval((__T_ITEMS(0)>1) && ifelse(__T_IS_PTR_REVERSE_2_1(0),0,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},
    __T_HEX_REVERSE_1(0),0x0001,{1},
    __T_HEX_REVERSE_2(0),0x0001,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_MUL,          {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(*,__T_LAST_2_PAR(0)))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_MUL:0x0002,     {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_2MUL},__T_INFO(1))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_2(0),      __TOKEN_PUSHS:1:__TOKEN_MUL:0x0002,     {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__T_REVERSE_1(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_2MUL},__T_INFO(1))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_MUL:0xFFFF,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NEGATE},__T_INFO(1))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_2(0),      __TOKEN_PUSHS:1:__TOKEN_MUL:0xFFFF,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__T_REVERSE_1(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NEGATE},__T_INFO(1))},

            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,                                  __TOKEN_PUSHS:1:__TOKEN_MUL,       {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_MUL}, __T_INFO(1){ }$2,ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_2(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_2_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),2,,{,}){}ifelse(__T_IS_PTR_REVERSE_1(1),1,__T_REVERSE_1(1),__T_REVERSE_2(1)))},

            __T_NAME(0):__T_ITEMS(0):$1,                                          __TOKEN_PUSHS:1:__TOKEN_MUL,       {__SET_TOKEN({__TOKEN_PUSH_MUL},__T_INFO(0){ }$2,__T_ARRAY(0))},

__T_NAME(0):eval((__T_ITEMS(0)>1) && ifelse(__T_IS_PTR_REVERSE_2_1(0),0,{1},
    __T_HEX_REVERSE_1(0),0x0001,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DIV,          {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(/,__T_LAST_2_PAR(0)))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_DIV:0xFFFF,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NEGATE},__T_INFO(1))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_DIV:0x0002,     {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_2DIV},__T_INFO(1))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UDIV:0,        {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u/,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_2(0),      __TOKEN_PUSHS:1:__TOKEN_UDIV:0x0000,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,})0))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_UDIV:0x0001,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_UDIV:0x0002,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_2UDIV},__T_INFO(1))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_UDIV:0x0004,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_4UDIV},__T_INFO(1))},

__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_UDIV:0x0001,            {__DELETE_LAST_TOKEN},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_UDIV:0x0002,            {__SET_TOKEN({__TOKEN_2UDIV},__T_INFO(0){ }$2)},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_UDIV:0x0004,            {__SET_TOKEN({__TOKEN_4UDIV},__T_INFO(0){ }$2)},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_MOD:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(%,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UMOD:0,     {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u%,__T_LAST_2_PAR(0)))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DIVMOD:0,   {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(/mod,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UDIVMOD:0,  {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u/mod,__T_LAST_2_PAR(0)))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_MMUL:0,     {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(m*,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UMMUL:0,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(um*,__T_LAST_2_PAR(0)))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_MAX:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(>?,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_MIN:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(<?,__T_LAST_2_PAR(0)))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_EQ:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(=,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_NE:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(<>,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_LT:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(<,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_GT:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(>,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_LE:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(<=,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_GE:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(>=,__T_LAST_2_PAR(0)))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UEQ:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u=,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UNE:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u<>,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_ULT:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u<,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UGT:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u>,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_ULE:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u<=,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UGE:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u>=,__T_LAST_2_PAR(0)))},

__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_FILL,    {__SET_TOKEN({__TOKEN_PUSH_FILL},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:2:__TOKEN_FILL,    {__SET_TOKEN({__TOKEN_PUSH2_FILL},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:3:__TOKEN_FILL,    {__SET_TOKEN({__TOKEN_PUSH3_FILL},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1, __TOKEN_PUSHS:1:__TOKEN_FILL,    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH3_FILL},__REMOVE_COMMA(__T_LAST_3_PAR(1)){ }$2,__T_LAST_3_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ 3drop},__DROP_3_PAR(__T_ARRAY(1)))},

__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:1:__TOKEN_CMOVE:0x0000, {__SET_TOKEN({__TOKEN_2DROP},__T_INFO(0){ }$2)},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:2:__TOKEN_CMOVE:0x0000, {__SET_TOKEN({__TOKEN_DROP},__T_INFO(0){ }$2)},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:3:__TOKEN_CMOVE:0x0000, {__DELETE_LAST_TOKEN},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_HEX_REVERSE_1(0), __TOKEN_PUSHS:1:__TOKEN_CMOVE:0x0000, {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__DROP_3_PAR(__T_ARRAY(0)))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_CMOVE,    {__SET_TOKEN({__TOKEN_PUSH_CMOVE},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:2:__TOKEN_CMOVE,    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_CMOVE},__T_REVERSE_1(1){ }$2,__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ drop},__DROP_1_PAR(__T_ARRAY(1)))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:3:__TOKEN_CMOVE,    {__SET_TOKEN({__TOKEN_PUSH3_CMOVE},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1, __TOKEN_PUSHS:1:__TOKEN_CMOVE,    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH3_CMOVE},__REMOVE_COMMA(__T_LAST_3_PAR(1)){ }$2,__T_LAST_3_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ 3drop},__DROP_3_PAR(__T_ARRAY(1)))},

__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:1:__TOKEN_MOVE:0x0000,  {__SET_TOKEN({__TOKEN_2DROP},__T_INFO(0){ }$2)},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:2:__TOKEN_MOVE:0x0000,  {__SET_TOKEN({__TOKEN_DROP},__T_INFO(0){ }$2)},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:3:__TOKEN_MOVE:0x0000,  {__DELETE_LAST_TOKEN},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_HEX_REVERSE_1(0), __TOKEN_PUSHS:1:__TOKEN_MOVE:0x0000,  {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__DROP_3_PAR(__T_ARRAY(0)))},
__T_NAME(0):__T_ITEMS(0):$1,                                     __TOKEN_PUSHS:1:__TOKEN_MOVE,    {__SET_TOKEN({__TOKEN_PUSH_MOVE},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                     __TOKEN_PUSHS:2:__TOKEN_MOVE,    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_MOVE},__T_REVERSE_1(1){ }$2,__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ drop},__DROP_1_PAR(__T_ARRAY(1)))},
__T_NAME(0):__T_ITEMS(0):$1,                                     __TOKEN_PUSHS:3:__TOKEN_MOVE,    {__SET_TOKEN({__TOKEN_PUSH3_MOVE},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1,                             __TOKEN_PUSHS:1:__TOKEN_MOVE,    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH3_MOVE},__REMOVE_COMMA(__T_LAST_3_PAR(1)){ }$2,__T_LAST_3_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ 3drop},__DROP_3_PAR(__T_ARRAY(1)))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1,                             __TOKEN_PUSHS:1:__TOKEN_SWAP,    {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__T_REVERSE_1(0),__T_REVERSE_2(0))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1:__T_IS_NUM_1_2_3(0),   __TOKEN_PUSHS:1:__TOKEN_WITHIN:1,{__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_3_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),3,,{,}){}ifelse(eval((__T_REVERSE_3(0)>=__T_REVERSE_2(0)) && (__T_REVERSE_3(0)<__T_REVERSE_1(0))),{1},{-1},{0}))},

            __T_NAME(0)-$1,                         x{__TOKEN_PUSH4_WITHIN-__TOKEN_IF}, {__SET_TOKEN({__TOKEN_PUSH4_WITHIN_IF},__T_INFO(0){ }$2,__T_ARRAY_2(0),__T_ARRAY_3(0))},
            __T_NAME(0)-$1,                         x{__TOKEN_PUSH4_WITHIN-__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_PUSH4_WITHIN_WHILE},__T_INFO(0){ }$2,__T_ARRAY_2(0),__T_ARRAY_3(0))},
            __T_NAME(0)-$1,                         x{__TOKEN_PUSH4_WITHIN-__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_PUSH4_WITHIN_UNTIL},__T_INFO(0){ }$2,__T_ARRAY_2(0),__T_ARRAY_3(0))},

__T_NAME(0):$1,                                                        __TOKEN_PUSHS:__TOKEN_PUSH,      {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},
__T_NAME(0):$1,                                                        __TOKEN_PUSHS:__TOKEN_PUSHS,     {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},


__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_2STORE,   {__SET_TOKEN({__TOKEN_PUSH_2STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:2:__TOKEN_2STORE,   {__SET_TOKEN({__TOKEN_PUSH2_2STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:3:__TOKEN_2STORE,   {__SET_TOKEN({__TOKEN_PUSH3_2STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1, __TOKEN_PUSHS:1:__TOKEN_2STORE,   {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH3_2STORE},__REMOVE_COMMA(__T_LAST_3_PAR(1)){ }$2,__T_LAST_3_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ 3drop},__DROP_3_PAR(__T_ARRAY(1)))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_FETCH,    {__SET_TOKEN({__TOKEN_PUSH_FETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:2:__TOKEN_FETCH,    {__SET_TOKEN({__TOKEN_PUSH2_FETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_FETCH,    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_FETCH},__T_REVERSE_1(1),__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ drop},__DROP_1_PAR(__T_ARRAY(1)))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_2FETCH,   {__SET_TOKEN({__TOKEN_PUSH_2FETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_2FETCH,   {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_2FETCH},__T_REVERSE_1(1){ }$2,__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ drop},__DROP_1_PAR(__T_ARRAY(1)))},

__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_VALUE,    {__SET_TOKEN({__TOKEN_PUSH_VALUE},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_VALUE,    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_VALUE},__T_REVERSE_1(1){ }$2,__T_REVERSE_1(1),$3){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ drop},__DROP_1_PAR(__T_ARRAY(1)))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:2:__TOKEN_DVALUE,   {__SET_TOKEN({__TOKEN_PUSHDOT_DVALUE},__T_REVERSE_2(0)*65536+__T_REVERSE_1(0){. }$2,__T_REVERSE_2(0)*65536+__T_REVERSE_1(0),$3)},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1, __TOKEN_PUSHS:1:__TOKEN_DVALUE,   {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSHDOT_DVALUE},__T_REVERSE_2(1)*65536+__T_REVERSE_1(1){. }$2,__T_REVERSE_2(1)*65536+__T_REVERSE_1(1),$3){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},

__T_NAME(0):eval(2*__T_ITEMS(0)):$1, __TOKEN_PUSHS:__PSIZE_$4:__TOKEN_PVALUE,   {dnl
__{}ifelse(dnl
__{}__IS_ARRAY_NUM(__T_ARRAY(0)),1,{dnl
__{}__{}define(_{_TEMP},0x{}__ARRAY2HEXSTRING(__T_ARRAY(0))){}dnl
__{}__{}__DELETE_LAST_TOKEN{}dnl
__{}__{}PPUSH_VALUE($3,__TEMP,$4)},
__{}{dnl
__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN($@)}){}dnl
__{}},

__T_NAME(0):$1,                            __TOKEN_PUSHS:__TOKEN_PVALUE,     {dnl
__{}ifelse(eval(__PSIZE_$4>(2*__T_ITEMS(0))),1,{dnl
__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN($@)},
__{}__IS_ARRAY_NUM(__LAST_X_PAR(eval(($3+1)/2),__T_ARRAY(0))),1,{dnl
__{}__{}__{}define({__TEMP},0x{}__ARRAY2HEXSTRING(__LAST_X_PAR(eval(($3+1)/2),__T_ARRAY(0)))){}dnl
__{}__{}__{}__SET_TOKEN({__TOKEN_PUSHS},__REMOVE_COMMA(}__FIRST_X_PAR(eval(__T_ITEMS(0)-($3+1)/2),__T_ARRAY(0)){),__FIRST_X_PAR(eval(__T_ITEMS(0)-($3+1)/2),__T_ARRAY(0))){}dnl
__{}__{}__{}PPUSH_VALUE($3,__TEMP,$4){}dnl
__{}__{}},
__{}{dnl
__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN($@)}){}dnl
__{}},


dnl # PUSHDOT

pushdot,,,

__T_NAME(0):eval((__T_ITEMS(0)>3) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_4_2(0),0,{1},
    __T_HEX_REVERSE_4(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},
    __T_HEX_REVERSE_4(0),0xFFFF,{1},
    __T_HEX_REVERSE_2(0),0xFFFF,{1},{0}) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_3_1(0),0,{1},
    __T_HEX_REVERSE_3(0),0x0000,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},
    __T_HEX_REVERSE_3(0),0xFFFF,{1},
    __T_HEX_REVERSE_1(0),0xFFFF,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DAND,     {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S16(&,__T_REVERSE_4(0),__T_REVERSE_2(0)),__EVAL_S16(&,__T_REVERSE_3(0),__T_REVERSE_1(0)))},

__T_NAME(0):eval((__T_ITEMS(0)>3) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_4_2(0),0,{1},
    __T_HEX_REVERSE_4(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},
    __T_HEX_REVERSE_4(0),0xFFFF,{1},
    __T_HEX_REVERSE_2(0),0xFFFF,{1},{0}) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_3_1(0),0,{1},
    __T_HEX_REVERSE_3(0),0x0000,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},
    __T_HEX_REVERSE_3(0),0xFFFF,{1},
    __T_HEX_REVERSE_1(0),0xFFFF,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DOR,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S16(|,__T_REVERSE_4(0),__T_REVERSE_2(0)),__EVAL_S16(|,__T_REVERSE_3(0),__T_REVERSE_1(0)))},

__T_NAME(0):eval((__T_ITEMS(0)>3) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_4_2(0),0,{1},
    __T_HEX_REVERSE_4(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},{0}) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_3_1(0),0,{1},
    __T_HEX_REVERSE_3(0),0x0000,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DXOR,         {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S16(^,__T_REVERSE_4(0),__T_REVERSE_2(0)),__EVAL_S16(^,__T_REVERSE_3(0),__T_REVERSE_1(0)))},

__T_NAME(0):eval((__T_ITEMS(0)>3) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_4_2(0),0,{1},
    __T_HEX_REVERSE_4(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},
    __T_HEX_REVERSE_4(0),0xFFFF,{1},
    __T_HEX_REVERSE_2(0),0xFFFF,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DAND,     {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_AND},__T_INFO(1){ }$2,ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_3(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,,{,}){}__EVAL_S16(&,__T_REVERSE_4(1),__T_REVERSE_2(1)),ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_1(1),__T_REVERSE_3(1)))},

__T_NAME(0):eval((__T_ITEMS(0)>3) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_4_2(0),0,{1},
    __T_HEX_REVERSE_4(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},
    __T_HEX_REVERSE_4(0),0xFFFF,{1},
    __T_HEX_REVERSE_2(0),0xFFFF,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DOR,      {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_OR}, __T_INFO(1){ }$2,ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_3(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,,{,}){}__EVAL_S16(|,__T_REVERSE_4(1),__T_REVERSE_2(1)),ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_1(1),__T_REVERSE_3(1)))},

__T_NAME(0):eval((__T_ITEMS(0)>3) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_4_2(0),0,{1},
    __T_HEX_REVERSE_4(0),0x0000,{1},
    __T_HEX_REVERSE_2(0),0x0000,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DXOR,         {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_XOR},__T_INFO(1){ }$2,ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_3(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,,{,}){}__EVAL_S16(^,__T_REVERSE_4(1),__T_REVERSE_2(1)),ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_1(1),__T_REVERSE_3(1)))},

__T_NAME(0):eval((__T_ITEMS(0)>3) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_3_1(0),0,{1},
    __T_HEX_REVERSE_3(0),0x0000,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},
    __T_HEX_REVERSE_3(0),0xFFFF,{1},
    __T_HEX_REVERSE_1(0),0xFFFF,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DAND,     {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_SWAP_PUSH_AND_SWAP},__T_INFO(1){ }$2,ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_4(1),__T_REVERSE_2(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,,{,}){}ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_2(1),__T_REVERSE_4(1)),__EVAL_S16(&,__T_REVERSE_3(1),__T_REVERSE_1(1)))},

__T_NAME(0):eval((__T_ITEMS(0)>3) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_3_1(0),0,{1},
    __T_HEX_REVERSE_3(0),0x0000,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},
    __T_HEX_REVERSE_3(0),0xFFFF,{1},
    __T_HEX_REVERSE_1(0),0xFFFF,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DOR,      {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_SWAP_PUSH_OR_SWAP}, __T_INFO(1){ }$2,ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_4(1),__T_REVERSE_2(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,,{,}){}ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_2(1),__T_REVERSE_4(1)),__EVAL_S16(|,__T_REVERSE_3(1),__T_REVERSE_1(1)))},

__T_NAME(0):eval((__T_ITEMS(0)>3) &&{}dnl
   ifelse(__T_IS_PTR_REVERSE_3_1(0),0,{1},
    __T_HEX_REVERSE_3(0),0x0000,{1},
    __T_HEX_REVERSE_1(0),0x0000,{1},{0})):$1, __TOKEN_PUSHS:1:__TOKEN_DXOR,         {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_SWAP_PUSH_XOR_SWAP},__T_INFO(1){ }$2,ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_4(1),__T_REVERSE_2(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,,{,}){}ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_2(1),__T_REVERSE_4(1)),__EVAL_S16(^,__T_REVERSE_3(1),__T_REVERSE_1(1)))},

__T_NAME(0):eval(__T_ITEMS(0)>3):$1,                                                             __TOKEN_PUSHS:1:__TOKEN_DAND,         {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DAND}, __T_INFO(1){ }$2,ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_4(1),__T_REVERSE_2(1)),ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_3(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,,{,}){}ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_2(1),__T_REVERSE_4(1)),ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_1(1),__T_REVERSE_3(1)))},

__T_NAME(0):eval(__T_ITEMS(0)>3):$1,                                                             __TOKEN_PUSHS:1:__TOKEN_DOR,          {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DOR},  __T_INFO(1){ }$2,ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_4(1),__T_REVERSE_2(1)),ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_3(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,,{,}){}ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_2(1),__T_REVERSE_4(1)),ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_1(1),__T_REVERSE_3(1)))},

__T_NAME(0):eval(__T_ITEMS(0)>3):$1,                                                             __TOKEN_PUSHS:1:__TOKEN_DXOR,         {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DXOR}, __T_INFO(1){ }$2,ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_4(1),__T_REVERSE_2(1)),ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_3(1),__T_REVERSE_1(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }$2,__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,,{,}){}ifelse(__T_IS_NUM_REVERSE_2(1),0,__T_REVERSE_2(1),__T_REVERSE_4(1)),ifelse(__T_IS_NUM_REVERSE_1(1),0,__T_REVERSE_1(1),__T_REVERSE_3(1)))},

__T_NAME(0):__T_ITEMS(0):$1,                                                                     __TOKEN_PUSHS:2:__TOKEN_DAND,         {__SET_TOKEN({__TOKEN_PUSH2_DAND},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                                                     __TOKEN_PUSHS:2:__TOKEN_DOR,          {__SET_TOKEN({__TOKEN_PUSH2_DOR}, __T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                                                     __TOKEN_PUSHS:2:__TOKEN_DXOR,         {__SET_TOKEN({__TOKEN_PUSH2_DXOR},__T_INFO(0){ }$2,__T_ARRAY(0))},

__T_NAME(0):eval(__T_ITEMS(0)>3):__T_IS_PTR_REVERSE_4_3(0):$1,      __TOKEN_PUSHS:1:0:__TOKEN_DADD,      {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DADD},__T_REVERSE_4(1){ }__T_REVERSE_3(1){ }$2,__T_REVERSE_4(1),__T_REVERSE_3(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2swap 2drop},__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,{},{,})__T_LAST_2_PAR(1))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                      __TOKEN_PUSHS:1:__TOKEN_DADD,        {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DADD},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_REVERSE_2(1),__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                      __TOKEN_PUSHS:1:__TOKEN_DSUB,        {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DSUB},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_REVERSE_2(1),__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},


__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DEQ:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d=,  __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DNE:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d<>, __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DLT:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d<,  __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DGT:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d>,  __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DLE:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d<=, __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DGE:0,       {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d>=, __T_LAST_4_PAR(0)))},

__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DUEQ:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(du=, __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DUNE:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(du<>,__T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DULT:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(du<, __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DUGT:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(du>, __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DULE:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(du<=,__T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DUGE:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(du>=,__T_LAST_4_PAR(0)))},


__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DADD:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d+,  __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DSUB:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d-,  __T_LAST_4_PAR(0)))},

__T_NAME(0):__T_ITEMS(0):$1,                                              __TOKEN_PUSHS:2:__TOKEN_DADD,        {__SET_TOKEN({__TOKEN_PUSH2_DADD},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                              __TOKEN_PUSHS:2:__TOKEN_DSUB,        {__SET_TOKEN({__TOKEN_PUSH2_DSUB},__T_INFO(0){ }$2,__T_ARRAY(0))},

__T_NAME(0):eval(__T_ITEMS(0)>3):__T_IS_PTR_REVERSE_4_3(0):$1,      __TOKEN_PUSHS:1:0:__TOKEN_DADD,      {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DADD},__T_REVERSE_4(1){ }__T_REVERSE_3(1){ }$2,__T_REVERSE_4(1),__T_REVERSE_3(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2swap 2drop},__DROP_4_PAR(__T_ARRAY(1)){}ifelse(__T_ITEMS(1),4,{},{,})__T_LAST_2_PAR(1))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                      __TOKEN_PUSHS:1:__TOKEN_DADD,        {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DADD},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_REVERSE_2(1),__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                      __TOKEN_PUSHS:1:__TOKEN_DSUB,        {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DSUB},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_REVERSE_2(1),__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),      __TOKEN_PUSHS:1:__TOKEN_DABS:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S32(dabs,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),      __TOKEN_PUSHS:1:__TOKEN_DNEGATE:0,   {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S32(dneg,__T_LAST_2_PAR(0)))},

__T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,        {__TOKEN_PUSHS:2=0x0000:0x0000:__TOKEN_DEQ},{__SET_TOKEN({__TOKEN_D0EQ},__T_INFO(0){ }$2)},
__T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,        {__TOKEN_PUSHS:2=0x0000:0x0000:__TOKEN_DNE},{__SET_TOKEN({__TOKEN_D0NE},__T_INFO(0){ }$2)},
__T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,        {__TOKEN_PUSHS:2=0x0000:0x0000:__TOKEN_DLT},{__SET_TOKEN({__TOKEN_D0LT},__T_INFO(0){ }$2)},
__T_NAME(0):eval(__T_ITEMS(0)>2)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,{__TOKEN_PUSHS:1=0x0000:0x0000:__TOKEN_DEQ},{__SET_TOKEN(__TOKEN_PUSHS,__T_INFO(0){ 2drop},__DROP_2_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_D0EQ},{0. }$2)},
__T_NAME(0):eval(__T_ITEMS(0)>2)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,{__TOKEN_PUSHS:1=0x0000:0x0000:__TOKEN_DNE},{__SET_TOKEN(__TOKEN_PUSHS,__T_INFO(0){ 2drop},__DROP_2_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_D0NE},{0. }$2)},
__T_NAME(0):eval(__T_ITEMS(0)>2)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,{__TOKEN_PUSHS:1=0x0000:0x0000:__TOKEN_DLT},{__SET_TOKEN(__TOKEN_PUSHS,__T_INFO(0){ 2drop},__DROP_2_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_D0LT},{0. }$2)},

__T_NAME(0):__T_ITEMS(0):$1,                                                    __TOKEN_PUSHS:2:__TOKEN_DEQ,                 {__SET_TOKEN({__TOKEN_PUSH2_DEQ}, __T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                                    __TOKEN_PUSHS:2:__TOKEN_DNE,                 {__SET_TOKEN({__TOKEN_PUSH2_DNE}, __T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                                    __TOKEN_PUSHS:2:__TOKEN_DLT,                 {__SET_TOKEN({__TOKEN_PUSH2_DLT}, __T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                            __TOKEN_PUSHS:1:__TOKEN_DEQ,                 {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DEQ},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                            __TOKEN_PUSHS:1:__TOKEN_DNE,                 {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DNE},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                            __TOKEN_PUSHS:1:__TOKEN_DLT,                 {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DLT},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},

__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DMAX:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d>?,  __T_LAST_4_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_IS_PTR_REVERSE_4_3_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_DMIN:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_4_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),4,,{,}){}__EVAL_S32(d<?,  __T_LAST_4_PAR(0)))},

__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_REVERSE_2_1(0):$1,              __TOKEN_PUSHS:2:0:__TOKEN_DMAX,      {__SET_TOKEN({__TOKEN_PUSHDOT_DMAX},__T_INFO(0){ }$2,eval(__HEX_HL(__T_ARRAY_1(0))*65536+__HEX_HL(__T_ARRAY_2(0))))},
__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_REVERSE_2_1(0):$1,              __TOKEN_PUSHS:2:0:__TOKEN_DMIN,      {__SET_TOKEN({__TOKEN_PUSHDOT_DMIN},__T_INFO(0){ }$2,eval(__HEX_HL(__T_ARRAY_1(0))*65536+__HEX_HL(__T_ARRAY_2(0))))},

__T_NAME(0):eval(__T_ITEMS(0)>2):__T_IS_PTR_REVERSE_2_1(0):$1,      __TOKEN_PUSHS:1:0:__TOKEN_DMAX,      {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSHDOT_DMAX},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,eval(__HEX_HL(__T_REVERSE_2(1))*65536+__HEX_HL(__T_REVERSE_1(1)))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):__T_IS_PTR_REVERSE_2_1(0):$1,      __TOKEN_PUSHS:1:0:__TOKEN_DMIN,      {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSHDOT_DMIN},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,eval(__HEX_HL(__T_REVERSE_2(1))*65536+__HEX_HL(__T_REVERSE_1(1)))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},

            dodelat__T_NAME(0)-$1,{__TOKEN_PUSHDOT-__TOKEN_DNE},{__SET_TOKEN({__TOKEN_PUSHDOT_DNE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            dodelat__T_NAME(0)-$1,{__TOKEN_PUSHDOT-__TOKEN_DLT},{__SET_TOKEN({__TOKEN_PUSHDOT_DLT},__T_INFO(0){ }$2,__T_ARRAY(0))},
            dodelat__T_NAME(0)-$1,{__TOKEN_PUSHDOT-__TOKEN_DGT},{__SET_TOKEN({__TOKEN_PUSHDOT_DGT},__T_INFO(0){ }$2,__T_ARRAY(0))},
            dodelat__T_NAME(0)-$1,{__TOKEN_PUSHDOT-__TOKEN_DLE},{__SET_TOKEN({__TOKEN_PUSHDOT_DLE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            dodelat__T_NAME(0)-$1,{__TOKEN_PUSHDOT-__TOKEN_DGE},{__SET_TOKEN({__TOKEN_PUSHDOT_DGE},__T_INFO(0){ }$2,__T_ARRAY(0))},


      __T_NAME(0):__T_ITEMS(0):$1,{__TOKEN_PUSHS:2:__TOKEN_2SWAP},{__SET_TOKEN({__TOKEN_PUSH2_2SWAP},__T_INFO(0){ }$2,__T_ARRAY(0))},

            dodelat__T_NAME(0)-$1,{__TOKEN_PUSH2-__TOKEN_DLT},{__SET_TOKEN({__TOKEN_PUSHDOT_DLT},__T_INFO(0){ }$2,__T_ARRAY(0))},
            dodelat__T_NAME(0)-$1,{__TOKEN_PUSH2-__TOKEN_DGT},{__SET_TOKEN({__TOKEN_PUSHDOT_DGT},__T_INFO(0){ }$2,__T_ARRAY(0))},
            dodelat__T_NAME(0)-$1,{__TOKEN_PUSH2-__TOKEN_DLE},{__SET_TOKEN({__TOKEN_PUSHDOT_DLE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            dodelat__T_NAME(0)-$1,{__TOKEN_PUSH2-__TOKEN_DGE},{__SET_TOKEN({__TOKEN_PUSHDOT_DGE},__T_INFO(0){ }$2,__T_ARRAY(0))},


dnl # Q...
o...,,,
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_OVER:__TOKEN_PD0NE:__TOKEN_NIP},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_OVER_PD0NE_NIP},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_OVER:__TOKEN_PD0EQ:__TOKEN_NIP},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_OVER_PD0EQ_NIP},__TEMP)},
            __T_NAME(0):$1,                        {__TOKEN_OVER:__TOKEN_ADD},{__SET_TOKEN({__TOKEN_OVER_ADD},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,                        {__TOKEN_OVER:__TOKEN_SUB},{__SET_TOKEN({__TOKEN_OVER_SUB},__T_INFO(0){ }$2)},

dnl # R...
r...,,,
            __T_NAME(0)-$1,{__TOKEN_ROT-__TOKEN_DROP},{__SET_TOKEN({__TOKEN_ROT_DROP},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_ROT-__TOKEN_ROT},{__SET_TOKEN({__TOKEN_NROT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_ROT_DROP-__TOKEN_SWAP},{__SET_TOKEN({__TOKEN_NROT_NIP},__T_INFO(0){ }$2)},
            __T_NAME(0):$1:$#,{__TOKEN_R_FETCH-__TOKEN_PUSH},{__SET_TOKEN({__TOKEN_R_FETCH_PUSH},__T_INFO(0){ }$2,$3)},
            __T_NAME(0)-$1,{__TOKEN_ROT-__TOKEN_ADD},{__SET_TOKEN({__TOKEN_ROT_ADD},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_ROT-__TOKEN_SUB},{__SET_TOKEN({__TOKEN_ROT_SUB},__T_INFO(0){ }$2)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT:__TOKEN_1ADD:__TOKEN_NROT},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1ADD_NROT},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT:__TOKEN_1SUB:__TOKEN_NROT},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1SUB_NROT},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT:__TOKEN_2ADD:__TOKEN_NROT},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_2ADD_NROT},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT:__TOKEN_2SUB:__TOKEN_NROT},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_2SUB_NROT},__TEMP)},

            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_TO_R:__TOKEN_PUSHS:__TOKEN_R_FROM},{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_TO_R_PUSHS_R_FROM},__T_INFO(1){ }__T_INFO(0){ }$2,__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            
dnl # (C/H))STORE
s...,,,

"dup num !",,,
            __T_NAME(2):__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,__TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP, {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_DUP_PUSH_STORE}, __CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            __T_NAME(2):__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,__TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_DUP_PUSH_CSTORE},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            __T_NAME(2):__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,__TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_2DUP_HSTORE:__TOKEN_2DROP,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_DUP_PUSH_HSTORE},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_STORE,                         {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_STORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_CSTORE,                        {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_HSTORE,                        {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_HSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},

"num !" --> "dup num !" + "drop",,,
            __T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,__TOKEN_PUSHS:1:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_STORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__SET_TOKEN({__TOKEN_DROP},__dtto)},
            __T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,__TOKEN_PUSHS:1:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__SET_TOKEN({__TOKEN_DROP},__dtto)},
            __T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,__TOKEN_PUSHS:1:__TOKEN_2DUP_HSTORE:__TOKEN_2DROP,                      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_HSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__SET_TOKEN({__TOKEN_DROP},__dtto)},
            __T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_PUSHS:1:__TOKEN_STORE,                                          {__SET_TOKEN({__TOKEN_PUSH_STORE}, __T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_PUSHS:1:__TOKEN_CSTORE,                                         {__SET_TOKEN({__TOKEN_PUSH_CSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_PUSHS:1:__TOKEN_HSTORE,                                         {__SET_TOKEN({__TOKEN_PUSH_HSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},

"num num !",,,
            __T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,__TOKEN_PUSHS:2:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH2_STORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,__TOKEN_PUSHS:2:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH2_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_PUSHS:2:__TOKEN_STORE,                                          {__SET_TOKEN({__TOKEN_PUSH2_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_PUSHS:2:__TOKEN_CSTORE,                                         {__SET_TOKEN({__TOKEN_PUSH2_CSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_R_FETCH:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,             {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_R_FETCH_STORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_R_FETCH:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                 {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_R_FETCH_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                         __TOKEN_PUSH_R_FETCH:__TOKEN_STORE,                                     {__SET_TOKEN({__TOKEN_PUSH_R_FETCH_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_R_FETCH:__TOKEN_CSTORE,                                    {__SET_TOKEN({__TOKEN_PUSH_R_FETCH_CSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(2):__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1, __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP, {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_DUP_PUSH_STORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            __T_NAME(2):__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1, __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_DUP_PUSH_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            __T_NAME(2):__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1, __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_2DUP_HSTORE:__TOKEN_2DROP,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_DUP_PUSH_HSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,             __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_STORE,                         {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_STORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,             __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_CSTORE,                        {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,             __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_HSTORE,                        {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_HSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},


            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_PICK_PUSH_SWAP:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_PICK_PUSH_SWAP_STORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_PICK_PUSH_SWAP:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,          {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_PICK_PUSH_SWAP_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                         __TOKEN_PUSH_PICK_PUSH_SWAP:__TOKEN_STORE,                              {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH_SWAP_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_PICK_PUSH_SWAP:__TOKEN_CSTORE,                             {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH_SWAP_CSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_OVER:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_OVER_STORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_OVER:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                    {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_OVER_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                         __TOKEN_PUSH_OVER:__TOKEN_STORE,                                        {__SET_TOKEN({__TOKEN_PUSH_OVER_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_OVER:__TOKEN_CSTORE,                                       {__SET_TOKEN({__TOKEN_PUSH_OVER_CSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_I:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_I_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_J:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_J_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_K:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_K_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                         __TOKEN_PUSH_I:__TOKEN_STORE,                                           {__SET_TOKEN({__TOKEN_PUSH_I_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_J:__TOKEN_STORE,                                           {__SET_TOKEN({__TOKEN_PUSH_J_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_K:__TOKEN_STORE,                                           {__SET_TOKEN({__TOKEN_PUSH_K_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_I:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                       {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_I_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_J:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                       {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_J_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_K:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                       {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_K_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                         __TOKEN_PUSH_I:__TOKEN_CSTORE,                                          {__SET_TOKEN({__TOKEN_PUSH_I_CSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_J:__TOKEN_CSTORE,                                          {__SET_TOKEN({__TOKEN_PUSH_J_CSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_K:__TOKEN_CSTORE,                                          {__SET_TOKEN({__TOKEN_PUSH_K_CSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):$1,                         __TOKEN_PUSH2_RPICK:__TOKEN_STORE,                                      {__SET_TOKEN({__TOKEN_PUSH2_RPICK_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH2_RPICK:__TOKEN_CSTORE,                                     {__SET_TOKEN({__TOKEN_PUSH2_RPICK_CSTORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                 dodelat{__TOKEN_PUSH2_FETCH_1ADD_PUSH-__TOKEN_STORE},                           {__SET_TOKEN({__TOKEN_PUSH_FETCH_1ADD_PUSH_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_FETCH_1ADD_PUSH:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_FETCH_1ADD_PUSH_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_FETCH_2ADD_PUSH:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_FETCH_2ADD_PUSH_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_FETCH_PUSH_ADD_PUSH:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP, {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_FETCH_PUSH_ADD_PUSH_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                         __TOKEN_PUSH_FETCH_1ADD_PUSH:__TOKEN_STORE,                             {__SET_TOKEN({__TOKEN_PUSH_FETCH_1ADD_PUSH_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_FETCH_2ADD_PUSH:__TOKEN_STORE,                             {__SET_TOKEN({__TOKEN_PUSH_FETCH_2ADD_PUSH_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_FETCH_PUSH_ADD_PUSH:__TOKEN_STORE,                         {__SET_TOKEN({__TOKEN_PUSH_FETCH_PUSH_ADD_PUSH_STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_2DUP:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                     {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_STORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_2DUP:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                         {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_2DUP:__TOKEN_2DUP_HSTORE:__TOKEN_2DROP,                         {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_HSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},

            __T_NAME(3):__T_NAME(2)=__T_LAST_1_PAR(2):__T_NAME(1):__T_NAME(0):$1, 
               __TOKEN_OVER:__TOKEN_PUSH_RSHIFT=8:__TOKEN_OVER:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,
                  {__SET_TOKEN_X(eval(__COUNT_TOKEN-3),{__TOKEN_2DUP_HSTORE},__CONCATENATE_WITH({ },__T_INFO(3),__T_INFO(2),__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            
            __T_NAME(0):$1,                         __TOKEN_2DUP:__TOKEN_STORE,                                             {__SET_TOKEN({__TOKEN_2DUP_STORE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,                         __TOKEN_2DUP:__TOKEN_CSTORE,                                            {__SET_TOKEN({__TOKEN_2DUP_CSTORE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,                         __TOKEN_2DUP:__TOKEN_HSTORE,                                            {__SET_TOKEN({__TOKEN_2DUP_HSTORE},__T_INFO(0){ }$2)},

            __T_NAME(2):__T_NAME(1)=__T_LAST_1_PAR(1):__T_NAME(0):$1,                         
               __TOKEN_OVER:__TOKEN_PUSH_RSHIFT=8:__TOKEN_OVER:__TOKEN_CSTORE,
                  {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_2DUP_HSTORE},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            
            __T_NAME(0):$1,                         __TOKEN_2DUP_STORE:__TOKEN_2ADD,                                        {__SET_TOKEN({__TOKEN_2DUP_STORE_2ADD},__T_INFO(0){ }$2)},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_OVER_SWAP:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_STORE_1ADD}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_DROP},$2)},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_OVER_SWAP:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                    {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_CSTORE},     __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_DROP},$2)},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_OVER_SWAP:__TOKEN_2DUP_HSTORE:__TOKEN_2DROP,                    {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_HSTORE},     __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_DROP},$2)},
            __T_NAME(0):$1,                         __TOKEN_OVER_SWAP:__TOKEN_STORE,                                        {__SET_TOKEN({__TOKEN_OVER_SWAP_STORE}, __T_INFO(0){ }$2)},
            __T_NAME(0):$1,                         __TOKEN_OVER_SWAP:__TOKEN_CSTORE,                                       {__SET_TOKEN({__TOKEN_OVER_SWAP_CSTORE},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,                         __TOKEN_OVER_SWAP:__TOKEN_HSTORE,                                       {__SET_TOKEN({__TOKEN_OVER_SWAP_HSTORE},__T_INFO(0){ }$2)},

__T_NAME(1):eval(__T_ITEMS(1)0>20):__T_NAME(0):$1, __TOKEN_PUSHS:1:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP, 
{__SET_TOKEN({__TOKEN_PUSH2_STORE},__REMOVE_COMMA(__T_LAST_2_PAR(1)){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSHS},__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
Teoreticky by to slo prohodit pokud by prvni pushs nenacitalo neco z adresy kam pak bude store ukladat...,,,

__T_NAME(1):eval(__T_ITEMS(1)0>20):__T_NAME(0):$1, __TOKEN_PUSHS:1:__TOKEN_PUSH2_STORE:__TOKEN_2DROP, 
{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSHS},__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
Teoreticky by to slo prohodit pokud by prvni pushs nenacitalo neco z adresy kam pak bude store ukladat...,,,

__T_NAME(2):eval(__T_ITEMS(2)0>20):__T_NAME(1):__T_NAME(0):$1, __TOKEN_PUSHS:1:__TOKEN_PUSH2_STORE:__TOKEN_1ADD:__TOKEN_2DROP, 
{__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_PUSHS},__T_INFO(2){ 2drop},__DROP_2_PAR(__T_ARRAY(2))){}__DELETE_LAST_TOKEN},
Teoreticky by to slo prohodit pokud by prvni pushs nenacitalo neco z adresy kam pak bude store ukladat...,,,

__T_NAME(2):eval(__T_ITEMS(2)0>20):__T_NAME(1):__T_NAME(0):$1, __TOKEN_PUSHS:1:__TOKEN_PUSH2_STORE:__TOKEN_2ADD:__TOKEN_2DROP, 
{__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_PUSHS},__T_INFO(2){ 2drop},__DROP_2_PAR(__T_ARRAY(2))){}__DELETE_LAST_TOKEN},
Teoreticky by to slo prohodit pokud by prvni pushs nenacitalo neco z adresy kam pak bude store ukladat...,,,

__T_NAME(2):eval(__T_ITEMS(2)0>20):__T_NAME(1):__T_NAME(0):$1, __TOKEN_PUSHS:1:__TOKEN_PUSH2_STORE:__TOKEN_1SUB:__TOKEN_2DROP, 
{__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_PUSHS},__T_INFO(2){ 2drop},__DROP_2_PAR(__T_ARRAY(2))){}__DELETE_LAST_TOKEN},
Teoreticky by to slo prohodit pokud by prvni pushs nenacitalo neco z adresy kam pak bude store ukladat...,,,

__T_NAME(2):eval(__T_ITEMS(2)0>20):__T_NAME(1):__T_NAME(0):$1, __TOKEN_PUSHS:1:__TOKEN_PUSH2_STORE:__TOKEN_2SUB:__TOKEN_2DROP, 
{__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_PUSHS},__T_INFO(2){ 2drop},__DROP_2_PAR(__T_ARRAY(2))){}__DELETE_LAST_TOKEN},
Teoreticky by to slo prohodit pokud by prvni pushs nenacitalo neco z adresy kam pak bude store ukladat...,,,

            __T_NAME(0):eval(__T_ITEMS(0)>2):$1,    __TOKEN_PUSHS:1:__TOKEN_STORE,                                          {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_STORE},__REMOVE_COMMA(__T_LAST_2_PAR(1)){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},

            __T_NAME(0):$1,                         __TOKEN_PUSH_STORE:__TOKEN_PUSHS,                                       {__SET_TOKEN({__TOKEN_DUP_PUSH_STORE}, __T_INFO(0),__T_ARRAY(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_DROP,__dtto){}__INC_TOKEN_COUNT{}__SET_TOKEN($1,$2,shift(shift($@)))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_CSTORE:__TOKEN_PUSHS,                                      {__SET_TOKEN({__TOKEN_DUP_PUSH_CSTORE},__T_INFO(0),__T_ARRAY(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_DROP,__dtto){}__INC_TOKEN_COUNT{}__SET_TOKEN($1,$2,shift(shift($@)))},
            __T_NAME(0):$1,                         __TOKEN_PUSH_HSTORE:__TOKEN_PUSHS,                                      {__SET_TOKEN({__TOKEN_DUP_PUSH_HSTORE},__T_INFO(0),__T_ARRAY(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_DROP,__dtto){}__INC_TOKEN_COUNT{}__SET_TOKEN($1,$2,shift(shift($@)))},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_2DUP_STORE:__TOKEN_NIP:__TOKEN_1ADD,                            {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_STORE_1ADD},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_NIP},__dtto)},

num 2pick !,,,
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_OVER_PUSH_SWAP:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,           {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_PUSH_SWAP_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
num 2pick c!,,,
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_OVER_PUSH_SWAP:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,               {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_PUSH_SWAP_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},

num 3pick !,,,
            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1, __TOKEN_2_PICK:__TOKEN_PUSH_SWAP:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP, {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_PUSH_3_PICK_STORE},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},

num 3pick c!,,,
            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1, __TOKEN_2_PICK:__TOKEN_PUSH_SWAP:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_PUSH_3_PICK_CSTORE},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},

num 4pick !,,,
            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1, __TOKEN_3_PICK:__TOKEN_PUSH_SWAP:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP, {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_PUSH_4_PICK_STORE},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},

num 4pick c!,,,
            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1, __TOKEN_3_PICK:__TOKEN_PUSH_SWAP:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_PUSH_4_PICK_CSTORE},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_TUCK:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                     {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_STORE},  __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_NIP},__dtto)},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_TUCK:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                         {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_CSTORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_NIP},__dtto)},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_TUCK:__TOKEN_2DUP_HSTORE:__TOKEN_2DROP,                         {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_HSTORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_NIP},__dtto)},

            __T_NAME(0):$1,                         __TOKEN_TUCK:__TOKEN_STORE,                                             {__SET_TOKEN({__TOKEN_2DUP_STORE},  __CONCATENATE_WITH({ },__T_INFO(0),$2)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP},__dtto)},
            __T_NAME(0):$1,                         __TOKEN_TUCK:__TOKEN_CSTORE,                                            {__SET_TOKEN({__TOKEN_2DUP_CSTORE}, __CONCATENATE_WITH({ },__T_INFO(0),$2)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP},__dtto)},
            __T_NAME(0):$1,                         __TOKEN_TUCK:__TOKEN_HSTORE,                                            {__SET_TOKEN({__TOKEN_2DUP_HSTORE}, __CONCATENATE_WITH({ },__T_INFO(0),$2)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP},__dtto)},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_2DUP_STORE:__TOKEN_NIP:__TOKEN_2ADD,                            {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_TUCK_STORE_2ADD},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                         __TOKEN_TUCK_STORE:__TOKEN_2ADD,                                        {__SET_TOKEN({__TOKEN_TUCK_STORE_2ADD},__T_INFO(0){ }$2)},
            
dnl # S...
s...,,,

            __T_NAME(0):$1,{__TOKEN_2DUP_STORE:__TOKEN_1ADD}, {__SET_TOKEN({__TOKEN_2DUP_STORE_1ADD}, __T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_2DUP_CSTORE:__TOKEN_1ADD},{__SET_TOKEN({__TOKEN_2DUP_CSTORE_1ADD},__T_INFO(0){ }$2)},
            __T_NAME(0):$1,{__TOKEN_2DUP_HSTORE:__TOKEN_1ADD},{__SET_TOKEN({__TOKEN_2DUP_HSTORE_1ADD},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1, {__TOKEN_SPACE-__TOKEN_DOT},  {__SET_TOKEN({__TOKEN_SPACE_DOT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1, {__TOKEN_SPACE-__TOKEN_UDOT}, {__SET_TOKEN({__TOKEN_SPACE_UDOT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1, {__TOKEN_SPACE-__TOKEN_DDOT}, {__SET_TOKEN({__TOKEN_SPACE_DDOT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1, {__TOKEN_SPACE-__TOKEN_UDDOT},{__SET_TOKEN({__TOKEN_SPACE_UDDOT},__T_INFO(0){ }$2)},

            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_IF},{__SET_TOKEN({__TOKEN_SWAP_IF},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_DROP},{__SET_TOKEN({__TOKEN_NIP},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_EQ},{__SET_TOKEN({__TOKEN_EQ},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_NE},{__SET_TOKEN({__TOKEN_NE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_LT},{__SET_TOKEN({__TOKEN_GT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_GT},{__SET_TOKEN({__TOKEN_LT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_LE},{__SET_TOKEN({__TOKEN_GE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_GE},{__SET_TOKEN({__TOKEN_LE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_UEQ},{__SET_TOKEN({__TOKEN_EQ},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_UNE},{__SET_TOKEN({__TOKEN_NE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_ULT},{__SET_TOKEN({__TOKEN_UGT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_UGT},{__SET_TOKEN({__TOKEN_ULT},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_ULE},{__SET_TOKEN({__TOKEN_UGE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_UGE},{__SET_TOKEN({__TOKEN_ULE},__T_INFO(0){ }$2)},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_OVER},{__SET_TOKEN({__TOKEN_TUCK},__T_INFO(0){ }$2)},

            __T_NAME(1):__T_NAME(0):$1,  __TOKEN_SWAP:__TOKEN_1ADD:__TOKEN_SWAP,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_SWAP_1ADD_SWAP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,  __TOKEN_SWAP:__TOKEN_2ADD:__TOKEN_SWAP,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_SWAP_2ADD_SWAP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,  __TOKEN_SWAP:__TOKEN_1SUB:__TOKEN_SWAP,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_SWAP_1SUB_SWAP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,  __TOKEN_SWAP:__TOKEN_2SUB:__TOKEN_SWAP,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_SWAP_2SUB_SWAP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN},

            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_PDSUB},{__SET_TOKEN({__TOKEN_SWAP_PDSUB},__T_INFO(0){ }$2)},
dnl # T...
t...,,,


dnl # U...
dnl # V...
dnl # W...
w...,,,
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT_1ADD_NROT_2OVER_NIP:__TOKEN_CFETCH_0CNE:__TOKEN_WHILE},{define({__TEMP},__T_INFO(1){ }__T_INFO(0){ }$2){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE},__TEMP)},

dnl # X...
dnl # Y...
dnl # Z...
z,,,
        {dnl
__{}__{}__{}__INC_TOKEN_COUNT{}dnl
__{}__{}__{}ifelse($1,__TOKEN_LOOP,{__SET_LOOP_STEP(LOOP_STACK,1)}){}dnl
__{}__{}__{}__SET_TOKEN($@){}dnl
__{}__{}})},
__{}{dnl
__{}__{}define({__COUNT_TOKEN},1){}dnl
__{}__{}ifelse(dnl
__{}__{}__{}$1:__IS_MEM_REF($3),__TOKEN_PUSHDOT:1,    {__SET_TOKEN({__TOKEN_PUSHS},$2,($3+2),$3)},
__{}__{}__{}$1:__IS_NUM($3),    __TOKEN_PUSHDOT:1,    {__SET_TOKEN({__TOKEN_PUSHS},$2,__HEX_DE($3),__HEX_HL($3))},
__{}__{}{dnl
__{}__{}__{}__SET_TOKEN($@){}dnl
__{}__{}}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__ASM_TOKEN_NOPE},{}){}dnl
dnl
dnl
dnl
define({__SET_CHECK_TOKEN}, {__SET_TOKEN($1,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),__T_ARRAY(0)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_NOPE})}){}dnl
dnl
define({__SET_CHECK_TOKEN2},{__SET_TOKEN($1,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),__T_ARRAY(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_NOPE})}){}dnl
dnl
define({__SET_CHECK_TOKEN3},{__SET_TOKEN($1,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),__T_ARRAY(1),__T_ARRAY(0)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_NOPE})}){}dnl
dnl
dnl
dnl
dnl # xxx + pushs = xxx_pushs ( after all pushs + xxx = pushs_xxx rule is done )
define({__CHECK_TOKEN},{ifelse(dnl
__T_NAME(1):__T_NAME(0),                     __TOKEN_2SWAP:__TOKEN_2OVER_DADD,       {__SET_CHECK_TOKEN(__TOKEN_2SWAP_2OVER_DADD)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2OVER_DADD:__TOKEN_2SWAP,       {__SET_CHECK_TOKEN(__TOKEN_2OVER_DADD_2SWAP)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_PUSH_SWAP:__TOKEN_PUSH_SWAP,    {__SET_CHECK_TOKEN3(__TOKEN_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0),           __TOKEN_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,    {__SET_CHECK_TOKEN3(__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0), __TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,    {__SET_CHECK_TOKEN3(__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_EQ,            {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_EQ)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_EQ:__TOKEN_UNTIL,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_EQ_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_EQ:__TOKEN_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_EQ_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_EQ:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_EQ_IF)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_NE,            {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_NE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_NE:__TOKEN_UNTIL,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_NE_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_NE:__TOKEN_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_NE_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_NE:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_NE_IF)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP:__TOKEN_PUSH2_DEQ,         {__SET_CHECK_TOKEN(__TOKEN_2DUP_PUSH2_DEQ)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP:__TOKEN_PUSH2_DNE,         {__SET_CHECK_TOKEN(__TOKEN_2DUP_PUSH2_DNE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP:__TOKEN_PUSH2_DLT,         {__SET_CHECK_TOKEN(__TOKEN_2DUP_PUSH2_DLT)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DEQ:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DEQ_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DNE:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DNE_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DLT:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DLT_IF)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LT_IF,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LT_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LE_IF,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GE_IF,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GT_IF,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GT_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULT_IF,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULT_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULE_IF,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGE_IF,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGT_IF,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGT_IF)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LT_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LT_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LE_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GE_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GT_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GT_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULT_WHILE,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULT_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULE_WHILE,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGE_WHILE,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGT_WHILE,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGT_WHILE)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0), __TOKEN_DUP_PUSHS:1:__TOKEN_CEQ,        {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_CEQ)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0), __TOKEN_DUP_PUSHS:1:__TOKEN_HEQ,        {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_HEQ)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_CEQ:__TOKEN_UNTIL,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_CEQ_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_HEQ:__TOKEN_UNTIL,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_HEQ_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_CNE,           {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_CNE)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_EQ_IF,         {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_EQ_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_NE_IF,         {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_NE_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_CEQ_IF,        {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_CEQ_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_CNE_IF,        {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_CNE_IF)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_SWAP,          {__SET_CHECK_TOKEN(__TOKEN_PUSH_OVER)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE:__TOKEN_DUP_PUSH_CSTORE,  {__SET_CHECK_TOKEN3(__TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_CSTORE:__TOKEN_DUP_PUSH_CSTORE,                  {__SET_CHECK_TOKEN3(__TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE:__TOKEN_DUP_PUSH_HSTORE,  {__SET_CHECK_TOKEN3(__TOKEN_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_HSTORE:__TOKEN_DUP_PUSH_HSTORE,                  {__SET_CHECK_TOKEN3(__TOKEN_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_HSTORE,        {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_HSTORE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_STORE,         {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_STORE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_ADD,           {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_ADD)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH2_WITHIN_IF,    {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH2_WITHIN_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH2_WITHIN_WHILE, {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH2_WITHIN_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH2_WITHIN_UNTIL, {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH2_WITHIN_UNTIL)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_FETCH:__TOKEN_PUSHS,            {__SET_CHECK_TOKEN(__TOKEN_FETCH_PUSHS)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_NIP:__TOKEN_PUSHS,              {__SET_CHECK_TOKEN(__TOKEN_NIP_PUSHS)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_NIP:__TOKEN_PUSH_SWAP,          {__SET_CHECK_TOKEN(__TOKEN_NIP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DROP:__TOKEN_PUSHS,             {__SET_CHECK_TOKEN(__TOKEN_DROP_PUSHS)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DROP:__TOKEN_PUSH_OVER,         {__SET_CHECK_TOKEN(__TOKEN_DROP_PUSH_OVER)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DROP:__TOKEN_PUSH_RPICK,        {__SET_CHECK_TOKEN(__TOKEN_DROP_PUSH_RPICK)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DROP:__TOKEN_PUSH_PICK,         {__SET_CHECK_TOKEN(__TOKEN_DROP_PUSH_PICK)},
__T_NAME(1):__T_NAME(0):__T_ITEMS(0),  __TOKEN_DROP_DUP:__TOKEN_PUSHS:1,       {__SET_CHECK_TOKEN(__TOKEN_DROP_DUP_PUSH)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DROP_DUP:__TOKEN_PUSH_SWAP,     {__SET_CHECK_TOKEN(__TOKEN_DROP_PUSH_OVER)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_OVER:__TOKEN_PUSHS,             {__SET_CHECK_TOKEN(__TOKEN_OVER_PUSHS)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_OVER:__TOKEN_PUSH_ADD,          {__SET_CHECK_TOKEN(__TOKEN_OVER_PUSH_ADD)},
udelano nahore __T_NAME(1):__T_NAME(0),                     __TOKEN_OVER:__TOKEN_PUSH_SWAP,         {__SET_CHECK_TOKEN(__TOKEN_OVER_PUSH_SWAP)},
udelano nahore a c! je ted "2dup c! 2drop" __T_NAME(1):__T_NAME(0),                     __TOKEN_OVER_PUSH_SWAP:__TOKEN_CSTORE,  {__SET_CHECK_TOKEN2(__TOKEN_OVER_PUSH_SWAP_CSTORE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSHS,              {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSHS)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_2DROP:__TOKEN_PUSHS,            {__SET_CHECK_TOKEN(__TOKEN_2DROP_PUSHS)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_SWAP:__TOKEN_PUSHS,             {__SET_CHECK_TOKEN(__TOKEN_SWAP_PUSHS)},
xxx,yyy,{}){}dnl
}){}dnl
dnl
dnl
dnl
define({__CHECK_ALL_TOKENS_REC},{dnl
__{}ifelse(eval(__COUNT_TOKEN<__SUM_TOKEN),1,{dnl
__{}__{}__CHECK_TOKEN{}dnl
__{}__{}define({__COUNT_TOKEN},eval(__COUNT_TOKEN+1)){}dnl
__{}$0{}dnl
__{}},
__{}{dnl
__{}__{}define({__COUNT_TOKEN},__SUM_TOKEN){}dnl
__{}__{}__CHECK_TOKEN{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__CHECK_ALL_TOKENS},{dnl
__{}define({__SUM_TOKEN},__COUNT_TOKEN){}dnl
__{}define({__COUNT_TOKEN},2){}dnl
__{}__CHECK_ALL_TOKENS_REC{}dnl
}){}dnl
dnl
dnl
dnl
dnl #    sed 's#^\([^;{]*\s\|^\)NROT\s\+SWAP\s\+_2SWAP\sSWAP\(\s\|$\)#\1STACK_BCAD\2#gi' |
dnl #    sed 's#^\([^;{]*\s\|^\)OVER\s\+_2OVER\s\+DROP\(\s\|$\)#\1STACK_CBABC\2#gi' |
dnl #    sed 's#^\([^;{]*\s\|^\)_2OVER\s\+NIP\s\+_2OVER\s\+NIP\s\+SWAP\(\s\|$\)#\1STACK_CBABC\2#gi' |
dnl #    sed 's#^\([^;{]*\s\|^\)OVER\s\+3\s\+PICK\(\s\|$\)#\1STACK_CBABC\2#gi' |
dnl #    sed 's#^\([^;{]*\s\|^\)2\s\+PICK\s\+2\s\+PICK\s\+SWAP\(\s\|$\)#\1STACK_CBABC\2#gi' |
dnl
dnl
dnl
define({__A},{$1$2}){}dnl
dnl
define({__COMPILE_REC},{ifelse(eval(__COUNT_TOKEN>__TOKEN_I),{1},{dnl
__{}define({__TOKEN_I},eval(__TOKEN_I+1))dnl
__{}define({__COMPILE_INFO},__GET_TOKEN_INFO(__TOKEN_I))dnl
__{}ifelse(__COMPILE_INFO,{__dtto},{define({__COMPILE_INFO},__GET_TOKEN_INFO(eval(__TOKEN_I-1)))})dnl
__{}ifelse(__GET_TOKEN_PARAM(__TOKEN_I),{()},{dnl
__{}__{}__A({__ASM}substr(__GET_TOKEN_NAME(__TOKEN_I),1))},
__{}{dnl
__{}__{}__A({__ASM}substr(__GET_TOKEN_NAME(__TOKEN_I),1){}__GET_TOKEN_PARAM(__TOKEN_I))}){}dnl
__{}$0{}dnl
})}){}dnl
dnl
dnl
dnl
define({__COMPILE},{ifdef({__COUNT_TOKEN},{dnl
__{}__CHECK_ALL_TOKENS{}dnl
__{}define({__TOKEN_I},0)dnl
__{}$0_REC{}dnl
})}){}dnl
dnl
dnl
dnl
dnl
define({__SWAP2DEF},{dnl
__{}define({__SWAP2DEF_TMP},$1)define({$1},$2)define({$2},__SWAP2DEF_TMP)}){}dnl
dnl
dnl
dnl
define({__XOR_REG8_8BIT},{dnl
dnl # Input
dnl #   $1 name reg
dnl #   $2 8bit value
ifelse(__IS_NUM($2),{0},{
__{}   if (($2) = 0x00)
__{}   else
__{}    if (($2) = 0xFF)
__{}      ld    A, $1          ; 1:4       _TMP_INFO
__{}      cpl                 ; 1:4       _TMP_INFO
__{}      ld    $1, A          ; 1:4       _TMP_INFO   ($1 xor 0xFF) = invert $1
__{}    else
__{}      ld    A,format({%-12s},$2); 2:7       _TMP_INFO
__{}      xor   $1             ; 1:4       _TMP_INFO
__{}      ld    $1, A          ; 1:4       _TMP_INFO
__{}    endif
__{}   endif},
__{}{ifelse(__HEX_L($2),{0x00},{},
__{}__HEX_L($2),{0xFF},{
__{}__{}    ld    A, $1          ; 1:4       _TMP_INFO
__{}__{}    cpl                 ; 1:4       _TMP_INFO
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO   ($1 xor 0xFF) = invert $1},
__{}{
__{}__{}    ld    A, __HEX_L($2)       ; 2:7       _TMP_INFO
__{}__{}    xor   $1             ; 1:4       _TMP_INFO
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO})})}){}dnl
dnl
dnl
dnl
define({__XOR_REG16_16BIT},{dnl
dnl # Input
dnl #   $1 name reg pair
dnl #   $2 16bit value
ifelse(dnl
__IS_MEM_REF($2),{1},{
__{}    ld    A,format({%-12s},$2); 3:13      _TMP_INFO
__{}    xor   substr($1,1,1)             ; 1:4       _TMP_INFO
__{}    ld    substr($1,1,1), A          ; 1:4       _TMP_INFO
__{}    ld    A,format({%-12s},($2+1)); 3:13      _TMP_INFO
__{}    xor   substr($1,0,1)             ; 1:4       _TMP_INFO
__{}    ld    substr($1,0,1), A          ; 1:4       _TMP_INFO},
__IS_NUM($2),{0},{
__{}  .warning {$0}($@): M4 does not know the "{$2}" value and therefore cannot optimize the code.
__{}__XOR_REG8_8BIT(substr($1,1,1),0xFF & ($2)){}dnl
__{}__XOR_REG8_8BIT(substr($1,0,1),+($2) >> 8)},
{dnl
__{}__XOR_REG8_8BIT(substr($1,1,1),__HEX_L($2)){}dnl
__{}__XOR_REG8_8BIT(substr($1,0,1),__HEX_H($2)){}dnl
})}){}dnl
dnl
dnl
define({__OR_REG8_8BIT},{dnl
dnl # Input
dnl #   $1 name reg
dnl #   $2 8bit value
ifelse(__IS_NUM($2),{0},{
__{}   if (($2) = 0xFF)
__{}     ld    $1, 0xFF       ; 2:7       _TMP_INFO
__{}   else
__{}    if (($2) = 0x01)
__{}      set   0, $1          ; 2:8       _TMP_INFO
__{}    else
__{}     if (($2) = 0x02)
__{}       set   1, $1          ; 2:8       _TMP_INFO
__{}     else
__{}      if (($2) = 0x04)
__{}        set   2, $1          ; 2:8       _TMP_INFO
__{}      else
__{}       if (($2) = 0x08)
__{}         set   3, $1          ; 2:8       _TMP_INFO
__{}       else
__{}        if (($2) = 0x10)
__{}          set   4, $1          ; 2:8       _TMP_INFO
__{}        else
__{}         if (($2) = 0x20)
__{}           set   5, $1          ; 2:8       _TMP_INFO
__{}         else
__{}          if (($2) = 0x40)
__{}            set   6, $1          ; 2:8       _TMP_INFO
__{}          else
__{}           if (($2) = 0x80)
__{}             set   7, $1          ; 2:8       _TMP_INFO
__{}           else
__{}            if ((($2) > 0x00) && (($2) <= 0xFF))
__{}              ld    A,format({%-12s},$2); 2:7       _TMP_INFO
__{}              or    $1             ; 1:4       _TMP_INFO
__{}              ld    $1, A          ; 1:4       _TMP_INFO
__{}            endif
__{}           endif
__{}          endif
__{}         endif
__{}        endif
__{}       endif
__{}      endif
__{}     endif
__{}    endif
__{}   endif},
{dnl
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
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO})})}){}dnl
dnl
dnl
dnl
define({__OR_REG16_16BIT},{dnl
dnl # Input
dnl #   $1 name reg pair
dnl #   $2 16bit value
ifelse(dnl
__IS_MEM_REF($2),{1},{
__{}    ld    A,format({%-12s},$2); 3:13      _TMP_INFO
__{}    or    substr($1,1,1)             ; 1:4       _TMP_INFO
__{}    ld    substr($1,1,1), A          ; 1:4       _TMP_INFO
__{}    ld    A,format({%-12s},($2+1)); 3:13      _TMP_INFO
__{}    or    substr($1,0,1)             ; 1:4       _TMP_INFO
__{}    ld    substr($1,0,1), A          ; 1:4       _TMP_INFO},
__IS_NUM($2),{0},{
__{}  .warning {$0}($@): M4 does not know the "{$2}" value and therefore cannot optimize the code.
__{}  if (($2) = 0xFFFF)
__{}    ld   $1, 0xFFFF     ; 3:10      _TMP_INFO
__{}  else{}dnl
__{}__OR_REG8_8BIT(substr($1,1,1),0xFF & ($2)){}dnl
__{}__OR_REG8_8BIT(substr($1,0,1),+($2) >> 8)
__{}  endif},
{dnl
__{}ifelse(__HEX_HL($2),0xFFFF,{
__{}    ld   $1, 0xFFFF     ; 3:10      _TMP_INFO},
__{}{dnl
__{}__{}__OR_REG8_8BIT(substr($1,1,1),__HEX_L($2)){}dnl
__{}__{}__OR_REG8_8BIT(substr($1,0,1),__HEX_H($2)){}dnl
})})}){}dnl
dnl
dnl
dnl
define({__AND_REG8_8BIT},{dnl
dnl # Input
dnl #   $1 name reg
dnl #   $2 8bit value with hex form 0xNN
dnl #   $3 name reg
dnl #   $4 8bit value with hex form 0xNN, $3 = $4
dnl # Output
dnl #   code $1 = $1 and $2
ifelse(dnl
__IS_MEM_REF($2),{1},{
__{}ifelse(dnl
__{}$1,{C},{    ld    A,format({%-12s},$2); 3:13      _TMP_INFO},
__{}$1,{E},{    ld    A,format({%-12s},$2); 3:13      _TMP_INFO},
__{}$1,{L},{    ld    A,format({%-12s},$2); 3:13      _TMP_INFO},
__{}$1,{B},{    ld    A,format({%-12s},($2+1)); 3:13      _TMP_INFO},
__{}$1,{D},{    ld    A,format({%-12s},($2+1)); 3:13      _TMP_INFO},
__{}$1,{H},{    ld    A,format({%-12s},($2+1)); 3:13      _TMP_INFO})
__{}    and   $1             ; 1:4       _TMP_INFO
__{}    ld    $1, A          ; 1:4       _TMP_INFO},
__{}$2,$4,{
__{}__{}    ld    A, $3          ; 1:4       _TMP_INFO
__{}__{}    and   $1             ; 1:4       _TMP_INFO
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO},
__IS_NUM($2),{0},{
__{}   if (($2) = 0x00)
__{}ifelse(0x00,$4,{dnl
__{}__{}     ld    $1, $3          ; 1:4       _TMP_INFO},
__{}{dnl
__{}__{}     ld    $1, 0x00       ; 2:7       _TMP_INFO})
__{}   else
__{}    if (($2) = 0xFE)
__{}      res   0, $1          ; 2:8       _TMP_INFO
__{}    else
__{}     if (($2) = 0xFD)
__{}       res   1, $1          ; 2:8       _TMP_INFO
__{}     else
__{}      if (($2) = 0xFB)
__{}        res   2, $1          ; 2:8       _TMP_INFO
__{}      else
__{}       if (($2) = 0xF7)
__{}         res   3, $1          ; 2:8       _TMP_INFO
__{}       else
__{}        if (($2) = 0xEF)
__{}          res   4, $1          ; 2:8       _TMP_INFO
__{}        else
__{}         if (($2) = 0xDF)
__{}           res   5, $1          ; 2:8       _TMP_INFO
__{}         else
__{}          if (($2) = 0xBF)
__{}            res   6, $1          ; 2:8       _TMP_INFO
__{}          else
__{}           if (($2) = 0x7F)
__{}             res   7, $1          ; 2:8       _TMP_INFO
__{}           else
__{}            if ((($2) > 0x00) && (($2) <= 0xFF))
__{}ifelse($4,,{dnl
__{}__{}              ld    A,format({%-12s},$2); 2:7       _TMP_INFO},
__{}{dnl
__{}__{}             if (($2) = $4)
__{}__{}               ld    A, $3          ; 1:4       _TMP_INFO
__{}__{}             else
__{}__{}               ld    A,format({%-12s},$2); 2:7       _TMP_INFO
__{}__{}             endif})
__{}              and   $1             ; 1:4       _TMP_INFO
__{}              ld    $1, A          ; 1:4       _TMP_INFO
__{}            endif
__{}           endif
__{}          endif
__{}         endif
__{}        endif
__{}       endif
__{}      endif
__{}     endif
__{}    endif
__{}   endif},
{dnl
__{}ifelse(__HEX_L($2),{0xFF},{},
__{}$1:$2,$3:$4,{
__{}__{}                        ;           _TMP_INFO   $1 = $2},
__{}$2:$4,{0x00:0x00},{
__{}__{}    ld    $1, $3          ; 1:4       _TMP_INFO},
__{}__HEX_L($2),{0x00},{
__{}__{}    ld    $1, 0x00       ; 2:7       _TMP_INFO},
__{}__HEX_L($2),{0xFE},{
__{}__{}    res   0, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0xFD},{
__{}__{}    res   1, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0xFB},{
__{}__{}    res   2, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0xF7},{
__{}__{}    res   3, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0xEF},{
__{}__{}    res   4, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0xDF},{
__{}__{}    res   5, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0xBF},{
__{}__{}    res   6, $1          ; 2:8       _TMP_INFO},
__{}__HEX_L($2),{0x7F},{
__{}__{}    res   7, $1          ; 2:8       _TMP_INFO},
__{}$2,$4,{
__{}__{}    ld    A, $3          ; 1:4       _TMP_INFO
__{}__{}    and   $1             ; 1:4       _TMP_INFO
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO},
__{}{
__{}__{}    ld    A, __HEX_L($2)       ; 2:7       _TMP_INFO
__{}__{}    and   $1             ; 1:4       _TMP_INFO
__{}__{}    ld    $1, A          ; 1:4       _TMP_INFO})})}){}dnl
dnl
dnl
dnl
define({__AND_REG16_16BIT},{dnl
dnl # Input
dnl #   $1 name reg pair
dnl #   $2 16bit value
dnl #   $3 name reg
dnl #   $4 8bit value with hex form 0xNN, $3 = $4
ifelse(dnl
__IS_MEM_REF($2),{1},{
__{}    ld    A,format({%-12s},$2); 3:13      _TMP_INFO
__{}    and   substr($1,1,1)             ; 1:4       _TMP_INFO
__{}    ld    substr($1,1,1), A          ; 1:4       _TMP_INFO
__{}    ld    A,format({%-12s},($2+1)); 3:13      _TMP_INFO
__{}    and   substr($1,0,1)             ; 1:4       _TMP_INFO
__{}    ld    substr($1,0,1), A          ; 1:4       _TMP_INFO},
__IS_NUM($2),{0},{
__{}  .warning {$0}($@): M4 does not know the "{$2}" value and therefore cannot optimize the code.
__{}  if (($2) = 0x0000)
__{}    ld   $1, 0x0000     ; 3:10      _TMP_INFO
__{}  else{}dnl
__{}__AND_REG8_8BIT(substr($1,1,1),0xFF & ($2),$3,$4){}dnl
__{}__AND_REG8_8BIT(substr($1,0,1),+($2) >> 8,$3,$4)
__{}  endif},
{dnl
__{}ifelse(__HEX_HL($2),{0x0000},{
__{}    ld   $1, 0x0000     ; 3:10      _TMP_INFO},
__{}{dnl
__{}__{}__AND_REG8_8BIT(substr($1,1,1),__HEX_L($2),$3,$4){}dnl
__{}__{}__AND_REG8_8BIT(substr($1,0,1),__HEX_H($2),$3,$4){}dnl
})})}){}dnl
dnl
dnl
dnl
define({__LD_R_NUM},{dnl
dnl #errprint({
dnl #}info:$1 t_reg:$2 t_val:$3 s_reg:$4 s_val:$5){}dnl
dnl # Input:
dnl #  $1 info
dnl #  $2 Name of the target registry
dnl #  $3 Searched value that is needed
dnl #  $4 Source registry name
dnl #  $5 Source registry value
__{}define({__CLOCKS},10000000){}dnl
__{}__LD4($2,$3,$4,$5){}dnl
__{}__LD4($2,$3,$6,$7){}dnl
__{}__LD4($2,$3,$8,$9){}dnl
__{}__LD4($2,$3,$10,$11){}dnl
__{}__LD4($2,$3,$12,$13){}dnl
__{}define({_TMP_INFO},$1){}dnl
__{}define({__CODE},__CODE){}dnl
__{}__CODE{}dnl
}){}dnl
dnl
dnl
dnl
define({__LD4},{dnl
dnl $2->$1 && $3=$4
dnl # Input:
dnl #  __CLOCKS = max!!!
dnl #  $1 Name of the target registry
dnl #  $2 Searched hex value that is needed
dnl #  $3 Source registry name
dnl #  $4 Source hex registry value
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
__{}__{}ifelse($1:__HEX_L($2):eval(__CLOCKS>4),{A:0x00:1},{dnl
__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    xor   $1             ; 1:4       {_TMP_INFO}})},
__{}__{}$1:__IS_MEM_REF($2):eval(__CLOCKS>13),{A:1:1},{dnl
__{}__{}__{}define({__CLOCKS},13){}dnl
__{}__{}__{}define({__BYTES},3){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    A{{,}}format({%-12s},$2); 3:13      {_TMP_INFO}})},
__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7),{0:1},{dnl
__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})})},
__{}$4,{},{dnl # no source value
__{}__{}ifelse($1:__HEX_L($2):eval(__CLOCKS>4),{A:0x00:1},{dnl
__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    xor   A         ; 1:4       {_TMP_INFO}})},
__{}__{}$1:__IS_MEM_REF($2):eval(__CLOCKS>13),{A:1:1},{dnl
__{}__{}__{}define({__CLOCKS},13){}dnl
__{}__{}__{}define({__BYTES},3){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    A{{,}}format({%-12s},$2); 3:13      {_TMP_INFO}})},
__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7),{0:1},{dnl
__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})})},
__{}$1,$3,{dnl # Identical register
__{}__{}ifelse($4,{},{dnl # empty value because 0xFF==__HEX_L({}-1) or 0x01==__HEX_L({}+1)
__{}__{}__{}ifelse($1:__HEX_L($2):eval(__CLOCKS>4),{A:0x00:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    xor   A         ; 1:4       {_TMP_INFO}})},
__{}__{}__{}$1:__IS_MEM_REF($2):eval(__CLOCKS>13 && len($1)>0 && len($2)>0),{A:1:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},13){}dnl
__{}__{}__{}__{}define({__BYTES},3){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    A{{,}}format({%-12s},$2); 3:13      {_TMP_INFO}})},
__{}__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7 && len($1)>0 && len($2)>0),{0:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})})},
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
__{}__{}$1:__HEX_L($2),{A:0x00},{dnl
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    xor   A             ; 1:4       {_TMP_INFO}})})},
__{}__{}$1:__HEX_L($2),A:__HEX_L($4+$4),{dnl
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    add   A{{,}} A          ; 1:4       {_TMP_INFO}})})},
__{}__{}$1:__HEX_L($2),A:__HEX_L(__HEX_L(128*($4))+(__HEX_L($4)>>1)),{dnl
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    rrca                ; 1:4       {_TMP_INFO}})})},
__{}__{}{dnl # no match found
__{}__{}__{}ifelse($1:__IS_MEM_REF($2):eval(__CLOCKS>13),{A:1:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},13){}dnl
__{}__{}__{}__{}define({__BYTES},3){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    A{{,}}format({%-12s},$2); 3:13      {_TMP_INFO}})},
__{}__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7),{0:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})})})},
__{}{dnl # different register
__{}__{}ifelse($2,$4,{dnl # match found
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} $3          ; 1:4       {_TMP_INFO}   $1 = $3 = $4})})},
__{}__{}{dnl # no match found
__{}__{}__{}ifelse($1:__HEX_L($2):__eval(__CLOCKS>4),{A:0x00:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    xor   A          ; 1:4       {_TMP_INFO}})},
__{}__{}__{}$1:__IS_MEM_REF($2):eval(__CLOCKS>13),{A:1:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},13){}dnl
__{}__{}__{}__{}define({__BYTES},3){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    A{{,}}format({%-12s},$2); 3:13      {_TMP_INFO}})},
__{}__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7),{0:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})})}){}dnl
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
__{}define({__GARBAGE},   __LD_REG8(substr($1,1,1),__HEX_L($2),substr($3,0,1),__HEX_H($4),substr($3,1,1),__HEX_L($4),substr($5,0,1),__HEX_H($6),substr($5,1,1),__HEX_L($6),substr($7,0,1),__HEX_H($8),substr($7,1,1),__HEX_L($8))){}dnl
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
__{}__{}    ld   $1{,}format({%-12s},$2); 3:16      _TMP_INFO},
__{}{dnl
__{}__{}define({__CLOCKS_16BIT},20){}dnl
__{}__{}define({__BYTES_16BIT},4)
__{}__{}    ld   $1{,}format({%-12s},$2); 4:20      _TMP_INFO})}){}dnl
dnl
dnl
dnl
define({__LD_REG16},{dnl
dnl # __ld_reg16_16bit $1,$2,$3,$4,$5,$6,$7,$8
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
dnl # __CODE_16BIT
dnl # __BYTES_16BIT
dnl # __CLOCKS_16BIT
dnl # __PRICE_16BIT = __CLOCKS_16BIT+4*__BYTES_16BIT
dnl # __SUM_BYTES  += __BYTES_16BIT
dnl # __SUM_CLOCKS += __CLOCKS_16BIT
dnl # __SUM_PRICES += __PRICE_16BIT
__{}undefine({__COMMA}){}dnl
ifelse(__IS_MEM_REF($2),{1},{dnl
__{}define({__CLOCKS_16BIT},0){}dnl
__{}define({__BYTES_16BIT},0){}dnl
__{}define({__CODE_16BIT},{}){}dnl
__{}ifelse(dnl # memory reference
__{}$1:$2,$3:$4,{define({__CODE_16BIT},{})},
__{}$1:$2,$5:$6,{define({__CODE_16BIT},{})},
__{}$1:$2,$7:$8,{define({__CODE_16BIT},{})},
__{}$2,$4,{define({__CODE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$2,$6,{define({__CODE_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}$2,$8,{define({__CODE_16BIT},__LD_MEM16($1,$2,$7,$8))},
__{}{define({__CODE_16BIT},__LD_MEM16($1,$2,,))})},
$2,{},{dnl
__{}__{}define({__CLOCKS_16BIT},0){}dnl
__{}__{}define({__BYTES_16BIT},0){}dnl
__{}__{}define({__CODE_16BIT},{})},
__IS_NUM($2),{0},{dnl # unknown number
__{}define({__CLOCKS_16BIT},0){}dnl
__{}define({__BYTES_16BIT},0){}dnl
__{}define({__CODE_16BIT},{}){}dnl
__{}ifelse(dnl
__{}$1:$2,$3:$4,{define({__CODE_16BIT},{})},
__{}$1:$2,$5:$6,{define({__CODE_16BIT},{})},
__{}$1:$2,$7:$8,{define({__CODE_16BIT},{})},
__{}$2,$4,{define({__CODE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$2,$6,{define({__CODE_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}$2,$8,{define({__CODE_16BIT},__LD_MEM16($1,$2,$7,$8))},
__{}{dnl
__{}__{}define({__CLOCKS_16BIT},10){}dnl
__{}__{}define({__BYTES_16BIT},3){}dnl
__{}__{}define({__CODE_16BIT},{
__{}__{}    ld   $1{,} format({%-11s},$2); 3:10      }_TMP_INFO)})},{dnl
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
__{}ifelse(__IS_NUM(__SUM_BYTES), 0,{define({__SUM_BYTES},  __BYTES_16BIT)},{define({__SUM_BYTES}, eval(__SUM_BYTES + __BYTES_16BIT))}){}dnl
__{}ifelse(__IS_NUM(__SUM_CLOCKS),0,{define({__SUM_CLOCKS},__CLOCKS_16BIT)},{define({__SUM_CLOCKS},eval(__SUM_CLOCKS+__CLOCKS_16BIT))}){}dnl
__{}ifelse(__IS_NUM(__SUM_PRICES),0,{define({__SUM_PRICES}, __PRICE_16BIT)},{define({__SUM_PRICES},eval(__SUM_PRICES+ __PRICE_16BIT))}){}dnl
}){}dnl
dnl
dnl
dnl
define({__LD_REG16_BEFORE_AFTER},{dnl
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
dnl # __CODE_BEFORE_16BIT
dnl # __CODE_AFTER_16BIT
dnl # __BYTES_16BIT
dnl # __CLOCKS_16BIT
dnl # __PRICE_16BIT = __CLOCKS_16BIT+4*__BYTES_16BIT
dnl # __SUM_BYTES  += __BYTES_16BIT
dnl # __SUM_CLOCKS += __CLOCKS_16BIT
dnl # __SUM_PRICES += __PRICE_16BIT
ifelse(1,0,{
;+++vvv+++
; $1 $2
; $3 $4
; $5 $6
;---^^^---})dnl
__{}undefine({__COMMA}){}dnl
ifelse(__IS_MEM_REF($2),{1},{dnl
__{}define({__CODE_BEFORE_16BIT},{}){}dnl
__{}define({__CODE_AFTER_16BIT},{}){}dnl
__{}ifelse(dnl # memory reference
__{}$1:$2,$3:$4,{define({__CODE_BEFORE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$1:$2,$5:$6,{define({__CODE_AFTER_16BIT},__LD_MEM16($1,$2,$5,$6))},
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
__{}$1:$2,$3:$4,{define({__CODE_BEFORE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$1:$2,$5:$6,{define({__CODE_AFTER_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}$2,$4,{define({__CODE_BEFORE_16BIT},__LD_MEM16($1,$2,$3,$4))},
__{}$2,$6,{define({__CODE_AFTER_16BIT},__LD_MEM16($1,$2,$5,$6))},
__{}{dnl
__{}__{}define({__CLOCKS_16BIT},10){}dnl
__{}__{}define({__BYTES_16BIT},3){}dnl
__{}__{}define({__CODE_BEFORE_16BIT},{
__{}__{}    ld   $1{,} format({%-11s},$2); 3:10      }_TMP_INFO)})},{dnl
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
__{}ifelse(__IS_NUM(__SUM_BYTES), 0,{define({__SUM_BYTES},  __BYTES_16BIT)},{define({__SUM_BYTES}, eval(__SUM_BYTES + __BYTES_16BIT))}){}dnl
__{}ifelse(__IS_NUM(__SUM_CLOCKS),0,{define({__SUM_CLOCKS},__CLOCKS_16BIT)},{define({__SUM_CLOCKS},eval(__SUM_CLOCKS+__CLOCKS_16BIT))}){}dnl
__{}ifelse(__IS_NUM(__SUM_PRICES),0,{define({__SUM_PRICES}, __PRICE_16BIT)},{define({__SUM_PRICES},eval(__SUM_PRICES+ __PRICE_16BIT))}){}dnl
}){}dnl
dnl
dnl
dnl
define({__RESET_BYTES_CLOCKS_PRICES},{dnl
__{}define({__SUM_BYTES},0){}dnl
__{}define({__SUM_CLOCKS},0){}dnl
__{}define({__SUM_PRICES},0){}dnl
}){}dnl
dnl
dnl
dnl
define({__SET_BYTES_CLOCKS_PRICES},{dnl
__{}define({__SUM_BYTES},eval($1)){}dnl
__{}define({__SUM_CLOCKS},eval($2)){}dnl
__{}define({__SUM_PRICES},eval(4*__SUM_BYTES+__SUM_CLOCKS)){}dnl
}){}dnl
dnl
dnl
dnl
dnl
define({__ADD_HL_CONST},{dnl
dnl # Input:
dnl # _TMP_INFO
dnl #  $1 constant value
dnl #  $2 info "BC = ..."
dnl #  $3 info "HL = ..."
dnl
dnl # Output:
dnl # __CODE
dnl # __CLOCKS
dnl # __BYTES
dnl # __PRICE = __CLOCKS+4*__BYTES
dnl
dnl # Pollutes: HL
dnl # Possible pollutes: carry flag, BC
dnl
dnl # zero flag unaffected
dnl # sign flag unaffected
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}define({__CODE},{
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   $2
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   $3}){}dnl
__{}__{}define({__CLOCKS},31){}dnl
__{}__{}define({__BYTES},5){}dnl
__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__IS_NUM($1),0,{dnl
__{}__{}define({__CODE},{
__{}__{}__{}    ld   BC, format({%-11s},$1); 3:10      __INFO   $2
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   $3}){}dnl
__{}__{}define({__CLOCKS},21){}dnl
__{}__{}define({__BYTES},4){}dnl
__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}{dnl
__{}__{}ifelse(__HEX_HL($1),{0x0000},{dnl # 0
__{}__{}__{}define({__CODE},{}){}dnl
__{}__{}__{}define({__CLOCKS},0){}dnl
__{}__{}__{}define({__BYTES},0){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0x0001},{dnl # 1
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    inc  HL             ; 1:6       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},6){}dnl
__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0xFFFF},{dnl # -1
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    dec  HL             ; 1:6       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},6){}dnl
__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0x0100},{dnl # 256
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    inc  H              ; 1:4       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0xFF00},{dnl # -256
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    dec  H              ; 1:4       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0x0200},{dnl # 512
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    inc  H              ; 1:4       __INFO
__{}__{}__{}__{}    inc  H              ; 1:4       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},8){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0xFE00},{dnl # -512
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    dec  H              ; 1:4       __INFO
__{}__{}__{}__{}    dec  H              ; 1:4       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},8){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0x00FF},{dnl # 255
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    inc  H              ; 1:4       __INFO
__{}__{}__{}__{}    dec  HL             ; 1:6       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},10){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0xFF01},{dnl # -255
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    dec  H              ; 1:4       __INFO
__{}__{}__{}__{}    inc  HL             ; 1:6       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},10){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0x0101},{dnl # 257
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    inc  H              ; 1:4       __INFO
__{}__{}__{}__{}    inc  HL             ; 1:6       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},10){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0xFEFF},{dnl # -257
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    dec  H              ; 1:4       __INFO
__{}__{}__{}__{}    dec  HL             ; 1:6       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},10){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0x0002},{dnl # 2
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}__{}__{}    inc  HL             ; 1:6       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},12){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0xFFFE},{dnl # -2
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}__{}__{}    dec  HL             ; 1:6       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},12){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0x0300},{dnl # 768
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    inc  H              ; 1:4       __INFO
__{}__{}__{}__{}    inc  H              ; 1:4       __INFO
__{}__{}__{}__{}    inc  H              ; 1:4       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},12){}dnl
__{}__{}__{}define({__BYTES},3){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}__HEX_HL($1),{0xFD00},{dnl # -768
__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    dec  H              ; 1:4       __INFO
__{}__{}__{}__{}    dec  H              ; 1:4       __INFO
__{}__{}__{}__{}    dec  H              ; 1:4       __INFO   $3}){}dnl
__{}__{}__{}define({__CLOCKS},12){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))},

__{}__{}{dnl
__{}__{}define({__CODE},{
__{}__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO   $2
__{}__{}__{}    add  HL, BC         ; 1:11      __INFO   $3}){}dnl
__{}__{}define({__CLOCKS},21){}dnl
__{}__{}define({__BYTES},4){}dnl
__{}__{}define({__PRICE},eval(__CLOCKS+4*__BYTES))}){}dnl
})}){}dnl
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
define({__DEQ_16_16_INIT_CODE},{dnl
__{}__{}define({_TMP_R1},{D})define({_TMP_N1},eval((($1)>>8) & 0xFF)){}dnl
__{}__{}define({_TMP_R2},{E})define({_TMP_N2},eval( ($1)     & 0xFF)){}dnl
__{}__{}define({_TMP_R3},{H})define({_TMP_N3},eval((($2)>>8) & 0xFF)){}dnl
__{}__{}define({_TMP_R4},{L})define({_TMP_N4},eval( ($2)     & 0xFF)){}dnl
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
dnl # ============================================
dnl # Input parameters:
dnl #   $1 = 32 bit number
dnl #   $2 = +-bytes no jump
dnl #   $3 = +-clocks no jump
dnl #   $4 = +-bytes jump
dnl #   $5 = +-clocks jump
dnl # _TMP_INFO = info
dnl # _TMP_STACK_INFO = stack info
dnl # _TMP_R1 .. _TMP_R4  Rx = D,E,H,L
dnl # _TMP_N1 .. _TMP_N4  Nx = 1..256
dnl # reg with 0(=256) must by last
dnl # reg with 255 must by last
dnl # 
dnl # Out:
dnl # __DEQ_CODE
dnl # __DEQ_CLOCKS_TRUE
dnl # __DEQ_CLOCKS_FAIL
dnl # __DEQ_CLOCKS
dnl # __DEQ_BYTES
dnl # 
dnl # zero flag if const == DEHL
dnl # A = 0 if const == DEHL, because the "cp" instruction can be the last instruction only with a non-zero result.
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
define({__DEQ_16_16_MAKE_BEST_CODE},{dnl
__DEQ_16_16_INIT_CODE($1,$2){}dnl
__{}define({_TMP_BEST_P},10000000){}dnl    price = 16*(clocks + 4*bytes)
__{}define({_TMP_BEST_B},10000000){}dnl    bytes
__{}define({_TMP_BEST_C},10000000){}dnl    clocks
__{}__DEQ_VARIATION_32(shift($@)){}dnl
__{}ifelse(eval(_TMP_N4<255),{1},{dnl
__{}__SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__SWAP2DEF({_TMP_R4},{_TMP_R3}){}dnl
__{}__DEQ_VARIATION_32(shift($@)){}dnl
__{}__SWAP2DEF({_TMP_N4},{_TMP_N3}){}dnl
__{}__SWAP2DEF({_TMP_R4},{_TMP_R3}){}dnl
__{}__DEQ_VARIATION_32(shift($@)){}dnl
__{}__SWAP2DEF({_TMP_N4},{_TMP_N1}){}dnl
__{}__SWAP2DEF({_TMP_R4},{_TMP_R1}){}dnl
__{}__DEQ_VARIATION_32(shift($@))})}){}dnl
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
__{}define({__EQ_CODE},format({%39s},;[eval(__EQ_BYTES):__EQ_CLOCKS_TRUE/_TMP_J1{{{,}}}_TMP_J2]){ _TMP_STACK_INFO{}__EQ_CODE_1{}__EQ_CODE_2}){}dnl
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
dnl #   zero flag if const == HL
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
__{}__{}define({_TMP_BEST_CODE},{                        ;}format({%-10s},[eval(_TMP_BEST_B):_TMP_BEST_C]){ _TMP_STACK_INFO{}__EQ_CODE_1})},
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
__{}__{}define({_TMP_BEST_CODE},format({%37s},;[eval(_TMP_BEST_B):_TMP_J1{{,}}_TMP_J2/__EQ_CLOCKS_FAIL]){ _TMP_STACK_INFO{}__EQ_CODE_1})},
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
__{}__{}define({_TMP_BEST_CODE},format({%37s},;[eval(_TMP_BEST_B):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2]){ _TMP_STACK_INFO{}__EQ_CODE_1})})},
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
__{}__{}__{}                        ;format({%-10s},[eval(_TMP_BEST_B):_TMP_BEST_C]) _TMP_STACK_INFO{}__EQ_CODE_1})},
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
__{}__{}__{}format({%37s},;[eval(_TMP_BEST_B):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2]) _TMP_STACK_INFO{}__EQ_CODE_1})},
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
__{}__{}__{}format({%37s},;[eval(_TMP_BEST_B):__EQ_CLOCKS_TRUE/_TMP_J1{{,}}_TMP_J2]) _TMP_STACK_INFO{}__EQ_CODE_1})})},
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
__{}define({_TMP_BEST_CODE},format({%39s},;[eval(_TMP_BEST_B):__EQ_CLOCKS_TRUE/_TMP_J1{{{,}}}_TMP_J2]){ _TMP_STACK_INFO   L_first variant{}__EQ_CODE_1{}__EQ_CODE_2{}__EQ_CODE_3})},
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
dnl ============================================
dnl # Input parameters:
dnl #   $1 = _TMP_INFO = info
dnl #   $2 = _TMP_STACK_INFO = stack info
dnl #   $3 = HL or DE or BC
dnl #   $4 = 16 bit number
dnl #   $5 = +-bytes no jump
dnl #   $6 = +-clocks no jump
dnl #   $7 = +-bytes jump
dnl #   $8 = +-clocks jump
dnl #
dnl # Out:
dnl #   _TMP_BEST_P       price = 16*(clocks + 4*bytes)
dnl #   _TMP_BEST_B       bytes
dnl #   _TMP_BEST_C       clocks
dnl #   _TMP_BEST_CODE    asm code
dnl #   zero flag if const == HL
dnl #   A = 0 if const == HL, because the "cp" instruction can be the last instruction only with a non-zero result.
dnl
define({__MAKE_BEST_CODE_R16_CP},{dnl
__{}dnl ---------------------------------
__{}define({_TMP_INFO},$1){}dnl
__{}define({_TMP_STACK_INFO},$2){}dnl
__{}ifelse($7,{},{define({_TMP_B0},0)},{define({_TMP_B0},$7)}){}dnl
__{}ifelse($8,{},{define({_TMP_J0},0)},{define({_TMP_J0},$8)}){}dnl
__{}define({__R1},substr($3,1,1)){}dnl E C L
__{}define({__R2},substr($3,0,1)){}dnl D B H
__{}define({__N1},eval(($4) & 0xFF)){}dnl
__{}define({__N2},eval((($4)>>8) & 0xFF)){}dnl
__{}ifelse(__N1,{0},{dnl
__{}__{}__SWAP2DEF({__N1},{__N2}){}dnl
__{}__{}__SWAP2DEF({__R1},{__R2})}){}dnl
__{}__EQ_MAKE_CODE($4,$5,$6,$7,$8){}dnl
__{}define({_TMP_BEST_P},__EQ_PRICE){}dnl
__{}define({_TMP_BEST_B},__EQ_BYTES){}dnl
__{}define({_TMP_BEST_C},__EQ_CLOCKS){}dnl
__{}define({_TMP_BEST_CODE},__EQ_CODE){}dnl
__{}ifelse(eval(__N2>0),{1},{dnl
__{}__SWAP2DEF({__N1},{__N2}){}dnl
__{}__SWAP2DEF({__R1},{__R2}){}dnl
__{}__EQ_MAKE_CODE($4,$5,$6,$7,$8){}dnl
__{}__{}ifelse(ifelse(_TYP_SINGLE,{small},{eval((_TMP_BEST_B>__EQ_BYTES) || ((_TMP_BEST_B==__EQ_BYTES) && (_TMP_BEST_P>__EQ_PRICE)))},{eval(_TMP_BEST_P>__EQ_PRICE)}),{1},{dnl
__{}__{}__{}define({_TMP_BEST_P},__EQ_PRICE){}dnl
__{}__{}__{}define({_TMP_BEST_B},__EQ_BYTES){}dnl
__{}__{}__{}define({_TMP_BEST_C},__EQ_CLOCKS){}dnl
__{}__{}__{}define({_TMP_BEST_CODE},__EQ_CODE)})})}){}dnl
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
__{}__HEX_HL($1):__HEX_H($2),{0x0001:0x00},{define({__SAVE_HL_WITHIN_B},8){}define({__SAVE_HL_WITHIN_C},30)
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    jr   nz{,} $+6        ; 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    sub  __HEX_L($2-($1))           ; 2:7       _TMP_INFO},
__{}__HEX_H($1):__HEX_H($2),{0x00:0x00},{define({__SAVE_HL_WITHIN_B},9){}define({__SAVE_HL_WITHIN_C},33)
__{}__{}    ld    A{,} H          ; 1:4       _TMP_INFO
__{}__{}    or    A             ; 1:4       _TMP_INFO
__{}__{}    jr   nz{,} $+7        ; 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    sub  __HEX_L($1)           ; 2:7       _TMP_INFO
__{}__{}    sub  __HEX_L($2-($1))           ; 2:7       _TMP_INFO},
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
__{}__{}__{}    dec   B             ; 1:4       _TMP_INFO   BA = {TOS}-($1)},
__{}__{}__HEX_H($1),{0xFF},{define({__SAVE_HL_WITHIN_B},12){}define({__SAVE_HL_WITHIN_C},44)
__{}__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}__{}    sub   __HEX_L($1)          ; 2:7       _TMP_INFO
__{}__{}__{}    ld    B{,} H          ; 1:4       _TMP_INFO
__{}__{}__{}    jr    c{,} $+3        ; 2:7/12    _TMP_INFO
__{}__{}__{}    inc   B             ; 1:4       _TMP_INFO   BA = {TOS}-($1)},
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
dnl # Input:
dnl #    __INFO
dnl #    $1 ...hi16
dnl #    $2 ...lo16
dnl #    $3 ...head info
dnl #    $4 ...+bytes
dnl #    $5 ...+clocks
dnl # Output:
dnl #    print code
dnl # Pollutes: 
dnl #    AF,BC
define({__MAKE_CODE_DLT_SET_CARRY},{dnl
ifelse(dnl
eval(__IS_MEM_REF($1)+__IS_MEM_REF($2)),{2},{dnl
__{}__SET_BYTES_CLOCKS_PRICES(12+$4,48+$5){}dnl
__{}define({_TMP_INFO},__INFO{   ..BC = $2}){}dnl
__{}__LD_REG16(BC,$1,BC,$2){}dnl
__{}__LD_REG16(BC,$2)
__{}                        ;format({%-11s},[__SUM_BYTES:__SUM_CLOCKS])__INFO   {$3}{}dnl
__{}__CODE_16BIT
__{}    ld    A{,} L          ; 1:4       __INFO   ..HL < ..BC
__{}    sub   C             ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true
__{}    ld    A{,} H          ; 1:4       __INFO   ..HL < ..BC
__{}    sbc   A{,} B          ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true{}define({_TMP_INFO},__INFO{   BC.. = $1}){}__LD_REG16(BC,$1,BC,$2){}__CODE_16BIT
__{}    ld    A{,} E          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A{,} C          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    ld    A{,} D          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A{,} B          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO
__{}    xor   B             ; 1:4       __INFO
__{}    add   A{,} A          ; 1:4       __INFO   --> carry if true},
eval(__IS_MEM_REF($1)+__IS_MEM_REF($2)),{1},{
__{}ifelse(dnl
__{}__IS_NUM($1),0,{__SET_BYTES_CLOCKS_PRICES(18+$4,74+$5)},
__{}__HEX_HL(0x8000 & ($1)),{0x8000},{__SET_BYTES_CLOCKS_PRICES(18+$4,74+$5)},
__{}{__SET_BYTES_CLOCKS_PRICES(17+$4,70+$5)}){}dnl
__{}                        ;format({%-11s},[__SUM_BYTES:__SUM_CLOCKS])__INFO   {$3}{}dnl
__{}ifelse(__IS_MEM_REF($2),1,{dnl
__{}define({_TMP_INFO},__INFO{    ..BC = $2}){}dnl
__{}__LD_REG16(BC,$2){}dnl
__{}__CODE_16BIT
__{}    ld    A{,} L          ; 1:4       __INFO   ..HL < ..BC
__{}    sub   C             ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true
__{}    ld    A{,} H          ; 1:4       __INFO   ..HL < ..BC
__{}    sbc   A{,} B          ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true},
__{}{
__{}    ld    A{,} L          ; 1:4       __INFO   HL < $2
__{}    sub  format({%-15s},low $2); 2:7       __INFO   HL - $2 < 0 --> carry if true
__{}    ld    A{,} H          ; 1:4       __INFO   HL < $2
__{}    sbc   A{,} format({%-11s},high $2); 2:7       __INFO   HL - $2 < 0 --> carry if true}){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{dnl
__{}define({_TMP_INFO},__INFO{    BC.. = $1}){}dnl
__{}__LD_REG16(BC,$1,BC,$2){}dnl
__{}__CODE_16BIT
__{}    ld    A{,} E          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A{,} C          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    ld    A{,} D          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A{,} B          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO
__{}    xor   B             ; 1:4       __INFO},
__{}{
__{}    ld    A{,} E          ; 1:4       __INFO   DE < $1
__{}    sbc   A{,} format({%-11s},low $1); 2:7       __INFO   DE - $1 < 0 --> carry if true
__{}    ld    A{,} D          ; 1:4       __INFO   DE < $1
__{}    sbc   A{,} format({%-11s},high $1); 2:7       __INFO   DE - $1 < 0 --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO{}dnl
__{}ifelse(__IS_NUM($1),0,{
__{}  if ((($1) & 0x8000) = 0x8000)
__{}    ccf                 ; 1:4       __INFO
__{}  endif},
__{}__HEX_HL(0x8000 & ($1)),0x8000,{
__{}    ccf                 ; 1:4       __INFO})})
__{}    add   A{,} A          ; 1:4       __INFO   --> carry if true},
{
__{}__SET_BYTES_CLOCKS_PRICES(16+$4,59+$5){}dnl
__{}                        ;format({%-11s},[__SUM_BYTES:__SUM_CLOCKS])__INFO   {$3}
__{}    ld    A{,} D          ; 1:4       __INFO
__{}    add   A{,} A          ; 1:4       __INFO
__{}ifelse(__IS_NUM($1),1,{dnl
__{}ifelse(eval((($1) & 0x8000) - 0x8000),0,{dnl
__{}__{}    jr   nc{,} $+14       ; 2:7/12    __INFO   positive d1 < negative constant --> false},
__{}__{}{dnl
__{}__{}    jr    c{,} $+14       ; 2:7/12    __INFO   negative d1 < positive constant --> true})},
__{}{dnl
__{}  if ((($1) & 0x8000) = 0x8000)
__{}    jr   nc{,} $+14       ; 2:7/12    __INFO   positive d1 < negative constant --> false
__{}  else
__{}    jr    c{,} $+14       ; 2:7/12    __INFO   negative d1 < positive constant --> true
__{}  endif}){}dnl
__{}ifelse(__IS_NUM($2),1,{
__{}    ld    A{,} L          ; 1:4       __INFO   HL < __HEX_HL($2)
__{}    sub  format({%-15s},low $2); 2:7       __INFO    L -   __HEX_L($2) < 0 --> carry if true
__{}    ld    A{,} H          ; 1:4       __INFO   HL < __HEX_HL($2)
__{}    sbc   A{,} format({%-11s},high $2); 2:7       __INFO   H  - __HEX_H($2)   < 0 --> carry if true},
__{}{
__{}    ld    A{,} L          ; 1:4       __INFO   HL < $2
__{}    sub  format({%-15s},low $2); 2:7       __INFO   HL - $2 < 0 --> carry if true
__{}    ld    A{,} H          ; 1:4       __INFO   HL < $2
__{}    sbc   A{,} format({%-11s},high $2); 2:7       __INFO   HL - $2 < 0 --> carry if true}){}dnl
__{}ifelse(__IS_NUM($1),1,{
__{}    ld    A{,} E          ; 1:4       __INFO   DE < __HEX_HL($1)
__{}    sbc   A{,} __HEX_L($1)       ; 2:7       __INFO    E -   __HEX_L($1) < 0 --> carry if true
__{}    ld    A{,} D          ; 1:4       __INFO   DE < __HEX_HL($1)
__{}    sbc   A{,} __HEX_H($1)       ; 2:7       __INFO   D  - __HEX_H($1)   < 0 --> carry if true},
__{}{
__{}    ld    A{,} E          ; 1:4       __INFO   DE < $1
__{}    sbc   A{,} format({%-11s},low $1); 2:7       __INFO   DE - $1 < 0 --> carry if true
__{}    ld    A{,} D          ; 1:4       __INFO   DE < $1
__{}    sbc   A{,} format({%-11s},high $1); 2:7       __INFO   DE - $1 < 0 --> carry if true})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #    __INFO
dnl #    $1 ...hi16
dnl #    $2 ...lo16
dnl #    $3 ...head info
dnl #    $4 ...+bytes
dnl #    $5 ...+clocks
dnl # Output:
dnl #    print code
dnl # Pollutes: 
dnl #    AF,BC
define({__MAKE_CODE_DEQ_SET_ZERO},{dnl

.error DODELAT!!!!!!!!!!!!!!!!


ifelse(dnl
eval(__IS_MEM_REF($1)+__IS_MEM_REF($2)),{2},{dnl
__{}define({_TMP_INFO},__INFO{   ..BC = $2}){}dnl
__{}__LD_REG16(BC,$1,BC,$2){}dnl
__{}define({__TMP_B},__BYTES_16BIT){}dnl
__{}define({__TMP_C},__CLOCKS_16BIT){}dnl
__{}__LD_REG16(BC,$2){}dnl
__{}define({__TMP},[eval(__TMP_B+__BYTES_16BIT+12+$4):eval(__TMP_C+__CLOCKS_16BIT+48+$5)])
__{}                        ;format({%-11s},__TMP)__INFO   {$3}{}dnl
__{}__CODE_16BIT

__{}__{}    ld   BC{,} format({%-11s},$1); 4:20      _TMP_INFO
__{}__{}    xor   A             ; 1:4       _TMP_INFO   cp HL{,} BC
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   cp HL{,} BC
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   cp HL{,} BC


__{}    ld    A, L          ; 1:4       __INFO   ..HL < ..BC
__{}    sub   C             ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true
__{}    ld    A, H          ; 1:4       __INFO   ..HL < ..BC
__{}    sbc   A, B          ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true{}define({_TMP_INFO},__INFO{   BC.. = $1}){}__LD_REG16(BC,$1,BC,$2){}__CODE_16BIT
__{}    ld    A, E          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A, C          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    ld    A, D          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A, B          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO
__{}    xor   B             ; 1:4       __INFO
__{}    add   A, A          ; 1:4       __INFO   --> carry if true},
eval(__IS_MEM_REF($1)+__IS_MEM_REF($2)),{1},{
__{}define({__TMP},[ifelse(__IS_NUM($1),0,{eval(18+$4):eval(74+$5)},{ifelse(__HEX_HL(0x8000 & ($1)),{0x8000},{eval(18+$4):eval(74+$5)},{eval(17+$4):eval(70+$5)})})]){}dnl
__{}                        ;format({%-11s},__TMP)__INFO   {$3}{}dnl
__{}ifelse(__IS_MEM_REF($2),1,{dnl
__{}define({_TMP_INFO},__INFO{    ..BC = $2}){}dnl
__{}__LD_REG16(BC,$2){}dnl
__{}__CODE_16BIT
__{}    ld    A, L          ; 1:4       __INFO   ..HL < ..BC
__{}    sub   C             ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true
__{}    ld    A, H          ; 1:4       __INFO   ..HL < ..BC
__{}    sbc   A, B          ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true},
__{}{
__{}    ld    A, L          ; 1:4       __INFO   HL < $2
__{}    sub  format({%-15s},low $2); 2:7       __INFO   HL - $2 < 0 --> carry if true
__{}    ld    A, H          ; 1:4       __INFO   HL < $2
__{}    sbc   A, format({%-11s},high $2); 2:7       __INFO   HL - $2 < 0 --> carry if true}){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{dnl
__{}define({_TMP_INFO},__INFO{    BC.. = $1}){}dnl
__{}__LD_REG16(BC,$1,BC,$2){}dnl
__{}__CODE_16BIT
__{}    ld    A, E          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A, C          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    ld    A, D          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A, B          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO
__{}    xor   B             ; 1:4       __INFO},
__{}{
__{}    ld    A, E          ; 1:4       __INFO   DE < $1
__{}    sbc   A, format({%-11s},low $1); 2:7       __INFO   DE - $1 < 0 --> carry if true
__{}    ld    A, D          ; 1:4       __INFO   DE < $1
__{}    sbc   A, format({%-11s},high $1); 2:7       __INFO   DE - $1 < 0 --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO{}dnl
__{}ifelse(__IS_NUM($1),0,{
__{}  if ((($1) & 0x8000) = 0x8000)
__{}    ccf                 ; 1:4       __INFO
__{}  endif},
__{}__HEX_HL(0x8000 & ($1)),0x8000,{
__{}    ccf                 ; 1:4       __INFO})})
__{}    add   A, A          ; 1:4       __INFO   --> carry if true},
__IS_MEM_REF($1):__IS_MEM_REF($2),{1:0},{
__{}                       ;[19:96]     __INFO   ( d1 -- flag )  flag: d1 == ($1<<16)+__HEX_HL($2)
__{}    ld   BC,format({%-12s},$2); 3:10      __INFO
__{}    xor   A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    jr   nz, $+10       ; 2:7/12    __INFO
__{}    ld   HL,format({%-12s},$1); 3:16      __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}    dec   A             ; 1:4       __INFO   A = 0xFF
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO},
__IS_MEM_REF($1):__IS_MEM_REF($2),{0:1},{
__{}                       ;[20:100]    __INFO   ( d1 -- flag )  flag: d1 == __HEX_DEHL($1<<16)+$2
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld   BC,format({%-12s},$1); 3:10      __INFO
__{}    xor   A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    jr   nz, $+10       ; 2:7/12    __INFO
__{}    ld   HL,format({%-12s},$2); 3:16      __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}    dec   A             ; 1:4       __INFO   A = 0xFF
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO},
eval(__IS_MEM_REF($1) | __IS_MEM_REF($2)),{1},{
__{}                       ;[20:106]    __INFO   ( d1 -- flag )  flag: d1 == ($1<<16)+$2
__{}    ld   BC,format({%-12s},$2); 4:20      __INFO
__{}    xor   A             ; 1:4       __INFO
__{}    sbc  HL, BC         ; 2:15      __INFO
__{}    jr   nz, $+10       ; 2:7/12    __INFO
__{}    ld   HL,format({%-12s},$1); 3:16      __INFO
__{}    sbc  HL, DE         ; 2:15      __INFO
__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}    dec   A             ; 1:4       __INFO   A = 0xFF
__{}    ld    L, A          ; 1:4       __INFO
__{}    ld    H, A          ; 1:4       __INFO   HL = flag
__{}    pop  DE             ; 1:10      __INFO},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
{dnl
__{}ifelse(eval($1):eval($2),0:0,{__ASM_TOKEN_D0EQ},
__{}{dnl
__{}__{}define({_TMP_INFO},__COMPILE_INFO){}define({_TMP_STACK_INFO},{ _TMP_INFO   ( d1 -- flag )  flag: d1 == eval((__HEX_HL($1)<<16)+__HEX_HL($2))}){}__LD_REG16({HL},__HEX_HL($1),{HL},0,{BC},__HEX_HL($2)){}
__{}__{}__DEQ_MAKE_BEST_CODE(eval((__HEX_HL($1)<<16)+__HEX_HL($2)),6,29,0,0){}dnl
__{}__{}define({_TMP_P},eval(59+80+__CLOCKS_16BIT+8*(16+__BYTES_16BIT))){}dnl #     price = 16*(clocks + 4*bytes)
__{}__{}ifelse(eval(8*_TMP_P<_TMP_BEST_P),{1},{
__{}__{}                        ;[eval(16+__BYTES_16BIT):59/eval(80+__CLOCKS_16BIT)] __INFO   ( d1 -- flag )  flag: d1 == __HEX_DEHL((__HEX_HL($1)<<16)+__HEX_HL($2))
__{}__{}    ld   BC, __HEX_HL($2)     ; 3:10      __INFO
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO
__{}__{}    jr   nz, $+format({%-9s},eval(7+__BYTES_16BIT)); 2:7/12    __INFO{}dnl
__{}__{}__CODE_16BIT
__{}__{}    sbc  HL, DE         ; 2:15      __INFO
__{}__{}    jr   nz, $+3        ; 2:7/12    __INFO
__{}__{}    dec   A             ; 1:4       __INFO   A = 0xFF
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO   HL = flag
__{}__{}    pop  DE             ; 1:10      __INFO},{
__{}__{}_TMP_BEST_CODE
__{}__{}    sub  0x01           ; 2:7       __INFO
__{}__{}    sbc   A, A          ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO   HL = flag
__{}__{}    pop  DE             ; 1:10      __INFO})})})}){}dnl
dnl
dnl
dnl
define({PRINT_NIBBLE},{ifelse(eval(TEMP_BIN),{0},{define({TEMP_BIN_OUT},{_0000}TEMP_BIN_OUT)},{dnl
__{}define({TEMP_BIN_OUT},eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
__{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
__{}define({TEMP_BIN_OUT},eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
__{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
__{}define({TEMP_BIN_OUT},eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
__{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
__{}define({TEMP_BIN_OUT},{_}eval(TEMP_BIN & 1)TEMP_BIN_OUT){}dnl
__{}define({TEMP_BIN},eval(TEMP_BIN/2)){}dnl
__{}ifelse(eval(TEMP_BIN),{0},,{PRINT_NIBBLE}){}dnl
})}){}dnl
dnl
dnl
dnl
define({PRINT_BINARY},{dnl
__{}define({TEMP_BIN},eval(($1) & 0xffff)){}dnl
__{}define({TEMP_BIN_OUT},{}){}dnl
__{}PRINT_NIBBLE{}dnl
__{}b{}TEMP_BIN_OUT{}dnl
}){}dnl
dnl
dnl
dnl
define({SUM_1BITS},{define({TEMP},eval((($1) & 0x5555) + (($1) & 0xAAAA)/2)){}dnl
__{}define({TEMP},eval((TEMP & 0x3333) + (TEMP & 0xCCCC)/4)){}dnl
__{}define({TEMP},eval((TEMP & 0x0F0F) + (TEMP & 0xF0F0)/16)){}dnl
__{}eval((TEMP & 0x00FF) + (TEMP & 0xFF00)/256)}){}dnl
dnl
dnl
dnl
define({SUM_0BITS},{define({INV_BITS},eval(($1) | (($1) >> 1)))dnl
__{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 2)))dnl
__{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 4)))dnl
__{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 8)))dnl
__{}define({INV_BITS},eval(INV_BITS | (INV_BITS >> 16)))dnl
__{}define({INV_BITS},eval(INV_BITS-($1)))dnl
__{}SUM_1BITS(eval(INV_BITS))}){}dnl
dnl
dnl
dnl
define({_ADD_OUTPUT},{dnl
__{}ifdef({_OUTPUT},{define({_OUTPUT},_OUTPUT{}$1)},{define({_OUTPUT},$1)}){}dnl
}){}dnl
dnl
dnl
dnl
define({_PUSH_OUTPUT},{dnl
__{}ifdef({_OUTPUT},{define({_OUTPUT},$1{}_OUTPUT)},{define({_OUTPUT},$1)}){}dnl
}){}dnl
dnl
dnl
dnl
define({HI_BIT_LOOP},{ifelse(eval(($1)>0),{1},{dnl
__{}define({HI_BIT_TEMP},eval(HI_BIT_TEMP|($1)))dnl
__{}HI_BIT_LOOP(eval(($1)/2))dnl
})}){}dnl
dnl
dnl
dnl
define({HI_BIT},{dnl
__{}define({HI_BIT_TEMP},{0}){}dnl
__{}HI_BIT_LOOP(eval($1))dnl
__{}eval((HI_BIT_TEMP+1)/2)dnl
}){}dnl
dnl
dnl
dnl
define({_ADD_COST},{dnl
__{}ifdef({_COST},{define({_COST},eval(_COST+($1)))},{define({_COST},eval($1))}){}dnl
dnl # (eval(_COST&255):eval(_COST/256))dnl
}){}dnl
dnl
dnl
define({PUSH_MUL_INFO_MINUS},{dnl
__{}define({XMUL_INFO_TEMP},{[eval($1 & 0xff):eval($1/256)]}){}dnl
                        ;format({%-9s},XMUL_INFO_TEMP)  $2 *   $3 = HL * (PRINT_BINARY($4) - PRINT_BINARY($5)){}dnl
}){}dnl
dnl
dnl
define({PUSH_MUL_INFO_PLUS},{dnl
__{}define({XMUL_INFO_TEMP},{[eval($1 & 0xff):eval($1/256)]}){}dnl
                        ;format({%-9s},XMUL_INFO_TEMP)  $2 *   $3 = HL * (PRINT_BINARY($2)){}dnl
}){}dnl
dnl
dnl
dnl
define({PUSH_MUL_CHECK_FIRST_IS_BETTER},{dnl
__{}eval((($1 & 0xff) < ($2 & 0xff)) || ((($1 & 0xff) == ($2 & 0xff)) && ($1 < $2))){}dnl
__{}}){}dnl
dnl
dnl
