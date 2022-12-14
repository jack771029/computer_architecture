.data
nums1:
    .word   1,2,3,4,5,6,7,8,9
nums2:
    .word   1,2,3,4,5,6,7,8,4
nums3:
    .word   4,2,3,4,4,6,7,8,9    
len:
    .word   9
value:
    .word   4
str1:
    .string "Nums:"
str2:
    .string ","
str3:
    .string ". "

.text
# s2 : num len
# s3 : remove value
# s5 : new_nums len
# s6 : count

main:
    la      a0, nums1           # load nums1 addr
    jal     ra, removeElement   # go to removeElement
    jal     ra, printResult     # print nums1 result to console

    la      a0, nums2           # load nums2 addr
    jal     ra, removeElement   # go to removeElement
    jal     ra, printResult     # print nums1 result to console

    la      a0, nums3           # load nums3 addr
    jal     ra, removeElement   # go to removeElement
    jal     ra, printResult     # print nums1 result to console

    j   exit

removeElement:
    lw      s2, len             # load num len
    lw      s3, value           # load will remove value
    mv      s5, x0              # set count new_nums len
    addi    s6, x0, 1           # set count = 1
    mv      a1, a0              # copy address to a1
    addi    sp,sp,-4
    sw      a0, 0(sp)           # save nums head address in stack
loop:
    lw      t0, 0(a0)           # load nums value
    beq     t0, s3, next        # if nums == value, go next
    sw      t0, 0(a1)           # write back value to nums
    addi    a1, a1, 4           # nums next addr for write back addr
    addi    s5, s5, 1           # count write value len
next:
    addi    a0, a0, 4           # nums next addr
    beq     s6, s2, end         # count = len, go end
    addi    s6, s6, 1           # count +1
    j loop
end:
    lw      a1, 0(sp)           # restore nums head address for print used
    jr ra

printResult:
    addi    s6, x0, 1           # set count = 1
    mv      a0, s5              # print new_nums number
    li      a7, 1               # print integer ecall
    ecall
    la      a0, str2
    li      a7, 4               # print string ecall
    ecall
    la      a0, str1
    li      a7, 4               # print string ecall
    ecall
    lw      a0, 0(a1)
    li      a7, 1               # print integer ecall
    ecall
print_loop:
    la      a0,str2
    li      a7, 4               # print string ecall
    ecall
    addi    a1, a1, 4           # next value
    lw      a0, 0(a1)
    li      a7, 1
    ecall
    addi    s6, s6, 1
    bne     s6, s5, print_loop  # if count != nums len go loop
    la      a0, str3
    li      a7, 4               # print string ecall
    ecall
    jr ra

exit:
    li      a7, 10              # print exit program
    ecall
