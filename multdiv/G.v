module G(G, A, B); 
    input [7:0] A, B; 
    output [7:0] G;
    and AND1(G[0], A[0], B[0]); 
    and AND2(G[1], A[1], B[1]); 
    and AND3(G[2], A[2], B[2]); 
    and AND4(G[3], A[3], B[3]); 
    and AND5(G[4], A[4], B[4]); 
    and AND6(G[5], A[5], B[5]); 
    and AND7(G[6], A[6], B[6]); 
    and AND8(G[7], A[7], B[7]); 
endmodule