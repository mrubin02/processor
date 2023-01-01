module add8_tb; 
    wire [7:0] A, B;
    wire [7:0] S;
    wire overflow, temp;
    wire P, G, Cin; 

    assign Cin = 0;
    assign A = 15;
    assign B = -15;

    CLA_8bit CLA1(P, G, S, A, B, Cin);
    and AND(temp, P, Cin); 
    or OR(overflow, G, temp);

    initial begin 
        #80 
        $display("A: %b + B: %b ==> S:%d, 0: %b", A, B, S, overflow);
        $display("P : %b, G:%b", P, G);

        $finish;
    end

endmodule 


