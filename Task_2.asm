#Kefil Tonouewa
#ECE 355
#Project Phase2 
################################################################################### Task2#################################################################################
										
									    #Highest and Lowest

	.data
	
	LOW:  	 .asciiz "The lowest Element of the array is:  "
	HIGH: 	 .asciiz "The Highest Element of the array is : "
	NewLine:	 .asciiz "\n"
	arr:  	 .byte 99,81,-1,76,0,1,7,-74,23,99,-30
	size:    .byte 11		#int size =11
	highest: .space 1		#int highest
	lowest:  .space 1		#int lowest
	
	.text
	
	main:	la $t1,arr		#Storing the starting address of the array into $t1
		li $t0,0		#Setting the for loop counter to 0 (int i=0)
		la $t2,size		#Storing register $t2 to size memory address 
		
		la $t3,highest		#Storing the regester $t3 to highest memory address
		sb $t0,($t3)		#initializing highest to 0 (highest=0)
		lb $t3,($t3)		#Storing the value of the highest into register t3.
		
		la $t4,lowest		#Storing the regester $t4 to highest memory address
		sb $t0,($t4)		#initializing highest to 0 (lowest=0)
		lb $t4,($t4)		#Storing the value of the highest into register t4.
		
		lb $t2,($t2)		#Storing the value of the size into register t3.
		
		
				
	loop:	beq $t0,$t2,exit	#i<size? yes--> keepgoing, no-->Getout
		
		lb $t8,($t1)  		#Loading the content of register $t1 into $t8
		addi $t1,$t1,1		#Incrementing the pointer to the array
		addi $t0,$t0,1		#Incrementing the loop counter
		bge $t8,$t3,High	#Branch to high if the arrayv value at this point is higher than the value containned by highest
		ble $t8,$t4,Low		#Branch to Low if the arrayv value at this point is Lower than the value containned by lowest
	
	High:	sb $t8,highest 		#Storring the value of $t8 into highest
		b loop			#Branching back to the loop
	
	Low:	sb $t8,lowest		#Storring the value of $t8 into lowest
		b loop			#Branching back to the loop
		
	exit:	li $v0,4         	#This is used to print a string
		la $a0,HIGH    		#Passing the argument to the print function 
		syscall		 	#Printing the text for High

		li $v0,1		#This is used to print an integer
		lb $a0,highest		#Passing the argument to the print function
		syscall			#Printing the value of the highest value of the array
		
		li $v0,4         	#This is used to print a string
		la $a0,NewLine   	#Passing the argument (/n) into the print function 
		syscall		 	#Printing a newline on the terminal
		
		li $v0,4         	#This is used to print a string
		la $a0,LOW   		#Passing the argument to the print function 
		syscall			#Printing the text for Low

		
		li $v0,1		#This is used to print an integer
		lb $a0,lowest		#Passing the argument to the print function
		syscall		 	#Printing the value of the lowest value of the array
		
		nop			#No operation
		
