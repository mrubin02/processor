module mult_control(bits, clk, start_mult, mltnd_shift, sub, zero, finish_cyc, init_cycle);

    input [2:0] bits;
    input clk, start_mult;
    output mltnd_shift, sub, zero, finish_cyc, init_cycle;
    wire [4:0] count;
    wire mltnd_shift_a, mltnd_shift_b, zero_a, zero_b, sub_12, start_mult, ctr_rst, ctr_restart;

    counter counter_1(clk, count, ctr_restart);
    assign ctr_restart = ctr_rst | start_mult;

    and and_shift_a(mltnd_shift_a, ~bits[2], bits[1], bits[0]);
    and and_shift_b(mltnd_shift_b, bits[2], ~bits[1], ~bits[0]);
    or or_shift(mltnd_shift, mltnd_shift_a, mltnd_shift_b);

    nand sub_1(sub_12, bits[1], bits[0]);
    and sub_2(sub, bits[2], sub_12);
    // mux_2_1bit sub_mux(sub, bits[2], 1'b0, 1'b1);

    and and_zero_a(zero_a, ~bits[2], ~bits[1], ~bits[0]);
    and and_zero_b(zero_b, bits[2], bits[1], bits[0]);
    or or_zero(zero, zero_a, zero_b);

    and and_ctr_rst(ctr_rst, count[4], ~count[3], ~count[2], count[1], ~count[0]); 
    and and_init_cyc(init_cycle, ~count[4], ~count[3], ~count[2], ~count[1], ~count[0]);
    and and_finish_cyc(finish_cyc, count[4], ~count[3], ~count[2], ~count[1], count[0]); 

endmodule