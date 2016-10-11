#
# Copyright 2014-2016 CyberVision, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)

set(ARM_GCC_COMPILER "arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX}")

# Find toolchain path

if (NOT DEFINED ENV{CC32XX_TOOLCHAIN_PATH})
  # Check if GCC is reachable.
  find_path(TOOLCHAIN_PATH bin/${ARM_GCC_COMPILER})

  if (NOT TOOLCHAIN_PATH)
    # Set default path.
    set(TOOLCHAIN_PATH "/usr/bin/gcc-arm-none-eabi")
    message(STATUS "GCC not found, default path will be used")
  endif ()
else ()
  set(TOOLCHAIN_PATH "$ENV{CC32XX_TOOLCHAIN_PATH}")
  message(STATUS "Toolchain path is provided: ${TOOLCHAIN_PATH}")
endif ()

# Find CC32XX SDK

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
	set(PROJECT_CFLAGS "-Dgcc -O0 ${PROJECT_CFLAGS}")
else ()
	set(PROJECT_CFLAGS "-Dgcc -DTARGET_IS_CC3200 -Os ${PROJECT_CFLAGS}")
	set(CC3200_LIB_TYPE "Release")
endif ()

#
# append dependent libs
#
if (CC3200_USE_LIBS MATCHES "middleware")
	set(CC3200_USE_LIBS "${CC3200_USE_LIBS} driverlib")
endif()

#
# include specific libs
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

# Specify target's environment
set(CMAKE_FIND_ROOT_PATH "${TOOLCHAIN_PATH}/arm-none-eabi/")

set(CMAKE_C_COMPILER   "${TOOLCHAIN_PATH}/bin/arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_CXX_COMPILER "${TOOLCHAIN_PATH}/bin/arm-none-eabi-g++${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_C_LINKER     "${TOOLCHAIN_PATH}/bin/arm-none-eabi-ld${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_CXX_LINKER   "${TOOLCHAIN_PATH}/bin/arm-none-eabi-ld${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_OBJCOPY
        "${TOOLCHAIN_PATH}/bin/arm-none-eabi-objcopy${CMAKE_EXECUTABLE_SUFFIX}"
        CACHE STRING "Objcopy" FORCE)

CMAKE_FORCE_C_COMPILER(${CMAKE_C_COMPILER} GNU)
CMAKE_FORCE_CXX_COMPILER(${CMAKE_CXX_COMPILER} GNU)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CPU_FLAGS "-mthumb -mcpu=cortex-m4")
set(CMAKE_C_FLAGS "${CPU_FLAGS} -ffunction-sections -fdata-sections -g -Wall ${PROJECT_CFLAGS}" CACHE STRING "C flags" FORCE)

set(CC3200_SDK_ROOT "${CC3200_SDK_ROOT}" CACHE STRING "SDK location" FORCE)

set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS)    # remove -rdynamic
set(CMAKE_EXE_LINK_DYNAMIC_C_FLAGS)       # remove -Wl,-Bdynamic

execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libgcc.a" OUTPUT_VARIABLE LIBGCC_PATH)
string(STRIP "${LIBGCC_PATH}" LIBGCC_PATH)
execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libnosys.a" OUTPUT_VARIABLE LIBNOSYS_PATH)
string(STRIP "${LIBNOSYS_PATH}" LIBNOSYS_PATH)
execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libc_nano.a" OUTPUT_VARIABLE LIBC_NANO_PATH)
string(STRIP "${LIBC_NANO_PATH}" LIBC_NANO_PATH)
execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libc.a" OUTPUT_VARIABLE LIBC_PATH)
string(STRIP "${LIBC_PATH}" LIBC_PATH)
execute_process(COMMAND ${CMAKE_C_COMPILER} "-mthumb" "-mcpu=cortex-m4" "-print-file-name=libm.a" OUTPUT_VARIABLE LIBM_PATH)
string(STRIP "${LIBM_PATH}" LIBM_PATH)

#
# use newlib or newlib-nano
#
if (NEWLIB MATCHES full)
	set(STDLIBS "'${LIBC_PATH}' '${LIBM_PATH}' '${LIBGCC_PATH}'")
else ()
	set(STDLIBS "'${LIBC_NANO_PATH}' '${LIBM_PATH}' '${LIBGCC_PATH}' '${LIBNOSYS_PATH}'")
endif ()

#
# use default or provided linker script
#
if (NOT DEFINED LINKER_SCRIPT)
	set(LINKER_SCRIPT "${CC3200_SDK_ROOT}/example/common/gcc/cc3200r1m2.ld")
endif ()

#
# linker commandline
#
set(CMAKE_C_LINK_EXECUTABLE
        "${CMAKE_C_LINKER} -T${LINKER_SCRIPT} -Map output.map --entry ResetISR --gc-sections -o <TARGET> <OBJECTS> <LINK_LIBRARIES> ${LINK_LIBS} ${STDLIBS}")
