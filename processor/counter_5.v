module counter_5(clk, count, reset);

    input clk, reset;
    output [5:0] count;

    wire Q0, Q1, Q2, T2, T3, T4, T5;

    tff tff0(1'b1, clk, count[0], reset);
    tff tff1(count[0], clk, count[1], reset);
    and and2(T2, count[0], count[1]);
    tff tff2(T2, clk, count[2], reset);
    and and3(T3, T2, count[2]);
    tff tff3(T3, clk, count[3], reset);
    and and4(T4, T3, count[3]);
    tff tff4(T4, clk, count[4], reset);
    and and5(T5, T4, count[4]);
    tff tff5(T5, clk, count[5], reset);

endmodule