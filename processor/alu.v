module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    wire [31:0] data_operandB_flipped;
    wire [31:0] add_result, sub_result, and_result, or_result, sll_result, sra_result;
    wire LTover, LTno_over;    
    wire overflow_add, overflow_sub, Cout;
    wire ABsame, ARdiff, ABdiff, BRsame;

    // ADD 00000
    cla_32 ADD_CLA(data_operandA, data_operandB, 1'b0, add_result, Cout);
    xnor XNOR1(ABsame, data_operandA[31], data_operandB[31]);
    xor XOR1(ARdiff, data_operandA[31], add_result[31]);
    and AND_OVER_ADD(overflow_add, ABsame, ARdiff);

    // SUB 00001
    not_bit NOT_B(data_operandB_flipped, data_operandB);
    cla_32 SUB_CLA(data_operandA, data_operandB_flipped, 1'b1, sub_result, Cout);
    or NEQ_OR(isNotEqual, sub_result[31], sub_result[30], sub_result[29], sub_result[28], sub_result[27], sub_result[26], sub_result[25], sub_result[24], sub_result[23], sub_result[22], sub_result[21], sub_result[20], sub_result[19], sub_result[18], sub_result[17], sub_result[16], sub_result[15], sub_result[14], sub_result[13], sub_result[12], sub_result[11], sub_result[10], sub_result[9], sub_result[8], sub_result[7], sub_result[6], sub_result[5], sub_result[4], sub_result[3], sub_result[2], sub_result[1], sub_result[0]);
    assign LTno_over = sub_result[31];
    assign LTover = data_operandA[31];
    xor XOR2(ABdiff, data_operandA[31], data_operandB[31]);
    xnor XNOR2(BRsame, data_operandB[31], sub_result[31]);
    and AND_OVER_SUB(overflow_sub, ABdiff, BRsame);

    // AND 00010
    and_bit AND(and_result, data_operandA, data_operandB);

    // OR 00011
    or_bit OR(or_result, data_operandA, data_operandB);

    // SLL 00100
    lshift SLL(data_operandA, ctrl_shiftamt, sll_result);

    // SRA 00101
    rshift SRA(data_operandA, ctrl_shiftamt, sra_result);

    // ALU MUX
    mux_8 ALUOP(data_result, ctrl_ALUopcode[2:0], add_result, sub_result, and_result, or_result, sll_result, sra_result, 32'd0, 32'd0);
    mux_2_1bit MUX_OVER(overflow, ctrl_ALUopcode[0], overflow_add, overflow_sub);
    mux_2_1bit MUX_LT(isLessThan, overflow, LTno_over, LTover);

endmodule