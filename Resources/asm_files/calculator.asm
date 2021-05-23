.data
.text
start:
    addi    $v0, $zero, 5
    syscall

    srl     $t0, $v0, 16
    andi    $s1, $t0, 1
    andi    $s2, $t0, 2
    srl     $s2, $s2, 1
    andi    $s3, $t0, 4
    srl     $s3, $s3, 2
    addi    $t0, $zero, 1
        
    beq     $s3, $t0, case_1XX

    case_0XX:
         beq     $s2, $t0, case_01X

        case_00X:
            beq     $s1, $t0, case_001

            case_000:     #read num1 and num2   x = $s4 y = $s5
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

            case_001:     # x * y
                addi    $t2, $zero, 0
                addi    $a0, $zero, 0
                mul_loop:
                    add     $a0, $s4, $a0
                    addi    $t2, $t2, 1
                    bne     $t2, $s5, mul_loop
                jal     output
                j       start

        case_01X:
            beq     $s1, $t0, case_011

            case_010:     # x / y
                add     $t2, $zero, $s4
                addi    $a0, $zero, 0
                div_loop:
                    slt     $t4, $s5, $t2
                    beq     $t4, $zero, div_end
                    sub     $t2, $t2, $s5
                    addi    $a0, $a0, 1
                    j       div_loop
                div_end:
                j       output
                j       start

            case_011:     # nothing
                j       start

    case_1XX:
        beq     $s2, $t0, case_11X

        case_10X:
            beq     $s1, $t0, case_101

            case_100:     # x % y
                add     $a0, $zero, $s4
                mod_loop:
                    slt     $t4, $s5, $a0
                    beq     $t4, $zero, mod_end
                    sub     $a0, $a0, $s5
                    j       mod_loop
                mod_end:
                j       output
                j       start

            case_101:     # nothing
                j       start

        case_11X:
            beq     $s1, $t0, case_111

            case_110:     # nothing
                j       start

            case_111:     # nothing
                j       start

output:
    addi $v0, $zero, 1
    syscall
    jr $ra

pause:
    addi $v0, $zero, 111
    syscall 
    jr $ra

