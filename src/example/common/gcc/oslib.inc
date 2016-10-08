#******************************************************************************
#
# oslib.inc - Rules for building some example with oslib (freertos).
#             Included automatically by common.make
#
#	v- 1.2.0
#
#*****************************************************************************

OSLIB_PATH ?= $(SDK_ROOT)/oslib

IPATH += -I$(SDK_ROOT)/oslib

DEBUG_LDLIBS+='$(OSLIB_PATH)/gcc/free_rtos/Debug/free_rtos.a'
RELEASE_LDLIBS+='$(OSLIB_PATH)/gcc/free_rtos/Release/free_rtos.a'

DEBUG_CFLAGS+=-DUSE_FREERTOS
RELEASE_CFLAGS+=-DUSE_FREERTOS
