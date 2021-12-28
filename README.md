# Hangman Instructions

Page changelog

Date	Changes

03 November	Initial version released

24 November	Deadline updated

22 December	Updated early feedback guidance and clarified mark breakdown for error messages (they must be descriptive, not generic, and exact error messages, which ideally should be used, still stand)

Important information

Academic misconduct

Coursework will be routinely checked for academic misconduct. Your submission must be your own work. Please read the Student Handbook to ensure that you know what this means. Do not give your code to anyone else, either before or after the coursework deadline.

Deadline and late submissions
Due date: 04 January 16:00

Late submissions for any part of this assignment will incur the standard 10% penalty per day, applied to your overall grade. If any work is submitted later than two days after the deadline, your grade will be zero.

Use of virtual Pi
It is very important to back up your files regularly. The files in the virtual Raspberry Pi may be cleared without notice. You should use scp to copy your files to your University home directory or other secured location.

Section A: Theory (20%)
Complete the test on SurreyLearn.

Save progress as you go and only submit when you are happy with your answers. Once you submit, you will not be able to change any answers later—you will have to complete and submit the test from scratch. You may resubmit the quiz as many times as you like, but only your last submission will count.

Section B: Programming (80%)
QUICK LINKS: word file, hangman file, mark scheme

Overview
You will write a hangman game using ARM Assembly. The player attempts to guess a hidden word, one letter at a time. Marks are awarded based on functionality implemented.

You are given a text file with 10 words for the game:

TESTS
CHALLENGE
UNIVERSITY
STUDENTS
BALANCE
FEEDBACK
BINARY
INTELLIGENCE
CARTOGRAPHERS
CHARACTERISTICALLY

A random secret word is read from the text file. Alternatively, you can list the 10 words in an array in the program (slightly less marks are given for this option) and choose a random word from the array.

The player has six chances to guess the letters for each game. Valid inputs of the game are from A-Z or a-z (convert the letter into a capital if a small letter is input).

For each correct letter guessed, the letter is revealed at its correct location or locations in the word. For each incorrect letter guessed, an additional segment of the hangman is displayed.

The game is won when the entire word is guessed, whereas the game is lost when the entire hangman is displayed.

You should not allow the player to make an illegal move, or to enter invalid characters. For example, a player cannot guess the same letter twice, or enter a number (other than 0-2 depending on which functionality you attempt), or enter a non-printable character.

Submission
Submit your .S file using SurreyLearn. You can submit as many times as you link, but note that submitting a new file will overwrite the previous. 

If want some formative feedback before the deadline, speak to Nick via Teams.

Tips
There are opportunities to gain marks even if you do not implement all functionality. Start off with basic functionality to secure some easier marks, e.g. use a list first and then later add reading the words from a text file. Where marks are broken down into separate parts, you can target the easier requirements first to gain marks wherever possible.

Whilst writing your program, be sure to make use of comments, functions, and loops to make it easier to write and keep track of your work. Try to think about how you might use control flows in higher-level languages and how this can be translated into Assembly.

Make sure you manage versioning of your work well, for example saving a new, dated, copy for each submission (advanced: you could even take a look at git). SurreyLearn will not retain previous submissions for you.

Marking
Marks take into account consistency (i.e. if you implement something, the game should say this and behave as expected), as well as awarding marks with as few dependencies as possible (so you can still gain marks, even if you do not implement everything).

1. Presentation [16 marks]
Marks in this section are related to interface functions.

Credit at start [1 mark]
Your URN and name are printed when the program (not game) starts.

Welcome [1 mark]
‘Welcome to hangman!’ is printed when a game (not just program) starts.

Credit at end [2 marks]
The message ‘Thanks for playing hangman by’, followed by your name and URN, is printed when the game finishes (1 mark) or user exits (1 mark).

Hangman frames [10 marks]
Hangman is shown during game and frames shown as specified. Max 5 marks for frames shown but inconsistent with guess counter (or game flow if guess counter not implemented/working).

Input prompt [1 mark]
When a game starts, a prompt is shown reading ‘Enter your guess (A-Z)’.

Accurate prompt [1 mark]
The prompt matches implemented functionality. If user can start a new game, ‘2 to start new’ is included in prompt. If user can ask for a letter ‘1 to show letter’. If user can exit the game early, ‘0 to exit’. If none of these are implemented, the basic prompt is shown for the mark.

The functionality offered in the prompt must be implemented and pass related checks.

2. Data [10 marks]
A random word is selected from a hardcoded list (5 marks) or read from a text file (10 marks). If you implement the file reading, be sure to remove the old array so the marker does not penalise you.

3. Input [20 marks]
Lowercase acceptance [5 marks]
Lowercase letters accepted and converted to uppercase when shown on UI.

Input trimming [5 marks]
Only the first character of input used or error ‘Input too long’ given, user guesses not decremented. E.g. ‘A  ’ and ‘A’ are valid, ‘AB’, ‘’ and ‘AB  ’ are not.

2 marks if just first character accepted and rest ignored (i.e. no error shown) or 2 marks if error shown (only 1 mark if error is not descriptive: i.e. descriptive such as 'input too long', not just 'invalid' or 'error'), 3 marks if error used and shown only when extra characters are not spaces or tabs and processing continues with trimmed input.

Invalid input [5 marks]
User input not matching functionality or prompt gives error ‘Invalid input, try again’.

3 marks for message shown when completely invalid entry given, regardless of functionality (i.e. not A-Z, a-z, 0-2), only 2 marks if error is not descriptive (i.e. descriptive such as 'invalid input', not just 'error'). 2 marks for identifying with respect to functionality, e.g. if you have not implemented 1 to show letter, then ‘1’ should be considered an error.

Already guessed [5 marks]
If user enters a letter that has already been entered, the message ‘That letter has already been entered’ is shown and guess counter is not decremented. If you have ‘show letter’ functionality, this is considered as a letter already entered and must be taken into account. Max 4 marks if the error is not descriptive, i.e. descriptive such as 'error already entered', not just 'invalid' or 'error'.

4. Gameplay [34 marks]
Letter tracking [10 marks]
5 marks for showing guessed letters in word indicator (max 2 if just listed onscreen and not in position), 5 marks for listing incorrect guessed letters.

Target word indicator [5 marks]
Underscores shown to indicate word length. Max 1 mark for showing a fixed dash length.

Guess counter [5 marks]
Guess counter shown at each turn, starting at 6, decremented by one after each guess for letter not in word, decremented by two if ‘1 show letter’ is used, reset to 6 when new game started (if ‘2 new game’ function implemented).

Game end options [2 marks]
Options to exit or play again may be shown (‘0 to exit’ and/or ‘y to play again’ shown according to functionality) or program exits. 1 mark for program exit if no further options implemented, or 1 for option to exit and 1 for restart.

Game restart [5 marks]
‘2 to start new’ function added, when user enters ‘2’ a new game is started.

Show letter [5 marks]
‘1 to show letter’ function added, when user enters ‘1’ a correct letter is chosen for them with a penalty of two guesses. Option not shown if user has fewer than 3 guesses left.

Game end [2 marks]
When user has no guesses left, the message ‘Game over, word was’, followed by the word is shown. If the user guesses the word, the game ends and shows ‘Well done! You guessed the word with N guesses left’. 1 mark each for win and lose.

Examples
The following GIF demonstrates the look and feel of a hangman game and its functionality. Your implementation does not need to look exactly like this, but you will need to meet the specifications above (e.g. message content, hangman design).



Note some functionality shown:

Lowercase letters accepted and whitespace ignored
Already entered letters identified, including incorrect guesses
Word indicator displayed along with hangman
Game wins and losses identified
User can start a new game and ask for a letter
At end of game, credit is printed with option to play again or to exit
