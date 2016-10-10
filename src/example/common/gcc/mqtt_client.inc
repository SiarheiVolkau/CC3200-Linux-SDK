#******************************************************************************
#
# mqtt_client.inc - Rules for building some example with MQTT client library.
#                   Included automatically by common.make
#
#	v- 1.2.0
#
#*****************************************************************************

NETAPPS_PATH ?= $(SDK_ROOT)/netapps
MQTT_CLIENT_LIB_PATH ?= $(NETAPPS_PATH)/mqtt

# Avoid simultaneous MQTT client
# and MQTT client/server library usage
ifeq (,$(findstring mqtt_server,$(USE_LIBS)))

    IPATH += -I$(MQTT_CLIENT_LIB_PATH)/include

    DEBUG_LDLIBS+='$(MQTT_CLIENT_LIB_PATH)/gcc/lib/client/Debug/libmqtt.a'
    RELEASE_LDLIBS+='$(MQTT_CLIENT_LIB_PATH)/gcc/lib/client/Release/libmqtt.a'
endif
