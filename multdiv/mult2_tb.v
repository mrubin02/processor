
`timescale 1ns/100ps

module mult2_tb;
    reg clk; 
    reg signed [31:0] A, B; 
    wire signed [31:0] product; 
    wire [63:0] QCount, QP;
    wire rdy; 
    wire [2:0] ctrl;
    reg ctrl_MULT;
    wire [31:0] A_shift, A_in, A_sub; 
    wire exp; 
    mult MULT(product, A, B, clk, ctrl_MULT, rdy, exp, ctrl, QP, A_in, A_sub);

    initial begin 
        A = 1; 
        B = 2; 
        clk = 0; 
        ctrl_MULT = 1; 
        #80 
        $finish;
    end 

    always 
        #1 clk = ~clk; 

    always @(clk) begin 
        #1 
        ctrl_MULT = 0; 
        $display("ctrl: %b\nA_in: %b\nA_sub: %b\nQP:%b\nproduct: %b\nrdy: %b", ctrl, A_in, A_sub,QP, product, rdy);
        $display("A: %d, B: %d ==> product: %d", A, B, product);
    end 

endmodule 



