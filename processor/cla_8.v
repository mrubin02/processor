module cla_8(A, B, Cin, S, G, P);
    input [7:0] A, B;
    input Cin;
    output [7:0] S;
    output G, P;
    wire g0, g1, g2, g3, g4, g5, g6, g7;
    wire p0, p1, p2, p3, p4, p5, p6, p7;
    wire c1, c2, c3, c4, c5, c6, c7;
    wire w0, w1a, w1b, w2a, w2b, w2c, w3a, w3b, w3c, w3d, w4a, w4b, w4c, w4d, w4e, w5a, w5b, w5c, w5d, w5e, w5f, w6a, w6b, w6c, w6d, w6e, w6f, w6g, w7a, w7b, w7c, w7d, w7e, w7f, w7g, w7h;

    // Block 0
    xor xor_s0(S[0], A[0], B[0], Cin);
    and and_g0(g0, A[0], B[0]);
    or or_p0(p0, A[0], B[0]);
    and and_c1(w0, p0, Cin);
    or or_c1(c1, w0, g0);

    // Block 1
    xor xor_s1(S[1], A[1], B[1], c1);
    and and_g1(g1, A[1], B[1]);
    or or_p1(p1, A[1], B[1]);
    and and_c2a(w1a, p1, g0);
    and and_c2b(w1b, p1, p0, Cin);
    or or_c2(c2, g1, w1a, w1b);

    // Block 2
    xor xor_s2(S[2], A[2], B[2], c2);
    and and_g2(g2, A[2], B[2]);
    or or_p2(p2, A[2], B[2]);
    and and_c3a(w2a, p2, g1);
    and and_c3b(w2b, p2, p1, g0);
    and and_c3c(w2c, p2, p1, p0, Cin);
    or or_c3(c3, g2, w2a, w2b, w2c);

    // Block 3
    xor xor_s3(S[3], A[3], B[3], c3);
    and and_g3(g3, A[3], B[3]);
    or or_p3(p3, A[3], B[3]);
    and and_c4a(w3a, p3, g2);
    and and_c4b(w3b, p3, p2, g1);
    and and_c4c(w3c, p3, p2, p1, g0);
    and and_c4d(w3d, p3, p2, p1, p0, Cin);
    or or_c4(c4, g3, w3a, w3b, w3c, w3d);

    // Block 4
    xor xor_s4(S[4], A[4], B[4], c4);
    and and_g4(g4, A[4], B[4]);
    or or_p4(p4, A[4], B[4]);
    and and_c5a(w4a, p4, g3);
    and and_c5b(w4b, p4, p3, g2);
    and and_c5c(w4c, p4, p3, p2, g1);
    and and_c5d(w4d, p4, p3, p2, p1, g0);
    and and_c5e(w4e, p4, p3, p2, p1, p0, Cin);
    or or_c5(c5, g4, w4a, w4b, w4c, w4d, w4e);

    // Block 5
    xor xor_s5(S[5], A[5], B[5], c5);
    and and_g5(g5, A[5], B[5]);
    or or_p5(p5, A[5], B[5]);
    and and_c6a(w5a, p5, g4);
    and and_c6b(w5b, p5, p4, g3);
    and and_c6c(w5c, p5, p4, p3, g2);
    and and_c6d(w5d, p5, p4, p3, p2, g1);
    and and_c6e(w5e, p5, p4, p3, p2, p1, g0);
    and and_c6f(w5f, p5, p4, p3, p2, p1, p0, Cin);
    or or_c6(c6, g5, w5a, w5b, w5c, w5d, w5e, w5f);

    // Block 6
    xor xor_s6(S[6], A[6], B[6], c6);
    and and_g6(g6, A[6], B[6]);
    or or_p6(p6, A[6], B[6]);
    and and_c7a(w6a, p6, g5);
    and and_c7b(w6b, p6, p5, g4);
    and and_c7c(w6c, p6, p5, p4, g3);
    and and_c7d(w6d, p6, p5, p4, p3, g2);
    and and_c7e(w6e, p6, p5, p4, p3, p2, g1);
    and and_c7f(w6f, p6, p5, p4, p3, p2, p1, g0);
    and and_c7g(w6g, p6, p5, p4, p3, p2, p1, p0, Cin);
    or or_c7(c7, g6, w6a, w6b, w6c, w6d, w6e, w6f, w6g);

    // Block 7
    xor xor_s7(S[7], A[7], B[7], c7);
    and and_g7(g7, A[7], B[7]);
    or or_p7(p7, A[7], B[7]);
    and and_c8a(w7a, p7, g6);
    and and_c8b(w7b, p7, p6, g5);
    and and_c8c(w7c, p7, p6, p5, g4);
    and and_c8d(w7d, p7, p6, p5, p4, g3);
    and and_c8e(w7e, p7, p6, p5, p4, p3, g2);
    and and_c8f(w7f, p7, p6, p5, p4, p3, p2, g1);
    and and_c8g(w7g, p7, p6, p5, p4, p3, p2, p1, g0);
    and and_P(P, p7, p6, p5, p4, p3, p2, p1, p0);
    or or_G(G, g7, w7a, w7b, w7c, w7d, w7e, w7f, w7g);

endmodule