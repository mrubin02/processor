module PC_latch(pc_in, pc_out, clk);

    input [31:0] pc_in;
    input clk;
    output [31:0] pc_out;

    wire [31:0] data_outB;

    reg_32 reg_pc(pc_out, data_outB, pc_in, clk, 1'b1, 1'b1, 1'b0, 1'b0);

endmodule