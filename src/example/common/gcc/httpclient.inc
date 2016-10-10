#******************************************************************************
#
# httpclient.inc - Rules for building some example with http client library.
#                  Included automatically by common.make
#
#	v- 1.2.0
#
#*****************************************************************************

NETAPPS_PATH ?= $(SDK_ROOT)/netapps
HTTP_CLIENT_PATH = $(NETAPPS_PATH)/http/client

IPATH += -I$(NETAPPS_PATH)

ifeq (,$(findstring oslib,$(USE_LIBS)))
    DEBUG_LDLIBS+='$(HTTP_CLIENT_PATH)/gcc/lib/min/Debug/libwebclient.a'
    RELEASE_LDLIBS+='$(HTTP_CLIENT_PATH)/gcc/lib/min/Release/libwebclient.a'
    DEBUG_CFLAGS+=-DHTTPCli_LIBTYPE_MIN
    RELEASE_CFLAGS+=-DHTTPCli_LIBTYPE_MIN
else
    DEBUG_LDLIBS+='$(HTTP_CLIENT_PATH)/gcc/lib/full/Debug/libwebclient.a'
    RELEASE_LDLIBS+='$(HTTP_CLIENT_PATH)/gcc/lib/full/Release/libwebclient.a'
endif
