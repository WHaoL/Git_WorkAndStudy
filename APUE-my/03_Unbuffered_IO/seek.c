/** P54
 *  file seek.c
 *  brief 测试标准输入能否被设置偏移量
 *  date 2021-06-04
 */
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    if (lseek(STDIN_FILENO, 0, SEEK_CUR) == -1)
        printf("cannot seek\n");
    else
        printf("seek OK\n");

    exit(0);
}

/***
 * 测试： 
 * 
 *      ./seek < /etc/passwd
 * 
 *      cat < /etc/passwd | ./seek    
 * 
*/