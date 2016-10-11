#******************************************************************************
#
# simplelink.inc - Rules for building some example with simplelink library.
#                  Included automatically by common.make
#
#	v- 1.2.0
#
#*****************************************************************************

SL_PATH ?= $(SDK_ROOT)/simplelink

IPATH += -I$(SL_PATH) -I$(SL_PATH)/include

ifeq (,$(findstring oslib,$(USE_LIBS)))
    DEBUG_LDLIBS+='$(SL_PATH)/gcc/lib/nonos/Debug/libsimplelink.a'
    RELEASE_LDLIBS+='$(SL_PATH)/gcc/lib/nonos/Release/libsimplelink.a'
else
    DEBUG_CFLAGS+=-DSL_PLATFORM_MULTI_THREADED
    RELEASE_CFLAGS+=-DSL_PLATFORM_MULTI_THREADED
    ifeq (,$(findstring middleware,$(USE_LIBS)))
        DEBUG_LDLIBS+='$(SL_PATH)/gcc/lib/os/Debug/libsimplelink.a'
        RELEASE_LDLIBS+='$(SL_PATH)/gcc/lib/os/Release/libsimplelink.a'
    else
        DEBUG_LDLIBS+='$(SL_PATH)/gcc/lib/os_PM/Debug/libsimplelink.a'
        RELEASE_LDLIBS+='$(SL_PATH)/gcc/lib/os_PM/Release/libsimplelink.a'
    endif
endif

DEBUG_CFLAGS+=-D__SL__
RELEASE_CFLAGS+=-D__SL__
