module and_bit_tb;
    wire [31:0] operandA, operandB;
    wire [31:0] result;

    and_bit AND(.operandA(operandA), .operandB(operandB), .result(result));

    integer i;
    assign operandA = i;
    assign operandB = 32'b11001010100011001111000111000101;
    integer count = 0;
    integer correct = 0;
    initial begin
        #20;
        for(i=0; i<429496; i=i+1) begin
            #20;
            // $display("%b & %b = %b", operandA, operandB, result);
            count = count + 1;
            if (result == (operandA & operandB)) begin
                correct = correct + 1;
            end
        end
        $display("%d/%d tests passed --> %.0f%%", correct, count, correct/count*100);
        $finish;
    end

    initial begin
        $dumpfile("and_bit.vcd");
        $dumpvars(0, and_bit_tb);
    end
endmodule