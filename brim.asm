
	extern printf
	section .data
Brim:	db	10, "███████████████████████████████████████████████████████████████████", 10, \
	"███████████████████████████████    ████████████████████████████████", 10, \
	"█████████████████████▀▀▀▀▀                  ▀▀▀████████████████████", 10, \
	"██████████████▀▀▀                                 ▀████████████████", 10, \
	"███████████▀                                         ▀█████████████", 10, \
	"█████████▀                                             ▀███████████", 10, \
	"████████            .                                    ██████████", 10, \
	"███████            ██    ██,                              ▀████████", 10, \
	"██████▌         .█ ▀█▌  ██▀ s                              ████████", 10, \
	"██████          └██ ▀█ ██  ███                             └███████", 10, \
	"██████           ███████   ██                               ███████", 10, \
	"██████           ██ ▀███   █▌                               ███████", 10, \
	"██████          ╒█▌   ████ ██                               ███████", 10, \
	"██████          ██   ╒█▌ ▀███╤                              ║██████", 10, \
	"██████               ╫██    ▀                               ║██████", 10, \
	"██████                                                      ║██████", 10, \
	"█████▌                                                      ║██████", 10, \
	"███████████▌╓¬,...                  ..⌐¬¬╓╓┐..¬¬╓¬╓╓╓████▓▌████████", 10, \
	"███████████████████████████████████████████████████████████████████", 10, \
	"		    WHOA, YANKEE W NO BRIM!", 10, 10, 0

	section .text
	global brim
brim:
	push rbp

	mov rdi, Brim
	mov rax, 0
	call printf

	pop rbp
	ret
