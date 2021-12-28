
.data

	//line break
	linebreak:		.asciz "\n"
	linebreak_len = .-linebreak
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
	goodbye:		.asciz "\nThanks for playing Hangman by Hishaam Khan (669114)!\n"
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
	.align 4
	word1:	.asciz "                  \n"		//memory address 135520
	word1_len:	.word 0
	.align 4
	word2:	.asciz "                  \n"		//memory address 135415
	word2_len:	.word 0
	.align 4
	word3:	.asciz "                  \n"
	word3_len:	.word 0
	.align 4
	word4:	.asciz "                  \n"
	word4_len:	.word 0
	.align 4
	word5:	.asciz "                  \n"
	word5_len:	.word 0
	.align 4
	word6:	.asciz "                  \n"
	word6_len:	.word 0
	.align 4
	word7:	.asciz "                  \n"
	word7_len:	.word 0
	.align 4
	word8:	.asciz "                  \n"
	word8_len:	.word 0
	.align 4
	word9:	.asciz "                  \n"
	word9_len:	.word 0
	.align 4
	word10:	.asciz "                  \n"
	word10_len:	.word 0

	//guess_message
	.align 2
	guess_message:	.asciz "     Enter your guess (A-Z), 2 to restart, 0 to quit: "			//address 135832
	guess_message_len = .-guess_message		
	.align 2											
	guess_message_lessthan3:	.asciz "Enter your guess (A-Z), 1 to show a letter, 2 to restart, 0 to quit: "
	guess_message_lessthan3_len = .-guess_message_lessthan3

	//hangman frames
	guess_6_left:	.asciz "______\n|/  |\n|\n|\n|\n|\n|_______\n"
	guess_6_left_len = .-guess_6_left

	guess_5_left:	.asciz "______\n|/  |\n|   O\n|\n|\n|\n|_______\n"
	guess_5_left_len = .-guess_5_left

	guess_4_left:	.asciz "______\n|/  |\n|   O\n|   |\n|   |\n|\n|_______\n"
	guess_4_left_len = .-guess_4_left

	guess_3_left:	.asciz "______\n|/  |\n|   O\n|  \\|\n|   |\n|\n|_______\n"
	guess_3_left_len = .-guess_3_left

	guess_2_left:	.asciz "______\n|/  |\n|   O\n|  \\|/\n|   |\n|\n|_______\n"
	guess_2_left_len = .-guess_2_left

	guess_1_left:	.asciz "______\n|/  |\n|   O\n|  \\|/\n|   |\n|  /\n|_______\n"
	guess_1_left_len = .-guess_1_left

	guess_0_left:	.asciz "______\n|/  |\n|   x\n|  \\|/\n|   |\n|  / \\\n|_______\n"
	guess_0_left_len = .-guess_0_left

	//stats
	WordLabel:	.asciz "Word: "
	WordLabel_Len = .-WordLabel
	wordShown1:		.asciz "--------------------\n"
	wordShown2:		.asciz "--------------------\n"
	wordShown3:		.asciz "--------------------\n"
	wordShown4:		.asciz "--------------------\n"
	wordShown5:		.asciz "--------------------\n"
	wordShown6:		.asciz "--------------------\n"
	wordShown7:		.asciz "--------------------\n"
	wordShown8:		.asciz "--------------------\n"
	wordShown9:		.asciz "--------------------\n"
	wordShown10:	.asciz "--------------------\n"

	Guesses_left:	.asciz "Guesses Left: %d"
	Guesses_left_len = .-Guesses_left

	guessValue:		.asciz "0"
	guessValue_len = .-guessValue

	//guess store
	.align 2
	guess_input:	.space 100
	invalid_guess_msg:	.asciz "Invalid Input, try again:"
	invalid_guess_msg_len = .-invalid_guess_msg

	guesses: .asciz "                          "
	guesses_len = .-guesses

	incorrect_guesses_lbl:	.asciz "Incorrect Guesses: "
	incorrect_guesses_lbl_len = .-incorrect_guesses_lbl

	incorrect_guesses: 		.asciz "      "
	incorrect_guesses_len = .-incorrect_guesses

	already_entered_msg:	.asciz "You've already tried this! Try something else: "
	already_entered_msg_len = .-already_entered_msg
	//game end messages
	game_win_p1:	.asciz "Well Done! You won with %d guesses left."
	game_win_p1_len = .-game_win_p1

	game_lose:	.asciz "Game Over! The word was: "
	game_lose_len = .-game_lose

	end_game_msg:	 .asciz "Enter 1 to start again or 0 to exit: "


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
	.LTORG
startgame:
	mov r0, #1
	ldr r1, =start_msg
	ldr r2, =start_msg_len
	mov r7, #4
	svc #0
	b ReadWords
	.LTORG
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
	beq pre_word2
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1				//r4 stores length of the word
	add r1, r1, #1
	b read_word1
	.LTORG
pre_word2:
	str r4, [r6]
	ldr r6, =word2_len
	mov r4, #0
	ldr r2, =word2
	add r1, r1, #1
	b read_word2

read_word2:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq pre_word3
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word2
	.LTORG
pre_word3:
	str r4, [r6]
	ldr r6, =word3_len
	mov r4, #0
	ldr r2, =word3
	add r1, r1, #1
	b read_word3
	
	and r0, r0, #10
	mov r8, #10
	udiv r6, r0, r8
	sub r0, r0, r7
read_word3:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq pre_word4
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word3
.LTORG
pre_word4:
	str r4, [r6]
	ldr r6, =word4_len
	mov r4, #0
	ldr r2, =word4
	add r1, r1, #1
	b read_word4

read_word4:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq pre_word5
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word4
	.LTORG
pre_word5:
	str r4, [r6]
	ldr r6, =word5_len
	mov r4, #0
	ldr r2, =word5
	add r1, r1, #1
	b read_word5

read_word5:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq pre_word6
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word5
	.LTORG
pre_word6:
	str r4, [r6]
	ldr r6, =word6_len
	mov r4, #0
	ldr r2, =word6
	add r1, r1, #1
	b read_word6

read_word6:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq pre_word7
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word6
	.LTORG
pre_word7:
	str r4, [r6]
	ldr r6, =word7_len
	mov r4, #0
	ldr r2, =word7
	add r1, r1, #1
	b read_word7

read_word7:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq pre_word8
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word7
	.LTORG
pre_word8:
	str r4, [r6]
	ldr r6, =word8_len
	mov r4, #0
	ldr r2, =word8
	add r1, r1, #1
	b read_word8

read_word8:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq pre_word9
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word8
	.LTORG
pre_word9:
	str r4, [r6]
	ldr r6, =word9_len
	mov r4, #0
	ldr r1, =start_msg
	ldr r2, =start_msg_len
	mov r7, #4
	ldr r2, =word9
	add r1, r1, #1
	b read_word9

read_word9:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq pre_word10
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word9
	.LTORG
pre_word10:
	str r4, [r6]
	ldr r6, =word10_len
	mov r4, #0
	ldr r2, =word10
	add r1, r1, #1
	b read_word10
	
read_word10:
	ldrb r3, [r1]
	cmp r3, #10					//check if character is a line break
	beq game
	strb r3, [r2]
	add r3, r3, #1
	add r2, r2, #1
	add r4, r4, #1
	add r1, r1, #1
	b read_word10
	.LTORG
game:
	str r4, [r6]

	mov r0, #0
	bl time
	bl srand
	bl rand

	mov r7, #11
	udiv r5, r0, r7
	mul r8, r5, r7 
	sub r1, r0, r8
	mov r0, r1

	cmp r0, #0
	beq pre_game1

	cmp r0, #1
	beq pre_game2

	cmp r0, #2
	beq pre_game3

	cmp r0, #3
	beq pre_game4

	cmp r0, #4
	beq pre_game5

	cmp r0, #5
	beq pre_game6

	cmp r0, #6
	beq pre_game7

	cmp r0, #7
	beq pre_game8

	cmp r0, #8
	beq pre_game9

	cmp r0, #9
	beq pre_game10

	b game

	.LTORG
b end

guess6left:
	mov r0, #1
	ldr r1, =guess_6_left
	ldr r2, =guess_6_left_len
	mov r7, #4
	svc #0
	bx lr

guess5left:
	mov r0, #1
	ldr r1, =guess_5_left
	ldr r2, =guess_5_left_len
	mov r7, #4
	svc #0
	bx lr
	
guess4left:
	mov r0, #1
	ldr r1, =guess_4_left
	ldr r2, =guess_4_left_len
	mov r7, #4
	svc #0
	bx lr
	
guess3left:
	mov r0, #1
	ldr r1, =guess_3_left
	ldr r2, =guess_3_left_len
	mov r7, #4
	svc #0
	bx lr
	
guess2left:
	mov r0, #1
	ldr r1, =guess_2_left
	ldr r2, =guess_2_left_len
	mov r7, #4
	svc #0
	bx lr
	
guess1left:
	mov r0, #1
	ldr r1, =guess_1_left
	ldr r2, =guess_1_left_len
	mov r7, #4
	svc #0
	bx lr
	
guess0left:
	mov r0, #1
	ldr r1, =guess_0_left
	ldr r2, =guess_0_left_len
	mov r7, #4
	svc #0
	bx lr

toUpper:
	sub r3, r3, #32
	bx lr

guess:
	mov r0, #0
	ldr r1, =guess_input
	mov r2, #99
	mov r7, #3
	svc #0
	push {lr}
	mov r8, #0
	bl read_guess
	pop {lr}
	cmp r7, #1
	push {lr}
	bleq invalid_input
	pop {lr}
	beq guess
	cmp r8, #2
	push {lr}
	bleq invalid_input
	pop {lr}
	beq guess

	mov r9, #0
	push {lr}
	bl check_if_entered
	pop {lr}
	cmp r9, #1
	beq guess

	bx lr
	.LTORG
read_guess:
	ldrb r3, [r1]
	cmp r3, #32
	addeq r1, r1, #1
	beq read_guess

	cmp r3, #48
	beq pre_end

	mov r9, #0
	cmp r3, #49
	addeq r9, r9, #1
	cmp r6, #3
	addlt r9, r9, #1
	cmp r9, #2
	moveq r8, #0
	bleq reveal_letter
	bxeq lr

	cmp r3, #50
	popeq {lr}
	beq newgame

	mov r8, #0
	mov r9, #0
	mov r7, #0
	cmp r3, #65
	addlt r7, r7, #1
	cmp r3, #97
	addlt r8, r8, #1
	cmp r3, #90
	addgt r8, r8, #1
	cmp r8, #2
	bxeq lr
	cmp r3, #97
	addge r9, r9, #1
	cmp r3, #122
	addle r9, r9, #1
	cmp r9, #2
	push {lr}
	bleq toUpper
	pop {lr}
	bx lr

process_letter:
	ldrb r10, [r5]
	push {lr}
	cmp r10, r3 
	bleq store_letter
	pop {lr}
	add r8, r8, #1
	add r5, r5, #1
	add r11, r11, #1
	cmp r8, r9
	bne process_letter
	cmp r2, #0
	push {lr}
	bleq incorrect_guess
	pop {lr}
	bx lr

store_letter:
	add r2, r2, #1
	strb r10, [r11]
	bx lr

check_if_entered:
	ldr r8, =incorrect_guesses
	mov r7, #0
	push {r11}
	ldr r11, =incorrect_guesses_len
	push {lr}
	bl check_incorrect_guesses
	pop {lr}
	pop {r11}

	mov r10, #0
	push {lr}
	bl check_displayed_word
	pop {lr}

	bx lr

check_displayed_word:
	ldrb r8, [r11]
	cmp r3, r8
	push {lr}
	bleq already_entered
	pop {lr}
	addeq r9, r9, #1
	bxeq lr
	add r10, r10, #1
	add r11, r11, #1
	cmp r10, r4
	bxeq lr
	b check_displayed_word

check_incorrect_guesses:
	ldrb r10, [r8]
	cmp r3, r10
	addeq r9, r9, #1
	push {r7}
	push {lr}
	bleq already_entered
	pop {lr}
	pop {r7}
	bxeq lr
	add r8, r8, #1
	add r7, r7, #1
	cmp r7, r11
	bxeq lr
	b check_incorrect_guesses

already_entered:
	mov r0, #1
	ldr r1, =already_entered_msg
	ldr r2, =already_entered_msg_len
	mov r7, #4
	svc #0
	bx lr

reveal_letter:
	ldrb r10, [r5]
	ldrb r9, [r11]
	cmp r9, r10
	movne r3, r10
	popne {lr}
	bxne lr
	add r8, r8, #1
	add r5, r5, #1
	add r11, r11, #1
	cmp r8, r9
	bne reveal_letter
	bxeq lr

invalid_input:
	mov r0, #1
	ldr r1, =invalid_guess_msg
	ldr r2, =invalid_guess_msg_len
	mov r7, #4
	svc #0
	bx lr

incorrect_guess:
	subeq r6, r6, #1
	ldr r1, =incorrect_guesses
	mov r4, #6
	sub r2, r4, r6
	add r1, r1, r2
	strb r3, [r1]
	bx lr

print_guess_message:
	mov r0, #1
	ldr r1, =guess_message
	add r1, r1, #5
	ldr r2, =guess_message_len
	sub r2, r2, #5
	mov r7, #4
	svc #0
	bx lr

print_guess_message_lessthan3:
	mov r0, #1
	ldr r1, =guess_message_lessthan3
	ldr r2, =guess_message_lessthan3_len
	mov r7, #4
	svc #0
	bx lr

check_if_done:
	ldrb r2, [r1]
	ldrb r3, [r5]
	cmp r2, r3
	bxne lr
	add r8, r8, #1
	cmp r8, r9
	beq game_win
	add r1, r1, #1
	add r5, r5, #1
	b check_if_done
	
pre_game1:
	mov r6, #6				//guesses left
	ldr r12, =guesses		
	b game_word1

game_word1:
	ldr r5, =word1
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown1
	ldr r3, =word1_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown1
	ldr r4, =word1_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word1_len
	ldr r9, [r9]
	ldr r11, =wordShown1
	ldr r5, =word1
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown1
	ldr r9, =word1_len
	ldr r9, [r9]
	ldr r5, =word1
	bl check_if_done


	b game_word1

pre_game2:
	mov r6, #6				//guesses left
	ldr r12, =guesses		
	b game_word2

game_word2:
	ldr r5, =word2
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown2
	ldr r3, =word2_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown2
	ldr r4, =word2_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word2_len
	ldr r9, [r9]
	ldr r11, =wordShown2
	ldr r5, =word2
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown2
	ldr r9, =word2_len
	ldr r9, [r9]
	ldr r5, =word2
	bl check_if_done


	b game_word2

pre_game3:
	mov r6, #6				//guesses left
	ldr r12, =guesses
	b game_word3

game_word3:
	ldr r5, =word3
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown3
	ldr r3, =word3_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown3
	ldr r4, =word3_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word3_len
	ldr r9, [r9]
	ldr r11, =wordShown3
	ldr r5, =word3
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown3
	ldr r9, =word3_len
	ldr r9, [r9]
	ldr r5, =word3
	bl check_if_done


	b game_word3

pre_game4:
	mov r6, #6				//guesses left
	ldr r12, =guesses
	b game_word4

game_word4:
	ldr r5, =word4
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown4
	ldr r3, =word4_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown4
	ldr r4, =word4_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word4_len
	ldr r9, [r9]
	ldr r11, =wordShown4
	ldr r5, =word4
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown4
	ldr r9, =word4_len
	ldr r9, [r9]
	ldr r5, =word4
	bl check_if_done


	b game_word4

pre_game5:
	mov r6, #6				//guesses left
	ldr r12, =guesses
	b game_word5

game_word5:
	ldr r5, =word5
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown5
	ldr r3, =word5_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown5
	ldr r4, =word5_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word5_len
	ldr r9, [r9]
	ldr r11, =wordShown5
	ldr r5, =word5
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown5
	ldr r9, =word5_len
	ldr r9, [r9]
	ldr r5, =word5
	bl check_if_done


	b game_word5

pre_game6:
	mov r6, #6				//guesses left
	ldr r12, =guesses
	b game_word6

game_word6:
	ldr r5, =word6
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown6
	ldr r3, =word6_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown6
	ldr r4, =word6_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word6_len
	ldr r9, [r9]
	ldr r11, =wordShown6
	ldr r5, =word6
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown6
	ldr r9, =word6_len
	ldr r9, [r9]
	ldr r5, =word6
	bl check_if_done


	b game_word6

pre_game7:
	mov r6, #6				//guesses left
	ldr r12, =guesses
	b game_word7

game_word7:
	ldr r5, =word7
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown1
	ldr r3, =word7_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown7
	ldr r4, =word7_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word7_len
	ldr r9, [r9]
	ldr r11, =wordShown7
	ldr r5, =word7
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown7
	ldr r9, =word7_len
	ldr r9, [r9]
	ldr r5, =word7
	bl check_if_done


	b game_word7

pre_game8:
	mov r6, #6				//guesses left
	ldr r12, =guesses
	b game_word8

game_word8:
	ldr r5, =word8
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown8
	ldr r3, =word8_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown8
	ldr r4, =word8_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word8_len
	ldr r9, [r9]
	ldr r11, =wordShown8
	ldr r5, =word8
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown8
	ldr r9, =word8_len
	ldr r9, [r9]
	ldr r5, =word8
	bl check_if_done


	b game_word8

pre_game9:
	mov r6, #6				//guesses left
	ldr r12, =guesses
	b game_word9

game_word9:
	ldr r5, =word9
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown9
	ldr r3, =word9_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown9
	ldr r4, =word9_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word9_len
	ldr r9, [r9]
	ldr r11, =wordShown9
	ldr r5, =word9
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown9
	ldr r9, =word9_len
	ldr r9, [r9]
	ldr r5, =word9
	bl check_if_done


	b game_word9

pre_game10:
	mov r6, #6				//guesses left
	ldr r12, =guesses
	b game_word10

game_word10:
	ldr r5, =word10
	ldr r7, =guessValue
	strb r6, [r7]

	cmp r6, #6
	bleq guess6left

	cmp r6, #5
	bleq guess5left

	cmp r6, #4
	bleq guess4left

	cmp r6, #3
	bleq guess3left
	
	cmp r6, #2
	bleq guess2left

	cmp r6, #1
	bleq guess1left

	cmp r6, #0
	bleq guess0left
	beq game_lost

	mov r0, #1
	ldr r1, =WordLabel
	ldr r2, =WordLabel_Len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =wordShown10
	ldr r3, =word10_len
	ldr r2, [r3]
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	ldr r0, =Guesses_left
	mov r1, r6
	bl printf
	mov r0, #0
	bl fflush

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses_lbl
	ldr r2, =incorrect_guesses_lbl_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =incorrect_guesses
	ldr r2, =incorrect_guesses_len
	mov r7, #4
	svc #0

	mov r0, #1
	ldr r1, =linebreak
	ldr r2, =linebreak_len
	mov r7, #4
	svc #0

	cmp r6, #3
	blge print_guess_message
	bllt print_guess_message_lessthan3

	ldr r11, =wordShown10
	ldr r4, =word10_len
	ldrb r4, [r4]
	bl guess
	
	mov r2, #0
	mov r8, #0
	ldr r9, =word10_len
	ldr r9, [r9]
	ldr r11, =wordShown10
	ldr r5, =word10
	bl process_letter

	mov r8, #0
	ldr r1, =wordShown10
	ldr r9, =word10_len
	ldr r9, [r9]
	ldr r5, =word10
	bl check_if_done


	b game_word10

game_win:
	ldr r0, =game_win_p1
	ldr r1, =guessValue
	ldrb r1, [r1]		
	bl printf
	mov r0, #0
	bl fflush

	b pre_end		

game_lost:
	mov r0, #1
	ldr r1, =game_lose
	ldr r2, =game_lose_len
	mov r7, #4
	svc #0

	mov r0, #1
	mov r1, r5
	mov r2, r9
	mov r7, #4
	svc #0

	b pre_end

pre_end:
	mov r0, #1
	ldr r1, =goodbye
	ldr r2, =gblen
	mov r7, #4
	svc #0						//output goodbye message

	b newgame

end:
	mov r7, #1
	svc #0
	.end						//end program


.global scanf
.global printf



