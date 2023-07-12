define({__},{})dnl
dnl
dnl
dnl
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
dnl
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
define({__GET_TOKEN_ARRAY_7},{__SPOJ({__7},defn(__TOKEN[}$1{].PARAM))}){}dnl
define({__GET_TOKEN_ARRAY_8},{__SPOJ({__8},defn(__TOKEN[}$1{].PARAM))}){}dnl
define({__GET_TOKEN_ARRAY_9},{__SPOJ({__9},defn(__TOKEN[}$1{].PARAM))}){}dnl
dnl
dnl
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
define({__T_REVERSE_7},{__REVERSE_7_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_REVERSE_8},{__REVERSE_8_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
define({__T_REVERSE_9},{__REVERSE_9_PAR(__GET_TOKEN_ARRAY(eval(__COUNT_TOKEN-$1)))}){}dnl
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
define({__INC_TOKEN_COUNT},{define({__COUNT_TOKEN},eval(__COUNT_TOKEN+1))}){}dnl
dnl define({__INC_TOKEN_COUNT},ifdef({__COUNT_TOKEN},{define({__COUNT_TOKEN},eval(__COUNT_TOKEN+1))},{define({__COUNT_TOKEN},1)})){}dnl
dnl
dnl
define({__ADD_TOKEN},
    {ifdef({__COUNT_TOKEN},
        {ifelse(dnl
a,,,
            __T_NAME(0):$1,{__TOKEN_EQ:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_EQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_NE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_NE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_LT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_LT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_GT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_GT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_LE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_LE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_GE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_GE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_ULT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_ULT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_UGT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_UGT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_ULE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_ULE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_UGE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_UGE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_EQ:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_EQ_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_NE:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_NE_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_LT:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_LT_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_GT:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_GT_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_LE:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_LE_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_GE:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_GE_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_ULT:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_ULT_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_UGT:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_UGT_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_ULE:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_ULE_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_UGE:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_UGE_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_EQ,                {__SET_TOKEN({__TOKEN_0EQ},  __CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_NE,                {__SET_TOKEN({__TOKEN_0NE},  __CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_LT,                {__SET_TOKEN({__TOKEN_0LT},  __CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_GT,                {__SET_TOKEN({__TOKEN_0GT},  __CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_LE,                {__SET_TOKEN({__TOKEN_0LE},  __CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_GE,                {__SET_TOKEN({__TOKEN_0GE},  __CONCATENATE_WITH({ },__T_INFO(0),$2))},

__T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,  __TOKEN_CFETCH:__TOKEN_PUSHS:1:0x0000:__TOKEN_CEQ,  {define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_CFETCH_0CEQ},__TEMP)},
__T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,  __TOKEN_CFETCH:__TOKEN_PUSHS:1:0x0000:__TOKEN_CNE,  {define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_CFETCH_0CNE},__TEMP)},
__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_CEQ,               {__SET_TOKEN({__TOKEN_0CEQ}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):__T_HEX_REVERSE_1(0):$1,                        __TOKEN_PUSHS:1:0x0000:__TOKEN_CNE,               {__SET_TOKEN({__TOKEN_0CNE}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},

dnl # _0...
_0,,,

dnl # _1...
_1,,,

            __T_NAME(0):$1,   {__TOKEN_COR:__TOKEN_1ADD},      {__SET_TOKEN({__TOKEN_COR_1ADD},  __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   {__TOKEN_COR:__TOKEN_1CADD},     {__SET_TOKEN({__TOKEN_COR_1CADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   {__TOKEN_COR:__TOKEN_1ADD_ZF},   {__SET_TOKEN({__TOKEN_COR_1ADD_ZF},  __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   {__TOKEN_COR:__TOKEN_1CADD_ZF},  {__SET_TOKEN({__TOKEN_COR_1CADD_ZF}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_IS_PTR_1(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_PUSH_ADD:0:__TOKEN_PUSHS:1:0:__TOKEN_ADD},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(1)+__T_ARRAY_1(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_IS_PTR_1(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_PUSH_ADD:0:__TOKEN_PUSHS:1:0:__TOKEN_SUB},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(1)-__T_ARRAY_1(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_IS_PTR_1(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_PUSH_SUB:0:__TOKEN_PUSHS:1:0:__TOKEN_ADD},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(1)-__T_ARRAY_1(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_IS_PTR_1(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_PUSH_SUB:0:__TOKEN_PUSHS:1:0:__TOKEN_SUB},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(1)+__T_ARRAY_1(0)){}__DELETE_LAST_TOKEN},

            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_ADD:1:__TOKEN_1ADD},   {__SET_TOKEN({__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY_1(0)+1)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_ADD:1:__TOKEN_2ADD},   {__SET_TOKEN({__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY_1(0)+2)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_SUB:1:__TOKEN_1ADD},   {__SET_TOKEN({__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY_1(0)-1)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_SUB:1:__TOKEN_2ADD},   {__SET_TOKEN({__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY_1(0)-2)},

            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_ADD:1:__TOKEN_1SUB},   {__SET_TOKEN({__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY_1(0)-1)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_ADD:1:__TOKEN_2SUB},   {__SET_TOKEN({__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY_1(0)-2)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_SUB:1:__TOKEN_1SUB},   {__SET_TOKEN({__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY_1(0)+1)},
            __T_NAME(0):__T_IS_NUM_1(0):$1,{__TOKEN_PUSH_SUB:1:__TOKEN_2SUB},   {__SET_TOKEN({__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY_1(0)+2)},

            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_1ADD:__TOKEN_PUSHS:1:0:__TOKEN_ADD},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(0)+1){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_2ADD:__TOKEN_PUSHS:1:0:__TOKEN_ADD},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(0)+2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_1ADD:__TOKEN_PUSHS:1:0:__TOKEN_SUB},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(0)-1){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_2ADD:__TOKEN_PUSHS:1:0:__TOKEN_SUB},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(0)-2){}__DELETE_LAST_TOKEN},

            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_1SUB:__TOKEN_PUSHS:1:0:__TOKEN_ADD},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(0)-1){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_2SUB:__TOKEN_PUSHS:1:0:__TOKEN_ADD},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(0)-2){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_1SUB:__TOKEN_PUSHS:1:0:__TOKEN_SUB},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(0)+1){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):__T_IS_PTR_1(0):$1, {__TOKEN_2SUB:__TOKEN_PUSHS:1:0:__TOKEN_SUB},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY_1(0)+2){}__DELETE_LAST_TOKEN},

            __T_NAME(0):$1,{__TOKEN_2ADD:__TOKEN_1ADD},       {__SET_TOKEN({__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2),3)},
            __T_NAME(0):$1,{__TOKEN_2SUB:__TOKEN_1SUB},       {__SET_TOKEN({__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(0),$2),3)},

            __T_NAME(0):$1,{__TOKEN_2ADD:__TOKEN_2ADD},       {__SET_TOKEN({__TOKEN_PUSH_ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2),4)},
            __T_NAME(0):$1,{__TOKEN_2SUB:__TOKEN_2SUB},       {__SET_TOKEN({__TOKEN_PUSH_SUB}, __CONCATENATE_WITH({ },__T_INFO(0),$2),4)},

            __T_NAME(0):$1,{__TOKEN_1SUB:__TOKEN_2ADD},       {__SET_TOKEN({__TOKEN_1ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2ADD:__TOKEN_1SUB},       {__SET_TOKEN({__TOKEN_1ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_1ADD:__TOKEN_2SUB},       {__SET_TOKEN({__TOKEN_1SUB}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2SUB:__TOKEN_1ADD},       {__SET_TOKEN({__TOKEN_1SUB}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_1SUB:__TOKEN_1ADD},       {__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,{__TOKEN_1ADD:__TOKEN_1SUB},       {__DELETE_LAST_TOKEN},

            __T_NAME(0):$1,{__TOKEN_2SUB:__TOKEN_2ADD},       {__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,{__TOKEN_2ADD:__TOKEN_2SUB},       {__DELETE_LAST_TOKEN},

dnl # _2...
_2,,,
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_DADD},{__SET_TOKEN({__TOKEN_2DUP_DADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},


            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CEQ}, {__SET_TOKEN({__TOKEN_2DUP_CEQ}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CNE}, {__SET_TOKEN({__TOKEN_2DUP_CNE}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CULT},{__SET_TOKEN({__TOKEN_2DUP_CULT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CUGT},{__SET_TOKEN({__TOKEN_2DUP_CUGT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CULE},{__SET_TOKEN({__TOKEN_2DUP_CULE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_CUGE},{__SET_TOKEN({__TOKEN_2DUP_CUGE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HEQ}, {__SET_TOKEN({__TOKEN_2DUP_HEQ}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HNE}, {__SET_TOKEN({__TOKEN_2DUP_HNE}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HULT},{__SET_TOKEN({__TOKEN_2DUP_HULT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HUGT},{__SET_TOKEN({__TOKEN_2DUP_HUGT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HULE},{__SET_TOKEN({__TOKEN_2DUP_HULE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_HUGE},{__SET_TOKEN({__TOKEN_2DUP_HUGE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_EQ},{__SET_TOKEN({__TOKEN_2DUP_EQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_NE},{__SET_TOKEN({__TOKEN_2DUP_NE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_LT},{__SET_TOKEN({__TOKEN_2DUP_LT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_GT},{__SET_TOKEN({__TOKEN_2DUP_GT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_LE},{__SET_TOKEN({__TOKEN_2DUP_LE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_GE},{__SET_TOKEN({__TOKEN_2DUP_GE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_2DUP_EQ:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_EQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_NE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_NE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_LT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_LT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_GT:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_GT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_LE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_LE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_GE:__TOKEN_WHILE},{__SET_TOKEN({__TOKEN_2DUP_GE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_2DUP_EQ:__TOKEN_IF},   {__SET_TOKEN({__TOKEN_2DUP_EQ_IF},   __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_NE:__TOKEN_IF},   {__SET_TOKEN({__TOKEN_2DUP_NE_IF},   __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_LT:__TOKEN_IF},   {__SET_TOKEN({__TOKEN_2DUP_LT_IF},   __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_GT:__TOKEN_IF},   {__SET_TOKEN({__TOKEN_2DUP_GT_IF},   __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_LE:__TOKEN_IF},   {__SET_TOKEN({__TOKEN_2DUP_LE_IF},   __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_GE:__TOKEN_IF},   {__SET_TOKEN({__TOKEN_2DUP_GE_IF},   __CONCATENATE_WITH({ },__T_INFO(0),$2))},

__T_NAME(1):__T_NAME(0):$1,{__TOKEN_2DUP:__TOKEN_ULT:__TOKEN_IF},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_ULT_IF},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
__T_NAME(1):__T_NAME(0):$1,{__TOKEN_2DUP:__TOKEN_UGT:__TOKEN_IF},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_UGT_IF},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
__T_NAME(1):__T_NAME(0):$1,{__TOKEN_2DUP:__TOKEN_ULE:__TOKEN_IF},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_ULE_IF},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
__T_NAME(1):__T_NAME(0):$1,{__TOKEN_2DUP:__TOKEN_UGE:__TOKEN_IF},   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_UGE_IF},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},

            __T_NAME(0):$1,{__TOKEN_2DUP_EQ:__TOKEN_UNTIL},{__SET_TOKEN({__TOKEN_2DUP_EQ_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2DROP-__TOKEN_DROP},{__SET_TOKEN({__TOKEN_3DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2OVER-__TOKEN_2OVER},{__SET_TOKEN({__TOKEN_4DUP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT_1ADD_NROT:__TOKEN_2OVER:__TOKEN_NIP},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1ADD_NROT_2OVER_NIP},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT_1SUB_NROT:__TOKEN_2OVER:__TOKEN_NIP},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1SUB_NROT_2OVER_NIP},__TEMP)},
            __T_NAME(0)-$1,{__TOKEN_2OVER-__TOKEN_NIP},{__SET_TOKEN({__TOKEN_2OVER_NIP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2OVER-__TOKEN_DADD},{__SET_TOKEN({__TOKEN_2OVER_DADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2OVER-__TOKEN_DSUB},{__SET_TOKEN({__TOKEN_2OVER_DSUB},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_2DROP},{__SET_TOKEN({__TOKEN_2NIP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DSUB},{__SET_TOKEN({__TOKEN_2SWAP_DSUB},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DEQ},{__SET_TOKEN({__TOKEN_DEQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DNE},{__SET_TOKEN({__TOKEN_DNE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DLT},{__SET_TOKEN({__TOKEN_DGT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DGT},{__SET_TOKEN({__TOKEN_DLT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DLE},{__SET_TOKEN({__TOKEN_DGE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DGE},{__SET_TOKEN({__TOKEN_DLE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DULT},{__SET_TOKEN({__TOKEN_DUGT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DUGT},{__SET_TOKEN({__TOKEN_DULT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DULE},{__SET_TOKEN({__TOKEN_DUGE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2SWAP-__TOKEN_DUGE},{__SET_TOKEN({__TOKEN_DULE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,  __TOKEN_PUSHS:1:__TOKEN_2DUP, {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),__T_REVERSE_2(0),__T_REVERSE_1(0))},

dnl # _3..
_3,,,

            __T_NAME(0):$1,{__TOKEN_3_PICK:__TOKEN_3_PICK},{__SET_TOKEN({__TOKEN_2OVER},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_3DUP:__TOKEN_ROT},     {__SET_TOKEN({__TOKEN_3DUP_ROT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_3DUP:__TOKEN_NROT},    {__SET_TOKEN({__TOKEN_3DUP_NROT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

dnl # _4..
_4,,,
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DEQ},{__SET_TOKEN({__TOKEN_4DUP_DEQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DNE},{__SET_TOKEN({__TOKEN_4DUP_DNE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DLT},{__SET_TOKEN({__TOKEN_4DUP_DLT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DGT},{__SET_TOKEN({__TOKEN_4DUP_DGT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DLE},{__SET_TOKEN({__TOKEN_4DUP_DLE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DGE},{__SET_TOKEN({__TOKEN_4DUP_DGE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DULT},{__SET_TOKEN({__TOKEN_4DUP_DULT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DUGT},{__SET_TOKEN({__TOKEN_4DUP_DUGT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DULE},{__SET_TOKEN({__TOKEN_4DUP_DULE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DUGE},{__SET_TOKEN({__TOKEN_4DUP_DUGE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_4DUP-__TOKEN_DROP},{__SET_TOKEN({__TOKEN_4DUP_DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

dnl # A...

dnl # B...

dnl # C...
c...,,,

            __T_NAME(0):$1,            {__TOKEN_2OVER_NIP:__TOKEN_CFETCH},                                                  {__SET_TOKEN({__TOKEN_2OVER_NIP_CFETCH},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,            {__TOKEN_2OVER_NIP:__TOKEN_HFETCH},                                                  {__SET_TOKEN({__TOKEN_2OVER_NIP_HFETCH},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE:__TOKEN_2OVER_NIP:__TOKEN_CFETCH},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE_2OVER_NIP_CFETCH},__TEMP)},

            __T_NAME(0):$1,                              __TOKEN_CFETCH:__TOKEN_0CNE,               {__SET_TOKEN({__TOKEN_CFETCH_0CNE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                              __TOKEN_CFETCH:__TOKEN_0CEQ,               {__SET_TOKEN({__TOKEN_CFETCH_0CEQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):__T_ITEMS(0):$1:$#,             __TOKEN_PUSHS:1:__TOKEN_CONSTANT:3,         {__SET_TOKEN({__TOKEN_CONSTANT},                   __CONCATENATE_WITH({ },__T_INFO(0),$2),$3,__T_ARRAY(0))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1:$#,     __TOKEN_PUSHS:1:__TOKEN_CONSTANT:3,         {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_CONSTANT},__CONCATENATE_WITH({ },__T_LAST_1_PAR(1),$2),$3,__T_LAST_1_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__CONCATENATE_WITH({ },__T_INFO(1), {drop}),__DROP_1_PAR(__T_ARRAY(1)))},
            
            
dnl # DUP
dup,,,

__T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP:__TOKEN_DUP_TYPE_I:__TOKEN_DROP,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_TYPE_I},__T_INFO(1){ }__T_INFO(0),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},

            __T_NAME(0):$1,{__TOKEN_NIP:__TOKEN_DUP},               {__SET_TOKEN({__TOKEN_NIP_DUP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_DUP:__TOKEN_DOT},               {__SET_TOKEN({__TOKEN_DUP_DOT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},


            __T_NAME(0):$1,{__TOKEN_DUP:__TOKEN_ADD},               {__SET_TOKEN({__TOKEN_DUP_ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_DUP_DUP:__TOKEN_ADD},           {__SET_TOKEN({__TOKEN_DUP_DUP_ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP:__TOKEN_ADD},           {__SET_TOKEN({__TOKEN_2DUP_ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_DUP:__TOKEN_IF},                {__SET_TOKEN({__TOKEN_DUP_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_DUP:__TOKEN_WHILE},             {__SET_TOKEN({__TOKEN_DUP_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_I},                 {__SET_TOKEN({__TOKEN_DUP_I},__T_INFO(0){ }$2,shift(shift($@)))},
            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_J},                 {__SET_TOKEN({__TOKEN_DUP_J},__T_INFO(0){ }$2,shift(shift($@)))},
            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_K},                 {__SET_TOKEN({__TOKEN_DUP_K},__T_INFO(0){ }$2,shift(shift($@)))},

            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_DUP},                        {__SET_TOKEN({__TOKEN_DUP_DUP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP:__TOKEN_DUP_EMIT:__TOKEN_DROP,       {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_EMIT},__T_INFO(1){ }__T_INFO(0),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},

            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_TO_R},                       {__SET_TOKEN({__TOKEN_DUP_TO_R},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_FETCH},                      {__SET_TOKEN({__TOKEN_DUP_FETCH},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

__T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP_FETCH:__TOKEN_DUP_EMIT:__TOKEN_DROP, {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_FETCH_EMIT},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},

            __T_NAME(0)-$1,{__TOKEN_DUP_FETCH-__TOKEN_SWAP},                 {__SET_TOKEN({__TOKEN_DUP_FETCH_SWAP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_CFETCH},                     {__SET_TOKEN({__TOKEN_DUP_CFETCH},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DUP_CFETCH-__TOKEN_SWAP},                {__SET_TOKEN({__TOKEN_DUP_CFETCH_SWAP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DUP-__TOKEN_SPACE},         {__SET_TOKEN({__TOKEN_DUP_SPACE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DUP_SPACE-__TOKEN_DOT},     {__SET_TOKEN({__TOKEN_DUP_SPACE_DOT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DUP_SPACE-__TOKEN_UDOT},    {__SET_TOKEN({__TOKEN_DUP_SPACE_UDOT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,                                __TOKEN_DUP:__TOKEN_UNTIL,                        {__SET_TOKEN({__TOKEN_DUP_UNTIL},           __CONCATENATE_WITH({ },            __T_INFO(0),$2))},
            __T_NAME(1):__T_NAME(0):$1,        __TOKEN_DUP:__TOKEN_0EQ:__TOKEN_UNTIL,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_0EQ_UNTIL},       __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP_CFETCH:__TOKEN_0EQ:__TOKEN_UNTIL,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_CFETCH_0EQ_UNTIL},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1, __TOKEN_DUP_CFETCH:__TOKEN_0EQ:__TOKEN_WHILE,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_CFETCH_0EQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},

__T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_FILE:__TOKEN_PUSHS:2:__TOKEN_CMOVE,              {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_FILE_PUSH2_CMOVE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__ESCAPING(__ESCAPING(__T_ARRAY_1(1))),__ESCAPING(__ESCAPING(__T_ARRAY_2(1))),__ESCAPING(__ESCAPING(__T_ARRAY_3(1))),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},


dnl # D...
d...,,,
            __T_NAME(0):$1,{__TOKEN_UNPACK:__TOKEN_DROP},       {__SET_TOKEN({__TOKEN_UNPACK_DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):$1,{__TOKEN_PUSH_UNPACK:__TOKEN_DROP},  {__SET_TOKEN({__TOKEN_PUSH_UNPACK_DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):$1,{__TOKEN_PUSH2_UNPACK:__TOKEN_DROP}, {__SET_TOKEN({__TOKEN_PUSH2_UNPACK_DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},

            __T_NAME(0):$1,{__TOKEN_FILE:__TOKEN_DROP},         {__SET_TOKEN({__TOKEN_FILE_DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):$1,{__TOKEN_BINFILE:__TOKEN_DROP},      {__SET_TOKEN({__TOKEN_BINFILE_DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_DROP},         {__SET_TOKEN({__TOKEN_2DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_2DROP},        {__SET_TOKEN({__TOKEN_3DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_RAS},          {__SET_TOKEN({__TOKEN_DROP_RAS},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_DUP},          {__SET_TOKEN({__TOKEN_DROP_DUP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_OVER},         {__SET_TOKEN({__TOKEN_DROP_OVER},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_I},            {__SET_TOKEN({__TOKEN_DROP_I},__T_INFO(0){ }$2,$3)},
            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_J},            {__SET_TOKEN({__TOKEN_DROP_J},__T_INFO(0){ }$2,shift(shift($@)))},
            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_K},            {__SET_TOKEN({__TOKEN_DROP_K},__T_INFO(0){ }$2,shift(shift($@)))},

            __T_NAME(0)-$1,{__TOKEN_DROP-__TOKEN_R_FETCH},      {__SET_TOKEN({__TOKEN_DROP_R_FETCH},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DEQ-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DEQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DNE-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DNE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DLT-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DLT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DGT-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DGT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DLE-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DLE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DGE-__TOKEN_IF},            {__SET_TOKEN({__TOKEN_DGE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DULT-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DULT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DUGT-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DUGT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DULE-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DULE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DUGE-__TOKEN_IF},           {__SET_TOKEN({__TOKEN_DUGE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DEQ-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DEQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DNE-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DNE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DLT-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DLT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DGT-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DGT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DLE-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DLE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DGE-__TOKEN_WHILE},         {__SET_TOKEN({__TOKEN_DGE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_DULT-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DULT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DUGT-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DUGT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DULE-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DULE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_DUGE-__TOKEN_WHILE},        {__SET_TOKEN({__TOKEN_DUGE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,   __TOKEN_PD0EQ:__TOKEN_WHILE, {__SET_TOKEN({__TOKEN_PD0EQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   __TOKEN_PD0NE:__TOKEN_WHILE, {__SET_TOKEN({__TOKEN_PD0NE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,   __TOKEN_PD0EQ:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PD0EQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   __TOKEN_PD0NE:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PD0NE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   __TOKEN_PDEQ:__TOKEN_IF,  {__SET_TOKEN({__TOKEN_PDEQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   __TOKEN_PDNE:__TOKEN_IF,  {__SET_TOKEN({__TOKEN_PDNE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   __TOKEN_PDULT:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PDULT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   __TOKEN_PDUGT:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PDUGT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   __TOKEN_PDULE:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PDULE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,   __TOKEN_PDUGE:__TOKEN_IF, {__SET_TOKEN({__TOKEN_PDUGE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_D0EQ},         {__SET_TOKEN({__TOKEN_2DUP_D0EQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP-__TOKEN_D0NE},         {__SET_TOKEN({__TOKEN_2DUP_D0NE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_2DUP_D0EQ-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_2DUP_D0EQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP_D0NE-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_2DUP_D0NE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP_D0EQ-__TOKEN_WHILE},      {__SET_TOKEN({__TOKEN_2DUP_D0EQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_2DUP_D0NE-__TOKEN_WHILE},      {__SET_TOKEN({__TOKEN_2DUP_D0NE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1, __TOKEN_2DUP:__TOKEN_D0EQ:__TOKEN_IF,   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_D0EQ_IF},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
                        __T_NAME(0):$1,              __TOKEN_D0EQ:__TOKEN_IF,   {__SET_TOKEN({__TOKEN_D0EQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},


            __T_NAME(1):__T_NAME(0):$1, __TOKEN_2DUP:__TOKEN_D0NE:__TOKEN_IF,   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_D0NE_IF},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
                        __T_NAME(0):$1,              __TOKEN_D0NE:__TOKEN_IF,   {__SET_TOKEN({__TOKEN_D0NE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_4DUP_DEQ-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DEQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DNE-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DNE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DLT-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DLT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DGT-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DGT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DLE-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DLE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DGE-__TOKEN_IF},       {__SET_TOKEN({__TOKEN_4DUP_DGE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DULT-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_4DUP_DULT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DUGT-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_4DUP_DUGT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DULE-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_4DUP_DULE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DUGE-__TOKEN_IF},      {__SET_TOKEN({__TOKEN_4DUP_DUGE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_4DUP_DEQ-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DEQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DNE-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DNE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DLT-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DLT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DGT-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DGT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DLE-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DLE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DGE-__TOKEN_WHILE},    {__SET_TOKEN({__TOKEN_4DUP_DGE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DULT-__TOKEN_WHILE},   {__SET_TOKEN({__TOKEN_4DUP_DULT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DUGT-__TOKEN_WHILE},   {__SET_TOKEN({__TOKEN_4DUP_DUGT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DULE-__TOKEN_WHILE},   {__SET_TOKEN({__TOKEN_4DUP_DULE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_4DUP_DUGE-__TOKEN_WHILE},   {__SET_TOKEN({__TOKEN_4DUP_DUGE_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)=__GET_LOOP_TYPE(LOOP_STACK):$1,__TOKEN_I=S:__TOKEN_DUP,  {__SET_TOKEN({__TOKEN_DUP_DUP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

dnl # E...
dnl # F...
f...,,,
            __T_NAME(0)-$1,{__TOKEN_FOR-__TOKEN_I},             {__SET_TOKEN({__TOKEN_FOR_I},__T_INFO(0){ }$2,__T_ARRAY(0))},
dnl # G...
dnl # H...
h....,,,
            __T_NAME(0):$1,         __TOKEN_HEX:__TOKEN_UDOT,   {__SET_TOKEN({__TOKEN_HEX_UDOT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,         __TOKEN_HEX:__TOKEN_UDDOT,  {__SET_TOKEN({__TOKEN_HEX_UDDOT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,         __TOKEN_HEX:__TOKEN_PUDOT,  {__SET_TOKEN({__TOKEN_HEX_PUDOT},__T_INFO(0){ }$2,$3)},

dnl # I...
i....,,,

            __T_NAME(0):$1,               __TOKEN_2DUP:__TOKEN_FLT,                           {__SET_TOKEN({__TOKEN_2DUP_FLT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,               __TOKEN_DUP:__TOKEN_F0EQ,                           {__SET_TOKEN({__TOKEN_DUP_F0EQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,               __TOKEN_DUP:__TOKEN_F0LT,                           {__SET_TOKEN({__TOKEN_DUP_F0LT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            
            __T_NAME(0):$1,               __TOKEN_DUP_F0EQ:__TOKEN_IF,                        {__SET_TOKEN({__TOKEN_DUP_F0EQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                   __TOKEN_F0EQ:__TOKEN_IF,                            {__SET_TOKEN({__TOKEN_F0EQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,               __TOKEN_DUP_F0LT:__TOKEN_IF,                        {__SET_TOKEN({__TOKEN_DUP_F0LT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                   __TOKEN_F0LT:__TOKEN_IF,                            {__SET_TOKEN({__TOKEN_F0LT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,               __TOKEN_2DUP_FLT:__TOKEN_IF,                        {__SET_TOKEN({__TOKEN_2DUP_FLT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                    __TOKEN_FLT:__TOKEN_IF,                             {__SET_TOKEN({__TOKEN_FLT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            
            __T_NAME(0):$1,               __TOKEN_DUP_F0EQ:__TOKEN_UNTIL,                     {__SET_TOKEN({__TOKEN_DUP_F0EQ_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                   __TOKEN_F0EQ:__TOKEN_UNTIL,                         {__SET_TOKEN({__TOKEN_F0EQ_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,               __TOKEN_DUP_F0LT:__TOKEN_UNTIL,                     {__SET_TOKEN({__TOKEN_DUP_F0LT_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                   __TOKEN_F0LT:__TOKEN_UNTIL,                         {__SET_TOKEN({__TOKEN_F0LT_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,               __TOKEN_DUP_F0EQ:__TOKEN_WHILE,                     {__SET_TOKEN({__TOKEN_DUP_F0EQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                   __TOKEN_F0EQ:__TOKEN_WHILE,                         {__SET_TOKEN({__TOKEN_F0EQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,               __TOKEN_DUP_F0LT:__TOKEN_WHILE,                     {__SET_TOKEN({__TOKEN_DUP_F0LT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                   __TOKEN_F0LT:__TOKEN_WHILE,                         {__SET_TOKEN({__TOKEN_F0LT_WHILE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,   __TOKEN_2OVER_NIP_CFETCH:__TOKEN_0CEQ:__TOKEN_IF,   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_NIP_CFETCH_0CEQ_IF},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,   __TOKEN_2OVER_NIP_CFETCH:__TOKEN_0CNE:__TOKEN_IF,   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_NIP_CFETCH_0CNE_IF},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},

            __T_NAME(0):$1,                        __TOKEN_1ADD:__TOKEN_0CEQ,                 {__SET_TOKEN({__TOKEN_1ADD_0CEQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                     __TOKEN_1ADD_0CEQ:__TOKEN_IF,                 {__SET_TOKEN({__TOKEN_1ADD_0CEQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,                         __TOKEN_1ADD:__TOKEN_0EQ,                 {__SET_TOKEN({__TOKEN_1ADD_0EQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                      __TOKEN_1ADD_0EQ:__TOKEN_IF,                 {__SET_TOKEN({__TOKEN_1ADD_0EQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,   __TOKEN_DUP:__TOKEN_0EQ:__TOKEN_IF,                 {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_0EQ_IF},              __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                           __TOKEN_0EQ:__TOKEN_IF,                 {__SET_TOKEN({__TOKEN_0EQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,   __TOKEN_DUP:__TOKEN_0NE:__TOKEN_IF,                 {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_0NE_IF},              __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                           __TOKEN_0NE:__TOKEN_IF,                 {__SET_TOKEN({__TOKEN_0NE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,   __TOKEN_DUP:__TOKEN_0LT:__TOKEN_IF,                 {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_0LT_IF},              __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                           __TOKEN_0LT:__TOKEN_IF,                 {__SET_TOKEN({__TOKEN_0LT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,   __TOKEN_DUP:__TOKEN_0GT:__TOKEN_IF,                 {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_0GT_IF},              __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                           __TOKEN_0GT:__TOKEN_IF,                 {__SET_TOKEN({__TOKEN_0GT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,   __TOKEN_DUP:__TOKEN_0LE:__TOKEN_IF,                 {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_0LE_IF},              __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                           __TOKEN_0LE:__TOKEN_IF,                 {__SET_TOKEN({__TOKEN_0LE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,   __TOKEN_DUP:__TOKEN_0GE:__TOKEN_IF,                 {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_0GE_IF},              __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                           __TOKEN_0GE:__TOKEN_IF,                 {__SET_TOKEN({__TOKEN_0GE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,               __TOKEN_EQ:__TOKEN_IF,                              {__SET_TOKEN({__TOKEN_EQ_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,               __TOKEN_NE:__TOKEN_IF,                              {__SET_TOKEN({__TOKEN_NE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,               __TOKEN_LT:__TOKEN_IF,                              {ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSHS:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_LT_IF},__T_INFO(0){ <}$2, __T_ARRAY(0))},{__SET_TOKEN({__TOKEN_LT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))})},
            __T_NAME(0):$1,               __TOKEN_GT:__TOKEN_IF,                              {ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSHS:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_GT_IF},__T_INFO(0){ >}$2, __T_ARRAY(0))},{__SET_TOKEN({__TOKEN_GT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))})},
            __T_NAME(0):$1,               __TOKEN_LE:__TOKEN_IF,                              {ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSHS:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_LE_IF},__T_INFO(0){ <=}$2,__T_ARRAY(0))},{__SET_TOKEN({__TOKEN_LE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))})},
            __T_NAME(0):$1,               __TOKEN_GE:__TOKEN_IF,                              {ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSHS:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_GE_IF},__T_INFO(0){ >=}$2,__T_ARRAY(0))},{__SET_TOKEN({__TOKEN_GE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))})},

            __T_NAME(0):$1,               __TOKEN_ULT:__TOKEN_IF,                             {ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_ULT_IF},__T_INFO(0){ u<}$2, __T_ARRAY(0))},{__SET_TOKEN({__TOKEN_ULT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))})},
            __T_NAME(0):$1,               __TOKEN_UGT:__TOKEN_IF,                             {ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_UGT_IF},__T_INFO(0){ u>}$2, __T_ARRAY(0))},{__SET_TOKEN({__TOKEN_UGT_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))})},
            __T_NAME(0):$1,               __TOKEN_ULE:__TOKEN_IF,                             {ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_ULE_IF},__T_INFO(0){ u<=}$2,__T_ARRAY(0))},{__SET_TOKEN({__TOKEN_ULE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))})},
            __T_NAME(0):$1,               __TOKEN_UGE:__TOKEN_IF,                             {ifelse(__T_NAME(1):__T_ITEMS(1),__TOKEN_DUP_PUSH:1,{__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_DUP_PUSH_UGE_IF},__T_INFO(0){ u>=}$2,__T_ARRAY(0))},{__SET_TOKEN({__TOKEN_UGE_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))})},

dnl # J...
dnl # K...
dnl # L...
dnl # M...
dnl # N...
n...,,,

            __T_NAME(0)-$1,{__TOKEN_NROT-__TOKEN_SWAP},{__SET_TOKEN({__TOKEN_NROT_SWAP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_NROT-__TOKEN_NIP},{__SET_TOKEN({__TOKEN_NROT_NIP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_NROT-__TOKEN_2SWAP},{__SET_TOKEN({__TOKEN_NROT_2SWAP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

dnl # O...
o...,,,

            __T_NAME(0):$1,{__TOKEN_OVER:__TOKEN_IF},       {__SET_TOKEN({__TOKEN_OVER_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_OVER-__TOKEN_OVER},     {__SET_TOKEN({__TOKEN_2DUP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER-__TOKEN_SWAP},     {__SET_TOKEN({__TOKEN_OVER_SWAP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_AND}, {__SET_TOKEN({__TOKEN_OVER_SWAP_AND}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_OR},  {__SET_TOKEN({__TOKEN_OVER_SWAP_OR},  __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_XOR}, {__SET_TOKEN({__TOKEN_OVER_SWAP_XOR}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_CAND},{__SET_TOKEN({__TOKEN_OVER_SWAP_CAND},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_COR}, {__SET_TOKEN({__TOKEN_OVER_SWAP_COR}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_CXOR},{__SET_TOKEN({__TOKEN_OVER_SWAP_CXOR},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HAND},{__SET_TOKEN({__TOKEN_OVER_SWAP_HAND},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HOR}, {__SET_TOKEN({__TOKEN_OVER_SWAP_HOR}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HXOR},{__SET_TOKEN({__TOKEN_OVER_SWAP_HXOR},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_ADD}, {__SET_TOKEN({__TOKEN_OVER_SWAP_ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_SUB}, {__SET_TOKEN({__TOKEN_OVER_SWAP_SUB}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,{__TOKEN_TUCK:__TOKEN_ADD},      {__SET_TOKEN({__TOKEN_SWAP},__CONCATENATE_WITH({ },__T_INFO(0),$2)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_OVER_ADD},__dtto)},
            __T_NAME(0):$1,{__TOKEN_TUCK:__TOKEN_SUB},      {__SET_TOKEN({__TOKEN_SWAP},__CONCATENATE_WITH({ },__T_INFO(0),$2)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_OVER_SUB},__dtto)},

            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_CADD},{__SET_TOKEN({__TOKEN_OVER_SWAP_CADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_CSUB},{__SET_TOKEN({__TOKEN_OVER_SWAP_CSUB},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HADD},{__SET_TOKEN({__TOKEN_OVER_SWAP_HADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_OVER_SWAP-__TOKEN_HSUB},{__SET_TOKEN({__TOKEN_OVER_SWAP_HSUB},__CONCATENATE_WITH({ },__T_INFO(0),$2))},


            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1,
               __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_OVER:__TOKEN_CFETCH,
                  {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_OVER_CFETCH_OVER_CFETCH},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},

            __T_NAME(0)-$1,{__TOKEN_OVER_CFETCH_OVER_CFETCH-__TOKEN_CEQ},{__SET_TOKEN({__TOKEN_OVER_CFETCH_OVER_CFETCH_CEQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,                              __TOKEN_OVER:__TOKEN_UNTIL,               {__SET_TOKEN({__TOKEN_OVER_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_UNTIL,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_CFETCH_UNTIL},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_WHILE,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_CFETCH_WHILE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1,  __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_0EQ:__TOKEN_UNTIL,   {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_OVER_CFETCH_0EQ_UNTIL},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},
            __T_NAME(2):__T_NAME(1):__T_NAME(0):$1,  __TOKEN_OVER:__TOKEN_CFETCH:__TOKEN_0EQ:__TOKEN_WHILE,   {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_OVER_CFETCH_0EQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},

            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_OVER:__TOKEN_0EQ:__TOKEN_UNTIL,     {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_0EQ_UNTIL},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                              __TOKEN_2OVER_NIP:__TOKEN_UNTIL,            {__SET_TOKEN({__TOKEN_2OVER_NIP_UNTIL},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_2OVER_NIP:__TOKEN_0EQ:__TOKEN_UNTIL,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_NIP_0EQ_UNTIL},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_2OVER_NIP:__TOKEN_CFETCH_0CEQ:__TOKEN_UNTIL,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_NIP_CFETCH_0CEQ_UNTIL},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,      __TOKEN_2OVER_NIP:__TOKEN_CFETCH_0CEQ:__TOKEN_WHILE,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_NIP_CFETCH_0CEQ_WHILE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},

dnl # P
p,,,

            __T_NAME(0):$1,   __TOKEN_PDSUB:__TOKEN_NEGATE,   {__SET_TOKEN({__TOKEN_PDSUB_NEGATE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):$1,   __TOKEN_TUCK:__TOKEN_PORTSTORE, {__SET_TOKEN({__TOKEN_TUCK_PORTSTORE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_PLAY,                                {__SET_TOKEN({__TOKEN_PUSH_PLAY},   __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):$1,                      __TOKEN_FILE:__TOKEN_PLAY,                                   {__SET_TOKEN({__TOKEN_FILE_PLAY},   __CONCATENATE_WITH({ },__T_INFO(0),$2),__ESCAPING(__ESCAPING(__T_ARRAY_1(1))),__ESCAPING(__ESCAPING(__T_ARRAY_2(1))),__ESCAPING(__ESCAPING(__T_ARRAY_3(1))))},
            __T_NAME(0):$1,                      __TOKEN_BINFILE:__TOKEN_PLAY,                                {__SET_TOKEN({__TOKEN_BINFILE_PLAY},__CONCATENATE_WITH({ },__T_INFO(0),$2),__ESCAPING(__ESCAPING(__T_ARRAY_1(1))),__ESCAPING(__ESCAPING(__T_ARRAY_2(1))),__ESCAPING(__ESCAPING(__T_ARRAY_3(1))))},
__T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_BINFILE:__TOKEN_PUSHS:1:__TOKEN_UNPACK,              {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_BINFILE_PUSH_UNPACK},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__ESCAPING(__ESCAPING(__T_ARRAY_1(1))),__ESCAPING(__ESCAPING(__T_ARRAY_2(1))),__ESCAPING(__ESCAPING(__T_ARRAY_3(1))),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                      __TOKEN_BINFILE_PUSH_UNPACK:__TOKEN_PLAY,                    {__SET_TOKEN({__TOKEN_BINFILE_PUSH_UNPACK_PLAY},__CONCATENATE_WITH({ },__T_INFO(0),$2),__ESCAPING(__ESCAPING(__T_ARRAY_1(0))),__ESCAPING(__ESCAPING(__T_ARRAY_2(0))),__ESCAPING(__ESCAPING(__T_ARRAY_3(0))),__T_ARRAY_4(0))},
__T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1=__T_HEX_4(1),         __TOKEN_FILE_PUSH2_CMOVE:__TOKEN_PUSHS:1:__TOKEN_PLAY=__T_HEX_1(0),   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_FILEBUFFERPLAY},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__ESCAPING(__ESCAPING(__T_ARRAY_1(1))),__ESCAPING(__ESCAPING(__T_ARRAY_2(1))),__ESCAPING(__ESCAPING(__T_ARRAY_3(1))),__T_ARRAY_4(1)){}__DELETE_LAST_TOKEN},


dnl # PUSHDOT
pushdot,,,
            __T_NAME(0):$1:__IS_NUM($3),                 __TOKEN_PUSHS:__TOKEN_PUSHDOT:1,                      {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),__HEX_DE($3),__HEX_HL($3))},
            __T_NAME(0):$1:__IS_MEM_REF($3),             __TOKEN_PUSHS:__TOKEN_PUSHDOT:1,                      {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),($3+2),$3)},
            $1:__IS_NUM($3),                             __TOKEN_PUSHDOT:1,                                    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSHS},$2,__HEX_DE($3),__HEX_HL($3))},
            $1:__IS_MEM_REF($3),                         __TOKEN_PUSHDOT:1,                                    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSHS},$2,($3+2),$3)},

dnl # PUSH
push,,,
            __T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_TESTKEY,                             {__SET_TOKEN({__TOKEN_PUSH_TESTKEY},   __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_TESTKEY_ZF,                          {__SET_TOKEN({__TOKEN_PUSH_TESTKEY_ZF},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_TESTKEY,                             {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_TESTKEY},    __CONCATENATE_WITH({ },__T_LAST_1_PAR(1),$2),__T_LAST_1_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__CONCATENATE_WITH({ },__T_INFO(1), {drop}),__DROP_1_PAR(__T_ARRAY(1)))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_TESTKEY_ZF,                          {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_TESTKEY_ZF}, __CONCATENATE_WITH({ },__T_LAST_1_PAR(1),$2),__T_LAST_1_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__CONCATENATE_WITH({ },__T_INFO(1), {drop}),__DROP_1_PAR(__T_ARRAY(1)))},

            __T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_TESTKEMPSTON,                        {__SET_TOKEN({__TOKEN_PUSH_TESTKEMPSTON},   __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_TESTKEMPSTON_ZF,                     {__SET_TOKEN({__TOKEN_PUSH_TESTKEMPSTON_ZF},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_TESTKEMPSTON,                        {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_TESTKEMPSTON},    __CONCATENATE_WITH({ },__T_LAST_1_PAR(1),$2),__T_LAST_1_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__CONCATENATE_WITH({ },__T_INFO(1), {drop}),__DROP_1_PAR(__T_ARRAY(1)))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_TESTKEMPSTON_ZF,                     {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_TESTKEMPSTON_ZF}, __CONCATENATE_WITH({ },__T_LAST_1_PAR(1),$2),__T_LAST_1_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__CONCATENATE_WITH({ },__T_INFO(1), {drop}),__DROP_1_PAR(__T_ARRAY(1)))},

            __T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_PORTFETCH,                           {__SET_TOKEN({__TOKEN_PUSH_PORTFETCH},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_PORTFETCH,                           {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_PORTFETCH}, __CONCATENATE_WITH({ },__T_LAST_1_PAR(1),$2),__T_LAST_1_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__CONCATENATE_WITH({ },__T_INFO(1), {drop}),__DROP_1_PAR(__T_ARRAY(1)))},

__T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_OVER:__TOKEN_PUSHS:1:__TOKEN_PORTSTORE,              {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_PUSH_PORTSTORE}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
__T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_PORTSTORE,               {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH_PORTSTORE},  __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,         __TOKEN_PUSHS:1:__TOKEN_2DUP:__TOKEN_PORTSTORE,              {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_2DUP_PORTSTORE},  __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                      __TOKEN_2DUP:__TOKEN_PORTSTORE,                              {__SET_TOKEN({__TOKEN_2DUP_PORTSTORE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_PORTSTORE,                           {__SET_TOKEN({__TOKEN_PUSH_PORTSTORE},  __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:2:__TOKEN_PORTSTORE,                           {__SET_TOKEN({__TOKEN_PUSH2_PORTSTORE}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_PORTSTORE,                           {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_PORTSTORE}, __CONCATENATE_WITH({ },__T_LAST_1_PAR(1),$2),__T_LAST_1_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__CONCATENATE_WITH({ },__T_INFO(1), {drop}),__DROP_1_PAR(__T_ARRAY(1)))},

            __T_NAME(0):$1,                      __TOKEN_PUSH_TESTKEY:__TOKEN_0EQ,                            {__SET_TOKEN({__TOKEN_PUSH_TESTKEY_0EQ},     __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):$1,                      __TOKEN_TESTKEY:__TOKEN_0EQ,                                 {__SET_TOKEN({__TOKEN_TESTKEY_0EQ},          __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):$1,                      __TOKEN_PUSH_TESTKEMPSTON:__TOKEN_0EQ,                       {__SET_TOKEN({__TOKEN_PUSH_TESTKEMPSTON_0EQ},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):$1,                      __TOKEN_TESTKEMPSTON:__TOKEN_0EQ,                            {__SET_TOKEN({__TOKEN_TESTKEMPSTON_0EQ},     __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1:__PSIZE_$3,         __TOKEN_PUSHS:1:__TOKEN_TO:2,                      {__SET_TOKEN({__TOKEN_PUSH_TO},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0),shift(shift($@)))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1:__PSIZE_$3, __TOKEN_PUSHS:1:__TOKEN_TO:2,                      {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_TO}, __CONCATENATE_WITH({ },__T_LAST_1_PAR(1),$2),__T_LAST_1_PAR(1),shift(shift($@))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__CONCATENATE_WITH({ },__T_INFO(1), {drop}),__DROP_1_PAR(__T_ARRAY(1)))},

            __T_NAME(0):__T_ITEMS(0):$1:__PSIZE_$3,         __TOKEN_PUSHS:2:__TOKEN_TO:4,                      {__SET_TOKEN({__TOKEN_PUSH2_TO},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0),shift(shift($@)))},
            __T_NAME(0):eval(__T_ITEMS(0)>2):$1:__PSIZE_$3, __TOKEN_PUSHS:1:__TOKEN_TO:4,                      {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_TO},__CONCATENATE_WITH({ },__T_LAST_2_PAR(1),$2),__T_LAST_2_PAR(1),shift(shift($@))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__CONCATENATE_WITH({ },__T_INFO(1),{2drop}),__DROP_2_PAR(__T_ARRAY(1)))},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_DROP,                         {__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                              __TOKEN_PUSHS:__TOKEN_DROP,                           {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0)))},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_ADDLOOP,
__{}__{}__{}{ifelse(__GET_LOOP_STEP($3),{},{dnl
__{}__{}__{}__{}__SET_LOOP_STEP($3,__T_ARRAY_1(0)){}__SET_TOKEN({__TOKEN_PUSH_ADDLOOP},__CONCATENATE_WITH({ },__T_INFO(0),$2),$3,__T_ARRAY_1(0))},
__{}__{}__{}{dnl
__{}__{}__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN(__TOKEN_PUSH_ADDLOOP,__CONCATENATE_WITH({ },__GET_LOOP_STEP($3),$2),$3,__GET_LOOP_STEP($3)){}dnl
__{}__{}__{}})},

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
            __T_NAME(0):$1,                              __TOKEN_PUSH_CFETCH:__TOKEN_ADD,                      {__SET_TOKEN({__TOKEN_PUSH_CFETCH_ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):$1,                              __TOKEN_PUSH_CFETCH:__TOKEN_SUB,                      {__SET_TOKEN({__TOKEN_PUSH_CFETCH_SUB},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_FOR,                          {__SET_LOOP_BEGIN($3,__T_REVERSE_1(0)){}__SET_TOKEN({__TOKEN_PUSH_FOR}, __T_INFO(0){ }$2,$3)},
            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_QFOR,                         {__SET_LOOP_BEGIN($3,__T_REVERSE_1(0)){}__SET_TOKEN({__TOKEN_PUSH_QFOR},__T_INFO(0){ }$2,$3)},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,         __TOKEN_PUSHS:1:__TOKEN_FOR,                          {__SET_LOOP_BEGIN($3,__T_REVERSE_1(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_FOR}, __CONCATENATE_WITH({ },__T_REVERSE_1(1),$2),$3){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }drop,__DROP_1_PAR(__T_ARRAY(1)))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1,         __TOKEN_PUSHS:1:__TOKEN_QFOR,                         {__SET_LOOP_BEGIN($3,__T_REVERSE_1(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_QFOR},__CONCATENATE_WITH({ },__T_REVERSE_1(1),$2),$3){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__T_NAME(1),__T_INFO(1){ }drop,__DROP_1_PAR(__T_ARRAY(1)))},

            __T_NAME(0)-$1,                              __TOKEN_PUSH_FOR-__TOKEN_I,                           {__SET_TOKEN({__TOKEN_PUSH_FOR_I},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0)-$1,                              __TOKEN_PUSH_QFOR-__TOKEN_I,                          {__SET_TOKEN({__TOKEN_PUSH_QFOR_I},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_I,                            {__SET_TOKEN({__TOKEN_PUSH_I},__T_INFO(0){ }$2,__T_ARRAY(0),$3)},
            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_J,                            {__SET_TOKEN({__TOKEN_PUSH_J},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},
            __T_NAME(0):__T_ITEMS(0):$1,                 __TOKEN_PUSHS:1:__TOKEN_K,                            {__SET_TOKEN({__TOKEN_PUSH_K},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},

            __T_NAME(0)=__T_HEX_REVERSE_1(0):$1,         __TOKEN_PUSHS=0x0000:__TOKEN_QDUP,                    {},
            __T_NAME(0):__T_IS_NUM_REVERSE_1(0):$1,      __TOKEN_PUSHS:1:__TOKEN_QDUP,                         {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__T_ARRAY(0),__T_REVERSE_1(0))},

__T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,     __TOKEN_NIP:__TOKEN_PUSHS:1:__TOKEN_OVER,                         {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_NIP_PUSH_OVER},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
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

            __T_NAME(0):$1,                                            __TOKEN_2OVER:__TOKEN_3_PICK,             {__SET_TOKEN({__TOKEN_2OVER_3_PICK},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(1):__T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_2OVER:__TOKEN_PUSHS=0x0003:1:__TOKEN_PICK, {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2OVER_3_PICK},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},


+4,2 1 0 0 pick,,
+3,2 1 0 1 pick,,
+2,2 1 0 2 pick,,
            __T_NAME(0):eval(__T_ITEMS(0)+0>__T_HEX_REVERSE_1(0)+1):$1,__TOKEN_PUSHS:1:__TOKEN_PICK,        {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__DROP_1_PAR(__T_ARRAY(0)),__REVERSE_X_PAR(__T_REVERSE_1(0)+2,__T_ARRAY(0)))},

+1,hl->tos,,
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0000:1:__TOKEN_PICK,                                                                                                                                                                                          {__SET_TOKEN(                        __TOKEN_DUP,           __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0001:2:__TOKEN_PICK,                                                                                                                                                                                          {__SET_TOKEN(                        __TOKEN_PUSH_OVER,     __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_REVERSE_2(0)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0002:3:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP},                                        __dtto,                                                                    __T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_OVER,     __CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_3(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0003:4:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP},                              __dtto,                                                   __T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_OVER,     __CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_4(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0004:5:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},                    __dtto,                                  __T_REVERSE_4(1),__T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_OVER,     __CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_5(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0005:6:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},          __dtto,                 __T_REVERSE_5(1),__T_REVERSE_4(1),__T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_OVER,     __CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_6(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0006:7:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},__dtto,__T_REVERSE_6(1),__T_REVERSE_5(1),__T_REVERSE_4(1),__T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_OVER,     __CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_7(1)))},

0,de->tos,,
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0001:1:__TOKEN_PICK,                                                                                                                                                                                          {__SET_TOKEN(                        __TOKEN_OVER,          __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0002:2:__TOKEN_PICK,                                                                                                                                                                                          {__SET_TOKEN(                        __TOKEN_OVER_PUSH_SWAP,__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_REVERSE_2(0)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0003:3:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP},                                        __dtto,                                                                    __T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_PUSH_SWAP,__CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_3(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0004:4:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP},                              __dtto,                                                   __T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_PUSH_SWAP,__CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_4(1)))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0005:5:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},                    __dtto,                                  __T_REVERSE_4(1),__T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_PUSH_SWAP,__CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_5(1))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0006:6:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},          __dtto,                 __T_REVERSE_5(1),__T_REVERSE_4(1),__T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_PUSH_SWAP,__CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_6(1))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0007:7:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},__dtto,__T_REVERSE_6(1),__T_REVERSE_5(1),__T_REVERSE_4(1),__T_REVERSE_3(1),__T_REVERSE_2(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_PUSH_SWAP,__CONCATENATE_WITH({ },__T_INFO(1),$2),__T_REVERSE_7(1))},

-1,(sp)->tos,,
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0002:1:__TOKEN_PICK,                                                                                                                                              {__SET_TOKEN(                        __TOKEN_2_PICK,        __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0003:2:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP},                                        __dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_3_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0004:3:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP},                              __dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_3_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0005:4:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},                    __dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_3_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0006:5:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},          __dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_3_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0007:6:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},__dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_3_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},

-2,(sp+2)->tos,,
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0003:1:__TOKEN_PICK,                                                                                                                                              {__SET_TOKEN(                        __TOKEN_3_PICK,        __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0004:2:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP},                                        __dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_4_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0005:3:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP},                              __dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_4_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0006:4:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},                    __dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_4_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0007:5:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},          __dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_4_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},
            __T_NAME(0)=__T_HEX_REVERSE_1(0):__T_ITEMS(0):$1, __TOKEN_PUSHS=0x0008:6:__TOKEN_PICK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP},__dtto,          __DROP_1_PAR(__T_ARRAY(1))){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_OVER_4_PICK,   __CONCATENATE_WITH({ },__T_INFO(1),$2))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_PICK,           {__SET_TOKEN({__TOKEN_PUSH_PICK},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                                   __TOKEN_PUSHS:__TOKEN_PICK,             {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_PICK},__T_REVERSE_1(1){ }$2,__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ drop},__DROP_1_PAR(__T_ARRAY(1)))},

            __T_NAME(0):$1:$#,                                __TOKEN_PUSH_PICK:__TOKEN_PUSHS:3,      {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH},__T_INFO(0){ }$2,__T_ARRAY(0),shift(shift($@)))},
            __T_NAME(0)-$1,                                   __TOKEN_PUSH_PICK_PUSH-__TOKEN_SWAP,    {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH_SWAP},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0)-$1,                                   __TOKEN_2_PICK-__TOKEN_PUSH,            {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH},__T_INFO(0){ }$2,2,shift(shift($@)))},
            __T_NAME(0)-$1,                                   __TOKEN_3_PICK-__TOKEN_PUSH,            {__SET_TOKEN({__TOKEN_PUSH_PICK_PUSH},__T_INFO(0){ }$2,3,shift(shift($@)))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_R_FETCH,        {__SET_TOKEN({__TOKEN_PUSH_R_FETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_2STORE,         {__SET_TOKEN({__TOKEN_PUSH_2STORE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_2FETCH,         {__SET_TOKEN({__TOKEN_PUSH_2FETCH},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_ALLOT,          {__SET_TOKEN({__TOKEN_PUSH_ALLOT},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,          __TOKEN_PUSH_COMMA:__TOKEN_PUSHS:1:__TOKEN_COMMA,
               {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSHS_COMMA},__CONCATENATE_WITH({ },{__T_INFO(1)},__T_INFO(0),{$2}),__T_ARRAY(1),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},

            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,          __TOKEN_PUSHS_COMMA:__TOKEN_PUSHS:1:__TOKEN_COMMA,
               {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSHS_COMMA},__CONCATENATE_WITH({ },{__T_INFO(1)},__T_INFO(0),{$2}),__T_ARRAY(1),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_COMMA,          {__SET_TOKEN({__TOKEN_PUSH_COMMA}, __CONCATENATE_WITH({ },__T_INFO(0),{$2}),__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_LSHIFT,         {__SET_TOKEN({__TOKEN_PUSH_LSHIFT},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_RSHIFT,         {__SET_TOKEN({__TOKEN_PUSH_RSHIFT},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},

            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,          __TOKEN_OVER:__TOKEN_PUSHS:1:__TOKEN_SWAP, {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_PUSH_SWAP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,          __TOKEN_DUP:__TOKEN_PUSHS:1:__TOKEN_SWAP,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_OVER},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_SWAP,              {__SET_TOKEN({__TOKEN_PUSH_SWAP},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0)-$1,                                   __TOKEN_PUSH_COMMA-__TOKEN_PUSHS_COMMA, {__SET_TOKEN({__TOKEN_PUSHS_COMMA},__CONCATENATE_WITH({__T_INFO(0)},{$2}),__T_ARRAY(0),shift(shift($@)))},
            __T_NAME(0)-$1,                                   __TOKEN_PUSHS_COMMA-__TOKEN_PUSHS_COMMA,{__SET_TOKEN({__TOKEN_PUSHS_COMMA},__CONCATENATE_WITH({__T_INFO(0)},{$2}),__T_ARRAY(0),shift(shift($@)))},

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
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_NE,              {__SET_TOKEN({__TOKEN_PUSH_NE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_CEQ,             {__SET_TOKEN({__TOKEN_PUSH_CEQ},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:1:__TOKEN_CNE,             {__SET_TOKEN({__TOKEN_PUSH_CNE},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):$1,                                   __TOKEN_PUSH_EQ:__TOKEN_IF,              {__SET_TOKEN({__TOKEN_PUSH_EQ_IF},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                                   __TOKEN_PUSH_NE:__TOKEN_IF,              {__SET_TOKEN({__TOKEN_PUSH_NE_IF},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                                   __TOKEN_PUSH_CEQ:__TOKEN_IF,             {__SET_TOKEN({__TOKEN_PUSH_CEQ_IF},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                                   __TOKEN_PUSH_CNE:__TOKEN_IF,             {__SET_TOKEN({__TOKEN_PUSH_CNE_IF},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):$1,                                   __TOKEN_0EQ:__TOKEN_WHILE,               {__SET_TOKEN({__TOKEN_PUSH_EQ_WHILE},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0NE:__TOKEN_WHILE,               {__SET_TOKEN({__TOKEN_PUSH_NE_WHILE},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0LT:__TOKEN_WHILE,               {__SET_TOKEN({__TOKEN_PUSH_LT_WHILE},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0GT:__TOKEN_WHILE,               {__SET_TOKEN({__TOKEN_PUSH_GT_WHILE},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0LE:__TOKEN_WHILE,               {__SET_TOKEN({__TOKEN_PUSH_LE_WHILE},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0GE:__TOKEN_WHILE,               {__SET_TOKEN({__TOKEN_PUSH_GE_WHILE},__T_INFO(0){ }$2,0)},

            __T_NAME(0):$1,                                   __TOKEN_0EQ:__TOKEN_UNTIL,               {__SET_TOKEN({__TOKEN_PUSH_EQ_UNTIL},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0NE:__TOKEN_UNTIL,               {__SET_TOKEN({__TOKEN_PUSH_NE_UNTIL},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0LT:__TOKEN_UNTIL,               {__SET_TOKEN({__TOKEN_PUSH_LT_UNTIL},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0GT:__TOKEN_UNTIL,               {__SET_TOKEN({__TOKEN_PUSH_GT_UNTIL},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0LE:__TOKEN_UNTIL,               {__SET_TOKEN({__TOKEN_PUSH_LE_UNTIL},__T_INFO(0){ }$2,0)},
            __T_NAME(0):$1,                                   __TOKEN_0GE:__TOKEN_UNTIL,               {__SET_TOKEN({__TOKEN_PUSH_GE_UNTIL},__T_INFO(0){ }$2,0)},

            __T_NAME(0):$1,                                   __TOKEN_PUSH_EQ:__TOKEN_WHILE,           {__SET_TOKEN({__TOKEN_PUSH_EQ_WHILE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                                   __TOKEN_PUSH_EQ:__TOKEN_UNTIL,           {__SET_TOKEN({__TOKEN_PUSH_EQ_UNTIL},__T_INFO(0){ }$2,__T_ARRAY(0))},

            __T_NAME(0):$1,                                   __TOKEN_PUSH_NE:__TOKEN_WHILE,           {__SET_TOKEN({__TOKEN_PUSH_NE_WHILE},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):$1,                                   __TOKEN_PUSH_NE:__TOKEN_UNTIL,           {__SET_TOKEN({__TOKEN_PUSH_NE_UNTIL},__T_INFO(0){ }$2,__T_ARRAY(0))},

dnl # PUSH2
push2,,,


            __T_NAME(0):eval(__T_ITEMS(0)0>10):$1,              __TOKEN_PUSHS:1:__TOKEN_ADDLOOP,
            {ifelse(__GET_LOOP_STEP($3),{},
__{}__{}__{}__{}{__SET_LOOP_STEP($3,__T_REVERSE_1(0)){}dnl
__{}__{}__{}__{}__{}__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ drop},__DROP_1_PAR(__T_ARRAY(0))){}dnl
__{}__{}__{}__{}__{}__INC_TOKEN_COUNT{}dnl
__{}__{}__{}__{}__{}__SET_TOKEN(__TOKEN_PUSH_ADDLOOP,__GET_LOOP_STEP($3){ }$2,shift(shift($@)))},
__{}__{}__{}__{}{__INC_TOKEN_COUNT{}dnl
__{}__{}__{}__{}__{}__SET_TOKEN(__TOKEN_PUSH_ADDLOOP,__CONCATENATE_WITH({ },__GET_LOOP_STEP($3),$2),$3,__GET_LOOP_STEP($3)){}dnl
__{}__{}__{}__{}}){}dnl
__{}__{}__{}},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_DO,              {ifelse(__GET_LOOP_BEGIN($3):__GET_LOOP_END($3),{:},{dnl
__{}__{}__{}__{}__SET_LOOP_END(  $3,__T_ARRAY_1(0)){}dnl
__{}__{}__{}__{}__SET_LOOP_BEGIN($3,__T_ARRAY_2(0)){}dnl
__{}__{}__{}__{}__SET_TOKEN({__TOKEN_DO},__T_INFO(0){ }$2,$3)},{__INC_TOKEN_COUNT{}__SET_TOKEN($@)})},

            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_QDO,             {ifelse(__GET_LOOP_BEGIN($3):__GET_LOOP_END($3),{:},{dnl
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

__T_NAME(1):__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_DROP:__TOKEN_PUSHS:2:__TOKEN_CFETCH,          {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DROP_PUSH2_CFETCH},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(0)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):__T_ITEMS(0):$1,                      __TOKEN_PUSHS:2:__TOKEN_CFETCH,          {__SET_TOKEN(                        {__TOKEN_PUSH2_CFETCH},     __CONCATENATE_WITH({ },            __T_INFO(0),$2),__T_ARRAY(0))},


dnl # PUSH3
push3,,,

_errprint(__T_NAME(1)(__T_ITEMS(1)):__T_NAME(0)(__T_ITEMS(0)):$1{
}),x,blah,

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
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_UDIV:0x0002,            {__SET_TOKEN({__TOKEN_2UDIV},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),      __TOKEN_PUSHS:1:__TOKEN_UDIV:0x0004,            {__SET_TOKEN({__TOKEN_4UDIV},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

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

__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_ULT:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u<,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UGT:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u>,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_ULE:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u<=,__T_LAST_2_PAR(0)))},
__T_NAME(0):eval(__T_ITEMS(0)>1):$1:__T_IS_PTR_REVERSE_2_1(0),  __TOKEN_PUSHS:1:__TOKEN_UGE:0,      {__SET_TOKEN(__TOKEN_PUSHS, __T_INFO(0){ }$2,__DROP_2_PAR(__T_ARRAY(0)){}ifelse(__T_ITEMS(0),2,,{,}){}__EVAL_S16(u>=,__T_LAST_2_PAR(0)))},

      fill=,     _2dup_fill_2dirty,+_2drop,
 push_fill=,_2dup_push_fill_2dirty,+_2drop,
push2_fill=, dup_push2_fill_dirty,   +drop,
push3_fill=,     push3_fill,,

__T_NAME(0):__T_ITEMS(0):$1,                     __TOKEN_PUSHS:1:__TOKEN_2DUP_FILL_2DIRTY,                                      {__SET_TOKEN({__TOKEN_2DUP_PUSH_FILL_2DIRTY}, __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,         __TOKEN_PUSHS:2:__TOKEN_2DUP_FILL_2DIRTY:__TOKEN_2DROP,{__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_PUSH2_FILL_DIRTY},  __CONCATENATE_WITH({ },__T_INFO(1),$2),__T_ARRAY(1)){}__SET_TOKEN(__TOKEN_DROP,__dtto)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0):$1,         __TOKEN_PUSHS:3:__TOKEN_2DUP_FILL_2DIRTY:__TOKEN_2DROP,   {__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_PUSH3_FILL},            __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
__T_NAME(1):eval(__T_ITEMS(1)+0>3):__T_NAME(0):$1, __TOKEN_PUSHS:1:__TOKEN_2DUP_FILL_2DIRTY:__TOKEN_2DROP,                      {__SET_TOKEN({__TOKEN_PUSH3_FILL},            __CONCATENATE_WITH({ },__T_LAST_3_PAR(1),$2),__T_LAST_3_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ 3drop},__DROP_3_PAR(__T_ARRAY(1)))},

__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:1:__TOKEN_CMOVE:0x0000, {__SET_TOKEN({__TOKEN_2DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:2:__TOKEN_CMOVE:0x0000, {__SET_TOKEN({__TOKEN_DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:3:__TOKEN_CMOVE:0x0000, {__DELETE_LAST_TOKEN},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1:__T_HEX_REVERSE_1(0), __TOKEN_PUSHS:1:__TOKEN_CMOVE:0x0000, {__SET_TOKEN({__TOKEN_PUSHS},__T_INFO(0){ }$2,__DROP_3_PAR(__T_ARRAY(0)))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:1:__TOKEN_CMOVE,    {__SET_TOKEN({__TOKEN_PUSH_CMOVE},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:2:__TOKEN_CMOVE,    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_CMOVE},__T_REVERSE_1(1){ }$2,__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ drop},__DROP_1_PAR(__T_ARRAY(1)))},
__T_NAME(0):__T_ITEMS(0):$1,         __TOKEN_PUSHS:3:__TOKEN_CMOVE,    {__SET_TOKEN({__TOKEN_PUSH3_CMOVE},__T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):eval(__T_ITEMS(0)>3):$1, __TOKEN_PUSHS:1:__TOKEN_CMOVE,    {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH3_CMOVE},__REMOVE_COMMA(__T_LAST_3_PAR(1)){ }$2,__T_LAST_3_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ 3drop},__DROP_3_PAR(__T_ARRAY(1)))},

__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:1:__TOKEN_MOVE:0x0000,  {__SET_TOKEN({__TOKEN_2DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0):$1:__T_HEX_REVERSE_1(0),         __TOKEN_PUSHS:2:__TOKEN_MOVE:0x0000,  {__SET_TOKEN({__TOKEN_DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
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

__T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,        {__TOKEN_PUSHS:2=0x0000:0x0000:__TOKEN_DEQ},{__SET_TOKEN({__TOKEN_D0EQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,        {__TOKEN_PUSHS:2=0x0000:0x0000:__TOKEN_DNE},{__SET_TOKEN({__TOKEN_D0NE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):__T_ITEMS(0)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,        {__TOKEN_PUSHS:2=0x0000:0x0000:__TOKEN_DLT},{__SET_TOKEN({__TOKEN_D0LT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
__T_NAME(0):eval(__T_ITEMS(0)>2)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,{__TOKEN_PUSHS:1=0x0000:0x0000:__TOKEN_DEQ},{__SET_TOKEN(__TOKEN_PUSHS,__T_INFO(0){ 2drop},__DROP_2_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_D0EQ},{0. }$2)},
__T_NAME(0):eval(__T_ITEMS(0)>2)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,{__TOKEN_PUSHS:1=0x0000:0x0000:__TOKEN_DNE},{__SET_TOKEN(__TOKEN_PUSHS,__T_INFO(0){ 2drop},__DROP_2_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_D0NE},{0. }$2)},
__T_NAME(0):eval(__T_ITEMS(0)>2)=__T_HEX_REVERSE_2(0):__T_HEX_REVERSE_1(0):$1,{__TOKEN_PUSHS:1=0x0000:0x0000:__TOKEN_DLT},{__SET_TOKEN(__TOKEN_PUSHS,__T_INFO(0){ 2drop},__DROP_2_PAR(__T_ARRAY(0))){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_D0LT},{0. }$2)},

__T_NAME(0):__T_ITEMS(0):$1,                                                    __TOKEN_PUSHS:2:__TOKEN_DEQ,                 {__SET_TOKEN({__TOKEN_PUSH2_DEQ}, __T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                                    __TOKEN_PUSHS:2:__TOKEN_DNE,                 {__SET_TOKEN({__TOKEN_PUSH2_DNE}, __T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                                    __TOKEN_PUSHS:2:__TOKEN_DLT,                 {__SET_TOKEN({__TOKEN_PUSH2_DLT}, __T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                                    __TOKEN_PUSHS:2:__TOKEN_DGT,                 {__SET_TOKEN({__TOKEN_PUSH2_DGT}, __T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                                    __TOKEN_PUSHS:2:__TOKEN_DLE,                 {__SET_TOKEN({__TOKEN_PUSH2_DLE}, __T_INFO(0){ }$2,__T_ARRAY(0))},
__T_NAME(0):__T_ITEMS(0):$1,                                                    __TOKEN_PUSHS:2:__TOKEN_DGE,                 {__SET_TOKEN({__TOKEN_PUSH2_DGE}, __T_INFO(0){ }$2,__T_ARRAY(0))},

__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                            __TOKEN_PUSHS:1:__TOKEN_DEQ,                 {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DEQ},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                            __TOKEN_PUSHS:1:__TOKEN_DNE,                 {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DNE},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                            __TOKEN_PUSHS:1:__TOKEN_DLT,                 {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DLT},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                            __TOKEN_PUSHS:1:__TOKEN_DGT,                 {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DGT},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                            __TOKEN_PUSHS:1:__TOKEN_DLE,                 {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DLE},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},
__T_NAME(0):eval(__T_ITEMS(0)>2):$1,                                            __TOKEN_PUSHS:1:__TOKEN_DGE,                 {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_DGE},__T_REVERSE_2(1){ }__T_REVERSE_1(1){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS,__T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},

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
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_OVER:__TOKEN_PD0NE:__TOKEN_NIP},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_OVER_PD0NE_NIP},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_OVER:__TOKEN_PD0EQ:__TOKEN_NIP},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_OVER_PD0EQ_NIP},__TEMP)},
            __T_NAME(0):$1,                        {__TOKEN_OVER:__TOKEN_ADD},{__SET_TOKEN({__TOKEN_OVER_ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                        {__TOKEN_OVER:__TOKEN_SUB},{__SET_TOKEN({__TOKEN_OVER_SUB},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

dnl # R...
r...,,,
            __T_NAME(0)-$1,{__TOKEN_ROT-__TOKEN_DROP},{__SET_TOKEN({__TOKEN_ROT_DROP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_ROT-__TOKEN_ROT},{__SET_TOKEN({__TOKEN_NROT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_ROT_DROP-__TOKEN_SWAP},{__SET_TOKEN({__TOKEN_NROT_NIP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1:$#,{__TOKEN_R_FETCH-__TOKEN_PUSH},{__SET_TOKEN({__TOKEN_R_FETCH_PUSH},__T_INFO(0){ }$2,$3)},
            __T_NAME(0)-$1,{__TOKEN_ROT-__TOKEN_ADD},{__SET_TOKEN({__TOKEN_ROT_ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_ROT-__TOKEN_SUB},{__SET_TOKEN({__TOKEN_ROT_SUB},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT:__TOKEN_1ADD:__TOKEN_NROT},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1ADD_NROT},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT:__TOKEN_1SUB:__TOKEN_NROT},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1SUB_NROT},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT:__TOKEN_2ADD:__TOKEN_NROT},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_2ADD_NROT},__TEMP)},
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT:__TOKEN_2SUB:__TOKEN_NROT},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_2SUB_NROT},__TEMP)},

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

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_OVER:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_OVER_STORE_1ADD}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__SET_TOKEN({__TOKEN_1SUB},__dtto)},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_OVER:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                    {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_OVER_CSTORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},
            __T_NAME(0):$1,                         __TOKEN_PUSH_OVER:__TOKEN_STORE,                                        {__SET_TOKEN({__TOKEN_PUSH_OVER_STORE_1ADD},__T_INFO(0){ }$2,__T_ARRAY(0)){}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_1SUB},__dtto)},
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

            __T_NAME(0):$1,                         __TOKEN_2DUP:__TOKEN_STORE,                                             {__SET_TOKEN({__TOKEN_2DUP_STORE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                         __TOKEN_2DUP:__TOKEN_CSTORE,                                            {__SET_TOKEN({__TOKEN_2DUP_CSTORE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                         __TOKEN_2DUP:__TOKEN_HSTORE,                                            {__SET_TOKEN({__TOKEN_2DUP_HSTORE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(2):__T_NAME(1)=__T_LAST_1_PAR(1):__T_NAME(0):$1,
               __TOKEN_OVER:__TOKEN_PUSH_RSHIFT=8:__TOKEN_OVER:__TOKEN_CSTORE,
                  {__SET_TOKEN_X(eval(__COUNT_TOKEN-2),{__TOKEN_2DUP_HSTORE},__CONCATENATE_WITH({ },__T_INFO(2),__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__DELETE_LAST_TOKEN},

            __T_NAME(0):$1,                         __TOKEN_2DUP_STORE:__TOKEN_2ADD,                                        {__SET_TOKEN({__TOKEN_2DUP_STORE_2ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_OVER_SWAP:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_STORE_1ADD}, __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_DROP},$2)},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_OVER_SWAP:__TOKEN_2DUP_CSTORE:__TOKEN_2DROP,                    {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_CSTORE},     __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_DROP},$2)},
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_OVER_SWAP:__TOKEN_2DUP_HSTORE:__TOKEN_2DROP,                    {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2DUP_HSTORE},     __CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_DROP},$2)},
            __T_NAME(0):$1,                         __TOKEN_OVER_SWAP:__TOKEN_STORE,                                        {__SET_TOKEN({__TOKEN_OVER_SWAP_STORE}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                         __TOKEN_OVER_SWAP:__TOKEN_CSTORE,                                       {__SET_TOKEN({__TOKEN_OVER_SWAP_CSTORE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,                         __TOKEN_OVER_SWAP:__TOKEN_HSTORE,                                       {__SET_TOKEN({__TOKEN_OVER_SWAP_HSTORE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

0 pick !,,,
dup !,,,
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_DUP:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_DUP_DUP_STORE_1ADD},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_DROP},__dtto)},

1 pick !,,,
over !,,,
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_OVER:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                     {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_OVER_STORE_1ADD},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__SET_TOKEN({__TOKEN_1SUB},__dtto)},

2 pick !,,,
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_2_PICK:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_2_PICK_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},

3 pick !,,,
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_3_PICK:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                   {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_3_PICK_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},

num pick !,,,
            __T_NAME(1):__T_NAME(0):$1,             __TOKEN_PUSH_PICK:__TOKEN_2DUP_STORE_1ADD:__TOKEN_2DROP,                {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_PUSH_PICK_STORE},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2),__T_ARRAY(1)){}__DELETE_LAST_TOKEN},


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
            __T_NAME(0):$1,                         __TOKEN_TUCK_STORE:__TOKEN_2ADD,                                        {__SET_TOKEN({__TOKEN_TUCK_STORE_2ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

dnl # S...
s...,,,

            __T_NAME(0):$1,{__TOKEN_2DUP_STORE:__TOKEN_1ADD}, {__SET_TOKEN({__TOKEN_2DUP_STORE_1ADD}, __CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_CSTORE:__TOKEN_1ADD},{__SET_TOKEN({__TOKEN_2DUP_CSTORE_1ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):$1,{__TOKEN_2DUP_HSTORE:__TOKEN_1ADD},{__SET_TOKEN({__TOKEN_2DUP_HSTORE_1ADD},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1, {__TOKEN_SPACE-__TOKEN_DOT},  {__SET_TOKEN({__TOKEN_SPACE_DOT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1, {__TOKEN_SPACE-__TOKEN_UDOT}, {__SET_TOKEN({__TOKEN_SPACE_UDOT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1, {__TOKEN_SPACE-__TOKEN_DDOT}, {__SET_TOKEN({__TOKEN_SPACE_DDOT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1, {__TOKEN_SPACE-__TOKEN_UDDOT},{__SET_TOKEN({__TOKEN_SPACE_UDDOT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_IF},{__SET_TOKEN({__TOKEN_SWAP_IF},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_DROP},{__SET_TOKEN({__TOKEN_NIP},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_EQ},{__SET_TOKEN({__TOKEN_EQ},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_NE},{__SET_TOKEN({__TOKEN_NE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_LT},{__SET_TOKEN({__TOKEN_GT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_GT},{__SET_TOKEN({__TOKEN_LT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_LE},{__SET_TOKEN({__TOKEN_GE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_GE},{__SET_TOKEN({__TOKEN_LE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_ULT},{__SET_TOKEN({__TOKEN_UGT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_UGT},{__SET_TOKEN({__TOKEN_ULT},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_ULE},{__SET_TOKEN({__TOKEN_UGE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_UGE},{__SET_TOKEN({__TOKEN_ULE},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_OVER},{__SET_TOKEN({__TOKEN_TUCK},__CONCATENATE_WITH({ },__T_INFO(0),$2))},

            __T_NAME(1):__T_NAME(0):$1,  __TOKEN_SWAP:__TOKEN_1ADD:__TOKEN_SWAP,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_SWAP_1ADD_SWAP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,  __TOKEN_SWAP:__TOKEN_2ADD:__TOKEN_SWAP,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_SWAP_2ADD_SWAP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,  __TOKEN_SWAP:__TOKEN_1SUB:__TOKEN_SWAP,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_SWAP_1SUB_SWAP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},
            __T_NAME(1):__T_NAME(0):$1,  __TOKEN_SWAP:__TOKEN_2SUB:__TOKEN_SWAP,  {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_SWAP_2SUB_SWAP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN},

            __T_NAME(0)-$1,{__TOKEN_SWAP-__TOKEN_PDSUB},{__SET_TOKEN({__TOKEN_SWAP_PDSUB},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
dnl # T...
t...,,,


dnl # U...
u...,,,
            __T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_PUSHS:1:__TOKEN_UNPACK,                    {__SET_TOKEN({__TOKEN_PUSH_UNPACK},   __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):__T_ITEMS(0):$1,            __TOKEN_PUSHS:2:__TOKEN_UNPACK,                    {__SET_TOKEN({__TOKEN_PUSH2_UNPACK},  __CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0))},
            __T_NAME(0):eval(__T_ITEMS(0)>2):$1,    __TOKEN_PUSHS:1:__TOKEN_UNPACK, {__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH2_UNPACK},__REMOVE_COMMA(__T_LAST_2_PAR(1)){ }$2,__T_LAST_2_PAR(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ 2drop},__DROP_2_PAR(__T_ARRAY(1)))},

dnl # V...
dnl # W...
w...,,,
            __T_NAME(1):__T_NAME(0):$1,{__TOKEN_ROT_1ADD_NROT_2OVER_NIP:__TOKEN_CFETCH_0CNE:__TOKEN_WHILE},{define({__TEMP},__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0),$2)){}__DELETE_LAST_TOKEN{}__SET_TOKEN({__TOKEN_ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE},__TEMP)},

dnl # X...
dnl # Y...
dnl # Z...
z,,,

            __T_NAME(0):$1,              __TOKEN_ZPUSH:__TOKEN_ZPUSH,               {__SET_TOKEN({__TOKEN_ZPUSH},__CONCATENATE_WITH({ },__T_INFO(0),$2),__T_ARRAY(0),shift(shift($@)))},

            __T_NAME(0):$1,              __TOKEN_DUP:__TOKEN_ZX_BORDER,             {__SET_TOKEN({__TOKEN_DUP_ZX_BORDER},__CONCATENATE_WITH({ },__T_INFO(0),$2))},
            __T_NAME(0):__T_ITEMS(0):$1, __TOKEN_PUSHS:1:__TOKEN_ZX_BORDER,         {__SET_TOKEN({__TOKEN_PUSH_ZX_BORDER},__T_INFO(0){ }$2,__T_ARRAY(0))},
            __T_NAME(0):eval(__T_ITEMS(0)>1):$1, __TOKEN_PUSHS:1:__TOKEN_ZX_BORDER, {dnl
__{}ifelse(__T_REVERSE_1(1),__T_REVERSE_2(1),{dnl
__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_DUP_ZX_BORDER},__T_REVERSE_1(1){ }$2,__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ drop},__DROP_1_PAR(__T_ARRAY(1)))},
__{}{dnl
__{}__{}__INC_TOKEN_COUNT{}__SET_TOKEN({__TOKEN_PUSH_ZX_BORDER},__T_REVERSE_1(1){ }$2,__T_REVERSE_1(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSHS, __T_INFO(1){ drop},__DROP_1_PAR(__T_ARRAY(1)))})},



        {dnl
__{}__{}__{}__INC_TOKEN_COUNT{}dnl
__{}__{}__{}ifelse($1,__TOKEN_LOOP,{__SET_LOOP_STEP($3,1)}){}dnl
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
dnl # param second only
define({__SET_CHECK_TOKEN}, {__SET_TOKEN($1,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),__T_ARRAY(0)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_NOPE})}){}dnl
dnl # param first only
define({__SET_CHECK_TOKEN2},{__SET_TOKEN($1,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),__T_ARRAY(1)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_NOPE})}){}dnl
dnl # param both
define({__SET_CHECK_TOKEN3},{__SET_TOKEN($1,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),__T_ARRAY(1),__T_ARRAY(0)){}__SET_TOKEN_X(eval(__COUNT_TOKEN-1),{__TOKEN_NOPE})}){}dnl
dnl
dnl
dnl
dnl # xxx + pushs = xxx_pushs ( after all pushs + xxx = pushs_xxx rule is done )
define({__CHECK_TOKEN},{ifelse(dnl
__T_NAME(1):__T_NAME(0),                     __TOKEN_DROP:__TOKEN_SWAP,              {__SET_CHECK_TOKEN(__TOKEN_DROP_SWAP)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_2SWAP:__TOKEN_2OVER_DADD,       {__SET_CHECK_TOKEN(__TOKEN_2SWAP_2OVER_DADD)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2OVER_DADD:__TOKEN_2SWAP,       {__SET_CHECK_TOKEN(__TOKEN_2OVER_DADD_2SWAP)},

__T_NAME(1):__T_NAME(0):__T_ITEMS(0),        __TOKEN_I:__TOKEN_PUSHS:1,                    {__SET_CHECK_TOKEN3(__TOKEN_I_PUSH)},
__T_NAME(1):__T_NAME(0):__T_ITEMS(0),        __TOKEN_J:__TOKEN_PUSHS:1,                    {__SET_CHECK_TOKEN3(__TOKEN_J_PUSH)},
__T_NAME(1):__T_NAME(0):__T_ITEMS(0),        __TOKEN_K:__TOKEN_PUSHS:1,                    {__SET_CHECK_TOKEN3(__TOKEN_K_PUSH)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_I:__TOKEN_PUSH_ADD,                   {__SET_CHECK_TOKEN3(__TOKEN_I_PUSH_ADD)},

__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_ADD:0x0002,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_1ADD,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0))){}__SET_TOKEN(__TOKEN_DUP_ADD,__dtto)},
__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_SUB:0x0002,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_1SUB,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0))){}__SET_TOKEN(__TOKEN_DUP_ADD,__dtto)},
__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_ADD:0x0003,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_1ADD,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0))){}__SET_TOKEN(__TOKEN_DUP_ADD_1ADD,__dtto)},
__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_SUB:0x0003,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_1SUB,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0))){}__SET_TOKEN(__TOKEN_DUP_ADD_1SUB,__dtto)},
__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_ADD:0x0004,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_ADD,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),2){}__SET_TOKEN(__TOKEN_DUP_ADD,__dtto)},
__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_SUB:0x0004,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_SUB,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),2){}__SET_TOKEN(__TOKEN_DUP_ADD,__dtto)},
__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_ADD:0x0005,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_ADD,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),2){}__SET_TOKEN(__TOKEN_DUP_ADD_1ADD,__dtto)},
__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_SUB:0x0005,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_SUB,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),2){}__SET_TOKEN(__TOKEN_DUP_ADD_1SUB,__dtto)},
__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_ADD:0x0006,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_ADD,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),3){}__SET_TOKEN(__TOKEN_DUP_ADD,__dtto)},
__T_NAME(1):__T_NAME(0):__T_HEX_1(0),        __TOKEN_DUP_ADD:__TOKEN_PUSH_SUB:0x0006,      {__SET_TOKEN_X(eval(__COUNT_TOKEN-1),__TOKEN_PUSH_SUB,__CONCATENATE_WITH({ },__T_INFO(1),__T_INFO(0)),3){}__SET_TOKEN(__TOKEN_DUP_ADD,__dtto)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_GT_IF,     {__SET_CHECK_TOKEN2(__TOKEN_PUSH_GT_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_GE_IF,     {__SET_CHECK_TOKEN2(__TOKEN_PUSH_GE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_LE_IF,     {__SET_CHECK_TOKEN2(__TOKEN_PUSH_LE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_LT_IF,     {__SET_CHECK_TOKEN2(__TOKEN_PUSH_LT_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_UGT_IF,    {__SET_CHECK_TOKEN2(__TOKEN_PUSH_UGT_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_UGE_IF,    {__SET_CHECK_TOKEN2(__TOKEN_PUSH_UGE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_ULE_IF,    {__SET_CHECK_TOKEN2(__TOKEN_PUSH_ULE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_ULT_IF,    {__SET_CHECK_TOKEN2(__TOKEN_PUSH_ULT_IF)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_GT_WHILE,  {__SET_CHECK_TOKEN2(__TOKEN_PUSH_GT_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_GE_WHILE,  {__SET_CHECK_TOKEN2(__TOKEN_PUSH_GE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_LE_WHILE,  {__SET_CHECK_TOKEN2(__TOKEN_PUSH_LE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_LT_WHILE,  {__SET_CHECK_TOKEN2(__TOKEN_PUSH_LT_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_UGT_WHILE, {__SET_CHECK_TOKEN2(__TOKEN_PUSH_UGT_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_UGE_WHILE, {__SET_CHECK_TOKEN2(__TOKEN_PUSH_UGE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_ULE_WHILE, {__SET_CHECK_TOKEN2(__TOKEN_PUSH_ULE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_ULT_WHILE, {__SET_CHECK_TOKEN2(__TOKEN_PUSH_ULT_WHILE)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_GT_UNTIL,  {__SET_CHECK_TOKEN2(__TOKEN_PUSH_GT_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_GE_UNTIL,  {__SET_CHECK_TOKEN2(__TOKEN_PUSH_GE_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_LE_UNTIL,  {__SET_CHECK_TOKEN2(__TOKEN_PUSH_LE_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_LT_UNTIL,  {__SET_CHECK_TOKEN2(__TOKEN_PUSH_LT_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_UGT_UNTIL, {__SET_CHECK_TOKEN2(__TOKEN_PUSH_UGT_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_UGE_UNTIL, {__SET_CHECK_TOKEN2(__TOKEN_PUSH_UGE_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_ULE_UNTIL, {__SET_CHECK_TOKEN2(__TOKEN_PUSH_ULE_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),                     __TOKEN_PUSHS:1:__TOKEN_ULT_UNTIL, {__SET_CHECK_TOKEN2(__TOKEN_PUSH_ULT_UNTIL)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_FETCH,         {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_FETCH)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_FETCH:__TOKEN_ADD,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_FETCH_ADD)},


__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_FETCH_1ADD,    {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_FETCH_1ADD)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_FETCH_2ADD,    {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_FETCH_2ADD)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_I:__TOKEN_ADD,              {__SET_CHECK_TOKEN2(__TOKEN_DUP_I_ADD)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_J:__TOKEN_ADD,              {__SET_CHECK_TOKEN2(__TOKEN_DUP_J_ADD)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_K:__TOKEN_ADD,              {__SET_CHECK_TOKEN2(__TOKEN_DUP_K_ADD)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_EQ,            {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_EQ)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_NE,            {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_NE)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_EQ:__TOKEN_UNTIL,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_EQ_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_NE:__TOKEN_UNTIL,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_NE_UNTIL)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_EQ_WHILE,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_EQ_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_NE_WHILE,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_NE_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_LT_WHILE,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_LT_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_GT_WHILE,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_GT_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_LE_WHILE,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_LE_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_GE_WHILE,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_GE_WHILE)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_EQ_UNTIL,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_EQ_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_NE_UNTIL,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_NE_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_LT_UNTIL,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_LT_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_GT_UNTIL,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_GT_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_LE_UNTIL,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_LE_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP:__TOKEN_PUSH_GE_UNTIL,      {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_GE_UNTIL)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_EQ:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_EQ_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_DUP_PUSH_NE:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_NE_IF)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP:__TOKEN_PUSH2_DEQ,         {__SET_CHECK_TOKEN(__TOKEN_2DUP_PUSH2_DEQ)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP:__TOKEN_PUSH2_DNE,         {__SET_CHECK_TOKEN(__TOKEN_2DUP_PUSH2_DNE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP:__TOKEN_PUSH2_DLT,         {__SET_CHECK_TOKEN(__TOKEN_2DUP_PUSH2_DLT)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP:__TOKEN_PUSH2_DGT,         {__SET_CHECK_TOKEN(__TOKEN_2DUP_PUSH2_DGT)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP:__TOKEN_PUSH2_DLE,         {__SET_CHECK_TOKEN(__TOKEN_2DUP_PUSH2_DLE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP:__TOKEN_PUSH2_DGE,         {__SET_CHECK_TOKEN(__TOKEN_2DUP_PUSH2_DGE)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DEQ:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DEQ_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DNE:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DNE_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DLT:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DLT_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DGT:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DGT_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DLE:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DLE_IF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DGE:__TOKEN_IF,         {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DGE_IF)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DLT:__TOKEN_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DLT_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DGT:__TOKEN_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DGT_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DLE:__TOKEN_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DLE_WHILE)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DGE:__TOKEN_WHILE,      {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DGE_WHILE)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DLT:__TOKEN_UNTIL,      {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DLT_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DGT:__TOKEN_UNTIL,      {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DGT_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DLE:__TOKEN_UNTIL,      {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DLE_UNTIL)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_2DUP_PUSH2_DGE:__TOKEN_UNTIL,      {__SET_CHECK_TOKEN2(__TOKEN_2DUP_PUSH2_DGE_UNTIL)},

__T_NAME(1):__T_NAME(0):__T_ITEMS(0),        __TOKEN_PUSH_PORTFETCH:__TOKEN_PUSHS:1,    {__SET_CHECK_TOKEN3(__TOKEN_PUSH_PORTFETCH_PUSH)},

__T_NAME(1):__T_NAME(0),                     __TOKEN_PUSH_PORTFETCH:__TOKEN_PUSH_OR,          {__SET_CHECK_TOKEN3(__TOKEN_PUSH_PORTFETCH_PUSH_OR)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_PUSH_PORTFETCH_PUSH:__TOKEN_OR,          {__SET_CHECK_TOKEN2(__TOKEN_PUSH_PORTFETCH_PUSH_OR)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_PUSH_PORTFETCH_PUSH_OR:__TOKEN_1CADD_ZF, {__SET_CHECK_TOKEN2(__TOKEN_PUSH_PORTFETCH_PUSH_COR_1CADD_ZF)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_PUSH_PORTFETCH_PUSH:__TOKEN_COR_1CADD_ZF,{__SET_CHECK_TOKEN2(__TOKEN_PUSH_PORTFETCH_PUSH_COR_1CADD_ZF)},


__T_NAME(1):__T_NAME(0),                     __TOKEN_PUSH_PORTFETCH:__TOKEN_PUSH_AND,   {__SET_CHECK_TOKEN3(__TOKEN_PUSH_PORTFETCH_PUSH_AND)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_PUSH_PORTFETCH_PUSH:__TOKEN_AND,   {__SET_CHECK_TOKEN2(__TOKEN_PUSH_PORTFETCH_PUSH_AND)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_PUSH_PORTFETCH_PUSH:__TOKEN_AND_ZF,{__SET_CHECK_TOKEN2(__TOKEN_PUSH_PORTFETCH_PUSH_AND_ZF)},


__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_PUSHS:1:__TOKEN_IF,              {__SET_CHECK_TOKEN2(__TOKEN_PUSH_IF)},

__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEY:__TOKEN_IF,                 {__SET_CHECK_TOKEN2(__TOKEN_TESTKEY_IF)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEY:__TOKEN_IF,            {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEY_IF)},
__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEY_0EQ:__TOKEN_IF,             {__SET_CHECK_TOKEN2(__TOKEN_TESTKEY_0EQ_IF)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEY_0EQ:__TOKEN_IF,        {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEY_0EQ_IF)},

__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEMPSTON:__TOKEN_IF,            {__SET_CHECK_TOKEN2(__TOKEN_TESTKEMPSTON_IF)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEMPSTON:__TOKEN_IF,       {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEMPSTON_IF)},
__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEMPSTON:__TOKEN_0EQ_IF,        {__SET_CHECK_TOKEN2(__TOKEN_TESTKEMPSTON_0EQ_IF)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEMPSTON:__TOKEN_0EQ_IF,   {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEMPSTON_0EQ_IF)},

__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEY:__TOKEN_WHILE,              {__SET_CHECK_TOKEN2(__TOKEN_TESTKEY_WHILE)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEY:__TOKEN_WHILE,         {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEY_WHILE)},
__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEY_0EQ:__TOKEN_WHILE,          {__SET_CHECK_TOKEN2(__TOKEN_TESTKEY_0EQ_WHILE)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEY_0EQ:__TOKEN_WHILE,     {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEY_0EQ_WHILE)},

__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEMPSTON:__TOKEN_WHILE,         {__SET_CHECK_TOKEN2(__TOKEN_TESTKEMPSTON_WHILE)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEMPSTON:__TOKEN_WHILE,    {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEMPSTON_WHILE)},
__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEMPSTON_0EQ:__TOKEN_WHILE,     {__SET_CHECK_TOKEN2(__TOKEN_TESTKEMPSTON_0EQ_WHILE)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEMPSTON_0EQ:__TOKEN_WHILE,{__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEMPSTON_0EQ_WHILE)},

__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEY:__TOKEN_UNTIL,              {__SET_CHECK_TOKEN2(__TOKEN_TESTKEY_UNTIL)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEY:__TOKEN_UNTIL,         {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEY_UNTIL)},
__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEY_0EQ:__TOKEN_UNTIL,          {__SET_CHECK_TOKEN2(__TOKEN_TESTKEY_0EQ_UNTIL)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEY_0EQ:__TOKEN_UNTIL,     {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEY_0EQ_UNTIL)},

__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEMPSTON:__TOKEN_UNTIL,         {__SET_CHECK_TOKEN2(__TOKEN_TESTKEMPSTON_UNTIL)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEMPSTON:__TOKEN_UNTIL,    {__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEMPSTON_UNTIL)},
__T_NAME(1):__T_NAME(0),        __TOKEN_TESTKEMPSTON_0EQ:__TOKEN_UNTIL,     {__SET_CHECK_TOKEN2(__TOKEN_TESTKEMPSTON_0EQ_UNTIL)},
__T_NAME(1):__T_NAME(0),        __TOKEN_PUSH_TESTKEMPSTON_0EQ:__TOKEN_UNTIL,{__SET_CHECK_TOKEN2(__TOKEN_PUSH_TESTKEMPSTON_0EQ_UNTIL)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LT_IF,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LT_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LE_IF,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GE_IF,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GT_IF,      {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GT_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULT_IF,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULT_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULE_IF,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGE_IF,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGE_IF)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGT_IF,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGT_IF)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LT_WHILE,   {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LT_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LE_WHILE,   {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GE_WHILE,   {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GT_WHILE,   {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GT_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULT_WHILE,  {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULT_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULE_WHILE,  {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGE_WHILE,  {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGE_WHILE)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGT_WHILE,  {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGT_WHILE)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LT_UNTIL,   {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LT_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_LE_UNTIL,   {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_LE_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GE_UNTIL,   {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GE_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_GT_UNTIL,   {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_GT_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULT_UNTIL,  {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULT_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_ULE_UNTIL,  {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_ULE_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGE_UNTIL,  {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGE_UNTIL)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_UGT_UNTIL,  {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_UGT_UNTIL)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_CEQ,        {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_CEQ)},
__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_HEQ,        {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_HEQ)},

__T_NAME(1):__T_ITEMS(1):__T_NAME(0),  __TOKEN_DUP_PUSHS:1:__TOKEN_CNE,        {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_CNE)},

__T_NAME(1):__T_NAME(0),               __TOKEN_DUP_PUSH_CEQ:__TOKEN_UNTIL,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_CEQ_UNTIL)},
__T_NAME(1):__T_NAME(0),               __TOKEN_DUP_PUSH_HEQ:__TOKEN_UNTIL,     {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_HEQ_UNTIL)},
__T_NAME(1):__T_NAME(0),               __TOKEN_DUP:__TOKEN_PUSH_CNE,           {__SET_CHECK_TOKEN(__TOKEN_DUP_PUSH_CNE)},

__T_NAME(1):__T_NAME(0),               __TOKEN_DUP_PUSH_CEQ:__TOKEN_IF,        {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_CEQ_IF)},
__T_NAME(1):__T_NAME(0),               __TOKEN_DUP_PUSH_CNE:__TOKEN_IF,        {__SET_CHECK_TOKEN2(__TOKEN_DUP_PUSH_CNE_IF)},

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

__T_NAME(1):__T_NAME(0),                                         __TOKEN_NIP_PUSH_SWAP:__TOKEN_PUSH_SWAP,{__SET_CHECK_TOKEN3(__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0),                               __TOKEN_NIP_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,{__SET_CHECK_TOKEN3(__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,{__SET_CHECK_TOKEN3(__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0),           __TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,{__SET_CHECK_TOKEN3(__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0), __TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,{__SET_CHECK_TOKEN3(__TOKEN_NIP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},

__T_NAME(1):__T_NAME(0),                                         __TOKEN_PUSH_SWAP:__TOKEN_PUSH_SWAP,    {__SET_CHECK_TOKEN3(__TOKEN_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0),                               __TOKEN_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,    {__SET_CHECK_TOKEN3(__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0),                     __TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,    {__SET_CHECK_TOKEN3(__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0),           __TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,    {__SET_CHECK_TOKEN3(__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},
__T_NAME(1):__T_NAME(0), __TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP:__TOKEN_PUSH_SWAP,    {__SET_CHECK_TOKEN3(__TOKEN_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP_PUSH_SWAP)},

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
__{}$0_REC{}dnl
}){}dnl
dnl
dnl
dnl
define({__CHECK_ALL_TOKENS2_REC},{dnl
__{}ifelse(dnl
__{}__T_NAME(0),__TOKEN_2DUP_FILL_2DIRTY,{dnl
__{}__{}__def({USE_Fill_Over}){}dnl
__{}__{}__def({USE_Fill_Unknown_Addr}){}dnl
__{}},
__{}__T_NAME(0),__TOKEN_2DUP_PUSH_FILL_2DIRTY,{dnl
__{}__{}__def({USE_Fill_Over}){}dnl
__{}__{}__def({USE_Fill_Unknown_Addr}){}dnl
__{}},
__{}__T_NAME(0),__TOKEN_DUP_PUSH2_FILL_DIRTY,{dnl
__{}__{}ifelse(__HEX_L(__T_HEX_REVERSE_2(0)0>0x8000),0x01,{__def({USE_Fill_Over})}){}dnl
__{}__{}ifelse(
        __T_HEX_REVERSE_2(0),0x0000,,
        __T_HEX_REVERSE_2(0),0x0001,,
        __T_HEX_REVERSE_2(0),0x0002,,
        __T_HEX_REVERSE_2(0),0x0003,,
        __T_HEX_REVERSE_2(0),0x0004,,
        __T_HEX_REVERSE_2(0),0x0005,,
        {__def({USE_Fill_Unknown_Addr})})},
__{}__T_NAME(0),__TOKEN_PUSH3_FILL,{dnl
__{}__{}ifelse(__HEX_L(__T_HEX_REVERSE_2(0)0>0x8000),0x01,{__def({USE_Fill_Over})}){}dnl
__{}__{}ifelse(__IS_MEM_REF(__T_REVERSE_3(0)),1,{__def({USE_Fill_Unknown_Addr})}){}dnl
__{}}){}dnl
__{}ifelse(eval(__COUNT_TOKEN<__SUM_TOKEN),1,{dnl
__{}__{}define({__COUNT_TOKEN},eval(__COUNT_TOKEN+1)){}dnl
__{}__{}$0{}dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({__CHECK_ALL_TOKENS2},{dnl
__{}ifelse(eval(__COUNT_TOKEN>0),1,{dnl
__{}__{}define({__SUM_TOKEN},__COUNT_TOKEN){}dnl
__{}__{}define({__COUNT_TOKEN},1){}dnl
__{}__{}$0_REC{}dnl
__{}}){}dnl
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
__{}ifelse(__GET_TOKEN_INFO(__TOKEN_I),{__dtto},,{define({__COMPILE_INFO},__GET_TOKEN_INFO(__TOKEN_I))}){}dnl
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
__{}__CHECK_ALL_TOKENS2{}dnl
__{}define({__TOKEN_I},0)dnl
__{}$0_REC{}dnl
})}){}dnl
dnl
dnl
dnl
dnl
