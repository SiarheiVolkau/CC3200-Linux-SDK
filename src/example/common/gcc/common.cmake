#
# use specific compiler flags
#
set(CPU_FLAGS "-mthumb -mcpu=cortex-m4")
set(CMAKE_C_FLAGS "${CPU_FLAGS} -ffunction-sections -fdata-sections -g -Wall -Dgcc")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS} -O0" CACHE STRING "Debug compiler flags" FORCE)
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} -Os -DTARGET_IS_CC3200" CACHE STRING "Release compiler flags" FORCE)
set(CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS} -Os -DTARGET_IS_CC3200")
set(CMAKE_C_FLAGS_MINSIZEREL "${CMAKE_C_FLAGS} -Os -DTARGET_IS_CC3200")

#
# Find CC32XX SDK
#
if (NOT DEFINED CC3200_SDK_ROOT)
  message(ERROR "SDK location is not defined (CC3200_SDK_ROOT)")
else ()
# absolutize SDK root path
  get_filename_component(CC3200_SDK_ROOT "${CC3200_SDK_ROOT}" ABSOLUTE)
endif ()

message(STATUS "CC32XX SDK path: ${CC3200_SDK_ROOT}")
message(STATUS "Toolchain path: ${TOOLCHAIN_PATH}")
include_directories(${CC3200_SDK_ROOT}/inc)

if(CMAKE_BUILD_TYPE MATCHES Debug)
	set(CC3200_LIB_TYPE "Debug")
else ()
	set(CC3200_LIB_TYPE "Release")
endif ()

#
# append dependent libs
#
if (CC3200_USE_LIBS MATCHES "middleware")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} driverlib")
endif()

#
# include requested libs
#
if (CC3200_USE_LIBS MATCHES "driverlib")
	message(STATUS "Using driverlib library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/driverlib/gcc/lib/${CC3200_LIB_TYPE}/libdriver.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/driverlib)
endif()

if (CC3200_USE_LIBS MATCHES "middleware")
	message(STATUS "Using middleware library.")
	include_directories(
		${CC3200_SDK_ROOT}/middleware/driver/
		${CC3200_SDK_ROOT}/middleware/driver/hal/
		${CC3200_SDK_ROOT}/middleware/framework/pm/
		${CC3200_SDK_ROOT}/middleware/framework/timer/
		${CC3200_SDK_ROOT}/middleware/soc/
	)
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/middleware/gcc/lib/${CC3200_LIB_TYPE}/middleware.a' ${LINK_LIBS}")
endif()

if (CC3200_USE_LIBS MATCHES "oslib")
	message(STATUS "Using oslib (FreeRTOS based) library.")
	include_directories(${CC3200_SDK_ROOT}/oslib)
	add_definitions(-DUSE_FREERTOS)
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/oslib/gcc/free_rtos/${CC3200_LIB_TYPE}/free_rtos.a' ${LINK_LIBS}")
endif()

if (CC3200_USE_LIBS MATCHES "simplelink")
	message(STATUS "Using simplelink library.")
	include_directories(
		${CC3200_SDK_ROOT}/simplelink
		${CC3200_SDK_ROOT}/simplelink/include
	)
	add_definitions(-D__SL__)
	if (CC3200_USE_LIBS MATCHES "oslib")
		add_definitions(-DSL_PLATFORM_MULTI_THREADED)
		if (CC3200_USE_LIBS MATCHES "middleware")
			set(LINK_LIBS "'${CC3200_SDK_ROOT}/simplelink/gcc/lib/os_PM/${CC3200_LIB_TYPE}/libsimplelink.a' ${LINK_LIBS}")
		else ()
			set(LINK_LIBS "'${CC3200_SDK_ROOT}/simplelink/gcc/lib/os/${CC3200_LIB_TYPE}/libsimplelink.a' ${LINK_LIBS}")
		endif ()
	else()
		set(LINK_LIBS "'${CC3200_SDK_ROOT}/simplelink/gcc/lib/nonos/${CC3200_LIB_TYPE}/libsimplelink.a' ${LINK_LIBS}")
	endif()
endif()

if (CC3200_USE_LIBS MATCHES "json")
	message(STATUS "Using JSON library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/netapps/json/gcc/lib/${CC3200_LIB_TYPE}/libjson.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/netapps/json)
endif()

if (CC3200_USE_LIBS MATCHES "mqtt-client")
	message(STATUS "Using MQTT Client library.")
	set(LINK_LIBS "'${CC3200_SDK_ROOT}/netapps/mqtt/gcc/lib/client/${CC3200_LIB_TYPE}/libmqtt.a' ${LINK_LIBS}")
	include_directories(${CC3200_SDK_ROOT}/netapps/mqtt/include)
endif()


set(CC3200_SDK_ROOT "${CC3200_SDK_ROOT}" CACHE STRING "SDK location" FORCE)

#
# use newlib or newlib-nano
# default is newlib-nano (declared in compiler.cmake)
#
if (NEWLIB STREQUAL full)
	set(STDLIBS "'${LIBC_PATH}' '${LIBM_PATH}' '${LIBGCC_PATH}' '${LIBNOSYS_PATH}'")
else()
	set(NEWLIB nano)
endif ()

set(NEWLIB "${NEWLIB}" CACHE STRING "Newlib variant: nano or full (default)." FORCE)

#
# use specific linker script
# default is the script for 256K devices
#
if (CC3200_SRAM_SIZE STREQUAL 128K)
	set(LINKER_SCRIPT "${CC3200_SDK_ROOT}/example/common/gcc/cc3200r1m1.ld")
else ()
	set(CC3200_SRAM_SIZE 256K)
	set(LINKER_SCRIPT "${CC3200_SDK_ROOT}/example/common/gcc/cc3200r1m2.ld")
endif ()

set(CC3200_SRAM_SIZE "${CC3200_SRAM_SIZE}" CACHE STRING "SRAM size on target: 128K or 256K (default)." FORCE)

#
# linker commandline
#
set(CMAKE_C_LINK_EXECUTABLE
        "${CMAKE_C_LINKER} -T${LINKER_SCRIPT} -Map <TARGET>.map --entry ResetISR --gc-sections -o <TARGET> <OBJECTS> <LINK_LIBRARIES> ${LINK_LIBS} ${STDLIBS}")

