.data
.text
start:
	addi		$a0,			$zero,			1
Loop:
	addi		$v0,			$zero,			1
	addi		$v0,			$zero,			1
	addi		$v0,			$zero,			111
	addi		$v0,			$zero,			111
	sll			$a0,			$a0,			1
	j		Loop
	
	