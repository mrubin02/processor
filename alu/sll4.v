module sll4(out, A);
    input [31:0] A;
    output [31:0] out; 

    assign out[31:4] = A[27:0];
    assign out[3:0] = 0;

endmodule