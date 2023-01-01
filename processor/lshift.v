module lshift(operand, shift_amt, result);
    input [31:0] operand;
    input [4:0] shift_amt;
    output [31:0] result;
    wire [31:0] in16, res16, in8, res8, in4, res4, in2, res2, in1;

    assign in16 = {operand[15:0], 16'd0};
    mux_2 MUX16(res16, shift_amt[4], operand, in16);

    assign in8 = {res16[23:0], 8'd0};
    mux_2 MUX8(res8, shift_amt[3], res16, in8);

    assign in4 = {res8[27:0], 4'd0};
    mux_2 MUX4(res4, shift_amt[2], res8, in4);

    assign in2 = {res4[29:0], 2'd0};
    mux_2 MUX2(res2, shift_amt[1], res4, in2);

    assign in1 = {res2[30:0], 1'd0};
    mux_2 MUX1(result, shift_amt[0], res2, in1);

endmodule