module counter_tb;

    reg clk, clr;
    wire [4:0] count;

    counter counter1(clk, count, clr);

    initial begin
        clk = 0;
        clr = 0;
        #370;
        $finish;
    end

    always
        #5 clk = ~clk;
    always @(posedge clk) begin
        #1;
        if (count[4] == 1 && count[3] == 0 && count[2]==0 && count[1]==0 && count[0]==1) clr = 1;
        else clr = 0;
        $display("clk: %b count: %b", clk, count);
    end

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, counter_tb);
    end

endmodule