ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)


ifeq "$(PLATFORM)" "linux"
	EXTRALIBS=-pthread
endif


PROGS += test_getopt
# PROGS += test_getopt


all: $(PROGS) 

# $(PROGS): $(LIBAPUE)
%: %.c $(LIBAPUE)
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)

clean:
	rm -rf $(PROGS) $(TEMPFILES)

include $(ROOT)/Make.libapue.inc 