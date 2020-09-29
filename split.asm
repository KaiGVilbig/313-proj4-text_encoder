	
	section .text
	global split
split:

	dec rcx			;take the back "half" of the string (split_val to end)
	xor r10, r10		;and put it at the front
	mov r11, r9
	dec r11
	inc r11
	mov al, [r8 + r11]
	mov [rsi + r10], al
	inc r10
	cmp r11, rcx
	jl split + 12

	dec r9			;take the front of the string and put it at the back
	xor r11, r11
	dec r11
	inc r11
	mov al, [r8 + r11]
	mov [rsi + r10], al
	inc r10
	cmp r11, r9
	jl split + 40

	mov rax, rsi
	ret
