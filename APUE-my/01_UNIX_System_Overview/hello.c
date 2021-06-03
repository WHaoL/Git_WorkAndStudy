/*** P9
 * 打印当前进程的ID--PID
 * 
*/
#include "apue.h"

int 
main(void)
{
    printf("Hello world from process ID %ld\n", (long)getpid());
    exit(0);
}