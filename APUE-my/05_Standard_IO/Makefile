ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)

PROGS += fwide
PROGS += getcputc
PROGS += getcharbug
PROGS += fgetsfputs
PROGS += buf
PROGS += tempfiles
PROGS += mkstemp
PROGS += memstr

all: $(PROGS) 

$(PROGS): $(LIBAPUE)
# %: %.c $(LIBAPUE)
	$(CC) $(CFLAGS) -g $@.c -o $@ $(LDFLAGS) $(LDLIBS)

clean:
	rm -rf $(PROGS) $(TEMPFILES) *hole 

include $(ROOT)/Make.libapue.inc 