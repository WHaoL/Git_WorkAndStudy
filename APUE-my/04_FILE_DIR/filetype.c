#include "apue.h"

int main(int argc, char *argv[])
{
    int i;
    struct stat buf;
    char *ptr;

    for (i = 1; i < argc; i++)
    {
        printf("argv[%d]: %s\n", i, argv[i]);
        if (lstat(argv[i], &buf) == -1)
            err_ret("lstat error");

        if (S_ISREG(buf.st_mode))
            ptr = "regular file";
        else if (S_ISDIR(buf.st_mode))
            ptr = "directory file";
        else if (S_ISBLK(buf.st_mode))
            ptr = "block special file";
        else if (S_ISCHR(buf.st_mode))
            ptr = "char special file";
        else if (S_ISFIFO(buf.st_mode))
            ptr = "FIFO";
        else if (S_ISLNK(buf.st_mode))
            ptr = "symbolic link";
        else if (S_ISSOCK(buf.st_mode))
            ptr = "socket";
        else
            ptr = "** unknow mode **";

        printf("%s\n", ptr);
    }

    exit(0);
}

/*

make 

测试
./filetype  ./filetype /etc/passwd /etc/ /dev/log  /dev/tty

*/