module cla_32(A, B, Cin, S, Cout);
    input [31:0] A, B;
    input Cin;
    output [31:0] S;
    output Cout;
    wire G0, G1, G2, G3, P0, P1, P2, P3, c8, c16, c24;
    wire w8, w16a, w16b, w24a, w24b, w24c, w32a, w32b, w32c, w32d;

    // Block 0
    cla_8 cla0(.A(A[7:0]), .B(B[7:0]), .Cin(Cin), .S(S[7:0]), .G(G0), .P(P0));
    and and_c8(w8, P0, Cin);
    or or_c8(c8, G0, w8);

    // Block 1
    cla_8 cla1(.A(A[15:8]), .B(B[15:8]), .Cin(c8), .S(S[15:8]), .G(G1), .P(P1));
    and and_c16a(w16a, P1, G0);
    and and_c16b(w16b, P1, P0, Cin);
    or or_c16(c16, G1, w16a, w16b);
    
    // Block 2
    cla_8 cla2(.A(A[23:16]), .B(B[23:16]), .Cin(c16), .S(S[23:16]), .G(G2), .P(P2));
    and and_c24a(w24a, P2, G1);
    and and_c24b(w24b, P2, P1, G0);
    and and_c24c(w24c, P2, P1, P0, Cin);
    or or_c24(c24, G2, w24a, w24b, w24c);
   
    // Block 3
    cla_8 cla3(.A(A[31:24]), .B(B[31:24]), .Cin(c24), .S(S[31:24]), .G(G3), .P(P3));
    and and_c32a(w32a, P3, G2);
    and and_c32b(w32b, P3, P2, G1);
    and and_c32c(w32c, P3, P2, P1, G0);
    and and_c32d(w32d, P3, P2, P1, P0, Cin);
    or or_c32(Cout, G3, w32a, w32b, w32c, w32d);

endmodule