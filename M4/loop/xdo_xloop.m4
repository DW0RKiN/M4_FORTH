dnl ## non-recursive xdo(stop,index) xi i xloop
define({__},{})dnl
dnl
dnl ---------- xdo(stop,index) ... xloop ------------
dnl Napevno zadavana optimalizovana konstantni smycka, jejiz rozsah je znam uz v dobe kompilace a kterou nelze programove menit
dnl ( -- ) 
dnl xdo(stop,index) ... xloop
dnl xdo(stop,index) ... addxloop(step)
define({XDO},{
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}                                 ;           xunloop LOOP_STACK}){}dnl
__{}pushdef({STOP_STACK}, $1)pushdef({INDEX_STACK}, $2)
    ld   BC, format({%-11s},$2); 3:10      xdo($1,$2) LOOP_STACK
    ld  format({%-16s},(idx{}LOOP_STACK){,}BC); 4:20      xdo($1,$2) LOOP_STACK
xdo{}LOOP_STACK:                 ;           xdo($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl ( -- ) 
dnl xdo(stop,index) ... xloop
dnl xdo(stop,index) ... addxloop(step)
define({QUESTIONXDO},{
dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}                                 ;           xunloop LOOP_STACK}){}dnl
__{}pushdef({STOP_STACK}, $1)pushdef({INDEX_STACK}, $2)ifelse({$1},{$2},{
    jp   xexit{}LOOP_STACK       ; 3:10      ?xdo($1,$2) LOOP_STACK{}dnl
},{
    ld   BC, format({%-11s},$2); 3:10      ?xdo($1,$2) LOOP_STACK
    ld  format({%-16s},(idx{}LOOP_STACK){,}BC); 4:20      ?xdo($1,$2) LOOP_STACK})
xdo{}LOOP_STACK:                 ;           ?xdo($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( -- )
define({XLOOP},{ifelse(eval((0<=(INDEX_STACK)) && ((INDEX_STACK)<(STOP_STACK)) && ((STOP_STACK)<256)),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK 0 <= index < stop < 256
__{}    ld    A, 0          ; 2:7       xloop LOOP_STACK
__{}    nop                 ; 1:4       xloop LOOP_STACK idx always points to a 16-bit index
__{}    inc   A             ; 1:4       xloop LOOP_STACK index++
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK
__{}    sub  low format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK
__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK index-stop
dnl                         ;12:45/45/45},
__{}eval((((INDEX_STACK)^(STOP_STACK))&0xFF00)==0 && ((INDEX_STACK)<(STOP_STACK))),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;           xloop LOOP_STACK hi index == hi stop && index < stop
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK idx always points to a 16-bit index
__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}    inc   A             ; 1:4       xloop LOOP_STACK index++
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK save index
__{}    sub  low format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK index - stop
__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK
dnl                         ;13:48/48/48},
__{}eval((((STOP_STACK) && 0xFF) == 0) && (((INDEX_STACK)^(STOP_STACK))&0xFF00)),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[14:57]    xloop LOOP_STACK lo stop == 0  && hi index != hi stop
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK idx always points to a 16-bit index
__{}    inc  BC             ; 1:6       xloop LOOP_STACK index++
__{}    ld  (idx{}LOOP_STACK),BC     ; 4:20      xloop LOOP_STACK save index
__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}    sub  high format({%-10s},STOP_STACK); 2:7       xloop LOOP_STACK index - stop
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK
dnl                         ;14:57/57/57},
__{}eval((((INDEX_STACK)^(STOP_STACK))&0x8000)==0 && ((INDEX_STACK)<(STOP_STACK))),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[17:68]    xloop LOOP_STACK index < stop && same sign
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK idx always points to a 16-bit index
__{}    inc  BC             ; 1:6       xloop LOOP_STACK index++
__{}    ld  (idx{}LOOP_STACK),BC     ; 4:20      xloop LOOP_STACK save index
__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}    sub  low format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK index - stop
__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},STOP_STACK); 2:7       xloop LOOP_STACK index - stop
__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK
dnl                         ;17:68/68/68},
__{}{
__{}idx{}LOOP_STACK EQU $+1          ;[20:~71]   xloop LOOP_STACK INDEX_STACK..STOP_STACK
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK idx always points to a 16-bit index
__{}    inc  BC             ; 1:6       xloop LOOP_STACK index++
__{}    ld  (idx{}LOOP_STACK),BC     ; 4:20      xloop LOOP_STACK save index
__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}    xor  low format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}    xor  high format({%-10s},STOP_STACK); 2:7       xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK
dnl                         ;20:57/78/78})
xleave{}LOOP_STACK:              ;           xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl ( -- )
define({SUB1_ADDXLOOP},{
idx{}LOOP_STACK EQU $+1          ;           -1 +xloop LOOP_STACK
    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK idx always points to a 16-bit index
    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
    xor  low format({%-11s},STOP_STACK); 2:7       -1 +xloop LOOP_STACK
    ld    A, B          ; 1:4       -1 +xloop LOOP_STACK
    dec  BC             ; 1:6       -1 +xloop LOOP_STACK index--
    ld  (idx{}LOOP_STACK),BC     ; 4:20      -1 +xloop LOOP_STACK save index
    jp   nz, xdo{}LOOP_STACK     ; 3:10      -1 +xloop LOOP_STACK
    xor  high format({%-10s},STOP_STACK); 2:7       -1 +xloop LOOP_STACK
    jp   nz, xdo{}LOOP_STACK     ; 3:10      -1 +xloop LOOP_STACK
xleave{}LOOP_STACK:              ;           -1 +xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl 2 +loop
dnl ( -- )
define(_ADD2_ADDXLOOP,{
idx{}LOOP_STACK EQU $+1          ;           2 +xloop LOOP_STACK
    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop LOOP_STACK index++
    inc  BC             ; 1:6       2 +xloop LOOP_STACK index++
    ld  (idx{}LOOP_STACK),BC     ; 4:20      2 +xloop LOOP_STACK save index
    ld    A, C          ; 1:4       2 +xloop LOOP_STACK
    sub  low format({%-11s},STOP_STACK); 2:7       2 +xloop LOOP_STACK
    rra                 ; 1:4       2 +xloop LOOP_STACK
    add   A, A          ; 1:4       2 +xloop LOOP_STACK and 0xFE with save carry
    jp   nz, xdo{}LOOP_STACK     ; 3:10      2 +xloop LOOP_STACK
    ld    A, B          ; 1:4       2 +xloop LOOP_STACK
    sbc   A, high format({%-6s},STOP_STACK); 2:7       2 +xloop LOOP_STACK
    jp   nz, xdo{}LOOP_STACK     ; 3:10      2 +xloop LOOP_STACK
dnl                         ;23:71/92/92
xleave{}LOOP_STACK:              ;           2 +xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           2 +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl
dnl stop index do ... step +loop
dnl ( -- )
dnl xdo(stop,index) ... push_addxloop(step)
define({X_ADDXLOOP},{
    push HL             ; 1:11      $1 +xloop LOOP_STACK
idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
    ld   HL, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
    ld   BC, format({%-11s},$1); 3:10      $1 +xloop LOOP_STACK BC = step
    add  HL, BC         ; 1:11      $1 +xloop LOOP_STACK HL = index+step
    ld  (idx{}LOOP_STACK), HL    ; 3:16      $1 +xloop LOOP_STACK save index{}dnl
__{}ifelse(eval(STOP_STACK),{},{
__{}    ld    A, format({%-11s},1*(STOP_STACK)-1); 2:7       $1 +xloop LOOP_STACK},
__{}{
__{}    ld    A, low format({%-7s},eval(STOP_STACK-1)); 2:7       $1 +xloop LOOP_STACK})
    sub   L             ; 1:4       $1 +xloop LOOP_STACK
    ld    L, A          ; 1:4       $1 +xloop LOOP_STACK{}dnl
__{}ifelse(eval(STOP_STACK),{},{
__{}    ld    A, 1*((STOP_STACK)+65535)/256; 2:7       $1 +xloop LOOP_STACK},
__{}{
__{}    ld    A, high format({%-6s},eval(STOP_STACK-1)); 2:7       $1 +xloop LOOP_STACK})
    sbc   A, H          ; 1:4       $1 +xloop LOOP_STACK
    ld    H, A          ; 1:4       $1 +xloop LOOP_STACK HL = stop-(index+step)
    add  HL, BC         ; 1:11      $1 +xloop LOOP_STACK HL = stop-index
    pop  HL             ; 1:10      $1 +xloop LOOP_STACK{}dnl
__{}ifelse(eval(($1)<0),{1},{
__{}__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK negative step},
__{}{
__{}__{}    jp   nc, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK positive step})
dnl                     ;24:119
xleave{}LOOP_STACK:              ;           $1 +xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           $1 +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl
dnl step +loop
dnl ( -- )
define({PUSH_ADDXLOOP},{ifelse(eval($1),{1},{
                        ;           push_addxloop($1) LOOP_STACK{}XLOOP},
eval($1),{-1},{
                        ;           push_addxloop($1) LOOP_STACK{}SUB1_ADDXLOOP},
eval($1),{2},{
                        ;           push_addxloop($1) LOOP_STACK{}_ADD2_ADDXLOOP},
{$#},{1},{X_ADDXLOOP($1)},{
.error push_addxloop without parameter!})})dnl
dnl
dnl
define({ADDXLOOP},{ifelse({fast},{slow},{
__{}    ld    B, H          ; 1:4       +xloop LOOP_STACK
__{}    ld    C, L          ; 1:4       +xloop LOOP_STACK BC = step
__{}idx{}LOOP_STACK EQU $+1          ;           +xloop LOOP_STACK
__{}    ld   HL, 0x0000     ; 3:10      +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      +xloop LOOP_STACK save index{}dnl
__{}__{}ifelse(eval(STOP_STACK),{},{
__{}__{}    ld    A, format({%-11s},1*(STOP_STACK)-1); 2:7       +xloop LOOP_STACK},
__{}__{}{
__{}__{}    ld    A, low format({%-7s},eval(STOP_STACK-1)); 2:7       +xloop LOOP_STACK})
__{}    sub   L             ; 1:4       +xloop LOOP_STACK
__{}    ld    L, A          ; 1:4       +xloop LOOP_STACK{}dnl
__{}__{}ifelse(eval(STOP_STACK),{},{
__{}__{}    ld    A, 1*((STOP_STACK)+65535)/256; 2:7       +xloop LOOP_STACK},
__{}__{}{
__{}__{}    ld    A, high format({%-6s},eval(STOP_STACK-1)); 2:7       +xloop LOOP_STACK})
__{}    sbc   A, H          ; 1:4       +xloop LOOP_STACK
__{}    ld    H, A          ; 1:4       +xloop LOOP_STACK HL = stop-(index+step)
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK HL = stop-index
__{}    xor   H             ; 1:4       +xloop LOOP_STACK
__{}    ex   DE, HL         ; 1:4       +xloop LOOP_STACK
__{}    pop  DE             ; 1:10      +xloop LOOP_STACK
__{}    jp    p, xdo{}LOOP_STACK     ; 3:10      +xloop LOOP_STACK
                        ;24:114},
__{}{fast},{small},{
__{}    push DE             ; 1:11      +xloop LOOP_STACK
__{}idx{}LOOP_STACK EQU $+1          ;           +xloop LOOP_STACK
__{}    ld   DE, 0x0000     ; 3:10      +xloop LOOP_STACK DE = index
__{}    add  HL, DE         ; 1:11      +xloop LOOP_STACK HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      +xloop LOOP_STACK save index
__{}    ld   BC, format({%-11s},-1*(STOP_STACK)); 3:10      +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK HL = index+step-stop
__{}    ld    A, H          ; 1:4       +xloop LOOP_STACK
__{}    ex   DE, HL         ; 1:4       +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK HL = index-stop
__{}    xor   H             ; 1:4       +xloop LOOP_STACK
__{}    pop  HL             ; 1:10      +xloop LOOP_STACK
__{}    pop  DE             ; 1:10      +xloop LOOP_STACK
__{}    jp    p, xdo{}LOOP_STACK     ; 3:10      +xloop LOOP_STACK
                        ;21:122},
__{}{
__{}idx{}LOOP_STACK EQU $+1          ;           +xloop LOOP_STACK
__{}    ld   BC, 0x0000     ; 3:10      +xloop LOOP_STACK BC = index
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      +xloop LOOP_STACK save index
__{}    ld    A, L          ; 1:4       +xloop LOOP_STACK
__{}    sub   low format({%-10s},STOP_STACK); 2:7       +xloop LOOP_STACK
__{}    ld    A, H          ; 1:4       +xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},STOP_STACK); 2:7       +xloop LOOP_STACK
__{}    ld    H, A          ; 1:4       +xloop LOOP_STACK H = hi index+step-stop
__{}    ld    A, C          ; 1:4       +xloop LOOP_STACK
__{}    sub   low format({%-10s},STOP_STACK); 2:7       +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       +xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},STOP_STACK); 2:7       +xloop LOOP_STACK A = hi index-stop
__{}    xor   H             ; 1:4       +xloop LOOP_STACK
__{}    ex   DE, HL         ; 1:4       +xloop LOOP_STACK
__{}    pop  DE             ; 1:10      +xloop LOOP_STACK
__{}    jp    p, xdo{}LOOP_STACK     ; 3:10      +xloop LOOP_STACK
                        ;26:113})
xleave{}LOOP_STACK:              ;           +xloop LOOP_STACK
xexit{}LOOP_STACK:               ;           +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl ( -- i )
dnl hodnota indexu vnitrni smycky
define({XI},{
    push DE             ; 1:11      index xi LOOP_STACK
    ex   DE, HL         ; 1:4       index xi LOOP_STACK
    ld   HL, (idx{}LOOP_STACK)   ; 3:16      index xi LOOP_STACK idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl
dnl ( -- j )
dnl hodnota indexu druhe vnitrni smycky
define({XJ},{
    push DE             ; 1:11      index xj LOOP_STACK
    ex   DE, HL         ; 1:4       index xj LOOP_STACK
__{}pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK}){}dnl
    ld   HL, (idx{}LOOP_STACK)   ;{}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK}){}dnl
__{} 3:16      index xj LOOP_STACK idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl
dnl ( -- k )
dnl hodnota indexu treti vnitrni smycky
define({XK},{
    push DE             ; 1:11      index xk LOOP_STACK
    ex   DE, HL         ; 1:4       index xk LOOP_STACK
__{}pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK}){}dnl
__{}pushdef({TEMP_STACK},LOOP_STACK){}popdef({LOOP_STACK}){}dnl
    ld   HL, (idx{}LOOP_STACK)   ;{}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK}){}dnl
__{}pushdef({LOOP_STACK},TEMP_STACK){}popdef({TEMP_STACK}){}dnl
__{} 3:16      index xk LOOP_STACK idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl
