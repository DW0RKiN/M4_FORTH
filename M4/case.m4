dnl ## n Case n1 Of .. EndOf n2 Of .. EndOf default EndCase
define({__},{})dnl
dnl
dnl
dnl --------- case of endof endcase ------------
dnl # ( n -- n )
dnl # CASE
dnl #   n1 OF ( n -- ) code1 ENDOF
dnl #   n2 OF ( n -- ) code2 ENDOF
dnl #   ...
dnl #   ( n -- n ) default-code ( n -- n )
dnl # ENDCASE ( -- )
dnl
dnl Pokud žádné ni neodpovídá, provede se volitelný výchozí kód .
dnl Volitelný výchozí případ lze přidat jednoduchým napsáním kódu za poslední ENDOF.
dnl Může použít n , které je na vrcholu zásobníku, ale nesmí ho spotřebovat.
dnl Hodnota n je odstraněna touto konstrukcí (buď odpovídající OF, nebo ENDCASE, pokud se žádný OF neshoduje).
dnl
dnl
define(CASE_COUNT,100)dnl
define(LASTOF_STACK,100000)dnl
dnl
dnl
dnl # Non standard CASE: ( n -- n )
dnl # CASE
dnl #   OF code1 ENDOF
dnl #   OF code2 ENDOF
dnl #   ...
dnl #       default-code
dnl # ENDCASE
dnl
dnl # Compatibility with standard CASE: ( n -- )
dnl # CASE
dnl #   OF DROP code1 ENDOF
dnl #   OF DROP code2 ENDOF
dnl #   ...
dnl #       default-code
dnl #   DROP
dnl # ENDCASE ( n -- )
dnl
define({CASE},{define({CASE_COUNT}, incr(CASE_COUNT))pushdef({CASE_STACK}, CASE_COUNT)pushdef({LASTOF_STACK}, LASTOF_STACK)define({LASTOF_STACK},CASE_COUNT{000})
;   v---v---v case CASE_STACK v---v---v
                        ;           case CASE_STACK{}dnl
})dnl
dnl
dnl
define({_OF_INFO},{$1 eval(OF_STACK % 1000) from $2{}case CASE_STACK})dnl
dnl
dnl
dnl ( b a -- b a )
define({OF},{define({LASTOF_STACK}, incr(LASTOF_STACK))pushdef({OF_STACK}, LASTOF_STACK)ifelse($#,{0},,{
.error 'of': Unexpected parameter $@, 'of' uses a parameter eval(OF_STACK % 1000) from the stack!})
                        ;[8:44]     _OF_INFO(of)
    xor   A             ; 1:4       _OF_INFO(of)
    sbc  HL, DE         ; 2:15      _OF_INFO(of)
    pop HL              ; 1:11      _OF_INFO(of)
    ex   DE, HL         ; 1:4       _OF_INFO(of)
    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(of){}dnl
})dnl
dnl
dnl
dnl ( b a -- b a )
define({ZERO_OF},{define({LASTOF_STACK}, incr(LASTOF_STACK))pushdef({OF_STACK}, LASTOF_STACK)ifelse($#,{0},,{
.error 'of': Unexpected parameter $@, 'of' uses a parameter eval(OF_STACK % 1000) from the stack!})
                        ;[5:18]     _OF_INFO(zero_of)   version: zero check
    ld    A, H          ; 1:4       _OF_INFO(zero_of)
    or    L             ; 1:4       _OF_INFO(zero_of)
    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(zero_of){}dnl
})dnl
dnl
dnl
dnl ( a -- a )
define({PUSH_OF},{define({LASTOF_STACK}, incr(LASTOF_STACK))pushdef({OF_STACK}, LASTOF_STACK)ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}                        ;[13:52]    _OF_INFO(push_of($1))   version: variable in memory
__{}    ld    A, (format({%-10s},substr($1,1,eval(len($1)-2)){+1)}); 3:13      _OF_INFO(push_of($1))
__{}    xor   H             ; 1:4       _OF_INFO(push_of($1))
__{}    ld    B, A          ; 1:4       _OF_INFO(push_of($1))
__{}    ld    A, format({%-11s},$1); 3:13      _OF_INFO(push_of($1))
__{}    xor   L             ; 1:4       _OF_INFO(push_of($1))
__{}    or    B             ; 1:4       _OF_INFO(push_of($1))
__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(push_of($1))},
__{}eval($1),{0},{dnl
__{}                        ;[5:18]     _OF_INFO(push_of($1))   version: $1 = 0
__{}    ld    A, H          ; 1:4       _OF_INFO(push_of($1))
__{}    or    L             ; 1:4       _OF_INFO(push_of($1))
__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(push_of($1))},
__{}eval((($1) & 255)^(($1)/256)),{0},{dnl
__{}                        ;[10:37]    _OF_INFO(push_of($1))   version: hi($1) = lo($1) = eval(($1)/256)
__{}    ld    A, low format({%-7s},$1); 2:7       _OF_INFO(push_of($1))
__{}    xor   H             ; 1:4       _OF_INFO(push_of($1))
__{}    ld    B, A          ; 1:4       _OF_INFO(push_of($1))
__{}    xor   H             ; 1:4       _OF_INFO(push_of($1))
__{}    xor   L             ; 1:4       _OF_INFO(push_of($1))
__{}    or    B             ; 1:4       _OF_INFO(push_of($1))
__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(push_of($1))},
__{}eval(($1)/256),{0},{dnl
__{}                        ;[7:25]     _OF_INFO(push_of($1))   version: hi($1) = 0
__{}    ld    A, low format({%-7s},$1); 2:7       _OF_INFO(push_of($1))
__{}    xor   L             ; 1:4       _OF_INFO(push_of($1))
__{}    or    H             ; 1:4       _OF_INFO(push_of($1))
__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(push_of($1))},
__{}eval(($1) & 255),{0},{dnl
__{}                        ;[7:25]     _OF_INFO(push_of($1))   version: lo($1) = 0
__{}    ld    A, high format({%-6s},$1); 2:7       _OF_INFO(push_of($1))
__{}    xor   H             ; 1:4       _OF_INFO(push_of($1))
__{}    or    L             ; 1:4       _OF_INFO(push_of($1))
__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(push_of($1))},
__{}{dnl
__{}                        ;[11:40]    _OF_INFO(push_of($1))   version: default
__{}    ld    A, high format({%-6s},$1); 2:7       _OF_INFO(push_of($1))
__{}    xor   H             ; 1:4       _OF_INFO(push_of($1))
__{}    ld    B, A          ; 1:4       _OF_INFO(push_of($1))
__{}    ld    A, low format({%-7s},$1); 2:7       _OF_INFO(push_of($1))
__{}    xor   L             ; 1:4       _OF_INFO(push_of($1))
__{}    or    B             ; 1:4       _OF_INFO(push_of($1))
__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(push_of($1))}){}dnl
})dnl
dnl
dnl
dnl ( a $1 $2 -- ((a-$1) ($2-$1) U<) )
dnl $1 <= a < $2
define({WITHIN_OF},{define({LASTOF_STACK}, incr(LASTOF_STACK))pushdef({OF_STACK}, LASTOF_STACK)ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}    .error "within_of($1,$2): within_of does not support variable parameters stored in memory."}
__{},index({$2},{(}),{0},{dnl
__{}    .error "within_of($1,$2): within_of does not support variable parameters stored in memory."},
__{}eval($1),{},{dnl
__{}                        ;[17:62]    _OF_INFO(within_of($1),within_)   ( a -- flag=($1<=a<$2) )
__{}    ld    A, L          ; 1:4       _OF_INFO(within_of($1),within_)
__{}    sub   low format({%-10s},$1); 2:7       _OF_INFO(within_of($1),within_)
__{}    ld    C, A          ; 1:4       _OF_INFO(within_of($1),within_)
__{}    ld    A, H          ; 1:4       _OF_INFO(within_of($1),within_)
__{}    sbc   A, high format({%-6s},$1); 2:7       _OF_INFO(within_of($1),within_)
__{}    ld    B, A          ; 1:4       _OF_INFO(within_of($1),within_)   BC = a - {{$1}}
__{}    ld    A, C          ; 1:4       _OF_INFO(within_of($1),within_)
__{}    sub  low format({%-11s},$2-($1)); 2:7       _OF_INFO(within_of($1),within_)
__{}    ld    A, B          ; 1:4       _OF_INFO(within_of($1),within_)
__{}    sbc   A, high format({%-6s},$2-($1)); 2:7       _OF_INFO(within_of($1),within_)   carry:(a - {{$1}}) - ($2 - {{$1}}
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(within_of($1),within_)},
__{}eval($1),{0},{dnl
__{}                        ;[9:32]     _OF_INFO(within_of($1),within_)   ( a -- flag=($1<=a<$2) ) variant: 0,x
__{}    ld    A, L          ; 1:4       _OF_INFO(within_of($1),within_)
__{}    sub  low format({%-11s},$2); 2:7       _OF_INFO(within_of($1),within_)
__{}    ld    A, H          ; 1:4       _OF_INFO(within_of($1),within_)
__{}    sbc   A, high format({%-6s},$2); 2:7       _OF_INFO(within_of($1),within_)   carry:(a - {{$1}}) - ($2 - {{$1}}
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(within_of($1),within_)},
__{}{dnl
__{}__{}ifelse(eval($1),{1},{dnl
__{}__{}                        ;[12:46]    _OF_INFO(within_of($1),within_)   ( a -- flag=($1<=a<$2) )
__{}__{}    ld    C, L          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    ld    B, H          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    dec  BC             ; 1:6       _OF_INFO(within_of($1),within_)   BC = a - {{$1}}},
__{}__{}eval($1),{-1},{dnl
__{}__{}                        ;[12:46]    _OF_INFO(within_of($1),within_)   ( a -- flag=($1<=a<$2) )
__{}__{}    ld    C, L          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    ld    B, H          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    inc  BC             ; 1:6       _OF_INFO(within_of($1),within_)   BC = a - {{$1}}},
__{}__{}eval($1),{2},{dnl
__{}__{}                        ;[13:52]    _OF_INFO(within_of($1),within_)   ( a -- flag=($1<=a<$2) )
__{}__{}    ld    C, L          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    ld    B, H          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    dec  BC             ; 1:6       _OF_INFO(within_of($1),within_)
__{}__{}    dec  BC             ; 1:6       _OF_INFO(within_of($1),within_)   BC = a - {{$1}}},
__{}__{}eval($1),{-2},{dnl
__{}__{}                        ;[13:52]    _OF_INFO(within_of($1),within_)   ( a -- flag=($1<=a<$2) )
__{}__{}    ld    C, L          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    ld    B, H          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    inc  BC             ; 1:6       _OF_INFO(within_of($1),within_)
__{}__{}    inc  BC             ; 1:6       _OF_INFO(within_of($1),within_)   BC = a - {{$1}}},
__{}__{}eval($1),{3},{dnl
__{}__{}                        ;[14:58]    _OF_INFO(within_of($1),within_)   ( a -- flag=($1<=a<$2) )
__{}__{}    ld    C, L          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    ld    B, H          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    dec  BC             ; 1:6       _OF_INFO(within_of($1),within_)
__{}__{}    dec  BC             ; 1:6       _OF_INFO(within_of($1),within_)
__{}__{}    dec  BC             ; 1:6       _OF_INFO(within_of($1),within_)   BC = a - {{$1}}},
__{}__{}eval($1),{-3},{dnl
__{}__{}                        ;[14:58]    _OF_INFO(within_of($1),within_)   ( a -- flag=($1<=a<$2) )
__{}__{}    ld    C, L          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    ld    B, H          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    inc  BC             ; 1:6       _OF_INFO(within_of($1),within_)
__{}__{}    inc  BC             ; 1:6       _OF_INFO(within_of($1),within_)
__{}__{}    inc  BC             ; 1:6       _OF_INFO(within_of($1),within_)   BC = a - {{$1}}},
__{}__{}{dnl
__{}__{}                        ;[17:62]    _OF_INFO(within_of($1),within_)   ( a -- flag=($1<=a<$2) )
__{}__{}    ld    A, L          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    sub   low format({%-10s},$1); 2:7       _OF_INFO(within_of($1),within_)
__{}__{}    ld    C, A          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    ld    A, H          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    sbc   A, high format({%-6s},$1); 2:7       _OF_INFO(within_of($1),within_)
__{}__{}    ld    B, A          ; 1:4       _OF_INFO(within_of($1),within_)   BC = a - {{$1}}})
__{}    ld    A, C          ; 1:4       _OF_INFO(within_of($1),within_){}dnl
__{}__{}ifelse(eval((($2)-($1)) & 0xff),{},{
__{}__{}    sub  low format({%-11s},($2)-($1)); 2:7       _OF_INFO(within_of($1),within_)
__{}__{}    ld    A, B          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    sbc   A, high format({%-6s},($2)-($1)); 2:7       _OF_INFO(within_of($1),within_)   carry:(a - {{$1}}) - ($2 - {{$1}})},
__{}__{}{
__{}__{}    sub  format({%-15s},eval((($2)-($1)) & 0xff)); 2:7       _OF_INFO(within_of($1),within_)
__{}__{}    ld    A, B          ; 1:4       _OF_INFO(within_of($1),within_)
__{}__{}    sbc   A, format({%-11s},eval((($2)-($1))/256)); 2:7       _OF_INFO(within_of($1),within_)   carry:(a - {{$1}}) - ($2 - {{$1}})})
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(within_of($1),within_)}){}dnl
})dnl
dnl
dnl
define({ENDOF},{
    jp   endcase{}CASE_STACK     ; 3:10      _OF_INFO(endof)
endof{}OF_STACK:            ;           _OF_INFO(endof){}popdef({OF_STACK})})dnl
dnl
dnl
define({DECLINING_ENDOF},{
;   --vvv-- falling down --vvv--    _OF_INFO(declining_endof)
endof{}OF_STACK:            ;           _OF_INFO(declining_endof){}popdef({OF_STACK})})dnl
dnl
dnl
define({ENDCASE},{popdef({LASTOF_STACK})define({OF_COUNT}, LASTOF_STACK)
endcase{}CASE_STACK:             ;           endcase CASE_STACK
;   ^---^---^ endcase CASE_STACK ^---^---^{}popdef({CASE_STACK})})dnl
dnl
dnl
dnl # Non standard 8-bit case ignores hi byte: ( n -- n )
dnl # LO_CASE
dnl #   LO_OF code1 LO_ENDOF
dnl #   LO_OF code2 LO_ENDOF
dnl #   ...
dnl #       default-code
dnl # LO_ENDCASE ( n -- n )
dnl
dnl # Compatibility with standard: ( n -- )
dnl # LO_CASE
dnl #   LO_OF DROP code1 LO_ENDOF
dnl #   LO_OF DROP code2 LO_ENDOF
dnl #   ...
dnl #       default-code
dnl #   DROP
dnl # LO_ENDCASE
dnl
define({LO_CASE},{define({CASE_COUNT}, incr(CASE_COUNT))pushdef({CASE_STACK}, CASE_COUNT)pushdef({LASTOF_STACK}, LASTOF_STACK)define({LASTOF_STACK},CASE_COUNT{000})
;   v---v---v lo_case CASE_STACK v---v---v
    ld    A, L          ; 1:4       lo_case CASE_STACK{}dnl
})dnl
dnl
dnl
define({LO_OF},{define({LASTOF_STACK}, incr(LASTOF_STACK))pushdef({OF_STACK}, LASTOF_STACK)ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(eval($1),{},{dnl
__{}    .error {$0}($@): M4 cannot calculate "$1".},
__{}index({$1},{(}),{0},{dnl
__{}    .error {$0}($@): Does not support variable parameters stored in memory.},
__{}{dnl
__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}__{}                        ;[4:14]     _OF_INFO(lo_of($1),lo_)
__{}__{}__{}    or   A              ; 1:4       _OF_INFO(lo_of($1),lo_)
__{}__{}__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(lo_of($1),lo_)},
__{}__{}{dnl
__{}__{}__{}                        ;[5:17]     _OF_INFO(lo_of($1),lo_){}ifelse(eval(($1)/256 == 0),{0},{
__{}__{}__{}    .warning {$0}($@): Value $1 is greater than 255.})
__{}__{}__{}    cp   low format({%-11s},$1); 2:7       _OF_INFO(lo_of($1),lo_)
__{}__{}__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(lo_of($1),lo_)})}){}dnl
})dnl
dnl
dnl
dnl ( a $1 $2 -- ((a-$1) ($2-$1) U<) )
dnl $1 <= a < $2
define({LO_WITHIN_OF},{define({LASTOF_STACK}, incr(LASTOF_STACK))pushdef({OF_STACK}, LASTOF_STACK)ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}                        ;[ifelse(index({$2},{(}),{0},{15:69},{14:63})]    _OF_INFO(lo_within_of($1),lo_within_)   ( a $1 $2 -- flag=($1<=a<$2) )
__{}    ld    A, format({%-11s},$1); 3:13      _OF_INFO(lo_within_of($1),lo_within_)
__{}    ld    C, A          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)   C = $1
__{}    ld    A, format({%-11s},$2); ifelse(index({$2},{(}),{0},{3:13},{2:7 })      _OF_INFO(lo_within_of($1),lo_within_)
__{}    sub   C             ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)
__{}    ld    B, A          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)   B = $2 - $1
__{}    ld    A, L          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)
__{}    sub   C             ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)   A = a  - $1
__{}    sub   B             ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)   A = (a - $1) - ($2 - $1)
__{}    ld    A, L          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(lo_within_of($1),lo_within_)},
__{}index({$2},{(}),{0},{dnl
__{}                        ;[13:59]    _OF_INFO(lo_within_of($1),lo_within_)   ( a -- flag=($1<=a<$2) )
__{}    ld    C, format({%-11s},$1); 2:7       _OF_INFO(lo_within_of($1),lo_within_)
__{}    ld    A, format({%-11s},$2); 3:13      _OF_INFO(lo_within_of($1),lo_within_)
__{}    sub   C             ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)
__{}    ld    B, A          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)   B = $2 - {{$1}}
__{}    ld    A, L          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)
__{}    sub   C             ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)   A = a  - {{$1}}
__{}    sub   B             ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)   A = (a - {{$1}}) - ($2 - {{$1}})
__{}    ld    A, L          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(lo_within_of($1),lo_within_)},
__{}eval($1),{0},{dnl
__{}                        ;[5:17]     _OF_INFO(lo_within_of($1),lo_within_)   ( a -- flag=($1<=a<$2) )
__{}    cp   low format({%-11s},$2-($1)); 2:7       _OF_INFO(lo_within_of($1),lo_within_)   carry: (a - {{$1}}) - ($2 - {{$1}})
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(lo_within_of($1),lo_within_)},
__{}eval($1),{1},{dnl
__{}                        ;[7:25]     _OF_INFO(lo_within_of($1),lo_within_)   ( a -- flag=($1<=a<$2) )
__{}    dec   A             ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)   A = a - {{$1}}
__{}    sub  low format({%-11s},$2-($1)); 2:7       _OF_INFO(lo_within_of($1),lo_within_)   carry: (a - {{$1}}) - ($2 - {{$1}})
__{}    ld    A, L          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(lo_within_of($1),lo_within_)},
__{}eval($1),{-1},{dnl
__{}                        ;[7:25]     _OF_INFO(lo_within_of($1),lo_within_)   ( a -- flag=($1<=a<$2) )
__{}    inc   A             ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)   A = a - {{$1}}
__{}    sub  low format({%-11s},$2-($1)); 2:7       _OF_INFO(lo_within_of($1),lo_within_)   carry: (a - {{$1}}) - ($2 - {{$1}})
__{}    ld    A, L          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(lo_within_of($1),lo_within_)},
__{}{dnl
__{}                        ;[8:28]     _OF_INFO(lo_within_of($1),lo_within_)   ( a -- flag=($1<=a<$2) )
__{}    sub  low format({%-11s},$1); 2:7       _OF_INFO(lo_within_of($1),lo_within_)   A = a - {{$1}}
__{}    sub  low format({%-11s},$2-($1)); 2:7       _OF_INFO(lo_within_of($1),lo_within_)   carry: (a - {{$1}}) - ($2 - {{$1}})
__{}    ld    A, L          ; 1:4       _OF_INFO(lo_within_of($1),lo_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(lo_within_of($1),lo_within_)})})dnl
dnl
dnl
define({LO_ENDOF},{
    jp   endcase{}CASE_STACK     ; 3:10      _OF_INFO(lo_endof,lo_)
endof{}OF_STACK:            ;           _OF_INFO(lo_endof,lo_){}popdef({OF_STACK})})dnl
dnl
dnl
define({LO_DECLINING_ENDOF},{
;   --vvv-- falling down --vvv--    _OF_INFO(lo_declining_endof,lo_)
endof{}OF_STACK:            ;           _OF_INFO(lo_declining_endof,lo_){}popdef({OF_STACK})})dnl
dnl
dnl
define({LO_ENDCASE},{popdef({LASTOF_STACK})
endcase{}CASE_STACK:             ;           lo_endcase CASE_STACK
;   ^---^---^ lo_endcase CASE_STACK ^---^---^{}popdef({CASE_STACK})})dnl
dnl
dnl
dnl
dnl # Non standard 8-bit CASE ignores lo byte: ( n -- n )
dnl # HI_CASE
dnl #   HI_OF code1 HI_ENDOF
dnl #   HI_OF code2 HI_ENDOF
dnl #   ...
dnl #       default-code
dnl # HI_ENDCASE
dnl
dnl # Compatibility with standard CASE: ( n -- )
dnl # HI_CASE
dnl #   HI_OF DROP code1 HI_ENDOF
dnl #   HI_OF DROP code2 HI_ENDOF
dnl #   ...
dnl #       default-code
dnl #   DROP
dnl # HI_ENDCASE ( n -- )
dnl
define({HI_CASE},{define({CASE_COUNT}, incr(CASE_COUNT))pushdef({CASE_STACK}, CASE_COUNT)pushdef({LASTOF_STACK}, LASTOF_STACK)define({LASTOF_STACK},CASE_COUNT{000})
;   v---v---v hi_case CASE_STACK v---v---v
    ld    A, H          ; 1:4       hi_case CASE_STACK{}dnl
})dnl
dnl
dnl
define({HI_OF},{define({LASTOF_STACK}, incr(LASTOF_STACK))pushdef({OF_STACK}, LASTOF_STACK)ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(eval($1),{},{dnl
__{}    .error {$0}($@): M4 cannot calculate "$1".},
__{}index({$1},{(}),{0},{dnl
__{}    .error {$0}($@): Does not support variable parameters stored in memory.},
__{}{dnl
__{}__{}ifelse(eval($1),{0},{dnl
__{}__{}__{}                        ;[4:14]     _OF_INFO(hi_of($1),hi_)
__{}__{}__{}    or   A              ; 1:4       _OF_INFO(hi_of($1),hi_)
__{}__{}__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(hi_of($1),hi_)},
__{}__{}{dnl
__{}__{}__{}                        ;[5:17]     _OF_INFO(hi_of($1),hi_){}ifelse(eval(($1)/256 == 0),{0},{
__{}__{}__{}    .warning {$0}($@): Value $1 is greater than 255.})
__{}__{}__{}    cp   low format({%-11s},$1); 2:7       _OF_INFO(hi_of($1),hi_)
__{}__{}__{}    jp   nz, endof{}OF_STACK; 3:10      _OF_INFO(hi_of($1),hi_)})}){}dnl
})dnl
dnl
dnl
dnl ( a $1 $2 -- ((a-$1) ($2-$1) U<) )
dnl $1 <= a < $2
define({HI_WITHIN_OF},{define({LASTOF_STACK}, incr(LASTOF_STACK))pushdef({OF_STACK}, LASTOF_STACK)ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameters!},
__{}$#,{1},{
__{}__{}.error {$0}($@): The second parameter is missing!},
__{}$#,{2},,{
__{}__{}.error {$0}($@): $# parameters found in macro!})
__{}ifelse(index({$1},{(}),{0},{dnl
__{}                        ;[ifelse(index({$2},{(}),{0},{15:69},{14:63})]    _OF_INFO(hi_within_of($1),hi_within_)   ( a $1 $2 -- flag=($1<=a<$2) )
__{}    ld    A, format({%-11s},$1); 3:13      _OF_INFO(hi_within_of($1),hi_within_)
__{}    ld    C, A          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)   C = $1
__{}    ld    A, format({%-11s},$2); ifelse(index({$2},{(}),{0},{3:13},{2:7 })      _OF_INFO(hi_within_of($1),hi_within_)
__{}    sub   C             ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)
__{}    ld    B, A          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)   B = ($2)-[$1]
__{}    ld    A, L          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)
__{}    sub   C             ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)   A = a -($1)
__{}    sub   B             ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)   A = (a -($1)) - ([$2]-($1))
__{}    ld    A, H          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(hi_within_of($1),hi_within_)},
__{}index({$2},{(}),{0},{dnl
__{}                        ;[13:59]    _OF_INFO(hi_within_of($1),hi_within_)   ( a -- flag=($1<=a<$2) )
__{}    ld    C, format({%-11s},$1); 2:7       _OF_INFO(hi_within_of($1),hi_within_)
__{}    ld    A, format({%-11s},$2); 3:13      _OF_INFO(hi_within_of($1),hi_within_)
__{}    sub   C             ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)
__{}    ld    B, A          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)   B = $2 - {{$1}}
__{}    ld    A, L          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)
__{}    sub   C             ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)   A = a -($1)
__{}    sub   B             ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)   A = (a -($1)) - ([$2]-($1))
__{}    ld    A, H          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(hi_within_of($1),hi_within_)},
__{}eval($1),{0},{dnl
__{}                        ;[5:17]     _OF_INFO(hi_within_of($1),hi_within_)   ( a -- flag=($1<=a<$2) )
__{}    cp   low format({%-11s},$2-($1)); 2:7       _OF_INFO(hi_within_of($1),hi_within_)   carry: (a - {{$1}}) - ($2 - {{$1}})
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(hi_within_of($1),hi_within_)},
__{}eval($1),{1},{dnl
__{}                        ;[7:25]     _OF_INFO(hi_within_of($1),hi_within_)   ( a -- flag=($1<=a<$2) )
__{}    dec   A             ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)   A = a - {{$1}}
__{}    sub  low format({%-11s},$2-($1)); 2:7       _OF_INFO(hi_within_of($1),hi_within_)   carry: (a - {{$1}}) - ($2 - {{$1}})
__{}    ld    A, H          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(hi_within_of($1),hi_within_)},
__{}eval($1),{-1},{dnl
__{}                        ;[7:25]     _OF_INFO(hi_within_of($1),hi_within_)   ( a -- flag=($1<=a<$2) )
__{}    inc   A             ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)   A = a - {{$1}}
__{}    sub  low format({%-11s},$2-($1)); 2:7       _OF_INFO(hi_within_of($1),hi_within_)   carry: (a - {{$1}}) - ($2 - {{$1}})
__{}    ld    A, H          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(hi_within_of($1),hi_within_)},
__{}{
__{}                        ;[8:28]     _OF_INFO(hi_within_of($1),hi_within_)   ( a -- flag=($1<=a<$2) )
__{}    sub  low format({%-11s},$1); 2:7       _OF_INFO(hi_within_of($1),hi_within_)   A = a-($1)
__{}    sub  low format({%-11s},($2)-($1)); 2:7       _OF_INFO(hi_within_of($1),hi_within_)
__{}    ld    A, H          ; 1:4       _OF_INFO(hi_within_of($1),hi_within_)
__{}    jp   nc, endof{}OF_STACK; 3:10      _OF_INFO(hi_within_of($1),hi_within_)})})dnl
dnl
dnl
define({HI_ENDOF},{
    jp   endcase{}CASE_STACK     ; 3:10      _OF_INFO(hi_endof,hi_)
endof{}OF_STACK:            ;           _OF_INFO(hi_endof,hi_){}popdef({OF_STACK})})dnl
dnl
dnl
define({HI_DECLINING_ENDOF},{
;   --vvv-- falling down --vvv--    _OF_INFO(hi_declining_endof,hi_)
endof{}OF_STACK:            ;           _OF_INFO(hi_declining_endof,hi_){}popdef({OF_STACK})})dnl
dnl
dnl
define({HI_ENDCASE},{popdef({LASTOF_STACK})
endcase{}CASE_STACK:             ;           hi_endcase CASE_STACK
;   ^---^---^ hi_endcase CASE_STACK ^---^---^{}popdef({CASE_STACK})})dnl
dnl
dnl
dnl
