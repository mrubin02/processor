module div_control(A, clk, start_div, finish_cyc, init_cycle, sec_cycle);

    input [31:0] A;
    input clk, start_div;
    output finish_cyc, init_cycle, sec_cycle;
    wire [5:0] count;
    wire ctr_rst, ctr_restart;

    counter_5 count_1(clk, count, ctr_restart);
    assign ctr_restart = ctr_rst | start_div;
    and and_ctr_rst(ctr_rst, count[5], ~count[4], ~count[3], ~count[2], ~count[1], count[0]); 
    and and_init_cyc(init_cycle, ~count[5], ~count[4], ~count[3], ~count[2], ~count[1], ~count[0]);
    and and_sec_cyc(sec_cycle, ~count[5], ~count[4], ~count[3], ~count[2], ~count[1], count[0]);
    and and_finish_cyc(finish_cyc, count[5], ~count[4], ~count[3], ~count[2], ~count[1], ~count[0]); 

    

endmodule