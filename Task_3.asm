#Kefil Tonouewa
#ECE 355
#Project Phase2 
################################################################################### Task3#################################################################################
										
									    #Highest and Lowest
	.data
	
	a: 	    .space 100 
	transpose:  .space 100
	r: 	    .byte  10 
	c: 	    .byte  10
 	i: 	    .byte  1
 	j: 	    .byte  1
	space: .ascii " "
	#Newline: .ascii " "
	
	.text
	
	
	main:	li $t0,0
		la $t2,a
		la $t3,r
		lb $t3,($t3)
		la $t4,c
		lb $t4,($t4)
		
	
	iloop:	addi $t0,$t0,1 
		li $t1,0
		li $t9,0
		beq $t0,$t3,print_array 
		
	
	jloop:	beq $t1,$t4,iloop  #j<c	
		mul $t5,$t0,$t1 #i*j
		mul $t7,$t0,$t3	#Calculating the offset of the array(1)
		add $t7,$t7,$t1	#Offset calaculation (2)
		sb $t5,a($t7)	#Initializing the array
		addi $t1,$t1,1	#Incrementing j
		b jloop
	 
	 #Tanspose computation
	loop_:	li $t0,0 #initializing i to 0(int i=0)
		li $t1,0 #initializing j to 0(int j=0)
		li $t9,0 
		b loop__
	iloop_:addi $t0,$t0,1
		li $t1,0
	loop__:	beq $t0,$t3,print_transpose  	#printing the transpose if i=10
		beq $t1,$t4,iloop_ 	#incrementing i if j=10
		
		mul $t7,$t1,$t3
		add $t7,$t7,$t0	
		la $t8,a($t7)
		lb $t8,($t8)
		mul $t7,$t0,$t3
		add $t7,$t7,$t1
		sb $t8,transpose($t7)
		
		addi $t1,$t1,1
		b loop__
		
		
	print_array : li $v0,1		#This is used to print an integer
		
		beq $t9,100,loop_
		lb $a0,a($t9)		#Passing the argument to the print function
		addi $t9,$t9,1
		syscall			#Printing the value of the highest value of the array
		li $v0,4         #This is used to print a string
		la $a0,space   #Passing the argument ( ) into the print function 
		syscall		 #Printing a newline on the terminal
		b print_array
		
				
	print_transpose : li $v0,1		#This is used to print an integer
		
		beq $t9,100,exit
		lb $a0,transpose($t9)		#Passing the argument to the print function
		addi $t9,$t9,1
		syscall			#Printing the value of the highest value of the array
		li $v0,4         #This is used to print a string
		la $a0,space   #Passing the argument ( ) into the print function 
		syscall		 #Printing a newline on the terminal
		b print_transpose
			
	exit:	nop		