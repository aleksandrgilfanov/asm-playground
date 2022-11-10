# parameters of a system call placed in:
# %rdi %rsi %rdx %r10 %r8 %r9

# syscall clobbers %rcx
    # stores next instruction for kernel to return

# syscall clobbers %r11
    # stores current %eflags

# syscall returns value in %rax

.globl _start		# directive that define symbol _start as global

.section .data
curtime:
	.quad 0

.section .text		# put following code in the .text (code) section
_start:			# label (address in memory of following code/data)
    # get initial time into curtime
	movq $0xc9, %rax
	movq $curtime, %rdi
	syscall
    # store end time in %rdx (current + 5)
	movq curtime, %rdx
	addq $5, %rdx

timeloop:
    # check the time
	movq $0xc9, %rax
	movq $curtime, %rdi
	syscall
    # If I haven't reached the time specified in %rdx, do it again
	cmpq %rdx, curtime
	jb timeloop

timefinish:
    # exit, return value of rdi
	movq $0x3c, %rax
	movq $123, %rdi
	syscall
