bits 64

extern __errno_location

section .text

global ft_read

	ft_read:
		mov rax, 0x0
		syscall
		cmp rax, 0xfffffffffffff000
		ja ft_read_error ; -1 >= RAX > -4096
		ret
	ft_read_error:
		mov edx, eax
		call __errno_location WRT ..plt
		neg edx
		mov DWORD [rax], edx
		mov rax, -1
		ret
