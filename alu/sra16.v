module sra16(out, A);
    input [31:0] A;
    output [31:0] out; 

    assign out[31:16] = {A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31]};
    assign out[15:0] = A[31:16];

endmodule