/**
 * @file 测试getchar和putchar
 *
 * apue示例程序 - getcharbug.c
 * https://stackoverflow.com/questions/10720821/im-trying-to-understand-getchar-eof
 *
 * @author Steve & r00tk1t
 *
 */
#include "apue.h"

int main(void)
{
	char c; // 此 getcharbug例程

	// int c; //正确的做法

	while ((c = getchar()) != EOF)
		putchar(c);

	if (ferror(stdin))
		err_sys("input error");
	if (ferror(stdout))
		err_sys("output error");

	if (feof(stdin))
		printf("stdin EOF\n");
	if (feof(stdout))
		printf("stdout EOF\n");

	return 0;
}