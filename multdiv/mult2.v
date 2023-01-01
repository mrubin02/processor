`include "mux_32.v"
`include "CLA_32bit.v"
`include "reg1.v"

module mult2(product, A, B, clk, ctrl_MULT, Ordy, exp, ctrl, QP, A_in, A_sub);
    input [31:0] A, B;
    input clk; 
    input ctrl_MULT;
    output [31:0] product; 
    wire Qrdy, rdy; 
    output Ordy; 
    output [63:0] Qcount; 
    wire [63:0] Dcount;
    wire clr;
    wire [63:0] add_B; 
    output exp;

    assign clr = 0; 
    and ANDRDY(rdy, count[4], !count[0], count[1], !count[2], !count[3], !count[5]);

    // counter 
    reg1 COUNT(Qcount, Dcount, clk, 1'b1, clr);
    CLA_32bit CLA1(Dcount[31:0], ovf2, Qcount[31:0], 32'b1, 1'b0, 1'b1);
    assign Dcount[63:32] = {64{1'b0}};

    wire [63:0] count; 

    assign count = ctrl_MULT ? 1'b0 : Qcount;  

    // latch all inputs
    wire [31:0] QA, QB; 
    reg1 Areg(QA, A, clk, ctrl_MULT, clr);
    reg1 Breg(QB, B, clk, ctrl_MULT, clr);

    wire [63:0] DP, Qctrl, Dctrl;
    output [63:0] QP;
    wire ovf1, ovf2;
    wire enP, enC, shift, addsub;
    output [2:0] ctrl; 
    output [31:0] A_shift;
    output [31:0] A_in; 
    output [31:0] A_sub;
    wire [31:0] upper_DP, lower_DP;
    wire check0, check1, check01; 

    reg1 PROD(QP, DP, clk, enP, clr);
    reg1 CTRL(Qctrl, Dctrl, clk, enC, clr);

    assign add_B = {{16{1'b0}}, B};
    assign DP = ctrl_MULT ? add_B : {upper_DP, lower_DP} >>> 2;
 
    assign Dctrl = QP[2:0];
    assign ctrl = Qctrl[2:0];

    assign enP = Mrdy ? 1'b0 : 1'b1;
    assign enC = Mrdy ? 1'b0 : 1'b1;

    wire Mrdy; 

    assign Mrdy = ctrl_MULT ? rdy : Ordy; 

    reg1 RDY_reg(Qrdy, rdy, clk, !rdy, clr);
    reg1 RDY_reg2(Ordy, rdy, clk, 1'b1, clr);

    mux_8 SHIFT(shift, ctrl, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
    mux_8 ADDSUB(addsub, ctrl, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0);
    
    CLA_32bit CLA2(upper_DP, ovf1, QP[63:32], A_in, addsub, check01);
    assign lower_DP = QP[31:0];

    assign A_shift = shift ? A << 1 : A; 
    assign A_in = check01 ? A_sub : 0;
    assign A_sub = addsub ? ~A_shift : A_shift;
    assign product = QP[31:0];

    and check000(check0, !ctrl[0], !ctrl[1], !ctrl[2]);
    and check111(check1, ctrl[0], ctrl[1], ctrl[2]);
    nor check(check01, check0, check1);

    assign exp = 1'b0; 

endmodule



















