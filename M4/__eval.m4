define({__},{})dnl
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
dnl # Input: input can only be numbers or constants. Not a pointer.
dnl #    operation num_1 num_2
dnl #    operation num_1 num_2 num_3
dnl # Output:
dnl #    eval(            (num_1) operation (num_2))
dnl #    eval(((num_3)<<16+num_1) operation (num_2))
define({__EVAL_OP_NUM_XXX_PASMO},{dnl
__{}define({$0_EXPRESION_A},__SIMPLIFY_EXPRESSION({$2})){}dnl
__{}define({$0_EXPRESION_B},__SIMPLIFY_EXPRESSION({$3})){}dnl
__{}define({$0_EXPRESION_C},__SIMPLIFY_EXPRESSION({$4})){}dnl
__{}ifelse(__IS_MEM_REF($0_EXPRESION_A):__IS_NUM($0_EXPRESION_A):__IS_NAME($0_EXPRESION_A),0:0:0,{define({__TEMP_A},($0_EXPRESION_A))},{define({__TEMP_A},$0_EXPRESION_A)}){}dnl
__{}ifelse(__IS_MEM_REF($0_EXPRESION_B):__IS_NUM($0_EXPRESION_B):__IS_NAME($0_EXPRESION_B),0:0:0,{define({__TEMP_B},($0_EXPRESION_B))},{define({__TEMP_B},$0_EXPRESION_B)}){}dnl
__{}ifelse(__IS_MEM_REF($0_EXPRESION_C):__IS_NUM($0_EXPRESION_C):__IS_NAME($0_EXPRESION_C),0:0:0,{define({__TEMP_C},($0_EXPRESION_C))},{define({__TEMP_C},$0_EXPRESION_C)}){}dnl
__{}ifelse(__HEX_HL($2),{},{define({__TEMP_LO_A},{(low($2))})},{define({__TEMP_LO_A},{eval(($2)&0xFF)})}){}dnl
__{}ifelse(__HEX_HL($3),{},{define({__TEMP_LO_B},{(low($3))})},{define({__TEMP_LO_B},{eval(($3)&0xFF)})}){}dnl
__{}ifelse(__HEX_HL($2),{},{define({__TEMP_HI_A},{(($2)>>8)})},{define({__TEMP_HI_A},{eval((($2)>>8)&0xFF)})}){}dnl
__{}ifelse(__HEX_HL($3),{},{define({__TEMP_HI_B},{(($3)>>8)})},{define({__TEMP_HI_B},{eval((($3)>>8)&0xFF)})}){}dnl
__{}ifelse(__HEX_HL($2),{},{define({__TEMP_SIGN_A},{(($2)>>15)})},{define({__TEMP_SIGN_A},{eval((($2)>>15)&0x01)})}){}dnl
__{}ifelse(__HEX_HL($3),{},{define({__TEMP_SIGN_B},{(($3)>>15)})},{define({__TEMP_SIGN_B},{eval((($3)>>15)&0x01)})}){}dnl
__{}ifelse(__HEX_HL($4),{},{define({__TEMP_SIGN_C},{(($4)>>15)})},{define({__TEMP_SIGN_C},{eval((($4)>>15)&0x01)})}){}dnl
ifelse(1,0,{errprint({
__eval_op_num_xxx_pasmo($@) a:}__TEMP_A{ b:}__TEMP_B{ c:}__TEMP_C{
})}){}dnl
__{}ifelse(dnl
__{}__{}$1:__TEMP_A,      {=:}__TEMP_B, {0xFFFF},
__{}__{}$1:__TEMP_A,     {<>:}__TEMP_B, {0},

__{}__{}$1:__IS_NUM($2),  {=:1}, {__TEMP_A=__TEMP_B},
__{}__{}$1:__IS_NUM($2), {<>:1}, {__TEMP_A!=__TEMP_B},
__{}__{}$1:__IS_NUM($2), {<=:1}, {__HEX_HL($2+0x8000)<=(($3)+0x8000)},
__{}__{}$1:__IS_NUM($2),  {<:1}, {__HEX_HL($2+0x8000)<(($3)+0x8000)},
__{}__{}$1:__IS_NUM($2), {>=:1}, {__HEX_HL($2+0x8000)>=(($3)+0x8000)},
__{}__{}$1:__IS_NUM($2),  {>:1}, {__HEX_HL($2+0x8000)>(($3)+0x8000)},

dnl # A >  B --> B  <  A
dnl # A >= B --> B <= A
...,,,

__{}__{}$1:__IS_NUM($3),  {=:1}, {__TEMP_B=__TEMP_A},
__{}__{}$1:__IS_NUM($3), {<>:1}, {__TEMP_B!=__TEMP_A},
__{}__{}$1:__IS_NUM($3),  {<:1}, {__HEX_HL($3+0x8000)>(($2)+0x8000)},
__{}__{}$1:__IS_NUM($3), {<=:1}, {__HEX_HL($3+0x8000)>=(($2)+0x8000)},
__{}__{}$1:__IS_NUM($3), {>=:1}, {__HEX_HL($3+0x8000)<=(($2)+0x8000)},
__{}__{}$1:__IS_NUM($3),  {>:1}, {__HEX_HL($3+0x8000)<(($2)+0x8000)},

__{}__{}$1,               {=},   {+__TEMP_A=__TEMP_B},
__{}__{}$1,              {<>},   {+__TEMP_A!=__TEMP_B},
__{}__{}$1,               {<},   {+(($2)+0x8000)<(($3)+0x8000)},
__{}__{}$1,              {<=},   {+(($2)+0x8000)<=(($3)+0x8000)},
__{}__{}$1,              {>=},   {+(($2)+0x8000)>=(($3)+0x8000)},
__{}__{}$1,               {>},   {+(($2)+0x8000)>(($3)+0x8000)},

__{}__{}$1:__TEMP_A,     {u=:}__TEMP_B, {0xFFFF},
__{}__{}$1:__TEMP_A,    {u<>:}__TEMP_B, {0},

__{}__{}$1:__IS_NUM($2), {u=:1}, {__TEMP_A=__TEMP_B},
__{}__{}$1:__IS_NUM($2),{u<>:1}, {__TEMP_A!=__TEMP_B},
__{}__{}$1:__IS_NUM($2), {u<:1}, {__HEX_HL($2)<($3)},
__{}__{}$1:__IS_NUM($2),{u<=:1}, {__HEX_HL($2)<=($3)},
__{}__{}$1:__IS_NUM($2),{u>=:1}, {__HEX_HL($2)>=($3)},
__{}__{}$1:__IS_NUM($2), {u>:1}, {__HEX_HL($2)>($3)},

__{}__{}$1:__IS_NUM($3), {u=:1}, {__TEMP_B=__TEMP_A},
__{}__{}$1:__IS_NUM($3),{u<>:1}, {__TEMP_B!=__TEMP_A},
__{}__{}$1:__IS_NUM($3), {u<:1}, {__HEX_HL($3)>($2)},
__{}__{}$1:__IS_NUM($3),{u<=:1}, {__HEX_HL($3)>=($2)},
__{}__{}$1:__IS_NUM($3),{u>=:1}, {__HEX_HL($3)<=($2)},
__{}__{}$1:__IS_NUM($3), {u>:1}, {__HEX_HL($3)<($2)},

__{}__{}$1,              {u=},   {+__TEMP_A=__TEMP_B},
__{}__{}$1,             {u<>},   {+__TEMP_A!=__TEMP_B},
__{}__{}$1,              {u<},   {+($2)<($3)},
__{}__{}$1,             {u<=},   {+($2)<=($3)},
__{}__{}$1,             {u>=},   {+($2)>=($3)},
__{}__{}$1,              {u>},   {+($2)>($3)},

__{}__{}$1:__IS_NUM($2):__TEMP_A, {&:1:}__TEMP_B, {__TEMP_A},
__{}__{}$1:__TEMP_A,              {&:}__TEMP_B, {$2},

__{}__{}$1:__TEMP_A,     {&:0},    {0},
__{}__{}$1:__TEMP_B,     {&:0},    {0},
__{}__{}$1:__TEMP_A,     {&:65535},{$3},
__{}__{}$1:__TEMP_B,     {&:65535},{$2},
__{}__{}$1:__IS_NUM($2), {&:1},    {__TEMP_A&__TEMP_B},
__{}__{}$1:__IS_NUM($3), {&:1},    {__TEMP_B&__TEMP_A},
__{}__{}$1,              {&},     {+__TEMP_A&__TEMP_B},

__{}__{}$1:__IS_NUM($2):__TEMP_A, {|:1:}__TEMP_B, {__TEMP_A},
__{}__{}$1:__TEMP_A,              {|:}__TEMP_B, {$2},

__{}__{}$1:__TEMP_A,     {|:65535},{65535},
__{}__{}$1:__TEMP_B,     {|:65535},{65535},
__{}__{}$1:__TEMP_A,     {|:0},    {$3},
__{}__{}$1:__TEMP_B,     {|:0},    {$2},
__{}__{}$1:__IS_NUM($2), {|:1},    {__TEMP_A|__TEMP_B},
__{}__{}$1:__IS_NUM($3), {|:1},    {__TEMP_B|__TEMP_A},
__{}__{}$1,              {|},     {+__TEMP_A|__TEMP_B},

__{}__{}$1:__TEMP_A,     {^:}__TEMP_B, {0},

__{}__{}$1:__TEMP_A,     {^:0},    {__TEMP_B},
__{}__{}$1:__TEMP_B,     {^:0},    {__TEMP_A},
__{}__{}$1:__IS_NUM($2), {^:1},    {__TEMP_A^__TEMP_B},
__{}__{}$1:__IS_NUM($3), {^:1},    {__TEMP_B^__TEMP_A},
__{}__{}$1,              {^},     {+__TEMP_A^__TEMP_B},

__{}__{}$1:__TEMP_A,     {*:0},      {0},
__{}__{}$1:__TEMP_B,     {*:0},      {0},
__{}__{}$1:__TEMP_A,     {*:1},      {$3},
__{}__{}$1:__TEMP_B,     {*:1},      {$2},
__{}__{}$1:__TEMP_A,     {*:65535:0},{-($3)},
__{}__{}$1:__TEMP_B,     {*:65535:0},{-($2)},
__{}__{}$1:__IS_NUM($2), {*:1},    {__TEMP_A*__TEMP_B},
__{}__{}$1:__IS_NUM($3), {*:1},    {__TEMP_B*__TEMP_A},
__{}__{}$1,              {*},     {+__TEMP_A*__TEMP_B},

__{}__{}$1:__TEMP_A,     {u*:0},      {0},
__{}__{}$1:__TEMP_B,     {u*:0},      {0},
__{}__{}$1:__TEMP_A,     {u*:1},      {$3},
__{}__{}$1:__TEMP_B,     {u*:1},      {$2},
__{}__{}$1:__IS_NUM($2), {u*:1},    {__TEMP_A*__TEMP_B},
__{}__{}$1:__IS_NUM($3), {u*:1},    {__TEMP_B*__TEMP_A},
__{}__{}$1,              {u*},     {+__TEMP_A*__TEMP_B},

__{}__{}$1:__TEMP_A,                    {+:0},   $0_EXPRESION_B,
__{}__{}$1:__TEMP_B,                    {+:0},   $0_EXPRESION_A,
__{}__{}$1:__IS_MEM_REF($0_EXPRESION_A),{+:0},   {__SIMPLIFY_EXPRESSION($0_EXPRESION_A+$0_EXPRESION_B)},
__{}__{}$1:__IS_MEM_REF($0_EXPRESION_B),{+:0},   {__SIMPLIFY_EXPRESSION($0_EXPRESION_B+$0_EXPRESION_A)},
__{}__{}$1,                             {+},     {__SIMPLIFY_EXPRESSION($0_EXPRESION_A+$0_EXPRESION_B)},

__{}__{}$1:__TEMP_A,                    {u+:0},   $0_EXPRESION_B,
__{}__{}$1:__TEMP_B,                    {u+:0},   $0_EXPRESION_A,
__{}__{}$1:__IS_MEM_REF($0_EXPRESION_A),{u+:0},   {__SIMPLIFY_EXPRESSION($0_EXPRESION_A+$0_EXPRESION_B)},
__{}__{}$1:__IS_MEM_REF($0_EXPRESION_B),{u+:0},   {__SIMPLIFY_EXPRESSION($0_EXPRESION_B+$0_EXPRESION_A)},
__{}__{}$1,                             {u+},     {__SIMPLIFY_EXPRESSION($0_EXPRESION_A+$0_EXPRESION_B)},

__{}__{}$1:__IS_MEM_REF($2):regexp(__TEMP_B,{^[+-]}),  {u+:0:0},   {!! $0_EXPRESION_A__TEMP_B},
__{}__{}$1:__IS_MEM_REF($3):regexp(__TEMP_A,{^[+-]}),  {u+:0:0},   {!! {}$0_EXPRESION_B__TEMP_A},

__{}__{}$1:__IS_MEM_REF($2),            {u+:0},   {$0_EXPRESION_A+__TEMP_B},
__{}__{}$1:__IS_MEM_REF($3),            {u+:0},   {{}$0_EXPRESION_B+__TEMP_A},
__{}__{}$1,                             {u+},    {+__TEMP_A+__TEMP_B},

__{}__{}$1:__TEMP_A,     {-:}__TEMP_B, {0},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {-:0:1}, {__DEC_HL(-($3))},
__{}__{}$1:__TEMP_A,                    {-:0},   {-__TEMP_B},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {-:0:1}, {__TEMP_A},
__{}__{}$1:__TEMP_B,                    {-:0},   {$2},
__{}__{}$1:__IS_NUM($2),                {-:1},   {__TEMP_A-__TEMP_B},
__{}__{}$1,                             {-},    {+__TEMP_A-__TEMP_B},

__{}__{}$1:__TEMP_A,     {u-:}__TEMP_B, {0},

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {u-:0:1}, {__DEC_HL(-($3))},
__{}__{}$1:__TEMP_A,                    {u-:0},   {-__TEMP_B},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {u-:0:1}, {__TEMP_A},
__{}__{}$1:__TEMP_B,                    {u-:0},   {$2},
__{}__{}$1:__IS_NUM($2),                {u-:1},   {__TEMP_A-__TEMP_B},
__{}__{}$1,                             {u-},    {+__TEMP_A-__TEMP_B},

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

__{}__{}$1:__TEMP_A:__IS_NUM(__TEMP_B), {/:0:0},    {0},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {/:1:0},    {$2},
__{}__{}$1:__TEMP_B:__IS_NUM(__TEMP_A), {/:65535:0},{-($2)},
__{}__{}$1:__SAVE_EVAL($2>=0),          {/:1},      {+((~($3))>>15)*__16BIT_TO_ABS($2)/($3)-(($3)>>15)*__16BIT_TO_ABS($2)/(-($3))},
__{}__{}$1:__SAVE_EVAL($2<0),           {/:1},      {+(($3)>>15)*__16BIT_TO_ABS($2)/(-($3))-((~($3))>>15)*__16BIT_TO_ABS($2)/($3)},
__{}__{}$1:__SAVE_EVAL($3>=0),          {/:1},      {+((($2)>>15) xor 1)*($2)/__16BIT_TO_ABS($3)-(($2)>>15)*(-($2))/__16BIT_TO_ABS($3)},
__{}__{}$1:__SAVE_EVAL($3<0),           {/:1},      {+(($2)>>15)*(-($2))/__16BIT_TO_ABS($3)-((~($2))>>15)*($2)/__16BIT_TO_ABS($3)},
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
__{}__{}$1,                             {u/},{+__TEMP_A/__TEMP_B},

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

__{}__{}$1, {m+},{__TEMP_C+__TEMP_SIGN_B*0xFFFF+(__TEMP_HI_A+__TEMP_HI_B+(__TEMP_LO_A+__TEMP_LO_B)>>8)>>8},

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
  .warning Pasmo does not support 32 bit numbers and M4 does not know all values(They can only emulate 28-bit/12-bit or 16-bit/16-bit without checking the range): "}$2<<16+$3 $4 um/mod{"
})},
__{}__{}__{}$1,{sm/rem},{__EVAL_OP_NUM_XXX_PASMO(sm%,$3,$4,$2),__EVAL_OP_NUM_XXX_PASMO(sm/,$3,$4,$2)errprint({
  .warning Pasmo does not support 32 bit numbers and M4 does not know all values(They can only emulate 28-bit/12-bit or 16-bit/16-bit without checking the range): "}$2<<16+$3 $4 sm/rem{"
})},
__{}__{}__{}$1,{fm/mod},{__EVAL_OP_NUM_XXX_PASMO(fm%,$3,$4,$2),__EVAL_OP_NUM_XXX_PASMO(fm/,$3,$4,$2)errprint({
  .warning Pasmo does not support 32 bit numbers and M4 does not know all values(They can only emulate 16-bit/16-bit without checking the range): "}$2<<16+$3 $4 fm/mod{"
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
