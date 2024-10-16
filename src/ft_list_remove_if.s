bits 64

extern free

struc t_list
	pdata:	resq 1
	pnext:	resq 1
endstruc

section .text

global ft_list_remove_if

	ft_list_remove_if:
		push rbp
		mov rbp, rsp
		sub rsp, 0x28 ; Alloc 8*5 bytes on stack
		mov QWORD [rbp-0x8], rdi ; t_list **begin_list
		mov QWORD [rbp-0x10], rsi ; void *data_ref
		mov QWORD [rbp-0x18], rdx ; int (*cmp)(void *, void *)
		mov QWORD [rbp-0x20], rcx ; void (free_fct)(void *)
		mov r8, QWORD [rbp-0x8] ; t_list **begin_list
	ft_list_remove_if_loop:
		cmp QWORD [r8], 0x0
		je ft_list_remove_if_end ; *begin list != NULL
		mov r8, QWORD [r8]
		mov rdi, QWORD [r8+pdata] ; (*begin_list)->data
		mov rsi, QWORD [rbp-0x10] ; load void *data_ref
		mov rdx, QWORD [rbp-0x18] ; load int (*cmp)(void *, void *)
		push r8
		call rdx
		pop r8
		test eax, eax
		jz ft_list_remove_if_remove
		lea r8, QWORD [r8+pnext]
		mov QWORD [rbp-0x8], r8
		jmp ft_list_remove_if_loop
	ft_list_remove_if_remove:
		mov rdx, QWORD [rbp-0x20]
		test rdx, rdx
		jz ignore_free
		mov rdi, QWORD [r8+pdata]
		push r8
		call rdx ; free_fct data
		pop r8
	ignore_free:
		mov r9, QWORD [rbp-0x8]
		mov rdx, QWORD [r8+pnext]
		mov QWORD [r9], rdx
		mov rdi, r8
		push r9
		call free WRT ..plt
		pop r8
		jmp ft_list_remove_if_loop
	ft_list_remove_if_end:
		leave
		ret
