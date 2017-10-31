set(CMAKE_SYSTEM_NAME Generic)

set(ARM_GCC_COMPILER "arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX}")

# Find toolchain path

if (NOT DEFINED TOOLCHAIN_PATH)
  # Check if GCC is reachable.
  find_path(TOOLCHAIN_PATH ${ARM_GCC_COMPILER} PATHS /usr)

  if (NOT TOOLCHAIN_PATH)
    # Set default path.
    set(TOOLCHAIN_PATH "/usr/bin")
    message(STATUS "GCC not found, default path will be used")
  endif ()
endif ()

# Specify target's environment
set(CMAKE_FIND_ROOT_PATH "${TOOLCHAIN_PATH}/arm-none-eabi/")

set(CMAKE_C_COMPILER   "${TOOLCHAIN_PATH}/arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_CXX_COMPILER "${TOOLCHAIN_PATH}/arm-none-eabi-g++${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_C_LINKER     "${TOOLCHAIN_PATH}/arm-none-eabi-ld${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_CXX_LINKER   "${TOOLCHAIN_PATH}/arm-none-eabi-ld${CMAKE_EXECUTABLE_SUFFIX}")
set(CMAKE_OBJCOPY
        "${TOOLCHAIN_PATH}/arm-none-eabi-objcopy${CMAKE_EXECUTABLE_SUFFIX}"
        CACHE STRING "Objcopy" FORCE)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

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

set(STDLIBS "'${LIBC_NANO_PATH}' '${LIBM_PATH}' '${LIBGCC_PATH}' '${LIBNOSYS_PATH}'")

set(CMAKE_C_LINK_EXECUTABLE "${CMAKE_C_LINKER} --gc-sections -o <TARGET> <OBJECTS> <LINK_LIBRARIES> ${STDLIBS}")
