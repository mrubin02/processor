`include "mult.v"
`include "div.v"
`include "tri_state.v"
`include "tri_state32.v"

module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;
    wire [31:0] QN; 

    wire [31:0] A_shift, A_sub, A_in; 

    //wire [31:0] A_sub, A_shift;
    wire [63:0] QAQ, fAQ;
    wire [63:0] result2; 
    wire [2:0] ctrl; 
    wire [63:0] in; 
    wire [63:0] sQAQ; 
    wire clk0; 
    wire ovf1;
    wire [31:0] inM;

    wire [31:0] Ain, Bin; 
    wire [4:0] count; 
    wire [31:0] result_mult, result_div; 
    wire [31:0] addsub; 
    wire exp_mult, exp_div; 
    wire data_resultRDY_mult, data_resultRDY_div; 

    mult MULT1(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, result_mult, exp_mult, data_resultRDY_mult);
    div DIV1(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, result_div, exp_div, data_resultRDY_div);

    wire [31:0] data_result1; 
    wire data_exception1, data_resultRDY1; 

    tri_state32 TRI(result_mult, data_resultRDY_mult, data_result);
    tri_state TRI2(exp_mult, data_resultRDY_mult, data_exception);
    tri_state TRI3(data_resultRDY_mult, data_resultRDY_mult, data_resultRDY);

    tri_state32 TR4(result_div, data_resultRDY_div, data_result);
    tri_state TRI5(exp_div, data_resultRDY_div, data_exception);
    tri_state TRI6(data_resultRDY_div, data_resultRDY_div, data_resultRDY);

endmodule