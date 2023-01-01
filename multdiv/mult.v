`include "counter.v"
`include "reg32.v"
`include "reg63.v"
`include "CLA_32bit.v"
`include "oneeq.v"
`include "xor_gate.v"
`include "mux_32.v"
`include "jone.v"


//module mult(dataA, dataB, ctrl_MULT, clock, result, exception, rdy, count, ctrl, A_in);
module mult(dataA, dataB, ctrl_MULT, ctrl_DIV, clock, result, exception, rdy);
    input [31:0] dataA, dataB; 
    input ctrl_MULT, ctrl_DIV, clock; 
    output signed [31:0] result;
    wire [31:0] A_in; 
    output exception, rdy;
    wire [4:0] count; 
    wire Qrdy, clr; 
    wire signed [63:0] result2; 
    wire ovf1; 

    assign clr = ctrl_MULT;
    // counter 

    wire clk17;
    counter COUNT(count, clock, ctrl_MULT, start);
    wire rdy1; 
    assign rdy1 = !count[0] && !count[1] && !count[2] && !count[3] && count[4]; 
    wire clk0; 
    assign clk0 = !count[0] && !count[1] && !count[2] && !count[3] && !count[4]; 
    assign clk17 = !count[0] && count[1] && !count[2] && !count[3] && count[4]; 
    
    // latch inputs 
    wire [31:0] A, B; 
    reg32 REGA(A, dataA, clock, ctrl_MULT, clr); 
    reg32 REGB(B, dataB, clock, ctrl_MULT, clr); 

    // latch rdy when asserted 
    wire Ordy, start1, start; 
    reg1 REG1(Qrdy, rdy, clock, rdy, 1'b0); 
    reg1 REG3(Ordy, Qrdy, clock, Qrdy, 1'b0); 
    reg1 REG4(start1, 1'b1, clock, ctrl_MULT, ctrl_DIV); 

    // latch exception when raised 
    wire exp1, exp2, exp3, exp4, exp5, exp6, exp7, exp8; 
    wire t1, t2, t3;
    zeroeq Z1(t1, result); 
    zeroeq Z2(t2, dataA); 
    zeroeq Z3(t3, dataB); 
    and AND1(exp1, dataA[31], dataB[31], result[31]); 
    and AND2(exp2, dataA[31], !dataB[31], !t3, !result[31]);
    and AND3(exp3, !dataA[31], dataB[31], !t2, !result[31]);
    and AND4(exp4, !dataA[31], !dataB[31], result[31]);
    and AND5(exp5, !t3, !t2, t1); 
    oneeq O1(exp6, result2[63:32]); 
    zeroeq O2(exp7, result2[63:32]); 
    or OR10(exp8, exp6, exp7);

    wire j1, j2, j3, o1, o2, exp9; 
    jone J1(j1, result); 
    jone J2(j2, dataA); 
    jone J3(j3, dataB); 
    oneeq J4(o1, dataB); 
    oneeq J5(o2, dataA); 
    assign exp9 = j1 && !((o1 && o2) || (j1 && j2));

    or OR1(exception, exp1, exp2, exp3, exp4, exp5, !exp8, exp9); 


    // create product register 
    wire [31:0] result1; 
    wire signed [63:0] DP, QP;
    //assign DP = clk0 ? {A_in, dataB} >>> 2 : {upper_DP, lower_DP} >>> 2;
    wire signed [63:0] dp_temp = {upper_DP, lower_DP};
    assign DP = dp_temp >>> 2;
    reg63 REG2(QP, DP, clock, !rdy, clr); 
    //assign result = (clk0 && ctrl_MULT) ? {{32{1'b0}}, dataB} : QP[31:0]; 
    assign result1 = clk0 ? {dataB} : QP[31:0]; 
    assign result2 = (clk0) ? {{32{1'b0}}, dataB} : QP;
    
    // controls 
    wire shift, sub; 
    wire QH, DH; 
    wire helper;
    wire [2:0] ctrl;
    assign ctrl = clk0 ? {dataB[1:0], 1'b0} : {result[1:0], QH}; 
    mux_8 SHIFT(shift, ctrl, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0);
    mux_8 ADDSUB(sub, ctrl, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0);
    reg1 REGHELP(QH, DH, clock, 1'b1, clr);
    assign DH = result[1]; 

    // find A to add 
    wire [31:0] A_shift, A_sub; 
    assign A_shift = shift ? dataA<<1 : dataA; 
    assign A_sub = sub ? ~A_shift : A_shift; 
    assign A_in = check01 ? A_sub : 0; 

    
    wire check0, check1, check01; 
    and check000(check0, !ctrl[0], !ctrl[1], !ctrl[2]);
    and check111(check1, ctrl[0], ctrl[1], ctrl[2]);
    nor check(check01, check0, check1);

    // add/sub 
    wire signed [31:0] upper_DP, lower_DP; 
    wire [31:0] add_DP; 
    wire [31:0] add_in; 
    assign add_in = clk0 ? {32{1'b0}} : QP[63:32];
    CLA_32bit CLA2(add_DP, ovf1, add_in, A_in, sub, check01);
    assign lower_DP = clk0 ? dataB : QP[31:0];
    assign upper_DP = add_DP; 

    assign result = ctrl_DIV && start1 ? 0 : result1; 
    assign rdy = ctrl_DIV && start1 ? 1 : rdy1; 
    assign start = ctrl_DIV && start1 ? 0 : start1;

endmodule

