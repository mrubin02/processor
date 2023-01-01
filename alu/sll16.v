module sll16(out, A);
    input [31:0] A;
    output [31:0] out; 

    assign out[31:16] = A[15:0];
    assign out[15:0] = 0;

endmodule