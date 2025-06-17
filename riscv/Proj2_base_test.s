###############################
## (c) 2025 Connor J. Link. All Rights Reserved.
## Iowa State University - CPRE 3810
## Proj1_base_test.s
###############################

###############################
## Arithmetic-Type Instruction Test Suite
###############################

# x2 contains the test number to diagnose failures easily
# x5 is the first arithmetic operand
# x6 is the second arithmetic operand
# x7 is the actual arithmetic result
# x8 is the expected arithmetic result

.data
dummy: .word 0

.text
_start:
    # Test 1.) add
    li x2, 1         # 00100113
    li x5, 10        # 00a00293
    li x6, 5         # 00500313
    li x8, 15        # 00f00413
    add x7, x5, x6   # 006283b3
    # x7 = 10 + 5 = 15
    bne x7, x8, fail # 1a839463


    # Test 2.) addi
    li x2, 2         # 00200113
    li x5, 10        # 00a00293
    li x8, 12        # 00c00413
    addi x7, x5, 2   # 00228393
    # x7 = 10 + 2 = 12
    bne x7, x8, fail # 1a839063
    

    # Test 3.) sub
    li x2, 3
    li x5, 20
    li x6, 5
    li x8, 15
    sub x7, x5, x6
    # x7 = 20 - 5 = 15
    bne x7, x8, fail


    # Test 4.) "subi"
    li x2, 4
    li x5, 20
    li x8, 12
    addi x7, x5, -8
    # x7 = 20 - 8 = 12
    bne x7, x8, fail


    # Test 5.) or
    li x2, 5
    li x5, 0xA 
    li x6, 0xC
    li x8, 0xE
    or x7, x5, x6
    # x7 = b1010 | b1100 = b1110
    bne x7, x8, fail


    # Test 6.) ori
    li x2, 6
    li x5, 0xA
    li x8, 0xB
    ori x7, x5, 0x1
    # x7 = b1010 | b0001 = b1011
    bne x7, x8, fail


    # Test 7.) and
    li x2, 7         # 00700113 ; 780ns
    li x5, 0xA       # 00a00293
    li x6, 0x3       # 00300313
    li x8, 0x2       # 00200413
    and x7, x5, x6   # 0062f3b3
    # x7 = b1010 & b0011 = b0010
    bne x7, x8, fail # 12839263


    # Test 8.) andi
    li x2, 8
    li x5, 0xA
    li x8, 0x8
    andi x7, x5, 0xC
    # x7 = b1010 & b1100 = b1000
    bne x7, x8, fail


    # Test 9.) xor
    li x2, 9
    li x5, 0x5
    li x6, 0xF
    xor x7, x5, x6
    # x7 = b0101 ^ b1111 = b1010
    li x8, 0xA
    bne x7, x8, fail


    # Test 10.) xori
    li x2, 10
    li x5, 0x3
    li x8, 0xC
    xori x7, x5, 0xF
    # x7 = b0011 ^ b1111 = b1100
    bne x7, x8, fail


    # Test 11.) sll
    li x2, 11
    li x5, 0x1
    li x6, 2
    li x8, 0x4
    sll x7, x5, x6
    # x7 = b0001 << 2 = b0100
    bne x7, x8, fail


    # Test 12.) slli
    li x2, 12
    li x5, 0x1
    li x8, 0x2
    slli x7, x5, 1
    # x7 = b0001 << 1 = b0010
    bne x7, x8, fail


    # Test 13.) srl
    li x2, 13
    li x5, 0x4
    li x6, 2
    li x8, 0x1
    srl x7, x5, x6
    # x7 = b0100 >> 2 = b0001
    bne x7, x8, fail


    # Test 14.) srli
    li x2, 14
    li x5, 0x4
    li x8, 0x2
    srli x7, x5, 1
    # x7 = b0100 >> 1 = b0010
    bne x7, x8, fail


    # Test 15.) sra
    li x2, 15
    li x5, -8
    li x6, 1
    li x8, -4
    sra x7, x5, x6
    # x7 = -8 >> 1 = -4
    bne x7, x8, fail


    # Test 16.) srai
    li x2, 16
    li x5, -8
    li x8, -2
    srai x7, x5, 2
    # x7 = -8 >> 2 = -2
    bne x7, x8, fail
    

    # Test 17.) slt
    li x2, 17
    li x5, -5
    li x6, 4
    li x8, 1
    slt x7, x5, x6
    # x7 = -5 < 4 = 1
    bne x7, x8, fail

    
    # Test 18.) slti
    li x2, 18
    li x5, 4
    li x8, 0
    slti x7, x5, 3
    # x7 = 4 < 3 = 0
    bne x7, x8, fail 


    # Test 19.) sltu
    li x2, 19
    li x5, -5
    li x6, 4
    li x8, 0
    sltu x7, x5, x6
    # x7 = -5 < 4 (unsigned) = 0
    bne x7, x8, fail


    # Test 20.) sltiu
    li x2, 20
    li x5, 1
    li x8, 1
    sltiu x7, x5, 3
    # x7 = 1 < 3 (unsigned) = 1
    bne x7, x8, fail

    # omitting fence, ecall, ebreak since they all just implement a no-op or trap

    # Success if execution reaches here
    j pass

fail:
    li x1, 1           # return 1 (EXIT_FAILURE)
    j end

pass:
    li x1, 0           # return 0 (EXIT_SUCCESS)

end:
    ebreak