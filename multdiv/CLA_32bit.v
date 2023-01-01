`include "CLA_8bit.v"

module CLA_32bit(S, overflow, data_operandA, data_operandB, ctrl, addctrl); 
    input [31:0] data_operandA, data_operandB; 
    input ctrl; 
    output [31:0] S;
    wire [31:0] temp_S;
    output overflow; 
    input addctrl;

    wire c8, c16, c24, c32; 
    wire G0, P0, G1, P1, G2, P2, G3, P3;
    wire [7:0] S7, S15, S23, S31;
    wire c0; 

    assign c0 = ctrl;

    wire temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10; 
   
    //get c8 
    CLA_8bit CLA1(P0, G0, S7, data_operandA[7:0], data_operandB[7:0], c0);
    and AND1(temp1, P0, c0);
    or OR1(c8, temp1, G0);

    //get c16
    CLA_8bit CLA2(P1, G1, S15, data_operandA[15:8], data_operandB[15:8],  c8);
    and AND2(temp2, P1, G0);
    and AND3(temp3, P1, P0, c0);
    or OR2(c16, temp2, temp3, G1);

    //get c24
    CLA_8bit CLA3(P2, G2, S23, data_operandA[23:16], data_operandB[23:16], c16);
    and AND4(temp4, P2, G1);
    and AND5(temp5, P2, P1, G0);
    and AND6(temp6, P2, P1, P0, c0);
    or OR3(c24, G2, temp4, temp5, temp6);

    //get c32
    CLA_8bit CLA4(P3, G3, S31, data_operandA[31:24], data_operandB[31:24], c24);
    and AND7(temp7, P3, G2);
    and AND8(temp8, P3, P2, G1);
    and AND9(temp9, P3, P2, P1, G0);
    and AND10(temp10, P3, P2, P1, P0, c0);
    or OR4(c32, G3, temp7, temp8, temp9, temp10);

    wire ov; 
    assign temp_S[31:24] = S31;
    assign temp_S[23:16] = S23; 
    assign temp_S[15:8] = S15; 
    assign temp_S[7:0] = S7; 
    assign ov = c32;

    wire overcheck1, overcheck2, overcheck3, overcheck4, overcheck5; 
    and AND11(overcheck1, data_operandA[31], data_operandB[31], !S[31], !ctrl); 
    and AND12(overcheck2, !data_operandA[31], !data_operandB[31], S[31], !ctrl); 
    and AND13(overcheck3, data_operandB[31], S[31], !data_operandA[31], ctrl); 
    and AND15(overcheck4, !data_operandB[31], !S[31], data_operandA[31], ctrl); 
    or OR5(overcheck5, overcheck1, overcheck2, overcheck3, overcheck4);

    assign overflow = overcheck5 ?  1 : 0;

    assign S = addctrl ? temp_S : data_operandA;

endmodule











