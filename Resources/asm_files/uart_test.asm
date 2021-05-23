.data
.text
start:
	addi		$a0,			$zero,			0
	addi		$t1,			$zero,			17

Loop_1:
	addi		$v0,			$zero,			1
	syscall
	addi		$v0,			$zero,			111
	syscall
	sll			$a0,			$a0,				1
	addi		$t0,			$t0,				1
	beq			$t0, 			$t1, 				Loop_2	# if $t0 == $t1 then Loop_2
	j				Loop_1				# jump to Loop_1
	
Loop_2:
	addi		$v0,			$zero,			1
	syscall
	addi		$v0,			$zero,			111
	syscall
	srl			$a0,			$a0,				1
	addi		$t0,			$t0,				-1
	beq			$t0, 			$zero, 			Loop_1	# if $t0 == $zero then Loop_1
	j				Loop_2				# jump to Loop_2

	