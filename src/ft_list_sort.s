bits 64

struc t_list
	pdata:	resq 1
	pnext:	resq 1
endstruc

section .text

global ft_list_sort

	ft_list_sort:
		push rbp
		mov rbp, rsp
		sub rsp, 0x18 ; Alloc 8*3 bytes on stack
		mov rdi, QWORD [rdi] ; t_list **begin_list
		mov QWORD [rbp-0x8], rdi ; save *begin_list
		mov QWORD [rbp-0x10], rsi ; int (*cmp)(void *, void *)
		cmp rdi, 0x0
		je ft_list_sort_end
		mov r8, rdi
	ft_list_sort_loop:
		cmp QWORD [r8+pnext], 0x0 ; l->next == NULL
		je ft_list_sort_end
		mov rdi, QWORD [r8+pdata] ; load l->data
		mov rdx, QWORD [r8+pnext] ; load l->next
		mov rsi, QWORD [rdx+pdata] ; load l->next->data
		mov rdx, QWORD [rbp-0x10] ; load cmp
		push r8
		call rdx
		pop r8
		cmp eax, 0x0
		jg ft_list_sort_swap ; eax > 0
		mov r8, QWORD [r8+pnext]
		jmp ft_list_sort_loop
	ft_list_sort_swap:
		mov r9, QWORD [r8+pdata] ; save l->data
		mov rdx, QWORD [r8+pnext] ; load l->next
		mov rcx, QWORD [rdx+pdata] ; load l->next->data
		mov QWORD [r8+pdata], rcx ; l->data = l->next->data
		mov QWORD [rdx+pdata], r9 ; l->next->data = saved l->data
		mov r8, QWORD [rbp-0x8] ; reload *begin_list
		jmp ft_list_sort_loop
	ft_list_sort_end:
		leave
		ret
