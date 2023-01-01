module two_bit_comparator(EQi, GTi, EQi2, GTi2, A, B);

    input EQi2, GTi2;
    input [1:0] A, B;
    output EQi, GTi;
    wire [2:0] select;
    assign select[2:1] = A;
    assign select[0] = B[1];
    wire w1, w2, w3, w4;

    mux_8_1bit eq(w1, select, ~B[0], 1'b0, B[0], 1'b0, 1'b0, ~B[0], 1'b0, B[0]);
    and andeq(EQi, EQi2, ~GTi2, w1);

    mux_8_1bit gt(w2, select, 1'b0, 1'b0, ~B[0], 1'b0, 1'b1, 1'b0, 1'b1, ~B[0]);
    and andgt1(w3, ~EQi2, GTi2);
    and andgt2(w4, EQi2, ~GTi2, w2);
    or orgt(GTi, w3, w4);

endmodule