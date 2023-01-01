module PW_latch(p_in, ir_in, p_out, ir_out, clk, enable);

    input [31:0] p_in, ir_in;
    input clk, enable;
    output [31:0] p_out, ir_out;

    wire [31:0] data_outB_p;
    wire [31:0] data_outB_ir;

    reg_32 reg_pc(p_out, data_outB_p, p_in, clk, enable, 1'b1, 1'b0, 1'b0);
    reg_32 reg_ir(ir_out, data_outB_ir, ir_in, clk, 1'b1, 1'b1, 1'b0, 1'b0);

endmodule