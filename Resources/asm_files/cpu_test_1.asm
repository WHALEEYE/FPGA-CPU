.data
	init: .word 1431655765
.text
start:
	addi		$s0,		$zero,		0
	lw			$s1,		0($s0)
	add			$a0,		$s1,		$zero
Loop:
	addi		$v0,		$zero,		1
	syscall
	addi		$v0,		$zero,		111
	syscall
	srl			$a0,		$a0,		1
	j			Loop
