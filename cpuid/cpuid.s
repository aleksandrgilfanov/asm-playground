# Sample program to extract the processor Vendor ID

# define ascii string in data section (initialized)
.section .data
output:
   .ascii "The processor Vendor ID is 'xxxxxxxxxxxx'\n"

# code section
.section .text
# .globl declares program labels accessible from external programs
.globl _start

# linker needs _start label by default
_start:
   # load 0 to EAX, cpuid returns different info depends on EAX
   movl $0, %eax
   # for EAX=0 it returns VendorID to EBX EDX ECX
   cpuid

   movl $output, %edi
   movl %ebx, 28(%edi)
   movl %edx, 32(%edi)
   movl %ecx, 36(%edi)
   movl $4, %eax
   movl $1, %ebx
   movl $output, %ecx
   movl $42, %edx
   int $0x80
   movl $1, %eax
   movl $0, %ebx
   int $0x80
