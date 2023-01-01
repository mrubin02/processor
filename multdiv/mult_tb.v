`timescale 1ns/100ps

module mult_tb;
    reg clk; 
    wire [4:0] count; 
    wire signed [31:0] result;
    wire exception, rdy, Qrdy;
    reg ctrl_MULT;
    reg signed [31:0] A, B;
    wire [31:0] A_in; 
    wire [31:0] Aout, Bout; 
    wire [63:0] result2; 
    wire [2:0] ctrl;  
    wire [31:0] A_shift; 
    wire clk0;
    wire ovf1; 
    //multdiv MULT1(A, B, ctrl_MULT, clk, result, exception, rdy, A_in, result2, ctrl, A_shift, count, clk0);
    multdiv MULT1(A, B, ctrl_MULT, 1'b0, clk, result, exception, rdy, result2, ovf1);

    initial begin 
        clk = 1'b0;
        A = -1; 
        B = -1; 
        ctrl_MULT = 1;
        #40
        $finish;
    end 

    always 
        #1 clk = ~clk; 
    always
        #10 ctrl_MULT = ~ctrl_MULT;

    always @(clk) begin 
        #1
        ctrl_MULT = 0; 
        //$display("count", count);
        $display("A: %d, B:%d ==> result: %d, result2: %b, ovf: %b, ovf1: %b", A, B, result, result2, exception, ovf1);
    end 

endmodule 
        

    

