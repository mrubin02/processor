module tff(T, clk, Q, clr);

    input T, clk, clr;
    output Q;

    wire Q_not, and1, and2, D;

    // and and_a(and1, T, clk, Q);
    // and and_b(and2, clk, T, Q_not);
    // nor nor_a(Q, and1, Q_not);
    // nor nor_b(Q_not, Q, and2);

    xor xor1(D, T, Q);
    dffe_ref dffe1(Q, D, clk, 1'b1, clr);

endmodule