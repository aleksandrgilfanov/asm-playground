# parameters of a system call placed in:
# %rdi %rsi %rdx %r10 %r8 %r9

# syscall clobbers %rcx
    # stores next instruction for kernel to return
# syscall clobbers %r11
    # stores current %eflags
# syscall returns value in %rax

.globl _start

.section .data
mystring:
    .ascii "Hello!\n"
mystring_end:
.equ mystring_length, mystring_end - mystring

.section .text
_start:
    # Write to stdout
    movq $1, %rax		# syscall number = 1
    movq $1, %rdi		# fd = 1
    movq $mystring, %rsi	# data pointer
    movq $mystring_length, %rdx	# data length
    syscall

    # Exit
    movq $0x3c, %rax
    movq $0, %rdi
    syscall
