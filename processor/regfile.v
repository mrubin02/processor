module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB, dance1, dance2, ledr, ledl, off, pulse_width_cont, pulse_width_std, pulse_width_std2,  pulse_width_std3, pulse_width_std4
);

	input clock, ctrl_writeEnable, ctrl_reset, off;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;
	input dance1, dance2; 

	output [31:0] data_readRegA, data_readRegB, ledr, ledl, pulse_width_cont, pulse_width_std, pulse_width_std2, pulse_width_std3, pulse_width_std4;

	wire [31:0] reg_en;
	wire [31:0] out_enableA, out_enableB, button_inr, button_inl;

	// add your code here
	assign reg_en = ctrl_writeEnable << ctrl_writeReg;
	assign out_enableA = 1'b1 << ctrl_readRegA;
	assign out_enableB = 1'b1 << ctrl_readRegB;
    assign button_inr = dance1 ? 32'b1 : 32'b0;
    assign button_inl = dance2 ? 32'b1 : 32'b0; 
    assign off_in = off ? 32'b1 : 32'b0;
    
	reg_32 reg0(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[0]), .out_enableA(out_enableA[0]), .out_enableB(out_enableB[0]), .clr(ctrl_reset));
	reg_32 reg1(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(button_inr), .clk(~clock), .in_enable(1'b1), .out_enableA(out_enableA[1]), .out_enableB(out_enableB[1]), .clr(ctrl_reset));
	reg_32 reg2(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(button_inl), .clk(~clock), .in_enable(1'b1), .out_enableA(out_enableA[2]), .out_enableB(out_enableB[2]), .clr(ctrl_reset));
	reg_32 reg3(.data_outA(pulse_width_std), .data_outB(pulse_width_std), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[3]), .out_enableA(1'b1), .out_enableB(1'b1), .clr(ctrl_reset));
	reg_32 reg4(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[4]), .out_enableA(out_enableA[4]), .out_enableB(out_enableB[4]), .clr(ctrl_reset));
	reg_32 reg5(.data_outA(ledr), .data_outB(ledr), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[5]), .out_enableA(1'b1), .out_enableB(1'b1), .clr(ctrl_reset));
	reg_32 reg6(.data_outA(ledl), .data_outB(ledl), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[6]), .out_enableA(1'b1), .out_enableB(1'b1), .clr(ctrl_reset));
	reg_32 reg7(.data_outA(pulse_width_cont), .data_outB(pulse_width_cont), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[7]), .out_enableA(1'b1), .out_enableB(1'b1), .clr(ctrl_reset));
	reg_32 reg8(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(off_in), .clk(~clock), .in_enable(1'b1), .out_enableA(out_enableA[8]), .out_enableB(out_enableB[8]), .clr(ctrl_reset));
	reg_32 reg9(.data_outA(pulse_width_std2), .data_outB(pulse_width_std2), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[9]), .out_enableA(1'b1), .out_enableB(1'b1), .clr(ctrl_reset));
	reg_32 reg10(.data_outA(pulse_width_std3), .data_outB(pulse_width_std3), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[10]), .out_enableA(1'b1), .out_enableB(1'b1), .clr(ctrl_reset));
	reg_32 reg11(.data_outA(pulse_width_std4), .data_outB(pulse_width_std4), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[11]), .out_enableA(1'b1), .out_enableB(1'b1), .clr(ctrl_reset));
	reg_32 reg12(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[12]), .out_enableA(out_enableA[12]), .out_enableB(out_enableB[12]), .clr(ctrl_reset));
	reg_32 reg13(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[13]), .out_enableA(out_enableA[13]), .out_enableB(out_enableB[13]), .clr(ctrl_reset));
	reg_32 reg14(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[14]), .out_enableA(out_enableA[14]), .out_enableB(out_enableB[14]), .clr(ctrl_reset));
	reg_32 reg15(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[15]), .out_enableA(out_enableA[15]), .out_enableB(out_enableB[15]), .clr(ctrl_reset));
	reg_32 reg16(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[16]), .out_enableA(out_enableA[16]), .out_enableB(out_enableB[16]), .clr(ctrl_reset));
	reg_32 reg17(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[17]), .out_enableA(out_enableA[17]), .out_enableB(out_enableB[17]), .clr(ctrl_reset));
	reg_32 reg18(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[18]), .out_enableA(out_enableA[18]), .out_enableB(out_enableB[18]), .clr(ctrl_reset));
	reg_32 reg19(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[19]), .out_enableA(out_enableA[19]), .out_enableB(out_enableB[19]), .clr(ctrl_reset));
	reg_32 reg20(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[20]), .out_enableA(out_enableA[20]), .out_enableB(out_enableB[20]), .clr(ctrl_reset));
	reg_32 reg21(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[21]), .out_enableA(out_enableA[21]), .out_enableB(out_enableB[21]), .clr(ctrl_reset));
	reg_32 reg22(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[22]), .out_enableA(out_enableA[22]), .out_enableB(out_enableB[22]), .clr(ctrl_reset));
	reg_32 reg23(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[23]), .out_enableA(out_enableA[23]), .out_enableB(out_enableB[23]), .clr(ctrl_reset));
	reg_32 reg24(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[24]), .out_enableA(out_enableA[24]), .out_enableB(out_enableB[24]), .clr(ctrl_reset));
	reg_32 reg25(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[25]), .out_enableA(out_enableA[25]), .out_enableB(out_enableB[25]), .clr(ctrl_reset));
	reg_32 reg26(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[26]), .out_enableA(out_enableA[26]), .out_enableB(out_enableB[26]), .clr(ctrl_reset));
	reg_32 reg27(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[27]), .out_enableA(out_enableA[27]), .out_enableB(out_enableB[27]), .clr(ctrl_reset));
	reg_32 reg28(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[28]), .out_enableA(out_enableA[28]), .out_enableB(out_enableB[28]), .clr(ctrl_reset));
	reg_32 reg29(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[29]), .out_enableA(out_enableA[29]), .out_enableB(out_enableB[29]), .clr(ctrl_reset));
	reg_32 reg30(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[30]), .out_enableA(out_enableA[30]), .out_enableB(out_enableB[30]), .clr(ctrl_reset));
	reg_32 reg31(.data_outA(data_readRegA), .data_outB(data_readRegB), .data_in(data_writeReg), .clk(~clock), .in_enable(reg_en[31]), .out_enableA(out_enableA[31]), .out_enableB(out_enableB[31]), .clr(ctrl_reset));

    ila_reg debuggers(.clk(clock), .probe0(button), .probe1(button_in));

endmodule
