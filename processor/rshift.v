module rshift(operand, shift_amt, result);
    input [31:0] operand;
    input [4:0] shift_amt;
    output [31:0] result;
    wire [31:0] in161, res161, in81, res81, in41, res41, in21, res21, in11;
    wire [31:0] in160, res160, in80, res80, in40, res40, in20, res20, in10;
    wire [31:0] result1, result0;

    // MSB = 1
    assign in161 = {16'b1111111111111111, operand[31:16]};
    mux_2 MUX161(res161, shift_amt[4], operand, in161);

    assign in81 = {8'b11111111, res161[31:8]};
    mux_2 MUX81(res81, shift_amt[3], res161, in81);

    assign in41 = {4'b1111, res81[31:4]};
    mux_2 MUX41(res41, shift_amt[2], res81, in41);

    assign in21 = {2'b11, res41[31:2]};
    mux_2 MUX21(res21, shift_amt[1], res41, in21);

    assign in11 = {1'b1, res21[31:1]};
    mux_2 MUX11(result1, shift_amt[0], res21, in11);

    // MSB = 0
    assign in160 = {16'd0, operand[31:16]};
    mux_2 MUX160(res160, shift_amt[4], operand, in160);

    assign in80 = {8'd0, res160[31:8]};
    mux_2 MUX80(res80, shift_amt[3], res160, in80);

    assign in40 = {4'd0, res80[31:4]};
    mux_2 MUX40(res40, shift_amt[2], res80, in40);

    assign in20 = {2'd0, res40[31:2]};
    mux_2 MUX20(res20, shift_amt[1], res40, in20);

    assign in10 = {1'd0, res20[31:1]};
    mux_2 MUX10(result0, shift_amt[0], res20, in10);

    // Select correct shift result based on MSB
    mux_2 MUX_final(result, operand[31], result0, result1);

endmodule