/*** P9-P10
 * 进程控制
 *     从标准输入读取命令，然后执行这些命令；类似于shell程序的基本实施部分
*/
#include "apue.h"
#include <sys/wait.h>

/*
 *demo 
 *测试：如果 fgets读到 EOF(Ctrl+D) 是否返回NULL，如果返回NULL，那么打印
 */
void test_fgets_EOF()
{
    char buf2[MAXLINE];
    if (fgets(buf2, MAXLINE, stdin) == NULL)
        printf("fgets receive EOF and return: NULL\n");
    else
        printf("fgets receive EOF and return: not NULL\n");
}

int main(void)
{
    // test_fgets_EOF();

    char buf[MAXLINE];  /*from apue.h*/
    pid_t pid;
    int status;

    printf("%% ");                             /*打印提示符 (为了打印出% 此处需要%%)*/
    while (fgets(buf, MAXLINE, stdin) != NULL) /*fgets读到 EOF(Ctrl+D) 返回NULL*/
    {
        /*fgets每次读取一行，把行尾的'\n'替换为'\0' 
         * 因为execlp要求的参数是以 null('\0')('0')结尾，而不是'\n'
         */
        if (buf[strlen(buf) - 1] == '\n')
            buf[strlen(buf) - 1] = 0;

        if ((pid = fork()) < 0)
            err_sys("fork error");
        else if (pid == 0) /*子进程*/
        {
            execlp(buf, buf, (char *)0);
            err_ret("couldn't execute: %s", buf);
            exit(127);
        }

        /*父进程*/
        if ((pid = waitpid(pid, &status, 0)) < 0)
            err_sys("waitpid error");
        printf("%% ");
    }

    exit(0);
}