module counter_tb; 
    wire Q0, Q1, Q2, Q3, Q4; 
    wire [4:0] count; 
    reg clk; 

    counter COUNT1(count, clk, 1'b0); 

    initial begin
        clk =0; 
        #80
        $finish; 
    end 

    always
        #10 clk = ~clk; 

    always @(clk) begin 
        #1
        $display("%b", count);
    end 

endmodule 