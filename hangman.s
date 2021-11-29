
.data
	//Program start message
	entrmsg:   		.asciz "Hangman, by Hishaam Khan (669114)\n"
	len =			.-entrmsg

	//newgame prompt
	newmsg:			.asciz "Would you like to start a new game? (1 for yes, 0 for no)\n"
	newlen =		.-newmsg
	
	//newgame input format
	inputformat:	.asciz "%d"

	//newgame input store
	.align 2
	startinput:		.word 0

	//program end output message
	goodbye:		.asciz "Thanks for playing Hangman by Hishaam Khan (669114)!\n"
	gblen =			.-goodbye

	//startgame mesage
	start_msg:		.asciz "Welcome to Hangman!\n"
	start_msg_len =	.-start_msg

	//words file
	word_filename:	.asciz "words.txt"
	word_filemode:	.asciz "r"

	//file io error
	file_err_msg:	.asciz "File Error"
	file_err_msg_len = .-file_err_msg

	//words
	words:	.space 100

	word1:	.asciz ""
	word1_len:	.word 0
	word2:	.asciz ""
	word2_len:	.word 0
	word3:	.asciz ""
	word3_len:	.word 0
	word4:	.asciz ""
	word4_len:	.word 0
	word5:	.asciz ""
	word5_len:	.word 0
	word6:	.asciz ""
	word6_len:	.word 0
	word7:	.asciz ""
	word7_len:	.word 0
	word8:	.asciz ""
	word8_len:	.word 0
	word9:	.asciz ""
	word9_len:	.word 0
	word10:	.asciz ""
	word10_len:	.word 0


.global main

.text

main:
	@load Entry Message
	mov r0, #1
	ldr r1, =entrmsg
	ldr r2, =len

	@output Entry Message
	mov r7, #4
	svc #0

	b newgame
	
	
newgame:
	mov r0, #1
	ldr r1, =newmsg
	ldr r2, =newlen
	mov r7, #4
	svc #0						//output new game prompt
	
	ldr r0, =inputformat
	ldr r1, =startinput
	mov r2, #1
	bl scanf					//read input

	ldr r3, =startinput
	ldr r2, [r3]				//load the input into r2
	sub r2, r2, #1				//subtract input by 1
	cmp r2, #0					//compare (input - 1) by 0
	blt end						//if less than 0, end program
	beq startgame				//if equal to 0, start game

startgame:
	mov r0, #1
	ldr r1, =start_msg
	ldr r2, =start_msg_len
	mov r7, #4
	svc #0
	b ReadWords

file_err:
	mov r4, r0
	mov r0, #1
	ldr r1, =file_err_msg
	ldr r2, =file_err_msg_len
	mov r7, #4
	svc #0

ReadWords:
	@open the file
	ldr r0, =word_filename		//file descriptor
	mov r1, #0x42
	mov r2, #384				
	mov r7, #5					@openfile("words.txt", "r")
	svc 0

	cmp r0, #-1
	beq file_err

	mov r4, r0					//save file descriptor

	@read the file
	mov r0, r4
	ldr r1, =words
	mov r2, #200
	mov r7, #3
	svc #0

	mov r5, r0					//save num of characters
	mov r4, #0
	ldr r6, =word1_len
	ldr r2, =word1
read_word1:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq read_word2
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word1

read_word2:
	str r4, [r6]
	ldr r6, =word2_len
	mov r4, #0
	ldr r2, =word2
	ldrb r3, [r1]
	mov r4, #0
	cmp r3, #10					//check if character is a line break
	beq read_word3
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	b read_word2

read_word3:
	str r4, [r6]
	ldr r6, =word3_len
	mov r4, #0
	ldr r2, =word3
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq read_word4
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	b read_word3

read_word4:
	str r4, [r6]
	ldr r6, =word4_len
	mov r4, #0
	ldr r2, =word4
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq read_word5
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	b read_word4

read_word5:
	str r4, [r6]
	ldr r6, =word5_len
	mov r4, #0
	ldr r2, =word5
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq read_word6
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	b read_word5

read_word6:
	str r4, [r6]
	ldr r6, =word6_len
	mov r4, #0
	ldr r2, =word6
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq read_word7
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	b read_word6

read_word7:
	str r4, [r6]
	ldr r6, =word7_len
	mov r4, #0
	ldr r2, =word7
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq read_word8
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	b read_word7

read_word8:
	str r4, [r6]
	ldr r6, =word8_len
	mov r4, #0
	ldr r2, =word8
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq read_word9
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	b read_word8

read_word9:
	str r4, [r6]
	ldr r6, =word9_len
	mov r4, #0
	ldr r2, =word9
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq read_word10
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	b read_word9

read_word10:
	str r4, [r6]
	ldr r6, =word10_len
	mov r4, #0
	ldr r2, =word10
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq game
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	b read_word10

game:
	str r4, [r6]

	mov r0, #1
	ldr r1, =word1
	ldr r2, =word1_len
	mov r7, #4
	svc #0


b end
	

end:
	mov r0, #1
	ldr r1, =goodbye
	ldr r2, =gblen
	mov r7, #4
	svc #0						//output goodbye message

	mov r7, #1
	svc #0
	.end						//end program


.global scanf


