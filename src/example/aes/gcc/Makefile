#******************************************************************************
#
# Makefile - Rules for building the AES example.
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
EXE_NAME=aes

USE_LIBS=driverlib

#use full libc for float printing, used in this example
#default is `nano`
LIBC_TYPE=nano

# Sources
SOURCES=aes_userinput.c main.c pinmux.c uart_if.c startup_gcc.c

# make all targets by vars defined here
include $(SDK_ROOT)/example/common/gcc/common.make
