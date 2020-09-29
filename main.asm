
	extern scanf
	extern printf
	extern validate
	extern split
	extern jump
	extern root
	extern brim
	extern T
	
	section .data
menu_options_txt:	db	10, "Encryption menu options:", 10,\
	"d - display current message", 10,\
	"r - read new message", 10,\
	"s - split encrypt", 10,\
	"j - jump encrypt", 10,\
	"q - quit program", 10,\
	"enter option letter -> ", 0 ;whole menu message in one for ease of printing

msg:	db	"This is the original message.", 0
curr_msg_txt:	db	"Current message: ", 0
jmp_enc_msg:	db	"Jump encryption: ", 0
	
invalid_op_msg:	db	"invalid option, try again", 10, 0	

enter_split_val:	db	"Enter split value: ", 0
invalid_split_val:	db	"Invalid split value", 10, \
	"Split value has to be less than messaga length. ", \
	"Current message length is = ", 0
split_enc_txt:	db	"Shift encryption: ", 0
	
exit_msg:	db	"Goodbye!", 10, 10, 0 ;quit msg.

display_op:	db	"d", 0	;display
read_op:	db	"r", 0	;read
split_op:	db	"s", 0	;split
jump_op:	db	"j", 0	;jump
quit_op:	db	"q", 0	;quit 
b:	db	"B", 0		;what could this be?
t:	db	"T", 0
	
enter_msg_txt:	  db    "Enter new message: ", 0 ;used for read messages part
enter_val_txt:	db	"Enter jump interval between 2-", 0 ;used for jmp val
evt2:	db	" -> ", 0
fmtevt:	db	"%s%d%s", 0	;format used for the above message
fmtd:	db	"%d", 0		;format for pringting a digit
fmt0:	db	"%s%d", 10, 0	;format used for invalid split value
fmt:	db	"%s", 0		;format for menu_options_txt
fmt1:	db	"%s%s", 10, 0	;format for enter_option_letter
newline:	db	10	;newline
	
	section .bss
enter_option:	resb	8	;store the option for menu
new_msg:	resb	2048	;store new user entered message
orig_msg_len:	resb	8
msg_len:	resb	8	;store len of new msg
jmp_int:	resb	8	;jump interval
split_int:	resb	8 	;split value
	
	section .text
	global main
main:	
	mov r8, 0x1D		;had to put lenfth og origional message here because
	mov [orig_msg_len], r8 	;when I did it above where I put the txt when typing new
	push rbp		;msg in the curr_msg_txt would get over written
				
	mov rdi, fmt		;format and print menu_options_txt
	mov rsi, menu_options_txt
	mov rax, 0
	call printf

	mov rsi, enter_option	;take user input letter and put into enter_option
	mov rdi, fmt
	mov rax, 0
	call scanf
	
	mov r9b, [enter_option]	;compare the entered letter to display to see if d has
	mov r8b, [display_op]	;been entered
	cmp r9, r8
	jne main + 116
	mov rbx, curr_msg_txt
	call display_msg
	jmp main + 317		;loop
	
	mov r9b, [enter_option]	;compare the entered letter to read to see if r has 
	mov r8b, [read_op]	;been entered
	cmp r9, r8
	jne main + 147
	call validate_call
	jmp main + 317		;loop

	mov r9b, [enter_option]	;compare the entered letter to split to see if s has
	mov r8b, [split_op]	;been entered
	cmp r9, r8
	jne main + 178
	call split_val
	jmp main + 317		;loop
	
	mov r9b, [enter_option]	;compare the entered letter to jump to see if j has
	mov r8b, [jump_op]	;been entered
	cmp r9, r8
	jne main + 206
	call jump_call
	jmp main + 317		;loop
	
	mov r9b, [enter_option] ;compare the entered letter to quit to see if q has
	mov r8b, [quit_op] 	;been entered
	cmp r9, r8
	je exit

	mov r9b, [enter_option]	;well, well, well, what is this?
	mov r8b, [b]
	cmp r9, r8
	jne main + 259
	call brim
	jmp main + 317

	mov r9b, [enter_option]	;what could this be?
	mov r8b, [t]		;this will exit the program as if q was pressed
	cmp r9, r8
	jne main + 290
	call T
	jmp exit
	
	mov rdi, fmt		;invalid option message
	mov rsi, invalid_op_msg
	call printf
	jmp main + 317		;loop

	pop rbp
	jmp main + 14
	
display_msg:

	push rbp
	mov rdi, fmt1 		;print current message
	mov rsi, rbx
	mov rdx, msg
	mov rax, 0
	call printf
	pop rbp
	
	ret
	
validate_call:	

        mov rax, 1              ;write enter_msg text
	mov rdi, 1
	mov rsi, enter_msg_txt
	mov rdx, 19
	syscall

	mov rax, 0		;read in new_msg from user input
	mov rdi, 0
	mov rsi, new_msg
	mov rdx, 2048
	syscall

	call str_len
	
	mov rdi, new_msg
	mov rsi, [msg_len]
	call validate		;validate string
	mov r10, rax		;r10 stores 0 or 1 for true or false msg accept or nah
	cmp r10, 0
	je validate_call + 106	;skip the setting string to new one if false

	mov rax, new_msg
	call replace_str
	ret

split_call:

	mov rbx, curr_msg_txt	;display message before split
	call display_msg
	
	mov r8, msg		;call split
	mov r9, [split_int]
	mov rcx, [orig_msg_len]
	mov rsi, new_msg
	call split

	call str_len		;replace the string
	call replace_str

	mov rbx, split_enc_txt	;display the new string
	call display_msg
	ret
	
jump_call:	

	mov rdi, [orig_msg_len]	;get the root of teh message length
	call root
	mov rdx, rax

	mov rdi, fmtevt		;print option to enter jump val
	mov rsi, enter_val_txt
	mov rdx, rdx
	mov rcx, evt2
	mov rax, 0
	call printf
	
	push rbp		;get the user input on how to jump
	mov rsi, jmp_int
	mov rdi, fmtd
	mov rax, 0
	call scanf
	pop rbp

	mov rbx, curr_msg_txt	;display unedited text
	call display_msg
	
	mov rdi, msg		;call jump
	mov rsi, new_msg
	mov rdx, [jmp_int]
	mov rcx, [orig_msg_len]
	call jump

	call str_len		;replace string
	call replace_str
	
	mov rbx, jmp_enc_msg	;display edited string
	call display_msg
	ret
	
str_len:

        mov r8, 0               ;get the length of the new string
	mov r9b, [new_msg + r8]
	cmp r9, 10
	je str_len + 30
	cmp r9, 0
	je str_len + 30
	inc r8
	jmp str_len + 6
	mov [msg_len], r8
	ret
	
replace_str:	

	mov r11, [msg_len]
	mov r8, 0		;clear origional message
	mov r9b, [msg + r8]
	cmp r9, 0x0
	je replace_str + 39
	sub [msg + r8], r9b
	inc r8
	jmp replace_str + 14

	mov r8, 0		;put whats in new_msg into msg
	dec r8
	inc r8
	mov r9b, [rax + r8]
	mov [msg + r8], r9b
	cmp r11, r8
	jne replace_str + 48

	mov [orig_msg_len], r11 ;update the length of orig string
	ret

split_val:
		
	mov rdi, fmt		;print option to enter split val
	mov rsi, enter_split_val
	mov rax, 0
	call printf

	push rbp		;get split value from user
	mov rsi, split_int
	mov rdi, fmtd
	mov rax, 0
	call scanf
	pop rbp
	
	mov rbx, [split_int]	;make sure split_val is not longer than message length
	mov rcx, [orig_msg_len]
	cmp rbx, rcx
	jl split_val + 123
		
	mov rdi, fmt0		;invalid split int message
	mov rsi, invalid_split_val
	mov rdx, [orig_msg_len]
	mov rax, 0
	call printf

	jmp split_val + 128
	call split_call		;call split
	ret
	
exit:
	mov rdi, fmt		;print quit msg 
	mov rsi, exit_msg
	mov rax, 0
	call printf

	mov rax, 0		;exit
	ret
