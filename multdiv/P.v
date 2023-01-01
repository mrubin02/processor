module P(P, A, B); 
    input [7:0] A, B; 
    output [7:0] P;
    or OR1(P[0], A[0], B[0]); 
    or OR2(P[1], A[1], B[1]); 
    or OR3(P[2], A[2], B[2]); 
    or OR4(P[3], A[3], B[3]); 
    or OR5(P[4], A[4], B[4]); 
    or OR6(P[5], A[5], B[5]); 
    or OR7(P[6], A[6], B[6]); 
    or OR8(P[7], A[7], B[7]); 
endmodule

