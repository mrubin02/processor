`include "tff.v"

module counter(count, clk, rs, start);
    output [4:0] count; 
    input clk, rs, start; 

    wire Q0, Q1, Q2, Q3, Q4;
    wire nQ0, nQ1, nQ2, nQ3, nQ4;
    wire in2, in3, in4; 
    wire reset; 

    and AND1(in2, Q0, Q1); 
    and AND2(in3, Q0, Q1, Q2); 
    and AND3(in4, Q0, Q1, Q2, Q3); 

    tff TFF1(Q0, nQ0, 1'b1, clk, reset);
    tff TFF2(Q1, nQ1, Q0, clk, reset);
    tff TFF3(Q2, nQ2, in2, clk, reset);
    tff TFF4(Q3, nQ3, in3, clk, reset);
    tff TFF5(Q4, nQ4, in4, clk, reset);

    assign count = {Q4, Q3, Q2, Q1,Q0};

    assign reset = !start ? 1 : rs;

endmodule 





