#******************************************************************************
#
# Makefile - Rules for building the File Download example.
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
EXE_NAME=file_download

USE_LIBS=httpclient simplelink driverlib

#for use full libc (for float printing), use `full`
#default is `nano`
LIBC_TYPE=nano

# Sources
SOURCES=main.c pinmux.c uart_if.c startup_gcc.c

# make all targets by vars defined here
include $(SDK_ROOT)/example/common/gcc/common.make
