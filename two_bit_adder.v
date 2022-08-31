`include "full_adder.v"
module two_bit_adder(S0, S1, Cout0, Cout1, A0, A1, B0, B1, Cin); 
    input A0, A1, B0, B1, Cin;
    output S0, S1, Cout0, Cout1; 
    wire w1, w2, w3;
    
    full_adder add1(S0, Cout0, A0, B0, Cin);
    full_adder add2(S1, Cout1, A1, B1, Cout0);

endmodule 
