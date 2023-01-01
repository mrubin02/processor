module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire [31:0] data_result_mult, data_result_div;
    wire data_resultRDY_mult, data_resultRDY_div, data_exception_mult, data_exception_div, mult_set, div_set;

    mult mult_1(data_operandA, data_operandB, clock, ctrl_MULT, data_result_mult, data_exception_mult, data_resultRDY_mult);
    div div_1(data_operandA, data_operandB, clock, ctrl_DIV, data_result_div, data_exception_div, data_resultRDY_div);

    sr sr_mult(ctrl_MULT, ctrl_DIV, mult_set);
    sr sr_div(ctrl_DIV, ctrl_MULT, div_set);
    assign data_result = mult_set ? data_result_mult : data_result_div;
    assign data_resultRDY = mult_set ? data_resultRDY_mult : data_resultRDY_div;
    assign data_exception = mult_set ? data_exception_mult : data_exception_div;

endmodule