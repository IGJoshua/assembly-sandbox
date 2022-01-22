;;; sum.asm
;;; Taken from the nasm tutorial https://cs.lmu.edu/~ray/notes/nasmtutorial/

; -----------------------------------------------------------------------------
; A 64-bit function that returns the sum of the elements in a floating-point
; array. The function has prototype:
;
;   double sum(double[] array, uint64_t length)
; -----------------------------------------------------------------------------

    global sum
    section .text
sum:
    movq    xmm0, [empty]       ; initialize the sum to 0
    cmp     rsi, 0              ; special case for length = 0
    je      done
next:
    addsd   xmm0, [rdi]         ; add in the current array element
    add     rdi, 8              ; move to the next array element
    dec     rsi                 ; count down
    jnz     next                ; if not done counting, continue
done:
    ret                         ; return value already in xmm0

    section .data
empty:  dq 0.0, 0.0
