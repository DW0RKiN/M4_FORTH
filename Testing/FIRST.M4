changequote(`{', `}')dnl
ifdef({__pathlib__},,define({__pathlib__},{../M4/}))dnl
include(__pathlib__{if.m4})dnl
include(__pathlib__{logic.m4})dnl
include(__pathlib__{loop.m4})dnl
include(__pathlib__{function.m4})dnl
include(__pathlib__{device.m4})dnl
include(__pathlib__{arithmetic.m4})dnl
include(__pathlib__{other.m4})dnl
include(__pathlib__{stack.m4})dnl
dnl
