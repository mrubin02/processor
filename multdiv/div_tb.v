`timescale 1ns/100ps

module mult_tb;
    reg [31:0] operandA, operandB;
    wire [31:0] result, addsub, Ain, Bin, inM; 
    reg ctrl_Mult, ctrl_Div, clock; 
    wire except, ready; 
    wire [63:0] QAQ, sQAQ; 

    //multdiv MULT1(A, B, ctrl_MULT, clk, result, exception, rdy, A_in, result2, ctrl, A_shift, count, clk0);
    multdiv tester(operandA, operandB, ctrl_Mult, ctrl_Div, clock, result, except, ready, QAQ, sQAQ, addsub, Ain, Bin, inM);

    initial begin 
        clock = 1'b0;
        operandA = 7; 
        operandB = 3; 
        ctrl_Div = 1;
        ctrl_Mult = 0; 
        #40
        $finish;
    end 

    always 
        #1 clock = ~clock; 
    always 
        ctrl_Div 

    always @(clock) begin 
        #1
        ctrl_Div = 0;
        //$display("count", count);
        $display("rdy: %b, QAQ: %b, Ain: %d, Bin: %d, addsub: %d\n        inM: %b", ready, QAQ, Ain, Bin, addsub, inM);
    end 

endmodule 