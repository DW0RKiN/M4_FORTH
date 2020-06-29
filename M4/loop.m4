dnl ## Loop
define({__},{})dnl
define(LOOP_COUNT,100)dnl
dnl
dnl Discard the loop-control parameters for the current nesting level.
define({UNLOOP},{UNLOOP_STACK}){}dnl
dnl
dnl Leaves the loop.
define({LEAVE},{LEAVE_STACK}){}dnl
dnl
dnl
include(M4PATH{}loop/begin.m4)dnl
include(M4PATH{}loop/do_loop.m4)dnl
include(M4PATH{}loop/for_next.m4)dnl
include(M4PATH{}loop/rdo_rloop.m4)dnl
include(M4PATH{}loop/sdo_sloop.m4)dnl
include(M4PATH{}loop/xdo_xloop.m4)dnl
dnl
dnl
dnl
