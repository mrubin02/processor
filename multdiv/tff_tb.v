module tff_tb; 
    reg clk, T; 
    wire Q, nQ; 

    tff TFF1(Q, nQ, T, clk); 

    initial begin 
        clk = 0; 
        T = 1; 
        #80
        $finish;
    end 

    always 
        #10 clk = ~clk; 
    
    always @(clk) begin
        #1
        $display("T: %b clk: %b ==> Q: %b, nQ: %b ", T, clk, Q, nQ);
    end

endmodule
