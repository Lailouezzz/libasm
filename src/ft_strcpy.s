bits 64

section .text

global ft_strcpy

	ft_strcpy:
		xor rax, rax
	ft_strcpy_start:
		mov cl, BYTE [rsi+rax]
		mov BYTE [rdi+rax], cl
		cmp cl, 0x0
		jz ft_strcpy_end ; end of string
		inc rax
		jmp ft_strcpy_start
	ft_strcpy_end:
		mov rax, rdi
		ret
