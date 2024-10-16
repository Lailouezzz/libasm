bits 64

extern malloc

struc t_list
	pdata:	resq 1
	pnext:	resq 1
endstruc

section .text

	ft_create_elem:
		push rbp
		mov rbp, rsp
		sub rsp, 0x10 ; Alloc 16 bytes on stack
		mov QWORD [rbp-0x8], rdi ; void *data
		mov rdi, t_list_size
		call malloc WRT ..plt
		cmp rax, 0x0
		je elem_badalloc
		mov rdi, QWORD [rbp-0x8] ; restore void *data
		mov QWORD [rax+pdata], rdi
		mov QWORD [rax+pnext], 0x0
	elem_badalloc:
		leave
		ret

global ft_list_push_back

	ft_list_push_back:
		push rbp
		mov rbp, rsp
		sub rsp, 0x20 ; Alloc 8*4 bytes on stack
		mov QWORD [rbp-0x8], rdi ; t_list **begin_list
		mov QWORD [rbp-0x10], rsi ; void *data
		mov rdi, rsi
		call ft_create_elem
		cmp rax, 0
		je list_pf_badalloc
		mov QWORD [rbp-0x18], rax ; t_list *new
		mov rdx, QWORD [rbp-0x8] ; t_list **begin_list
		cmp QWORD [rdx], 0x0
		jne list_pf_insert ; *begin_list != NULL
		mov QWORD [rdx], rax
		jmp list_pf_end
	list_pf_insert:
		mov rdx, QWORD [rdx] ; rdx == *begin_list
	list_pf_insert_check:
		cmp QWORD [rdx+pnext], 0x0
		je list_pf_can_insert
		mov rdx, QWORD [rdx+pnext]
		jmp list_pf_insert_check
	list_pf_can_insert:
		mov QWORD [rdx+pnext], rax
	list_pf_badalloc:
	list_pf_end:
		leave
		ret
