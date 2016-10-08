#******************************************************************************
#
# Makefile - Rules for building the Idle Profile example.
#
#	v- 1.2.0
#
#*****************************************************************************

.PHONY: all clean

# The base SDK directory.
SDK_ROOT=../../..

# Sources root directory
SRC_ROOT=..

# Lib Name
EXE_NAME=idle_profile

# the order of libs are important
# simplelink depends from oslib & middleware
# middleware depends from driverlib & oslib
# oslib & driverlib not have explicit dependencies
USE_LIBS=simplelink middleware driverlib oslib

#for use full libc (for float printing), use `full`
#default is `nano`
LIBC_TYPE=nano

# Sources
SOURCES=main.c pinmux.c lp3p0_board.c lp3p0_plat_ops.c wdt_if.c utils_if.c startup_gcc.c

# make all targets by vars defined here
include $(SDK_ROOT)/example/common/gcc/common.make
