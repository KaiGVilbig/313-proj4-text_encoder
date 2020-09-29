FILE  =
FILE2 =
FILE3 =
FILE4 =
FILE5 =
FILE6 =
FILE7 =

all: $(FILE)

$(FILE): $(FILE).asm
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	gcc -m64 -o $(FILE) $(FILE).o
two: $(FILE).asm $(FILE2).asm
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	nasm -f elf64 -l $(FILE2).lst $(FILE2).asm
	gcc -m64 -o $(FILE) $(FILE2).o $(FILE).o

three: $(FILE).asm $(FILE2).asm $(FILE3).asm
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	nasm -f elf64 -l $(FILE2).lst $(FILE2).asm
	nasm -f elf64 -l $(FILE3).lst $(FILE3).asm
	gcc -m64 -o $(FILE) $(FILE2).o $(FILE3).o $(FILE).o 

four: $(FILE).asm $(FILE2).asm $(FILE3).asm $(FILE4).asm
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	nasm -f elf64 -l $(FILE2).lst $(FILE2).asm
	nasm -f elf64 -l $(FILE3).lst $(FILE3).asm
	nasm -f elf64 -l $(FILE4).lst $(FILE4).asm
	gcc -m64 -o $(FILE) $(FILE2).o $(FILE3).o $(FILE4).o $(FILE).o 

five: $(FILE).asm $(FILE2).asm $(FILE3).asm $(FILE4).asm $(FILE5).c
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	nasm -f elf64 -l $(FILE2).lst $(FILE2).asm
	nasm -f elf64 -l $(FILE3).lst $(FILE3).asm
	nasm -f elf64 -l $(FILE4).lst $(FILE4).asm
	gcc -c	$(FILE5).c -o $(FILE5).o
	gcc -m64 -o $(FILE) $(FILE2).o $(FILE3).o $(FILE4).o $(FILE5).o $(FILE).o -lm 

six: $(FILE).asm $(FILE2).asm $(FILE3).asm $(FILE4).asm $(FILE5).c $(FILE6).asm
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	nasm -f elf64 -l $(FILE2).lst $(FILE2).asm
	nasm -f elf64 -l $(FILE3).lst $(FILE3).asm
	nasm -f elf64 -l $(FILE4).lst $(FILE4).asm
	gcc -c  $(FILE5).c -o $(FILE5).o
	nasm -f elf64 -l $(FILE6).lst $(FILE6).asm
	gcc -m64 -o $(FILE) $(FILE2).o $(FILE3).o $(FILE4).o $(FILE5).o $(FILE6).o $(FILE).o -lm

seven: $(FILE).asm $(FILE2).asm $(FILE3).asm $(FILE4).asm $(FILE5).c $(FILE6).asm $(FILE7).asm
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	nasm -f elf64 -l $(FILE2).lst $(FILE2).asm
	nasm -f elf64 -l $(FILE3).lst $(FILE3).asm
	nasm -f elf64 -l $(FILE4).lst $(FILE4).asm
	gcc -c  $(FILE5).c -o $(FILE5).o
	nasm -f elf64 -l $(FILE6).lst $(FILE6).asm
	nasm -f elf64 -l $(FILE7).lst $(FILE7).asm
	gcc -m64 -o $(FILE) $(FILE2).o $(FILE3).o $(FILE4).o $(FILE5).o $(FILE6).o $(FILE7).o \
$(FILE).o -lm

run: $(FILE)
	./$(FILE)

clean: 
	rm *.o  *.lst

