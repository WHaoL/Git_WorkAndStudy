/*** P15
 * 
*/
#include "apue.h"
#include <sys/wait.h>

/**
 * @brief 我们的信号捕捉函数
 * 
 * @param signo 信号
 */
static void sig_int(int signo)
{
    printf("i am parent -- interrupt%% ");
}

int main(void)
{
    char buf[MAXLINE];
    pid_t pid;
    int status;

    /**
     * @brief 注册了一个信号捕捉，捕捉 Ctrl+C, 使得父进程收到此信号后，并不退出
     */
    if (signal(SIGINT, sig_int) == SIG_ERR)
        err_sys("signal error");

    printf("%% ");
    while ((fgets(buf, MAXLINE, stdin)) != NULL)
    {
        if (buf[strlen(buf) - 1] == '\n')
            buf[strlen(buf) - 1] = 0;

        if ((pid = fork()) < 0)
            err_sys("fork error");
        else if (pid == 0)
        {
            execlp(buf, buf, (char *)0);
            err_ret("I am child -- couldn't execute: %s", buf);
            sleep(1);
            exit(127);
        }

        if ((pid = waitpid(pid, &status, 0)) < 0)
            err_sys("waitpid error");
        
        printf("%% ");
    }

    exit(0);
}