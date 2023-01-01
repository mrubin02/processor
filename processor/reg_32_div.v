module reg_32_div (data_out, data_in, clk, in_enable, clr);

    input [31:0] data_in;
    input clk, in_enable, clr;
    output [31:0] data_out;
    wire [31:0] tri_in;

    // Registers 0-31
    genvar i;
    generate
        for (i=0; i<32; i=i+1) begin: dffe_loop
            dffe_ref dff(.q(data_out[i]), .d(data_in[i]), .clk(clk), .en(in_enable), .clr(clr));
            // assign data_outA[i] = out_enableA ? tri_in[i] : 1'bz;
            // assign data_outB[i] = out_enableB ? tri_in[i] : 1'bz;
        end
    endgenerate

endmodule