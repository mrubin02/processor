module rshift_tb;
    wire signed [31:0] operand;
    wire [4:0] shift_amt;
    wire signed [31:0] result;

    rshift Rshift(.operand(operand), .shift_amt(shift_amt), .result(result));

    integer i;
    assign shift_amt = i[4:0];
    assign operand = 32'b11110001101001110011011100101111;
    // assign operand = 32'b01110001101001110011011100101111;
    integer count = 0;
    integer correct = 0;
    initial begin
        #20;
        for(i=0; i<32; i=i+1) begin
            #20;
            $display("%b >>> %d = %b", operand, shift_amt, result);
            count = count + 1;
            if (result == operand >>> i) begin
                correct = correct + 1;
            end
        end
        $display("%d/%d tests passed --> %.0f%%", correct, count, correct/count*100);
        $finish;
    end

    initial begin
        $dumpfile("rshift.vcd");
        $dumpvars(0, rshift_tb);
    end
endmodule