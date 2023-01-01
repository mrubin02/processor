module FD_latch(pc_in, ir_in, pc_out, ir_out, clk, enable);

    input [31:0] pc_in, ir_in;
    input clk, enable;
    output [31:0] pc_out, ir_out;

    wire [31:0] data_outB_pc;
    wire [31:0] data_outB_ir;

    reg_32 reg_pc(pc_out, data_outB_pc, pc_in, clk, enable, 1'b1, 1'b0, 1'b0);
    reg_32 reg_ir(ir_out, data_outB_ir, ir_in, clk, enable, 1'b1, 1'b0, 1'b0);

endmodule