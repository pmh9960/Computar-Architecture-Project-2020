.data
prompt: .asciiz "Enter the 3x3 matrix from row 1 to row 2 to row 3 :"
answer: .asciiz "The Determinant is : "
.text
li $v0,4
la $a0, prompt
syscall
     
li $v0,5                           # THIS LOOPS 9 times to get all the user input
syscall
move $t0,$v0
li $v0,5
syscall
move $t1,$v0
    li $v0,5
syscall
move $t2,$v0
    li $v0,5
syscall
move $t3,$v0
    li $v0,5
syscall
move $t4,$v0
    li $v0,5
syscall
move $t5,$v0
    li $v0,5
syscall
move $t6,$v0
    li $v0,5
syscall
move $t7,$v0
    li $v0,5
syscall
move $t8,$v0
       
       
     

   jal determ                       # JAL TO DETERMINANT FUNCTINO            #Copies the address of s7 to a0 for printing
      li $v0,4
      la $a0, answer
       syscall
      move $a0,$s7 #Copies the address of s7 to a0 for printing
      li $v0,1
      syscall
      li $v0,10
      syscall
     
           determ:
             mult $t4,$t8                                 #multiplies the specified numbers from the determinant formula
             mflo $s1
             mult $t5,$t7
             mflo $s2
             sub $s2,$s1,$s2
             
             mult $s2,$t0
             mflo $s2
             
             mult $t3,$t8
             mflo $s3
             mult $t5,$t6
             mflo $s4
             sub $s4,$s3,$s4
             mult $s4,$t1
             mflo $s4
             sub $s4,$s2,$s4
             
             mult $t3,$t7
             mflo $s5
             mult $t4,$t6
             mflo $s6
             sub $s6,$s5,$s6
             mult $s6,$t2
             mflo $s6
             add $s7, $s4,$s6
             jr $ra