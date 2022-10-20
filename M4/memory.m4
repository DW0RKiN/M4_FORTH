dnl ## Memory
dnl
dnl
dnl
define({ALL_VARIABLE},{}){}dnl
define({LAST_HERE_NAME},{VARIABLE_SECTION}){}dnl
define({LAST_HERE_ADD},{0}){}dnl
dnl
dnl
define({CONSTANT},{dnl
__{}__ADD_TOKEN({__TOKEN_CONSTANT},{constant},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CONSTANT},{dnl
__{}define({__INFO},{constant}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}format({%-20s},$1) EQU $2{}dnl
__{}define({$1},{$2})}){}dnl
dnl
dnl
dnl
dnl # VALUE(name)    --> (name) = TOS
define({VALUE},{dnl
__{}__ADD_TOKEN({__TOKEN_VALUE},{value},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_VALUE},{dnl
__{}define({__INFO},{value}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter with variable name!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
{dnl
__{}define({__VALUE_}$1)dnl
__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}pushdef({LAST_HERE_ADD},2)dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}$1: dw 0x0000})
__{}    ld  format({%-16s},{($1), HL}); 3:16      value {$1}
__{}    ex   DE, HL         ; 1:4       value {$1}
__{}    pop  DE             ; 1:10      value {$1}})}){}dnl
dnl
dnl
dnl
define({PUSH_VALUE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_VALUE},{push_value},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_VALUE},{dnl
__{}define({__INFO},{push_value}){}dnl
ifelse($2,{},{
dnl # PUSH_VALUE(100,name)    --> (name) = 100
dnl # PUSH_VALUE(0x2211,name) --> (name) = 0x2211
__{}  .error {$0}(): Missing  parameter with variable name!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($2),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$2}},
__IS_INSTRUCTION($2),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$2}},
$#,{1},{
__{}  .error {$0}(): The second parameter with the initial value is missing!},
{dnl
__{}define({__VALUE_}$2)dnl
__{}pushdef({LAST_HERE_NAME},$2)dnl
__{}pushdef({LAST_HERE_ADD},2)dnl
__{}ifelse(__IS_NUM($1),{0},{
__{}  .warning {$0}($@): M4 does not know $1 parameter value!}){}dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}$2: dw $1})
__{}    ld   BC, format({%-11s},{$1}); 3:10      $1 value {$2}
__{}    ld  format({%-16s},{($2), BC}); 4:20      $1 value {$2}})}){}dnl
dnl
dnl
dnl
define({ALIGN},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
{dnl
__{}__ADD_TOKEN({__TOKEN_ALIGN},{align($1)},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ALIGN},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
{dnl
__{}define({__DVALUE_}$1)dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}; Align to $1-byte page boundary.
__{}__{}__{}; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
__{}__{}__{}DEFS    (($ + $1 - 1) / ($1)) * ($1) - $})
__{}                        ;           __INFO})}){}dnl
dnl
dnl
dnl
define({NO_SEGMENT},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}__ADD_TOKEN({__TOKEN_NO_SEGMENT},{no_segment($1)},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_NO_SEGMENT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
__{}  .error {$0}($@): Parameter is pointer!},
__SAVE_EVAL($1>256),{1},{
__{}  .error {$0}($@): The parameter is greater than 256!},
__SAVE_EVAL($1<0),{1},{
__{}  .error {$0}($@): The parameter is negative!},
{dnl
__{}define({__DVALUE_}$1)dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}; The padding will fill if the following X bytes overflow the 256 byte segment.
__{}__{}__{}; Any use of Allot with a negative value exceeding this address will result in undefined behavior.
__{}__{}__{}if  ((($ + $1 - 1) / 256) != ($/256))
__{}__{}__{}  DEFS    (($/256)+1)*256 - $
__{}__{}__{}endif})
__{}                        ;           __INFO})}){}dnl
dnl
dnl
dnl # DVALUE(name)    --> (name) = TOS,NOS
define({DVALUE},{dnl
__{}__ADD_TOKEN({__TOKEN_DVALUE},{dvalue {$1}},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DVALUE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter with variable name!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
{dnl
__{}define({__DVALUE_}$1)dnl
__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}pushdef({LAST_HERE_ADD},4)dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},{$1:});
__{}__{}__{}    dw 0x0000
__{}__{}__{}    dw 0x0000})
__{}    ld  format({%-16s},{($1), HL}); 3:16      __INFO   lo
__{}    ld  format({%-16s},{($1+2), DE}); 4:20      __INFO   hi
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO})}){}dnl
dnl
dnl
dnl
define({PUSHDOT_DVALUE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_DVALUE},{$1. dvalue {$2}},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_DVALUE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($2,{},{
dnl # PUSHDOT_DVALUE(100000,name)     --> (name) = 100000
dnl # PUSHDOT_DVALUE(0x44332211,name) --> (name) = 0x2211,0x4433
__{}  .error {$0}(): Missing  parameter with variable name!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($2),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$2}},
__IS_INSTRUCTION($2),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$2}},
$#,{1},{
__{}  .error {$0}(): The second parameter with the initial value is missing!},
{dnl
__{}define({__DVALUE_}$2)dnl
__{}pushdef({LAST_HERE_NAME},$2)dnl
__{}pushdef({LAST_HERE_ADD},4)dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($1),{1},{dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},{$2:});
__{}__{}__{}    dw 0x0000
__{}__{}__{}    dw 0x0000})
__{}__{}    ld   BC,format({%-12s},{$1}); 4:20      __INFO   lo
__{}__{}    ld  format({%-16s},{($2), BC}); 4:20      __INFO   lo
__{}__{}    ld   BC,format({%-12s},{(2+$1)}); 4:20      __INFO   hi
__{}__{}    ld  format({%-16s},{($2+2), BC}); 4:20      __INFO   hi},
__{}__IS_NUM($1),{0},{
__{}__{}  .warning {$0}($@): M4 does not know $1 parameter value!},
__{}{dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},{$2:});{}dnl
__{}__{} = ifelse(substr($1,0,2),{0x},eval($1),__HEX_DEHL($1)){}dnl
__{}__{} = db __HEX_L($1) __HEX_H($1) __HEX_E($1) __HEX_D($1)
__{}__{}__{}    dw __HEX_HL($1)
__{}__{}__{}    dw __HEX_DE($1)})
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO   lo
__{}__{}    ld  format({%-16s},{($2), BC}); 4:20      __INFO   lo
__{}__{}    ld   BC, __HEX_DE($1)     ; 3:10      __INFO   hi
__{}__{}    ld  format({%-16s},{($2+2), BC}); 4:20      __INFO   hi})})}){}dnl
dnl
dnl
dnl
define({TO},{dnl
__{}__ADD_TOKEN({__TOKEN_TO},{to},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TO},{dnl
__{}define({__INFO},{to}){}dnl
ifelse({$1},{},{
dnl # TO(name)    --> (name) = TOS
dnl # TO(name)    --> (name) = TOS,NOS
__{}  .error {$0}(): Missing  parameter with variable name!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
ifdef({__VALUE_$1},{1},{0}),{1},{
__{}    ld  format({%-16s},{($1), HL}); 3:16      to {$1}
__{}    pop  HL             ; 1:10      to {$1}
__{}    ex   DE, HL         ; 1:4       to {$1}},
ifdef({__DVALUE_$1},{1},{0}),{1},{
__{}    ld  format({%-16s},{($1), HL}); 3:16      to {$1}   lo
__{}    ex   DE, HL         ; 1:4       to {$1}
__{}    ld  format({%-16s},{($1+2), HL}); 3:16      to {$1}   hi
__{}    pop  HL             ; 1:10      to {$1}
__{}    pop  DE             ; 1:10      to {$1}},
{
__{}  .error {$0}($@): The variable with this name not exist!})}){}dnl
dnl
dnl
dnl
define({PUSH_TO},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_TO},{push_to},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_TO},{dnl
__{}define({__INFO},{push_to}){}dnl
ifelse({$2},{},{
dnl # PUSH_TO(200,name)    --> (name) = 200
dnl # PUSH_TO(0x4422,name) --> (name) = 0x4422
__{}  .error {$0}(): Missing  parameter with variable name!},
ifdef({__VALUE_$2},{1},{0}),{0},{
__{}  .error {$0}($@): The single variable with this name not exist!ifelse(ifdef({__DVALUE_$2},{1},{0}),{1},{ Did you want to write {PUSHDOT_TO}?})},
$#,{1},{
__{}  .error {$0}(): The second parameter with the initial value is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}    ld   BC, format({%-11s},{$1}); 4:20      $1 to {$2}
__{}    ld  format({%-16s},{($2), BC}); 4:20      $1 to {$2}},
{dnl
__{}ifelse(__IS_NUM($1),{0},{
__{}  .warning {$0}($@): M4 does not know $1 parameter value!})
__{}    ld   BC, format({%-11s},{$1}); 3:10      $1 to {$2}
__{}    ld  format({%-16s},{($2), BC}); 4:20      $1 to {$2}{}dnl
})}){}dnl
dnl
dnl
dnl
define({PUSHDOT_TO},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_TO},{pushdot_to},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_TO},{dnl
__{}define({__INFO},{pushdot_to}){}dnl
ifelse({$2},{},{
dnl # PUSHDOT_TO(200,name)        --> (name) = 200
dnl # PUSHDOT_TO(0x44221100,name) --> (name) = 0x1100,0x4422
__{}  .error {$0}(): Missing  parameter with variable name!},
eval(ifdef({__DVALUE_$2},{0},{1})),{1},{
__{}  .error {$0}($@): The double variable with this name not exist!ifelse(ifdef({__VALUE_$2},{1},{0}),{1},{ Did you want to write {PUSH_TO}?})},
$#,{1},{
__{}  .error {$0}(): The second parameter with the initial value is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}    ld   BC, format({%-11s},{$1}); 4:20      $1. to {$2}   lo
__{}    ld  format({%-16s},{($2), BC}); 4:20      $1. to {$2}   lo
__{}    ld   BC, format({%-11s},{(2+$1)}); 4:20      $1. to {$2}   hi
__{}    ld  format({%-16s},{($2+2), BC}); 4:20      $1. to {$2}   hi},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): M4 does not know $1 parameter value!},
{
__{}    ld   BC, __HEX_HL($1)     ; 3:10      $1. to {$2}   lo
__{}    ld  format({%-16s},{($2), BC}); 4:20      $1. to {$2}   lo
__{}    ld   BC, __HEX_DE($1)     ; 3:10      $1. to {$2}   hi
__{}    ld  format({%-16s},{($2+2), BC}); 4:20      $1. to {$2}   hi{}dnl
})}){}dnl
dnl
dnl
dnl
dnl # CVARIABLE(name)        --> (name) = 0
dnl # CVARIABLE(name,100)    --> (name) = 100
dnl # CVARIABLE(name,0x88)   --> (name) = 0x88
define({CVARIABLE},{dnl
__{}__ADD_TOKEN({__TOKEN_CVARIABLE},{cvariable},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CVARIABLE},{dnl
__{}define({__INFO},{cvariable}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter with variable name!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
$#,{1},{dnl
__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}pushdef({LAST_HERE_ADD},1)dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}$1:
__{}    db 0x00})},
{dnl
__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}pushdef({LAST_HERE_ADD},1)dnl
__{}ifelse(__IS_NUM($2),{0},{
__{}  .warning {$0}($@): M4 does not know $2 parameter value!}){}dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}$1:
__{}__{}    db $2})})}){}dnl
dnl
dnl
dnl
dnl # VARIABLE(name)        --> (name) = 0
dnl # VARIABLE(name,100)    --> (name) = 100
dnl # VARIABLE(name,0x2211) --> (name) = 0x2211
define({VARIABLE},{dnl
__{}__ADD_TOKEN({__TOKEN_VARIABLE},{variable},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_VARIABLE},{dnl
__{}define({__INFO},{variable}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing  parameter with variable name!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
$#,{1},{dnl
__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}pushdef({LAST_HERE_ADD},2)dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}$1:
__{}    dw 0x0000})},
{dnl
__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}pushdef({LAST_HERE_ADD},2)dnl
__{}ifelse(__IS_NUM($2),{0},{
__{}  .warning {$0}($@): M4 does not know $2 parameter value!}){}dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}$1:
__{}__{}    dw $2})})}){}dnl
dnl
dnl
dnl # _DVARIABLE(name)             --> (name) = 0
dnl # _DVARIABLE(name,100)         --> (name) = 100
dnl # _DVARIABLE(name,0x88442211)  --> (name) = 0x88442211
define({DVARIABLE},{dnl
__{}__ADD_TOKEN({__TOKEN_DVARIABLE},{dvariable},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DVARIABLE},{dnl
__{}define({__INFO},{dvariable}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter with variable name!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
$#,{1},{dnl
__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}pushdef({LAST_HERE_ADD},4)dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}$1:
__{}__{}    dw 0x0000
__{}__{}    dw 0x0000})},
{dnl
__{}ifelse(eval(ifelse(__IS_NUM($2),{0},{1},{0})),{1},{
__{}__{}  .error {$0}($@): M4 does not know $2 parameter value!},
__{}{dnl
__{}__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}__{}pushdef({LAST_HERE_ADD},4)dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}format({%-24s},$1:); = $2{}dnl
__{}__{}__{} = ifelse(substr($2,0,2),{0x},eval($2),__HEX_DEHL($2)){}dnl
__{}__{}__{} = db __HEX_L($2) __HEX_H($2) __HEX_E($2) __HEX_D($2)
__{}__{}__{}    dw __HEX_HL($2)           ; = eval(($2) & 0xffff)
__{}__{}__{}    dw __HEX_DE($2)           ; = eval((($2) >> 16) & 0xffff)})}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # CREATE(name)         --> make data space pointer
define({CREATE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing name parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
{
format({%-21s},$1){}EQU __create_{}$1{}dnl
__{}__ADD_TOKEN({__TOKEN_CREATE},{create},__create_{}$1){}dnl
})}){}dnl
dnl
define({__ASM_TOKEN_CREATE},{dnl
__{}define({__INFO},{create}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing name parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
{dnl
__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}pushdef({LAST_HERE_ADD},0)dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}$1:})})}){}dnl
dnl
dnl
dnl
dnl # HERE
define({HERE},{dnl
__{}__ADD_TOKEN({__TOKEN_HERE},{here},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HERE},{dnl
__{}define({__INFO},{here}){}dnl

    push DE             ; 1:11      here
    ex   DE, HL         ; 1:4       here
    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      here}){}dnl
dnl
dnl
dnl
dnl # allot     --> reserve TOS bytes
define({ALLOT},{dnl
__{}__ADD_TOKEN({__TOKEN_ALLOT},{allot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ALLOT},{dnl
__{}define({__INFO},{allot})
__{}  .error __INFO{($@): Sorry, but ALLOT only supports constant allocation size, such as "PUSH(8) ALLOT"}dnl
}){}dnl
dnl
dnl
dnl
dnl # PUSH_ALLOT(8)      --> reserve 8 bytes
define({PUSH_ALLOT},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ALLOT},{push_allot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ALLOT},{dnl
__{}define({__INFO},{push_allot}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing name parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_NUM($1),{0},{
__{}  .error {$0}($@): Bad parameter! M4 does not know the numeric value of the parameter.},
{dnl
__{}ifelse(eval((LAST_HERE_ADD+$1)<0),{1},{dnl
__{}__{}ifelse(LAST_HERE_NAME,{VARIABLE_SECTION},{dnl
__{}__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+$1)){}dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}  .warning push_allot($1): Deallocation under VARIABLE_SECTION!
__{}__{}__{}format({%-24s},{    ORG $}$1);           $1 allot   (deallocation)})},
__{}__{}{dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}}format({%-24s},{    ORG $-}LAST_HERE_ADD{}){;           $1 allot   (deallocation }LAST_HERE_ADD{ bytes from }LAST_HERE_NAME{)}){}dnl
__{}__{}__{}popdef({LAST_HERE_NAME}){}dnl
__{}__{}__{}define({PUSH_ALLOT_TEMP},eval($1+LAST_HERE_ADD)){}dnl
__{}__{}__{}popdef({LAST_HERE_ADD}){}dnl
__{}__{}__{}__ASM_TOKEN_PUSH_ALLOT(PUSH_ALLOT_TEMP)})},
__{}{dnl
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+$1))dnl
__{}__{}ifelse(eval(($1)>0),{1},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}ds $1})},
__{}__{}eval(($1)<0),{1},{define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},{    ORG $}$1);           $1 allot   ( allocation }$1{ bytes from }LAST_HERE_NAME{)})})})})}){}dnl
dnl
dnl
dnl
dnl # COMMA      --> reserve one word = TOS
define({COMMA},{dnl
__{}__ADD_TOKEN({__TOKEN_COMMA},{comma},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_COMMA},{dnl
__{}define({__INFO},{comma}){}dnl
ifelse(eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{
__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)){,}HL); 3:16      ,
__{}    pop  HL             ; 1:10      ,
__{}    ex   DE, HL         ; 1:4       ,{}dnl
__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2))dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}    dw 0x0000})})}){}dnl
dnl
dnl
dnl
dnl # PUSH_COMMA(8)      --> reserve one word = 8
define({PUSH_COMMA},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_COMMA},{push_comma},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_COMMA},{dnl
__{}define({__INFO},{push_comma}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing value parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{
__{}    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 ,
__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)){,}BC); 4:20      $1 ,{}dnl
__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2))dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}    dw $1})})}){}dnl
dnl
dnl
dnl
define({__PUSHS_COMMA_REC},{dnl
__{}ifelse({debug},{},{
__{}rec:$@
__{}BC            >PUSHS_COMMA_BC<
__{}HL            >PUSHS_COMMA_HL<
__{}before val    >__SORT_VAL$1<
__{}before offset >__SORT_OFFSET$1<
__{}now val       >__SORT_VAL$2<
__{}noe offset    >__SORT_OFFSET$2<
__{}next val      >__SORT_VAL$3<
__{}next offset   >__SORT_OFFSET$3<}){}dnl
__{}undefine({_TMP_INFO}){}dnl
__{}dnl # BC variant
__{}ifelse(eval($#>2),{1},{__LD_REG16({HL},__SORT_VAL$3,{HL},PUSHS_COMMA_HL,{BC},__SORT_VAL$2)},{define({__PRICE_16BIT},0)}){}dnl
__{}define({__PUSHS_COMMA_REC_BC_P},__PRICE_16BIT){}dnl
__{}__LD_REG16({BC},__SORT_VAL$2,{HL},PUSHS_COMMA_HL,BC,PUSHS_COMMA_BC){}dnl
__{}define({__PUSHS_COMMA_REC_BC_P},eval(8+__PUSHS_COMMA_REC_BC_P+__PRICE_16BIT)){}dnl
__{}dnl # HL variant
__{}__{}ifelse(eval($#>2),{1},{__LD_REG16({HL},__SORT_VAL$3,{HL},__SORT_VAL$2,{BC},PUSHS_COMMA_BC)},{define({__PRICE_16BIT},0)}){}dnl
__{}define({__PUSHS_COMMA_REC_HL_P},__PRICE_16BIT){}dnl
__{}__LD_REG16({HL},__SORT_VAL$2,{HL},PUSHS_COMMA_HL,{BC},PUSHS_COMMA_BC){}dnl
__{}define({__PUSHS_COMMA_REC_HL_P},eval(__PUSHS_COMMA_REC_HL_P+__PRICE_16BIT)){}dnl
__{}dnl
__{}ifelse(eval(__PUSHS_COMMA_REC_HL_P<__PUSHS_COMMA_REC_BC_P),{1},{dnl # HL variant
__{}__{}define({PUSHS_COMMA_C},eval(PUSHS_COMMA_C+__CLOCKS_16BIT+16)){}dnl
__{}__{}define({PUSHS_COMMA_B},eval(PUSHS_COMMA_B+__BYTES_16BIT+3)){}dnl
__{}__{}__{}define({_TMP_INFO},{__SORT_VAL$2 ,}){}define({PUSHS_COMMA_HL},__SORT_VAL$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(__SORT_OFFSET$2,{0},{},+__SORT_OFFSET$2)){,}HL); 3:16      __SORT_VAL$2 ,{}dnl
__{}},
__{}{dnl
__{}__{}__LD_REG16({BC},$2,{HL},PUSHS_COMMA_HL,{BC},PUSHS_COMMA_BC){}dnl # BC variant
__{}__{}define({PUSHS_COMMA_C},eval(PUSHS_COMMA_C+__CLOCKS_16BIT+20)){}dnl
__{}__{}define({PUSHS_COMMA_B},eval(PUSHS_COMMA_B+__BYTES_16BIT+4)){}dnl
__{}__{}__{}define({_TMP_INFO},{__SORT_VAL$2 ,}){}define({PUSHS_COMMA_HL},__SORT_VAL$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(__SORT_OFFSET$2,{0},{},+__SORT_OFFSET$2)){,}BC); 4:20      __SORT_VAL$2 ,}){}dnl
__{}ifelse(eval($#>2),{1},{__PUSHS_COMMA_REC(shift($@))})}){}dnl
dnl
dnl
define({__PUSHS_COMMA_SORTED},{dnl
ifelse({debug},{},{
sorted:$@
now val     = __SORT_VAL$1
now offset  = __SORT_OFFSET$1
next val    = __SORT_VAL$2
next offset = __SORT_OFFSET$2}){}dnl
__{}define({PUSHS_COMMA_C},47){}dnl
__{}define({PUSHS_COMMA_B},8)
__{}    push HL             ; 1:11      _TMP_MAIN_INFO   default version
__{}    ld   HL, format({%-11s},__SORT_VAL$1); 3:10      __SORT_VAL$1 ,{}define({PUSHS_COMMA_HL},__SORT_VAL$1){}define({PUSHS_COMMA_BC},{})
__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(__SORT_OFFSET$1,{0},{},+__SORT_OFFSET$1)){,}HL); 3:16      __SORT_VAL$1 ,{}dnl
__{}__PUSHS_COMMA_REC($@)
__{}    pop  HL             ; 1:10      _TMP_MAIN_INFO
__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+$#+$#)){}dnl
__{}                        ;format({%-11s},[PUSHS_COMMA_B:PUSHS_COMMA_C])_TMP_MAIN_INFO}){}dnl
dnl
dnl
dnl
define({__PUSHS_COMMA_ANALYSIS},{dnl
ifelse(dnl
__{}__IS_NUM($1),{0},{define({__PUSHS_COMMA_ANALYSIS_LAST},$2)},
__{}__IS_NUM($2),{0},{define({__PUSHS_COMMA_ANALYSIS_LAST},$2)},
__{}{dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_H($2){_}__HEX_L($2),__IS_MEM_REF($1){x}__HEX_H($1){_}__HEX_L($1+1),{define({__PUSHS_COMMA_ANALYSIS_ADD1},eval(1+__PUSHS_COMMA_ANALYSIS_ADD1))}){}dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_H($2){_}__HEX_L($2),__IS_MEM_REF($1){x}__HEX_H($1){_}__HEX_L($1-1),{define({__PUSHS_COMMA_ANALYSIS_SUB1},eval(1+__PUSHS_COMMA_ANALYSIS_SUB1))}){}dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_H($2){_}__HEX_L($2),__IS_MEM_REF($1){x}__HEX_H($1+256){_}__HEX_L($1),{define({__PUSHS_COMMA_ANALYSIS_ADD256},eval(1+__PUSHS_COMMA_ANALYSIS_ADD256))}){}dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_H($2){_}__HEX_L($2),__IS_MEM_REF($1){x}__HEX_H($1-256){_}__HEX_L($1),{define({__PUSHS_COMMA_ANALYSIS_SUB256},eval(1+__PUSHS_COMMA_ANALYSIS_SUB256))}){}dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_HL($2),__IS_MEM_REF($1){x}__HEX_HL($1+1),{define({__PUSHS_COMMA_ANALYSIS_ADD16},eval(1+__PUSHS_COMMA_ANALYSIS_ADD16))}){}dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_HL($2),__IS_MEM_REF($1){x}__HEX_HL($1-1),{define({__PUSHS_COMMA_ANALYSIS_SUB16},eval(1+__PUSHS_COMMA_ANALYSIS_SUB16))}){}dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_H($2){_}__HEX_L($2),__IS_MEM_REF($1){x}__HEX_H($1){_}__HEX_L(2*$1),{define({__PUSHS_COMMA_ANALYSIS_LO2MUL},eval(1+__PUSHS_COMMA_ANALYSIS_LO2MUL))}){}dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_H($2){_}__HEX_L($2),__IS_MEM_REF($1){x}__HEX_H(2*$1){_}__HEX_L($1),{define({__PUSHS_COMMA_ANALYSIS_HI2MUL},eval(1+__PUSHS_COMMA_ANALYSIS_HI2MUL))}){}dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_HL($2),__IS_MEM_REF($1){x}__HEX_HL(2*$1),{define({__PUSHS_COMMA_ANALYSIS_2MUL},eval(1+__PUSHS_COMMA_ANALYSIS_2MUL))}){}dnl
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_HL($2),__IS_MEM_REF($1){x}__HEX_HL($1),{define({__PUSHS_COMMA_ANALYSIS_SAME},eval(1+__PUSHS_COMMA_ANALYSIS_SAME))}){}dnl
__{}__{}define({__PUSHS_COMMA_ANALYSIS_LAST},$2){}dnl
__{}__{}define({__PUSHS_COMMA_ANALYSIS_LAST_NUM},$2){}dnl
__{}}){}dnl
__{}dnl # __PUSHS_COMMA_ANALYSIS_ADD1
__{}dnl # __PUSHS_COMMA_ANALYSIS_ADD256
__{}dnl # __PUSHS_COMMA_ANALYSIS_ADD16
__{}dnl # __PUSHS_COMMA_ANALYSIS_SUB1
__{}dnl # __PUSHS_COMMA_ANALYSIS_SUB256
__{}dnl # __PUSHS_COMMA_ANALYSIS_SUB16
__{}dnl # __PUSHS_COMMA_ANALYSIS_SAME
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}    dw $1}){}dnl
__{}ifelse(eval($#>2),{1},{__PUSHS_COMMA_ANALYSIS(shift($@))},
__{}{dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}    dw $2})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # PUSH_COMMA(1,2,3,4,5,6,7,8,9,10)      --> reserve 10 words
define({PUSHS_COMMA},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHS_COMMA},{dnl
__{}define({__INFO},{pushs_comma}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing value parameter!},
eval($#),{1},{PUSH_COMMA($1)},
eval($#),{2},{
__{}    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      $1 ,
__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)){,}BC); 4:20      $1 ,{}dnl
__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2)){}dnl
__{}undefine({__COMMA}){}dnl
__{}define({_TMP_INFO},$2{ }__COMMA){}dnl
__{}__LD_REG16({BC},$2,{BC},$1){}dnl
__{}define({__COMMA},{,}){}dnl
__{}__CODE_16BIT
__{}    ld  format({%-16s},(LAST_HERE_NAME{}+LAST_HERE_ADD){,}BC); 4:20      $2 ,{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2))dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}    dw $1
__{}__{}    dw $2})},
{dnl
__{}define({PUSHS_COMMA_SUM},$#){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_ADD1},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_ADD256},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_ADD16},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_SUB1},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_SUB256},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_SUB16},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_LO2MUL},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_HI2MUL},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_2MUL},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_SAME},1){}dnl
__{}define({__PUSHS_COMMA_ANALYSIS_LAST_NUM},0xBAAAD){}dnl # ERR0R
__{}__PUSHS_COMMA_ANALYSIS($@){}dnl
__{}ifelse({debug},{},{errprint(
__{}__{}              {PUSHS_COMMA_SUM} = PUSHS_COMMA_SUM
__{}__{}    {__PUSHS_COMMA_ANALYSIS_ADD1} = __PUSHS_COMMA_ANALYSIS_ADD1
__{}__{}  {__PUSHS_COMMA_ANALYSIS_ADD256} = __PUSHS_COMMA_ANALYSIS_ADD256
__{}__{}   {__PUSHS_COMMA_ANALYSIS_ADD16} = __PUSHS_COMMA_ANALYSIS_ADD16
__{}__{}    {__PUSHS_COMMA_ANALYSIS_SUB1} = __PUSHS_COMMA_ANALYSIS_SUB1
__{}__{}  {__PUSHS_COMMA_ANALYSIS_SUB256} = __PUSHS_COMMA_ANALYSIS_SUB256
__{}__{}   {__PUSHS_COMMA_ANALYSIS_SUB16} = __PUSHS_COMMA_ANALYSIS_SUB16
__{}__{}  {__PUSHS_COMMA_ANALYSIS_LO2MUL} = __PUSHS_COMMA_ANALYSIS_LO2MUL
__{}__{}  {__PUSHS_COMMA_ANALYSIS_HI2MUL} = __PUSHS_COMMA_ANALYSIS_HI2MUL
__{}__{}    {__PUSHS_COMMA_ANALYSIS_2MUL} = __PUSHS_COMMA_ANALYSIS_2MUL
__{}__{}    {__PUSHS_COMMA_ANALYSIS_SAME} = __PUSHS_COMMA_ANALYSIS_SAME
__{}__{}{__PUSHS_COMMA_ANALYSIS_LAST_NUM} = __PUSHS_COMMA_ANALYSIS_LAST_NUM)}){}dnl
__{}ifelse(dnl
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_ADD1==$#),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   +1
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_L($1))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc   C             ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-6            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[16:eval(36+$#*46)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_ADD256==$#),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   +256
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_H($1))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),__HEX_L($1)       ; 2:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc   C             ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-6            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[16:eval(36+$#*46)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>4 && __PUSHS_COMMA_ANALYSIS_ADD16==$# && $#<256),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   +1 16-bit
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld    A, __HEX_L(__PUSHS_COMMA_ANALYSIS_LAST+1)       ; 2:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),B          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  BC             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    cp    C             ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    jr   nz, $-6        ; 2:7/12    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[18:eval(43+48*$#)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>5 && __PUSHS_COMMA_ANALYSIS_ADD16==$#),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   +1 16-bit
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld    A, __HEX_L(__PUSHS_COMMA_ANALYSIS_LAST+1)       ; 2:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),B          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  BC             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    cp    C             ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    jr   nz, $-6        ; 2:7/12    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld    A, __HEX_H(__PUSHS_COMMA_ANALYSIS_LAST+1)       ; 2:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    cp    B             ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    jr   nz, $-13       ; 2:7/12    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[23:cca eval(36+48*$#+(1+LAST_HERE_ADD/256-$1/256)*23)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_SUB1==$# && __PUSHS_COMMA_ANALYSIS_LAST_NUM==1),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   -1 to 1
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(__HEX_L($1))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),B          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-4            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[14:eval(36+$#*39)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_SUB1==$#),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   -1
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_L($1))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    dec   C             ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-6            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[16:eval(36+$#*46)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_SUB256==$# && __PUSHS_COMMA_ANALYSIS_LAST_NUM==256),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   -256 to 256
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),B          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-4            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[14:eval(36+$#*39)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_SUB256==$#),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   -256
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_H($1))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),__HEX_L($1)       ; 2:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    dec   C             ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-6            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[16:eval(36+$#*46)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>4 && __PUSHS_COMMA_ANALYSIS_SUB16==$# && $#<256),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   -1 16-bit
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld    A, __HEX_L(__PUSHS_COMMA_ANALYSIS_LAST-1)       ; 2:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),B          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    dec  BC             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    cp    C             ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    jr   nz, $-6        ; 2:7/12    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[18:eval(43+48*$#)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_LO2MUL==$#),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   2xlo
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_H($1))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),A          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    add   A, A          ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-5            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[17:eval(43+$#*43)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_HI2MUL==$#),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   2xhi
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_L($1))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),A          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    add   A, A          ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-5            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[17:eval(43+$#*43)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>4 && __PUSHS_COMMA_ANALYSIS_2MUL==$#),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   2x
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_H($1))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),A          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    add   A, A          ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    rl    C             ; 2:8       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-7            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[19:eval(43+$#*51)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}eval($#>4 && __PUSHS_COMMA_ANALYSIS_SAME==$# && $#<257),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   +0
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_L($1))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,{}ifelse(__HEX_H($1),__HEX_L($1),{
__{}__{}    ld  (HL),C          ; 1:7       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-4            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[14:eval(36+39*$#)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},{
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz $-5            ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[15:eval(36+42*$#)])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,})},
__{}eval($#>256 && __PUSHS_COMMA_ANALYSIS_SAME==$#),{1},{
__{}__{}    push HL             ; 1:11      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,   +0
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+1+__HEX_H($#))     ; 3:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),__HEX_L($1)       ; 2:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    inc  HL             ; 1:6       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    djnz nz, $-6        ; 2:8/13    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    dec   C             ; 1:4       $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    jr   nz, $-9        ; 2:7/12    $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}    pop  HL             ; 1:10      $1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,
__{}__{}                        ;format({%-11s},[18:eval(36+45*$#+11*__HEX_H(256+$#))])$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,},
__{}{dnl
__{}__{}undefine({__COMMA}){}dnl
__{}__{}define({_TMP_MAIN_INFO},{$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,}){}dnl
__{}__{}__SORT({a},LAST_HERE_ADD,$@){}dnl
__{}__{}__PUSHS_COMMA_SORTED(__SORT_SHOW({a})){}dnl
__{}}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # BUFFER(name,8)      --> Reserve 8 bytes
define({BUFFER},{dnl
__{}__ADD_TOKEN({__TOKEN_BUFFER},{buffer},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_BUFFER},{dnl
__{}define({__INFO},{buffer}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing name parameter!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_REG($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__IS_INSTRUCTION($1),{1},{
__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
$#,{1},{
__{}  .error {$0}(): Missing byte size parameter!},
{dnl
__{}ifelse(__IS_NUM($2),{0},{
__{}  .warning {$0}($@): M4 does not know $2 parameter value!}){}dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}$1:
__{}__{}    ds $2})})}){}dnl
dnl
dnl
dnl # -------------------------------------------------------------------------------------
dnl ## Memory access 8bit
dnl # -------------------------------------------------------------------------------------
dnl
dnl # C@
dnl # ( addr -- char )
dnl # fetch 8-bit char from addr
define({CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_CFETCH},{c@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CFETCH},{dnl
__{}define({__INFO},{cfetch}){}dnl

    ld    L,(HL)        ; 1:7       C@ cfetch   ( addr -- char )
    ld    H, 0x00       ; 2:7       C@ cfetch}){}dnl
dnl
dnl
dnl # dup C@
dnl # ( addr -- addr char )
dnl # save addr and fetch 8-bit number from addr
define({DUP_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_CFETCH},{dup c@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_CFETCH},{dnl
__{}define({__INFO},{dup_cfetch}){}dnl

                        ;[5:29]     dup C@ dup_cfetch ( addr -- addr char )
    push DE             ; 1:11      dup C@ dup_cfetch
    ld    E,(HL)        ; 1:7       dup C@ dup_cfetch
    ld    D, 0x00       ; 2:7       dup C@ dup_cfetch
    ex   DE, HL         ; 1:4       dup C@ dup_cfetch}){}dnl
dnl
dnl
dnl # 2over nip C@
dnl # ( addr d -- addr d char )
define({_2OVER_NIP_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_CFETCH},{2over nip c@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_CFETCH},{dnl
__{}define({__INFO},{2over_nip_cfetch}){}dnl

                        ;[8:54]     2over nip C@ ( addr d -- addr d char )
    pop  BC             ; 1:10      2over nip C@
    push BC             ; 1:11      2over nip C@
    push DE             ; 1:11      2over nip C@
    ex   DE, HL         ; 1:4       2over nip C@
    ld    A,(BC)        ; 1:7       2over nip C@
    ld    L, A          ; 1:4       2over nip C@
    ld    H, 0x00       ; 2:7       2over nip C@}){}dnl
dnl
dnl
dnl # dup C@ swap
dnl # ( addr -- char addr )
dnl # save addr and fetch 8-bit number from addr and swap
define({DUP_CFETCH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_CFETCH_SWAP},{dup c@ swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_CFETCH_SWAP},{dnl
__{}define({__INFO},{dup_cfetch_swap}){}dnl

                        ;[4:25]     dup C@ swap dup_cfetch_swap ( addr -- char addr )
    push DE             ; 1:11      dup C@ swap dup_cfetch_swap
    ld    E,(HL)        ; 1:7       dup C@ swap dup_cfetch_swap
    ld    D, 0x00       ; 2:7       dup C@ swap dup_cfetch_swap}){}dnl
dnl
dnl
dnl # C@ swap C@
dnl # ( addr2 addr1 -- char1 char2 )
dnl # double fetch 8-bit number and swap
define({CFETCH_SWAP_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_CFETCH_SWAP_CFETCH},{c@ swap c@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CFETCH_SWAP_CFETCH},{dnl
__{}define({__INFO},{cfetch_swap_cfetch}){}dnl

                        ;[6:29]     @C swap @C cfetch_swap_cfetch ( addr2 addr1 -- char1 char2 )
    ld    L,(HL)        ; 1:7       @C swap @C cfetch_swap_cfetch
    ld    H, 0x00       ; 2:7       @C swap @C cfetch_swap_cfetch
    ex   DE, HL         ; 1:4       @C swap @C cfetch_swap_cfetch
    ld    L,(HL)        ; 1:7       @C swap @C cfetch_swap_cfetch
    ld    H, D          ; 1:4       @C swap @C cfetch_swap_cfetch}){}dnl
dnl
dnl
dnl # C@ swap C@ swap
dnl # ( addr2 addr1 -- char1 char2 )
dnl # double fetch 8-bit number
define({CFETCH_SWAP_CFETCH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_CFETCH_SWAP_CFETCH_SWAP},{c@ swap c@ swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CFETCH_SWAP_CFETCH_SWAP},{dnl
__{}define({__INFO},{cfetch_swap_cfetch_swap}){}dnl

                        ;[6:29]     @C swap @C swap cfetch_swap_cfetch_swap ( addr2 addr1 -- char2 char1 )
    ld    L, (HL)       ; 1:7       @C swap @C swap cfetch_swap_cfetch_swap
    ld    H, 0x00       ; 2:7       @C swap @C swap cfetch_swap_cfetch_swap
    ld    A, (DE)       ; 1:7       @C swap @C swap cfetch_swap_cfetch_swap
    ld    E, A          ; 1:4       @C swap @C swap cfetch_swap_cfetch_swap
    ld    D, H          ; 1:4       @C swap @C swap cfetch_swap_cfetch_swap}){}dnl
dnl
dnl
dnl # over C@ over C@
dnl # ( addr2 addr1 -- addr2 addr1 char2 char1 )
dnl # double fetch 8-bit number with save address
define({OVER_CFETCH_OVER_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_CFETCH_OVER_CFETCH},{over c@ over c@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_CFETCH_OVER_CFETCH},{dnl
__{}define({__INFO},{over_cfetch_over_cfetch}){}dnl

                        ;[8:51]     over @C over @C over_cfetch_over_cfetch ( addr2 addr1 -- addr2 addr1 char2 char1 )
    push DE             ; 1:11      over @C over @C over_cfetch_over_cfetch
    push HL             ; 1:11      over @C over @C over_cfetch_over_cfetch
    ld    L, (HL)       ; 1:7       over @C over @C over_cfetch_over_cfetch
    ld    H, 0x00       ; 2:7       over @C over @C over_cfetch_over_cfetch
    ld    A, (DE)       ; 1:7       over @C over @C over_cfetch_over_cfetch
    ld    E, A          ; 1:4       over @C over @C over_cfetch_over_cfetch
    ld    D, H          ; 1:4       over @C over @C over_cfetch_over_cfetch}){}dnl
dnl
dnl
dnl
dnl # addr C@
dnl # ( -- x )
dnl # push_cfetch(addr), load 8-bit char from addr
define({PUSH_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CFETCH},{$1 c@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CFETCH},{dnl
__{}define({__INFO},{push_cfetch}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 @  push_cfetch($1)
    ex   DE, HL         ; 1:4       $1 @  push_cfetch($1)
    ld   HL,format({%-12s},($1)); 3:16      $1 @  push_cfetch($1)
    ld    H, 0x00       ; 2:7       $1 @  push_cfetch($1)}){}dnl
dnl
dnl
dnl
dnl # addr C@ x
dnl # ( -- (addr) x )
dnl # push_cfetch_push(addr,x), load 8-bit char from addr and push x
define({PUSH_CFETCH_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CFETCH_PUSH},{$1 c@ $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CFETCH_PUSH},{dnl
__{}define({__INFO},{push_cfetch_push}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address and second parameter!},
__{}$#,{1},{
__{}__{}.error {$0}():  The second parameter is missing!},
__{}$#,{2},{
    push DE             ; 1:11      $1 @ $2  push_cfetch_push($1,$2)
    push HL             ; 1:11      $1 @ $2  push_cfetch_push($1,$2)
    ld    A,format({%-12s},($1)); 3:13      $1 @ $2  push_cfetch_push($1,$2)
    ld    D, 0x00       ; 2:7       $1 @ $2  push_cfetch_push($1,$2)
    ld    E, A          ; 1:4       $1 @ $2  push_cfetch_push($1,$2)
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{3:16},{3:10})      $1 @ $2  push_cfetch_push($1,$2)},
__{}__{}.error {$0}($@): $# parameters found in macro!)}){}dnl
dnl
dnl
dnl
dnl # addr C@ x
dnl # ( -- (addr) x )
dnl # push2_cfetch(x,addr), push x and load 8-bit char from addr
dnl # n addr C@
dnl # ( -- n x )
define({PUSH2_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_CFETCH},{$1 $2 c@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_CFETCH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($#,0,{
__{}  .error {$0}(): Missing first and address parameter!},
__{}$#,1,{
__{}  .error {$0}($@): Missing address parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($2),1,{
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld   DE,format({%-12s},$1); ifelse(__IS_MEM_REF($1),1,{4:20},{3:10})      __INFO
    ld   HL,format({%-12s},$2); 3:16      __INFO
    ld    L,(HL)        ; 1:7       __INFO
    ld    H, 0x00       ; 2:7       __INFO},
{
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld   DE,format({%-12s},$1); ifelse(__IS_MEM_REF($1),1,{4:20},{3:10})      __INFO
    ld   HL,format({%-12s},{($2)}); 3:16      __INFO
    ld    H, 0x00       ; 2:7       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr C@ +
dnl # ( x -- x+(addr) )
dnl # push_cfetch(addr), add 8-bit char from addr
define({PUSH_CFETCH_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CFETCH_ADD},{$1 c@ add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CFETCH_ADD},{dnl
__{}define({__INFO},{push_cfetch_add}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld    A,format({%-12s},($1)); 3:13      $1 @ +  push_cfetch_add($1)   ( x -- x+($1) )
    add   A, L          ; 1:4       $1 @ +  push_cfetch_add($1)
    ld    L, A          ; 1:4       $1 @ +  push_cfetch_add($1)
    adc   A, H          ; 1:4       $1 @ +  push_cfetch_add($1)
    sub   L             ; 1:4       $1 @ +  push_cfetch_add($1)
    ld    H, A          ; 1:4       $1 @ +  push_cfetch_add($1)}){}dnl
dnl
dnl
dnl
dnl # addr C@ -
dnl # ( x -- x-(addr) )
dnl # push_cfetch(addr), sub 8-bit char from addr
define({PUSH_CFETCH_SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CFETCH_SUB},{$1 c@ sub},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CFETCH_SUB},{dnl
__{}define({__INFO},{push_cfetch_sub}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ld    A,format({%-12s},($1)); 3:13      $1 @ -  push_cfetch_sub($1)   ( x -- x-($1) )
    ld    B, A          ; 1:4       $1 @ -  push_cfetch_sub($1)
    ld    A, L          ; 1:4       $1 @ -  push_cfetch_sub($1)
    sub   B             ; 1:4       $1 @ -  push_cfetch_sub($1)
    ld    L, A          ; 1:4       $1 @ -  push_cfetch_sub($1)
    sbc   A, A          ; 1:4       $1 @ -  push_cfetch_sub($1)
    adc   A, H          ; 1:4       $1 @ -  push_cfetch_sub($1)
    ld    H, A          ; 1:4       $1 @ -  push_cfetch_sub($1)}){}dnl
dnl
dnl
dnl
dnl # C!
dnl # ( char addr -- )
dnl # store 8-bit char at addr
define({CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_CSTORE},{c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld  (HL),E          ; 1:7       __INFO   ( char addr -- )
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # dup addr C!
dnl # ( char -- char )
dnl # store 8-bit char lo(tos) at addr
define({DUP_PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CSTORE},{dup $1 c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}    ld    A, L          ; 1:4       __INFO
__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}    ld    A, L          ; 1:4       __INFO
__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO})})}){}dnl
dnl
dnl
dnl # addr C!
dnl # ( char -- )
dnl # store(addr) store 8-bit char at addr
define({PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CSTORE},{$1 c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{define({__INFO},__COMPILE_INFO)
__{}    ld    A, L          ; 1:4       __INFO
__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO})}){}dnl
dnl
dnl
dnl # addr swap n C!
dnl # ( addr -- )
dnl # store(addr) store 8-bit char at addr
define({PUSH_SWAP_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_SWAP_CSTORE},{push_swap_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_SWAP_CSTORE},{dnl
__{}define({__INFO},{push_swap_cstore}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 swap C! push_swap_cstore($1)   ( addr -- )
    ld  (HL),A          ; 1:7       $1 swap C! push_swap_cstore($1)
    ex   DE, HL         ; 1:4       $1 swap C! push_swap_cstore($1)
    pop  DE             ; 1:10      $1 swap C! push_swap_cstore($1)}){}dnl
dnl
dnl
dnl # ( addr+$2) = $1
dnl # ( addr -- addr )
dnl # store(addr+$1) store 8-bit char at addr
define({PUSH_OVER_PUSH_ADD_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_PUSH_ADD_CSTORE},{push_over_push_add_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER_PUSH_ADD_CSTORE},{dnl
__{}define({__INFO},{push_over_push_add_cstore}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
__{}$#,{2},{ifelse(__IS_MEM_REF($2),{1},{
    ld    B, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- addr )   (addr+$2)=$1
    ld    C, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld   HL, format({%-11s},$2); 3:16      $1 over $2 add C! push_over_push_add_cstore($1,$2)
    add  HL, BC         ; 1:11      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}    ld    A, format({%-11s},$1); 3:13      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld  (HL),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}dnl
__{},{dnl
__{}    ld  (HL),low format({%-7s},$1); 2:10      $1 over $2 add C! push_over_push_add_cstore($1,$2)})
    ld    H, B          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld    L, C          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)}
,eval($2),,{
    .warning {$0}($1,$2): M4 does not know $2 parameter value!
    ld    A, low format({%-7s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- addr )   (addr+$2)=$1
    add   A, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld    C, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld    A, high format({%-6s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    adc   A, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld    B, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 over $2 add C! push_over_push_add_cstore($1,$2)
    ld  (BC),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}
,{dnl
__{}ifelse(eval($2),0,{
__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- addr )   (addr+$2)=$1
__{}__{}    ld  (HL),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}dnl
__{}__{},{dnl
__{}__{}    ld  (HL),low format({%-7s},$1); 2:10      $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- addr )   (addr+$2)=$1})},
__{}eval($2),1,{
__{}    inc  HL             ; 1:6       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- addr )   (addr+$2)=$1
__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}__{}    ld  (HL),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}dnl
__{}__{},{dnl
__{}__{}    ld  (HL),low format({%-7s},$1); 2:10      $1 over $2 add C! push_over_push_add_cstore($1,$2)})
__{}    dec  HL             ; 1:6       $1 over $2 add C! push_over_push_add_cstore($1,$2)},
__{}__HEX_HL($2),{0xFFFF},{
__{}    dec  HL             ; 1:6       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- addr )   (addr+$2)=$1
__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}    ld    A, format({%-11s},$1); 3:13      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}__{}    ld  (HL),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)}dnl
__{}__{},{dnl
__{}__{}    ld  (HL),low format({%-7s},$1); 2:10      $1 over $2 add C! push_over_push_add_cstore($1,$2)})
__{}    inc  HL             ; 1:6       $1 over $2 add C! push_over_push_add_cstore($1,$2)},
__{}eval(($2) & 0xFF00),0,{
__{}    ld    A, low format({%-7s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- addr )   (addr+$2)=$1
__{}    add   A, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    C, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    adc   A, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    sub   C             ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    B, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld  (BC),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)},
__{}eval(($2) & 0xFF),0,{
__{}    ld    C, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- addr )   (addr+$2)=$1
__{}    ld    A, high format({%-6s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    add   A, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    B, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld  (BC),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)},
__{}{
__{}    ld    A, low format({%-7s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)   ( addr -- addr )   (addr+$2)=$1
__{}    add   A, L          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    C, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    A, high format({%-6s},$2); 2:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    adc   A, H          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld    B, A          ; 1:4       $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ifelse(__IS_MEM_REF($1),{1},{ld    A, format({%-11s},$1); 3:13},eval($1),0,{xor   A             ; 1:4 },{ld    A, low format({%-7s},$1); 2:7 })      $1 over $2 add C! push_over_push_add_cstore($1,$2)
__{}    ld  (BC),A          ; 1:7       $1 over $2 add C! push_over_push_add_cstore($1,$2)})})},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # addr C!
dnl # ( char -- char )
dnl # store(addr) store 8-bit char at addr
define({DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dup_push_cstore_dup_push_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dnl
__{}define({__INFO},{dup_push_cstore_dup_push_cstore}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
__{}$#,{2},{
    ld    A, L          ; 1:4       dup $1 C! dup $2 C! dup push($1) cstore dup push($2) cstore
    ld   format({%-15s},($1){,} A); 3:13      dup $1 C! dup $2 C! dup push($1) cstore dup push($2) cstore
    ld   format({%-15s},($2){,} A); 3:13      dup $1 C! dup $2 C! dup push($1) cstore dup push($2) cstore},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl # addr C!
dnl # ( char -- char )
dnl # store(addr) store 8-bit char at addr
define({DUP_PUSH_CSTORE_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dup_push_cstore_dup_push_cstore_dup_push_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dnl
__{}define({__INFO},{dup_push_cstore_dup_push_cstore_dup_push_cstore}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing two address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
$3,{},{
__{}__{}.error {$0}(): Missing third address parameter!},
__{}$#,{3},{
    ld    A, L          ; 1:4       dup $1 C! dup $2 C! dup $3 C!   dup push($1) cstore dup push($2) cstore dup push($3) cstore
    ld   format({%-15s},($1){,} A); 3:13      dup $1 C! dup $2 C! dup $3 C!   dup push($1) cstore dup push($2) cstore dup push($3) cstore
    ld   format({%-15s},($2){,} A); 3:13      dup $1 C! dup $2 C! dup $3 C!   dup push($1) cstore dup push($2) cstore dup push($3) cstore
    ld   format({%-15s},($3){,} A); 3:13      dup $1 C! dup $2 C! dup $3 C!   dup push($1) cstore dup push($2) cstore dup push($3) cstore},
__{}{
__{}__{}.error {$0}($@): $# parameters found in macro!})}){}dnl
dnl
dnl
dnl
dnl # char addr C!
dnl # ( -- )
dnl # store(addr) store 8-bit number at addr
define({PUSH2_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_CSTORE},{$1 $2 c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_CSTORE},{ifelse($1,{},{
__{}  .error {$0}(): Missing parameters!},
$#,{1},{
__{}  .error {$0}($@): The second parameter (address) is missing!},
eval($#>2),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1):__IS_MEM_REF($2),{1:1},{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}                        ;[8:40]     __INFO   ( -- )  val=$1, addr=$2
__{}    ld    A, format({%-11s},$1); 3:13      __INFO
__{}    ld   BC, format({%-11s},$2); 4:20      __INFO
__{}    ld  (BC),A          ; 1:7       __INFO},
__IS_MEM_REF($1),{1},{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}    ld    A, format({%-11s},$1); 3:13      __INFO
__{}    ld   format({%-15s},($2){,} A); 3:13      __INFO},
__IS_MEM_REF($2),{1},{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({__CODE1},__LD_R_NUM(__INFO{   lo($1) = __HEX_L($1)},{A},__HEX_L($1))){}dnl
__{}                        ;format({%-10s},[eval(5+__BYTES):eval(27+__CLOCKS)]) __INFO   ( -- )  val=$1, addr=$2{}dnl
__{}__CODE1
__{}    ld   BC, format({%-11s},$2); 4:20      __INFO
__{}    ld  (BC),A          ; 1:7       __INFO},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({__CODE1},__LD_R_NUM(__INFO{   lo($1) = __HEX_L($1)},{A},__HEX_L($1))){}dnl
__{}__CODE1
__{}    ld   format({%-15s},($2){,} A); 3:13      __INFO})}){}dnl
dnl
dnl
dnl
dnl
dnl # tuck C!
dnl # ( char addr -- addr )
dnl # store 8-bit number at addr with save addr
define({TUCK_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_TUCK_CSTORE},{tuck_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK_CSTORE},{dnl
__{}define({__INFO},{tuck_cstore}){}dnl

                        ;[2:17]     tuck c!  tuck_cstore   ( char addr -- addr )
    ld  (HL),E          ; 1:7       tuck c!  tuck_cstore
    pop  DE             ; 1:10      tuck c!  tuck_cstore}){}dnl
dnl
dnl
dnl # tuck c! 1+
dnl # ( char addr -- addr+1 )
dnl # store 8-bit number at addr and increment
define({TUCK_CSTORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_TUCK_CSTORE_1ADD},{tuck_cstore_1add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK_CSTORE_1ADD},{dnl
__{}define({__INFO},{tuck_cstore_1add}){}dnl

                        ;[3:23]     tuck c! +1  tuck_cstore_1add   ( x addr -- addr+2 )
    ld  (HL),E          ; 1:7       tuck c! +1  tuck_cstore_1add
    inc  HL             ; 1:6       tuck c! +1  tuck_cstore_1add
    pop  DE             ; 1:10      tuck c! +1  tuck_cstore_1add}){}dnl
dnl
dnl
dnl # over swap c!
dnl # ( char addr -- char )
dnl # store 8-bit number at addr with save char
define({OVER_SWAP_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_CSTORE},{over_swap_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_CSTORE},{dnl
__{}define({__INFO},{over_swap_cstore}){}dnl

                        ;[3:21]     over swap c!  over_swap_cstore   ( char addr -- char )
    ld  (HL),E          ; 1:7       over swap c!  over_swap_cstore
    ex   DE, HL         ; 1:4       over swap c!  over_swap_cstore
    pop  DE             ; 1:10      over swap c!  over_swap_cstore}){}dnl
dnl
dnl
dnl # 2dup c!
dnl # ( char addr -- char addr )
dnl # store 8-bit number at addr with save all
define({_2DUP_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CSTORE},{2dup_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CSTORE},{dnl
__{}define({__INFO},{2dup_cstore}){}dnl

                        ;[1:7]      2dup c!  _2dup_cstore   ( char addr -- char addr )
    ld  (HL),E          ; 1:7       2dup c!  _2dup_cstore}){}dnl
dnl
dnl
dnl # 2dup c! 1+
dnl # ( char addr -- char addr+1 )
dnl # store 8-bit number at addr with save all and increment
define({_2DUP_CSTORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CSTORE_1ADD},{2dup_cstore_1add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CSTORE_1ADD},{dnl
__{}define({__INFO},{2dup_cstore_1add}){}dnl

                        ;[2:13]     2dup c! 1+  _2dup_cstore_1add   ( char addr -- char addr+1 )
    ld  (HL),E          ; 1:7       2dup c! 1+  _2dup_cstore_1add
    inc  HL             ; 1:6       2dup c! 1+  _2dup_cstore_1add}){}dnl
dnl
dnl
dnl # number over c!
dnl # ( addr -- addr )
dnl # store 8-bit number at addr with save addr
define({PUSH_OVER_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_CSTORE},{push_over_cstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER_CSTORE},{dnl
__{}define({__INFO},{push_over_cstore}){}dnl
ifelse(
$1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{
__{}                        ;[2:10]     $1 over c!  push_over_cstore($1)   ( addr -- addr )   (addr)=$1
__{}    ld  (HL),low format({%-7s},$1); 2:10      $1 over c!  push_over_cstore($1)})}){}dnl
dnl
dnl
dnl # over number swap c!
dnl # ( addr x -- addr x )
dnl # store 8-bit number at addr with save addr
define({OVER_PUSH_SWAP_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_PUSH_SWAP_CSTORE},{over $1 swap c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_PUSH_SWAP_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
__IS_MEM_REF($1),1,{define({__INFO},__COMPILE_INFO)
                        ;[4:20]     __INFO   ( addr x1 -- addr x1 )  store $1 to addr
    ld    A, format({%-11s},$1); 3:13      __INFO   lo
    ld  (DE),A          ; 1:7       __INFO},
__IS_NUM($1),0,{define({__INFO},__COMPILE_INFO)
                        ;[3:14]     __INFO   ( addr x1 -- addr x1 )  store $1 to addr
    ld    A, format({%-11s},low $1); 2:7       __INFO
    ld  (DE),A          ; 1:7       __INFO},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({__CODE},__LD_R_NUM(__INFO{   lo},{A},__HEX_L($1))){}dnl
                        ;[eval(1+__BYTES):eval(7+__CLOCKS)]     __INFO   ( addr x1 -- addr x1 )  store $1 to addr{}dnl
__{}__CODE
    ld  (DE),A          ; 1:7       __INFO{}dnl
})}){}dnl
dnl
dnl
dnl
dnl # dup number swap c! 1+
dnl # push over c! 1+
dnl # ( addr -- addr+1 )
dnl # store 8-bit number at addr with save addr and increment
define({PUSH_OVER_CSTORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_CSTORE_1ADD},{push_over_cstore_1add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER_CSTORE_1ADD},{dnl
__{}define({__INFO},{push_over_cstore_1add}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[3:16]     $1 over c! 1+  push_over_cstore_1add($1)   ( addr -- addr+1 )
    ld  (HL),low format({%-7s},$1); 2:10      $1 over c! 1+  push_over_cstore_1add($1)
    inc  HL             ; 1:6       $1 over c! 1+  push_over_cstore_1add($1)}){}dnl
dnl
dnl
define({DUP_PUSH_SWAP_CSTORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_SWAP_CSTORE_1ADD},{dup_push_swap_cstore_1add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_SWAP_CSTORE_1ADD},{dnl
__{}define({__INFO},{dup_push_swap_cstore_1add}){}dnl
PUSH_OVER_CSTORE_1ADD($1)}){}dnl
dnl
dnl
dnl # cmove
dnl # ( from_addr to_addr u -- )
dnl # If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({CMOVE},{dnl
__{}__ADD_TOKEN({__TOKEN_CMOVE},{cmove},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CMOVE},{dnl
__{}define({__INFO},{cmove}){}dnl

    ld    A, H          ; 1:4       cmove   ( from_addr to_addr u_chars -- )
    or    L             ; 1:4       cmove
    ld    B, H          ; 1:4       cmove
    ld    C, L          ; 1:4       cmove BC = u_chars
    pop  HL             ; 1:10      cmove HL = from_addr
    jr    z, $+4        ; 2:7/12    cmove
    ldir                ; 2:u*21/16 cmove
    pop  HL             ; 1:10      cmove
    pop  DE             ; 1:10      cmove}){}dnl
dnl
dnl
dnl # u cmove
dnl # ( from_addr to_addr -- )
dnl # If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({PUSH_CMOVE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CMOVE},{push_cmove},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CMOVE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{ifelse(__IS_MEM_REF($1),{1},{
__{}__{}                       ;[13:54+21*u]__INFO   ( from_addr to_addr -- )
__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   BC = u_chars
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    or    C             ; 1:4       __INFO
__{}__{}    jr    z, $+5        ; 2:7/12    __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}    ldir                ; 2:u*21/16 __INFO   addr++
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__IS_NUM($1),{0},{
__{}    .warning  {$0}($@): M4 does not know $1 parameter value!
__{}__{}                       ;[12:44+21*u]__INFO   ( from_addr to_addr -- )
__{}__{}    ld   BC, __FORM({%-11s},$1); 3:10      __INFO   BC = u_chars
__{}__{}    ld    A, B          ; 1:4       __INFO
__{}__{}    or    C             ; 1:4       __INFO
__{}__{}    jr    z, $+5        ; 2:7/12    __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}    ldir                ; 2:u*21/16 __INFO   addr++
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},
__{}{dnl
__{}__{}ifelse(eval(($1)<1),{1},{
__{}__{}__{}                        ;[2:20]     __INFO   ( from_addr to_addr -- )   u = 0 or negative
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__{}eval($1),{1},{
__{}__{}__{}                        ;[5:40]     __INFO   ( from_addr to_addr -- )   u = 1 char
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}__{}    ldi                 ; 2:16      __INFO   1x
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__{}eval($1),{2},{
__{}__{}__{}                        ;[7:56]     __INFO   ( from_addr to_addr -- )   u = 2 chars
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}__{}    ldi                 ; 2:16      __INFO   1x
__{}__{}__{}    ldi                 ; 2:16      __INFO   2x
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__{}eval($1),{3},{
__{}__{}__{}                        ;[8:72]     __INFO   ( from_addr to_addr -- )   u = 3 chars
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}__{}    ldi                 ; 2:16      __INFO   1x
__{}__{}__{}    ldi                 ; 2:16      __INFO   2x
__{}__{}__{}    ldi                 ; 2:16      __INFO   3x
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__{}{
__{}__{}__{}                        ;format({%-11s},[8:eval(29+21*($1))])__INFO   ( from_addr to_addr -- )   u = $1 chars
__{}__{}__{}ifelse(eval(($1)>65535),{1},{dnl
__{}__{}__{}    .warning  {$0}($@): Trying to copy data bigger 64k!
__{}__{}__{}}){}dnl
__{}__{}__{}    ld   BC, format({%-11s},$1); 3:10      __INFO   BC = __HEX_HL($1)
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}__{}    ldir                ; 2:u*21/16 __INFO
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO})})})}){}dnl
dnl
dnl
dnl
dnl
dnl # u3 u2 u1 cmove
dnl # ( from_addr to_addr u -- )
dnl # If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({PUSH3_CMOVE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH3_CMOVE},{$1 $2 $3 cmove},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH3_CMOVE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($#,0,{
__{}  .error .error {$0}($@): Missing from_address parameter!},
$#,1,{
__{}  .error .error {$0}($@): Missing to_address parameter!},
$#,2,{
__{}  .error .error {$0}($@): Missing u_times parameter!},
eval($#>3),1,{
__{}  .error .error {$0}($@): Unexpected parameter!},
__SAVE_EVAL($3),0,{},
__SAVE_EVAL($3),1,{dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}    ld   BC,format({%-12s},{$1}); 4:20      __INFO   ( $1 $2 $3 -- )
__{}    ld    A,(BC)        ; 1:7       __INFO},
__{}{
__{}    ld    A,format({%-12s},{($1)}); 3:13      __INFO   ( $1 $2 $3 -- )})
__{}ifelse(__IS_MEM_REF($2),1,{dnl
__{}    ld   BC,format({%-12s},{$2}); 4:20      __INFO
__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{dnl
__{}    ld  format({%-16s},{($2),A}); 3:13      __INFO})},
__SAVE_EVAL($3),2,{dnl
__{}ifelse(__IS_MEM_REF($1),{1},{
__{}    push HL             ; 1:11      __INFO   ( $1 $2 $3 -- )
__{}    mov  HL,format({%-12s},{$1}); 3:16      __INFO   from_addr
__{}    mov   C,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    mov   B,(HL)        ; 1:7       __INFO},
__IS_MEM_REF($2),{1},{
__{}    push HL             ; 1:11      __INFO   ( $1 $2 $3 -- )
__{}    ld   BC,format({%-12s},{($1)}); 4:20      __INFO},
__{}{
__{}    ld   BC,format({%-12s},{($1)}); 4:20      __INFO   ( $1 $2 $3 -- )}){}dnl
__{}ifelse(__IS_MEM_REF($2),{1},{
__{}    mov  HL,format({%-12s},{$2}); 3:16      __INFO   to_addr
__{}    mov (HL),C          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    mov (HL),B          ; 1:7       __INFO
__{}    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1),{1},{
__{}    ld  format({%-16s},{($2),BC}); 4:20      __INFO
__{}    pop  HL             ; 1:10      __INFO)},
__{}{
__{}    ld  format({%-16s},{($2),BC}); 4:20      __INFO})},
{
    push DE             ; 1:11      __INFO   ( $1 $2 $3 -- )
    push HL             ; 1:11      __INFO{}dnl
__{}define({_TMP_INFO},__INFO{   from_addr}){}__LD_REG16({HL},$1){}__CODE_16BIT{}dnl
__{}define({_TMP_INFO},__INFO{   to_addr}){}__LD_REG16({DE},$2,{HL},$1){}__CODE_16BIT{}dnl
__{}define({_TMP_INFO},__INFO{   u_times}){}__LD_REG16({BC},$3,{HL},$1,{DE},$2){}__CODE_16BIT{}dnl
__{}ifelse(__IS_NUM($3),0,{
    ld    A, C          ; 1:4       __INFO
    or    B             ; 1:4       __INFO
    jr    z, $+4        ; 2:7/12    __INFO})
    ldir                ; 2:u*21/16 __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # cmove>
dnl # ( addr1 addr2 u -- )
dnl # If u is greater than zero, copy the contents of u consecutive characters at addr1 to the u consecutive characters at addr2.
define({CMOVEGT},{dnl
__{}__ADD_TOKEN({__TOKEN_CMOVEGT},{cmovegt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CMOVEGT},{dnl
__{}define({__INFO},{cmovegt}){}dnl

    ld    A, H          ; 1:4       cmove>   ( from_addr to_addr u_chars -- )
    or    L             ; 1:4       cmove>
    ld    B, H          ; 1:4       cmove>
    ld    C, L          ; 1:4       cmove>   BC = u
    pop  HL             ; 1:10      cmove>   HL = from = addr1
    jr    z, $+4        ; 2:7/12    cmove>
    lddr                ; 2:u*21/16 cmove>   addr--
    pop  HL             ; 1:10      cmove>
    pop  DE             ; 1:10      cmove>}){}dnl
dnl
dnl
dnl
dnl # addr u char fill
dnl # ( addr u char -- )
dnl # If u is greater than zero, fill the contents of u consecutive characters at addr.
define({FILL},{dnl
__{}__ADD_TOKEN({__TOKEN_FILL},{fill},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FILL},{dnl
__{}define({__INFO},{fill}){}dnl
ifelse({fast},{fast},{
__{}    ld    A, D          ; 1:4       fill
__{}    or    E             ; 1:4       fill
__{}    ld    A, L          ; 1:4       fill
__{}    pop  HL             ; 1:10      fill HL = from
__{}    jr    z, $+15       ; 2:7/12    fill
__{}    ld  (HL),A          ; 1:7       fill
__{}    dec  DE             ; 1:6       fill
__{}    ld    A, D          ; 1:4       fill
__{}    or    E             ; 1:4       fill
__{}    jr    z, $+9        ; 2:7/12    fill
__{}    ld    C, E          ; 1:4       fill
__{}    ld    B, D          ; 1:4       fill
__{}    ld    E, L          ; 1:4       fill
__{}    ld    D, H          ; 1:4       fill
__{}    inc  DE             ; 1:6       fill DE = to
__{}    ldir                ; 2:u*21/16 fill
__{}    pop  HL             ; 1:10      fill
__{}    pop  DE             ; 1:10      fill},
__{}{
__{}    ld    A, L          ; 1:4       fill A  = char
__{}    pop  HL             ; 1:10      fill HL = addr
__{}    ld    B, E          ; 1:4       fill
__{}    inc   D             ; 1:4       fill
__{}    inc   E             ; 1:4       fill
__{}    dec   E             ; 1:4       fill
__{}    jr    z, $+6        ; 2:7/12    fill
__{}    ld  (HL),A          ; 1:7       fill
__{}    inc  HL             ; 1:6       fill
__{}    djnz $-2            ; 2:13/8    fill
__{}    dec   D             ; 1:4       fill
__{}    jr   nz, $-5        ; 2:7/12    fill
__{}    pop  HL             ; 1:10      fill
__{}    pop  DE             ; 1:10      fill})}){}dnl
dnl
dnl
dnl
dnl # addr u char fill
dnl # ( addr u -- )
dnl # If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH_FILL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FILL},{push_fill},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FILL},{dnl
__{}define({__INFO},{push_fill}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse({fast},{fast},{dnl
__{}    ld    A, H          ; 1:4       $1 fill
__{}    or    L             ; 1:4       $1 fill
__{}    jr    z, $+16       ; 2:7/12    $1 fill
__{}    ld    C, L          ; 1:4       $1 fill
__{}    ld    B, H          ; 1:4       $1 fill
__{}    ld    L, E          ; 1:4       $1 fill
__{}    ld    H, D          ; 1:4       $1 fill HL = from
__{}    ld  (HL),format({%-11s},$1); 2:10      $1 fill
__{}    dec  BC             ; 1:6       $1 fill
__{}    ld    A, B          ; 1:4       $1 fill
__{}    or    C             ; 1:4       $1 fill
__{}    jr    z, $+5        ; 2:7/12    $1 fill
__{}    inc  DE             ; 1:6       $1 fill DE = to
__{}    ldir                ; 2:u*21/16 $1 fill
__{}    pop  HL             ; 1:10      $1 fill
__{}    pop  DE             ; 1:10      $1 fill},
__{}{dnl
__{}    ld    A, format({%-11s},$1); 2:7       $1 fill
__{}    ld    B, L          ; 1:4       $1 fill
__{}    inc   H             ; 1:4       $1 fill
__{}    inc   L             ; 1:4       $1 fill
__{}    dec   L             ; 1:4       $1 fill
__{}    jr    z, $+6        ; 2:7/12    $1 fill
__{}    ld  (DE),A          ; 1:7       $1 fill
__{}    inc  DE             ; 1:6       $1 fill
__{}    djnz $-2            ; 2:13/8    $1 fill
__{}    dec   H             ; 1:4       $1 fill
__{}    jr   nz, $-5        ; 2:7/12    $1 fill
__{}    pop  HL             ; 1:10      $1 fill
__{}    pop  DE             ; 1:10      $1 fill})}){}dnl
dnl
dnl
dnl
dnl # addr u char fill
dnl # ( addr -- )
dnl # If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH2_FILL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_FILL},{push2_fill},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_FILL},{dnl
__{}define({__INFO},{push2_fill}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(eval($1),{0},{dnl
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}eval($1),{1},{dnl
__{}                        ;[4:24]     1 $2 fill
__{}    ld  (HL),format({%-11s},$2); 2:10      1 $2 fill
__{}    ex   DE, HL         ; 1:4       1 $2 fill
__{}    pop  DE             ; 1:10      1 $2 fill},
__{}eval($1),{2},{dnl
__{}                        ;[7:40]     2 $2 fill
__{}    ld  (HL),format({%-11s},$2); 2:10      2 $2 fill
__{}    inc  HL             ; 1:6       2 $2 fill
__{}    ld  (HL),format({%-11s},$2); 2:10      2 $2 fill
__{}    ex   DE, HL         ; 1:4       2 $2 fill
__{}    pop  DE             ; 1:10      2 $2 fill},
__{}eval($1),{3},{dnl
__{}                        ;[9:54]     3 $2 fill
__{}    ld    A, format({%-11s},$2); 2:7       3 $2 fill
__{}    ld  (HL),A          ; 1:7       3 $2 fill
__{}    inc  HL             ; 1:6       3 $2 fill
__{}    ld  (HL),A          ; 1:7       3 $2 fill
__{}    inc  HL             ; 1:6       3 $2 fill
__{}    ld  (HL),A          ; 1:7       3 $2 fill
__{}    ex   DE, HL         ; 1:4       3 $2 fill
__{}    pop  DE             ; 1:10      3 $2 fill},
__{}eval($1),{4},{dnl
__{}                        ;[11:67]    4 $2 fill
__{}    ld    A, format({%-11s},$2); 2:7       4 $2 fill
__{}    ld  (HL),A          ; 1:7       4 $2 fill
__{}    inc  HL             ; 1:6       4 $2 fill
__{}    ld  (HL),A          ; 1:7       4 $2 fill
__{}    inc  HL             ; 1:6       4 $2 fill
__{}    ld  (HL),A          ; 1:7       4 $2 fill
__{}    inc  HL             ; 1:6       4 $2 fill
__{}    ld  (HL),A          ; 1:7       4 $2 fill
__{}    ex   DE, HL         ; 1:4       4 $2 fill
__{}    pop  DE             ; 1:10      4 $2 fill},
__{}eval($1),{5},{dnl
__{}                        ;[13:80]    5 $2 fill
__{}    ld    A, format({%-11s},$2); 2:7       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    inc  HL             ; 1:6       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    inc  HL             ; 1:6       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    inc  HL             ; 1:6       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    inc  HL             ; 1:6       5 $2 fill
__{}    ld  (HL),A          ; 1:7       5 $2 fill
__{}    ex   DE, HL         ; 1:4       5 $2 fill
__{}    pop  DE             ; 1:10      5 $2 fill},
__{}eval((($1)<=3*256) && ((($1) % 3)==0)),{1},{dnl
__{}                        ;[13:eval(19+(52*$1)/3)]   $1 $2 fill
__{}    ld   BC, format({%-11s},eval(($1)/3){*256+$2}); 3:10      $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    djnz $-6            ; 2:13/8    $1 $2 fill
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}eval((($1)<=2*256) && ((($1) & 1)==0)),{1},{dnl
__{}                        ;[11:eval(19+39*(($1)/2))]   $1 $2 fill
__{}    ld   BC, format({%-11s},eval(($1)/2){*256+$2}); 3:10      $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    djnz $-4            ; 2:13/8    $1 $2 fill
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}eval((($1)<=2*256) && ((($1) & 1)==1)),{1},{dnl
__{}                        ;[12:eval(26+39*(($1)/2))]   $1 $2 fill
__{}    ld   BC, format({%-11s},eval(($1)/2){*256+$2}); 3:10      $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    inc  HL             ; 1:6       $1 $2 fill
__{}    djnz $-4            ; 2:13/8    $1 $2 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 fill
__{}    ex   DE, HL         ; 1:4       $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill},
__{}{dnl
__{}                        ;[13:eval(39+($1)*21)]   $1 $2 fill
__{}    ld  (HL),format({%-11s},$2); 2:10      $1 $2 fill
__{}    ld   BC, format({%-11s},eval($1)-1); 3:10      $1 $2 fill
__{}    push DE             ; 1:11      $1 $2 fill
__{}    ld    D, H          ; 1:4       $1 $2 fill
__{}    ld    E, L          ; 1:4       $1 $2 fill
__{}    inc  DE             ; 1:6       $1 $2 fill DE = to
__{}    ldir                ; 2:u*21/16 $1 $2 fill
__{}    pop  HL             ; 1:10      $1 $2 fill
__{}    pop  DE             ; 1:10      $1 $2 fill})}){}dnl
dnl
dnl
dnl
dnl # addr u char fill
dnl # ( -- )
dnl # If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH3_FILL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH3_FILL},{$1 $2 $3 fill},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH3_FILL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},{
__{}__{}.error {$0}($@): The third parameter is missing!},
__{}$#,{3},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__SAVE_EVAL($2),{0},{dnl
__{}                        ;           $1 $2 $3 fill {$0}(addr,u,char)   variant null: 0 byte},
__SAVE_EVAL($2),{1},{dnl
__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[6:26]     $1 $2 $3 fill {$0}(addr,u,char)   variant A.1: 1 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[5:20]     $1 $2 $3 fill {$0}(addr,u,char)   variant A.2: 1 byte
__{}__{}    ld    A, format({%-11s},$3); 2:7       $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill},
__SAVE_EVAL($2),{2},{dnl
__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[9:39]     $1 $2 $3 fill {$0}(addr,u,char)   variant B.1: 2 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill},
__{}__{}{
__{}__{}                        ;[7:30]     $1 $2 $3 fill {$0}(addr,u,char)   variant B.2: 2 byte
__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      $1 $2 $3 fill
__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill})},
__SAVE_EVAL($2),{3},{dnl
__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[12:52]    $1 $2 $3 fill {$0}(addr,u,char)   variant C.1: 3 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[11:46]    $1 $2 $3 fill {$0}(addr,u,char)   variant C.2: 3 byte
__{}__{}    ld    A, format({%-11s},$3); 2:7       $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} A); 3:13      $1 $2 $3 fill
__{}    ld   format({%-15s},(1+$1){,} A); 3:13      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} A); 3:13      $1 $2 $3 fill},
__SAVE_EVAL($2),{4},{dnl
__{}__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[13:61]    $1 $2 $3 fill {$0}(addr,u,char)   variant D.1: 4 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld    C, A          ; 1:4       $1 $2 $3 fill
__{}__{}    ld    B, A          ; 1:4       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[11:50]    $1 $2 $3 fill {$0}(addr,u,char)   variant D.2: 4 byte
__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      $1 $2 $3 fill},
__SAVE_EVAL($2),{5},{dnl
__{}__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[16:74]    $1 $2 $3 fill {$0}(addr,u,char)   variant E.1: 5 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld    C, A          ; 1:4       $1 $2 $3 fill
__{}__{}    ld    B, A          ; 1:4       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[15:67]    $1 $2 $3 fill {$0}(addr,u,char)   variant E.2: 5 byte
__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      $1 $2 $3 fill
__{}__{}    ld    A, B          ; 1:4       $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(4+$1){,} A); 3:13      $1 $2 $3 fill},
__SAVE_EVAL($2),{6},{dnl
__{}__{}ifelse(__IS_MEM_REF($3),{1},{dnl
__{}__{}                        ;[17:81]    $1 $2 $3 fill {$0}(addr,u,char)   variant F.1: 6 byte
__{}__{}    ld    A, format({%-11s},$3); 3:13      $1 $2 $3 fill
__{}__{}    ld    C, A          ; 1:4       $1 $2 $3 fill
__{}__{}    ld    B, A          ; 1:4       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}                        ;[15:70]    $1 $2 $3 fill {$0}(addr,u,char)   variant F.2: 6 byte
__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      $1 $2 $3 fill})
__{}    ld   format({%-15s},($1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      $1 $2 $3 fill
__{}    ld   format({%-15s},(4+$1){,} BC); 4:20      $1 $2 $3 fill},
__SAVE_EVAL(+((($1) & 0xFF00) == (($1 + $2) & 0xFF00)) && (($2) % 3 == 0)),{1},{dnl
__{}define({_TEMP_B},eval(((($2) & 0xFFFF)/3) & 0x1FF))dnl
__{}                        ;[16:format({%-7s},eval(36+46*_TEMP_B)])$1 $2 $3 fill {$0}(addr,u,char)   variant G: u == 3*n bytes (3..+3..255) and hi(addr) == hi(addr_end)
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill   HL = addr
__{}    ld   BC, format({%-11s},eval((256*_TEMP_B) & 0xFFFF)+$3); 3:10      $1 $2 $3 fill   B = _TEMP_B{}x, C = $3
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}    djnz $-6            ; 2:13/8    $1 $2 $3 fill
__{}    pop  HL             ; 1:10      $1 $2 $3 fill},
__SAVE_EVAL(+($2) <= 2*256+1),{1},{dnl
__{}define({_TEMP_B},eval(((($2) & 0xFFFF)/2) & 0x1FF))dnl
__{}                        ;[eval(14+(($2) & 0x01)):format({%-7s},eval(36+37*_TEMP_B+7*(($2) & 0x01))])$1 $2 $3 fill {$0}(addr,u,char)   variant H: 2..513 byte
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill   HL = addr
__{}    ld   BC, format({%-11s},eval((256*_TEMP_B) & 0xFFFF)+$3); 3:10      $1 $2 $3 fill   B = _TEMP_B{}x, C = $3
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(__SAVE_EVAL(+($1+1) & 0x01),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(__SAVE_EVAL(+($1+2) & 0x01),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    djnz $-4            ; 2:13/8    $1 $2 $3 fill
__{}ifelse(eval(($2) & 0x01),{1},{dnl
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}}){}dnl
__{}    pop  HL             ; 1:10      $1 $2 $3 fill},
__SAVE_EVAL(+($2) <= 4*256+3),{1},{dnl
__{}define({_TEMP_B},eval(((($2) & 0xFFFF)/4) & 0x1FF))dnl
__{}ifelse(eval(($2) % 4),{0},{dnl
__{}__{}define({_TEMP_SIZE},{18}){}dnl
__{}__{}define({_TEMP_CLOCK},{0}){}dnl
__{}__{}define({_TEMP_PLUS},{})},
__{}eval(($2) % 4),{1},{dnl
__{}__{}define({_TEMP_SIZE},{19}){}dnl
__{}__{}define({_TEMP_CLOCK},{7}){}dnl
__{}__{}define({_TEMP_PLUS},{
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill})},
__{}eval(($2) % 4),{2},{dnl
__{}__{}define({_TEMP_SIZE},{21}){}dnl
__{}__{}ifelse(__SAVE_EVAL(+($1+4*_TEMP_B+1) & 0xFF),{0},{dnl
__{}__{}__{}define({_TEMP_CLOCK},{20}){}dnl
__{}__{}__{}define({_TEMP_PLUS},{
__{}__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill
__{}__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill})},
__{}__{}{dnl
__{}__{}__{}define({_TEMP_CLOCK},{18}){}dnl
__{}__{}__{}define({_TEMP_PLUS},{
__{}__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill})})},
__{}{dnl
__{}__{}define({_TEMP_SIZE},{23}){}dnl
__{}__{}define({_TEMP_CLOCK},{29}){}dnl
__{}__{}ifelse(__SAVE_EVAL(+($1+4*_TEMP_B+1) & 0xFF),{0},{define({_TEMP_CLOCK},eval(_TEMP_CLOCK+2))}){}dnl
__{}__{}ifelse(__SAVE_EVAL(+($1+4*_TEMP_B+2) & 0xFF),{0},{define({_TEMP_CLOCK},eval(_TEMP_CLOCK+2))}){}dnl
__{}__{}define({_TEMP_PLUS},{
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}__{}ifelse(__SAVE_EVAL(+($1+4*_TEMP_B+1) & 0xFF),{0},{dnl
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}__{}ifelse(__SAVE_EVAL(+($1+4*_TEMP_B+2) & 0xFF),{0},{dnl
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}__{}{dnl
__{}__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill})}){}dnl
__{}                        ;[_TEMP_SIZE:format({%-7s},eval(36+59*_TEMP_B+_TEMP_CLOCK)])$1 $2 $3 fill {$0}(addr,u,char)   variant {I}: 4..1027 byte
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill   HL = addr
__{}    ld   BC, format({%-11s},eval((256*_TEMP_B) & 0xFFFF)+$3); 3:10      $1 $2 $3 fill   B = _TEMP_B{}x, C = $3
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(__IS_NUM($1),{0},{dnl
__{}__{}  if 0x03 & ($1+1)
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}__{}  else
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill
__{}__{}  endif},
__{}__SAVE_EVAL(+($1+1) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(__IS_NUM($1),{0},{dnl
__{}__{}  if 0x03 & ($1+2)
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}__{}  else
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill
__{}__{}  endif},
__{}__SAVE_EVAL(+($1+2) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(__IS_NUM($1),{0},{dnl
__{}__{}  if 0x03 & ($1+3)
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}__{}  else
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill
__{}__{}  endif},
__{}__SAVE_EVAL(+($1+3) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),C          ; 1:7       $1 $2 $3 fill
__{}ifelse(__IS_NUM($1),{0},{dnl
__{}__{}  if 0x03 & ($1+0)
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill
__{}__{}  else
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill
__{}__{}  endif},
__{}__SAVE_EVAL(+($1+0) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    djnz $-8            ; 2:13/8    $1 $2 $3 fill{}_TEMP_PLUS
__{}    pop  HL             ; 1:10      $1 $2 $3 fill},
__SAVE_EVAL(+(($2) % 4) == 0),{1},{dnl
__{}define({_TEMP_B},eval((($2)/4) & 0xFF))dnl
__{}define({_TEMP_C},eval(((($2)/4) & 0xFF00)/256))dnl
__{}ifelse(eval(_TEMP_B>0),{1},{define({_TEMP_C},eval(_TEMP_C+1))}){}dnl
__{}                       ;[24:format({%-8s},eval(48+46*($2)/4+13*(_TEMP_B+(_TEMP_C-1)*256)+9*_TEMP_C)])$1 $2 $3 fill {$0}(addr,u,char)   variant {J}: u = 4*n bytes
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill   HL = addr
__{}    ld   BC, format({%-11s},256*_TEMP_B+_TEMP_C); 3:10      $1 $2 $3 fill   $2{}x = (C-1)*4*256 + 4*B
__{}    ld    A, format({%-11s},$3); ifelse(__IS_MEM_REF($3),{1},{3:13},{2:7 })      $1 $2 $3 fill   A = char
__{}    ld  (HL),A          ; 1:7       $1 $2 $3 fill
__{}ifelse(__SAVE_EVAL(+($1+1) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),A          ; 1:7       $1 $2 $3 fill
__{}ifelse(__SAVE_EVAL(+($1+2) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),A          ; 1:7       $1 $2 $3 fill
__{}ifelse(__SAVE_EVAL(+($1+3) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    ld  (HL),A          ; 1:7       $1 $2 $3 fill
__{}ifelse(__SAVE_EVAL(+($1+0) & 0x03),{0},{dnl
__{}__{}    inc  HL             ; 1:6       $1 $2 $3 fill},
__{}{dnl
__{}__{}    inc   L             ; 1:4       $1 $2 $3 fill})
__{}    djnz $-8            ; 2:13/8    $1 $2 $3 fill
__{}    dec  C              ; 1:4       $1 $2 $3 fill
__{}    jp   nz, $-11       ; 3:10      $1 $2 $3 fill
__{}    pop  HL             ; 1:10      $1 $2 $3 fill},
__{}{dnl
__{}                       ;[17:format({%-8s},eval(77+$2*21)])$1 $2 $3 fill {$0}(addr,u,char)   variant {K}.default
__{}    push DE             ; 1:11      $1 $2 $3 fill
__{}    push HL             ; 1:11      $1 $2 $3 fill
__{}    ld   HL, format({%-11s},$1); 3:10      $1 $2 $3 fill HL = addr from
__{}    ld   DE, format({%-11s},$1+1); 3:10      $1 $2 $3 fill DE = to
__{}    ld   BC, format({%-11s},$2-1); 3:10      $1 $2 $3 fill
__{}    ld  (HL),format({%-11s},$3); 2:10      $1 $2 $3 fill
__{}    ldir                ; 2:u*21/16 $1 $2 $3 fill
__{}    pop  HL             ; 1:10      $1 $2 $3 fill
__{}    pop  DE             ; 1:10      $1 $2 $3 fill})}){}dnl
dnl
dnl
dnl # -------------------------------------------------------------------------------------
dnl ## Memory access 16bit
dnl # -------------------------------------------------------------------------------------
dnl
dnl
dnl # @
dnl # ( addr -- x )
dnl # fetch 16-bit number from addr
define({FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_FETCH},{@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FETCH},{dnl
__{}define({__INFO},{fetch}){}dnl

    ld    A, (HL)       ; 1:7       @ fetch   ( addr -- x )
    inc  HL             ; 1:6       @ fetch
    ld    H, (HL)       ; 1:7       @ fetch
    ld    L, A          ; 1:4       @ fetch}){}dnl
dnl
dnl
dnl # dup @
dnl # ( addr -- addr x )
dnl # save addr and fetch 16-bit number from addr
define({DUP_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_FETCH},{dup @},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_FETCH},{dnl
__{}define({__INFO},{dup_fetch}){}dnl

                        ;[6:41]     dup @ dup_fetch ( addr -- addr x )
    push DE             ; 1:11      dup @ dup_fetch
    ld    E, (HL)       ; 1:7       dup @ dup_fetch
    inc  HL             ; 1:6       dup @ dup_fetch
    ld    D, (HL)       ; 1:7       dup @ dup_fetch
    dec  HL             ; 1:6       dup @ dup_fetch
    ex   DE, HL         ; 1:4       dup @ dup_fetch}){}dnl
dnl
dnl
dnl # dup @ swap
dnl # ( addr -- x addr )
dnl # save addr and fetch 16-bit number from addr and swap
define({DUP_FETCH_SWAP},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_FETCH_SWAP},{dup @ swap},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_FETCH_SWAP},{dnl
__{}define({__INFO},{dup_fetch_swap}){}dnl

                        ;[5:37]     dup @ swap dup_fetch_swap ( addr -- x addr )
    push DE             ; 1:11      dup @ swap dup_fetch_swap
    ld    E, (HL)       ; 1:7       dup @ swap dup_fetch_swap
    inc  HL             ; 1:6       dup @ swap dup_fetch_swap
    ld    D, (HL)       ; 1:7       dup @ swap dup_fetch_swap
    dec  HL             ; 1:6       dup @ swap dup_fetch_swap}){}dnl
dnl
dnl
dnl # addr @
dnl # ( -- x )
dnl # push_fetch(addr), load 16-bit number from addr
define({PUSH_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH},{$1 @},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH},{dnl
__{}define({__INFO},{push_fetch}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 @ push($1) fetch
    ex   DE, HL         ; 1:4       $1 @ push($1) fetch
    ld   HL,format({%-12s},($1)); 3:16      $1 @ push($1) fetch}){}dnl
dnl
dnl
dnl
dnl # b addr @
dnl # ( -- b a )
define({PUSH2_FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_FETCH},{$1 $2 @},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_FETCH},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($#,0,{
__{}  .error {$0}(): Missing first and address parameter!},
__{}$#,1,{
__{}  .error {$0}($@): Missing address parameter!},
eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($2),1,{
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld   HL,format({%-12s},$2); 3:16      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    D,(HL)        ; 1:7       __INFO
    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),1,{3:16},{3:10})      __INFO
    ex   DE, HL         ; 1:4       __INFO},
{
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld   DE,format({%-12s},$1); ifelse(__IS_MEM_REF($1),1,{4:20},{3:10})      __INFO
    ld   HL,format({%-12s},{($2)}); 3:16      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr @ 1+
dnl # ( -- x )
define({PUSH_FETCH_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_1ADD},{$1 @ 1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_1ADD},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},($1)); 3:16      __INFO
    inc  HL             ; 1:6       __INFO})}){}dnl
dnl
dnl
dnl
dnl # addr @ 1+ number
dnl # ( -- x2 x1 )  x2 = (addr)+1
define({PUSH_FETCH_1ADD_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_1ADD_PUSH},{$1 @ 1+ $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_1ADD_PUSH},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
$2,{},{
__{}  .error {$0}(): Missing second parameter!},
__{}eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld   DE,format({%-12s},($1)); 4:20      __INFO
    inc  DE             ; 1:6       __INFO
    ld   HL, format({%-11s},$2); ifelse(__IS_MEM_REF($2),{1},{3:16},{3:10})      __INFO{}dnl
})}){}dnl
dnl
dnl
dnl
dnl # addr1 @ 1+ addr2 !
dnl # ( -- )
define({PUSH_FETCH_1ADD_PUSH_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_1ADD_PUSH_STORE},{$1 @ 1+ $2 !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_1ADD_PUSH_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
$2,{},{
__{}  .error {$0}(): Missing second parameter!},
__{}eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(_TYP_SINGLE,{fast},{
                       ;[12:59/40]  __INFO
    ld   BC,format({%-12s},$1); 3:10      __INFO
    ld    A,(BC)        ; 1:7       __INFO
    inc   A             ; 1:4       __INFO
    ld  (BC),A          ; 1:7       __INFO
    jr   nz, $+6        ; 2:7/12    __INFO
    inc  BC             ; 1:6       __INFO
    ld    A,(BC)        ; 1:7       __INFO
    inc   A             ; 1:4       __INFO
    ld  (BC),A          ; 1:7       __INFO},
{
                       ;[ 9:46]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    inc  BC             ; 1:6       __INFO
    ld  format({%-16s},($1){,} BC); 4:20      __INFO}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # !
dnl # ( x addr -- )
dnl # store 16-bit number at addr
define({STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_STORE},{!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:40]     __INFO   ( x addr -- )
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl
dnl # dup addr !
dnl # ( x -- x )
dnl # store 16-bit tos at addr
define({DUP_PUSH_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_STORE},{dup $1 !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}    ld    A, L          ; 1:4       __INFO
__{}    ld  (BC),A          ; 1:7       __INFO
__{}    ld    A, H          ; 1:4       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}    ld   format({%-15s},($1){,} HL); 3:16      __INFO})})}){}dnl
dnl
dnl
dnl
dnl # addr !
dnl # ( x -- )
dnl # store(addr) store 16-bit number at addr
define({PUSH_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_STORE},{push_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_STORE},{dnl
__{}define({__INFO},{push_store}){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}                        ;[10:58]    $1 !  push_store($1)   ( x -- )  addr=$1
__{}    ld    C, L          ; 1:4       $1 !  push_store($1)
__{}    ld    B, H          ; 1:4       $1 !  push_store($1)
__{}    ld   HL, format({%-11s},$1); 3:16      $1 !  push_store($1)
__{}    ld  (HL), C         ; 1:7       $1 !  push_store($1)
__{}    inc  HL             ; 1:6       $1 !  push_store($1)
__{}    ld  (HL), B         ; 1:7       $1 !  push_store($1)
__{}    ex   DE, HL         ; 1:4       $1 !  push_store($1)
__{}    pop  DE             ; 1:10      $1 !  push_store($1)},
{
__{}                        ;[5:30]     $1 !  push_store($1)   ( x -- )  addr=$1
__{}    ld   format({%-15s},($1){,} HL); 3:16      $1 !  push_store($1)
__{}    ex   DE, HL         ; 1:4       $1 !  push_store($1)
__{}    pop  DE             ; 1:10      $1 !  push_store($1)})}){}dnl
dnl
dnl
dnl
dnl # x addr !
dnl # ( -- )
dnl # store(addr) store 16-bit number at addr
define({PUSH2_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_STORE},{push2_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_STORE},{dnl
__{}define({__INFO},{push2_store}){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameters!},
$#,{1},{
__{}  .error {$0}($@): The second parameter is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}                        ;[12:78]    $1 $2 !  push2_store($1,$2)   ( -- )  val=$1, addr=$2
__{}__{}__{}    push HL             ; 1:11      $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld  (HL), C         ; 1:7       $1 $2 !  push2_store($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld  (HL), B         ; 1:7       $1 $2 !  push2_store($1,$2)
__{}__{}__{}    pop  HL             ; 1:11      $1 $2 !  push2_store($1,$2)},
__{}__{}__{}_TYP_SINGLE,{smal},{
__{}__{}__{}                        ;[10:64]    $1 $2 !  push2_store($1,$2)   ( -- )  val=$1, addr=$2
__{}__{}__{}    push HL             ; 1:11      $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld  (HL),format({%-11s}, low $1); 2:10      $1 $2 !  push2_store($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld  (HL),format({%-11s}, high $1); 2:10      $1 $2 !  push2_store($1,$2)
__{}__{}__{}    pop  HL             ; 1:11      $1 $2 !  push2_store($1,$2)},
__{}__{}__{}__IS_NUM($1),{1},{
__{}__{}__{}__{}define({__CODE1},__LD_R_NUM({$1 $2 !  push2_store($1,$2)   lo($1) = __HEX_L($1)},{A},__HEX_L($1))){}dnl
__{}__{}__{}__{}define({__TMP_C},eval(40+__CLOCKS)){}dnl
__{}__{}__{}__{}define({__TMP_B},eval(7+__BYTES)){}dnl
__{}__{}__{}__{}define({__CODE2},__LD_R_NUM({$1 $2 !  push2_store($1,$2)   hi($1) = __HEX_H($1)},{A},__HEX_H($1),{A},__HEX_L($1))){}dnl
__{}__{}__{}__{}define({__TMP_C},eval(__TMP_C+__CLOCKS)){}dnl
__{}__{}__{}__{}define({__TMP_B},eval(__TMP_B+__BYTES)){}dnl
__{}__{}__{}                        ;format({%-10s},[__TMP_B:__TMP_C]) $1 $2 !  push2_store($1,$2)   ( -- )  val=$1, addr=$2
__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      $1 $2 !  push2_store($1,$2){}dnl
__{}__{}__{}__CODE1
__{}__{}__{}    ld  (BC), A         ; 1:7       $1 $2 !  push2_store($1,$2)
__{}__{}__{}    inc  BC             ; 1:6       $1 $2 !  push2_store($1,$2){}dnl
__{}__{}__{}__CODE2
__{}__{}__{}    ld  (BC), A         ; 1:7       $1 $2 !  push2_store($1,$2)},
__{}__{}__{}{
__{}__{}__{}                        ;[11:54]    $1 $2 !  push2_store($1,$2)   ( -- )  val=$1, addr=$2
__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld    A, format({%-11s}, low $1); 2:7       $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld  (BC), A         ; 1:7       $1 $2 !  push2_store($1,$2)
__{}__{}__{}    inc  BC             ; 1:6       $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld    A, format({%-11s}, high $1); 2:7       $1 $2 !  push2_store($1,$2)
__{}__{}__{}    ld  (BC), A         ; 1:7       $1 $2 !  push2_store($1,$2)})},
__IS_MEM_REF($1),{1},{
__{}                        ;[8:40]     $1 $2 !  push2_store($1,$2)   ( -- )  val=$1, addr=$2
__{}    ld   BC, format({%-11s},$1); 4:20      $1 $2 !  push2_store($1,$2)
__{}    ld   format({%-15s},($2){,} BC); 4:20      $1 $2 !  push2_store($1,$2)},
{
__{}                        ;[7:30]     $1 $2 !  push2_store($1,$2)   ( -- )  val=$1, addr=$2
__{}    ld   BC, format({%-11s},$1); 3:10      $1 $2 !  push2_store($1,$2)
__{}    ld   format({%-15s},($2){,} BC); 4:20      $1 $2 !  push2_store($1,$2)})}){}dnl
dnl
dnl
dnl
dnl # tuck !
dnl # ( x addr -- addr )
dnl # store 16-bit number at addr
define({TUCK_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_TUCK_STORE},{tuck_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK_STORE},{dnl
__{}define({__INFO},{tuck_store}){}dnl

                        ;[5:36]     tuck ! tuck_store   ( x addr -- addr )
    ld  (HL),E          ; 1:7       tuck ! tuck_store
    inc  HL             ; 1:6       tuck ! tuck_store
    ld  (HL),D          ; 1:7       tuck ! tuck_store
    dec  HL             ; 1:6       tuck ! tuck_store
    pop  DE             ; 1:10      tuck ! tuck_store}){}dnl
dnl
dnl
dnl # tuck ! 2+
dnl # ( x addr -- addr+2 )
dnl # store 16-bit number at addr
define({TUCK_STORE_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_TUCK_STORE_2ADD},{tuck_store_2add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK_STORE_2ADD},{dnl
__{}define({__INFO},{tuck_store_2add}){}dnl

                        ;[5:36]     tuck ! +2 tuck_store_2add   ( x addr -- addr+2 )
    ld  (HL),E          ; 1:7       tuck ! +2 tuck_store_2add
    inc  HL             ; 1:6       tuck ! +2 tuck_store_2add
    ld  (HL),D          ; 1:7       tuck ! +2 tuck_store_2add
    inc  HL             ; 1:6       tuck ! +2 tuck_store_2add
    pop  DE             ; 1:10      tuck ! +2 tuck_store_2add}){}dnl
dnl
dnl
dnl
dnl # over number swap !
dnl # number 2 pick !
dnl # ( addr x -- addr x )
dnl # store 16-bit number at addr
define({OVER_PUSH_SWAP_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_PUSH_SWAP_STORE},{over $1 swap !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_PUSH_SWAP_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
__IS_MEM_REF($1),1,{define({__INFO},__COMPILE_INFO)
                        ;[10:52]    __INFO   ( addr -- addr )
    ld    A, format({%-11s},$1); 3:13      __INFO   lo
    ld  (DE),A          ; 1:7       __INFO
    ld    A, format({%-11s},(1+$1)); 3:13      __INFO   hi
    inc  DE             ; 1:6       __INFO
    ld  (DE),A          ; 1:7       __INFO
    dec  DE             ; 1:6       __INFO},
__IS_NUM($1),0,{define({__INFO},__COMPILE_INFO)
                        ;[8:40]     __INFO   ( addr -- addr )
    ld    A, format({%-11s},low $1); 2:7       __INFO
    ld  (DE),A          ; 1:7       __INFO
    ld    A, format({%-11s},high $1); 2:7       __INFO
    inc  DE             ; 1:6       __INFO
    ld  (DE),A          ; 1:7       __INFO
    dec  DE             ; 1:6       __INFO},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({__CODE1},__LD_R_NUM(__INFO{   lo},{A},__HEX_L($1))){}dnl
__{}define({__B},eval(4+__BYTES)){}dnl
__{}define({__C},eval(26+__CLOCKS)){}dnl
__{}define({__CODE2},__LD_R_NUM(__INFO{   hi},{A},__HEX_H($1),{A},__HEX_L($1))){}dnl
__{}define({__B},eval(__B+__BYTES)){}dnl
__{}define({__C},eval(__C+__CLOCKS)){}dnl
                        ;[__B:__C]     __INFO   ( addr x1 -- addr x1 )  store $1 to addr{}dnl
__{}__CODE1
    ld  (DE),A          ; 1:7       __INFO{}dnl
__{}__CODE2
    inc  DE             ; 1:6       __INFO
    ld  (DE),A          ; 1:7       __INFO
    dec  DE             ; 1:6       __INFO
})}){}dnl
dnl
dnl
dnl
dnl # 2 pick number swap !
dnl # number 3 pick !
dnl # 2over nip number swap !
dnl # ( addr x2 x1 -- addr x2 x1 )
dnl # store 16-bit number at addr
define({PUSH_3_PICK_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_3_PICK_STORE},{$1 3 pick !},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_3_PICK_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
__IS_MEM_REF($1),1,{define({__INFO},__COMPILE_INFO)
                        ;[11:67]    __INFO   ( addr x2 x1 -- addr x2 x1 )  store $1 to addr
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    ld    A, format({%-11s},$1); 3:13      __INFO
    ld  (BC),A          ; 1:7       __INFO
    ld    A, format({%-11s},(1+$1)); 3:13      __INFO
    inc  BC             ; 1:6       __INFO
    ld  (BC),A          ; 1:7       __INFO},
__IS_NUM($1),0,{define({__INFO},__COMPILE_INFO)
                        ;[9:55]     __INFO   ( addr x2 x1 -- addr x2 x1 )  store $1 to addr
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    ld    A, format({%-11s},low $1); 2:7       __INFO
    ld  (BC),A          ; 1:7       __INFO
    ld    A, format({%-11s},high $1); 2:7       __INFO
    inc  BC             ; 1:6       __INFO
    ld  (BC),A          ; 1:7       __INFO},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({__CODE1},__LD_R_NUM(__INFO{   lo},{A},__HEX_L($1))){}dnl
__{}define({__B},eval(5+__BYTES)){}dnl
__{}define({__C},eval(41+__CLOCKS)){}dnl
__{}define({__CODE2},__LD_R_NUM(__INFO{   hi},{A},__HEX_H($1),{A},__HEX_L($1))){}dnl
__{}define({__B},eval(__B+__BYTES)){}dnl
__{}define({__C},eval(__C+__CLOCKS)){}dnl
                        ;[__B:__C]     __INFO   ( addr x2 x1 -- addr x2 x1 )  store $1 to addr
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO{}dnl
__{}__CODE1
    ld  (BC),A          ; 1:7       __INFO{}dnl
__{}__CODE2
    inc  BC             ; 1:6       __INFO
    ld  (BC),A          ; 1:7       __INFO})}){}dnl
dnl
dnl
dnl
dnl # 2 pick char swap c!
dnl # char 3 pick c!
dnl # 2over nip char swap c!
dnl # ( addr x2 x1 -- addr x2 x1 )
dnl # store 8-bit char at addr
define({PUSH_3_PICK_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_3_PICK_CSTORE},{$1 3 pick c!},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_3_PICK_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
__IS_MEM_REF($1),1,{define({__INFO},__COMPILE_INFO)
                        ;[6:41]     __INFO   ( addr x2 x1 -- addr x2 x1 )  lo($1)-->(addr)
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    ld    A, format({%-11s},$1); 3:13      __INFO
    ld  (BC),A          ; 1:7       __INFO},
__IS_NUM($1),0,{define({__INFO},__COMPILE_INFO)
                        ;[5:35]     __INFO   ( addr x2 x1 -- addr x2 x1 )  lo($1)-->(addr)
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    ld    A, format({%-11s},low $1); 2:7       __INFO
    ld  (BC),A          ; 1:7       __INFO},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({__CODE},__LD_R_NUM(__INFO{   lo},{A},__HEX_L($1))){}dnl
__{}define({__B},eval(3+__BYTES)){}dnl
__{}define({__C},eval(18+__CLOCKS)){}dnl
                        ;[__B:__C]     __INFO   ( addr x2 x1 -- addr x2 x1 )  lo($1)-->(addr)
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO{}dnl
__{}__CODE
    ld  (BC),A          ; 1:7       __INFO})}){}dnl
dnl
dnl
dnl
dnl # 3 pick number swap !
dnl # number 4 pick !
dnl # 2over drop number swap !
dnl # ( addr x3 x2 x1 -- addr x3 x2 x1 )
dnl # store 16-bit number at addr
define({PUSH_4_PICK_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_4_PICK_STORE},{$1 4 pick !},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_4_PICK_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
__IS_MEM_REF($1),1,{define({__INFO},__COMPILE_INFO)
                        ;[13:88]    __INFO   ( addr x3 x2 x1 -- addr x3 x2 x1 )  $1-->(addr)
    pop  AF             ; 1:10      __INFO
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    push AF             ; 1:11      __INFO
    ld    A, format({%-11s},$1); 3:13      __INFO
    ld  (BC),A          ; 1:7       __INFO
    ld    A, format({%-11s},(1+$1)); 3:13      __INFO
    inc  BC             ; 1:6       __INFO
    ld  (BC),A          ; 1:7       __INFO},
__IS_NUM($1),0,{define({__INFO},__COMPILE_INFO)
                        ;[11:76]    __INFO   ( addr x3 x2 x1 -- addr x3 x2 x1 )  $1-->(addr)
    pop  AF             ; 1:10      __INFO
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    push AF             ; 1:11      __INFO
    ld    A, format({%-11s},low $1); 2:7       __INFO
    ld  (BC),A          ; 1:7       __INFO
    ld    A, format({%-11s},high $1); 2:7       __INFO
    inc  BC             ; 1:6       __INFO
    ld  (BC),A          ; 1:7       __INFO},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({__CODE1},__LD_R_NUM(__INFO{   lo},{A},__HEX_L($1))){}dnl
__{}define({__B},eval(7+__BYTES)){}dnl
__{}define({__C},eval(62+__CLOCKS)){}dnl
__{}define({__CODE2},__LD_R_NUM(__INFO{   hi},{A},__HEX_H($1),{A},__HEX_L($1))){}dnl
__{}define({__B},eval(__B+__BYTES)){}dnl
__{}define({__C},eval(__C+__CLOCKS)){}dnl
                        ;[__B:__C]    __INFO   ( addr x3 x2 x1 -- addr x3 x2 x1 )  $1-->(addr)
    pop  AF             ; 1:10      __INFO
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    push AF             ; 1:11      __INFO{}dnl
__{}__CODE1
    ld  (BC),A          ; 1:7       __INFO{}dnl
__{}__CODE2
    inc  BC             ; 1:6       __INFO
    ld  (BC),A          ; 1:7       __INFO})}){}dnl
dnl
dnl
dnl
dnl # 3 pick char swap c!
dnl # char 4 pick c!
dnl # 2over drop char swap c!
dnl # ( addr x3 x2 x1 -- addr x3 x2 x1 )
dnl # store 8-bit char at addr
define({PUSH_4_PICK_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_4_PICK_CSTORE},{$1 4 pick c!},$@)}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_4_PICK_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
__IS_MEM_REF($1),1,{define({__INFO},__COMPILE_INFO)
                        ;[8:62]     __INFO   ( addr x3 x2 x1 -- addr x3 x2 x1 )  $1-->(addr)
    pop  AF             ; 1:10      __INFO
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    push AF             ; 1:11      __INFO
    ld    A, format({%-11s},$1); 3:13      __INFO
    ld  (BC),A          ; 1:7       __INFO},
__IS_NUM($1),0,{define({__INFO},__COMPILE_INFO)
                        ;[7:56]    __INFO   ( addr x3 x2 x1 -- addr x3 x2 x1 )  $1-->(addr)
    pop  AF             ; 1:10      __INFO
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    push AF             ; 1:11      __INFO
    ld    A, format({%-11s},low $1); 2:7       __INFO
    ld  (BC),A          ; 1:7       __INFO},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({__CODE},__LD_R_NUM(__INFO{   lo},{A},__HEX_L($1))){}dnl
__{}define({__B},eval(5+__BYTES)){}dnl
__{}define({__C},eval(49+__CLOCKS)){}dnl
                        ;[__B:__C]     __INFO   ( addr x3 x2 x1 -- addr x3 x2 x1 )  $1-->(addr)
    pop  AF             ; 1:10      __INFO
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    push AF             ; 1:11      __INFO{}dnl
__{}__CODE
    ld  (BC),A          ; 1:7       __INFO})}){}dnl
dnl
dnl
dnl
dnl # over swap !
dnl # ( x addr -- x )
dnl # store 16-bit number at addr
define({OVER_SWAP_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_STORE},{over_swap_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_STORE},{dnl
__{}define({__INFO},{over_swap_store}){}dnl

                        ;[5:34]     over swap ! over_swap_store   ( x addr -- x )
    ld  (HL),E          ; 1:7       over swap ! over_swap_store
    inc  HL             ; 1:6       over swap ! over_swap_store
    ld  (HL),D          ; 1:7       over swap ! over_swap_store
    ex   DE, HL         ; 1:4       over swap ! over_swap_store
    pop  DE             ; 1:10      over swap ! over_swap_store}){}dnl
dnl
dnl
dnl # 2dup !
dnl # ( x addr -- x addr )
dnl # store 16-bit number at addr
define({_2DUP_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_STORE},{2dup_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_STORE},{dnl
__{}define({__INFO},{2dup_store}){}dnl

                        ;[4:26]     2dup ! _2dup_store   ( x addr -- x addr )
    ld  (HL),E          ; 1:7       2dup ! _2dup_store
    inc  HL             ; 1:6       2dup ! _2dup_store
    ld  (HL),D          ; 1:7       2dup ! _2dup_store
    dec  HL             ; 1:6       2dup ! _2dup_store}){}dnl
dnl
dnl
dnl # 2dup ! 2+
dnl # ( x addr -- x addr+2 )
dnl # store 16-bit number at addr
define({_2DUP_STORE_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_STORE_2ADD},{2dup_store_2add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_STORE_2ADD},{dnl
__{}define({__INFO},{2dup_store_2add}){}dnl

                        ;[4:26]     2dup ! 2+ _2dup_store_2add   ( x addr -- x addr+2 )
    ld  (HL),E          ; 1:7       2dup ! 2+ _2dup_store_2add
    inc  HL             ; 1:6       2dup ! 2+ _2dup_store_2add
    ld  (HL),D          ; 1:7       2dup ! 2+ _2dup_store_2add
    inc  HL             ; 1:6       2dup ! 2+ _2dup_store_2add}){}dnl
dnl
dnl
dnl
dnl # number over !
dnl # dup number swap !
dnl # ( addr -- addr )
dnl # store 16-bit number at addr
define({PUSH_OVER_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_STORE},{$1 over !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
__IS_MEM_REF($1),1,{define({__INFO},__COMPILE_INFO)
                        ;[8:46]     __INFO   ( addr -- addr )
    ld   BC,format({%-12s},$1); 4:20      __INFO
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO},
{define({__INFO},__COMPILE_INFO)
                        ;[6:32]     __INFO   ( addr -- addr )
    ld  (HL),low format({%-7s},$1); 2:10      __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),high format({%-6s},$1); 2:10      __INFO
    dec  HL             ; 1:6       __INFO})}){}dnl
dnl
dnl
dnl
dnl # char over c!
dnl # dup char swap c!
dnl # ( addr -- addr )
dnl # store 16-bit number at addr
define({PUSH_OVER_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_CSTORE},{$1 over c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
__IS_MEM_REF($1),1,{define({__INFO},__COMPILE_INFO)
                        ;[4:20]     __INFO   ( addr -- addr )
    ld    A,format({%-12s},$1); 3:13      __INFO
    ld  (HL),A          ; 1:7       __INFO},
{define({__INFO},__COMPILE_INFO)
    ld  (HL),low format({%-7s},$1); 2:10      __INFO   ( addr -- addr )})}){}dnl
dnl
dnl
define({DUP_PUSH_SWAP_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_SWAP_STORE},{dup_push_swap_store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_SWAP_STORE},{dnl
__{}define({__INFO},{dup_push_swap_store}){}dnl
PUSH_OVER_STORE($1)}){}dnl
dnl
dnl
dnl
dnl # number over ! 2+
dnl # dup number swap ! 2+
dnl # ( addr -- addr+2 )
dnl # store 16-bit number at addr
define({PUSH_OVER_STORE_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_STORE_2ADD},{push_over_store_2add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER_STORE_2ADD},{dnl
__{}define({__INFO},{push_over_store_2add}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
                        ;[6:32]     $1 over ! 2+ push_over_store_2add($1)   ( addr -- addr+2 )
    ld  (HL),low format({%-7s},$1); 2:10      $1 over ! 2+ push_over_store_2add($1)
    inc  HL             ; 1:6       $1 over ! 2+ push_over_store_2add($1)
    ld  (HL),high format({%-6s},$1); 2:10      $1 over ! 2+ push_over_store_2add($1)
    inc  HL             ; 1:6       $1 over ! 2+ push_over_store_2add($1)}){}dnl
dnl
dnl
define({DUP_PUSH_SWAP_STORE_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_SWAP_STORE_2ADD},{dup_push_swap_store_2add},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_SWAP_STORE_2ADD},{dnl
__{}define({__INFO},{dup_push_swap_store_2add}){}dnl
PUSH_OVER_STORE_2ADD($1)}){}dnl
dnl
dnl
dnl # move
dnl # ( addr1 addr2 u -- )
dnl # If u is greater than zero, copy the contents of u consecutive 16-bit words at addr1 to the u consecutive 16-bit words at addr2.
define({MOVE},{dnl
__{}__ADD_TOKEN({__TOKEN_MOVE},{move},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MOVE},{dnl
__{}define({__INFO},{move}){}dnl

    or    A             ; 1:4       move   ( from_addr to_addr u_words -- )
    adc  HL, HL         ; 1:11      move
    ld    B, H          ; 1:4       move
    ld    C, L          ; 1:4       move   BC = 2*u
    pop  HL             ; 1:10      move   HL = from = addr1
    jr    z, $+4        ; 2:7/12    move
    ldir                ; 2:u*42/32 move   addr++
    pop  HL             ; 1:10      move
    pop  DE             ; 1:10      move}){}dnl
dnl
dnl
dnl # u move
dnl # ( from_addr to_addr -- )
dnl # If u is greater than zero, copy the contents of u consecutive words at from_addr to the u consecutive words at to_addr.
define({PUSH_MOVE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_MOVE},{push_move},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_MOVE},{dnl
__{}define({__INFO},{push_move}){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($1),{1},{
__{}__{}                       ;[15:70+42*u]$1 move   ( from_addr to_addr -- )
__{}__{}    ld   BC, format({%-11s},$1); 4:20      $1 move   BC = u_words
__{}__{}    sla   C             ; 2:8       $1 move
__{}__{}    rl    B             ; 2:8       $1 move
__{}__{};   jr    c, $+9        ; 2:7/12    $1 move   negative or unsigned overflow?
__{}__{}    ld    A, C          ; 1:4       $1 move
__{}__{}    or    B             ; 1:4       $1 move
__{}__{}    jr    z, $+5        ; 2:7/12    $1 move   zero?
__{}__{}    ex   DE, HL         ; 1:4       $1 move   HL = from_addr, DE = to_addr
__{}__{}    ldir                ; 2:u*42-5  $1 move   addr++
__{}__{}    pop  HL             ; 1:10      $1 move
__{}__{}    pop  DE             ; 1:10      $1 move},
__{}__IS_NUM($1),{0},{dnl
__{}__{}  .error  {$0}(): Bad parameter!},
__{}{dnl
__{}__{}ifelse(eval(($1)<1),{1},{
__{}__{}__{}                        ;[2:20]     $1 move   ( from_addr to_addr -- )   u = 0 or negative
__{}__{}__{}    pop  HL             ; 1:10      $1 move
__{}__{}__{}    pop  DE             ; 1:10      $1 move},
__{}__{}eval($1),{1},{
__{}__{}__{}                        ;[7:56]     $1 move   ( from_addr to_addr -- )   u = 1 word
__{}__{}__{}    ex   DE, HL         ; 1:4       $1 move   HL = from_addr, DE = to_addr
__{}__{}__{}    ldi                 ; 2:16      $1 move   addr++
__{}__{}__{}    ldi                 ; 2:16      $1 move   addr++
__{}__{}__{}    pop  HL             ; 1:10      $1 move
__{}__{}__{}    pop  DE             ; 1:10      $1 move},
__{}__{}{
__{}__{}__{}                        ;format({%-11s},[8:eval(29+42*($1))])$1 move   ( from_addr to_addr -- )   u = $1 words
__{}__{}__{}ifelse(eval(2*($1)>65535),{1},{dnl
__{}__{}__{}    .warning  {$0}($@): Trying to copy data bigger 64k!
__{}__{}__{}}){}dnl
__{}__{}__{}    ld   BC, __HEX_HL(2*($1))     ; 3:10      $1 move   BC = eval(2*($1)) chars
__{}__{}__{}    ex   DE, HL         ; 1:4       $1 move   HL = from_addr, DE = to_addr
__{}__{}__{}    ldir                ; 2:u*42-5  $1 move   addr++
__{}__{}__{}    pop  HL             ; 1:10      $1 move
__{}__{}__{}    pop  DE             ; 1:10      $1 move})})})}){}dnl
dnl
dnl
dnl
dnl # u move
dnl # ( from_addr to_addr -- )
dnl # If u is greater than zero, copy the contents of u consecutive words at from_addr to the u consecutive words at to_addr.
define({PUSH3_MOVE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH3_MOVE},{push3_move},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH3_MOVE},{dnl
__{}define({__INFO},{push3_move}){}dnl
ifelse(eval($#<3),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>3),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($3),{1},{dnl
__{}__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}__{}__{}define({PUSH3_MOVE_C},16)dnl
__{}__{}__{}__{}define({PUSH3_MOVE_HL},{    mov  HL,format({%-12s},$1); 3:16      $1 $2 $3 move   from_addr})},
__{}__{}__{}{dnl
__{}__{}__{}__{}define({PUSH3_MOVE_C},10)dnl
__{}__{}__{}__{}define({PUSH3_MOVE_HL},{    mov  HL, format({%-11s},$1); 3:10      $1 $2 $3 move   from_addr})}){}dnl
__{}__{}__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}__{}define({PUSH3_MOVE_C},eval(20+PUSH3_MOVE_C))dnl
__{}__{}__{}__{}define({PUSH3_MOVE_B},25)dnl
__{}__{}__{}__{}define({PUSH3_MOVE_DE},{    mov  DE,format({%-12s},$2); 4:20      $1 $2 $3 move   to_addr})},
__{}__{}__{}{
__{}__{}__{}__{}define({PUSH3_MOVE_C},eval(10+PUSH3_MOVE_C))dnl
__{}__{}__{}__{}define({PUSH3_MOVE_B},24)dnl
__{}__{}__{}__{}define({PUSH3_MOVE_DE},{    mov  DE, format({%-11s},$2); 3:10      $1 $2 $3 move   to_addr})}){}dnl
__{}__{}__{}define({PUSH3_MOVE_C},eval(88+PUSH3_MOVE_C))
__{}__{}                      ;[PUSH3_MOVE_B:PUSH3_MOVE_C+42*u]$1 $2 $3 move   ( -- ) from = $1, to = $2, u = $3 words
__{}__{}    ld   BC, format({%-11s},$3); 4:20      $1 $2 $3 move   BC = u_words
__{}__{}    sla   C             ; 2:8       $1 $2 $3 move
__{}__{}    rl    B             ; 2:8       $1 $2 $3 move
__{}__{};   jr    c, $+eval(PUSH3_MOVE_B-6)       ; 2:7/12    $1 $2 $3 move   negative or unsigned overflow?
__{}__{}    ld    A, C          ; 1:4       $1 $2 $3 move
__{}__{}    or    B             ; 1:4       $1 $2 $3 move
__{}__{}    jr    z, $+eval(PUSH3_MOVE_B-10)       ; 2:7/12    $1 $2 $3 move   zero?
__{}__{}    push DE             ; 1:11      $1 $2 $3 move
__{}__{}    push HL             ; 1:11      $1 $2 $3 move
__{}__{}PUSH3_MOVE_HL
__{}__{}PUSH3_MOVE_DE
__{}__{}    ldir                ; 2:u*42-5  $1 $2 $3 move   addr++
__{}__{}    pop  HL             ; 1:10      $1 $2 $3 move
__{}__{}    pop  DE             ; 1:10      $1 $2 $3 move},
__{}__IS_NUM($3),{0},{dnl
__{}__{}  .error  {$0}(): Bad parameter!},
__{}{dnl
__{}__{}ifelse(eval(($3)<1),{1},{
__{}__{}__{}                        ;[0:0]      $1 $2 $3 move   ( -- ) from: $1, to: $2, u: 0 or negative},
__{}__{}eval((($3)==1) && ((__IS_MEM_REF($1)+__IS_MEM_REF($2))==2)),{1},{
__{}__{}__{}                        ;[14:93]    $1 $2 $3 move   ( -- ) from: $1, to: $2, u: $3 words
__{}__{}__{}    push HL             ; 1:11      $1 $2 $3 move
__{}__{}__{}    mov  HL,format({%-12s},$1); 3:16      $1 $2 $3 move   from_addr
__{}__{}__{}    mov   C,(HL)        ; 1:7       $1 $2 $3 move
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 move
__{}__{}__{}    mov   B,(HL)        ; 1:7       $1 $2 $3 move
__{}__{}__{}    mov  HL,format({%-12s},$2); 3:16      $1 $2 $3 move   to_addr
__{}__{}__{}    mov (HL),C          ; 1:7       $1 $2 $3 move
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 move
__{}__{}__{}    mov (HL),B          ; 1:7       $1 $2 $3 move
__{}__{}__{}    pop  HL             ; 1:10      $1 $2 $3 move},
__{}__{}eval((($3)==1) && ((__IS_MEM_REF($1)+__IS_MEM_REF($2))==0)),{1},{
__{}__{}__{}                        ;[8:40]     $1 $2 $3 move   ( -- ) from: $1, to: $2, u: $3 words
__{}__{}__{}    mov  BC,format({%-12s},($1)); 4:20      $1 $2 $3 move   from_addr
__{}__{}__{}    mov format({%-16s},($2){,}BC); 4:20      $1 $2 $3 move   to_addr},
__{}__{}eval((($3)==2) && ((__IS_MEM_REF($1)+__IS_MEM_REF($2))==0)),{1},{
__{}__{}__{}                       ;[14:85]     $1 $2 $3 move   ( -- ) from: $1, to: $2, u: $3 words
__{}__{}__{}    push HL             ; 1:11      $1 $2 $3 move
__{}__{}__{}    mov  HL,format({%-12s},($1)); 3:16      $1 $2 $3 move   from_addr
__{}__{}__{}    mov format({%-16s},($2){,}HL); 3:16      $1 $2 $3 move   to_addr
__{}__{}__{}    mov  HL,format({%-12s},(2+$1)); 3:16      $1 $2 $3 move   from_addr
__{}__{}__{}    mov format({%-16s},(2+$2){,}HL); 3:16      $1 $2 $3 move   to_addr
__{}__{}__{}    pop  HL             ; 1:10      $1 $2 $3 move},
__{}__{}eval($3),{1},{
__{}__{}__{}                        ;[12:77]    $1 $2 $3 move   ( -- ) from: $1, to: $2, u: $3 words
__{}__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}__{}    push HL             ; 1:11      $1 $2 $3 move
__{}__{}__{}    mov  HL,format({%-12s},$1); 3:16      $1 $2 $3 move   from_addr
__{}__{}__{}    mov   C,(HL)        ; 1:7       $1 $2 $3 move   from_addr
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 move   from_addr
__{}__{}__{}    mov   B,(HL)        ; 1:7       $1 $2 $3 move   from_addr
__{}__{}__{}    pop  HL             ; 1:10      $1 $2 $3 move},
__{}__{}__{}{dnl
__{}__{}__{}    mov  BC,format({%-12s},($1)); 4:20      $1 $2 $3 move   from_addr})
__{}__{}__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}    push HL             ; 1:11      $1 $2 $3 move
__{}__{}__{}    mov  HL,format({%-12s},$2); 3:16      $1 $2 $3 move   to_addr
__{}__{}__{}    mov (HL),C          ; 1:7       $1 $2 $3 move   to_addr
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 $3 move   to_addr
__{}__{}__{}    mov (HL),B          ; 1:7       $1 $2 $3 move   to_addr
__{}__{}__{}    pop  HL             ; 1:10      $1 $2 $3 move},
__{}__{}__{}{dnl
__{}__{}__{}    mov format({%-16s},($2){,}BC); 4:20      $1 $2 $3 move   to_addr})},
__{}__{}{ifelse(eval(2*($3)>65535),{1},{
__{}__{}__{}__{}  .warning  {$0}($@): Trying to copy data bigger 64k!}){}dnl
__{}__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}__{}__{}define({PUSH3_MOVE_C},16)dnl
__{}__{}__{}__{}define({PUSH3_MOVE_HL},{    mov  HL,format({%-12s},$1); 3:16      $1 $2 $3 move   from_addr})},
__{}__{}__{}{dnl
__{}__{}__{}__{}define({PUSH3_MOVE_C},10)dnl
__{}__{}__{}__{}define({PUSH3_MOVE_HL},{    mov  HL, format({%-11s},$1); 3:10      $1 $2 $3 move   from_addr})}){}dnl
__{}__{}__{}ifelse(__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}__{}define({PUSH3_MOVE_C},eval(20+PUSH3_MOVE_C))dnl
__{}__{}__{}__{}define({PUSH3_MOVE_B},16)dnl
__{}__{}__{}__{}define({PUSH3_MOVE_DE},{    mov  DE,format({%-12s},$2); 4:20      $1 $2 $3 move   to_addr})},
__{}__{}__{}{
__{}__{}__{}__{}define({PUSH3_MOVE_C},eval(10+PUSH3_MOVE_C))dnl
__{}__{}__{}__{}define({PUSH3_MOVE_B},15)dnl
__{}__{}__{}__{}define({PUSH3_MOVE_DE},{    mov  DE, format({%-11s},$2); 3:10      $1 $2 $3 move   to_addr})}){}dnl
__{}__{}__{}define({PUSH3_MOVE_C},eval(47+42*($3)+PUSH3_MOVE_C))
__{}__{}__{}                        ;format({%-11s},[PUSH3_MOVE_B:PUSH3_MOVE_C])$1 $2 $3 move   ( -- ) from = $1, to = $2, u = $3 words
__{}__{}__{}    ld   BC, __HEX_HL(2*($3))     ; 3:10      $1 $2 $3 move   BC = eval(2*($3)) chars
__{}__{}__{}    push DE             ; 1:11      $1 $2 $3 move
__{}__{}__{}    push HL             ; 1:11      $1 $2 $3 move
__{}__{}__{}PUSH3_MOVE_HL
__{}__{}__{}PUSH3_MOVE_DE
__{}__{}__{}    ldir                ; 2:u*42-5  $1 $2 $3 move   addr++
__{}__{}__{}    pop  HL             ; 1:10      $1 $2 $3 move
__{}__{}__{}    pop  DE             ; 1:10      $1 $2 $3 move})})})}){}dnl
dnl
dnl
dnl
dnl # move>
dnl # ( addr1 addr2 u -- )
dnl # If u is greater than zero, copy the contents of u consecutive 16-bit words at addr1 to the u consecutive 16-bit words at addr2.
define({MOVEGT},{dnl
__{}__ADD_TOKEN({__TOKEN_MOVEGT},{movegt},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MOVEGT},{dnl
__{}define({__INFO},{movegt}){}dnl

    or    A             ; 1:4       move>
    adc  HL, HL         ; 1:11      move>
    ld    B, H          ; 1:4       move>
    ld    C, L          ; 1:4       move>   BC = 2*u
    pop  HL             ; 1:10      move>   HL = from = addr1
    jr    z, $+4        ; 2:7/12    move>
    lddr                ; 2:u*42/32 move>   addr--
    pop  HL             ; 1:10      move>
    pop  DE             ; 1:10      move>}){}dnl
dnl
dnl
dnl
dnl # +!
dnl # ( num addr -- )
dnl # Adds num to the 16-bit number stored at addr.
define({ADDSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_ADDSTORE},{addstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ADDSTORE},{dnl
__{}define({__INFO},{addstore}){}dnl

    ld    A, E          ; 1:4       +! addstore
    add   A,(HL)        ; 1:7       +! addstore
    ld  (HL),A          ; 1:7       +! addstore
    inc  HL             ; 1:6       +! addstore
    ld    A, D          ; 1:4       +! addstore
    adc   A,(HL)        ; 1:7       +! addstore
    ld  (HL),A          ; 1:7       +! addstore
    pop  HL             ; 1:10      +! addstore
    pop  DE             ; 1:10      +! addstore}){}dnl
dnl
dnl
dnl # num addr +!
dnl # ( -- )
dnl # Adds num to the 16-bit number stored at addr.
define({PUSH2_ADDSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_ADDSTORE},{push2_addstore},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_ADDSTORE},{dnl
__{}define({__INFO},{push2_addstore}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
ifelse(__IS_NUM($1),{0},{dnl
    push HL             ; 1:11      push2_addstore($1,$2)
    .warning {$0}($1): M4 does not know $1 parameter value!
    ld   BC, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      push2_addstore($1,$2)
    ld   HL, format({%-11s},{($2)}); 3:16      push2_addstore($1,$2)
    add  HL, BC         ; 1:11      push2_addstore($1,$2)
    ld   format({%-15s},($2){,} HL); 3:16      push2_addstore($1,$2)
    pop  HL             ; 1:10      push2_addstore($1,$2)},
__IS_MEM_REF($1),{1},{dnl
    push HL             ; 1:11      push2_addstore($1,$2)
    ld   BC, format({%-11s},$1); 4:20      push2_addstore($1,$2)
    ld   HL, format({%-11s},{($2)}); 3:16      push2_addstore($1,$2)
    add  HL, BC         ; 1:11      push2_addstore($1,$2)
    ld   format({%-15s},($2){,} HL); 3:16      push2_addstore($1,$2)
    pop  HL             ; 1:10      push2_addstore($1,$2)},
eval($1),0,{dnl
                        ;           push2_addstore($1,$2)},
eval($1),1,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval($1),2,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval($1),3,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval((($1) & 0xffff) == 0xffff),1,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval((($1) & 0xffff) == 0xfffe),1,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
eval((($1) & 0xffff) == 0xfffd),1,{dnl
    ld   BC, format({%-11s},{($2)}); 4:20      push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    dec  BC             ; 1:6       push2_addstore($1,$2)
    ld   format({%-15s},($2){,} BC); 4:20      push2_addstore($1,$2)},
{dnl
    ld   BC, format({%-11s},$2); ifelse(__IS_MEM_REF($1),{1},{4:20},{3:10})      push2_addstore($1,$2)
    ld    A,(BC)        ; 1:7       push2_addstore($1,$2)
    add   A, __HEX_L($1)       ; 2:7       push2_addstore($1,$2)   lo($1)
    ld  (BC),A          ; 1:7       push2_addstore($1,$2)
    inc  BC             ; 1:6       push2_addstore($1,$2)
    ld    A,(BC)        ; 1:7       push2_addstore($1,$2)
    adc   A, __HEX_H($1)       ; 2:7       push2_addstore($1,$2)   hi($1)
    ld  (BC),A          ; 1:7       push2_addstore($1,$2)})}){}dnl
dnl
dnl
dnl # -------------------------------------------------------------------------------------
dnl ## Memory access 32bit
dnl # -------------------------------------------------------------------------------------
dnl
dnl
dnl # 2@
dnl # ( addr -- hi lo )
dnl # fetch 32-bit number from addr
define({_2FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_2FETCH},{2@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2FETCH},{dnl
__{}define({__INFO},{2fetch}){}dnl

                        ;[10:65]    2@ _2fetch
    push DE             ; 1:11      2@ _2fetch
    ld    E, (HL)       ; 1:7       2@ _2fetch
    inc  HL             ; 1:6       2@ _2fetch
    ld    D, (HL)       ; 1:7       2@ _2fetch
    inc  HL             ; 1:6       2@ _2fetch
    ld    A, (HL)       ; 1:7       2@ _2fetch
    inc  HL             ; 1:6       2@ _2fetch
    ld    H, (HL)       ; 1:7       2@ _2fetch
    ld    L, A          ; 1:4       2@ _2fetch
    ex   DE, HL         ; 1:4       2@ _2fetch ( adr -- lo hi )}){}dnl
dnl
dnl
dnl
dnl
dnl # addr 2@
dnl # ( -- hi lo )
dnl # push_2fetch(addr), load 32-bit number from addr
define({PUSH_2FETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_2FETCH},{$1 2@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_2FETCH},{dnl
__{}define({__INFO},{push_2fetch}){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing address parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
    push DE             ; 1:11      $1 2@ push_2fetch($1)
    push HL             ; 1:11      $1 2@ push_2fetch($1)
__{}ifelse(__IS_NUM($1),{0},{dnl
__{}    ld   DE,format({%-12s},{(2+$1)}); 4:20      $1 2@ push_2fetch($1) hi}dnl
__{},{dnl
__{}    ld   DE,format({%-12s},(eval(2+$1))); 4:20      $1 2@ push_2fetch($1) hi})
    ld   HL,format({%-12s},($1)); 3:16      $1 2@ push_2fetch($1) lo}){}dnl
dnl
dnl
dnl
dnl # 2!
dnl # ( hi lo addr -- )
dnl # store 32-bit number at addr
define({_2STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2STORE},{2store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2STORE},{dnl
__{}define({__INFO},{2store}){}dnl

                        ;[10:76]    2!  _2store   ( hi lo addr -- )
    ld  (HL),E          ; 1:7       2!  _2store
    inc  HL             ; 1:6       2!  _2store
    ld  (HL),D          ; 1:7       2!  _2store
    inc  HL             ; 1:6       2!  _2store
    pop  DE             ; 1:10      2!  _2store
    ld  (HL),E          ; 1:7       2!  _2store
    inc  HL             ; 1:6       2!  _2store
    ld  (HL),D          ; 1:7       2!  _2store
    pop  HL             ; 1:10      2!  _2store
    pop  DE             ; 1:10      2!  _2store}){}dnl
dnl
dnl
dnl
dnl # addr 2!
dnl # ( hi lo -- )
dnl # store(addr) store 32-bit number at addr
define({PUSH_2STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_2STORE},{push_2store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_2STORE},{dnl
__{}define({__INFO},{push_2store}){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}                        ;[14:90]    $1 2!  push_2store($1)   ( hi lo -- )  addr=$1
__{}    ld    C, L          ; 1:4       $1 2!  push_2store($1)
__{}    ld    B, H          ; 1:4       $1 2!  push_2store($1)
__{}    ld   HL, format({%-11s},$1); 3:16      $1 2!  push_2store($1)
__{}    ld  (HL), C         ; 1:7       $1 2!  push_2store($1)
__{}    inc  HL             ; 1:6       $1 2!  push_2store($1)
__{}    ld  (HL), B         ; 1:7       $1 2!  push_2store($1)
__{}    inc  HL             ; 1:6       $1 2!  push_2store($1)
__{}    ld  (HL), E         ; 1:7       $1 2!  push_2store($1)
__{}    inc  HL             ; 1:6       $1 2!  push_2store($1)
__{}    ld  (HL), D         ; 1:7       $1 2!  push_2store($1)
__{}    pop  HL             ; 1:10      $1 2!  push_2store($1)
__{}    pop  DE             ; 1:10      $1 2!  push_2store($1)},
{
__{}                        ;[9:56]     $1 2!  push_2store($1)   ( hi lo -- ) adr = $1
__{}    ld   format({%-15s},{($1), HL}); 3:16      $1 2!  push_2store($1)   lo
__{}ifelse(__IS_NUM($1),{0},{dnl
__{}    ld   format({%-15s},{(2+$1), DE}); 4:20      $1 2!  push_2store($1)   hi},{dnl
__{}    ld   (__HEX_HL($1+2)), DE   ; 4:20      $1 2!  push_2store($1)   hi})
__{}    pop  HL             ; 1:10      $1 2!  push_2store($1)
__{}    pop  DE             ; 1:10      $1 2!  push_2store($1)})}){}dnl
dnl
dnl
dnl # hi lo addr 2!
dnl # ( hi -- ) lo=$1 addr=$2
dnl # store(addr) store 32-bit number at addr
define({PUSH2_2STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_2STORE},{push2_2store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_2STORE},{dnl
__{}define({__INFO},{push2_2store}){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameters!},
$#,{1},{
__{}  .error {$0}($@): The second parameter is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}ifelse(__IS_MEM_REF($2),{1},{
__{}__{}__{}ifelse(__IS_MEM_REF($1),{1},{dnl
__{}__{}__{}                        ;[18:118]   $1 $2 2!  push2_2store($1,$2)   ( hi -- )  lo=$1, addr=$2
__{}__{}__{}    push HL             ; 1:11      $1 $2 2!  push2_2store($1,$2)   save hi
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      $1 $2 2!  push2_2store($1,$2)   lo
__{}__{}__{}    ld  (HL), C         ; 1:7       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld  (HL), B         ; 1:7       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    pop  BC             ; 1:11      $1 $2 2!  push2_2store($1,$2)   load hi
__{}__{}__{}    ld  (HL), C         ; 1:7       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld  (HL), B         ; 1:7       $1 $2 2!  push2_2store($1,$2)},
__{}__{}__{}{dnl
__{}__{}__{}                        ;[16:90]    $1 $2 2!  push2_2store($1,$2)   ( hi -- )  lo=$1, addr=$2
__{}__{}__{}    ld    C, L          ; 1:4       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld    B, H          ; 1:4       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld  (HL), format({%-10s}, low $1); 2:10      $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld  (HL),format({%-11s}, high $1); 2:10      $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld  (HL), C         ; 1:7       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    inc  HL             ; 1:6       $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld  (HL), B         ; 1:7       $1 $2 2!  push2_2store($1,$2)})},
__{}{dnl
__{}__{}                        ;[11:ifelse(__IS_MEM_REF($1),{1},{62},{56})]    $1 $2 2!  push2_2store($1,$2)   ( hi -- )  lo=$1, addr=$2
__{}__{}ifelse(__IS_NUM($2),{0},{dnl
__{}__{}__{}    ld   format({%-15s},{($2+2), HL}); 3:16      $1 $2 2!  push2_2store($1,$2)   hi
__{}__{}__{}    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld   (format({%-14s},{$2), HL}); 3:16      $1 $2 2!  push2_2store($1,$2)   lo},
__{}__{}__{}{dnl
__{}__{}__{}    ld   (__HEX_HL($2+2)), HL   ; 3:16      $1 $2 2!  push2_2store($1,$2)   hi
__{}__{}__{}    ld   HL, format({%-11s},$1); ifelse(__IS_MEM_REF($1),{1},{3:16},{3:10})      $1 $2 2!  push2_2store($1,$2)
__{}__{}__{}    ld   (__HEX_HL($2)), HL   ; 3:16      $1 $2 2!  push2_2store($1,$2)   lo})})
__{}    pop  HL             ; 1:10      $1 $2 2!  push2_2store($1,$2)
__{}    ex   DE, HL         ; 1:4       $1 $2 2!  push2_2store($1,$2)})}){}dnl
dnl
dnl
dnl
dnl
dnl
dnl # hi lo addr 2!
dnl # ( -- )
dnl # store 32-bit number at addr
define({PUSH3_2STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH3_2STORE},{$1 $2 $3 2store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH3_2STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameters!},
eval($#<3),{1},{
__{}  .error {$0}($@): Missing parameter!},
eval($#>3),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($3):__IS_NUM($1):__IS_NUM($2),{1:1:1},{dnl
__{}ifelse(__HEX_H($2):__HEX_L($1):__HEX_H($1),__HEX_L($2):__HEX_L($2):__HEX_L($2),{
__{}__{}    ld   BC,format({%-12s},{$3}); 4:20      __INFO   addr{}dnl
__{}__{}__LD_R_NUM(__INFO,{A},__HEX_L($2))
__{}__{}    ld  (BC),A          ; 1:7       __INFO   lo
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO   lo
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO   hi
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO   hi},
__{}__HEX_L($1):__HEX_H($1),__HEX_H($2):__HEX_H($2),{
__{}__{}    ld   BC,format({%-12s},{$3}); 4:20      __INFO   addr{}dnl
__{}__{}__LD_R_NUM(__INFO,{A},__HEX_L($2))
__{}__{}    ld  (BC),A          ; 1:7       __INFO   lo{}dnl
__{}__{}__LD_R_NUM(__INFO,{A},__HEX_H($2),{A},__HEX_L($2))
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO   lo
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO   hi
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO   hi},
__{}__HEX_HL($1),__HEX_HL($2),{
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},{$3}); 3:16      __INFO   addr
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO   lo
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),B          ; 1:7       __INFO   lo
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO   hi
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),B          ; 1:7       __INFO   hi
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}{
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},{$3}); 3:16      __INFO   addr
__{}__{}    ld  (HL),__HEX_L($2)       ; 2:10      __INFO   lo
__{}__{}    inc  HL             ; 1:6       __INFO   lo
__{}__{}    ld  (HL),__HEX_H($2)       ; 2:10      __INFO   lo
__{}__{}    inc  HL             ; 1:6       __INFO   lo
__{}__{}    ld  (HL),__HEX_L($1)       ; 2:10      __INFO   hi
__{}__{}    inc  HL             ; 1:6       __INFO   hi
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      __INFO   hi
__{}__{}    pop  HL             ; 1:10      __INFO})},
__IS_MEM_REF($3),{1},{
__{}    push HL             ; 1:11      __INFO
__{}    ld   HL,format({%-12s},{$3}); 3:16      __INFO   addr
__{}ifelse(__IS_MEM_REF($2),1,{dnl
__{}__{}    ld   BC,format({%-12s},{$2}); 4:20      __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO   lo16
__{}__{}    inc  HL             ; 1:6       __INFO   lo16
__{}__{}    ld  (HL),B          ; 1:7       __INFO   lo16},
__{}__IS_NUM($2),1,{dnl
__{}__{}    ld  (HL),__HEX_L($2)       ; 2:10      __INFO   lo16
__{}__{}    inc  HL             ; 1:6       __INFO   lo16
__{}__{}    ld  (HL),__HEX_H($2)       ; 2:10      __INFO   lo16},
__{}{dnl
__{}__{}    ld  (HL),format({%-11s},{low $2}); 2:10      __INFO   lo16
__{}__{}    inc  HL             ; 1:6       __INFO   lo16
__{}__{}    ld  (HL),format({%-11s},{high $2}); 2:10      __INFO   lo16})
__{}    inc  HL             ; 1:6       __INFO
__{}ifelse(__IS_MEM_REF($1),1,{dnl
__{}__{}    ld   BC,format({%-12s},{$1}); 4:20      __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO   hi16
__{}__{}    inc  HL             ; 1:6       __INFO   hi16
__{}__{}    ld  (HL),B          ; 1:7       __INFO   hi16},
__{}__IS_NUM($1),1,{dnl
__{}__{}    ld  (HL),__HEX_L($1)       ; 2:10      __INFO   hi16
__{}__{}    inc  HL             ; 1:6       __INFO   hi16
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      __INFO   hi16},
__{}{dnl
__{}__{}    ld  (HL),format({%-11s},{low $1}); 2:10      __INFO   hi16
__{}__{}    inc  HL             ; 1:6       __INFO   hi16
__{}__{}    ld  (HL),format({%-11s},{high $1}); 2:10      __INFO   hi16})
__{}    pop  HL             ; 1:10      __INFO},
__IS_NUM($1):__IS_NUM($2),{1:1},{
__{}    ld   BC, __HEX_HL($2)     ; 3:10      __INFO   lo16
__{}ifelse(__IS_NUM($3),1,{dnl
__{}__{}    ld  (__HEX_HL($3)),BC     ; 4:20      __INFO   lo16},
__{}{dnl
__{}__{}    ld  format({%-16s},{($3),BC}); 4:20      __INFO   lo16}){}dnl
__{}define({_TMP_INFO},__INFO   hi16){}__LD_REG16({BC},__HEX_HL($1),{BC},__HEX_HL($2)){}__CODE_16BIT
__{}ifelse(__IS_NUM($3),1,{dnl
__{}__{}    ld  (__HEX_HL($3+2)),BC     ; 4:20      __INFO   hi16},
__{}{dnl
__{}__{}    ld  format({%-16s},{($3+2),BC}); 4:20      __INFO   hi16})},
{dnl
__{}ifelse(__IS_MEM_REF($2),1,{
__{}__{}    ld   BC,format({%-12s},{$2}); 4:20      __INFO   lo16},
__IS_NUM($2),0,{
__{}__{}    ld   BC,format({%-12s},{$2}); 3:10      __INFO   lo16},
__{}{
__{}__{}    ld   BC, __HEX_HL($2)     ; 3:10      __INFO   lo16}){}dnl
__{}ifelse(__IS_NUM($3),1,{
__{}__{}    ld  (__HEX_HL($3)),BC     ; 4:20      __INFO   lo16},
__{}{
__{}__{}    ld  format({%-16s},{($3),BC}); 4:20      __INFO   lo16}){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}__{}    ld   BC,format({%-12s},{$1}); 4:20      __INFO   hi16},
__IS_NUM($1),0,{
__{}__{}    ld   BC,format({%-12s},{$1}); 3:10      __INFO   hi16},
__{}{
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __INFO   hi16}){}dnl
__{}ifelse(__IS_NUM($3),1,{
__{}__{}    ld  (__HEX_HL($3+2)),BC     ; 4:20      __INFO   hi16},
__{}{
__{}__{}    ld  format({%-16s},{($3+2),BC}); 4:20      __INFO   hi16})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # d 2over nip 2!
dnl # ( addr -- addr )
dnl # store 32-bit number at addr
define({PUSH2_2OVER_NIP_2STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_2OVER_NIP_2STORE},{$1 $2 2over nip 2store},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_2OVER_NIP_2STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameters!},
$#,{1},{
__{}  .error {$0}($@): The second parameter is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
eval(__IS_MEM_REF($1)+__IS_MEM_REF($2)),{2},{
__{}    push HL             ; 1:11      __INFO
__{}    ld   BC,format({%-12s},{$1}); 4:20      __INFO   lo
__{}    ld  (HL),C          ; 1:7       __INFO   lo
__{}    inc  HL             ; 1:6       __INFO   lo
__{}    ld  (HL),B          ; 1:7       __INFO   lo
__{}    inc  HL             ; 1:6       __INFO   lo
__{}    ld   BC,format({%-12s},{$2}); 4:20      __INFO   hi
__{}    ld  (HL),C          ; 1:7       __INFO   hi
__{}    inc  HL             ; 1:6       __INFO   hi
__{}    ld  (HL),B          ; 1:7       __INFO   hi
__{}    pop  HL             ; 1:10      __INFO},
__IS_MEM_REF($1),{1},{
__{}    push HL             ; 1:11      __INFO
__{}    ld   BC,format({%-12s},{$1}); 4:20      __INFO   lo
__{}    ld  (HL),C          ; 1:7       __INFO   lo
__{}    inc  HL             ; 1:6       __INFO   lo
__{}    ld  (HL),B          ; 1:7       __INFO   lo
__{}    inc  HL             ; 1:6       __INFO   lo
__{}    ld  (HL),__HEX_L($2)       ; 2:10      __INFO   hi
__{}    inc  HL             ; 1:6       __INFO   hi
__{}    ld  (HL),__HEX_H($2)       ; 2:10      __INFO   hi
__{}    pop  HL             ; 1:10      __INFO},
__IS_MEM_REF($2),{1},{
__{}    push HL             ; 1:11      __INFO
__{}    ld  (HL),__HEX_L($1)       ; 2:10      __INFO   lo
__{}    inc  HL             ; 1:6       __INFO   lo
__{}    ld  (HL),__HEX_H($1)       ; 2:10      __INFO   lo
__{}    inc  HL             ; 1:6       __INFO   lo
__{}    ld   BC,format({%-12s},{$2}); 4:20      __INFO   hi
__{}    ld  (HL),C          ; 1:7       __INFO   hi
__{}    inc  HL             ; 1:6       __INFO   hi
__{}    ld  (HL),B          ; 1:7       __INFO   hi
__{}    pop  HL             ; 1:10      __INFO},
{
__{}    push HL             ; 1:11      __INFO
__{}    ld  (HL),__HEX_L($1)       ; 2:10      __INFO   lo
__{}    inc  HL             ; 1:6       __INFO   lo
__{}    ld  (HL),__HEX_H($1)       ; 2:10      __INFO   lo
__{}    inc  HL             ; 1:6       __INFO   lo
__{}    ld  (HL),__HEX_L($2)       ; 2:10      __INFO   hi
__{}    inc  HL             ; 1:6       __INFO   hi
__{}    ld  (HL),__HEX_H($2)       ; 2:10      __INFO   hi
__{}    pop  HL             ; 1:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
define({FAST_COPY_16_BYTES_INIT},{dnl
__{}__ADD_TOKEN({__TOKEN_FAST_COPY_16_BYTES_INIT},{fast_copy_16_bytes_init},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FAST_COPY_16_BYTES_INIT},{dnl
__{}define({__INFO},{fast_copy_16_bytes_init}){}dnl

                        ;[9:58]
    di                  ; 1:4
    push DE             ; 1:11      save nos
    push HL             ; 1:11      save tos
    exx                 ; 1:4
    push HL             ; 1:11      save ras
    ld   format({%-15s},($1){,}SP); 4:20      save orig SP}){}dnl
dnl
define({FAST_COPY_16_BYTES_STOP},{dnl
__{}__ADD_TOKEN({__TOKEN_FAST_COPY_16_BYTES_STOP},{fast_copy_16_bytes_stop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FAST_COPY_16_BYTES_STOP},{dnl
__{}define({__INFO},{fast_copy_16_bytes_stop}){}dnl

                        ;[9:58]
    ld   SP, format({%-11s},($1)); 4:20      load orig SP
    pop  HL             ; 1:10      load ras
    exx                 ; 1:4
    pop  HL             ; 1:10      load tos
    pop  HL             ; 1:10      load nos
    ei                  ; 1:4}){}dnl
dnl
dnl
dnl
define({FAST_COPY_16_BYTES},{dnl
__{}__ADD_TOKEN({__TOKEN_FAST_COPY_16_BYTES},{fast_copy_16_bytes},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FAST_COPY_16_BYTES},{dnl
__{}define({__INFO},{fast_copy_16_bytes}){}dnl

                        ;[26:204]
    ld   SP, format({%-11s},$1); 3:10      from
    pop  AF             ; 1:10
    pop  BC             ; 1:10
    pop  DE             ; 1:10
    pop  HL             ; 1:10
    exx                 ; 1:4
    pop  BC             ; 1:10
    pop  DE             ; 1:10
    pop  HL             ; 1:10
    ex   AF, AF'        ; 1:4
    pop  AF             ; 1:10
    ld   SP, format({%-11s},$2); 3:10      to
    push AF             ; 1:11
    ex   AF, AF'        ; 1:4
    push HL             ; 1:11
    push DE             ; 1:11
    push BC             ; 1:11
    exx                 ; 1:4
    push HL             ; 1:11
    push DE             ; 1:11
    push BC             ; 1:11
    push AF             ; 1:11}){}dnl
dnl
dnl
dnl
