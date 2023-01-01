module full_comparator_tb;

    reg [31:0] A, B;
    wire EQ, GT;

    full_comparator full_comp(A, B, EQ, GT);

    initial begin
        A = 32'd15;
        B = 32'd19;
        
        #80;

        $finish;
    end

    // $display("A:%d B:%d => EQ:%b, GT:%b", A, B, EQ, GT);
    always begin
        #1;
        $display("A:%d B:%d => EQ:%b, GT:%b", A, B, EQ, GT);
    end

    initial begin
        $dumpfile("full_comparator.vcd");
        $dumpvars(0, full_comparator_tb);
    end

endmodule