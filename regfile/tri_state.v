module tri_state(in, oe, out); 
    input in, oe; 
    output out; 

    assign out = oe ? in : 1'bz;

endmodule