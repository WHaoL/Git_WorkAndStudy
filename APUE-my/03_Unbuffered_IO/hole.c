/**
 * @file hole.c
 * @author LiangWenhao (1943080020@qq.com)
 * @brief 
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

char buf1[] = "abcdefghij";
char buf2[] = "ABCDEFGHIJ";

int main(void)
{
    int fd;

    if ((fd = creat("file.hole", FILE_MODE)) < 0)
        err_sys("create error");

    if (write(fd, buf1, 10) != 10)
        err_sys("buf1 write error");
    /* offset now = 10 */

    if (lseek(fd, 16384, SEEK_SET) == 1)
        err_sys("lseek error");

    if (write(fd, buf2, 10) != 10)
        err_sys("buf2 write error");
    /* offset now = 16394 */

    /***
检查文件的大小
gos@gos-Latitude-5591:~/workspace/Git_WorkAndStudy/APUE-my/03_Unbuffered_IO$ ls -l file.hole 
-rw-r--r-- 1 gos gos 16394 6月   6 17:27 file01.hole

观察文件的实际内容
gos@gos-Latitude-5591:~/workspace/Git_WorkAndStudy/APUE-my/03_Unbuffered_IO$ od -c file.hole 
0000000   a   b   c   d   e   f   g   h   i   j  \0  \0  \0  \0  \0  \0
0000020  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0040000   A   B   C   D   E   F   G   H   I   J
0040012     
     
    */

    //-----------------------------------------------------

    int fd2;
    int count = 0;
    char buf3[3] = "AB";

    if ((fd2 = creat("file.nohole", FILE_MODE)) < 0)
        err_sys("create error");

    while (count < 16394)
    {
        if (write(fd2, buf3, 2) != 2)
            err_sys("buf3 write error");
        count += 2;
    }

    /*

gos@gos-Latitude-5591:~/workspace/Git_WorkAndStudy/APUE-my/03_Unbuffered_IO$ ls -l file.nohole 
-rw-r--r-- 1 gos gos 16394 6月   6 17:36 file02.hole

gos@gos-Latitude-5591:~/workspace/Git_WorkAndStudy/APUE-my/03_Unbuffered_IO$ od -c file.nohole 
0000000   A   B   A   B   A   B   A   B   A   B   A   B   A   B   A   B
*
0040000   A   B   A   B   A   B   A   B   A   B
0040012

    */



    exit(0);
}