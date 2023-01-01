module sll2(out, A);
    input [31:0] A;
    output [31:0] out; 

    assign out[31:2] = A[29:0];
    assign out[1:0] = 0;

endmodule