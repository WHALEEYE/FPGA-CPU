.data
.text
#first_test
Loop_1:
	addi $t0, $zero, 1
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
	addi $v1, $zero, 21845
	jal output_1
	jal zawaludo
	sll $v1, $v1, 1
	jal output_1
	jal zawaludo
	j Loop_1
	
first_zero_second_one_1:
	beq $s1, $zero, zoz_1
	
zoo_1:
	addi $v1, $v1, -1
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
	jal output_1
	jal zawaludo
	j  Loop_1
	
ozz_1: 
	sll $v1, $v1, 1
	jal output_1
	jal zawaludo
	j  Loop_1
	
ooz_1:
	sra $v1, $v1, 1
	jal output_1
	jal zawaludo
	j  Loop_1
	
zoz_1:
	addi $v1, $v1, 1
	jal output_1
	jal zawaludo
	j  Loop_1
	
zzo_1:
	add $v1, $a0, $zero
	sll $v1, $v1, 16
	srl $v1, $v1, 16
	jal output_1
	jal zawaludo
	j  Loop_1	
	
output_1:
	add $a0, $v1, $zero
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
	sll $s4, $a0, 24
	srl $s4, $s4, 24
	sll $s5, $a0, 16
	srl $s5, $s5, 24
	j Loop
	
	
first_zero_second_one:
	beq $s1, $zero, zoz
	
zoo:
	add $s6, $s5, $zero
	add $v1, $s4, $zero
judge:
	slti $s7, $s6, 1
	beq $s7, $zero, shift_left 
	jal output
	j  Loop
	
shift_left:
	sll $v1, $v1, 1
	addi $s6, $s6, -1
	j judge
	
first_bit_one: 
	beq $s2, $zero, first_one_second_zero
	beq $s1, $zero, ooz
	xor $v1, $s4, $s5
	jal output
	j  Loop
		
	
first_one_second_zero:
	beq $s1, $zero, ozz
	
ozo:
	slt $s6, $s5, $s4
	beq $s6, $t0, bigger 
	addi $v1, $zero, 0
	jal output 
	j  Loop
	
bigger:
	addi $v1, $zero, 1
	j Loop
	
	
ozz: 
	add $s6, $s5, $zero
	add $v1, $s4, $zero
judge_2:
	slti $s7, $s6, 1
	beq $s7, $zero, shift_right 
	jal output
	j  Loop
	
shift_right:
	srl $v1, $v1, 1
	addi $s6, $s6, -1
	j judge_2
	
ooz:
	and $v1, $s4, $s5
	jal output
	j  Loop
	
zoz:
	sub  $v1, $s4, $s5
	jal output
	j  Loop
	
zzo:
	add $v1, $s4, $s5
	jal output
	j  Loop
	
output:
	add $a0, $v1, $zero
	addi $v0, $zero, 1
	syscall 
	jr $ra
