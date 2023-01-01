
`include "mux_2.v"

module sra_tb; 
    wire signed [31:0]  A; 
    wire signed [31:0] out;
    wire [4:0] shift; 

    assign shift = 2; 

    assign A = -252645136;

    sra SRA(out, A, shift); 

    initial begin
        #40 
        $display("A: %d ==> Out: %d", A, out);
        $display("A: %b ==> Out: %b", A, out);
        $finish;
    end

endmodule





