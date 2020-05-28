# Example program to display an array.
# Demonstrates use of QtSpim system service calls.
# -----------------------------------------------------
# Data Declarations

.data
hdr: 	.ascii 	"Squaring Example\n"
	.asciiz 	"Enter Value: "
ansMsg: .asciiz 	"Value Squared: "
value: 	.word 	0

# -----------------------------------------------------
# text/code section

.text
.globl 	main
.ent 	main
main:
	li 	$v0, 4		# call code for print string
	la 	$a0, hdr 	# addr of NULL terminated str
	syscall 		# system call
	li 	$v0, 5 		# call code for read integer
	syscall 		# system call (result in $v0)
	mul 	$t0, $v0, $v0 # square answer
	sw 	$t0, value	# save to variable
	li 	$v0, 4 		# call code for print string
	la 	$a0, ansMsg 	# addr of NULL terminated str
	syscall		 	# system call
	li $v0, 1 		# call code for print integer
	lw $a0, value 		# value for integer to print
	syscall 		# system call
# -----
# Done, terminate program.
	li $v0, 10		# terminate
	syscall			# system call
	.end main