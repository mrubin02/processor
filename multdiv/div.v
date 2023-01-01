`include "zeroeq.v"
`include "negth.v"

module div(A, B, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);
    
    input [31:0] A, B;
    wire [31:0] M, Q;  
    output [31:0] data_result; 
    input clock, ctrl_DIV, ctrl_MULT; 
    output data_exception, data_resultRDY;
    wire [31:0] QN;
    wire rdy1; 
    wire clr = ctrl_DIV;

    wire clk17, clk1;
    wire [4:0] count;
    counter COUNT(count, clock, ctrl_DIV, start);
    wire clk0; 
    assign clk0 = !count[0] && !count[1] && !count[2] && !count[3] && !count[4];  

    wire [31:0] Ain, Bin; 

    wire Ach; 
    wire rdy; 
    negth NEG(Ach, A); 
    wire [31:0] negA; 
    assign negA = Ach? ~A : -A; 

    assign Ain = A[31] ? negA : A;  
    assign Bin = B[31] ? -B : B;  

    reg32 REGA(M, Bin, clock, ctrl_DIV, 1'b0);
    reg32 REGB(Q, Ain, clock, ctrl_DIV, 1'b0);

    wire Ordy, Qrdy, start, start1; 
    reg1 REG1(Qrdy, rdy1, clock, rdy1, 1'b0); 
    reg1 REG3(Ordy, Qrdy, clock, Qrdy, 1'b0); 
    reg1 REG4(start1, 1'b1, clock, ctrl_DIV, ctrl_MULT); 

    wire [31:0] result1 = checkQ || checkM ? 0 : oAQ[31:0];
    wire [31:0] oAQ = A[31] ^ B[31] ?  -fAQ[31:0] : fAQ[31:0]; 
    wire data_exception = checkM ? 1 : 0;
    wire checkQ, checkM;
    zeroeq Z1(checkQ, Ain); 
    zeroeq Z2(checkM, Bin); 

    wire [31:0] presult = Ach ? resultsub: result1; 
    assign data_result = ctrl_MULT && start1 ? 0 : presult; 
    assign data_resultRDY = (ctrl_MULT && start1) || zN ? 1 : 0; 
    assign start = ctrl_MULT && start1 ? 0 : start1;

    wire ovf11; 
    wire [31:0] resultsub; 
    CLA_32bit CLA20(resultsub, ovf11, result1, ~1, 1'b1, 1'b1);

    //wire [31:0] oAQ; 
    wire ovf7;
    //CLA_32bit ADD10(oAQ, ovf7, tAQ, ~1, 1'b1, !A[31] & B[31]);

    wire [31:0] DN, nm, Nm1;
    wire ovf1, ovf2, ovf3, Qdone;  

    reg32 REGN(QN, DN, clock, 1'b1, rdy); 
    reg1 REGM(Qdone, zN, clock, zN, rdy); 
    assign DN = clk0 ? 30 : Nm1; 
    CLA_32bit CLA1(Nm1, ovf1, QN, ~1, 1'b1, start1);


    wire [63:0] DAQ, DAQ2, QAQ2, AQ; 
    wire [63:0] QAQ; 
    wire [31:0] addsub; 
    wire [31:0] Ac = 32'b0;
    reg63 REGAQ(QAQ, DAQ, clock, 1'b1, clr); 
    assign DAQ = clk0 ? {-Bin, Ain << 1} : AQ; 

    wire [63:0] sQAQ; 
    assign sQAQ = QAQ << 1; 
    wire [31:0] inM;
    assign inM = QAQ[63] ? Bin : ~Bin;
    CLA_32bit CLA2(addsub, ovf2, sQAQ[63:32], inM, !QAQ[63], 1'b1);

    assign DAQ2 = {addsub, sQAQ[31:0]}; 
    //reg63 REGB(QAQ2, DAQ2, clock, 1'b1, clr);
    assign AQ = DAQ2[63] ? {DAQ2[63:1], 1'b0} : {DAQ2[63:1], 1'b1};

    wire zN;
    wire [31:0] addsub2; 
    zeroeq N0(zN, QN);
    wire [63:0] fAQ;
    //assign fAQ = AQ[63] ? {addsub2, AQ[31:0]} : AQ; 
    assign fAQ = AQ;
    CLA_32bit CLA3(addsub2, ovf3, AQ[63:32], M, 1'b0, 1'b1);

endmodule 