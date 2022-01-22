;;; hello.asm
;;; Taken from the nasm tutorial https://cs.lmu.edu/~ray/notes/nasmtutorial/

; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -felf64 hello.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------

    global _start

    section .text
_start:
    mov     rax, 1              ; write systemcall
    mov     rdi, 1              ; file handle 1 is stdout
    mov     rsi, message        ; address of string to output
    mov     rdx, 13             ; number of bytes
    syscall                     ; invoke write()
    mov     rax, 60             ; syscall for exit()
    xor     rdi, rdi            ; exit code 0 (xor with yourself zeros out a register)
    syscall                     ; invoke exit()

    section .data
message:
    db "Hello, world", 10       ; has newline
