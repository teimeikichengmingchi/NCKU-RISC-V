.data
nums1:      .word 0
            .word 0
            .word 0
            .word 1
            .word 1
            .word 2
            .word 3
            .word 4
            .word 4
            .word 4
            .word 5
            .word 6
            .word 7
            .word 7
            .word 7

nums2:      .word -7
            .word -7
            .word 0
            .word 1
            .word 1
            .word 3
            .word 3
            .word 4
            .word 4
            .word 4
            .word 5
            .word 5
            .word 5
            .word 6

nums3:      .word -1
            .word 0
            .word 0
            .word 1
            .word 1
            .word 2
            .word 3
            .word 4
            .word 4
            .word 4
            .word 5
            .word 6
            .word 7
            .word 7
            .word 7
            .word 8
            .word 9
            .word 10
            .word 11
            .word 11
            .word 11

space:      .byte 32
newline:    .byte 10

.text
# start main function here
main:
    la a0, nums1                # load argument 1 (base address of num1)
    addi a1, zero, 15           # load argument 2
    jal removeDuplicates
    
    # the return value is the argument of next function(print), so we can directely call "print"
    # add s0, a0, zero          # receive return value of removeDuplicates
    jal print

    la a0, nums2
    addi a1, zero, 14
    jal removeDuplicates
    jal print

    la a0, nums3
    addi a1, zero, 21
    jal removeDuplicates
    jal print

    j exit


# function to remove duplicated values in an array
# removeDuplicates(int *nums, int numSize)
removeDuplicates:
    add s0, zero, zero          # shift = 0
    addi s1, zero, 1            # i = 1 * 4
    add s2, a0, zero            # nums' base address
    addi s2, s2, 4              # nums[1]'s address
for:
    bge s1, a1, forEnd
# if:
    addi t0, s2, -4             # t0 is (i - 1) * 4
    lw t1, 0(s2)                # t1 is nums[i]
    lw t2, 0(t0)                # t2 is nums[i - 1]
    bne t1, t2, else
# then:
    addi s0, s0, 4              # (shift++) * 4
    j ifEnd
else:
    sub t0, s2, s0              # t0 is the address of nums[i - shift]
    sw t1, 0(t0)
ifEnd:
    addi s1, s1, 1
    addi s2, s2, 4
    j for
forEnd:
    srli s0, s0, 2
    sub a1, a1, s0
    jr ra



# function to print each value in an array
# print(int *nums, int numSize)
print:
    add t0, zero, zero          # i = 0
    add t1, a0, zero            # t1 is array's base address
printLoop:
    bge t0, a1, printLoopEnd
    lw a0, 0(t1)
    addi a7, zero, 1
    ecall
    
    la a0, space
    lbu a0, 0(a0)                # load the ascii value of ' ' in address of space
    addi a7, zero, 11
    ecall
    
    addi t0, t0, 1              # i++
    addi t1, t1, 4              # go to next element in array
    j printLoop
printLoopEnd:
    la a0, newline
    lbu a0, 0(a0)
    addi a7, zero, 11
    ecall
    jr ra



# exit the program
exit:
    li a7, 10
    ecall
