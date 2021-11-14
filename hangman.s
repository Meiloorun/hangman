
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
	goodbye:		.asciz "Thanks for Playing!\n"
	gblen =			.-goodbye

	//startgame mesage
	start_msg:		.asciz "Welcome to Hangman!\n"
	start_msg_len =	.-start_msg

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


