module dff32(q,d,clk,en,clr); 
	input [31:0] d; 
	input clk, en, clr; 
	wire [31:0] temp; 
	output [31:0] q; 

	genvar i; 
	generate 
		for(i=0; i<31; i=i+1) begin: loop1
			dffe_ref DFFE1(.q(q[i]), .d(d[i]), .clk(clk), .en(en), .clr(clr));
		end 
	endgenerate 
endmodule