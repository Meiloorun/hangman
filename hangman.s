
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
	word2:	.asciz ""
	word3:	.asciz ""
	word4:	.asciz ""
	word5:	.asciz ""
	word6:	.asciz ""
	word7:	.asciz ""
	word8:	.asciz ""
	word9:	.asciz ""
	word10:	.asciz ""


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

ReadWords:mov
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


