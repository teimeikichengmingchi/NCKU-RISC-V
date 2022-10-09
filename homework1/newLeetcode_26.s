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

ans1:       .word 8
ansArr1:    .word 0
            .word 1
            .word 2
            .word 3
            .word 4
            .word 5
            .word 6
            .word 7
            
ans2:       .word 7
ansArr2:    .word -7
            .word 0
            .word 1
            .word 3
            .word 4
            .word 5
            .word 6

ans3:       .word 13
ansArr3:    .word -1
            .word 0
            .word 1
            .word 2
            .word 3
            .word 4
            .word 5
            .word 6
            .word 7
            .word 8
            .word 9
            .word 10
            .word 11

true:        .string "true!\n"
false:        .string "false!\n"


.text
# start main function here
main:
    la a0, nums1                # load argument 1 (base address of num1)
    addi a1, zero, 15           # load argument 2
    jal removeDuplicates
    
    # the return value is the argument of next function(print), so we can directely call "print"
    # add s0, a0, zero          # receive return value of removeDuplicates
    jal print
    la a0, nums1
    la a2, ans1
    lw a2, 0(a2)
    la a3, ansArr1
    jal checkAns

    la a0, nums2
    addi a1, zero, 14
    jal removeDuplicates
    jal print
    la a0, nums2
    la a2, ans2
    lw a2, 0(a2)
    la a3, ansArr2
    jal checkAns

    la a0, nums3
    addi a1, zero, 21
    jal removeDuplicates
    jal print
    la a0, nums3
    la a2, ans3
    lw a2, 0(a2)
    la a3, ansArr3
    jal checkAns
    
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
    #j ifEnd
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

# function to check the answer
# a0 array's base address
# a1 returned array's length
# a2 true length
# a3 true array's address
checkAns:
    add t0, a0, zero            # t0 is array's base address
    la a0, false                # default is false, if true, a0 will be modified in checkTrue
    li a7, 4
    bne a1, a2, checkAnsEnd
    add t1, zero, zero            # i = 0
checkAnsFor:
    bge t1, a2, checkTrue
    lw t2, 0(t0)                # t2 = a0[i]
    lw t3, 0(a3)                # t3 = a3[i]
    bne t2, t3 checkAnsEnd
    addi t1, t1, 1
    addi t0, t0, 4
    addi a3, a3, 4
    j checkAnsFor
checkTrue:
    la a0, true
checkAnsEnd:
    ecall
    jr ra

# exit the program
exit:
    li a7, 10
    ecall
