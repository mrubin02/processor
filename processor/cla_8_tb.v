module cla_8_tb;
    wire [7:0] A, B;
    wire Cin;
    wire [7:0] S;
    wire G, P;

    cla_8 mux(.A(A), .B(B), .Cin(Cin), .S(S), .G(G), .P(P));
    
    integer i;
    assign {A, B, Cin} = i[16:0];
    integer count = 0;
    integer correct = 0;
    initial begin
        for(i=0; i<131072; i=i+1) begin
            #20;
            count = count + 1;
            if (S == (A + B + Cin)) begin
                correct = correct + 1;
            end
            // if(i%9876 == 0) begin
            //     $display("%b%b%b%b%b%b%b%b + %b%b%b%b%b%b%b%b + %b = %b%b%b%b%b%b%b%b", A[7], A[6], A[5], A[4], A[3], A[2], A[1], A[0], B[7], B[6], B[5], B[4], B[3], B[2], B[1], B[0], Cin, S[7], S[6], S[5], S[4], S[3], S[2], S[1], S[0]);
            // end
        end
        $display("%d/%d tests passed --> %.0f%%", correct, count, correct/count*100);
        $finish;
    end

    initial begin
        $dumpfile("cla_8.vcd");
        $dumpvars(0, cla_8_tb);
    end
endmodule