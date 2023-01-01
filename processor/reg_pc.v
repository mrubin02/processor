module reg_pc (data_outA, data_in, out_enable, in_enable, clk, clr);

    input [31:0] data_in;
    input clk, out_enable, in_enable, clr;
    output [31:0] data_outA;
    wire [31:0] tri_in;

    // DFFs 0-31
    genvar i;
    generate
        for (i=0; i<32; i=i+1) begin: dffe_loop
            dffe_ref dff(.q(tri_in[i]), .d(data_in[i]), .clk(clk), .en(in_enable), .clr(clr));
            assign data_outA[i] = out_enable ? tri_in[i] : 1'bz;
        end
    endgenerate

endmodule