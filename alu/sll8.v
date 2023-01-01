module sll8(out, A);
    input [31:0] A;
    output [31:0] out; 

    assign out[31:8] = A[23:0];
    assign out[7:0] = 0;

endmodule