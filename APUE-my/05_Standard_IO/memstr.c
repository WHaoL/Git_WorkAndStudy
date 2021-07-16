
#include "apue.h"
#include <stdio.h>
#define BSZ 48

/*
fmemopen打开 缓冲区 用于 流内存

fmemopen
    以追加方式打开，文件位置 设置为 
        缓冲区中的第一个null字节，
        或者 当没有找到null字节时 缓冲区结尾的后一个字节
    以其他方式打开，文件位置 设置为 
        缓冲区开始的位置

问题：到底如何追加null字节的？？？

fmemopen打开的 流缓冲区 追加null只有两种情况: 
    1.增加流缓冲区中数据量
    2.调用fclose、fflush、fseek、fseeko、fsetpos会在当前位置添加null(即'\0')
*/
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
    // --> 因此，此时fmemopen 文件位置设置为缓冲区的开始位置，所以 在缓冲区开始处 放置null字节('\0')
    if ((fp = fmemopen(buf, BSZ, "w+")) == NULL)
        err_sys("fmemopen error");
    printf("initial buffer content: %s\n", buf); //所以此时打印，显示的是空串
    printf("%ld\n", ftell(fp));                  //此时的 文件指针位置  0

    //注意：只要写数据，文件偏移量就会增加
    fprintf(fp, "hello, world");       //向 流 写入数据
    printf("%ld\n", ftell(fp));        //此时的 文件指针位置  12
    printf("before flush: %s\n", buf); //但是 此时缓冲区是没有变化的

    //调用fclose、fflush、fseek、fseeko、fsetpos会在当前位置添加null(即'\0')
    fflush(fp);                                                //流被冲洗后，缓冲区才会发生变化; 追加 '\0'
    printf("after flush: %s\n", buf);                          //此时缓冲区的内容是： hello,world
    printf("len of string in buf = %ld\n", (long)strlen(buf)); //12
    printf("%ld\n", ftell(fp));                                //此时的 文件指针位置  12

    //--------------------------------------------------------------------

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  12

    memset(buf, 'b', BSZ - 2);
    buf[BSZ - 2] = '\0';
    buf[BSZ - 1] = 'X';
    printf("buffer content: %s\n", buf);

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  12

    fprintf(fp, "hello, worldhello, worldhello, worldhello, worldhello, worldhello, worldhello, world"); //向 流 写入数据

    printf("%ld\n", ftell(fp)); //此时的 文件指针位置  24

    printf("before fseek: %s\n", buf);                         //
    fseek(fp, 0, SEEK_SET);                                    //fseek引起缓冲区冲洗; 追加 '\0'
    printf("after fseek: %s\n", buf);                          //
    printf("len of string in buf = %ld\n", (long)strlen(buf)); //24
    printf("buf[47]如果是null/空就证明写入了null: %c\n",buf[47]);

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