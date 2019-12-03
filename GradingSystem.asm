	.data
	
	User_input: .asciiz "Enter the number of students in the class: "
	Average_disp: .asciiz "The class average is: "
	User_grade_input: .asciiz "Enter a grade: "
	Class_statistics: .asciiz "\n Class Statistiques:"
	A: .asciiz "A(90-100)-----> "
	B: .asciiz "B(80-89) -----> "
	C: .asciiz "C(70-79) -----> "
	D: .asciiz "D(60-69) -----> "
	F: .asciiz "F(0-60)  -----> "
	newline: .asciiz "\n"
	Grades: .space 100
	A_students: .byte 0
	B_students: .byte 0
	C_students: .byte 0
	D_students: .byte 0
	F_students: .byte 0
	Num_of_students: .space 1
	Average: .space 2 
	
	    
	   
	.text
	
	 main:
	 
	 #ask the user to enter the number of students
	 li $v0,4
	 la $a0, User_input
	 syscall
	 
	 #waiting fo the user input
	 li $v0,5
	 syscall 
	 
	 sb $v0,Num_of_students 	#Storing user input into Num_of_students
	 la $t1,Num_of_students
	 lb $t1,($t1)
	 li $t2,0
	 bgt $t1,0,GradesLoop
	 ble $t1,0,exit
	 
	 
	 GradesLoop: 	li $v0,4
			la $a0, User_grade_input
	 		syscall
	 		
	 		#waiting fo the user input
			li $v0,5
	 		syscall 
	 		
	 		#store the user value into the grades array
	 		
	 		sb $v0,Grades($t2)
	 		addi $t2,$t2,1
	 		
	 		subi $t1,$t1,1
	 		bne $t1,0,GradesLoop

			la $t1,Num_of_students
	 		lb $t1,($t1)
	 		li $t4,0
	 		li $t2,0
	 	
AverageCalculation:	#add all the element of the array and divide it by the number of students in the class.
			#summation portion
			
			la $t3,Grades($t2)
			lb $t3,($t3)
			addi $t2,$t2,1
			add $t4,$t4,$t3
			
			subi $t1,$t1,1
			bne $t1,0,AverageCalculation
			
			#average determination
			la $t1,Num_of_students
	 		lb $t1,($t1)
	 		div $t4,$t1
	 		mflo $t3
	 		sb $t3,Average

Print_Average:		li $v0,4
			la $a0, Average_disp
	 		syscall
	 		
	 		li $0,1
			la $a0,Average
	 		syscall
	 		li $t2,0

	 		la $t1,Num_of_students
			lb $t1,($t1)
Repartition:		la $t3,Grades($t2)
			lb $t3,($t3)
			blt $t3,60,F_Grade
			b D_Grade
	 		
	F_Grade:	la $t2,F_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,F_students
			addi $t2,$t2,1
			subi $t1,$t1,1
			bne $t1,0,Repartition		
	 		b Statistics
	 
	 D_Grade:	bgt $t3,69,C_Grade
	 		la $t2,D_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,D_students
			addi $t2,$t2,1
			subi $t1,$t1,1
			bne $t1,0,Repartition
			b Statistics
	
	C_Grade:	bgt $t3,79,B_Grade
	 		la $t2,C_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,C_students
			addi $t2,$t2,1
			subi $t1,$t1,1
			bne $t1,0,Repartition
			b Statistics
	
	B_Grade:	bgt $t3,89,A_Grade
	 		la $t2,B_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,B_students
			addi $t2,$t2,1
			subi $t1,$t1,1
			bne $t1,0,Repartition
			b Statistics
	
	A_Grade:	la $t2,A_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,A_students
			addi $t2,$t2,1
			subi $t1,$t1,1
			bne $t1,0,Repartition
			b Statistics
	 		

Statistics:		li $v0,4
			la $a0,Class_statistics
			syscall
			
			li $v0,4
			la $a0,newline
	 		syscall
			
			#A students
			li $v0,4
			la $a0,A
	 		syscall
	 		
	 		li $0,1
			la $a0,A_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
	 		
	 		#B students
			li $v0,4
			la $a0,B
	 		syscall
	 		
	 		li $0,1
			la $a0,B_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
	 		
	 		#C students
			li $v0,4
			la $a0,C
	 		syscall
	 		
	 		li $0,1
			la $a0,C_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
	 		
	 		#D students
			li $v0,4
			la $a0,D
	 		syscall
	 		
	 		li $0,1
			la $a0,D_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
	 		
	 		#F students
			li $v0,4
			la $a0,F
	 		syscall
	 		
	 		li $0,1
			la $a0,F_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
exit:	 		nop