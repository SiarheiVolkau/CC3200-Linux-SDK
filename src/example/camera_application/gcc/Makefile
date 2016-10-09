#******************************************************************************
#
# Makefile - Rules for building the Camera Application example.
#
#	v- 1.2.0
#
#*****************************************************************************

.PHONY: all clean

#capture configuration
# image size [QVGA/VGA/XGA]
FRAME_SIZE ?= QVGA
#format [jpeg/any other - raw]
FRAME_FORMAT ?= jpeg

ifeq (VGA,$(FRAME_SIZE))
	FRAME_FORMAT = jpeg
endif
ifeq (XGA,$(FRAME_SIZE))
	FRAME_FORMAT = jpeg
endif

CFLAGS += -D$(FRAME_SIZE)_FRAME

ifeq (jpeg,$(FRAME_FORMAT))
	CFLAGS += -DENABLE_JPEG
endif


# The base SDK directory.
SDK_ROOT=../../..

# Sources root directory
SRC_ROOT=..

# Lib Name
EXE_NAME=camera_application

USE_LIBS=simplelink oslib driverlib

#for use full libc (for float printing), use `full`
#default is `nano`
LIBC_TYPE=nano

# Sources
SOURCES=camera_app.c i2cconfig.c mt9d111.c main.c uart_if.c udma_if.c pinmux.c startup_gcc.c

# make all targets by vars defined here
include $(SDK_ROOT)/example/common/gcc/common.make
