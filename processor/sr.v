module sr(S, R, Q);

    input S, R;
    output Q;
    wire wR, wS;

    nor r_nor(wR, R, wS);
    nor s_nor(wS, S, wR);
    // assign Q = (~S & ~R) ? 1'b1 : wR;
    assign Q = wR;

endmodule