//There are three .asm files here, test separately.
//type I:

.data
	eleven: .word 11
.text
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
  
  
  
  //type R:
  
  .data
	eleven: .word -11
.text
	lw $t1, eleven
	sll $a1, $t1, 1
	sllv $a2, $t1, $t1
	
	srl $a3, $t1, 1
	srlv $t2 $t1, $t1
	
	sra $t3, $t1, 1
	
	add $t4, $t1, $t1
	addu $t5, $t1, $t1
	
	sub $t6, $t1, 1
	subu $t7, $t1, 1
	
	and $t8, $t1, 1
	or $t9, $t1, 1
	xor $s1, $t1, 1
	nor $s2, $t1, $a3
	
	slt $s3, $t1, $t4
	sltu $s4, $t1, $t5
  
  
  
  Type J:
  
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

	

	  
