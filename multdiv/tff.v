`include "reg1.v"

module tff(Q, nQ, T, clk, clr); 
    input T, clk, clr; 
    output Q, nQ; 
    wire o1, o2, D; 

    assign nQ = !Q;

    reg1 REG1(Q, D, clk, 1'b1, clr);

    and AND1(o1, !T, Q);
    and AND2(o2, T, nQ);
    or OR1(D, o1, o2);
    
endmodule

