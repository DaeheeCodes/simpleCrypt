.global encrypt
.global decrypt

.text
.align 4
/// function: encrypt
/// input: R0 - address of message array
///	   R1 - length of message array
///	   R2 - address of key array
///	   R3 - length of key array
/// return: no return values, just the message encrypted
///
.align 4
encrypt:
// step #1_en - Save R4,R5,R6,R7, and LR
push { r4, r5, r6, r7, LR}
// step #2_en - Set register R4 to 0
mov r4, #0
// step #3+_en - Set register R5 to 0
mov r5, #0
EN_WHL_R5_LT_R1:
// step #4_en - compare R5 and R1 in this order of the registers
cmp r5, r1
// step #5_en - if R5 greater than or equal to R1, branch to EN_END_WHL_R5_LT_R1
// bge = greater, equal conditioanl
bge EN_END_WHL_R5_LT_R1
// step #6_en - load byte into register R6, the contents of R0[R5]
ldrb r6, [r0,r5]
// step #7_en - load byte into register R7, the contents of R2[R4]
ldrb r7, [r2,r4]
// step #8_en - exclusive or R6 and R7, storing result in R6
eor r6,r7
// step #9_en - use bitwise AND with R5 and #255 to cast R5's value as char instead of int, store in R7
and r7,r5, #255
// step #10_en - add R6 and R7, storing result in R6
add r6,r7
// step #11_en - store byte in R6 to R0[R5]
strb r6, [r0,r5]
// step #12_en - increment R4 by one
add r4, #1
EN_IF_R4_GE_R3:
// step #13_en - compare R4 and R3 in this order of the registers
cmp r4, r3
// step #14_en - do conditional execution, move if greater than or equal, into R4 the value #0
movge r4, #0
// step #15_en - increment R5 by one
add r5, #1
// step #16_en - branch (or branch ALways) back to EN_WHL_R5_LT_R1 label
b EN_WHL_R5_LT_R1
EN_END_WHL_R5_LT_R1:
// step #17_en - restore the registers R4,R5,R6,R7, and PC; in the order of registers given
pop { r4, r5, r6, r7, PC}
//////////////////////////////////////////////////////////////////////////////////////////////
/// end of encrypt function //////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

/// function: decrypt
/// input: R0 - address of encrypted message array
///	   R1 - length of encrypted message array
///	   R2 - address of key array
///	   R3 - length of key array
/// return: no return values, just the message decrypted
///
.align 4
decrypt:
// step #1_de - Save R4,R5,R6,R7, and LR
push { r4, r5, r6, r7, LR}
// step #2_de - Set register R4 to 0
mov r4, #0
// step #3+_de - Set register R5 to 0
mov r5, #0
DE_WHL_R5_LT_R1:
// step #4_de - compare R5 and R1 in this order of the registers
cmp r5, r1
// step #5_de - if R5 greater than or equal to R1, branch to EN_END_WHL_R5_LT_R1
// bge = greater, equal conditioanl
bge DE_END_WHL_R5_LT_R1
// step #6_de - load byte into register R6, the contents of R0[R5]
ldrb r6, [r0, r5]
// step #7_de - use bitwise AND with R5 and #255 to cast R5's value as char instead of int, store in R7
and r7, r5, #255
// step #8_de - subtract R6 and R7, storing result in R6
sub r6, r7
// step #9_de - load byte into register R7, the contents of R2[R4]
ldrb r7, [r2, r4]
// step #10_de - exclusive or R6 and R7, storing result in R6
eor r6, r7
// step #11_de - store byte in R6 to R0[R5]
strb r6, [r0,r5]
// step #12_de - increment R4 by one
add r4, #1
DE_IF_R4_GE_R3:
// step #13_de - compare R4 and R3 in this order of the registers
cmp r4, r3
// step #14_de - do conditional execution, move if greater than or equal, into R4 the value #0
movge r4, #0
// step #15_de - increment R5 by one
add r5, #1
// step #16_de - branch (or branch ALways) back to DE_WHL_R5_LT_R1 label
b DE_WHL_R5_LT_R1
DE_END_WHL_R5_LT_R1:
// step #17_en - restore the registers R4,R5,R6,R7, and PC; in the order of registers given
pop { r4, r5, r6, r7, PC}
//////////////////////////////////////////////////////////////////////////////////////////////
/// end of decrypt function //////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////]
