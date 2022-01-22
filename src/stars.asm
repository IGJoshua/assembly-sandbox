;;; stars.asm
;;; Taken from the nasm tutorial https://cs.lmu.edu/~ray/notes/nasmtutorial/

; ----------------------------------------------------------------------------------------
; Adapted from an OSX console program that writes a little triangle of asterisks
; to standard output. Runs on macOS only.
;
;     nasm -fmacho64 triangle.asm && gcc hola.o && ./a.out
; ----------------------------------------------------------------------------------------

    global _start

    section .text
_start:
    mov     rdx, output         ; rdx holds address of the next byte to write
    mov     r8, 1               ; initial line length
    mov     r9, 0               ; number of stars written so far
line:
    mov     byte [rdx], '*'     ; write a single star
    inc     rdx                 ; advance pointer to the next cell to write
    inc     r9                  ; we've written one more star
    cmp     r9, r8              ; check if we've gotten to the correct number of stars
    jne     line                ; jump if we need to write more
lineDone:
    mov     byte [rdx], 10      ; write a newline
    inc     rdx                 ; advance the pointer
    inc     r8                  ; next line will be a char longer
    mov     r9, 0               ; we've not written any stars in the next line yet
    cmp     r8, maxlines        ; check if we've finished the last line
    jng     line                ; if not, write the next line
done:
    mov     rax, 1              ; write syscall
    mov     rdi, 1              ; write to stdout
    mov     rsi, output         ; write from the output
    mov     rdx, dataSize       ; write the correct number of bytes
    syscall                     ; invoke write()

    mov     rax, 60             ; exit syscall
    mov     rdi, 0              ; exit code 0
    syscall                     ; invoke exit()

    section .bss
maxlines equ 8
dataSize equ 44
output: resb dataSize
