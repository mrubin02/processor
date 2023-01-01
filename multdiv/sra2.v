module sra2(out, A);
    input [63:0] A;
    output [63:0] out; 

    assign out[63:62] = {A[63], A[63]};
    assign out[61:0] = A[63:2];

endmodule