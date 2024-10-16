bits 64

struc t_list
	pdata:	resq 1
	pnext:	resq 1
endstruc

section .text

global ft_list_size

	ft_list_size:
		xor eax, eax
	ft_list_start:
		cmp rdi, 0x0
		je ft_list_end
		inc eax
		mov rdi, QWORD [rdi+pnext]
		jmp ft_list_start
	ft_list_end:
		ret
