`include "mux_32.v"
`include "CLA_32bit.v"
`include "and_gate.v"
`include "or_gate.v"
`include "sll.v"
`include "sra.v"
`include "not_gate.v"
module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    wire [31:0] notB;

    not_gate NOT(notB, data_operandB);

    wire [31:0] adder, subresult;
    wire [31:0] andresult, orresult, sllresult, sraresult;
    wire overflowA, overflowB, overflowT;  

    CLA_32bit CLA1(adder, overflowA, data_operandA, data_operandB, ctrl_ALUopcode[0], 1'b1);
    CLA_32bit CLA2(subresult, overflowB, data_operandA, notB, ctrl_ALUopcode[0], 1'b1);
    and_gate AND(andresult, data_operandA, data_operandB);
    or_gate OR(orresult, data_operandA, data_operandB);
    sra SRA(sraresult, data_operandA, ctrl_shiftamt);
    sll SLL(sllresult, data_operandA, ctrl_shiftamt);

    
    wire overcheck1, overcheck2, overcheck3, overcheck4, overcheck5, notA, notC, notB2, i0, notOp;

    
    not NOT2(notA, data_operandA[31]); 
    not NOT3(notC, data_result[31]); 
    not NOT4(notB2, data_operandB[31]); 
    not NOT5(notOp, ctrl_ALUopcode[0]);
    and AND2(overcheck1, data_operandA[31], data_operandB[31], notC, notOp); 
    and AND3(overcheck2, notA, notB2, data_result[31], notOp); 
    and AND5(overcheck3, data_operandB[31], data_result[31], notA, ctrl_ALUopcode[0]); 
    and AND6(overcheck4, notB2, notC, data_operandA[31], ctrl_ALUopcode[0]); 
    or OR2(overcheck5, overcheck1, overcheck2, overcheck3, overcheck4);


    wire notov, sub1, sub2; 
    not NOT6(notov, overflow);
    and AND7(sub1, notov, subresult[31]);
    and AND8(sub2, overflow, notC);
    or OR3(isLessThan, sub1, sub2);
    assign isNotEqual = subresult ? 1 : 0;
    assign overflowT = ctrl_ALUopcode[0] ? data_operandB[31] : data_operandA[31]; 
    assign overflow = overcheck5 ?  1 : 0;

    mux_32 MUX2(data_result, ctrl_ALUopcode, adder, subresult, andresult, orresult, sllresult, sraresult, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

endmodule