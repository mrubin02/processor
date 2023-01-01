module mult_overflow(data_operandA, data_operandB, result, overflow);

    input [31:0] data_operandA, data_operandB;
    input [64:0] result;
    output overflow;
    wire zero, ABpos, ABneg, ABposneg, over1, over2, over3, over4;

    and and_0(zero, !result[32], !result[31], !result[30], !result[29], !result[28], !result[27], !result[26], !result[25], !result[24], !result[23], !result[22], !result[21], !result[20], !result[19], !result[18], !result[17], !result[16], !result[15], !result[14], !result[13], !result[12], !result[11], !result[10], !result[9], !result[8], !result[7], !result[6], !result[5], !result[4], !result[3], !result[2], !result[1]);

    and and_1(ABneg, data_operandA[31], data_operandB[31]);
    and and_2(ABpos, ~data_operandA[31], ~data_operandB[31]);
    xor and_3(ABposneg, data_operandA[31], data_operandB[31]);

    and and_4(over1, ABpos, result[32]);
    and and_5(over2, ABneg, result[32]);
    and and_6(over3, ABposneg, ~result[32]);

    or or_1(over4, over1, over2, over3);
    and and_7(overflow, over4, ~zero);
    // and and_7(overflow, 1'b1, 1'b1, 1'b1);

endmodule