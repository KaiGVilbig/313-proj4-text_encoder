
	;; my code written in c++ so that I know what to do as
	;; I code in assembly
	;; 
	;; int h = 0;
	;; int i = 0;
	;; int j = 0;
	;; while i != root;
	;; 	while j < len;
	;; 		new_msg[h] = orig_msg[i+j];
	;; 		j + jmp_int;
	;;		h++
	;; 	j = 0;
	;; 	i++
	;; return
		
	section .text
	global jump
jump:

	mov r10, 0		;int h = 0
	mov r8, 0		;int i = 0
	mov r9, 0		;int j = 0
	
	cmp r8, rdx		;while i =! jmp_int
	je jump	+ 55		;escae loop
	add r10, r8		;r10 = [i + ]

	cmp r10, rcx		;2nd loop. 
	jge jump + 47		;escape 2nd loop
	mov al, [rdi + r10]	;encryption
	mov [rsi + r9], al
       	add r10, rdx		;j + jmp_int
	inc r9			;h++
	jmp jump + 26		;2nd loop

	inc r8			;i++
	xor r10, r10		;j = 0		
	jmp jump + 18		;loop
	
	mov rax, rsi
	ret
