/**
 * @file fgetsfputs.c
 * @author LiangWenhao (1943080020@qq.com)
 * @brief  使用fets和fputs将标准输入复制到标准输出
 * @version 0.1
 * @date 2021-06-08
 * 
 * @copyright Copyright (c) 2021
 * 
 * @blogs: https://blog.csdn.net/liangwenhao1108
 * @gitee: https://gitee.com/liangwenhao
 * @GitHub: https://github.com/WHaoL
 */

// APUE 推荐 (!!!) 使用这两个函数 读取一行  写入一行

#include "apue.h"

int main(void)
{   
    char buf[MAXLINE];
    while(fgets(buf,MAXLINE,stdin) != NULL)
        if(fputs(buf,stdout) == EOF)
            err_sys("output error");
    
    if (ferror(stdin))
        err_sys("input error");
    if (ferror(stdout))
        err_sys("output error");

    if (feof(stdin))
        printf("stdin EOF\n");
    if (feof(stdout))
        printf("stdout EOF\n");

    exit(0);
}
