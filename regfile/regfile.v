`include "reg1.v"
`include "decoder32.v"

module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;

	//start code here

	wire [31:0] write_enable;
	wire [31:0] decode_RA;
	wire [31:0] decode_RB;


	decoder32 DECODE1(write_enable, ctrl_writeReg, ctrl_writeEnable);
	decoder32 DECODE2(decode_RA, ctrl_readRegA, 1'b1);
	decoder32 DECODE3(decode_RB, ctrl_readRegB, 1'b1);

	reg1 REG1(.q1(data_readRegA), .q2(data_readRegB), .d(32'b0), .clk(clock), .en(write_enable[0]), .clr(ctrl_reset), .decodeRA(decode_RA[0]), .decodeRB(decode_RB[0]));

	genvar i; 
	generate 
		for(i=1; i<32; i=i+1) begin: loop1
			reg1 REG2(.d(data_writeReg), .q1(data_readRegA), .q2(data_readRegB), .clk(clock), .clr(ctrl_reset), .en(write_enable[i]), .decodeRA(decode_RA[i]), .decodeRB(decode_RB[i]));
		end 
	endgenerate 

endmodule
