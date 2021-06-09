/**
 * @file fwide.c
 * @author LiangWenhao (1943080020@qq.com)
 * @brief 测试fwide - P115
 * @version 0.1
 * @date 2021-06-07
 * 
 * @copyright Copyright (c) 2021
 * 
 * @blogs: https://blog.csdn.net/liangwenhao1108
 * @gitee: https://gitee.com/liangwenhao
 * @GitHub: https://github.com/WHaoL
 */
#include "apue.h"

#include <wchar.h>

int fwide_help(FILE *fp, int mode)
{
    if(!fp)
        return 0;
    
    int result = fwide(fp,mode);
    if(result > 0)
        printf("fp(%p) is wide-byte-flow\n",fp);
    else if(result < 0)
        printf("fp(%p) is byte-flow\n",fp);
    else
        printf("fp(%p) is unordered\n",fp);
    
    return result;
}

int main()
{

    fwide_help(stdin,0);
    fwide_help(stdout,0);
    fwide_help(stderr,0);

    FILE* fp = fopen("fwide.c","r");
    if(fp != NULL)
    {
        fwide_help(fp,0);
        fwide_help(fp,-1); // 修改为字节流
        fwide_help(fp,1);  //尝试修改为宽字节流，但不会成功，因为一旦指定了流向就不能再更改
    }
    return 0;
}
