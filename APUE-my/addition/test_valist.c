#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>

void test_vasprintf(const char *fmt, va_list args)
{
    char *result = NULL;
    int len = vasprintf(&result, fmt, args);
    if (len != -1)
    {
        printf("%s\n", result);
        free(result);
    }
    /***
     * vasprintf()会自动的申请空间，
     *      按照 fmt传进来的格式，
     *      并结合 args传进来的具体参数值
     *      拼接成一个字符串，放在第一个参数里，并返回这个字符串的长度
     *      所以我们要记得free()
    */
}

void test_valist(const char *fmt, ...)
{
    va_list ptr;        //可变参数的指针
    va_start(ptr, fmt); //使得ptr指向最后一个固定参数，即 指向第一个可变参数

    // int tmp1 = va_arg(ptr, int);   //返回当前指针 指向的参数 内部 类型为type的数据
    test_vasprintf(fmt, ptr);

    va_end(ptr); //清空可变参列表和ptr
}

int main(int argc, char *argv[])
{
    test_valist("%s, %d", "Hello1", 1);
    test_valist("%s, %d, %s", "Hello1", 1, "Hello2");
    test_valist("%s, %d, %s, %d", "Hello1", 1, "world2", 2);
    test_valist("%s, %d, %s, %d, %s", "Hello1", 1, "Hello2", 2, "Hello3");
    test_valist("%s, %d, %s, %d, %s,%d", "Hello1", 1, "Hello2", 2, "Hello3", 3);
    return 0;
}