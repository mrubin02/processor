module sra8(out, A);
    input [31:0] A;
    output [31:0] out; 

    assign out[31:24] = {A[31], A[31], A[31], A[31], A[31], A[31], A[31], A[31]};
    assign out[23:0] = A[31:8];

endmodule