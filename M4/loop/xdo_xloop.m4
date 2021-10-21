dnl ## non-recursive xdo(stop,index) xi i xloop
define({__},{})dnl
dnl
dnl ---------- xdo(stop,index) ... xloop ------------
dnl Napevno zadavana optimalizovana konstantni smycka, jejiz rozsah je znam uz v dobe kompilace a kterou nelze programove menit
dnl ( -- )
dnl xdo(stop,index) ... xloop
dnl xdo(stop,index) ... addxloop(step)
define({XDO},{
__{}pushdef({STOP_STACK}, $1){}dnl
__{}pushdef({INDEX_STACK}, $2){}dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           xunloop LOOP_STACK}){}dnl
__{}    ld   BC, format({%-11s},$2); 3:10      xdo($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK{}save:             ;           xdo($1,$2) LOOP_STACK
__{}    ld  format({%-16s},(idx{}LOOP_STACK){,}BC); 4:20      xdo($1,$2) LOOP_STACK
__{}xdo{}LOOP_STACK:                 ;           xdo($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl ( -- )
dnl xdo(stop,index) ... xloop
dnl xdo(stop,index) ... addxloop(step)
define({QUESTIONXDO},{
__{}pushdef({STOP_STACK}, $1){}dnl
__{}pushdef({INDEX_STACK}, $2){}dnl
__{}define({LOOP_COUNT}, incr(LOOP_COUNT)){}dnl
__{}pushdef({LOOP_STACK}, LOOP_COUNT){}dnl
__{}pushdef({LEAVE_STACK},{
__{}__{}    jp   xleave{}LOOP_STACK      ;           xleave LOOP_STACK}){}dnl
__{}pushdef({UNLOOP_STACK},{
__{}__{}                                 ;           xunloop LOOP_STACK}){}dnl
__{}ifelse({$1},{$2},{
__{}__{}    jp   xexit{}LOOP_STACK       ; 3:10      ?xdo($1,$2) LOOP_STACK{}dnl
__{}},{
__{}__{}    ld   BC, format({%-11s},$2); 3:10      ?xdo($1,$2) LOOP_STACK
__{}__{}    ld  format({%-16s},(idx{}LOOP_STACK){,}BC); 4:20      ?xdo($1,$2) LOOP_STACK})
__{}xdo{}LOOP_STACK:                 ;           ?xdo($1,$2) LOOP_STACK})dnl
dnl
dnl
dnl
dnl ( -- )
define({XLOOP},{ifelse(eval((0<=(INDEX_STACK)) && ((INDEX_STACK)<(STOP_STACK)) && ((STOP_STACK)<256)),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[12:45]    xloop LOOP_STACK   variant: 0 <= index < stop < 256
__{}    ld    A, 0          ; 2:7       xloop LOOP_STACK
__{}    nop                 ; 1:4       xloop LOOP_STACK   Contains a zero value because idx always points to a 16-bit index.
__{}    inc   A             ; 1:4       xloop LOOP_STACK   index++
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK
__{}    sub  low format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK
__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK   index-stop
dnl                         ;12:45/45/45},
__{}eval((((INDEX_STACK)^(STOP_STACK))&0xFF00)==0 && ((INDEX_STACK)<(STOP_STACK))),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[11:41]    xloop LOOP_STACK   variant: hi index == hi stop == 0x3c && index < stop
__{}    ld    A, 0          ; 2:7       xloop LOOP_STACK
__{}    inc   A             ; 1:4       xloop LOOP_STACK   = hi index = 0x3c -> idx always points to a 16-bit index
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK   save index
__{}    sub  low format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK   index - stop
__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK
dnl                         ;13:48/48/48},
__{}eval((((INDEX_STACK)^(STOP_STACK))&0xFF00)==0 && ((INDEX_STACK)<(STOP_STACK))),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[13:48]    xloop LOOP_STACK   variant: hi index == hi stop && index < stop
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}    inc   A             ; 1:4       xloop LOOP_STACK   index++
__{}    ld  (idx{}LOOP_STACK),A      ; 3:13      xloop LOOP_STACK   save index
__{}    sub  low format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK   index - stop
__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK
dnl                         ;13:48/48/48},
__{}eval(STOP_STACK),{0},{
__{}idx{}LOOP_STACK EQU $+1          ;[9:54/34]  xloop LOOP_STACK   variant: stop == 0
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   idx always points to a 16-bit index
__{}    inc  BC             ; 1:6       xloop LOOP_STACK   index++
__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}    or    C             ; 1:4       xloop LOOP_STACK   index - stop
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK
dnl                         ;14:57/57/57},
__{}eval((((STOP_STACK) & 0xFF) == 0) && (((INDEX_STACK)^(STOP_STACK)) & 0xFF00)),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[10:57/37] xloop LOOP_STACK   variant: lo stop == 0  && hi index != hi stop
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   idx always points to a 16-bit index
__{}    inc  BC             ; 1:6       xloop LOOP_STACK   index++
__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}    sub  high format({%-10s},STOP_STACK); 2:7       xloop LOOP_STACK   index - stop
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK
dnl                         ;14:57/57/57},
__{}eval((((INDEX_STACK)^(STOP_STACK))&0x8000)==0 && ((INDEX_STACK)<(STOP_STACK))),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[13:68/48] xloop LOOP_STACK   variant: index < stop && same sign
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   idx always points to a 16-bit index
__{}    inc  BC             ; 1:6       xloop LOOP_STACK   index++
__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}    sub  low format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK   index - stop
__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},STOP_STACK); 2:7       xloop LOOP_STACK   index - stop
__{}    jp    c, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK
dnl                         ;17:68/68/68},
__{}{
__{}idx{}LOOP_STACK EQU $+1          ;[16:~eval(57+21/((0x10000+(STOP_STACK)-(INDEX_STACK)) & 0xffff))]   xloop LOOP_STACK   variant: INDEX_STACK.. +1 ..(STOP_STACK)
__{}    ld   BC, 0x0000     ; 3:10      xloop LOOP_STACK   idx always points to a 16-bit index
__{}    inc  BC             ; 1:6       xloop LOOP_STACK   index++
__{}    ld    A, C          ; 1:4       xloop LOOP_STACK
__{}    xor  low format({%-11s},STOP_STACK); 2:7       xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       xloop LOOP_STACK
__{}    xor  high format({%-10s},STOP_STACK); 2:7       xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      xloop LOOP_STACK
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
define({SUB1_ADDXLOOP},{ifelse(eval(STOP_STACK),{-1},{
__{}idx{}LOOP_STACK EQU $+1          ;[10:58/38] -1 +xloop LOOP_STACK   variant: INDEX_STACK.. -1 ..STOP_STACK = -1
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    and   B             ; 1:4       -1 +xloop LOOP_STACK   0xff & 0xff = 0xff
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    inc   A             ; 1:4       -1 +xloop LOOP_STACK   0xff -> 0},
__{}eval(STOP_STACK),{0},{
__{}idx{}LOOP_STACK EQU $+1          ;[9:54/34]  -1 +xloop LOOP_STACK   variant: INDEX_STACK.. -1 ..STOP_STACK = 0
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -1 +xloop LOOP_STACK
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--},
__{}eval(STOP_STACK),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[9:54/34]  -1 +xloop LOOP_STACK   variant: INDEX_STACK.. -1 ..STOP_STACK = 1
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -1 +xloop LOOP_STACK},
__{}eval(STOP_STACK),{2},{
__{}idx{}LOOP_STACK EQU $+1          ;[10:58/38] -1 +xloop LOOP_STACK   variant: INDEX_STACK.. -1 ..STOP_STACK = 2
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    dec   A             ; 1:4       -1 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -1 +xloop LOOP_STACK},
__{}eval((STOP_STACK) & 0xFF00),{0},{
__{}idx{}LOOP_STACK EQU $+1          ;[11:61/41] -1 +xloop LOOP_STACK   variant: INDEX_STACK.. -1 ..STOP_STACK -> hi stop = 0
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    sub   low format({%-10s},STOP_STACK); 2:7       -1 +xloop LOOP_STACK
__{}    or    B             ; 1:4       -1 +xloop LOOP_STACK},
__{}{
__{}dnl                                16:61/78/58
__{}idx{}LOOP_STACK EQU $+1          ;[20:~eval(61-3/((0x10000+(INDEX_STACK)-(STOP_STACK)) & 0xffff))]   -1 +xloop LOOP_STACK   variant: INDEX_STACK.. -1 ..STOP_STACK
__{}    ld   BC, 0x0000     ; 3:10      -1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, C          ; 1:4       -1 +xloop LOOP_STACK
__{}    xor  low format({%-11s},STOP_STACK); 2:7       -1 +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       -1 +xloop LOOP_STACK
__{}    dec  BC             ; 1:6       -1 +xloop LOOP_STACK   index--
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK
__{}    xor  high format({%-10s},STOP_STACK); 2:7       -1 +xloop LOOP_STACK})
    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      -1 +xloop LOOP_STACK
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
define(_ADD2_ADDXLOOP,{ifelse(eval(STOP_STACK),{0},{
idx{}LOOP_STACK EQU $+1          ;[12:67/47] 2 +xloop LOOP_STACK   variant: step 2 and stop 0, INDEX_STACK..(STOP_STACK)
    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK   idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
    ld    A, C          ; 1:4       2 +xloop LOOP_STACK
    and  0xFE           ; 2:7       2 +xloop LOOP_STACK   0 or 1 -> 0
    or    B             ; 1:4       2 +xloop LOOP_STACK},
eval(STOP_STACK),{1},{
idx{}LOOP_STACK EQU $+1          ;[12:67/47] 2 +xloop LOOP_STACK   variant: step 2 and stop 1, INDEX_STACK..(STOP_STACK)
    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK   idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
    ld    A, C          ; 1:4       2 +xloop LOOP_STACK
    and  0xFE           ; 2:7       2 +xloop LOOP_STACK   0 or 1 -> 0
    or    B             ; 1:4       2 +xloop LOOP_STACK
    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++},
{
dnl                                19:51+20/72+20/72
idx{}LOOP_STACK EQU $+1          ;[19:71/72] 2 +xloop LOOP_STACK   variant: step 2, INDEX_STACK..(STOP_STACK)
    ld   BC, 0x0000     ; 3:10      2 +xloop LOOP_STACK   idx always points to a 16-bit index
    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
    inc  BC             ; 1:6       2 +xloop LOOP_STACK   index++
    ld    A, C          ; 1:4       2 +xloop LOOP_STACK
    sub  low format({%-11s},STOP_STACK); 2:7       2 +xloop LOOP_STACK
    rra                 ; 1:4       2 +xloop LOOP_STACK
    add   A, A          ; 1:4       2 +xloop LOOP_STACK   and 0xFE with save carry
    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK
    ld    A, B          ; 1:4       2 +xloop LOOP_STACK
    sbc   A, high format({%-6s},STOP_STACK); 2:7       2 +xloop LOOP_STACK})
    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      2 +xloop LOOP_STACK
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
define({_TEMP_FIND_REAL_STOP},{dnl
__{}ifelse(eval($1<0),{1},{dnl
__{}__{}define({_TEMP_START},eval(((INDEX_STACK)-(STOP_STACK)) & 0xffff)){}dnl
__{}__{}define({_TEMP_X},eval(1+_TEMP_START/(-($1)))){}dnl
__{}__{}define({_TEMP_REAL_STOP},{eval((INDEX_STACK+$1*_TEMP_X) & 0xffff)})},
__{}{dnl
__{}__{}define({_TEMP_START},eval(((STOP_STACK)-(INDEX_STACK+1)) & 0xffff)){}dnl
__{}__{}define({_TEMP_X},eval(1+_TEMP_START/($1))){}dnl
__{}__{}define({_TEMP_REAL_STOP},{eval((INDEX_STACK+$1*_TEMP_X) & 0xffff)})}){}dnl
})dnl
dnl
dnl
dnl
dnl stop index do ... +step +loop
dnl ( -- )
dnl xdo(stop,index) ... push_addxloop(+step)
define({POSITIVE_ADDXLOOP},{_TEMP_FIND_REAL_STOP($1){}ifelse(eval((0 <= INDEX_STACK) && (INDEX_STACK < STOP_STACK) && (STOP_STACK < 256)),{1},{
__{}                        ;[13:48]    $1 +xloop LOOP_STACK   variant: positive step and 0 <= index:INDEX_STACK < stop:STOP_STACK < 256, real stop:_TEMP_REAL_STOP, run _TEMP_X{}x, INDEX_STACK.. +$1 ..(STOP_STACK)
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}    ld    A, 0x00       ; 2:7       $1 +xloop LOOP_STACK   A = index
__{}    nop                 ; 1:4       $1 +xloop LOOP_STACK   Contains a zero value because idx always points to a 16-bit index.
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK   A = index+step
__{}    ld  (idx{}LOOP_STACK), A     ; 3:13      $1 +xloop LOOP_STACK   save new index
__{}    xor  low format({%-11s},_TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK   Contains the values of eval((INDEX_STACK+$1) & 0xFF)..eval(_TEMP_REAL_STOP & 0xFF)
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK},
eval((0xC600 <= (INDEX_STACK & 0xFFFF)) && ((INDEX_STACK & 0xFFFF) < (STOP_STACK & 0xFFFF)) && ((STOP_STACK & 0xFFFF) < 0xC700)),{1},{
__{}                        ;[12:44]    $1 +xloop LOOP_STACK   variant: positive step and 0xC600 <= index:INDEX_STACK < stop:STOP_STACK < 0xC700, real stop:_TEMP_REAL_STOP, run _TEMP_X{}x, INDEX_STACK.. +$1 ..(STOP_STACK)
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}    ld    A, 0x00       ; 2:7       $1 +xloop LOOP_STACK   A = index
__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK   First byte contains a 0xC6 value because idx always points to a 16-bit index.
__{}    ld  (idx{}LOOP_STACK), A     ; 3:13      $1 +xloop LOOP_STACK   save new index
__{}    xor  low format({%-11s},_TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK   Contains the values of eval((INDEX_STACK+$1) & 0xFF)..eval(_TEMP_REAL_STOP & 0xFF)
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK},
eval($1 & 0xFF),{0},{
__{}                        ;[10:51/31] $1 +xloop LOOP_STACK   variant: positive lo step 0 and real stop _TEMP_REAL_STOP, run _TEMP_X{}x, INDEX_STACK.. +$1 ..(STOP_STACK)
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    add   A, high format({%-6s},$1); 2:7       $1 +xloop LOOP_STACK
__{}    xor  high format({%-10s},_TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
eval(_TEMP_REAL_STOP & 0xFF00),{0},{
__{}                        ;[19:93]    $1 +xloop LOOP_STACK   variant: positive step and 0 <= real stop:_TEMP_REAL_STOP < 256, run _TEMP_X{}x, INDEX_STACK.. +$1 ..(STOP_STACK)
__{}    push HL             ; 1:11      $1 +xloop LOOP_STACK
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}    ld   HL, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}    ld   BC, format({%-11s},$1); 3:10      $1 +xloop LOOP_STACK   BC = step
__{}    add  HL, BC         ; 1:11      $1 +xloop LOOP_STACK   HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      $1 +xloop LOOP_STACK   save new index
__{}    ld    A, format({%-11s},low _TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK   A = last_index
__{}    xor   L             ; 1:4       $1 +xloop LOOP_STACK
__{}    or    H             ; 1:4       $1 +xloop LOOP_STACK
__{}    pop  HL             ; 1:10      $1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK},
eval(STOP_STACK==0),{1},{
__{}                        ;[17:90]    $1 +xloop LOOP_STACK   variant: positive step and stop 0, INDEX_STACK.. +$1 ..0
__{}    push HL             ; 1:11      $1 +xloop LOOP_STACK
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}    ld   HL, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}    ld   BC, format({%-11s},$1); 3:10      $1 +xloop LOOP_STACK   BC = step
__{}    dec  HL             ; 1:6       $1 +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      $1 +xloop LOOP_STACK   HL = index+step-1
__{}    inc  HL             ; 1:6       $1 +xloop LOOP_STACK
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      $1 +xloop LOOP_STACK   save new index
__{}    pop  HL             ; 1:10      $1 +xloop LOOP_STACK
__{}    jp   nc, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK   positive step},
{dnl
__{}ifelse(eval($1 & 0xFF00),{0},{
__{}__{}                        ;[22:78/79] $1 +xloop LOOP_STACK   variant: positive hi step 0 and real stop _TEMP_REAL_STOP, run _TEMP_X{}x, INDEX_STACK.. +$1 ..(STOP_STACK)
__{}__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    adc   A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sub   C             ; 1:4       $1 +xloop LOOP_STACK},
__{}{
__{}__{}                        ;[23:81/82] $1 +xloop LOOP_STACK   variant: positive step and real stop _TEMP_REAL_STOP, run _TEMP_X{}x, INDEX_STACK.. +$1 ..(STOP_STACK)
__{}__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    add   A, low format({%-7s},$1); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    adc   A, high format({%-6s},$1); 2:7       $1 +xloop LOOP_STACK})
__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  low format({%-11s},_TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    xor  high format({%-10s},_TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK
__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK})
__{}xleave{}LOOP_STACK:              ;           $1 +xloop LOOP_STACK
__{}xexit{}LOOP_STACK:               ;           $1 +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK})})dnl
dnl
dnl
dnl
dnl stop index do ... -step +loop
dnl ( -- )
dnl xdo(stop,index) ... push_addxloop(-step)
define({NEGATIVE_ADDXLOOP},{_TEMP_FIND_REAL_STOP($1){}ifelse(eval(($1==-2) && (STOP_STACK==0)),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[10:60/40] $1 +xloop LOOP_STACK   variant: step -2 and stop 0, INDEX_STACK.. $1 ..STOP_STACK
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK   hi old index
__{}    dec  BC             ; 1:6       $1 +xloop LOOP_STACK   index--
__{}    dec  BC             ; 1:6       $1 +xloop LOOP_STACK   index--
__{}    sub   B             ; 1:4       $1 +xloop LOOP_STACK   old-new = carry if index: positive -> negative
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   carry if postivie index -> negative index},
eval(($1==-3) && (STOP_STACK==0)),{1},{
__{}idx{}LOOP_STACK EQU $+1          ;[11:66/46] $1 +xloop LOOP_STACK   variant: step -3 and stop 0, INDEX_STACK.. $1 ..STOP_STACK
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK   idx always points to a 16-bit index
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK   hi old index
__{}    dec  BC             ; 1:6       $1 +xloop LOOP_STACK   index--
__{}    dec  BC             ; 1:6       $1 +xloop LOOP_STACK   index--
__{}    dec  BC             ; 1:6       $1 +xloop LOOP_STACK   index--
__{}    sub   B             ; 1:4       $1 +xloop LOOP_STACK   old-new = carry if index: positive -> negative
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   carry if postivie index -> negative index},
eval(STOP_STACK==0),{1},{
__{}                        ;[14:70/50] $1 +xloop LOOP_STACK   variant: negative step and stop 0, INDEX_STACK.. $1 ..0
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}    sub  low format({%-11s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}    jp   nc, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK   carry if postivie index -> negative index},
{dnl
__{}ifelse(eval(_TEMP_REAL_STOP & 0xFF00),{0},{
__{}__{}                        ;[18:85/65] $1 +xloop LOOP_STACK   variant: negative step and real stop 0 <= _TEMP_REAL_STOP < 256, run _TEMP_X{}x, INDEX_STACK.. $1 ..STOP_STACK
__{}__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sub  low format({%-11s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sbc   A, high format({%-6s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK   A = last_index
__{}__{}    xor  format({%-15s},low _TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK
__{}__{}    or    B             ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK},
__{}{
__{}__{}                        ;[23:81/82] $1 +xloop LOOP_STACK   variant: negative step and real stop _TEMP_REAL_STOP, run _TEMP_X{}x, INDEX_STACK.. $1 ..STOP_STACK
__{}__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}__{}    ld   BC, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sub  low format({%-11s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    C, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    sbc   A, high format({%-6s},eval(-($1))); 2:7       $1 +xloop LOOP_STACK
__{}__{}    ld    B, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, C          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    xor  low format({%-11s},_TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK
__{}__{}    ld    A, B          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    xor  high format({%-10s},_TEMP_REAL_STOP); 2:7       $1 +xloop LOOP_STACK
__{}__{}    jp   nz, xdo{}LOOP_STACK{}save ; 3:10      $1 +xloop LOOP_STACK})})
__{}xleave{}LOOP_STACK:              ;           $1 +xloop LOOP_STACK
__{}xexit{}LOOP_STACK:               ;           $1 +xloop LOOP_STACK{}dnl
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
define({X_ADDXLOOP},{dnl
__{}                        ;[24:119]   $1 +xloop LOOP_STACK   variant: INDEX_STACK.. $1 ..STOP_STACK
__{}    push HL             ; 1:11      $1 +xloop LOOP_STACK
__{}idx{}LOOP_STACK EQU $+1          ;           $1 +xloop LOOP_STACK
__{}    ld   HL, 0x0000     ; 3:10      $1 +xloop LOOP_STACK
__{}    ld   BC, format({%-11s},$1); 3:10      $1 +xloop LOOP_STACK   BC = step
__{}    add  HL, BC         ; 1:11      $1 +xloop LOOP_STACK   HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      $1 +xloop LOOP_STACK   save new index
__{}ifelse(eval(STOP_STACK),{},{dnl
__{}__{}    ld    A, low format({%-7s},STOP_STACK-1); 2:7       $1 +xloop LOOP_STACK
__{}__{}    sub   L             ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    L, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, high format({%-6s},(STOP_STACK-1)); 2:7       $1 +xloop LOOP_STACK},
__{}{dnl
__{}__{}    ld    A, low format({%-7s},eval(STOP_STACK-1)); 2:7       $1 +xloop LOOP_STACK
__{}__{}    sub   L             ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    L, A          ; 1:4       $1 +xloop LOOP_STACK
__{}__{}    ld    A, high format({%-6s},eval(STOP_STACK-1)); 2:7       $1 +xloop LOOP_STACK})
__{}    sbc   A, H          ; 1:4       $1 +xloop LOOP_STACK
__{}    ld    H, A          ; 1:4       $1 +xloop LOOP_STACK   HL = (stop-1)-(index+step)
__{}    add  HL, BC         ; 1:11      $1 +xloop LOOP_STACK   HL = (stop-1)-index
__{}    pop  HL             ; 1:10      $1 +xloop LOOP_STACK
__{}  if (($1)>=0x8000 || ($1)<0)=0
__{}    jp   nc, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK   positive step
__{}  else
__{}    jp    c, xdo{}LOOP_STACK     ; 3:10      $1 +xloop LOOP_STACK   negative step
__{}  endif
__{}xleave{}LOOP_STACK:              ;           $1 +xloop LOOP_STACK
__{}xexit{}LOOP_STACK:               ;           $1 +xloop LOOP_STACK{}dnl
__{}popdef({LEAVE_STACK}){}dnl
__{}popdef({UNLOOP_STACK}){}dnl
__{}popdef({LOOP_STACK}){}dnl
__{}popdef({STOP_STACK}){}dnl
__{}popdef({INDEX_STACK}){}dnl
})dnl
dnl
dnl
dnl
dnl step +loop
dnl ( -- )
define({PUSH_ADDXLOOP},{ifelse($1,{},{
__{}__{}.error {$0}(): Missing parameter!
__{}},
__{}$#,{1},,{
__{}__{}.error {$0}($@): $# parameters found in macro!
__{}})dnl
__{}ifelse(eval($1),{},{X_ADDXLOOP($1)},{dnl
__{}__{}ifelse(eval($1),{1},{
__{}__{}__{}                        ;           push_addxloop($1) --> xloop LOOP_STACK{}XLOOP{}},
__{}__{}eval($1),{-1},{dnl
__{}__{}__{}SUB1_ADDXLOOP{}},
__{}__{}eval($1),{2},{dnl
__{}__{}__{}_ADD2_ADDXLOOP{}},
__{}__{}eval($1>0),{1},{dnl
__{}__{}__{}POSITIVE_ADDXLOOP($1)},
__{}__{}{dnl
__{}__{}__{}NEGATIVE_ADDXLOOP($1)})dnl
__{}}){}dnl
}){}dnl
dnl
dnl
dnl
define({ADDXLOOP},{ifelse({fast},{slow},{
__{}    ld    B, H          ; 1:4       +xloop LOOP_STACK
__{}    ld    C, L          ; 1:4       +xloop LOOP_STACK   BC = step
__{}idx{}LOOP_STACK EQU $+1          ;           +xloop LOOP_STACK
__{}    ld   HL, 0x0000     ; 3:10      +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      +xloop LOOP_STACK   save index{}dnl
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
__{}    ld    H, A          ; 1:4       +xloop LOOP_STACK   HL = stop-(index+step)
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = stop-index
__{}    xor   H             ; 1:4       +xloop LOOP_STACK
__{}    ex   DE, HL         ; 1:4       +xloop LOOP_STACK
__{}    pop  DE             ; 1:10      +xloop LOOP_STACK
__{}    jp    p, xdo{}LOOP_STACK     ; 3:10      +xloop LOOP_STACK
                        ;24:114},
__{}{fast},{small},{
__{}    push DE             ; 1:11      +xloop LOOP_STACK
__{}idx{}LOOP_STACK EQU $+1          ;           +xloop LOOP_STACK
__{}    ld   DE, 0x0000     ; 3:10      +xloop LOOP_STACK   DE = index
__{}    add  HL, DE         ; 1:11      +xloop LOOP_STACK   HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      +xloop LOOP_STACK   save index
__{}    ld   BC, format({%-11s},-1*(STOP_STACK)); 3:10      +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = index+step-stop
__{}    ld    A, H          ; 1:4       +xloop LOOP_STACK
__{}    ex   DE, HL         ; 1:4       +xloop LOOP_STACK
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = index-stop
__{}    xor   H             ; 1:4       +xloop LOOP_STACK
__{}    pop  HL             ; 1:10      +xloop LOOP_STACK
__{}    pop  DE             ; 1:10      +xloop LOOP_STACK
__{}    jp    p, xdo{}LOOP_STACK     ; 3:10      +xloop LOOP_STACK
                        ;21:122},
__{}{
__{}idx{}LOOP_STACK EQU $+1          ;           +xloop LOOP_STACK
__{}    ld   BC, 0x0000     ; 3:10      +xloop LOOP_STACK   BC = index
__{}    add  HL, BC         ; 1:11      +xloop LOOP_STACK   HL = index+step
__{}    ld  (idx{}LOOP_STACK), HL    ; 3:16      +xloop LOOP_STACK   save index
__{}    ld    A, L          ; 1:4       +xloop LOOP_STACK
__{}    sub   low format({%-10s},STOP_STACK); 2:7       +xloop LOOP_STACK
__{}    ld    A, H          ; 1:4       +xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},STOP_STACK); 2:7       +xloop LOOP_STACK
__{}    ld    H, A          ; 1:4       +xloop LOOP_STACK   H = hi index+step-stop
__{}    ld    A, C          ; 1:4       +xloop LOOP_STACK
__{}    sub   low format({%-10s},STOP_STACK); 2:7       +xloop LOOP_STACK
__{}    ld    A, B          ; 1:4       +xloop LOOP_STACK
__{}    sbc   A, high format({%-6s},STOP_STACK); 2:7       +xloop LOOP_STACK   A = hi index-stop
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
    ld   HL, (idx{}LOOP_STACK)   ; 3:16      index xi LOOP_STACK   idx always points to a 16-bit index}){}dnl
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
__{} 3:16      index xj LOOP_STACK   idx always points to a 16-bit index}){}dnl
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
__{} 3:16      index xk LOOP_STACK   idx always points to a 16-bit index}){}dnl
dnl
dnl
dnl
