#******************************************************************************
#
# mqtt_server.inc - Rules for building some example with MQTT
#                   client/server library.
#                   Included automatically by common.make
#
#	v- 1.2.0
#
#*****************************************************************************

NETAPPS_PATH ?= $(SDK_ROOT)/netapps
MQTT_CLIENT_SERVER_LIB_PATH ?= $(NETAPPS_PATH)/mqtt

IPATH += -I$(MQTT_CLIENT_SERVER_LIB_PATH)/include

DEBUG_LDLIBS+='$(MQTT_CLIENT_SERVER_LIB_PATH)/gcc/lib/client_server/Debug/libmqtt.a'
RELEASE_LDLIBS+='$(MQTT_CLIENT_SERVER_LIB_PATH)/gcc/lib/client_server/Release/libmqtt.a'
