#******************************************************************************
#
# middleware.inc - Rules for building some example with middleware library.
#                  Included automatically by common.make
#
#	v- 1.2.0
#
#*****************************************************************************

PM_PATH ?= $(SDK_ROOT)/middleware

IPATH += -I$(PM_PATH)/include
IPATH += -I$(PM_PATH)/driver
IPATH += -I$(PM_PATH)/driver/hal
IPATH += -I$(PM_PATH)/framework/pm
IPATH += -I$(PM_PATH)/framework/timer
IPATH += -I$(PM_PATH)/soc

DEBUG_LDLIBS+='$(PM_PATH)/gcc/lib/Debug/middleware.a'
RELEASE_LDLIBS+='$(PM_PATH)/gcc/lib/Release/middleware.a'
