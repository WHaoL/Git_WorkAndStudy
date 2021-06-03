/*** P12
 * 两个出错函数的使用
*/
#include "apue.h"
#include <errno.h>

int main(int argc, char *argv[])
{
    fprintf(stderr, "EACCESS: %s\n", strerror(EACCES));
    errno = ENOENT;
    perror("argv[0]"); /*  argv[0]: No such file or directory  why??????? */
    exit(0);
}