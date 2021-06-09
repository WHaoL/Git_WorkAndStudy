
#include "apue.h"
#include <stdio.h>
#define BSZ 48

int main(void)
{

    FILE *fp;
    char buf[BSZ];

    //--------------------------------------------------------------------
    memset(buf, 'a', BSZ - 2);
    buf[BSZ - 2] = '\0';
    buf[BSZ - 1] = 'X';
    printf("buffer content: %s\n", buf);

    // w+ == O_RDWR|O_CREAT|O_TRUNC
    // 此时没有fmemopen不是追加方式打开，所以 当前文件指针 指向 缓冲区的开始位置
    // --> 因此，此时fmemopen 在缓冲区开始处 放置null字节('\0')
    if ((fp = fmemopen(buf, BSZ, "w+")) == NULL)
        err_sys("fmemopen error");
    printf("initial buffer content: %s\n", buf); //所以此时打印，显示的是空串

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  0

    fprintf(fp, "hello, world");                               //向 流 写入数据
    printf("before flush: %s\n", buf);                         //但是 此时缓冲区是没有变化的
    fflush(fp);                                                //流被冲洗后，缓冲区才会发生变化; 追加 '\0'
    printf("after flush: %s\n", buf);                          //此时缓冲区的内容是： hello,world
    printf("len of string in buf = %ld\n", (long)strlen(buf)); //12

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  12

    //--------------------------------------------------------------------

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  12

    memset(buf, 'b', BSZ - 2);
    buf[BSZ - 2] = '\0';
    buf[BSZ - 1] = 'X';
    printf("buffer content: %s\n", buf);

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  12

    fprintf(fp, "hello, world"); //向 流 写入数据

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  24

    printf("before fseek: %s\n", buf);                         //
    fseek(fp, 0, SEEK_SET);                                    //fseek引起缓冲区冲洗; 追加 '\0'
    printf("after fseek: %s\n", buf);                          //
    printf("len of string in buf = %ld\n", (long)strlen(buf)); //24

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  0

    //问题： 为什么是0 ？？？

    //--------------------------------------------------------------------
    memset(buf, 'c', BSZ - 2);
    buf[BSZ - 2] = '\0';
    buf[BSZ - 1] = 'X';
    printf("buffer content: %s\n", buf);

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  0

    fprintf(fp, "hello, world");                               //向 流 写入数据
    fclose(fp);                                                //关闭流 也会冲洗； 但是不追加 '\0'
    printf("after fclose: %s\n", buf);                         //
    printf("len of string in buf = %ld\n", (long)strlen(buf)); //46

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  12

    exit(0);
}