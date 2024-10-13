bits 64

section .text

global ft_strlen

	ft_strlen:
		xor rax, rax
	ft_strlen_start:
		cmp BYTE [rdi+rax], 0x0
		jz ft_strlen_end
		inc rax
		jmp ft_strlen_start
	ft_strlen_end:
		ret
