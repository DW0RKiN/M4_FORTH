changequote(`{', `}')dnl
dnl
sinclude(./path0.m4)dnl
sinclude(./path1.m4)dnl
sinclude(./path2.m4)dnl
sinclude(./M4/path0.m4)dnl
sinclude(./M4/path1.m4)dnl
sinclude(./M4/path2.m4)dnl
sinclude(../M4/path0.m4)dnl
sinclude(../M4/path1.m4)dnl
sinclude(../M4/path2.m4)dnl
ifelse(M4PATH,{},{
.error M4 did not find a relative path from the source file to the M4 libraries.})dnl
include(M4PATH{}float.m4)dnl
include(M4PATH{}if.m4)dnl
include(M4PATH{}logic.m4)dnl
include(M4PATH{}function.m4)dnl
include(M4PATH{}loop.m4)dnl
include(M4PATH{}device.m4)dnl
include(M4PATH{}arithmetic.m4)dnl
include(M4PATH{}other.m4)dnl
include(M4PATH{}stack.m4)dnl
dnl
dnl
