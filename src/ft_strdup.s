bits 64

extern malloc
extern ft_strlen
extern ft_strcpy

section .text

global ft_strdup

	ft_strdup:
		push rbp
		mov rbp, rsp
		sub rsp, 0x8
		mov QWORD [rbp-0x8], rdi ; src

		call ft_strlen
		inc rax
		mov rdi, rax
		call malloc WRT ..plt
		cmp rax, 0x0
		jnz ft_strdup_continue
		leave
		ret
	ft_strdup_continue:
		mov rdi, rax
		mov rsi, QWORD [rbp-0x8]
		call ft_strcpy
		leave
		ret

