module full_comparator(A, B, EQ, GT);

    input [31:0] A, B;
    output EQ, GT;
    wire EQ_higher = 1'b1;
    wire GT_higher = 1'b0;

    wire eq0, eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10, eq11, eq12, eq13, eq14, eq15, gt0, gt1, gt2, gt3, gt4, gt5, gt6, gt7, gt8, gt9, gt10, gt11, gt12, gt13, gt14, gt15;
    wire [1:0] A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15;
    
    assign {A15, A14, A13, A12, A11, A10, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0} = A;
    assign {B15, B14, B13, B12, B11, B10, B9, B8, B7, B6, B5, B4, B3, B2, B1, B0} = B;

    two_bit_comparator comp15(eq15, gt15, EQ_higher, GT_higher, A15, B15);
    two_bit_comparator comp14(eq14, gt14, eq15, gt15, A14, B14);
    two_bit_comparator comp13(eq13, gt13, eq14, gt14, A13, B13);
    two_bit_comparator comp12(eq12, gt12, eq13, gt13, A12, B12);
    two_bit_comparator comp11(eq11, gt11, eq12, gt12, A11, B11);
    two_bit_comparator comp10(eq10, gt10, eq11, gt11, A10, B10);
    two_bit_comparator comp9(eq9, gt9, eq10, gt10, A9, B9);
    two_bit_comparator comp8(eq8, gt8, eq9, gt9, A8, B8);
    two_bit_comparator comp7(eq7, gt7, eq8, gt8, A7, B7);
    two_bit_comparator comp6(eq6, gt6, eq7, gt7, A6, B6);
    two_bit_comparator comp5(eq5, gt5, eq6, gt6, A5, B5);
    two_bit_comparator comp4(eq4, gt4, eq5, gt5, A4, B4);
    two_bit_comparator comp3(eq3, gt3, eq4, gt4, A3, B3);
    two_bit_comparator comp2(eq2, gt2, eq3, gt3, A2, B2);
    two_bit_comparator comp1(eq1, gt1, eq2, gt2, A1, B1);
    two_bit_comparator comp0(EQ, GT, eq1, gt1, A0, B0);

endmodule