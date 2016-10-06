#******************************************************************************
#
# Makefile - Rules for building the Driverlib library.
#
#	v- 1.2.0
#
#*****************************************************************************

# The base SDK directory.
SDK_ROOT=../..

# Sources root directory
SRC_ROOT=..

# Output directory
OUTDIR=lib

# Lib Name
LIBRARY=libdriver.a
DEBUG_LIBRARY=$(OUTDIR)/Debug/${LIBRARY}
RELEASE_LIBRARY=$(OUTDIR)/Release/${LIBRARY}

DEBUG_OBJPATH=obj/Debug
RELEASE_OBJPATH=obj/Release

# Where to find header files
IPATH=-I${SDK_ROOT}

# Tools Setup
ifeq (${CC},cc)
	CC=arm-none-eabi-gcc
endif
ifeq ($(AR),)
	AR=arm-none-eabi-ar
endif

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
SOURCES= adc.c aes.c camera.c cpu.c crc.c des.c flash.c gpio.c hwspinlock.c i2c.c \
	interrupt.c i2s.c pin.c prcm.c sdhost.c shamd5.c spi.c systick.c timer.c \
	uart.c udma.c utils.c wdt.c

# Directory creator
dir_create=@mkdir -p $(@D)

# Objects
DEBUG_OBJECTS= $(addprefix $(DEBUG_OBJPATH)/,$(SOURCES:.c=.o))
RELEASE_OBJECTS= $(addprefix $(RELEASE_OBJPATH)/,$(SOURCES:.c=.o))

all: debug release

debug: $(DEBUG_LIBRARY)

release: $(RELEASE_LIBRARY)

DEBUG_TARGETS= $(addprefix $(DEBUG_OBJPATH)/,$(SOURCES:.c=.o))
$(DEBUG_TARGETS): Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(DEBUG_CFLAGS) $(CFLAGS) -c "$(SRC_ROOT)/$(@:$(DEBUG_OBJPATH)/%.o=%.c)" -o "$@";
	@echo "CC	$@";

RELEASE_TARGETS= $(addprefix $(RELEASE_OBJPATH)/,$(SOURCES:.c=.o))
$(RELEASE_TARGETS): Makefile
	$(dir_create)
	@$(CC) $(CFLAGS_COMMON) $(RELEASE_CFLAGS) $(CFLAGS) -c "$(SRC_ROOT)/$(@:$(RELEASE_OBJPATH)/%.o=%.c)" -o "$@";
	@echo "CC	$@";

$(DEBUG_LIBRARY): $(DEBUG_TARGETS)
	$(dir_create)
	@${AR} -cr $@ $(DEBUG_OBJECTS)
	@echo "AR	$@";

$(RELEASE_LIBRARY): $(RELEASE_TARGETS)
	$(dir_create)
	@${AR} -cr $@ $(RELEASE_OBJECTS)
	@echo "AR	$@";

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
