`include "sra1.v"
`include "sra2.v"
`include "sra4.v"
`include "sra8.v"
`include "sra16.v"

module sra(out, A, shiftamt);
    input [31:0] A; 
    input [4:0] shiftamt; 
    output [31:0] out; 

    wire [31:0] out16, out8, out4, out2, sra16, sra8, sra4, sra2, sra1; 

    sra16 SRA16(sra16, A);
    mux_2 MUX16(out16, shiftamt[4], A, sra16);

    sra8 SRA8(sra8, out16);
    mux_2 MUX8(out8, shiftamt[3], out16, sra8);

    sra4 SRA4(sra4, out8);
    mux_2 MUX4(out4, shiftamt[2], out8, sra4);

    sra2 SRA2(sra2, out4);
    mux_2 MUX2(out2, shiftamt[1], out4, sra2);

    sra1 SRA1(sra1, out2);
    mux_2 MUX1(out, shiftamt[0], out2, sra1);

endmodule 