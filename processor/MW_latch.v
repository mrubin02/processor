module MW_latch(o_in, d_in, ir_in, o_out, d_out, ir_out, clk);

    input [31:0] o_in, d_in, ir_in;
    input clk;
    output [31:0] o_out, d_out, ir_out;

    wire [31:0] data_outB_o;
    wire [31:0] data_outB_d;
    wire [31:0] data_outB_ir;

    reg_32 reg_pc(o_out, data_outB_o, o_in, clk, 1'b1, 1'b1, 1'b0, 1'b0);
    reg_32 reg_b(d_out, data_outB_d, d_in, clk, 1'b1, 1'b1, 1'b0, 1'b0);
    reg_32 reg_ir(ir_out, data_outB_ir, ir_in, clk, 1'b1, 1'b1, 1'b0, 1'b0);

endmodule