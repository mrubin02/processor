module sr_tb;

    reg S, R, clk;
    // reg clk, clr;
    wire Q;
    sr sr_latch(S, R, Q);

    initial begin
        S = 1;
        R = 0;
        clk = 0;
        // clr = 0;
        #100;
        $finish;
    end

    always 
        #5 clk=~clk;
    always 
        #40 R = ~R;
    always
        #20 S = ~S;
    always @(clk) begin
        #1;
        $display("S:%b R:%b | Q:%b", S, R, Q);
    end

    initial begin
        $dumpfile("sr.vcd");
        $dumpvars(0, sr_tb);
    end

endmodule