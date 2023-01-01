/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */
    wire [4:0] op_d, alu_op_d, rd_d, rs_d, rt_d, shamt_d, op_x, alu_op_x, rd_x, rs_x, rt_x, shamt_x, op_m, alu_op_m, rd_m, rs_m, rt_m, shamt_m, op_w, alu_op_w, rd_w, rs_w, rt_w, shamt_w, op_p, alu_op_p, rd_p, rs_p, rt_p, shamt_p, rstatus_ctrl, writeReg_ctrl, alu_rd_out, alu_opcode, rs1_nop, rs2_nop, rd_nop_x, rd_nop_m;
    wire [4:0] rs1_bypass, rs2_bypass, rd_bypass_w, rd_by_x, rs1_by_d, rs2_by_d, rd_by_d, rd_by_m;
    wire [1:0] type_d, type_x, type_m, type_w, type_p, bypass_select_a, bypass_select_b; // R: 00, I: 01, J1: 10, J2: 11
    wire [16:0] immediate_d, immediate_x, immediate_m, immediate_w, immediate_p;
    wire [26:0] target_d, target_x, target_m, target_w, target_p;
    wire [31:0] pc_in, pc_out, pc_mux_out, pc_ctr_out, pc_jump, pc1_jal, pc_ctr_in, pc1, pc_out_fd, pc_out_dx, ir_out_fd, ir_out_dx, ir_out_xm, ir_out_mw, ir_in_xm, p_out_pw, ir_in_dx, ir_out_dp, ir_out_pw, ir_writeback, pc_blt_bne, ir_in_fd;
    wire [31:0] alu_result, alu_operand_a, alu_operand_b, alu_op_b_mux_in, a_in_comp, b_in_comp, a_out_dx, b_out_dx, b_out_xm, o_out_mw, d_out_mw, N_ext, N_ext_d, rstatus_data, writeReg_alu_rstatus, multdiv_result, multdiv_a, multdiv_b, a_in_dx, b_in_dx, stall_count, stall_count_out, stall_count_in;
    wire processor_clk, isNEQ, isLT, alu_overflow, cout_pc_ctr, cout_pc, cout_pc_br, cout_pc_jal, init_cyc, useAluResult, multdiv_exception, multdiv_rdy_internal, multdiv_resultRDY, multdiv_error;
    wire isLwAlu_w, isAluOp_w, isAddi_w, isI_x, isR_x, isAdd_x, isAddi_x, isSub_x, isSetx_x, isMultDiv_aluop, isMultDiv, isMultDiv_aluop_p, isMultDiv_p, isMultDiv_aluop_x, isMultDiv_x, isMultDiv_aluop_d, isMultDiv_d, dp_enable, isBltBne_d, isMultDiv_op_x, isMult_x, isDiv_x;
    wire FDIRRS1_DXIRRD, FDIRRS2_DXIRRD, RDIRRS1_XMIRRD, FDIRRS2_XMIRRD, DXIRRS1_XMIRRD, DXIRRS1_MWIRRD, DXIRRS2_XMIRRD, DXIRRS2_MWIRRD, insert_nop_multdiv, insert_nop, isJJal_d, isJr_d, isBex_d, isSetx_d, noRs1, isAlu_d, isShift_d, yesRs2, isJJal_x, isBex_x, noRd_x, isJJal_m, isBex_m, isSetx_m, noRd_m;
    wire DXIRRD_FDIRRS1, DXIRRD_FDIRRS2, DXIRRD_FDIRRD, XMIRRD_FDIRRS1, XMIRRD_FDIRRS2;
    wire isStall_d, isJr_x, isJal_x, noRs1_x, isJJal_w, isAddi_m, isAlu_m, isBex_w, isSw_x, isSetx_w, isEQ_d, isGT_d, noRd_w, isLw_w, isLw_d, isSw_m, isLw_x, isSw_d, isSw_w, isBlt_x, isBne_x, isBlt_d, isBne_d, sAlu_x, isShift_x, yesRs2_x, pc_BltBne_select, pc_bex_select, insert_nop_hazard, isAlu_x, wm_select, isJal_w, isAddi_d, isBltBne_w;
    wire count_rst, insert_nop_stall, stall_cmp_eq, stall_cmp_ct_gt, stall_ct_cout;
    assign processor_clk = ~clock;

    // Fetch
    PC_latch pc_latch1(pc_in, pc_out, clock);
    assign address_imem = pc_out;
    cla_32 cla_pc(32'b1, pc_out, 1'b0, pc1, cout_pc);
    reg_pc reg_pc1(pc_ctr_out, pc_ctr_in, 1'b1, 1'b1, clock, reset);
    cla_32 cla_pc_ctr(32'b1, pc_ctr_out, 1'b0, pc_ctr_in, cout_pc_ctr);
    and and_init(init_cyc, ~pc_ctr_out[31], ~pc_ctr_out[30], ~pc_ctr_out[29], ~pc_ctr_out[28], ~pc_ctr_out[27], ~pc_ctr_out[26], ~pc_ctr_out[25], ~pc_ctr_out[24], ~pc_ctr_out[23], ~pc_ctr_out[22], ~pc_ctr_out[21], ~pc_ctr_out[20], ~pc_ctr_out[19], ~pc_ctr_out[18], ~pc_ctr_out[17], ~pc_ctr_out[16], ~pc_ctr_out[15], ~pc_ctr_out[14], ~pc_ctr_out[13], ~pc_ctr_out[12], ~pc_ctr_out[11], ~pc_ctr_out[10], ~pc_ctr_out[9], ~pc_ctr_out[8], ~pc_ctr_out[7], ~pc_ctr_out[6], ~pc_ctr_out[5], ~pc_ctr_out[4], ~pc_ctr_out[3], ~pc_ctr_out[2], ~pc_ctr_out[1], ~pc_ctr_out[0]);
    assign pc_in = init_cyc ? 32'b0 : insert_nop ? pc_out : pc_BltBne_select ? pc_blt_bne : (isJJal_x | isJr_x) ? pc_jump : pc_bex_select ? target_x : isBltBne_d ? pc_out : pc1;
    // counter_32 counter_stall(clock, stall_count, ~isStall_d);
    reg_pc stall_ctr_reg(stall_count_out, stall_count_in, 1'b1, 1'b1, clock, ~isStall_d);
    cla_32 cla_stall_ctr(stall_count_out, 32'b1, 1'b0, stall_count_in, stall_ct_cout);

    // Decode
    FD_latch fd_latch1(pc1, ir_in_fd, pc_out_fd, ir_out_fd, clock, ~insert_nop);
    isa_decoder isa_dec_d(ir_out_fd, op_d, alu_op_d, type_d, rd_d, rs_d, rt_d, shamt_d, immediate_d, target_d);
    // handle stall instructions
    and and_stall_d(isStall_d, op_d[4], op_d[3], ~op_d[2], ~op_d[1], ~op_d[0]);
    full_comparator stall_comp({5'b0, target_d}, stall_count_out, stall_cmp_eq, stall_cmp_ct_gt);
    assign insert_nop_stall = isStall_d ? stall_cmp_ct_gt : 1'b0;
    // change operand a to $rd if blt or bne
    and and_blt_bne(isBltBne_d, ~op_d[4], ~op_d[3], op_d[1], ~op_d[0]);
    assign ctrl_readRegA = (isBltBne_d | isJr_d) ? rd_d : isBex_d ? 5'd30 : rs_d;
    assign ctrl_readRegB = isBltBne_d ? rs_d : isSw_d ? rd_d : rt_d;

    // eXecute
    DX_latch dx_latch1(pc_out_fd, a_in_dx, b_in_dx, ir_in_dx, pc_out_dx, a_out_dx, b_out_dx, ir_out_dx, clock);
    isa_decoder isa_dec_x(ir_out_dx, op_x, alu_op_x, type_x, rd_x, rs_x, rt_x, shamt_x, immediate_x, target_x);
    alu alu_X(alu_operand_a, alu_operand_b, alu_opcode, shamt_x, alu_result, isNEQ, isLT, alu_overflow);
    // Sign extend immediate (N)
    assign N_ext = {immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x[16], immediate_x};
    // Select correct operand B - from RegFile or sign extended immediate
    and and_I_x(isI_x, type_x[0], ~type_x[1]);
    assign alu_operand_b = (isI_x & ~isBlt_x & ~isBne_x) ? N_ext : alu_op_b_mux_in;
    // Select correct ALU opcode - from R type or set to add (00000) for I, J1, J2 types
    and and_R_x(isR_x, ~type_x[0], ~type_x[1]);
    assign alu_opcode = isR_x ? alu_op_x : 5'b0;
    // Set $rstatus
    and and_add_x(isAdd_x, ~alu_op_x[4], ~alu_op_x[3], ~alu_op_x[2], ~alu_op_x[1], ~alu_op_x[0]);
    and and_addi_x(isAddi_x, ~op_x[4], ~op_x[3], op_x[2], ~op_x[1], op_x[0]);
    and and_sub_x(isSub_x, ~alu_op_x[4], ~alu_op_x[3], ~alu_op_x[2], ~alu_op_x[1], alu_op_x[0]);
    and and_setx_x(isSetx_x, op_x[4], ~op_x[3], op_x[2], ~op_x[1], op_x[0]);
    assign rstatus_data = isAdd_x ? 32'd1 : isAddi_w ? 32'd2 : isSub_x ? 32'd3 : isMult_x ? 32'd4 : isDiv_x ? 32'd5 : isSetx_x ? {5'b0, target_x} : 32'd0;
    assign rstatus_ctrl = 5'd30;
    assign writeReg_alu_rstatus = (alu_overflow | multdiv_exception) ? rstatus_data : isJal_x ? pc_out_dx : isSetx_x ? target_x : alu_result;
    assign alu_rd_out = (alu_overflow | multdiv_exception | isSetx_x) ? rstatus_ctrl : isJal_x ? 5'd31 : rd_x;
    assign ir_in_xm = {ir_out_dx[31:27], alu_rd_out, ir_out_dx[21:0]};
    // Handle blt and bne
    assign N_ext_d = {immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d[16], immediate_d};
    cla_32 cla_pc_br(pc_out_fd, N_ext_d, 1'b0, pc_blt_bne, cout_pc_br);
    and and_blt_x(isBlt_x, ~op_x[4], ~op_x[3], op_x[2], op_x[1], ~op_x[0]);
    and and_bne_x(isBne_x, ~op_x[4], ~op_x[3], ~op_x[2], op_x[1], ~op_x[0]);
    and and_blt_d(isBlt_d, ~op_d[4], ~op_d[3], op_d[2], op_d[1], ~op_d[0]);
    and and_bne_d(isBne_d, ~op_d[4], ~op_d[3], ~op_d[2], op_d[1], ~op_d[0]);
    full_comparator branch_comp(a_in_comp, b_in_comp, isEQ_d, isGT_d);
    assign pc_BltBne_select = (isBlt_d & (~isGT_d & ~isEQ_d)) | (isBne_d & ~isEQ_d);
    // Handle jumps
    assign pc_jump = isJJal_x ? target_x : alu_operand_a;
    and and_jal_x(isJal_x, ~op_x[4], ~op_x[3], ~op_x[2], op_x[1], op_x[0]);
    // Handle bex and setx
    assign pc_bex_select = (alu_operand_a !== 32'b0) & isBex_x;

    // Mult/Div
    and and_multdiv_aluop_x(isMultDiv_aluop_x, ~alu_op_x[4], ~alu_op_x[3], alu_op_x[2], alu_op_x[1]);
    and and_multdiv_x(isMultDiv_x, ~op_x[4], ~op_x[3], ~op_x[2], ~op_x[1], ~op_x[0], isMultDiv_aluop_x);
    and and_multdiv_aluop_d(isMultDiv_aluop_d, ~alu_op_d[4], ~alu_op_d[3], alu_op_d[2], alu_op_d[1]);
    and and_multdiv_d(isMultDiv_d, ~op_d[4], ~op_d[3], ~op_d[2], ~op_d[1], ~op_d[0], isMultDiv_aluop_d);
    assign dp_enable = isMultDiv_x | (isMultDiv_p & multdiv_resultRDY);
    DP_latch dp_latch1(alu_operand_a, alu_operand_b, ir_out_dx, multdiv_a, multdiv_b, ir_out_dp, clock, dp_enable); // determine enable to not update values during mult cycle
    isa_decoder isa_dec_p(ir_out_dp, op_p, alu_op_p, type_p, rd_p, rs_p, rt_p, shamt_p, immediate_p, target_p);
    // get ctrl Mult/Div
    and and_multdiv_op_d(isMultDiv_op_x, ~op_x[4], ~op_x[3], ~op_x[2], ~op_x[1], ~op_x[0]);
    and and_mult_d(isMult_x, ~alu_op_x[4], ~alu_op_x[3], alu_op_x[2], alu_op_x[1], ~alu_op_x[0], isMultDiv_op_x);
    and and_div_d(isDiv_x, ~alu_op_x[4], ~alu_op_x[3], alu_op_x[2], alu_op_x[1], alu_op_x[0], isMultDiv_op_x);
    // calc multdiv
    multdiv multdiv_1(multdiv_a, multdiv_b, isMult_x, isDiv_x, clock, multdiv_result, multdiv_error, multdiv_rdy_internal);
    assign multdiv_exception = isMultDiv_p ? multdiv_error : 1'b0;
    assign multdiv_resultRDY = isMultDiv_p ? multdiv_rdy_internal : 1'b0;
    and and_multdiv_aluop_p(isMultDiv_aluop_p, ~alu_op_p[4], ~alu_op_p[3], alu_op_p[2], alu_op_p[1]);
    and and_multdiv_p(isMultDiv_p, ~op_p[4], ~op_p[3], ~op_p[2], ~op_p[1], ~op_p[0], isMultDiv_aluop_p);
    // and and_multdiv_nop(insert_nop_multdiv, isMultDiv_p, ~multdiv_resultRDY);
    assign insert_nop_multdiv = (isMultDiv_p & (~multdiv_resultRDY)) | isMultDiv_x;
    PW_latch pw_latch1(multdiv_result, ir_out_dp, p_out_pw, ir_out_pw, clock, multdiv_resultRDY);

    // Memory
    XM_latch xm_latch1(writeReg_alu_rstatus, alu_op_b_mux_in, ir_in_xm, address_dmem, b_out_xm, ir_out_xm, clock);
    isa_decoder isa_dec_m(ir_out_xm, op_m, alu_op_m, type_m, rd_m, rs_m, rt_m, shamt_m, immediate_m, target_m);
    // Assign wren for data write enable
    and and_wren(wren, ~op_m[4], ~op_m[3], op_m[2], op_m[1], op_m[0]);

    // Writeback
    MW_latch mw_latch1(address_dmem, q_dmem, ir_out_xm, o_out_mw, d_out_mw, ir_out_mw, clock);
    assign ir_writeback = (isMultDiv_p & multdiv_resultRDY) ? ir_out_dp : ir_out_mw;
    isa_decoder isa_dec_w(ir_writeback, op_w, alu_op_w, type_w, rd_w, rs_w, rt_w, shamt_w, immediate_w, target_w);
    assign ctrl_writeReg = rd_w;
    // Determine write enable for RegFile
    and and_lw_alu(isLwAlu_w, ~op_w[4], ~op_w[2], ~op_w[1], ~op_w[0]);
    and and_addi(isAddi_w, ~op_w[4], ~op_w[3], op_w[2], ~op_w[1], op_w[0]);
    and and_jal_w(isJal_w, ~op_w[4], ~op_w[3], ~op_w[2], op_w[1], op_w[0]);
    or or_writeEn(ctrl_writeEnable, isLwAlu_w, isAddi_w, isJal_w, isSetx_w);
    // Choose ALU result, data from memory, or MultDiv result
    and and_aluop(isAluOp_w, ~op_w[4], ~op_w[3], ~op_w[2], ~op_w[1], ~op_w[0]);
    or or_write_res(useAluResult, isAluOp_w, isAddi_w, isJal_w, isSetx_w);
    and and_multdiv_aluop(isMultDiv_aluop, ~alu_op_w[4], ~alu_op_w[3], alu_op_w[2], alu_op_w[1]);
    and and_multdiv(isMultDiv, ~op_w[4], ~op_w[3], ~op_w[2], ~op_w[1], ~op_w[0], isMultDiv_aluop);
    assign data_writeReg = isMultDiv ? multdiv_result : useAluResult ? o_out_mw : d_out_mw;

    // Hardware Interlocks - stalls
    // Rs1
    and and_j_jal(isJJal_d, ~op_d[4], ~op_d[3], ~op_d[2], op_d[0]);
    and and_jr(isJr_d, ~op_d[4], ~op_d[3], op_d[2], ~op_d[1], ~op_d[0]);
    and and_bex(isBex_d, op_d[4], ~op_d[3], op_d[2], op_d[1], ~op_d[0]);
    and and_setx(isSetx_d, op_d[4], ~op_d[3], op_d[2], ~op_d[1], op_d[0]);
    or or_noRs1(noRs1, isJJal_d, isJr_d, isBex_d, isSetx_d);
    assign rs1_nop = noRs1 ? 5'b0000x : rs_d;
    // Rs2
    and and_alu_d(isAlu_d, ~op_d[4], ~op_d[3], ~op_d[2], ~op_d[1], ~op_d[0]);
    and and_shift_d(isShift_d, ~alu_op_d[4], ~alu_op_d[3], alu_op_d[2], ~alu_op_d[1]);
    and and_Rs2(yesRs2, isAlu_d, ~isShift_d);
    assign rs2_nop = yesRs2 ? rt_d : 5'b000x0;
    // Rd
    and and_j_jal_x(isJJal_x, ~op_x[4], ~op_x[3], ~op_x[2], op_x[0]);
    and and_bex_x(isBex_x, op_x[4], ~op_x[3], op_x[2], op_x[1], ~op_x[0]);
    or or_noRd_x(noRd_x, isJJal_x, isBex_x, isSetx_x);
    assign rd_nop_x = noRd_x ? 5'b000xx : rd_x;
    and and_j_jal_m(isJJal_m, ~op_m[4], ~op_m[3], ~op_m[2], op_m[0]);
    and and_bex_m(isBex_m, op_m[4], ~op_m[3], op_m[2], op_m[1], ~op_m[0]);
    and and_setx_m(isSetx_m, op_m[4], ~op_m[3], op_m[2], ~op_m[1], op_m[0]);
    or or_noRd_m(noRd_m, isJJal_m, isBex_m, isSetx_m, isSw_m);
    assign rd_nop_m = noRd_m ? 5'b00x00 : rd_m;
    // Find Hazard
    assign FDIRRS1_DXIRRD = (rs1_nop === rd_nop_x) & (rd_nop_x !== 5'b0);
    assign FDIRRS2_DXIRRD = (rs2_nop === rd_nop_x) & (rd_nop_x !== 5'b0);
    and and_lw_x(isLw_x, ~op_x[4], op_x[3], ~op_x[2], ~op_x[1], ~op_x[0]);
    and and_sw_d(isSw_d, ~op_d[4], ~op_d[3], op_d[2], op_d[1], op_d[0]);
    assign insert_nop_hazard = isLw_x & (FDIRRS1_DXIRRD | (FDIRRS2_DXIRRD & ~isSw_d));
    or or_nop(insert_nop, insert_nop_hazard, insert_nop_stall, insert_nop_multdiv);
    assign ir_in_dx = (insert_nop | (isJJal_x | isJr_x)) ? 32'b0 : ir_out_fd;
    assign a_in_dx = insert_nop ? 32'b0 : data_readRegA;
    assign b_in_dx = insert_nop ? 32'b0 : data_readRegB;
    // FD nop for jumps
    assign ir_in_fd = (isJJal_x | isJr_x | isBltBne_d) ? 32'b0 : q_imem;

    // Bypassing
    // Rs_x
    and and_jr_x(isJr_x, ~op_x[4], ~op_x[3], op_x[2], ~op_x[1], ~op_x[0]);
    or or_noRs1_x(noRs1_x, isJJal_x, isBex_x, isSetx_x);
    assign rs1_bypass = noRs1_x ? 5'b00x0x : isJr_x ? rd_x : rs_x;
    // Rs2_x
    and and_alu_x(isAlu_x, ~op_x[4], ~op_x[3], ~op_x[2], ~op_x[1], ~op_x[0]);
    and and_shift_x(isShift_x, ~alu_op_x[4], ~alu_op_x[3], alu_op_x[2], ~alu_op_x[1]);
    and and_sw_x(isSw_x, ~op_x[4], ~op_x[3], op_x[2], op_x[1], op_x[0]);
    and and_Rs2_x(yesRs2_x, isAlu_x, ~isShift_x);
    assign rs2_bypass = yesRs2_x ? rt_x : isSw_x ? rd_x : 5'b00xx0;
    // Rd_w 
    and and_j_jal_w(isJJal_w, ~op_w[4], ~op_w[3], ~op_w[2], op_w[0]);
    and and_bex_w(isBex_w, op_w[4], ~op_w[3], op_w[2], op_w[1], ~op_w[0]);
    and and_setx_w(isSetx_w, op_w[4], ~op_w[3], op_w[2], ~op_w[1], op_w[0]);
    and and_sw_w(isSw_w, ~op_w[4], ~op_w[3], op_w[2], op_w[1], op_w[0]);
    and and_blt_bne_w(isBltBne_w, ~op_w[4], ~op_w[3], op_w[1], ~op_w[0]);
    or or_noRd_w(noRd_w, isJJal_w, isJr_x, isBex_w, isSetx_w, isSw_w, isBltBne_w);
    assign rd_bypass_w = noRd_w ? 5'b00xxx : rd_w;
    // compare registers
    assign DXIRRS1_XMIRRD = (rs1_bypass === rd_nop_m) & (rd_nop_m !== 5'b0);
    assign DXIRRS1_MWIRRD = (rs1_bypass === rd_bypass_w) & (rd_bypass_w !== 5'b0);
    assign DXIRRS2_XMIRRD = (rs2_bypass === rd_nop_m) & (rd_nop_m !== 5'b0);
    assign DXIRRS2_MWIRRD = (rs2_bypass === rd_bypass_w) & (rd_bypass_w !== 5'b0);
    // WM bypass
    and and_lw_w(isLw_w, ~op_w[4], op_w[3], ~op_w[2], ~op_w[1], ~op_w[0]);
    and and_sw_m(isSw_m, ~op_m[4], ~op_m[3], op_m[2], op_m[1], op_m[0]);
    assign wm_select = (isLw_w & isSw_m) & (rd_w === rd_m);
    // XD bypass
    assign rd_by_x = (isAlu_x | isAddi_x) ? rd_x : 5'b0x000;
    assign rd_by_m = (isAlu_m | isAddi_m) ? rd_m : 5'b0x00x;
    and and_addi_d(isAddi_d, ~op_d[4], ~op_d[3], op_d[2], ~op_d[1], op_d[0]);
    and and_addi_m(isAddi_m, ~op_m[4], ~op_m[3], op_m[2], ~op_m[1], op_m[0]);
    and and_alu_m(isAlu_m, ~op_m[4], ~op_m[3], ~op_m[2], ~op_m[1], ~op_m[0]);
    and and_lw_d(isLw_d, ~op_d[4], op_d[3], ~op_d[2], ~op_d[1], ~op_d[0]);
    assign rs1_by_d = isBltBne_d ? rd_d : 5'b0x0x0;
    assign rs2_by_d = isBltBne_d ? rs_d : 5'b0x0xx;
    assign DXIRRD_FDIRRS1 = (rd_by_x === rs1_by_d) & (rs1_by_d !== 5'b0) & (ir_in_dx !== 32'b0);
    assign DXIRRD_FDIRRS2 = (rd_by_x === rs2_by_d) & (rs2_by_d !== 5'b0) & (ir_in_dx !== 32'b0);
    assign XMIRRD_FDIRRS1 = (rd_by_m === rs1_by_d) & (rs1_by_d !== 5'b0) & (ir_in_dx !== 32'b0);
    assign XMIRRD_FDIRRS2 = (rd_by_m === rs2_by_d) & (rs2_by_d !== 5'b0) & (ir_in_dx !== 32'b0);
    assign a_in_comp = DXIRRD_FDIRRS1 ? alu_result : XMIRRD_FDIRRS1 ? address_dmem : a_in_dx;
    assign b_in_comp = DXIRRD_FDIRRS2 ? alu_result : XMIRRD_FDIRRS2 ? address_dmem : b_in_dx;
    // bypass control
    assign bypass_select_a = DXIRRS1_XMIRRD ? 2'd0 : DXIRRS1_MWIRRD ? 2'd1 : 2'd2;
    assign bypass_select_b = DXIRRS2_XMIRRD ? 2'd0 : DXIRRS2_MWIRRD ? 2'd1 : 2'd2;
    mux_4 mux_alu_a(alu_operand_a, bypass_select_a, address_dmem, data_writeReg, a_out_dx, 32'b0);
    mux_4 mux_alu_b(alu_op_b_mux_in, bypass_select_b, address_dmem, data_writeReg, b_out_dx, 32'b0);
    assign data = wm_select ? data_writeReg : b_out_xm;

	/* END CODE */
//    ila_proc debuggers(.clk(clock), .probe0(ir_in_fd));
endmodule
