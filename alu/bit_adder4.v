`include "bit_adder2.v"

module bit_adder4(S0, S1, S2, S3, Cout0, Cout1, Cout2, Cout3, A0, A1, A2, A3, B0, B1, B2, B3, Cin); 
    input A0, A1, A2, A3, B0, B1, B2, B3, Cin;
    output S0, S1, S2, S3, Cout0, Cout1, Cout2, Cout3; 
    wire w1, w2, w3;
    
    bit_adder2 ADD1(S0, S1, Cout0, Cout1, A0, A1, B0, B1, Cin); 
    bit_adder2 ADD2(S2, S3, Cout2, Cout3, A2, A3, B2, B3, Cout1); 

endmodule 