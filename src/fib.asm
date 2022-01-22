;;; fib.asm
;;; Taken from the nasm tutorial https://cs.lmu.edu/~ray/notes/nasmtutorial/

; -----------------------------------------------------------------------------
; A 64-bit Linux application that writes the first 90 Fibonacci numbers. To
; assemble and run:
;
;     nasm -felf64 fib.asm && gcc fib.o && ./a.out
; -----------------------------------------------------------------------------

    global main
    extern printf

    section .text
main:
    push    rbx                 ; we have to save this since we use it

    mov     ecx, 90             ; ecx will count down to 0
    mov     rax, 0              ; rax will hold the current number
    mov     rbx, 1              ; rbx will hold the next number

print:
    ;; We need to call printf, but we are using rax, rbx, and rcx. printf may
    ;; destroy rax and rcx so we will save these before the call and restore
    ;; them afterwards.

    push    rax                 ; caller-save registers
    push    rcx

    lea     rdi, [rel format]   ; set first parameter (format)
    mov     rsi, rax            ; set second parameter (current_number)
    mov     rax, 0              ; because printf is varargs

    ;; Stack is already aligned because we pushed 3 8-byte registers
    call    [rel printf wrt ..got] ; printf(format, current_number)

    pop     rcx                 ; restore caller-save registers
    pop     rax

    mov     rdx, rax            ; save the current number
    mov     rax, rbx            ; next number is now current
    add     rbx, rdx            ; get the new next number
    dec     ecx                 ; count down
    jnz     print               ; if not done counting, do some more

    pop     rbx                 ; restore callee-save register
    ret

format:
    db "%20ld", 10, 0           ; zero-terminated string
