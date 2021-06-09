
// APUE 推荐 (!!!) 使用这两个函数创建 临时文件
#include "apue.h"
#include <errno.h>


void make_temp(char *template);
int main(void)
{
    char good_template[] = "/tmp/dirXXXXXX"; // right way //注意这是大写的X
    char *bad_template = "/tmp/dirXXXXXX";   // wrong way
    //因为字符串存放在只读段，不可修改；那么mkstemp试图修改字符串时，出现端错误

    printf("trying to create first file...\n");
    make_temp(good_template);
    printf("trying to create second file...\n");
    make_temp(bad_template);
    exit(0);
}

void make_temp(char *template)
{
    int fd;
    struct stat st;

    if ((fd = mkstemp(template)) < 0)
        err_sys("can't create temp file");
    printf("temp name = %s\n", template);
    close(fd);

    if (stat(template, &st) < 0)
    {
        if (errno == ENOENT)
            printf("file doesn't exist\n");
        else
            err_sys("stat failed");
    }
    else
    {
        printf("file exists\n");
        unlink(template);
    }
}