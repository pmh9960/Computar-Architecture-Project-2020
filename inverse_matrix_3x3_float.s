# Example program to display an array.
# Demonstrates use of QtSpim system service calls.
# -----------------------------------------------------
# Data Declarations

.data
hdr: 	.asciiz  	"Calculate Inverse Matrix\n"
noSolution: .asciiz "There is no solution\n"
solution: .asciiz "The inverse matrix is : \n"
MAT:   .float   1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 8.0
invMat: .float   0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
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
	la  $s0, MAT

    # MAT => float reg
    l.s		$f0, 0($s0)
    l.s		$f1, 4($s0)
    l.s		$f2, 8($s0)
    l.s		$f3, 12($s0)
    l.s		$f4, 16($s0)
    l.s		$f5, 20($s0)
    l.s		$f6, 24($s0)
    l.s		$f7, 28($s0)
    l.s		$f8, 32($s0)

    # Calculate Determinant
    jal		det			    	# jump to det and save position to $ra

    c.eq.s  $f9, $f31
    bc1t noSol


    # Calculate element
    # Element 1
    mov.s 	$f20, $f4		# $f20 = $f4
    mov.s 	$f21, $f8		# $f21 = $f8
    mov.s 	$f22, $f5		# $f22 = $f5
    mov.s 	$f23, $f7		# $f23 = $f7
    jal		element				# jump to element and save position to $ra
    div.s   $f10, $f24, $f9

    # Element 2
    mov.s 	$f20, $f2		# $f20 = $f2
    mov.s 	$f21, $f7		# $f21 = $f7
    mov.s 	$f22, $f1		# $f22 = $f1
    mov.s 	$f23, $f8		# $f23 = $f8
    jal		element				# jump to element and save position to $ra
    div.s   $f11, $f24, $f9

    # Element 3
    mov.s 	$f20, $f1		# $f20 = $f1
    mov.s 	$f21, $f5		# $f21 = $f5
    mov.s 	$f22, $f2		# $f22 = $f2
    mov.s 	$f23, $f4		# $f23 = $f4
    jal		element				# jump to element and save position to $ra
    div.s   $f12, $f24, $f9

    # Element 4
    mov.s 	$f20, $f5		# $f20 = $f5
    mov.s 	$f21, $f6		# $f21 = $f6
    mov.s 	$f22, $f3		# $f22 = $f3
    mov.s 	$f23, $f8		# $f23 = $f8
    jal		element				# jump to element and save position to $ra
    div.s   $f13, $f24, $f9

    # Element 5
    mov.s 	$f20, $f0		# $f20 = $f0
    mov.s 	$f21, $f8		# $f21 = $f8
    mov.s 	$f22, $f2		# $f22 = $f2
    mov.s 	$f23, $f6		# $f23 = $f6
    jal		element				# jump to element and save position to $ra
    div.s   $f14, $f24, $f9

    # Element 6
    mov.s 	$f20, $f2		# $f20 = $f2
    mov.s 	$f21, $f3		# $f21 = $f3
    mov.s 	$f22, $f0		# $f22 = $f0
    mov.s 	$f23, $f5		# $f23 = $f5
    jal		element				# jump to element and save position to $ra
    div.s   $f15, $f24, $f9

    # Element 7
    mov.s 	$f20, $f3		# $f20 = $f3
    mov.s 	$f21, $f7		# $f21 = $f7
    mov.s 	$f22, $f4		# $f22 = $f4
    mov.s 	$f23, $f6		# $f23 = $f6
    jal		element				# jump to element and save position to $ra
    div.s   $f16, $f24, $f9

    # Element 8
    mov.s 	$f20, $f1		# $f20 = $f1
    mov.s 	$f21, $f6		# $f21 = $f6
    mov.s 	$f22, $f0		# $f22 = $f0
    mov.s 	$f23, $f7		# $f23 = $f7
    jal		element				# jump to element and save position to $ra
    div.s   $f17, $f24, $f9

    # Element 9
    mov.s 	$f20, $f0		# $f20 = $f0
    mov.s 	$f21, $f4		# $f21 = $f4
    mov.s 	$f22, $f1		# $f22 = $f1
    mov.s 	$f23, $f3		# $f23 = $f3
    jal		element				# jump to element and save position to $ra
    div.s   $f18, $f24, $f9

    
    # $f10 ~ $f18이 답인데 $f12에 있어야 출력됨.
    # $f12를 잠시 $f19로 옮길 예정
    mov.s   $f19, $f12

    # print ans
	li 	$v0, 4 	    	# call code for print string
	la 	$a0, solution 	# addr of NULL terminated str
	syscall		    	# system call

	li $v0, 2 		    # call code for print integer
	mov.s $f12, $f10
	syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 2 		    # call code for print integer
	mov.s $f12, $f11
    syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 2 		    # call code for print integer
	mov.s $f12, $f19
    syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, enter 		# value for integer to print
	syscall 		    # system call
	li $v0, 2 		    # call code for print integer
	mov.s $f12, $f13
    syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 2 		    # call code for print integer
	mov.s $f12, $f14
    syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 2 		    # call code for print integer
	mov.s $f12, $f15
    syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, enter 		# value for integer to print
	syscall 		    # system call
	li $v0, 2 		    # call code for print integer
	mov.s $f12, $f16
    syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 2 		    # call code for print integer
	mov.s $f12, $f17
    syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, space 		# value for integer to print
	syscall 		    # system call
	li $v0, 2 		    # call code for print integer
	mov.s $f12, $f18
    syscall 		    # system call
    li $v0, 4 		    # call code for print integer
	la $a0, enter 		# value for integer to print
	syscall 		    # system call


# -----
# Done, terminate program.
	li $v0, 10		# terminate
	syscall			# system call
	.end main

det:
    # $f9 is the determinent of MAT
    # $f10 is temporary float reg
    
    mul.s $f10, $f0, $f4
    mul.s $f10, $f10, $f8
    add.s $f9, $f9, $f10

    mul.s $f10, $f1, $f5
    mul.s $f10, $f10, $f6
    add.s $f9, $f9, $f10

    mul.s $f10, $f2, $f3
    mul.s $f10, $f10, $f7
    add.s $f9, $f9, $f10

    mul.s $f10, $f0, $f5
    mul.s $f10, $f10, $f7
    sub.s $f9, $f9, $f10
    
    mul.s $f10, $f1, $f3
    mul.s $f10, $f10, $f8
    sub.s $f9, $f9, $f10

    mul.s $f10, $f2, $f4
    mul.s $f10, $f10, $f6
    sub.s $f9, $f9, $f10

    jr		$ra			# jump to $ra


element:

    mul.s   $f25, $f20, $f21
    mul.s   $f26, $f22, $f23
    sub.s   $f24, $f25, $f26

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