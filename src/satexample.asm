;;; sum.asm
;;; Taken from the nasm tutorial https://cs.lmu.edu/~ray/notes/nasmtutorial/

; ----------------------------------------------------------------------------------------
; Example of signed saturated arithmetic.
; ----------------------------------------------------------------------------------------

    global main
    extern printf

    section .text
main:
    push    rbp
    movaps  xmm0, [rel arg1]
    movaps  xmm1, [rel arg2]
    paddsw  xmm0, xmm1
    movaps  [rel result], xmm0

    lea     rdi, [rel format]
    mov     esi, dword [rel result]
    mov     edx, dword [rel result+4]
    mov     ecx, dword [rel result+8]
    mov     r8d, dword [rel result+12]
    mov     rax, 0
    call    [rel printf wrt ..got]
    pop     rbp
    ret

    section .data
    align   16
arg1:
    dw      0x3544,0x24FF,0x7654,0x9A77,0xF677,0x9000,0xFFFF,0x0000
arg2:
    dw      0x7000,0x1000,0xC000,0x1000,0xB000,0xA000,0x1000,0x0000
result:
    dd      0, 0, 0, 0
format:
    db      '%x%x%x%x',10,0
