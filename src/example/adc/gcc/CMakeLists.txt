########################################################################
#
# Cmake build script for ADC example
#
# type following commands in console for build project
#   mkdir build && cd build
#   cmake -DCMAKE_BUILD_TYPE=<Debug|Release> ..
#   make
#
########################################################################

cmake_minimum_required(VERSION 2.6)

# name of the final binary files
set(TARGET_NAME "adc")

project(${TARGET_NAME} C)

# define required variable for
# common part of build script
set(CC3200_SDK_ROOT "../../..")
set(CC3200_USE_LIBS "driverlib")
set(NEWLIB "full")

set(CC3200_EXAMPLE_COMMON_PATH "${CC3200_SDK_ROOT}/example/common")
include(${CC3200_EXAMPLE_COMMON_PATH}/gcc/common.cmake)

set(CC3200_PROJECT_ROOT "..")

add_executable(${TARGET_NAME}
	${CC3200_PROJECT_ROOT}/adc_userinput.c
	${CC3200_PROJECT_ROOT}/main.c
	${CC3200_PROJECT_ROOT}/pinmux.c

	${CC3200_EXAMPLE_COMMON_PATH}/uart_if.c
	${CC3200_EXAMPLE_COMMON_PATH}/startup_gcc.c
)

include_directories(${CC3200_EXAMPLE_COMMON_PATH})

set_target_properties(${TARGET_NAME} PROPERTIES PREFIX "" SUFFIX ".elf")

add_custom_command(OUTPUT ${TARGET_NAME}.tmp
                   COMMAND ${CMAKE_OBJCOPY} -O binary ${TARGET_NAME}.elf ${TARGET_NAME}.tmp
                   COMMAND ${CMAKE_COMMAND} -E copy ${TARGET_NAME}.tmp ${TARGET_NAME}.bin
                   COMMAND ${CMAKE_COMMAND} -E remove ${TARGET_NAME}.tmp
                   DEPENDS ${TARGET_NAME}
                   COMMENT "Making binary file ${TARGET_NAME}.bin")
add_custom_target(${TARGET_NAME}.bin ALL DEPENDS ${TARGET_NAME}.tmp)
get_directory_property(PROP_CLEAN_FILES ADDITIONAL_MAKE_CLEAN_FILES)
set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${PROP_CLEAN_FILES}${TARGET_NAME}.bin;${TARGET_NAME}.tmp;")
