`include "sll1.v"
`include "sll2.v"
`include "sll4.v"
`include "sll8.v"
`include "sll16.v"

module sll(out, A, shiftamt);
    input [31:0] A; 
    input [4:0] shiftamt; 
    output [31:0] out; 

    wire [31:0] out16, out8, out4, out2, sll16, sll8, sll4, sll2, sll1; 

    
    sll16 SLL16(sll16, A);
    mux_2 MUX16(out16, shiftamt[4], A, sll16);

    sll8 SLL8(sll8, out16);
    mux_2 MUX8(out8, shiftamt[3], out16, sll8);

    sll4 SLL4(sll4, out8);
    mux_2 MUX4(out4, shiftamt[2], out8, sll4);

    sll2 SLL2(sll2, out4);
    mux_2 MUX2(out2, shiftamt[1], out4, sll2);

    sll1 SLL1(sll1, out2);
    mux_2 MUX1(out, shiftamt[0], out2, sll1);

endmodule

