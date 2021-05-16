.data
	eleven: .word 11
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