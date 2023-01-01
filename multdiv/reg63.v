
`include "dffe_ref.v"
module reg63(q, d, clk, en, clr); 
   //Inputs
   input [63:0] d;
   input clk, en, clr;
   wire [63:0] temp;
   output [63:0] q;

   genvar i; 
	generate 
		for(i=0; i<64; i=i+1) begin: loop1 
			dffe_ref DFFE1(.q(q[i]), .d(d[i]), .clk(clk), .en(en), .clr(clr)); 
		end 
	endgenerate  

endmodule