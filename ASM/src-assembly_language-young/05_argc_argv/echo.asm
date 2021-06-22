; -----------------------------------------------------------------------------
; A 64-bit program that displays its command line arguments, one per line.
;
; On entry, rdi will contain argc and rsi will contain argv.
; -----------------------------------------------------------------------------

        global  main
        extern  puts    ;使用puts函数 对字符串进行输出
        section .text
main:
        push    rdi                     ; save registers that puts uses ; 保存现场 rdi存储了argc
        push    rsi                                                     ; 保存现场 因为执行过程中要对rdi rsi做一些修改 rsi存储了argv
        sub     rsp, 8                  ; must align stack before call          ;对栈中的字节进行对齐
        mov     rdi, [rsi]              ; the argument string to display;把 每个参数(字符串 argcv[0] argv[1]...)的首地址 赋给rdi
        call    puts                    ; print it                      ;打印每个参数
        add     rsp, 8                  ; restore %rsp to pre-aligned value     ;对栈中的字节进行对齐
        pop     rsi                     ; restore registers puts used   ;恢复现场
        pop     rdi                                                     ;恢复现场

        add     rsi, 8                  ; point to next argument        ;rsi指向下一个地址
        dec     rdi                     ; count down                    ;计数器减1
        jnz     main                    ; if not done counting keep going;计数器没有减到0的话，接着执行main

        ret

