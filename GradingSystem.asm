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
	Grades: .byte 100 50 78 90 66 78 63 10 98 76 45 49 76 80 88
	A_students: .byte 0
	B_students: .byte 0
	C_students: .byte 0
	D_students: .byte 0
	F_students: .byte 0
	Num_of_students: .byte 15
	Average: .space 1 
	
	    
	   
	.text
	
	 main:
	 
	li $t5,0
	li $t5,0
	li $t4,0
	la $t1,Num_of_students
	lb $t1,($t1)
	 	
AverageCalculation:	#add all the element of the array and divide it by the number of students in the class.
			#summation portion
			
			la $t3,Grades($t5)
			lb $t3,($t3)
			addi $t5,$t5,1
			add $t4,$t4,$t3
			
			subi $t1,$t1,1
			bne $t1,0,AverageCalculation
			
			#average determination
			la $t1,Num_of_students
	 		lb $t1,($t1)
	 		div $t4,$t1
	 		mflo $t3
	 		sb  $t3,Average
	 		

Print_Average:		li $v0,4
			la $a0, Average_disp
	 		syscall
	 		
	 		li $v0,1
			lb $a0,Average
	 		syscall
	 		li $t2,0

	 		la $t1,Num_of_students
			lb $t1,($t1)
			li $t5,0
			
Repartition:		la $t3,Grades($t5)
			lb $t3,($t3)
			bgt $t3,60,D_Grade
			
			#This secion in used to determine which student has F.
	F_Grade:	la $t2,F_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,F_students
			addi $t5,$t5,1
			subi $t1,$t1,1
			bne $t1,0,Repartition		
	 		b Statistics
	 
	 		#This section is used to determine which students has D.
	 D_Grade:	bgt $t3,69,C_Grade
	 		la $t2,D_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,D_students
			addi $t5,$t5,1
			subi $t1,$t1,1
			bne $t1,0,Repartition
			b Statistics
	
			#This section is used to determine which students has C.
	C_Grade:	bgt $t3,79,B_Grade
	 		la $t2,C_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,C_students
			addi $t5,$t5,1
			subi $t1,$t1,1
			bne $t1,0,Repartition
			b Statistics
			
			#This section is used to determine which students has B
	B_Grade:	bgt $t3,89,A_Grade
	 		la $t2,B_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,B_students
			addi $t5,$t5,1
			subi $t1,$t1,1
			bne $t1,0,Repartition
			b Statistics
			
			#This section is used to determine which students has A
	A_Grade:	la $t2,A_students
			lb $t2,($t2)
			addi $t2,$t2,1
			sb $t2,A_students
			addi $t5,$t5,1
			subi $t1,$t1,1
			bne $t1,0,Repartition
			b Statistics
	 		

Statistics:		li $v0,4
			la $a0,Class_statistics
			syscall
			
			li $v0,4
			la $a0,newline
	 		syscall
			
			#A students number printing process
			li $v0,4
			la $a0,A
	 		syscall
	 		
	 		li $v0,1
			lb $a0,A_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
	 		
	 		#B students number printing process
			li $v0,4
			la $a0,B
	 		syscall
	 		
	 		li $v0,1
			lb $a0,B_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
	 		
	 		#C students number printing process
			li $v0,4
			la $a0,C
	 		syscall
	 		
	 		li $v0,1
			lb $a0,C_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
	 		
	 		#D students number printing process
			li $v0,4
			la $a0,D
	 		syscall
	 		
	 		li $v0,1
			lb $a0,D_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
	 		
	 		#F student number printing process
			li $v0,4
			la $a0,F
	 		syscall
	 		
	 		li $v0,1
			lb $a0,F_students
	 		syscall
	 		
	 		li $v0,4
			la $a0,newline
	 		syscall
exit:	 		nop
