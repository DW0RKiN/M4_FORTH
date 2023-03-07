dnl ## Memory
dnl
dnl
dnl
define({ALL_VARIABLE},{}){}dnl
define({LAST_HERE_NAME},{VARIABLE_SECTION}){}dnl
define({LAST_HERE_ADD},{0}){}dnl
dnl
dnl
dnl # Input:
dnl #   $1 ...bytes
dnl #   $2 ...hex string with value (without $)
dnl #   $3 ...variable/label name (only for error output)
define({__ALLOC_CONST_REC},{dnl
__{}ifelse(dnl
__{}$1,1,{dnl
__{}__{}ifelse(len($2),0,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    db 0x00})},
__{}__{}len($2),1,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    db 0x0$2})},
__{}__{}len($2),2,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    db 0x$2})},
__{}__{}{
__{}__{}__{}  .warning Overflow 0x{}substr($2,0,eval(len($2)-2)) from constant $3!{}dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    db 0x{}substr($2,eval(len($2)-2))})})},
__{}$1,2,{dnl
__{}__{}ifelse(len($2),0,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x0000})},
__{}__{}len($2),1,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x000$2})},
__{}__{}len($2),2,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x00$2})},
__{}__{}len($2),3,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x0$2})},
__{}__{}len($2),4,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x$2})},
__{}__{}{
__{}__{}__{}  .warning Overflow 0x{}substr($2,0,eval(len($2)-4)) from constant $3!{}dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x{}substr($2,eval(len($2)-4))})})},
{dnl
__{}__{}ifelse(len($2),0,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x0000})},
__{}__{}len($2),1,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x000$2})},
__{}__{}len($2),2,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x00$2})},
__{}__{}len($2),3,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x0$2})},
__{}__{}len($2),4,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x$2})},
__{}__{}{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}    dw 0x{}substr($2,eval(len($2)-4))})}){}dnl
__{}__{}__ALLOC_CONST_REC(eval($1-2),substr($2,0,eval(len($2)-4)),$3){}dnl
__{}__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({CONSTANT},{dnl
__{}__ADD_TOKEN({__TOKEN_CONSTANT},{constant},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CONSTANT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}  .error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}  .error {$0}($@): $# parameters found in macro!})
__{}format({%-20s},$1) EQU $2{}dnl
__{}define({$1},{$2})}){}dnl
dnl
dnl
dnl
dnl # VALUE(name)    --> (name) = TOS
define({VALUE},{dnl
__{}define({__PSIZE_}$1,2)dnl
__{}__ADD_TOKEN({__TOKEN_VALUE},{value }$1,$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_VALUE},{dnl
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
__{}define({__PSIZE_}$1,2)dnl
__{}__ASM_TOKEN_CREATE($1){}dnl
__{}pushdef({LAST_HERE_ADD},2)dnl
__{}__ALLOC_CONST_REC(2,,$1){}dnl
__{}__ASM_TOKEN_TO($1){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({PUSH_VALUE},{dnl
__{}define({__PSIZE_}$2,2)dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_VALUE},$1{ value }$2,$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_VALUE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
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
__{}define({__PSIZE_}$2,2)dnl
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
__{}define({__PSIZE_}$1,4)dnl
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
__{}define({__PSIZE_}$1,4)dnl
__{}__ASM_TOKEN_CREATE($1){}dnl
__{}pushdef({LAST_HERE_ADD},4)dnl
__{}__ALLOC_CONST_REC(4,,$1){}dnl
__{}__ASM_TOKEN_TO($1){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({PUSHDOT_DVALUE},{dnl
__{}define({__PSIZE_}$1,4)dnl
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
__{}define({__PSIZE_}$2,4)dnl
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
define({__TO_REC},{dnl
__{}ifelse(dnl
__{}$2,2,{
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ld  format({%-16s},{($1+$3), HL}); 3:16      __INFO},
__{}eval($2>2),1,{
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ld  format({%-16s},{($1+$3), HL}); 3:16      __INFO{}dnl
__{}__{}__TO_REC($1,eval($2-2),eval($3+2))}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TO},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse({$1},{},{
dnl # TO(name)    --> (name) = TOS
dnl # TO(name)    --> (name) = TOS,NOS
__{}  .error {$0}(): Missing  parameter with variable name!},
eval($#>1),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
eval(__PSIZE_$1),2,{
__{}    ld  format({%-16s},{($1), HL}); 3:16      __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO},
eval(__PSIZE_$1),4,{
__{}    ld  format({%-16s},{($1), HL}); 3:16      __INFO   lo
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld  format({%-16s},{($1+2), HL}); 3:16      __INFO   hi
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
ifdef({__PSIZE}_$1,1,0),1,{
__{}    ld  format({%-16s},{($1), HL}); 3:16      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    ld  format({%-16s},{($1+2), HL}); 3:16      __INFO{}dnl
__{}__TO_REC($1,eval(__PSIZE_$1-4),4)
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
{
__{}  .error {$0}($@): The variable with this name not exist!})}){}dnl
dnl
dnl
dnl # PUSH_TO(200,name)    --> (name) = 200
dnl # PUSH_TO(0x4422,name) --> (name) = 0x4422
define({PUSH_TO},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_TO},{push_to},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_TO},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter! Need {$0}(value,name)},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): Unexpected parameters!},
__{}eval(__PSIZE_$2!=2),1,{
__{}__{}  .error {$0}($@): The single variable with this name not exist!ifelse(ifdef({__PSIZE_$2},4,{ Did you want to write {PUSHDOT_TO}?})},
__{}{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({BC},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld  format({%-16s},{($2), BC}); 4:20      __INFO{}dnl
})}){}dnl
dnl
dnl
dnl
dnl # PUSH2_TO(hi16,lo16,name)        --> (name) = 200
define({PUSH2_TO},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_TO},{$1 $2 to $3},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_TO},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<3),1,{
__{}__{}  .error {$0}($@): Missing parameter! Need {$0}(hi16,lo16,name)},
__{}eval($#>3),{1},{
__{}__{}  .error {$0}($@): Unexpected parameters!},
__{}eval(__PSIZE_$3!=4),1,{
__{}__{}  .error {$0}($@): The double variable with this name not exist!ifelse(ifdef({__PSIZE_$3},2,{ Did you want to write {PUSH_TO}?})},
__{}{dnl
__{}define({_TMP_INFO},__INFO{   lo}){}dnl
__{}__LD_REG16({BC},$2){}dnl
__{}__CODE_16BIT
__{}    ld  format({%-16s},{($3), BC}); 4:20      __INFO   lo{}dnl
__{}define({_TMP_INFO},__INFO{   hi}){}dnl
__{}__LD_REG16({BC},$1,{BC},$2){}dnl
__{}__CODE_16BIT
__{}    ld  format({%-16s},{($3+2), BC}); 4:20      __INFO   hi{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # obsolete
define({PUSHDOT_TO},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSHDOT_TO},{$1. to $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSHDOT_TO},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse({$2},{},{
dnl # PUSHDOT_TO(200,name)        --> (name) = 200
dnl # PUSHDOT_TO(0x44221100,name) --> (name) = 0x1100,0x4422
__{}  .error {$0}(): Missing  parameter with variable name!},
eval(__PSIZE_$2!=4),1,{
__{}  .error {$0}($@): The double variable with this name not exist!ifelse(ifdef({__PSIZE_$2},2,{ Did you want to write {PUSH_TO}?})},
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
__{}define({__PSIZE_}$1,1)dnl
__{}__ADD_TOKEN({__TOKEN_CVARIABLE},{cvariable $1 $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CVARIABLE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing  parameter with variable name!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_REG($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__{}__IS_INSTRUCTION($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
__{}$#,{1},{dnl
__{}__{}define({__PSIZE_}$1,1)dnl
__{}__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}__{}pushdef({LAST_HERE_ADD},1)dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},$1:);           }__INFO{
__{}__{}__{}    db 0x00             ;           }__INFO)},
__{}__IS_NUM($2),1,{dnl
__{}__{}define({__PSIZE_}$1,1)dnl
__{}__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}__{}pushdef({LAST_HERE_ADD},1)dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},$1:);           }__INFO{   = ifelse(substr($2,0,2),{0x},eval($2),substr($2,0,2),{0X},eval($2),__HEX_L($2))
__{}__{}__{}    db __HEX_L($2)             ;           }__INFO)},
__{}{dnl
__{}__{}define({__PSIZE_}$1,1)dnl
__{}__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}__{}pushdef({LAST_HERE_ADD},1)dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},$1:);           }__INFO{
__{}__{}__{}    db format({%-17s},$2);           }__INFO)}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # VARIABLE(name)        --> (name) = 0
dnl # VARIABLE(name,100)    --> (name) = 100
dnl # VARIABLE(name,0x2211) --> (name) = 0x2211
define({VARIABLE},{dnl
__{}define({__PSIZE_}$1,2)dnl
__{}__ADD_TOKEN({__TOKEN_VARIABLE},{variable $1 $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_VARIABLE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing  parameter with variable name!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_REG($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__{}__IS_INSTRUCTION($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
__{}$#,1,{dnl
__{}__{}define({__PSIZE_}$1,2){}dnl
__{}__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}__{}pushdef({LAST_HERE_ADD},2)dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},$1:);           }__INFO{
__{}__{}__{}    dw 0x0000           ;           }__INFO)},
__{}__IS_NUM($2),1,{dnl
__{}__{}define({__PSIZE_}$1,2){}dnl
__{}__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}__{}pushdef({LAST_HERE_ADD},2)dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},$1:);           }__INFO{   = ifelse(substr($2,0,2),{0x},eval($2),substr($2,0,2),{0X},eval($2),__HEX_HL($2))
__{}__{}__{}    dw __HEX_HL($2)           ;           }__INFO)},
__{}{dnl
__{}__{}define({__PSIZE_}$1,2){}dnl
__{}__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}__{}pushdef({LAST_HERE_ADD},2)dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},$1:);           }__INFO{
__{}__{}__{}    dw format({%-17s},$2);           }__INFO)}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # >r     ... r>                     --> name ! ... inline_variable(name)
dnl # name ! ... variable name name @   --> name ! ... inline_variable(name)
define({INLINE_VARIABLE},{dnl
__{}define({__PSIZE_}$1,2)dnl
__{}__ADD_TOKEN({__TOKEN_INLINE_VARIABLE},{inline_variable __REMOVE_COMMA($@)},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_INLINE_VARIABLE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing  parameter with variable name!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_REG($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__{}__IS_INSTRUCTION($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
__{}__IS_MEM_REF($2),1,{
__{}__{}  .error {$0}($@): The variable value is memory reference!},
__{}$#,{1},{dnl
__{}__{}define({__PSIZE_}$1,2)
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 )
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    db   0x21           ; 3:10      __INFO   = ld HL, 0x0000
__{}__{}format({%-24s},$1:);           __INFO
__{}__{}    dw   0x0000         ;           __INFO},
__{}__IS_NUM($2),1,{dnl
__{}__{}define({__PSIZE_}$1,2)
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 )
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    db   0x21           ; 3:10      __INFO   = ld HL, __HEX_HL($2)
__{}__{}format({%-24s},$1:);           __INFO
__{}__{}    dw   __HEX_HL($2)         ;           __INFO},
__{}{dnl
__{}__{}define({__PSIZE_}$1,2)
__{}__{}    push DE             ; 1:11      __INFO   ( -- $1 )
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    db   0x21           ; 3:10      __INFO   = ld HL, $2
__{}__{}format({%-24s},$1:);           __INFO
__{}__{}    dw   format({%-15s},$2);           __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # _DVARIABLE(name)             --> (name) = 0
dnl # _DVARIABLE(name,100)         --> (name) = 100
dnl # _DVARIABLE(name,0x88442211)  --> (name) = 0x88442211
define({DVARIABLE},{dnl
__{}define({__PSIZE_}$1,4)dnl
__{}__ADD_TOKEN({__TOKEN_DVARIABLE},{dvariable $1 $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DVARIABLE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing parameter with variable name!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_REG($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__{}__IS_INSTRUCTION($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
__{}$#,{1},{dnl
__{}__{}define({__PSIZE_}$1,4){}dnl
__{}__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}__{}pushdef({LAST_HERE_ADD},4)dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},$1:);           }__INFO{
__{}__{}__{}    dw 0x0000           ;           }__INFO{
__{}__{}__{}    dw 0x0000           ;           }__INFO)},
__{}__IS_NUM($2),0,{
__{}__{}  .error {$0}($@): M4 does not know $2 parameter value!},
__{}{dnl
__{}__{}define({__PSIZE_}$1,4){}dnl
__{}__{}pushdef({LAST_HERE_NAME},$1)dnl
__{}__{}pushdef({LAST_HERE_ADD},4)dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}format({%-24s},$1:);           }__INFO{   ifelse(substr($2,0,2),{0x},eval($2),substr($2,0,2),{0X},eval($2),__HEX_DEHL($2)){}dnl
__{}__{}__{} = db __HEX_L($2) __HEX_H($2) __HEX_E($2) __HEX_D($2)
__{}__{}__{}    dw __HEX_HL($2)           ;           }__INFO{   = eval(($2) & 0xffff)
__{}__{}__{}    dw __HEX_DE($2)           ;           }__INFO{   = eval((($2) >> 16) & 0xffff)})}){}dnl
}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl
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
__{}__{}format({%-24s},{$1:});}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # HERE
define({HERE},{dnl
__{}__ADD_TOKEN({__TOKEN_HERE},{here},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HERE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # allot     --> reserve TOS bytes
define({ALLOT},{dnl
__{}__ADD_TOKEN({__TOKEN_ALLOT},{allot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ALLOT},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}  .error __INFO{($@): Sorry, but ALLOT only supports constant allocation size, such as "PUSH(8) ALLOT"}dnl
}){}dnl
dnl
dnl
dnl
dnl # PUSH_ALLOT(8)      --> reserve 8 bytes
define({PUSH_ALLOT},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_ALLOT},{$1 allot},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_ALLOT},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
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
__{}__ADD_TOKEN({__TOKEN_COMMA},{{,}},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_COMMA},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#>0),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{
__{}__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)){,}HL); 3:16      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO{}dnl
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2))dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}    dw 0x0000           ;           __INFO})})}){}dnl
dnl
dnl
dnl
dnl # PUSH_COMMA(8)      --> reserve one word = 8
define({PUSH_COMMA},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_COMMA},{$1 {,}},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_COMMA},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<1),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}{dnl
__{}__{}define({_TMP_INFO},{{__INFO}}){}dnl
__{}__{}__LD_REG16({BC},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)){,}BC); 4:20      __INFO{}dnl
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2))dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}    dw format({%-17s},$1);           }__CONCATENATE_WITH({ },__INFO){comma})}){}dnl
}){}dnl
dnl
dnl
dnl
define({__PUSHS_COMMA_REC},{dnl
__{}ifelse({debug},{},{
__{}rec:$@
__{}BC            >__TEMP_BC<
__{}HL            >__TEMP_HL<
__{}before val    >__SORT_VAL$1<
__{}before offset >__SORT_OFFSET$1<
__{}now val       >__SORT_VAL$2<
__{}noe offset    >__SORT_OFFSET$2<
__{}next val      >__SORT_VAL$3<
__{}next offset   >__SORT_OFFSET$3<}){}dnl
__{}undefine({_TMP_INFO}){}dnl
__{}dnl # BC variant
__{}ifelse(eval($#>2),{1},{__LD_REG16({HL},__SORT_VAL$3,{HL},__TEMP_HL,{BC},__SORT_VAL$2)},{define({__PRICE_16BIT},0)}){}dnl
__{}define({__PUSHS_COMMA_REC_BC_P},__PRICE_16BIT){}dnl
__{}__LD_REG16({BC},__SORT_VAL$2,{HL},__TEMP_HL,BC,__TEMP_BC){}dnl
__{}define({__PUSHS_COMMA_REC_BC_P},eval(8+__PUSHS_COMMA_REC_BC_P+__PRICE_16BIT)){}dnl
__{}dnl # HL variant
__{}__{}ifelse(eval($#>2),{1},{__LD_REG16({HL},__SORT_VAL$3,{HL},__SORT_VAL$2,{BC},__TEMP_BC)},{define({__PRICE_16BIT},0)}){}dnl
__{}define({__PUSHS_COMMA_REC_HL_P},__PRICE_16BIT){}dnl
__{}__LD_REG16({HL},__SORT_VAL$2,{HL},__TEMP_HL,{BC},__TEMP_BC){}dnl
__{}define({__PUSHS_COMMA_REC_HL_P},eval(__PUSHS_COMMA_REC_HL_P+__PRICE_16BIT)){}dnl
__{}dnl
__{}ifelse(eval(__PUSHS_COMMA_REC_HL_P<__PUSHS_COMMA_REC_BC_P),{1},{dnl # HL variant
__{}__{}define({__PUSHS_COMMA_C},eval(__PUSHS_COMMA_C+__CLOCKS_16BIT+16)){}dnl
__{}__{}define({__PUSHS_COMMA_B},eval(__PUSHS_COMMA_B+__BYTES_16BIT+3)){}dnl
__{}__{}__{}define({_TMP_INFO},{__SORT_VAL$2 ,}){}define({__TEMP_HL},__SORT_VAL$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(__SORT_OFFSET$2,{0},{},+__SORT_OFFSET$2)){,}HL); 3:16      __SORT_VAL$2 ,{}dnl
__{}},
__{}{dnl
__{}__{}__LD_REG16({BC},$2,{HL},__TEMP_HL,{BC},__TEMP_BC){}dnl # BC variant
__{}__{}define({__PUSHS_COMMA_C},eval(__PUSHS_COMMA_C+__CLOCKS_16BIT+20)){}dnl
__{}__{}define({__PUSHS_COMMA_B},eval(__PUSHS_COMMA_B+__BYTES_16BIT+4)){}dnl
__{}__{}__{}define({_TMP_INFO},{__SORT_VAL$2 ,}){}define({__TEMP_HL},__SORT_VAL$2){}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(__SORT_OFFSET$2,{0},{},+__SORT_OFFSET$2)){,}BC); 4:20      __SORT_VAL$2 ,}){}dnl
__{}ifelse(eval($#>2),{1},{__PUSHS_COMMA_REC(shift($@))})}){}dnl
dnl
dnl
define({__PUSHS_COMMA_SORTED},{dnl
__{}define({__INFO},{push_comma}){}dnl
ifelse({debug},{},{
sorted:$@
now val     = __SORT_VAL$1
now offset  = __SORT_OFFSET$1
next val    = __SORT_VAL$2
next offset = __SORT_OFFSET$2}){}dnl
__{}define({__PUSHS_COMMA_C},47){}dnl
__{}define({__PUSHS_COMMA_B},8)
__{}    push HL             ; 1:11      __SHORT_INFO   default version
__{}    ld   HL, format({%-11s},__SORT_VAL$1); 3:10      __SORT_VAL$1 ,{}define({__TEMP_HL},__SORT_VAL$1){}define({__TEMP_BC},{})
__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(__SORT_OFFSET$1,{0},{},+__SORT_OFFSET$1)){,}HL); 3:16      __SORT_VAL$1 ,{}dnl
__{}__PUSHS_COMMA_REC($@)
__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+$#+$#)){}dnl
__{}                        ;format({%-11s},[__PUSHS_COMMA_B:__PUSHS_COMMA_C])__SHORT_INFO}){}dnl
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
__{}__{}ifelse(__IS_MEM_REF($2){x}__HEX_H($2){_}__HEX_L($2),__IS_MEM_REF($1){x}__HEX_L(2*__HEX_H($1)){_}__HEX_L($1),{define({__PUSHS_COMMA_ANALYSIS_HI2MUL},eval(1+__PUSHS_COMMA_ANALYSIS_HI2MUL))}){}dnl
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
__{}__{}    dw format({%-17s},$1);           $1 comma}){}dnl
__{}ifelse(eval($#>2),{1},{__PUSHS_COMMA_ANALYSIS(shift($@))},
__{}{dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}    dw format({%-17s},$2);           $2 comma})}){}dnl
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
eval($#),{2},   {
__{}undefine({__COMMA}){}dnl
__{}define({_TMP_INFO},$1{ }__COMMA){}dnl
__{}__LD_REG16({BC},$1){}dnl
__{}define({__COMMA},{,}){}dnl
__{}__CODE_16BIT
__{}    ld  format({%-16s},(LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)){,}BC); 4:20      $1 ,{}dnl
__{}undefine({__COMMA}){}dnl
__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2)){}dnl
__{}define({_TMP_INFO},$2{ }__COMMA){}dnl
__{}__LD_REG16({BC},$2,{BC},$1){}dnl
__{}define({__COMMA},{,}){}dnl
__{}__CODE_16BIT
__{}    ld  format({%-16s},(LAST_HERE_NAME{}+LAST_HERE_ADD){,}BC); 4:20      $2 ,{}dnl
__{}undefine({__COMMA}){}dnl
__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2))dnl
__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}    dw format({%-17s},$1);           $1 comma
__{}__{}    dw format({%-17s},$2);           $2 comma})},
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
__{}define({__SHORT_INFO},{$1 , $2 , ... __PUSHS_COMMA_ANALYSIS_LAST ,}){}dnl
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
__{}__{}    push HL             ; 1:11      __SHORT_INFO   +1
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_L($1))     ; 3:10      __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    inc   C             ; 1:4       __SHORT_INFO
__{}__{}    djnz $-6            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[16:eval(36+$#*46)])__SHORT_INFO},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_ADD256==$#),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   +256
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_H($1))     ; 3:10      __SHORT_INFO
__{}__{}    ld  (HL),__HEX_L($1)       ; 2:10      __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    inc   C             ; 1:4       __SHORT_INFO
__{}__{}    djnz $-6            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[16:eval(36+$#*46)])__SHORT_INFO},
__{}eval($#>4 && __PUSHS_COMMA_ANALYSIS_ADD16==$# && $#<256),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   +1 16-bit
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __SHORT_INFO
__{}__{}    ld    A, __HEX_L(__PUSHS_COMMA_ANALYSIS_LAST+1)       ; 2:7       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),B          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    inc  BC             ; 1:6       __SHORT_INFO
__{}__{}    cp    C             ; 1:4       __SHORT_INFO
__{}__{}    jr   nz, $-6        ; 2:7/12    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[18:eval(43+48*$#)])__SHORT_INFO},
__{}eval($#>5 && __PUSHS_COMMA_ANALYSIS_ADD16==$#),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   +1 16-bit
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __SHORT_INFO
__{}__{}    ld    A, __HEX_L(__PUSHS_COMMA_ANALYSIS_LAST+1)       ; 2:7       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),B          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    inc  BC             ; 1:6       __SHORT_INFO
__{}__{}    cp    C             ; 1:4       __SHORT_INFO
__{}__{}    jr   nz, $-6        ; 2:7/12    __SHORT_INFO
__{}__{}    ld    A, __HEX_H(__PUSHS_COMMA_ANALYSIS_LAST+1)       ; 2:7       __SHORT_INFO
__{}__{}    cp    B             ; 1:4       __SHORT_INFO
__{}__{}    jr   nz, $-13       ; 2:7/12    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[23:cca eval(36+48*$#+(1+LAST_HERE_ADD/256-$1/256)*23)])__SHORT_INFO},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_SUB1==$# && __PUSHS_COMMA_ANALYSIS_LAST_NUM==1),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   -1 to 1
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(__HEX_L($1))     ; 3:10      __SHORT_INFO
__{}__{}    ld  (HL),B          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    djnz $-4            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[14:eval(36+$#*39)])__SHORT_INFO},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_SUB1==$#),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   -1
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_L($1))     ; 3:10      __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    dec   C             ; 1:4       __SHORT_INFO
__{}__{}    djnz $-6            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[16:eval(36+$#*46)])__SHORT_INFO},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_SUB256==$# && __PUSHS_COMMA_ANALYSIS_LAST_NUM==256),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   -256 to 256
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#))     ; 3:10      __SHORT_INFO
__{}__{}    ld  (HL),B          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    djnz $-4            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[14:eval(36+$#*39)])__SHORT_INFO},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_SUB256==$#),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   -256
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_H($1))     ; 3:10      __SHORT_INFO
__{}__{}    ld  (HL),__HEX_L($1)       ; 2:10      __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    dec   C             ; 1:4       __SHORT_INFO
__{}__{}    djnz $-6            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[16:eval(36+$#*46)])__SHORT_INFO},
__{}eval($#>4 && __PUSHS_COMMA_ANALYSIS_SUB16==$# && $#<256),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   -1 16-bit
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL($1)     ; 3:10      __SHORT_INFO
__{}__{}    ld    A, __HEX_L(__PUSHS_COMMA_ANALYSIS_LAST-1)       ; 2:7       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),B          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    dec  BC             ; 1:6       __SHORT_INFO
__{}__{}    cp    C             ; 1:4       __SHORT_INFO
__{}__{}    jr   nz, $-6        ; 2:7/12    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[18:eval(43+48*$#)])__SHORT_INFO},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_LO2MUL==$#),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   2xlo
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_H($1))     ; 3:10      __SHORT_INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __SHORT_INFO
__{}__{}    ld  (HL),A          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    add   A, A          ; 1:4       __SHORT_INFO
__{}__{}    djnz $-5            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[17:eval(43+$#*43)])__SHORT_INFO},
__{}eval($#>3 && __PUSHS_COMMA_ANALYSIS_HI2MUL==$#),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   2xhi
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_L($1))     ; 3:10      __SHORT_INFO
__{}__{}    ld    A, __HEX_H($1)       ; 2:7       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),A          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    add   A, A          ; 1:4       __SHORT_INFO
__{}__{}    djnz $-5            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[17:eval(43+$#*43)])__SHORT_INFO},
__{}eval($#>4 && __PUSHS_COMMA_ANALYSIS_2MUL==$#),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   2x
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_H($1))     ; 3:10      __SHORT_INFO
__{}__{}    ld    A, __HEX_L($1)       ; 2:7       __SHORT_INFO
__{}__{}    ld  (HL),A          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    add   A, A          ; 1:4       __SHORT_INFO
__{}__{}    rl    C             ; 2:8       __SHORT_INFO
__{}__{}    djnz $-7            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[19:eval(43+$#*51)])__SHORT_INFO},
__{}eval($#>4 && __PUSHS_COMMA_ANALYSIS_SAME==$# && $#<257),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   +0
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+__HEX_L($1))     ; 3:10      __SHORT_INFO
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO{}ifelse(__HEX_H($1),__HEX_L($1),{
__{}__{}    ld  (HL),C          ; 1:7       __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    djnz $-4            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[14:eval(36+39*$#)])__SHORT_INFO},{
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    djnz $-5            ; 2:8/13    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[15:eval(36+42*$#)])__SHORT_INFO})},
__{}eval($#>256 && __PUSHS_COMMA_ANALYSIS_SAME==$#),{1},{
__{}__{}    push HL             ; 1:11      __SHORT_INFO   +0
__{}__{}    ld   HL, format({%-11s},LAST_HERE_NAME{}ifelse(eval(LAST_HERE_ADD!=0),1,+LAST_HERE_ADD)); 3:10      __SHORT_INFO
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+2*$#)){}dnl
__{}__{}    ld   BC, __HEX_HL(256*__HEX_L($#)+1+__HEX_H($#))     ; 3:10      __SHORT_INFO
__{}__{}    ld  (HL),__HEX_L($1)       ; 2:10      __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    ld  (HL),__HEX_H($1)       ; 2:10      __SHORT_INFO
__{}__{}    inc  HL             ; 1:6       __SHORT_INFO
__{}__{}    djnz nz, $-6        ; 2:8/13    __SHORT_INFO
__{}__{}    dec   C             ; 1:4       __SHORT_INFO
__{}__{}    jr   nz, $-9        ; 2:7/12    __SHORT_INFO
__{}__{}    pop  HL             ; 1:10      __SHORT_INFO
__{}__{}                        ;format({%-11s},[18:eval(36+45*$#+11*__HEX_H(256+$#))])__SHORT_INFO},
__{}{dnl
__{}__{}undefine({__COMMA}){}dnl
__{}__{}__SORT({a},LAST_HERE_ADD,$@){}dnl
__{}__{}__PUSHS_COMMA_SORTED(__SORT_SHOW({a})){}dnl
__{}}){}dnl
})}){}dnl
dnl
dnl
dnl
define({HEXPUSH_COMMA_REC},{dnl
__{}ifelse(eval(len($1)>=4),1,{dnl
__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x{}substr($1,eval(len($1)-4))){}dnl
__{}__{}HEXPUSH_COMMA_REC(substr($1,0,eval(len($1)-4)))},
__{}eval(len($1)>0),1,{
__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x{}$1){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({HEXPUSH_COMMA},{dnl
__{}ifelse(dnl
__{}$1,{},{},
__{}$1,{0x},{},
__{}$1,{0X},{},
__{}substr($1,0,2),{0x},{HEXPUSH_COMMA_REC(substr($1,2))},
__{}substr($1,0,2),{0X},{HEXPUSH_COMMA_REC(substr($1,2))},
__{}{dnl
__{}__{}HEXPUSH_COMMA_REC($1){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__NO_LEADING_ZERO},{dnl
__{}ifelse(dnl
__{}len($1),1,{$1},
__{}substr($1,0,1),0,{__NO_LEADING_ZERO(substr($1,1))},
__{}{$1})}){}dnl
dnl
dnl
dnl
define({__STR10_DIV_16},{dnl
ifelse(1,0,{errprint({
}len($1),$1,$2{
})}){}dnl
__{}ifelse(eval(len($1)<9),1,{dnl
__{}__{}define({__STR10_MOD_16},eval((__NO_LEADING_ZERO($1)+$2)%16)){}dnl
__{}__{}eval((__NO_LEADING_ZERO($1)+$2)/16,10,8)},
__{}eval(len($1)%8),0,{dnl
__{}__{}eval((__NO_LEADING_ZERO(substr($1,0,8))+$2)/16,10,8){}dnl
__{}__{}__STR10_DIV_16(substr($1,8),eval(((__NO_LEADING_ZERO(substr($1,0,8))+$2)%16)*100000000))},
__{}{dnl
__{}__{}ifelse(eval((substr($1,0,eval(len($1)%8))+$2)>15),1,eval((substr($1,0,eval(len($1)%8))+$2)/16)){}dnl
__{}__{}__STR10_DIV_16(substr($1,eval(len($1)%8)),eval(((substr($1,0,eval(len($1)%8))+$2)%16)*100000000)){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__STR10_TO_STR16_REC},{dnl
__{}ifelse(eval(len($1)>8),1,{dnl
__{}__{}define({__TEMP},__NO_LEADING_ZERO(__STR10_DIV_16(__NO_LEADING_ZERO($1),0))){}dnl
__{}__{}define({__RES_HEX},eval(__STR10_MOD_16,16){}__RES_HEX){}dnl
ifelse(1,0,{errprint({
}>__TEMP:eval(__STR10_MOD_16,16)<)}){}dnl
__{}__{}__STR10_TO_STR16_REC(__TEMP){}dnl
__{}},
__{}{dnl
__{}__{}define({__RES_HEX},eval($1,16){}__RES_HEX){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__STR10_TO_STR16},{dnl
__{}define({__RES_HEX},{}){}dnl
__{}__STR10_TO_STR16_REC($1){}dnl
__{}__RES_HEX}){}dnl
dnl
dnl
dnl
define({DECPUSH_COMMA},{dnl
__{}ifelse(dnl
__{}$1,{},{},
__{}$1,{0x},{},
__{}$1,{0X},{},
__{}substr($1,0,2),{0x},{HEXPUSH_COMMA_REC(substr($1,2))},
__{}substr($1,0,2),{0X},{HEXPUSH_COMMA_REC(substr($1,2))},
__{}{dnl
__{}__{}DECPUSH_COMMA_REC($1){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({PHEXPUSH_COMMA_REC},{dnl
dnl errprint({
dnl }$1,$2){}dnl
__{}ifelse(eval($1>1),1,{dnl
__{}__{}ifelse(len($2),0,{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x0000)},
__{}__{}len($2),1,{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x000{}$2)},
__{}__{}len($2),2,{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x00{}$2)},
__{}__{}len($2),3,{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x0{}$2)},
__{}__{}len($2),4,{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x{}$2)},
__{}__{}{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x{}substr($2,eval(len($2)-4)))}){}dnl
__{}__{}$0(eval($1-2),substr($2,0,eval(len($2)-4)))},
__{}$1,1,{
__{}__{}ifelse(len($2),0,{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x00)},
__{}__{}len($2),1,{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x0{}$2)},
__{}__{}len($2),2,{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x{}$2)},
__{}__{}{dnl
__{}__{}__{}__ADD_TOKEN({__TOKEN_PUSHS_COMMA},{pushs_comma},0x00{}substr($2,eval(len($2)-2)))
__{}__{}__{}  .warning Pocatek hex retezce 0x{}substr($2,0,eval(len($2)-2)) se uz nevleze do alokovaneho prostoru!})},
__{}$1,0,{
__{}__{}ifelse(len($2),0,,{
__{}__{}__{}  .warning Pocatek hex retezce 0x{}$2 se uz nevleze do alokovaneho prostoru!}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({PHEXPUSH_COMMA},{dnl
__{}ifelse(dnl
__{}$2,{},{},
__{}$2,{0x},{},
__{}$2,{0X},{},
__{}substr($2,0,2),{0x},{PHEXPUSH_COMMA_REC($1,substr($2,2))},
__{}substr($2,0,2),{0X},{PHEXPUSH_COMMA_REC($1,substr($2,2))},
__{}{dnl
__{}__{}PHEXPUSH_COMMA_REC($1,$2){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({DECPUSH_COMMA},{dnl
__{}HEXPUSH_COMMA_REC(__STR10_TO_STR16($1)){}dnl
}){}dnl
dnl
dnl
dnl
define({PDECPUSH_COMMA},{dnl
__{}PHEXPUSH_COMMA_REC($1,__STR10_TO_STR16($2)){}dnl
}){}dnl
dnl
dnl
dnl
dnl # PCONSTANT(bytes,100,name)    --> (name) = 100
dnl # PCONSTANT(bytes,0x8877665544332211,name) --> (name) = 0x00...008877665544332211
define({PCONSTANT},{dnl
__{}ifelse(eval($#<3),1,{
__{}__{}  .error {$0}(bytes,value,name): Missing  parameters!},
__{}eval($#>3),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}  .error {$0}($@): Parameter is pointer!},
__{}__IS_NUM($1),{0},{
__{}__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__{}__SAVE_EVAL($1),{0},{
__{}__{}  .error {$0}($@): The parameter is 0!},
__{}__SAVE_EVAL($1>256),{1},{
__{}__{}  .error {$0}($@): The parameter is greater than 256!},
__{}__SAVE_EVAL($1<0),{1},{
__{}__{}  .error {$0}($@): The parameter is negative!},
__{}__IS_REG($3),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$3}},
__{}__IS_INSTRUCTION($3),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$3}},
__{}{dnl
__{}define({__PSIZE_}$3,$1)dnl
__{}__{}NO_SEGMENT($1){}dnl
__{}__{}ifelse(dnl
__{}__{}__{}substr($2,0,2),{0x},{__ADD_TOKEN({__TOKEN_PCONSTANT},{p}$1{constant }$2,$1,substr($2,2),$3)},
__{}__{}__{}substr($2,0,2),{0X},{__ADD_TOKEN({__TOKEN_PCONSTANT},{p}$1{constant }$2,$1,substr($2,2),$3)},
__{}__{}__{}{__ADD_TOKEN({__TOKEN_PCONSTANT},{p}$1{constant }$2,$1,__STR10_TO_STR16($2),$3,$2)}){}dnl
__{}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PCONSTANT},{dnl
__{}__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<4),1,{
__{}__{}  .error {$0}(bytes,hex_value,name,orig_value): Missing  parameters!},
__{}eval($#>4),1,{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),1,{
__{}__{}  .error {$0}($@): Parameter is pointer!},
__{}__IS_NUM($1),0,{
__{}__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__{}__SAVE_EVAL($1),0,{
__{}__{}  .error {$0}($@): The parameter is 0!},
__{}__SAVE_EVAL($1>256),1,{
__{}__{}  .error {$0}($@): The parameter is greater than 256!},
__{}__SAVE_EVAL($1<0),1,{
__{}__{}  .error {$0}($@): The parameter is negative!},
__{}__IS_REG($3),1,{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$3}},
__{}__IS_INSTRUCTION($3),1,{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$3}},
__{}{dnl
__{}__{}define({__PSIZE_}$3,$1){}dnl
__{}__{}pushdef({LAST_HERE_NAME},$3)dnl
__{}__{}pushdef({LAST_HERE_ADD},$1)dnl
__{}__{}ifelse($4,,{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}$3:})},
__{}__{}{dnl
__{}__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}__{}}format({%-24s},{$3:}){; = }$4)}){}dnl
__{}__{}__ALLOC_CONST_REC(eval($1),$2,$3){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # PVALUE(bytes,name)
define({PVALUE},{dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}(bytes,name): Missing  parameters!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}  .error {$0}($@): Parameter is pointer!},
__{}__IS_NUM($1),{0},{
__{}__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__{}__SAVE_EVAL($1),{0},{
__{}__{}  .error {$0}($@): The parameter is 0!},
__{}__SAVE_EVAL($1>256),{1},{
__{}__{}  .error {$0}($@): The parameter is greater than 256!},
__{}__SAVE_EVAL($1<0),{1},{
__{}__{}  .error {$0}($@): The parameter is negative!},
__{}__IS_REG($2),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$2}},
__{}__IS_INSTRUCTION($2),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$2}},
__{}{dnl
__{}__{}define({__PSIZE_}$2,$1){}dnl
__{}__{}__ADD_TOKEN({__TOKEN_PVALUE},{p}$1{value }$2,$@){}dnl
__{}}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PVALUE},{dnl
__{}__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}(bytes,name): Missing  parameters!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}  .error {$0}($@): Parameter is pointer!},
__{}__IS_NUM($1),{0},{
__{}__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__{}__SAVE_EVAL($1),{0},{
__{}__{}  .error {$0}($@): The parameter is 0!},
__{}__SAVE_EVAL($1>256),{1},{
__{}__{}  .error {$0}($@): The parameter is greater than 256!},
__{}__SAVE_EVAL($1<0),{1},{
__{}__{}  .error {$0}($@): The parameter is negative!},
__{}__IS_REG($2),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$2}},
__{}__IS_INSTRUCTION($2),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$2}},
__{}{dnl
__{}__{}define({__PSIZE_}$2,$1){}dnl
__{}__{}__ASM_TOKEN_NO_SEGMENT($1){}dnl
__{}__{}__ASM_TOKEN_CREATE($2){}dnl
__{}__{}pushdef({LAST_HERE_ADD},$1)dnl
__{}__{}__ALLOC_CONST_REC($1,,$2){}dnl
__{}__{}__ASM_TOKEN_TO($2){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # PPUSH_VALUE(bytes,100,name)    --> (name) = 100
dnl # PPUSH_VALUE(bytes,0x8877665544332211,name) --> (name) = 0x00...008877665544332211
define({PPUSH_VALUE},{dnl
__{}ifelse(eval($#<3),1,{
__{}__{}  .error {$0}(bytes,value,name): Missing  parameters!},
__{}eval($#>3),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1),{1},{
__{}__{}  .error {$0}($@): Parameter is pointer!},
__{}__IS_NUM($1),{0},{
__{}__{}  .error {$0}($@): M4 does not know $1 parameter value!},
__{}__SAVE_EVAL($1),{0},{
__{}__{}  .error {$0}($@): The parameter is 0!},
__{}__SAVE_EVAL($1>256),{1},{
__{}__{}  .error {$0}($@): The parameter is greater than 256!},
__{}__SAVE_EVAL($1<0),{1},{
__{}__{}  .error {$0}($@): The parameter is negative!},
__{}__IS_REG($3),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$3}},
__{}__IS_INSTRUCTION($3),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$3}},
__{}{dnl
__{}__{}define({__PSIZE_}$3,$1){}dnl
__{}__{}NO_SEGMENT($1){}dnl
__{}__{}CREATE($3){}dnl
__{}__{}ifelse(dnl
__{}__{}__{}substr($2,0,2),{0x},{PHEXPUSH_COMMA_REC($1,substr($2,2))},
__{}__{}__{}substr($2,0,2),{0X},{PHEXPUSH_COMMA_REC($1,substr($2,2))},
__{}__{}__{}{PHEXPUSH_COMMA_REC($1,__STR10_TO_STR16($2))}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # BUFFER(name,8)      --> Reserve 8 bytes
define({BUFFER},{dnl
__{}__ADD_TOKEN({__TOKEN_BUFFER},{buffer $1 $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_BUFFER},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing name parameter!},
__{}eval($#>2),{1},{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_REG($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the registry name! Try: _{$1}},
__{}__IS_INSTRUCTION($1),{1},{
__{}__{}  .error {$0}($@): The variable name is identical to the instruction name! Try: _{$1}},
__{}$#,{1},{
__{}__{}  .error {$0}(): Missing byte size parameter!},
__{}__IS_MEM_REF($2),1,{
__{}__{}  .error {$0}($@): $2 is memory pointer!},
__{}__IS_NUM($2),0,{
__{}__{}  .error {$0}($@): M4 does not know $2 parameter value!},
__{}{dnl
__{}__{}define({LAST_HERE_ADD},eval(LAST_HERE_ADD+$2)){}dnl
__{}__{}define({ALL_VARIABLE},ALL_VARIABLE{
__{}__{}__{}format({%-24s},$1:);           __INFO
__{}__{}__{}    ds format({%-17s},$2);           __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl # -------------------------------------------------------------------------------------
dnl ## Memory access 8bit
dnl # -------------------------------------------------------------------------------------
dnl
dnl # c@
dnl # ( addr -- char )
dnl # fetch 8-bit char from addr
define({CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_CFETCH},{c@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CFETCH},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    L,(HL)        ; 1:7       __INFO   ( addr -- char )
    ld    H, 0x00       ; 2:7       __INFO}){}dnl
dnl
dnl
dnl # h@
dnl # ( addr -- char )
dnl # fetch 8-bit char from addr
define({HFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_HFETCH},{h@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HFETCH},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    H,(HL)        ; 1:7       __INFO   ( addr -- char )
    ld    L, 0x00       ; 2:7       __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:29]     __INFO   ( addr -- addr char )
    push DE             ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    ld    D, 0x00       ; 2:7       __INFO
    ex   DE, HL         ; 1:4       __INFO}){}dnl
dnl
dnl
dnl # 2over nip c@
dnl # ( addr d -- addr d char )
define({_2OVER_NIP_CFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_CFETCH},{2over nip c@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_CFETCH},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:54]     __INFO   ( addr x2 x1 -- addr x2 x1 n )  n = (addr) & 0xFF
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    A,(BC)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ld    H, 0x00       ; 2:7       __INFO}){}dnl
dnl
dnl
dnl # 2over nip h@
dnl # ( addr d -- addr d char )
define({_2OVER_NIP_HFETCH},{dnl
__{}__ADD_TOKEN({__TOKEN_2OVER_NIP_HFETCH},{2over nip h@},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2OVER_NIP_HFETCH},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:54]     __INFO   ( addr x2 x1 -- addr x2 x1 x )  x = (addr) << 8
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    A,(BC)        ; 1:7       __INFO
    ld    L, 0x00       ; 2:7       __INFO
    ld    H, A          ; 1:4       __INFO
}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
                        ;[4:25]     __INFO   ( addr -- char addr )
    push DE             ; 1:11      __INFO
    ld    E,(HL)        ; 1:7       __INFO
    ld    D, 0x00       ; 2:7       __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:29]     __INFO   ( addr2 addr1 -- char1 char2 )
    ld    L,(HL)        ; 1:7       __INFO
    ld    H, 0x00       ; 2:7       __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld    L,(HL)        ; 1:7       __INFO
    ld    H, D          ; 1:4       __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:29]     __INFO   ( addr2 addr1 -- char2 char1 )
    ld    L, (HL)       ; 1:7       __INFO
    ld    H, 0x00       ; 2:7       __INFO
    ld    A, (DE)       ; 1:7       __INFO
    ld    E, A          ; 1:4       __INFO
    ld    D, H          ; 1:4       __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
                        ;[8:51]     __INFO   ( addr2 addr1 -- addr2 addr1 char2 char1 )
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ld    L, (HL)       ; 1:7       __INFO
    ld    H, 0x00       ; 2:7       __INFO
    ld    A, (DE)       ; 1:7       __INFO
    ld    E, A          ; 1:4       __INFO
    ld    D, H          ; 1:4       __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL,format({%-12s},$1); 3:16      __INFO
__{}__{}    ld    L,(HL)        ; 1:7       __INFO
__{}__{}    ld    H, 0x00       ; 2:7       __INFO},
__{}{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO
__{}__{}    ld   HL,format({%-12s},($1)); 3:16      __INFO
__{}__{}    ld    H, 0x00       ; 2:7       __INFO}){}dnl
}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}__{}eval($#>2),1,{
__{}__{}  .error {$0}($@):  Unexpected parameter!},
__{}{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld    A,format({%-12s},($1)); 3:13      __INFO
__{}__{}    ld    D, 0x00       ; 2:7       __INFO
__{}__{}    ld    E, A          ; 1:4       __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({HL},$2,{D},0x00){}dnl
__{}__{}__CODE_16BIT}){}dnl
}){}dnl
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
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}$1:$2:__IS_MEM_REF($2),$2:$2:1,{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({HL},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld    E,(HL)        ; 1:7       __INFO
__{}__{}    ld    D, 0x00       ; 2:7       __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO},
__{}__IS_MEM_REF($2),1,{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$1){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}__LD_REG16({HL},$2,{DE},$1){}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld    L,(HL)        ; 1:7       __INFO{}dnl
__{}__{}__LD_R_NUM(__INFO,{H},0x00,{D},__HEX_H($1),{E},__HEX_L($1))},
__{}{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},{($2)}); 3:16      __INFO
__{}__{}    ld    H, 0x00       ; 2:7       __INFO{}dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({DE},$1,{H},0x00){}dnl
__{}__{}__CODE_16BIT}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<1),1,{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1):_TYP_SINGLE,1:fast,{
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({HL},$1){}dnl
__{}__{}                       ;[10:47]     __INFO  ( x -- x+$1 )  # fast version can be changed with "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    ld    B, H          ; 1:4       __INFO{}dnl
__{}__{}__CODE_16BIT
__{}__{}    add   A,(HL)        ; 1:7       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    adc   A, B          ; 1:4       __INFO
__{}__{}    sub   L             ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO},
__{}__IS_MEM_REF($1),1,{
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({HL},$1){}dnl
__{}__{}                        ;[9:49]     __INFO  ( x -- x+$1 )  # default version can be changed with "define({_TYP_SINGLE},{fast})"
__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}    ld    B, H          ; 1:4       __INFO{}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld    L,(HL)        ; 1:7       __INFO
__{}__{}    ld    H, 0x00       ; 2:7       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO},
__{}__IS_MEM_REF($1):_TYP_SINGLE,1:fast,{;# never use
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({BC},$1){}dnl
__{}__{}                       ;[10:47]     __INFO{}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld    A,(BC)        ; 1:7       __INFO   ( x -- x+$1 )
__{}__{}    add   A, L          ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    adc   A, H          ; 1:4       __INFO
__{}__{}    sub   L             ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO},
__{}__IS_MEM_REF($1),1,{;# never use
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({BC},$1){}dnl
__{}__{}                        ;[9:49]     __INFO{}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld    A,(BC)        ; 1:7       __INFO   ( x -- x+$1 )
__{}__{}    ld    B, 0x00       ; 2:7       __INFO
__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO},
__{}_TYP_SINGLE,fast,{
__{}__{}                        ;[8:33]     __INFO  ( x -- x+($1) )  # fast version can be changed with "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A,format({%-12s},($1)); 3:13      __INFO
__{}__{}    add   A, L          ; 1:4       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    adc   A, H          ; 1:4       __INFO
__{}__{}    sub   L             ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO},
__{}{
__{}__{}                        ;[7:35]     __INFO  ( x -- x+($1) )  # default version can be changed with "define({_TYP_SINGLE},{fast})"
__{}__{}    ld    A,format({%-12s},($1)); 3:13      __INFO
__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}    ld    B, 0x00       ; 2:7       __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr C@ -
dnl # ( x -- x-(addr) )
dnl # push_cfetch(addr), sub 8-bit char from addr
define({PUSH_CFETCH_SUB},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CFETCH_SUB},{$1 c@ -},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CFETCH_SUB},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<1),1,{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1):_TYP_SINGLE,1:fast,{
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({HL},$1){}dnl
__{}__{}                       ;[10:47]     __INFO  ( x -- x-$1 )  # fast version can be changed with "define({_TYP_SINGLE},{default})"
__{}__{}    ld    A, L          ; 1:4       __INFO
__{}__{}    ld    B, H          ; 1:4       __INFO{}dnl
__{}__{}__CODE_16BIT
__{}__{}    sub (HL)            ; 1:7       __INFO
__{}__{}    ld    L, A          ; 1:4       __INFO
__{}__{}    sbc   A, A          ; 1:4       __INFO
__{}__{}    add   A, B          ; 1:4       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO},
__{}__IS_MEM_REF($1),1,{
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__LD_REG16({BC},$1){}dnl
__{}__{}                        ;[9:50]     __INFO  ( x -- x-$1 ){}dnl
__{}__{}__CODE_16BIT{}  # default version can be changed with "define({_TYP_SINGLE},{fast})"
__{}__{}    ld    A,(BC)        ; 1:7       __INFO
__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 1:11      __INFO},
__{}{
__{}__{}                        ;[8:40]     __INFO  ( x -- x-$1 )
__{}__{}    ld    A,format({%-12s},($1)); 3:13      __INFO
__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}    xor   A             ; 1:4       __INFO
__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}    sbc  HL, BC         ; 2:15      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # C!
dnl # ( char addr -- )
dnl # store 8-bit char at addr
define({CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CSTORE},{c!},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_2DROP},{__dtto},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld  (HL),E          ; 1:7       __INFO   ( char addr -- )
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # swap 8 rshift swap C!
dnl # ( x addr -- )
dnl # store hi(x) at addr
define({HSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HSTORE},{h!},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_2DROP},{__dtto},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_HSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld  (HL),D          ; 1:7       __INFO   ( x addr -- )
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # dup addr C!
dnl # ( x -- x )
dnl # store 8-bit char lo8(tos) at addr
define({DUP_PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CSTORE},{dup $1 c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{define({__INFO},__COMPILE_INFO)
__{}    ld    A, L          ; 1:4       __INFO   ( x -- x ){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # dup 8 rshift addr C!
dnl # ( x -- x )
dnl # store hi8(tos) at addr
define({DUP_PUSH_HSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_HSTORE},{dup $1 h!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_HSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__{}{
__{}    ld    A, H          ; 1:4       __INFO   ( x -- x ){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl # addr C!
dnl # ( char -- )
dnl # store lo(tos) at addr
define({PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_CSTORE},{$1 c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_CSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}    ld   BC,format({%-12s},$1); 4:20      __INFO   ( x -- )
__{}    ld    A, L          ; 1:4       __INFO
__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}    ld    A, L          ; 1:4       __INFO   ( x -- )
__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO})
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO})}){}dnl
dnl
dnl
dnl # 8 rshift addr C!
dnl # ( x -- )
dnl # store hi(tos) at addr
define({PUSH_HSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_HSTORE},{$1 h!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_HSTORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}    ld   BC,format({%-12s},$1); 4:20      __INFO   ( x -- )
__{}    ld    A, H          ; 1:4       __INFO
__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}    ld    A, H          ; 1:4       __INFO   ( x -- )
__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO})
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
dnl # ( x -- x )
dnl # store(addr) store 8-bit lo8(x) at addr
define({DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dup $1 c! dup $2 c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing first address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
eval($#>2),1,{
__{}__{}.error {$0}($@): $# parameters found in macro!},
{
__{}    ld    A, L          ; 1:4       __INFO   ( x -- x )   A = lo8(x){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO}){}dnl
__{}ifelse(__IS_MEM_REF($2),1,{
__{}__{}    ld   BC,format({%-12s},$2); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($2){,} A); 3:13      __INFO}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr h!
dnl # ( x -- x )
dnl # store(addr) store 8-bit hi8(x) at addr
define({DUP_PUSH_HSTORE_DUP_PUSH_HSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE},{dup $1 h! dup $2 h!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing first address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
eval($#>2),1,{
__{}__{}.error {$0}($@): $# parameters found in macro!},
{
__{}    ld    A, H          ; 1:4       __INFO   ( x -- x )   A = hi8(x){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO}){}dnl
__{}ifelse(__IS_MEM_REF($2),1,{
__{}__{}    ld   BC,format({%-12s},$2); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($2){,} A); 3:13      __INFO}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr C!
dnl # ( x -- x )
dnl # store(addr) store 8-bit lo8(x) at addr
define({DUP_PUSH_CSTORE_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dup $1  c! dup $2 c! dup $3 c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE_DUP_PUSH_CSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing first address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
$3,{},{
__{}__{}.error {$0}(): Missing third address parameter!},
eval($#>3),1,{
__{}__{}.error {$0}($@): $# parameters found in macro!},
{
__{}    ld    A, L          ; 1:4       __INFO   ( x -- x )   A = lo8(x){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO}){}dnl
__{}ifelse(__IS_MEM_REF($2),1,{
__{}__{}    ld   BC,format({%-12s},$2); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($2){,} A); 3:13      __INFO}){}dnl
__{}ifelse(__IS_MEM_REF($3),1,{
__{}__{}    ld   BC,format({%-12s},$3); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($3){,} A); 3:13      __INFO}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr h!
dnl # ( x -- x )
dnl # store(addr) store 8-bit hi8(x) at addr
define({DUP_PUSH_HSTORE_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE},{dup $1  h! dup $2 h! dup $3 h!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE_DUP_PUSH_HSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing first address parameters!},
$2,{},{
__{}__{}.error {$0}(): Missing second address parameter!},
$3,{},{
__{}__{}.error {$0}(): Missing third address parameter!},
eval($#>3),1,{
__{}__{}.error {$0}($@): $# parameters found in macro!},
{
__{}    ld    A, H          ; 1:4       __INFO   ( x -- x )   A = hi8(x){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO}){}dnl
__{}ifelse(__IS_MEM_REF($2),1,{
__{}__{}    ld   BC,format({%-12s},$2); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($2){,} A); 3:13      __INFO}){}dnl
__{}ifelse(__IS_MEM_REF($3),1,{
__{}__{}    ld   BC,format({%-12s},$3); 4:20      __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}{
__{}__{}    ld   format({%-15s},($3){,} A); 3:13      __INFO}){}dnl
__{}}){}dnl
}){}dnl
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
dnl # tuck c!
dnl # ( x addr -- addr )
dnl # store 8-bit lo8(x) at addr with save addr
define({TUCK_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CSTORE},{tuck c!},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_NIP},{},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK_CSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[2:17]     __INFO   ( x addr -- addr )  (addr) = lo8(x)
    ld  (HL),E          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # tuck h!
dnl # ( char addr -- addr )
dnl # store 8-bit hi8(x) at addr with save addr
define({TUCK_HSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HSTORE},{tuck h!},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_NIP},{},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK_HSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[2:17]     __INFO   ( x addr -- addr )  (addr) = hi8(x)
    ld  (HL),D          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # tuck c! 1+
dnl # ( char addr -- addr+1 )
dnl # store 8-bit number at addr and increment
define({TUCK_CSTORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CSTORE},{tuck c! 1+}){}dnl
__{}__ADD_TOKEN({__TOKEN_NIP},{__dtto}){}dnl
__{}__ADD_TOKEN({__TOKEN_1ADD},{__dtto}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK_CSTORE_1ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[3:23]     __INFO   ( x addr -- addr+2 )
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # over swap c!
dnl # ( char addr -- char )
dnl # store 8-bit number at addr with save char
define({OVER_SWAP_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_CSTORE},{over swap c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_CSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[3:21]     __INFO   ( char addr -- char )
    ld  (HL),E          ; 1:7       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # over 8 rshift swap c!
dnl # ( x addr -- char )
dnl # store hi(x) at addr with save x
define({OVER_SWAP_HSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_HSTORE},{over swap h!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_HSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[3:21]     __INFO   ( x addr -- x )
    ld  (HL),D          ; 1:7       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup c!
dnl # ( x addr -- x addr )  (addr)=lo8(x)
dnl # store 8-bit number at addr with save all
define({_2DUP_CSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CSTORE},{2dup c!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[1:7]      __INFO   ( char addr -- char addr )  (addr)=lo8(x)
    ld  (HL),E          ; 1:7       __INFO}){}dnl
dnl
dnl
dnl # over 8 rshift over c!
dnl # ( x addr -- x addr )  (addr)=hi8(x)
dnl # store hi(x) at addr with save all
define({_2DUP_HSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HSTORE},{2dup h!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[1:7]      __INFO   ( x addr -- x addr )  (addr)=hi8(x)
    ld  (HL),D          ; 1:7       __INFO}){}dnl
dnl
dnl
dnl # 2dup c! 1+
dnl # ( x addr -- x addr+1 )  (addr)=lo8(x)
dnl # store 8-bit number at addr with save all and increment
define({_2DUP_CSTORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_CSTORE_1ADD},{2dup c! 1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_CSTORE_1ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[2:13]     __INFO   ( x addr -- x addr+1 )  (addr)=lo8(x)
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # 2dup h! 1+
dnl # ( x addr -- x addr+1 )  (addr)=hi8(x)
dnl # store 8-bit number at addr with save all and increment
define({_2DUP_HSTORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_HSTORE_1ADD},{2dup h! 1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_HSTORE_1ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[2:13]     __INFO   ( x addr -- x addr+1 )  (addr)=hi8(x)
    ld  (HL),D          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
    ld    A, H          ; 1:4       __INFO   ( from_addr to_addr u_chars -- )
    or    L             ; 1:4       __INFO
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO BC = u_chars
    pop  HL             ; 1:10      __INFO HL = from_addr
    jr    z, $+4        ; 2:7/12    __INFO
    ldir                ; 2:u*21/16 __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
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
__{}__{}__{}                        ;[4:34]     __INFO   ( from_addr to_addr -- )   u = 1 char
__{}__{}__{}    ld    A,(DE)        ; 1:7       __INFO
__{}__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__{}eval($1),{2},{
__{}__{}__{}                        ;[7:54]     __INFO   ( from_addr to_addr -- )   u = 2 chars
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}__{}    ldi                 ; 2:16      __INFO   1x
__{}__{}__{}    ld    A,(HL)        ; 1:7       __INFO
__{}__{}__{}    ld  (DE),A          ; 1:7       __INFO   2x
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__{}eval($1),{3},{
__{}__{}__{}                        ;[9:70]     __INFO   ( from_addr to_addr -- )   u = 3 chars
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}__{}    ldi                 ; 2:16      __INFO   1x
__{}__{}__{}    ldi                 ; 2:16      __INFO   2x
__{}__{}__{}    ld    A,(HL)        ; 1:7       __INFO
__{}__{}__{}    ld  (DE),A          ; 1:7       __INFO   3x
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
__{}    ld   HL,format({%-12s},{$1}); 3:16      __INFO   from_addr
__{}    ld    C,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    B,(HL)        ; 1:7       __INFO},
__IS_MEM_REF($2),{1},{
__{}    push HL             ; 1:11      __INFO   ( $1 $2 $3 -- )
__{}    ld   BC,format({%-12s},{($1)}); 4:20      __INFO},
__{}{
__{}    ld   BC,format({%-12s},{($1)}); 4:20      __INFO   ( $1 $2 $3 -- )}){}dnl
__{}ifelse(__IS_MEM_REF($2),{1},{
__{}    ld   HL,format({%-12s},{$2}); 3:16      __INFO   to_addr
__{}    ld  (HL),C          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),B          ; 1:7       __INFO
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
__{}__ADD_TOKEN({__TOKEN_CMOVEGT},{cmove>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_CMOVEGT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, H          ; 1:4       __INFO   ( from_addr to_addr u_chars -- )
    or    L             ; 1:4       __INFO
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   BC = u
    pop  HL             ; 1:10      __INFO   HL = from = addr1
    jr    z, $+4        ; 2:7/12    __INFO
    lddr                ; 2:u*21/16 __INFO   addr--
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}_TYP_SINGLE,{small},{
__{}    ;[17:cca 73+u*26+int(u/256)*24] __INFO  ( addr u char -- )  # small version can be changed with "define({_TYP_SINGLE},{default})"
__{}    ld    A, L          ; 1:4       __INFO  A  = char
__{}    pop  HL             ; 1:10      __INFO  HL = addr
__{}    ld    B, E          ; 1:4       __INFO
__{}    inc   D             ; 1:4       __INFO
__{}    inc   E             ; 1:4       __INFO
__{}    dec   E             ; 1:4       __INFO  u = DE = 0x..00?
__{}    jr    z, $+6        ; 2:7/12    __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    djnz $-2            ; 2:13/8    __INFO
__{}    dec   D             ; 1:4       __INFO
__{}    jr   nz, $-5        ; 2:7/12    __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
__{}_TYP_SINGLE,function,{__def({USE_Fill3})
__{}define({__SUM_BYTES},eval(3+1+1)){}dnl
__{}define({__SUM_CLOCKS},eval(17+10+10)){}dnl
__{}define({__TMP_CODE},{
__{}__{}    call Fill3          ; 3:17      __INFO{}dnl
__{}__{}__ASM_TOKEN_2DROP}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO  ( addr u char -- ) variant function{}dnl
__{}__TMP_CODE},
__{}{
__{}                      ;[21:94+u*21] __INFO  ( addr u char -- )  # default version can be changed with "define({_TYP_SINGLE},{small})"
__{}    ld    A, D          ; 1:4       __INFO
__{}    or    E             ; 1:4       __INFO
__{}    ld    A, L          ; 1:4       __INFO
__{}    pop  HL             ; 1:10      __INFO  HL = from
__{}    jr    z, $+15       ; 2:7/12    __INFO  u = 0?
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    dec  DE             ; 1:6       __INFO
__{}    ld    A, D          ; 1:4       __INFO
__{}    or    E             ; 1:4       __INFO
__{}    jr    z, $+9        ; 2:7/12    __INFO  u = 1?
__{}    ld    C, E          ; 1:4       __INFO
__{}    ld    B, D          ; 1:4       __INFO
__{}    ld    E, L          ; 1:4       __INFO
__{}    ld    D, H          ; 1:4       __INFO
__{}    inc  DE             ; 1:6       __INFO  DE = to
__{}    ldir                ; 2:u*21/16 __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr u char fill
dnl # ( addr u -- )
dnl # If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH_FILL},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FILL},{$1 fill},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FILL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<1),1,{
__{}__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}_TYP_SINGLE,small,{
__{}    ;[17:cca 66+u*26+int(u/256)*24] __INFO  ( addr u -- )  char = $1  # small version, change: "define({_TYP_SINGLE},{default})"
__{}    ld    A, format({%-11s},$1); 2:7       __INFO  A = char
__{}    ld    B, L          ; 1:4       __INFO
__{}    inc   H             ; 1:4       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    dec   L             ; 1:4       __INFO  u = HL = 0x..00?
__{}    jr    z, $+6        ; 2:7/12    __INFO
__{}    ld  (DE),A          ; 1:7       __INFO
__{}    inc  DE             ; 1:6       __INFO
__{}    djnz $-2            ; 2:13/8    __INFO
__{}    dec   H             ; 1:4       __INFO
__{}    jr   nz, $-5        ; 2:7/12    __INFO{}dnl
__{}__ASM_TOKEN_2DROP},
__{}_TYP_SINGLE,function,{__def({USE_Fill2})
__{}define({__SUM_BYTES},3+1+1){}dnl
__{}define({__SUM_CLOCKS},17+10+10){}dnl
__{}define({__TMP_CODE},__LD_R_NUM(__INFO{  A = char},A,$1){}dnl
__{}__{}{
__{}__{}    call Fill2          ; 3:17      __INFO{}dnl
__{}__{}__ASM_TOKEN_2DROP}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO  ( addr u -- ) fill(char)   variant function: fill(?){}dnl
__{}__TMP_CODE},
__{}{
__{}                      ;[20:83+u*21] __INFO  ( addr u -- )  char = $1  # default version, change: "define({_TYP_SINGLE},{small})"
__{}    ld    A, H          ; 1:4       __INFO
__{}    or    L             ; 1:4       __INFO
__{}    jr    z, $+16       ; 2:7/12    __INFO  u  = 0?
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, H          ; 1:4       __INFO
__{}    ld    L, E          ; 1:4       __INFO
__{}    ld    H, D          ; 1:4       __INFO  HL = from
__{}    ld  (HL),format({%-11s},$1); 2:10      __INFO
__{}    dec  BC             ; 1:6       __INFO
__{}    ld    A, B          ; 1:4       __INFO
__{}    or    C             ; 1:4       __INFO
__{}    jr    z, $+5        ; 2:7/12    __INFO  u  = 1?
__{}    inc  DE             ; 1:6       __INFO  DE = to
__{}    ldir                ; 2:u*21/16 __INFO{}dnl
__{}__ASM_TOKEN_2DROP}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr u char fill
dnl # ( addr -- )
dnl # If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH2_FILL},{dnl
__{}ifelse(__HEX_L(__HEX_HL($1)0>0x8000),0x01,{__def({USE_Fill_Over})}){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_FILL},{$1 $2 fill},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_FILL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}eval($#>2),{1},{
__{}__{}.error {$0}($@): $# parameters found in macro!},

__{}__HEX_HL($1),{0x0000},{{}__ASM_TOKEN_DROP},

__{}__HEX_HL($1),{0x0001},{ifelse(__IS_MEM_REF($2),1,{
__{}__{}                        ;[6:34]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO},
__{}{
__{}__{}                        ;[4:24]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld  (HL),format({%-11s},$2); 2:10      __INFO}){}__ASM_TOKEN_DROP},

__{}__HEX_HL($1),{0x0002},{ifelse(__IS_MEM_REF($2),1,{
__{}__{}                        ;[8:47]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO},
__{}{
__{}__{}                        ;[7:40]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld  (HL),format({%-11s},$2); 2:10      __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),format({%-11s},$2); 2:10      __INFO}){}__ASM_TOKEN_DROP},

__{}__HEX_HL($1),{0x0003},{ifelse(__IS_MEM_REF($2),1,{
__{}__{}                       ;[10:60]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO},
__{}__IS_NUM($2),1,{define({__TMP},__LD_R_NUM(__INFO,A,$2))
__{}__{}                        ;[eval(7+__BYTES):eval(47+__CLOCKS)]     __INFO  ( addr -- ) u=$1, char=$2{}__TMP},
__{}{
__{}__{}                        ;[9:54]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 2:7       __INFO})
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO{}__ASM_TOKEN_DROP},

__{}__HEX_HL($1),{0x0004},{ifelse(__IS_MEM_REF($2),1,{
__{}__{}                       ;[12:73]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO},
__{}__IS_NUM($2),1,{define({__TMP},__LD_R_NUM(__INFO,A,$2))
__{}__{}                        ;[eval(9+__BYTES):eval(60+__CLOCKS)]    __INFO  ( addr -- ) u=$1, char=$2{}__TMP},
__{}{
__{}__{}                       ;[11:67]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 2:7       __INFO})
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO{}__ASM_TOKEN_DROP},

__{}__HEX_HL($1),{0x0005},{ifelse(__IS_MEM_REF($2),1,{
__{}__{}                       ;[14:86]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO},
__{}__IS_NUM($2),1,{define({__TMP},__LD_R_NUM(__INFO,A,$2))
__{}__{}                        ;[eval(11+__BYTES):eval(73+__CLOCKS)]    __INFO  ( addr -- ) u=$1, char=$2{}__TMP},
__{}{
__{}__{}                       ;[13:80]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 2:7       __INFO})
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL),A          ; 1:7       __INFO{}__ASM_TOKEN_DROP},

__IS_MEM_REF($1),1,{
__{}  .warning Fail if $1 < 2!{}dnl
__{}ifelse(__IS_MEM_REF($2),1,{
__{}__{}format({%35s},;[17:86+21*($1)]) __INFO  ( addr -- ) u=$1, char=$2
__{}__{}                       ;[12:73]     __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO},
__{}{
__{}__{}format({%35s},;[15:76+21*($1)]) __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld  (HL),format({%-11s},$2); 2:10      __INFO})
__{}    ld   BC, format({%-11s},$1-1); 4:20      __INFO
__{}    dec  BC             ; 1:6       __INFO   $1-1
__{}    push DE             ; 1:11      __INFO
__{}    ld    D, H          ; 1:4       __INFO
__{}    ld    E, L          ; 1:4       __INFO
__{}    inc  DE             ; 1:6       __INFO   DE = to
__{}    ldir                ; 2:u*21/16 __INFO{}__ASM_TOKEN_2DROP},

__{}__IS_NUM($1),0,{
__{}  .warning Fail if $1 < 2!{}dnl
__{}ifelse(__IS_MEM_REF($2),1,{
__{}__{}format({%35s},;[15:70+21*($1)]) __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO},
__{}{
__{}__{}format({%35s},;[13:60+21*($1)]) __INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld  (HL),format({%-11s},$2); 2:10      __INFO})
__{}    ld   BC, format({%-11s},$1-1); 3:10      __INFO   $1-1
__{}    push DE             ; 1:11      __INFO
__{}    ld    D, H          ; 1:4       __INFO
__{}    ld    E, L          ; 1:4       __INFO
__{}    inc  DE             ; 1:6       __INFO   DE = to
__{}    ldir                ; 2:u*21/16 __INFO{}__ASM_TOKEN_2DROP},

_TYP_SINGLE:__IS_NUM($1),function:1,{
__{}__def({USE_Fill}){}dnl
__{}define({__TMP_STEP},8){}dnl
__{}define({__SUM_BYTES},1+3+1){}dnl
__{}define({__SUM_CLOCKS},4+17+10){}dnl
__{}define({__TMP_U},eval($1)){}dnl
__{}define({__TMP_MOD},eval(__TMP_U%__TMP_STEP)){}dnl
__{}define({__TMP_SUB},eval((__TMP_STEP-__TMP_MOD)%__TMP_STEP)){}dnl
__{}define({__TMP_B},eval((__TMP_U+__TMP_STEP-1)/__TMP_STEP)){}dnl
__{}define({__TMP_C},eval(__HEX_H(__TMP_B-1)+1)){}dnl
__{}define({__TMP_B},__HEX_L(__TMP_B)){}dnl
__{}define({__TMP_FCE_CLOCKS},eval(__TMP_B*(__TMP_STEP*13+13)-__TMP_SUB*13-5+10)){}dnl
__{}ifdef({USE_Fill_Over},{__add({__TMP_FCE_CLOCKS},eval((__TMP_C-1)*(256*(__TMP_STEP*13+13)-5+4+12)+4+7))}){}dnl
__{}__add({__SUM_CLOCKS},__TMP_FCE_CLOCKS){}dnl
__{}define({__TMP_CODE},{
__{}__{}    ex   DE, HL         ; 1:4       __INFO   addr}dnl
__{}__{}__LD_R_NUM(__INFO{   char},A,$2){}dnl
__{}__{}ifelse(ifdef({USE_Fill_Over},1,0),1,
__{}__{}{__LD_R16(BC,256*__TMP_B+__TMP_C,A,$2)   u=B*16-__TMP_SUB=eval(__TMP_B)*16-__TMP_SUB},
__{}__{}{__LD_R_NUM(__INFO{   u=B*16-__TMP_SUB=eval(__TMP_B)*16-__TMP_SUB},B,__TMP_B,A,$2)}){}dnl
__{}__{}{
__{}__{}    call format({%-15s},Fill+eval(2*__TMP_SUB)); 3:format({%-7s},eval(17+__TMP_FCE_CLOCKS)) __INFO}dnl
__{}__{}{
__{}__{}    pop  DE             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   ( addr -- ) fill(u,char)   variant function: fill(num,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__{}__IS_MEM_REF($2),1,{ifelse(dnl
__{}__{}eval((($1)<=3*256) && ((($1) % 3)==0)),{1},{
__{}__{}                       format({%-13s},;[29:eval(29+52*($1)/3)])__INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}    ld    B, __HEX_L(($1)/3)       ; 2:7       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    djnz $-6            ; 2:13/8    __INFO{}__ASM_TOKEN_DROP},
__{}__{}eval((($1)<=2*256) && ((($1) & 1)==0)),{1},{
__{}__{}                       format({%-13s},;[13:eval(29+39*($1)/2)])__INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}    ld    B, __HEX_L(($1)/2)       ; 2:7       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    djnz $-4            ; 2:13/8    __INFO{}__ASM_TOKEN_DROP},
__{}__{}eval((($1)<=2*256) && ((($1) & 1)==1)),{1},{
__{}__{}                       format({%-13s},;[14:eval(36+39*($1)/2)])__INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}    ld    B, __HEX_L(($1)/2)       ; 2:7       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    djnz $-4            ; 2:13/8    __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO{}__ASM_TOKEN_DROP},
__{}__{}{
__{}__{}                       format({%-13s},;[15:eval(70+($1)*21)])__INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld    A, format({%-11s},$2); 3:13      __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    ld   BC, __HEX_HL($1-1)     ; 3:10      __INFO   $1-1
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   DE = to
__{}__{}    ldir                ; 2:u*21/16 __INFO{}__ASM_TOKEN_2DROP})},
__{}{ifelse(dnl
__{}__{}eval((($1)<=3*256) && ((($1) % 3)==0)),{1},{
__{}__{}                       format({%-13s},;[13:eval(19+(52*$1)/3)])__INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld   BC, format({%-11s},eval(($1)/3){*256+$2}); 3:10      __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    djnz $-6            ; 2:13/8    __INFO{}__ASM_TOKEN_DROP},
__{}__{}eval((($1)<=2*256) && ((($1) & 1)==0)),{1},{
__{}__{}                       format({%-13s},;[11:eval(19+39*(($1)/2))])__INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld   BC, format({%-11s},eval(($1)/2){*256+$2}); 3:10      __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    djnz $-4            ; 2:13/8    __INFO{}__ASM_TOKEN_DROP},
__{}__{}eval((($1)<=2*256) && ((($1) & 1)==1)),{1},{
__{}__{}                       format({%-13s},;[12:eval(26+39*(($1)/2))])__INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld   BC, format({%-11s},eval(($1)/2){*256+$2}); 3:10      __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    djnz $-4            ; 2:13/8    __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO{}__ASM_TOKEN_DROP},
__{}__{}{
__{}__{}                       format({%-13s},;[13:eval(60+($1)*21)])__INFO  ( addr -- ) u=$1, char=$2
__{}__{}    ld  (HL),format({%-11s},$2); 2:10      __INFO
__{}__{}    ld   BC, __HEX_HL($1-1)     ; 3:10      __INFO   $1-1
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   DE = to
__{}__{}    ldir                ; 2:u*21/16 __INFO{}__ASM_TOKEN_2DROP}){}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr u char fill
dnl # ( -- )
dnl # If u is greater than zero, fill the contents of u consecutive characters at addr.
define({PUSH3_FILL},{dnl
__{}ifelse(__HEX_L(__HEX_HL($2)0>0x8000),0x01,{__def({USE_Fill_Over})}){}dnl
__{}__ADD_TOKEN({__TOKEN_PUSH3_FILL},{$1 $2 $3 fill},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH3_FILL},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(addr,u,char): Missing all parameters!},
$#,{1},{
__{}  .error {$0}($@): The second parameter is missing!},
$#,{2},{
__{}  .error {$0}($@): The third parameter is missing!},
eval($#>3),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},

__IS_MEM_REF($1):__IS_MEM_REF($2),1:1,{
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({__SUM_BYTES},14+4){}dnl
__{}define({__SUM_CLOCKS},11+6+4+4+7+11+4+4+6+10+10+4+4+7-5){}dnl
__{}define({__TMP_CODE_END},{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16_PLUS_ESCAPE({HL},$1,{BC},$2){   HL = addr from}dnl
__{}__{}__LD_MEM8_PLUS_ESCAPE({HL},$3,{HL},$1,{BC},$2){}dnl
__{}__{}{
__{}__{}    dec  BC             ; 1:6       __INFO   = $2-1
__{}__{}    ld   A{,} C           ; 1:4       __INFO
__{}__{}    or   B              ; 1:4       __INFO
__{}__{}    jr   z{,} format({%-12s},$+9); 2:7/12    __INFO
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    ld    E{,} L          ; 1:4       __INFO
__{}__{}    ld    D{,} H          ; 1:4       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   DE = to = from+1
__{}__{}    ldir                ; 2:u*21/16 __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}define({__TMP_CODE},
__{}__{}__LD_R16({BC},$2){   BC = u}dnl
__{}__{}{
__{}__{}    ld   A, C           ; 1:4       __INFO
__{}__{}    or   B              ; 1:4       __INFO
__{}__{}    jr   z, format({%-12s},$+eval(__SUM_BYTES-2-__BYTES)); 2:7/12    __INFO}dnl
__{}__{}__TMP_CODE_END){}dnl
__{}format({%36s},;[__SUM_BYTES:__SUM_CLOCKS+21*u/40] )__INFO   fill(addr,u,char)   variant: fill(no ptr,ptr,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__IS_MEM_REF($2),1,{
__{}define({_TMP_INFO},__INFO){}dnl
__{}define({__SUM_BYTES},5+6+4){}dnl
__{}define({__SUM_CLOCKS},11+10+10+11+6+4+4+7+4+4+7-5){}dnl
__{}define({__TMP_CODE_END},{
__{}__{}    push DE             ; 1:11      __INFO}dnl
__{}__{}__LD_R16_PLUS_ESCAPE({DE},$1+1,{HL},$1,{BC},$2-1){   DE = to}dnl
__{}__{}{
__{}__{}    ldir                ; 2:u*21/16 __INFO
__{}__{}    pop  DE             ; 1:10      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}__{}define({__TMP_JMP},eval(6+__BYTES)){}dnl
__{}define({__TMP_CODE_MIDDLE},{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16_PLUS_ESCAPE({HL},$1,{BC},$2){   HL = addr from}dnl
__{}__{}__LD_MEM8_PLUS_ESCAPE({HL},$3,{HL},$1,{BC},$2){}dnl
__{}__{}{
__{}__{}    dec  BC             ; 1:6       __INFO   = $2-1
__{}__{}    ld   A{,} C           ; 1:4       __INFO
__{}__{}    or   B              ; 1:4       __INFO
__{}__{}    jr   z{,} format({%-12s},$+__TMP_JMP); 2:7/12    __INFO}){}dnl
__{}define({__TMP_CODE},
__{}__{}__LD_R16({BC},$2){   BC = u}dnl
__{}__{}{
__{}__{}    ld   A, C           ; 1:4       __INFO
__{}__{}    or   B              ; 1:4       __INFO
__{}__{}    jr   z, format({%-12s},$+eval(__SUM_BYTES-2-__BYTES)); 2:7/12    __INFO}dnl
__{}__{}__TMP_CODE_MIDDLE{}dnl
__{}__{}__TMP_CODE_END){}dnl
__{}format({%36s},;[__SUM_BYTES:__SUM_CLOCKS+21*u/40] )__INFO   fill(addr,u,char)   variant: fill(no ptr,ptr,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__IS_NUM($2),0,{
__{}  if (($2)=1){}dnl
__{}__{}ifelse(__IS_MEM_REF($1):__IS_MEM_REF($3),{1:1},{
__{}__{}__{}                        ;[8:40]     __INFO   fill(addr,u,char)   variant u = ??? = 1 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($1),1,{
__{}__{}__{}                        ;[7:34]     __INFO   fill(addr,u,char)   variant u = ??? = 1 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($3),1,{
__{}__{}__{}                        ;[6:26]     __INFO   fill(addr,u,char)   variant u = ??? = 1 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO},
__{}__{}{
__{}__{}__{}                        ;[5:20]     __INFO   fill(addr,u,char)   variant u = ??? = 1 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO})
__{}  endif
__{}  if (($2)=2){}dnl
__{}__{}ifelse(__IS_MEM_REF($1):__IS_MEM_REF($3),{1:1},{
__{}__{}__{}                       ;[10:53]     __INFO   fill(addr,u,char)   variant u = ??? = 2 byte
__{}__{}__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($1),1,{
__{}__{}__{}                        ;[9:47]     __INFO   fill(addr,u,char)   variant u = ??? = 2 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($3),1,{
__{}__{}__{}                        ;[9:39]     __INFO   fill(addr,u,char)   variant u = ??? = 2 byte
__{}__{}__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO
__{}__{}__{}    ld   format({%-15s},(1+$1){,} A); 3:13      __INFO},
__{}__{}{
__{}__{}__{}                        ;[7:30]     __INFO   fill(addr,u,char)   variant u = ??? = 2 byte
__{}__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO})
__{}  endif
__{}  if (($2)=3){}dnl
__{}__{}ifelse(__IS_MEM_REF($1):__IS_MEM_REF($3),{1:1},{
__{}__{}__{}                       ;[12:66]     __INFO   fill(addr,u,char)   variant u = ??? = 3 byte
__{}__{}__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($1),1,{
__{}__{}__{}                       ;[11:60]     __INFO   fill(addr,u,char)   variant u = ??? = 3 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($3),1,{
__{}__{}__{}                        ;[12:52]    __INFO   fill(addr,u,char)   variant u = ??? = 3 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO
__{}__{}__{}    ld   format({%-15s},(1+$1){,} A); 3:13      __INFO
__{}__{}__{}    ld   format({%-15s},(2+$1){,} A); 3:13      __INFO},
__{}__{}{
__{}__{}__{}                        ;[11:46]    __INFO   fill(addr,u,char)   variant u = ??? = 3 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO
__{}__{}__{}    ld   format({%-15s},(1+$1){,} A); 3:13      __INFO
__{}__{}__{}    ld   format({%-15s},(2+$1){,} A); 3:13      __INFO})
__{}  endif
__{}  if (($2)=4){}dnl
__{}__{}ifelse(__IS_MEM_REF($1):__IS_MEM_REF($3),{1:1},{
__{}__{}__{}                       ;[14:79]     __INFO   fill(addr,u,char)   variant u = ??? = 4 byte
__{}__{}__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($1),1,{
__{}__{}__{}                       ;[13:73]     __INFO   fill(addr,u,char)   variant u = ??? = 4 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($3),1,{
__{}__{}__{}                        ;[13:61]    __INFO   fill(addr,u,char)   variant u = ??? = 4 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}__{}__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO},
__{}__{}{
__{}__{}__{}                        ;[11:50]    __INFO   fill(addr,u,char)   variant u = ??? = 4 byte
__{}__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      __INFO   hi = lo
__{}__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}__{}__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO})
__{}  endif
__{}  if (($2)=5){}dnl
__{}__{}ifelse(__IS_MEM_REF($1):__IS_MEM_REF($3),{1:1},{
__{}__{}__{}                       ;[16:92]     __INFO   fill(addr,u,char)   variant u = ??? = 5 byte
__{}__{}__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($1),1,{
__{}__{}__{}                       ;[15:86]     __INFO   fill(addr,u,char)   variant u = ??? = 5 byte
__{}__{}__{}    ld    A,format({%-12s},$3); 2:7       __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($3),1,{
__{}__{}__{}                        ;[16:74]    __INFO   fill(addr,u,char)   variant u = ??? = 5 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}__{}__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO
__{}__{}__{}    ld   format({%-15s},(4+$1){,} A); 3:13      __INFO},
__{}__{}{
__{}__{}__{}                       ;[15:67]     __INFO   fill(addr,u,char)   variant u = ??? = 5 byte
__{}__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}__{}__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO
__{}__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}__{}    ld   format({%-15s},(4+$1){,} A); 3:13      __INFO})
__{}  endif
__{}  if (($2)=6){}dnl
__{}__{}ifelse(__IS_MEM_REF($1):__IS_MEM_REF($3),{1:1},{
__{}__{}__{}                       ;[18:105]    __INFO   fill(addr,u,char)   variant u = ??? = 6 byte
__{}__{}__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($1),1,{
__{}__{}__{}                       ;[17:99]     __INFO   fill(addr,u,char)   variant u = ??? = 6 byte
__{}__{}__{}    ld    A,format({%-12s},$3); 2:7       __INFO
__{}__{}__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld  (BC){,}A          ; 1:7       __INFO},
__{}__{}__IS_MEM_REF($3),1,{
__{}__{}__{}                        ;[17:81]    __INFO   fill(addr,u,char)   variant u = ??? = 6 byte
__{}__{}__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}__{}__{}    ld    C, A          ; 1:4       __INFO
__{}__{}__{}    ld    B, A          ; 1:4       __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}__{}__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO
__{}__{}__{}    ld   format({%-15s},(4+$1){,} BC); 4:20      __INFO},
__{}__{}{
__{}__{}__{}                       ;[15:70]     __INFO   fill(addr,u,char)   variant u = ??? = 6 byte
__{}__{}__{}    ld   BC, format({%-11s},257*($3)); 3:10      __INFO
__{}__{}__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}__{}__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO
__{}__{}__{}    ld   format({%-15s},(4+$1){,} BC); 4:20      __INFO})
__{}  endif
__{}__{}  if (($2)>6){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}__{}define({__SUM_BYTES},12){}dnl
__{}__{}define({__SUM_CLOCKS},61){}dnl
__{}__{}define({__TEMP_CODE},__LD_MEM8({HL},$3,{HL},$1)){}dnl
__{}__{}__LD_REG16({HL},$1){}dnl
__{}__{}format({%36s},;[__SUM_BYTES:__SUM_CLOCKS+21*u] )__INFO   fill(addr,u,char)   variant u = ??? > 6
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   BC, format({%-11s},$2-1); 3:10      __INFO{}dnl
__{}__{}__CODE_16BIT   HL = addr from
__{}__{}    ld    E, L          ; 1:4       __INFO
__{}__{}    ld    D, H          ; 1:4       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   DE = to{}dnl
__{}__{}__TEMP_CODE
__{}__{}    ldir                ; 2:u*21/16 __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},
__{}{
__{}__{}define({__SUM_BYTES},9){}dnl
__{}__{}define({__SUM_CLOCKS},47){}dnl
__{}__{}define({__TEMP_CODE},__LD_MEM8({HL},$3,{DE},$1+1,{HL},$1)){}dnl
__{}__{}__LD_REG16(          {DE},$1+1,{HL},$1){}dnl
__{}__{}__LD_REG16(                    {HL},$1){}dnl
__{}__{}__{}format({%36s},;[__SUM_BYTES:__SUM_CLOCKS+21*u] )__INFO   fill(addr,u,char)   variant u = ???
__{}__{}__{}    push DE             ; 1:11      __INFO
__{}__{}__{}    push HL             ; 1:11      __INFO
__{}__{}__{}    ld   BC, format({%-11s},$2-1); 3:10      __INFO{}dnl
__{}__{}__{}__CODE_16BIT   HL = from{}__LD_REG16({DE},$1+1,{HL},$1){}dnl
__{}__{}__{}__CODE_16BIT   DE = to = from+1{}dnl
__{}__{}__{}__TEMP_CODE
__{}__{}__{}    ldir                ; 2:u*21/16 __INFO
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO})
__{}  endif},

__HEX_HL($2),{0x0000},{
__{}                        ;           __INFO   fill(addr,u,char)   variant: fill(?,0,?)},

__HEX_HL($2):__IS_MEM_REF($1):__IS_MEM_REF($3),{0x0001:1:1},{
__{}                        ;[8:40]     __INFO   fill(addr,u,char)   variant: fill(ptr,1,ptr)
__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($1),{0x0001:1},{
__{}                        ;[7:34]     __INFO   fill(addr,u,char)   variant: fill(ptr,1,no ptr)
__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($3),{0x0001:1},{
__{}                        ;[6:26]     __INFO   fill(addr,u,char)   variant: fill(no ptr,1,ptr)
__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO},
__HEX_HL($2),{0x0001},{
__{}                        ;[5:20]     __INFO   fill(addr,u,char)   variant: fill(no ptr,1,no ptr)
__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO},

__HEX_HL($2):__IS_MEM_REF($1):__IS_MEM_REF($3),{0x0002:1:1},{
__{}                       ;[10:53]     __INFO   fill(addr,u,char)   variant: fill(ptr,2,ptr)
__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($1),{0x0002:1},{
__{}                        ;[9:47]     __INFO   fill(addr,u,char)   variant: fill(ptr,2,no ptr)
__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($3),{0x0002:1},{
__{}                        ;[9:39]     __INFO   fill(addr,u,char)   variant: fill(no ptr,2,ptr)
__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO
__{}    ld   format({%-15s},(1+$1){,} A); 3:13      __INFO},
__HEX_HL($2),{0x0002},{
__{}                        ;[7:30]     __INFO   fill(addr,u,char)   variant: fill(no ptr,2,no ptr)
__{}    ld   BC, format({%-11s},257*($3)); 3:10      __INFO
__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO},


__HEX_HL($2):__IS_MEM_REF($1):__IS_MEM_REF($3),{0x0003:1:1},{
__{}                       ;[12:66]     __INFO   fill(addr,u,char)   variant: fill(ptr,3,ptr)
__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($1),{0x0003:1},{
__{}                       ;[11:60]     __INFO   fill(addr,u,char)   variant: fill(ptr,3,no ptr)
__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($3),{0x0003:1},{
__{}                        ;[12:52]    __INFO   fill(addr,u,char)   variant: fill(no ptr,3,ptr)
__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO
__{}    ld   format({%-15s},(1+$1){,} A); 3:13      __INFO
__{}    ld   format({%-15s},(2+$1){,} A); 3:13      __INFO},
__HEX_HL($2),{0x0003},{
__{}                        ;[11:46]    __INFO   fill(addr,u,char)   variant: fill(no ptr,3,no ptr)
__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}    ld   format({%-15s},($1){,} A); 3:13      __INFO
__{}    ld   format({%-15s},(1+$1){,} A); 3:13      __INFO
__{}    ld   format({%-15s},(2+$1){,} A); 3:13      __INFO},

__HEX_HL($2):__IS_MEM_REF($1):__IS_MEM_REF($3),{0x0004:1:1},{
__{}                       ;[14:79]     __INFO   fill(addr,u,char)   variant: fill(ptr,4,ptr)
__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($1),{0x0004:1},{
__{}                       ;[13:73]     __INFO   fill(addr,u,char)   variant: fill(ptr,4,no ptr)
__{}    ld    A, format({%-11s},$3); 2:7       __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($3),{0x0004:1},{
__{}                        ;[13:61]    __INFO   fill(addr,u,char)   variant: fill(no ptr,4,ptr)
__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO},
__HEX_HL($2),{0x0004},{
__{}                        ;[11:50]    __INFO   fill(addr,u,char)   variant: fill(no ptr,4,no ptr)
__{}    ld   BC, format({%-11s},257*($3)); 3:10      __INFO   hi = lo
__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO},

__HEX_HL($2):__IS_MEM_REF($1):__IS_MEM_REF($3),{0x0005:1:1},{
__{}                       ;[16:92]     __INFO   fill(addr,u,char)   variant: fill(ptr,5,ptr)
__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($1),{0x0005:1},{
__{}                       ;[15:86]     __INFO   fill(addr,u,char)   variant: fill(ptr,5,no ptr)
__{}    ld    A,format({%-12s},$3); 2:7       __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($3),{0x0005:1},{
__{}                        ;[16:74]    __INFO   fill(addr,u,char)   variant: fill(no ptr,5,ptr)
__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO
__{}    ld   format({%-15s},(4+$1){,} A); 3:13      __INFO},
__HEX_HL($2),{0x0005},{
__{}                       ;[15:67]     __INFO   fill(addr,u,char)   variant: fill(no ptr,5,no ptr)
__{}    ld   BC, format({%-11s},257*($3)); 3:10      __INFO
__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO
__{}    ld    A, C          ; 1:4       __INFO
__{}    ld   format({%-15s},(4+$1){,} A); 3:13      __INFO},

__HEX_HL($2):__IS_MEM_REF($1):__IS_MEM_REF($3),{0x0006:1:1},{
__{}                       ;[18:105]    __INFO   fill(addr,u,char)   variant: fill(ptr,6,ptr)
__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($1),{0x0006:1},{
__{}                       ;[17:99]     __INFO   fill(addr,u,char)   variant: fill(ptr,6,no ptr)
__{}    ld    A,format({%-12s},$3); 2:7       __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO},
__HEX_HL($2):__IS_MEM_REF($3),{0x0006:1},{
__{}                        ;[17:81]    __INFO   fill(addr,u,char)   variant: fill(no ptr,6,ptr)
__{}    ld    A, format({%-11s},$3); 3:13      __INFO
__{}    ld    C, A          ; 1:4       __INFO
__{}    ld    B, A          ; 1:4       __INFO
__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO
__{}    ld   format({%-15s},(4+$1){,} BC); 4:20      __INFO},
__HEX_HL($2),{0x0006},{
__{}                       ;[15:70]     __INFO   fill(addr,u,char)   variant: fill(no ptr,6,no ptr)
__{}    ld   BC, format({%-11s},257*($3)); 3:10      __INFO
__{}    ld   format({%-15s},($1){,} BC); 4:20      __INFO
__{}    ld   format({%-15s},(2+$1){,} BC); 4:20      __INFO
__{}    ld   format({%-15s},(4+$1){,} BC); 4:20      __INFO},

__IS_NAME($1):_TYP_SINGLE,0:function,{
__{}__def({USE_Fill}){}dnl
__{}define({__TMP_STEP},8){}dnl
__{}define({__SUM_BYTES},1+3+1){}dnl
__{}define({__SUM_CLOCKS},4+17+4){}dnl
__{}define({__TMP_C1},eval(11+ifdef({USE_Fill_Unknown_Addr},2,0))){}dnl
__{}define({__TMP_U},eval($2)){}dnl
__{}define({__TMP_BONUS},{}){}dnl
__{}ifdef({USE_Fill_Unknown_Addr},,{ifelse(eval(($1+$2)&(__HEX_H($1)!=__HEX_H($1+$2-1))),{1},{dnl
__{}__{}__add({__TMP_U},-1){}dnl
__{}__{}__add({__SUM_BYTES},1){}dnl
__{}__{}__add({__SUM_CLOCKS},7){}dnl
__{}__{}define({__TMP_BONUS},{
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}){}dnl
__{}})}){}dnl
__{}define({__TMP_MOD},eval(__TMP_U%__TMP_STEP)){}dnl
__{}define({__TMP_SUB},eval((__TMP_STEP-__TMP_MOD)%__TMP_STEP)){}dnl
__{}define({__TMP_B},eval((__TMP_U+__TMP_STEP-1)/__TMP_STEP)){}dnl
__{}define({__TMP_C},eval(__HEX_H(__TMP_B-1)+1)){}dnl
__{}define({__TMP_B},__HEX_L(__TMP_B)){}dnl
__{}define({__TMP_FCE_CLOCKS},eval(((__TMP_STEP/2)*(__TMP_C1+13)+13)*__TMP_B-(__TMP_C1+13)*(__TMP_SUB/2)-__TMP_C1*(__TMP_SUB&1)-5+10)){}dnl
__{}ifdef({USE_Fill_Over},{__add({__TMP_FCE_CLOCKS},eval((__TMP_C-1)*(256*(__TMP_STEP*(__TMP_C1+13)/2+13)-5+4+12)+4+7))}){}dnl
__{}__add({__SUM_CLOCKS},__TMP_FCE_CLOCKS){}dnl
__{}define({__TMP_CODE},{
__{}__{}    exx                 ; 1:4       __INFO}dnl
__{}__{}__LD_R16({DE},$1){   addr __SAVE_VALUE_HL($1)..__SAVE_VALUE_HL($1+$2-1)}dnl
__{}__{}__LD_R_NUM(__INFO{   char},A,$3,DE,$1){}dnl
__{}__{}ifelse(ifdef({USE_Fill_Over},1,0),1,
__{}__{}{__LD_R16(BC,256*__TMP_B+__TMP_C,A,$3,DE,$1)   u=B*16-__TMP_SUB=eval(__TMP_B)*16-__TMP_SUB},
__{}__{}{__LD_R_NUM(__INFO{   u=B*16-__TMP_SUB=eval(__TMP_B)*16-__TMP_SUB},B,__TMP_B,A,$3,DE,$1)}){}dnl
__{}__{}{
__{}__{}    call format({%-15s},Fill+eval(2*__TMP_SUB)); 3:format({%-7s},eval(17+__TMP_FCE_CLOCKS)) __INFO}dnl
__{}__{}__TMP_BONUS{}dnl
__{}__{}{
__{}__{}    exx                 ; 1:4       __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant function: fill(ptr/num, ifdef({USE_Fill_Over},no limit,max 4096),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__IS_NAME($1):_TYP_SINGLE,1:function,{
__{}__def({USE_Fill}){}dnl
__{}define({__TMP_STEP},8){}dnl
__{}define({__SUM_BYTES},1+3+1){}dnl
__{}define({__SUM_CLOCKS},4+17+4){}dnl
__{}define({__TMP_C1},eval(11+ifdef({USE_Fill_Unknown_Addr},2,0))){}dnl
__{}define({__TMP_U},eval($2)){}dnl
__{}define({__TMP_MOD_0},eval(__TMP_U%__TMP_STEP)){}dnl
__{}define({__TMP_SUB_0},eval((__TMP_STEP-__TMP_MOD_0)%__TMP_STEP)){}dnl
__{}define({__TMP_MOD_1},eval((__TMP_U-1)%__TMP_STEP)){}dnl
__{}define({__TMP_SUB_1},eval((__TMP_STEP-__TMP_MOD_1)%__TMP_STEP)){}dnl
__{}define({__TMP_B_0},eval((__TMP_U+__TMP_STEP-1)/__TMP_STEP)){}dnl
__{}define({__TMP_B_1},eval((__TMP_U+__TMP_STEP-2)/__TMP_STEP)){}dnl
__{}define({__TMP_C_0},eval(__HEX_H(__TMP_B_0-1)+1)){}dnl
__{}define({__TMP_C_1},eval(__HEX_H(__TMP_B_1-1)+1)){}dnl
__{}define({__TMP_B_0},__HEX_L(__TMP_B_0)){}dnl
__{}define({__TMP_B_1},__HEX_L(__TMP_B_1)){}dnl
__{}define({__TMP_FCE_CLOCKS_0},eval(((__TMP_STEP/2)*(__TMP_C1+13)+13)*__TMP_B_0-(__TMP_C1+13)*(__TMP_SUB_0/2)-__TMP_C1*(__TMP_SUB_0&1)-5+10)){}dnl
__{}define({__TMP_FCE_CLOCKS_1},eval(((__TMP_STEP/2)*(__TMP_C1+13)+13)*__TMP_B_1-(__TMP_C1+13)*(__TMP_SUB_1/2)-__TMP_C1*(__TMP_SUB_1&1)-5+10)){}dnl
__{}ifdef({USE_Fill_Over},{dnl
__{}__{}__add({__TMP_FCE_CLOCKS_0},eval((__TMP_C_0-1)*(256*(__TMP_STEP*(__TMP_C1+13)/2+13)-5+4+12)+4+7)){}dnl
__{}__{}__add({__TMP_FCE_CLOCKS_1},eval((__TMP_C_1-1)*(256*(__TMP_STEP*(__TMP_C1+13)/2+13)-5+4+12)+4+7)){}dnl
__{}}){}dnl
__{}define({__TMP_CODE},{
__{}__{}    exx                 ; 1:4       __INFO}dnl
__{}__{}__LD_R16({DE},$1){   addr __SAVE_VALUE_HL($1)..__SAVE_VALUE_HL($1+$2-1)}dnl
__{}__{}__LD_R_NUM(__INFO{   char},A,$3,DE,$1){}dnl
__{}__{}define({__TMP_CLOCKS},__SUM_CLOCKS){}dnl
__{}__{}define({__TMP_BYTES},__SUM_BYTES){}dnl
__{}ifdef({USE_Fill_Unknown_Addr},{dnl
__{}__{}__{}ifelse(ifdef({USE_Fill_Over},1,0),1,
__{}__{}__{}{__LD_R16(BC,256*__TMP_B_0+__TMP_C_0,A,$3,DE,$1)   u=B*16-__TMP_SUB_0=eval(__TMP_B_0)*16-__TMP_SUB_0},
__{}__{}__{}{__LD_R_NUM(__INFO{   u=B*16-__TMP_SUB_0=eval(__TMP_B_0)*16-__TMP_SUB_0},B,__TMP_B_0,A,$3,DE,$1)})
__{}__{}__{}define({__TMP_BYTES_1}, __BYTES){}dnl
__{}__{}__{}define({__TMP_BYTES_0}, __BYTES){}dnl
__{}__{}__{}define({__TMP_CLOCKS_0},__CLOCKS){}dnl
__{}__{}__{}define({__TMP_CLOCKS_1},__CLOCKS){}dnl
__{}__{}__{}define({__TMP_FCE_CLOCKS_1},__TMP_FCE_CLOCKS_0){}dnl
__{}__{}    call format({%-15s},Fill+eval(2*__TMP_SUB_0)); 3:format({%-7s},eval(17+__TMP_FCE_CLOCKS_0)) __INFO},
__{}__{}{
__{}__{}  if (1&($1+$2))&&(0xFF00&(($1)xor($1+$2-1))){}dnl
__{}__{}__{}ifelse(ifdef({USE_Fill_Over},1,0),1,
__{}__{}__{}{__LD_R16(BC,256*__TMP_B_1+__TMP_C_1,A,$3,DE,$1)   u=B*16-__TMP_SUB_1=eval(__TMP_B_1)*16-__TMP_SUB_1},
__{}__{}__{}{__LD_R_NUM(__INFO{   u=B*16-__TMP_SUB_1=eval(__TMP_B_1)*16-__TMP_SUB_1},B,__TMP_B_1,A,$3,DE,$1)})
__{}__{}__{}define({__TMP_CLOCKS_1},7+__CLOCKS){}dnl
__{}__{}__{}define({__TMP_BYTES_1}, 1+__BYTES){}dnl
__{}__{}__{}    call format({%-15s},Fill+eval(2*__TMP_SUB_1)); 3:format({%-7s},eval(17+__TMP_FCE_CLOCKS_1)) __INFO
__{}__{}__{}    ld  (DE){,}A          ; 1:7       __INFO
__{}__{}  else{}dnl
__{}__{}__{}ifelse(ifdef({USE_Fill_Over},1,0),1,
__{}__{}__{}{__LD_R16(BC,256*__TMP_B_0+__TMP_C_0,A,$3,DE,$1)   u=B*16-__TMP_SUB_0=eval(__TMP_B_0)*16-__TMP_SUB_0},
__{}__{}__{}{__LD_R_NUM(__INFO{   u=B*16-__TMP_SUB_0=eval(__TMP_B_0)*16-__TMP_SUB_0},B,__TMP_B_0,A,$3,DE,$1)})
__{}__{}__{}define({__TMP_CLOCKS_0},__CLOCKS){}dnl
__{}__{}__{}define({__TMP_BYTES_0}, __BYTES){}dnl
__{}__{}    call format({%-15s},Fill+eval(2*__TMP_SUB_0)); 3:format({%-7s},eval(17+__TMP_FCE_CLOCKS_0)) __INFO
__{}__{}  endif}){}dnl
__{}__{}{
__{}__{}    exx                 ; 1:4       __INFO}){}dnl
__{}define({__TMP_BYTES_0},eval(__TMP_BYTES+__TMP_BYTES_0)){}dnl
__{}define({__TMP_BYTES_1},eval(__TMP_BYTES+__TMP_BYTES_1)){}dnl
__{}define({__TMP_CLOCKS_0},eval(__TMP_CLOCKS+__TMP_CLOCKS_0+__TMP_FCE_CLOCKS_0)){}dnl
__{}define({__TMP_CLOCKS_1},eval(__TMP_CLOCKS+__TMP_CLOCKS_1+__TMP_FCE_CLOCKS_1)){}dnl
__{}ifelse(__TMP_BYTES_0,  __TMP_BYTES_1,,{define({__TMP_BYTES_1},__TMP_BYTES_1/__TMP_BYTES_0)}){}dnl
__{}ifelse(__TMP_CLOCKS_0,__TMP_CLOCKS_1,,{define({__TMP_CLOCKS_1},__TMP_CLOCKS_1/__TMP_CLOCKS_0)}){}dnl
__{}format({%36s},;[__TMP_BYTES_1:format({%-8s},__TMP_CLOCKS_1] ))__INFO   fill(addr,u,char)   variant function: fill(variable, ifdef({USE_Fill_Over},no limit,max 4096),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($2<=3*256):__HEX_L($1+$2):__HEX_L(($2) % 3),0x01:0x00:0x00,{
dnl # cFD  bFE  aFF  a00
dnl #           +++
dnl # cFE  bFF  b00
dnl #      +++
dnl # cFF  c00  b01
dnl # +++
__{}define({__TMP_X},eval(($2)/3)){}dnl
__{}define({__SUM_BYTES},3*1+3){}dnl
__{}define({__SUM_CLOCKS},3*7+10){}dnl
__{}define({__TMP_LOOP},{
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,0,3,__TMP_X){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,1,3,__TMP_X){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,2,3,__TMP_X-1){
__{}__{}    jp   nz{,} $-6        ; 3:10      __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(__TMP_X*(__SUM_CLOCKS))){}dnl
__{}define({__TMP_CODE},
__{}__{}__LD_R16({BC},$1){   addr}dnl
__{}__{}__LD_R_NUM(__INFO   char,A,$3,BC,$1){}dnl
__{}__{}__TMP_LOOP){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant >0: fill(num,3*__TMP_X (max 256),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_H($1):__HEX_L($1+$2),__HEX_H($1+$2-1):0x00,{
__{}define({__SUM_BYTES},4+3){}dnl
__{}define({__SUM_CLOCKS},eval((($2)>>1)*(2*11+10))){}dnl
__{}ifelse(eval(($2) & 0x01),{1},{dnl
__{}__{}__add({__SUM_BYTES},1){}dnl
__{}__{}__add({__SUM_CLOCKS},7){}dnl
__{}__{}define({__TMP_BONUS},{
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}){}dnl
__{}},
__{}{dnl
__{}__{}define({__TMP_BONUS},{}){}dnl
__{}}){}dnl
__{}define({__TMP_CODE},
__{}__{}__LD_R16({BC},$1){   addr}dnl
__{}__{}__LD_R_NUM(__INFO   char,A,$3,BC,$1){
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   C             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   C             ; 1:4       __INFO
__{}__{}    jp   nz, $-4        ; 3:10      __INFO}dnl
__{}__{}__TMP_BONUS){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant >0: fill(num,max 256,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_H($1):__HEX_L($1):__HEX_L(+($2) % 3),__HEX_H($1+$2-1):0x00:0x00,{
__{}dnl # 3*7
__{}define({__TMP_X},eval(($2)/3)){}dnl
__{}define({__SUM_BYTES},3*2+3){}dnl
__{}define({__SUM_CLOCKS},eval(__TMP_X*(3*11+10))){}dnl
__{}define({__TMP_CODE},
__{}__{}__LD_R16({BC},$1+$2){   addr+u}dnl
__{}__{}__LD_R_NUM(__INFO   char,A,$3,BC,$1+$2){
__{}__{}    dec   C             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    dec   C             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    dec   C             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    jp   nz, $-6        ; 3:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant 0>: fill(num,3*eval(($2)/3) max(256),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_H($1):__HEX_L($1),__HEX_H($1+$2-1):0x00,{
__{}dnl # 0x4800,23 or 22
__{}define({__TMP_X},     eval(($2)>>1)){}dnl
__{}define({__TMP_BC},    eval(256*__HEX_H($1)+__HEX_L($1+$2-(($2) & 1)))){}dnl
__{}define({__SUM_BYTES}, 2*2+3){}dnl
__{}define({__SUM_CLOCKS},eval(__TMP_X*(2*11+10))){}dnl
__{}ifelse(eval(($2) & 1),1,{
__{}__{}__add({__SUM_BYTES},1){}dnl
__{}__{}__add({__SUM_CLOCKS},7){}dnl
__{}__{}define({__TMP_BONUS},{
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO})},
__{}{dnl
__{}__{}define({__TMP_BONUS},{}){}dnl
__{}}){}dnl
__{}define({__TMP_CODE},
__{}__{}__LD_R16({BC},__TMP_BC){   addr+u}dnl
__{}__{}__LD_R_NUM(__INFO   char,A,$3,BC,__TMP_BC){}dnl
__{}__{}__TMP_BONUS{
__{}__{}    dec   C             ; 1:4       __INFO
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    dec   C             ; 1:4       __INFO
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    jp   nz{,} $-6        ; 3:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant 0>: fill(num,max 256,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_HL($2):__IS_MEM_REF($1):__IS_MEM_REF($3),{0x0007:1:1},{
__{}                       ;[18:149]    __INFO   fill(addr,u,char)   variant: fill(ptr,7,ptr)
__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    scf                 ; 1:4       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    jr   nc, $-7        ; 2:7/12    __INFO},
__HEX_HL($2):__HEX_L($3),{0x0007:0x00},{
__{}define({__SUM_BYTES},8){}dnl
__{}define({__SUM_CLOCKS},7+7+7+4+12){}dnl
__{}define({_TEMP_LOOP},{
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,1,3,2){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,2,3,2){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,3,3,2){
__{}__{}    ccf                 ; 1:4       __INFO
__{}__{}    jr    c, $-7        ; 2:7/12    __INFO}){}dnl
__{}define({__SUM_CLOCKS},4+7+2*(__SUM_CLOCKS)-5){}dnl
__{}define({_TEMP_BONUS},{
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,0,1,1)){}dnl
__{}define({_TMP_INFO},__INFO   addr){}dnl
__{}__LD_REG16(BC,$1){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(anything,7,0){}dnl
__{}__CODE_16BIT
__{}    xor   A             ; 1:4       __INFO{}dnl
__{}_TEMP_BONUS{}dnl
__{}_TEMP_LOOP},
__HEX_HL($2):__IS_MEM_REF($1),{0x0007:1},{
__{}                       ;[17:143]    __INFO   fill(addr,u,char)   variant: fill(ptr,7,no ptr)
__{}    ld   BC{,}format({%-12s},$1); 4:20      __INFO
__{}    ld    A,format({%-12s},$3); 2:7       __INFO
__{}    scf                 ; 1:4       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    inc  BC             ; 1:6       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    jr   nc, $-7        ; 2:7/12    __INFO},
__HEX_HL($2):__IS_MEM_REF($3),{0x0007:1},{
__{}define({__SUM_CLOCKS},7+7+7+4+12){}dnl
__{}define({__SUM_BYTES},6+8){}dnl
__{}define({_TEMP_LOOP},{dnl
__{}}__INC_REG16(BC,$1,0,3,2){
__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,1,3,2){
__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,2,3,2){
__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}    ccf                 ; 1:4       __INFO
__{}    jr   nc, $-7        ; 2:7/12    __INFO}){}dnl
__{}__add({__SUM_CLOCKS},13+10+4+7+__SUM_CLOCKS-5){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(no ptr,7,ptr)
__{}    ld    A,format({%-12s},$3); 3:13      __INFO
__{}    ld   BC{,}format({%-12s},$1); 3:10      __INFO
__{}    scf                 ; 1:4       __INFO
__{}    ld  (BC){,}A          ; 1:7       __INFO{}dnl
__{}_TEMP_LOOP},

__HEX_L($2<768):__HEX_L(($2) % 3):__IS_MEM_REF($3),0x01:0x00:1,{
__{}dnl # 3*50
__{}define({__TMP_X},eval(($2)/3)){}dnl
__{}define({__SUM_CLOCKS},21+13){}dnl
__{}define({__SUM_BYTES},1+5+1){}dnl
__{}define({__TMP_LOOP},{
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16(DE,$1,0,3,__TMP_X){
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16(DE,$1,1,3,__TMP_X){
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16(DE,$1,2,3,__TMP_X-1){
__{}__{}    djnz $-6            ; 2:13/8    __INFO}){}dnl
__{}define({__SUM_CLOCKS},4+__TMP_X*(__SUM_CLOCKS)-5+4){}dnl
__{}define({_TMP_INFO},__INFO   addr){}dnl
__{}define({__TMP_CODE},{
__{}__{}    exx                 ; 1:4       __INFO}dnl
__{}__{}__LD_R16(DE,$1){}dnl
__{}__{}__LD_R_NUM(__INFO   ($2)/3,     B,__HEX_L(__TMP_X),DE,$1){}dnl
__{}__{}__LD_R_NUM(__INFO   char,  A,$3,B,__HEX_L(__TMP_X),DE,$1){}dnl
__{}__{}__TMP_LOOP{
__{}__{}    exx                 ; 1:4       __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(num,3*__TMP_X (max 767),ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($2<768):__HEX_L(($2) % 3):__IS_MEM_REF($3),0x01:0x00:0,{
__{}dnl # 3*50
__{}define({__TMP_X},eval(($2)/3)){}dnl
__{}define({__SUM_CLOCKS},21+13){}dnl
__{}define({__SUM_BYTES},1+5+1){}dnl
__{}define({__TMP_LOOP},{
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16(HL,$1,0,3,__TMP_X){
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16(HL,$1,1,3,__TMP_X){
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16(HL,$1,2,3,__TMP_X-1){
__{}__{}    djnz $-6            ; 2:13/8    __INFO}){}dnl
__{}define({__SUM_CLOCKS},11+__TMP_X*(__SUM_CLOCKS)-5+10){}dnl
__{}define({__TMP_CODE},{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(HL,$1)   addr{}dnl
__{}__{}__LD_R_NUM(__INFO   ($2)/3,     B,__HEX_L(__TMP_X),HL,$1){}dnl
__{}__{}__LD_R_NUM(__INFO   char,  A,$3,B,__HEX_L(__TMP_X),HL,$1){}dnl
__{}__{}__TMP_LOOP
__{}__{}    pop  HL             ; 1:10      __INFO){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(num,3*eval(($2)/3) (max 767),no ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

__SAVE_EVAL(+($2) <= 2*256+1):__IS_MEM_REF($3),{1:1},{
__{}dnl # 511
__{}define({__SUM_CLOCKS},7+7+13){}dnl
__{}define({__SUM_BYTES},1+2+2+1){}dnl
__{}define({__TMP_LOOP},{
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,0,2,eval(($2)>>1)){
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,1,2,eval(($2)>>1)){
__{}    djnz $-4            ; 2:13/8    __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(4+($2>>1)*(__SUM_CLOCKS)-5+4)){}dnl
__{}define({__TMP_CODE},{
__{}__{}    exx                 ; 1:4       __INFO}dnl
__{}__{}__LD_R16({DE},$1){}dnl
__{}__{}__LD_R_NUM(__INFO   char,A,$3){}dnl
__{}__{}__LD_R_NUM(__INFO   u/2,B,__HEX_L(($2)>>1),DE,$1){}dnl
__{}__{}__TMP_LOOP{}dnl
__{}__{}ifelse(eval(($2) & 0x01),{1},dnl
__{}__{}__{}__add({__SUM_BYTES},1){}dnl
__{}__{}__{}__add({__SUM_CLOCKS},7){
__{}__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}){
__{}    exx                 ; 1:4       __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(?,max 513,ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

__SAVE_EVAL(+($2) <= 2*256+1):__IS_MEM_REF($3),1:0,{
__{}dnl # 511
__{}define({__SUM_CLOCKS},7+7+13){}dnl
__{}define({__SUM_BYTES},1+2+2+1){}dnl
__{}define({__TMP_LOOP},{
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,0,2,eval(($2)>>1)){
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,1,2,eval(($2)>>1)){
__{}    djnz $-4            ; 2:13/8    __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(11+($2>>1)*(__SUM_CLOCKS)-5+10)){}dnl
__{}ifelse(eval(($2) & 0x01),{1},{dnl
__{}__{}__add({__SUM_BYTES},1){}dnl
__{}__{}__add({__SUM_CLOCKS},7){}dnl
__{}__{}define({__TMP_BONUS},{
__{}__{}__{}    ld  (HL){,}C          ; 1:7       __INFO})},
__{}{dnl
__{}__{}define({__TMP_BONUS},{})}){}dnl
__{}define({__TMP_CODE},{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16({HL},$1)   addr{}dnl
__{}__{}__LD_R16({BC},__HEX_HL(256*(($2)>>1))+$3,{HL},$1){   B = eval(($2)>>1){x,} C = $3}dnl
__{}__{}__TMP_LOOP{}dnl
__{}__{}__TMP_BONUS{}dnl
__{}__{}{
__{}__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(?,max 513,no ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_HL($1):__HEX_HL($2),__HEX_L($3)00:0x0500,{
dnl # PUSH3_FILL(0x4800,5*256,0x48)
dnl # only if HI(addr) == LO(char), because >0 == 18705t
dnl # ; t= 7+7-5+256*(4+7+4+7+4+7+4+7+4+7+4+12)=9+256*71=18185
dnl #
dnl # ; t= 7+7-5+256*(7+7+4+7+4+7+4+7+4+7+4+12)=9+256*74=18953
dnl # cca 14.8 t/b
dnl # cca 14.4 t/b if JP t=14+256*72=18446
__{}define({__SUM_CLOCKS},5*11+12){}dnl
__{}define({__SUM_BYTES},10+2){}dnl
__{}define({__TMP_LOOP},
__{}__{}__LD_R_NUM(__INFO   hi(addr),B,__HEX_H($1),C,{0x00},A,__HEX_L($3)){}dnl
__{}__{}{
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   C             ; 1:4       __INFO
__{}__{}    jr   nz{,} format({%-11s},$-}eval(10+__BYTES){); 2:7/12    __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(256*(__SUM_CLOCKS)-5)){}dnl
__{}define({__TMP_CODE},dnl
__{}__{}__LD_R_NUM(__INFO   char,             A,$3){}dnl
__{}__{}__LD_R_NUM(__INFO   lo(addr),C,{0x00},A,__HEX_L($3)){}dnl
__{}__{}__TMP_LOOP){}dnl
__{}                       ;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] )__INFO   fill(addr,u,char)   variant 0>0: fill(0x??00,5*256,hi(addr)){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($1+$2):__HEX_L(($2) % 5):__HEX_L(5*256>=$2),0x00:0x00:0x01,{
dnl # PUSH3_FILL(0x5000-5*231,5*231,0x48)
dnl # ; <  256 t= 10+7+$2*(7+4+7+4+7+4+7+4+7+4+10)/5=17+$2*13
dnl # ; <  512 t= 10+7+$2*(7+4+7+4+7+4+7+6+7+4+10)/5=17+$2*67/5=17*$2*13.4
dnl # ; <  768 t= 10+7+$2*(7+4+7+4+7+6+7+6+7+4+10)/5=17+$2*69/5=17*$2*13.8
dnl # ; < 1024 t= 10+7+$2*(7+4+7+6+7+6+7+6+7+4+10)/5=17+$2*71/5=17*$2*14.2
dnl # ; <=1280 t= 10+7+$2*(7+6+7+6+7+6+7+6+7+4+10)/5=17+$2*73/5=17*$2*14.6
dnl #
dnl # eFB  dFC  cFD  bFE  aFF  a00
dnl #                     +++
dnl # eFC  dFD  cFE  bFF  b00
dnl #                +++
dnl # eFD  dFE  cFF  c00  b01
dnl #           +++
dnl # eFE  dFF  d00  c01  b02
dnl #      +++
dnl # eFF  e00  d01  c02  b03
dnl # +++
__{}define({__TMP_X},eval(($2)/5)){}dnl
__{}define({__SUM_CLOCKS},5*7+10){}dnl
__{}define({__SUM_BYTES},8){}dnl
__{}define({__TMP_LOOP},{
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,0,5,__TMP_X){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,1,5,__TMP_X){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,2,5,__TMP_X){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,3,5,__TMP_X){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,4,5,__TMP_X-1){
__{}__{}    jp   nz{,} format({%-11s},$-10); 3:10      __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(__TMP_X*(__SUM_CLOCKS))){}dnl
__{}define({__TMP_CODE},dnl
__{}__{}__LD_R16({BC},$1){   addr = (__HEX_HL($1)..__HEX_HL($1+$2-1))}{}dnl
__{}__{}__LD_R_NUM(__INFO   char,A,$3,BC,$1){}dnl
__{}__{}__TMP_LOOP){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant >0: fill(num,5*eval($2/5) (max 1280),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($1+$2):__HEX_L(($2+2) % 5):__HEX_L(5*256>=$2+2),0x00:0x00:0x01,{dnl
dnl # PUSH3_FILL(0x5000-5*231+2,5*231-2,0x48) = PUSH3_FILL(0x4B7F,5*231-2,0x48)
dnl # ; <  256 t= 10+7+$2*(7+4+7+4+7+4+7+4+7+4+10)/5=17+$2*13
dnl # ; <  512 t= 10+7+$2*(7+4+7+4+7+4+7+6+7+4+10)/5=17+$2*67/5=17*$2*13.4
dnl # ; <  768 t= 10+7+$2*(7+4+7+4+7+6+7+6+7+4+10)/5=17+$2*69/5=17*$2*13.8
dnl # ; < 1024 t= 10+7+$2*(7+4+7+6+7+6+7+6+7+4+10)/5=17+$2*71/5=17*$2*14.2
dnl # ; <=1280 t= 10+7+$2*(7+6+7+6+7+6+7+6+7+4+10)/5=17+$2*73/5=17*$2*14.6
dnl #
dnl # eFB  dFC  cFD  bFE  aFF  a00
dnl #                     +++
dnl # eFC  dFD  cFE  bFF  b00
dnl #                +++
dnl # eFD  dFE  cFF  c00  b01
dnl #           +++
dnl # eFE  dFF  d00  c01  b02
dnl #      +++
dnl # eFF  e00  d01  c02  b03
dnl # +++
__{}define({__TMP_X},eval(($2+2)/5)){}dnl
__{}define({__SUM_CLOCKS},7+7){}dnl
__{}define({__SUM_BYTES},1+5+1+3){}dnl
__{}define({__TMP_LOOP_1},{
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1+5,-2,5,__TMP_X-1){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}){}dnl
__{}define({__TMP_CLOCKS},__SUM_CLOCKS){}dnl
__{}define({__TMP_LOOP_2},
                                                     __INC_REG16(BC,$1,  -1,5,__TMP_X){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,   0,5,__TMP_X){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO}__INC_REG16(BC,$1,   1,5,__TMP_X){
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   C             ; 1:4       __INFO
__{}__{}    jp   nz{,} format({%-11s},$-10); 3:10      __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(__TMP_X*(__SUM_CLOCKS+21+4+10)-__TMP_CLOCKS+12)){}dnl
__{}define({__TMP_CODE},dnl
__{}__LD_R16({BC},$1-1){   addr = (__HEX_HL($1)..__HEX_HL($1+$2-1))}dnl
__{}__LD_R_NUM(__INFO   char,A,$3,BC,$1-1){
__{}    db 0x18             ; 1:12      __INFO   db 0x18{,}0x02 = jr $+4}dnl
__{}__TMP_LOOP_1{}dnl
__{}__TMP_LOOP_2){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant >0: fill(num,5*__TMP_X-2 (max 1280),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L(($2) % 5):ifelse(__HEX_L(($2) % 4),0x00,0,1):__HEX_L(3*256>$2):__IS_MEM_REF($3),0x00:1:0x01:1,{
dnl # PUSH3_FILL(0x5011,5*151,(char))
dnl # neni efektivni kdyz pretina vic jak 2 segmenty
dnl # max 20 bytes
dnl # ; 0 segment cca t/b= (5*11+1*13)/5=68/5=13.6
dnl # ; 1 segment cca t/b= (4*11+2*13)/5=70/5=14
dnl # ; 2 segment cca t/b= (3*11+3*13)/5=72/5=14.4
dnl # ; 3 segment cca t/b= (2*11+4*13)/5=74/5=14.8   >14.75=(3*11+2*13)/4
dnl # ; 4 segment cca t/b= (1*11+5*13)/5=76/5=15.2   >14.75=(3*11+2*13)/4
dnl # ; 5 segment cca t/b= (0*11+6*13)/5=78/5=15.6   >14.75=(3*11+2*13)/4
__{}define({__TMP_X},eval(($2)/5)){}dnl
__{}define({__SUM_CLOCKS},5*7+13){}dnl
__{}define({__SUM_BYTES},1+5+2+1){}dnl
__{}define({__TMP_LOOP},{
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,0,5,__TMP_X){
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,1,5,__TMP_X){
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,2,5,__TMP_X){
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,3,5,__TMP_X){
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,4,5,__TMP_X){
__{}__{}    djnz $-10           ; 2:8/13    __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(4+__TMP_X*(__SUM_CLOCKS)-5+4)){}dnl
__{}define({__TMP_CODE},{
__{}__{}    exx                 ; 1:4       __INFO}dnl
__{}__{}__LD_R16({DE},$1){}dnl
__{}__{}__LD_R_NUM(__INFO   char,                A,$3,DE,$1){}dnl
__{}__{}__LD_R_NUM(__INFO   __TMP_X{}x,B,__TMP_X,A,$3,DE,$1){}dnl
__{}__{}__TMP_LOOP{
__{}__{}    exx                 ; 1:4       __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(num,5*__TMP_X (max 767),ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L(($2) % 5):ifelse(__HEX_L(($2) % 4),0x00,0,1):__HEX_L(3*256>$2):__IS_MEM_REF($3),0x00:1:0x01:0,{
dnl # PUSH3_FILL(0x5011,5*151,0x48)
dnl # neni efektivni kdyz pretina vic jak 2 segmenty
dnl # max 20 bytes
dnl # ; 0 segment cca t/b= (5*11+1*13)/5=68/5=13.6
dnl # ; 1 segment cca t/b= (4*11+2*13)/5=70/5=14
dnl # ; 2 segment cca t/b= (3*11+3*13)/5=72/5=14.4
dnl # ; 3 segment cca t/b= (2*11+4*13)/5=74/5=14.8   >14.75=(3*11+2*13)/4
dnl # ; 4 segment cca t/b= (1*11+5*13)/5=76/5=15.2   >14.75=(3*11+2*13)/4
dnl # ; 5 segment cca t/b= (0*11+6*13)/5=78/5=15.6   >14.75=(3*11+2*13)/4
__{}define({__TMP_X},eval(($2)/5)){}dnl
__{}define({__SUM_CLOCKS},5*7+13){}dnl
__{}define({__SUM_BYTES},1+5+2+1){}dnl
__{}define({__TMP_LOOP},{
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,0,5,__TMP_X){
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,1,5,__TMP_X){
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,2,5,__TMP_X){
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,3,5,__TMP_X){
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,4,5,__TMP_X){
__{}__{}    djnz $-10           ; 2:8/13    __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(11+__TMP_X*(__SUM_CLOCKS)-5+10)){}dnl
__{}define({__TMP_CODE},{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16({HL},$1){}dnl
__{}__{}__LD_R16({BC},__HEX_HL(256*__TMP_X)+$3,{HL},$1){}dnl
__{}__{}__TMP_LOOP{
__{}__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(num,5*__TMP_X (max 767),no ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

_TYP_SINGLE:__HEX_L($1):__HEX_HL($2),{small:0x00:0x0400},{
dnl # ; t= 7+7-5+256*(7+7+4+7+4+7+4+7+4+12)=9+256*63=16137
dnl # cca 15.8 t/b
dnl # cca 15.3 t/b if JP t=14+256*61=15630
__{}define({__SUM_CLOCKS},4*11+12){}dnl
__{}define({__SUM_BYTES},8+2){}dnl
__{}define({__TMP_LOOP},
__{}__{}__LD_R_NUM(__INFO   hi(addr),B,__HEX_H($1),C,{0x00},A,__HEX_L($3)){}dnl
__{}__{}{
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC){,}A          ; 1:7       __INFO
__{}__{}    inc   C             ; 1:4       __INFO
__{}__{}    jr   nz{,} format({%-11s},$-}eval(8+__BYTES){); 2:7/12    __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(256*__SUM_CLOCKS-5)){}dnl
__{}define({__TMP_CODE},dnl
__{}__{}__LD_R_NUM(__INFO   char,             A,$3){}dnl
__{}__{}__LD_R_NUM(__INFO   lo(addr),C,{0x00},A,__HEX_L($3)){}dnl
__{}__{}__TMP_LOOP){}dnl
__{}                       ;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] )__INFO   fill(addr,u,char)   variant: fill(0x??00,4*256,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($1):__HEX_HL($2):__IS_MEM_REF($3),0x00:0x0400:1,{
dnl # ; t= 4+13+7?+7?+256*(4+7+4+7+4+7+4+7+4+10)+4=21+14?+256*58=14883
dnl # cca 14.5 t/b
__{}define({__SUM_CLOCKS},21+256*58){}dnl
__{}define({__SUM_BYTES},17){}dnl
__{}define({__TMP_CODE},{
__{}__{}    exx                 ; 1:4       __INFO
__{}__{}    ld    A,format({%-12s},$3); 3:13      __INFO}dnl
__{}__{}__LD_R_NUM(__INFO   hi(addr),D,__HEX_H($1)){}dnl
__{}__{}__LD_R_NUM(__INFO   lo(addr),C,0x00,D,__HEX_H($1)){
__{}__{}    ld    B, D          ; 1:4       __INFO   hi(addr)
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   C             ; 1:4       __INFO
__{}__{}    jp   nz, format({%-11s},$-9); 3:10      __INFO
__{}__{}    exx                 ; 1:4       __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(0x??00,4*256,ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($1):__HEX_HL($2):__IS_MEM_REF($3),0x00:0x0400:0,{
dnl # ; t= 11+10+7+256*(4+7+4+7+4+7+4+7+4+10)+10=38+256*58=14886
dnl # cca 14.5 t/b
__{}define({__SUM_CLOCKS},11+256*(4+4*11+10)+10){}dnl
__{}define({__SUM_BYTES},14){}dnl
__{}define({__TMP_CODE},{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16({BC},__HEX_HL(256*__HEX_H($1))+$3){}dnl
__{}__{}__LD_R_NUM(__INFO   lo(addr),L,0x00,B,__HEX_H($1),C,__HEX_L($3)){
__{}__{}    ld    H, B          ; 1:4       __INFO   hi(addr) = B
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    jp   nz, format({%-11s},$-9); 3:10      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(0x??00,4*256,no ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

bad__HEX_L($1):__HEX_HL($2),0x00:0x0600,{
dnl # ; t= 7+7+256*(7+11*6+10)=14+256*83=21262
dnl # cca 13.8 t/b
dnl # [21:21262]
dnl # exist (4*11+10)/4 = 13.5 t/b variant [22:20874] fill(addr,u,char)   variant >0: fill(no ptr,4*384 (no limit),?)
__{}define({__SUM_CLOCKS},0){}dnl
__{}define({__SUM_BYTES},6*2+3){}dnl
__{}define({__TMP_CODE},
__{}__{}__LD_R_NUM(__INFO   char,                           A,$3){}dnl
__{}__{}__LD_R_NUM(__INFO   lo(addr),              C,{0x00},A,__HEX_L($3)){}dnl
__{}__{}__LD_R_NUM(__INFO   hi(addr),B,__HEX_H($1),C,{0x00},A,__HEX_L($3)){
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   C             ; 1:4       __INFO
__{}__{}    jp   nz, format({%-11s},$-eval(12+__BYTES)); 3:10      __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(__SUM_CLOCKS-__CLOCKS+256*(__CLOCKS+6*11+10))){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(0x??00,6*256,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L(0==(($2) % 6)):__HEX_L(+(1024 < $2) || (2==(($2) % 4))):__HEX_L(6*256>=$2):__IS_MEM_REF($3),0x01:0x01:0x01:1,{
__{}dnl # 6*253
__{}define({_TMP_X},eval(($2)/6)){}dnl
__{}define({__SUM_CLOCKS},42+13){}dnl
__{}define({__SUM_BYTES},1+6+2+1){}dnl
__{}define({__TMP_LOOP},{
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,0,6,_TMP_X){
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,1,6,_TMP_X){
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,2,6,_TMP_X){
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,3,6,_TMP_X){
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,4,6,_TMP_X){
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,5,6,_TMP_X){
__{}    djnz $-12           ; 2:13/8    __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(4+_TMP_X*(__SUM_CLOCKS)-5+4)){}dnl
__{}define({__TMP_CODE},{
__{}    exx                 ; 1:4       __INFO}dnl
__{}__LD_R16({DE},$1){}dnl
__{}__LD_R_NUM(__INFO   char,       A,$3){}dnl
__{}__LD_R_NUM(__INFO   B' = ($2)/6,B,__HEX_L(_TMP_X),A,$3,DE,$1){}dnl
__{}__TMP_LOOP{
__{}    exx                 ; 1:4       __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(?,6*eval(($2)/6)(max 1536),ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L(0==(($2) % 6)):__HEX_L(+(($2 > 1024) && ifelse(__HEX_L($1),0x00,0,__HEX_L($1+$2),0x00,0,1)) || (2==(($2) % 4))):__HEX_L(6*256>=$2):__IS_MEM_REF($3),0x01:0x01:0x01:0,{
__{}dnl # 6*253
__{}define({__TMP_X},eval(($2)/6)){}dnl
__{}define({__SUM_CLOCKS},42+13){}dnl
__{}define({__SUM_BYTES},1+6+2+1){}dnl
__{}define({__TMP_LOOP},{
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,0,6,__TMP_X){
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,1,6,__TMP_X){
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,2,6,__TMP_X){
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,3,6,__TMP_X){
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,4,6,__TMP_X){
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,5,6,__TMP_X){
__{}    djnz $-12           ; 2:13/8    __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(11+__TMP_X*(__SUM_CLOCKS)-5+10)){}dnl
__{}define({__TMP_CODE},{
__{}    push HL             ; 1:11      __INFO}dnl
__{}__LD_R16({HL},$1){}dnl
__{}__LD_R16({BC},__HEX_HL(256*__TMP_X)+$3,{HL},$1){   B = __TMP_X{}x, C = char}dnl
__{}__TMP_LOOP{
__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(?,6*eval(($2)/6)(max 1536),no ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($1):__HEX_HL($2),0x00:0x0700,{dnl
dnl # ; t= 7+7+256*(7+7*11+10)=14+256*94=24078
dnl # cca 13.43 t/b
dnl # [23:24078]
dnl # exist:
dnl # [22:27820]  0x5000 8*256 0x48 fill   fill(addr,u,char)   variant >0: fill(no ptr,4*512 (no limit),?)
__{}define({__SUM_CLOCKS},0){}dnl
__{}define({__SUM_BYTES},7*2+3){}dnl
__{}define({__TMP_CODE},
__{}__{}__LD_R_NUM(__INFO   char,                           A,$3){}dnl
__{}__{}__LD_R_NUM(__INFO   lo(addr),              C,{0x00},A,__HEX_L($3)){}dnl
__{}__{}__LD_R_NUM(__INFO   hi(addr),B,__HEX_H($1),C,{0x00},A,__HEX_L($3)){
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   C             ; 1:4       __INFO
__{}__{}    jp   nz, format({%-11s},$-eval(14+__BYTES)); 3:10      __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(__SUM_CLOCKS-__CLOCKS+256*(__CLOCKS+7*11+10))){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(0x??00,7*256,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

bad__HEX_L($1):__HEX_HL($2),0x00:0x0800,{dnl
dnl # ; t= 7+7+256*(7+8*11+10)=14+256*105=26984
dnl # cca 13.125 t/b
dnl # [25:26894]
dnl # exist:
dnl # [22:27820]  0x5000 8*256 0x48 fill   fill(addr,u,char)   variant >0: fill(no ptr,4*512 (no limit),?)
__{}define({__SUM_CLOCKS},0){}dnl
__{}define({__SUM_BYTES},8*2+3){}dnl
__{}define({__TMP_CODE},
__{}__{}__LD_R_NUM(__INFO   char,                           A,$3){}dnl
__{}__{}__LD_R_NUM(__INFO   lo(addr),              C,{0x00},A,__HEX_L($3)){}dnl
__{}__{}__LD_R_NUM(__INFO   hi(addr),B,__HEX_H($1),C,{0x00},A,__HEX_L($3)){
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   B             ; 1:4       __INFO
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc   C             ; 1:4       __INFO
__{}__{}    jp   nz, format({%-11s},$-eval(16+__BYTES)); 3:10      __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(__SUM_CLOCKS-__CLOCKS+256*(__CLOCKS+8*11+10))){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(0x??00,8*256,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L(4*256+3>=$2):__IS_MEM_REF($3),{0x01:1},{
__{}define({__TMP_X},eval(($2)>>2)){}dnl
__{}define({__SUM_CLOCKS},4*7+13){}dnl
__{}define({__SUM_BYTES},1+4+2+1){}dnl
__{}define({__TMP_LOOP},{
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,0,4,__TMP_X){
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,1,4,__TMP_X){
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,2,4,__TMP_X){
__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,3,4,__TMP_X){
__{}    djnz $-8            ; 2:13/8    __INFO})dnl
__{}define({__SUM_CLOCKS},eval(4+__TMP_X*__SUM_CLOCKS-5+4)){}dnl
__{}ifelse(eval(($2) % 4),{0},{dnl
__{}__{}define({__TMP_PLUS},{})},
__{}eval(($2) % 4),{1},{dnl
__{}__{}define({__TMP_PLUS},{
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}){}dnl
__{}__{}__add({__SUM_BYTES},1){}dnl
__{}__{}__add({__SUM_CLOCKS},7)},
__{}eval(($2) % 4),{2},{dnl
__{}__{}define({__TMP_PLUS},{
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,4,1,1){
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}){}dnl
__{}__{}__add({__SUM_BYTES},2){}dnl
__{}__{}__add({__SUM_CLOCKS},14)},
__{}{dnl
__{}__{}define({__TMP_PLUS},{
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,4,1,1){
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}__INC_REG16({DE},$1,5,1,1){
__{}__{}    ld  (DE){,}A          ; 1:7       __INFO}){}dnl
__{}__{}__add({__SUM_BYTES},3){}dnl
__{}__{}__add({__SUM_CLOCKS},21){}dnl
__{}})dnl
__{}define({__TMP_CODE},{
__{}__{}    exx                 ; 1:4       __INFO}dnl
__{}__{}__LD_R16({DE},$1){   DE' = addr}dnl
__{}__{}__LD_R_NUM(__INFO   char,                  A,$3,DE,$1){}dnl
__{}__{}__LD_R_NUM(__INFO   B' = ($2)>>2,B,__TMP_X,A,$3,DE,$1){}dnl
__{}__{}__TMP_LOOP{}dnl
__{}__{}__TMP_PLUS{
__{}__{}    exx                 ; 1:4       __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(?,max 1027,ptr){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L(4*256+3>=$2):__IS_MEM_REF($3),{0x01:0},{
__{}define({__SUM_CLOCKS},28+13){}dnl
__{}define({__SUM_BYTES},4+2){}dnl
__{}define({_TEMP_LOOP},{dnl
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,0,4,eval(($2)>>2)){
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,1,4,eval(($2)>>2)){
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,2,4,eval(($2)>>2)){
__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,3,4,eval(($2)>>2))){}dnl
__{}define({__SUM_CLOCKS},eval(($2>>2)*__SUM_CLOCKS-5)){}dnl
__{}dnl
__{}ifelse(eval(($2) % 4),{0},{dnl
__{}__{}define({_TEMP_PLUS},{})},
__{}eval(($2) % 4),{1},{dnl
__{}__{}define({_TEMP_PLUS},{
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}){}dnl
__{}__{}__add({__SUM_BYTES},1){}dnl
__{}__{}__add({__SUM_CLOCKS},7)},
__{}eval(($2) % 4),{2},{dnl
__{}__{}define({_TEMP_PLUS},{
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,eval($2-2),1,1){
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}){}dnl
__{}__{}__add({__SUM_BYTES},2){}dnl
__{}__{}__add({__SUM_CLOCKS},14)},
__{}{dnl
__{}__{}define({_TEMP_PLUS},{
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,eval($2-3),1,1){
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}__INC_REG16({HL},$1,eval($2-2),1,1){
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO}){}dnl
__{}__{}__add({__SUM_BYTES},3){}dnl
__{}__{}__add({__SUM_CLOCKS},21){}dnl
__{}}){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({BC},__HEX_HL(256*($2>>2))+$3,{HL},$1){}dnl
__{}__LD_REG16({HL},$1){}dnl
__{}__add({__SUM_BYTES},2){}dnl
__{}__add({__SUM_CLOCKS},21){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(?,max 1027,no ptr)
__{}    push HL             ; 1:11      __INFO{}dnl
__{}__CODE_16BIT   addr{}dnl
__{}__LD_REG16({BC},__HEX_HL(256*($2>>2))+$3,{HL},$1){}dnl
__{}__CODE_16BIT   B = ($2)>>2, C = char
__{}_TEMP_LOOP
__{}    djnz $-8            ; 2:13/8    __INFO{}dnl
__{}_TEMP_PLUS
__{}    pop  HL             ; 1:10      __INFO},

x__HEX_L($1):__HEX_HL(+($2)%(6*256)):__HEX_L($2>6*256),0x00:0x0000:0x01,{dnl
dnl # ; t/b= (4+6*11+10)/6=80/6=13.3
__{}define({__TMP_X},eval(($2)/(6*256))){}dnl
__{}define({__SUM_BYTES},22){}dnl
__{}define({__SUM_CLOCKS},eval(11+__TMP_X*(256*(4+6*11+10)+4+13)+4-5+10)){}dnl
__{}define({__TMP_CODE},{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16({BC},256*__TMP_X+__HEX_H($1)){   B = u/(6*256), C = hi(addr)}dnl
__{}__{}__LD_R_NUM(__INFO   char,     A,$3,B,__TMP_X,C,__HEX_H($1)){}dnl
__{}__{}__LD_R_NUM(__INFO   lo(addr),L, 0,A,$3,B,__TMP_X,C,__HEX_H($1)){
__{}__{}    ld    H{,} C          ; 1:4       __INFO
__{}__{}    ld  (HL){,}A          ; 1:7       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    ld  (HL){,}A          ; 1:7       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    ld  (HL){,}A          ; 1:7       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    ld  (HL){,}A          ; 1:7       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    ld  (HL){,}A          ; 1:7       __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    ld  (HL){,}A          ; 1:7       __INFO
__{}__{}    inc   L             ; 1:4       __INFO
__{}__{}    jp   nz{,}$-13        ; 3:10      __INFO
__{}__{}    inc   H             ; 1:4       __INFO
__{}__{}    ld    C{,} H          ; 1:4       __INFO
__{}__{}    djnz $-16           ; 2:8/13    __INFO
__{}__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(0x??00,n*6*256,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($1+$2):__HEX_L(+(($2) % 4)),{0x00:0x00},{
__{}dnl # 0x5000-4*321,4*321
__{}define({__TMP_X},eval(($2)/4))dnl
__{}define({__TMP_B},eval(__HEX_H($1+$2)-__HEX_H($1)))dnl
__{}define({__TMP_C},$3)dnl
__{}define({__SUM_BYTES},1+8+3+1+2+1)dnl
__{}define({__SUM_CLOCKS},11+__TMP_X*(4*11+10)+__TMP_B*(4+13)-5+10)dnl
__{}define({__TMP_CODE},{
__{}    push HL             ; 1:11      __INFO}dnl
__{}__LD_R16({HL},$1){   HL = addr}dnl
__{}__LD_R16({BC},__HEX_HL(256*__TMP_B)+__TMP_C,{HL},$1){   B = __TMP_B{}x, C = char
__{}    ld  (HL),C          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld  (HL),C          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld  (HL),C          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    ld  (HL),C          ; 1:7       __INFO
__{}    inc   L             ; 1:4       __INFO
__{}    jp   nz, $-8        ; 3:10      __INFO
__{}    inc   H             ; 1:4       __INFO
__{}    djnz $-12           ; 2:13/8    __INFO
__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant >0: fill(no ptr,4*__TMP_X (no limit),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($1):__HEX_L(+(($2) % 4)),{0x00:0x00},{
__{}dnl # 4*321
__{}define({__TMP_X},eval(($2)/4))dnl
__{}define({__TMP_HL},$1+$2){}dnl
__{}ifelse(__HEX_L($1+$2),0x00,{__add({__TMP_HL},-256)}){}dnl
__{}define({__TMP_B},eval(1+__HEX_H($1+$2-1)-__HEX_H($1)))dnl
__{}define({__SUM_BYTES},1+8+3+1+2+1)dnl
__{}define({__SUM_CLOCKS},11+__TMP_X*(4*11+10)+__TMP_B*(4+13)-5+10)dnl
__{}define({__TMP_CODE},{
__{}    push HL             ; 1:11      __INFO   __HEX_HL($1)..__HEX_HL($1+$2-1)}dnl
__{}__LD_R16({HL},__TMP_HL){   HL = addr+u}dnl
__{}__LD_R16({BC},__HEX_HL(256*__TMP_B)+$3,{HL},__TMP_HL){   B = __TMP_B{}x, C = char
__{}    dec   L             ; 1:4       __INFO
__{}    ld  (HL),C          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ld  (HL),C          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ld  (HL),C          ; 1:7       __INFO
__{}    dec   L             ; 1:4       __INFO
__{}    ld  (HL),C          ; 1:7       __INFO
__{}    jp   nz, $-8        ; 3:10      __INFO
__{}    dec   H             ; 1:4       __INFO
__{}    djnz $-12           ; 2:13/8    __INFO
__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant 0>: fill(no ptr,4*__TMP_X (no limit),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__IS_MEM_REF($1):__HEX_L(+(($2) % 4)),{1:0x00},{
__{}dnl # 4*666
__{}define({__TMP_X},__HEX_HL(($2)/4))dnl
__{}define({__TMP_B},__HEX_L(__TMP_X % 256))dnl
__{}define({__TMP_C},__HEX_L(__TMP_X / 256))dnl
__{}ifelse(__TMP_B,0x00,,{__add({__TMP_C},1)}){}dnl
__{}define({__SUM_BYTES},eval(1+3+8+2+1+3+1))dnl
__{}define({__SUM_CLOCKS},eval(11+16+__TMP_X*(5*13)+__TMP_C*(4+10-5)+10))dnl
__{}define({__TMP_CODE},{
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},$1); 3:16      __INFO   HL = addr}dnl
__{}__{}__LD_R16({BC},__HEX_HL(256*__TMP_B+__TMP_C)){   $2{}x = 4*B + 256*4*(C-1) = 4*eval(__TMP_B) + 256*eval(4*(__TMP_C-1))}dnl
__{}__{}__LD_R_NUM(__INFO{   A = char},{A},$3,HL,$1,B,__TMP_B,C,__TMP_C){
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),A          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    djnz $-8            ; 2:13/8    __INFO
__{}__{}    dec  C              ; 1:4       __INFO
__{}__{}    jp   nz, $-11       ; 3:10      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(ptr,4*eval(__TMP_X) (no limit),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__IS_MEM_REF($1):__HEX_L(+(($2) % 4)),{0:0x00},{
__{}dnl # 4*666
__{}define({__TMP_X},__HEX_HL(($2)/4))dnl
__{}define({__TMP_B},__HEX_L(__TMP_X % 256))dnl
__{}define({__TMP_C},__HEX_L(__TMP_X / 256))dnl
__{}ifelse(__TMP_B,0x00,,{__add({__TMP_C},1)}){}dnl
__{}define({__SUM_BYTES},eval(1+4+2+1+3+1))dnl
__{}define({__SUM_CLOCKS},eval(4*7+13))dnl
__{}define({__TMP_LOOP},{
__{}    ld  (HL){,}A          ; 1:7       __INFO}__INC_REG16(HL,$1,0,4,__TMP_X){
__{}    ld  (HL){,}A          ; 1:7       __INFO}__INC_REG16(HL,$1,1,4,__TMP_X){
__{}    ld  (HL){,}A          ; 1:7       __INFO}__INC_REG16(HL,$1,2,4,__TMP_X){
__{}    ld  (HL){,}A          ; 1:7       __INFO}__INC_REG16(HL,$1,3,4,__TMP_X){
__{}    djnz $-8            ; 2:13/8    __INFO}){}dnl
__{}define({__SUM_CLOCKS},eval(11+__TMP_X*(__SUM_CLOCKS)+__TMP_C*(-5+4+10)+10))dnl
__{}define({__TMP_CODE},{
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16({HL},$1){   HL = addr}dnl
__{}__{}__LD_R16({BC},__HEX_HL(256*__TMP_B+__TMP_C)){   $2{}x = 4*B + 256*4*(C-1) = 4*eval(__TMP_B) + 256*eval(4*(__TMP_C-1))}dnl
__{}__{}__LD_R_NUM(__INFO{   A = char},{A},$3,HL,$1,B,__TMP_B,C,__TMP_C){}dnl
__{}__{}__TMP_LOOP{
__{}__{}    dec  C              ; 1:4       __INFO
__{}__{}    jp   nz, $-11       ; 3:10      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant: fill(no ptr,4*eval(__TMP_X) (no limit),?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__HEX_L($1):__HEX_L(__HEX_L($1+$2)+0>1):__IS_MEM_REF($3),{0x00:0x01:0},{
__{}dnl # fail PUSH3_FILL(0x4800,5*256+1,abc)
__{}dnl # 2*600-1 or 2*600-2
__{}define({__TMP_X},     eval(($2)>>1)){}dnl
__{}define({__TMP_HL},    eval($1+$2-(($2) & 1))){}dnl
__{}ifelse(__HEX_L(__TMP_HL),0x00,__add({__TMP_HL},-256)){}dnl
dnl __{}ifelse(__HEX_L($1+$2),0x00,{__add({__TMP_HL},-256)}){}dnl
__{}define({__TMP_B},eval(1+(($2-1)>>8))){}dnl
__{}define({__SUM_BYTES}, 1+2*2+2+1+2+1){}dnl
__{}define({__SUM_CLOCKS},eval(11+__TMP_X*(2*11+12)+__TMP_B*(4+13-5)-5+10)){}dnl
__{}ifelse(eval(($2) & 1),1,{dnl
__{}__{}__add({__SUM_BYTES},1){}dnl
__{}__{}__add({__SUM_CLOCKS},7){}dnl
__{}__{}define({__TMP_BONUS},{
__{}__{}    ld  (HL){,}C          ; 1:7       __INFO})},
__{}{dnl
__{}__{}define({__TMP_BONUS},{}){}dnl
__{}}){}dnl
__{}define({__TMP_CODE},{
__{}__{}    push HL             ; 1:11      __INFO   __HEX_HL($1)..__HEX_HL($1+$2-1)}dnl
__{}__LD_R16({HL},__TMP_HL){   HL = addr+u}dnl
__{}__LD_R16({BC},__HEX_HL(256*__TMP_B)+$3,{HL},__TMP_HL){   B = __TMP_B{}x, C = char}dnl
__{}__{}__TMP_BONUS{
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    dec   L             ; 1:4       __INFO
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    jr   nz, $-4        ; 2:7/12    __INFO
__{}__{}    dec   H             ; 1:4       __INFO
__{}__{}    djnz $-7            ; 2:13/8    __INFO
__{}__{}    pop  HL             ; 1:10      __INFO}){}dnl
__{}format({%36s},;[__SUM_BYTES:format({%-8s},__SUM_CLOCKS] ))__INFO   fill(addr,u,char)   variant 0>: fill(no ptr,no limit,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__{}__IS_MEM_REF($1),1,{
__{}define({__SUM_BYTES},6+3){}dnl
__{}define({__SUM_CLOCKS},eval(22+14+21*($2-1)-5+20)){}dnl
__{}define({__TMP_CODE},{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(                             {HL},$1){   HL = addr from
__{}__{}    ld    E{,} L          ; 1:4       __INFO
__{}__{}    ld    D{,} H          ; 1:4       __INFO
__{}__{}    inc  DE             ; 1:6       __INFO   DE = to}dnl
__{}__{}__LD_R16(         {BC},$2-1,{HL},$1){   = $2-1}dnl
__{}__{}__LD_MEM8({HL},$3,{BC},$2-1,{HL},$1){
__{}__{}    ldir                ; 2:u*21/16 __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO}){}dnl
__{}format({%28s},;[__SUM_BYTES:)format({%-7s},__SUM_CLOCKS]) __INFO   fill(addr,u,char)   default variant: fill(ptr,?,?){}dnl
__{}__TMP_CODE{}dnl
__{}},

__{}{
__{}define({__SUM_BYTES},6){}dnl
__{}define({__SUM_CLOCKS},eval(22+21*($2-1)-5+20)){}dnl
__{}define({__TMP_CODE},{
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO}dnl
__{}__{}__LD_R16(                             {HL},$1){   HL = addr from}dnl
__{}__{}__LD_R16(                   {DE},$1+1,{HL},$1){   DE = to}dnl
__{}__{}__LD_R16(         {BC},$2-1,{DE},$1+1,{HL},$1){   = $2-1}dnl
__{}__{}__LD_MEM8({HL},$3,{BC},$2-1,{DE},$1+1,{HL},$1){
__{}__{}    ldir                ; 2:u*21/16 __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO}){}dnl
__{}format({%28s},;[__SUM_BYTES:)format({%-7s},__SUM_CLOCKS]) __INFO   fill(addr,u,char)   default variant: fill(no ptr,?,?){}dnl
__{}__TMP_CODE{}dnl
__{}}){}dnl
}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
    ld    A, (HL)       ; 1:7       __INFO   ( addr -- x )
    inc  HL             ; 1:6       __INFO
    ld    H, (HL)       ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO}){}dnl
dnl
dnl
dnl
dnl # ( addr -- x $1 )
define({FETCH_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_FETCH_PUSH},{@ $1},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FETCH_PUSH},{dnl
define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),{1},{
    push DE             ; 1:11      __INFO   ( addr -- x $1 )  x = (addr)
    ld    E, (HL)       ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    D, (HL)       ; 1:7       __INFO
    ld   HL, format({%-11s},$1); 3:16      __INFO},
{
    push DE             ; 1:11      __INFO   ( addr -- x $1 )  x = (addr)
    ld    E, (HL)       ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    D, (HL)       ; 1:7       __INFO
    ld   HL, __FORM({%-11s},$1); 3:10      __INFO}){}dnl
}){}dnl
dnl
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
__{}define({__INFO},__COMPILE_INFO)
                        ;[6:41]     __INFO   ( addr -- addr x )
    push DE             ; 1:11      __INFO
    ld    E, (HL)       ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    D, (HL)       ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ex   DE, HL         ; 1:4       __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:37]     __INFO   ( addr -- x addr )
    push DE             ; 1:11      __INFO
    ld    E, (HL)       ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    D, (HL)       ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),1,{
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},$1); 3:16      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO},
{
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},($1)); 3:16      __INFO}){}dnl
}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),1,{
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},$1); 3:16      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO},
{
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},($1)); 3:16      __INFO
    inc  HL             ; 1:6       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr @ 2+
dnl # ( -- x )
define({PUSH_FETCH_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_2ADD},{$1 @ 2+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_2ADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),1,{
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},$1); 3:16      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    inc  HL             ; 1:6       __INFO},
{
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},($1)); 3:16      __INFO
    inc  HL             ; 1:6       __INFO
    inc  HL             ; 1:6       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # addr @ x+
dnl # ( -- x )
define({PUSH_FETCH_PUSH_ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_PUSH_ADD},{$1 @ $2 +},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_PUSH_ADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<2),{1},{
__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
__IS_MEM_REF($1),1,{
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},$1); 3:16      __INFO
    ld    A,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO{}__ASM_TOKEN_PUSH_ADD($2)},
{
    push DE             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO
    ld   HL,format({%-12s},($1)); 3:16      __INFO{}__ASM_TOKEN_PUSH_ADD($2)}){}dnl
}){}dnl
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
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},$1){}__CODE_16BIT
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    inc  DE             ; 1:6       __INFO{}__LD_REG16({HL},$2){}__CODE_16BIT},
__{}{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},($1)){}__CODE_16BIT
__{}    inc  HL             ; 1:6       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO{}__LD_REG16({HL},$2){}__CODE_16BIT{}dnl
__{}}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # addr @ 2+ number
dnl # ( -- x2 x1 )  x2 = (addr)+2
define({PUSH_FETCH_2ADD_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_2ADD_PUSH},{$1 @ 2+ $2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_2ADD_PUSH},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
$2,{},{
__{}  .error {$0}(): Missing second parameter!},
__{}eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},$1){}__CODE_16BIT
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO
__{}    inc  DE             ; 1:6       __INFO
__{}    inc  DE             ; 1:6       __INFO{}__LD_REG16({HL},$2){}__CODE_16BIT},
__{}{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},($1)){}__CODE_16BIT
__{}    inc  HL             ; 1:6       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO{}__LD_REG16({HL},$2){}__CODE_16BIT{}dnl
__{}}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # addr @ x + number
dnl # ( -- x2 x1 )  x2 = (addr)+x
define({PUSH_FETCH_PUSH_ADD_PUSH},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_PUSH_ADD_PUSH},{$1 @ $2 + $3},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_PUSH_ADD_PUSH},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
$2,{},{
__{}  .error {$0}(): Missing second parameter!},
$3,{},{
__{}  .error {$0}(): Missing third parameter!},
__{}eval($#>3),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}define({_TMP_INFO},__INFO){}dnl
__{}ifelse(__IS_MEM_REF($1),1,{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},$1){}__CODE_16BIT
__{}    ld    E,(HL)        ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld    D,(HL)        ; 1:7       __INFO{}__LD_REG16({DE},$2){}__CODE_16BIT
__{}    add  HL, DE         ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO{}__LD_REG16({HL},$3,{HL},$2){}__CODE_16BIT},
__{}__HEX_HL($2),{0x0001},{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},($1)){}__CODE_16BIT
__{}    inc  HL             ; 1:6       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO{}__LD_REG16({HL},$3){}__CODE_16BIT},
__{}__HEX_HL($2),{0xFFFF},{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},($1)){}__CODE_16BIT
__{}    dec  HL             ; 1:6       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO{}__LD_REG16({HL},$3){}__CODE_16BIT},
__{}__HEX_HL($2),{0x0002},{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},($1)){}__CODE_16BIT
__{}    inc  HL             ; 1:6       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO{}__LD_REG16({HL},$3){}__CODE_16BIT},
__{}__HEX_HL($2),{0xFFFE},{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},($1)){}__CODE_16BIT
__{}    dec  HL             ; 1:6       __INFO
__{}    dec  HL             ; 1:6       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO{}__LD_REG16({HL},$3){}__CODE_16BIT},
__{}{
__{}    push DE             ; 1:11      __INFO
__{}    push HL             ; 1:11      __INFO{}__LD_REG16({HL},($1)){}__CODE_16BIT{}__LD_REG16({DE},$2){}__CODE_16BIT
__{}    add  HL, DE         ; 1:11      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO{}__LD_REG16({HL},$3,{HL},$2){}__CODE_16BIT{}dnl
__{}}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # addr1 @ 1+ addr2 !
dnl # ( -- )
define({PUSH_FETCH_C1ADD_PUSH_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_C1ADD_PUSH_STORE},{$1 @ 1+ $2 !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_C1ADD_PUSH_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
$2,{},{
__{}  .error {$0}(): Missing second parameter!},
__{}eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1):$1,{1:$2},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1){}dnl
                       ;[ 6:48]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    inc (HL)            ; 1:11      __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{0:1},{define({_TMP_INFO},__INFO){}dnl
                       ;[ 9:44]     __INFO
    ld    A,format({%-12s},($1)); 3:13      __INFO
    inc   A             ; 1:4       __INFO{}__LD_REG16({BC},$2){}__CODE_16BIT
    ld  (BC),A          ; 1:7       __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{1:0},{define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({BC},$1){}dnl
                       ;[ 9:44]     __INFO{}__CODE_16BIT
    ld    A,(BC)        ; 1:7       __INFO
    inc   A             ; 1:4       __INFO
    ld  format({%-16s},($2){,}A); 3:13      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{1:1},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1)
__{}__LD_REG16({BC},$1){}dnl
                       ;[11:58]     __INFO{}__CODE_16BIT
    ld    A,(BC)        ; 1:7       __INFO
    inc   A             ; 1:4       __INFO{}__LD_REG16({BC},$2){}__CODE_16BIT
    ld  (BC),A          ; 1:7       __INFO},
{dnl
                       ;[ 7:30]     __INFO
    ld    A,format({%-12s},($1)); 3:13      __INFO
    inc   A             ; 1:4       __INFO
    ld  format({%-16s},($2){,} A); 3:13      __INFO}){}dnl
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
__{}ifelse(__IS_MEM_REF($1):$1,{1:$2},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1){}dnl
                       ;[10:60/72]  __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    inc (HL)            ; 1:11      __INFO
    jr   nz, $+4        ; 2:7/12    __INFO
    inc  HL             ; 1:6       __INFO
    inc (HL)            ; 1:11      __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{0:1},{define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}define({__TMP_B},eval(6+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(47+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({BC},($1)){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    inc  BC             ; 1:6       __INFO{}__LD_REG16({HL},$2){}__CODE_16BIT
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{1:0},{define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$1){}dnl
__{}define({__TMP_B},eval(10+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(67+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    A,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld  format({%-16s},($2){,}HL); 3:16      __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{1:1},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1)
__{}__LD_REG16({HL},$2){}dnl
__{}define({__TMP_B},eval(9+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(67+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({HL},$1){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    C,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    inc  BC             ; 1:6       __INFO{}__LD_REG16({HL},$2){}__CODE_16BIT
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
{dnl
                       ;[ 9:46]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    inc  BC             ; 1:6       __INFO
    ld  format({%-16s},($2){,} BC); 4:20      __INFO}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # addr1 @ 2+ addr2 !
dnl # ( -- )
define({PUSH_FETCH_2ADD_PUSH_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_2ADD_PUSH_STORE},{$1 @ 2+ $2 !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_2ADD_PUSH_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
$2,{},{
__{}  .error {$0}(): Missing second parameter!},
__{}eval($#>2),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(__IS_MEM_REF($1):$1,{1:$2},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1){}dnl
                       ;[13:70/82]  __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    A, 0x02       ; 2:7       __INFO
    add   A,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    jr   nc,$+4         ; 2:7/12    __INFO
    inc  HL             ; 1:6       __INFO
    inc (HL)            ; 1:11      __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{0:1},{define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}define({__TMP_B},eval(7+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(53+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({BC},($1)){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    inc  BC             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO{}__LD_REG16({HL},$2){}__CODE_16BIT
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{1:0},{define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$1){}dnl
__{}define({__TMP_B},eval(11+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(73+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    A,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    inc  HL             ; 1:6       __INFO
    ld  format({%-16s},($2){,}HL); 3:16      __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{1:1},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1)
__{}__LD_REG16({HL},$2){}dnl
__{}define({__TMP_B},eval(10+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(73+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({HL},$1){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]    __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    C,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    inc  BC             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO{}__LD_REG16({HL},$2){}__CODE_16BIT
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
{dnl
                       ;[10:52]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    inc  BC             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO
    ld  format({%-16s},($2){,} BC); 4:20      __INFO}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # addr1 @ x + addr2 !
dnl # ( -- )
define({PUSH_FETCH_PUSH_ADD_PUSH_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_FETCH_PUSH_ADD_PUSH_STORE},{$1 @ $2 + $3 !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_FETCH_PUSH_ADD_PUSH_STORE},{dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing address parameter!},
$2,{},{
__{}  .error {$0}(): Missing second parameter!},
__{}eval($#>3),{1},{
__{}  .error {$0}($@): Unexpected parameter!},
{
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($1):__HEX_HL($2):$1,{1:0x0001:$3},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1){}dnl
                       ;[10:60/72]  __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    inc (HL)            ; 1:11      __INFO
    jr   nz,$+4         ; 2:7/12    __INFO
    inc  HL             ; 1:6       __INFO
    inc (HL)            ; 1:11      __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__HEX_HL($2):$1,{1:0x0001:$3},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1){}dnl
                       ;[12:83]  __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    C,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    B,(HL)        ; 1:7       __INFO
    inc  BC             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ld  (HL),C          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__HEX_H($2):$1,{1:0x00:$3},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1){}dnl
                       ;[13:70/82]  __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    A,format({%-12s},low $2); 2:7       __INFO
    add   A,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    jr   nc,$+4         ; 2:7/12    __INFO
    inc  HL             ; 1:6       __INFO
    inc (HL)            ; 1:11      __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__HEX_H($2):$1,{1:0xFF:$3},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1){}dnl
                       ;[13:70/82]  __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    A,format({%-12s},low $2); 2:7       __INFO
    add   A,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    jr    c,$+4         ; 2:7/12    __INFO
    inc  HL             ; 1:6       __INFO
    dec (HL)            ; 1:11      __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):$1,{1:0:$3},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1){}dnl
                       ;[14:85]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    A,format({%-12s},low $2); 2:7       __INFO
    add   A,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A,format({%-12s},high $2); 2:7       __INFO
    adc   A,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):$1,{1:1:$3},{define({_TMP_INFO},__INFO){}__LD_REG16({HL},$1){}dnl
                       ;[16:97]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    A,format({%-12s},$2); 3:13      __INFO
    add   A,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A,format({%-12s},($2+1)); 3:13      __INFO
    adc   A,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):__IS_MEM_REF($3),{0:0:1},{define({_TMP_INFO},__INFO){}dnl
                       ;[17:98]     __INFO
    push HL             ; 1:11      __INFO{}__LD_REG16({HL},($1)){}__CODE_16BIT
    ld    A,format({%-12s},low $2); 2:7       __INFO
    add   A, L          ; 1:4       __INFO{}__LD_REG16({HL},$3){}__CODE_16BIT
    ld  (HL),A          ; 1:7       __INFO
    adc   A,format({%-12s},high $2); 2:7       __INFO
    sub  (HL)           ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),A          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1)::__IS_MEM_REF($3),{0::1},{define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$3){}dnl
__{}define({__TMP_B},eval(8+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(60+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({BC},$2){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({HL},($1)){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]    __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT{}__LD_REG16({BC},$2){}__CODE_16BIT
    add  HL, BC         ; 1:11      __INFO
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO{}__LD_REG16({HL},$3){}__CODE_16BIT
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):__IS_MEM_REF($3),{1:0:0},{define({_TMP_INFO},__INFO){}dnl
                       ;[17:80]     __INFO{}__LD_REG16({BC},$1){}__CODE_16BIT
    ld    A,(BC)        ; 1:7       __INFO
    add   A,format({%-12s},low $2); 2:7       __INFO
    ld  format({%-16s},($3){,}A); 3:13      __INFO
    inc  BC             ; 1:6       __INFO
    ld    A,(BC)        ; 1:7       __INFO
    adc   A,format({%-12s},high $2); 2:7       __INFO
    ld  format({%-16s},($3+1){,}A); 3:13      __INFO},
__{}__IS_MEM_REF($1)::__IS_MEM_REF($3),{1::0},{define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({BC},$2){}dnl
__{}define({__TMP_B},eval(10+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(72+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({HL},$1){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    A,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    H,(HL)        ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO{}__LD_REG16({BC},$2){}__CODE_16BIT
    add  HL, BC         ; 1:11      __INFO
    ld  format({%-16s},($3){,}HL); 3:16      __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):__IS_MEM_REF($3),{1:0:1},{define({_TMP_INFO},__INFO){}dnl
                       ;[19:111]    __INFO
    push HL             ; 1:11      __INFO{}__LD_REG16({HL},$1){}__CODE_16BIT
    ld    A,format({%-12s},low $2); 2:7       __INFO
    add   A,(HL)        ; 1:7       __INFO
    ld    C, A          ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A,format({%-12s},high $2); 2:7       __INFO
    adc   A,(HL)        ; 1:7       __INFO{}__LD_REG16({HL},$3){}__CODE_16BIT
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),A          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):__IS_MEM_REF($3),{1:0:1},{define({_TMP_INFO},__INFO){}dnl
                       ;[19:111]    __INFO
    push HL             ; 1:11      __INFO{}__LD_REG16({HL},$1){}__CODE_16BIT{}__LD_REG16({BC},$3){}__CODE_16BIT
    ld    A,format({%-12s},low $2); 2:7       __INFO
    add   A,(HL)        ; 1:7       __INFO
    ld  (BC),A          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO
    ld    A,format({%-12s},low $2); 2:7       __INFO
    adc   A,(HL)        ; 1:7       __INFO
    ld  (BC),A          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1)::__IS_MEM_REF($3),{1::1},{define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({HL},$3){}dnl
__{}define({__TMP_B},eval(11+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(80+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({HL},$2){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({HL},$1){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]    __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT
    ld    C,(HL)        ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    B,(HL)        ; 1:7       __INFO{}__LD_REG16({HL},$2){}__CODE_16BIT
    add  HL, BC         ; 1:11      __INFO
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO{}__LD_REG16({HL},$3){}__CODE_16BIT
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO},
__{}__HEX_HL($2),0x0001,{
                       ;[ 9:46]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    inc  BC             ; 1:6       __INFO
    ld  format({%-16s},($3){,} BC); 4:20      __INFO},
__{}__HEX_HL($2),0xFFFF,{
                       ;[ 9:46]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    dec  BC             ; 1:6       __INFO
    ld  format({%-16s},($3){,} BC); 4:20      __INFO},
__{}__HEX_HL($2),0x0002,{
                       ;[10:52]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    inc  BC             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO
    ld  format({%-16s},($3){,} BC); 4:20      __INFO},
__{}__HEX_HL($2),0xFFFE,{
                       ;[10:52]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    dec  BC             ; 1:6       __INFO
    dec  BC             ; 1:6       __INFO
    ld  format({%-16s},($3){,} BC); 4:20      __INFO},
__{}__HEX_HL($2),0x0003,{
                       ;[11:58]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    inc  BC             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO
    ld  format({%-16s},($3){,} BC); 4:20      __INFO},
__{}__HEX_HL($2),0xFFFD,{
                       ;[11:58]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    dec  BC             ; 1:6       __INFO
    dec  BC             ; 1:6       __INFO
    dec  BC             ; 1:6       __INFO
    ld  format({%-16s},($3){,} BC); 4:20      __INFO},
__{}__HEX_HL($2),0x0004,{
                       ;[12:64]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    inc  BC             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO
    inc  BC             ; 1:6       __INFO
    ld  format({%-16s},($3){,} BC); 4:20      __INFO},
__{}__HEX_HL($2),0xFFFC,{
                       ;[12:64]     __INFO
    ld   BC,format({%-12s},($1)); 4:20      __INFO
    dec  BC             ; 1:6       __INFO
    dec  BC             ; 1:6       __INFO
    dec  BC             ; 1:6       __INFO
    dec  BC             ; 1:6       __INFO
    ld  format({%-16s},($3){,} BC); 4:20      __INFO},
__{}__IS_MEM_REF($2):ifelse($1,$3,{1},__HEX_HL($1),__HEX_HL($3),{1},{0}),{0:1},{define({_TMP_INFO},__INFO){}dnl
                       ;[12:58]     __INFO{}__LD_REG16({BC},$1){}__CODE_16BIT
    ld    A,(BC)        ; 1:7       __INFO
    add   A,format({%-12s},low $2); 2:7       __INFO
    ld  (BC),A          ; 1:7       __INFO
    inc  BC             ; 1:6       __INFO
    ld    A,(BC)        ; 1:7       __INFO
    adc   A,format({%-12s},high $2); 2:7       __INFO
    ld  (BC),A          ; 1:7       __INFO},
__{}_TYP_SINGLE:__IS_MEM_REF($2),{fast:0},{define({_TMP_INFO},__INFO){}dnl
                       ;[16:66]     __INFO
    ld    A,format({%-12s},($1)); 3:13      __INFO
    add   A,format({%-12s},low $2); 2:7       __INFO
    ld  format({%-16s},($3){,}A); 3:13      __INFO
    ld    A,format({%-12s},($1+1)); 3:13      __INFO
    adc   A,format({%-12s},high $2); 2:7       __INFO
    ld  format({%-16s},($3+1){,}A); 3:13      __INFO},

__{}{define({_TMP_INFO},__INFO){}dnl
__{}__LD_REG16({BC},$2){}dnl
__{}define({__TMP_B},eval(6+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(48+__CLOCKS_16BIT)){}dnl
__{}__LD_REG16({HL},($1)){}dnl
__{}define({__TMP_B},eval(__TMP_B+__BYTES_16BIT)){}dnl
__{}define({__TMP_C},eval(__TMP_C+__CLOCKS_16BIT)){}dnl
                       ;[__TMP_B:__TMP_C]     __INFO
    push HL             ; 1:11      __INFO{}__CODE_16BIT{}__LD_REG16({BC},$2){}__CODE_16BIT
    add  HL, BC         ; 1:11      __INFO
    ld  format({%-16s},($3){,} HL); 3:16      __INFO
    pop  HL             ; 1:10      __INFO}){}dnl
})}){}dnl
dnl
dnl
dnl
dnl # !
dnl # ( x addr -- )
dnl # store 16-bit number at addr
define({STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_STORE_1ADD},{!},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_2DROP},{__dtto},$@){}dnl
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
__{}__ADD_TOKEN({__TOKEN_PUSH_STORE},{$1 !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}                        ;[10:58]    __INFO   ( x -- )  addr=$1
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, H          ; 1:4       __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    ld  (HL), C         ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL), B         ; 1:7       __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO},
{
__{}                        ;[5:30]     __INFO   ( x -- )  addr=$1
__{}    ld   format({%-15s},($1){,} HL); 3:16      __INFO
__{}    ex   DE, HL         ; 1:4       __INFO
__{}    pop  DE             ; 1:10      __INFO})}){}dnl
dnl
dnl
dnl
dnl # x addr !
dnl # ( -- )
dnl # store(addr) store 16-bit number at addr
define({PUSH2_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_STORE},{$1 $2 !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing parameters!},
$#,{1},{
__{}  .error {$0}($@): The second parameter is missing!},
eval($#>2),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($2),{1},{dnl
__{}__{}__{}ifelse(__IS_MEM_REF($1),{1},{
__{}__{}__{}                        ;[12:78]    __INFO   ( -- )  val=$1, addr=$2
__{}__{}__{}    push HL             ; 1:11      __INFO
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO
__{}__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO
__{}__{}__{}    ld  (HL), C         ; 1:7       __INFO
__{}__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}__{}    ld  (HL), B         ; 1:7       __INFO
__{}__{}__{}    pop  HL             ; 1:11      __INFO},
__{}__{}__{}_TYP_SINGLE,{small},{
__{}__{}__{}                        ;[10:64]    __INFO   ( -- )  val=$1, addr=$2
__{}__{}__{}    push HL             ; 1:11      __INFO
__{}__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO
__{}__{}__{}    ld  (HL),format({%-11s}, low $1); 2:10      __INFO
__{}__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}__{}    ld  (HL),format({%-11s}, high $1); 2:10      __INFO
__{}__{}__{}    pop  HL             ; 1:11      __INFO},
__{}__{}__{}__IS_NUM($1),{1},{
__{}__{}__{}__{}define({__CODE1},__LD_R_NUM({__INFO   lo($1) = __HEX_L($1)},{A},__HEX_L($1))){}dnl
__{}__{}__{}__{}define({__TMP_C},eval(40+__CLOCKS)){}dnl
__{}__{}__{}__{}define({__TMP_B},eval(7+__BYTES)){}dnl
__{}__{}__{}__{}define({__CODE2},__LD_R_NUM({__INFO   hi($1) = __HEX_H($1)},{A},__HEX_H($1),{A},__HEX_L($1))){}dnl
__{}__{}__{}__{}define({__TMP_C},eval(__TMP_C+__CLOCKS)){}dnl
__{}__{}__{}__{}define({__TMP_B},eval(__TMP_B+__BYTES)){}dnl
__{}__{}__{}                        ;format({%-10s},[__TMP_B:__TMP_C]) __INFO   ( -- )  val=$1, addr=$2
__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      __INFO{}dnl
__{}__{}__{}__CODE1
__{}__{}__{}    ld  (BC), A         ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO{}dnl
__{}__{}__{}__CODE2
__{}__{}__{}    ld  (BC), A         ; 1:7       __INFO},
__{}__{}__{}{
__{}__{}__{}                        ;[11:54]    __INFO   ( -- )  val=$1, addr=$2
__{}__{}__{}    ld   BC, format({%-11s},$2); 4:20      __INFO
__{}__{}__{}    ld    A, format({%-11s}, low $1); 2:7       __INFO
__{}__{}__{}    ld  (BC), A         ; 1:7       __INFO
__{}__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}__{}    ld    A, format({%-11s}, high $1); 2:7       __INFO
__{}__{}__{}    ld  (BC), A         ; 1:7       __INFO})},
__IS_MEM_REF($1),{1},{
__{}                        ;[8:40]     __INFO   ( -- )  val=$1, addr=$2
__{}    ld   BC, format({%-11s},$1); 4:20      __INFO
__{}    ld   format({%-15s},($2){,} BC); 4:20      __INFO},
{
__{}                        ;[7:30]     __INFO   ( -- )  val=$1, addr=$2
__{}    ld   BC, format({%-11s},$1); 3:10      __INFO
__{}    ld   format({%-15s},($2){,} BC); 4:20      __INFO})}){}dnl
dnl
dnl
dnl
dnl # tuck !
dnl # ( x addr -- addr )
dnl # store 16-bit number at addr
define({TUCK_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_STORE},{tuck !},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_NIP},{},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:36]     __INFO   ( x addr -- addr )
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # tuck ! 2+
dnl # ( x addr -- addr+2 )
dnl # store 16-bit number at addr
define({TUCK_STORE_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_TUCK_STORE_2ADD},{tuck ! +2},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_TUCK_STORE_2ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:36]     __INFO   ( x addr -- addr+2 )
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
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
__{}__ADD_TOKEN({__TOKEN_OVER_SWAP_STORE},{over swap !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_SWAP_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[5:34]     __INFO   ( x addr -- x )
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    ex   DE, HL         ; 1:4       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # 2dup !
dnl # ( x addr -- x addr )
dnl # store 16-bit number at addr
define({_2DUP_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_STORE},{2dup !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[4:26]     __INFO   ( x addr -- x addr )
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl # 2dup ! 1+
dnl # ( x addr -- x addr+1 )
dnl # store 16-bit number at addr
define({_2DUP_STORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_STORE_1ADD},{2dup ! 1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_STORE_1ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[3:20]     __INFO   ( x addr -- x addr+1 )
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO}){}dnl
dnl
dnl
dnl # 2dup ! 2+
dnl # ( x addr -- x addr+2 )
dnl # store 16-bit number at addr
define({_2DUP_STORE_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_2DUP_STORE_2ADD},{2dup ! 2+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2DUP_STORE_2ADD},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[4:26]     __INFO   ( x addr -- x addr+2 )
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO}){}dnl
dnl
dnl
dnl
dnl # dup 3 pick !
dnl # ( addr x2 x1 -- addr x2 x1 )
dnl # store tos at addr
define({DUP_3_PICK_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_3_PICK_STORE},{dup 3 pick !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_3_PICK_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#>0),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
__{}{
                        ;[7:49]     __INFO   ( addr x2 x1 -- addr x2 x1 )
    pop  BC             ; 1:10      __INFO
    push BC             ; 1:11      __INFO
    ld    A, L          ; 1:4       __INFO
    ld  (BC),A          ; 1:7       __INFO   [addr] = lo(x1)
    inc  BC             ; 1:6       __INFO
    ld    A, H          ; 1:4       __INFO
    ld  (BC),A          ; 1:7       __INFO   [addr] = x1}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # x pick !
dnl # ( addr x3 x2 x1 -- addr x3 x2 )
dnl # store tos at addr
define({PUSH_PICK_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_PICK_STORE},{$1 pick !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_PICK_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse($1,{},{
__{}  .error {$0}(): Missing parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): Unexpected parameters!},
__IS_MEM_REF($1),1,{define({__INFO},__COMPILE_INFO)
                       ;[14:114]    __INFO   ( x$1 ... x2 x1 x0 -- x$1 ... x2 x1 )  x$1 = addr
    push DE             ; 1:11      __INFO
    push HL             ; 1:11      __INFO
    ex   DE, HL         ; 1:4       __INFO   DE = x0
    ld   HL,format({%-12s},$1); 3:16      __INFO
    add  HL, HL         ; 1:11      __INFO   2*$1
    add  HL, SP         ; 1:11      __INFO
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO{}__ASM_TOKEN_2DROP},
__{}__HEX_HL($1),0x0000,{__ASM_TOKEN_DUP_STORE},
__{}__HEX_HL($1),0x0001,{__ASM_TOKEN_OVER_STORE},
__{}__HEX_HL($1),0x0002,{__ASM_TOKEN_2_PICK_STORE},
__{}__HEX_HL($1),0x0003,{__ASM_TOKEN_3_PICK_STORE},
__{}{dnl
__{}ifelse(__IS_NUM($1),1,{
__{}                       ;[11:63]     __INFO   ( x$1 ... x2 x1 x0 -- x$1 ... x2 x1 )  x$1 = addr
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, H          ; 1:4       __INFO   BC = x0
__{}    ld   HL, __HEX_HL(2*($1-2))     ; 3:10      __INFO},
__{}{
__{}                       ;[11:63]     __INFO   ( x_$1 ... x2 x1 x0 -- x_$1 ... x2 x1 )  x_$1 = addr
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, H          ; 1:4       __INFO   BC = x0
__{}    ld   HL, format({%-11s},2*($1-2)); 3:10      __INFO})
    add  HL, SP         ; 1:11      __INFO
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO{}__ASM_TOKEN_DROP}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 3 pick !
dnl # ( addr x2 x1 x0 -- addr x2 x1 )
dnl # store tos at addr
define({_3_PICK_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_3_PICK_STORE},{3 pick !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_3_PICK_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#>0),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
__{}{
                       ;[10:69]     __INFO   ( addr x2 x1 x0 -- addr x2 x1 )
    ld    C, L          ; 1:4       __INFO
    ld    B, H          ; 1:4       __INFO   BC = x0
    pop  AF             ; 1:10      __INFO   x3
    pop  HL             ; 1:10      __INFO   addr
    push AF             ; 1:11      __INFO   x3
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ex   DE, HL         ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2 pick !
dnl # ( addr x2 x1 -- addr x2 )
dnl # store tos at addr
define({_2_PICK_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2_PICK_STORE},{2 pick !},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2_PICK_STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#>0),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
__{}{
                        ;[8:48]     __INFO   ( addr x1 x0 -- addr x1 )
    ld    C, L          ; 1:4       __INFO
    ld    B, H          ; 1:4       __INFO   BC = x0
    pop  HL             ; 1:10      __INFO   addr
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO
    dec  HL             ; 1:6       __INFO
    ex   DE, HL         ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # over !
dnl # 1 pick !
dnl # ( addr x -- addr )
dnl # store tos at nos
define({OVER_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_STORE_1ADD},{over !},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_1SUB},{__dtto}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_STORE},{dnl
__{}__ASM_TOKEN_OVER_STORE_1ADD{}dnl
__{}__ASM_TOKEN_1SUB{}dnl
}){}dnl
dnl
dnl
dnl
dnl # over !
dnl # ( addr x -- addr )
dnl # store tos at nos
define({OVER_STORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_OVER_STORE_1ADD},{over ! 1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_OVER_STORE_1ADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#>0),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
__{}{
                        ;[5:34]     __INFO   ( addr x -- addr+1 )
    ex   DE, HL         ; 1:4       __INFO
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup !
dnl # 0 pick !
dnl # ( addr -- )
dnl # store tos at nos
define({DUP_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_DUP_STORE_1ADD},{dup !},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_DROP},__dtto){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_STORE},{dnl
__{}__ASM_TOKEN_DUP_DUP_STORE_1ADD{}dnl
__{}__ASM_TOKEN_DROP{}dnl
}){}dnl
dnl
dnl
dnl
dnl # dup dup ! 1+
dnl # ( addr -- addr+1 )
dnl # store tos at tos
define({DUP_DUP_STORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_DUP_DUP_STORE_1ADD},{dup dup ! 1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_DUP_STORE_1ADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#>0),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
__{}{
                        ;[4:24]     __INFO   ( addr -- addr+1 )
    ld  (HL),L          ; 1:7       __INFO
    ld    A, H          ; 1:4       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),A          ; 1:7       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # number over !
dnl # dup number swap !
dnl # ( addr -- addr )
dnl # store 16-bit number at addr
define({PUSH_OVER_STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_STORE_1ADD},{$1 over !},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_1SUB},{__dtto}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER_STORE},{dnl
__{}__ASM_TOKEN_PUSH_OVER_STORE_1ADD($1){}dnl
__{}__ASM_TOKEN_1SUB{}dnl
}){}dnl
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
dnl # number over ! 1+
dnl # dup number swap ! 1+
dnl # ( addr -- addr+2 )
dnl # store 16-bit number at addr
define({PUSH_OVER_STORE_1ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_STORE_1ADD},{$1 over ! 1+},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER_STORE_1ADD},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<1),1,{
__{}  .error {$0}(): Missing parameter!},
__{}eval($#>1),1,{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),1,{
                        ;[7:40]     __INFO   ( addr -- addr+1 )
    ld   BC,format({%-12s},$1); 4:20      __INFO
    ld  (HL),C          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),B          ; 1:7       __INFO},
__{}{
                        ;[5:26]     __INFO   ( addr -- addr+1 )
    ld  (HL),low format({%-7s},$1); 2:10      __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),high format({%-6s},$1); 2:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # number over ! 2+
dnl # dup number swap ! 2+
dnl # ( addr -- addr+2 )
dnl # store 16-bit number at addr
define({PUSH_OVER_STORE_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_STORE_1ADD},{$1 over ! 2+},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_1ADD},{__dtto}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_OVER_STORE_2ADD},{dnl
__{}__ASM_TOKEN_PUSH_OVER_STORE_1ADD($1){}dnl
__{}__ASM_TOKEN_1ADD{}dnl
}){}dnl
dnl
dnl
define({DUP_PUSH_SWAP_STORE_2ADD},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_OVER_STORE_1ADD},{dup $1 swap ! 2+},$@){}dnl
__{}__ADD_TOKEN({__TOKEN_1ADD},{__dtto}){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_DUP_PUSH_SWAP_STORE_2ADD},{dnl
__{}__ASM_TOKEN_PUSH_OVER_STORE_1ADD($1){}dnl
__{}__ASM_TOKEN_1ADD{}dnl
}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
    or    A             ; 1:4       __INFO   ( from_addr to_addr u_words -- )
    adc  HL, HL         ; 1:11      __INFO
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   BC = 2*u
    pop  HL             ; 1:10      __INFO   HL = from = addr1
    jr    z, $+4        ; 2:7/12    __INFO
    ldir                ; 2:u*42/32 __INFO   addr++
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # u move
dnl # ( from_addr to_addr -- )
dnl # If u is greater than zero, copy the contents of u consecutive words at from_addr to the u consecutive words at to_addr.
define({PUSH_MOVE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_MOVE},{$1 move},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_MOVE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($1,{},{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>1),{1},{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}__{}                       ;[15:70+42*u]__INFO   ( from_addr to_addr -- )
__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   BC = u_words
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jr    z, $+11       ; 2:7/12    __INFO   zero?
__{}__{}    sla   C             ; 2:8       __INFO
__{}__{}    rl    B             ; 2:8       __INFO
__{}__{};   jr    c, $+9        ; 2:7/12    __INFO   negative or unsigned overflow?
__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}    ldir                ; 2:u*42-5  __INFO   addr++
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__IS_NUM($1),0,{dnl
__{}__{}  .error  {$0}($@): Bad parameter!},
__{}{dnl
__{}__{}ifelse(eval(($1)<1),{1},{
__{}__{}__{}                        ;[2:20]     __INFO   ( from_addr to_addr -- )   u = 0 or negative
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__{}__HEX_HL($1),0x0001,{
__{}__{}__{}                        ;[7:54]     __INFO   ( from_addr to_addr -- )   u = 1 word
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}__{}    ldi                 ; 2:16      __INFO   addr++
__{}__{}__{}    ld    A,(HL)        ; 1:7       __INFO
__{}__{}__{}    ld  (DE),A          ; 1:7       __INFO
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__{}{
__{}__{}__{}                        ;format({%-11s},[8:eval(29+42*($1))])__INFO   ( from_addr to_addr -- )   u = $1 words
__{}__{}__{}ifelse(eval(2*($1)>65535),{1},{dnl
__{}__{}__{}    .warning  {$0}($@): Trying to copy data bigger 64k!
__{}__{}__{}}){}dnl
__{}__{}__{}    ld   BC, __HEX_HL(2*($1))     ; 3:10      __INFO   BC = eval(2*($1)) chars
__{}__{}__{}    ex   DE, HL         ; 1:4       __INFO   HL = from_addr, DE = to_addr
__{}__{}__{}    ldir                ; 2:u*42-5  __INFO   addr++
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # u move
dnl # ( from_addr to_addr -- )
dnl # If u is greater than zero, copy the contents of u consecutive words at from_addr to the u consecutive words at to_addr.
define({PUSH3_MOVE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH3_MOVE},{$1 $2 $3 move},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH3_MOVE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(eval($#<3),{1},{
__{}  .error {$0}(): Missing parameter!},
eval($#>3),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
{dnl
__{}ifelse(dnl
__{}__IS_MEM_REF($3),{1},{dnl
__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__RESET_ADD_LD_REG16{}dnl
__{}__{}__ADD_LD_REG16(                {BC},$3){}dnl
__{}__{}__ADD_LD_REG16(        {HL},$2,{BC},$3){}dnl
__{}__{}__ADD_LD_REG16({DE},$1,{HL},$2,{BC},$3){}dnl
__{}__{}format({%32s},;[eval(__SUM_BYTES_16BIT+14)]:[eval(68+__SUM_CLOCKS_16BIT)+u*42]) __INFO   # default version
__{}__{}    push DE             ; 1:11      __INFO   ( -- )  from = $1, to = $2, u = $3 words
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}__LD_REG16({BC},$3){}dnl
__{}__{}__CODE_16BIT
__{}__{}    ld    A, C          ; 1:4       __INFO
__{}__{}    or    B             ; 1:4       __INFO
__{}__{}    jr    z, $+eval(10+__SUM_BYTES_16BIT-__BYTES_16BIT)       ; 2:7/12    __INFO   zero?{}dnl
__{}__{}__LD_REG16({HL},$2,{BC},$3){}dnl
__{}__{}__CODE_16BIT{}dnl
__{}__{}__LD_REG16({DE},$1,{HL},$2,{BC},$3){}dnl
__{}__{}__CODE_16BIT
__{}__{}    sla   C             ; 2:8       __INFO
__{}__{}    rl    B             ; 2:8       __INFO
__{}__{};   jr    c, $+4        ; 2:7/12    __INFO   negative or unsigned overflow?
__{}__{}    ldir                ; 2:16/21   __INFO   addr++
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    pop  DE             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):__HEX_HL($3),1:1:0x0001,{
__{}__{}                        ;[14:93]    __INFO   ( -- ) from: $1, to: $2, u: $3 words
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},$1); 3:16      __INFO   from_addr
__{}__{}    ld    C,(HL)        ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    B,(HL)        ; 1:7       __INFO
__{}__{}    ld   HL,format({%-12s},$2); 3:16      __INFO   to_addr
__{}__{}    ld  (HL),C          ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),B          ; 1:7       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1):__HEX_HL($3),1:0x0001,{
__{}__{}                        ;[12:77]    __INFO   ( -- ) from: $1, to: $2, u: $3 words
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},$1); 3:16      __INFO   from_addr
__{}__{}    ld    C,(HL)        ; 1:7       __INFO   from_addr
__{}__{}    inc  HL             ; 1:6       __INFO   from_addr
__{}__{}    ld    B,(HL)        ; 1:7       __INFO   from_addr
__{}__{}    ld  format({%-16s},($2){,}BC); 4:20      __INFO   to_addr
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($2):__HEX_HL($3),1:0x0001,{
__{}__{}                        ;[12:77]    __INFO   ( -- ) from: $1, to: $2, u: $3 words
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   BC,format({%-12s},($1)); 4:20      __INFO   from_addr
__{}__{}    ld   HL,format({%-12s},$2); 3:16      __INFO   to_addr
__{}__{}    ld  (HL),C          ; 1:7       __INFO   to_addr
__{}__{}    inc  HL             ; 1:6       __INFO   to_addr
__{}__{}    ld  (HL),B          ; 1:7       __INFO   to_addr
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}__HEX_HL($3),0x0001,{
__{}__{}                        ;[8:40]     __INFO   ( -- ) from: $1, to: $2, u: $3 words
__{}__{}    ld   BC,format({%-12s},($1)); 4:20      __INFO   from_addr
__{}__{}    ld  format({%-16s},($2){,}BC); 4:20      __INFO   to_addr},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2):__HEX_HL($3),0:0:0x0002,{
__{}__{}                       ;[14:85]     __INFO   ( -- ) from: $1, to: $2, u: $3 words
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},($1)); 3:16      __INFO   from_addr
__{}__{}    ld  format({%-16s},($2){,}HL); 3:16      __INFO   to_addr
__{}__{}    ld   HL,format({%-12s},(2+$1)); 3:16      __INFO   from_addr
__{}__{}    ld  format({%-16s},(2+$2){,}HL); 3:16      __INFO   to_addr
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}__IS_NUM($3),{0},{dnl
__{}__{}  .error  {$0}($@): Bad parameter!},
__{}{dnl
__{}__{}ifelse(eval(($3)<1),{1},{
__{}__{}__{}                        ;[0:0]      __INFO   ( -- ) from: $1, to: $2, u: 0 or negative},
__{}__{}{ifelse(eval(2*($3)>65535),{1},{
__{}__{}__{}__{}  .warning  {$0}($@): Trying to copy data bigger 64k!})
__{}__{}__{}define({_TMP_INFO},__INFO){}dnl
__{}__{}__{}__RESET_ADD_LD_REG16{}dnl
__{}__{}__{}__ADD_LD_REG16(                {BC},2*$3){}dnl
__{}__{}__{}__ADD_LD_REG16(        {HL},$2,{BC},2*$3){}dnl
__{}__{}__{}__ADD_LD_REG16({DE},$1,{HL},$2,{BC},2*$3){}dnl
__{}__{}__{}                      format({%-13s},;[eval(__SUM_BYTES_16BIT+6)]:[eval(37+__SUM_CLOCKS_16BIT+$3*42)]) __INFO   # default version
__{}__{}__{}    push DE             ; 1:11      __INFO   ( -- )  from = $1, to = $2, u = $3 words
__{}__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}__{}__LD_REG16({BC},2*$3){}dnl
__{}__{}__{}__CODE_16BIT{}dnl
__{}__{}__{}__LD_REG16({HL},$2,{BC},2*$3){}dnl
__{}__{}__{}__CODE_16BIT{}dnl
__{}__{}__{}__LD_REG16({DE},$1,{HL},$2,{BC},2*$3){}dnl
__{}__{}__{}__CODE_16BIT
__{}__{}__{}    ldir                ; 2:16/21   __INFO   addr++
__{}__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}__{}    pop  DE             ; 1:10      __INFO})})}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # move>
dnl # ( addr1 addr2 u -- )
dnl # If u is greater than zero, copy the contents of u consecutive 16-bit words at addr1 to the u consecutive 16-bit words at addr2.
define({MOVEGT},{dnl
__{}__ADD_TOKEN({__TOKEN_MOVEGT},{move>},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_MOVEGT},{dnl
__{}define({__INFO},__COMPILE_INFO)
    or    A             ; 1:4       __INFO
    adc  HL, HL         ; 1:11      __INFO
    ld    B, H          ; 1:4       __INFO
    ld    C, L          ; 1:4       __INFO   BC = 2*u
    pop  HL             ; 1:10      __INFO   HL = from = addr1
    jr    z, $+4        ; 2:7/12    __INFO
    lddr                ; 2:u*42/32 __INFO   addr--
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # +!
dnl # ( num addr -- )
dnl # Adds num to the 16-bit number stored at addr.
define({ADDSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_ADDSTORE},{+!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_ADDSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
    ld    A, E          ; 1:4       __INFO
    add   A,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A, D          ; 1:4       __INFO
    adc   A,(HL)        ; 1:7       __INFO
    ld  (HL),A          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl # num addr +!
dnl # ( -- )
dnl # Adds num to the 16-bit number stored at addr.
define({PUSH2_ADDSTORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_ADDSTORE},{$1 $2 +!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_ADDSTORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameter!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),1:1,{
__{}__{}                       ;[17:111]    __INFO   ( -- )  $2 += $1
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},$1); 3:16      __INFO   +num
__{}__{}    ld   BC,format({%-12s},$2); 4:20      __INFO   addr
__{}__{}    ld    A,(BC)        ; 1:7       __INFO
__{}__{}    add   A,(HL)        ; 1:7       __INFO   lo
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld    A,(BC)        ; 1:7       __INFO
__{}__{}    adc   A,(HL)        ; 1:7       __INFO   hi
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($1),1,{
__{}__{}                       ;[13:84]     __INFO   ( -- )  ($2) += $1
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   BC,format({%-12s},$1); 4:20      __INFO
__{}__{}    ld   HL,format({%-12s},{($2)}); 3:16      __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    ld  format({%-16s},{($2), HL}); 3:16      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($2):_TYP_SINGLE,1:small,{
__{}__{}                       ;[12:74]     __INFO   ( -- )  $2 += $1
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   BC, format({%-11s},$1); 3:10      __INFO
__{}__{}    ld   HL,format({%-12s},$2); 3:16      __INFO
__{}__{}    add  HL, BC         ; 1:11      __INFO
__{}__{}    ld  format({%-16s},{$2, HL}); 3:16      __INFO
__{}__{}    pop  HL             ; 1:10      __INFO},
__{}__IS_MEM_REF($2),1,{
__{}__{}                       ;[13:68]     __INFO   ( -- )  $2 += $1
__{}__{}    ld   BC,format({%-12s},$2); 4:20      __INFO
__{}__{}    ld    A,(BC)        ; 1:7       __INFO
__{}__{}ifelse(__IS_NUM($1),1,{dnl
__{}__{}__{}    add   A, __HEX_L($1)       ; 2:7       __INFO   lo($1)},
__{}__{}{dnl
__{}__{}__{}    add   A, format({%-11s},low $1); 2:7       __INFO   lo($1)})
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld    A,(BC)        ; 1:7       __INFO
__{}__{}ifelse(__IS_NUM($1),1,{dnl
__{}__{}__{}    adc   A, __HEX_H($1)       ; 2:7       __INFO   hi($1)},
__{}__{}{dnl
__{}__{}__{}    adc   A, format({%-11s},high $1); 2:7       __INFO   hi($1)})
__{}__{}    ld  (BC),A          ; 1:7       __INFO},
__{}__HEX_HL($1),0x0000,{
__{}__{}                        ;           __INFO   ( -- )  ($2) += $1},
__{}__HEX_HL($1),0x0001,{
__{}__{}                        ;[9:46]     __INFO   ( -- )  ($2) += $1
__{}__{}    ld   BC, format({%-11s},{($2)}); 4:20      __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld   format({%-15s},($2){,} BC); 4:20      __INFO},
__{}__HEX_HL($1),0xFFFF,{
__{}__{}                        ;[9:46]     __INFO   ( -- )  ($2) += $1
__{}__{}    ld   BC, format({%-11s},{($2)}); 4:20      __INFO
__{}__{}    dec  BC             ; 1:6       __INFO
__{}__{}    ld   format({%-15s},($2){,} BC); 4:20      __INFO},
__{}__HEX_HL($1),0x0002,{
__{}__{}                       ;[10:52]     __INFO   ( -- )  ($2) += $1
__{}__{}    ld   BC, format({%-11s},{($2)}); 4:20      __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld   format({%-15s},($2){,} BC); 4:20      __INFO},
__{}__HEX_HL($1),0xFFFE,{
__{}__{}                       ;[10:52]     __INFO   ( -- )  ($2) += $1
__{}__{}    ld   BC, format({%-11s},{($2)}); 4:20      __INFO
__{}__{}    dec  BC             ; 1:6       __INFO
__{}__{}    dec  BC             ; 1:6       __INFO
__{}__{}    ld   format({%-15s},($2){,} BC); 4:20      __INFO},
__{}__HEX_HL($1),0x0003,{
__{}__{}                       ;[11:58]     __INFO   ( -- )  ($2) += $1
__{}__{}    ld   BC, format({%-11s},{($2)}); 4:20      __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld   format({%-15s},($2){,} BC); 4:20      __INFO},
__{}__HEX_HL($1),0xFFFD,{
__{}__{}                       ;[11:58]     __INFO   ( -- )  ($2) += $1
__{}__{}    ld   BC, format({%-11s},{($2)}); 4:20      __INFO
__{}__{}    dec  BC             ; 1:6       __INFO
__{}__{}    dec  BC             ; 1:6       __INFO
__{}__{}    dec  BC             ; 1:6       __INFO
__{}__{}    ld   format({%-15s},($2){,} BC); 4:20      __INFO},
__{}{
__{}__{}                       ;[12:58]     __INFO   ( -- )  ($2) += $1
__{}__{}    ld   BC, format({%-11s},$2); 3:10      __INFO   # default version
__{}__{}    ld    A,(BC)        ; 1:7       __INFO
__{}__{}ifelse(__IS_NUM($1),1,{dnl
__{}__{}__{}    add   A, __HEX_L($1)       ; 2:7       __INFO   lo($1)},
__{}__{}{dnl
__{}__{}__{}    add   A, format({%-11s},low $1); 2:7       __INFO   lo($1)})
__{}__{}    ld  (BC),A          ; 1:7       __INFO
__{}__{}    inc  BC             ; 1:6       __INFO
__{}__{}    ld    A,(BC)        ; 1:7       __INFO
__{}__{}ifelse(__IS_NUM($1),1,{dnl
__{}__{}__{}    adc   A, __HEX_H($1)       ; 2:7       __INFO   hi($1)},
__{}__{}{dnl
__{}__{}__{}    adc   A, format({%-11s},high $1); 2:7       __INFO   hi($1)})
__{}__{}    ld  (BC),A          ; 1:7       __INFO}){}dnl
}){}dnl
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
__{}define({__INFO},__COMPILE_INFO)
                        ;[10:65]    __INFO   ( adr -- lo hi )
    push DE             ; 1:11      __INFO
    ld    E, (HL)       ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    D, (HL)       ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    A, (HL)       ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld    H, (HL)       ; 1:7       __INFO
    ld    L, A          ; 1:4       __INFO
    ex   DE, HL         ; 1:4       __INFO}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<1),1,{
__{}__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),1,{
__{}__{}.error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}__{}                       ;[13:88]     __INFO   ( -- lo hi )
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO
__{}__{}    ld   HL,format({%-12s},(3+$1)); 3:16      __INFO
__{}__{}    ld    D, (HL)       ; 1:7       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld    E, (HL)       ; 1:7       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld    A, (HL)       ; 1:7       __INFO
__{}__{}    dec  HL             ; 1:6       __INFO
__{}__{}    ld    L, (HL)       ; 1:7       __INFO
__{}__{}    ld    H, A          ; 1:4       __INFO},
__{}{
__{}__{}                        ;[9:58]     __INFO   ( -- lo hi )
__{}__{}    push DE             ; 1:11      __INFO
__{}__{}    push HL             ; 1:11      __INFO{}dnl
__{}__{}ifelse(__IS_NUM($1),1,{
__{}__{}__{}    ld   DE,(__HEX_HL(2+$1))    ; 4:20      __INFO   hi16 = ($1 + 2)},
__{}__{}{
__{}__{}__{}    ld   DE,format({%-12s},{(2+$1)}); 4:20      __INFO   hi16 =  ($1 + 2)})
__{}__{}    ld   HL,format({%-12s},($1)); 3:16      __INFO   lo16}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # 2!
dnl # ( hi lo addr -- )
dnl # store 32-bit number at addr
define({_2STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_2STORE},{2!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_2STORE},{dnl
__{}define({__INFO},__COMPILE_INFO)
                        ;[10:76]    __INFO   ( hi lo addr -- )
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    pop  DE             ; 1:10      __INFO
    ld  (HL),E          ; 1:7       __INFO
    inc  HL             ; 1:6       __INFO
    ld  (HL),D          ; 1:7       __INFO
    pop  HL             ; 1:10      __INFO
    pop  DE             ; 1:10      __INFO}){}dnl
dnl
dnl
dnl
dnl # addr 2!
dnl # ( hi lo -- )
dnl # store(addr) store 32-bit number at addr
define({PUSH_2STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH_2STORE},{$1 2!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH_2STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
ifelse(dnl
$1,{},{
__{}  .error {$0}(): Missing address parameter!},
eval($#>1),{1},{
__{}  .error {$0}($@): $# parameters found in macro!},
__IS_MEM_REF($1),{1},{
__{}                        ;[14:90]    __INFO   ( hi lo -- )  addr=$1
__{}    ld    C, L          ; 1:4       __INFO
__{}    ld    B, H          ; 1:4       __INFO
__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}    ld  (HL), C         ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL), B         ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL), E         ; 1:7       __INFO
__{}    inc  HL             ; 1:6       __INFO
__{}    ld  (HL), D         ; 1:7       __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO},
{
__{}                        ;[9:56]     __INFO   ( hi lo -- )  addr=$1
__{}    ld   format({%-15s},{($1), HL}); 3:16      __INFO   lo
__{}ifelse(__IS_NUM($1),{0},{dnl
__{}__{}    ld   format({%-15s},{(2+$1), DE}); 4:20      __INFO   hi},
__{}{dnl
__{}__{}    ld   (__HEX_HL($1+2)), DE   ; 4:20      __INFO   hi})
__{}    pop  HL             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl # hi lo addr 2!
dnl # ( hi -- ) lo=$1 addr=$2
dnl # store(addr) store 32-bit number at addr
define({PUSH2_2STORE},{dnl
__{}__ADD_TOKEN({__TOKEN_PUSH2_2STORE},{$1 $2 2!},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_PUSH2_2STORE},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse(eval($#<2),1,{
__{}__{}  .error {$0}($@): Missing parameters!},
__{}eval($#>2),1,{
__{}__{}  .error {$0}($@): $# parameters found in macro!},
__{}__IS_MEM_REF($1):__IS_MEM_REF($2),{1:1},{
__{}__{}                        ;[18:118]   __INFO   ( hi -- )  lo=$1, addr=$2
__{}__{}    push HL             ; 1:11      __INFO   save hi
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO
__{}__{}    ld   BC, format({%-11s},$1); 4:20      __INFO   lo
__{}__{}    ld  (HL), C         ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL), B         ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    pop  BC             ; 1:11      __INFO   load hi
__{}__{}    ld  (HL), C         ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL), B         ; 1:7       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO},
__{}__IS_MEM_REF($2),{1},{
__{}__{}                        ;[16:90]    __INFO   ( hi -- )  lo=$1, addr=$2
__{}__{}    ld    C, L          ; 1:4       __INFO
__{}__{}    ld    B, H          ; 1:4       __INFO
__{}__{}    ld   HL, format({%-11s},$2); 3:16      __INFO
__{}__{}    ld  (HL), format({%-10s}, low $1); 2:10      __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL),format({%-11s}, high $1); 2:10      __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL), C         ; 1:7       __INFO
__{}__{}    inc  HL             ; 1:6       __INFO
__{}__{}    ld  (HL), B         ; 1:7       __INFO
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO},
__{}__IS_MEM_REF($1),1,{
__{}__{}                        ;[11:62]    __INFO   ( hi -- )  lo=$1, addr=$2
__{}__{}    ld   format({%-15s},{($2+2), HL}); 3:16      __INFO   hi
__{}__{}    ld   HL, format({%-11s},$1); 3:16      __INFO
__{}__{}    ld   (format({%-14s},{$2), HL}); 3:16      __INFO   lo
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO},
__{}__IS_NUM($2),1,{
__{}__{}                        ;[11:56]    __INFO   ( hi -- )  lo=$1, addr=$2
__{}__{}    ld   (__HEX_HL($2+2)), HL   ; 3:16      __INFO   hi
__{}__{}    ld   HL, format({%-11s},$1); 3:10      __INFO
__{}__{}    ld   (__HEX_HL($2)), HL   ; 3:16      __INFO   lo
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO},
__{}{
__{}__{}                        ;[11:56]    __INFO   ( hi -- )  lo=$1, addr=$2
__{}__{}    ld   format({%-15s},{($2+2), HL}); 3:16      __INFO   hi
__{}__{}    ld   HL, format({%-11s},$1); 3:10      __INFO
__{}__{}    ld   (format({%-14s},{$2), HL}); 3:16      __INFO   lo
__{}__{}    pop  HL             ; 1:10      __INFO
__{}__{}    ex   DE, HL         ; 1:4       __INFO}){}dnl
}){}dnl
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
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($#,0,{
__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}  .error {$0}($@): Parameter is memory reference!},
__{}{
__{}                        ;[9:58]     __INFO
__{}    di                  ; 1:4       __INFO
__{}    push DE             ; 1:11      __INFO   save nos
__{}    push HL             ; 1:11      __INFO   save tos
__{}    exx                 ; 1:4       __INFO
__{}    push HL             ; 1:11      __INFO   save ras
__{}    ld   format({%-15s},($1){,}SP); 4:20      __INFO   save orig SP}){}dnl
}){}dnl
dnl
dnl
dnl
define({FAST_COPY_16_BYTES_STOP},{dnl
__{}__ADD_TOKEN({__TOKEN_FAST_COPY_16_BYTES_STOP},{fast_copy_16_bytes_stop},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FAST_COPY_16_BYTES_STOP},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($#,0,{
__{}  .error {$0}(): Missing address parameter!},
__{}eval($#>1),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}  .error {$0}($@): Parameter is memory reference!},
__{}{
                        ;[9:58]     __INFO
    ld   SP, format({%-11s},($1)); 4:20      __INFO   load orig SP
    pop  HL             ; 1:10      __INFO   load ras
    exx                 ; 1:4       __INFO
    pop  HL             ; 1:10      __INFO   load tos
    pop  HL             ; 1:10      __INFO   load nos
    ei                  ; 1:4       __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
dnl # FAST_COPY_16_BYTES(from,to)
define({FAST_COPY_16_BYTES},{dnl
__{}__ADD_TOKEN({__TOKEN_FAST_COPY_16_BYTES},{fast_copy_16_bytes},$@){}dnl
}){}dnl
dnl
define({__ASM_TOKEN_FAST_COPY_16_BYTES},{dnl
__{}define({__INFO},__COMPILE_INFO){}dnl
__{}ifelse($#,0,{
__{}  .error {$0}(): Missing from and to address parameter!},
__{}$#,1,{
__{}  .error {$0}($@): Missing second address parameter!},
__{}eval($#>2),1,{
__{}  .error {$0}($@): Unexpected parameter!},
__{}__IS_MEM_REF($1),1,{
__{}  .error {$0}($@): First parameter is memory reference!},
__{}__IS_MEM_REF($2),1,{
__{}  .error {$0}($@): Second parameter is memory reference!},
__{}{
__{}                        ;[26:204]   __INFO
__{}    ld   SP, format({%-11s},$1); 3:10      __INFO   from = $1 .. $1+15
__{}    pop  AF             ; 1:10      __INFO
__{}    pop  BC             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    exx                 ; 1:4       __INFO
__{}    pop  BC             ; 1:10      __INFO
__{}    pop  DE             ; 1:10      __INFO
__{}    pop  HL             ; 1:10      __INFO
__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    pop  AF             ; 1:10      __INFO
__{}    ld   SP, format({%-11s},$2); 3:10      __INFO   to = $2-16 .. $2-1
__{}    push AF             ; 1:11      __INFO
__{}    ex   AF, AF'        ; 1:4       __INFO
__{}    push HL             ; 1:11      __INFO
__{}    push DE             ; 1:11      __INFO
__{}    push BC             ; 1:11      __INFO
__{}    exx                 ; 1:4       __INFO
__{}    push HL             ; 1:11      __INFO
__{}    push DE             ; 1:11      __INFO
__{}    push BC             ; 1:11      __INFO
__{}    push AF             ; 1:11      __INFO}){}dnl
}){}dnl
dnl
dnl
dnl
