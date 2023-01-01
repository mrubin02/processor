`include "dffe_ref.v"
`include "tri_state.v"

module reg1(q1, q2, d, clk, en, clr, decodeRA, decodeRB);
   
   //Inputs
   input [31:0] d;
   input decodeRA, decodeRB; 
   input clk, en, clr;
   wire [31:0] temp;
   output [31:0] q1, q2;

   genvar i; 
	generate 
		for(i=0; i<32; i=i+1) begin: loop1 
			dffe_ref DFFE1(.q(temp[i]), .d(d[i]), .clk(clk), .en(en), .clr(clr));
         tri_state TRIA(.in(temp[i]), .oe(decodeRA), .out(q1[i]));
         tri_state TRIB(.in(temp[i]), .oe(decodeRB), .out(q2[i]));
		end 
	endgenerate  
endmodule