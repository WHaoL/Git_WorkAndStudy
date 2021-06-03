ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)

PROGS += ls1
PROGS += mycat
PROGS += getcputc
PROGS += hello
PROGS += shell1
PROGS += testerror
PROGS += uidgid
PROGS += shell2

all: $(PROGS) 

$(PROGS): $(LIBAPUE)
# %: %.c $(LIBAPUE)
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)

clean:
	rm -rf $(PROGS) $(TEMPFILES) 

include $(ROOT)/Make.libapue.inc 