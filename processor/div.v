module div(
	data_operandA, data_operandB, clock, ctr_rst,
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input clock, ctr_rst;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire signed [63:0] AQ_rd, AQ_wr, AQ_init, AQ_temp;
    wire [31:0] cla_result_rd, cla_result_wr, M, opA_signed, opB_signed, pos_A, pos_B, flip_quotient, flip_remainder, remainder_result, quot_xnor;
    wire finish_cyc, init_cyc, sec_cycle, Cout, sub_op, one_neg, CoutA, CoutB, CoutQ, CoutR, quot_match, zero_quot, div_overflow;

    // take care of signs for operands
    cla_32 flip_A(~data_operandA, 32'b1, 1'b0, pos_A, CoutA);
    cla_32 flip_B(~data_operandB, 32'b1, 1'b0, pos_B, CoutB);
    assign opA_signed = data_operandA[31] ? pos_A : data_operandA;
    assign opB_signed = data_operandB[31] ? pos_B : data_operandB;

    assign AQ_init = {32'b0, opA_signed};
    div_control div_ctrl(AQ_rd[63:32], clock, ctr_rst, finish_cyc, init_cyc, sec_cycle);
    reg_32_div result_reg(cla_result_rd, cla_result_wr, clock, 1'b1, 1'b0);
    reg_64 AQ_reg(AQ_rd, AQ_wr, clock, 1'b1, 1'b0);

    assign M = sec_cycle ? ~opB_signed : ~cla_result_rd[31] ? ~opB_signed : opB_signed;
    assign sub_op = sec_cycle ? 1'b1 : ~cla_result_rd[31];
    cla_32 sub_1(AQ_rd[63:32], M, sub_op, cla_result_wr, Cout);
    assign AQ_temp = {cla_result_wr[31:0], AQ_rd[31:1], ~cla_result_wr[31]};
    assign AQ_wr = init_cyc ? (AQ_init << 1) : finish_cyc ? AQ_temp : (AQ_temp << 1);

    // final assigns when cycle is finished
    cla_32 flip_quot(~AQ_wr[31:0], 32'b1, 1'b0, flip_quotient, CoutQ);
    xor xor_sign(one_neg, data_operandA[31], data_operandB[31]);
    // assign data_result = one_neg ? flip_quotient : AQ_wr[31] ? flip_quotient : AQ_wr[31:0];
    assign data_result = !data_operandB ? 32'b0 : one_neg ? flip_quotient : AQ_wr[31] ? flip_quotient : AQ_wr[31:0];
    cla_32 flip_rem(~AQ_wr[63:32], 32'b1, 1'b0, flip_remainder, CoutR);
    assign remainder_result = data_operandA[31] ? flip_remainder : AQ_wr[63:32];
    assign quot_xnor = AQ_wr[31:0] ~^ flip_quotient;
    and div_over1_and(quot_match, quot_xnor[31], quot_xnor[30], quot_xnor[29], quot_xnor[28], quot_xnor[27], quot_xnor[26], quot_xnor[25], quot_xnor[24], quot_xnor[23], quot_xnor[22], quot_xnor[21], quot_xnor[20], quot_xnor[19], quot_xnor[18], quot_xnor[17], quot_xnor[16], quot_xnor[15], quot_xnor[14], quot_xnor[13], quot_xnor[12], quot_xnor[11], quot_xnor[10], quot_xnor[9], quot_xnor[8], quot_xnor[7], quot_xnor[6], quot_xnor[5], quot_xnor[4], quot_xnor[3], quot_xnor[2], quot_xnor[1], quot_xnor[0]);
    and div_over2_and(zero_quot, !AQ_wr[31], !AQ_wr[30], !AQ_wr[29], !AQ_wr[28], !AQ_wr[27], !AQ_wr[26], !AQ_wr[25], !AQ_wr[24], !AQ_wr[23], !AQ_wr[22], !AQ_wr[21], !AQ_wr[20], !AQ_wr[19], !AQ_wr[18], !AQ_wr[17], !AQ_wr[16], !AQ_wr[15], !AQ_wr[14], !AQ_wr[13], !AQ_wr[12], !AQ_wr[11], !AQ_wr[10], !AQ_wr[9], !AQ_wr[8], !AQ_wr[7], !AQ_wr[6], !AQ_wr[5], !AQ_wr[4], !AQ_wr[3], !AQ_wr[2], !AQ_wr[1], !AQ_wr[0]);
    assign div_overflow = zero_quot ? 1'b0 : quot_match;
    assign data_exception = finish_cyc ? (!data_operandB || div_overflow) : 1'b0;
    assign data_resultRDY = finish_cyc;

endmodule