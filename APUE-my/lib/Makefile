
ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)

LIBMISC = libapue.a 
OBJS    = 	error.o pathalloc.o tellwait.o prexit.o prmask.o lockreg.o locktest.o \
			writen.o readn.o setfl.o setfd.o clrfl.o openmax.o

all: $(LIBMISC) 

$(LIBMISC): $(OBJS)
	$(AR) rv $(LIBMISC) $?
	$(RANLIB) $(LIBMISC)

clean:
	rm -rf *.o a.out core temp.*
# rm -rf *.o a.out core temp.* $(LIBMISC)


# 因为这是 /lib/ 自己的Makefile,不需要第二次生成 libapue.a 所以可以注释掉
#	(不过写上也无妨,只不过;多做了一次检测,但并不会重新生成,因为 目标 依赖 都没有被更改)
# 但是其他文件夹(需要依赖libapue.a的),需要包含这一行,这样就确保了 libapue.a一定生成了
# include $(ROOT)/Make.libapue.inc