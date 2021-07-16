ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)

ifeq "$(PLATFORM)" "linux"
	ZAP = zap
else
	ZAP = 
endif

# PROGS = access cdpwd changemod devrdev filetype mycd umask unlink $(ZAP)
PROGS += filetype
# PROGS += access 
# MOREPROGS = ftw8


all: $(PROGS) #$(MOREPROGS)

# $(PROGS): $(LIBAPUE)
%: %.c $(LIBAPUE)
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)

# ftw8: ftw8.c $(LIBAPUE)
# 	$(CC) $(CFLAGS) $(NAMEMAX) ftw8.c -o ftw8 $(LDFLAGS) $(LDLIBS)

clean:
	rm -rf $(PROGS) $(TEMPFILES) $(ZAP) $(MOREPROGS)

include $(ROOT)/Make.libapue.inc