#Kefil Tonouewa
#ECE 355
#Project Phase2 
	
	.data
	a: 	    .space 100 
	transpose:  .space 100
	r: 	    .byte  10 
	c: 	    .byte  10
 	i: 	    .byte  1
 	j: 	    .byte  1
	space: .asciiz " "
	newrow: .asciiz "\n"
	array: .asciiz "The original array is: \n"
	Transpose:.asciiz "\n The transpose is: \n"
	.text

	main:	li $t0,0	 	 	#initializing $t0 to 0(int i=0)
		la $t2,a		 	#initializing $t2 to the memory address of the array
		la $t3,r		 	#initializing $t3 to the memory address of r (row)
		lb $t3,($t3)		 	#initializing $t3 to the the values of r
		la $t4,c		 	#initializing $t3 to the memory address of c (column)
		lb $t4,($t4)		 	#initializing $t3 to the the values of c
		
		#This section represent the first for loop with i
	iloop:	addi $t0,$t0,1 		 	#incrementing the value of i by one (i++)
		li $t1,0		 	#initializing $t1 to 0 (int j=0)
		li $t9,0		 	#initializing $t9 to 0, This will be used in the loop used to print the array to signify when to stop printing number
		beq $t0,$t3,print  		#Printing the array if it is full
	jloop:	beq $t1,$t4,iloop  		#Branching back to iloop if $t1 is equal to c (j<c)
		mul $t5,$t0,$t1 	 	#Performing multiplication betweeen i and j (i*j)
		mul $t7,$t0,$t3		 	#Calculating the offset of the array(1)
		add $t7,$t7,$t1		 	#Offset calaculation (2)
		sb $t5,a($t7)		 	#Initializing the array
		addi $t1,$t1,1		 	#Incrementing the value of j by one (j++)
		b jloop			 	#Branching back to jloop until j=c
	 
	 	#This section represents the transpose computation
	loop_:	li $t0,0 		 	#initializing i to 0(int i=0)
		li $t1,0 		 	#initializing j to 0(int j=0)
		li $t9,0		 	#initializing $t9 to 0, This will be used in the loop used to print the transpose to signify when to stop printing number
		li $t6,0
		b loop__		 	#Branching to loop__ to start the transpose computation		
	iloop_:addi $t0,$t0,1		 	#incrementing the value of i by one (i++)	
		li $t1,0			#Setting $t1 to 0 after each passage in the loop
	loop__:	beq $t0,$t3,print2  		#printing the transpose if i=10
		beq $t1,$t4,iloop_ 		#Braching to iloop if j is equal to 10 (j<10)
		#This section will be used to define the pointer of the array (jth row*10+ith column)
		mul $t7,$t1,$t3			
		add $t7,$t7,$t0	
		la $t8,a($t7)			#Storing memory address obtain into $t8
		lb $t8,($t8)			#Storing the content of content of $t8 into $t8
		#This section will be used to define where to put the value in the transpose (ith row*10+jth column)
		mul $t7,$t0,$t3			
		add $t7,$t7,$t1
		sb $t8,transpose($t7)		#Storing the value from the array into its respective position in the transpose
		addi $t1,$t1,1			#incrementing the value of j by one (j++)
		b loop__			#Branching to loop__ until j=10
		
  print_array : li $v0,1			#This is used to print an integer
		beq $t9,100,loop_		#Branch to loop_if there is no more element in the array
		lb $a0,a($t9)			#Passing the argument to the print function
		addi $t9,$t9,1			#Incrementing $t9 to point to the next element in the array
		div $t6,$t9,$t3
		mfhi $t6
		beq $t6,0,nextRow
		syscall				
		li $v0,4         		#This is used to print a string
		la $a0,space   			#Passing the argument ( ) into the print function 
		syscall		 		#Printing a newline on the terminal
		b print_array			#Branching to print array if there is more element in the array		
        
        nextRow:syscall
        	li $v0,4         		#This is used to print a string
		la $a0,newrow   		#Passing the argument newrow into the print function 
		syscall
		b print_array
	 
       nextRow_:syscall
        	li $v0,4         		#This is used to print a string
		la $a0,newrow   		#Passing the argument ( ) into the print function 
		syscall
		b print_transpose
	  print:li $v0,4         		#This is used to print a string
		la $a0,array   			#Passing the argument array into the print function 
		syscall				#Printing the message before the array
		b print_array			#Branching to the loop that print the array
	 print2:li $v0,4         		#This is used to print a string
		la $a0,Transpose  		#Passing the argument Transpose into the print function 
		syscall				#Printing the message before the transpose
		b print_transpose		#Branching to the loop that prints the transpose
print_transpose : li $v0,1			#This is used to print an integer
		beq $t9,100,exit 		#This is used to to end the program when all the element of the transpose has been traversed
		lb $a0,transpose($t9)		#Passing the argument to the print function
		addi $t9,$t9,1			#moving the transpose pointer to the next element
		div $t6,$t9,$t3			
		mfhi $t6
		beq $t6,0,nextRow_
		syscall				#Printing the value of the highest value of the array
		li $v0,4         		#This is used to print a string
		la $a0,space   			#Passing the argument ( ) into the print function 
		syscall		 		#Printing a space on the terminal
		b print_transpose		#Branching to print transpose if
			
	exit:	nop				#no operation is to be performed
