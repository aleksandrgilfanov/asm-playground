.globl _start
.section .text

.type myfunc, @function
myfunc:
    # %rdi has arg1
    # %rsi has arg2

    # Create the stack frame with one 8-byte local variable
    # which will be referred to using -8(%rbp).

    # But allocate 16 bytes so that we maintain 16-byte alignment.
    enter $16, $0

    # move arg1 to address contained in %rbp - 8 (localvar = arg1)
    movq %rdi, -8(%rbp)
    # localvar += arg2
    addq %rsi, -8(%rbp)

    # put result in %rax
    movq -8(%rbp), %rax
    leave
    ret

_start:
    # call sum(arg1, arg2) function
    movq $3, %rdi
    movq $22, %rsi
    call myfunc # returns result into %rax

    # exit (60 or 0x3c)
    movq %rax, %rdi
    movq $60, %rax
    syscall
