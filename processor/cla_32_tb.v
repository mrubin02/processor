module cla_32_tb;
    wire [31:0] A, B;
    wire Cin;
    wire [31:0] S;
    wire Cout;

    cla_32 cla(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    integer i;
    assign A = i;
    assign B = 32'd12345;
    // assign A = 32'd4334995;
    // assign B = 32'd124564;
    assign Cin = 1'b0;
    integer count = 0;
    integer correct = 0;
    initial begin
        #20;
        // $display("%b + %b + %b = %b // %b", A, B, Cin, S, Cout);
        for(i=0; i<300; i=i+1) begin
            #20;
            // count = count + 1;
            // if (S == (A + B + Cin)) begin
            //     correct = correct + 1;
            // end
            if(i%6 == 0) begin
                $display("%d + %d + %d = %d // %d", A, B, Cin, S, Cout);
                // $display("%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b + %b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b + %b = %b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b", A[7], A[6], A[5], A[4], A[3], A[2], A[1], A[0], B[7], B[6], B[5], B[4], B[3], B[2], B[1], B[0], Cin, S[7], S[6], S[5], S[4], S[3], S[2], S[1], S[0]);
            end
        end
        // $display("%d/%d tests passed --> %.0f%%", correct, count, correct/count*100);
        $finish;
    end

    initial begin
        $dumpfile("cla_32.vcd");
        $dumpvars(0, cla_32_tb);
    end
endmodule