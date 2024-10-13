bits 64

section .text

global ft_strcmp

	ft_strcmp:
		xor rax, rax
	ft_strcmp_start:
		cmp BYTE [rsi+rax], 0x0
		jz ft_strcmp_end ; end of string
		cmp BYTE [rdi+rax], 0x0
		jz ft_strcmp_end ; end of string
		mov cl, BYTE [rdi+rax]
		cmp cl, BYTE [rsi+rax] ; cmp the 2 strings
		jnz ft_strcmp_end ; 2 string differ
		inc rax ; next char
		jmp ft_strcmp_start ; start of the loop
	ft_strcmp_end:
		movzx ecx, BYTE [rsi+rax]
		movzx eax, BYTE [rdi+rax]
		sub eax, ecx
		ret
