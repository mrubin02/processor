module mult(
	data_operandA, data_operandB, clock, ctr_rst,
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input clock, ctr_rst;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire [31:0] multiplicand, multiplicand_shift, multiplicand_inv, multiplicand_a, multiplicand_b, cla_result;
    wire signed [64:0] wr_product, rd_product, shifted_prod, init_product;
    wire signed [64:0] added_product, added_shift_product;
    wire Cout, mltnd_shift, sub, zero, finish_cyc, init_cyc;
    wire overflow_mult, overflow_mult0, overflow_mult1, overflow_mult10, overflow;

    // execute before cycle begins
    assign init_product = {32'b0, data_operandB, 1'b0};
    assign multiplicand_shift = data_operandA << 1;
    assign multiplicand_inv = mltnd_shift ? ~multiplicand_shift : ~data_operandA;
    reg_65 prod_reg(rd_product, wr_product, clock, 1'b1, 1'b0);

    // execute each iteration of clock cycle
    mult_control mult_control1(rd_product[2:0], clock, ctr_rst, mltnd_shift, sub, zero, finish_cyc, init_cyc);
    mux_2 multiplicand_shift_mux(multiplicand_a, mltnd_shift, data_operandA, multiplicand_shift);
    mux_2 multiplicand_inv_mux(multiplicand_b, sub, multiplicand_a, multiplicand_inv);
    mux_2 multiplicand_mux(multiplicand, zero, multiplicand_b, 32'b0);
    cla_32 adder(rd_product[64:33], multiplicand, sub, cla_result, Cout);

    // assign the new product
    assign added_product = {cla_result, rd_product[32:0]};
    assign wr_product = init_cyc ? init_product : finish_cyc ? rd_product : (added_product >>> 2);
    assign data_result = rd_product[32:1];

    // determine overflow
    nand nand_over_mult1(overflow_mult1, rd_product[64], rd_product[63], rd_product[62], rd_product[61], rd_product[60], rd_product[59], rd_product[58], rd_product[57], rd_product[56], rd_product[55], rd_product[54], rd_product[53], rd_product[52], rd_product[51], rd_product[50], rd_product[49], rd_product[48], rd_product[47], rd_product[46], rd_product[45], rd_product[44], rd_product[43], rd_product[42], rd_product[41], rd_product[40], rd_product[39], rd_product[38], rd_product[37], rd_product[36], rd_product[35], rd_product[34], rd_product[33], rd_product[32]);
    nand nand_over_mult0(overflow_mult0, ~rd_product[64], ~rd_product[63], ~rd_product[62], ~rd_product[61], ~rd_product[60], ~rd_product[59], ~rd_product[58], ~rd_product[57], ~rd_product[56], ~rd_product[55], ~rd_product[54], ~rd_product[53], ~rd_product[52], ~rd_product[51], ~rd_product[50], ~rd_product[49], ~rd_product[48], ~rd_product[47], ~rd_product[46], ~rd_product[45], ~rd_product[44], ~rd_product[43], ~rd_product[42], ~rd_product[41], ~rd_product[40], ~rd_product[39], ~rd_product[38], ~rd_product[37], ~rd_product[36], ~rd_product[35], ~rd_product[34], ~rd_product[33], ~rd_product[32]);
    assign overflow_mult10 = rd_product[32] ? overflow_mult1 : overflow_mult0;
    mult_overflow over(data_operandA, data_operandB, rd_product, overflow_mult);
    or over_or(overflow, overflow_mult10, overflow_mult);
    
    // final assigns when cycle is finished
    assign data_exception = finish_cyc ? overflow : 1'b0;
    assign data_resultRDY = finish_cyc;

endmodule