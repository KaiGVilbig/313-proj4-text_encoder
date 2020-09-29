
	section .data
enter_msg_txt:	db	"Enter new message: ", 0
error_msg:	db	"invalid message, keeping current", 10, 0
error_msg_len:	equ	$-error_msg
orig_msg:	db	"This is the original message.", 0
	
	section .text
	global validate
validate:

        mov r9b, [rdi]		;move first character into r9

	cmp r9, "A"		;check if first char is less than A
	jl error

	cmp r9, "Z"		;check if fist char is greater than Z
	jg error		;this way all thats left is between A-Z

	mov rcx, 1		;after returning to main if this is 1, means
	xor r9, r9		;string is accepted. 0 means denied
	mov [rdi + rsi], r9b
	dec rsi
	mov r9b, [rdi + rsi]
	cmp r9, "."		;check if last letter is !, ., or ?
	je validate + 57	;if so, jump to the clear msg section
	cmp r9, "!"
	je validate + 57
	cmp r9, "?"
	je validate + 57
	call error		
			
	mov rax, rcx		;return
	ret
	
error:

	mov rax, 1
	mov rdi, 1		;display error mseeage
	mov rsi, error_msg
	mov rdx, error_msg_len
	syscall

	mov rcx, 0			;making rcx 0 so meaning string was denied
	jmp validate + 57	;jump to return to main
