module mult_control_tb;

    reg clk;
    reg [2:0] bits;
    wire mltnd_shift, sub, zero, finish_cyc, init_cyc;

    mult_control mult_control1(bits, clk, mltnd_shift, sub, zero, finish_cyc, init_cyc);

    initial begin
        clk = 0;
        bits = 3'b0;
        #40;
        $finish;
    end

    always
        #5 clk = ~clk;
    always
        #5 bits[0] = ~bits[0];
    always
        #10 bits[1] = ~bits[1];
    always
        #20 bits[2] = ~bits[2];
    always @(clk) begin
        #1;
        $display("bits: %b, mltnd_shift: %b, sub: %b, zero: %b, finish_cyc: %b", bits, mltnd_shift, sub, zero, finish_cyc);
    end

    initial begin
        $dumpfile("mult_control.vcd");
        $dumpvars(0, mult_control_tb);
    end

endmodule