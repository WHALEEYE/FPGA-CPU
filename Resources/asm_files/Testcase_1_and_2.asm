.data 
.text 
# register list:
# a0 : output
# v0 : input and control syscall

# s1 : first  bit of control
# s2 : second bit of control
# s3 : third  bit of control
# a1 : val
# a2 : sign bit

# s4 : num 1
# s5 : num 2

start:
    addi    $v0, $zero, 5
    syscall
    srl     $t0, $v0, 31
    addi    $t1, $zero, 1
    beq     $t0, $t1, test_2

    test_1:
        addi    $v0, $zero, 5
        syscall
        srl     $t0, $v0, 16
        andi    $s1, $t0, 1
        andi    $s2, $t0, 2
        srl     $s2, $s2, 1
        andi    $s3, $t0, 4
        srl     $s3, $s3, 2
        addi    $t0, $zero, 1

        beq     $s3, $t0, test_1_1XX

        test_1_0XX:
            beq     $s2, $t0, test_1_01X

            test_1_00X:
                beq     $s1, $t0, test_1_001

                test_1_000:     #blink
                    addi    $a0, $zero, 21845
                    jal     output
                    jal     pause
                    sll     $a0, $a0, 1
                    jal     output
                    jal     pause
                    j       start

                test_1_001:     #read data
                    addi    $v0, $zero, 5
                    syscall
                    add     $a1, $v0, $zero
                    sll     $a1, $a1, 16
                    srl     $a1, $a1, 16
                    srl     $a2, $a1, 15
                    sll     $a2, $a2, 15
                    add     $a0, $a1, $zero
                    jal     output
                    j       start

            test_1_01X:
                beq     $s1, $t0, test_1_011

                test_1_010:     #add 1
                    addi    $a1, $a1, 1
                    add     $a0, $a1, $zero
                    jal     output
                    jal     pause
                    j       start

                test_1_011:     #sub 1
                    addi    $a1, $a1, -1
                    add     $a0, $a1, $zero
                    jal     output
                    jal     pause
                    j       start

        test_1_1XX:
            beq     $s2, $t0, test_1_11X

            test_1_10X:
                beq     $s1, $t0, test_1_101

                test_1_100:     #sll 1
                    sll     $a1, $a1, 1
                    add     $a0, $a1, $zero
                    jal     output
                    jal     pause
                    j       start

                test_1_101:     #srl 1
                    srl     $a1, $a1, 1
                    add     $a0, $a1, $zero
                    jal     output
                    jal     pause
                    j       start

            test_1_11X:
                beq     $s1, $t0, test_1_111

                test_1_110:     #sra 1
                    srl     $a1, $a1, 1
                    add     $a1, $a1, $a2
                    add     $a0, $a1, $zero
                    jal     output
                    jal     pause
                    j       start

                test_1_111:     #nothing
                    add     $a0, $a1, $zero
                    jal     output
                    j       start

    test_2:
        addi    $v0, $zero, 5
        syscall
        srl     $t0, $v0, 16
        andi    $s1, $t0, 1
        andi    $s2, $t0, 2
        srl     $s2, $s2, 1
        andi    $s3, $t0, 4
        srl     $s3, $s3, 2
        addi    $t0, $zero, 1
        
        beq     $s3, $t0, test_2_1XX

        test_2_0XX:
            beq     $s2, $t0, test_2_01X

            test_2_00X:
                beq     $s1, $t0, test_2_001

                test_2_000:     #read num1 and num2
                    addi      $v0, $zero, 5
                    syscall
                    sll     $s4, $v0, 16
                    srl     $s4, $s4, 24
                    sll     $s5, $v0, 24
                    srl     $s5, $s5, 24

                    sll     $a0, $s4, 13
                    addi    $t2, $zero, 0
                    addi    $t3, $zero, 1808
                    add_loop:
                        add     $a0, $s4, $a0
                        addi    $t2, $t2, 1
                        bne     $t2, $t3, add_loop
                    add     $a0, $a0, $s5
                    jal     output
                    j       start

                test_2_001:     # num1 + num2
                    add     $a0, $s4, $s5
                    jal     output
                    j       start

            test_2_01X:
                beq     $s1, $t0, test_2_011

                test_2_010:     # num1 - num2
                    sub     $a0, $s4, $s5
                    jal     output
                    j       start

                test_2_011:     # sllv
                    sllv    $a0, $s4, $s5
                    jal     output
                    j       start

        test_2_1XX:
            beq     $s2, $t0, test_2_11X

            test_2_10X:
                beq     $s1, $t0, test_2_101

                test_2_100:     # srlv
                    srlv    $a0, $s4, $s5
                    jal     output
                    j       start

                test_2_101:     # slt
                    slt     $a0, $s5, $s4
                    jal     output 
                    j       start

            test_2_11X:
                beq     $s1, $t0, test_2_111

                test_2_110:     # num1 & num2
                    and     $a0, $s4, $s5
                    jal     output
                    j       start

                test_2_111:     # num1 ^ num2
                    xor     $a0, $s4, $s5
                    jal     output
                    j       start

output:
    addi $v0, $zero, 1
	syscall 
	jr $ra

pause:
    addi $v0, $zero, 111
	syscall 
	jr $ra

