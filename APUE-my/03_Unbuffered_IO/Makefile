ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)

PROGS += seek
PROGS += hole
PROGS += mycat
PROGS += fileflags
# PROGS += setfl

all: $(PROGS) 

$(PROGS): $(LIBAPUE)
# %: %.c $(LIBAPUE)
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)

clean:
	rm -rf $(PROGS) $(TEMPFILES) *hole 

include $(ROOT)/Make.libapue.inc 