module add_tb; 
    wire signed [31:0] A, B;
    wire signed [31:0] S;
    wire [4:0] ctrl_ALUopcode;
    wire overflow;
    wire c8, c16, c24, c32;

    assign A = 1073741824;
    assign B = 1073741824;
    assign ctrl_ALUopcode = 0;

    CLA_32bit CLA1(S, overflow, A, B, ctrl_ALUopcode);

    initial begin 
        #80 
        $display("A: %b, B: %b ==> S:%b", A, B, S);
        $display("A: %d, B: %d ==> S:%d", A, B, S);
        $display("O:%b", overflow);
        $finish;
    end

endmodule 


