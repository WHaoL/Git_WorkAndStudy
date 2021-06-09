
// 注意 tmpnam只是创建了一个 不重复的字符串(路径名+文件名)，并不是创建了一个文件

#include "apue.h"

int main(void)
{
    char name[L_tmpnam];
    char line[MAXLINE];
    FILE *fp;

    char *ptr;
    ptr = tmpnam(name); //数组name中存放了临时文件的路径+文件名；并把name的地址返回给
    printf("1 name: %s\n", name);
    printf("1 ptr : %s\n", ptr);
    printf("2 name: %p\n", name);
    printf("2 ptr : %p\n", ptr);
    // 警告： the use of `tmpnam' is dangerous, better use `mkstemp'

    if ((fp = tmpfile()) == NULL) //创建临时文件
        err_sys("tmpfile error");
    fputs("one line of output\n", fp); //向文件中写入数据

    rewind(fp); //将流设置到文件的起始位置

    if (fgets(line, MAXLINE, fp) == NULL) //从文件中读取数据
        err_sys("fgets error");
    fputs(line, stdout); //把读取到的数据，打印到标准输出

    // 问题： 如何通过fd获得文件名？
    // 问题： 如何通过fp获得文件名？

    // 问题： 如何通过fp获得fd？
    // int fd = fileno(fp);

    exit(0);
}