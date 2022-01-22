;;; power.asm
;;; Taken from the nasm tutorial https://cs.lmu.edu/~ray/notes/nasmtutorial/

; -----------------------------------------------------------------------------
; A 64-bit command line application to compute x^y.
;
; Syntax: power x y
; x and y are (32-bit) integers
; -----------------------------------------------------------------------------

    global main
    extern printf
    extern puts
    extern atoi

    section .text
main:
    push    r12                 ; save callee-save registers
    push    r13
    push    r14
    ;; by pushing three registers our stack is already aligned

    cmp     rdi, 3              ; must have exactly two arguments
    jne     error1

    mov     r12, rsi            ; argv

    ;; We will use ecx to count down form the exponent to zero, esi to hold the
    ;; value of the base, and eax to hold the running product.

    mov     rdi, [r12+16]       ; argv[2]
    call    atoi                ; y in eax
    cmp     eax, 0              ; disallow negative exponents
    jl      error2
    mov     r13d, eax           ; y in r13d

    mov     rdi, [r12+8]        ; argv
    call    atoi                ; x in eax
    mov     r14d, eax           ; x in r14d

    mov     eax, 1              ; start with answer = 1
check:
    test    r13d, r13d          ; we're counting y downto 0
    jz      gotit               ; done
    imul    eax, r14d           ; multiply in another x
    dec     r13d
    jmp     check
gotit:                          ; print report on success
    mov     rdi, answer
    movsxd  rsi, eax
    mov     rax, 0
    call    printf
    jmp     done
error1:                         ; print error message
    mov     edi, badArgumentCount
    call    puts
    jmp     done
error2:                         ; print error message
    mov     edi, negativeExponent
    call    puts
done:                           ; restore saved registers
    pop     r14
    pop     r13
    pop     r12
    ret

answer:
    db      "%d", 10, 0
badArgumentCount:
    db      "Requires exactly two arguments", 10, 0
negativeExponent:
    db      "The exponent may not be negative", 10, 0
