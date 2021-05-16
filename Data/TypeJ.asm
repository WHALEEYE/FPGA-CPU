.data
	eleven: .word 11
.text
	lw $a1, eleven
	jal AddOne
	j AddTwo
	
	
	AddOne:
	addi $a1, $a1, 1
	jr $ra
	
	AddTwo:
	addi $a1, $a1, 2
	
	li $v0, 10
	syscall