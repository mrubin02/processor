module alu_personal_tb;
    wire [31:0] data_operandA, data_operandB;
    wire [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    wire [31:0] data_result;
    wire isNotEqual, isLessThan, overflow;

    alu ALU(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

    integer i;
    assign data_operandA = 32'd43;
    assign data_operandB = 32'd12;
    assign ctrl_ALUopcode = 5'd0;
    assign ctrl_shiftamt = 5'd0;

    integer count = 0;
    integer correct = 0;
    initial begin
        #20;
        $display("%b + %b = %b", data_operandA, data_operandB, data_result);
        // for(i=0; i<429496; i=i+1) begin
        //     #20;
        //     // $display("%b | %b = %b", operandA, operandB, result);
        //     count = count + 1;
        //     if (result == (operandA | operandB)) begin
        //         correct = correct + 1;
        //     end
        // end
        // $display("%d/%d tests passed --> %.0f%%", correct, count, correct/count*100);
        $finish;
    end

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_personal_tb);
    end
endmodule