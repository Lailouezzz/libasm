bits 64

extern ft_strlen

section .text

global ft_atoi_base

	ft_strchr:
		mov rdx, rsi
		cmp BYTE [rdi], dl
		je ft_strchr_find
		cmp BYTE [rdi], 0
		je ft_strchr_notfound
		inc rdi
		jmp ft_strchr
	ft_strchr_find:
		mov rax, rdi
		ret
	ft_strchr_notfound:
		mov rax, 0
		ret
	
	ft_atoi_base_check_unauthorized:
		lea rsi, [rel unauthrozied]
	ft_atoi_base_check_unauthorized_start:
		cmp BYTE [rsi], 0
		je ft_atoi_base_check_unauthorized_ok
		push rsi
		push rdi
		movzx rsi, BYTE [rsi]
		cmp rsi, 0
		call ft_strchr
		pop rdi
		pop rsi
		cmp rax, 0
		jne ft_atoi_base_check_unauthorized_error
		inc rsi
		jmp ft_atoi_base_check_unauthorized_start

	ft_atoi_base_check_unauthorized_error:
		mov rax, 1
		ret
	ft_atoi_base_check_unauthorized_ok:
		xor rax, rax
		ret

	ft_atoi_base_check_dup:
		movzx rsi, BYTE [rdi]
		cmp rsi, 0
		jne ft_atoi_base_check_dup_continue
		mov rax, 0
		ret
	ft_atoi_base_check_dup_continue:
		inc rdi
		push rdi
		call ft_strchr
		pop rdi
		cmp rax, 0
		jne ft_atoi_base_check_dup_error
		jmp ft_atoi_base_check_dup
	ft_atoi_base_check_dup_error:
		mov rax, 1
		ret

	ft_atoi_base: ; entry
		push rdi
		push rsi
		mov rdi, rsi
		call ft_strlen
		pop rsi
		pop rdi
		mov r10, rax
		cmp rax, 1
		ja ft_atoi_base_blen
		xor rax, rax
		ret
	ft_atoi_base_blen:
		push rdi
		push rsi
		mov rdi, rsi
		call ft_atoi_base_check_unauthorized
		pop rsi
		pop rdi
		cmp rax, 0
		je ft_atoi_base_unaut_ok
		xor rax, rax
		ret
	ft_atoi_base_unaut_ok:
		push rdi
		push rsi
		mov rdi, rsi
		call ft_atoi_base_check_dup
		pop rsi
		pop rdi
		cmp rax, 0
		je ft_atoi_base_ready
		mov rax, 0
		ret
	ft_atoi_base_ready:
		mov r8, 0
		jmp skipspace_start
	skipspace:
		inc rdi
	skipspace_start:
		movzx rcx, BYTE [rdi]
		cmp cl, 0x0
		je ft_atoi_base_end
		cmp cl, ' '
		je skipspace
		cmp cl, `\t`
		je skipspace
		cmp cl, `\v`
		je skipspace
		cmp cl, `\n`
		je skipspace
		cmp cl, `\f`
		je skipspace
		cmp cl, `\r`
		je skipspace
		mov r9, 1
		jmp sign_start
	sign_minus:
		neg r9
	sign_plus:
		inc rdi
		movzx rcx, BYTE [rdi]
	sign_start:
		cmp cl, 0x0
		je ft_atoi_base_end
		cmp cl, '+'
		je sign_plus
		cmp cl, '-'
		je sign_minus
		xor r8, r8
		jmp calc_start


	add_to_res:
		sub rax, rsi
		cmp rax, r10
		jae ft_atoi_base_end
		mov r11, rax
		mov rax, r8
		mul r10
		mov r8, rax
		add r8, r11
		inc rdi
		movzx rcx, BYTE [rdi]
	calc_start:
		push rdi
		push rsi
		mov rdi, rsi
		mov rsi, rcx
		call ft_strchr
		pop rsi
		pop rdi
		cmp rax, 0
		jne add_to_res

	ft_atoi_base_end:
		mov rax, r8 ; TODO mul
		mul r9
		ret

section .data
	unauthrozied db `\n\r\f\v\t +-`, 0
