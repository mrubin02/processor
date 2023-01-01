module reg_64 (data_out, data_in, clk, in_enable, clr);

    input [63:0] data_in;
    input clk, in_enable, clr;
    output [63:0] data_out;
    wire [63:0] tri_in;

    // Registers 0-63
    genvar i;
    generate
        for (i=0; i<64; i=i+1) begin: dffe_loop
            dffe_ref dff(.q(data_out[i]), .d(data_in[i]), .clk(clk), .en(in_enable), .clr(clr));
            // assign data_outA[i] = out_enableA ? tri_in[i] : 1'bz;
            // assign data_outB[i] = out_enableB ? tri_in[i] : 1'bz;
        end
    endgenerate

endmodule