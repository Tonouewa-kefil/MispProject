#Kefil Tonouewa
#ECE 355
#Project Phase2 
################################################################################### Task1#################################################################################
										
										 #For loop

	.data
	
	X: .asciiz "x = "
	NewLine: .asciiz "\n"
	x: .byte 100
	.text
	
	main:	la $t0,x	 #Setting $t0 to the memory address to x
		lb $a1,($t0)     #Setting a1 to 100 (int x=100)
		li $t0,0         #setting to to 0   (int j=0)
	loop: 	beq $t0,10,exit  #comparring j to 10 and exiting if it is equal (j<10)
		
		li $v0,4         #This is used to print a string
		la $a0,X         #Passing the argument (x= ) into the print function
		syscall          #Printing x= on the terminal
		
		add $a1,$a1,1    #adding 1 to a1 (x++)
		move $a0,$a1     #Moving a1 to a1 in order to pass it to the print function
		li $v0,1         #This is used to print an integer
		syscall		 #Printing the value of x on the terminal  
		
		li $v0,4         #This is used to print a string
		la $a0,NewLine   #Passing the argument (/n) into the print function 
		syscall		 #Printing a newline on the terminal
		
		addi $t0,$t0,1   #incrementing the value of j (j++)
		b loop 		 #Branching back to the loop	
	
	exit: nop		 #No operation
		
	
