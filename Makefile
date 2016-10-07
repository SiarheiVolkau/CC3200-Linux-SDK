#******************************************************************************
#
# Makefile - Rules for building all the stuff.
#
#	v- 1.2.0
#
#*****************************************************************************

SDK_LIBS = driverlib simplelink oslib middleware
SDK_EXAMPLES = driverlib simplelink oslib middleware

.PHONY: all clean

all: libs examples

clean: clean_libs clean_examples

libs: $(SDK_LIBS:%=lib/%)

lib/%: src/%/gcc/Makefile
	@$(MAKE) -C "$(dir $<)" all

clean_libs: $(SDK_LIBS:%=clean_lib/%)

clean_lib/%: src/%/gcc/Makefile
	@$(MAKE) -C "$(dir $<)" clean

examples: #TODO
