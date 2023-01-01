module tff_tb;

    reg t;
    reg clk, clr;
    wire q;
    tff tflipflop(.T(t), .clk(clk), .Q(q), .clr(clr));

    initial begin
        t = 0;
        clk = 0;
        clr = 0;
        #100;
        $finish;
    end

    always 
        #5 clk=~clk;
    always 
        #20 t=~t;
    always @(clk, t) begin
        #1;
        $display("clk: %b T: %b, Q: %b", clk, t, q);
    end

    initial begin
        $dumpfile("tff.vcd");
        $dumpvars(0, tff_tb);
    end

endmodule