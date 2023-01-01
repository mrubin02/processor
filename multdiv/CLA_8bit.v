`include "G.v" 
`include "P.v"
`include "bit_adder8.v"

module CLA_8bit(P, G, S, A, B, Cin); 
    input [7:0] A, B;
    input Cin; 
    wire w1, w2, w3, w4, w5, w6, w7, w8, c0;
    wire [7:0] Cout;
    output [7:0] S;
    output P, G;

    wire [7:0] p, g;

    P getP(p, A, B);
    G getG(g, A, B);
    
    and AND1(P, p[7], p[6], p[5], p[4], p[3], p[2], p[1], p[0]);
    and AND3(w1, p[7], p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
    and AND4(w2, p[7], p[6], p[5], p[4], p[3], p[2], g[1]);
    and AND5(w3, p[7], p[6], p[5], p[4], p[3], g[2]);
    and AND6(w4, p[7], p[6], p[5], p[4], g[3]);
    and AND7(w5, p[7], p[6], p[5], g[4]);
    and AND8(w6, p[7], p[6], g[5]);
    and AND9(w7, p[7], g[6]);
    or OR1(G, g[7], w1, w2, w3, w4, w5, w6, w7);

    bit_adder8 ADD1(S, Cout, A, B, Cin, p, g);

endmodule 



    
