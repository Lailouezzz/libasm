bits 64

section .text

global ft_atoi_base_int

	ft_atoi_base_int:
		mov r8, 0
		jmp skipspace_start
	skipspace:
		inc rdi
	skipspace_start:
		mov cl, BYTE [rdi]
		cmp cl, 0x0
		je ft_atoi_base_int_end
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
		mov cl, BYTE [rdi]
	sign_start:
		cmp cl, 0x0
		je ft_atoi_base_int_end
		cmp cl, '+'
		je sign_plus
		cmp cl, '-'
		je sign_minus
		xor r8, r8
		jmp calc_start
	
	alpha_minus:
		sub cl, 'a'-10
		cmp cl, 16
		ja ft_atoi_base_int_end ; char > 'f'
		jmp add_to_res
	alpha_major:
		sub cl, 'A'-10
		cmp cl, 16
		ja ft_atoi_base_int_end ; char > 'F'
		jmp add_to_res
	numeric:
		sub cl, '0'
		cmp cl, 9
		ja ft_atoi_base_int_end ; char > '9'
	add_to_res:
		cmp rcx, rsi
		jae ft_atoi_base_int_end
		mov rax, r8
		mul rsi
		mov r8, rax
		add r8, rcx
		inc rdi
		movzx rcx, BYTE [rdi]
	calc_start:
		cmp cl, 'a'
		jae alpha_minus
		cmp cl, 'A'
		jae alpha_major
		cmp cl, '0'
		jae numeric
	ft_atoi_base_int_end:
		mov rax, r8 ; TODO mul
		mul r9
		ret
