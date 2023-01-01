module DP_latch(a_in, b_in, ir_in, a_out, b_out, ir_out, clk, enable);

    input [31:0] a_in, b_in, ir_in;
    input clk, enable;
    output [31:0] a_out, b_out, ir_out;

    wire [31:0] data_outB_a;
    wire [31:0] data_outB_b;
    wire [31:0] data_outB_ir;

    reg_32 reg_a(a_out, data_outB_a, a_in, clk, enable, 1'b1, 1'b0, 1'b0);
    reg_32 reg_b(b_out, data_outB_b, b_in, clk, enable, 1'b1, 1'b0, 1'b0);
    reg_32 reg_ir(ir_out, data_outB_ir, ir_in, clk, enable, 1'b1, 1'b0, 1'b0);

endmodule