
module reg1(q, d, clk, en, clr); 
   //Inputs
   input d;
   input clk, en, clr;
   wire temp;
   output q;

   genvar i; 
	generate 
		for(i=0; i<1; i=i+1) begin: loop1 
			dffe_ref DFFE1(.q(q), .d(d), .clk(clk), .en(en), .clr(clr)); 
		end 
	endgenerate  

endmodule