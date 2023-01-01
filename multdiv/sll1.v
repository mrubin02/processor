module sll1(out, A, ctrl);
    input [31:0] A;
    output [31:0] out; 

    wire [31:0] temp; 
    input ctrl;

    assign temp[31:1] = A[30:0];
    assign temp[0] = 0;

    assign out = ctrl ? temp : A;

endmodule