; -----------------------------------------------------------------------------
; 64-bit program that treats all its command line arguments as integers and
; displays their average as a floating point number.  This program uses a data
; section to store intermediate results, not that it has to, but only to
; illustrate how data sections are used.
; -----------------------------------------------------------------------------

        global   main   ;main函数
        extern   atoi   ;把字符串转成整数
        extern   printf ;打印
        default  rel

        section  .text  ;代码段
main:
        dec      rdi                    ; argc-1, since we don't count program name ;argc至少是1
        jz       nothingToAverage                                                   ;如果argc-1后是0，证明没有任何参数，直接跳转返回
        mov      [count], rdi           ; save number of real arguments
accumulate:     ;累加
        push     rdi                    ; save register across call to atoi     ;这两个我们要使用，先保存起来
        push     rsi                                                            ;
        mov      rdi, [rsi+rdi*8]       ; argv[rdi]                             ;把每个命令行参数的首地址 赋给rdi
        call     atoi                   ; now rax has the int value of arg      ;把参数(字符串)转换为数字
        pop      rsi                    ; restore registers after atoi call
        pop      rdi
        add      [sum], rax             ; accumulate sum as we go               ;累加到sum这块内存中去                   
        dec      rdi                    ; count down
        jnz      accumulate             ; more arguments?
average:        ;求平均数
        cvtsi2sd xmm0, [sum]    ;cvtsi2sd把[sum]中的int转成double 并存到xmm0的后8字节里
        cvtsi2sd xmm1, [count]  ;cvtsi2sd把[count]中的int转成double 并存到xmm1的后8字节里
        divsd    xmm0, xmm1             ; xmm0 is sum/count     ;求平均值
        mov      rdi, format            ; 1st arg to printf                             ;给printf设定输出格式
        mov      rax, 1                 ; printf is varargs, there is 1 non-int argument;告诉printf 有一个不是整数的参数

        sub      rsp, 8                 ; align stack pointer           ;栈对齐
        call     printf                 ; printf(format, sum/count)     ;输出
        add      rsp, 8                 ; restore stack pointer         ;

        ret

nothingToAverage:
        mov      rdi, error
        xor      rax, rax
        call     printf
        ret

        section  .data
count:  dq       0
sum:    dq       0
format: db       "%g", 10, 0
error:  db       "There are no command line arguments to average", 10, 0

