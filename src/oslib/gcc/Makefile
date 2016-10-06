#******************************************************************************
#
# Makefile - Rules for building the Osi library.
#
#	v- 1.2.0
#
#*****************************************************************************

# The base SDK directory.
SDK_ROOT=../..

# Sources root directory
SRC_ROOT=..

# The FreeRTOS directory.
RTOSDIR=$(SDK_ROOT)/third_party/FreeRTOS/source

# Output directory
OUTDIR=free_rtos

# Lib Name
LIBRARY=free_rtos.a
DEBUG_LIBRARY=$(OUTDIR)/Debug/${LIBRARY}
RELEASE_LIBRARY=$(OUTDIR)/Release/${LIBRARY}

DEBUG_OBJPATH=obj/Debug
RELEASE_OBJPATH=obj/Release

# Tools Setup
ifeq (,$(CROSS_COMPILE))
	CROSS_COMPILE=arm-none-eabi-
endif
CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar

# Where to find header files
IPATH=  -I${SRC_ROOT}
IPATH+= -I${SDK_ROOT}/inc
IPATH+= -I${SDK_ROOT}/driverlib
IPATH+= -I${RTOSDIR}
IPATH+= -I${RTOSDIR}/include
IPATH+= -I${RTOSDIR}/portable/GCC/ARM_CM4

# C Compiler Flags
CFLAGS_COMMON=-mthumb       \
       -mcpu=cortex-m4      \
       -ffunction-sections  \
       -fdata-sections      \
       -MD                  \
       -std=c99             \
       -Wall                \
       -g                   \
       -Dgcc                \
       $(IPATH)

RELEASE_CFLAGS=-Os -DTARGET_IS_CC3200
DEBUG_CFLAGS=-O0

# Sources
SOURCES= osi_freertos.c \
	croutine.c      \
	list.c          \
	queue.c         \
	tasks.c         \
	port.c          \
	timers.c        \
	heap_4.c

# Directory creator
dir_create=@mkdir -p $(@D)

# Objects
# Objects
DEBUG_OBJECTS= $(SOURCES:%.c=$(DEBUG_OBJPATH)/%.o)
RELEASE_OBJECTS= $(SOURCES:%.c=$(RELEASE_OBJPATH)/%.o)

all: debug release

# Rules for rebuild when dependencies changed
# GCC option -MD enables dependency rules generation
-include $(SOURCES:%.c=$(DEBUG_OBJPATH)/%.d)
-include $(SOURCES:%.c=$(RELEASE_OBJPATH)/%.d)

# *.o build rules
$(DEBUG_OBJPATH)/osi_freertos.o: $(SRC_ROOT)/osi_freertos.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_OBJPATH)/croutine.o: $(RTOSDIR)/croutine.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_OBJPATH)/list.o: $(RTOSDIR)/list.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_OBJPATH)/queue.o: $(RTOSDIR)/queue.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_OBJPATH)/tasks.o: $(RTOSDIR)/tasks.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_OBJPATH)/timers.o: $(RTOSDIR)/timers.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_OBJPATH)/port.o: $(RTOSDIR)/portable/GCC/ARM_CM4/port.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(DEBUG_OBJPATH)/heap_4.o: $(RTOSDIR)/portable/MemMang/heap_4.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/osi_freertos.o: $(SRC_ROOT)/osi_freertos.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/croutine.o: $(RTOSDIR)/croutine.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/list.o: $(RTOSDIR)/list.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/queue.o: $(RTOSDIR)/queue.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/tasks.o: $(RTOSDIR)/tasks.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/timers.o: $(RTOSDIR)/timers.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/port.o: $(RTOSDIR)/portable/GCC/ARM_CM4/port.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

$(RELEASE_OBJPATH)/heap_4.o: $(RTOSDIR)/portable/MemMang/heap_4.c Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$<" -o "$@";
	@echo "CC	$@";

# *.a build rules
$(DEBUG_LIBRARY): $(DEBUG_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_OBJECTS)
	@echo "AR	$@";

$(RELEASE_LIBRARY): $(RELEASE_OBJECTS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_OBJECTS)
	@echo "AR	$@";

# Rules for build release & debug libs
debug: $(DEBUG_LIBRARY)

release: $(RELEASE_LIBRARY)

# clean rules
clean_debug:
	@rm -rf $(DEBUG_OBJPATH)/*.d
	@echo "rm -rf $(DEBUG_OBJPATH)/*.d";
	@rm -rf $(DEBUG_OBJPATH)/*.o
	@echo "rm -rf $(DEBUG_OBJPATH)/*.o";
	@rm -rf $(DEBUG_LIBRARY)
	@echo "rm -rf $(DEBUG_LIBRARY)";

clean_release:
	@rm -rf $(RELEASE_OBJPATH)/*.d
	@echo "rm -rf $(RELEASE_OBJPATH)/*.d";
	@rm -rf $(RELEASE_OBJPATH)/*.o
	@echo "rm -rf $(RELEASE_OBJPATH)/*.o";
	@rm -rf $(RELEASE_LIBRARY)
	@echo "rm -rf $(RELEASE_LIBRARY)";

clean: clean_debug clean_release

.PHONY: all clean
