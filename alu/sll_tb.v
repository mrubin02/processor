
`include "mux_2.v"

module sll_tb; 
    wire [31:0] A; 
    wire [31:0] out;
    wire [4:0] shift; 

    assign shift = 17; 

    assign A = 8;

    sll SLL(out, A, shift); 

    initial begin
        #40 
        $display("Out: %b", out);
        $finish;
    end

endmodule





