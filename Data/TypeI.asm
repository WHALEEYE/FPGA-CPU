.data 0x0000
	eleven: .word 11
.text 0x0000
start:
	lw $t1, eleven
	la $t2, eleven
	
	sw $t1, ($t2)
	beq  $t1, 1, exit 
	bne  $t1, 11, exit
	addi $t1, $t1, 1
	addiu  $t1, $t1, -1
	
	andi $t3, $t1, 1
	ori $t4, $t1, 1
	xori $t5, $t1, 1
	
	slti $a1, $t1, 11
	sltiu $a2, $t1, 11
	lui $a3, 11

	
	exit:
	li $v0, 10
	syscall