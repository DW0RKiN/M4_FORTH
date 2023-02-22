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
define({__IS_NAME},{dnl
dnl #           --> 0
dnl # (abc)     --> 0
dnl # abc + 2   --> 1  fail!
dnl # abc + sd  --> 1  fail!
dnl # ()        --> 0
dnl # 0xFF & () --> 0
dnl # abc       --> 1
dnl # Abc       --> 1
dnl # _abc      --> 1
__{}ifelse(eval($#>1),1,0,
__{}regexp({$1},{^[a-zA-Z_][a-zA-Z_0-9]*}),0,{ifelse(regexp({$1},{[a-zA-Z_0-9].*\ .*[a-zA-Z_0-9].*}),0,0,1)},
__{}0){}dnl
}){}dnl
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
dnl # 3.14159   --> 0 no integer!
dnl # 1.0E1     --> 0 fail
dnl # 1E1       --> 0 fail
dnl # 10.0E0    --> 0 fail
dnl # 10E0      --> 0 fail
dnl # [0        --> 0 but with error message
dnl # (5+1) & (3-1)  --> 0
dnl # +(5+1) & (3-1) --> 1
dnl # 10+0x0A   --> 1
dnl # 2*(0x0A)  --> 1
dnl # 10+(0x0A) --> 1
dnl # 0xa       --> 1
dnl # 5         --> 1
dnl # 25*3      --> 1
__{}ifelse(dnl
__{}eval($#!=1),{1},{0},
__{}{$1},{},{0},
__{}{$1},(),{0},
__{}eval( regexp({$1},{[0-9]}) == -1 ),{1},{0},dnl # ( -- )
__{}eval( regexp({$1},{()}) != -1 ),{1},{0},dnl #
__{}eval( regexp({$1},{[?'",yzYZ_g-wG-W.]}) != -1 ),{1},{0},dnl # Any letter (except a,b,c,d,e,f,x) or underscore (_) or dot (.)
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
define({__add},{ifdef({$1},
__{}{define({$1},eval($1+$2))},
__{}{define({$1},$2)}){}dnl
}){}dnl
dnl
dnl
dnl
define({__RESET_ADD_LD_REG16},{dnl
__{}define({__SUM_CLOCKS_16BIT},0){}dnl
__{}define({__SUM_BYTES_16BIT}, 0){}dnl
__{}define({__SUM_PRICE_16BIT}, 0){}dnl
}){}dnl
dnl
dnl
dnl
define({__ADD_LD_REG16},{dnl
__{}__LD_REG16($1,$2,$3,$4,$5,$6,$7,$8){}dnl
__{}__add({__SUM_CLOCKS_16BIT},__CLOCKS_16BIT){}dnl
__{}__add({__SUM_BYTES_16BIT}, __BYTES_16BIT){}dnl
__{}__add({__SUM_PRICE_16BIT}, __PRICE_16BIT){}dnl
}){}dnl
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
__{}$#{:$2},2:__dtto,,
__{}$#,2,{$2},
__{}{$2},,{$0({$1},shift(shift($@)))},
__{}{$2},__dtto,{$0({$1},shift(shift($@)))},
__{}{$2{}__CONCATENATE_WITH_LOOP({$1},shift(shift($@)))}){}dnl
}){}dnl
dnl
define({__CONCATENATE_WITH_LOOP},{dnl
__{}ifelse(dnl
__{}$#{:$2},2:,{},
__{}$#{:$2},2:__dtto,{},
__{}$#,2,{{$1}{$2}},
__{}{$2},,{$0({$1},shift(shift($@)))},
__{}{$2},__dtto,{$0({$1},shift(shift($@)))},
__{}{{$1}{$2}{}$0({$1},shift(shift($@)))}){}dnl
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
dnl
dnl # __PARAM_X()            --> ""
dnl # __PARAM_X(0)           --> ""
dnl # __PARAM_X(-1,p1,p2,p3) --> ""
dnl # __PARAM_X( x,p1,p2,p3) --> ""
dnl # __PARAM_X( 0,p1,p2,p3) --> ""
dnl # __PARAM_X( 1,p1,p2,p3) --> "p1"
dnl # __PARAM_X( 2,p1,p2,p3) --> "p2"
dnl # __PARAM_X( 3,p1,p2,p3) --> "p3"
dnl # __PARAM_X( 4,p1,p2,p3) --> ""
define({__PARAM_X},{dnl
__{}ifelse(dnl
__{}__IS_NUM($1),0,{},
__{}{ifelse(dnl
__{}__{}eval($1),{1},{$2},
__{}__{}eval($1>1),{1},{$0(eval($1-1),shift(shift($@)))}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # __REVERSE_X_PAR()            --> ""
dnl # __REVERSE_X_PAR(0)           --> ""
dnl # __REVERSE_X_PAR(-1,p3,p2,p1) --> ""
dnl # __REVERSE_X_PAR( x,p3,p2,p1) --> ""
dnl # __REVERSE_X_PAR( 0,p3,p2,p1) --> ""
dnl # __REVERSE_X_PAR( 1,p3,p2,p1) --> "p1"
dnl # __REVERSE_X_PAR( 2,p3,p2,p1) --> "p2"
dnl # __REVERSE_X_PAR( 3,p3,p2,p1) --> "p3"
dnl # __REVERSE_X_PAR( 4,p3,p2,p1) --> ""
define({__REVERSE_X_PAR},{dnl
__{}ifelse(dnl
__{}__IS_NUM($1),0,{},
__{}{ifelse(eval($#<$1+1),1,{},
__{}__{}$#,eval($1+1),{$2},
__{}__{}eval($1>0),{1},{$0($1,shift(shift($@)))}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
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
define({__7},{$7}){}dnl
define({__8},{$8}){}dnl
define({__9},{$9}){}dnl
define({__SPOJ},{$1$2}){}dnl
dnl
dnl
dnl
dnl # __DROP_2_PAR(1,2,3,4,5) --> 1,2,3
define({__DROP_1_PAR},      {ifelse(eval($#>2), 1,{$1,$0(shift($@))},{ifelse($#, 2,{$1})})}){}dnl
define({__DROP_2_PAR},      {ifelse(eval($#>3), 1,{$1,$0(shift($@))},{ifelse($#, 3,{$1})})}){}dnl
define({__DROP_3_PAR},      {ifelse(eval($#>4), 1,{$1,$0(shift($@))},{ifelse($#, 4,{$1})})}){}dnl
define({__DROP_4_PAR},      {ifelse(eval($#>5), 1,{$1,$0(shift($@))},{ifelse($#, 5,{$1})})}){}dnl
define({__DROP_5_PAR},      {ifelse(eval($#>6), 1,{$1,$0(shift($@))},{ifelse($#, 6,{$1})})}){}dnl
define({__DROP_6_PAR},      {ifelse(eval($#>7), 1,{$1,$0(shift($@))},{ifelse($#, 7,{$1})})}){}dnl
define({__DROP_7_PAR},      {ifelse(eval($#>8), 1,{$1,$0(shift($@))},{ifelse($#, 8,{$1})})}){}dnl
define({__DROP_8_PAR},      {ifelse(eval($#>9), 1,{$1,$0(shift($@))},{ifelse($#, 9,{$1})})}){}dnl
define({__DROP_9_PAR},      {ifelse(eval($#>10),1,{$1,$0(shift($@))},{ifelse($#,10,{$1})})}){}dnl
dnl
dnl # nepouzito, dodelat, zatim shodne s predchozim
define({__DROP_1_PAR_COMMA},{ifelse(eval($#>2),1,{$1,$0(shift($@))},{ifelse($#,2,{$1})})}){}dnl
define({__DROP_2_PAR_COMMA},{ifelse(eval($#>3),1,{$1,$0(shift($@))},{ifelse($#,3,{$1})})}){}dnl
define({__DROP_3_PAR_COMMA},{ifelse(eval($#>4),1,{$1,$0(shift($@))},{ifelse($#,4,{$1})})}){}dnl
define({__DROP_4_PAR_COMMA},{ifelse(eval($#>5),1,{$1,$0(shift($@))},{ifelse($#,5,{$1})})}){}dnl
dnl
dnl # __LAST_2_PAR(1,2,3) --> 2,3
dnl # define({__LAST_1_PAR},{ifelse($#,0,{},$#,1,{$1},                                                                                                                                                                                            {$0(shift($@))})}){}dnl
dnl # define({__LAST_2_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},                                                                                                                                                                               {$0(shift($@))})}){}dnl
dnl # define({__LAST_3_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},$#,3,{$1,$2,$3},                                                                                                                                                               {$0(shift($@))})}){}dnl
dnl # define({__LAST_4_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},$#,3,{$1,$2,$3},$#,4,{$1,$2,$3,$4},                                                                                                                                            {$0(shift($@))})}){}dnl
dnl # define({__LAST_5_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},$#,3,{$1,$2,$3},$#,4,{$1,$2,$3,$4},$#,5,{$1,$2,$3,$4,$5},                                                                                                                      {$0(shift($@))})}){}dnl
dnl # define({__LAST_6_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},$#,3,{$1,$2,$3},$#,4,{$1,$2,$3,$4},$#,5,{$1,$2,$3,$4,$5},$#,6,{$1,$2,$3,$4,$5,$6},                                                                                             {$0(shift($@))})}){}dnl
dnl # define({__LAST_7_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},$#,3,{$1,$2,$3},$#,4,{$1,$2,$3,$4},$#,5,{$1,$2,$3,$4,$5},$#,6,{$1,$2,$3,$4,$5,$6},$#,7,{$1,$2,$3,$4,$5,$6,$7},                                                                 {$0(shift($@))})}){}dnl
dnl # define({__LAST_8_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},$#,3,{$1,$2,$3},$#,4,{$1,$2,$3,$4},$#,5,{$1,$2,$3,$4,$5},$#,6,{$1,$2,$3,$4,$5,$6},$#,7,{$1,$2,$3,$4,$5,$6,$7},$#,8,{$1,$2,$3,$4,$5,$6,$7,$8},                                  {$0(shift($@))})}){}dnl
dnl # define({__LAST_9_PAR},{ifelse($#,0,{},$#,1,{$1},$#,2,{$1,$2},$#,3,{$1,$2,$3},$#,4,{$1,$2,$3,$4},$#,5,{$1,$2,$3,$4,$5},$#,6,{$1,$2,$3,$4,$5,$6},$#,7,{$1,$2,$3,$4,$5,$6,$7},$#,8,{$1,$2,$3,$4,$5,$6,$7,$8},$#,9,{$1,$2,$3,$4,$5,$6,$7,$8,$9},{$0(shift($@))})}){}dnl
dnl
dnl # __LAST_2_PAR(1,2,3) --> 2,3
define({__LAST_1_PAR},{ifelse(eval($#<2), 1,{$@},{$0(shift($@))})}){}dnl
define({__LAST_2_PAR},{ifelse(eval($#<3), 1,{$@},{$0(shift($@))})}){}dnl
define({__LAST_3_PAR},{ifelse(eval($#<4), 1,{$@},{$0(shift($@))})}){}dnl
define({__LAST_4_PAR},{ifelse(eval($#<5), 1,{$@},{$0(shift($@))})}){}dnl
define({__LAST_5_PAR},{ifelse(eval($#<6), 1,{$@},{$0(shift($@))})}){}dnl
define({__LAST_6_PAR},{ifelse(eval($#<7), 1,{$@},{$0(shift($@))})}){}dnl
define({__LAST_7_PAR},{ifelse(eval($#<8), 1,{$@},{$0(shift($@))})}){}dnl
define({__LAST_8_PAR},{ifelse(eval($#<9), 1,{$@},{$0(shift($@))})}){}dnl
define({__LAST_9_PAR},{ifelse(eval($#<10),1,{$@},{$0(shift($@))})}){}dnl
dnl
dnl # __COMMA_LAST_2_PAR(1,2,3) --> ,2,3
dnl # __COMMA_LAST_2_PAR(2,3)   --> ,2,3
dnl # __COMMA_LAST_2_PAR(3)     --> ,3
dnl # __COMMA_LAST_2_PAR()      -->
define({__COMMA_LAST_1_PAR},{ifelse($#,0,{},$#:$1,{1:},{},eval($#<2), 1,{,$@},{$0(shift($@))})}){}dnl
define({__COMMA_LAST_2_PAR},{ifelse($#,0,{},$#:$1,{1:},{},eval($#<3), 1,{,$@},{$0(shift($@))})}){}dnl
define({__COMMA_LAST_3_PAR},{ifelse($#,0,{},$#:$1,{1:},{},eval($#<4), 1,{,$@},{$0(shift($@))})}){}dnl
define({__COMMA_LAST_4_PAR},{ifelse($#,0,{},$#:$1,{1:},{},eval($#<5), 1,{,$@},{$0(shift($@))})}){}dnl
define({__COMMA_LAST_5_PAR},{ifelse($#,0,{},$#:$1,{1:},{},eval($#<6), 1,{,$@},{$0(shift($@))})}){}dnl
define({__COMMA_LAST_6_PAR},{ifelse($#,0,{},$#:$1,{1:},{},eval($#<7), 1,{,$@},{$0(shift($@))})}){}dnl
define({__COMMA_LAST_7_PAR},{ifelse($#,0,{},$#:$1,{1:},{},eval($#<8), 1,{,$@},{$0(shift($@))})}){}dnl
define({__COMMA_LAST_8_PAR},{ifelse($#,0,{},$#:$1,{1:},{},eval($#<9), 1,{,$@},{$0(shift($@))})}){}dnl
define({__COMMA_LAST_9_PAR},{ifelse($#,0,{},$#:$1,{1:},{},eval($#<10),1,{,$@},{$0(shift($@))})}){}dnl
dnl
dnl # __REVERSE_2_PAR(1,2,3) --> 2
define({__REVERSE_1_PAR},    {ifelse($#,0,{},$#,1,{$1},$#,2,{$2},$#,3,{$3},$#,4,{$4},$#,5,{$5},$#,6,{$6},{$0(shift(shift(shift(shift(shift(shift($@)))))))})}){}dnl
define({__REVERSE_2_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,{$1},$#,3,{$2},$#,4,{$3},$#,5,{$4},$#,6,{$5},{$0(shift(shift(shift(shift(shift($@))))))})}){}dnl
define({__REVERSE_3_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,  {},$#,3,{$1},$#,4,{$2},$#,5,{$3},$#,6,{$4},{$0(shift(shift(shift(shift($@)))))})}){}dnl
define({__REVERSE_4_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,  {},$#,3,  {},$#,4,{$1},$#,5,{$2},$#,6,{$3},{$0(shift(shift(shift($@))))})}){}dnl
define({__REVERSE_5_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,  {},$#,3,  {},$#,4,  {},$#,5,{$1},$#,6,{$2},{$0(shift(shift($@)))})}){}dnl
define({__REVERSE_6_PAR},    {ifelse($#,0,{},$#,1,  {},$#,2,  {},$#,3,  {},$#,4,  {},$#,5,  {},$#,6,{$1},{$0(shift($@))})}){}dnl
define({__REVERSE_7_PAR},    {ifelse(eval($#<7),1,{},$#,7,{$1},{$0(shift($@))})}){}dnl
define({__REVERSE_8_PAR},    {ifelse(eval($#<8),1,{},$#,8,{$1},{$0(shift($@))})}){}dnl
define({__REVERSE_9_PAR},    {ifelse(eval($#<9),1,{},$#,9,{$1},{$0(shift($@))})}){}dnl
dnl
dnl
dnl
define({__SWAP2DEF},{dnl
__{}define({__SWAP2DEF_TMP},$1)define({$1},$2)define({$2},__SWAP2DEF_TMP)}){}dnl
dnl
dnl
dnl
dnl __{}__{}  if ((($2+$3) & __HEX_L($4-1)) = __HEX_L($4-1))
dnl __{}__{}    inc  $1             ; 1:6       __INFO
dnl __{}__{}  else
dnl __{}__{}    inc   substr($1,1)             ; 1:4       __INFO
dnl __{}__{}  endif},
dnl
dnl # Input:
dnl #
dnl #  $1 = name register pair
dnl #  $2 = start number
dnl #  $3 = additional
dnl #  $4 = increment
dnl #  $5 = times
dnl #  $6 = times to end
dnl
dnl # number = ($2+$3) ...+$4... <$2+$3+$4*$5> 
dnl #
dnl # Output:
dnl #   if ( ($2+$3) & ($4-1) == ($4-1)
dnl #     inc HL
dnl #   else
dnl #     inc L
define({__INC_REG16_REC},{dnl
ifelse(1,0,{errprint({
__inc_Reg16_rec($@): }eval($5-$6+1)x: ifelse(__IS_NUM($2),1,{__HEX_L($2+$3)},__HEX_L$3){
})}){}dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($2),1,{dnl               # pravdepodobnost je zavisla zda prirustek je nasobkem 2, ale protoze v kodu musi byt defenzivne "inc hl" tak je clock=6
__{}__{}define({__BYTES},1){}dnl
__{}__{}define({__CLOCKS},6){}dnl
__{}__{}__add({__SUM_BYTES},__BYTES){}dnl
__{}__{}__add({__SUM_CLOCKS},__CLOCKS)
__{}__{}    inc  $1             ; 1:6       __INFO   from ptr},
__{}$6:__IS_NUM($2),{0:1},{dnl
__{}__{}define({__BYTES},1){}dnl
__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__add({__SUM_BYTES},__BYTES){}dnl
__{}__{}__add({__SUM_CLOCKS},__CLOCKS)
__{}__{}    inc   substr($1,1)             ; 1:4       __INFO},
__{}$6,0,{dnl
__{}__{}define({__BYTES},1){}dnl
__{}__{}__def({__CLOCKS},4){}dnl
__{}__{}__add({__SUM_BYTES},__BYTES){}dnl
__{}__{}__add({__SUM_CLOCKS},__CLOCKS){}dnl
__{}__{}substr((),1,1)
__{}__{}    inc   substr($1,1)             ; 1:4       __INFO
__{}__{}  else
__{}__{}    inc  $1             ; 1:6       __INFO
__{}__{}  endif},
__{}__HEX_L($2+$3),0xFF,{dnl
__{}__{}define({__BYTES},1){}dnl
__{}__{}define({__CLOCKS},6){}dnl
__{}__{}__add({__SUM_BYTES},__BYTES){}dnl
__{}__{}__add({__SUM_CLOCKS},__CLOCKS)
__{}__{}    inc  $1             ; 1:6       __INFO   ($@) __HEX_HL($2+$3)=$2+eval($3-$4*($5-$6))+$4*eval($5-$6)},
__{}__IS_NUM($2),1,{dnl
__{}__{}$0($1,$2,eval($3+$4),$4,$5,eval($6-1))},
__{}{dnl
__{}__{}ifelse($3,$4,{define({__CLOCKS},6)}){}dnl
__{}__{}ifelse(eval((256 % $4)==0 && ($3>255)),1,,{&&255&($2+eval($3+1))})dnl
__{}__{}$0($1,$2,eval($3+$4),$4,$5,eval($6-1)){}dnl
__{}}){}dnl
})dnl
dnl
dnl
dnl
dnl # Input:
dnl #
dnl #  $1 = name register pair
dnl #  $2 = start number
dnl #  $3 = additional
dnl #  $4 = increment
dnl #  $5 = times
dnl #  $6 = times to end
define({__INC_REG16},{dnl
ifelse(1,0,{errprint({
__inc_reg16($@) 
})}){}dnl
__{}define({__BYTES},1){}dnl
__{}undefine({__CLOCKS}){}dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($2),1,{dnl # pravdepodobnost je zavisla zda prirustek je nasobkem 2, ale protoze v kodu musi byt defenzivne "inc hl" tak je clock=6
__{}__{}define({__BYTES},1){}dnl
__{}__{}define({__CLOCKS},6){}dnl
__{}__{}__add({__SUM_BYTES},__BYTES){}dnl
__{}__{}__add({__SUM_CLOCKS},__CLOCKS)
__{}__{}    inc  $1             ; 1:6       __INFO   from ptr},

__{}__IS_NUM($2):__HEX_L(1 & ($2+$3)):__HEX_L(1 & ($4)),1:0x00:0x00,{dnl # pouze suda cisla = sudy pocatek a sudy prirustek
__{}__{}define({__BYTES},1){}dnl
__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__add({__SUM_BYTES},__BYTES){}dnl
__{}__{}__add({__SUM_CLOCKS},__CLOCKS)
__{}__{}    inc   substr($1,1)             ; 1:4       __INFO   only even numbers},

__{}eval((256 % $4)==0 && ($4*$5>256)),1,{dnl # prirustek je mocnina 2 a rozsah vic jak 256 bajtu, takze bud vzdy mineme a nebo vzdy trefime
__{}__{}ifelse(__IS_NUM($2),1,{dnl
__{}__{}__{}ifelse(__HEX_L(+($4-1) & ($2+$3+1)),0x00,{dnl
__{}__{}__{}__{}define({__CLOCKS},6)
__{}__{}__{}__{}    inc  $1             ; 1:6       __INFO   0x??FF=$2+$3+$4*eval(__HEX_L((0xFF-$2-$3)/$4))},
__{}__{}__{}{dnl
__{}__{}__{}__{}define({__CLOCKS},4)
__{}__{}__{}__{}    inc   substr($1,1)             ; 1:4       __INFO   never 0x??FF (PRINT_BINARY(0xFF&($2+$3))+n*PRINT_BINARY($4))})},
__{}__{}{dnl
__{}__{}__{}ifelse(__HEX_L(+($4-1) & (0+$3+1)),0x00,{dnl
__{}__{}__{}__{}define({__CLOCKS},6)},
__{}__{}__{}{dnl
__{}__{}__{}__{}define({__CLOCKS},4)}){}dnl
__{}__{}__{}  if __HEX_L($4-1) & ($2+eval($3+1))
__{}__{}__{}    inc   substr($1,1)             ; 1:4       __INFO
__{}__{}__{}  else
__{}__{}__{}    inc  $1             ; 1:6       __INFO
__{}__{}__{}  endif}){}dnl
__{}__{}define({__BYTES},1){}dnl
__{}__{}__add({__SUM_BYTES},__BYTES){}dnl
__{}__{}__add({__SUM_CLOCKS},__CLOCKS)},

__{}__IS_NUM($2),1,{$0_REC($1,$2,$3,$4,$5,$5)},

__{}eval(($4<$5) && ($4 & 1)),1,{dnl # 
__{}__{}define({__BYTES},1){}dnl
__{}__{}define({__CLOCKS},6){}dnl
__{}__{}__add({__SUM_BYTES},__BYTES){}dnl
__{}__{}__add({__SUM_CLOCKS},__CLOCKS)
__{}__{}    inc  $1             ; 1:6       __INFO   $4 is odd increment && increment<times},
__{}{
__{}__{}  if substr((),0,1)1dnl # begin pasmo macro
__{}__{}$0_REC($1,$2,$3,$4,$5,$5){}dnl
__{}}){}dnl
}){}dnl
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
__{}define({__BYTES},0){}dnl
__{}undefine({__CODE}){}dnl
__{}__LD4($2,ifelse(__IS_NUM($3),1,__HEX_L($3),$3), $4,ifelse(__IS_NUM( $5),1,__HEX_L( $5), $5)){}dnl
__{}__LD4($2,ifelse(__IS_NUM($3),1,__HEX_L($3),$3), $6,ifelse(__IS_NUM( $7),1,__HEX_L( $7), $7)){}dnl
__{}__LD4($2,ifelse(__IS_NUM($3),1,__HEX_L($3),$3), $8,ifelse(__IS_NUM( $9),1,__HEX_L( $9), $9)){}dnl
__{}__LD4($2,ifelse(__IS_NUM($3),1,__HEX_L($3),$3),$10,ifelse(__IS_NUM($11),1,__HEX_L($11),$11)){}dnl
__{}__LD4($2,ifelse(__IS_NUM($3),1,__HEX_L($3),$3),$12,ifelse(__IS_NUM($13),1,__HEX_L($13),$13)){}dnl
__{}define({_TMP_INFO},$1){}dnl
__{}define({__CODE},__CODE){}dnl
__{}__add({__SUM_CLOCKS_8BIT},__CLOCKS){}dnl
__{}__add({__SUM_BYTES_8BIT},__BYTES){}dnl
__{}__CODE{}dnl
}){}dnl
dnl
dnl
dnl
define({__LD4},{dnl
dnl ; __ld4($@) ; format({%-15s},__BYTES:__CLOCKS) ptr($2) = __IS_MEM_REF($2); num($2) = __IS_NUM($2){}dnl
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
__{}__{}__IS_NUM($2):eval(__CLOCKS>7),{1:1},{dnl
__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})},
__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7),{0:1},{dnl
__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    $1{{,}} format({%-11s},$2); 2:7       {_TMP_INFO}})})},
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
__{}__{}__IS_NUM($2):eval(__CLOCKS>7),{1:1},{dnl
__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})},
__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7),{0:1},{dnl
__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}define({__CODE},{
__{}__{}__{}    ld    $1{{,}} format({%-11s},$2); 2:7       {_TMP_INFO}})})},
__{}$1,$3,{dnl # Identical register
__{}__{}ifelse($4,{},{dnl # empty value because 0xFF==__HEX_L({}-1) or 0x01==__HEX_L({}+1)
__{}__{}__{}ifelse($1:__HEX_L($2):eval(__CLOCKS>4),{A:0x00:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    xor   A         ; 1:4       {_TMP_INFO}})},
__{}__{}__{}$1:__IS_MEM_REF($2):eval(__CLOCKS>13),{A:1:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},13){}dnl
__{}__{}__{}__{}define({__BYTES},3){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    A{{,}}format({%-12s},$2); 3:13      {_TMP_INFO}})},
__{}__{}__{}__IS_NUM($2):eval(__CLOCKS>7 && len($1)>0),{1:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})},
__{}__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7 && len($1)>0 && len($2)>0),{0:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} format({%-11s},$2); 2:7       {_TMP_INFO}})})},
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
__{}__{}$1:__IS_NUM($2):__HEX_L($2),A:1:__HEX_L($4+$4),{dnl
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    add   A{{,}} A          ; 1:4       {_TMP_INFO}})})},
__{}__{}$1:__IS_NUM($2):__HEX_L($2),A:1:__HEX_H(0+(($4+0)*514)),{dnl
__{}__{}__{}ifelse(eval(__CLOCKS>4),{1},{dnl
__{}__{}__{}__{}define({__CLOCKS},4){}dnl
__{}__{}__{}__{}define({__BYTES},1){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    rlca                ; 1:4       {_TMP_INFO}})})},
__{}__{}$1:__IS_NUM($2):__HEX_L($2),A:1:__HEX_L(0+(($4+0)*257)>>1),{dnl
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
__{}__{}__{}__IS_NUM($2):eval(__CLOCKS>7),{1:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})},
__{}__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7),{0:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} format({%-12s},$2); 2:7       {_TMP_INFO}})})})},
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
__{}__{}__{}$1:__IS_NUM($2):eval(__CLOCKS>7),{A:1:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} __HEX_L($2)       ; 2:7       {_TMP_INFO}})},
__{}__{}__{}__IS_MEM_REF($2):eval(__CLOCKS>7),{0:1},{dnl
__{}__{}__{}__{}define({__CLOCKS},7){}dnl
__{}__{}__{}__{}define({__BYTES},2){}dnl
__{}__{}__{}__{}define({__CODE},{
__{}__{}__{}__{}    ld    $1{{,}} format({%-11s},$2); 2:7       {_TMP_INFO}})})}){}dnl
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
ifelse(1,0,{errprint({
__ld_reg16($@)
})}){}dnl
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
ifelse(__IS_MEM_REF($1),1,{dnl
__{}ifelse($1,(HL),{dnl
__{}__{}ifelse(dnl
__{}__{}__IS_MEM_REF($2):HL=$2,1:$3=($4),{dnl # ld (HL),(0x8000) && HL=$0x8000 --> nothing
__{}__{}__{}define({__CLOCKS_16BIT},0){}dnl
__{}__{}__{}define({__BYTES_16BIT},0){}dnl
__{}__{}__{}define({__CODE_16BIT},{})},
__{}__{}__IS_MEM_REF($2):HL=$2,1:$5=($6),{dnl # ld (HL),(0x8000) && HL=$0x8000 --> nothing
__{}__{}__{}define({__CLOCKS_16BIT},0){}dnl
__{}__{}__{}define({__BYTES_16BIT},0){}dnl
__{}__{}__{}define({__CODE_16BIT},{})},
__{}__{}__IS_MEM_REF($2):HL=$2,1:$7=($8),{dnl # ld (HL),(0x8000) && HL=$0x8000 --> nothing
__{}__{}__{}define({__CLOCKS_16BIT},0){}dnl
__{}__{}__{}define({__BYTES_16BIT},0){}dnl
__{}__{}__{}define({__CODE_16BIT},{})},
__{}__{}$2,$4,{dnl # ld (HL),(0x8000) && DE=($0x8000) --> ld (HL),E
__{}__{}__{}define({__CLOCKS_16BIT},7){}dnl
__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,}substr($3,1,1)          ; 1:7       }_TMP_INFO)},
__{}__{}$2,$6,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},7){}dnl
__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,}substr($5,1,1)          ; 1:7       }_TMP_INFO)},
__{}__{}$2,$8,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},7){}dnl
__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,}substr($7,1,1)          ; 1:7       }_TMP_INFO)},
__{}__{}__IS_MEM_REF($2),1,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},20){}dnl
__{}__{}__{}define({__BYTES_16BIT},4){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld    A{,}format({%-12s},$2); 3:13      }_TMP_INFO{
__{}__{}__{}    ld  $1{,}A          ; 1:7       }_TMP_INFO)},
__{}__{}__HEX_L($2):__IS_NUM($4),__HEX_L($4):1,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},7){}dnl
__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,}substr($3,1,1)          ; 1:7       }_TMP_INFO)},
__{}__{}__HEX_L($2):__IS_NUM($4),__HEX_H($4):1,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},7){}dnl
__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,}substr($3,0,1)          ; 1:7       }_TMP_INFO)},
__{}__{}__HEX_L($2):__IS_NUM($6),__HEX_L($6):1,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},7){}dnl
__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,}substr($5,1,1)          ; 1:7       }_TMP_INFO)},
__{}__{}__HEX_L($2):__IS_NUM($6),__HEX_H($6):1,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},7){}dnl
__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,}substr($5,0,1)          ; 1:7       }_TMP_INFO)},
__{}__{}__HEX_L($2):__IS_NUM($8),__HEX_L($8):1,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},7){}dnl
__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,}substr($7,1,1)          ; 1:7       }_TMP_INFO)},
__{}__{}__HEX_L($2):__IS_NUM($8),__HEX_H($8):1,{dnl
__{}__{}__{}define({__CLOCKS_16BIT},7){}dnl
__{}__{}__{}define({__BYTES_16BIT},1){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,}substr($7,0,1)          ; 1:7       }_TMP_INFO)},
__{}__{}{dnl
__{}__{}__{}define({__CLOCKS_16BIT},10){}dnl
__{}__{}__{}define({__BYTES_16BIT},2){}dnl
__{}__{}__{}define({__CODE_16BIT},{
__{}__{}__{}    ld  $1{,} format({%-10s},$2); 2:10      }_TMP_INFO)})},
__{}$1,(BC),{bc dodelat!},
__{}$1,(DE),{de dodelat!},
__{}{dnl # unknown target name
__{}define({__CLOCKS_16BIT},0){}dnl
__{}define({__BYTES_16BIT},0){}dnl
__{}define({__CODE_16BIT},{})})},
__IS_MEM_REF($2),{1},{dnl
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
__{}ifelse(__IS_NUM(__SUM_BYTES), 0,{define({__SUM_BYTES},  __BYTES_16BIT)},{__add({__SUM_BYTES}, __BYTES_16BIT)}){}dnl
__{}ifelse(__IS_NUM(__SUM_CLOCKS),0,{define({__SUM_CLOCKS},__CLOCKS_16BIT)},{__add({__SUM_CLOCKS},__CLOCKS_16BIT)}){}dnl
__{}ifelse(__IS_NUM(__SUM_PRICES),0,{define({__SUM_PRICES}, __PRICE_16BIT)},{__add({__SUM_PRICES},__PRICE_16BIT)}){}dnl
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
dnl # reg with 255 must by last (before 256)
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    xor   __HEX_L(__N4)          ; 2:7       _TMP_INFO   x[4] = __HEX_L(__N4)  termination of identical values})},
__{}dnl
__{}dnl a+1 a - -
__{}dnl
__{}eval(__N4==(__N3+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = x[3]/2})},
__{}dnl
__{}dnl left(c) c - -
__{}dnl
__{}eval(__N4==((514*__N3)/256 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    rlca                ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = 514*x[3]/256})},
__{}dnl
__{}dnl right(c) c - -
__{}dnl
__{}eval(__N4==((257*__N3 & 0xFF)/2)),{1},{dnl
__{}__{}define({_TMP_B4},4){}dnl
__{}__{}define({_TMP_T4},15){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
__{}__{}    rrca                ; 1:4       _TMP_INFO
__{}__{}    xor   __R4             ; 1:4       _TMP_INFO   x[4] = 257*x[3]/2})},
__{}dnl
__{}dnl   default version
__{}{dnl
__{}__{}define({_TMP_B4},5){}dnl
__{}__{}define({_TMP_T4},18){}dnl
__{}__{}define({_TMP_J3},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_4},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B4)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    cp    __R4             ; 1:4       _TMP_INFO   x[3] = x[4]  continuation of identical values})},
__{}dnl
__{}dnl c c - -    the beginning of identical values (preserves value)
__{}dnl
__{}__N4,__N3,{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    _TMP_OR3  __HEX_L(__N3)           ; 2:7       _TMP_INFO   x[3] = __HEX_L(__N3)  termination of identical values})},
__{}dnl
__{}dnl - b+1 b -
__{}dnl
__{}eval(__N3==(__N2+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = x[2]/2})},
__{}dnl
__{}dnl - left(b) b -
__{}dnl
__{}eval(__N3==((514*__N2)/256 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    rlca                ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = 514*x[2]/256})},
__{}dnl
__{}dnl - right(b) b -
__{}dnl
__{}eval(__N3==((257*__N2)/2 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+4)){}dnl
__{}__{}define({_TMP_T3},15){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
__{}__{}    rrca                ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR3   __R3             ; 1:4       _TMP_INFO   x[3] = 257*x[2]/2})},__{}dnl
__{}dnl  default version
__{}{dnl
__{}__{}define({_TMP_B3},eval(_TMP_B4+5)){}dnl
__{}__{}define({_TMP_T3},18){}dnl
__{}__{}define({_TMP_J2},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_3},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B3)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} __R2          ; 1:4       _TMP_INFO   the beginning of identical values
__{}__{}    cp    __R3             ; 1:4       _TMP_INFO   x[2] = x[3]})},
__{}dnl
__{}dnl - - a a    termination of identical values
__{}__N2,__N1,{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},14){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    _TMP_OR2   __HEX_L(__N2)          ; 2:7       _TMP_INFO   x[2] = __HEX_L(__N2)  termination of identical values})},
__{}dnl
__{}dnl - - a+1 a
__{}dnl
__{}eval(__N2==(__N1+1 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
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
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   __R2             ; 1:4       _TMP_INFO   x[2] = x[1]/2})},
__{}dnl
__{}dnl - - left(a) a
__{}dnl
__{}eval(__N2==((514*__N1)/256 & 0xFF)),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    rlca                ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   __R2             ; 1:4       _TMP_INFO   x[2] = 514*x[1]/256})},
__{}dnl
__{}dnl - - right(a) a
__{}dnl
__{}eval(__N2==((257*__N1)/2) & 0xFF),{1},{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+4)){}dnl
__{}__{}define({_TMP_T2},15){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}    rrca                ; 1:4       _TMP_INFO
__{}__{}    _TMP_OR2   __R2             ; 1:4       _TMP_INFO   x[2] = 257*x[1]/2})},
__{}dnl
__{}dnl - - - -     default version
__{}{dnl
__{}__{}define({_TMP_B2},eval(_TMP_B3+5)){}dnl
__{}__{}define({_TMP_T2},18){}dnl
__{}__{}define({_TMP_J1},eval(12+_TMP_J0)){}dnl
__{}__{}define({__DEQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2)); 2:7/12    _TMP_INFO
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
dnl #   $1 = BC,HL,DE
dnl #   $2 = 16 bit number
dnl #   $3 = +-bytes no jump
dnl #   $4 = +-clocks no jump
dnl #   $5 = +-bytes jump
dnl #   $6 = +-clocks jump
dnl #         _TMP_INFO = info
dnl #   _TMP_STACK_INFO = stack info
dnl #
dnl # Out:
dnl #   __EQ_CODE
dnl #     zero flag if $1 == $2
dnl #     if zero flag then A = 0
dnl #
dnl # Pollutes:
dnl #
dnl #  A, flag, can change C if C is not in $1
dnl
define({__EQ_MAKE_CODE},{dnl
__{}define({_TMP_R2},substr($1,0,1)){}dnl
__{}define({_TMP_R1},substr($1,1,1)){}dnl
__{}define({_TMP_N2},eval(__HEX_H($2))){}dnl
__{}define({_TMP_N1},eval(__HEX_L($2))){}dnl
__{}dnl # Code look like:
__{}dnl #   __EQ_CODE_1          ; _TMP_B1:_TMP
__{}dnl #   __EQ_CODE_2          ; _TMP_B2:_TMP
__{}dnl #
__{}dnl # __EQ_CODE_2 look like:
__{}dnl #                  ;[_TMP_B2:..]
__{}dnl #   jp nz, $5            ; 3:10
__{}dnl #   ...                  ;..:..
__{}dnl #
__{}dnl # __EQ_CODE_2 look like:
__{}dnl #                  ;[_TMP_B2:..]
__{}dnl #   jr nz, $5+_TMP_B2    ; 2:7/12
__{}dnl #   ...                  ;..:..
__{}dnl #
__{}dnl # __EQ_CODE_2 look like:
__{}dnl #                  ;[_TMP_B2:..]
__{}dnl #   ...                  ;..:..
__{}dnl
__{}dnl --------------- 2 ---------------
__{}dnl
__{}define({_TMP_OR1},{cp }){}dnl
__{}ifelse(_TMP_N2,0,{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},1){}dnl
__{}__{}define({_TMP_T2},4){}dnl
__{}__{}define({_TMP_J1},eval($4+4)){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE_2},{
__{}__{}    or    _TMP_R2             ; 1:4       _TMP_INFO   x[2] = 0})},
__{}_TMP_N2{-}_TMP_N1,{2-1},{dnl
__{}__{}ifelse(__IS_NAME($5),0,{dnl
__{}__{}__{}define({_TMP_B2},3){}dnl
__{}__{}__{}define({_TMP_T2},11){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+12)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval($5+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[2] = 2})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},14){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+10)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$5); 3:10      _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[2] = 2})})},
__{}_TMP_N2,{255},{dnl
__{}__{}define({_TMP_B2},2){}dnl
__{}__{}define({_TMP_T2},8){}dnl
__{}__{}define({_TMP_J1},eval($4+8)){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE_2},{
__{}__{}    and   _TMP_R2             ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[2] = 0xFF})},
__{}regexp({$1},{.*[Cc].*}){:}_TMP_N2{-}_TMP_N1,{-1:1-1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},eval($4+12)){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE_2},{
__{}__{}    ld    C{{,}} _TMP_R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}regexp({$1},{.*[Cc].*}){:}_TMP_N2,{-1:1},{dnl
__{}__{}define({_TMP_OR1},{xor}){}dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},12){}dnl
__{}__{}define({_TMP_J1},eval($4+12)){}dnl      No jump! Multibyte solution
__{}__{}define({__EQ_CODE_2},{
__{}__{}    ld    C{{,}} _TMP_R2          ; 1:4       _TMP_INFO
__{}__{}    dec   C             ; 1:4       _TMP_INFO
__{}__{}    or    C             ; 1:4       _TMP_INFO   x[2] = 1})},
__{}_TMP_N2,_TMP_N1,{dnl
__{}__{}ifelse(__IS_NAME($5),0,{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},14){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+12)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval($5+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    xor   __HEX_L(_TMP_N2)          ; 2:7       _TMP_INFO   x[2] = __HEX_L(_TMP_N2)})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},17){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+10)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$5); 3:10      _TMP_INFO
__{}__{}__{}    xor   __HEX_L(_TMP_N2)          ; 2:7       _TMP_INFO   x[2] = __HEX_L(_TMP_N2)})})},
__{}eval(_TMP_N2==(_TMP_N1+1 & 0xFF)),{1},{dnl
__{}__{}ifelse(__IS_NAME($5),0,{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+12)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval($5+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = x[1] + 1})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+10)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$5); 3:10      _TMP_INFO
__{}__{}__{}    inc   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = x[1] + 1})})},
__{}eval(_TMP_N2==(_TMP_N1-1 & 0xFF)),{1},{dnl
__{}__{}ifelse(__IS_NAME($5),0,{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+12)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval($5+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = x[1] - 1})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+10)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$5); 3:10      _TMP_INFO
__{}__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = x[1] - 1})})},
__{}eval(_TMP_N2==(_TMP_N1+_TMP_N1 & 0xFF)),{1},{dnl
__{}__{}ifelse(__IS_NAME($5),0,{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+12)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval($5+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    add   A{{,}} _TMP_R1          ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = x[1] + x[1]})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+10)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$5); 3:10      _TMP_INFO
__{}__{}__{}    add   A{{,}} _TMP_R1          ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = x[1] + x[1]})})},
__{}eval(_TMP_N2==(_TMP_N1/2)),{1},{dnl
__{}__{}ifelse(__IS_NAME($5),0,{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+12)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval($5+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = x[1]/2})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+10)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$5); 3:10      _TMP_INFO
__{}__{}__{}    rra                 ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = x[1]/2})})},
__{}__HEX_L(_TMP_N2),__HEX_H((_TMP_N1*257)*2),{dnl
__{}__{}ifelse(__IS_NAME($5),0,{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+12)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval($5+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    rlca                ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = rotation_left(x[1]) = 2*257*x[1]/256})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+10)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$5); 3:10      _TMP_INFO
__{}__{}__{}    rlca                ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = rotation_left(x[1]) = 2*257*x[1]/256})})},
__{}__HEX_L(_TMP_N2),__HEX_L((_TMP_N1*257)/2),{dnl
__{}__{}ifelse(__IS_NAME($5),0,{dnl
__{}__{}__{}define({_TMP_B2},4){}dnl
__{}__{}__{}define({_TMP_T2},15){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+12)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval($5+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    rrca                ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = rotation_right(x[1]) = 257*x[1]/2})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+10)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$5); 3:10      _TMP_INFO
__{}__{}__{}    rrca                ; 1:4       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = rotation_right(x[1]) = 257*x[1]/2})})},
__{}{dnl
__{}__{}ifelse(__IS_NAME($5),0,{dnl
__{}__{}__{}define({_TMP_B2},5){}dnl
__{}__{}__{}define({_TMP_T2},18){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+12)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jr   nz{{,}} $+format({%-9s},eval($5+_TMP_B2)); 2:7/12    _TMP_INFO
__{}__{}__{}    ld    A{{,}} __HEX_L(_TMP_N2)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = __HEX_L(_TMP_N2)})},
__{}__{}{dnl
__{}__{}__{}define({_TMP_B2},6){}dnl
__{}__{}__{}define({_TMP_T2},21){}dnl
__{}__{}__{}define({_TMP_J1},eval($6+10)){}dnl
__{}__{}__{}define({__EQ_CODE_2},{
__{}__{}__{}    jp   nz{{,}} format({%-11s},$5); 3:10      _TMP_INFO
__{}__{}__{}    ld    A{{,}} __HEX_L(_TMP_N2)       ; 2:7       _TMP_INFO
__{}__{}__{}    xor   _TMP_R2             ; 1:4       _TMP_INFO   x[2] = __HEX_L(_TMP_N2)})})}){}dnl
__{}dnl
__{}dnl --------------- 1 ---------------
__{}dnl
__{}ifelse(_TMP_N1,0,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{{,}} _TMP_R1          ; 1:4       _TMP_INFO   x[1] = 0})},
__{}_TMP_N2{-}_TMP_N1,{255-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+1)){}dnl
__{}__{}define({_TMP_T1},4){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{{,}} _TMP_R1          ; 1:4       _TMP_INFO   x[1] = 0xFF})},
__{}_TMP_N2{-}_TMP_N1,{255-254},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{{,}} _TMP_R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = x[2] - 1})},
__{}_TMP_N2,{255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{{,}} _TMP_R1          ; 1:4       _TMP_INFO
__{}__{}    xor   __HEX_L(_TMP_N1 ^ 0xFF)          ; 2:7       _TMP_INFO   x[1] = 0xFF ^ __HEX_L(_TMP_N1 ^ 0xFF)})},
__{}_TMP_N2{-}_TMP_N1,{0-255},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{{,}} _TMP_R1          ; 1:4       _TMP_INFO
__{}__{}    inc   A             ; 1:4       _TMP_INFO   x[1] = 0xFF})},
__{}_TMP_N2{-}_TMP_N1,{2-1},{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},12){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{{,}} _TMP_R2          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO
__{}__{}    cp    _TMP_R1             ; 1:4       _TMP_INFO   x[1] = x[2] - 1})},
__{}_TMP_N1,{1},{dnl    255-1 --> 255-x rule priority!
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{{,}} _TMP_R1          ; 1:4       _TMP_INFO
__{}__{}    dec   A             ; 1:4       _TMP_INFO   x[1] = 1})},
__{}_TMP_N2,_TMP_N1,{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+2)){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{{,}} _TMP_R1          ; 1:4       _TMP_INFO
__{}__{}    cp    _TMP_R2             ; 1:4       _TMP_INFO   x[1] = x[2]})},
__{}{dnl
__{}__{}define({_TMP_B1},eval(_TMP_B2+3)){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{{,}} __HEX_L(_TMP_N1)       ; 2:7       _TMP_INFO
__{}__{}    _TMP_OR1   _TMP_R1             ; 1:4       _TMP_INFO   x[1] = __HEX_L(_TMP_N1)})}){}dnl
__{}dnl
__{}dnl # ---------------------------------
__{}dnl # $0($1,$2,    $3,             $4,             $5,          $6,          $7,        $8)
__{}dnl # $0(HL,0x1234,+-bytes no jump,+-clock no jump,+-bytes jump,+-clock jump,old prices,old bytes)
__{}dnl # jr --> define({_TMP_J1},eval(12+_TMP_J0))
__{}dnl # jp --> define({_TMP_J1},eval(10-($4+0)))
__{}dnl # _TMP_J1 = clock jump instruction +-clock jump
__{}define({_TMP_J1},eval(_TMP_J1+_TMP_T1)){}dnl         # clock for fail with    jmp
__{}define({_TMP_J2},eval($4+_TMP_T2+_TMP_T1)){}dnl      # clock for fail without jmp = clock true
__{}define({__EQ_CLOCKS_FAIL},eval(_TMP_J1+_TMP_J2)){}dnl
__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J2)){}dnl
__{}define({__EQ_PRICE},eval(8*__EQ_CLOCKS_FAIL)){}dnl
__{}define({__EQ_CLOCKS_FAIL},eval((1+__EQ_CLOCKS_FAIL)/2)){}dnl
__{}define({__EQ_CLOCKS},eval((8+__EQ_PRICE)/16)){}dnl
__{}define({__EQ_BYTES},eval($3+_TMP_B1)){}dnl
__{}define({__EQ_PRICE},eval(__EQ_PRICE+(64*__EQ_BYTES)+ifelse(_TMP_R2,{L},{1},{0}))){}dnl   # = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}ifelse(debug,-debug,{
__{}__{}; ------------
__{}__{}format({%-20s},$1=$2)format({%-10s},t2:_TMP_T2)...clock down code with fail jump
__{}__{}format({%-20s},{ true:}__EQ_CLOCKS_TRUE)format({%-10s},b1:_TMP_B1)...bytes all  code
__{}__{}format({%-20s},{ fail:}__EQ_CLOCKS_FAIL)format({%-10s},b2:_TMP_B2)...bytes down code with jump
__{}__{}format({%-20s},price:__EQ_PRICE)format({%-10s},j2:_TMP_J2)...clock without jump
__{}__{}format({%-20s},clock:__EQ_CLOCKS)format({%-10s},j1:_TMP_J1)...clock with    jump
__{}__{}format({%-20s},bytes:__EQ_BYTES)format({%-10s},t1:_TMP_T1)...clock up   code
__{}}){}dnl
__{}dnl
__{}ifelse($7,{},{dnl
__{}__{}ifelse(__EQ_CLOCKS_TRUE,_TMP_J1,
__{}__{}__{}{define({__EQ_HEAD},format({%-8s},__EQ_CLOCKS_TRUE] ))},
__{}__{}__{}{define({__EQ_HEAD},format({%-8s},__EQ_CLOCKS_TRUE/_TMP_J1] ))}){}dnl
__{}__{}define({__EQ_HEAD},format({%28s},;[eval(__EQ_BYTES):)__EQ_HEAD{}_TMP_STACK_INFO){}dnl
__{}__{}define({__EQ_CODE},__EQ_HEAD{}__EQ_CODE_1{}__EQ_CODE_2){}dnl
__{}__{}dnl
__{}__{}define({__TMP_EQ_CLOCKS_TRUE},__EQ_CLOCKS_TRUE){}dnl
__{}__{}define({__TMP_EQ_CLOCKS_FAIL},__EQ_CLOCKS_FAIL){}dnl
__{}__{}define(      {__TMP_EQ_PRICE},__EQ_PRICE){}dnl
__{}__{}define(     {__TMP_EQ_CLOCKS},__EQ_CLOCKS){}dnl
__{}__{}define(      {__TMP_EQ_BYTES},__EQ_BYTES){}dnl
__{}__{}$0(substr($1,1,1){}substr($1,0,1),__HEX_HL(__HEX_L($2)*256+__HEX_H($2)),$3,$4,$5,$6,__EQ_PRICE,__EQ_BYTES)},
__{}_TYP_SINGLE:eval(__EQ_BYTES{}0<$8{}0),{small:1},{
__{}__{}ifelse(__EQ_CLOCKS_TRUE,_TMP_J1,
__{}__{}__{}{define({__EQ_HEAD},format({%-8s},__EQ_CLOCKS_TRUE] ))},
__{}__{}__{}{define({__EQ_HEAD},format({%-8s},__EQ_CLOCKS_TRUE/_TMP_J1] ))}){}dnl
__{}__{}define({__EQ_HEAD},format({%28s},;[eval(__EQ_BYTES):){}__EQ_HEAD{}_TMP_STACK_INFO){}dnl
__{}__{}define({__EQ_CODE},__EQ_HEAD{}__EQ_CODE_1{}__EQ_CODE_2){}dnl
__{}},
__{}eval(__EQ_PRICE{}0<$7{}0),1,{dnl
__{}__{}ifelse(__EQ_CLOCKS_TRUE,_TMP_J1,
__{}__{}__{}{define({__EQ_HEAD},format({%-8s},__EQ_CLOCKS_TRUE] ))},
__{}__{}__{}{define({__EQ_HEAD},format({%-8s},__EQ_CLOCKS_TRUE/_TMP_J1] ))}){}dnl
__{}__{}define({__EQ_HEAD},format({%28s},;[eval(__EQ_BYTES):){}__EQ_HEAD{}_TMP_STACK_INFO){}dnl
__{}__{}define({__EQ_CODE},__EQ_HEAD{}__EQ_CODE_1{}__EQ_CODE_2){}dnl
__{}},
__{}{dnl
__{}__{}define({__EQ_CLOCKS_TRUE},__TMP_EQ_CLOCKS_TRUE){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},__TMP_EQ_CLOCKS_FAIL){}dnl
__{}__{}define(      {__EQ_PRICE},__TMP_EQ_PRICE){}dnl
__{}__{}define(     {__EQ_CLOCKS},__TMP_EQ_CLOCKS){}dnl
__{}__{}define(      {__EQ_BYTES},__TMP_EQ_BYTES){}dnl
__{}}){}dnl
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
define({__EQ_MAKE_BEST_CODE},{dnl
__{}ifelse($5,{},{define({_TMP_J0},0)},{define({_TMP_J0},$5)}){}dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($1):_TYP_SINGLE,{1:small},{dnl
__{}dnl ---------------------------------
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld   BC{,} format({%-11s},$1); 4:20      _TMP_INFO
__{}__{}    xor   A             ; 1:4       _TMP_INFO   cp HL{,} BC
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   cp HL{,} BC
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   cp HL{,} BC}){}dnl
__{}__{}define({_TMP_BEST_B},eval($2+8)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval($3+50)){}dnl
__{}__{}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},__EQ_CLOCKS_FAIL){}dnl
__{}__{}define({_TMP_BEST_C},__EQ_CLOCKS_TRUE){}dnl
__{}__{}define({_TMP_BEST_P},eval(16*_TMP_BEST_C+64*_TMP_BEST_B)){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},{                        ;}format({%-10s},[eval(_TMP_BEST_B):_TMP_BEST_C]){ _TMP_STACK_INFO{}__EQ_CODE_1})},
__{}__IS_MEM_REF($1):__IS_NAME($4),1:0,{dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} format({%-11s},$1); 3:13      _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jr   nz{,} format({%-11s},$+eval($4+6)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({_TMP_BEST_B},eval($2+10)){}dnl
__{}__{}define({_TMP_J1},eval($5+29)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval($3+41)){}dnl
__{}__{}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J1+__EQ_CLOCKS_FAIL)){}dnl
__{}__{}define({_TMP_BEST_P},eval(8*__EQ_CLOCKS_TRUE)){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval((1+__EQ_CLOCKS_TRUE)/2)){}dnl
__{}__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},format({%37s},;[eval(_TMP_BEST_B):_TMP_J1{{,}}__EQ_CLOCKS_FAIL/__EQ_CLOCKS_FAIL]){ _TMP_STACK_INFO{}__EQ_CODE_1})},
__{}__IS_MEM_REF($1),1,{dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} format({%-11s},$1); 3:13      _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jp   nz{,} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({_TMP_BEST_B},eval($2+11)){}dnl
__{}__{}define({_TMP_J1},eval($5+27)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval($3+44)){}dnl
__{}__{}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J1+__EQ_CLOCKS_FAIL)){}dnl
__{}__{}define({_TMP_BEST_P},eval(8*__EQ_CLOCKS_TRUE)){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval((1+__EQ_CLOCKS_TRUE)/2)){}dnl
__{}__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},format({%37s},;[eval(_TMP_BEST_B):_TMP_J1{{,}}__EQ_CLOCKS_FAIL/__EQ_CLOCKS_FAIL]){ _TMP_STACK_INFO{}__EQ_CODE_1})},
__{}__IS_NUM($1):_TYP_SINGLE,{0:small},{dnl
__{}dnl ---------------------------------
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld   BC{,} format({%-11s},$1); 3:10      _TMP_INFO
__{}__{}    xor   A             ; 1:4       _TMP_INFO   cp HL{,} BC
__{}__{}    sbc  HL{,} BC         ; 2:15      _TMP_INFO   cp HL{,} BC
__{}__{}    add  HL{,} BC         ; 1:11      _TMP_INFO   cp HL{,} BC}){}dnl
__{}__{}define({_TMP_BEST_B},eval($2+7)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval($3+40)){}dnl
__{}__{}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},__EQ_CLOCKS_FAIL){}dnl
__{}__{}define({_TMP_BEST_C},__EQ_CLOCKS_TRUE){}dnl
__{}__{}define({_TMP_BEST_P},eval(16*_TMP_BEST_C+64*_TMP_BEST_B)){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},{                        ;}format({%-10s},[eval(_TMP_BEST_B):_TMP_BEST_C]){ _TMP_STACK_INFO{}__EQ_CODE_1})},
__{}__IS_NUM($1):__IS_NAME($4),0:0,{
__{}__{}  .warning {$0}($@): M4 does not know the "$1" value and therefore cannot optimize the code.{}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} low format({%-7s},$1); 2:7       _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jr   nz{,} format({%-11s},$+eval($4+5)); 2:7/12    _TMP_INFO
__{}__{}    ld    A{,} high format({%-6s},$1); 2:7       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({_TMP_BEST_B},eval($2+8)){}dnl
__{}__{}define({_TMP_J1},eval($5+23)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval($3+29)){}dnl
__{}__{}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J1+__EQ_CLOCKS_FAIL)){}dnl
__{}__{}define({_TMP_BEST_P},eval(8*__EQ_CLOCKS_TRUE)){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval((1+__EQ_CLOCKS_TRUE)/2)){}dnl
__{}__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},format({%37s},;[eval(_TMP_BEST_B):_TMP_J1{{,}}__EQ_CLOCKS_FAIL/__EQ_CLOCKS_FAIL]){ _TMP_STACK_INFO{}__EQ_CODE_1})},
__{}__IS_NUM($1),0,{dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} low format({%-7s},$1); 2:7       _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO
__{}__{}    jp   nz{,} format({%-11s},$4); 3:10      _TMP_INFO
__{}__{}    ld    A{,} high format({%-6s},$1); 2:7       _TMP_INFO
__{}__{}    xor   H             ; 1:4       _TMP_INFO}){}dnl
__{}__{}define({_TMP_BEST_B},eval($2+9)){}dnl
__{}__{}define({_TMP_J1},eval($5+21)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval($3+32)){}dnl
__{}__{}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J1+__EQ_CLOCKS_FAIL)){}dnl
__{}__{}define({_TMP_BEST_P},eval(8*__EQ_CLOCKS_TRUE)){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval((1+__EQ_CLOCKS_TRUE)/2)){}dnl
__{}__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},format({%37s},;[eval(_TMP_BEST_B):_TMP_J1{{,}}__EQ_CLOCKS_FAIL/__EQ_CLOCKS_FAIL]){ _TMP_STACK_INFO{}__EQ_CODE_1})},
__{}_TYP_SINGLE,{L_first},{dnl
dnl # Input parameters:
dnl #   $1 = 16 bit number
dnl #   $2 = +-bytes no jump
dnl #   $3 = +-clocks no jump
dnl #   $4 = +-bytes jump
dnl #   $5 = +-clocks jump
dnl #   _TMP_INFO = info
dnl #   _TMP_STACK_INFO = stack info
__{}dnl ---------------------------------
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
__{}eval(__HEX_L(__HEX_H($1)+1)<3),{1},{dnl  # 0xFF.., 0x00.., 0x01..
__{}__{}define({_TMP_A1},{0x00}){}dnl
__{}__{}define({_TMP_B1},3){}dnl
__{}__{}define({_TMP_T1},11){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} __HEX_L($1)       ; 2:7       _TMP_INFO
__{}__{}    xor   L             ; 1:4       _TMP_INFO   L = __HEX_L($1)})},
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
__{}ifelse(__IS_NAME($4),0,{dnl
__{}__{}define({_TMP_B2},2){}dnl
__{}__{}define({_TMP_T2},7){}dnl
__{}__{}define({_TMP_J1},eval($5+12+_TMP_T1)){}dnl
__{}__{}define({__EQ_CODE_2},{
__{}__{}    jr   nz{,} $+format({%-9s},eval($4+_TMP_B2+_TMP_B3)); 2:7/12    _TMP_INFO})},
__{}{dnl
__{}__{}define({_TMP_B2},3){}dnl
__{}__{}define({_TMP_T2},10){}dnl
__{}__{}define({_TMP_J1},eval($5+10+_TMP_T1)){}dnl
__{}__{}define({__EQ_CODE_2},{
__{}__{}    jp   nz{,} format({%-11s},$4); 3:10      _TMP_INFO})}){}dnl
__{}dnl
__{}ifelse(__HEX_HL($1),0x0000,{dnl
__{}__{}define({_TMP_B1},2){}dnl
__{}__{}define({_TMP_B2},0){}dnl
__{}__{}define({_TMP_B3},0){}dnl
__{}__{}define({_TMP_T1},8){}dnl
__{}__{}define({_TMP_T2},0){}dnl
__{}__{}define({_TMP_T3},0){}dnl
__{}__{}define({_TMP_J1},eval($3+8)){}dnl
__{}__{}define({__EQ_CODE_3},{}){}dnl
__{}__{}define({__EQ_CODE_2},{}){}dnl
__{}__{}define({__EQ_CODE_1},{
__{}__{}    ld    A{,} L          ; 1:4       _TMP_INFO
__{}__{}    or    H             ; 1:4       _TMP_INFO   L = H = 0x00})}){}dnl
__{}dnl
__{}dnl ---------------------------------
__{}dnl
__{}__{}define({_TMP_BEST_B},eval($2+_TMP_B1+_TMP_B2+_TMP_B3)){}dnl
__{}__{}define({__EQ_CLOCKS_FAIL},eval($3+_TMP_T1+_TMP_T2+_TMP_T3)){}dnl
__{}__{}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval(_TMP_J1+__EQ_CLOCKS_FAIL)){}dnl
__{}__{}define({_TMP_BEST_P},eval(8*__EQ_CLOCKS_TRUE)){}dnl
__{}__{}define({__EQ_CLOCKS_TRUE},eval((1+__EQ_CLOCKS_TRUE)/2)){}dnl
__{}__{}define({_TMP_BEST_C},eval((8+_TMP_BEST_P)/16)){}dnl
__{}__{}define({_TMP_BEST_P},eval(_TMP_BEST_P+(64*_TMP_BEST_B))){}dnl              = 16*(clocks + 4*bytes) + 1 if it does not check register L first
__{}__{}define({_TMP_BEST_CODE},format({%37s},;[eval(_TMP_BEST_B):_TMP_J1{{,}}__EQ_CLOCKS_FAIL/__EQ_CLOCKS_FAIL]){ _TMP_STACK_INFO   L_first variant{}__EQ_CODE_1{}__EQ_CODE_2{}__EQ_CODE_3})},
__{}{dnl
__{}__EQ_MAKE_CODE({HL},$1,$2,$3,$4,$5){}dnl
__{}define({_TMP_BEST_P},__EQ_PRICE){}dnl
__{}define({_TMP_BEST_B},__EQ_BYTES){}dnl
__{}define({_TMP_BEST_C},__EQ_CLOCKS){}dnl
__{}define({_TMP_BEST_CODE},__EQ_CODE)}){}dnl
__{}ifelse(debug,-debug,{
__{}__{}; bytes: _TMP_BEST_B
__{}__{}; prize: _TMP_BEST_P
__{}__{}; clock: _TMP_BEST_C
__{}__{}; true: __EQ_CLOCKS_TRUE
__{}__{}; false: __EQ_CLOCKS_FAIL
__{}}){}dnl
}){}dnl
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
__{}__EQ_MAKE_CODE($3,$4,$5,$6,$7,$8){}dnl
__{}define({_TMP_BEST_P},__EQ_PRICE){}dnl
__{}define({_TMP_BEST_B},__EQ_BYTES){}dnl
__{}define({_TMP_BEST_C},__EQ_CLOCKS){}dnl
__{}define({_TMP_BEST_CODE},__EQ_CODE){}dnl
}){}dnl
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
dnl #    $4 ...+bytes    after code
dnl #    $5 ...+clocks   after code
dnl #    $6 ...+-bytes   carry jump     if (number) jr else if (name) jp
dnl #    $7 ...+-clocks  carry jump
dnl #    $8 ...+-bytes   no carry jump  if (number) jr else if (name) jp
dnl #    $9 ...+-clocks  no carry jump
dnl # Output:
dnl #    print code
dnl # Pollutes:
dnl #    AF, BC
dnl # Use:
dnl #    until
dnl #    __MAKE_CODE_DLT_SET_CARRY($@,{( d -- d )  flag: d < $1<<16+$2},3,10,3,0,begin{}BEGIN_STACK,0)
dnl #        jp   nc, format({%-11s},begin{}BEGIN_STACK); 3:10      __INFO
define({__MAKE_CODE_DLT_SET_CARRY},{dnl
ifelse(dnl
__IS_MEM_REF($1):__IS_MEM_REF($2),1:1,{dnl
__{}__SET_BYTES_CLOCKS_PRICES($4+12,$5+48){}dnl
__{}define({_TMP_INFO},__INFO{   ..BC = $2}){}dnl
__{}__LD_REG16(BC,$1,BC,$2){}dnl
__{}__LD_REG16(BC,$2){}dnl
__{}ifelse($3,{},,{
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS])__INFO   {$3}}){}dnl
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
__IS_MEM_REF($1):__IS_MEM_REF($2),1:0,{dnl
__{}__SET_BYTES_CLOCKS_PRICES($4+18,$5+74){}dnl
__{}ifelse($3,{},,{
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS])__INFO   {$3}})
__{}                       ;format({%-12s},[__SUM_BYTES:__SUM_CLOCKS])__INFO   {$3}
__{}    ld    A{,} L          ; 1:4       __INFO   HL < $2
__{}    sub  format({%-15s},low $2); 2:7       __INFO   HL - $2 < 0 --> carry if true
__{}    ld    A{,} H          ; 1:4       __INFO   HL < $2
__{}    sbc   A{,} format({%-11s},high $2); 2:7       __INFO   HL - $2 < 0 --> carry if true
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO   BC.. = $1
__{}    ld    A{,} E          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A{,} C          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    ld    A{,} D          ; 1:4       __INFO   DE.. < BC..
__{}    sbc   A{,} B          ; 1:4       __INFO   DE.. - BC.. < 0 --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO
__{}    xor   B             ; 1:4       __INFO
__{}    add   A{,} A          ; 1:4       __INFO   --> carry if true},
__IS_MEM_REF($1):__IS_MEM_REF($2),0:1,{dnl
__{}ifelse(__HEX_H(0x8000 & ($1)),0x00,{__SET_BYTES_CLOCKS_PRICES($4+17,$5+70)},{__SET_BYTES_CLOCKS_PRICES($4+18,$5+74)}){}dnl
__{}ifelse($3,{},,{
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS])__INFO   {$3}})
__{}    ld   BC{,}format({%-12s},$2); 4:20      __INFO   ..BC = $2
__{}    ld    A{,} L          ; 1:4       __INFO   ..HL < ..BC
__{}    sub   C             ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true
__{}    ld    A{,} H          ; 1:4       __INFO   ..HL < ..BC
__{}    sbc   A{,} B          ; 1:4       __INFO   ..HL - ..BC < 0 --> carry if true
__{}    ld    A{,} E          ; 1:4       __INFO   DE < $1
__{}    sbc   A{,} format({%-11s},low $1); 2:7       __INFO   DE - $1 < 0 --> carry if true
__{}    ld    A{,} D          ; 1:4       __INFO   DE < $1
__{}    sbc   A{,} format({%-11s},high $1); 2:7       __INFO   DE - $1 < 0 --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO{}dnl
__{}ifelse(__IS_NUM($1),0,{
__{}  if ((0x8000 & ($1)) = 0x8000)
__{}    ccf                 ; 1:4       __INFO
__{}  endif},
__{}__HEX_HL(0x8000 & ($1)),0x8000,{
__{}    ccf                 ; 1:4       __INFO})
__{}    add   A{,} A          ; 1:4       __INFO   --> carry if true},
{dnl
__{}__SET_BYTES_CLOCKS_PRICES($4+14,$5+52){}dnl
__{}ifelse(__HEX_H(0x8000 & ($1)),0x80,{dnl
__{}__{}ifelse(__IS_NAME($8),1,
__{}__{}{__add({__SUM_BYTES},3){}__add({__SUM_CLOCKS},10){}define({__JMP_CLOCK},eval($9+4+4+10)){}define({__JMP_CODE},{    jp   nc{,} format({%-11s},$8); 3:10      __INFO   positive d1 < negative constant --> false})},
__{}__{}{__add({__SUM_BYTES},2){}__add({__SUM_CLOCKS}, 7){}define({__JMP_CLOCK},eval($9+4+4+12)){}define({__JMP_CODE},{    jr   nc{,} format({%-11s},$+eval($8+14)); 2:7/12    __INFO   positive d1 < negative constant --> false})}){}dnl
__{}},
__{}__HEX_H(0x8000 & ($1)),0x00,{dnl
__{}__{}ifelse(__IS_NAME($6),1,
__{}__{}{__add({__SUM_BYTES},3){}__add({__SUM_CLOCKS},10){}define({__JMP_CLOCK},eval($7+4+4+10)){}define({__JMP_CODE},{    jp    c{,} format({%-11s},$6); 3:10      __INFO   negative d1 < positive constant --> ture})},
__{}__{}{__add({__SUM_BYTES},2){}__add({__SUM_CLOCKS}, 7){}define({__JMP_CLOCK},eval($7+4+4+12)){}define({__JMP_CODE},{    jr    c{,} format({%-11s},$+eval($6+14)); 2:7/12    __INFO   negative d1 < positive constant --> true})}){}dnl
__{}},{dnl
__{}__{}ifelse(__IS_NAME($8),1,
__{}__{}{__add({__SUM_BYTES},3){}__add({__SUM_CLOCKS},10){}define({__JMP_CLOCK},eval($9+4+4+10))},
__{}__{}{__add({__SUM_BYTES},2){}__add({__SUM_CLOCKS}, 7){}define({__JMP_CLOCK},eval($9+4+4+12))}){}dnl
__{}__{}define({__JMP_CODE},{dnl
__{}__{}  if ((($1) & 0x8000) = 0x8000)
__{}__{}ifelse(__IS_NAME($8),1,
__{}__{}{    jp   nc{,} format({%-11s},$8); 3:10      __INFO   positive d1 < negative constant --> false},
__{}__{}{    jr   nc{,} format({%-11s},$+eval($8+14)); 2:7/12    __INFO   positive d1 < negative constant --> false})
__{}__{}  else
__{}__{}ifelse(__IS_NAME($6),1,
__{}__{}{    jp    c{,} format({%-11s},$6); 3:10      __INFO   negative d1 < positive constant --> true},
__{}__{}{    jr    c{,} format({%-11s},$+eval($6+14)); 2:7/12    __INFO   negative d1 < positive constant --> true})
__{}__{}  endif}){}dnl
__{}}){}dnl
__{}ifelse($3,{},,{
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS/__JMP_CLOCK])__INFO   {$3}})
__{}    ld    A{,} D          ; 1:4       __INFO
__{}    add   A{,} A          ; 1:4       __INFO
__{}__JMP_CODE{}dnl
__{}ifelse(__IS_NUM($2),1,{
__{}__{}    ld    A{,} L          ; 1:4       __INFO   HL < __HEX_HL($2)
__{}__{}    sub   __HEX_L($2)          ; 2:7       __INFO    L -   __HEX_L($2) < 0 --> carry if true
__{}__{}    ld    A{,} H          ; 1:4       __INFO   HL < __HEX_HL($2)
__{}__{}    sbc   A{,} __HEX_H($2)       ; 2:7       __INFO   H  - __HEX_H($2)   < 0 --> carry if true},
__{}{
__{}__{}    ld    A{,} L          ; 1:4       __INFO   HL < $2
__{}__{}    sub  format({%-15s},low $2); 2:7       __INFO   HL - $2 < 0 --> carry if true
__{}__{}    ld    A{,} H          ; 1:4       __INFO   HL < $2
__{}__{}    sbc   A{,} format({%-11s},high $2); 2:7       __INFO   HL - $2 < 0 --> carry if true}){}dnl
__{}ifelse(__IS_NUM($1),1,{
__{}__{}    ld    A{,} E          ; 1:4       __INFO   DE < __HEX_HL($1)
__{}__{}    sbc   A{,} __HEX_L($1)       ; 2:7       __INFO    E -   __HEX_L($1) < 0 --> carry if true
__{}__{}    ld    A{,} D          ; 1:4       __INFO   DE < __HEX_HL($1)
__{}__{}    sbc   A{,} __HEX_H($1)       ; 2:7       __INFO   D  - __HEX_H($1)   < 0 --> carry if true},
__{}{
__{}__{}    ld    A{,} E          ; 1:4       __INFO   DE < $1
__{}__{}    sbc   A{,} format({%-11s},low $1); 2:7       __INFO   DE - $1 < 0 --> carry if true
__{}__{}    ld    A{,} D          ; 1:4       __INFO   DE < $1
__{}__{}    sbc   A{,} format({%-11s},high $1); 2:7       __INFO   DE - $1 < 0 --> carry if true})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #    __INFO
dnl #    $1 ...hi16
dnl #    $2 ...lo16
dnl #    $3 ...head info
dnl #    $4 ...+bytes    after code
dnl #    $5 ...+clocks   after code
dnl #    $6 ...+-bytes   carry jump     if (number) jr else if (name) jp
dnl #    $7 ...+-clocks  carry jump
dnl #    $8 ...+-bytes   no carry jump  if (number) jr else if (name) jp
dnl #    $9 ...+-clocks  no carry jump
dnl # Output:
dnl #    print code
dnl # Pollutes:
dnl #    AF, BC
dnl # Use:
dnl #    __MAKE_CODE_DGT_SET_CARRY(hi16,lo16,{( d -- d)  if d > num32},3,10,3,-10,)
dnl #    jp   nc, else_xxx   ; 3:10      __INFO
define({__MAKE_CODE_DGT_SET_CARRY},{dnl
ifelse(dnl
__IS_MEM_REF($1):__IS_MEM_REF($2),1:1,{dnl
__{}__SET_BYTES_CLOCKS_PRICES($4+12,$5+48){}dnl
__{}define({_TMP_INFO},__INFO{   ..BC = $2}){}dnl
__{}__LD_REG16(BC,$1,BC,$2){}dnl
__{}__LD_REG16(BC,$2){}dnl
__{}ifelse($3,{},,{
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS])__INFO   {$3}}){}dnl
__{}__CODE_16BIT
__{}    ld    A{,} C          ; 1:4       __INFO   ..HL > ..BC
__{}    sub   L             ; 1:4       __INFO      0 > ...C - ...L --> carry if true
__{}    ld    A{,} B          ; 1:4       __INFO
__{}    sbc   A{,} H          ; 1:4       __INFO      0 > ..B. - ..H. --> carry if true{}define({_TMP_INFO},__INFO{   BC.. = $1}){}__LD_REG16(BC,$1,BC,$2){}__CODE_16BIT
__{}    ld    A{,} C          ; 1:4       __INFO   DE.. > BC..
__{}    sbc   A{,} E          ; 1:4       __INFO      0 > .E.. - .C.. --> carry if true
__{}    ld    A{,} B          ; 1:4       __INFO
__{}    sbc   A{,} D          ; 1:4       __INFO      0 > B... - D... --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO
__{}    xor   B             ; 1:4       __INFO
__{}    add   A{,} A          ; 1:4       __INFO   --> carry if true},
__IS_MEM_REF($1):__IS_MEM_REF($2),1:0,{dnl
__{}__SET_BYTES_CLOCKS_PRICES(18+$4,74+$5){}dnl
__{}ifelse($3,{},,{
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS])__INFO   {$3}})
__{}    ld   format({%-15s},low $2); 2:7       __INFO   ...L > lo($2)
__{}    sub   L             ; 1:4       __INFO      0 > ...A - ...L --> carry if true
__{}    ld    A{,} format({%-11s},high $2); 2:7       __INFO   ..H. > hi($2)
__{}    sbc   A{,} H          ; 1:4       __INFO      0 > ..A. - ..H. --> carry if true
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO   BC.. = $1
__{}    ld    A{,} C          ; 1:4       __INFO   DE.. > BC..
__{}    sbc   A{,} E          ; 1:4       __INFO      0 > .E.. - .C.. --> carry if true
__{}    ld    A{,} B          ; 1:4       __INFO
__{}    sbc   A{,} D          ; 1:4       __INFO      0 > B... - D... --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO
__{}    xor   B             ; 1:4       __INFO
__{}    add   A{,} A          ; 1:4       __INFO   --> carry if true},
__HEX_H(0x8000 & ($1)):__IS_MEM_REF($2),0x00:1,{dnl
__{}__SET_BYTES_CLOCKS_PRICES(17+$4,70+$5){}dnl
__{}ifelse($3,{},,{
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS])__INFO   {$3}})
__{}    ld   BC{,}format({%-12s},$2); 4:20      __INFO   ..BC = $2
__{}    ld    A{,} C          ; 1:4       __INFO   ..HL > ..BC
__{}    sub   L             ; 1:4       __INFO      0 > ...C - ...L --> carry if true
__{}    ld    A{,} B          ; 1:4       __INFO
__{}    sbc   A{,} H          ; 1:4       __INFO      0 > ..B. - ..H. --> carry if true
__{}    ld    A{,} format({%-11s},low $1); 2:7       __INFO   ...L > lo($1)
__{}    sbc   A{,} E          ; 1:4       __INFO      0 > .E.. - .C.. --> carry if true
__{}    ld    A{,} format({%-11s},high $1); 2:7       __INFO   ..H. > hi($1)
__{}    sbc   A{,} D          ; 1:4       __INFO      0 > B... - D... --> carry if true
__{}    rra                 ; 1:4       __INFO   --> sign  if true
__{}    xor   D             ; 1:4       __INFO
__{}    add   A{,} A          ; 1:4       __INFO   --> carry if true},
__IS_MEM_REF($1):__IS_MEM_REF($2),0:1,{dnl
__{}__SET_BYTES_CLOCKS_PRICES($4+17,$5+67){}dnl
__{}ifelse(__HEX_H(0x8000 & ($1)),0x80,{dnl
__{}__{}ifelse(__IS_NAME($6),1,
__{}__{}{__add({__SUM_BYTES},3){}__add({__SUM_CLOCKS},10){}define({__JMP_CLOCK},eval($7+4+7+10)){}define({__JMP_CODE},{    jp    c{,} format({%-11s},$6); 3:10      __INFO   positive d1 > negative constant --> true})},
__{}__{}{__add({__SUM_BYTES},2){}__add({__SUM_CLOCKS}, 7){}define({__JMP_CLOCK},eval($7+4+7+12)){}define({__JMP_CODE},{    jr    c{,} format({%-11s},$+eval($6+14)); 2:7/12    __INFO   positive d1 > negative constant --> true})}){}dnl
__{}},
__{}__HEX_H(0x8000 & ($1)),0x00,{dnl
__{}__{}ifelse(__IS_NAME($8),1,
__{}__{}{__add({__SUM_BYTES},3){}__add({__SUM_CLOCKS},10){}define({__JMP_CLOCK},eval($9+4+7+10)){}define({__JMP_CODE},{    jp   nc{,} format({%-11s},$8); 3:10      __INFO   negative d1 > positive constant --> false})},
__{}__{}{__add({__SUM_BYTES},2){}__add({__SUM_CLOCKS}, 7){}define({__JMP_CLOCK},eval($9+4+7+12)){}define({__JMP_CODE},{    jr   nc{,} format({%-11s},$+eval($8+14)); 2:7/12    __INFO   negative d1 > positive constant --> false})}){}dnl
__{}},{dnl
__{}__{}ifelse(__IS_NAME($6),1,
__{}__{}{__add({__SUM_BYTES},3){}__add({__SUM_CLOCKS},10){}define({__JMP_CLOCK},eval($7+4+7+10))},
__{}__{}{__add({__SUM_BYTES},2){}__add({__SUM_CLOCKS}, 7){}define({__JMP_CLOCK},eval($7+4+7+10))}){}dnl
__{}__{}define({__JMP_CODE},{dnl
__{}__{}  if ((($1) & 0x8000) = 0x8000)
__{}__{}ifelse(__IS_NAME($6),1,
__{}__{}{    jp    c{,} format({%-11s},$6); 3:10      __INFO   positive d1 > negative constant --> true},
__{}__{}{    jr    c{,} format({%-11s},$+eval($6+14)); 2:7/12    __INFO   positive d1 > negative constant --> true})
__{}__{}  else
__{}__{}ifelse(__IS_NAME($8),1,
__{}__{}{    jp   nc{,} format({%-11s},$8); 3:10      __INFO   negative d1 > positive constant --> false},
__{}__{}{    jr   nc{,} format({%-11s},$+eval($8+14)); 2:7/12    __INFO   negative d1 > positive constant --> false})
__{}__{}  endif}){}dnl
__{}}){}dnl
__{}ifelse($3,{},,{
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS/__JMP_CLOCK])__INFO   {$3}})
__{}    ld    A{,} D          ; 1:4       __INFO
__{}    sub  0x80           ; 2:7       __INFO
__{}__JMP_CODE
__{}    ld    A{,} format({%-11s},$2); 3:13      __INFO   HL > $2
__{}    sub   L             ; 1:4       __INFO    0 > lo($2) - L --> carry if true
__{}    ld    A{,} format({%-11s},(1+$2)); 3:13      __INFO   HL > $2
__{}    sbc   A{,} H          ; 1:4       __INFO    0 > hi($2) - H --> carry if true{}dnl
__{}ifelse(__IS_NUM($1),1,{
__{}__{}    ld    A{,} __HEX_L($1)       ; 2:7       __INFO   DE > __HEX_HL($1)
__{}__{}    sbc   A{,} E          ; 1:4       __INFO    0 >   __HEX_L($1) - E --> carry if true
__{}__{}    ld    A{,} __HEX_H($1)       ; 2:7       __INFO   DE > __HEX_HL($1)
__{}__{}    sbc   A{,} D          ; 1:4       __INFO    0 > __HEX_H($1)   - D --> carry if true},
__{}{
__{}__{}    ld    A{,} format({%-11s},low $1); 2:7       __INFO   DE > $1
__{}__{}    sbc   A{,} E          ; 1:4       __INFO    0 > lo($1) - E --> carry if true
__{}__{}    ld    A{,} format({%-11s},high $1); 2:7       __INFO   DE > $1
__{}__{}    sbc   A{,} D          ; 1:4       __INFO    0 > hi($1) - D --> carry if true})},
{dnl
__{}__SET_BYTES_CLOCKS_PRICES($4+15,$5+55){}dnl
__{}ifelse(__HEX_H(0x8000 & ($1)),0x80,{dnl
__{}__{}ifelse(__IS_NAME($6),1,
__{}__{}{__add({__SUM_BYTES},3){}__add({__SUM_CLOCKS},10){}define({__JMP_CLOCK},eval($7+4+7+10)){}define({__JMP_CODE},{    jp    c{,} format({%-11s},$6); 3:10      __INFO   positive d1 > negative constant --> true})},
__{}__{}{__add({__SUM_BYTES},2){}__add({__SUM_CLOCKS}, 7){}define({__JMP_CLOCK},eval($7+4+7+12)){}define({__JMP_CODE},{    jr    c{,} format({%-11s},$+eval($6+14)); 2:7/12    __INFO   positive d1 > negative constant --> true})}){}dnl
__{}},
__{}__HEX_H(0x8000 & ($1)),0x00,{dnl
__{}__{}ifelse(__IS_NAME($8),1,
__{}__{}{__add({__SUM_BYTES},3){}__add({__SUM_CLOCKS},10){}define({__JMP_CLOCK},eval($9+4+7+10)){}define({__JMP_CODE},{    jp   nc{,} format({%-11s},$8); 3:10      __INFO   negative d1 > positive constant --> false})},
__{}__{}{__add({__SUM_BYTES},2){}__add({__SUM_CLOCKS}, 7){}define({__JMP_CLOCK},eval($9+4+7+12)){}define({__JMP_CODE},{    jr   nc{,} format({%-11s},$+eval($8+14)); 2:7/12    __INFO   negative d1 > positive constant --> false})}){}dnl
__{}},{dnl
__{}__{}ifelse(__IS_NAME($6),1,
__{}__{}{__add({__SUM_BYTES},3){}__add({__SUM_CLOCKS},10){}define({__JMP_CLOCK},eval($7+4+7+10))},
__{}__{}{__add({__SUM_BYTES},2){}__add({__SUM_CLOCKS}, 7){}define({__JMP_CLOCK},eval($7+4+7+10))}){}dnl
__{}__{}define({__JMP_CODE},{dnl
__{}__{}  if ((($1) & 0x8000) = 0x8000)
__{}__{}ifelse(__IS_NAME($6),1,
__{}__{}{    jp    c{,} format({%-11s},$6); 3:10      __INFO   positive d1 > negative constant --> true},
__{}__{}{    jr    c{,} format({%-11s},$+eval($6+14)); 2:7/12    __INFO   positive d1 > negative constant --> true})
__{}__{}  else
__{}__{}ifelse(__IS_NAME($8),1,
__{}__{}{    jp   nc{,} format({%-11s},$8); 3:10      __INFO   negative d1 > positive constant --> false},
__{}__{}{    jr   nc{,} format({%-11s},$+eval($8+14)); 2:7/12    __INFO   negative d1 > positive constant --> false})
__{}__{}  endif}){}dnl
__{}}){}dnl
__{}ifelse($3,{},,{
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS/__JMP_CLOCK])__INFO   {$3}})
__{}    ld    A{,} D          ; 1:4       __INFO
__{}    sub  0x80           ; 2:7       __INFO
__{}__JMP_CODE{}dnl
__{}ifelse(__IS_NUM($2),1,{
__{}__{}    ld    A{,} __HEX_L($2)       ; 2:7       __INFO   HL > __HEX_HL($2)
__{}__{}    sub   L             ; 1:4       __INFO    0 >   __HEX_L($2) - L --> carry if true
__{}__{}    ld    A{,} __HEX_H($2)       ; 2:7       __INFO   HL > __HEX_HL($2)
__{}__{}    sbc   A{,} H          ; 1:4       __INFO    0 > __HEX_H($2)   - H --> carry if true},
__{}{
__{}__{}    ld    A{,} format({%-11s},low $2); 2:7       __INFO   HL > $2
__{}__{}    sub   L             ; 1:4       __INFO    0 > lo($2) - L --> carry if true
__{}__{}    ld    A{,} format({%-11s},high $2); 2:7       __INFO   HL > $2
__{}__{}    sbc   A{,} H          ; 1:4       __INFO    0 > hi($2) - H --> carry if true}){}dnl
__{}ifelse(__IS_NUM($1),1,{
__{}__{}    ld    A{,} __HEX_L($1)       ; 2:7       __INFO   DE > __HEX_HL($1)
__{}__{}    sbc   A{,} E          ; 1:4       __INFO    0 >   __HEX_L($1) - E --> carry if true
__{}__{}    ld    A{,} __HEX_H($1)       ; 2:7       __INFO   DE > __HEX_HL($1)
__{}__{}    sbc   A{,} D          ; 1:4       __INFO    0 > __HEX_H($1)   - D --> carry if true},
__{}{
__{}__{}    ld    A{,} format({%-11s},low $1); 2:7       __INFO   DE > $1
__{}__{}    sbc   A{,} E          ; 1:4       __INFO    0 > lo($1) - E --> carry if true
__{}__{}    ld    A{,} format({%-11s},high $1); 2:7       __INFO   DE > $1
__{}__{}    sbc   A{,} D          ; 1:4       __INFO    0 > hi($1) - D --> carry if true})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # Input:
dnl #    $1 ...hi16
dnl #    $2 ...lo16
dnl #    $3 ...head info
dnl #    $4 ...+bytes    after code
dnl #    $5 ...+clocks   after code
dnl #    $6 ...+-bytes   no zero jump   if (number) jr else if (name) jp
dnl #    $7 ...+-clocks  no zero jump
dnl #    $8 ...+-bytes   zero jump      if (number) jr else if (name) jp
dnl #    $9 ...+-clocks  zero jump
dnl # Output:
dnl #    print code
dnl #    z = 1 if DEHL =  $1$2
dnl #    z = 0 if DEHL <> $1$2, but A can by zero!
dnl # Pollutes:
dnl #    AF,BC
define({__MAKE_CODE_DEQ_SET_ZERO},{dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):__HEX_HL(0+$1-$2):__IS_NAME($6),1:1:0x0002:0,{dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+20,$5+93){}dnl
__{}__{}format({%35s},;[__SUM_BYTES:__SUM_CLOCKS/eval($7+eval($5+0)+33){,}eval($7+eval($5+0)+57){,}eval($7+eval($5+0)+81)]) __INFO   {$3}
__{}__{}    ld   BC{,} __HEX_HL(0+$2)     ; 3:10      __INFO
__{}__{}    ld    A{,}(BC)        ; 1:7       __INFO
__{}__{}    cp    L             ; 1:4       __INFO   ...L = (BC) = $2
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+15)); 2:7/12    __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld    A{,}(BC)        ; 1:7       __INFO
__{}__{}    cp    H             ; 1:4       __INFO   ..H. = (BC) = (__HEX_HL(1+$2))
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+10)); 2:7/12    __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld    A{,}(BC)        ; 1:7       __INFO
__{}__{}    cp    E             ; 1:4       __INFO   .E.. = (BC) = $1
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+5)); 2:7/12    __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld    A{,}(BC)        ; 1:7       __INFO
__{}__{}    cp    D             ; 1:4       __INFO   D... = (BC) = (__HEX_HL(1+$1))},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):__IS_NAME($6),1:1:1,{dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+21,$5+100){}dnl
__{}__{}format({%35s},;[__SUM_BYTES:__SUM_CLOCKS/eval($7+eval($5+0)+27){,}eval($7+eval($5+0)+83)]) __INFO   {$3}
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld   BC{,}format({%-12s},$2); 4:20      __INFO   ..BC = $2
__{}__{}    sbc  HL{,} BC         ; 2:15      __INFO   cp HL{,} BC
__{}__{}    add  HL{,} BC         ; 1:11      __INFO   cp HL{,} BC
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld    A{,}format({%-12s},$1); 3:13      __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),1:1,{dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+19,$5+94){}dnl
__{}__{}format({%35s},;[__SUM_BYTES:__SUM_CLOCKS/eval($7+eval($5+0)+29){,}eval($7+eval($5+0)+82)]) __INFO   {$3}
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+15)); 2:7/12    __INFO
__{}__{}    ld   BC{,}format({%-12s},$2); 4:20      __INFO   ..BC = $2
__{}__{}    sbc  HL{,} BC         ; 2:15      __INFO   cp HL{,} BC
__{}__{}    add  HL{,} BC         ; 1:11      __INFO   cp HL{,} BC
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+6)); 2:7/12    __INFO
__{}__{}    ld    A{,}format({%-12s},$1); 3:13      __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)},
__{}__IS_MEM_REF($2):__IS_NAME($6),1:1,{dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+19,$5+88){}dnl
__{}__{}format({%35s},;[__SUM_BYTES:__SUM_CLOCKS/eval($7+eval($5+0)+21){,}eval($7+eval($5+0)+77)]) __INFO   {$3}
__{}__{}    ld    A{,} format({%-11s},high $1); 2:7       __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld   BC{,}format({%-12s},$2); 4:20      __INFO   ..BC = $2
__{}__{}    sbc  HL{,} BC         ; 2:15      __INFO   cp HL{,} BC
__{}__{}    add  HL{,} BC         ; 1:11      __INFO   cp HL{,} BC
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld    A{,} format({%-11s},low $1); 2:7       __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)},
__{}__IS_MEM_REF($2),1,{dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+17,$5+82){}dnl
__{}__{}format({%35s},;[__SUM_BYTES:__SUM_CLOCKS/eval($7+eval($5+0)+23){,}eval($7+eval($5+0)+76)]) __INFO   {$3}
__{}__{}    ld    A{,} format({%-11s},high $1); 2:7       __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+14)); 2:7/12    __INFO
__{}__{}    ld   BC{,}format({%-12s},$2); 4:20      __INFO   ..BC = $2
__{}__{}    sbc  HL{,} BC         ; 2:15      __INFO   cp HL{,} BC
__{}__{}    add  HL{,} BC         ; 1:11      __INFO   cp HL{,} BC
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+5)); 2:7/12    __INFO
__{}__{}    ld    A{,} format({%-11s},low $1); 2:7       __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)},
__{}__IS_MEM_REF($1):__IS_NAME($6),1:1,{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},{__INFO   {$3}}){}dnl
__{}__{}__EQ_MAKE_BEST_CODE($2,3,eval($7+10),,){}dnl
__{}__{}_TMP_BEST_CODE
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+11,$5+44){}dnl
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS/eval($7+27)])__INFO   {$3}
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld    A{,}format({%-12s},$1); 3:13      __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)},
__{}__IS_MEM_REF($1):__IS_NAME($6),1:1,{dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+20,$5+90){}dnl
__{}__{}format({%28s},;[__SUM_BYTES:)format({%-8s},__SUM_CLOCKS/eval($7+eval($5+0)+27){,}eval($7+eval($5+0)+73)])__INFO   {$3}
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld   BC{,} format({%-11s},$2); 3:10      __INFO
__{}__{}    sbc  HL{,} BC         ; 2:15      __INFO   ..HL = $2
__{}__{}    add  HL{,} BC         ; 1:11      __INFO   cp HL, BC
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld    A{,}format({%-12s},$1); 3:13      __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)},
__{}__IS_MEM_REF($1):__IS_NAME($6),1:1,{dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+23,$5+86){}dnl
__{}__{}format({%35s},;[__SUM_BYTES:__SUM_CLOCKS/eval($7+eval($5+0)+21){,}eval($7+eval($5+0)+42){,}eval($7+eval($5+0)+69)]) __INFO   {$3}
__{}__{}    ld    A{,} format({%-11s},low $2); 2:7       __INFO
__{}__{}    xor   L             ; 1:4       __INFO   ...L = lo($2)
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld    A{,} format({%-11s},high $2); 2:7       __INFO
__{}__{}    xor   H             ; 1:4       __INFO   ..L. = hi($2)
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld    A{,}format({%-12s},$1); 3:13      __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)
__{}__{}    jp   nz{,} format({%-11s},$6); 3:10      __INFO
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)},
__{}__IS_MEM_REF($1),1,{dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+20,$5+77){}dnl
__{}__{}format({%35s},;[__SUM_BYTES:__SUM_CLOCKS/eval($7+eval($5+0)+23){,}eval($7+eval($5+0)+41){,}eval($7+eval($5+0)+65)]) __INFO   {$3}
__{}__{}    ld    A{,} format({%-11s},low $2); 2:7       __INFO
__{}__{}    xor   L             ; 1:4       __INFO   ...L = lo($2)
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+17)); 2:7/12    __INFO
__{}__{}    ld    A{,} format({%-11s},high $2); 2:7       __INFO
__{}__{}    xor   H             ; 1:4       __INFO   ..L. = hi($2)
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+12)); 2:7/12    __INFO
__{}__{}    ld    A{,}format({%-12s},$1); 3:13      __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)
__{}__{}    jr   nz{,} format({%-11s},$+eval($6+6)); 2:7/12    __INFO
__{}__{}    ld    A{,}format({%-12s},(1+$1)); 3:13      __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)},
__{}__IS_NUM($1):__IS_NUM($2),1:1,{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},{ __INFO   {$3}}){}dnl
__{}__{}__DEQ_MAKE_BEST_CODE(eval((__HEX_HL($1)<<16)+__HEX_HL($2)),$4,$5,$6,$7){}dnl
__{}__{}_TMP_BEST_CODE},
__{}__IS_NUM($2),1,{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},{__INFO   {$3}}){}dnl
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
__{}__{}__EQ_MAKE_BEST_CODE($2,eval($4+10),eval($5+36),eval($6+10),eval($7-36)){}dnl
__{}__{}_TMP_BEST_CODE
__{}__{}    jr   nz{,} $+format({%-9s},eval($6+10)); 2:7/12    __INFO
__{}__{}    ld    A{,} format({%-11s},low $1); 2:7       __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)
__{}__{}    jr   nz{,} $+format({%-9s},eval($6+5)); 2:7/12    __INFO
__{}__{}    ld    A{,} format({%-11s},high $1); 2:7       __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)},
__{}__IS_NUM($1),1,{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}define({_TMP_STACK_INFO},{__INFO   {$3}}){}dnl
__{}__{}__EQ_MAKE_CODE({DE},$1,$4,$5,$6,$7)
__{}__{}format({%36s},;[eval(__EQ_BYTES+10):eval(__EQ_CLOCKS_TRUE+36)/eval($7+23){,}eval($7+41){}ifelse(_TMP_J1,__EQ_CLOCKS_TRUE,,{{,}}eval(36+_TMP_J1))] ){}__INFO
__{}__{}    ld    A{,} format({%-11s},low $2); 2:7       __INFO
__{}__{}    xor   L             ; 1:4       __INFO   ...L = lo($2)
__{}__{}    jr   nz{,} $+format({%-9s},eval($6+7+__EQ_BYTES-($4+0))); 2:7/12    __INFO
__{}__{}    ld    A{,} format({%-11s},high $2); 2:7       __INFO
__{}__{}    xor   H             ; 1:4       __INFO   ..H. = hi($2)
__{}__{}    jr   nz{,} $+format({%-9s},eval($6+2+__EQ_BYTES-($4+0))); 2:7/12    __INFO
__{}__{}__EQ_CODE},
__{}{dnl
__{}__{}__SET_BYTES_CLOCKS_PRICES($4+18,$5+65){}dnl
__{}__{}format({%35s},;[__SUM_BYTES:__SUM_CLOCKS/eval($7+eval($5+0)+23){,}eval($7+eval($5+0)+41){,}eval($7+eval($5+0)+59)]) __INFO   {$3}
__{}__{}    ld    A{,} format({%-11s},low $2); 2:7       __INFO   default version
__{}__{}    xor   L             ; 1:4       __INFO   ...L = lo($2)
__{}__{}    jr   nz{,} $+format({%-9s},eval($6+15)); 2:7/12    __INFO
__{}__{}    ld    A{,} format({%-11s},high $2); 2:7       __INFO
__{}__{}    xor   H             ; 1:4       __INFO   ..H. = hi($2)
__{}__{}    jr   nz{,} $+format({%-9s},eval($6+10)); 2:7/12    __INFO
__{}__{}    ld    A{,} format({%-11s},low $1); 2:7       __INFO
__{}__{}    xor   E             ; 1:4       __INFO   .E.. = lo($1)
__{}__{}    jr   nz{,} $+format({%-9s},eval($6+5)); 2:7/12    __INFO
__{}__{}    ld    A{,} format({%-11s},high $1); 2:7       __INFO
__{}__{}    xor   D             ; 1:4       __INFO   D... = hi($1)}){}dnl
}){}dnl
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
dnl #    INPUT  OUTPUT
dnl #
dnl #        5  b_0101
dnl #        7  b_0111
dnl #       20  b_0001_0100
dnl #    0x321  b_0011_0010_0001
dnl #       -1  b_1111_1111_1111_1111
dnl #     8-16  b_1111_1111_1111_1111
dnl #      abc  b_????_????_????_????
dnl # (0x8000)  b_????_????_????_????
dnl #
define({PRINT_BINARY},{dnl
__{}ifelse(__IS_NUM($1),0,{b_????_????_????_????},
__{}{dnl
__{}__{}define({TEMP_BIN},__HEX_HL($1)){}dnl
__{}__{}define({TEMP_BIN_OUT},{}){}dnl
__{}__{}PRINT_NIBBLE{}dnl
__{}__{}b{}TEMP_BIN_OUT{}dnl
__{}}){}dnl
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
