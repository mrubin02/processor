module isa_decoder(instr, op, alu_op, type, rd, rs, rt, shamt, immediate, target);

	input [31:0] instr;
    output [4:0] op, alu_op, rd, rs, rt, shamt;
    output [1:0] type; // R: 00, I: 01, J1: 10, J2: 11
    output [16:0] immediate;
    output [26:0] target;

    wire R, I, J1mux, J1, J2;

    // Determine the type based on op
    and and_r(R, ~instr[31], ~instr[30], ~instr[29], ~instr[28], ~instr[27]);
    and and_j2(J2, ~instr[31], ~instr[30], instr[29], ~instr[28], ~instr[27]);
    mux_32_1bit mux_i(I, instr[31:27], 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
    mux_32_1bit mux_j1(J1mux, instr[31:27], 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0);
    and and_j1(J1, J1mux, instr[31], instr[30], ~instr[29], ~instr[28], ~instr[27]);
    assign type[1] = J1 | J2;
    assign type[0] = I | J2;

    // Assign outputs
    assign op = instr[31:27];
    assign rd = instr[26:22];
    assign rs = instr[21:17];
    assign rt = instr[16:12];
    assign shamt = instr[11:7];
    assign alu_op = instr[6:2];
    assign immediate = instr[16:0];
    assign target = instr[26:0];

endmodule