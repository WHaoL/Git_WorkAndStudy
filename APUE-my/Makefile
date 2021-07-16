# DIRS = 	01_UNIX_System_Overview  02_UNIX_Standard  03_Unbuffered_IO \
# 		04_FILE_DIR              05_Standard_IO    06_System_Info   \
# 		07_Process_Env           08_Process_Ctl    09_Process_Rel 	\
# 		10_Process_Rel           10_Signals        11_Threads 		\
# 		12_ThreadCtl             13_Daemons        14_Advanced_IO 	\
# 		15_IPC					 lib

DIRS += lib
DIRS += 01_UNIX_System_Overview
DIRS += 03_Unbuffered_IO

all:
	for i in $(DIRS); do \
		(cd $$i && echo "making $$i" && $(MAKE)) || exit 1; \
	done

clean:
	for i in $(DIRS); do \
		(cd $$i && echo "cleaning $$i" && $(MAKE) clean) || exit 1; \
	done






#在Makefile中 $(MAKE) ==> make
# echoMAKE:
# 	echo $(MAKE)


# # https://blog.csdn.net/u012989012/article/details/80572043
# # makefile '@' '$' '$$' '-' '-n ' 使用小结
# 	'@'符号的使用
# 		通常makefile会将其执行的命令行在执行前输出到屏幕上。
# 		如果将‘@’添加到命令行前，这个命令将不被make回显出来。
# 		示例：
# 			@echo  --compiling module----;  //      屏幕输出  --compiling module----
# 			echo  --compiling module----;   // 没有@ 屏幕输出  echo  --compiling module----  
# 	'-'符号的使用
# 		通常删除，创建文件如果碰到文件不存在或者已经创建，
# 		那么希望忽略掉这个错误，继续执行，就可以在命令前面添加 -，
# 		示例：
# 			-rm dir;
# 			-mkdir aaadir;
# 	'$'符号的使用
# 		美元符号$，主要扩展打开makefile中定义的变量
# 	'$$'符号的使用
# 		$$符号主要扩展打开makefile中定义的shell变量
# 		示例：
# 			@for dir in $(subdirs); do \
# 				@echo -------compiling $$dir-----------; \
# 				$(MAKE) -C
# 			?"; \
# 			done
# 		以上  subdir属于makefile中定义的变量，
# 			  而dir则属于makefile中定义的shell变量，所以使用是使用 $$ 而不是 $ 。
# 	如果make执行时，带入make参数“-n”或“--just-print”，
# 		那么其只是显示命令，但不会执行命令，
# 		这个功能很有利于我们调试我们的Makefile，
# 		看看我们书写的命令是执行起来是什么样子的或是什么顺序的。 
# 	而make参数“-s”或“--slient”则是全面禁止命令的显示。

# 	补充说明自动化变量：
# 		$@表示规则中的目标文件集。
# 			在模式规则中，如果有多个目标，那么，"$@"就是匹配于目标中模式定义的集合。
# 		$%仅当目标是函数库文件中，表示规则中的依赖成员名。
# 			例如，如果一个目标是"foo.a(bar.o)"，那么，"$%"就是"bar.o"，"$@"就是"foo.a"。
# 			如果目标不是函数库文件（Unix下是[.a]，Windows下是[.lib]），那么，其值为空。
# 		$<依赖目标中的第一个目标名字。如果依赖目标是以模式（即"%"）定义的，那么"$<"将是符合模式的一系列的文件集。注意，其是一个一个取出来的。
# 		$?所有比目标新的依赖目标的集合。以空格分隔。
# 		$^所有的依赖目标的集合。以空格分隔。如果在依赖目标中有多个重复的，那个这个变量会去除重复的依赖目标，只保留一份。


