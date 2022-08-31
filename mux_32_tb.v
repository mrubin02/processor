`timescale 1ns/100ps
module mux_32_tb;
    reg [31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15,in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31;
    wire [4:0] select;
    wire [31:0] out;


    mux_32 mux(out, select, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15,in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31);
    
    initial begin 

        in0 = 1; 
        in1 = 2; 
        in2 = 3; 
        in3 = 4; 
        in4 = 5; 
        in5 = 6; 
        in6 = 7; 
        in7 = 8; 
        in8 = 9; 
        in9 = 10; 
        in10 = 11; 
        in11 = 12; 
        in12 = 13; 
        in13 = 14; 
        in14 = 15; 
        in15 = 16; 
        in16 = 17; 
        in17 = 18; 
        in18 = 19; 
        in19 = 20; 
        in20 = 21; 
        in21 = 22; 
        in22 = 23; 
        in23 = 24; 
        in24 = 25; 
        in25 = 26; 
        in26 = 27; 
        in27 = 28; 
        in28 = 29; 
        in29 = 30; 
        in30 = 31; 
        in31 = 32; 
        #5
        $finish;
    end 

    integer i; 
    assign {select} = i; 
    initial begin 
        for(i  =0; i<31; i = i+1) begin 
            #0.1
            $display("Select:%b => Out:%b", select, out);
        end 
        $finish;
    end 
endmodule 