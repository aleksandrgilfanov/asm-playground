# minimal program, exits with status code 33

# note: _start is special symbol, which is used by linker to know where start

.globl _start		# directive that define symbol _start as global
.section .text		# put following code in the .text (code) section
_start:			# label (address in memory of following code/data)
	movq $60, %rax	# 60 = exit system call number
	movq $33, %rdi	# for exit %rdi holds exit status of program
	syscall		# transfer control to operating system
