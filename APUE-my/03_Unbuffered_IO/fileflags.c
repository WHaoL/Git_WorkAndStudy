/**
 * @file fileflags.c
 * @author LiangWenhao (1943080020@qq.com)
 * @brief 查看文件的文件状态标志
 * @version 0.1
 * @date 2021-06-06
 * 
 * @copyright Copyright (c) 2021
 * 
 * @blogs: https://blog.csdn.net/liangwenhao1108
 * @gitee: https://gitee.com/liangwenhao
 * @GitHub: https://github.com/WHaoL
 */
#include "apue.h"
#include <fcntl.h>

int main(int argc, char *argv[])
{
    int val;

    if (argc != 2)
        err_quit("usage: a.out <descriptor#>");

    /* 获取： 文件状态标志 
       其中 第一个参数指定文件描述符 */
    if ((val = fcntl(atoi(argv[1]), F_GETFL, 0)) < 0)
        err_sys("fcntl error for fd %d", atoi(argv[1]));
    switch (val & O_ACCMODE)
    {
    case O_RDONLY:
        printf("read only");
        break;
    case O_WRONLY:
        printf("write only");
        break;
    case O_RDWR:
        printf("read write");
        break;
    default:
        printf("unknown access mode");
        break;
    }

    if (val & O_APPEND)
        printf(", append");
    if (val & O_NONBLOCK)
        printf(", nonblocking");
    if (val & O_SYNC)
        printf(", synchronous writes");

    putchar('\n');

    exit(0);
}