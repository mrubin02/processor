`timescale 1ns / 1ps 
/**
 * 
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor, 
 * RegFile and Memory elements together.
 *
 * This file will be used to generate the bitstream to upload to the FPGA.
 * We have provided a sibling file, Wrapper_tb.v so that you can test your processor's functionality.
 * 
 * We will be using our own separate Wrapper_tb.v to test your code. You are allowed to make changes to the Wrapper files 
 * for your own individual testing, but we expect your final processor.v and memory modules to work with the 
 * provided Wrapper interface.
 * 
 * Refer to Lab 5 documents for detailed instructions on how to interface 
 * with the memory elements. Each imem and dmem modules will take 12-bit 
 * addresses and will allow for storing of 32-bit values at each address. 
 * Each memory module should receive a single clock. At which edges, is 
 * purely a design choice (and thereby up to you). 
 * 
 * You must change line 36 to add the memory file of the test you created using the assembler
 * For example, you would add sample inside of the quotes on line 38 after assembling sample.s
 *
 **/

module Wrapper (clock, reset, dance1, dance2, off, ledr, ledl, led3, signal, signalcont, signal2, signal3, signal4);
	input reset, dance1, dance2, off;
	input clock; 
    output ledr,ledl,led3;
    output signal, signal2, signal3, signal4, signalcont;
    
    assign signal = PWM; 
    assign signalcont = PWM2;
    assign signal2 = PWM3; 
	assign signal3 = PWM4; 
	assign signal4 = PWM5; 
    wire PWM, PWM2, PWM3, PWM4, PWM5;
    assign ledr = ledright[0];
    assign ledl = ledleft[0]; 
    
    assign led3 = off ? 32'b1 : 32'b0;
    
    wire [31:0] ledright, ledleft; 
    
	wire rwe, mwe; 
	wire[4:0] rd, rs1, rs2;
	wire[31:0] instAddr, instData, 
	    rData, regA, regB,
		memAddr, memDataIn, memDataOut;
    // assign led = rData[0];
	//dffe_ref led_latch(led, rData[0], clock, led, 1'b0);

	// Adjust clock
	reg clk1MHz = 0;
	reg[17:0] counter = 0;
	reg CounterLimit = 49;
	always @(posedge clock) begin
		if(counter < CounterLimit)
			counter <= counter + 1;
		else begin
			counter <= 0;
			clk1MHz <= ~clk1MHz;
		end
	end

	// ADD YOUR MEMORY FILE HERE
	localparam INSTR_FILE = "test";
	
	//wire [31:0] angle = ledr & ledl ? 9'd0 : ledr ? QA + 9'd1 : ledl ? QA-9'd1 : QA; 
	wire [31:0] pulse_width_std, pulse_width_std2,  pulse_width_std3,  pulse_width_std4, pulse_width_cont; 
	wire [31:0] QA, QA2, QA3, QA4, QA5; 
	Servo_interface servo(reset, QA,  clock, PWM); 
	Servo_interface servo2(reset, QA3,  clock, PWM3); 
	Servo_interface servo3(reset, QA4,  clock, PWM4); 
	Servo_interface servo4(reset, QA5,  clock, PWM5); 
	Servo_interface servocont(reset, QA2, clock, PWM2); 
	dff32 SERVO(QA, pulse_width_std, clock, 1'b1, reset); 
	dff32 SERVO3(QA3, pulse_width_std2, clock, 1'b1, reset); 
	dff32 SERVO4(QA4, pulse_width_std3, clock, 1'b1, reset); 
	dff32 SERVO5(QA5, pulse_width_std4, clock, 1'b1, reset); 
	dff32 SERVO2(QA2, pulse_width_cont, clock, 1'b1, reset); 
	
	
	// Main Processing Unit
	processor CPU(.clock(clk1MHz), .reset(reset), 
								
		// ROM
		.address_imem(instAddr), .q_imem(instData),
									
		// Regfile
		.ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB),
									
		// RAM
		.wren(mwe), .address_dmem(memAddr), 
		.data(memDataIn), .q_dmem(memDataOut)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({INSTR_FILE, ".mem"}))
	InstMem(.clk(clk1MHz), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));
	
	// Register File
	regfile RegisterFile(.clock(clk1MHz), 
		.ctrl_writeEnable(rwe), .ctrl_reset(reset), 
		.ctrl_writeReg(rd),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB), .dance1(dance1), .dance2(dance2), .ledr(ledright), .ledl(ledleft), .off(off), .pulse_width_std(pulse_width_std), .pulse_width_std2(pulse_width_std2), .pulse_width_std3(pulse_width_std3), .pulse_width_std4(pulse_width_std4), .pulse_width_cont(pulse_width_cont));
						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clk1MHz), 
		.wEn(mwe), 
		.addr(memAddr[11:0]), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut));
    
    ila_0 debuggers(.clk(clk1MHz), .probe0(off), .probe1(led), .probe2(regA), .probe3(regB), .probe4(rData), .probe5(rs1), .probe6(rs2));
endmodule

