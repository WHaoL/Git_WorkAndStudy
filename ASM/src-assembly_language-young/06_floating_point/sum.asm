; -----------------------------------------------------------------------------
; A 64-bit function that returns the sum of the elements in a floating-point
; array. The function has prototype:
;
;   double sum(double[] array, uint64_t length)  
;  
; rdi是数组首地址  rsi是长度 
; 整个过程中用到一个浮点数寄存器xmm0
; -----------------------------------------------------------------------------

        global  sum
        section .text
sum:
        xorpd   xmm0, xmm0              ; initialize the sum to 0       ;自己和自己异或，相当于把xmm0清空
        cmp     rsi, 0                  ; special case for length = 0   ;比较长度是不是为0
        je      done                                                    ;若是0，则直接结束
next:
        addsd   xmm0, [rdi]             ; add in the current array element ;把当前指向的数组元素 加到 addsd上
        add     rdi, 8                  ; move to next array element       ;移动到下一个数组元素的位置
        dec     rsi                     ; count down                       ;长度-1
        jnz     next                    ; if not done counting, continue   ;如果长度不等于0，继续执行
done:
        ret                             ; return value already in xmm0

