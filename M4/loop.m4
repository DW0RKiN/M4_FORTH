dnl ## Loop
define({__},{})dnl
define({LOOP_COUNT},100)dnl
dnl
dnl Discard the loop-control parameters for the current nesting level.
define({UNLOOP},{UNLOOP_STACK}){}dnl
dnl
dnl Leaves the loop.
define({LEAVE},{LEAVE_STACK}){}dnl
dnl
dnl
define({LEAVE},{dnl
__{}__ADD_TOKEN({__TOKEN_LEAVE},{leave_}LOOP_STACK,LOOP_STACK,LEAVE_STACK)}){}dnl
dnl
define({__ASM_TOKEN_LEAVE},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    $2}){}dnl
dnl
dnl
define({UNLOOP},{dnl
__{}__ADD_TOKEN({__TOKEN_UNLOOP},{unloop_}LOOP_STACK,LOOP_STACK,UNLOOP_STACK)}){}dnl
dnl
define({__ASM_TOKEN_UNLOOP},{dnl
__{}define({__INFO},__COMPILE_INFO)
__{}    $2}){}dnl
dnl
dnl
include(M4PATH{}loop/begin.m4)dnl
include(M4PATH{}loop/do_loop.m4)dnl
include(M4PATH{}loop/for_next.m4)dnl
include(M4PATH{}loop/rdo_rloop.m4)dnl
include(M4PATH{}loop/rfor_rnext.m4)dnl
include(M4PATH{}loop/rxdo_rxloop.m4)dnl
include(M4PATH{}loop/sdo_sloop.m4)dnl
include(M4PATH{}loop/sfor_snext.m4)dnl
include(M4PATH{}loop/xdo_xloop.m4)dnl
dnl
dnl
dnl
