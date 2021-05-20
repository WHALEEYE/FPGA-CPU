.data
.text
#first_test
Loop_1:
	addi $t0, $zero, 1
	addi $v1, $zero, 0
	addi $v0,  $zero, 5
	syscall
	add $a0, $v0, $zero
	srl $a2, $a0, 31
	andi $s1, $a2, 1
	beq $s1, $t0, Loop

	addi $v0,  $zero, 5
	syscall
	
	add $a0, $v0, $zero
	srl $a2, $a0, 16
	andi $s1, $a2, 1
	srl $a2, $a2, 1
	andi $s2, $a2, 1
	srl $a2, $a2, 1
	andi $s3, $a2, 1
	beq $s3, $t0, first_bit_one_1
	beq $s2, $t0, first_zero_second_one_1
	beq $s1, $t0, zzo_1
	
zzz_1:
	addi $a0, $zero, 21845
	jal output_1
	jal zawaludo
	sll $a0, $a0, 1
	jal output_1
	jal zawaludo
	j Loop_1
	
first_zero_second_one_1:
	beq $s1, $zero, zoz_1
	
zoo_1:
	addi $v1, $v1, -1
	add $a0, $v1, $zero
	jal output_1
	jal zawaludo
	j  Loop_1
	
	
first_bit_one_1: 
	beq $s2, $zero, first_one_second_zero_1
	beq $s1, $zero, ooz_1
	jal output_1
	jal zawaludo
	j  Loop_1
		
	
first_one_second_zero_1:
	beq $s1, $zero, ozz_1
	
ozo_1:
	srl $v1, $v1, 1
	add $a0, $v1, $zero
	jal output_1
	jal zawaludo
	j  Loop_1
	
ozz_1: 
	sll $v1, $v1, 1
	add $a0, $v1, $zero
	jal output_1
	jal zawaludo
	j  Loop_1
	
ooz_1: #sra
	srl $v1, $v1, 1
	add $v1, $v1, $t1
	add $a0, $v1, $zero
	jal output_1
	jal zawaludo
	j  Loop_1
	
zoz_1:
	addi $v1, $v1, 1
	add $a0, $v1, $zero
	jal output_1
	jal zawaludo
	j  Loop_1
	
zzo_1: #read
	add $v1, $a0, $zero
	sll $v1, $v1, 16
	srl $v1, $v1, 16
	srl $t1, $v1, 15
	sll $t1, $t1, 15
	add $a0, $v1, $zero
	jal output_1
	jal zawaludo
	j  Loop_1	
	
output_1:
	addi $v0, $zero, 1
	syscall 
	jr $ra
	
zawaludo:
	addi $v0, $zero, 111
	syscall
	jr $ra
	
#second test
Loop:
	addi $v0,  $zero, 5
	syscall
	
	add $a0, $v0, $zero
	srl $a2, $a0, 16
	andi $s1, $a2, 1
	srl $a2, $a2, 1
	andi $s2, $a2, 1
	srl $a2, $a2, 1
	andi $s3, $a2, 1
	beq $s3, $t0, first_bit_one

	beq $s2, $t0, first_zero_second_one
	beq $s1, $t0, zzo
zzz:
	sll $s5, $a0, 24
	srl $s5, $s5, 24
	sll $s4, $a0, 16
	srl $s4, $s4, 24

	sll $a0, $s4, 13
	addi $t2, $zero, 0
	addi $t3, $zero, 1808
	add_loop:
		add $a0, $s4, $a0
		addi $t2, $t2, 1
		bne $t2, $t3, add_loop
	add $a0, $a0, $s4
	jal output
	j Loop
	
	
first_zero_second_one:
	beq $s1, $zero, zoz
	
zoo:
	sllv $a0, $s4, $s5
	jal output
	j  Loop_1
	
first_bit_one: 
	beq $s2, $zero, first_one_second_zero
	beq $s1, $zero, ooz
	xor $v1, $s4, $s5
	jal output
	j  Loop_1
		
	
first_one_second_zero:
	beq $s1, $zero, ozz
	
ozo:
	slt $a0, $s5, $s4
	jal output 
	j  Loop_1
	
ozz: 
	srlv $a0, $s4, $s5
	jal output
	j  Loop_1
	
ooz:
	and $a0, $s4, $s5
	jal output
	j  Loop_1
	
zoz:
	sub  $a0, $s4, $s5
	jal output
	j  Loop_1
	
zzo:
	add $a0, $s4, $s5
	jal output
	j  Loop_1
	
output:
	addi $v0, $zero, 1
	syscall 
	jr $ra
