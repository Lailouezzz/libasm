bits 64

extern __errno_location

section .text

global ft_write

	ft_write:
		mov rax, 0x1
		syscall
		cmp rax, 0xfffffffffffff000
		ja ft_write_error ; -1 >= RAX > -4096
		ret
	ft_write_error:
		mov edx, eax
		sub rsp, 0x8
		call __errno_location WRT ..plt
		add rsp, 0x8
		neg edx
		mov DWORD [rax], edx
		mov rax, -1
		ret