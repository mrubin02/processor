module or_bit(result, operandA, operandB);

    input [31:0] operandA, operandB;
    output [31:0] result;

    or OR0(result[0], operandA[0], operandB[0]);
    or OR1(result[1], operandA[1], operandB[1]);
    or OR2(result[2], operandA[2], operandB[2]);
    or OR3(result[3], operandA[3], operandB[3]);
    or OR4(result[4], operandA[4], operandB[4]);
    or OR5(result[5], operandA[5], operandB[5]);
    or OR6(result[6], operandA[6], operandB[6]);
    or OR7(result[7], operandA[7], operandB[7]);
    or OR8(result[8], operandA[8], operandB[8]);
    or OR9(result[9], operandA[9], operandB[9]);
    or OR10(result[10], operandA[10], operandB[10]);
    or OR11(result[11], operandA[11], operandB[11]);
    or OR12(result[12], operandA[12], operandB[12]);
    or OR13(result[13], operandA[13], operandB[13]);
    or OR14(result[14], operandA[14], operandB[14]);
    or OR15(result[15], operandA[15], operandB[15]);
    or OR16(result[16], operandA[16], operandB[16]);
    or OR17(result[17], operandA[17], operandB[17]);
    or OR18(result[18], operandA[18], operandB[18]);
    or OR19(result[19], operandA[19], operandB[19]);
    or OR20(result[20], operandA[20], operandB[20]);
    or OR21(result[21], operandA[21], operandB[21]);
    or OR22(result[22], operandA[22], operandB[22]);
    or OR23(result[23], operandA[23], operandB[23]);
    or OR24(result[24], operandA[24], operandB[24]);
    or OR25(result[25], operandA[25], operandB[25]);
    or OR26(result[26], operandA[26], operandB[26]);
    or OR27(result[27], operandA[27], operandB[27]);
    or OR28(result[28], operandA[28], operandB[28]);
    or OR29(result[29], operandA[29], operandB[29]);
    or OR30(result[30], operandA[30], operandB[30]);
    or OR31(result[31], operandA[31], operandB[31]);

endmodule