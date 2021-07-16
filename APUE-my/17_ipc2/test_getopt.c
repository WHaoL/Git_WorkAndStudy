/**
 * file test_getopt.c
 * author lwh (https://gitee.com/liangwenhao/)
 * brief 
 * version 0.1
 * date 2021-06-03
 *
 * copyright Copyright (c) 2021
 * 
 */
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

//  int getopt(int argc, char *const argv[],const char *optstring);
//  参考： https://man7.org/linux/man-pages/man3/getopt.3.html
//  参考  《APUE》P662(En-3e) P536(Cn-3e)
/***
 * getopt()函数，用于解析命令行参数
 *      
 *      #include <unistd.h>
 *      
 *      argc 和 argv，就是 调用main函数传进去的argc和argc；分别表示了参数的个数和参数数组
 * 
 *      optind 是argv数组中，下一个要被处理的element的下标
 *      初始值是1
 *      可以将其重置为1，以重新开始扫描相同的argv
 * 
 *      没有处理完时，getopt()返回找到的选项字符 
 *          并改变optind和静态变量nextchar
 *      处理完参数后，getopt()返回-1，
 *      如果遇到一个不在optstring中的选项，那么返回'?'
 *      如果第一个参数是':',那么返回':'
 *      
 *      -W xxx 等同于 --xxx
 *      
 *      出错时默认情况下： 
 *          getopt向stderr打印错误，并使 optopt指向错误信息(字符串)，并返回'?'
 * 
 *      当将全局变量 opterr设置为0时，则getopt()不会打印错误信息，
 *      默认情况下opterr有个非0值
 *      
 *      选项的参数 存储在 optarg 中
 *      
 */
int main(int argc, char *argv[])
{
    int opt;
    while ((opt = getopt(argc, argv, "nt:")) != -1)
    {
        switch (opt)
        {
        case 'n':
            printf("-n\n");
            break;
        case 't':
            printf("-t, %s\n", (char *)optarg);
            break;
        default: /* '?' */
            fprintf(stderr, "Usage: %s [-t nsecs] [-n] name\n", argv[0]);
            exit(EXIT_FAILURE);
        }
    }

    printf("------------------------------------------\n");
    printf("argc: %d\n", argc);
    printf("optind: %d\n", optind);
    printf("argv: %s\n", *argv);
    printf("argv[optind]: %s\n", argv[optind]);
    printf("此时optind指向最后一个参数的下一个位置，即NULL \n");
    printf("------------------------------------------\n");

    // optind--;
    // argc -= optind;
    // argv += optind;

    // printf("argc: %d\n", argc);
    // printf("argv: %s\n", *argv);
    // printf("此时optind指向最后一个参数\n");
    // printf("argc代表了待处理的参数的个数是 1 \n");

    printf("------------------------------------------\n");
    //如果之间这样，那么将跳过所以已经执行了的参数
    //此时 argc=0，表示待处理的参数是0
    //此时 *argv == NULL ，表明，指到了最后一个参数的后面(NULL)
    argc -= optind;
    argv += optind;
    printf("argc: %d\n", argc);
    printf("argv: %s\n", *argv);

    exit(EXIT_SUCCESS);
}