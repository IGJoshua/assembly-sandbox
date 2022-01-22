;;; hello_c.asm
;;; Taken from the nasm tutorial https://cs.lmu.edu/~ray/notes/nasmtutorial/

; ----------------------------------------------------------------------------------------
; Writes "Hola, mundo" to the console using a C library. Runs on Linux.
;
;     nasm -felf64 hola.asm && gcc hola.o && ./a.out
; ----------------------------------------------------------------------------------------

    global main
    extern puts

    section .text
main:                           ; Main is called by the C library
    mov     rdi, message        ; First integer arg is in rdi
    call    puts                ; puts(message)
    ret                         ; Return back to the C library

message:
    db      "Hola, mundo", 0    ; it's a zero-terminated string for use with C
