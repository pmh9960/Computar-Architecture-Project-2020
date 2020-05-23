# Example program to display an array.
# Demonstrates use of QtSpim system service calls.
# -----------------------------------------------------
# Data Declarations

.data
hdr: 	.asciiz  	"Calculate Inverse Matrix\n"
noSolution: .asciiz "There is no solution\n"
solution: .asciiz "The inverse matrix is : \n"
mat1:   .word   1, 2, 3, 4, 5, 6, 7, 8, 9
invMat: .word   0, 0, 0, 0, 0, 0, 0, 0, 0
space: .asciiz " "
enter: .asciiz "\n"

# -----------------------------------------------------
# text/code section

.text
.globl 	main
.ent 	main
main:
	li 	$v0, 4		# call code for print string
	la 	$a0, hdr 	# addr of NULL terminated str
	syscall 		# system call

    # input 3x3 matrix
	li 	$v0, 5 		# call code for read int
	la  $s0, mat1

    # Calculate Determinant
    jal		det				# jump to det and save position to $ra
    sub	$sp, $sp, 4			# $sp = $sp - 4
    sw		$v0, 0($sp)

    beq		$v0, $0, noSol	# if $v0 == $0 then noSol

    # Mat1 => temp reg
    lw		$t0, 0($s0)
    lw		$t1, 4($s0)
    lw		$t2, 8($s0)
    lw		$t3, 12($s0)
    lw		$t4, 16($s0)
    lw		$t5, 20($s0)
    lw		$t6, 24($s0)
    lw		$t7, 28($s0)
    lw		$t8, 32($s0)

    # Calculate element
    # Element 1
    move 	$a0, $t4		# $a0 = $t4
    move 	$a1, $t8		# $a1 = $t8
    move 	$a2, $t5		# $a2 = $t5
    move 	$a3, $t7		# $a3 = $t7
    jal		element				# jump to element and save position to $ra
    move    $s0, $v0
    # Element 2
    move 	$a0, $t2		# $a0 = $t2
    move 	$a1, $t7		# $a1 = $t7
    move 	$a2, $t1		# $a2 = $t1
    move 	$a3, $t8		# $a3 = $t8
    jal		element				# jump to element and save position to $ra
    move    $s1, $v0
    # Element 3
    move 	$a0, $t1		# $a0 = $t1
    move 	$a1, $t5		# $a1 = $t5
    move 	$a2, $t2		# $a2 = $t2
    move 	$a3, $t4		# $a3 = $t4
    jal		element				# jump to element and save position to $ra
    move    $s2, $v0
    # Element 4
    move 	$a0, $t5		# $a0 = $t5
    move 	$a1, $t6		# $a1 = $t6
    move 	$a2, $t3		# $a2 = $t3
    move 	$a3, $t8		# $a3 = $t8
    jal		element				# jump to element and save position to $ra
    move    $s3, $v0
    # Element 5
    move 	$a0, $t0		# $a0 = $t0
    move 	$a1, $t8		# $a1 = $t8
    move 	$a2, $t2		# $a2 = $t2
    move 	$a3, $t6		# $a3 = $t6
    jal		element				# jump to element and save position to $ra
    move    $s4, $v0
    # Element 6
    move 	$a0, $t2		# $a0 = $t2
    move 	$a1, $t3		# $a1 = $t3
    move 	$a2, $t0		# $a2 = $t0
    move 	$a3, $t5		# $a3 = $t5
    jal		element				# jump to element and save position to $ra
    move    $s5, $v0
    # Element 7
    move 	$a0, $t3		# $a0 = $t3
    move 	$a1, $t7		# $a1 = $t7
    move 	$a2, $t4		# $a2 = $t4
    move 	$a3, $t6		# $a3 = $t6
    jal		element				# jump to element and save position to $ra
    move    $s6, $v0
    # Element 8
    move 	$a0, $t1		# $a0 = $t1
    move 	$a1, $t6		# $a1 = $t6
    move 	$a2, $t0		# $a2 = $t0
    move 	$a3, $t7		# $a3 = $t7
    jal		element				# jump to element and save position to $ra
    move    $s7, $v0
    # Element 9
    move 	$a0, $t0		# $a0 = $t0
    move 	$a1, $t4		# $a1 = $t4
    move 	$a2, $t1		# $a2 = $t1
    move 	$a3, $t3		# $a3 = $t3
    jal		element				# jump to element and save position to $ra
    move    $s8, $v0
    

    sw		$t0, 0($sp)
    add	    $sp, $sp, 4			# $sp = $sp - 4

    la $t1, invMat
    sw $s0, 0($t1)
    sw $s1, 4($t1)
    sw $s2, 8($t1)
    sw $s3, 12($t1)
    sw $s4, 16($t1)
    sw $s5, 20($t1)
    sw $s6, 24($t1)
    sw $s7, 28($t1)
    sw $s8, 32($t1)

	li 	$v0, 4 	    	# call code for print string
	la 	$a0, solution 	# addr of NULL terminated str
	syscall		    	# system call

	li $v0, 1 		    # call code for print integer
	lw $a0, 0($t1) 		# value for integer to print
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 1 		    # call code for print integer
	lw $a0, 4($t1) 		# value for integer to print
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 1 		    # call code for print integer
	lw $a0, 8($t1) 		# value for integer to print
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, enter 		# value for integer to print
	syscall 		    # system call
	li $v0, 1 		    # call code for print integer
	lw $a0, 12($t1) 		# value for integer to print
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 1 		    # call code for print integer
	lw $a0, 16($t1) 		# value for integer to print
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 1 		    # call code for print integer
	lw $a0, 20($t1) 		# value for integer to print
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, enter 		# value for integer to print
	syscall 		    # system call
	li $v0, 1 		    # call code for print integer
	lw $a0, 24($t1) 		# value for integer to print
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 1 		    # call code for print integer
	lw $a0, 28($t1) 		# value for integer to print
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 1 		    # call code for print integer
	lw $a0, 32($t1) 		# value for integer to print
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, enter 		# value for integer to print
	syscall 		    # system call

	# mul 	$t0, $v0, $v0 # square answer
	# sw 	$t0, value	# save to variable
	# li 	$v0, 4 		# call code for print string
	# la 	$a0, ansMsg 	# addr of NULL terminated str
	# syscall		 	# system call
	# li $v0, 1 		# call code for print integer
	# lw $a0, value 		# value for integer to print
	# syscall 		# system call
# -----
# Done, terminate program.
	li $v0, 10		# terminate
	syscall			# system call
	.end main

det:
    move $t1, $0
    
    lw 	$t3, 0($s0)
    lw 	$t4, 16($s0)
    lw 	$t5, 32($s0)
    mul $t2, $t3, $t4
    mul $t2, $t2, $t5
    add $t1, $t1, $t2

    lw 	$t3, 4($s0)
    lw 	$t4, 20($s0)
    lw 	$t5, 24($s0)
    mul $t2, $t3, $t4
    mul $t2, $t2, $t5
    add $t1, $t1, $t2

    lw 	$t3, 8($s0)
    lw 	$t4, 12($s0)
    lw 	$t5, 28($s0)
    mul $t2, $t3, $t4
    mul $t2, $t2, $t5
    add $t1, $t1, $t2

    lw 	$t3, 0($s0)
    lw 	$t4, 20($s0)
    lw 	$t5, 28($s0)
    mul $t2, $t3, $t4
    mul $t2, $t2, $t5
    sub $t1, $t1, $t2
    
    lw 	$t3, 4($s0)
    lw 	$t4, 12($s0)
    lw 	$t5, 32($s0)
    mul $t2, $t3, $t4
    mul $t2, $t2, $t5
    sub $t1, $t1, $t2

    lw 	$t3, 8($s0)
    lw 	$t4, 16($s0)
    lw 	$t5, 24($s0)
    mul $t2, $t3, $t4
    mul $t2, $t2, $t5
    sub $t1, $t1, $t2

    move 	$v0, $t1		# $v0 = $t1
    # $v0 : det(A)

    jr		$ra			# jump to $ra


element:
    sub $sp, $sp, 8 # 4 * temp
    sw $t1, 4($sp)
    sw $t0, 0($sp)

    mult 	$a0, $a1			# $a0 * $a1 = Hi and Lo registers
    mflo	$t0					# copy Lo to $t0
    mult	$a2, $a3			# $a2 * $a3 = Hi and Lo registers
    mflo	$t1					# copy Lo to $t1
    sub		$v0, $t0, $t1		# $v0 = $t0 - $t1

    lw $t0, 0($sp)
    lw $t1, 4($sp)
    add $sp, $sp, 8
    jr $ra

noSol:
    li 	$v0, 4		        # call code for print string
	la 	$a0, noSolution 	# addr of NULL terminated str
	syscall 		        # system call
    # -----
# Done, terminate program.
	li $v0, 10		# terminate
	syscall			# system call
	.end main