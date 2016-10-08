#******************************************************************************
#
# driverlib.inc - Rules for building some example with driverlib.
#                 Included automatically by common.make
#
#	v- 1.2.0
#
#*****************************************************************************

DRIVERLIB_PATH ?= $(SDK_ROOT)/driverlib

IPATH += -I$(SDK_ROOT)/inc
IPATH += -I$(DRIVERLIB_PATH)

DEBUG_LDLIBS+='$(DRIVERLIB_PATH)/gcc/lib/Debug/libdriver.a'
RELEASE_LDLIBS+='$(DRIVERLIB_PATH)/gcc/lib/Release/libdriver.a'
