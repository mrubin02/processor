`include "full_adder.v"

module bit_adder8(S, Cout, A, B, c0, p, g); 
    input [7:0] A, B;
    input c0;
    input [7:0] p, g;
    output [7:0] S, Cout; 
    wire c1, c2, c3, c4, c5, c6, c7, c8;
    wire temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15;


    and AND0(temp0, p[0], c0);
    or OR0(c1, g[0], temp0);

    and AND1(temp1, p[1], c1);
    or OR1(c2, g[1], temp1);

    and AND2(temp2, p[2], c2);
    or OR2(c3, g[2], temp2);

    and AND3(temp3, p[3], c3);
    or OR3(c4, g[3], temp3);

    and AND4(temp4, p[4], c4);
    or OR4(c5, g[4], temp4);

    and AND5(temp5, p[5], c5);
    or OR5(c6, g[5], temp5);

    and AND6(temp6, p[6], c6);
    or OR6(c7, g[6], temp6);

    and AND7(temp7, p[7], c7);
    or OR7(c8, g[7], temp7);


    full_adder ADD0(S[0], temp8, A[0], B[0], c0);
    full_adder ADD1(S[1], temp9, A[1], B[1], c1);
    full_adder ADD2(S[2], temp10, A[2], B[2], c2);
    full_adder ADD3(S[3], temp11, A[3], B[3], c3);
    full_adder ADD4(S[4], temp12, A[4], B[4], c4);
    full_adder ADD5(S[5], temp13, A[5], B[5], c5);
    full_adder ADD6(S[6], temp14, A[6], B[6], c6);
    full_adder ADD7(S[7], temp15, A[7], B[7], c7);

endmodule 