
module two_bit_adder_tb; 
    wire A0, A1, B0, B1;
    wire Cin;
    wire S0, S1;
    wire Cout0, Cout1;

    two_bit_adder adder(S0, S1, Cout0, Cout1, A0, A1, B0, B1, Cin);
    integer i; 
    assign {Cin, A1, A0, B1, B0} = i[4:0]; 
    initial begin 
        for(i =0; i<32; i = i+1) begin 
            #20 
            $display("A:%b%b, B:%b%b, Cin:%b => S:%b%b, Cout:%b", A1, A0, B1, B0, Cin, S1, S0, Cout1);
        end 
        $finish;
    end 
endmodule 