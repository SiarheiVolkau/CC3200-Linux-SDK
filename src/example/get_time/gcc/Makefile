#******************************************************************************
#
# Makefile - Rules for building the Get Time example.
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
EXE_NAME=get_time

# the order of libs are important
# simplelink depends from oslib & driverlib
# oslib & driverlib not have explicit dependencies
USE_LIBS=simplelink driverlib oslib

#for use full libc (for float printing), use `full`
#default is `nano`
LIBC_TYPE=nano

# Sources
SOURCES=main.c pinmux.c gpio_if.c timer_if.c udma_if.c uart_if.c network_if.c startup_gcc.c

# make all targets by vars defined here
include $(SDK_ROOT)/example/common/gcc/common.make
