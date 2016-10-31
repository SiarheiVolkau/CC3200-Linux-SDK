#******************************************************************************
#
# json.inc - Rules for building some example with JSON library.
#            Included automatically by common.make
#
#	v- 1.2.0
#
#*****************************************************************************

JSON_LIB_PATH ?= $(SDK_ROOT)/netapps/json

IPATH += -I$(JSON_LIB_PATH)

DEBUG_LDLIBS+='$(OSLIB_PATH)/gcc/lib/Debug/libjson.a'
RELEASE_LDLIBS+='$(OSLIB_PATH)/gcc/lib/Release/libjson.a'
