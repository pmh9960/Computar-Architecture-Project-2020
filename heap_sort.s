# Example program to display an array.
# Demonstrates use of QtSpim system service calls.
# -----------------------------------------------------
# Data Declarations

.data
title:  .asciiz "Heap Sort\n"
explain:.asciiz "Enter integer. Exit if you enter -1\n"
over:   .asciiz "Memory error. Too many integer.\n"
input:  .asciiz "Input : "
output: .asciiz "OUTPUT : "
end:    .asciiz "END\n"

space:  .asciiz " "
enter:  .asciiz "\n"

heap:   .space  1000
heapsz: .word   250

# -----------------------------------------------------
# text/code section

.text
.globl 	main
.ent 	main

main:
	li 	$v0, 4
	la 	$a0, title
	syscall
	li 	$v0, 4
	la 	$a0, explain
	syscall

    # $s0 = address of heap
    # $s1 = size of heap
    la  $s0, heap
    lw  $s1, heapsz

    # $s2 = size of heap
    # $s3 = store pointer
    addi $s0, $s0, 3
    li  $s2, 0
    move $s3, $s0

loop:
    beq $s2, $s1, overmemory
    li  $v0, 4
    la  $a0, input
    syscall

    li  $v0, 5
    syscall
    
    beq $v0, -1, exit
    sw  $v0, 0($s3)
    
    # 숫자를 받았으므로 integer 개수가 하나 늘었고 pointer도 이동해준다.
    addi $s2, $s2, 1
    addi $s3, $s3, 4

    sub $t0, $s2, 1

heapify:
    # heapify
    # args : index
    #        $t0
    # temp : largest, left_index, right_index
    #        $t1,     $t2,        $t3
    # trash value : $t5, $t6, $t7
    addi $sp, $sp, 4
    sw $ra, 0($sp)

    beq $t0, 0, L3

    # $t0의 기우성 보기 
    # 아래에서 위로 올라가야 함
    rem $t5, $t0, 2
    beq $t5, 1, odd
    div $t0, $t0, 2
    addi $t0, $t0, -1
    j exit_odd_even
    odd:
        div $t0, $t0, 2
    exit_odd_even:

    move $t1, $t0
    mul $t2, $t0, 2
    addi $t2, $t2, 1
    mul $t3, $t0, 2
    addi $t3, $t3, 2

    # left_index < heap_size
    bge $t2, $s2, L1
    # $t5 : arr[left_index]
    # $t6 : arr[largest]
    mul $t5, $t2, 4
    add $t5, $t5, $s0
    mul $t6, $t1, 4
    add $t6, $t6, $s0
    lw  $t5, 0($t5)
    lw  $t6, 0($t6)
    ble $t6, $t5, L1 # unsorted[largest] >= unsorted[left_index]
    move $t1, $t2
    L1: 
        # right
        bge $t3, $s2, L2
        # $t5 : arr[right_index]
        # $t6 : arr[largest]
        mul $t5, $t3, 4
        add $t5, $t5, $s0
        mul $t6, $t1, 4
        add $t6, $t6, $s0
        lw  $t5, 0($t5)
        lw  $t6, 0($t6)
        ble $t6, $t5, L2 # unsorted[largest] >= unsorted[right_index]
        move $t1, $t3
    L2:
        beq $t0, $t1, L3
        # unsorted[largest], unsorted[index] = unsorted[index], unsorted[largest]
        # heapify(unsorted, largest, heap_size)
        mul $t5, $t1, 4
        add $t5, $t5, $s0
        mul $t6, $t0, 4
        add $t6, $t6, $s0

        lw  $t7, 0($t5)
        lw  $t8, 0($t6)
        sw  $t7, 0($t6)
        sw  $t8, 0($t5)

        jr, heapify

    L3:
        sw $ra, 0($sp)
        addi $sp, $sp, 4
        # finish heapify

# print
li $v0, 4
la $a0, output
syscall
# $t5 : pointer (it is only used in print loop)
# $t6, $t7 : swap temp
move $t5, $s3
loop_print: 
    bge  $t5, $s0, exit_loop_print
    addi $t5, $t5, -4

    li  $v0, 1
    lw  $a0, ($s0)
    syscall
    li  $v0, 4
    la  $a0, space
    syscall

    # put the last node in front
    # but it is actually swap
    lw  $t6, ($s0)
    lw  $t7, ($t5)
    sw  $t7, ($s0)
    sw  $t6, ($t5)

    # heapify (head to tail)

    j loop_print

exit_loop_print:
    li $v0, 4
    la $a0, enter
    syscall

    j loop

exit:
    li  $v0, 4
    la  $a0, end
    syscall
# -----
# Done, terminate program.
	li $v0, 10		# terminate
	syscall			# system call
	.end main

overmemory:
    li  $v0, 4
    la  $a0, over
    syscall
    li  $v0, 10
    syscall
