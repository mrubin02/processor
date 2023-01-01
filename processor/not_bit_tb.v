module not_bit_tb;
    wire [31:0] operand;
    wire [31:0] result;

    not_bit NOT(.operand(operand), .result(result));

    integer i;
    assign operand = i;
    integer count = 0;
    integer correct = 0;
    initial begin
        #20;
        for(i=0; i<429496; i=i+1) begin
            #20;
            // $display("~%b = %b", operand, result);
            count = count + 1;
            if (result == ~operand) begin
                correct = correct + 1;
            end
        end
        $display("%d/%d tests passed --> %.0f%%", correct, count, correct/count*100);
        $finish;
    end

    initial begin
        $dumpfile("not_bit.vcd");
        $dumpvars(0, not_bit_tb);
    end
endmodule