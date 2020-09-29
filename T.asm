
	extern printf
	section .data
ty:	db	10, "___________.__                   __     _____.___.            ._.", 10, \
	"\__    ___/|  |__ _____    ____ |  | __ \__  |   | ____  __ __| |", 10, \
	"  |    |   |  |  \\__  \  /    \|  |/ /  /   |   |/  _ \|  |  \ |", 10, \
	"  |    |   |   Y  \/ __ \|   |  \    <   \____   (  <_> )  |  /\|", 10, \
	"  |____|   |___|  (____  /___|  /__|_ \  / ______|\____/|____/ __", 10, \
	"                \/     \/     \/     \/  \/                    \/", 10, 10, 0
ty1:	db	10, "Thank you for a great semester. This truly has been one of my favorite ", \
	"classes I have taken at ", 10, "college so far and I am looking forward to taking", \
	" your 411 class next semester!", 10, 0
fmty:	db	"%s%s", 0
	
	section .text
	global T
T:
	push rbp
	
	mov rdi, fmty
	mov rsi, ty1
	mov rdx, ty
	mov rax, 0
	call printf

	pop rbp
	ret
