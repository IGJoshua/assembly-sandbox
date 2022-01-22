;;; echo.asm
;;; Taken from the nasm tutorial https://cs.lmu.edu/~ray/notes/nasmtutorial/

; -----------------------------------------------------------------------------
; A 64-bit program that displays its command line arguments, one per line.
;
; On entry, rdi will contain argc and rsi will contain argv.
; -----------------------------------------------------------------------------

    global main
    extern puts
    section .text
main:
    push    rdi                 ; save registers that puts uses
    push    rsi
    sub     rsp, 8              ; must align stack before call

    mov     rdi, [rsi]          ; the argument string to display
    call    puts                ; print it

    add     rsp, 8              ; restore %rsp to pre-aligned value
    pop     rsi                 ; restore registers that puts uses
    pop     rdi

    add     rsi, 8              ; point to the next argument
    dec     rdi                 ; count down
    jnz     main                ; if not done keep going

    ret
